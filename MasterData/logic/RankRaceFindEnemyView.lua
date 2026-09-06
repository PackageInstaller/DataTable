-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/rankrace/view/RankRaceFindEnemyView.lua

module("logic.extensions.rankrace.view.RankRaceFindEnemyView", package.seeall)

local RankRaceFindEnemyView = class("RankRaceFindEnemyView", ViewComponent)

function RankRaceFindEnemyView:ctor()
	RankRaceFindEnemyView.super.ctor(self)

	local config = RankRaceConfig.instance:getFindEnemyConfig()

	self.name_poll = {}

	for i = 1, #config do
		self.name_poll[i] = config[i][2]
	end
end

function RankRaceFindEnemyView:buildUI()
	RankRaceFindEnemyView.super.buildUI(self)

	self._text_end = self:getGo("text_end"):GetComponent("Text")

	self._text_end.gameObject:SetActive(false)

	self._text_count_down_time = self:getGo("text_count_down_time"):GetComponent("Text")
	self._btnCancelMatch = self:getBtn("btnCancelMatch")
	self._txtCancelMatch = self:getGo("btnCancelMatch/txtCancelMatch"):GetComponent("Text")
	self._btnClose = self:getBtn("btnClose")
end

function RankRaceFindEnemyView:bindEvents()
	RankRaceFindEnemyView.super.bindEvents(self)
	self._btnCancelMatch:AddClickListener(function()
		if self._enemyFinded then
			-- block empty
		else
			removetimer(self._onNoEnemy, self)
			RankingMatchAgent.instance:sendRM_CancelMatchingReq()
		end
	end, self)
	self._btnClose:AddClickListener(self._onClickBtnClose, self)
end

function RankRaceFindEnemyView:unbindEvents()
	RankRaceFindEnemyView.super.unbindEvents(self)
	self._btnCancelMatch:RemoveClickListener()
	self._btnClose:RemoveClickListener()
end

function RankRaceFindEnemyView:_startMatchEnemy()
	self._text_end.gameObject:SetActive(false)
	self:_initNeedTimeCount()
	self:_showEffect()
end

function RankRaceFindEnemyView:endMatchEnemy()
	removetimer(self._onNoEnemy, self)
	self._text_end.gameObject:SetActive(true)

	self._text_end.text = RankRaceConfig.instance:getWord(8)

	removetimer(self._updateTime, self)
	self._text_count_down_time.gameObject:SetActive(false)

	self._txtCancelMatch.text = RankRaceConfig.instance:getWord(9)
	self._enemyFinded = true

	if self._effectControl then
		self._effectControl:StopTurn()
	end

	settimer(1, self._openMatchSuccView, self, false)
end

function RankRaceFindEnemyView:destroyUI()
	RankRaceFindEnemyView.super.destroyUI(self)
end

function RankRaceFindEnemyView:onEnter()
	RankRaceFindEnemyView.super.onEnter(self)

	self._viewFlag = true
	self._txtCancelMatch.text = RankRaceConfig.instance:getWord(10)
	self._enemyFinded = false

	self:_startMatchEnemy()
	settimer(40, self._onNoEnemy, self, false)
	self.registerNotify(self, GlobalNotify.RankRaceResult, self._onRankRaceResult, self)
end

function RankRaceFindEnemyView:onEnterFinished()
	RankRaceFindEnemyView.super.onEnterFinished(self)
end

function RankRaceFindEnemyView:onExit()
	RankRaceFindEnemyView.super.onExit(self)
	self:_clearEffect()
	removetimer(self._updateTime, self)
	removetimer(self._onNoEnemy, self)
	removetimer(self._openMatchSuccView, self)
	self.unregisterNotify(self, GlobalNotify.RankRaceResult, self._onRankRaceResult, self)
end

function RankRaceFindEnemyView:onExitFinished()
	RankRaceFindEnemyView.super.onExitFinished(self)
end

function RankRaceFindEnemyView:_getSpeed()
	return 40
end

function RankRaceFindEnemyView:_getNeedTime()
	return 1
end

function RankRaceFindEnemyView:_initNeedTimeCount()
	self.need_time = self:_getNeedTime()

	removetimer(self._updateTime, self)
	self:_updateTime()
	settimer(1, self._updateTime, self)
end

function RankRaceFindEnemyView:_updateTime()
	local hour, min, sec = GameUtil.getTimeHHMMSS(self.need_time)

	self._text_count_down_time.text = string.format("%02d:%02d", min, sec)
	self.need_time = self.need_time + 1

	if self.need_time <= 0 then
		self:endMatchEnemy()
	end
end

function RankRaceFindEnemyView:_onClickBtnClose()
	return
end

function RankRaceFindEnemyView:_onNoEnemy(_fromProto)
	removetimer(self._updateTime, self)
	removetimer(self._onNoEnemy, self)

	if not _fromProto then
		RankingMatchAgent.instance:sendRM_CancelMatchingReq()
	end

	TipsFacade.instance:openTipWindowNoX("提示", RankRaceConfig.instance:getWord(11), function()
		self:_viewClose()
	end, "知道了", UnityEngine.TextAnchor.MiddleCenter)
end

function RankRaceFindEnemyView:_openMatchSuccView()
	removetimer(self._openMatchSuccView, self)
	UIStateManager.instance:push(ViewName.RankRaceMatchSuccView)
	self:_viewClose()
end

function RankRaceFindEnemyView:_showEffect()
	local effect_path = "fx_ui_pipeduishou/fx_ui_pipeduishoueffect.prefab"

	self._uiEffect = UIEffectManager.instance:playEffect(self, effect_path, nil, 0, 0, true, nil, function(finishHandlerTarget, eff)
		return
	end, function(finishHandlerTarget, eff)
		Framework.TransformUtil.SetLocalPos(eff.effGo.transform, 0, 0, 0)

		self._effectControl = eff.effGo:GetComponent("UIrankraceFindEnemyEffectContrl")
	end)

	self._uiEffect:setParent(self.mainGO.transform)
	self._uiEffect:setScale(1)
end

function RankRaceFindEnemyView:_clearEffect()
	if self._uiEffect then
		UIEffectManager.instance:stopEffect(self._uiEffect)

		self._uiEffect = nil
	end
end

function RankRaceFindEnemyView:_onRankRaceResult()
	local state = RankRaceResultModel.instance:getRankRaceState()

	if state ~= RankRaceResultModel.State_Normal then
		self:_viewClose()
	end
end

function RankRaceFindEnemyView:_viewClose()
	if self._viewFlag then
		self:close()
	end

	self._viewFlag = false
end

return RankRaceFindEnemyView
