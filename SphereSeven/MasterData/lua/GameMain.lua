-- 全局模块
require "Global.Global"
require "CommonLogic"
-- 定义为全局模块，整个lua程序的入口类
GameMain = {};

local function Harmony()
	-- 和谐渠道处理
	if CS.UnityEngine.Application.platform == CS.UnityEngine.RuntimePlatform.IPhonePlayer then
		local suf = "HX"
		-- 图片资源和谐
		table.walk(Z_Skin, function (k, v) 
			v.CardBig = v["CardBig_"..suf] or ""
			v.CardMiddle = v["CardMiddle_"..suf] or ""
			v.FightSoulLarge = v["FightSoulLarge_"..suf] or ""
			v.FightSoulMid = v["FightSoulMid_"..suf] or ""
			v.FightSoulOriginal = v["FightSoulOriginal_"..suf] or ""
			v.BodyHalf = v["BodyHalf_"..suf] or ""
			v.CutIn = v["CutIn_"..suf] or ""
			v.CardPaint = v["CardPaint_"..suf] or ""
			v.SkinShopPaint = v["SkinShopPaint_"..suf] or ""
			v.Hide = v["Hide_"..suf] or v.Hide
			v.SsUnit = v["SsUnit_"..suf] or ""
		end)
		-- CG和谐
		local cgConfig = require("UI.UIHandBook.UIHandBookConfig")
		cgConfig.UIHandBookCG.PrefabPath = "UI/Prefabs/View/UI/HandBook/UIHandBookCG_HX.prefab"
		-- 剧情和谐
		require "UI.UIDialog.UIDialogMapping"
		DialogMapping.Scene["温泉"] = "WQ_HX"
		DialogMapping.Scene["温泉_雾气"] = "WQ_WQ_HX"
		-- 新手引导和谐
		local spriteLang = require "Config.Excel.Z_SpriteLang"
		local tab1 = spriteLang[253]
		local tab2 = spriteLang[306]
		table.walk(tab1, function (k, v)
			tab1[k] = v.."_"..suf
		end)
		table.walk(tab2, function (k, v)
			tab2[k] = v.."_"..suf
		end)
	end
end

local function TapDBInit()
	--TapDB.enableLog(true);
	--TapDB.enableAdvertiserIDCollection(true);
	print("TapDB GET START");
	local app_version = CS.GameChannel.ChannelManager.instance.appVersion or "Test"
	--local properties=helper.new_dictionary(typeof(string),)
	--Dictionary<string, object> properties = new Dictionary<string, object>();
	TapDB.onStart("fu9iayslww3qr1de", ChannelManager:GetInstance().CurrentChannel.Name, app_version);
end

