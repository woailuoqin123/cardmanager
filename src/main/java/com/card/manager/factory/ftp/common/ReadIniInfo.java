/**  
 * Project Name:cardmanager  
 * File Name:ReadIniInfo.java  
 * Package Name:com.card.manager.factory.ftp  
 * Date:Jan 2, 20189:38:13 PM  
 *  
 */
package com.card.manager.factory.ftp.common;

import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 * ClassName: ReadIniInfo <br/>
 * Function: TODO ADD FUNCTION. <br/>
 * date: Jan 2, 2018 9:38:13 PM <br/>
 * 
 * @author hebin
 * @version
 * @since JDK 1.7
 */
public class ReadIniInfo {

	private static Properties properties;

	private static Logger logger = LoggerFactory.getLogger(ReadIniInfo.class);

	// 初始化配置文件
	private ReadIniInfo() {

	}

	public static void getInstance() {

		if (properties == null) {

			properties = new Properties();
			// 读取配置文件：ftpconfig.properties
			InputStream is = ReadIniInfo.class.getResourceAsStream("/ftpconfig.properties");

			try {
				properties.load(is);

			} catch (FileNotFoundException e) {

				logger.error("配置文件不存在..", e);

			} catch (IOException e) {
				logger.error("读取配置文件错误：", e);
			} finally {

				try {

					if (null != is) {
						is.close();
					}
				} catch (IOException e) {
					logger.error("关闭链接失败..", 3);
				}
			}
		}
	}

	/**
	 * 获取FTP服务器地址
	 */
	public static String getFtpServer() {
		return properties.getProperty("ftpServer");
	}

	/**
	 * 获取FTP服务器端口
	 */
	public static String getFtpPort() {
		return properties.getProperty("ftpPort");
	}

	/**
	 * 获取FTP用户账号
	 */
	public static String getFtpUser() {
		return properties.getProperty("ftpUser");
	}

	/**
	 * 获取FTP用户密码
	 */
	public static String getFtpPwd() {
		return properties.getProperty("ftpPwd");
	}

	/**
	 * 获取ftp目的地仓库地址
	 */
	public static String getFtpRemotePath() {
		return properties.getProperty("ftpRemotePath");
	}

	/**
	 * http和ftp上传时的固定路径部份
	 */
	public static String getPathConstant() {
		return properties.getProperty("pathConstant");
	}

	/**
	 * 图片资源管理图片路径
	 */
	public static String getImageCenter() {
		return properties.getProperty("imagecenter");
	}

	/**
	 * 压缩图
	 */
	public static String getCompress() {
		return properties.getProperty("compress");
	}

	/**
	 * 公文管理的附件路径
	 */
	public static String getGwgl() {
		return properties.getProperty("gwgl");
	}
}
