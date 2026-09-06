-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/impl/BattleScene.lua

module("logicscene.scene.impl.BattleScene", package.seeall)

local BattleScene = class("BattleScene", SceneBase)
local shadowColId = MaterialUtils.GetPropertyId("_ShadowColor")

function BattleScene:_initComponents()
	self:_addComponent("resQueue", BattleResourcesQueue)
	self:_addComponent("stage", BattleSceneStage)
	self:_addComponent("camera", BattleSceneCamera)
	self:_addComponent("unitFactory", BattleUnitFactory)
	self:_addComponent("bgm", BattleSceneBgmMgr)
	self:_addComponent("roundHandler", BattleRoundHandler)
	self:_addComponent("resPreLoad", BattleResourcesPreload)
	self:_addComponent("collisions", CollisionsManager)
end

function BattleScene:getSceneType()
	return SceneType.Battle
end

function BattleScene:onEnter(sceneId, bornX, bornZ)
	BattleAnimEvevts.createMaskSceneObject()
	OpSummaryController.instance:clearBgmStatus()
	BattleScene.super.onEnter(self, sceneId, bornX, bornZ)
	UIStateManager.instance:setRoot(ViewName.battle)

	if SceneMainPlayer.instance then
		local mainPlayer = SceneMainPlayer.instance:getMainPlayer()

		if mainPlayer then
			mainPlayer:stopAllActions()
		end
	end

	self.bgm:preInitBgmId()

	AMTargetPosition.spineDirectionWithFlipX = true
	AMPlayer.autoJumpSkill = BattleModel.instance:getAutoSkipUtilSkill() or BattleModel.instance:getAutoSkipShenyaoSkill()
end

function BattleScene:onEnterFinished()
	GlobalModel.instance:visibleMainCamera(true)
	OpSummaryController.instance:clearBgmStatus()
	UIEffectManager.instance:setPermanentAll(true)
	UIStateManager.instance:setRoot(nil)

	CommonObjectMgr.shadowOrder = -6000

	self.unitFactory:buildUnits()
	BattleScene.super.onEnterFinished(self)
	BattleController.instance:startBattle()
	self:_handleCitySceneObjects()
	GlobalDispatcher:dispatch(GlobalNotify.OnBattleEnterFinished)
	ViewMgr.instance:open(ViewName.Battle)
	HardwareQuality._closeAdaptLRSide()
end

function BattleScene:onEnterNextBattle()
	self:pauseBattle(true)
	AMPlayer.ClearAllCacheObjects()
	self.resQueue:clearAll()
	self.resPreLoad:clearAll()
	ViewMgr.instance:close(ViewName.Battle)
	WaitingView.instance:show()
	print("enter next battle")
	self.collisions:clearAll()
	self.bgm:onEnterNextBattle()
	self.stage:loadCharacterRes(self._onEnterNextBattleFinished, self)
	self.stage:preloadSkillRes()
end

function BattleScene:_onEnterNextBattleFinished()
	print("enter next battle finished")
	WaitingView.instance:hide()
	self.roundHandler:onEnterSceneFinished()
	self:pauseBattle(false)
	self.unitFactory:removeAll()
	self.unitFactory:buildUnits()
	ViewMgr.instance:open(ViewName.Battle)
	BattleController.instance:startBattle()
	ResGcMgr.instance:gc()
	GMController.instance:showGM(true)
	GlobalDispatcher:dispatch(GlobalNotify.EndlessBattleResLoaded)
	HardwareQuality._closeAdaptLRSide()
end

function BattleScene:_handleCitySceneObjects()
	local cityParent = AoSceneManager.Instance:GetObjectParent()

	if cityParent then
		local childCount = cityParent.childCount - 1

		for i = 0, childCount do
			local go = cityParent:GetChild(i).gameObject

			go:SetActive(false)
		end
	end
end

function BattleScene:onExit()
	return
end

function BattleScene:onExitFinished()
	BattleAnimEvevts.setLuaMaskSceneObjectVisible(false)
	SoloAudioMgr.instance:stopEvt()

	GlobalModel.instance.groundCamera.cullingMask = LayerMask.GetMask(SceneLayer.Ground3D)

	UIEffectManager.instance:setPermanentAll(nil)

	AMPlayer.autoJumpSkill = false

	DropManager.instance:clear()
	HurtEvtsPool.instance:clear()
	self.unitFactory:removeAll()
	BattleFacade.instance:clearStatus()
	AMPlayer.ClearAllCacheObjects()

	self._isPause = nil

	ViewMgr.instance:close(ViewName.Battle)
	ViewMgr.instance:close(ViewName.BulletScreen)
	BulletScreenModel.instance:setEnum(nil)
	BulletScreenModel.instance:setKey(nil)
	BattleScene.super.onExit(self)
	GameEffectManager.instance:clearAll()
	FmodBanksManager.instance:unloadAllBanks()
	GameEffectManager.instance:releaseUnuseResources()
	UIEffectManager.instance:releaseUnuseResources()
	BattleModel.instance:setLeftTeamId(nil)
	SceneEffDistortMgr.instance:clear()
