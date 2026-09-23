--合体
FightActionCombo = oo.class(FightActionBase);
local this = FightActionCombo;

function this:SetData(fightActionData)
    CSAPI.LoadABsByOrder({"prefabs_characters_combo"});--预加载合体资源

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
end

function this:OnClean()
    self.isStart = nil;
    self.isShowed = nil;
    self.preloadComplete = nil;
    self.combos = nil;
    self.comboer = nil;
end

function this:IsSkip()
    local character = self:GetComber();

    local state = character and character.IsSkipSkill();
    --LogError(state and "tt" or "ff");
    return state;
end

function this:ApplyStart()
    if(self.preloadComplete == nil or self.isStart == nil)then
        return;
    end

    local comber = self:GetComber();
    EventMgr.Dispatch(EventType.Fight_Mask,comber and comber.GetID()); 
    FuncUtil:Call(self.ShowCombo,self,FightClient:GetFightMaskDelayTime());    
end
function this:ShowCombo()
    if(self:IsSkip())then
        self:RemoveCombos();
        self:ShowComboCharacter();
        return;
    end


    EventMgr.Dispatch(EventType.Fight_Skill_Skip,true); 

    self:SetUIState(false);
    --EventMgr.Dispatch(EventType.Character_HeadInfo_Scale_State,false);

    CharacterMgr:SetAllShowState(false);
    self:InitCamera();   
    self:RemoveCombos();        
    FuncUtil:Call(self.ShowNext,self,4500);
    FuncUtil:Call(EventMgr.Dispatch,nil,4000,EventType.Fight_Skill_Skip,false);
    --EventMgr.Dispatch(EventType.Fight_Skill_Skip,false); 
end

function this:SetUIState(state)
    EventMgr.Dispatch(EventType.Scene_Mask_Changed,not state);
    EventMgr.Dispatch(EventType.Fight_View_Show_Changed,state);
    EventMgr.Dispatch(EventType.Fight_View_Main_Info_Show_State,state);    
    EventMgr.Dispatch(EventType.Character_FightInfo_Show,state); 
    EventMgr.Dispatch(EventType.Fight_View_Mask,state); 
end

function this:ShowNext()
    self:PlayEnterVideo();
end

function this:PlayEnterVideo()
    --CSAPI.OpenView("VideoPlayer",{videoName = "combo_s50010",callBack = self.OnVideoComplete,caller = self});   
    local aniName;-- = "combo_s50010";
    local comboer = self:GetComber();
    if(comboer)then
        local cfgModel = comboer.GetCfgModel();
        aniName = cfgModel and cfgModel.combo_ani;-- or "combo_s50010";
        --LogError(cfgModel);
        comboer = nil;
    end

    if(aniName and not FightActionMgr:IsSkiping())then
        EventMgr.Dispatch(EventType.Fight_Skill_Skip,false); 
        local comboAni = ResUtil:PlayVideo(aniName); 
        comboAni:AddCompleteEvent(function()           
            --self:OnVideoComplete();
            EventMgr.Dispatch(EventType.Fight_Mask); 
            FuncUtil:Call(self.OnVideoComplete,self,350);
--            FuncUtil:Call(CSAPI.RemoveGO,nil,200,comboAni.gameObject);
        end); 

        --FuncUtil:Call(self.OnVideoComplete,self,1000);--保护性代码
    else
        EventMgr.Dispatch(EventType.Fight_Mask); 
        FuncUtil:Call(self.OnVideoComplete,self,350);
    end    
end
function this:OnVideoComplete()
    self:ShowComboCharacter();
end
    
function this:ShowComboCharacter()
    if(self.isShowed)then
        return;
    end
    self.isShowed = 1;   

    self:CreateComboCharacters();
    --FuncUtil:Call(self.CreateComboCharacters,self,100);
    
    if(luaCamera)then
        luaCamera.Remove();
        luaCamera = nil;
    end
    CharacterMgr:SetAllShowState(true);
    FuncUtil:Call(self.ApplyComplete,self,self:IsSkip() and 500 or 2000);    
    self:SetUIState(true);
    EventMgr.Dispatch(EventType.Character_HeadInfo_Scale_State,false);     
    --EventMgr.Dispatch(EventType.Scene_Mask_Changed,false);
