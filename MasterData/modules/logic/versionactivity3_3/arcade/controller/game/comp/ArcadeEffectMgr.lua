-- chunkname: @modules/logic/versionactivity3_3/arcade/controller/game/comp/ArcadeEffectMgr.lua

module("modules.logic.versionactivity3_3.arcade.controller.game.comp.ArcadeEffectMgr", package.seeall)

local ArcadeEffectMgr = class("ArcadeEffectMgr", ArcadeBaseSceneComp)
local __G__TRACKBACK__ = __G__TRACKBACK__
local xpcall = xpcall

function ArcadeEffectMgr:onInit()
	transformhelper.setLocalPos(self.trans, 0, 0, ArcadeGameEnum.Const.EffectZLevel)

	self._gridEffectDict = {}
	self._effectList = {}
	self._bulletGODict = {}
	self._bulletTweenDict = {}
end

function ArcadeEffectMgr:addEventListeners()
	return
end

function ArcadeEffectMgr:removeEventListeners()
	return
end

function ArcadeEffectMgr:_getGridEffectDict(gridX, gridY)
	local gridId = ArcadeGameHelper.getGridId(gridX, gridY)

	return (ArcadeGameHelper.checkDictTable(self._gridEffectDict, gridId))
end

function ArcadeEffectMgr:tryCheckEffectRound()
	xpcall(self._onCheckEffectRound, __G__TRACKBACK__, self)
end

function ArcadeEffectMgr:_onCheckEffectRound()
	if not self._initialized then
		return
	end

	local list = self._effectList

	for _, effect in ipairs(list) do
		if effect and effect.round and effect.round ~= -1 then
			if effect.round <= 0 then
				effect.round = -1

				if not effect.isPermanent then
					gohelper.setActive(effect.go, false)
				end
			else
				effect.round = effect.round - 1
			end
		end
	end
end

function ArcadeEffectMgr:removeEffect(effectId, gridX, gridY, isNotIgnoreAlert, isBullet)
	if isBullet then
		local resName = ArcadeConfig.instance:getEffectResName(effectId)

		self:removeBulletEffect(resName)
	else
		local effectGODict = self:_getGridEffectDict(gridX, gridY)
		local effect = effectGODict[effectId]

		if not effect then
			return
		end

		if isNotIgnoreAlert == true and effect.round and effect.round ~= -1 then
			effect.isPermanent = false

			return
		end

		if not gohelper.isNil(effect.go) then
			effect.isPermanent = false
			effect.round = -1

			gohelper.setActive(effect.go, false)
		end
	end
end

function ArcadeEffectMgr:removeBulletEffect(resName)
	if self._bulletGODict then
		gohelper.setActive(self._bulletGODict, false)
	end
end

function ArcadeEffectMgr:removeAllEffect()
	for _, effect in ipairs(self._effectList) do
		effect.round = -1
		effect.isPermanent = false

		gohelper.setActive(effect.go, false)
	end

	for _, effGO in pairs(self._bulletGODict) do
		gohelper.setActive(effGO, false)
	end
end

