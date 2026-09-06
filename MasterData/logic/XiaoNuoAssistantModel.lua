-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/xiaonuoassistant/model/XiaoNuoAssistantModel.lua

module("logic.extensions.xiaonuoassistant.model.XiaoNuoAssistantModel", package.seeall)

local XiaoNuoAssistantModel = class("XiaoNuoAssistantModel", BaseModel)

XiaoNuoAssistantModel.cellName = "detailcell"
XiaoNuoAssistantModel.CostColor = "9C8B79"
XiaoNuoAssistantModel.MaxTabCount = 4
XiaoNuoAssistantModel.TabEnum = {
	Material = 1,
	Shop = 4,
	Gameplay = 2,
	Relaxation = 3
}
XiaoNuoAssistantModel.AssistEnum = {
	MATERILAL_CARD = 16,
	MY_ANIMALS_STROKE = 10,
	LIFE_LONG_CARD = 15,
	GOLDEN_DIAMOND_CARD = 14,
	FAMILY_BOSS_BIG = 1,
	LEGEND_CHALLENGE_SWEEP = 23,
	MONTH_CARD = 12,
	MY_ANIMALS_GAIN_PRIZE = 8,
	MATERILAL_CARD_NEW = 17,
	WARRIOR_TOWER_TURN_TIME = 20,
	PAY_SHOP = 21,
	DAILY_FREE_STRENGTH = 7,
	MY_ANIMALS_ONE_KEY_FEED = 9,
	GOOD_FEELING_ANSWER = 24,
	DAILY_MIQILIN_STRENGTH = 6,
	MONEY_CAT = 5,
	FAMILY_DONATE = 18,
	GOOD_FEELING = 11,
	MATERIAL_CHALLENGE_SWEEP = 22,
	MONTH_CARD_NEW = 13,
	ONE_KEY_DISPATCH = 19,
	INFINITE_FIGHT = 3,
	THRONE_DAILY_PRIZE = 4,
	FAMILY_BOSS_DRAGON = 2
}
XiaoNuoAssistantModel.FuncEnum = {
	MATERILAL_CARD = 9,
	MY_ANIMALS = 7,
	DAILY_FREE_STRENGTH = 6,
	ARENA = 20,
	WARRIOR_TOWER_TURN_TIME = 14,
	LEGEND_CHALLENGE_SWEEP = 13,
	GOOD_FEELING_ANSWER = 15,
	YEAR_REWARD = 18,
	CutePet = 23,
	LingWen = 21,
	BoZhenTianXia = 22,
	GOOD_FEELING = 8,
	SHI_KONG_ZHI_MEN_SIGN = 25,
	FAMILY_BOSS = 1,
	DAILY_MIQILIN_STRENGTH = 5,
	MONEY_CAT = 4,
	VIP_REWARD = 17,
	FAMILY_DONATE = 10,
	PAY_SHOP = 16,
	MATERIAL_CHALLENGE_SWEEP = 12,
	ONE_KEY_DISPATCH = 11,
	INFINITE_FIGHT = 2,
	THRONE_DAILY_PRIZE = 3,
	TimeWheel_Exchange = 19,
	FAMILY_TASK = 24
}
XiaoNuoAssistantModel.Assist25ResultState = {
	Success = 2,
	Skipped = 4,
	Failed = 3,
	Pending = 1
}
XiaoNuoAssistantModel.Assist25ResultGroup = {
	DirectSign = 1,
	OpenThenSign = 2
}
XiaoNuoAssistantModel.Assist25CallbackStage = {
	OpenGate = 2,
	DirectSign = 1,
	SignAfterOpen = 3
}
XiaoNuoAssistantModel.PrefabClass = {
	AssistCell1,
	AssistCell2,
	AssistCell3,
	AssistCell4,
	AssistCell5,
	AssistCell6,
	AssistCell7,
	AssistCell8,
	AssistCell9,
	AssistCell10,
	AssistCell11,
	AssistCell12,
	AssistCell13,
	AssistCell14,
	AssistCell15,
	AssistCell16,
	AssistCell17,
	AssistCell18,
	AssistCell19,
	AssistCell20,
	AssistCell21,
	AssistCell22,
	AssistCell23,
	AssistCell24,
	AssistCell25
}
XiaoNuoAssistantModel.DataClass = {
	AssistData1,
	AssistData2,
	AssistData3,
	AssistData4,
	AssistData5,
	AssistData6,
	AssistData7,
	AssistData8,
	AssistData9,
	AssistData10,
	AssistData11,
	AssistData12,
	AssistData13,
	AssistData14,
	AssistData15,
	AssistData16,
	AssistData17,
	AssistData18,
	AssistData19,
	AssistData20,
	AssistData21,
	AssistData22,
	AssistData23,
	AssistData24,
	AssistData25
}
XiaoNuoAssistantModel.TabList = {
	{
		4,
		5,
		6,
		11,
		17,
		18
	},
	{
		2,
		22,
		12,
		21,
		14,
		20,
		10,
		25,
		13,
		23,
		24
	},
	{
		3,
		7,
		8,
		15
	},
	{
		9,
		16,
		19
	}
}
XiaoNuoAssistantModel.DataTypeList = {
	{
		5,
		6,
		7
	},
	{
		3,
		20,
		1,
		2,
		18,
		25
	},
	{
		4,
		8,
		9,
		10,
		11
	},
	{
		12,
		13,
		14,
		15,
		16,
		17
	}
}