-- 全局初始化
local function Initilize()
	-- init ecs --
	local entityAndComponents = {
		"Entity.Scene",
		"Framework.Scene.SceneComponent",
		
		"Module.Message.NetworkComponent",
		"Module.Message.MessageDispatcherComponent",
		"Module.Message.Session",
		"Module.Message.SessionComponent",
		"Module.Numeric.NumericComponent",
		"Module.HeartBeat.HeartBeatComponent",

		"Component.ConnectComponent",
		"Component.BgmComponent",
		"Component.SoundComponent",
		"Component.PointEffectComponent",
		"Component.MovieComponent",
		"Component.DialogComponent",

		"Entity.Player",
		"Entity.Card",
		"Entity.StoryLevelScore",
		"Entity.Team",
		"Entity.TeamDetail",
		"Entity.Equip",
		"Entity.CheatData",
		"Entity.FightSoul",
		"Entity.JadePearl",
		"Entity.Skin",
		"Entity.Item",
		"Entity.SupCard",
		"Entity.Friend.Friend",
		"Entity.SocietyRole",
		"Entity.BattleUnit",
		"Entity.Friend.AddFriend",
		"Entity.Friend.BlackList",
		"Entity.Friend.ApplyFriend",
		"Entity.Task",
		"Entity.Post",
		"Entity.Inform",
		"Entity.HintNode",
		"Entity.Affiche",
		"Entity.RecruitPool",
		"Entity.MonthCard",
		"Entity.GameEvent",
		"Entity.GameEventModule",
		"Entity.CheckInItem",
		"Entity.Arena.ArenaChallenger",
		"Entity.Arena.ArenaInfo",
		"Entity.Arena.ArenaRecord",
		"Entity.Arena.ArenaRole",
		"Entity.Pass",
		"Entity.Bossraid.Bossraid",
		"Entity.Bossraid.BossraidBattleRecord",
		"Entity.Bossraid.BossraidLeaderboardRecord",
		"Entity.BattleFormation",

		"Component.CompetitionComponent",
		"Component.PostBoxComponent",
		"Component.FriendComponent",
		"Component.RoomComponent",
		"Component.PlayerComponent",
		"Component.CardComponent",
		"Component.StoryComponent",
		"Component.TeamComponent",
		"Component.FightSoulComponent",
		"Component.EquipComponent",
		"Component.SkinComponent",
		"Component.ItemComponent",
		"Component.AgainstComponent",
		"Component.EquipAttrComponent",
		"Component.CardCharacterComponent",
		"Component.CardEquipComponent",
		"Component.CardFightSoulComponent",
		"Component.CardJadePearlComponent",
		"Component.CardConstelComponent",
		"Component.SupCardComponent",
		"Component.TaskComponent",
		"Component.MonthCardComponent",
		"Component.StarLightRebateComponent",
		"Component.GameEventComponent",
		"Component.ShopComponent",
		"Component.SevenStarComponent",
		"Component.PlayerBuffComponent",
		"Component.RecordComponent",
		"Component.GuideComponent",
		"Component.HintComponent",
		"Component.ChallengeComponent",
		"Component.AfficheComponent",
		"Component.UIEffectComponent",
		"Component.RiskComponent",
		"Component.TestInterface",
		"Component.RecruitComponent",
		"Component.ExpeditionComponent",
		"Component.CommonLevelComponent",
		"Component.CardIntimacyComponent",
		"Component.CardEncyclopediaComponent",
		"Component.CheckInComponent",
		"Component.PassComponent",
		"Component.BossraidComponent",

		"GameLogic.Battle.Entity.SsUnit",
		"GameLogic.Battle.Entity.Group",
		"GameLogic.Battle.Entity.HUDText",
		"GameLogic.Battle.Entity.Monster",
		"GameLogic.Battle.Entity.MonsterBatch",
		"GameLogic.Battle.Entity.BattleCharacter",
		
		"GameLogic.Battle.Component.SsUnitSoundComponent",
		"GameLogic.Battle.Component.SsUnitVoiceComponent",
		"GameLogic.Battle.Component.SsUnitMatrixComponent",
		"GameLogic.Battle.Component.SsUnitAnimatorComponent",
		"GameLogic.Battle.Component.AnimatorEventHandleComponent",
		"GameLogic.Battle.Component.SsUnitMoveComponent",
		"GameLogic.Battle.Component.CharacterComponent",
		"GameLogic.Battle.Component.LevelComponent",
		"GameLogic.Battle.Component.SkillComponent",
		"GameLogic.Battle.Component.BuffComponent",
		"GameLogic.Battle.Component.BattleUIComponent",
		"GameLogic.Battle.Component.SsUnitUIComponent",
		"GameLogic.Battle.Component.BattleComponent",
		"GameLogic.Battle.Component.BattleCameraComponent",
		"GameLogic.Battle.Component.SsUnitBattleComponent",
		"GameLogic.Battle.Component.MatrixComponent",
		"GameLogic.Battle.Component.SsUnitEffectComponent",
		"GameLogic.Battle.Component.PlayerBattleComponent",

		"GameLogic.Battle.Component.MonsterBatchComponent",
		"GameLogic.Battle.Component.BattleUnitComponent",
		"GameLogic.Battle.Component.BattleSsUnitUIComponent",

		"GameLogic.Battle.Component.BattleCharacterComponent",
		"GameLogic.Battle.Component.BattleFightSoulComponent",
		"GameLogic.Battle.Component.BattleEquipComponent",
		"GameLogic.Battle.Component.BattleEncyclopediaComponent",

		"GameLogic.Battle.Record.BattleUnitRecord",
	}
	for _, packageName in ipairs(entityAndComponents) do
		Game.Registry:Add(require(packageName))
	end

	if Config.MockEnabled then
		Game.Registry:Add(require("_Mock.MockSession"))
		MockManager:GetInstance()
	end

    Game.Scene = Game.Registry:NewObject("Scene")
	Game.Scene.SceneComponent = Game.Scene:AddComponent("SceneComponent")
	-- 3种组件：
	-- 1.功能性组件 => Game.Scene:AddComponent => 全局通用 退出和断线重连都不需要更新组件
	-- 2.游戏组件 => Game.Scene:AddComponent => 用于缓存登录后客户端数据 退出需要清理缓存（玩家缓存得清理），断线重连不需要（保存的本地数据不能清空了）
	-- 3.玩家组件 => Game.Scene.Player:AddComponent => 用于同步服务器数据 登录后给玩家添加 退出或断线重连都需要重新绑定组件（玩家数据同步服务器）
	-- => 功能性组件
	Game.Scene:AddComponent("NetworkComponent")
	Game.Scene:AddComponent("MessageDispatcherComponent")
	Game.Scene:AddComponent("SessionComponent")
	Game.Scene:AddComponent("ConnectComponent")
	Game.Scene:AddComponent("PlayerComponent")
	Game.Scene:AddComponent("BgmComponent")
	Game.Scene:AddComponent("SoundComponent")
	Game.Scene:AddComponent("UIEffectComponent")
	Game.Scene:AddComponent("PointEffectComponent")
	Game.Scene:AddComponent("DialogComponent")
	Game.Scene:AddComponent("TestInterface") -- 测试用
	
	-- => 游戏组件
	-- ******这里不要乱加组件******
	-- ******玩家数据组件在登出时需要在LoginScene重新绑定*****
	Game.Scene:AddComponent("CompetitionComponent") --争霸
	Game.Scene:AddComponent("GuideComponent") -- 新手引导
	Game.Scene:AddComponent("HintComponent") -- 红点
	Game.Scene:AddComponent("AgainstComponent") -- 对战
	Game.Scene:AddComponent("SupCardComponent") -- 支援
	
    -- inited ecs
	-- AudioClip
	-- RuntimeAnimatorController
	---------------------------------------------
	local messageDispatcherComponent = Game.Scene:GetComponent("MessageDispatcherComponent")
	messageDispatcherComponent:RegisterHandler(PROTOCOL.ItemUpdatePush,require("Handler.ItemUpdatePush"))
	messageDispatcherComponent:RegisterHandler(PROTOCOL.FightSoulUpdatePush,require("Handler.FightSoulUpdatePush"))
	messageDispatcherComponent:RegisterHandler(PROTOCOL.FormationUpdatePush,require("Handler.FormationUpdatePush"))
	messageDispatcherComponent:RegisterHandler(PROTOCOL.CharacterPackUpdatePush,require("Handler.CharacterUpdatePush"))
	messageDispatcherComponent:RegisterHandler(PROTOCOL.RecruitUpdatePush,require("Handler.RecruitUpdatePush"))
	messageDispatcherComponent:RegisterHandler(PROTOCOL.ShopUpdatePush,require("Handler.ShopUpdatePush"))
	messageDispatcherComponent:RegisterHandler(PROTOCOL.PaymentInfoUpdatePush,require("Handler.PaymentInfoUpdatePush"))
	messageDispatcherComponent:RegisterHandler(PROTOCOL.EquipmentPackUpdatePush,require("Handler.EquipUpdatePush"))
	messageDispatcherComponent:RegisterHandler(PROTOCOL.LevelUpdatePush,require("Handler.LevelUpdatePush"))
	messageDispatcherComponent:RegisterHandler(PROTOCOL.TaskUpdatePush,require("Handler.TaskUpdatePush"))
	messageDispatcherComponent:RegisterHandler(PROTOCOL.FriendDataUpdatePush,require("Handler.FriendUpdatePush"))
	messageDispatcherComponent:RegisterHandler(PROTOCOL.RoleInfoUpdatePush,require("Handler.RoleInfoUpdatePush"))
	messageDispatcherComponent:RegisterHandler(PROTOCOL.EncyclopediaUpdatePush,require("Handler.EncyclopediaUpdatePush"))
	messageDispatcherComponent:RegisterHandler(PROTOCOL.OtherLoginPush,require("Handler.OtherLoginPush"))
	messageDispatcherComponent:RegisterHandler(PROTOCOL.DailyRewardUpdatePush,require("Handler.DailyRewardUpdatePush"))
	messageDispatcherComponent:RegisterHandler(PROTOCOL.MonthlyCardUpdatePush,require("Handler.MonthlyCardUpdatePush"))
	messageDispatcherComponent:RegisterHandler(PROTOCOL.DailyUpdatePush,require("Handler.DailyUpdatePush"))
	messageDispatcherComponent:RegisterHandler(PROTOCOL.GameEventUpdatePush,require("Handler.GameEventUpdatePush"))
	messageDispatcherComponent:RegisterHandler(PROTOCOL.CommonCheckInUpdatePush,require("Handler.CommonCheckInUpdatePush"))
	messageDispatcherComponent:RegisterHandler(PROTOCOL.MailboxUpdatePush,require("Handler.MailboxUpdatePush"))
	messageDispatcherComponent:RegisterHandler(PROTOCOL.ArenaUpdatePush,require("Handler.ArenaUpdatePush"))
	messageDispatcherComponent:RegisterHandler(PROTOCOL.PassUpdatePush,require("Handler.PassUpdatePush"))
	messageDispatcherComponent:RegisterHandler(PROTOCOL.BossraidUpdatePush,require("Handler.BossraidUpdatePush"))
	--------------------------------------------
	Logger.Log(CS.System.Environment.Version)
	Logger.Log(CS.System.Environment.OSVersion)
	Logger.Log(CS.UnityEngine.Application.unityVersion)
	-- 多语言加载
	LangUtil.SetLangType()
	-- 和谐渠道处理
	Harmony()
	--保持手机常亮
	Screen.sleepTimeout = CS.UnityEngine.SleepTimeout.NeverSleep
	--tabpDB初始化
	-- TapDBInit()
	
	ResourcesManager:GetInstance():CoLoadAssetBundleAsync("UI/Prefabs/View/UILoading.prefab")
	-- 常用预制体常驻
	ResourcesManager:GetInstance():SetAssetBundleResident("ui/prefabs/view/uiloading.prefab", true)
	ResourcesManager:GetInstance():SetAssetBundleResident("ui/prefabs/view/ui/uiloading.prefab", true)
	ResourcesManager:GetInstance():SetAssetBundleResident("ui/prefabs/view/ui/uilobby.prefab", true)
	ResourcesManager:GetInstance():SetAssetBundleResident("UI/Prefabs/View/UI/UIComTop.prefab", true)
	ResourcesManager:GetInstance():SetAssetBundleResident("UI/Prefabs/View/UI/UITransition.prefab", true)
	ResourcesManager:GetInstance():SetAssetBundleResident("ui/effects/pointeffect.prefab", true)
	-- 小头像常驻
	ResourcesManager:GetInstance():SetAssetBundleResident("ui/atlas/cardlittle", true)
	ResourcesManager:GetInstance():SetAssetBundleResident("ui/atlas/currency", true)
	ResourcesManager:GetInstance():SetAssetBundleResident("ui/atlas/prop", true)
	-- shader常驻
	ResourcesManager:GetInstance():SetAssetBundleResident("Shaders",true)
	-- UI音效常驻
	ResourcesManager:GetInstance():SetAssetBundleResident("sound/ui", true)
	-- button动画常驻
	ResourcesManager:GetInstance():SetAssetBundleResident("ui/ani", true)
	--table.walk(LoadingBg, function (k, v)
	--	local path = "UI/LoadBg_"..LangUtil.GetLangType().."/"..v
	--	ResourcesManager:GetInstance():SetAssetBundleResident(path, true)
	--end)
	-- 字体常驻
	table.walk(FontType, function (k, v)
		ResourcesManager:GetInstance():SetAssetBundleResident("ui/fonts/"..v, true)
	end)
	--初始化敏感词过滤
	--LibStringSearch:InitWordFilter()
