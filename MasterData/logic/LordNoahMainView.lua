-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/view/lordnoah/LordNoahMainView.lua

module("logic.extensions.timelimitedchallenge.view.lordnoah.LordNoahMainView", package.seeall)

local LordNoahMainView = class("LordNoahMainView", MississiMainView)

function LordNoahMainView:buildUI()
	LordNoahMainView.super.buildUI(self)

	self._btnRank = self:getGo("btnRank")
end

function LordNoahMainView:bindEvents()
	LordNoahMainView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnRank, self.onClickRank, self)
end

function LordNoahMainView:unbindEvents()
	LordNoahMainView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnRank)
end

function LordNoahMainView:onClickStart()
	UIStateManager.instance:push(ViewName.LordNoahChallengeView)
end

function LordNoahMainView:onClickRank()
	if not string.nilorempty(self._actCfg.rankGoTo) then
		GotoMgr.gotoByString(self._actCfg.rankGoTo)
	end
end

function LordNoahMainView:_getActivityId()
	return 135002
end

function LordNoahMainView:refreshViewByCfg()
	self._actCfg = MississiConfig.instance:getActCfg(self._actId)
	self._challengeId = self._actCfg.challengeId
	self._challengeCfg = TimeLimitedConfig.instance:getCfgById(self._challengeId)

	if not self._challengeCfg then
		printError("密密西限时挑战为空" .. self._challengeId)

		return
	end

	self._skinId = checkint(self._challengeCfg.raceId)
	self._role = RoleObjectPool.instance:addRoleToParent(self._role, self._skinId, self._con, 1)
	self._txtLeftTime.text = TimeGateController.instance:getActTimeShow(self._actId)

	self:refreshCollegePart()
	MaterialMgr.setCell(MatType.Rare, self._skinId, self._posRare)
end

return LordNoahMainView
