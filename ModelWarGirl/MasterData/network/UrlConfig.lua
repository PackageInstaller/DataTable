-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/Network\\UrlConfig.lua

local DeviceHelper = require("Helper/DeviceHelper")
local ChannelUtil = require("SDK/ChannelUtil")
local UserData = require("Helper/UserData")
local VersionUtils = require("System/VersionUtils")
local HttpHelper = require("Network/HttpHelper")
local LuaToolkit = Framework.Tools.LuaToolkit
local IS_FORCE_INTRANET = LuaToolkit.IsForceIntranet()
local UrlConfig = {}
local self = UrlConfig

UrlConfig.isPublish = IS_PUBLISH_VERSION
UrlConfig.platform = string.lower(DeviceHelper.runtimePlatform)
UrlConfig.spMark = nil
UrlConfig.postfix = LuaToolkit.GetPatchPostfix()
UrlConfig.isPre = UrlConfig.postfix == "pre"
UrlConfig.isReview = VersionUtils.IsReviewVersion(true)

local POSTFIX_PRE = "pre"
local POSTFIX_QA = "qa"
local POSTFIX_DEFAULT = "_default"

UrlConfig.URL_CONST = {
	[{
		"shmain"
	}] = {
		[POSTFIX_DEFAULT] = {
			{
				"https://l1-api.antman-prod.xgjoy.com/",
				"https://l2-api.antman-prod.xgjoy.com/"
			},
			{
				"https://l1-api.antman-prod.xgjoy.com/",
				"https://l2-api.antman-prod.xgjoy.com/"
			}
		},
		[POSTFIX_PRE] = {
			{
				"https://api.antman-test.xgjoy.com/"
			},
			{
				"https://api.antman-test.xgjoy.com/"
			}
		}
	},
	[{
		"shmainreview"
	}] = {
		[POSTFIX_DEFAULT] = {
			{
				"https://l1-api.antman-prod.xgjoy.com/",
				"https://l2-api.antman-prod.xgjoy.com/"
			},
			{
				"https://l1-api.antman-prod.xgjoy.com/",
				"https://l2-api.antman-prod.xgjoy.com/"
			}
		}
	},
	[{
		"business",
		"business1",
		"cmptest",
		"studio",
		"zjtest",
		"designer"
	}] = {
		[POSTFIX_DEFAULT] = {
			{
				"https://api.antman-test.xgjoy.com/"
			},
			{
				"https://api.antman-test.xgjoy.com/"
			}
		}
	},
	[{
		"ibytemain"
	}] = {
		[POSTFIX_DEFAULT] = {
			{
				"https://l1-api-antman-jp-prod.xgjoy.com/",
				"https://l2-api-antman-jp-prod.flowgame-cdn.com/"
			},
			{
				"https://api-antman-jp-prod.xgjoy.com:8801/"
			}
		},
		[POSTFIX_PRE] = {
			{
				"https://antman-jp-test-all.xgjoy.com/"
			},
			{
				"http://192.168.1.168:8801/"
			}
		},
		[POSTFIX_QA] = {
			{
				"https://antman-jp-test-all.xgjoy.com/"
			},
			{
				"http://192.168.1.168:8801/"
			}
		}
	},
	[{
		"ibyted",
		"ibytecbreview",
		"ibytemainreview"
	}] = {
		[POSTFIX_DEFAULT] = {
			{
				"https://antman-jp-test-all.xgjoy.com/"
			},
			{
				"http://192.168.1.168:8801/"
			}
		}
	},
	[{
		"ibytecb"
	}] = {
		[POSTFIX_DEFAULT] = {
			{
				"https://antman-jp-test-all.xgjoy.com/"
			},
			{
				"http://192.168.1.168:8801/"
			}
		},
		[POSTFIX_PRE] = {
			{
				"https://antman-jp-test-all.xgjoy.com/"
			},
			{
				"http://192.168.1.168:8801/"
			}
		},
		[POSTFIX_QA] = {
			{
				"https://antman-jp-test-all.xgjoy.com/"
			},
			{
				"http://192.168.1.168:8801/"
			}
		}
	},
	[{
		"ibytebusiness"
	}] = {
		[POSTFIX_DEFAULT] = {
			{
				"https://antman-jp-test-all.xgjoy.com/"
			},
			{
				"http://192.168.1.168:8801/"
			}
		}
	},
	[{
		"ibilimain"
	}] = {
		[POSTFIX_DEFAULT] = {
			{
				"https://l13-prod-opensrv-figurestory.komoejoy.com/"
			},
			{
				"https://prod-cmonitor-figurestory.komoejoy.com:28801/"
			}
		},
		[POSTFIX_PRE] = {
			{
				"https://l11-dev-figurestory-gs-opensrv.komoejoy.com/"
			},
			{
				"https://cb-figurestory-gs-flowdata.komoejoy.com:28801/"
			}
		},
		[POSTFIX_QA] = {
			{
				"https://l11-dev-figurestory-gs-opensrv.komoejoy.com/"
			},
			{
				"https://cb-figurestory-gs-flowdata.komoejoy.com:28801/"
			}
		}
	},
	[{
		"ibilibili"
	}] = {
		[POSTFIX_DEFAULT] = {
			{
				"https://l11-dev-figurestory-gs-opensrv.komoejoy.com/"
			},
			{
				"https://cb-figurestory-gs-flowdata.komoejoy.com:28801/"
			}
		}
	},
	[{
		"ibilimainreview"
	}] = {
		[POSTFIX_DEFAULT] = {
			{
				"https://l11-ts-figurestory-gs-opensrv.komoejoy.com/"
			},
			{
				"https://cb-figurestory-gs-flowdata.komoejoy.com:28801/"
			}
		}
	},
	[{
		"ikotest"
	}] = {
		[POSTFIX_DEFAULT] = {
			{
				"https://l11-test-opensrv-figurestory.bilibiligame.kr/"
			},
			{
				"http://192.168.1.168:8801/"
			}
		}
	},
	[{
		"ikoreview"
	}] = {
		[POSTFIX_DEFAULT] = {
			{
				"http://antman-kr-test-all.xgjoy.com/"
			},
			{
				"http://192.168.1.168:8801/"
			}
		}
	},
	[{
		"ikocb"
	}] = {
		[POSTFIX_DEFAULT] = {
			{
				"https://l11-prod-opensrv-figurestory.bilibiligame.kr/",
				"https://l13-prod-opensrv-figurestory.bilibiligame.kr/"
			},
			{
				"http://192.168.1.168:8801/"
			}
		},
		[POSTFIX_PRE] = {
			{
				"https://l11-test-opensrv-figurestory.bilibiligame.kr/"
			},
			{
				"http://192.168.1.168:8801/"
			}
		},
		[POSTFIX_QA] = {
			{
				"https://l11-test-opensrv-figurestory.bilibiligame.kr/"
			},
			{
				"http://192.168.1.168:8801/"
			}
		}
	},
	[{
		"ikomain"
	}] = {
		[POSTFIX_DEFAULT] = {
			{
				"https://l1-api-antman-kr-prod.xgjoy.com/",
				"https://l2-api-antman-kr-prod.flowgame-cdn.com/"
			},
			{
				"http://192.168.1.168:8801/"
			}
		},
		[POSTFIX_PRE] = {
			{
				"http://antman-kr-test-all.xgjoy.com/"
			},
			{
				"http://192.168.1.168:8801/"
			}
		},
		[POSTFIX_QA] = {
			{
				"http://antman-kr-test-all.xgjoy.com/"
			},
			{
				"http://192.168.1.168:8801/"
			}
		}
	},
	[{
		"iseatest"
	}] = {
		[POSTFIX_DEFAULT] = {
			{
				"https://l11-test-opensrv-figurestory-sea.komoejoy-sea.com/"
			},
			{
				"http://192.168.1.168:8801/"
			}
		}
	},
	[{
		"iseamain_sea"
	}] = {
		[POSTFIX_DEFAULT] = {
			{
				"https://l1-api-antman-sea-prod.xgjoy.com/",
				"https://l2-api-antman-sea-prod.flowgame-cdn.com/"
			},
			{
				"http://192.168.1.168:8801/"
			}
		},
		[POSTFIX_PRE] = {
			{
				"http://api-antman-sea-test-all.xgjoy.com/"
			},
			{
				"http://192.168.1.168:8801/"
			}
		},
		[POSTFIX_QA] = {
			{
				"http://api-antman-sea-test-all.xgjoy.com/"
			},
			{
				"http://192.168.1.168:8801/"
			}
		}
	},
	[{
		"iseamain_na"
	}] = {
		[POSTFIX_DEFAULT] = {
			{
				"https://l1-api-antman-na-prod.xgjoy.com/",
				"https://l2-api-antman-na-prod.flowgame-cdn.com/"
			},
			{
				"http://192.168.1.168:8801/"
			}
		},
		[POSTFIX_PRE] = {
			{
				"http://api-antman-sea-test-all.xgjoy.com/"
			},
			{
				"http://192.168.1.168:8801/"
			}
		},
		[POSTFIX_QA] = {
			{
				"http://api-antman-sea-test-all.xgjoy.com/"
			},
			{
				"http://192.168.1.168:8801/"
			}
		}
	},
	[{
		"iseamain_eu"
	}] = {
		[POSTFIX_DEFAULT] = {
			{
				"https://l1-api-antman-eu-prod.xgjoy.com/",
				"https://l2-api-antman-eu-prod.flowgame-cdn.com/"
			},
			{
				"http://192.168.1.168:8801/"
			}
		},
		[POSTFIX_PRE] = {
			{
				"http://api-antman-sea-test-all.xgjoy.com/"
			},
			{
				"http://192.168.1.168:8801/"
			}
		},
		[POSTFIX_QA] = {
			{
				"http://api-antman-sea-test-all.xgjoy.com/"
			},
			{
				"http://192.168.1.168:8801/"
			}
		}
	},
	[{
		"iseamainreview_sea",
		"iseamainreview_na",
		"iseamainreview_eu"
	}] = {
		[POSTFIX_DEFAULT] = {
			{
				"http://api-antman-sea-test-all.xgjoy.com/"
			},
			{
				"http://192.168.1.168:8801/"
			}
		}
	},
	[{
		"iseatestreview"
	}] = {
		[POSTFIX_DEFAULT] = {
			{
				"https://l11-test-opensrv-figurestory-sea.komoejoy-sea.com/"
			},
			{
				"http://192.168.1.168:8801/"
			}
		}
	},
	[{
		"iseabusiness_sea"
	}] = {
		[POSTFIX_DEFAULT] = {
			{
				"https://l11-test-opensrv-figurestory-sea.komoejoy-sea.com/"
			},
			{
				"http://192.168.1.168:8801/"
			}
		}
	},
	[{
		"iseatest_sea"
	}] = {
		[POSTFIX_DEFAULT] = {
			{
				"https://l11-test-opensrv-figurestory-sea.komoejoy-sea.com/"
			},
			{
				"http://192.168.1.168:8801/"
			}
		}
	},
	[{
		"uwa"
	}] = {
		[POSTFIX_DEFAULT] = {
			{
				"https://tpapi.gnsbt.app.d2ty.com/"
			},
			{
				"http://192.168.1.168:8801/"
			}
		}
	},
	[{
		"sdkdev"
	}] = {
		[POSTFIX_DEFAULT] = {
			{
				"http://misc01.xgjoy.org:19000/"
			},
			{
				"http://192.168.1.168:8801/"
			}
		}
	},
	[{
		"__dev"
	}] = {
		[POSTFIX_DEFAULT] = {
			{
				"http://192.168.1.16/"
			},
			{
				"http://192.168.1.168:8801/"
			}
		}
	}
}

