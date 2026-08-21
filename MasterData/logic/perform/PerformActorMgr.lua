-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/Logic\\perform\\PerformActorMgr.lua

local BattleConst = require("Common/FrameBattle/BattleConst")
local PerformActor = require("logic/perform/PerformActor")
local SkillDataBank = require("Common/FrameBattle/BattleObject/SkillDataBank")
local CueDataBank = require("System/CueDataBank")
local EventCenter = EventCenter
local CueManager = CueManager
local Timer = Timer
local strClassName = "PerformActorMgr"
local PerformActorMgr = Class(strClassName)

function PerformActorMgr:ctor(performManager)
	self.nowEntityId = BattleConst.PERFORM_ACTOR_START
	self.performManager = performManager
	self.actors = {}
end

function PerformActorMgr:initActors(mEntityDict, hookData)
	self:giveBackTimeLineModel()

	local oldActors = self.actors

	self.actors = {}
	self.hookData = hookData

	local playerList = {}
	local monsterList = {}

	for entityId, heroInfo in pairs(mEntityDict) do
		local has = false

		for id, actor in pairs(oldActors) do
			if heroInfo.gid and actor.gid == heroInfo.gid or heroInfo.monsterID and heroInfo.monsterID == actor.monsterID then
				has = true
				self.actors[entityId] = actor

				actor:onReuse(entityId, heroInfo)

				oldActors[id] = nil

				break
			end
		end

		if not has then
			self.actors[entityId] = PerformActor(self.nowEntityId, "", self, heroInfo)
			self.nowEntityId = self.nowEntityId + 1
		end

		if heroInfo.camp == BattleConst.CAMP_PLAYER then
			table.insert(playerList, entityId)
		else
			table.insert(monsterList, entityId)
		end
	end

	for id, actor in pairs(oldActors) do
		actor:destroy()
	end

	local playerIdx = math.random(1, #playerList)
	local monsterIdx = math.random(1, #monsterList)

	self.cuePlayerEntityId = playerList[playerIdx]
	self.cueMonsterEntityId = monsterList[monsterIdx]
	self.waitForModel = true

	self:onOneModelLoaded()
end

function PerformActorMgr:onOneModelLoaded()
	if not self.waitForModel then
		return
	end

	for id, actor in pairs(self.actors) do
		if not actor:isModelLoaded() then
			return
		end
	end

	self.waitForModel = false

	if self.hookData and (not self.hookData.start_node or not self.hookData.battle_node) and self.hookData.timeline_heros then
		self:_initTimeLineActor(self.hookData.timeline_heros, self.hookData.timeline_skins)
	end

	self:_realSetActorsMute()
	self.performManager.onAllModelLoaded()
end

function PerformActorMgr:actorSkinValid(heroId, skinId, skinsList)
	if not skinId or skinId == 0 or not skinsList or #skinsList == 0 then
		return true
	end

	local longSkinId = heroId .. "_" .. skinId

	for _, validSkin in ipairs(skinsList) do
		if validSkin == longSkinId then
			return true
		end
	end

	return false
end

local NODE_SPEC_NUM = 5

function PerformActorMgr:_initTimeLineActor(heros, skins)
	self:giveBackTimeLineModel()

	local enableHeros = {}

	for _, heroID in ipairs(heros) do
		for id, actor in pairs(self.actors) do
			if actor.heroID == heroID and self:actorSkinValid(actor.heroID, actor.heroObj.skin, skins) then
				table.insert(enableHeros, heroID)

				break
			end
		end
	end

	local needHeroId

	if #enableHeros > 0 then
		local r = math.random(1, #enableHeros)

		needHeroId = enableHeros[r]
	end

	local nodeNum = 1

	for id, actor in pairs(self.actors) do
		if actor.camp == BattleConst.CAMP_PLAYER then
			local replaceNode = nodeNum

			if actor.heroID == needHeroId then
				replaceNode = NODE_SPEC_NUM
			else
				nodeNum = nodeNum + 1
			end

			local node = UnityEngine.GameObject.Find("Anchor0" .. replaceNode)

			if node then
				local go = actor.entityModel.modelGameObject

				go.transform.parent = node.transform
				go.transform.localPosition = Vector3.zero
				go.transform.localEulerAngles = Vector3.zero

				table.insert(self.timeLineModel, {
					actor.entityModel,
					actor
				})

				if replaceNode == NODE_SPEC_NUM then
					actor.entityModel:changeModelByCommonModelId(actor.commonModelId, Const.MODEL_TYPE.PerformAct, nil, Const.MODEL_LOD_LV1, nil, true)
				end
			end
		end
	end
end

function PerformActorMgr:giveBackTimeLineModel()
	if self.timeLineModel then
		for _, backInfo in ipairs(self.timeLineModel) do
			local entityModel = backInfo[1]
			local actor = backInfo[2]

			if entityModel.modelGameObject and not tolua.isnull(entityModel.modelGameObject) then
				actor.controller:InitModelAfterLoaded(entityModel.modelGameObject)
				entityModel:changeModelByCommonModelId(actor.commonModelId, Const.MODEL_TYPE.Default, nil, Const.MODEL_LOD_LV1, nil, true)
			end
		end
	end

	self.timeLineModel = {}
end

function PerformActorMgr:clear()
	self:giveBackTimeLineModel()

	if self.matrixInstance then
		self:stopBattle()
	end

	for id, actor in pairs(self.actors) do
		actor:destroy()
	end

	self.actors = {}
	self.waitForModel = false
end

function PerformActorMgr:actorSetPosition(startNode, endNode)
	local startCenter = utils.getNodePosition(startNode)
	local endCenter = utils.getNodePosition(endNode)

	if startCenter and endCenter then
		local dir = endCenter - startCenter

		dir:SetNormalize()

		self.leftDir = dir
		self.upDir = Vector3(-dir.z, 0, dir.x)

		local lrSub = BattleConst.GRID_SIZE * (BattleConst.LR_LEN - 1) / 2
		local udSub = BattleConst.GRID_SIZE * 0.866 * (BattleConst.UD_LEN - 1) / 2

		self.gridUpDir = self.upDir * 0.866 * BattleConst.GRID_SIZE
		self.gridLeftDir = self.leftDir * BattleConst.GRID_SIZE
		self.oriPosition = endCenter - self.leftDir * lrSub - self.upDir * udSub

		for id, actor in pairs(self.actors) do
			actor.entityModel:showModel(true)
			actor:lookatGrid()

			if actor.camp == BattleConst.CAMP_PLAYER then
				local startPos = utils.getPositionByBattlePos(dir, startCenter, actor.pos, actor.camp)

				actor:teleport(startPos.x, startPos.y, startPos.z)
			else
				local endPos = utils.getPositionByBattlePos(dir, endCenter, actor.pos, actor.camp)

				actor:teleport(endPos.x, endPos.y, endPos.z)
			end
		end
	end
end

function PerformActorMgr:runToBattle(startNode, endNode)
	local runTime = 0
	local startCenter = utils.getNodePosition(startNode)
	local endCenter = utils.getNodePosition(endNode)

	if startCenter and endCenter then
		local dir = endCenter - startCenter
		local len = dir:Magnitude()

		runTime = len / BattleConst.ACTOR_SPEED

		dir:SetNormalize()

		for id, actor in pairs(self.actors) do
			if actor.camp == BattleConst.CAMP_PLAYER then
				local startPos = utils.getPositionByBattlePos(dir, startCenter, actor.pos, actor.camp)
				local endPos = utils.getPositionByBattlePos(dir, endCenter, actor.pos, actor.camp)

				actor:autoRunTo(startPos, endPos)
			end
		end
	end

	return runTime
end

function PerformActorMgr:runToEnd(endNode)
	local endCenter = utils.getNodePosition(endNode)

	if endCenter then
		for id, actor in pairs(self.actors) do
			if actor.camp == BattleConst.CAMP_PLAYER then
				local endPos = utils.getPositionByBattlePos(self.leftDir, endCenter, actor.pos, actor.camp)

				actor:runToEnd(endPos)
			end
		end
	end
end

local listenerFuncConfig = {
	onPlayAtkCue = BattleConst.MATRIX_EVENT_ENTITY_PLAYATKCUE,
	onPlayHitCue = BattleConst.MATRIX_EVENT_ENTITY_PLAYHITCUE
}

function PerformActorMgr:startBattle(matrixInstance)
	self.matrixInstance = matrixInstance

	EventCenter.addEventListenerGroup(self, listenerFuncConfig)

	for _, actor in pairs(self.actors) do
		actor:startBattle()
	end
end

function PerformActorMgr:getPosition(orderX, orderY)
	return self.gridLeftDir * orderX + self.oriPosition + self.gridUpDir * orderY
end

function PerformActorMgr:getOutPosition(camp)
	local gridConfig = self.matrixInstance.bObjMgr.GridConfig
	local outPosX = gridConfig.CHUYIN_POS[1]
	local outPosY = gridConfig.CHUYIN_POS[2]

	if camp ~= BattleConst.CAMP_PLAYER then
		outPosX = BattleConst.LR_LEN - 1 - outPosX
	end

	local pos = self:getPosition(outPosX, outPosY)

	if gridConfig.CHUYIN_POS[3] then
		pos.y = pos.y + gridConfig.CHUYIN_POS[3]
	end

	return pos
end

function PerformActorMgr:stopBattle()
	self.matrixInstance = nil

	EventCenter.removeEventListenerGroup(self, listenerFuncConfig)
end

function PerformActorMgr:inLeft(attackId, targetId)
	local attacker = self.matrixInstance:getObjectByKey(attackId)
	local target = self.matrixInstance:getObjectByKey(targetId)

	if attacker and target then
		return attacker.coordX > target.coordX
	end
end

function PerformActorMgr:getAllActor()
	return self.actors
end

function PerformActorMgr:getActor(actorId)
	if self.actors then
		return self.actors[actorId]
	end
end

function PerformActorMgr:getActorGameObject(actorId)
	local actor = self.actors[actorId]

	if actor then
		local obj = actor.gameObject

		if obj and not tolua.isnull(obj) then
			return obj
		end
	end
end

function PerformActorMgr:onPlayHitCue(attackerId, targetId, hitCue)
	local attacker = self.actors[attackerId]
	local fashionTag

	if attacker then
		fashionTag = attacker.fashionTag
	end

	local target = self.actors[targetId]

	if hitCue then
		self:_playCueList(targetId, target, hitCue, attackerId, fashionTag)
	end
end

function PerformActorMgr:onPlayAtkCue(attackerId, baseId, atkCue, baseCue)
	local attacker = self.actors[attackerId]
	local fashionTag

	if attacker then
		fashionTag = attacker.fashionTag
	end

	local target = self.actors[baseId]

	if atkCue then
		self:_playCueList(attackerId, attacker, atkCue, nil, fashionTag)
	end

	if baseCue then
		self:_playCueList(baseId, target, baseCue, attackerId, fashionTag)
	end
end

function PerformActorMgr:_playCueList(cueTargetId, cueTarget, cueData, attackerId, fashionTag)
	local cues = cueData.cueList

	attackerId = attackerId or cueTargetId

	if not cueTarget then
		return
	end

	for i, cueId in ipairs(cues) do
		self:tryPlayCue(cueTargetId, cueTarget, cueId, attackerId, fashionTag)
	end
end

function PerformActorMgr:tryPlayCue(targetId, target, cueId, attackerId, fashionTag)
	if CueManager.cueIsAudio(cueId) then
		if self.actorsMute then
			return
		end

		if attackerId ~= self.cuePlayerEntityId and attackerId ~= self.cueMonsterEntityId then
			return
		end
	end

	if CueManager.shouldPlayCue(cueId, false, true) then
		target:PlayCue(cueId, self.actors[attackerId], fashionTag)
	end
end

function PerformActorMgr:onPause()
	self.prePauseState = {}

	for _, actor in pairs(self.actors) do
		self.prePauseState[actor.id] = actor.inPause

		if not actor.inPause then
			actor:PauseOn()
		end
	end

	CueManager.pauseTimerCue()
	Framework.CameraSystem.CameraManager.PauseCameraAnimator(1)
end

function PerformActorMgr:onResume()
	for _, actor in pairs(self.actors) do
		if not self.prePauseState[actor.id] then
			actor:PauseOff()
		end
	end

	CueManager.resumeTimerCue()
	Framework.CameraSystem.CameraManager.PauseCameraAnimator(0)
end

function PerformActorMgr:onBattleOver()
	for _, actor in pairs(self.actors) do
		actor:onBattleOver()
	end
end

function PerformActorMgr:onDeadEffect()
	local monsters = {}

	for _, actor in pairs(self.actors) do
		if actor.camp ~= BattleConst.CAMP_PLAYER then
			actor:onDeadEffect()
			table.insert(monsters, actor)
		end
	end

	local effType = math.random(4)

	if effType == 2 or effType == 4 then
		local aIndex = math.random(#monsters)

		monsters[aIndex]:onSpecDeadEffect("Effects/Heros/Common/efx_common_death02.prefab")
	end

	if effType == 3 or effType == 4 then
		local aIndex = math.random(#monsters)

		monsters[aIndex]:onSpecDeadEffect("Effects/Heros/Common/efx_common_death03.prefab")
	end
end

function PerformActorMgr:onDeadHide()
	for _, actor in pairs(self.actors) do
		if actor.camp ~= BattleConst.CAMP_PLAYER then
			actor:onDeadHide()
		end
	end
end

function PerformActorMgr:onMoneyEffect()
	for _, actor in pairs(self.actors) do
		if actor.camp ~= BattleConst.CAMP_PLAYER then
			actor:onMoneyEffect()
		end
	end

	local ui = UIManager.getUI("mainStageDlg", nil, false)

	if ui then
		ui:playGetAnim()
	end
end

function PerformActorMgr:setActorsMute(isMute)
	self.actorsMute = isMute

	self:_realSetActorsMute()
end

function PerformActorMgr:_realSetActorsMute()
	if self.actorsMute then
		for id, actor in pairs(self.actors) do
			if actor:isModelLoaded() then
				actor:setMute(true, true)
			end
		end
	else
		for id, actor in pairs(self.actors) do
			if actor:isModelLoaded() then
				if id == self.cuePlayerEntityId or id == self.cueMonsterEntityId then
					actor:setMute(false, true)
				else
					actor:setMute(true, true)
				end
			end
		end
	end
end

return PerformActorMgr
