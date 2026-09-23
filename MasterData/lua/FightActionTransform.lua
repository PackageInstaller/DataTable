--战斗变身

FightActionTransform = oo.class(FightActionBase);
local this = FightActionTransform;

function this:SetData(fightActionData)
    FightActionBase.SetData(self,fightActionData);
   
    self:Preload(fightActionData.model);
end
--预加载角色
function this:Preload(model)   
    local callBack = FuncUtil:ApplyCallBackFunc(self.OnPreloadCallBack,self);
    ResUtil:LoadCharacterAbs(model,callBack.OnCallBack);   
end
--预加载完成回调
function this:OnPreloadCallBack()
    self.preloadComplete = 1;
    self:ApplyCreate();
end


function this:ApplyCreate()
    if(self.preloadComplete == nil or self.isStart == nil)then
        return;
    end
    local cfgModel = Cfgs.character:GetByID(self.data.model); 
    
    resCallBack = self.OnResLoadComplete;
    resCaller = self;

    CharacterMgr:LoadModel(cfgModel,nil,OnResLoadCallBack);     
end

function OnResLoadCallBack(go)
   
    if(resCallBack)then
        resCallBack(resCaller,go);

        resCallBack = nil;
        resCaller = nil;
    end
end

function this:OnResLoadComplete(go)
    if(IsNil(go))then
        LogError("变身失败！！！找不到目标角色模型资源")
        LogError(self.data)
    end
   
    self.goModel = go;
    CSAPI.SetPos(go,-1000,0,0);

     --获取技能配置
    local cfgSkill = Cfgs.skill:GetByID(self.faParent:GetSkillID());
    local character = self:GetActorCharacter();
    --变身者播放动作
    local castName = cfgSkill.cast
   
    character.ApplyCast(castName);
    local transformData = character.GetCastStateData(castName);   
    if(transformData == nil)then
        LogError("找不到变身数据！！！");
    end
    
    local delay = transformData and transformData.transform_delay or 0;
    FuncUtil:Call(self.PlayTransform,self,delay);

    FuncUtil:Call(self.Complete,self,transformData and transformData.play_time or 2000);
end

function this:OnClean()
    self.isStart = nil;
    self.preloadComplete = nil;

    self.goModel = nil;
end


function this:OnPlay()    
    self.isStart = 1;
    self:ApplyCreate();  
end
--播放变身
function this:PlayTransform()
   local character = self:GetActorCharacter();
   local cfgSkill = Cfgs.skill:GetByID(self.faParent:GetSkillID());
 
   local transformData = character.GetCastStateData(cfgSkill.cast);  
   character.SetTransformState(self.data.state);
    CharacterMgr:SetTransformState(character.GetID(),self.data.state);
   --LogError(self.data);
   character.ReplacedModel(self.data.model,self.goModel);  
   
   if(transformData)then
       local enterState = transformData and transformData.transform_enter_state;      
       if(enterState)then
            --变身后播放动作           
           character.ApplyCast(enterState);
       end
   end 

   character.InitSkills(self.data.skills);

   local cfg = character.GetCfg();
   if(cfg.transformBGM)then
       EventMgr.Dispatch(EventType.Play_BGM, cfg.transformBGM);
   end 
end

return this;
