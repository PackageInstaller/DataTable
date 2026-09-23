--召唤友军角色
FightActionSummonTeammate = oo.class(FightActionBase);
local this = FightActionSummonTeammate;


--设置父FightAction
function this:SetParent(fightAction)
    FightActionBase.SetParent(self,fightAction);
    self.master = fightAction:GetActorCharacter();
end

function this:SetData(fightActionData)
    FightActionBase.SetData(self,fightActionData);
    self:Preload(fightActionData.datas);

    --LogError(fightActionData);
end
--预加载角色
function this:Preload(datas)   
    CharacterMgr:PreloadCharacters(datas,self.OnPreloadCallBack,self)
end
--预加载完成回调
function this:OnPreloadCallBack()
    self.isPreloaded = 1;
    self:ApplyCreate();
end

function this:OnPlay()   
    self:PlayPrePlot();
end

function this:PlayPrePlot()
    local plotId = self.data.pre;
    if(plotId)then
        PlotMgr:TryPlay(plotId,self.OnPrePlotComplete,self,true);
    else
        self:OnPrePlotComplete();
    end
    
end
function this:OnPrePlotComplete()
    self.isPlayed = 1;
    self:ApplyCreate();
end

function this:PlayAftPlot()
    local plotId =  self.data.after;
    if(plotId)then
        PlotMgr:TryPlay(plotId,self.OnAftPlotComplete,self,true);
    else
        self:OnAftPlotComplete();
    end
end
function this:OnAftPlotComplete()
    FuncUtil:Call(self.Complete,self,200); 
end

function this:OnClean()
    self.isSummonShow = nil;
    self.isSummonCreated = nil;
    self.isPreloaded = nil;
    self.isPlayed = nil;

  
    self.summons = nil;
end

function this:ApplyCreate()
    if(not self.isPreloaded or not self.isPlayed)then
        return;
    end

   self.summons = CharacterMgr:CreateCharacters(self.data.datas);
   self:SetSummonsShowState(false);
   self.isSummonCreated = 1;

   self:SummonEnter();

   local data = self.data;
   local summoner = CharacterMgr:Get(data and data.id);
   local summonData = summoner and summoner.GetCastStateData("SummonTeammate");
  
   local delay = summonData and summonData.play_time or 2000;
   FuncUtil:Call(self.PlayAftPlot,self,delay);    
end

function this:SetSummonsShowState(isShow)
    if(not self.summons)then
        return;
    end
    for _,character in ipairs(self.summons)do
        character.SetShowState(isShow);
    end
end
--召唤者进场
function this:SummonEnter()    
    self.isSummonShow = 1;
    self:ApplySummonShow();
end

function this:ApplySummonShow()
    if(self.isSummonShow and self.isSummonCreated)then        
        self:SummonShow();
    end
end

function this:SummonShow()
--this:GetFireBallData(castState)
   local data = self.data;
   local summoner = CharacterMgr:Get(data and data.id);
   local stateHash = CSAPI.StringToHash("SummonTeammate");
   local fbDatas = summoner and summoner.GetFireBallDataByKey(stateHash);  
   local fbData = fbDatas and fbDatas[1];

    local fbName = "common/character_appear";
    if(fbData)then
        local packName = fbData.effect_pack or summoner.GetModelName();
        if(fbData.effect)then
            fbName = packName .. "/" .. tostring(fbData.effect);
        end
    end
    self:SetSummonsShowState(true);
    for _,character in ipairs(self.summons)do      
        local x,y,z = character.GetPos();
        if(fbName)then
            ResUtil:CreateEffect(fbName,x,y,z);
        end
        --local soundActionName = "lokotunjailurus_recruit_move_02";
        --CSAPI.PlaySound("fight/effect/lokotunjailurus.acb",soundActionName,false,false,nil,nil,nil,nil,100);
        --character.PlayActionSound();
    end
end

return this;