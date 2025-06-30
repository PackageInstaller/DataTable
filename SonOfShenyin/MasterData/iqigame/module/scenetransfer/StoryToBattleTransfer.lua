-- chunkname: @IQIGame\\Module\\SceneTransfer\\StoryToBattleTransfer.lua

local SceneTransferController = require("IQIGame/Module/SceneTransfer/SceneTransferController")
local Transfer = Clone(SceneTransferController)

function Transfer:__OnPrepare()
	UIModule.CloseAllUIFrom()
	BattleModule.SetBattleSceneIsReady(false)

	local function callback()
		SceneTransferModule.SetMainCameraType(self.cameraStackType)
		self:__ChangeState(self.State.UnloadScene)
	end

	self:__OpenLoadingNormalUI(callback, nil)
end

function Transfer:__UnloadScene()
	UIModule.Close(Constant.UIControllerName.FormationUI)
	StoryModule.onEnterFight()
	self:__ChangeState(self.State.LoadScene)
end

function Transfer:__LoadScene()
	BattleModule.SetBattleSceneIsReady(true)
	BattleModule.RequestStartBattle(self.Args.IsLocalFight, self.Args.FightPOD, self.Args.UserData)

	local function condition()
		return BattleModule.isInitBattleComplete
	end

	local function callback()
		self:__ChangeState(self.State.Exit)
	end

	self:__AddConditionCall(condition, nil, callback, nil)
end

function Transfer:__Exit()
	UIModule.Close(Constant.UIControllerName.LoadingNormalUI)

	if self.completeCall == nil then
		return
	end

	self.completeCall(self.completeCallArgs)
end

return Transfer
