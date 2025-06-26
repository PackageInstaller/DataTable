-- chunkname: @IQIGame\\Module\\Login\\ProcedureReset.lua

ProcedureReset = {}

function ProcedureReset.ResetAndGoToLogin()
	LoginModule.NeedReconnect = false

	NetCommController.Clear()
	LuaCodeInterface.ClearNetwork()
	LuaCodeInterface.StopAllCSharpTimer(false)
	LuaCodeInterface.CleanEventSystem()
	GameEntry.LuaEvent:FireNow(LoginModule, ChangeSceneEventArgs():Fill(SceneID.Login))
	Initialization.ShutdownBase()
	GameEntry.UI:ClearUINameDictionary()
	GameEntry.LuaEvent:UnsubscribeAll()
	Initialization.InitBase()
end
