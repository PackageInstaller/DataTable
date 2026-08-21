-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/SDK\\Plugin\\Share\\SocialShareCN.lua

local SocialShareAgent = Framework.Plugin.SocialShareAgent
local MsgManager = MsgManager
local FileUtils = Framework.Tools.FileUtils
local DeviceHelper = require("Helper/DeviceHelper")
local VersionUtils = require("System/VersionUtils")
local SocialShareBase = require("SDK/Plugin/Share/SocialShareBase")
local SocialShareCN = Class("SocialShareCN", SocialShareBase)
local SocialShareEventType = {
	SHARE_FINISH = 0
}
local SocialShareType = {
	Text = 1,
	App = 7,
	Auto = 0,
	File = 8,
	Emoji = 9,
	Video = 6,
	Image = 2,
	Music = 5,
	Webpage = 4
}

SocialShareCN.SocialShareType = SocialShareType

local Platform = {
	WECHAT_FAV = 37,
	WECHAT_PLATFORM_IOS = 997,
	QQ_PLATFORM_IOS = 998,
	FACEBOOK = 10,
	LINE = 42,
	QQ_PLATFORM_ANDROID = 24,
	TWITTER = 11,
	QZONE = 6,
	WECHAT_MOMENTS = 23,
	WECHAT = 22,
	INSTAGRAM = 15,
	WECHAT_PLATFORM_ANDROID = 22,
	SINA_WEIBO = 1,
	QQ = 24
}

SocialShareCN.SocialSharePlatform = Platform

local paramKeys = {
	TEXT = "text",
	IMG_URL = "imageUrl",
	URL = "url",
	CLIENT_SHARE = "clientShare",
	THUMB_IMG_URL = "thumbImageUrl",
	TITLE = "title",
	SITE = "site",
	COMMENT = "comment",
	TITLE_URL = "titleUrl"
}

SocialShareCN.enableEdit = false