end

function BattleScene:update(deltaTime)
	if self._isPause then
		return
	end

	local units = self.unitFactory:getAllUnit()

	for k, v in pairs(units) do
		local sameUnits = v

		for k2, v2 in pairs(sameUnits) do
			v2:update(deltaTime)
		end
	end

	self.collisions:update(deltaTime)
	self.roundHandler:update(deltaTime)
end

function BattleScene:startBattle()
	UnitCompBattleFlowCommon.clearForbidBack()
	self.stage:startPreloadUnitsSkill()
	self.resQueue:startLoaded()
end

function BattleScene._sortUnits(x, y)
	if x == y then
		return false
	end

	if x.fmtIndex < y.fmtIndex then
		return true
	end

	return false
end

function BattleScene:getSortingUnits()
	local unitFactory = self.unitFactory
	local myTeamId = BattleModel.instance.myTeamId
	local enemyTeamId = BattleModel.instance:getEnemyPlayerTeam()
	local myUnits = unitFactory:getBttleUnits(myTeamId) or {}
	local enemyUnits = unitFactory:getBttleUnits(enemyTeamId) or {}
	local mySpeed = BattleModel.instance:getTeamSpeed(myTeamId)
	local enemySpeed = BattleModel.instance:getTeamSpeed(enemyTeamId)

	table.sort(myUnits, BattleScene._sortUnits)
	table.sort(enemyUnits, BattleScene._sortUnits)

	local teamList = {}

	if mySpeed < enemySpeed then
		table.insert(teamList, enemyUnits)
		table.insert(teamList, myUnits)
	else
		table.insert(teamList, myUnits)
		table.insert(teamList, enemyUnits)
	end

	local units = {}
	local idx = 1

	while true do
		local unit1 = teamList[1][idx]
		local unit2 = teamList[2][idx]

		idx = idx + 1

		if not unit1 and not unit2 then
			break
		end

		if unit1 then
			table.insert(units, unit1)
		end

		if unit2 then
			table.insert(units, unit2)
		end
	end

	return units
end

function BattleScene:endBattle()
	return
end

function BattleScene:passBattle()
	self.roundHandler:passBattle()
end

function BattleScene:retreatBattle()
	self.roundHandler:retreatBattle()
end

function BattleScene:pauseBattle(pause)
	self._isPause = pause

	self.roundHandler:pauseBattle(pause)

	local units = self.unitFactory:getAllUnit()

	for k, v in pairs(units) do
		local sameUnits = v

		for k2, v2 in pairs(sameUnits) do
			v2:pause(pause)
		end
	end
end

function BattleScene:onContinueFightRes()
	self.roundHandler:onContinueFightRes()
end

function BattleScene:updateBuffers(unit)
	local playerView = BattleModel.instance:getCharactorById(unit.teamId, unit.id)

	if playerView.buffIds and #playerView.buffIds > 0 then
		for i = 1, #playerView.buffIds do
			unit:addBuff(playerView.buffIds[i])

			if Framework.OSDef.isEditor then
				local targetColor = unit.teamId == BattleModel.instance.myTeamId and "28c3ff" or "ff2828"
				local buffCo = BattleConfig.instance:getBuffCo(playerView.buffIds[i])

				if buffCo then
					local petCo = CharacterConfig.instance:getPetCo(unit.raceId)

					printInfo(string.format(lang("battlerecord_buff_add"), targetColor, petCo.name, targetColor, buffCo.name .. "(" .. playerView.buffIds[i] .. ")"))
				else
					printInfo("buff 不存在，检查客户端是不是没导表，ID=" .. playerView.buffIds[i])
				end
			end
		end
	end
end

function BattleScene:updateUnitOnBorn(unit)
	self:updateUnitsTransform(unit)
	self:updateUnitsSkills(unit)
	self:updateUnitsAttrs(unit)
	self:updateBuffers(unit)

	local infoType = BattleModel.instance:getBtlInfoType()

	unit:updateBattleInfoType(infoType)
	GlobalDispatcher:dispatch(GlobalNotify.OnBattleUnitBirth, unit)
