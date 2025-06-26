-- chunkname: @IQIGame\\Module\\SceneTransfer\\ReturnLoginTransfer.lua

local SceneTransferController = require("IQIGame/Module/SceneTransfer/SceneTransferController")
local Transfer = Clone(SceneTransferController)

function Transfer:__OnPrepare()
	UIModule.Close(Constant.UIControllerName.GlobalNoticeUI)
	self:__CommonPrepare()
end

function Transfer:__UnloadScene()
	if SceneTransferModule.CurScene == SceneTransferModule.SceneName.MainCity then
		MainCityModule.Shutdown()
	elseif SceneTransferModule.CurScene == SceneTransferModule.SceneName.Battle then
		BattleModule.Dispose()
	elseif SceneTransferModule.CurScene == SceneTransferModule.SceneName.StoryBattle then
		BattleModule.Dispose()
		StoryModule.Dispose()
	elseif SceneTransferModule.CurScene == SceneTransferModule.SceneName.Story then
		StoryModule.Dispose()
	elseif SceneTransferModule.CurScene == SceneTransferModule.SceneName.Maze then
		-- block empty
	elseif SceneTransferModule.CurScene == SceneTransferModule.SceneName.MazeBattle then
		-- block empty
	elseif SceneTransferModule.CurScene == SceneTransferModule.SceneName.Home then
		HomeModule.ExitHomeScene()
	end

	self:__CommonUnloadScene()
end

function Transfer:__LoadScene()
	function self.__delegateLoadSceneCallback(sender, event)
		self:__OnLoadSceneCallback(sender, event)
	end

	LoginModule.NeedReconnect = false

	NetCommController.Clear()
	LuaCodeInterface.ClearNetwork()
	LuaCodeInterface.StopAllCSharpTimer(false)
	LuaCodeInterface.CleanEventSystem()
	Initialization.ShutdownBase()
	GameEntry.UI:ClearUINameDictionary()
	GameEntry.LuaEvent:UnsubscribeAll()
	Initialization.InitBase()
	GameEntry.LuaEvent:Subscribe(LoadSceneExtResEndEventArgs.EventId, self.__delegateLoadSceneCallback)
	GameEntry.LuaEvent:FireNow(LoginModule, ChangeSceneEventArgs():Fill(SceneID.Login))
end

function Transfer:__OnLoadSceneCallback(sender, event)
	if event.SceneID ~= SceneID.Login then
		return
	end

	GameEntry.LuaEvent:Unsubscribe(LoadSceneExtResEndEventArgs.EventId, self.__delegateLoadSceneCallback)
	self:__CommonLoadScene()
end

return Transfer