end
-- 进入游戏
local function EnterGame()
	-- TODO：服务器信息应该从服务器上拉取，这里读取测试数据
	--local ServerData = require "DataCenter.ServerData.ServerData"
	--local TestServerData = require "GameTest.DataTest.TestServerData"
	--local ClientData = require "DataCenter.ClientData.ClientData"
	--ServerData:GetInstance():ParseServerList(TestServerData)
	--CS.UnityEngine.QualitySettings.SetQualityLevel:SetQualityLevel(0, true)
	--CS.UnityEngine.QualitySettings.antiAliasing = 2
	--CS.UnityEngine.QualitySettings.SetQualityLevel(3, true)
	CS.UnityEngine.Application.targetFrameRate=60
	if CS.GameChannel.ChannelManager.instance.NeedDownGame then
		--大版本更新需要下载新游戏 这里弹出不同渠道的下址窗口，直接链接打开浏览器
		return
	end
	Game.Scene.SceneComponent:SwitchScene(SceneConfig.LoginScene)
	local guide=Game.Scene:GetComponent("GuideComponent")
	guide:Init()
	GameMain.SendLog()
end

--主入口函数。从这里开始lua逻辑
local function Start()
	print("GameMain start...")
	-- 初始化渠道
	ChannelManager:GetInstance():OnInit(CS.GameChannel.ChannelManager.instance.packageName)
	
	-- lua代码调试
	local cd = ClientData:GetInstance()
	if cd ~= nil and cd.app_version == "Test" and CS.System.Environment.MachineName ~= "PC-20211202VRWM" then 
		if CS.UnityEngine.Application.isEditor and CS.System.Environment.UserName == "Administrator" and (CS.System.Environment.MachineName == "PC-20200918MGHK" or
				CS.System.Environment.MachineName == "PC-20211202BUYF") then
			package.cpath = package.cpath .. ';C:/Users/Administrator/.Rider2019.2/config/plugins/intellij-emmylua/classes/debugger/emmy/windows/x64/?.dll'
			local dbg = require('emmy_core')
			dbg.tcpListen('localhost', 9966)
			dbg.waitIDE()
		elseif CS.UnityEngine.Application.isEditor and CS.System.Environment.UserName == "wwj" then
			--cd.guide = true
 			package.cpath =  package.cpath .. ';C:/Users/user/AppData/Roaming/JetBrains/Rider2022.2/plugins/EmmyLua/debugger/emmy/windows/x64/?.dll'
             --package.cpath = package.cpath .. ';C:/Users/Administrator/.Rider2019.2/config/plugins/intellij-emmylua/classes/debugger/emmy/windows/x64/?.dll'
 			local dbg = require('emmy_core')
 			dbg.tcpListen('localhost', 9966)
 			dbg.waitIDE()
		elseif CS.UnityEngine.Application.isEditor and CS.System.Environment.UserName == "kk" then
			--cd.guide = true
			
			package.cpath = package.cpath .. ';C:/Users/kk/.Rider2019.3/config/plugins/intellij-emmylua/classes/debugger/emmy/windows/x64/?.dll'
			local dbg = require('emmy_core')
			dbg.tcpListen('localhost', 9966)
			dbg.waitIDE()
		elseif CS.UnityEngine.Application.isEditor and CS.System.Environment.UserName == "Admin" then
			--cd.guide = true
			package.cpath = package.cpath .. ';C:/Users/Admin/.Rider2019.2/config/plugins/intellij-emmylua/classes/debugger/emmy/windows/x64/?.dll'
			local dbg = require('emmy_core')
			dbg.tcpListen('localhost', 9966)
			dbg.waitIDE()
		else
			--[[package.cpath = package.cpath .. ';C:/Users/lanbo/AppData/Roaming/JetBrains/Rider2020.1/plugins/intellij-emmylua/classes/debugger/emmy/windows/x64/?.dll'
			local dbg = require('emmy_core')
			dbg.waitIDE()
			dbg.tcpConnect('localhost', 9966)]]
		end
	end
	cd.guide=true
	
    UpdateManager:GetInstance():Startup()
	TimerManager:GetInstance():Startup()
	--LogicUpdater:GetInstance():Startup()
	UIManager:GetInstance():Startup()
    coroutine.start(function()
		UIManager:GetInstance():OpenWindow(UIWindowNames.UIBlack)
		Initilize()
		EnterGame()
		GameMain.CancelAllNotifications()
	end)
