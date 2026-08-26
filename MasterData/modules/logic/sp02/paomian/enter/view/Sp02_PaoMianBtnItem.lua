-- chunkname: @modules/logic/sp02/paomian/enter/view/Sp02_PaoMianBtnItem.lua

module("modules.logic.sp02.paomian.enter.view.Sp02_PaoMianBtnItem", package.seeall)

local Sp02_PaoMianBtnItem = class("Sp02_PaoMianBtnItem", ActCenterItemBase)

function Sp02_PaoMianBtnItem:onOpen()
	self._addNotEventRedDot(self, self._checkRed, self)
end

function Sp02_PaoMianBtnItem:onInit()
	self._actId = ActivityEnum.Activity.SP02_PaoMianActivityMain
	self._activityCo = ActivityConfig.instance:getActivityCo(self._actId)
	self._redDotId = self._activityCo and self._activityCo.redDotId
	self._actIdMap = {
		[ActivityEnum.Activity.SP02_PaoMianActivityMain] = true,
		[ActivityEnum.Activity.SP02_PaoMianActivityGuessMe] = true,
		[ActivityEnum.Activity.SP02_PaoMianActivityMarcus] = true,
		[ActivityEnum.Activity.SP02_PaoMianActivityShop] = true
	}

	self:refresh()
end

function Sp02_PaoMianBtnItem:onRefresh()
	local isShow = ActivityModel.showActivityEffect()
	local spriteName = self:getActBtnPrefixIconName(isShow, "icon_11")

	self:setFestival(isShow)
	self:_setMainSprite(spriteName)
	self:_tickUpdateRedDotInfo()
end

function Sp02_PaoMianBtnItem:onAddEvent()
	RedDotController.instance:registerCallback(RedDotEvent.UpdateFriendInfoDot, self.refreshDot, self)
	RedDotController.instance:registerCallback(RedDotEvent.UpdateActTag, self.refreshDot, self)
	RedDotController.instance:registerCallback(RedDotEvent.UpdateRelateDotInfo, self.refreshDot, self)
	ActivityController.instance:registerCallback(ActivityEvent.ChangeActivityStage, self.refreshDot, self)
	ActivityController.instance:registerCallback(ActivityEvent.RefreshNorSignActivity, self.refreshDot, self)
	RedDotController.instance:registerCallback(RedDotEvent.RefreshClientCharacterDot, self.refreshDot, self)
	ActivityController.instance:registerCallback(ActivityEvent.RefreshActivityState, self.refreshActivityState, self, LuaEventSystem.Low)
end

function Sp02_PaoMianBtnItem:onRemoveEvent()
	RedDotController.instance:unregisterCallback(RedDotEvent.UpdateFriendInfoDot, self.refreshDot, self)
	RedDotController.instance:unregisterCallback(RedDotEvent.UpdateActTag, self.refreshDot, self)
	RedDotController.instance:unregisterCallback(RedDotEvent.UpdateRelateDotInfo, self.refreshDot, self)
	ActivityController.instance:unregisterCallback(ActivityEvent.ChangeActivityStage, self.refreshDot, self)
	ActivityController.instance:unregisterCallback(ActivityEvent.RefreshNorSignActivity, self.refreshDot, self)
	RedDotController.instance:unregisterCallback(RedDotEvent.RefreshClientCharacterDot, self.refreshDot, self)
	ActivityController.instance:unregisterCallback(ActivityEvent.RefreshActivityState, self.refreshActivityState, self)
end

function Sp02_PaoMianBtnItem:onClick()
	ViewMgr.instance:openView(ViewName.Sp02_PaoMian_MainView, {
		actId = self._actId
	})
end

function Sp02_PaoMianBtnItem:_checkRed()
	if not ActivityHelper.isOpen(self._actId) then
		return false
	end

	self:_checkRedotShowType(self._redDotId)

	return RedDotModel.instance:isDotShow(self._redDotId, 0) or Sp02_PaoMianController.instance:isShowWebReddot()
end

function Sp02_PaoMianBtnItem:refreshActivityState(actId)
	if actId == ActivityEnum.Activity.SP02_PaoMianActivityWeb then
		self:refreshDot()
	end

	if not actId or not self._actIdMap[actId] then
		return
	end

	if ActivityHelper.isOpen(ActivityEnum.Activity.SP02_PaoMianActivityGuessMe) then
		Activity238Rpc.instance:sendGetAct238InfoRequest(ActivityEnum.Activity.SP02_PaoMianActivityGuessMe)
	end

	if ActivityHelper.isOpen(ActivityEnum.Activity.SP02_PaoMianActivityMarcus) then
		Activity239Rpc.instance:sendGetAct239InfoRequest(ActivityEnum.Activity.SP02_PaoMianActivityMarcus)
	end
end

function Sp02_PaoMianBtnItem:refreshDot()
	self:_refreshRedDot()
end

function Sp02_PaoMianBtnItem:_tickUpdateRedDotInfo()
	TaskDispatcher.cancelTask(self._sendRpc2GetMarcusRedDot, self)

	local nextOpenTime = Sp02_MarcusModel.instance:getNextOpenBonusTime(ActivityEnum.Activity.SP02_PaoMianActivityMarcus)

	if not nextOpenTime or nextOpenTime <= 0 then
		return
	end

	TaskDispatcher.runDelay(self._sendRpc2GetMarcusRedDot, self, nextOpenTime)
end

function Sp02_PaoMianBtnItem:_sendRpc2GetMarcusRedDot()
	RedDotRpc.instance:sendGetRedDotInfosRequest({
		self._redDotId
	})
end

function Sp02_PaoMianBtnItem:_gm_ActIds()
	return {
		self._actId
	}
end

function Sp02_PaoMianBtnItem:onDestroy()
	TaskDispatcher.cancelTask(self._sendRpc2GetMarcusRedDot, self)
end

return Sp02_PaoMianBtnItem
