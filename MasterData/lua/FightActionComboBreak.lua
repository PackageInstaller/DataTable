--解体
FightActionComboBreak = oo.class(FightActionBase);
local this = FightActionComboBreak;

function this:SetData(fightActionData)
    CSAPI.LoadABsByOrder({"prefabs_characters_combo"});--预加载解体资源

    FightActionBase.SetData(self,fightActionData);
    self:Preload(fightActionData.datas);
end
--预加载角色
function this:Preload(datas)   
    CharacterMgr:PreloadCharacters(datas,self.OnPreloadCallBack,self)
end
--预加载完成回调
function this:OnPreloadCallBack()
    self.preloadComplete = 1;
    self:ApplyStart();
end

function this:OnPlay()
    self.isStart = 1;    
    self:ApplyStart();  

    --self:TestCamera();
end

function this:OnClean()
    self.isStart = nil;
    self.preloadComplete = nil;
end

function this:ApplyStart()
    if(self.preloadComplete == nil or self.isStart == nil)then
        return;
    end

    self:PlayBreak();

    FuncUtil:Call(self.OnShow,self,1000);
end


function this:OnShow()    
    self:RemoveBreak();

    FuncUtil:Call(self.CreateComboBreakCharacters,self,500);

    FuncUtil:Call(self.ApplyComplete,self,1500);
end

function this:ApplyComplete()
    EventMgr.Dispatch(EventType.Character_HeadInfo_Scale_State,true);
    self:Complete();
end

--合体者行动动作
function this:PlayBreak()    
    local character = self:GetActorCharacter();
    --动作
    if(character == nil)then
        LogError("解体失败！同调角色不存在");
        return;
    end
    character.ApplyCast("combobreak");    
    --将合体者移出战场
    character.PutOut(); 

    local cfgModel = character.GetCfgModel();
    if(cfgModel)then
        CSAPI.PlayRandSound(cfgModel.s_combo_break,true);
    end
end

function this:CreateComboBreakCharacters()
    local comboTargets = CharacterMgr:CreateCharacters(self.data.datas);
    if(comboTargets)then
       for _,c in ipairs(comboTargets)do
          if(c)then
              local x,y,z = c.GetPos();
              --ResUtil:CreateEffect("combo/combo_break_eff1",x,y,z);
              CSAPI.CreateGO("Characters/combo/combo_break_eff1",x,y,z);
              --还原解体角色buff
              local buffDatas = g_FightMgr and g_FightMgr:RestoreObjBuffer(c.GetID());    
              if(buffDatas)then
                for _,buffData in ipairs(buffDatas)do
                    ClientBuffMgr:RemoveBuff(buffData.uuid);
                end 
              end   
              ClientBuffMgr:ClearRemovedBuffIds();       
              FightActionUtil:PlayAPIsByOrder(buffDatas);
              c.SetShowState(false);
              FuncUtil:Call(c.SetShowState,nil,300,true);
          end
       end
   end   
end

--移除合体角色
function this:RemoveBreak()
    local character = self:GetActorCharacter();
    if(character == nil)then
        return;
    end
    --合体特效
    local x,y,z = character.GetPos();
    --ResUtil:CreateEffect("combo/combo_break_eff",x,y,z);
    CSAPI.CreateGO("Characters/combo/combo_break_eff",x,y,z);
    FuncUtil:Call(character.Remove,nil,300);
end

----测试镜头
--function this:TestCamera()
--    local character = self:GetActorCharacter();
--    local teamId = character.GetTeam();

--    local x,y,z = FightGroundMgr:GetCenter(teamId);
--    local time = 200;

--    CameraMgr:MoveTo(x,y,z,time);
--    CameraMgr:SetViewAngle(45,0,time);
--    CameraMgr:ZoomInTime(400,time);
--end

return this;