end

-- 场景切换通知
local function OnLevelWasLoaded(level)
	collectgarbage("collect")
	Time.timeSinceLevelLoad = 0
end
local function OnApplicationQuit()
	-- 模块注销
	UpdateManager:GetInstance():Dispose()
	TimerManager:GetInstance():Dispose()
	--LogicUpdater:GetInstance():Dispose()
	Game.Scene:GetComponent("SessionComponent"):Dispose()
end
--取消排队中所有的推送通知
local function CancelAllNotifications()
	CS.NotificationSamples.GameNotificationsManager.Instance:CancelAllNotifications()
end
--根据id取消一条排队中的推送通知
local function CancelNotification(id)
	CS.NotificationSamples.GameNotificationsManager.Instance:CancelNotification(id)
end
--往队列里发送一条通知，标题，内容，延时分钟(可以是小数)，角标(nil用默认)，是否重启app进入队列，小图标，大图标
local function SendNotification(title,  body,  deliveryTime,badgeNumber ,reschedule , smallIcon ,  largeIcon)
	Logger.Log("Lua: SendNotification  --"..title)
	return CS.NotificationSamples.GameNotificationsManager.Instance:SendNotification(title,  body,  deliveryTime,badgeNumber ,reschedule , smallIcon ,  largeIcon)
