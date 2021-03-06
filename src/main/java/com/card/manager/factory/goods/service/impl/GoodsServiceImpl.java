/**  
 * Project Name:cardmanager  
 * File Name:SupplierServiceImpl.java  
 * Package Name:com.card.manager.factory.supplier.service.impl  
 * Date:Nov 7, 20173:22:23 PM  
 *  
 */
package com.card.manager.factory.goods.service.impl;

import java.io.ByteArrayInputStream;
import java.io.InputStream;
import java.net.URL;
import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.web.context.ContextLoader;
import org.springframework.web.context.WebApplicationContext;

import com.baidu.ueditor.PathFormat;
import com.card.manager.factory.annotation.Log;
import com.card.manager.factory.common.ResourceContants;
import com.card.manager.factory.common.RestCommonHelper;
import com.card.manager.factory.common.ServerCenterContants;
import com.card.manager.factory.common.serivce.impl.AbstractServcerCenterBaseService;
import com.card.manager.factory.ftp.common.ReadIniInfo;
import com.card.manager.factory.ftp.service.SftpService;
import com.card.manager.factory.goods.model.GoodsEntity;
import com.card.manager.factory.goods.model.GoodsFile;
import com.card.manager.factory.goods.model.GoodsItemEntity;
import com.card.manager.factory.goods.model.GoodsPrice;
import com.card.manager.factory.goods.model.GoodsRebateEntity;
import com.card.manager.factory.goods.model.GoodsTagBindEntity;
import com.card.manager.factory.goods.model.GoodsTagEntity;
import com.card.manager.factory.goods.model.ThirdWarehouseGoods;
import com.card.manager.factory.goods.pojo.GoodsPojo;
import com.card.manager.factory.goods.pojo.GoodsStatusEnum;
import com.card.manager.factory.goods.pojo.ItemSpecsPojo;
import com.card.manager.factory.goods.service.GoodsService;
import com.card.manager.factory.supplier.model.SupplierEntity;
import com.card.manager.factory.system.mapper.StaffMapper;
import com.card.manager.factory.system.model.StaffEntity;
import com.card.manager.factory.util.JSONUtilNew;
import com.card.manager.factory.util.SequeceRule;
import com.card.manager.factory.util.URLUtils;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

/**
 * ClassName: SupplierServiceImpl <br/>
 * Function: TODO ADD FUNCTION. <br/>
 * date: Nov 7, 2017 3:22:23 PM <br/>
 * 
 * @author hebin
 * @version
 * @since JDK 1.7
 */
@Service
public class GoodsServiceImpl extends AbstractServcerCenterBaseService implements GoodsService {

	@Resource
	StaffMapper<?> staffMapper;