local _Const = {}

UrlConfig.Const = _Const
_Const.PROJECT_NAME = "antman"
_Const.URL_ACCOUNT = "account/token"
_Const.URL_ACCOUNT_BIND = "account/bind"
_Const.URL_ACCOUNT_RECORD_MOBILE = "account/record"
_Const.URL_SERVER_LIST_FULL = "svrlist/lista/"
_Const.URL_SERVER_LIST_ENTRY = "svrlist/entryaddr/"
_Const.URL_SERVER_LIST_NAME = "svrlist/idname/"
_Const.URL_NOTICE = "svrlist/note/"
_Const.URL_NOTICE_JP = "svrlist/notev2/"
_Const.URL_PAY_RECEIPT_IG = "pay/igreceipt/"
_Const.URL_PAY_RECEIPT = "pay/receipt/"
_Const.URL_PAY_RESUPPLY = "pay/resupply/"
_Const.URL_GEN_SMS_CODE = "sms/generate"
_Const.URL_LIMIT_USERINFO = "limit/userinfo"
_Const.URL_LIMIT_ONLINE = "limit/online"
_Const.URL_TERM = _Const.PROJECT_NAME .. "/terms/"
_Const.ACCOUNT_ENTRY = "account/entry"
_Const.GET_CODE = "account/code/get"
_Const.SET_CODE = "account/code/set"
_Const.USE_CODE = "account/code/use"
_Const.Cancellation_Cancel = "account/logoff/cancel"
_Const.Cancellation_Check = "account/logoff/status"
_Const.Bind_Role = "account/jp/migrate"

