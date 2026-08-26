-- chunkname: @modules/logic/partygame/scene/PartyGameScene.lua

module("modules.logic.partygame.scene.PartyGameScene", package.seeall)

local PartyGameScene = class("PartyGameScene", BaseScene)

function PartyGameScene:_createAllComps()
	self:_addComp("level", PartyGameSceneLevelComp)
	self:_addComp("director", PartyGameSceneDirector)
	self:_addComp("view", PartyGameSceneViewComp)
	self:_addComp("camera", PartyGameSceneCameraComp)
	self:_addComp("bgm", PartyGameSceneBGMComp)
	self:_addComp("graphics", PartyGameSceneGraphicsComp)
end

function PartyGameScene:onStart(...)
	local preSceneType = GameSceneMgr.instance:getPreSceneType()

	if preSceneType ~= SceneType.PartyGame then
		PartyGame_GM.ClearGameIds()
	end

	local game = PartyGameController.instance:getCurPartyGame()

	if game then
		PartyGame_GM.AddGameId(game:getGameId())
	end

	PartyGameScene.super.onStart(self, ...)
end

function PartyGameScene:onClose()
	local nextSceneType = GameSceneMgr.instance:getNextSceneType()

	if nextSceneType ~= SceneType.PartyGame then
		local curGame = PartyGameController.instance:getCurPartyGame()

		if curGame and not curGame:getIsLocal() then
			PartyGameController.instance:KcpEndConnect()
		end

		PopupController.instance:clear()
		PartyGameController.instance:clearGame()
	end

	PartyGameScene.super.onClose(self)
end

return PartyGameScene
