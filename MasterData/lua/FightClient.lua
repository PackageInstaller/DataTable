local this = {};

this.data = nil;
this.isStarted = nil;
--返回虚拟键标记
this.IsFightStop=true;
this.IsFightOver=false;
--处于放大招中
this.Intheamplificationmove=false;
---德拉苏
this.NewPlayerDrasu=false;
--初始化战斗
function this:Init(data,initCallBack,initCaller)
    --LogError("进入战斗==========================");
    self:SetTotalDamage(0);

    if(data)then
        EventMgr.Dispatch(EventType.Play_BGM, data.bgm);
    end
    CSAPI.StopBGM();

--    Log(data);
--    if(1)then return; end
    EventMgr.Dispatch(EventType.Net_Msg_Getted,"fight");--通知战斗已开始
    EventMgr.Dispatch(EventType.Input_Scene_State_Change,true,true);--开启战斗输入    
    if(self:IsFightting())then
        LogError("重复战斗");

        BackToLogin();
--        local dialogdata = {
--			content = "战斗数据出错，请重新登录",
--			okCallBack = function()
--				PlayerClient:Exit();
--			end,
--            cancelCallBack = function()
--				PlayerClient:Exit();
--			end
--		}
--		CSAPI.OpenView("Dialog", dialogdata);
        return;
    end

    --进入战斗前，释放声音资源
    if(SceneMgr and SceneMgr:IsMajorCity())then
        ReleaseMgr:ReleaseSound();
    end

    self.initCallBack = initCallBack;
    self.initCaller = initCaller;

    self.fightting = true;
	self.isStarted = nil;
    self.isLoadingComplete = nil;
    self.disableExit = self.nextDisableExit;
    self.nextDisableExit = nil;

    if(self:IsUseCommonLoading())then
        self:InitFight(data);
    else
        CSAPI.OpenView("FightLoading");
        FuncUtil:Call(self.InitFight,self,500,data);  
    end    

    self:InitSkillScene();

    --重置帧率
    --SettingMgr:UpdateTargetFPS(); 
end

--获取开场表情
function this:GetEmote(emoteState)
    local emotes = self.data and self.data.emotes;
    if(emotes)then
       local emote1,emote2;
       emote1 = emotes[1] and emotes[1][emoteState];
       emote2 = emotes[2] and emotes[2][emoteState];

       return emote1,emote2;
    end
end

function this:InitSkillScene()
    if(self.inInited)then
        return;
    end
    self.inInited = 1;
    CSAPI.CreateGOAsync("Scenes/SkillScene/Main",0,0,0,nil,function(go)
        FightClient:SetSkillSceneGO(go);
        FightClient:SetSkillSceneState(false);
    end);    
end
function this:SetSkillSceneGO(go)
    self.skillSceneGo = go;
    self.skillScene = ComUtil.GetLuaTable(go);
end
function this:SetSkillSceneState(state,camp)
    if(self.skillSceneGo)then
        CSAPI.SetGOActive(self.skillSceneGo,state);
        if(state)then
            self.skillScene.SetCamp(camp);
        end
    end
end


function this:IsUseCommonLoading()
    return false;-- self:IsNewPlayerFight() or FightClient:IsRestoreState();
end

function this:InitFight(data)
	self.data = data;

    TeamUtil:SetMyNetTeamId(self.data.myTeamID);--设置己方队伍在后端上的队伍编号，前端己方队伍编号固定队伍1
    --格子数据
    local gridDatas = data.gridDatas;
	FightGroundMgr:InitData(gridDatas[1], gridDatas[2], gridDatas[3], gridDatas[4]);--设置战斗格子
	
	self:InitSpeed();
	

    --开始加载目标战斗场景
	EventMgr.AddListener(EventType.Loading_Start, this.OnLoadingStart);

    local sceneId = self.data.scene;
    if(g_fight_scene_id)then
        sceneId = g_fight_scene_id;
    end
    if(self:IsUseCommonLoading())then
        EventMgr.Dispatch(EventType.Scene_Load, sceneId);
	else
        EventMgr.Dispatch(EventType.Scene_Fight_Load, sceneId);   
    end

    if(g_FightMgr and IsPvpSceneType(g_FightMgr.type))then           
       self:SetAutoFight(false);
    elseif(PlayerClient:IsPassNewPlayerFight())then
        if(self:GetDirll() or DungeonMgr:IsTutorialDungeon())then
            self:SetAutoFight(false);  
        else
            local auto = PlayerPrefs.GetInt("fight_Auto")==1;
            self:SetAutoFight(auto);  
        end
    end    


    if(self.initCallBack)then
        local initCallBack = self.initCallBack;
        local initCaller = self.initCaller;        
        self.initCallBack = nil;
        self.initCaller = nil;

        initCallBack(initCaller);
    end
