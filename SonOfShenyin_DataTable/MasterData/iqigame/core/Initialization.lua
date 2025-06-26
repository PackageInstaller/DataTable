-- chunkname: @IQIGame\\Core\\Initialization.lua

Initialization = {
	LastTime = 0
}

function Initialization.Init()
	math.randomseed(os.time())
	math.random()
	Initialization.InitBase()
	NetManager.Init()
	SceneTransferModule.Init()

	Initialization.UpdateFuncList = {}

	Initialization.InitUpdateFuncPerSecond()
	SettingModule.DefaultSetting()

	local timer = Timer.New(function()
		local realtimeSinceStartup = Time.realtimeSinceStartup

		for i = 1, #Initialization.UpdateFuncList do
			Initialization.UpdateFuncList[i](realtimeSinceStartup - Initialization.LastTime)
		end

		Initialization.LastTime = realtimeSinceStartup
	end, 1, -1)

	timer:Start()

	Initialization.LastTime = Time.realtimeSinceStartup

	FSMModule.Init()
end

function Initialization.ShutdownBase()
	GlobalListener.Shutdown()
	PlayerModule.Shutdown()
	NoticeModule.Shutdown()
	FSMModule.ShutDown()
	UIModule.Shutdown()
	WarlockModule.Shutdown()
	RoleDevelopmentModule.Shutdown()
	GameChapterModule.Shutdown()
	EquipModule.Shutdown()
	TaskSystemModule.Shutdown()
	RoleExtendModule.Shutdown()
	GuideModule.Shutdown()
	ShopModule.Shutdown()
	BattleModule.Dispose()
	ActivityPassModule.ShutDown()
	StoryChapterModule.Shutdown()
	OpenUIUtility.Dispose()
	ActivityModule.Shutdown()
	SkinModule.Shutdown()
	UnlockFunctionModule.Shutdown()
	PopUpModule.Shutdown()
	MonthCardModule.Shutdown()
	StoryModule.Destroy()
	HomeModule.Shutdown()
	WorldMapModule.ShutDown()
	MazeModule.Shutdown()
	AffinityModule.ShutDown()
	RedDotModule.Shutdown()
	MapModule.Shutdown()
	CenterRankModule.ShutDown()
	GlobalBuffModule.ShutDown()
	GameNoticeModule.ShutDown()
end

function Initialization.InitBase()
	CfgUtil.Init()
	GlobalListener.Init()
	PlayerModule.Init()
	NoticeModule.Init()
	UIModule.Initialize()
	WarlockModule.Initialize()
	RoleDevelopmentModule.Initialize()
	GameChapterModule.Initialize()
	EquipModule.Initialize()
	ObjectPoolManager:ctor()
	TaskSystemModule.Initialize()
	RoleExtendModule.Initialize()
	ShopModule.Initialize()
	FormatRoleModule.Initialize()
	CombatFormationModel.Initialize()
	AssistInFightingModule.Initialize()
	SceneUtility.Init()
	EntityUtility.Init()
	OpenUIUtility.Init()
	RedDotModule.Initialize()
	SkinModule.Initialize()
	GMOrder2Module.Init()
	ActivityPassModule.Initialize()
	AchievementModule.Initialize()
	PopUpModule.Initialize()
	StoryChapterModule.Init()
	UnlockFunctionModule.Initialize()
	MapModule.Initialize()
	StoryModule.Initialize()
	CommonScreenModule.Initialize()
	HomeModule.Initialize()
	WorldMapModule.Initialize()
	ConversationModule.Init()
	AffinityModule.Initialize()
	CenterRankModule.Initialize()
	GlobalBuffModule.Initialize()
	GameNoticeModule.Initialize()
end

function Initialization.InitUpdateFuncPerSecond()
	return
end

function Initialization.OnApplicationPause(isPause)
	return
end

function Initialization.AddUpdateFunc(func)
	if type(func) ~= "function" then
		return
	end

	table.insert(Initialization.UpdateFuncList, func)
end

function Initialization.OnApplicationFocus(isActive)
	return
end