local APP_KEY = "30024dc36b5d0"
local APP_SECRET = "f5ab96c32b81004262386fe8ea1b4d47"
local SinaParams = {
	AppKey = "1330572700",
	RedirectUrl = "https://s8etk.share2dlink.com/",
	AppSecret = "e997eb397314ec44e710a775b31724b5",
	Enable = "true"
}
local platformConfig = {
	["com.ffg.antman"] = {
		[tostring(Platform.WECHAT)] = {
			app_id = "wxf9a4ad9d622d0eb9",
			app_universalLink = "https://s8etk.share2dlink.com/",
			app_secret = "ebcdfe9fb2561196562b3e5fdd335d95",
			Enable = "true"
		},
		[tostring(Platform.QQ)] = {
			app_id = "1110395842",
			app_universalLink = "https://s8etk.share2dlink.com/qq_conn/1110395842",
			app_secret = "QUzoTCeLkmf0nRSm",
			Enable = "true"
		},
		[tostring(Platform.SINA_WEIBO)] = {
			app_secret = "e997eb397314ec44e710a775b31724b5",
			redirect_uri = "https://s8etk.share2dlink.com/",
			app_key = "1330572700",
			Enable = "true"
		}
	},
	["com.gnsbt.Shgame"] = {
		[tostring(Platform.WECHAT)] = {
			AppId = "wx5d7cf5507391aa00",
			AppSecret = "c8cbf28e7d2780f4287fb98976f6eb44",
			Enable = "true"
		},
		[tostring(Platform.QQ)] = {
			AppId = "101903294",
			AppSecret = "13b07bf5a5ac78ce1db76810bd7712e7",
			Enable = "true"
		},
		[tostring(Platform.SINA_WEIBO)] = SinaParams
	},
	["com.gnsbt.xglmgame"] = {
		[tostring(Platform.WECHAT)] = {
			AppId = "wx8eb67853a1930799",
			AppSecret = "4350da0620f1bd05a0009f1bf9b047e1",
			Enable = "true"
		},
		[tostring(Platform.QQ)] = {
			AppId = "1112290110",
			AppSecret = "OEjXEEZTLzo7HFhW",
			Enable = "true"
		},
		[tostring(Platform.SINA_WEIBO)] = SinaParams
	},
	["com.gnsbt.wanyugame"] = {
		[tostring(Platform.SINA_WEIBO)] = SinaParams
	},
	["com.gnsbt.hyhygame"] = {
		[tostring(Platform.SINA_WEIBO)] = SinaParams
	},
	["com.gnsbt.Shgame.bilibili"] = {
		[tostring(Platform.WECHAT)] = {
			AppId = "wx7a3b53d02c2e29f5",
			AppSecret = "e9c8b6eef2096d9855271f9325d32f41",
			Enable = "true"
		},
		[tostring(Platform.QQ)] = {
			AppId = "101903294",
			AppSecret = "13b07bf5a5ac78ce1db76810bd7712e7",
			Enable = "true"
		}
	},
	["com.gnsbt.Shgame.nearme.gamecenter"] = {
		[tostring(Platform.WECHAT)] = {
			AppId = "wx8294e7f8befe8e5f",
			AppSecret = "f541f584cfff5effe1f5988b896e8df5",
			Enable = "true"
		},
		[tostring(Platform.QQ)] = {
			AppId = "101903294",
			AppSecret = "13b07bf5a5ac78ce1db76810bd7712e7",
			Enable = "true"
		},
		[tostring(Platform.SINA_WEIBO)] = SinaParams
	},
	["com.gnsbt.Shgame.aligames"] = {
		[tostring(Platform.WECHAT)] = {
			AppId = "wxe668ab1d9903eafe",
			AppSecret = "c9243e01b1a317ff27efed19b8365dc3",
			Enable = "true"
		},
		[tostring(Platform.QQ)] = {
			AppId = "101903294",
			AppSecret = "13b07bf5a5ac78ce1db76810bd7712e7",
			Enable = "true"
		},
		[tostring(Platform.SINA_WEIBO)] = SinaParams
	},
	["com.gnsbt.Shgame.m4399"] = {
		[tostring(Platform.WECHAT)] = {
			AppId = "wxce3bd15f0742fb2f",
			AppSecret = "210de333263ee11e8b78dc8b1107d15d",
			Enable = "true"
		},
		[tostring(Platform.QQ)] = {
			AppId = "101903294",
			AppSecret = "13b07bf5a5ac78ce1db76810bd7712e7",
			Enable = "true"
		},
		[tostring(Platform.SINA_WEIBO)] = SinaParams
	},
	["com.gnsbt.Shgame.vivo"] = {
		[tostring(Platform.WECHAT)] = {
			AppId = "wxece496f59bebf976",
			AppSecret = "cd919c7f790217644096544f65486591",
			Enable = "true"
		},
		[tostring(Platform.QQ)] = {
			AppId = "101903294",
			AppSecret = "13b07bf5a5ac78ce1db76810bd7712e7",
			Enable = "true"
		},
		[tostring(Platform.SINA_WEIBO)] = SinaParams
	},
	["com.tencent.tmgp.gnsbt"] = {
		[tostring(Platform.QQ)] = {
			AppId = "1110395842",
			AppSecret = "QUzoTCeLkmf0nRSm",
			Enable = "true"
		},
		[tostring(Platform.SINA_WEIBO)] = SinaParams
	},
	["com.sh.figurestory"] = {
		[tostring(Platform.WECHAT)] = {
			AppId = "wx18fccd35ea6c19c4",
			AppSecret = "382a95b9210b524fbca3a3bc06b7041b",
			Enable = "true"
		},
		[tostring(Platform.QQ)] = {
			AppId = "101903304",
			AppSecret = "f0357f4b6c8e26cd9da440ebac396cef",
			Enable = "true"
		},
		[tostring(Platform.SINA_WEIBO)] = SinaParams
	},
	["com.gnsbt.Shgame.huawei"] = {
		[tostring(Platform.WECHAT)] = {
			AppId = "wx7b20e0f14fc6d246",
			AppSecret = "3e690db3a50153cf69f83a68cd538dea",
			Enable = "true"
		},
		[tostring(Platform.QQ)] = {
			AppId = "101903304",
			AppSecret = "f0357f4b6c8e26cd9da440ebac396cef",
			Enable = "true"
		},
		[tostring(Platform.SINA_WEIBO)] = SinaParams
	},
	["com.gnsbt.xgjoy.honor"] = {
		[tostring(Platform.SINA_WEIBO)] = SinaParams
	},
	["com.m648sy.gnsbtgfzf"] = {
		[tostring(Platform.SINA_WEIBO)] = SinaParams
	},
	["com.m648sy.gnsbt"] = {
		[tostring(Platform.SINA_WEIBO)] = SinaParams
	},
	["com.gnsbt.Shgame.mz"] = {
		[tostring(Platform.WECHAT)] = {
			AppId = "wx4f2421a5433d34b5",
			AppSecret = "e2a2c66839bf7417a247fd928890e6a5",
			Enable = "true"
		},
		[tostring(Platform.QQ)] = {
			AppId = "101903304",
			AppSecret = "f0357f4b6c8e26cd9da440ebac396cef",
			Enable = "true"
		},
		[tostring(Platform.SINA_WEIBO)] = SinaParams
	},
	["com.gnsbt.Shgame.mi"] = {
		[tostring(Platform.WECHAT)] = {
			AppId = "wxadc3be9695d09387",
			AppSecret = "16f81aba9167ac184fd1950fc41af395",
			Enable = "true"
		},
		[tostring(Platform.QQ)] = {
			AppId = "101903304",
			AppSecret = "f0357f4b6c8e26cd9da440ebac396cef",
			Enable = "true"
		},
		[tostring(Platform.SINA_WEIBO)] = SinaParams
	},
	["com.gnsbt.Shgame.vivoad.vivo"] = {
		[tostring(Platform.QQ)] = {
			AppId = "101903304",
			AppSecret = "f0357f4b6c8e26cd9da440ebac396cef",
			Enable = "true"
		}
	},
	["com.gnsbt.Shgame.qh360"] = {
		[tostring(Platform.QQ)] = {
			AppId = "101899289",
			AppSecret = "8f45100bc529b0837b1150568ebc47c8",
			Enable = "true"
		}
	},
	["com.gnsbt.Shgame.g.baidu"] = {
		[tostring(Platform.QQ)] = {
			AppId = "101899289",
			AppSecret = "8f45100bc529b0837b1150568ebc47c8",
			Enable = "true"
		}
	},
	["com.gnsbt.Shgame.am"] = {
		[tostring(Platform.QQ)] = {
			AppId = "101899289",
			AppSecret = "8f45100bc529b0837b1150568ebc47c8",
			Enable = "true"
		},
		[tostring(Platform.SINA_WEIBO)] = SinaParams
	},
	["com.gnsbt.Shgame.lenovo"] = {
		[tostring(Platform.QQ)] = {
			AppId = "101899289",
			AppSecret = "8f45100bc529b0837b1150568ebc47c8",
			Enable = "true"
		},
		[tostring(Platform.SINA_WEIBO)] = SinaParams
	},
	["com.gnsbt.Shgame.coolpad"] = {
		[tostring(Platform.QQ)] = {
			AppId = "101899289",
			AppSecret = "8f45100bc529b0837b1150568ebc47c8",
			Enable = "true"
		},
		[tostring(Platform.SINA_WEIBO)] = SinaParams
	},
	["com.gnsbt.Shgame.nubia"] = {
		[tostring(Platform.QQ)] = {
			AppId = "101899289",
			AppSecret = "8f45100bc529b0837b1150568ebc47c8",
			Enable = "true"
		},
		[tostring(Platform.SINA_WEIBO)] = SinaParams
	},
	["com.gnsbt.Shgame.yofun"] = {
		[tostring(Platform.QQ)] = {
			AppId = "101903304",
			AppSecret = "f0357f4b6c8e26cd9da440ebac396cef",
			Enable = "true"
		},
		[tostring(Platform.SINA_WEIBO)] = SinaParams
	},
	["com.gnsbt.Shgame.kuaishou"] = {
		[tostring(Platform.QQ)] = {
			AppId = "101916497",
			AppSecret = "e00ac96a1c4420239ecfa266887cd2b1",
			Enable = "true"
		},
		[tostring(Platform.SINA_WEIBO)] = SinaParams
	},
	["com.xgjoy.antman"] = {
		[tostring(Platform.WECHAT)] = {
			AppId = "wxf226020e7669c95b",
			AppSecret = "b75e7d6479200aa82ac14410ee61ee73",
			Enable = "true"
		}
	}
}

