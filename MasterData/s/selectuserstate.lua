--在“江湖”这个游戏中，是存在选择角色这个环节的，但是，在舰L中，并不存在这个环节
--但是，为了代码的复用，我们保留了这个逻辑，但是，默认选择第一个用户

require "FSM"
require "GameFlowState"
require "CommonLogic"
local Random = require "Random"
---@type DPlayerPrefs
MyPrefs = nil

---@class SelectUserState : FSMState
local SelectUserState = FSMState:new("SelectUserState", GameFlowState.SelectUserState)

function SelectUserState:enter()
	ClientData:ServerTimeCorrect()
	ClientData:SubscribeMessage()
	ClientData:RecordSuperProperties()
	self:doLogic()
end

function SelectUserState:doLogic()
	-- UIMgr:removeUI("ServerListUI", nil, nil, true)
 	-- UIMgr:popUI("SelectUserPanel")
	self.userInfos = nil
	LoadingMgr:SetLoadingStart(function()
		UIMgr:closeUI("LoginUI", nil, nil, true)
		UIMgr:removeUI("ServerListUI", nil, nil, true)
		UIMgr:clearAllUI()
		-- AssetManager.Instance:UnloadUnusedAssets()
		self:getUserInfo()
	end, nil, nil, "SelectUserState")
end

--初始化角色信息
function SelectUserState:dealWithClickName(index)
	print("dealWithClickName")
	--判断是否有角色信息
	if self.userInfos and next(self.userInfos) then
		local userInfo = self.userInfos[index]
		if userInfo and userInfo.uid then
			--这里进行选择角色s
			self:selectUser(userInfo.uid)
		else
			self:createRole()
		end
	else
		self:createRole()
	end
end

--创建角色
function SelectUserState:createRole()
	LuaLogger.ds("目前没角色")
	--UIMgr:popUI("OPMotionComicsPanle", {callBack = function()
		LoadingMgr:SetLoadingOver(nil, function()
		LuaLogger.ds("CreateRolePanel")
			UIMgr:popUI("CreateRolePanel", {callBack = function(success)
				if success then
					self:getUserInfo()
				end
			end})
		end, "SelectUserState2")
	--end})
	
end

--获取角色信息
function SelectUserState:getUserInfo()
	GameNetHandler:SendWaitMessage("user.UserListReq", {}, function (data)
		self.userInfos = data.user_infos
		if self.userInfos then
			table.sort(self.userInfos, function (u1, u2)
				return u1.uid < u2.uid
			end)
		end
		self:dealWithClickName(1)	--默认第一个角色
		--self:Refresh()
        -- if GlobalInfo.DirectLogin then
        -- 	self:dealWithClickName(1)
        -- end
    end)
end

function SelectUserState:selectUser(uid)
	print("selectUser ", uid)
	self:GetUserData(uid, function (data)
		-- ClientData.userInfo:SetUserInfo(data)
		print("getUserInfo ", data, DLuaUtil.SerialiseProto(data))
		for k, v in pairs(data) do
			--本地模式特殊处理
			if k == "userDefined" then
				ClientData:SetCustomData(v)
				data.userDefined = nil
			end
		end
		local userInfo = data
		if userInfo then
			EngineGlobal.SetServerTime(userInfo.servertime*1000)
			local testMode = false
			if testMode then
				-- require "Test_BattleFormations"
				-- local a, b = GetFormations01()
				-- Me = a[11]

				-- Me.energy = Me:getCurrMaxEnergy()
				-- Me.hp = Me:getCurrMaxHp()
				-- Me.spirit = Me:getCurrMaxSpirit()
				-- Me.mp = Me:getCurrMaxMp()
				-- Me.temp = {}
			else
				-- 根据从服务器获取的数据初始化Me
				Me:copyFromUserInfoProto(userInfo)
				--初始化账号本地数据
				MyPrefs = require "DPlayerPrefs":new(SDKMgr:getSaveID() .. "_" .. Me.uid)
				self:MyPrefsInitData()
				RedDotManager.Initialize(SDKMgr:getSaveID() .. "_Red_" .. Me.uid)

				LuaLogger.ds("yearsOld", Me.yearsOld)
				RedPointMgr:initMsg()

				--初始化角色数据
				ClientData:InitRoleList()

				--初始化武器数据
				ClientData:InitWeaponMap()

				--进入游戏
				-- LoadingMgr:SetLoadingStart(function()
				-- 	StateMgr:ChangeToState(GameFlowState.GameState)
				-- end, true)

				--播放游戏名语音
				self:playGameNameVoice()
				ThinkingAnalytics:login()
				BuglyAgent.SetUserId(Me.uid)
				-- BuglyAgent.ReportException("登录游戏", "玩家登录了游戏","玩家登录了游戏")
				--发送进入游戏协议
				Me:enterScene(nil, function ()
					--初始化引导
					GuideMgr:InitUserGuideData()
					--进入游戏
					self:enterGameByMode()
					--埋点
					DUtil.SendGameStageLogMessage(2, "进入游戏");
					QualitySettingsMgr:RecordRecommendedQuality()
					UnityEngine.PlayerPrefs.SetInt("GameStageSendTime", DLuaUtil.GetCurrZeroHourTime())
				end, function ()
				end)
			end
		end
		--self:Refresh()
	end)
end