function UrlConfig.getSpMark()
	if UrlConfig._debugSpMark then
		return UrlConfig._debugSpMark
	end

	local spmark = LuaToolkit.GetPatchSPMark()

	if RegionUtils.isSEA() then
		local ServerSection = require("Network/ServerSection")
		local section = ServerSection.getSection()

		if section then
			spmark = UrlConfig._combineSpMarkWithSection(spmark, section)
		end
	end

	return spmark
end

function UrlConfig._combineSpMarkWithSection(raw, section)
	local withSection = (raw or "") .. "_" .. section

	return withSection
end

UrlConfig.LateUpdate = false

local function getSvrlistUseBy()
	local useBy = "dev"

	if IS_FORCE_INTRANET then
		useBy = "dev"
	elseif UrlConfig.isPublish then
		local args = {}

		if UrlConfig.isReview then
			table.insert(args, UrlConfig.platform)
		else
			table.insert(args, "all")
		end

		if UrlConfig.spMark ~= "" then
			if UrlConfig.LateUpdate and ChannelUtil.getSubChannelID() == "xxgame" then
				table.insert(args, "xxgame")
			else
				table.insert(args, UrlConfig.spMark)
			end
		end

		if UrlConfig.postfix ~= "" then
			if UrlConfig.isPre then
				if UrlConfig.LateUpdate and ChannelUtil.getSubChannelID() == "xxgame" then
					args = {
						"pre_xxgame"
					}
				else
					args = {
						"pre"
					}
				end
			else
				table.insert(args, UrlConfig.postfix)
			end
		end

		useBy = table.concat(args, "_")
	end

	return useBy