	@Override
	@Log(content = "新增商品明细信息操作", source = Log.BACK_PLAT, type = Log.ADD)
	public void addEntity(GoodsPojo entity, String token) throws Exception {
		RestCommonHelper helper = new RestCommonHelper();

		int goodsId = staffMapper.nextVal(ServerCenterContants.GOODS_ID_SEQUENCE);

		GoodsEntity goods = new GoodsEntity();
		goods.setGoodsId(SequeceRule.getGoodsId(goodsId));
		goods.setTemplateId(entity.getTemplateId());
		goods.setGoodsName(entity.getName());
		goods.setSupplierId(entity.getSupplierId());
		goods.setSupplierName(entity.getSupplierName());
		goods.setBaseId(entity.getBaseId());
		goods.setOrigin(entity.getOrigin());
		goods.setThirdId(entity.getThirdId());

		GoodsItemEntity goodsItem = new GoodsItemEntity();
		goodsItem.setExciseTax(entity.getExciseFax());
		goodsItem.setSku(entity.getSku());
		goodsItem.setStatus(GoodsStatusEnum.INIT.getIndex() + "");
		goodsItem.setItemCode(entity.getItemCode());
		goodsItem.setWeight(entity.getWeight());

		int itemid = staffMapper.nextVal(ServerCenterContants.GOODS_ITEM_ID_SEQUENCE);
		goodsItem.setItemId(SequeceRule.getGoodsItemId(itemid));
		goodsItem.setGoodsId(goods.getGoodsId());

		GoodsPrice goodsPrice = new GoodsPrice();
		goodsPrice.setProxyPrice(entity.getProxyPrice());
		goodsPrice.setFxPrice(entity.getFxPrice());
		goodsPrice.setMax(entity.getMax());
		goodsPrice.setMin(entity.getMin());
		goodsPrice.setItemId(goodsItem.getItemId());
		goodsPrice.setOpt(entity.getOpt());
		goodsPrice.setRetailPrice(entity.getRetailPrice());

		List<GoodsFile> files = new ArrayList<GoodsFile>();
		if (entity.getPicPath() != null) {
			String[] goodsFiles = entity.getPicPath().split(",");
			for (String file : goodsFiles) {
				GoodsFile f = new GoodsFile();
				f.setPath(file);
				f.setGoodsId(goods.getGoodsId());
				files.add(f);
			}
		}

		goods.setFiles(files);

		goodsItem.setGoodsPrice(goodsPrice);
		goodsItem.setOpt(entity.getOpt());

		String keys = entity.getKeys();
		String values = entity.getValues();

		List<ItemSpecsPojo> specsPojos = new ArrayList<ItemSpecsPojo>();
		if (keys != null && values != null) {
			String[] keyArray = keys.split(";");
			String[] valueArray = values.split(";");
			for (int i = 0; i < keyArray.length; i++) {
				ItemSpecsPojo itemSpecsPojo;
				if (keyArray[i].trim() != null || !"".equals(keyArray[i].trim())) {
					itemSpecsPojo = new ItemSpecsPojo();
					String[] kContesnts = keyArray[i].split(":");
					itemSpecsPojo.setSkId(kContesnts[0]);
					itemSpecsPojo.setSkV(kContesnts[1]);
					String[] vContants = valueArray[i].split(":");
					itemSpecsPojo.setSvId(vContants[0]);
					itemSpecsPojo.setSvV(vContants[1]);
					specsPojos.add(itemSpecsPojo);
				}
			}

			JSONArray json = JSONArray.fromObject(specsPojos);
			goodsItem.setInfo(json.toString());
		}

		goods.setGoodsItem(goodsItem);
		
		//新增商品时判断是否添加商品标签
		if (!"".equals(entity.getTagId()) && entity.getTagId() != null) {
			GoodsTagBindEntity goodsTagBindEntity = new GoodsTagBindEntity();
			goodsTagBindEntity.setItemId(goodsItem.getItemId());
			goodsTagBindEntity.setTagId(Integer.parseInt(entity.getTagId()));
			goods.setGoodsTagBind(goodsTagBindEntity);
		}

		ResponseEntity<String> usercenter_result = helper.request(
				URLUtils.get("gateway") + ServerCenterContants.GOODS_CENTER_SAVE + "?type=" + entity.getType(), token,
				true, goods, HttpMethod.POST);

		JSONObject json = JSONObject.fromObject(usercenter_result.getBody());

		if (!json.getBoolean("success")) {
			throw new Exception("新增商品明细信息操作失败:" + json.getString("errorMsg"));
		}

	}

	@Override
	public GoodsEntity queryById(String id, String token) {
		SupplierEntity entity = new SupplierEntity();
		entity.setId(Integer.parseInt(id));

		RestCommonHelper helper = new RestCommonHelper();
		ResponseEntity<String> query_result = helper.request(
				URLUtils.get("gateway") + ServerCenterContants.GOODS_CENTER_QUERY, token, true, entity,
				HttpMethod.POST);

		JSONObject json = JSONObject.fromObject(query_result.getBody());
		return JSONUtilNew.parse(json.getJSONObject("obj").toString(), GoodsEntity.class);
	}

	/**
	 * TODO 简单描述该方法的实现功能（可选）.
	 * 
	 * @see com.card.manager.factory.goods.service.GoodsService#queryThirdById(java.lang.String,
	 *      java.lang.String)
	 */
	@Override
	public ThirdWarehouseGoods queryThirdById(String id, String token) {
		ThirdWarehouseGoods entity = new ThirdWarehouseGoods();
		entity.setId(id);

		RestCommonHelper helper = new RestCommonHelper();
		ResponseEntity<String> query_result = helper.request(
				URLUtils.get("gateway") + ServerCenterContants.GOODS_CENTER_THIRD_QUERY, token, true, entity,
				HttpMethod.POST);

		JSONObject json = JSONObject.fromObject(query_result.getBody());
		return JSONUtilNew.parse(json.getJSONObject("obj").toString(), ThirdWarehouseGoods.class);
	}

	@Override
	@Log(content = "更新商品明细信息操作", source = Log.BACK_PLAT, type = Log.MODIFY)
	public void updEntity(GoodsEntity entity, String token) throws Exception {
		RestCommonHelper helper = new RestCommonHelper();
		ResponseEntity<String> usercenter_result = helper.request(
				URLUtils.get("gateway") + ServerCenterContants.GOODS_CENTER_EDIT, token, true, entity, HttpMethod.POST);

		JSONObject json = JSONObject.fromObject(usercenter_result.getBody());

		if (!json.getBoolean("success")) {
			throw new Exception("更新商品明细信息操作失败:" + json.getString("errorMsg"));
		}

	}

