require "FSM"
require "GameFlowState"

---@class LoginState : FSMState
local LoginState = FSMState:new("LoginState", GameFlowState.LoginState)

function LoginState:enter()
	QualitySettingsMgr:Init()
	LuaLogger.ds("enter LoginState")
	-- 回登录应视为会话结束，不应保留玩法组界面栈
	UIMgr:clearUIDataGroup(UIGroup.Main)
	UIMgr:clearUIDataGroup(UIGroup.Battle)
	UIMgr:clearUIDataGroup(UIGroup.Survival)
	UIMgr:clearUIDataGroup(UIGroup.SeaMap)
	UIMgr:clearUIDataGroup(UIGroup.Empty)
	UIMgr:clearAllUI()
	UIMgr:switchUIDataGroup(UIGroup.Login)
	self:doLogic()
end

function LoginState:doLogic()
	-- UIMgr.Instance:LoadUI(Config.UI.Login_LoginRegister, function (obj)
 --        print("Login_LoginRegister loaded", obj)
	-- 	local loginUI = obj:AddComponentLua("LoginUI")
 --    end, false,false)

 	-- kick，要放在popUI的前面，因为会重置MsgMgr\
	local lastStateId = GameFlowFSM:getLastStateId() or 0
	LuaLogger.ds("=====>>>>> lastStateId:" .. (lastStateId))
 	if lastStateId == GameFlowState.GameState or lastStateId == GameFlowState.SelectUserState or lastStateId == GameFlowState.BattleState then
		ClientData:PauseSyncServerTime()
		GameNetHandler:LuaDisconnect()
		if Me then
			Me.isEnterScene = false
			Me.enteredChallenge = nil
			Me.hasInitChallengeInfo = nil
			Me.pushDataDownMap = {}
			Me.pushDatasendList = {}
			Me.isFunctionDataRequesting = false
			Me.functionDataRequestQueue = {}
			Me:Clear()
		end
		if RedPointMgr then
			RedPointMgr:Clear()
		end
		
		local uibase = UIMgr:GetUI("InterludeLoadingPanel")
		if uibase ~= nil then
			UIMgr:closeLoadingUI(uibase)
		end

 		collectgarbage "collect"
 		LuaMain:reload()
 	end

	UIMgr:ClearLoader()

	UIMgr:_popUIDo("AdapterPanel")
 	UIMgr:popUI("LoginUI")
 	UIMgr:removeUI("CheckUpdateWnd")
	UIMgr:removeUI("UserGuidePanel")
end

function LoginState:update()
    -- print(string.format("LoginState %s update", self.name))  
end

function LoginState:exit()
	print("LoginState:exit",debug.traceback())
	-- LoadingMgr:SetLoadingStart(function()
	-- 	UIMgr:closeUI("LoginUI", nil, nil, true)
	-- 	UIMgr:removeUI("ServerListUI", nil, nil, true)
	-- 	UIMgr:clearAllUI()
	-- 	AssetManager.Instance:UnloadUnusedAssets()
	-- end)
	-- ResMgr:UnloadUnusedBundles(true)
end

return LoginState