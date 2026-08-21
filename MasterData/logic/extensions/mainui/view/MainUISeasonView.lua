-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mainui/view/MainUISeasonView.lua

module("logic.extensions.mainui.view.MainUISeasonView", package.seeall)

local M = class("MainUISeasonView", ViewComponent)

function M:ctor()
	M.super.ctor(self)
end

function M:buildUI()
	self._btnSeason = self:getBtn("main_view_-392342540")
	self._goRedPoint = goutil.findChild(self._btnSeason.gameObject, "red_point").gameObject
	self._txtLv = self:getUIComponent("main_view_-1956581933", UIComponentType.Text)
	self._txtExp = self:getUIComponent("main_view_-648469772", UIComponentType.Text)
	self._txtExpAdd = self:getUIComponent("main_view_-1449799066", UIComponentType.Text)
	self._sliderExpAdd = self:getUIComponent("main_view_1825237206", UIComponentType.Slider)
	self._imgExpCur = self:getImage("main_view_-1455000249")
	self.text_txtName = self:getText("main_view_622625566")
end

function M:destroyUI()
	return
end

function M:bindEvents()
	self._btnSeason:AddClickListener(self._onClickSeason, self)
end

function M:unbindEvents()
	self._btnSeason:RemoveClickListener()
end

function M:onEnter(reasonType)
	self:_setEvent(true)

	self._btnSeason.btn.interactable = true

	self:_updateSeasonActivityShow()
end

function M:onExit(reasonType)
	self:_setEvent(false)

	local isNormalClose = reasonType ~= WindowType.WindowCloseReasonType.QuickCloseType

	self._btnSeason.btn.interactable = false
end

function M:_setEvent(add)
	if add then
		GlobalDispatcher:addEventListener(EventType.ON_SYSTEM_OPEN, self._handleOnSystemOpen, self)
		GlobalDispatcher:addEventListener(EventType.ACTIVITY_ALL_REFRESH, self._handleOnSystemOpen, self)
		GlobalDispatcher:addEventListener(EventType.SEASON_INFO_UPDATE, self._onSeasonInfoUpdate, self)
		GlobalDispatcher:addEventListener(EventType.ACTIVITY_REFRESH + ActivityEnum.LogicType.SEASON, self._updateSeasonActivityShow, self)
		GlobalDispatcher:addEventListener(EventType.RED_DOT_UPDATE_EVENT, self._refreshRedDot, self)
	else
		GlobalDispatcher:removeEventListener(EventType.ON_SYSTEM_OPEN, self._handleOnSystemOpen, self)
		GlobalDispatcher:removeEventListener(EventType.ACTIVITY_ALL_REFRESH, self._handleOnSystemOpen, self)
		GlobalDispatcher:removeEventListener(EventType.SEASON_INFO_UPDATE, self._onSeasonInfoUpdate, self)
		GlobalDispatcher:removeEventListener(EventType.ACTIVITY_REFRESH + ActivityEnum.LogicType.SEASON, self._updateSeasonActivityShow, self)
		GlobalDispatcher:removeEventListener(EventType.RED_DOT_UPDATE_EVENT, self._refreshRedDot, self)
	end
end

function M:_handleOnSystemOpen()
	self:_updateSeasonActivityShow()
end

function M:_onSeasonInfoUpdate()
	self:_updateSeasonActivityShow()
end

function M:_onClickSeason()
	SeasonFacade.instance:enterSeasonMainView(true)
end

function M:_refreshRedDot()
	local active = RedDotModel.instance:getDotIsActive(GameEnum.RedPointEnum.Season)
	local hasRedPoint = active

	goutil.setActive(self._goRedPoint, hasRedPoint)
end

function M:_updateSeasonActivityShow()
	local hasSeasonInfo = SeasonFacade.instance:isActivityOpen() and SeasonFacade.instance:isSeasonOpen()

	if hasSeasonInfo then
		local seasonId = SeasonModel.instance:getSeasonId()
		local lv = SeasonModel.instance:getCurrLv()
		local maxLv = SeasonConfig.instance:getMaxLv()
		local currScore = SeasonModel.instance:getCurrScore()
		local upgradeScore = SeasonConfig.instance:getScorePerLv()
		local progress = lv < maxLv and currScore / upgradeScore or 1
		local progressStr = lv < maxLv and string.format("%s/%s", currScore, upgradeScore) or "MAX"
		local seasonName = SeasonConfig.instance:getSeasonName(seasonId)

		self._txtLv.text = lv
		self._txtExp.text = progressStr
		self._imgExpCur.fillAmount = progress
		self.text_txtName.text = seasonName

		local progressAdd = progress
		local progressAddStr

		self._txtExpAdd.text = progressAddStr
		self._sliderExpAdd.value = progressAdd

		self:_refreshSeasonTime()
		self:_refreshRedDot()
	end

	goutil.setActive(self._btnSeason.gameObject, hasSeasonInfo)
end

function M:_refreshSeasonTime()
	return
end

return M
