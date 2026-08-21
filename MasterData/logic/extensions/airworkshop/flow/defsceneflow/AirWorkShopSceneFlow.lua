-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/airworkshop/flow/defsceneflow/AirWorkShopSceneFlow.lua

module("logic.extensions.airworkshop.flow.defsceneflow.AirWorkShopSceneFlow", package.seeall)

local M = class("AirWorkShopSceneFlow", DefaultSceneFlow)

function M:createEnterSceneWork(info)
	local work = self:_createWork()

	work:setDoneCaller(self._onEnterFinish, self)

	local sequence = FlowSequence.New()

	sequence:addChild(WorkLoadScene.New())
	sequence:addChild(WorkFuncCaller.New(self._onSceneLoadDone, self))
	work:addChild(sequence)

	return work
end

return M
