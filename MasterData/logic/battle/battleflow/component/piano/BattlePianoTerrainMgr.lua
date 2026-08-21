-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/battleflow/component/piano/BattlePianoTerrainMgr.lua

module("logic.battle.battleflow.component.piano.BattlePianoTerrainMgr", package.seeall)

local BattlePianoTerrainMgr = class("BattlePianoTerrainMgr", IBattleFlowComp)
local kMonsterEffectUrl = "effect3d/prefab/skill/120100_gangqin_play/120100_gangqin_play.prefab"
local kRefreshEffectUrl = "effect3d/prefab/skill/120100_gangqin_refresh/120100_gangqin_refresh.prefab"

function BattlePianoTerrainMgr:onInit()
	self._scale2ResPath = {}
	self._scale2UnionIndexList = {}
	self._scale2Cmd = {}
	self._unionIndex2LoopEffect = {}
	self._unionIndex2StartEffect = {}
	self._monsterEffect = false
	self._refreshEffect = false
	self._totalScaleCount = 0
	self._currentScaleIndex = 0
	self._isInFinishStage = false
	self._timeWaiter = TimeWaiter.New()
	self._finishHander = Handler.New()
end

function BattlePianoTerrainMgr:onStart()
	self._boardMgr = self.flow.boardMgr or false
	self._unitMgr = self.flow.unitMgr or false
	self._cmdExecuter = self.flow.cmdExecuter or false
	self._entityId = false
	self._skillId = false
	self._sheetMusicCode = false
	self._totalScaleCount = 0
	self._currentScaleIndex = 0
	self._executingCmdCount = 0
	self._isMusicFinish = false
	self._isInFinishStage = false
end

function BattlePianoTerrainMgr:onClear()
	self._boardMgr = false
	self._unitMgr = false
	self._cmdExecuter = false

	self:_finishClear()
	self._finishHander:clear()

	self._entityId = false
	self._skillId = false
	self._sheetMusicCode = false
	self._totalScaleCount = 0
	self._currentScaleIndex = 0
	self._executingCmdCount = 0
	self._isMusicFinish = false
	self._isInFinishStage = false
end

function BattlePianoTerrainMgr:_setEvent(add)
	if add then
		GlobalDispatcher:addEventListener(EventType.CRIWARE_CALLBACK, self._onCriwareCallback, self)
	else
		GlobalDispatcher:removeEventListener(EventType.CRIWARE_CALLBACK, self._onCriwareCallback, self)
	end
end

function BattlePianoTerrainMgr:_finishClear()
	self:_setEvent(false)
	self:_clearLoopEffect()
	self:_clearStartEffect()
	self:_clearMonsterAndRefreshEffect()
	self:_clearCmd()
	self._timeWaiter:clear()
end

function BattlePianoTerrainMgr:setupMusic(entityId, skillId, sheetMusicCode, noteNOList)
	self._entityId = entityId
	self._skillId = skillId
	self._sheetMusicCode = sheetMusicCode
	self._totalScaleCount = #noteNOList

	self:_setupNotes(noteNOList)
end

function BattlePianoTerrainMgr:_setupNotes(noteNOList)
	for _, noteNO in ipairs(noteNOList) do
		local scale = noteNO.scale

		self._scale2ResPath[scale] = noteNO.specialEffectPath

		local unionIndexList = {}
		local cells = noteNO.cells

		for _, cellNO in ipairs(cells) do
			table.insert(unionIndexList, BoardIndexConverter.cellNOToUnionIndex(cellNO))
		end

		self._scale2UnionIndexList[scale] = unionIndexList
	end
end

function BattlePianoTerrainMgr:playBeginMusic(callback, callbackSelf)
	local audioName = PianoMusicConfig.instance:getAudioName(self._sheetMusicCode)
	local audioDuration = CriwareAudioPlayer.instance:getCueTotalTimeByName(audioName) + 3

	self._finishHander:setListener(callback, callbackSelf)

	self._currentScaleIndex = 0
	self._executingCmdCount = 0
	self._isInFinishStage = false
	self._isMusicFinish = false

	self._timeWaiter:clear()
	self._timeWaiter:start(audioDuration, self._onMaxWaitTimeFinish, self)
	self:_setEvent(true)
	CriwareAudioFacade.instance:playSEByName(audioName)
end

function BattlePianoTerrainMgr:setupPianoPlayingScaleCommand(scale2Cmd)
	table.merge(self._scale2Cmd, scale2Cmd)
	BattleTableUtil.clearTable(scale2Cmd)
end

function BattlePianoTerrainMgr:playFinishMusic(callback, callbackSelf)
	local audioName = PianoMusicConfig.instance:getAudioName(self._sheetMusicCode)
	local audioDuration = CriwareAudioPlayer.instance:getCueTotalTimeByName(audioName) + 3

	self._finishHander:setListener(callback, callbackSelf)

	self._currentScaleIndex = 0
	self._executingCmdCount = 0
	self._isInFinishStage = true
	self._isMusicFinish = false

	self._timeWaiter:clear()
	self._timeWaiter:start(audioDuration, self._onMaxWaitTimeFinish, self)
	self:_setEvent(true)
	CriwareAudioFacade.instance:playSEByName(audioName)
end