end

function this:SetInputCharacter(character)
    self.inputCharacter = character;
end
function this:GetInputCharacter()
    return self.inputCharacter;
end

function this:PlayFightBGM()
    if(self.data)then
        EventMgr.Dispatch(EventType.Play_BGM, self.data.bgm);
    end
end

--加载界面控制
--开场角色加载loading界面控制用的key
local loading_weight_key = "fight_start_create";
function this.OnLoadingStart()
	EventMgr.Dispatch(EventType.Loading_Weight_Apply, loading_weight_key);
end


function this:ApplyLoadingComplete()  
    
    self.isLoadingComplete = true;
	--关闭loading界面
	EventMgr.Dispatch(EventType.Loading_Weight_Update, loading_weight_key);
	EventMgr.RemoveListener(EventType.Loading_Start, this.OnLoadingStart);
end

function this:ApplyStart()
    --LogError("战斗准备就绪");

	--关闭loading界面
	self:ApplyLoadingComplete();  
	
	--DebugLog("战斗开始=============================");
	--向服务器发送开场请求
	FightProto:SendCmd(CMD_TYPE.Start, {});
	-- g_FightMgr:OnStart();
	
	--CameraMgr:EnableMainCamera(true); 
    FightClient:TryPlayCharacterBGM(); 
end

function this:IsFightting()
    return self.fightting;
end

--强行退出战斗
function this:ForceQuit()
    self:Reset();       
    DungeonMgr:Quit(true);
end

function this:QuitFihgt()
      if g_FightMgr and g_FightMgr.ForceQuit then
        g_FightMgr:ForceQuit()
    else
        EventMgr.Dispatch(EventType.Net_Loading, 500, true); -- 设定时间内未收到网络消息弹出网络Loading界面
        -- 发协议
        local proto = {"FightProtocol:Quit", {
            bIsQuit = true
        }}
        if(g_FightMgr and IsPvpSceneType(g_FightMgr.type))then    
            ExerciseRMgr:GetCurNet():Send(proto)
        else 
            NetMgr.net:Send(proto);
        end 
    end
end
function this:Reset()    
    self:SetAutoFight(false,true);
    self:Clean();
    self.playSpeed = nil;
    defaultPlaySpeed = nil;

    FireBallMgr:ClearFBs();    
    --self:SetPlaySpeed();
end

