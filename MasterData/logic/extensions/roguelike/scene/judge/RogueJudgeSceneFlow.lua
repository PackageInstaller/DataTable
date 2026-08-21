-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roguelike/scene/judge/RogueJudgeSceneFlow.lua

module("logic.extensions.roguelike.scene.judge.RogueJudgeSceneFlow", package.seeall)

local M = class("RogueJudgeSceneFlow", DefaultSceneFlow)

function M:_registerComponents()
	M.super._registerComponents(self)
	self:_addComponent("resMgr", RogueResourceMgr)
	self:_addComponent("viewMgr", RogueJudgeViewMgr)
end

function M:createEnterSceneWork()
	local work = self:_createWork()

	work:setDoneCaller(self._onEnterFinish, self)

	local sequence = FlowSequence.New()

	sequence:addChild(WorkShowLoading.New())
	sequence:addChild(WorkLoadScene.New())
	sequence:addChild(WorkLoadResource.New())
	sequence:addChild(WorkFuncCaller.New(self._onSceneLoadDone, self))
	sequence:addChild(WorkInterval.New(0.5))
	sequence:addChild(WorkHideLoading.New())
	work:addChild(sequence)

	return work
end

function M:createExitSceneWork()
	local work = self:_createWork()

	work:setDoneCaller(self._onExitFinish, self)

	local sequence = FlowSequence.New()

	sequence:addChild(WorkShowLoading.New())
	sequence:addChild(WorkInterval.New(0.2))
	sequence:addChild(WorkHideLoading.New())
	work:addChild(sequence)

	return work
end

return M