	@Override
	@Log(content = "删除商品明细信息操作", source = Log.BACK_PLAT, type = Log.DELETE)
	public void delEntity(GoodsEntity entity, String token) throws Exception {
		RestCommonHelper helper = new RestCommonHelper();
		ResponseEntity<String> usercenter_result = helper.request(
				URLUtils.get("gateway") + ServerCenterContants.GOODS_CENTER_REMOVE, token, true, entity,
				HttpMethod.POST);

		JSONObject json = JSONObject.fromObject(usercenter_result.getBody());

		if (!json.getBoolean("success")) {
			throw new Exception("删除商品明细信息操作失败:" + json.getString("errorMsg"));
		}

	}

	@Override
	public String getHtmlContext(String html, StaffEntity staffEntity) throws Exception {
		Document doc = Jsoup.parse(new URL(html), 3000);
		return htmlToCode(doc.toString());

	}

	private String htmlToCode(String context) {
		if (context == null) {
			return "";
		} else {
			context = context.replace("<html>", "");
			context = context.replace("</html>", "");
			context = context.replace("<body>", "");
			context = context.replace("</body>", "");
			context = context.replace("<head>", "");
			context = context.replace("</head>", "");
			context = context.replace("\n", "");
			context = context.replace("\t", "");
			context = context.replaceAll("\n\r", "<br>&nbsp;&nbsp;");
			context = context.replaceAll("\r\n", "<br>&nbsp;&nbsp;");// 这才是正确的！
			context = context.replaceAll("\t", "&nbsp;&nbsp;&nbsp;&nbsp;");
			return context;
		}
	}

	@Override
	@Log(content = "保存商品详情信息操作", source = Log.BACK_PLAT, type = Log.ADD)
	public void saveHtml(String goodsId, String html, StaffEntity staffEntity) throws Exception {

		String savePath;
		String invitePath;
		
		if (ServerCenterContants.FIRST_GRADE == staffEntity.getGradeLevel()) {
			savePath = ResourceContants.RESOURCE_BASE_PATH + "/" + ResourceContants.HTML + "/";
			invitePath = URLUtils.get("static") + "/" + ResourceContants.HTML + "/";

		} else {
			savePath = ResourceContants.RESOURCE_BASE_PATH + "/" + ResourceContants.HTML + "/"
					+ staffEntity.getGradeId() + "/";
			invitePath = URLUtils.get("static") + "/" + ResourceContants.HTML + "/" + staffEntity.getGradeId()
					+ "	/";

		}
		ReadIniInfo.getInstance();

		// long maxSize = ((Long) conf.get("maxSize")).longValue();
		//
		// if (!validType(suffix, (String[]) conf.get("allowFiles"))) {
		// return new BaseState(false, AppInfo.NOT_ALLOW_FILE_TYPE);
		// }

		savePath = PathFormat.parse(savePath);
		invitePath = PathFormat.parse(invitePath);

		// String physicalPath = (String) conf.get("rootPath") + savePath;

		InputStream is = new ByteArrayInputStream(html.getBytes("utf-8"));

		WebApplicationContext wac = ContextLoader.getCurrentWebApplicationContext();
		SftpService service = (SftpService) wac.getBean("sftpService");
		service.login();
		service.uploadFile(savePath, goodsId + ResourceContants.HTML_SUFFIX, is, "");

		GoodsEntity entity = new GoodsEntity();
		entity.setDetailPath(invitePath + goodsId + ResourceContants.HTML_SUFFIX);
		entity.setGoodsId(goodsId);

		RestCommonHelper helper = new RestCommonHelper();
		ResponseEntity<String> usercenter_result = helper.request(
				URLUtils.get("gateway") + ServerCenterContants.GOODS_CENTER_SAVE_DETAIL_PATH, staffEntity.getToken(),
				true, entity, HttpMethod.POST);

		JSONObject json = JSONObject.fromObject(usercenter_result.getBody());

		if (!json.getBoolean("success")) {
			throw new Exception("保存商品详情信息操作失败:" + json.getString("errorMsg"));
		}
	}

	@Override
	public GoodsRebateEntity queryGoodsRebateById(String id, String token) {
		GoodsRebateEntity entity = new GoodsRebateEntity();
		entity.setGoodsId(id);

		RestCommonHelper helper = new RestCommonHelper();
		ResponseEntity<String> query_result = helper.request(
				URLUtils.get("gateway") + ServerCenterContants.GOODS_CENTER_GOODS_REBATE_QUERY_BY_ID, token, true, entity,
				HttpMethod.POST);

		JSONObject json = JSONObject.fromObject(query_result.getBody());
		return JSONUtilNew.parse(json.getJSONObject("obj").toString(), GoodsRebateEntity.class);
	}

