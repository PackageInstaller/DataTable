-- chunkname: @IQIGame\\Core\\Initialization.lua

Initialization = {
	LastTime = 0
}

function Initialization.Init()
	math.randomseed(os.time())
	math.random()
	Initialization.InitBase()
	NetManager.Init()
	SettingModule.DefaultSetting()

	Initialization.UpdateFuncList = {}

	Initialization.InitUpdateFuncPerSecond()
	LuaCodeInterface.InitOpenUrl()

	local timer = Timer.New(function()
		local realtimeSinceStartup = Time.realtimeSinceStartup

		for i = 1, #Initialization.UpdateFuncList do
			Initialization.UpdateFuncList[i](realtimeSinceStartup - Initialization.LastTime)
		end

		Initialization.LastTime = realtimeSinceStartup
	end, 1, -1)

	timer:Start()

	Initialization.LastTime = Time.realtimeSinceStartup

	xpcall(function()
		if GameEntry.ProjectSetting.SubmitMode then
			CfgDiscreteDataTable[6520061].Data[1] = 1
		end
	end, function(msg)
		return
	end)
end

function Initialization.ShutdownBase()
	GlobalListener.Shutdown()
	PlayerModule.Shutdown()
	NoticeModule.Shutdown()
	MainTipsModule.Shutdown()
	UIModule.Shutdown()
	SoulModule.Shutdown()
	TownAreaModule.Shutdown()
	MemorySModule.Shutdown()
	ChallengeModule.Shutdown()
	JumpModule.Shutdown()
end

function Initialization.InitBase()
	GlobalListener.Init()
	PlayerModule.Init()
	NoticeModule.Init()
	MainTipsModule.Init()
	UIModule.Initialize()
	SoulModule.Initialize()
	TownAreaModule.Initialize()
	MemorySModule.Initialize()
	ChallengeModule.Initialize()
	JumpModule.Initialize()
end

function Initialization.InitUpdateFuncPerSecond()
	table.insert(Initialization.UpdateFuncList, PlayerModule.Update)
	table.insert(Initialization.UpdateFuncList, MazeModule.Update)
end
