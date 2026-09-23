--战斗回合
if(InputPlayer == nil)then
    InputPlayer = require "FightActionPlayer_Input";
end

FightActionTurn = oo.class(FightActionBase);
local this = FightActionTurn;

function this:OnPlay()  
    --LogError("测试信息忽略========================");    
    EventMgr.Dispatch(EventType.Fight_Info_Update,{ turnData = self.data });
    local turnNum = self.data and self.data.turnNum;
    if(turnNum)then
        FightClient:SetTurn(turnNum);
    end
    local leftTurn;
    if(turnData and turnData.nStepLimit and turnData.turnNum)then
        leftTurn = turnData.nStepLimit - turnData.turnNum + 1;
    end
    if(FightClient:IsWarningTurn(leftTurn))then
        FuncUtil:Call(self.TurnContinue,self, g_turn_timeout_warning_time or 1500);
    else
        self:TurnContinue();
    end

    local faDeadCheck = FightActionMgr:Apply(FightActionType.DeadChecker);
    faDeadCheck.queueType = QUEUE_TYPE.Green;
    FightActionMgr:Push(faDeadCheck);
end
function this:TurnContinue()
    EventMgr.Dispatch(EventType.Input_Target_Changed,self);
    

    self:ApplyTurnDatas();
    if(self:IsMotionless())then
        self:ApplyMotionless();
    else       
        --触发新手战斗引导
        --if(not PlayerClient:IsPassNewPlayerFight())then
            local character = self:GetActorCharacter();
            if(character and not character.IsEnemy())then
                EventMgr.Dispatch(EventType.Guide_Trigger,"Fight");
            else
                if(FightClient:IsNewPlayerFight())then
                    EventMgr.Dispatch(EventType.Guide_Trigger,"EnemyFight");
                end
            end
        --end   
        
        InputPlayer:Play(self);     
    end
end


function this:ApplyMotionless()
    CameraMgr:ApplyCommonAction(self,"to_default_camera");   
    local character = self:GetActorCharacter();
    if(not character)then
        return;
    end

    character.SetShowState(true);

    local effKey = self:GetMotionlessEff(self.data.isMotionless);
    if(effKey)then
        self:CreateEff(character,effKey);
    end
    
    FuncUtil:Call(self.Complete,self,2000);

    if(eMotionlessType.Cage == self.data.isMotionless)then
        character.EnterState("cage");    
        FuncUtil:Call(self.ShowCageDamage,self,700,character);
    else
        FuncUtil:Call(self.MotionlessFloatFont,self,500,character);
    end   
end

function this:ShowCageDamage(character)
    if(character)then
        character.ShowCageDamage();
    end
end

function this:OnComplete()
    if(self:IsMotionless())then
        EventMgr.Dispatch(EventType.Fight_Damage_Show_State,nil);
    end
end

function this:MotionlessFloatFont(character)
    if(character)then
        character.CreateFloatFont("motionless");
    end
end

function this:CreateEff(character,effKey)

    local cfg = Cfgs.buff_effect:GetByKey(effKey);

    local go = CSAPI.CreateGO("BuffEff",0,0,0,character.GetBuffEffNode());
    local be = ComUtil.GetLuaTable(go);     
    be.Set(cfg);   
end

function this:ApplyTurnDatas()
    local datas = self.data and self.data.datas;
    if(datas and #datas > 0)then        
        FightActionUtil:PlayAPIsByOrder(datas);        
    end
end
--是否禁止行动
function this:IsMotionless()
    return self.data and self.data.isMotionless;
end
function this:GetMotionlessEff(motionlessType)
    if(self.motionlessEffs == nil)then
        self.motionlessEffs = {};
        self.motionlessEffs[eMotionlessType.Palsy] = "paralysis";
    end

    return self.motionlessEffs[motionlessType];
end


--获取镜头增高
function this:GetCameraAddHeight(posRef)
    local character = self:GetActorCharacter();
    if(character)then
        return character.GetCameraAddHeight();
    end
    return 0;
end

return this;