--清理
function this:Clean(needConnect)
    Log("战斗清理");

    CSAPI.PlaySound("", "", true, false, "feature", 1);--停止人声

    g_FightMgr = nil;
    g_FightMgrServer = nil;
	FightActionMgr:Reset();
    FightActionUtil:Clean();
	CharacterMgr:Clean();
	FightGroundMgr:Clean();
	FightGridSelMgr.Hide();
    ClientBuffMgr:Clean();
    if(not needConnect)then 
        NetMgr.netFight:Disconnect();
    end 
    if(FightActionInputIdle)then
        FightActionInputIdle:SetState(nil);
    end

    self:SetSkillSceneState(false);
    self:SetTimeLineDatas();
	self.serverStart = nil;
	self.np = nil;
    self.fightting = nil;
    self:SetNewPlayerFight(false);
    self:SetDirll();
    self:SetInputCharacter();
	--CameraMgr:EnableMainCamera(false);
	
	if(self.playSpeed) then
        if(g_FightMgr and IsPvpSceneType(g_FightMgr.type))then
            defaultPvpPlaySpeed = self.playSpeed;
            self:SetPlaySpeed(nil);
		else
            defaultPlaySpeed = self.playSpeed;
            self:SetPlaySpeed(defaultPlaySpeed);
        end
	end
	
	self:SetStopState(false);
    CSAPI.SetTimeScale(1);
    self:UpdateCriWaveFeaturePitch(1);
    self:SetRestoreState(false);
    self.isSurrender = nil;
    self.disableExit = nil;
    
    CleanCamera()

    

    EventMgr.Dispatch(EventType.Fight_Clean);

    EventMgr.Dispatch(EventType.Input_Scene_State_Change,false,true);--关闭战斗输入     
    
    --重置帧率
    --SettingMgr:UpdateTargetFPS(); 
end


function CleanCamera()
    CSAPI.SetCameraRenderTarget(CameraMgr:GetCameraGO(),nil);
     --关闭战斗场景镜头
    local xluaCamera = CameraMgr:GetXLuaCamera();
    if(xluaCamera)then
        xluaCamera.RemoveCameraEffs();
        xluaCamera.SetEnable(false);
    end

end

function this:ApplySurrender()
    self.isSurrender = 1;
end
function this:IsSurrender()
    return self.isSurrender;
end

--获取场景ID
function this:GetSceneId()
	return self.data.scene;
end

--尝试战斗开场
function this:ApplyFightStart()
    --LogError("战斗启动");
	if(self.isStarted) then
		return false;
	end
	self.isStarted = true;
	
	FightActionMgr:Push(FightActionMgr:Apply(FightActionType.Start));
	return true;
end


function this:ApplyServerStart()
	self.serverStart = 1;
end

--总波数
function this:GetTotalWave()
	return self.data and self.data.totleState or 1;
end



--播放速度

local playSpeedStep = 0.1;

--获取播放速度配置
function this:GetPlaySpeedSetting()
    local slowestPlaySpeed = fight_play_speed_default and fight_play_speed_default * 0.01 or 1;
    local fastestPlaySpeed = fight_play_speed_faster and fight_play_speed_faster * 0.01 or 1.5;
    local speed3 = fight_play_speed_fastest and fight_play_speed_fastest * 0.01;
    return slowestPlaySpeed,fastestPlaySpeed,speed3;
end

function this:GetPlaySpeedDefault()
    local saveSpeed;

    local b, str = MenuMgr:CheckModelOpen(OpenViewType.special, SpecialOpenViewType.SpeedFight)
    if(b)then
        saveSpeed = PlayerPrefs.GetInt("fight_speed");
    end

    if(not saveSpeed or saveSpeed <= 0)then
        saveSpeed = nil;
    else
        saveSpeed = saveSpeed * 0.01;
    end
    return  saveSpeed or (fight_play_speed_default and fight_play_speed_default * 0.01 or 1);
end

function this:InitSpeed()
    if(g_FightMgr and IsPvpSceneType(g_FightMgr.type))then           
       local pvpSpeed = fight_play_speed_pvp and (fight_play_speed_pvp * 0.01) or 1;
       self:SetPlaySpeed(pvpSpeed,true);
    else
       self:SetPlaySpeed(defaultPlaySpeed);
    end    
end

function this:AddPlaySpeed(addValue)
	addValue = addValue or 1;
	local playSpeed =(self.playSpeed or defaultPlaySpeed) + addValue * playSpeedStep;
	this:SetPlaySpeed(playSpeed);