	@Override
	@Log(content = "更新商品返佣信息操作", source = Log.BACK_PLAT, type = Log.MODIFY)
	public void updGoodsRebateEntity(GoodsRebateEntity entity, String token) throws Exception {
		RestCommonHelper helper = new RestCommonHelper();
		ResponseEntity<String> result = helper.request(
				URLUtils.get("gateway") + ServerCenterContants.GOODS_CENTER_GOODS_REBATE_UPDATE, token, true, entity,
				HttpMethod.POST);

		JSONObject json = JSONObject.fromObject(result.getBody());

		if (!json.getBoolean("success")) {
			throw new Exception("更新商品返佣信息操作失败:" + json.getString("errorMsg"));
		}

	}

	@Override
	public GoodsTagEntity queryGoodsTag(String tagId, String token) {
		RestCommonHelper helper = new RestCommonHelper();
		GoodsTagEntity goodsTag = new GoodsTagEntity();
		goodsTag.setId(Integer.parseInt(tagId));
		ResponseEntity<String> query_result = helper.request(
				URLUtils.get("gateway") + ServerCenterContants.GOODS_CENTER_QUERY_TAG_INFO, token, true, goodsTag,
				HttpMethod.POST);

		JSONObject json = JSONObject.fromObject(query_result.getBody());
		return JSONUtilNew.parse(json.getJSONObject("obj").toString(), GoodsTagEntity.class);
	}

	@Override
	public List<GoodsTagEntity> queryGoodsTags(String token) {
		RestCommonHelper helper = new RestCommonHelper();
		ResponseEntity<String> query_result = helper.request(
				URLUtils.get("gateway") + ServerCenterContants.GOODS_CENTER_QUERY_TAG_LIST_INFO, token, true, null,
				HttpMethod.POST);

		JSONObject json = JSONObject.fromObject(query_result.getBody());
		JSONArray obj = json.getJSONArray("obj");
		int index = obj.size();

		List<GoodsTagEntity> list = new ArrayList<GoodsTagEntity>();
		for (int i = 0; i < index; i++) {
			JSONObject jObj = obj.getJSONObject(i);
			list.add(JSONUtilNew.parse(jObj.toString(), GoodsTagEntity.class));
		}
		return list;
	}
	
	@Override
	@Log(content = "新增商品标签操作", source = Log.BACK_PLAT, type = Log.ADD)
	public void addGoodsTag(GoodsTagEntity entity, String token) throws Exception {
		RestCommonHelper helper = new RestCommonHelper();
		ResponseEntity<String> result = helper.request(
				URLUtils.get("gateway") + ServerCenterContants.GOODS_CENTER_TAG_SAVE, token,
				true, entity, HttpMethod.POST);

		JSONObject json = JSONObject.fromObject(result.getBody());

		if (!json.getBoolean("success")) {
			throw new Exception("行政商品标签操作失败:" + json.getString("errorMsg"));
		}

	}

	@Override
	@Log(content = "更新商品标签操作", source = Log.BACK_PLAT, type = Log.MODIFY)
	public void updateGoodsTagEntity(GoodsTagEntity entity, String token) throws Exception {
		RestCommonHelper helper = new RestCommonHelper();
		ResponseEntity<String> usercenter_result = helper.request(
				URLUtils.get("gateway") + ServerCenterContants.GOODS_CENTER_TAG_UPDATE, token, true, entity, HttpMethod.POST);

		JSONObject json = JSONObject.fromObject(usercenter_result.getBody());

		if (!json.getBoolean("success")) {
			throw new Exception("更新商品标签操作失败:" + json.getString("errorMsg"));
		}

	}

	@Override
	public GoodsTagBindEntity queryGoodsTagBind(String token) {
		RestCommonHelper helper = new RestCommonHelper();
		ResponseEntity<String> query_result = helper.request(
				URLUtils.get("gateway") + ServerCenterContants.GOODS_CENTER_QUERY_TAG_INFO, token, true, null,
				HttpMethod.POST);

		JSONObject json = JSONObject.fromObject(query_result.getBody());
		return JSONUtilNew.parse(json.getJSONObject("obj").toString(), GoodsTagBindEntity.class);
	}

	@Override
	@Log(content = "删除商品标签操作", source = Log.BACK_PLAT, type = Log.DELETE)
	public void deleteGoodsTagEntity(GoodsTagEntity entity, String token) throws Exception {
		RestCommonHelper helper = new RestCommonHelper();
		ResponseEntity<String> usercenter_result = helper.request(
				URLUtils.get("gateway") + ServerCenterContants.GOODS_CENTER_TAG_REMOVE, token, true, entity, HttpMethod.POST);

		JSONObject json = JSONObject.fromObject(usercenter_result.getBody());

		if (!json.getBoolean("success")) {
			throw new Exception("删除商品标签失败:" + json.getString("errorMsg"));
		}

	}

}
