-- chunkname: @modules/logic/partycloth/controller/PartyClothController.lua

module("modules.logic.partycloth.controller.PartyClothController", package.seeall)

local PartyClothController = class("PartyClothController", BaseController)

function PartyClothController:onInit()
	self:reInit()
end

function PartyClothController:reInit()
	return
end

function PartyClothController:addConstEvents()
	GameSceneMgr.instance:registerCallback(SceneEventName.EnterScene, self._onEnterScene, self)
end

function PartyClothController:_onEnterScene(sceneType)
	if sceneType == SceneType.PartyGame then
		self:tryGetPartyWearInfo()
	end
end

function PartyClothController:tryGetPartyWearInfo()
	if not PartyClothModel.instance:alreadyGetWearCloth() then
		PartyClothRpc.instance:sendGetPartyClothInfoRequest()
		PartyClothRpc.instance:sendGetPartyWearInfoRequest()
	end
end

function PartyClothController:openPartyClothView()
	local levelId = PartyGameLobbyEnum.SceneLevelId.Dress

	GameSceneMgr.instance:dispatchEvent(SceneEventName.SetLoadingTypeOnce, GameLoadingState.PartyGameLobbyLoadingView)
	GameSceneMgr.instance:startScene(SceneType.PartyGameLobby, 1, levelId, true, true)
end

function PartyClothController:openPartyClothLotteryView()
	PartyClothRpc.instance:sendGetPartyClothSummonPoolInfoRequest(self.getSummonPoolInfoReply, self)
end

function PartyClothController:getSummonPoolInfoReply(_, resultCode)
	if resultCode ~= 0 then
		return
	end

	local levelId = PartyGameLobbyEnum.SceneLevelId.Lottery

	GameSceneMgr.instance:dispatchEvent(SceneEventName.SetLoadingTypeOnce, GameLoadingState.PartyGameLobbyLoadingView)
	GameSceneMgr.instance:startScene(SceneType.PartyGameLobby, 1, levelId, true, true)
end

function PartyClothController:openSummonRewardView(materialDataMOList)
	ViewMgr.instance:openView(ViewName.PartyClothLoadingView, materialDataMOList)
end

function PartyClothController:backToLobby()
	local levelId = PartyGameLobbyEnum.SceneLevelId.Lobby

	GameSceneMgr.instance:dispatchEvent(SceneEventName.SetLoadingTypeOnce, GameLoadingState.PartyGameLobbyLoadingView)
	GameSceneMgr.instance:startScene(SceneType.PartyGameLobby, 1, levelId, true, true)
end

PartyClothController.instance = PartyClothController.New()

return PartyClothController
