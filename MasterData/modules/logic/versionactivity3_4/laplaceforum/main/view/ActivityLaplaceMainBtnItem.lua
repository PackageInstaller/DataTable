-- chunkname: @modules/logic/versionactivity3_4/laplaceforum/main/view/ActivityLaplaceMainBtnItem.lua

module("modules.logic.versionactivity3_4.laplaceforum.main.view.ActivityLaplaceMainBtnItem", package.seeall)

local ActivityLaplaceMainBtnItem = class("ActivityLaplaceMainBtnItem", ActCenterItemBase)

function ActivityLaplaceMainBtnItem:onAddEvent()
	RedDotController.instance:registerCallback(RedDotEvent.UpdateRelateDotInfo, self.refreshDot, self)
	MainUISwitchController.instance:registerCallback(MainUISwitchEvent.UseMainUI, self.refreshDot, self)
end

function ActivityLaplaceMainBtnItem:onRemoveEvent()
	RedDotController.instance:unregisterCallback(RedDotEvent.UpdateRelateDotInfo, self.refreshDot, self)
	MainUISwitchController.instance:unregisterCallback(MainUISwitchEvent.UseMainUI, self.refreshDot, self)
end

function ActivityLaplaceMainBtnItem:onClick()
	LaplaceForumController.instance:openLaplaceForumMainView()
end

function ActivityLaplaceMainBtnItem:refreshData()
	local actId = VersionActivity3_4Enum.ActivityId.LaplaceMain
	local data = {
		viewName = "LaplaceForumMainView",
		viewParam = {
			actId = actId
		}
	}

	self:setCustomData(data)
end

function ActivityLaplaceMainBtnItem:onOpen()
	self:refreshData()
	self._addNotEventRedDot(self, self._checkRed, self)
	self:_checkLuckyRainChanged()
	TaskDispatcher.runRepeat(self._checkLuckyRainChanged, self, 0.5)
end

function ActivityLaplaceMainBtnItem:_checkLuckyRainChanged()
	local isLuckyRainEnd = ChatRoomModel.instance:isActLuckyRainEnd()

	if isLuckyRainEnd then
		TaskDispatcher.cancelTask(self._checkLuckyRainChanged, self)

		return
	end

	local isInLuckyRain, rainId = ChatRoomModel.instance:isInLuckyRain()

	if self._isInLuckyRain == nil then
		self._isInLuckyRain = isInLuckyRain
	end

	if isInLuckyRain == self._isInLuckyRain then
		return
	end

	RedDotRpc.instance:sendGetRedDotInfosRequest({
		RedDotEnum.DotNode.V3a4LaplaceChatRoomLuckyRain
	})

	self._isInLuckyRain = isInLuckyRain
end

function ActivityLaplaceMainBtnItem:_checkRedotShowType(reddotId)
	local curMainUIId = MainUISwitchModel.instance:getCurUseUI()
	local switchReddotCo = MainUISwitchConfig.instance:getUIReddotStyle(curMainUIId, reddotId)

	if switchReddotCo then
		local type = switchReddotCo.style

		if type then
			self:setReddotShowType(type)
		end
	else
		self:setReddotShowType(RedDotEnum.Style.Normal)
	end
end

function ActivityLaplaceMainBtnItem:_checkRed()
	local reddotId = RedDotEnum.DotNode.V3a4LaplaceEnter

	self:_checkRedotShowType(reddotId)

	if RedDotModel.instance:isDotShow(reddotId, 0) then
		return true
	end

	local uncheckCount = MiniPartyModel.instance:getAllUncheckInviteCount()

	if uncheckCount > 0 then
		return true
	end

	local observerStr = PlayerPrefsHelper.getString(PlayerModel.instance:getPlayerPrefsKey(PlayerPrefsKey.LaplaceObserverBoxShowed), "")
	local actId = VersionActivity3_4Enum.ActivityId.LaplaceObserverBox
	local actInfoMo = ActivityModel.instance:getActivityInfo()[actId]
	local isExpire = actInfoMo:isExpired()
	local isUnlock = actInfoMo:isOnline() and actInfoMo:isOpen()

	if not isExpire and isUnlock and LuaUtil.isEmptyStr(observerStr) then
		return true
	end

	return false
end

function ActivityLaplaceMainBtnItem:onRefresh()
	self:refreshData()

	local isShow = ActivityModel.showActivityEffect()
	local spriteName = self:getActBtnPrefixIconName(isShow, "icon_8")

	self:setFestival(isShow)
	self:_setMainSprite(spriteName)
end

function ActivityLaplaceMainBtnItem:onGetViewNameAndParam()
	local data = self:getCustomData()
	local viewParam = data.viewParam
	local viewName = data.viewName

	return viewName, viewParam
end

function ActivityLaplaceMainBtnItem:onGetActId()
	local data = self:getCustomData()
	local viewParam = data.viewParam

	return viewParam.actId
end

function ActivityLaplaceMainBtnItem:refreshDot()
	self:_refreshRedDot()
end

function ActivityLaplaceMainBtnItem:onDestroyView()
	ActivityLaplaceMainBtnItem.super.onDestroyView(self)
	TaskDispatcher.cancelTask(self._checkLuckyRainChanged, self)
end

function ActivityLaplaceMainBtnItem:_gm_ActIds()
	return {
		VersionActivity3_4Enum.ActivityId.LaplaceMain
	}
end

return ActivityLaplaceMainBtnItem