end

function this:ApplyComplete()
    FightActionMgr:TryStopSkip(); 
    --self:SetUIState(true);
    EventMgr.Dispatch(EventType.Character_HeadInfo_Scale_State,true);     
    self:Complete();
end

function this:InitCamera()    
    local isSkip = FightActionMgr:IsSkiping() or FightActionMgr:GetAutoSkipNext();

    local go = nil;
    if(not isSkip)then
        go = CSAPI.CreateGO("Characters/combo/combo_camera");
    end
    luaCamera = go and ComUtil.GetLuaTable(go);

    local data = self:GetData();

    local combos = self:GetCombos();
    for _,character in ipairs(combos)do
        character.SetShowState(true);
        character.ClearFlip();
        if(character == self:GetComber())then
            if(luaCamera)then
                luaCamera.SetComboer(character);
            end
            if(character)then
                character.SetComboEffShowState(true);
                local cfgModel = character.GetCfgModel();
                if(cfgModel and cfgModel.s_combo)then
                    if(not FightActionMgr:IsSkiping() and not FightActionMgr:GetAutoSkipNext())then
                        CSAPI.PlayRandSound(cfgModel.s_combo,true);
                    end                    
                end
            end
        else
            if(luaCamera)then
                luaCamera.SetComboTarget(character);
            end
            
            CSAPI.ApplyAction(character.gameObject,"action_combo_shader");
            CSAPI.ApplyAction(character.gameObject,"action_combo");
        end
    end
end

function this:GetComber()    
    if(not self.comboer)then
       local data = self:GetData();
       self.comboer = CharacterMgr:Get(data and data.id);
    end

    return self.comboer;
end

function this:CreateComboCharacters()
    local comboTargets = CharacterMgr:CreateCharacters(self.data.datas);
    if(comboTargets)then
       for _,character in ipairs(comboTargets)do
          if(character)then
              --local x,y,z = character.GetPos();
              --ResUtil:CreateEffect("battle/monster_born",x,y,z);
              FuncUtil:Call(self.PlayComboEnter,self,10,character);     
          end
       end
   end   
end

function this:PlayComboEnter(character)
    EventMgr.Dispatch(EventType.Character_HeadInfo_Scale_State,false);       
    character.ApplyCast("combo_enter");  
    EventMgr.Dispatch(EventType.Fight_Img_Update,character);
end

----合体者行动动作
--function this:PlayCombo()    
--    local combos = self:GetCombos();
--    for _,character in ipairs(combos)do
--        --动作
--        character.ApplyCast("combo");    
--        --将合体者移出战场
--        character.PutOut();
--    end
--end

--移除合体角色
function this:RemoveCombos()
    local data = self:GetData();
    local combos = self:GetCombos();
    for _,character in ipairs(combos)do
        character.PutOut();
        local removeDelay = 3000;
        if(data and data.id == character.GetID())then                   
            removeDelay = 4800;            
            FuncUtil:Call(self.DisableComboEff,self,removeDelay - 50,character);
        end
        removeDelay = self:IsSkip() and 0 or removeDelay;
        FuncUtil:Call(character.Remove,nil,removeDelay);
    end
end

function this:DisableComboEff(character)
    if(character)then        
        character.SetComboEffShowState(false);
    end
end

function this:GetCombos()  
    if(self.combos == nil)then
        self.combos = {};
        if(self.data == nil or self.data.ids == nil)then
--            LogError("没有合体角色");
--            LogError(self.data);
            Tips.ShowTips("no unite target");
            return;
        end
        --LogError(self.data.ids);
        for _,id in ipairs(self.data.ids)do           
            local character = CharacterMgr:Get(id);

            if(character)then
                table.insert(self.combos,character); 
            else
                LogError("找不到合体角色" .. id);   
            end
        end
    end
    
    return self.combos;
end

return this;