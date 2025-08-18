-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/System\\Recharge\\RechargeConst.lua

local OpenServerConst = require("Network/OpenServerConst")
local SDKConst = require("SDK/SDKConst")
local AccountType = OpenServerConst.AccountType
local ChannelID = SDKConst.ChannelID
local RechargeConst = {}
local ID_CHANNEL = {
	FLOW = 10
}

RechargeConst.RECHARGE_ID_CHANNEL = ID_CHANNEL

local PRODUCT_METHOD_DEFAULT = 1
local PRODUCT_METHOD_INPUT = 2

RechargeConst.PRODUCT_METHOD_DEFAULT = PRODUCT_METHOD_DEFAULT
RechargeConst.PRODUCT_METHOD_INPUT = PRODUCT_METHOD_INPUT

local RECHARGE_CHANNEL_DICT = {
	PLAT = {
		id = 19,
		imp = "rechargeChannelPlat",
		bindChannel = ChannelID.PLAT,
		rechargeIDChannel = ID_CHANNEL.FLOW
	},
	XGJOY_IAP = {
		id = 6,
		imp = "rechargeChannelIAP",
		productMethod = PRODUCT_METHOD_INPUT,
		rechargeIDChannel = ID_CHANNEL.FLOW
	},
	XGJOY_PAYTYPE = {
		id = 9,
		imp = "rechargeChannelXgjoy",
		rechargeIDChannel = ID_CHANNEL.FLOW
	},
	UC = {
		id = 11,
		imp = "rechargeChannelUC",
		bindChannel = ChannelID.UC,
		rechargeIDChannel = ID_CHANNEL.FLOW
	},
	HUAWEI = {
		imp = "rechargeChannelHuawei",
		id = 12,
		productMethod = PRODUCT_METHOD_INPUT,
		bindChannel = ChannelID.HUAWEI,
		rechargeIDChannel = ID_CHANNEL.FLOW
	},
	OPPO = {
		id = 13,
		imp = "rechargeChannelOppo",
		bindChannel = ChannelID.OPPO,
		rechargeIDChannel = ID_CHANNEL.FLOW
	},
	VIVO = {
		id = 14,
		imp = "rechargeChannelVivo",
		bindChannel = ChannelID.VIVO,
		rechargeIDChannel = ID_CHANNEL.FLOW
	},
	YYB = {
		id = 15,
		imp = "rechargeChannelYYB",
		bindChannel = ChannelID.YYB,
		rechargeIDChannel = ID_CHANNEL.FLOW
	},
	XIAOMI = {
		id = 16,
		imp = "rechargeChannelXiaoMi",
		bindChannel = ChannelID.XIAOMI,
		rechargeIDChannel = ID_CHANNEL.FLOW
	},
	MULTI = {
		id = 22,
		imp = "rechargeChannelMulti",
		bindChannel = ChannelID.MULTI,
		rechargeIDChannel = ID_CHANNEL.FLOW
	},
	BYTED = {
		id = 24,
		imp = "rechargeChannelByted",
		bindChannel = ChannelID.BYTED,
		rechargeIDChannel = ID_CHANNEL.FLOW
	},
	KOMOE = {
		id = 23,
		imp = "rechargeChannelKomoe",
		bindChannel = ChannelID.KOMOE,
		rechargeIDChannel = ID_CHANNEL.FLOW
	},
	BILIKOREA = {
		id = 25,
		imp = "rechargeChannelBiliKorea",
		bindChannel = ChannelID.BILIKOREA,
		rechargeIDChannel = ID_CHANNEL.FLOW
	},
	BILISEA = {
		id = 26,
		imp = "rechargeChannelBiliSea",
		bindChannel = ChannelID.BILISEA,
		rechargeIDChannel = ID_CHANNEL.FLOW
	},
	FLOW = {
		id = 1,
		imp = "rechargeChannelFlow",
		bindChannel = ChannelID.FLOW,
		rechargeIDChannel = ID_CHANNEL.FLOW
	},
	BT = {
		id = 27,
		imp = "rechargeChannelBT",
		bindChannel = ChannelID.BT,
		rechargeIDChannel = ID_CHANNEL.FLOW
	}
}
local RECHARGE_CHANNEL = {}

