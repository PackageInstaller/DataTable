-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dressactivityshop/controller/PayTrussController.lua

module("logic.extensions.dressactivityshop.controller.PayTrussController", package.seeall)

local PayTrussController = class("PayTrussController", BaseController)

PayTrussController.MAINHUDFIRSTCLICKREDPOINT = "MainHudFirstClickRedPoint"
PayTrussController.FIRSTCLICKBTNBUYSHOWTIPS = "FirstClickBtnBuyShowTips"
PayTrussController.curVersionInfos = {
	{
		activityId = 27009,
		redId = RedPointModel.ID_PAYTRUSSMAINHUDFIRSTCLICK
	},
	{
		activityId = 27010,
		redId = RedPointModel.ID_PAYTRUSSMAINHUDFIRSTCLICKTWO
	}
}

function PayTrussController:ctor()
	return
end

function PayTrussController:onInit()
	self:onReset()
end

function PayTrussController:onReset()
	self:_checkRedPoints()
end

function PayTrussController:_checkRedPoints()
	for _, info in ipairs(PayTrussController.curVersionInfos) do
		local key = PayTrussController.MAINHUDFIRSTCLICKREDPOINT .. info.activityId

		self:_showRedIfNotOpen(key, info.redId)
	end
end

function PayTrussController:_showRedIfNotOpen(key, redId)
	if string.nilorempty(redId) then
		return
	end

	local function callBackFunc(value)
		local isClicked = checknumber(value) == 1

		RedPointController.instance:setRedPointInfo(redId, not isClicked)
	end

	GameUtil.getUserData(key, callBackFunc)
end

function PayTrussController:_hideRedIfOpen(key, redId)
	if string.nilorempty(redId) then
		return
	end

	GameUtil.saveUserData(key, 1)
	RedPointController.instance:setRedPointInfo(redId, false)
end

function PayTrussController:_isHasClickedAnyGoods(key)
	local value = GameUtil.getUserData(key)
	local isHasClicked = checknumber(value) == 1

	if isHasClicked == false then
		GameUtil.saveUserData(key, 1)
	end

	return isHasClicked
end

function PayTrussController:_sendReqGetPayTrussInfo(activityId)
	PayTrussAgent.instance:sendPM_PayTrussGetInfoReq(activityId)
end

function PayTrussController:_handleResGetPayTrussInfo(msg)
	PayTrussModel.instance:_handlePayTrussInfo(msg)
	GlobalDispatcher:dispatch(PayTrussAgent.PM_PayTrussGetInfoRes, msg)
end

function PayTrussController:_handleResPayTrussNotifyPaySuc(msg)
	PayTrussModel.instance:_handlePayTrussPaySucInfo(msg)
	GlobalDispatcher:dispatch(PayTrussAgent.PM_PayTrussNotifyPaySucRes, msg)
end

PayTrussController.instance = PayTrussController.New()

return PayTrussController
