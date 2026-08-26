-- chunkname: @modules/logic/versionactivity3_3/arcade/controller/game/comp/ArcadeFlyingEffectMgr.lua

module("modules.logic.versionactivity3_3.arcade.controller.game.comp.ArcadeFlyingEffectMgr", package.seeall)

local ArcadeFlyingEffectMgr = class("ArcadeFlyingEffectMgr", ArcadeBaseSceneComp)

function ArcadeFlyingEffectMgr:onInit()
	transformhelper.setLocalPos(self.trans, 0, 0, ArcadeGameEnum.Const.EffectZLevel)

	self._effectListDict = {}
	self._effectList = {}
	self._bezierY = ArcadeConfig.instance:getArcadeConst(ArcadeEnum.ConstId.FlyingEffectOffsetY, true) or 2
	self._bezierTime = ArcadeConfig.instance:getArcadeConst(ArcadeEnum.ConstId.FlyingEffectTime, true) or 0.3
end

function ArcadeFlyingEffectMgr:addEventListeners()
	return
end

function ArcadeFlyingEffectMgr:removeEventListeners()
	return
end

function ArcadeFlyingEffectMgr:begin2EndXY(effectId, beginX, beginY, endX, endY)
	local scene = ArcadeGameController.instance:getGameScene()
	local effCfg = ArcadeConfig.instance:getArcadeEffectCfg(effectId, true)

	if not scene or not effCfg or string.nilorempty(effCfg.triggerEffects) or not beginX or not beginY or not endX or not endY then
		logNormal(string.format("ArcadeSkillHitThrowingBomb ==> %s %s %s %s %s", effectId, beginX, beginY, endX, endY))

		return
	end

	local resName = effCfg.triggerEffects
	local effect = self:_getEffectect(effectId)

	if effect then
		effect.beginX = beginX
		effect.beginY = beginY
		effect.endX = endX
		effect.endY = endY

		self:playEffect(effect)
	else
		local resAbPath
		local resPath = ResUrl.getArcadeGameEffect(resName)

		if not GameResMgr.IsFromEditorDir then
			resAbPath = FightHelper.getEffectAbPath(resPath)
		end

		scene.loader:loadRes(resAbPath or resPath, self._onLoadeffectectFinished, self, {
			resName = resName,
			resAbPath = resAbPath,
			resPath = resPath,
			effectId = effectId,
			beginX = beginX,
			beginY = beginY,
			endX = endX,
			endY = endY
		})
	end
end

function ArcadeFlyingEffectMgr:_onLoadeffectectFinished(param)
	local scene = ArcadeGameController.instance:getGameScene()

	if not self._initialized or not scene then
		return
	end

	local effectId = param.effectId
	local assetRes = scene.loader:getResource(param.resPath, param.resAbPath)
	local effGO = gohelper.clone(assetRes, self.go)
	local effTrans = effGO.transform

	transformhelper.setLocalPos(effTrans, param.beginX, param.beginY, 0)

	local effect = {
		effectId = effectId,
		go = effGO,
		transform = effTrans,
		beginX = param.beginX,
		beginY = param.beginY,
		endX = param.endX,
		endY = param.endY,
		bezierY = self._bezierY
	}

	self:addEffect(effectId, effect)
	self:playEffect(effect)
end

function ArcadeFlyingEffectMgr:playEffect(effect)
	if effect then
		if effect.tweenId then
			ZProj.TweenHelper.KillById(effect.tweenId)
		end

		gohelper.setActive(effect.go, false)
		transformhelper.setLocalPos(effect.transform, effect.beginX, effect.beginY, 0)
		gohelper.setActive(effect.go, true)

		effect.isFinish = false
		effect.tweenId = ZProj.TweenHelper.DOTweenFloat(0, 1, self._bezierTime, ArcadeFlyingEffectMgr._frameBeginCallback, ArcadeFlyingEffectMgr._finishCallback, effect)
	end
end

function ArcadeFlyingEffectMgr:addEffect(effectId, effect)
	local effectList = self._effectListDict[effectId]

	if effectList then
		table.insert(effectList, effect)
	else
		self._effectListDict[effectId] = {
			effect
		}
	end

	table.insert(self._effectList, effect)
end

function ArcadeFlyingEffectMgr:_getEffectect(effectId)
	local effectList = self._effectListDict[effectId]

	if effectList then
		for _, effect in ipairs(effectList) do
			if effect.isFinish == true then
				return effect
			end
		end
	end

	return nil
end

function ArcadeFlyingEffectMgr.getBezierValue(t, beginValue, endValue, bezier)
	return (1 - t) * (1 - t) * beginValue + 2 * t * (1 - t) * bezier + t * t * endValue
end

function ArcadeFlyingEffectMgr._finishCallback(effect)
	effect.isFinish = true

	gohelper.setActive(effect.go, false)

	effect.tweenId = nil
end

function ArcadeFlyingEffectMgr._frameBeginCallback(effect, t)
	local x = ArcadeFlyingEffectMgr.getBezierValue(t, effect.beginX, effect.endX, (effect.beginX + effect.endX) * 0.5)
	local y = ArcadeFlyingEffectMgr.getBezierValue(t, effect.beginY, effect.endY, effect.bezierY)

	transformhelper.setLocalPos(effect.transform, x, y, 0)
end

function ArcadeFlyingEffectMgr:onClear()
	if #self._effectList > 0 then
		local list = self._effectList

		self._effectList = {}
		self._effectListDict = {}

		for _, effect in pairs(list) do
			effect.go = nil
			effect.transform = nil

			if effect.tweenId then
				ZProj.TweenHelper.KillById(effect.tweenId)
			end

			effect.tweenId = nil
		end
	end
end

return ArcadeFlyingEffectMgr
