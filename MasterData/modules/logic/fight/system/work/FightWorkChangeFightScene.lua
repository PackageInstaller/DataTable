-- chunkname: @modules/logic/fight/system/work/FightWorkChangeFightScene.lua

module("modules.logic.fight.system.work.FightWorkChangeFightScene", package.seeall)

local FightWorkChangeFightScene = class("FightWorkChangeFightScene", FightWorkItem)

function FightWorkChangeFightScene:onConstructor(episodeId, battleId, sceneId, levelId)
	self.episodeId = episodeId
	self.battleId = battleId

	local sceneIds, levelIds = FightHelper.buildSceneAndLevel(episodeId, battleId)

	if sceneIds and levelIds then
		self.sceneId = sceneIds[1]
		self.levelId = levelIds[1]
	end

	self.SAFETIME = 30
end

function FightWorkChangeFightScene:onStart()
	self:_startLoadLevel()
end

function FightWorkChangeFightScene:_startLoadLevel()
	self:com_registFightEvent(FightEvent.OnSceneLevelLoaded, self._onLevelLoaded)
	FightGameMgr.sceneLevelMgr:loadScene(self.sceneId, self.levelId)
end

function FightWorkChangeFightScene:_onLevelLoaded()
	GameSceneMgr.instance:getCurScene().camera:setSceneCameraOffset()
	self:onDone(true)
end

return FightWorkChangeFightScene
