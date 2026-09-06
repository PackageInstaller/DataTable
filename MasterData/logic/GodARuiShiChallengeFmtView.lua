-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/godaruishichallenge/view/GodARuiShiChallengeFmtView.lua

module("logic.extensions.godaruishichallenge.view.GodARuiShiChallengeFmtView", package.seeall)

local GodARuiShiChallengeFmtView = class("GodARuiShiChallengeFmtView", ViewComponent)

function GodARuiShiChallengeFmtView:ctor()
	self._moveSpeed = 0.5
	self._effectPosition = {
		{
			rotate = -36,
			x = -127,
			y = 113
		},
		{
			rotate = 0,
			x = -131,
			y = -5
		},
		{
			rotate = 36,
			x = -127,
			y = -134
		},
		{
			rotate = -24,
			x = -271,
			y = 113
		},
		{
			rotate = 0,
			x = -278,
			y = -5
		},
		{
			rotate = 24,
			x = -294,
			y = -134
		},
		{
			rotate = -18,
			x = -415,
			y = 114
		},
		{
			rotate = 0,
			x = -432,
			y = -5
		},
		{
			rotate = 18,
			x = -454,
			y = -134
		}
	}
	self._effectEnemyPosition = {
		{
			rotate = 36,
			x = 125,
			y = 113
		},
		{
			rotate = 0,
			x = 127,
			y = -5
		},
		{
			rotate = -36,
			x = 123,
			y = -134
		},
		{
			rotate = 24,
			x = 267,
			y = 113
		},
		{
			rotate = 0,
			x = 277,
			y = -5
		},
		{
			rotate = -24,
			x = 289,
			y = -134
		},
		{
			rotate = 18,
			x = 413,
			y = 114
		},
		{
			rotate = 0,
			x = 429,
			y = -5
		},
		{
			rotate = -18,
			x = 453,
			y = -134
		}
	}
end

function GodARuiShiChallengeFmtView:buildUI()
	GodARuiShiChallengeFmtView.super.buildUI(self)

	self._txtTime = self:getTxt("txtTimes")
	self._effectMove = self:getGo("effectMove")
	self._effectPos = self:getGo("effectPos")
	self._effectMoveGroup = self:getGo("effectMoveGroup")
	self._effectPosGroup = self:getGo("effectPosGroup")
	self._moveGroup = ItemGroup.New(self._effectMoveGroup, self._effectMove)
	self._posGroup = ItemGroup.New(self._effectPosGroup, self._effectPos)
end

function GodARuiShiChallengeFmtView:bindEvents()
	GodARuiShiChallengeFmtView.super.bindEvents(self)
end

function GodARuiShiChallengeFmtView:unbindEvents()
	GodARuiShiChallengeFmtView.super.unbindEvents(self)
end

function GodARuiShiChallengeFmtView:onEnter()
	GodARuiShiChallengeFmtView.super.onEnter(self)

	self._fmtMo = self:getFirstParam()
	self._effectPosList = {}
	self._effectMoveHandlers = {}
	self._effectPoscHandlers = {}
	self._stageTypeCfg = nil

	GlobalDispatcher:addListener(GlobalNotify.GodARuiShiChallengeCloseRuleView, self._showStartEffect, self)

	self._canShowEffect = true
	self._type = self._fmtMo:getCustomType()

	if self._type == GodARuiShiCustomFmtMo.Boss then
		self._challengeBossTimes = GodARuiShiChallengeConfig.instance:getChallengeBossTimes(self._fmtMo:getChallengeId())
		self._bossTime = GodARuiShiChallengeModel.instance:getBossTime()
		self._txtTime.text = langPara("挑战次数：%d/%d", self._challengeBossTimes - self._bossTime, self._challengeBossTimes)
	else
		self._stageTypeCfg = GodARuiShiChallengeConfig.instance:getStageTypeInfo(self._type)
		self._txtTime.text = ""
	end
end

function GodARuiShiChallengeFmtView:onExit()
	GodARuiShiChallengeFmtView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.GodARuiShiChallengeCloseRuleView, self._showStartEffect, self)

	for i, v in pairs(self._effectMoveHandlers) do
		UIEffectManager.instance:stopEffect(v)
	end

	for i, v in pairs(self._effectPoscHandlers) do
		UIEffectManager.instance:stopEffect(v)
	end

	removetimer(self._updateMoveEffect, self)
end