SocialShareCN.platformConfig = platformConfig

local showWeChat = {
	["com.gnsbt.Shgame.m4399"] = true,
	["com.gnsbt.Shgame.aligames"] = true,
	["com.gnsbt.xglmgame"] = true,
	["com.sh.figurestory"] = true,
	["com.gnsbt.Shgame.vivo"] = true,
	["com.gnsbt.Shgame.nearme.gamecenter"] = true,
	["com.gnsbt.Shgame.mi"] = true,
	["com.gnsbt.Shgame.bilibili"] = true,
	["com.tencent.tmgp.gnsbt"] = true,
	["com.gnsbt.Shgame.huawei"] = true,
	["com.gnsbt.Shgame"] = true,
	["com.ffg.antman"] = true
}
local hideQQ = {
	["com.gnsbt.xgjoy.honor"] = true,
	["com.m648sy.gnsbt"] = true,
	["com.gnsbt.wanyugame"] = true,
	["com.m648sy.gnsbtgfzf"] = true
}

SocialShareCN.showWeChat = showWeChat
SocialShareCN.hideQQ = hideQQ

function SocialShareCN:setStrategy(newStrategyNo)
	self.packageName = UnityEngine.Application.identifier
	self.curConfig = platformConfig[self.packageName]

	if not IS_PUBLISH_VERSION and self.curConfig == nil then
		self.curConfig = platformConfig["com.tencent.tmgp.gnsbt"]
	end

	if not self.curConfig then
		newStrategyNo = 0
	end

	SocialShareAgent.SetStrategy(newStrategyNo)
