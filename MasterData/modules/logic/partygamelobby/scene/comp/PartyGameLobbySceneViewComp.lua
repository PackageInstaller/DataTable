-- chunkname: @modules/logic/partygamelobby/scene/comp/PartyGameLobbySceneViewComp.lua

module("modules.logic.partygamelobby.scene.comp.PartyGameLobbySceneViewComp", package.seeall)

local PartyGameLobbySceneViewComp = class("PartyGameLobbySceneViewComp", BaseSceneComp)

function PartyGameLobbySceneViewComp:onScenePrepared(sceneId, levelId)
	if isDebugBuild then
		PartyGame_GM.SetPlayerNum(0)
	end

	if levelId == PartyGameLobbyEnum.SceneLevelId.Lobby then
		ViewMgr.instance:openView(ViewName.PartyGameLobbyMainView)
	elseif levelId == PartyGameLobbyEnum.SceneLevelId.Dress then
		ViewMgr.instance:openView(ViewName.PartyClothView)
	elseif levelId == PartyGameLobbyEnum.SceneLevelId.Lottery then
		ViewMgr.instance:openView(ViewName.PartyClothLotteryView)
	end
end

function PartyGameLobbySceneViewComp:onSceneClose(sceneId, levelId)
	ViewMgr.instance:closeView(ViewName.PartyGameLobbyMainView)
end

return PartyGameLobbySceneViewComp