end

local function getOpenUrl(service)
	local url = self._openSvrUrlGroup:GetClone()

	if service ~= nil then
		url:Concat(service)
	end

	return url
end

local function getMonitorUrl()
	local url = self._monitorUrlGroup:GetClone()

	url:Concat("api/monitor")

	return url
end

local wlanStr = UserData.loadCommonData("WLAN_FLAG")

if wlanStr == "1" then
	Const.IS_NOT_WLAN = true
else
	Const.IS_NOT_WLAN = false
end

function UrlConfig.updateUrls()
	UrlConfig.spMark = UrlConfig.getSpMark()

	local urlKey = "__dev"

	if UrlConfig.isPublish and not IS_FORCE_INTRANET then
		urlKey = UrlConfig.spMark
	end

	self.updateUrlBase(urlKey)

	local useBy = getSvrlistUseBy()

	UrlConfig.useBy = useBy
	UrlConfig.AccountUrl = getOpenUrl(_Const.URL_ACCOUNT)
	UrlConfig.AccountBindUrl = getOpenUrl(_Const.URL_ACCOUNT_BIND)
	UrlConfig.AccountRecordMobileUrl = getOpenUrl(_Const.URL_ACCOUNT_RECORD_MOBILE)
	UrlConfig.ServerListUrl = getOpenUrl(_Const.URL_SERVER_LIST_FULL .. useBy)
	UrlConfig.ServerListEntryUrl = getOpenUrl(_Const.URL_SERVER_LIST_ENTRY .. useBy)
	UrlConfig.ServerListNameUrl = getOpenUrl(_Const.URL_SERVER_LIST_NAME .. useBy)
	UrlConfig.ReceiptIG = getOpenUrl(_Const.URL_PAY_RECEIPT_IG)
	UrlConfig.Receipt = getOpenUrl(_Const.URL_PAY_RECEIPT)
	UrlConfig.Resupply = getOpenUrl(_Const.URL_PAY_RESUPPLY)
	UrlConfig.GenSmsCode = getOpenUrl(_Const.URL_GEN_SMS_CODE)
	UrlConfig.LimitUserInfo = getOpenUrl(_Const.URL_LIMIT_USERINFO)
	UrlConfig.LimitOnline = getOpenUrl(_Const.URL_LIMIT_ONLINE)
	UrlConfig.NoticeUrl = getOpenUrl(_Const.URL_NOTICE .. useBy)
	UrlConfig.NoticeUrlJP = getOpenUrl(_Const.URL_NOTICE_JP .. useBy)
	UrlConfig.MonitorUrl = getMonitorUrl()
	UrlConfig.GetCode = getOpenUrl(_Const.GET_CODE)
	UrlConfig.SetCode = getOpenUrl(_Const.SET_CODE)
	UrlConfig.UseCode = getOpenUrl(_Const.USE_CODE)
	UrlConfig.CancellationCancel = getOpenUrl(_Const.Cancellation_Cancel)
	UrlConfig.CancellationCheck = getOpenUrl(_Const.Cancellation_Check)
	UrlConfig.BindRole = getOpenUrl(_Const.Bind_Role)
