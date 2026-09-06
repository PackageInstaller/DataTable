-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/scuffle/view/ScuffleRewardView.lua

module("logic.extensions.scuffle.view.ScuffleRewardView", package.seeall)

local ScuffleRewardView = class("ScuffleRewardView", ViewComponent)
local PageEnum = {
	Season = 2,
	Daily = 1,
	Rank = 3,
	Basics = 4
}

function ScuffleRewardView:ctor()
	ScuffleRewardView.super.ctor(self)

	self._seasonSubView = SeasonSubView.New()
	self._dailySubView = DailySubView.New()
	self._rankSubView = RankSubView.New()
end

function ScuffleRewardView:buildUI()
	ScuffleRewardView.super.buildUI(self)

	self._closeButton = self:getBtn("btnClose")

	self._seasonSubView:buildUI(self:getGo("season"))
	self._dailySubView:buildUI(self:getGo("daily"))
	self._rankSubView:buildUI(self:getGo("rank"))

	self._goBasics = self:getGo("basics")
	self._btnSeason = self:getBtn("btns/btnSeason")
	self._btnDaily = self:getBtn("btns/btnDaily")
	self._btnRank = self:getBtn("btns/btnRank")
	self._btnBasics = self:getBtn("btns/btnBasics")
	self._dailyRedPoint = self:getGo("btns/btnDaily/redPoint")
	self._seasonRedPoint = self:getGo("btns/btnSeason/redPoint")
	self._txtRule = self:getTxt("basics/txtRule")
end

function ScuffleRewardView:bindEvents()
	ScuffleRewardView.super.bindEvents(self)
	self._closeButton:AddClickListener(self._onClickClose, self)
	self._seasonSubView:bindEvents()
	self._dailySubView:bindEvents()
	self._rankSubView:bindEvents()
	self._btnSeason:AddClickListener(self._onClickSeason, self)
	self._btnDaily:AddClickListener(self._onClickDaily, self)
	self._btnRank:AddClickListener(self._onClickRank, self)
	self._btnBasics:AddClickListener(self._onClickBasics, self)

	self._changeSeason = self._btnSeason:GetComponent(typeof(UIChangeGroup))
	self._changeDaily = self._btnDaily:GetComponent(typeof(UIChangeGroup))
	self._changeRank = self._btnRank:GetComponent(typeof(UIChangeGroup))
	self._changeBasics = self._btnBasics:GetComponent(typeof(UIChangeGroup))
end

function ScuffleRewardView:unbindEvents()
	ScuffleRewardView.super.unbindEvents(self)
	self._closeButton:RemoveClickListener()
	self._seasonSubView:unbindEvents()
	self._dailySubView:unbindEvents()
	self._rankSubView:unbindEvents()
	self._btnSeason:RemoveClickListener()
	self._btnDaily:RemoveClickListener()
	self._btnRank:RemoveClickListener()
	self._btnBasics:RemoveClickListener()
end

function ScuffleRewardView:onEnter()
	ScuffleRewardView.super.onEnter(self)
	GlobalDispatcher:addListener(GlobalNotify.RedPointUpdate, self._updateRedPoint, self)
	self._seasonSubView:onEnter()
	self._dailySubView:onEnter()
	self._rankSubView:onEnter()
	self:_updateRedPoint()
	self:_setTxtRule()
	self:_changeTab(PageEnum.Daily)
end

function ScuffleRewardView:onExit()
	ScuffleRewardView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.RedPointUpdate, self._updateRedPoint, self)
	self._seasonSubView:onExit()
	self._dailySubView:onExit()
	self._rankSubView:onExit()
end

function ScuffleRewardView:_onClickClose()
	self:close()
end

function ScuffleRewardView:_onClickDaily()
	self:_changeTab(PageEnum.Daily)
end

function ScuffleRewardView:_onClickSeason()
	self:_changeTab(PageEnum.Season)
end

function ScuffleRewardView:_onClickRank()
	self:_changeTab(PageEnum.Rank)
end

function ScuffleRewardView:_onClickBasics()
	self:_changeTab(PageEnum.Basics)
end

function ScuffleRewardView:_changeTab(enum)
	self._changeDaily:SetState(enum == PageEnum.Daily and 1 or 0)
	self._changeSeason:SetState(enum == PageEnum.Season and 1 or 0)
	self._changeRank:SetState(enum == PageEnum.Rank and 1 or 0)
	self._changeBasics:SetState(enum == PageEnum.Basics and 1 or 0)

	if enum == PageEnum.Daily then
		self._dailySubView:show()
		self._seasonSubView:hide()
		self._rankSubView:hide()
		self:_hideBasics()
	elseif enum == PageEnum.Season then
		self._dailySubView:hide()
		self._seasonSubView:show()
		self._rankSubView:hide()
		self:_hideBasics()
	elseif enum == PageEnum.Rank then
		self._dailySubView:hide()
		self._seasonSubView:hide()
		self._rankSubView:show()
		self:_hideBasics()
	else
		self._dailySubView:hide()
		self._seasonSubView:hide()
		self._rankSubView:hide()
		self:_showBasics()
	end
end

function ScuffleRewardView:_showBasics()
	self._goBasics:SetActive(true)
end

function ScuffleRewardView:_hideBasics()
	self._goBasics:SetActive(false)
end

function ScuffleRewardView:_updateRedPoint()
	self._dailyRedPoint:SetActive(ScuffleModel.instance:isHaveTaskRed())
	self._seasonRedPoint:SetActive(ScuffleModel.instance:isHaveRewardRed())
end

function ScuffleRewardView:_setTxtRule()
	self._txtRule.text = ScuffleConfig.instance:getCommonValueByKey("PRIZE_RULE")
end

return ScuffleRewardView
