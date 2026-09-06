-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/eternaldragon/view/EternalDragonWaterView.lua

module("logic.extensions.eternaldragon.view.EternalDragonWaterView", package.seeall)

local EternalDragonWaterView = class("EternalDragonWaterView", ViewComponent)

function EternalDragonWaterView:buildUI()
	EternalDragonWaterView.super.buildUI(self)

	self._btnClose = goutil.findChild(self.mainGO, "btnClose")
	self._btnGoto = goutil.findChild(self.mainGO, "btnGoto")
	self._txtTips = goutil.findChildTextComponent(self.mainGO, "txtTips")
end

function EternalDragonWaterView:bindEvents()
	EternalDragonWaterView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnGoto, self._onClickBtnGo, self)
end

function EternalDragonWaterView:unbindEvents()
	EternalDragonWaterView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnGoto)
end

function EternalDragonWaterView:onEnter()
	EternalDragonWaterView.super.onEnter(self)

	self._activityId = EternalDragonController.instance:getActivityId()
	self._activityType = EternalDragonController.instance:getActivityType()

	local isInTime = EternalDragonController.instance:isInActivityTime(self._activityId)

	if not isInTime then
		local text = string.format("活动不在开启期限内( activityId = %d )", self._activityId)

		local function func()
			self:close()
		end

		TipsFacade.instance:openTipWindow("提示", text, func, "确定", UnityEngine.TextAnchor.MiddleCenter)

		return
	end

	self._txtTips.text = EternalDragonConfig.instance:getEdCommonValue(self._activityId, "waterViewTips")
end

function EternalDragonWaterView:onExit()
	EternalDragonWaterView.super.onExit(self)
end

function EternalDragonWaterView:_onClickBtnGo()
	local key = EternalDragonConfig.instance:getEdCommonValue(self._activityId, "waterJumpStr")

	GotoMgr.gotoByString(key)

	if not ViewSetting.instance:isFullScreen(self._viewPresentor.viewName) then
		self:close()
	end
end

return EternalDragonWaterView
