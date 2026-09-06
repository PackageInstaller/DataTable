-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/operationsummary/view/NuoyaSummaryView.lua

module("logic.extensions.operationsummary.view.NuoyaSummaryView", package.seeall)

local NuoyaSummaryView = class("NuoyaSummaryView", ViewComponent)
local NUOYA_ACTID = 17003

function NuoyaSummaryView:ctor()
	NuoyaSummaryView.super.ctor(self)
end

function NuoyaSummaryView:buildUI()
	NuoyaSummaryView.super.buildUI(self)

	self._container = self:getGo("container")
	self._btnTip = self:getBtn("leftTop/btn_tip")
	self._btnClose = self:getBtn("leftTop/btnClose")
	self._txtOpenTime = goutil.findChildTextComponent(self.mainGO, "openTime/txt")
end

function NuoyaSummaryView:bindEvents()
	NuoyaSummaryView.super.bindEvents(self)
	self._btnClose:AddClickListener(self.close, self)
	self._btnTip:AddClickListener(self._onClickTipRule, self)
end

function NuoyaSummaryView:unbindEvents()
	NuoyaSummaryView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
	self._btnTip:RemoveClickListener()
end

function NuoyaSummaryView:destroyUI()
	NuoyaSummaryView.super.destroyUI(self)
end

function NuoyaSummaryView:onEnter()
	NuoyaSummaryView.super.onEnter(self)

	local activityId = 17003

	self:showTabAt(self._container, ViewName.OperationSummaryView, NUOYA_ACTID)

	local cfg = ActivityDefineConfig.instance:getCfgById(GameEnum.ActivityType.Summary, activityId)
	local startTime = GameUtil.parseToTimeTable(cfg.startTime)
	local endTime = GameUtil.parseToTimeTable(cfg.endTime)

	self._txtOpenTime.text = langPara("活动时间：%s.%s.%s-%s.%s.%s", startTime.year, startTime.month, startTime.day, endTime.year, endTime.month, endTime.day)
end

function NuoyaSummaryView:onEnterFinished()
	NuoyaSummaryView.super.onEnterFinished(self)
end

function NuoyaSummaryView:onExit()
	NuoyaSummaryView.super.onExit(self)
end

function NuoyaSummaryView:onExitFinished()
	NuoyaSummaryView.super.onExitFinished(self)
end

function NuoyaSummaryView:_onClickTipRule()
	local ruleCo = RulesConfig.instance:getRuleCo("OpSummaryRule")
	local title = tostring((not ruleCo.title or nil) and 0)

	if not title or title == "0" or #title == 0 then
		title = lang("tip")
	end

	TipsFacade.instance:openTipWindowNoX(title, ruleCo.rules)
end

return NuoyaSummaryView