end

function SocialShareCN:init(strategyNo)
	local curConfig = self.curConfig

	if curConfig then
		local jsonConfig = ClientUtils.table2String(curConfig)

		SocialShareAgent.Init(APP_KEY, APP_SECRET, jsonConfig)
		SocialShareAgent.SetLuaEventCallback(SocialShareCN.onGetEvent)
	end
end

function SocialShareCN:getShareConfig()
	local config = {
		[Platform.WECHAT] = {
			false
		},
		[Platform.WECHAT_MOMENTS] = {
			true
		},
		[Platform.SINA_WEIBO] = {
			true
		},
		[Platform.QQ] = {
			false
		},
		[Platform.QZONE] = {
			true
		},
		[Platform.FACEBOOK] = {
			false
		}
	}

	return config
end

function SocialShareCN:getSharePlatforms()
	if not VersionUtils.hasAbilityShareCN() then
		return {}
	end

	local sharePlatforms = {}

	if SocialShareCN.platformConfig[self.packageName] and SocialShareCN.platformConfig[self.packageName][tostring(Platform.SINA_WEIBO)] then
		local platform0 = {
			spriteName = "BtnWeiBo",
			filePath = "Atlas/ArAtlas",
			platform = Platform.SINA_WEIBO
		}

		if DeviceHelper.isAndroid() then
			table.insert(sharePlatforms, platform0)
		elseif DeviceHelper.isIOS() and VersionUtils.getEngineVersion() >= 110692 then
			table.insert(sharePlatforms, platform0)
		end
	end

	if SocialShareCN.showWeChat[self.packageName] then
		local platform1 = {
			spriteName = "BtnWeChat",
			filePath = "Atlas/ArAtlas",
			platform = Platform.WECHAT
		}
		local platform2 = {
			spriteName = "BtnWeChatCircle",
			filePath = "Atlas/ArAtlas",
			platform = Platform.WECHAT_MOMENTS
		}

		if DeviceHelper.isAndroid() then
			local androidVersion = UnityEngine.SystemInfo.operatingSystem

			if not string.find(androidVersion, "API-30") or VersionUtils.getEngineVersion() > 110692 then
				table.insert(sharePlatforms, platform1)
				table.insert(sharePlatforms, platform2)
			end
		elseif DeviceHelper.isIOS() then
			table.insert(sharePlatforms, platform1)
			table.insert(sharePlatforms, platform2)
		end
	end

	local platform3 = {
		spriteName = "BtnQQ",
		filePath = "Atlas/ArAtlas",
		platform = Platform.QQ
	}
	local platform4 = {
		spriteName = "BtnQQSpace",
		filePath = "Atlas/ArAtlas",
		platform = Platform.QZONE
	}

	if not SocialShareCN.hideQQ[self.packageName] then
		table.insert(sharePlatforms, platform3)
		table.insert(sharePlatforms, platform4)
	end

	return sharePlatforms
end

SocialShareCN.MAX_PIXEL_COUNT = 2073600

function SocialShareCN:getPhotoResolution()
	local width, height = DeviceHelper.curWidth, DeviceHelper.curHeight

	if width and height then
		local pixelNum = width * height

		if pixelNum > SocialShareCN.MAX_PIXEL_COUNT then
			local scale = (SocialShareCN.MAX_PIXEL_COUNT / pixelNum)^0.5

			scale = math.floor(scale * 20) / 20
			width = math.floor(width * scale)
			height = math.floor(height * scale)
		end
	else
		width, height = 0, 0
	end

	return width, height
