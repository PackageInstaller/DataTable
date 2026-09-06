-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dressactivityshop/controller/PayTrussGodGemController.lua

module("logic.extensions.dressactivityshop.controller.PayTrussGodGemController", package.seeall)

local PayTrussGodGemController = class("PayTrussGodGemController", BaseController)

PayTrussGodGemController.MAINHUDFIRSTCLICKREDPOINT = "PayTrussGodGemController_MainHudFirstClickRedPoint"
PayTrussGodGemController.FIRSTCLICKBTNBUYSHOWTIPS = "PayTrussGodGemController_FirstClickBtnBuyShowTips"
PayTrussGodGemController.curVersionInfos = {
	{
		activityId = 120001,
		redId = RedPointModel.ID_PAYTRUSSGODGEMMAINHUDFIRSTCLICK
	}
}

function PayTrussGodGemController:ctor()
	return
end

function PayTrussGodGemController:onInit()
	self:onReset()
end

function PayTrussGodGemController:onReset()
	GlobalDispatcher:addListener("opendressshopgodgemview", self.gotoOepnDressShopGodGemView, self)
	self:_checkRedPoints()
end

function PayTrussGodGemController:_checkRedPoints()
	local runDataList = DressActivityShopGodGemConfig.instance:getRunDataList()

	for _, data in ipairs(runDataList) do
		if ActivityDefineController.instance:isInActivityTimeById(GameEnum.ActivityType.DressActivityShopGodGem, data.activityId) then
			local key = PayTrussGodGemController.MAINHUDFIRSTCLICKREDPOINT .. data.activityId

			self:_showRedIfNotOpen(key, data.firstRedId)
		end
	end
end

function PayTrussGodGemController:gotoOepnDressShopGodGemView(params)
	local activityId = params and checknumber(params[1]) or 0

	self:oepnDressShopGodGemView(activityId)
end

function PayTrussGodGemController:oepnDressShopGodGemView(activityId)
	activityId = checknumber(activityId)

	local runData = DressActivityShopGodGemConfig.instance:getRunData(activityId)

	if runData == nil then
		printError(string.format("不存在对应配置,请检查配置表( z支付-服装售卖活动(神钻版).xlsx | export_启动配置 | activityId = %s )", activityId))

		return
	end

	if string.nilorempty(runData.viewName) then
		printError("配置中缺失viewName字段数据,请务必填写,否则无法打开对应界面( z支付-服装售卖活动(神钻版).xlsx | export_启动配置 | activityId = %s )", activityId)

		return
	end

	UIStateManager.instance:push(runData.viewName, activityId)
end

function PayTrussGodGemController:_showRedIfNotOpen(key, redId)
	if string.nilorempty(redId) then
		return
	end

	local function callBackFunc(value)
		local isClicked = checknumber(value) == 1

		if RedPointExConfig.instance:isOnceRed(redId) then
			if isClicked then
				RedPointController.instance:saveUserOnceRedPoint(redId, true)
			else
				RedPointController.instance:regUserOnceRedPoint(redId)
			end
		else
			RedPointController.instance:setRedPointInfo(redId, not isClicked)
		end
	end

	GameUtil.getUserData(key, callBackFunc)
end

function PayTrussGodGemController:_hideRedIfOpen(key, redId)
	if string.nilorempty(redId) then
		return
	end

	GameUtil.saveUserData(key, 1)
	self:_showRedIfNotOpen(key, redId)
end

function PayTrussGodGemController:_isHasClickedAnyGoods(key)
	local value = GameUtil.getUserData(key)
	local isHasClicked = checknumber(value) == 1

	if isHasClicked == false then
		GameUtil.saveUserData(key, 1)
	end

	return isHasClicked
end

function PayTrussGodGemController:_sendPayTrussGodGemInfoReq(activityId)
	PayTrussGodGemAgent.instance:sendPM_PayTrussGodGemInfoReq(activityId)
end

function PayTrussGodGemController:_handlePayTrussGodGemInfoRes(msg)
	PayTrussGodGemModel.instance:_handlePayTrussInfo(msg)
	GlobalDispatcher:dispatch(PayTrussGodGemAgent.PM_PayTrussGodGemInfoRes, msg)
end

function PayTrussGodGemController:_sendPM_PayTrussGodGemBuyReq(activityId, buyId)
	PayTrussGodGemAgent.instance:sendPM_PayTrussGodGemBuyReq(activityId, buyId)
end

function PayTrussGodGemController:_handlePayTrussGodGemBuyRes(msg)
	PayTrussGodGemModel.instance:_handlePayTrussPaySucInfo(msg)
	GlobalDispatcher:dispatch(PayTrussGodGemAgent.PM_PayTrussGodGemBuyRes, msg)
end

function PayTrussGodGemController:getDefaultGiftPackActivityId()
	return 120022
end

PayTrussGodGemController.instance = PayTrussGodGemController.New()

return PayTrussGodGemController