end
function this:SetPlaySpeed(playSpeed,dontSave)
    --LogError(string.format("playSpeed:%s,dontSave:%s",tostring(playSpeed),tostring(dontSave)));

    local slowestPlaySpeed,fastestPlaySpeed,speed3 = self:GetPlaySpeedSetting();
    fastestPlaySpeed = speed3 or fastestPlaySpeed;

	playSpeed = playSpeed or self.playSpeed or self:GetPlaySpeedDefault();
	playSpeed = math.max(slowestPlaySpeed, playSpeed);
	playSpeed = math.min(fastestPlaySpeed, playSpeed);


    if(not dontSave)then
	    self.playSpeed = playSpeed;

        PlayerPrefs.SetInt("fight_speed", math.floor(self.playSpeed * 100));
    end
	self:UpdateTimeScale(playSpeed);
    
    self:UpdateCriWaveFeaturePitch(playSpeed);
    --LogError("最终playSpeed:" .. tostring(playSpeed));
end
function this:UpdateTimeScale(targetSpeed)
    targetSpeed = targetSpeed or self.playSpeed;
	local timeScale =(targetSpeed or 1) *(self.isStop and 0 or 1);
	--LogError("速度" .. timeScale);
	CSAPI.SetTimeScale(timeScale);
end

function this:UpdateCriWaveFeaturePitch(speed)
    local speed1,speed2 = self:GetPlaySpeedSetting();

    local index = speed == speed2 and 2 or 1;
    local pitch = g_CriWave_Feature_Pitch and g_CriWave_Feature_Pitch[index] or 0;
    --LogError(pitch);
    if(pitch > 0)then
        pitch = 1200;
    end
    EventMgr.Dispatch(EventType.CriWave_Feature_Pitch,pitch,true);
end

function this:SetStopState(isStop)
	self.isStop = isStop;
	self:UpdateTimeScale(self.playSpeed);
end

function this:GetPlaySpeed()
	return self.playSpeed or defaultPlaySpeed or self:GetPlaySpeedDefault();
end

--切换自动战斗状态
function this:ChangedAutoFight()
    self:SetAutoFight(not self.autoFight);
    PlayerPrefs.SetInt("fight_Auto", self.autoFight==true and 1 or 0);

    EventMgr.Dispatch(EventType.Fight_Auto_Changed);	
end
--设置自动战斗
function this:SetAutoFight(autoFight,dontSave)
    --LogError("AutoFight:" .. tostring(autoFight));

	self.autoFight = autoFight;
    
    if(dontSave)then
        return;
    end
    if(g_FightMgr)then      
        if( not IsPvpSceneType(g_FightMgr.type) and g_FightMgr.type ~= SceneType.PVPMirror and not self:GetDirll())then           
	        PlayerPrefs.SetInt("fight_Auto", autoFight==true and 1 or 0);
            --LogError("set auto state:" .. tostring(autoFight));
        end
    else
        PlayerPrefs.SetInt("fight_Auto", autoFight==true and 1 or 0);
        --LogError("set auto state:" .. tostring(autoFight));
    end
end
--是否自动战斗
function this:IsAutoFight()
	if self.autoFight == nil then
		local auto = PlayerPrefs.GetInt("fight_Auto")==1;
		self.autoFight = auto;
	end
    --LogError(tostring(self.autoFight));
	return self.autoFight;
end
--发送自动战斗命令
function this:SendAutoFight()
	if(self.serverStart == nil) then
		return;
	end
	
	if(FightClient:IsAutoFight()) then
        --超时未收到再发送一次
        EventMgr.Dispatch(EventType.Net_Msg_Wait,{msg="fight_input",time=1500,
        timeOutCallBack=function()
            LogWarning("自动战斗命令超时未响应，重新发送一次");
            FightProto:SendAuto();
        end});

		FightProto:SendAuto();
        --ProtocolRecordMgr:RecordFight({"FightProto:SendAuto"},1);--记录
	end
end

function this:SetRestoreState(state)
    --LogError("设置是否战斗恢复：" .. tostring(state));
    self.restoreFightState = state;
end
function this:IsRestoreState()   
    return self.restoreFightState;
end

function this:SetNewPlayerFight(state)
    self.isNewPlayerFight = state;
    if(state)then
        self:SetAutoFight(false)
        PlayerPrefs.SetInt("fight_Auto", 0);
    end