function GodARuiShiChallengeFmtView:_showStartEffect(isBoss, stageId, challengeId)
	local stageCfg = GodARuiShiChallengeConfig.instance:getStageInfo(challengeId, stageId)
	local creepCfg = GodARuiShiChallengeConfig.instance:getTeam(stageCfg.creepsMasterId)

	self._effectPosList = creepCfg.effectPos

	for i, v in pairs(self._effectMoveHandlers) do
		UIEffectManager.instance:stopEffect(v)
	end

	for i, v in pairs(self._effectPoscHandlers) do
		UIEffectManager.instance:stopEffect(v)
	end

	if self._stageTypeCfg and self._canShowEffect then
		self._moveGroup:updateWithMoArray(self._effectPosList, self.playMoveEffect, self)
	end

	self._canShowEffect = false
end

function GodARuiShiChallengeFmtView:playMoveEffect(item, pos, i)
	local go = item.mainGO

	GameUtil.setLocalPos(go, 0, 0, 0)

	local function _clearTrail(handler, eff)
		local trs = eff.effGo:GetComponentsInChildren(typeof(UnityEngine.TrailRenderer))

		for i = 0, trs.Length - 1 do
			trs[i]:Clear()
		end
	end

	UIEffectManager.instance:stopEffect(self._effectMoveHandlers[i])

	local effectHandler

	if not string.nilorempty(self._stageTypeCfg.effectMove) then
		local effectPath = "20220902/shenqiaruisi/" .. self._stageTypeCfg.effectMove .. ".prefab"

		effectHandler = UIEffectManager.instance:playEffect(self, effectPath, go.transform, 0, 0, true, nil, nil, _clearTrail)
	end

	if effectHandler then
		effectHandler:setParent(go.transform)
		effectHandler:setLocalPos(0, 0, 0)
		effectHandler:setScale(1)

		if effectHandler.effGo then
			local tr = effectHandler.effGo:GetComponentInChildren(typeof(UnityEngine.TrailRenderer))

			tr:Clear()
		end

		self._effectMoveHandlers[i] = effectHandler
	end

	local moveToEnemy = self._stageTypeCfg.enemyEffect

	UnityTweens.TweenPosition.StopTween(go)

	if moveToEnemy == true then
		UnityTweens.TweenPosition.StartTween(go, Vector3.zero, Vector3.New(self._effectEnemyPosition[pos].x, self._effectEnemyPosition[pos].y, 0), self._moveSpeed)
	else
		UnityTweens.TweenPosition.StartTween(go, Vector3.zero, Vector3.New(self._effectPosition[pos].x, self._effectPosition[pos].y, 0), self._moveSpeed)
	end

	removetimer(self._updateMoveEffect, self)
	settimer(0.02, self._updateMoveEffect, self, false)
	removetimer(self._tryShowPosEffect, self)
	settimer(self._moveSpeed + 0.1, self._tryShowPosEffect, self, false)
end

function GodARuiShiChallengeFmtView:_updateMoveEffect()
	for i, v in pairs(self._effectMoveHandlers) do
		UIEffectManager.instance:updateEffectPosition(v)
	end
end

function GodARuiShiChallengeFmtView:_tryShowPosEffect()
	removetimer(self._updateMoveEffect, self)

	for i, v in pairs(self._effectMoveHandlers) do
		UIEffectManager.instance:stopEffect(v)
	end

	self._posGroup:updateWithMoArray(self._effectPosList, self._updatePosEffect, self)
end

function GodARuiShiChallengeFmtView:_updatePosEffect(item, pos, i)
	local go = item.mainGO

	GameUtil.setLocalPos(go, self._effectPosition[pos].x, self._effectPosition[pos].y, 0)

	if self._fmtMo:checkOnPos(pos) then
		UIEffectManager.instance:stopEffect(self._effectPoscHandlers[pos])
	else
		local effectHandler

		if not string.nilorempty(self._stageTypeCfg.effectPos) then
			local effectPath = "20220902/shenqiaruisi/" .. self._stageTypeCfg.effectPos .. ".prefab"

			effectHandler = UIEffectManager.instance:playEffect(self, effectPath, nil, 0, 0, false)
		end

		local enemyEffect = self._stageTypeCfg.enemyEffect

		if enemyEffect == false then
			GameUtil.setLocalPos(go, self._effectPosition[pos].x, self._effectPosition[pos].y, 0)
		else
			GameUtil.setLocalPos(go, self._effectEnemyPosition[pos].x, self._effectEnemyPosition[pos].y, 0)
		end

		if effectHandler then
			effectHandler:setParent(go.transform)
			effectHandler:setLocalPos(0, 0, 0)
			effectHandler:setScale(1)

			self._effectPoscHandlers[pos] = effectHandler
		end
	end
end

return GodARuiShiChallengeFmtView
