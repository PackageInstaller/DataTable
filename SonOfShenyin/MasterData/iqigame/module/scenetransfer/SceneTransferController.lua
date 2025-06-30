-- chunkname: @IQIGame\\Module\\SceneTransfer\\SceneTransferController.lua

local FrameCall = {
	IsComplete = false
}

function FrameCall:__Init(action, args)
	self.Action = action
	self.Args = args
end

function FrameCall:Update()
	if self.IsComplete then
		return
	end

	self:__Update()
end

function FrameCall:__Update()
	return
end

function FrameCall:__Execute()
	self.IsComplete = true

	self.Action(self.Args)
end

local DelayFrameCall = Clone(FrameCall)

DelayFrameCall.delayFrame = 0

function DelayFrameCall.New(delay, action, args)
	local obj = Clone(DelayFrameCall)

	obj:Init(delay, action, args)

	return obj
end

function DelayFrameCall:Init(delay, action, args)
	self.delayFrame = delay

	self:__Init(action, args)
end

function DelayFrameCall:__Update()
	self.delayFrame = self.delayFrame - 1

	if self.delayFrame > 0 then
		return
	end

	self:__Execute()
end

local ConditionFrameCall = Clone(FrameCall)

ConditionFrameCall.conditionAction = nil
ConditionFrameCall.conditionArgs = nil

function ConditionFrameCall.New(condition, conditionArgs, action, args)
	local obj = Clone(ConditionFrameCall)

	obj:Init(condition, conditionArgs, action, args)

	return obj
end

function ConditionFrameCall:Init(condition, conditionArgs, action, args)
	self.conditionAction = condition
	self.conditionArgs = conditionArgs

	self:__Init(action, args)
end

function ConditionFrameCall:__Update()
	local checkResult = self.conditionAction(self.conditionArgs)

	if not checkResult then
		return
	end

	self:__Execute()
end

local m = {
	cameraStackType = 1
}

m.State = {
	Exit = 4,
	LoadScene = 3,
	Idle = 0,
	UnloadScene = 2,
	Prepare = 1
}

function m.New(class, cameraStackType)
	local controller = Clone(class)

	controller:__Init(cameraStackType)

	return controller
end

function m:Update(deltaFrame)
	if self.CurState == self.State.Idle then
		return
	end

	ForArrayTable(self.CustomCall, function(_, _frameCall)
		_frameCall:Update()
	end)
	ForArrayTable(self.CustomCall, function(_index, _frameCall)
		if not _frameCall.IsComplete then
			return
		end

		table.remove(self.CustomCall, _index)
	end, true)
end

function m:Execute(args, callback, callbackArgs)
	self.Args = args
	self.completeCall = callback
	self.completeCallArgs = callbackArgs

	self:__ChangeState(self.State.Prepare)
end

function m:__Init(cameraStackType)
	self.CustomCall = {}
	self.CurState = self.State.Idle
	self.cameraStackType = cameraStackType
end

function m:__AddDelayFrameCall(delayFrame, action, args)
	local delayFrameCall = DelayFrameCall.New(delayFrame, action, args)

	table.insert(self.CustomCall, delayFrameCall)
end

function m:__AddConditionCall(condition, conditionArgs, callback, callbackArgs)
	local conditionCall = ConditionFrameCall.New(condition, conditionArgs, callback, callbackArgs)

	table.insert(self.CustomCall, conditionCall)
end

function m:__OnPrepare()
	self:__CommonPrepare()
end

function m:__CommonPrepare()
	local function callback()
		SceneTransferModule.SetMainCameraType(self.cameraStackType)
		self:__ModifyUISystemSettingValue()
		self:__ChangeState(self.State.UnloadScene)
	end

	self:__OpenLoadingNormalUI(callback, nil)
end

function m:__OpenLoadingNormalUI(callback, args)
	local function conditionFunc()
		return UIModule.IsUIFormVisible(Constant.UIControllerName.LoadingNormalUI)
	end

	self:__AddConditionCall(conditionFunc, nil, callback, args)
	UIModule.Open(Constant.UIControllerName.LoadingNormalUI, Constant.UILayer.Top, {
		sceneID = -1
	})
end

function m:__ModifyUISystemSettingValue()
	self.uiInstanceExpireTime = GameEntry.UI.InstanceExpireTime
	self.uiInstanceAutoReleaseInterval = GameEntry.UI.InstanceAutoReleaseInterval
	GameEntry.UI.InstanceExpireTime = 0
	GameEntry.UI.InstanceAutoReleaseInterval = 0
end

function m:__RevertUISystemSettingValue()
	GameEntry.UI.InstanceExpireTime = self.uiInstanceExpireTime
	GameEntry.UI.InstanceAutoReleaseInterval = self.uiInstanceAutoReleaseInterval
end

function m:__DeepCleaningLastScene(callback, args)
	UIModule.CloseAllUIFrom({
		Constant.UIControllerName.LoadingNormalUI
	})
	GameEntry.Effect:StopAllEffect()
	GameEntry.Entity:HideAllLoadingEntities()
	GameEntry.Entity:HideAllLoadedEntities()
	GameEntry.Sound:StopAllLoadingSounds()
	GameEntry.Sound:StopAllLoadedSounds(3)
	GameEntry.Base:ResetNormalGameSpeed()
	LuaCodeInterface.OnBaseSceneStateExit()
	self:__AddDelayFrameCall(5, function()
		GameEntry.Entity:ReleaseEntities()
	end, nil)
	self:__AddDelayFrameCall(10, function()
		GameEntry.Resource:ForceUnloadUnusedAssets(true)
	end, nil)
	self:__AddDelayFrameCall(15, callback, args)
end

function m:__UnloadScene()
	self:__CommonUnloadScene()
end

function m:__CommonUnloadScene()
	local function callback(_args)
		self:__ChangeState(self.State.LoadScene)
	end

	self:__DeepCleaningLastScene(callback, nil)
end

function m:__LoadScene()
	self:__CommonLoadScene()
end

function m:__CommonLoadScene()
	self:__ChangeState(self.State.Exit)
end

function m:__Exit()
	self:__CommonExit()
end

function m:__CommonExit()
	self:__RevertUISystemSettingValue()
	UIModule.Close(Constant.UIControllerName.LoadingNormalUI)

	if self.completeCall == nil then
		return
	end

	self.completeCall(self.completeCallArgs)
end

function m:__ChangeState(state)
	self.CurState = state

	if self.CurState == self.State.Idle then
		return
	end

	if self.CurState == self.State.Prepare then
		self:__OnPrepare()
	elseif self.CurState == self.State.UnloadScene then
		self:__UnloadScene()
	elseif self.CurState == self.State.LoadScene then
		self:__LoadScene()
	elseif self.CurState == self.State.Exit then
		self:__Exit()
	end
end

return m
