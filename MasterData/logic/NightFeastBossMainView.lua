-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/nightfeastbosschallenge/view/NightFeastBossMainView.lua

module("logic.extensions.nightfeastbosschallenge.view.NightFeastBossMainView", package.seeall)

local NightFeastBossMainView = class("NightFeastBossMainView", ViewComponent)

function NightFeastBossMainView:ctor()
	NightFeastBossMainView.super.ctor(self)
end

function NightFeastBossMainView:buildUI()
	NightFeastBossMainView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._btnTip = self:getBtn("btnTip")
	self._btnRank = self:getBtn("btnRank")
	self._btnStory = self:getBtn("btnStory")
	self._btnStart = self:getBtn("btnStart")
	self._btnBuff = self:getBtn("btnBuff")
	self._txtTime = self:getTxt("time/txt")
	self._con = self:getGo("con")
end

function NightFeastBossMainView:bindEvents()
	NightFeastBossMainView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickTip, self)
	GameUtil.addClickHandler(self._btnRank, self._onClickRank, self)
	GameUtil.addClickHandler(self._btnStory, self._onClickStory, self)
	GameUtil.addClickHandler(self._btnStart, self._onClickStart, self)
	GameUtil.addClickHandler(self._btnBuff, self._onClickBuff, self)
end

function NightFeastBossMainView:unbindEvents()
	NightFeastBossMainView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnRank)
	GameUtil.rmClickHandler(self._btnStory)
	GameUtil.rmClickHandler(self._btnStart)
	GameUtil.rmClickHandler(self._btnBuff)
end

function NightFeastBossMainView:onEnter()
	NightFeastBossMainView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.NightFeastBossClgGetInfoRes, self._onGetInfoRes, self)

	self._activityId = NightFeastBossModel.instance:getActivityId()

	local isInTime = ActivityDefineController.instance:checkIsInActivityTimeByActivityId(self._activityId)

	if not isInTime then
		TipsFacade.instance:openTipWindowNoX(lang("tip"), lang("outtime"), function()
			self:close()
		end)

		return
	end

	self._cfgActivity = NightFeastBossConfig.instance:getActivityCfg(self._activityId)
	self._storyId = self._cfgActivity.storyId

	self:_initActivityTime()
	self:_showRoleModel(self._con, self._cfgActivity.raceId)
	NightFeastBossController.instance:playStoryOnce(self._storyId)
	NightFeastBossChallengeAgent.instance:sendPM_NightFeastBossClgGetInfoReq(self._activityId)
end

function NightFeastBossMainView:onExit()
	NightFeastBossMainView.super.onExit(self)
	self:_resetRoleModel()
end

function NightFeastBossMainView:_onClickTip()
	TipsFacade.instance:openRulesView("nightfeastbossmainview_rule")
end

function NightFeastBossMainView:_onClickRank()
	UIStateManager.instance:push(ViewName.NightFeastBossRankView, self._activityId)
end

function NightFeastBossMainView:_onClickStory()
	NightFeastBossController.instance:playStory(self._storyId)
end

function NightFeastBossMainView:_onClickStart()
	UIStateManager.instance:push(ViewName.NightFeastBossClgView, self._activityId)
end

function NightFeastBossMainView:_onClickBuff()
	UIStateManager.instance:push(ViewName.NightFeastBossBuffView, self._activityId)
end

function NightFeastBossMainView:_onGetInfoRes()
	return
end

function NightFeastBossMainView:_initActivityTime()
	self._txtTime.text = TimeGateController.instance:getActTimeShow(self._activityId)
end

function NightFeastBossMainView:_showRoleModel(go, raceId)
	local curFaceId = raceId
	local offset = CharactorFacade.instance:getBattleResultModelUIPosAndScale(curFaceId)
	local x, y, scale = 0, 0, 1

	if offset then
		x = checknumber(offset[1])
		y = checknumber(offset[2])
		scale = offset[3] or 1
	end

	self:_resetRoleModel()

	self.loader = RoleObjectPool.instance:addRoleToParent(self.loader, curFaceId, go, scale, nil, true, x, y)
end

function NightFeastBossMainView:_resetRoleModel()
	self.loader = RoleObjectPool.instance:removeRole(self.loader)
end

return NightFeastBossMainView