function BattlePianoTerrainMgr:_onCriwareCallback(_, position, eventId, playbackId, eventType, eventTag)
	self._currentScaleIndex = self._currentScaleIndex + 1

	if self._currentScaleIndex >= self._totalScaleCount then
		self._timeWaiter:clear()
		self._timeWaiter:start(2, self._onMaxWaitTimeFinish, self)
	end

	local scale = checknumber(eventId)
	local resPath = self._scale2ResPath[scale]
	local loopEffectUrl = BattleSkillAssist.getSceneCommon3dEffectUrl(resPath)
	local startEffectUrl = BattleSkillAssist.getSceneCommon3dEffectUrl(string.format("%s_1", resPath))

	self:_playMonsterEffect()

	local unionIndexList = self._scale2UnionIndexList[scale]

	for _, unionIndex in ipairs(unionIndexList) do
		self:_playScaleLoopEffect(loopEffectUrl, unionIndex)
		self:_playScaleStartEffect(startEffectUrl, unionIndex)
	end

	local cmd = self._scale2Cmd[scale]

	if cmd then
		self._scale2Cmd[scale] = nil
		self._executingCmdCount = self._executingCmdCount + 1

		self._cmdExecuter:executeCommand(cmd, self)
	end
end

function BattlePianoTerrainMgr:onCommandFinish()
	self._executingCmdCount = self._executingCmdCount - 1

	self:_tryFinishHandler()
end

function BattlePianoTerrainMgr:_playScaleLoopEffect(url, unionIndex)
	if self._unionIndex2LoopEffect[unionIndex] then
		return
	end

	local effectUnit = self:_createEffect(url, unionIndex)

	self._unionIndex2LoopEffect[unionIndex] = effectUnit
end

function BattlePianoTerrainMgr:_playScaleStartEffect(url, unionIndex)
	local effectUnit = self._unionIndex2StartEffect[unionIndex]

	if effectUnit then
		self:_replayEffect(effectUnit)

		return
	end

	effectUnit = self:_createEffect(url, unionIndex)
	self._unionIndex2StartEffect[unionIndex] = effectUnit
end

function BattlePianoTerrainMgr:_playMonsterEffect()
	local unit = self._unitMgr:getUnit(self._entityId)

	if not unit then
		if BattleLog.enableError then
			BattleLog.error("Cannot find unit", self._entityId)
		end

		return
	end

	if not self._monsterEffect then
		local unionIndex = BoardIndexConverter.coordinatesToUnionIndex(unit.transform:getCoordinates())

		self._monsterEffect = self:_createEffect(kMonsterEffectUrl, unionIndex)
	else
		self:_replayEffect(self._monsterEffect)
	end

	local x, y, z = BattleUnitUtil.getUnitCellCenterPos(unit)

	self._monsterEffect.transform:setLocalPositionXYZ(x, y, z)
end

function BattlePianoTerrainMgr:_replayEffect(effectUnit)
	goutil.setActive(effectUnit.mainGO, false)
	goutil.setActive(effectUnit.mainGO, true)
end

function BattlePianoTerrainMgr:_playRefreshEffect()
	local unit = self._unitMgr:getUnit(self._entityId)

	if not unit then
		if BattleLog.enableError then
			BattleLog.error("Cannot find unit", self._entityId)
		end

		return
	end

	if not self._refreshEffect then
		local unionIndex = BoardIndexConverter.coordinatesToUnionIndex(unit.transform:getCoordinates())

		self._refreshEffect = self:_createEffect(kRefreshEffectUrl, unionIndex)
	else
		self:_replayEffect(self._refreshEffect)
	end

	local x, y, z = BattleUnitUtil.getUnitCellCenterPos(unit)

	self._refreshEffect.transform:setLocalPositionXYZ(x, y, z)
end

function BattlePianoTerrainMgr:_createEffect(url, unionIndex)
	local x, y, z = self._boardMgr:getCellPositionXYZ(unionIndex)
	local effectUnit = EffectUnit:createInstance()

	effectUnit.loader:load(url)
	effectUnit.transform:setLocalPositionXYZ(x, y, z)
	BattleGameObjectRootUtil.addToEffectRoot(effectUnit.mainGO)

	return effectUnit
end

function BattlePianoTerrainMgr:_onMaxWaitTimeFinish()
	if self._isInFinishStage then
		self._timeWaiter:start(2, self._onRefreshEffectFinish, self)
		self:_clearLoopEffect()
		self:_clearStartEffect()
		self:_clearMonsterAndRefreshEffect()
		self:_playRefreshEffect()
	else
		self._isMusicFinish = true

		self:_tryFinishHandler()
	end
end

function BattlePianoTerrainMgr:_onRefreshEffectFinish()
	self._isMusicFinish = true

	self:_tryFinishHandler()
end

function BattlePianoTerrainMgr:_tryFinishHandler()
	if self._isMusicFinish and self._executingCmdCount <= 0 then
		self:_finishClear()
		self._finishHander:callAndClear()
	end
end

function BattlePianoTerrainMgr:_clearLoopEffect()
	for _, effect in pairs(self._unionIndex2LoopEffect) do
		EffectUtil.destroyEffect(effect)
	end

	BattleTableUtil.clearTable(self._unionIndex2LoopEffect)
end

function BattlePianoTerrainMgr:_clearStartEffect()
	for _, effect in pairs(self._unionIndex2StartEffect) do
		EffectUtil.destroyEffect(effect)
	end

	BattleTableUtil.clearTable(self._unionIndex2StartEffect)
end

function BattlePianoTerrainMgr:_clearMonsterAndRefreshEffect()
	if self._monsterEffect then
		self._monsterEffect:destroy()

		self._monsterEffect = false
	end

	if self._refreshEffect then
		self._refreshEffect:destroy()

		self._refreshEffect = false
	end
end

function BattlePianoTerrainMgr:_clearCmd()
	for _, cmd in pairs(self._scale2Cmd) do
		cmd:safeInterrupt()
	end

	BattleTableUtil.clearTable(self._scale2Cmd)
end

return BattlePianoTerrainMgr