end
function this:IsNewPlayerFight()   
    return self.isNewPlayerFight;
end

function this:SetNextFightExitState(state)
    self.nextDisableExit = not state;
end
function this:IsCanExit()   
   return not self.disableExit; 
end

--当前是否翻转状态
function this:IsFlip()
	return self.isFlip;
end

--设置NP
function this:SetNp(np)
    self.np = np;
end
--获取NP
function this:GetNp()
    return self.np or 0;
end

--设置回合
function this:SetTurn(turn)
    self.turn = turn;
end
--获取回合
function this:GetTurn()
    return self.turn or 0;
end


function this:SetSelSkill(skillId)
    self.skillId = skillId;
end
function this:GetSelSkill()
    return self.skillId;
end
function this:GetSelSkillCareer()
    local skillId = self:GetSelSkill();
    local cfgSkill = Cfgs.skill:GetByID(skillId);
    if(not cfgSkill)then
        return;
    end
    return cfgSkill.career;
end

function this:SetSelOverload(state)
    self.isSelOverload = state;
end
function this:IsSelOverload()
    return self.isSelOverload;
end


function this:GetSetting()
    if(not self.setting)then
        self.setting = require "FightSetting";
    end
    return self.setting;  
end

function this:GetDirll()
    return self.dirllId;
end
function this:SetDirll(dirllId)
    self.dirllId = dirllId;
end

function this:QuitDirll()
    local dirllId = self:GetDirll();    		
	if(dirllId) then
        self:Clean();    
		SceneLoader:Load("MajorCity", function()
			local card = RoleMgr:GetData(dirllId);
			--要打开列表
			CSAPI.OpenView("RoleListNormal", card, 3)  --3 =>试玩，会触发打开该卡牌详情界面
		end)
	end
end

function this:GetFightMaskDelayTime()
    return 1760;
end

function this:SetTimeLineDatas(datas)
    if not datas then
        return
    end
    local arr = {};
    for i,data in ipairs(datas)do
        --第一个是行动者
        if(i >= 2)then
            if(not data.arrow)then
               local index = 1;
               for i,arrData in ipairs(arr)do                   
                   if(data.progress > arrData.progress)then
                       break;
                   end       
                   index = i + 1;            
               end 
               table.insert(arr,index,data);
            end
        end
    end
    table.insert(arr,1,datas[1]);
    self.timeLineDatas = arr;
end
function this:GetTimeLineDatas()
    return self.timeLineDatas;
end

--是否预警倒计时回合
function this:IsWarningTurn(turnLeft)   
    --LogError(turnLeft)
    if(not turnLeft)then
        return;
    end
 
    local enterWarning = false;
    local isWarning = false;  

    if(g_turn_timeout_warning)then
        for _,targetLeftTurn in ipairs(g_turn_timeout_warning)do
            --LogError(targetLeftTurn)

            if(turnLeft <= targetLeftTurn)then
                enterWarning = true;
            end
            if(targetLeftTurn == turnLeft)then
                isWarning = true;
            end
        end
    end
    --return true,true;
    return isWarning,enterWarning;
end

local key_fight_pause = "fight_pause";
function this:SetPauseState(state)
    --LogError("state:" .. tostring(state));
    this.IsFightStop=state
    CSAPI.SetTimeScaleByKey(key_fight_pause, state and 0 or 1);
end

function this:SetTotalDamage(val)
    self.totalDamage = val;
end
function this:GetTotalDamage()
    return self.totalDamage;
end

--播放角色BGM
function this:TryPlayCharacterBGM()
    local characters = CharacterMgr:GetAll();
    local bgm = nil;
    if(characters)then
        for id,character in pairs(characters)do
            if(character and not character.IsDead())then
                local tmpBgm = character.GetBGM();
                bgm = tmpBgm;
                if(tmpBgm and character.IsMine())then
                    break;
                end
            end
        end
    end

    if(bgm)then
        CSAPI.PlayBGM(bgm,1000);
    else
        EventMgr.Dispatch(EventType.Replay_BGM);
    end
end

return this;