end

------------------------------------------------------------------------------

local function OnQooLoginSuccess(json)
	ChannelManager:GetInstance():OnLoginSuccess(json)
end

local function OnQooLoginFail(msg)
	ChannelManager:GetInstance():OnLoginFail(msg)
end

local function OnGkLoginSuccess(json)
	ChannelManager:GetInstance():OnLoginSuccess(json)
end

local function OnGkLoginFail(msg)
	ChannelManager:GetInstance():OnLoginFail(msg)
end

-- 支付成功后需要验证：需要lua全局类接收 Unity2Lua
local function PurchaseVerify(json, data)
	ChannelManager:GetInstance():PurchaseVerify(json, data)
end

-- 支付结果（失败或者成功）
local function Purchased()
end

local function CheckLog(data)
	if data == nil then 
		data = {}
	end

	if data.id == nil then
		data.id = Game.Scene ~= nil and Game.Scene.Player ~= nil and Game.Scene.Player.Id or 0
	end
	if data.logs == nil then
		data.logs = {}
	end
	return data
end

local function ClearLog()
	ClientData:GetInstance():SetLogData({})
	return CheckLog({})
end
local function SendLog()
	local data = ClientData:GetInstance():GetLogData()

	if data == nil or data.logs == nil or table.count(data.logs) == 0 then
		return
	end
	Logger.Log("SendLog")
	data = CheckLog(data)
	---@type SessionComponent
	local SessionComponent = Game.Scene:GetComponent("SessionComponent")
	local server_url = ""
	if SessionComponent.serverAddress ~= nil then
		server_url = server_url .. SessionComponent.serverAddress
	end

	if SessionComponent.serverPort ~= nil then
		server_url = server_url .. ":" .. SessionComponent.serverPort
	end

	local resourceVersion = ""
	local resourceVersionNumber = tonumber(SessionComponent.resourceVersion)
	if resourceVersionNumber ~= nil then
		-- 计算除以 1000000 的整数结果 x
		local x = resourceVersionNumber // 1000000

		-- 减去 x 部分后的剩余部分
		local remainder = resourceVersionNumber % 1000000

		-- 计算除以 1000 的整数结果 y
		local y = remainder // 1000

		-- 最后的 z 部分
		local z = remainder % 1000
		-- 格式化输出结果
		resourceVersion = string.format("%d.%d.%d", x, y, z)
	end

	local msg = {
		role_id = data.id,
		channel = SessionComponent.channelId,
		device = SessionComponent.device,
		os = SessionComponent.os,
		app_version = SessionComponent.appversion,
		resource_version = resourceVersion,
		server_url = server_url,
		logs = {},
	}

	for key, value in pairs(data.logs) do
		table.insert(msg.logs, {
			content = value.content,
			times = value.times,
			start_time = value.start_time,
			end_time = value.end_time,
			start_server_time = value.start_server_time,
			end_server_time = value.end_server_time,
		})
	end

	-- 连续发4 5次, 如果都失败, 就直接clearLog. 如果成功直接结束 clearLog
	coroutine.start(function ()
		local success = false
		-- local errorLogAddress = CS.Game.Instance.settings.errorLogAddress
		local errorLogAddress = "http://152.32.190.152:18380/client/error_log"
        --"http://23.91.97.79:18380/client/error_log"----"http://152.32.190.152:18380/client/error_log"--
		local SendReq = function()
			CS.HttpPost(errorLogAddress, function(httpRequest)
				if not httpRequest.Success or httpRequest.Success == nil or not string.IsNullOrEmpty(httpRequest.Error) then
					return
				end
				Logger.Log("<color=green>SendLog success!!!</color>")
				success = true
				ClearLog()
				end, cjson.encode(msg)):Send()
		end

        for i = 1, 5 do
			if success then
				break
			end
            coroutine.waitforframes(2)
            SendReq()
            coroutine.waitforseconds(1)
        end
        if not success then
			Logger.Log("<color=red>SendLog error!!!</color>")
			ClearLog()
		end
    end)
