--战斗入场

FightActionStart = oo.class(FightActionBase);
local this = FightActionStart;

function this:OnPlay()   
    self.isPlayed = false;
    self.isContinued = false;

    self.loadingCompleteCallBack = FuncUtil:ApplyCallBackFunc(self.OnLoadingComplete,self);
    EventMgr.AddListener(EventType.Loading_Complete, self.loadingCompleteCallBack.OnCallBack);  
    
    
    if(self:CheckPlot(true))then
        EventMgr.Dispatch(EventType.Loading_View_Delay_Close,500); 
        if(not FightClient:IsRestoreState())then       
             self:PlayContinue();
        end
    end

    FightClient:ApplyStart();  
end

function this:OnLoadingComplete()  
    
    EventMgr.RemoveListener(EventType.Loading_Complete, self.loadingCompleteCallBack.OnCallBack);
    self.loadingCompleteCallBack = nil;
     
    self:PlayContinue();
end

function this:PlayContinue()
    if(self.isContinued)then
        return;
    end
    self.isContinued = 1;


    if(FightClient:IsRestoreState())then        
        FuncUtil:Call(self.RestoreStart,self,500);        
    else
        self:CheckPlot();--正常开场，检测剧情
    end
end

function this:RestoreStart()
    self:Complete();--战斗恢复    
    EventMgr.Dispatch(EventType.Fight_UI_Enter_Action);
    FightClient:PlayFightBGM();
end

--检测剧情
function this:CheckPlot(isCheck)
    local cfg = nil;
    if(FightClient:IsNewPlayerFight())then
        local fightIds = PlayerClient:GetNewPlayerFightIDs();
        local fightId = fightIds and fightIds[1];
        cfg = Cfgs.MonsterGroup:GetByID(fightId);
    else
        cfg = DungeonMgr:GetFightMonsterGroup();
    end
    
    if(isCheck)then
        return not PlotMgr:IsPlayed(cfg and cfg.storyID1);
    end

    if(cfg and cfg.storyID1)then
        local state = PlotMgr:TryPlay(cfg.storyID1,self.OnPlotComplete,self);
    else
        self:OnPlotComplete();
    end
end
function this:OnPlotComplete()    
    if(self.isPlayed)then
        return;
    end
    self.isPlayed = true;
    FightClient:PlayFightBGM();
  
    FuncUtil:Call(FightClient.InitSpeed,FightClient,500);--设置战斗播放速度
    EventMgr.Dispatch(EventType.Input_Target_Changed);
    EventMgr.Dispatch(EventType.Character_FightInfo_Show,false); 
    EventMgr.Dispatch(EventType.Fight_View_Show_Changed,false);  
    EventMgr.Dispatch(EventType.Fight_View_Main_Info_Show_State,false);   

    self:PlayFightStart();

    --角色开场准备动作
    self:PlayCharacterEnterReady();
    --self:PlayCharacterFightStart();

    local enterAniName,enterSound = self:GetEnterAni();
    if(enterAniName)then
        CSAPI.StopBGM();
        CSAPI.SetBGMLock("boss_enter");
        CameraMgr:EnableMainCamera(false);
        --[[ local enterAni = ResUtil:PlayVideo(enterAniName);
        enterAni:AddCompleteEvent(function()
            CameraMgr:EnableMainCamera(true);
            self:PlayCharacterFightStart();
            CSAPI.SetBGMLock();
            EventMgr.Dispatch(EventType.Replay_BGM);
        end);
 ]]
        CSAPI.OpenView("VideoPlayer", {
            videoName = enterAniName,
            callBack = function()
                CSAPI.CloseView("VideoPlayer");
                CameraMgr:EnableMainCamera(true);
                self:PlayEmotes();
                CSAPI.SetBGMLock();
                CSAPI.StopSound();
                EventMgr.Dispatch(EventType.Replay_BGM);
            end,
        });


        if(enterSound)then
            CSAPI.PlaySound("fight/effect/" .. enterSound .. ".acb",enterSound);
        end        

        if(FightClient:IsNewPlayerFight())then--新手关boss入场打点
            BuryingPointMgr:BuryingPoint("after_login", 20042);
        end
    else
        FuncUtil:Call(self.PlayEmotes,self,150);
    end
        
    CSAPI.PlayUISound("ui_battle_interface_in");
 end


--获取入场动画
function this:GetEnterAni()
    local enterAniName;
    local enterSound;
    local characters = CharacterMgr:GetAll();
    if(characters)then
        for _,character in pairs(characters)do
            local cfg = character.GetCfg();
            --LogError(cfg);
            enterAniName = cfg.enter_ani;
            enterSound = cfg.enter_sound;
            if(enterAniName)then
                break;
            end
        end
    end
    return enterAniName,enterSound;
end

function this:PlayEmotes()
    local emote1,emote2 = FightClient:GetEmote(eEmoteState.Start);
    --emote1,emote2 = 1,2;
    if(emote1 and emote2)then
        --Tips.ShowTips("播放战斗表情：" .. tostring(emote1) .. "|" .. tostring(emote2));
        FuncUtil:Call(function()
            EventMgr.Dispatch(EventType.Fight_Play_Face,{{id=emote1},{id=emote2}});     
        end,nil,1000);         
        FuncUtil:Call(self.PlayCharacterFightStart,self,3000);
    else
        self:PlayCharacterFightStart(); 
    end
end



 --播放角色开场
 function this:PlayCharacterFightStart() 
    --开场镜头
    local sceneId = FightClient:GetSceneId();

    if(sceneId ~= nil) then
       local cfgScene = Cfgs.scene:GetByID(sceneId);
       local cameraSetting = cfgScene.camera_setting;
       if(cameraSetting ~= nil)then
            for _,v in ipairs(cameraSetting)do
                CameraMgr:ApplyCommonAction(nil,v);
            end
        else            
            CameraMgr:ApplyCommonAction(nil,"enter_fight");

            local time = 3000;
            FuncUtil:Call(self.OnCameraActionComplete,self,time);
        end
    end         

--    角色开场动作
--    FuncUtil:Call(self.PlayCharacterEnter,self,500,false);
--    FuncUtil:Call(self.PlayCharacterEnter,self,500,true);
    self:PlayCharacterEnter(false);
    self:PlayCharacterEnter(true);
end

function this:PlayFightStart()
--    local xluaCamera = CameraMgr:GetXLuaCamera();
--    if(xluaCamera)then
--        cameraEffs = {{res="battlestart_cameraEff_01"}};
--        xluaCamera.CreateCameraEffs(cameraEffs);             
--    end 
end


--角色入场动作准备
function this:PlayCharacterEnterReady()
    local characters = CharacterMgr:GetAll();
    if(characters)then
        for _,character in pairs(characters)do
            character.EnterState("enter_ready");
        end
    end
end

--角色开场动作
function this:PlayCharacterEnter(isEnemy)
    EventMgr.Dispatch(EventType.Character_FightInfo_Show,false); 

    local characters = CharacterMgr:GetAll();
    if(characters)then
        for _,character in pairs(characters)do
            if(character.IsEnemy() == isEnemy)then
                 character.EnterState("enter");
                 character.ApplyEnterShake();
            end
        end
    end
end

function this:OnCameraActionComplete()
    CameraMgr:CloseAllCamera();
    EventMgr.Dispatch(EventType.Fight_View_Main_Info_Show_State,true);
    EventMgr.Dispatch(EventType.Fight_View_Show_Changed,true); 
    EventMgr.Dispatch(EventType.Fight_UI_Enter_Action);
    self:Complete();    
end


return this;