function ArcadeEffectMgr:playBulletEffect(effectId, entityType, entityUid)
	local scene = ArcadeGameController.instance:getGameScene()
	local resName = ArcadeConfig.instance:getEffectResName(effectId)
	local entityMO = ArcadeGameModel.instance:getMOWithType(entityType, entityUid)

	if not scene or string.nilorempty(resName) or not entityMO then
		return
	end

	local direction = entityMO:getDirection()
	local cfgDirection = ArcadeConfig.instance:getEffectDirection(effectId)

	if cfgDirection and cfgDirection ~= 0 then
		direction = cfgDirection
	end

	local startGridX, startGridY, targetGridX, targetGridY
	local entityGridX, entityGridY = entityMO:getGridPos()
	local isFromBorder = ArcadeConfig.instance:getEffectIsFromBorder(effectId)

	if direction == ArcadeEnum.Direction.Up then
		startGridY = isFromBorder and ArcadeGameEnum.Const.RoomMinCoordinateValue - 1 or entityGridY + 1
		startGridX = entityGridX
		targetGridX = entityGridX
		targetGridY = ArcadeGameEnum.Const.RoomSize + 1
	elseif direction == ArcadeEnum.Direction.Down then
		startGridY = isFromBorder and ArcadeGameEnum.Const.RoomSize + 1 or entityGridY - 1
		startGridX = entityGridX
		targetGridX = entityGridX
		targetGridY = ArcadeGameEnum.Const.RoomMinCoordinateValue - 1
	elseif direction == ArcadeEnum.Direction.Left then
		startGridX = isFromBorder and ArcadeGameEnum.Const.RoomSize + 1 or entityGridX - 1
		targetGridX = ArcadeGameEnum.Const.RoomMinCoordinateValue - 1
		startGridY = entityGridY
		targetGridY = entityGridY
	elseif direction == ArcadeEnum.Direction.Right then
		startGridX = isFromBorder and ArcadeGameEnum.Const.RoomMinCoordinateValue - 1 or entityGridX + 1
		targetGridX = ArcadeGameEnum.Const.RoomSize + 1
		startGridY = entityGridY
		targetGridY = entityGridY
	end

	local effectGO = self._bulletGODict[resName]

	if not gohelper.isNil(effectGO) then
		self:_beginTweenBullet(effectId, effectGO, direction, startGridX, startGridY, targetGridX, targetGridY)
	else
		local resAbPath
		local resPath = ResUrl.getArcadeGameEffect(resName)

		if not GameResMgr.IsFromEditorDir then
			resAbPath = FightHelper.getEffectAbPath(resPath)
		end

		local rotationType = ArcadeConfig.instance:getEffectRotationType(effectId)
		local param = {
			isBullet = true,
			resName = resName,
			resAbPath = resAbPath,
			resPath = resPath,
			rotationType = rotationType,
			effectId = effectId,
			direction = direction,
			startGridX = startGridX,
			startGridY = startGridY,
			targetGridX = targetGridX,
			targetGridY = targetGridY
		}

		scene.loader:loadRes(resAbPath or resPath, self._onLoadEffectFinished, self, param)
	end
end

function ArcadeEffectMgr:_beginTweenBullet(effectId, effectGO, direction, startGridX, startGridY, targetGridX, targetGridY)
	local resName = ArcadeConfig.instance:getEffectResName(effectId)

	self:_killBulletTween(resName)

	if gohelper.isNil(effectGO) then
		return
	end

	local speed = ArcadeConfig.instance:getEffectSpeed(effectId)

	if not speed or speed <= 0 or not startGridX or not startGridY or not targetGridX or not targetGridY then
		self:removeBulletEffect(resName)

		return
	end

	local distance = 0
	local beginPosX, beginPosY = ArcadeGameHelper.getGridPos(startGridX, startGridY)
	local targetPosX, targetPosY = ArcadeGameHelper.getGridPos(targetGridX, targetGridY)

	if direction == ArcadeEnum.Direction.Up or direction == ArcadeEnum.Direction.Down then
		distance = math.abs(targetPosY - beginPosY)
	elseif direction == ArcadeEnum.Direction.Left or direction == ArcadeEnum.Direction.Right then
		distance = math.abs(targetPosX - beginPosX)
	end

	local effectTrans = effectGO.transform

	transformhelper.setLocalPosXY(effectTrans, beginPosX, beginPosY)

	local rotationType = ArcadeConfig.instance:getEffectRotationType(effectId)

	self:_setGoRotationByType(effectGO, rotationType, direction)
	gohelper.setActive(effectGO, true)
	self:_playEffectAudioId(effectId)

	local scene = ArcadeGameController.instance:getGameScene()

	if scene then
		scene:checkNeedShake(effectId)
	end

	self._bulletTweenDict[resName] = ZProj.TweenHelper.DOLocalMove(effectTrans, targetPosX, targetPosY, ArcadeGameEnum.Const.EffectZLevel, distance / speed, self._onBulletTweenEnd, self, resName, EaseType.Linear)
end

function ArcadeEffectMgr:_onBulletTweenEnd(resName)
	self:_killBulletTween(resName)
end

function ArcadeEffectMgr:_killBulletTween(resName)
	local tweenId = self._bulletTweenDict[resName]

	if tweenId then
		ZProj.TweenHelper.KillById(tweenId)
	end

	self:removeBulletEffect(resName)
end

function ArcadeEffectMgr:_killAllBulletTween()
	if self._bulletTweenDict then
		for resName, tweenId in pairs(self._bulletTweenDict) do
			ZProj.TweenHelper.KillById(tweenId)
			self:removeBulletEffect(resName)
		end
	end

	self._bulletTweenDict = {}