end

local function SaveLog(logText)
	if logText:match("^%[Error%] jar:file:///data/app/") then
		return
	end

	local data = CheckLog(ClientData:GetInstance():GetLogData())
	local playerId = 0
	if Game.Scene ~= nil and Game.Scene.Player ~= nil then
		playerId = Game.Scene.Player.Id
	end
	if data.id ~= playerId then
		SendLog()
		data = ClearLog()
	end

	local lines = {}
    for line in logText:gmatch("[^\r\n]+") do
        table.insert(lines, line)
    end
	local key = table.concat(lines, "\n", 1, math.min(#lines, 3))
	local isNewLog = true
	for index, value in ipairs(data.logs) do
		if value.key == key then
			local time = os.time()
			local serverTime = TimeUtil.GetServerTime()
			if time < value.start_time then
				value.start_time = time
			end
			if time > value.end_time then
				value.end_time = time
			end
			if serverTime < value.start_server_time then
				value.start_server_time = serverTime
			end
			if serverTime > value.end_server_time then
				value.end_server_time = serverTime
			end
			value.times = value.times + 1

			isNewLog = false
			break
		end
	end
	if isNewLog then
		table.insert(data.logs, {
			content  = logText,
			times = 1,
			start_time = os.time(),
			end_time = os.time(),
			start_server_time = TimeUtil.GetServerTime(),
			end_server_time  = TimeUtil.GetServerTime(),
			key = key,
		})
	end

	ClientData:GetInstance():SetLogData(data)
end


-- GameMain公共接口，其它的一律为私有接口，只能在本模块访问
GameMain.Start = Start
GameMain.OnLevelWasLoaded = OnLevelWasLoaded
GameMain.OnApplicationQuit = OnApplicationQuit
GameMain.OnQooLoginSuccess = OnQooLoginSuccess
GameMain.OnQooLoginFail = OnQooLoginFail 
GameMain.PurchaseVerify = PurchaseVerify
GameMain.Purchased = Purchased
GameMain.SendNotification = SendNotification
GameMain.CancelAllNotifications=CancelAllNotifications
GameMain.CancelNotification=CancelNotification
GameMain.OnGkLoginSuccess = OnGkLoginSuccess
GameMain.OnGkLoginFail = OnGkLoginFail
GameMain.SaveLog = SaveLog
GameMain.SendLog = SendLog
return GameMain