end

function UrlConfig._getUrlGroup(urlKey)
	local urlConst = UrlConfig.URL_CONST
	local curUrls

	for keys, urls in pairs(urlConst) do
		for _, key in ipairs(keys) do
			if urlKey == key then
				curUrls = urls[UrlConfig.postfix] or urls[POSTFIX_DEFAULT]

				break
			end
		end

		if curUrls ~= nil then
			break
		end
	end

	local openSvrs, monitorSvrs

	if curUrls then
		openSvrs, monitorSvrs = curUrls[1], curUrls[2]
	else
		openSvrs, monitorSvrs = {
			"http://127.0.0.1/"
		}, {
			"http://127.0.0.1/"
		}
	end

	return openSvrs, monitorSvrs
end

function UrlConfig.updateUrlBase(urlKey)
	local openSvrs, monitorSvrs = UrlConfig._getUrlGroup(urlKey)

	self._openSvrUrlGroup = HttpHelper.createUrlGroup(openSvrs)
	self._monitorUrlGroup = HttpHelper.createUrlGroup(monitorSvrs)
end

function UrlConfig.setDebugArgs(isPub, platform, spMark, postfix)
	UrlConfig.isPublish = isPub
	UrlConfig.platform = platform
	UrlConfig.spMark = spMark
	UrlConfig.postfix = postfix

	self.updateUrls()
end

function UrlConfig.getSectionOpenUrls(spMarkRaw, sections, concat)
	local raw = LuaToolkit.GetPatchSPMark()
	local urlDict = {}

	for i, section in ipairs(sections) do
		local spMark = UrlConfig._combineSpMarkWithSection(raw, section)
		local openSvrs, monitorSvrs = UrlConfig._getUrlGroup(spMark)
		local url = HttpHelper.createUrlGroup(openSvrs)

		if concat then
			url:Concat(concat)
		end

		urlDict[section] = url
	end

	return urlDict
end

self.updateUrls()

return UrlConfig
