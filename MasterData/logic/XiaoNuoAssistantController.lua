-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/xiaonuoassistant/controller/XiaoNuoAssistantController.lua

module("logic.extensions.xiaonuoassistant.controller.XiaoNuoAssistantController", package.seeall)

local XiaoNuoAssistantController = class("XiaoNuoAssistantController", BaseController)

XiaoNuoAssistantController.HideDropdown = "XiaoNuoAssistantController_HideDropdown"

function XiaoNuoAssistantController:ctor()
	return
end

function XiaoNuoAssistantController:onInit()
	return
end

function XiaoNuoAssistantController:getParams(funcId)
	local cfg = XiaoNuoAssistantConfig.instance:getStrCfg(funcId)

	return cfg.params
end

function XiaoNuoAssistantController:getCellHeight(funcId)
	local x = 792

	return x, funcId == XiaoNuoAssistantModel.FuncEnum.GOOD_FEELING_ANSWER and 320 or funcId == XiaoNuoAssistantModel.FuncEnum.MATERIAL_CHALLENGE_SWEEP and 316 or (funcId >= XiaoNuoAssistantModel.FuncEnum.FAMILY_DONATE and funcId <= XiaoNuoAssistantModel.FuncEnum.PAY_SHOP or funcId == XiaoNuoAssistantModel.FuncEnum.BoZhenTianXia) and 160 or (funcId == XiaoNuoAssistantModel.FuncEnum.INFINITE_FIGHT or funcId == XiaoNuoAssistantModel.FuncEnum.THRONE_DAILY_PRIZE or funcId == XiaoNuoAssistantModel.FuncEnum.MONEY_CAT or funcId == XiaoNuoAssistantModel.FuncEnum.DAILY_MIQILIN_STRENGTH or funcId == XiaoNuoAssistantModel.FuncEnum.DAILY_FREE_STRENGTH or funcId == XiaoNuoAssistantModel.FuncEnum.GOOD_FEELING or funcId == XiaoNuoAssistantModel.FuncEnum.MY_ANIMALS or funcId == XiaoNuoAssistantModel.FuncEnum.VIP_REWARD or funcId == XiaoNuoAssistantModel.FuncEnum.YEAR_REWARD or funcId == XiaoNuoAssistantModel.FuncEnum.CutePet or funcId == XiaoNuoAssistantModel.FuncEnum.FAMILY_TASK) and 160 or funcId == XiaoNuoAssistantModel.FuncEnum.TimeWheel_Exchange and 346 or funcId == XiaoNuoAssistantModel.FuncEnum.ARENA and 240 or funcId == XiaoNuoAssistantModel.FuncEnum.LingWen and 316 or funcId == XiaoNuoAssistantModel.FuncEnum.SHI_KONG_ZHI_MEN_SIGN and 410 or 118
end

function XiaoNuoAssistantController:getTabIdByFuncEnum(funcEnum)
	for tabId, list in pairs(XiaoNuoAssistantModel.TabList) do
		for i, funcId in ipairs(list) do
			if funcId == funcEnum then
				return tabId
			end
		end
	end

	return 0
end

function XiaoNuoAssistantController:sendGetSignInBuffInfoList()
	local list = XiaoNuoAssistantConfig.instance:getSignInBuffList() or {}
	local activityId_i32_Ary = {}

	for i, v in ipairs(list) do
		table.insert(activityId_i32_Ary, v.activityId)
	end

	SignInBuffAgent.instance:sendPM_BatchSignInBuffInfoReq(activityId_i32_Ary)
end

XiaoNuoAssistantController.instance = XiaoNuoAssistantController.New()

return XiaoNuoAssistantController
