-- chunkname: @modules/logic/versionactivity3_3/arcade/view/game/entity/comp/ArcadeEntityEffectComp.lua

module("modules.logic.versionactivity3_3.arcade.view.game.entity.comp.ArcadeEntityEffectComp", package.seeall)

local ArcadeEntityEffectComp = class("ArcadeEntityEffectComp", LuaCompBase)

function ArcadeEntityEffectComp:ctor(param)
	self._entity = param.entity
	self._compName = param.compName
end

function ArcadeEntityEffectComp:init(go)
	self.go = go
	self.trans = go.transform
	self._posZ = transformhelper.getLocalPos(self.trans)
	self._effectGODict = {}
	self._initialized = true
end

function ArcadeEntityEffectComp:playBulletEffect(effectId)
	local scene = ArcadeGameController.instance:getGameScene()
	local resName = ArcadeConfig.instance:getEffectResName(effectId)

	if not scene or string.nilorempty(resName) then
		return
	end

	local isPlayOnGrid = ArcadeConfig.instance:getEffectIsPlayOnGrid(effectId)

	if isPlayOnGrid then
		local mo = self._entity:getMO()

		if mo then
			local entityType = mo:getEntityType()
			local uid = mo:getUid()

			scene.effectMgr:playBulletEffect(effectId, entityType, uid)
		end
	else
		local effectGO = self._effectGODict[effectId]

		if not gohelper.isNil(effectGO) then
			self:_beginTweenBullet(effectId, effectGO)
			scene:checkNeedShake(effectId)
		else
			local resAbPath
			local resPath = ResUrl.getArcadeGameEffect(resName)

			if not GameResMgr.IsFromEditorDir then
				resAbPath = FightHelper.getEffectAbPath(resPath)
			end

			scene.loader:loadRes(resAbPath or resPath, self.onLoadEffectFinished, self, {
				isBullet = true,
				resName = resName,
				resAbPath = resAbPath,
				resPath = resPath,
				effectId = effectId
			})
		end
	end
end

function ArcadeEntityEffectComp:_beginTweenBullet(effectId, effectGO)
	if gohelper.isNil(effectGO) then
		return
	end

	if self._entity then
		local mo = self._entity:getMO()
		local speed = ArcadeConfig.instance:getEffectSpeed(effectId)

		if not mo or not speed or speed <= 0 then
			self:removeEffect(effectId)

			return
		end

		local distance = 0
		local beginPosX, beginPosY = 0, 0
		local targetPosX, targetPosY
		local effDirection = self:_getEntityDir()
		local cfgDirection = ArcadeConfig.instance:getEffectDirection(effectId)

		if cfgDirection and cfgDirection ~= 0 then
			effDirection = cfgDirection
		end

		local isFromBorder = ArcadeConfig.instance:getEffectIsFromBorder(effectId)
		local gridSize = ArcadeConfig.instance:getArcadeGameGridSize()
		local entityGridX, entityGridY = mo:getGridPos()

		if effDirection == ArcadeEnum.Direction.Up then
			targetPosX = 0
			targetPosY = gridSize * (ArcadeGameEnum.Const.RoomSize - entityGridY + 1)
			beginPosY = isFromBorder and gridSize * (ArcadeGameEnum.Const.RoomSize - entityGridY + 1) or gridSize
			distance = math.abs(targetPosY - beginPosY)
		elseif effDirection == ArcadeEnum.Direction.Down then
			targetPosX = 0
			targetPosY = -gridSize * (entityGridY + 1)
			beginPosY = isFromBorder and -gridSize * (entityGridY + 1) or -gridSize
			distance = math.abs(targetPosY - beginPosY)
		elseif effDirection == ArcadeEnum.Direction.Left then
			beginPosX = isFromBorder and gridSize * (ArcadeGameEnum.Const.RoomSize - entityGridX + 1) or -gridSize
			targetPosX = -gridSize * (entityGridX + 1)
			distance = math.abs(-gridSize * (entityGridX + 1) - beginPosX)
			targetPosY = 0
		elseif effDirection == ArcadeEnum.Direction.Right then
			beginPosX = isFromBorder and -gridSize * (entityGridX + 1) or gridSize
			targetPosX = gridSize * (ArcadeGameEnum.Const.RoomSize - entityGridX + 1)
			distance = math.abs(gridSize * (ArcadeGameEnum.Const.RoomSize - entityGridX + 1) - beginPosX)
			targetPosY = 0
		end

		if not targetPosX or not targetPosY or distance <= 0 then
			self:removeEffect(effectId)

			return
		end

		self:removeEffect(self._playingBulletEffectId)

		local effectTrans = effectGO.transform

		transformhelper.setLocalPosXY(effectTrans, beginPosX, beginPosY)

		local rotationType = ArcadeConfig.instance:getEffectRotationType(effectId)

		self:_setGoRotationByType(effectGO, rotationType)
		gohelper.setActive(effectGO, true)

		self._playingBulletEffectId = effectId

		self:_playEffectAudioId(effectId)

		local scene = ArcadeGameController.instance:getGameScene()

		if scene then
			scene:checkNeedShake(effectId)
		end

		self._bulletTweenId = ZProj.TweenHelper.DOLocalMove(effectTrans, targetPosX, targetPosY, self._posZ, distance / speed, self._onBulletTweenEnd, self, nil, EaseType.Linear)
	end
end

function ArcadeEntityEffectComp:_onBulletTweenEnd()
	self:removeEffect(self._playingBulletEffectId)
end