for name, info in pairs(RECHARGE_CHANNEL_DICT) do
	RECHARGE_CHANNEL[name] = info.id
end

RechargeConst.RECHARGE_CHANNEL_DICT = RECHARGE_CHANNEL_DICT
RechargeConst.RECHARGE_CHANNEL = RECHARGE_CHANNEL
RechargeConst.RECHARGE_CHANNEL_INFO_EDITOR = RECHARGE_CHANNEL_DICT.XGJOY_IAP
RechargeConst.RECHARGE_CAHNNEL_ID_EDITOR = RECHARGE_CHANNEL.XGJOY_IAP
RechargeConst.PAY_TYPE = {
	ABPAY = 3,
	WNPAY = 2,
	APPLE = 1,
	NONE = 0
}
RechargeConst.PAY_TYPE_ENUM = {
	[RechargeConst.PAY_TYPE.NONE] = "kOrderPayTypeCodeNone",
	[RechargeConst.PAY_TYPE.APPLE] = "kOrderPayTypeCodeApple",
	[RechargeConst.PAY_TYPE.WNPAY] = "kOrderPayTypeCodeWN",
	[RechargeConst.PAY_TYPE.ABPAY] = "kOrderPayTypeCodeABPay"
}

local RECHARGE_ERROR_CODE = {
	VERIFYED_ERROR = "RechargeErrorCodeVerifyError",
	IN_TRANSACTION = "RechargeErrorCodeInTransaction",
	NOT_INITED = "RechargeErrorCodeNotInited",
	PRODUCT_SOLD_OUT = "RechargeErrorCodeProductSoldOut",
	INVALID_GAME_INFO = "RechargeErrorCodeInvalidGameInfo",
	UNFINISHED_PRODUCT_ID = "RechargeErrorCodeUnfinishedProductId",
	NOT_INPUT_BIRTHDAY = "RechargeErrorCodeAgeLimit",
	UNKNOWN = "RechargeErrorCodeUnknown",
	QUERY_AGE = "RechargeErrorCodeQueryAge",
	SUCCESS = "RechargeErrorCodeSuccess",
	INVALID_PRODUCT_ID = "RechargeErrorCodeInvalidProductId"
}

RechargeConst.RECHARGE_ERROR_CODE = RECHARGE_ERROR_CODE
RechargeConst.ERROR_CODE_MSG = {
	[RECHARGE_ERROR_CODE.SUCCESS] = Lang.get(30058),
	[RECHARGE_ERROR_CODE.NOT_INITED] = Lang.get(30059),
	[RECHARGE_ERROR_CODE.INVALID_PRODUCT_ID] = Lang.get(30060),
	[RECHARGE_ERROR_CODE.INVALID_GAME_INFO] = Lang.get(30061),
	[RECHARGE_ERROR_CODE.IN_TRANSACTION] = Lang.get(30062),
	[RECHARGE_ERROR_CODE.PRODUCT_SOLD_OUT] = Lang.get(30063),
	[RECHARGE_ERROR_CODE.VERIFYED_ERROR] = Lang.get(30064),
	[RECHARGE_ERROR_CODE.UNFINISHED_PRODUCT_ID] = Lang.get(30065),
	[RECHARGE_ERROR_CODE.NOT_INPUT_BIRTHDAY] = Lang.get(30066),
	[RECHARGE_ERROR_CODE.QUERY_AGE] = Lang.get(30067),
	[RECHARGE_ERROR_CODE.UNKNOWN] = Lang.get(30068)
}
RechargeConst.UNFINISHED_TIP_HAS_RECORD = Lang.get(30069)
RechargeConst.UNFINISHED_TIP_NO_RECORD = Lang.get(30070)
RechargeConst.UNFINISHED_TIP_NO_ROLE = Lang.get(30071)
RechargeConst.VERIFY_ERROR_MSG_MC = Lang.get(30072)
RechargeConst.KEY_IAP_PERSIST_DATA = "KeyIapPersistData"

return RechargeConst