function XiaoNuoAssistantModel:getInitReqList()
	return {
		[XiaoNuoAssistantModel.TabEnum.Material] = {
			false,
			false,
			false,
			false,
			false,
			false
		},
		[XiaoNuoAssistantModel.TabEnum.Gameplay] = {
			false,
			false,
			false,
			false,
			false,
			false,
			false,
			false,
			false,
			false,
			false,
			false,
			false,
			false,
			false
		},
		[XiaoNuoAssistantModel.TabEnum.Relaxation] = {
			false,
			false,
			false,
			false
		},
		[XiaoNuoAssistantModel.TabEnum.Shop] = {
			false,
			false,
			false
		}
	}
end

function XiaoNuoAssistantModel:ctor()
	return
end

function XiaoNuoAssistantModel:onInit()
	self:onReset()
end

function XiaoNuoAssistantModel:onReset()
	self._infoDic = {}
end

function XiaoNuoAssistantModel:onhandleXiaoNuoAssistantInfoRes(msg)
	local list = GameUtil.pbToTable(msg.info) or {}

	for i, v in ipairs(list) do
		self._infoDic[v.type] = self._infoDic[v.type] or {}

		local info = self._infoDic[v.type]

		info.type = v.type
		info.canBeOperated = v.canBeOperated
		info.gainTimes = v.gainTimes
		info.maxTimes = v.maxTimes
		info.extResult = v.extResult
	end
end

function XiaoNuoAssistantModel:isCanBeOperated(type)
	return self._infoDic[type] and self._infoDic[type].canBeOperated
end

function XiaoNuoAssistantModel:getGainTimes(type)
	return (self._infoDic[type] or nil) and (self._infoDic[type].gainTimes or 0)
end

function XiaoNuoAssistantModel:isExistMaxTimes(type)
	return self._infoDic[type] and self._infoDic[type].maxTimes ~= nil
end

function XiaoNuoAssistantModel:getMaxTimes(type)
	return (self._infoDic[type] or nil) and (self._infoDic[type].maxTimes or 1)
end

function XiaoNuoAssistantModel:getExtResult(type)
	return self._infoDic[type] and self._infoDic[type].extResult
end

XiaoNuoAssistantModel.instance = XiaoNuoAssistantModel.New()

return XiaoNuoAssistantModel