--初始化本地数据(与账号绑定)
function SelectUserState:MyPrefsInitData()
	--初始化本地变量float
	local function _checkDefaultFloat(key, defaultValue)
		if not MyPrefs:HasKey(key) then
			MyPrefs:SetFloat(key, defaultValue)
		end
	end

	--初始化本地变量int
	local function _checkDefaultInt(key, defaultValue)
		if not MyPrefs:HasKey(key) then
			MyPrefs:SetInt(key, defaultValue)
		end
	end

	--初始化本地变量string
	local function _checkDefaultString(key, defaultValue)
		if not MyPrefs:HasKey(key) then
			MyPrefs:SetString(key, defaultValue)
		end
	end
	_checkDefaultInt(GE.LocalCustomDataKey.TimeLineIsOn, 1)
	_checkDefaultInt(GE.LocalCustomDataKey.cameraIsOn, 1)
	_checkDefaultInt(GE.LocalCustomDataKey.setFightSpeed, 1)
	_checkDefaultInt(GE.LocalCustomDataKey.BattleCameraAngle, 1) --战斗摄像机角度类型
    local list = Config.GetConfigInfo("BattleCameraType")
    local max = tablex.size(list)
    if MyPrefs:GetInt(GE.LocalCustomDataKey.BattleCameraAngle) > max then
        MyPrefs:SetInt(GE.LocalCustomDataKey.BattleCameraAngle, 1)
    end
    _checkDefaultInt(GE.LocalCustomDataKey.CoveCameraAngle, 1) --家园摄像机角度类型
    local list = Config.GetConfigInfo("HomeCameraType")
    local max = tablex.size(list)
    if MyPrefs:GetInt(GE.LocalCustomDataKey.CoveCameraAngle) > max then
        MyPrefs:SetInt(GE.LocalCustomDataKey.CoveCameraAngle, 1)
    end
end

--根据关卡状态选择进入游戏方式(首次进入或正常进入)
function SelectUserState:enterGameByMode()
	local newPlayerLevel = {10101, 10102}
	local needState = GameFlowState.GameState
	if not GV.SkipUsrGuide then
		for _, levelId in pairs(newPlayerLevel) do
			local levelData = Me:getLevelDataByid(levelId)
			if not levelData or levelData.state == GE.LevelStateType.Going then
				needState = GameFlowState.BattleState
				Me:setNowSelectLevel(levelId)
				break
			end
		end
	end
	Me.isEnterScene = true
	local InterludeLoadingPanel = UIMgr:getUIData("InterludeLoadingPanel")
	--有账号直接进游戏
	if InterludeLoadingPanel then
		StateMgr:ChangeToState(needState)
	else
		--需要取名完再进游戏
		LoadingMgr:SetLoadingStart(function()
			--进入游戏
			StateMgr:ChangeToState(needState)
		end, nil, nil, "SelectUserState3")
	end
end

--根据已拥有角色随机播放游戏名语音
function SelectUserState:playGameNameVoice()
	local seed = DLuaUtil.GetGreenwichTime()
    local random = Random:new(seed)
	local roleList = ClientData:GetRoleList()
	local roleWeightMain = {}
	if not next(roleList) then
		return
	end
	for id, _ in pairs(roleList) do
		table.insert(roleWeightMain, {index = id, weight = 1})
	end
	local roleId = DLuaUtil.getRandomIndexLinear(roleWeightMain, random)
	if not roleList[roleId] then
		return
	end
	local skinConfig = Config.GetCharacterSkinInfo(roleList[roleId].equipSkin)
	if not skinConfig then
		return
	end
	local lineWeightMain = {}
	local startLine = skinConfig.gameStartLine
	for _, lineData in pairs(startLine) do
		table.insert(lineWeightMain, {index = lineData[1], weight = lineData[2]})
	end
	if not next(lineWeightMain)then
		return
	end
	local voiceId = DLuaUtil.getRandomIndexLinear(lineWeightMain, random)
	local nowLineConfig = Config.GetScriptLinesInfo(voiceId)
	if not nowLineConfig then
		return
	end
	UICommonUtils.Play2DVoiceByLanguage(roleId, nowLineConfig.resource,nil,  ResMgr:GetGlobalResCarrier())
end

function SelectUserState:GetUserData(uid, callBack)
	local userData = {}
	local function send(part)
		local channel = UpdateManager.Instance.Code5
		--local channel = 1
		local deviceType = UnityEngine.Application.platform:ToInt()
	
		-- Me的new放在LuaMain里面，在这里只进行清空处理
		Me:initFromUserInfoProto({})
		GameNetHandler:SendWaitMessage("user.UserInfoReq", {uid = uid, part = part, channel = channel, deviceType = deviceType}, function (data)
			local userInfo = data.user_info or {}
			for key, value in pairs(userInfo) do
				-- LuaLogger.ds("UserInfoResp", string.format("key: %s, value: %s", key, tablex.dump(value)))
				if userData[key] == nil then
					userData[key] = value
				else
					-- if type(value) == "table" then
					-- 	for i, v in pairs(value) do
					-- 		table.insert(userData[key], v)
					-- 	end
					-- end
				end
			end
			if data.over then
				callBack(userData)
			else
				send(true)
			end
		end)
	end
	send(false)
end

function SelectUserState:update()
    --print(string.format("SelectUserState %s update", self.name))  
end

function SelectUserState:exit()
 	UIMgr:removeUI("SelectUserPanel")
end

return SelectUserState