end

function ArcadeEffectMgr:playEffect2Grid(effectId, gridX, gridY, direction)
	self:_playEffect(effectId, gridX, gridY, direction, -1)
end

function ArcadeEffectMgr:playAlertEffect(effectId, gridX, gridY, direction)
	self:_playEffect(effectId, gridX, gridY, direction, 1)
end

function ArcadeEffectMgr:_playEffect(effectId, gridX, gridY, direction, round)
	local scene = ArcadeGameController.instance:getGameScene()
	local effCfg = ArcadeConfig.instance:getArcadeEffectCfg(effectId, true)

	if not scene or not effCfg or string.nilorempty(effCfg.triggerEffects) or not gridX or not gridY then
		return
	end

	local resName = effCfg.triggerEffects
	local rotationType = effCfg.effectsRotationType
	local effectGoDict = self:_getGridEffectDict(gridX, gridY)
	local effect = effectGoDict[effectId]

	if effect then
		gohelper.setActive(effect.go, false)
		gohelper.setActive(effect.go, true)
		self:_setEffectRound(effect, round)
		self:_setGoRotationByType(effect, rotationType)
		self:_playEffectAudioId(effectId)
		scene:checkNeedShake(effectId)
	else
		local resAbPath
		local resPath = ResUrl.getArcadeGameEffect(resName)

		if not GameResMgr.IsFromEditorDir then
			resAbPath = FightHelper.getEffectAbPath(resPath)
		end

		scene.loader:loadRes(resAbPath or resPath, self._onLoadEffectFinished, self, {
			resName = resName,
			resAbPath = resAbPath,
			resPath = resPath,
			rotationType = rotationType,
			effectId = effectId,
			direction = direction,
			gridX = gridX,
			gridY = gridY,
			round = round
		})
	end
end

function ArcadeEffectMgr:_onLoadEffectFinished(param)
	local scene = ArcadeGameController.instance:getGameScene()

	if not self._initialized or not scene then
		return
	end

	local effectId = param.effectId
	local assetRes = scene.loader:getResource(param.resPath, param.resAbPath)
	local effGO = gohelper.clone(assetRes, self.go)

	if param.isBullet then
		self._bulletGODict[param.resName] = effGO

		self:_beginTweenBullet(effectId, effGO, param.direction, param.startGridX, param.startGridY, param.targetGridX, param.targetGridY)
	else
		local gridX = param.gridX
		local gridY = param.gridY
		local effectGODict = self:_getGridEffectDict(gridX, gridY)
		local effTrans = effGO.transform
		local x, y = ArcadeGameHelper.getGridPos(gridX, gridY)

		transformhelper.setLocalPos(effTrans, x, y, 0)

		local effect = self:getUserDataTb_()

		effect.go = effGO
		effect.transform = effTrans

		self:_setEffectRound(effect, param.round)

		effectGODict[effectId] = effect

		table.insert(self._effectList, effect)
		self:_setGoRotationByType(effect, param.rotationType, param.direction)
		self:_playEffectAudioId(effectId)
		scene:checkNeedShake(effectId)
	end
end

function ArcadeEffectMgr:_setEffectRound(effect, round)
	if round ~= -1 then
		effect.round = round
	else
		effect.isPermanent = true
	end
end

function ArcadeEffectMgr:_setGoRotationByType(effect, rotationType, dir)
	if rotationType == 1 and effect then
		if not ArcadeEnum.Dir2RotationVal[dir] then
			transformhelper.setLocalRotation(effect.transform, 0, 0, ArcadeEnum.Dir2RotationVal[dir])
		end
	end
end

function ArcadeEffectMgr:_playEffectAudioId(effectId)
	local audioId = ArcadeConfig.instance:getEffectAudio(effectId)

	if audioId and audioId > 0 then
		AudioMgr.instance:trigger(audioId)
	end
end

function ArcadeEffectMgr:onClear()
	if #self._effectList > 0 then
		local list = self._effectList

		self._gridEffectDict = {}
		self._effectList = {}

		for _, effect in pairs(list) do
			effect.go = nil
			effect.transform = nil
		end
	end

	self:_killAllBulletTween()

	self._bulletGODict = {}
end

return ArcadeEffectMgr
