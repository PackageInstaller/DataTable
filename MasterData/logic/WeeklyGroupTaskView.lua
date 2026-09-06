-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/weeklygroup/view/WeeklyGroupTaskView.lua

module("logic.extensions.weeklygroup.view.WeeklyGroupTaskView", package.seeall)

local WeeklyGroupTaskView = class("WeeklyGroupTaskView", EventTaskTabFrameView)

function WeeklyGroupTaskView:ctor()
	WeeklyGroupTaskView.super.ctor(self)
end

function WeeklyGroupTaskView:unbindEvents()
	WeeklyGroupTaskView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTeam)
	GameUtil.rmClickHandler(self._btnRank)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnShop)
end

function WeeklyGroupTaskView:bindEvents()
	WeeklyGroupTaskView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnShop, self._onClickBtnShop, self)
	GameUtil.addClickHandler(self._btnTeam, self._onClickTeam, self)
	GameUtil.addClickHandler(self._btnRank, self._onCickRank, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickTips, self)
end

function WeeklyGroupTaskView:buildUI()
	WeeklyGroupTaskView.super.buildUI(self)

	self._petCon = self:getGo("con")
	self._redPoint = self:getGo("btnTeam/redPoint")
	self._teamItem = self:getGo("teamBubble/reward")
	self._rankItem = self:getGo("rankBubble/reward")
	self._txtTime = self:getTxt("time/txt")
	self._txtTeamDesc = self:getTxt("teamScore/txt")
	self._txtTip = self:getTxt("txtTip")
	self._btnClose = self:getBtn("topLeft/btnClose")
	self._btnTeam = self:getBtn("btnTeam")
	self._btnRank = self:getBtn("btnRank")
	self._btnTip = self:getBtn("topLeft/btnTip")
	self._btnShop = self:getGo("btnShop")
	self._txtBackPlayer = self:getTxt("txtBackPlayer")
	self._txtNewPlayer = self:getTxt("txtNewPlayer")
end

function WeeklyGroupTaskView:onExit()
	WeeklyGroupTaskView.super.onExit(self)
	MaterialMgr.resetAll(self._teamItem)
	MaterialMgr.resetAll(self._rankItem)
	RoleObjectPool.instance:removeRole(self._loader)
	RedPointController.instance:unregRedPoint(self._redPoint)
end

function WeeklyGroupTaskView:onEnter()
	WeeklyGroupTaskView.super.onEnter(self)

	self._activityId = ActivityDefineController.instance:getActivityIdByType(GameEnum.ActivityType.WeeklyGroup)
	self._actCfg = WeeklyGroupConfig.instance:getWeeklyGroupCfgById(self._activityId)

	self.addGEvent(self, GlobalNotify.WeeklyGroupGetInfoRes, self._refresh, self)
	self.addGEvent(self, GlobalNotify.PM_EventTaskTabUpdate, self._sendInfoReq, self)
	self:_sendInfoReq()
	self:_initUI()
	RedPointController.instance:regRedPoint(self._redPoint, RedPointModel.ID_C20)

	if not GameUtil.getUserData(ViewName.WeeklyGroupTaskView) then
		self:_onClickTips()
	end
end

function WeeklyGroupTaskView:setActId()
	self._activityId = ActivityDefineController.instance:getActivityIdByType(GameEnum.ActivityType.WeeklyGroup)
end

function WeeklyGroupTaskView:_initUI()
	local startTime, endTime = ActivityDefineController.instance:getStartTimeAndEndTime(GameEnum.ActivityType.WeeklyGroup, self._activityId)

	self._txtTime.text = string.format("活动时间：%s", GameUtil.getFormatTimeByStamp(startTime, endTime))

	MaterialMgr.setCellByCfg(self._actCfg.teamItem, self._teamItem)
	MaterialMgr.setCellByCfg(self._actCfg.rankItem, self._rankItem)

	local x, y, scale = self._actCfg.petPos[1], self._actCfg.petPos[2], self._actCfg.petPos[3]

	self._loader = RoleObjectPool.instance:addRoleToParent(self._loader, self._actCfg.raceId, self._petCon, scale, nil, true, x, y)

	local matName = MaterialMgr.getMaterialsNameByCfg(self._actCfg.itemKey)

	self._txtTip.text = string.format("本期组队成功后不可退出队伍，组队前获得的%s也会计入队伍总分", matName)
	self._txtNewPlayer.text = string.format("新玩家积分加成(仅组队)：<color=#71f7ff>%d%%</color>", self._actCfg.newHandBonus)
	self._txtBackPlayer.text = string.format("回归玩家积分加成(仅组队)：<color=#71f7ff>%d%%</color>", self._actCfg.regressBonus)
end

function WeeklyGroupTaskView:_sendInfoReq()
	WeeklyGroupController.instance:sendPM_WeeklyGroupGetInfoReq(self._activityId)
end

function WeeklyGroupTaskView:_refresh()
	local teamScore = WeeklyGroupModel.instance:getTeamScore()
	local personScore = WeeklyGroupModel.instance:getPersonScore()

	self._txtTeamDesc.text = string.format("队伍总分：<color=#ffdaa2>%d</color>\n个人积分：<color=#ffdaa2>%d</color>", teamScore, personScore)
end

function WeeklyGroupTaskView:_onClickTeam()
	UIStateManager.instance:push(ViewName.WeeklyGroupMainView)
end

function WeeklyGroupTaskView:_onCickRank()
	UIStateManager.instance:push(ViewName.WeeklyGroupRankView)
end

function WeeklyGroupTaskView:_onClickTips()
	GameUtil.saveUserData(ViewName.WeeklyGroupTaskView, true)
	TipsFacade.instance:openRulesView("weeklygrouptaskrule")
end

function WeeklyGroupTaskView:_onClickBtnShop()
	local btnStr = "func#191#17#17169"

	GotoMgr.gotoByString(btnStr)
end

return WeeklyGroupTaskView
