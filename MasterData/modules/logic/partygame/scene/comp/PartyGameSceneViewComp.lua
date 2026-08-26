-- chunkname: @modules/logic/partygame/scene/comp/PartyGameSceneViewComp.lua

module("modules.logic.partygame.scene.comp.PartyGameSceneViewComp", package.seeall)

local PartyGameSceneViewComp = class("PartyGameSceneViewComp", BaseSceneComp)

function PartyGameSceneViewComp:onScenePrepared(sceneId, levelId)
	local curPartyGame = PartyGameController.instance:getCurPartyGame()

	curPartyGame:onScenePrepared()
end

function PartyGameSceneViewComp:onSceneClose(sceneId, levelId)
	local curPartyGame = PartyGameController.instance:getCurPartyGame()

	if curPartyGame ~= nil then
		PartyGameController.instance:clearGame()
	end
end

return PartyGameSceneViewComp
