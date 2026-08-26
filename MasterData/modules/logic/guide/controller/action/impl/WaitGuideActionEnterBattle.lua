-- chunkname: @modules/logic/guide/controller/action/impl/WaitGuideActionEnterBattle.lua

module("modules.logic.guide.controller.action.impl.WaitGuideActionEnterBattle", package.seeall)

local WaitGuideActionEnterBattle = class("WaitGuideActionEnterBattle", BaseGuideAction)

function WaitGuideActionEnterBattle:onStart(context)
	WaitGuideActionEnterBattle.super.onStart(self, context)

	self._battleId = tonumber(self.actionParam)

	GameSceneMgr.instance:registerCallback(SceneEventName.EnterSceneFinish, self._checkInBattle, self)
	self:_checkInBattle(GameSceneMgr.instance:getCurSceneType(), nil)
end

function WaitGuideActionEnterBattle:_checkInBattle(sceneType, sceneId)
	if sceneType == SceneType.Fight then
		local fightParam = FightModel.instance:getFightParam()

		if self._battleId and self._battleId == fightParam.battleId then
			GameSceneMgr.instance:unregisterCallback(SceneEventName.EnterSceneFinish, self._checkInBattle, self)
			self:onDone(true)
		end
	end
end

function WaitGuideActionEnterBattle:clearWork()
	GameSceneMgr.instance:unregisterCallback(SceneEventName.EnterSceneFinish, self._checkInBattle, self)
end

return WaitGuideActionEnterBattle
