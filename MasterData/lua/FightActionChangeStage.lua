--战斗切换周目

FightActionChangeStage = oo.class(FightActionBase);
local this = FightActionChangeStage;

function this:OnPlay()    
   self:PlayWave();  
end

function this:PlayWave()
   EventMgr.Dispatch(EventType.Fight_Info_Update,{ round = self.data.round });  --更新Wave数   

   CSAPI.DisableInput(2000);
   --local enterAniName = self:GetEnterAni();
   --if(not enterAniName)then
   CSAPI.OpenView("FightWave",self.data.round);   
   --end

   EventMgr.Dispatch(EventType.Character_FightInfo_Show,false); 
   EventMgr.Dispatch(EventType.Fight_View_Main_Info_Show_State,false);   
   --CSAPI.PlayBGM(self.data.bgm);
   EventMgr.Dispatch(EventType.Play_BGM_New, {bgm = self.data.bgm});
   FuncUtil:Call(self.OnPlayWaveComplete,self,500);

   local enterAniName,enterSound = self:GetEnterAni();
    if(enterAniName)then   
         CSAPI.StopBGM();    
    end
end

function this:OnPlayWaveComplete()
   self:PlayPlot();
end

function this:PlayPlot()
    local cfg = nil;
    if(FightClient:IsNewPlayerFight())then
        local fightIds = PlayerClient:GetNewPlayerFightIDs();
        local fightId = fightIds and fightIds[1];
        cfg = Cfgs.MonsterGroup:GetByID(fightId);
    else
        cfg = DungeonMgr:GetFightMonsterGroup();
    end
    local storyKey = "storyWave" .. (self.data.round or 0);
    if(cfg and cfg[storyKey])then
        PlotMgr:TryPlay(cfg[storyKey],self.OnPlotComplete,self);
    else
        self:OnPlotComplete();
    end
end

function this:OnPlotComplete()    
	ReleaseMgr:ApplyRelease({"textures_bigs"});--释放掉剧情加载的大图资源
    
    local enterAniName,enterSound = self:GetEnterAni();
    if(enterAniName)then       
        FuncUtil:Call(function()   
            CSAPI.StopBGM();
            CSAPI.SetBGMLock("boss_enter");
            CameraMgr:EnableMainCamera(false);  
            
   --[[          local enterAni = ResUtil:PlayVideo(enterAniName);
            CameraMgr:EnableMainCamera(false);
            enterAni:AddCompleteEvent(function()    
                CameraMgr:EnableMainCamera(true);       
                self:PlayEnter();
                EventMgr.Dispatch(EventType.Replay_BGM);
            end);  ]]

            CSAPI.OpenView("VideoPlayer", {
                videoName = enterAniName,
                callBack = function()
                    CSAPI.CloseView("VideoPlayer");
                    CameraMgr:EnableMainCamera(true);
                    CSAPI.SetBGMLock();
                    CSAPI.StopSound();
                    EventMgr.Dispatch(EventType.Replay_BGM);

                    self:PlayEnter();
                end,
            });


            if(enterSound)then
                CSAPI.PlaySound("fight/effect/" .. enterSound .. ".acb",enterSound);
            end
           
        end,nil,1650);

    else
        FuncUtil:Call(self.FightContinue,self,3000,false);       
    end

    FuncUtil:Call(self.Complete,self,300);       
end

function this:PlayEnter()   
    if(self.enterTarget)then
        local enterCharacter = CharacterMgr:Get(self.enterTarget.id);
        if(enterCharacter)then
            enterCharacter.EnterState("enter");
            enterCharacter.ApplyEnterShake();
        end
    end 
 
    FuncUtil:Call(self.FightContinue,self,2000,false);      
end

--获取入场动画
function this:GetEnterAni()
    local enterAniName;
    local enterSound;
    local data = self.data;
 
    if(data and data.datas)then
        for _,targetData in ipairs(data.datas)do        
            local characterData = targetData.characterData; 
            --local cfgModel = Cfgs.character:GetByID(characterData.model);
            local cfg = Cfgs.MonsterData:GetByID(characterData.cfgId);
            if(cfg)then
                enterAniName = cfg.enter_ani;
                enterSound = cfg.enter_sound;
                if(enterAniName)then
                    self.enterTarget = characterData;
                    break;
                end
            end
        end
    end
    return enterAniName,enterSound;
end


function this:OnComplete()
    EventMgr.Dispatch(EventType.Character_FightInfo_Show,false);    
    EventMgr.Dispatch(EventType.Fight_View_Main_Info_Show_State,true);
    if(self.enterTarget)then
        FuncUtil:Call(self.PlayEnterReady,self,200);       
    end
end

function this:PlayEnterReady()
    if(self.enterTarget)then
        local enterCharacter = CharacterMgr:Get(self.enterTarget.id);
        if(enterCharacter)then
            enterCharacter.EnterState("enter_ready");
        end
    end 
end

function this:FightContinue()
    FightActionUtil:SetServerDatasHangUpState(false);
end

return this;
