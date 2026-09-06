-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/neverland/view/NeverLandView.lua

module("logic.extensions.neverland.view.NeverLandView", package.seeall)

local NeverLandView = class("NeverLandView", ViewComponent)

function NeverLandView:ctor()
	NeverLandView.super.ctor(self)
end

function NeverLandView:unbindEvents()
	NeverLandView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnRank)
	GameUtil.rmClickHandler(self._btnShop)
	GameUtil.rmClickHandler(self._btnTask)
	GameUtil.rmClickHandler(self._btnDefend)
	GameUtil.rmClickHandler(self._btnAttack)
	GameUtil.rmClickHandler(self._btnBuff)
end

function NeverLandView:bindEvents()
	NeverLandView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickTip, self)
	GameUtil.addClickHandler(self._btnRank, self._onClickRank, self)
	GameUtil.addClickHandler(self._btnShop, self._onClickShop, self)
	GameUtil.addClickHandler(self._btnTask, self._onClickTask, self)
	GameUtil.addClickHandler(self._btnDefend, self._onClickDefend, self)
	GameUtil.addClickHandler(self._btnAttack, self._onClickAttack, self)
	GameUtil.addClickHandler(self._btnBuff, self._onClickBuff, self)
end

function NeverLandView:buildUI()
	NeverLandView.super.buildUI(self)

	self._goldBar = self:getGo("goldBarCon")
	self._taskRd = self:getGo("btnTask/redpoint")
	self._buffRd = self:getGo("btnBuff/redpoint")
	self._txtTime = self:getTxt("time/txt")
	self._btnTip = self:getBtn("btnTip")
	self._btnTip = self:getBtn("btnTip")
	self._btnRank = self:getBtn("btnRank")
	self._btnShop = self:getBtn("btnShop")
	self._btnTask = self:getBtn("btnTask")
	self._btnBuff = self:getBtn("btnBuff")
	self._btnClose = self:getBtn("btnClose")
	self._btnDefend = self:getBtn("btnDefend")
	self._btnAttack = self:getBtn("btnAttack")
end

function NeverLandView:onExit()
	NeverLandView.super.onExit(self)
	RedPointController.instance:unregRedPoint(self._taskRd)
	RedPointController.instance:unregRedPoint(self._buffRd)
end

function NeverLandView:onEnter()
	NeverLandView.super.onEnter(self)

	self._activityId = ActivityDefineController.instance:getActivityIdByType(GameEnum.ActivityType.NeverLand)
	self._actCfg = NeverLandConfig.instance:getActCfg(self._activityId)

	local startTime, endTime = ActivityDefineController.instance:getStartTimeAndEndTime(GameEnum.ActivityType.NeverLand, self._activityId)

	self._txtTime.text = string.format("活动时间：%s", GameUtil.getFormatTimeByStamp(startTime, endTime))

	local name = self._actCfg.main_res
	local objList = {
		{
			showAdd = false,
			id = name
		}
	}

	MainUIController.instance:showGlodBar(self._goldBar, self._viewPresentor, objList)
	RedPointController.instance:regRedPoint(self._taskRd, RedPointModel.ID_NEVERLANDTASK)
	RedPointController.instance:regRedPoint(self._buffRd, RedPointModel.ID_C21)
end

function NeverLandView:_sendGetInfoReq()
	NeverLandController.instance:sendPM_NeverLandInfoReq(self._activityId)
end

function NeverLandView:_onClickTip()
	TipsFacade.instance:openRulesView("neverLand_rule")
end

function NeverLandView:_onClickRank()
	UIStateManager.instance:push(ViewName.NeverLandRankView)
end

function NeverLandView:_onClickShop()
	GotoMgr.gotoByString(self._challengeCfg.jump_shop)
end

function NeverLandView:_onClickTask()
	UIStateManager.instance:push(ViewName.NeverLandTaskView)
end

function NeverLandView:_onClickBuff()
	UIStateManager.instance:push(ViewName.NeverLandBuffView)
end

function NeverLandView:_onClickDefend()
	NeverLandController.instance:openNeverLandDefendForm(self._activityId)
end

function NeverLandView:_onClickAttack()
	NeverLandController.instance:openNeverLandAttackForm(self._activityId)
end

return NeverLandView
