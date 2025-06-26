-- chunkname: @IQIGame\\Module\\SceneTransfer\\BattleToStoryTransfer.lua

local SceneTransferController = require("IQIGame/Module/SceneTransfer/SceneTransferController")
local Transfer = Clone(SceneTransferController)

function Transfer:__OnPrepare()
	BehaviorTreeUtility.PlayBlackInkScreenEffect(1, 0)
	SceneTransferModule.SetMainCameraType(self.cameraStackType)
	self:__ChangeState(self.State.UnloadScene)
end

function Transfer:__UnloadScene()
	BattleModule.Dispose()
	self:__AddDelayFrameCall(5, function()
		GameEntry.Entity:ReleaseEntities()
	end, nil)
	self:__AddDelayFrameCall(10, function()
		GameEntry.Resource:ForceUnloadUnusedAssets(true)
	end, nil)
	self:__AddDelayFrameCall(15, function(_args)
		self:__ChangeState(self.State.LoadScene)
	end)
end

function Transfer:__LoadScene()
	if StoryModule.onExitFight then
		StoryModule.onExitFight()
	end

	StoryModule.isStoryUIInitOver = false

	BehaviorTreeUtility.ShowStoryUI(true)

	local function fightOverFunc()
		self:FightOver()
	end

	self:__AddConditionCall(function()
		return StoryModule.isStoryUIInitOver
	end, nil, fightOverFunc, nil)
end

function Transfer:__Exit()
	if self.completeCall == nil then
		return
	end

	self.completeCall(self.completeCallArgs)
end

function Transfer:FightOver()
	if StoryModule.fightOverCallback then
		StoryModule.fightOverCallback(self.Args.FightOverPOD.fightResult == Constant.FightResult.ATTACKER_WIN)

		StoryModule.fightOverCallback = nil
	end

	if self.Args.FightOverPOD.fightResult ~= Constant.FightResult.ATTACKER_WIN then
		BehaviorTreeUtility.PlayBlackInkScreenEffect(2, 0)
	end

	self:__CommonLoadScene()
	EventDispatcher.DispatchSingleEvent(EventID.OnNormalFightInStoryOverEvent)
end

return Transfer