end

function BattleScene:updateUnitsTransform(unit)
	local teamId = unit.teamId
	local dirTeamId = BattleModel.instance:getTeamDirection(teamId)
	local playerView = BattleModel.instance:getCharactorById(unit.teamId, unit.id)
	local index = playerView.y * 3 + playerView.x + 1

	if index < 0 then
		index = 1
	end

	local pos = BattleConfig.instance:getFormationPos(dirTeamId + 1, index)

	if unit.attrs:isSpiritInvocationPet() then
		unit:hideUIAndShadow(true)
		unit:setAlpha(0)
		unit:hideBuffEffects(true)
		unit:setVisible(false)
	end

	unit.transform:setPos(pos[1], pos[2], pos[3])
	unit.attrs:setBirthPoint(pos[1], pos[2], pos[3])
	unit.attrs:setSummonedCharacter(playerView.isSummonedCharacter)
	unit.attrs:setIsDoppelganger(playerView.isDoppelganger)
	unit.attrs:setTJSummonedCharacter(playerView.isHeavenAwakenSummonedCharacter)
	unit:onUnitChataterCreate(playerView)
end

function BattleScene:_initSouceMonUnitsTransform()
	local allUnits = self.unitFactory:getAllUnit()

	for k, v in pairs(allUnits) do
		local sameUnits = v

		if sameUnits then
			for k2, v2 in pairs(sameUnits) do
				if v2.isSourceMon then
					local unit = v2
					local teamId = unit.teamId
					local spineDir
					local dirTeamId = BattleModel.instance:getTeamDirection(teamId)

					unit.spine:setDirection(dirTeamId == GameEnum.BattleTeam.Left and UnitSpineDir.Right or UnitSpineDir.Left)
					unit.transform:setPos(0, 0, 0)
					unit.attrs:setBirthPoint(0, 0, 0)
					unit:setVisible(false)

					unit.fmtIndex = -1
				end
			end
		end
	end
end

function BattleScene:updateUnitsAttrs(unit)
	local teamId = unit.teamId
	local playerView = BattleModel.instance:getCharactorById(teamId, unit.id)
	local petCO = CharacterConfig.instance:getPetCo(unit.raceId)
	local skillCfg = BattleConfig.instance:getSkillCo(playerView.ultimateSkillId, unit.modelId)

	unit.attrs:setCurShield(checknumber(playerView.shield))
	unit.attrs:setMaxHp(checknumber(playerView.maxHp))
	unit.attrs:setCurHp(checknumber(playerView.curHp))
	unit.attrs:setCurTempHp(checknumber(playerView.curHp))
	unit.attrs:setMaxVigour(checknumber(skillCfg.needVigour))
	unit.attrs:setOriginSkinId(unit.modelId)
	unit.attrs:setFightingPower(checknumber(playerView.zdl))
	unit:setVigour(checknumber(playerView.curVigour))
	unit.attrs:setName(PetSkinConfig.instance:getPetSkinName(unit.modelId))
	unit.attrs:setOtherName(playerView.skinOtherName)
	unit.attrs:setCatchable(playerView.enableCatched)
	unit.attrs:setLevel(checknumber(playerView.lv))
	unit.attrs:setAwakenLv(checknumber(playerView.awakenLv))
	unit.attrs:setAttributes(playerView.attributes)
	unit.unitUI:setHpValue(checknumber(playerView.curHp), checknumber(playerView.maxHp))
end

function BattleScene:_initSouceMonUnitsAttrs()
	local allUnits = self.unitFactory:getAllUnit()

	for k, v in pairs(allUnits) do
		local sameUnits = v

		if sameUnits then
			for k2, v2 in pairs(sameUnits) do
				if v2.isSourceMon then
					local unit = v2
					local petCO = CharacterConfig.instance:getPetCo(unit.raceId)

					unit.attrs:setMaxHp(100)
					unit.attrs:setCurHp(100)
					unit.attrs:setCurTempHp(100)
					unit.attrs:setMaxVigour(BattleModel.MaxVigour)
					unit.attrs:setCurVigour(BattleModel.MaxVigour)
					unit.attrs:setName(PetSkinConfig.instance:getPetSkinName(unit.modelId))
					unit.attrs:setLevel(0)

					local eles = PetSkinConfig.instance:getAllElementAttrs(unit.modelId)

					unit.attrs:setAttributes(eles)
					unit.unitUI:setHpValue(100, 100)
				end
			end
		end
	end
end

function BattleScene:updateUnitsSkills(unit)
	unit.skillList:initSkills()
end

return BattleScene
