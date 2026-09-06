-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinefeiyin/view/DivinefeiyinchallengemainView.lua

module("logic.extensions.divinefeiyin.view.DivinefeiyinchallengemainView", package.seeall)

local DivinefeiyinchallengemainView = class("DivinefeiyinchallengemainView", SunWuKongChallengeMainView)

function DivinefeiyinchallengemainView:unbindEvents()
	DivinefeiyinchallengemainView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnReceive)
end

function DivinefeiyinchallengemainView:bindEvents()
	DivinefeiyinchallengemainView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnReceive, GameUtil.handler(self._onClickReceive, self))
end

function DivinefeiyinchallengemainView:buildUI()
	DivinefeiyinchallengemainView.super.buildUI(self)

	self._pointItem = self:getGo("reward/pointItem")
	self._effect = self:getGo("reward/effect")
	self._receive = self:getGo("reward/receive")
	self._btnReceive = self:getBtn("reward/btnReceive")
end

function DivinefeiyinchallengemainView:onExit()
	DivinefeiyinchallengemainView.super.onExit(self)

	self._roleObj = RoleObjectPool.instance:removeRole(self._roleObj)

	MaterialMgr.resetAll(self._pointItem)
end

function DivinefeiyinchallengemainView:onEnter()
	DivinefeiyinchallengemainView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.PM_SunWuKongChallengeGetInfoRes, self._refreshUI, self)
	SunWuKongChallengeAgent.instance:sendPM_SunWuKongChallengeGetInfoReq(self._activityId)
	self:_refreshUI()
	self:_updateRole()
end

function DivinefeiyinchallengemainView:_onClickReceive()
	SunWuKongChallengeAgent.instance:sendPM_SunWuKongChallengeGainDailyPrizeReq(self._activityId)
end

function DivinefeiyinchallengemainView:_refreshUI()
	MaterialMgr.setCellByCfg(self._actCfg.dailyPrize, self._pointItem)

	local data = SunWuKongChallengeModel.instance:getMsgData(self._activityId) or {}
	local hadGainedDailyPrize = checkbool(data.hadGainedDailyPrize)

	GameUtil.SetActive(self._btnReceive, not hadGainedDailyPrize)
	GameUtil.SetActive(self._receive, hadGainedDailyPrize)
end

function DivinefeiyinchallengemainView:_updateRole()
	local curFaceId = self._actCfg.raceId
	local offset = CharactorFacade.instance:getBattleResultModelUIPosAndScale(curFaceId)
	local x, y, scale = 0, 0, 1

	if offset then
		x = checknumber(offset[1])
		y = checknumber(offset[2])
		scale = offset[3] or 1
	end

	self._roleObj = RoleObjectPool.instance:addRoleToParent(self._roleObj, curFaceId, self._petCon, scale, nil, true, x, y)
end

function DivinefeiyinchallengemainView:_onClickChallenge()
	UIStateManager.instance:push(ViewName.DivinefeiyinchallengegameView, self._activityId)
end

return DivinefeiyinchallengemainView
