-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/preface/controller/PrefaceController.lua

module("logic.extensions.preface.controller.PrefaceController", package.seeall)

local M = class("PrefaceController", BaseController)

function M:ctor()
	M.super.ctor(self)
end

function M:onReset()
	if self._prefaceBattleWF then
		self._prefaceBattleWF:clearWork()

		self._prefaceBattleWF = nil
	end
end

function M:startPreface()
	local info = {}

	if self._prefaceBattleWF == nil then
		self._prefaceBattleWF = PrefaceFlow.New()

		self._prefaceBattleWF:enter(info)
	end
end

function M:simulationCloseSystem()
	if self._prefaceBattleWF then
		self._prefaceBattleWF:simulationCloseSystem()
	end
end

function M:exitDungeonSceneFlow(isEnterRoomScene)
	local sceneFlow = SceneFace.instance:getCurSceneFlow()

	if sceneFlow then
		sceneFlow.model.isEnterRoomScene = isEnterRoomScene

		SceneFace.instance:exitScene()

		local type = DungeonModel.instance:getNeedEnterSceneType()

		if type == SceneType.Room then
			SceneFace.instance:enterRoomScene(nil, nil)
		end

		DungeonModel.instance:setNeedEnterSceneType()
	end
end

function M:getPrefaceBattleFlow()
	return self._prefaceBattleWF
end

function M:getIsInPrefaceBattleFlow()
	return self._prefaceBattleWF ~= nil
end

function M:clearPrefaceBattleFlow()
	self._prefaceBattleWF = nil
end

M.instance = M.New()

return M