end

function SocialShareCN:sharePicture(platform, picPath, text)
	if GameConfig.getChannelConfig(Const.REMOTE_CONFIG_HIDE_SOCIAL_SHARE) == 1 then
		MsgManager.notice(Lang.get(36295))

		return
	end

	if picPath == nil then
		return
	end

	local params = {}

	if text ~= nil then
		params[paramKeys.TEXT] = text
	end

	if platform == Platform.SINA_WEIBO then
		params[paramKeys.TEXT] = " "
	end

	if platform == Platform.FACEBOOK then
		params[paramKeys.CLIENT_SHARE] = true
	end

	local paramStr

	if next(params) then
		paramStr = ClientUtils.table2String(params)
	end

	local reqId = SocialShareAgent.ShareContentFull(platform, SocialShareType.Image, picPath, paramStr, SocialShareCN.enableEdit)

	SocialShareCN.reqId = reqId

	self:_showBugTip()
end

function SocialShareCN:shareWebpage(platform, contentType, title, text, comment, url, imageUrl, picPath, enableEditor)
	if platform and (picPath or imageUrl) and title and text then
		SocialShareAgent.ShareContent(platform, contentType, title, text, comment, url, imageUrl, picPath, enableEditor)
	else
		MsgManager.notice(Lang.get(29997))
	end
end

function SocialShareCN:shareWebpageJson(platform, contentType, title, text, comment, url, imageUrl, picPath, enableEditor)
	if GameConfig.getChannelConfig(Const.REMOTE_CONFIG_HIDE_SOCIAL_SHARE) == 1 then
		MsgManager.notice(Lang.get(36295))

		return
	end

	if VersionUtils.getEngineVersion() < 88196 then
		return
	end

	if platform and (picPath or imageUrl) and title and text then
		local shareParam = {}

		shareParam.title = title
		shareParam.text = text
		shareParam.comment = comment
		shareParam.url = url
		shareParam.imageUrl = imageUrl

		if DeviceHelper.isAndroid() then
			if picPath and FileUtils.Exists(picPath, false) then
				shareParam.imagePath = picPath
			end

			if contentType == 0 then
				shareParam.shareType = 1
			elseif contentType == 10 then
				shareParam.shareType = 11
			else
				shareParam.shareType = contentType
			end

			shareParam.titleUrl = url
			shareParam.site = title
			shareParam.siteUrl = url
		elseif DeviceHelper.isIOS() then
			if picPath and FileUtils.Exists(picPath, false) then
				shareParam.imageUrl = picPath
			end

			shareParam.shareType = contentType
		end

		local paramStr = ClientUtils.table2String(shareParam)

		SocialShareAgent.ShareContentJson(platform, enableEditor, paramStr)
	else
		MsgManager.notice(Lang.get(29997))
	end
end

SocialShareCN._CSEventHandler = {
	[SocialShareEventType.SHARE_FINISH] = "onShareFinish"
}

function SocialShareCN.onGetEvent(eventType, ret, arg1, arg2)
	local funcName = SocialShareCN._CSEventHandler[eventType]

	if funcName then
		local func = SocialShareCN[funcName]

		if func then
			func(ret, arg1)
		end
	end
end

local ResponseState = {
	Begin = 0,
	BeginUPLoad = 4,
	Fail = 2,
	Cancel = 3,
	Success = 1
}

function SocialShareCN:onShareFinish(ret, resultJson)
	local msg = Lang.get(29998)

	if ret == ResponseState.Success then
		msg = Lang.get(29999)
	elseif ret == ResponseState.Fail then
		msg = Lang.get(30000)
	elseif ret == ResponseState.Cancel then
		msg = Lang.get(30001)
	end

	MsgManager.notice(msg)
end

function SocialShareCN:_showBugTip()
	if VersionUtils.getEngineVersion() == 103709 then
		if ChannelUtil.isMulti then
			local subChannelID = ChannelUtil.getSubChannelID()

			if subChannelID == "moniqi" or subChannelID == "nubia" or subChannelID == "bilibili" then
				MsgManager.notice(Lang.get(31294))

				return
			end
		end

		MsgManager.notice(Lang.get(31295))
	end
end

return SocialShareCN