function ArcadeEntityEffectComp:playEffect(effectId)
	local willPlaySceneEff = true
	local scene = ArcadeGameController.instance:getGameScene()
	local resName = ArcadeConfig.instance:getEffectResName(effectId)

	willPlaySceneEff = (not scene or string.nilorempty(resName)) and false

	ArcadeGameController.instance:dispatchEvent(ArcadeEvent.PlayUIEffect, effectId, not willPlaySceneEff)

	if not willPlaySceneEff then
		return
	end

	local isPlayOnGrid = ArcadeConfig.instance:getEffectIsPlayOnGrid(effectId)

	if isPlayOnGrid then
		local mo = self._entity:getMO()
		local gridX, gridY = mo:getGridPos()
		local direction = self:_getEntityDir()
		local playInNearestGrid = ArcadeConfig.instance:getIsNearestGrid(effectId)

		if playInNearestGrid then
			gridX, gridY = ArcadeGameHelper.getEntityNearCharacterGrid(mo)
		end

		scene.effectMgr:playEffect2Grid(effectId, gridX, gridY, direction)
	else
		local effectGO = self._effectGODict[effectId]

		if not gohelper.isNil(effectGO) then
			gohelper.setActive(effectGO, false)
			gohelper.setActive(effectGO, true)

			local rotationType = ArcadeConfig.instance:getEffectRotationType(effectId)

			self:_setGoRotationByType(effectGO, rotationType)
			self:_playEffectAudioId(effectId)
			scene:checkNeedShake(effectId)
		else
			local resAbPath
			local resPath = ResUrl.getArcadeGameEffect(resName)

			if not GameResMgr.IsFromEditorDir then
				resAbPath = FightHelper.getEffectAbPath(resPath)
			end

			scene.loader:loadRes(resAbPath or resPath, self.onLoadEffectFinished, self, {
				resName = resName,
				resAbPath = resAbPath,
				resPath = resPath,
				effectId = effectId
			})
		end
	end
end

function ArcadeEntityEffectComp:onLoadEffectFinished(param)
	local scene = ArcadeGameController.instance:getGameScene()

	if not self._initialized or not scene then
		return
	end

	local effectId = param.effectId
	local effGO = self._effectGODict[effectId]

	if gohelper.isNil(effGO) then
		local assetRes = scene.loader:getResource(param.resPath, param.resAbPath)

		if not assetRes then
			return
		end

		effGO = gohelper.clone(assetRes, self.go)
		self._effectGODict[effectId] = effGO
	end

	local rotationType = ArcadeConfig.instance:getEffectRotationType(effectId)

	self:_setGoRotationByType(effGO, rotationType)

	local dir = ArcadeConfig.instance:getEffectDirection(effectId)
	local x, y = self:_getLocalPosByDir(dir)

	transformhelper.setLocalPos(effGO.transform, x, y, 0)

	if param.isBullet then
		self:_beginTweenBullet(effectId, effGO)
	else
		self:_playEffectAudioId(effectId)
		scene:checkNeedShake(effectId)
	end
end

function ArcadeEntityEffectComp:_playEffectAudioId(effectId)
	local audioId = ArcadeConfig.instance:getEffectAudio(effectId)

	if audioId and audioId > 0 then
		AudioMgr.instance:trigger(audioId)
	end
end

function ArcadeEntityEffectComp:removeEffect(effectId)
	if not effectId then
		return
	end

	local resName = ArcadeConfig.instance:getEffectResName(effectId)

	if string.nilorempty(resName) then
		return
	end

	local effectGO = self._effectGODict[effectId]

	if not gohelper.isNil(effectGO) then
		gohelper.setActive(effectGO, false)
	end

	if self._playingBulletEffectId and self._playingBulletEffectId == effectId then
		self._playingBulletEffectId = nil

		self:_killBulletTween()
	end
end

function ArcadeEntityEffectComp:removeAllEffect()
	for _, effectGO in pairs(self._effectGODict) do
		gohelper.setActive(effectGO, false)
	end

	self:_killBulletTween()
end

function ArcadeEntityEffectComp:_killBulletTween()
	if self._bulletTweenId then
		ZProj.TweenHelper.KillById(self._bulletTweenId)

		self._bulletTweenId = nil
	end
end

function ArcadeEntityEffectComp:_setGoRotationByType(effectGO, rotationType)
	if rotationType == 1 and not gohelper.isNil(effectGO) then
		local dir = self:_getEntityDir()

		if not ArcadeEnum.Dir2RotationVal[dir] then
			transformhelper.setLocalRotation(effectGO.transform, 0, 0, ArcadeEnum.Dir2RotationVal[dir])
		end
	end
end

function ArcadeEntityEffectComp:_getEntityDir()
	local mo = self._entity:getMO()

	if mo then
		return mo:getDirection()
	end

	return ArcadeEnum.Direction.Right
end

function ArcadeEntityEffectComp:_getLocalPosByDir(dir)
	local sizeX, sizeY = 1, 1
	local mo = self._entity:getMO()

	if mo then
		sizeX, sizeY = mo:getSize()
	end

	return ArcadeGameHelper.getEffectOffSetPos(dir, sizeX, sizeY)
end

function ArcadeEntityEffectComp:getCompName()
	return self._compName
end

function ArcadeEntityEffectComp:clear()
	if not self._initialized then
		return
	end

	self:_killBulletTween()

	self._initialized = false
	self._entity = nil
	self._compName = nil
	self._effectGODict = {}
end

function ArcadeEntityEffectComp:onDestroy()
	self:clear()
end

return ArcadeEntityEffectComp
