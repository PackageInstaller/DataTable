--角色输入播放器

--local SceneInput = nil;
local GetScenePos;
--local GetScreenPos;


local this = {};


--当前输入控制角色
this.character = nil;
--当前行为
this.fightAction = nil;
--场景输入位置
this.sceneInputPos = {};
--选中技能配置
this.currSelSkill = nil;

--范围映射表
this.rangeMaps = nil;

function this:Init()

    EventMgr.AddListener(EventType.Input_Select_Skill,this.OnInputSelectSkill); 
    EventMgr.AddListener(EventType.Input_Select_Relive,this.OnInputSelectRelive); 
    EventMgr.AddListener(EventType.Input_Select_Transform,this.OnInputSelectTransform); 
        

    EventMgr.AddListener(EventType.Fight_Action_Enqueue,this.OnFightActionEnqueue);

    EventMgr.AddListener(EventType.Input_Scene_Down,this.OnInputSceneDown);
    --EventMgr.AddListener(EventType.Input_Scene_Move,this.OnInputSceneMove);
    EventMgr.AddListener(EventType.Input_Scene_Up,this.OnInputSceneUp);
    
    EventMgr.AddListener(EventType.Input_Auto_Change,this.OnInputAutoChange);
    --输入确定
    EventMgr.AddListener(EventType.Input_Select_Grid,this.OnInputSelectGrid);

    --输入取消
    EventMgr.AddListener(EventType.Input_Select_Cancel,this.OnInputSelectCancel);
    

    --场景加载完成
    EventMgr.AddListener(EventType.Scene_Load_Complete,this.OnSceneLoadComplete);
    --Overload状态变化
    EventMgr.AddListener(EventType.Input_Overload_State_Changed,this.OnOverLoadStateChanged);
    EventMgr.AddListener(EventType.Fight_Move_Character,this.OnFightMoveCharacter);
    
    --投降
    EventMgr.AddListener(EventType.Fight_Surrender,this.OnFightSurrender);
    --清理
    EventMgr.AddListener(EventType.Fight_Clean,this.OnFightClean);
    
    self:Clear();
end


function this.OnOverLoadStateChanged(state)
    this:SwitchOverload(state);
end

--移动角色
function this.OnFightMoveCharacter()
    this:FightMoveCharacter();
end
function this:FightMoveCharacter()
    CameraMgr:ApplyCommonAction(self.fightAction,CameraActionMgr.sel_my_character);
    self:SetCameraIdleState(false);
    FightGridSelMgr.SetMoveCharacter(true);

    local rangeLimit = self:GetLimitMainFightRange();
    FightGridSelMgr.Show(TeamUtil.ourTeamId,{},rangeLimit,nil,1);
end

--投降处理
function this.OnFightSurrender()
    this:FightSurrender();    
end
function this:FightSurrender()
    if(not self.fightAction)then        
        return;
    end
    self:ApplyComplete();
end

function this.OnFightClean()
    this:FightClean();   
end
function this:FightClean()
    if(not self.fightAction)then        
        return;
    end
    self:ApplyComplete();
end

--行为入列
function this.OnFightActionEnqueue(fightAction)
    this:FightActionEnqueue(fightAction);    
end
function this:FightActionEnqueue(fightAction)    

    if(fightAction and fightAction:GetType() == FightActionType.OverLoad and not fightAction.data.flag)then
        local xluaCamera = CameraMgr:GetXLuaCamera();
        if(xluaCamera)then
             xluaCamera.CreateCameraEffs({{res="overload/replace_camera_OverLoad01"},{res="overload/replace_camera_OverLoad01_Eff"}});
        end                      
    end

    if(self.fightAction == nil)then
        return;
    end  
    
    if(self.fightAction == fightAction)then        
        return;
    end

    self:UpdateState();
end

--输入更新
function this:UpdateState()
    
    --无法行动
    if(self.fightAction:IsMotionless())then
        self:ApplyMotionless();
        return false;
    end

    local nextSkillFightAction = FightActionMgr:FindNextByType(FightActionType.Skill);
    --输入完成
    if(nextSkillFightAction ~= nil)then
        local skillDatas = self.fightAction:GetData().skillDatas;
        self:ApplyComplete();   

        if(skillDatas and not nextSkillFightAction:IsPlayerSkill())then
            EventMgr.Dispatch(EventType.Fight_Action_Turn_Add1); 
        end
        return false;
    end

    local endFightAction = FightActionMgr:FindNextByType(FightActionType.FightEnd);
    --输入完成
    if(endFightAction ~= nil)then
        self:ApplyComplete();
        --EventMgr.Dispatch(EventType.Fight_Action_Turn_Add1);
        return false;
    end

    local skipFightAction = FightActionMgr:FindNextByType(FightActionType.Skip);
    --跳过
    if(skipFightAction ~= nil)then
        self:ApplyComplete();
        --EventMgr.Dispatch(EventType.Fight_Action_Turn_Add1);
        return false;
    end

    local nextOverLoadFightAction = FightActionMgr:FindNextByType(FightActionType.OverLoad);
    if(nextOverLoadFightAction ~= nil)then         
        self:SwitchOverload(true);    
    end
    
    return true;--输入中
end

function this:ApplyMotionless()
    CameraMgr:ApplyCommonAction(self,"to_default_camera");    
    local character = self.fightAction:GetActorCharacter();
    FuncUtil:Call(self.MotionlessFloatFont,self,500,character);
    FuncUtil:Call(self.ApplyComplete,self,2000);
end
function this:MotionlessFloatFont(character)
    if(character)then
        character.CreateFloatFont("motionless");
    end
end


function this.OnSceneLoadComplete()
    this:Clear();
end

function this:SwitchOverload(state)
    self.overload = state;
end

function this:GetOverloadSkillId()
    local skillDatas = self.fightAction:GetData().skillDatas;
    if(skillDatas)then
        for skillId,skillData in pairs(skillDatas)do
            local isOverloadSkill = SkillUtil:IsOverloadSkillId(skillId);
            if(isOverloadSkill)then
                return skillId;
            end
        end
    end
end

function this:Clear()
    self.rangeMaps = {};
end

--点击复活技能
function this.OnInputSelectRelive(data)
    this:InputSelectRelive(data);
end
function this:InputSelectRelive(data)
    if(not data or not data.skillId)then
        return;
    end


    local skillId = data.skillId;
    local cfgSkill = self.character.GetSkill(skillId);
    if(cfgSkill == nil)then
        --LogError("目标角色不存在技能，skillId：" .. skillId .. "，角色id" .. self.character.GetID() .. "，角色配置id" .. self.character.GetModelID());
        cfgSkill = Cfgs.skill:GetByID(skillId);
        if(cfgSkill and cfgSkill.isCommander)then
            self.playerSkill = 1;
        end        
    else
        self.playerSkill = nil;
    end
    self.currSelSkill = cfgSkill;    



    self.reliveData = data.characterData;
--    不再需要选择位置
--    local placeHolderInfo = self.reliveData:GetPlaceHolderInfo();  
--    local rangeLimit = self:GetLimitMainFightRange();
--    FightGridSelMgr.SetMoveCharacter(false);
--    FightGridSelMgr.Show(TeamUtil.ourTeamId,placeHolderInfo,rangeLimit,nil,2);

--    CameraMgr:ApplyCommonAction(self.fightAction,CameraActionMgr.sel_my_character); 
--    self:SetCameraIdleState(false);
--    self:ApplySceneMaskIn();    

      --直接发送
      self:ApplyInput(true);  
end

--点击复活技能
function this.OnInputSelectTransform(data)
    this:InputSelectTransform(data);
end
function this:InputSelectTransform(data)
    self.transData = data.transData;
    self:InputSelectSkill(data.skillId);
end

function this:ApplySceneMaskIn()
    if(self.sceneMask)then
        return;
    end
    self.sceneMask = 1;
    local xluaCamera = CameraMgr:GetXLuaCamera();
    if(xluaCamera)then
        xluaCamera.ApplyMaskFadeIn("action_scene_camera_mask_fade_in1");
    end   
end
function this:ApplySceneMaskOut()
    if(not self.sceneMask)then
        return;
    end
    self.sceneMask = nil;
    local xluaCamera = CameraMgr:GetXLuaCamera();
    if(xluaCamera)then
        xluaCamera.ApplyMaskFadeOut("action_scene_camera_mask_fade_out1");
    end 
end


--点击技能
function this.OnInputSelectSkill(skillId)
    this:InputSelectSkill(skillId);
end
function this:InputSelectSkill(skillId)   
--    if(self.overload)then       
--        return;
--    end

    FightClient:SetSelSkill(skillId);

    if(not skillId)then
        return;
    end

    self.reliveData = nil;
    if(self.character == nil)then
        return;
    end
      
    local cfgSkill = self.character.GetSkill(skillId);

    if(cfgSkill == nil)then
        cfgSkill = Cfgs.skill:GetByID(skillId);
        if(cfgSkill and cfgSkill.isCommander)then
            self.playerSkill = 1;
        end
    else       
        self.playerSkill = nil;
        --LogError("目标角色不存在技能，skillId：" .. skillId .. "，角色id" .. self.character.GetID() .. "，角色配置id" .. self.character.GetModelID());        
    end
    
    
        

    local teamId = self.character.GetTeam();

    if(TeamUtil:IsEnemyCamp(cfgSkill.target_camp))then
        teamId = TeamUtil:GetOpponent(teamId);
    end

    local x,y,z = FightGroundMgr:GetCenter(teamId);


    CameraMgr:ApplyCommonAction(self.fightAction,TeamUtil:IsEnemy(teamId) and CameraActionMgr.sel_enemy_character or CameraActionMgr.sel_my_character);
    self:SetCameraIdleState(false);
    self:ApplySceneMaskIn(); 

    
    self.currSelSkill = cfgSkill;
    local rangeList,rangeLimit,isCross = self:GetSkillRangeList();
    local coverType = cfgSkill.type == SkillType.Summon and 2 or 1;
    --目标角色限制
    local idsLimit = self:GetIdsLimit();
    FightGridSelMgr.SetMoveCharacter(false);
    FightGridSelMgr.Show(teamId,rangeList,rangeLimit,idsLimit,coverType,isCross);
end
--获取技能范围
function this:GetSkillRangeList()
    local cfgSkill = self.currSelSkill;
    if(cfgSkill == nil)then
        return;
    end

    local teamId = self.character.GetTeam();

    if(TeamUtil:IsEnemyCamp(cfgSkill.target_camp))then
        teamId = TeamUtil:GetOpponent(teamId);
    end

   
    local cfgSkillRange = Cfgs.skill_range:GetByKey(cfgSkill.range_key);
    if(cfgSkillRange == nil)then
        return;
    end
    local rangeList = nil;

    local rangeType = cfgSkillRange and cfgSkillRange.range_type or 0;    

    if(rangeType == 0)then
        rangeList = cfgSkillRange.range;
    else
        local rangeKey = rangeType .. teamId;
        if(self.rangeMaps[rangeKey] == nil)then           
            self.rangeMaps[rangeKey] = self:GenSpecialRange(rangeType,teamId);
        end
        rangeList = self.rangeMaps[rangeKey]; 
    end

    local range_limit = cfgSkillRange.range_limit;
    if(cfgSkill.type == SkillType.Unite)then
        --合体技能范围限制
        range_limit = self.character.GetComboRangeLimit(); 
    elseif(cfgSkill.type == SkillType.Transform)then
        range_limit = self.character.GetGrids();
    end  
    return rangeList,range_limit,cfgSkillRange.cross;
end
--获取主战区
function this:GetLimitMainFightRange()
    return FightGroundMgr:GetLimitMainFightRange();
end

--构造特殊范围
function this:GenSpecialRange(rangetType,teamId)
    local list = {};
    if(rangetType == 1)then
        --打一排算的是列数
        local colCount = TeamUtil:IsEnemy(teamId) and FightGroundMgr.cfg.enemyCol or FightGroundMgr.cfg.myCol;
        for i = 1,colCount do
            table.insert(list,{1,i});
        end
    elseif(rangetType == 2)then
        --打一列算的是排数
        local rowCount = TeamUtil:IsEnemy(teamId) and FightGroundMgr.cfg.enemyRow or FightGroundMgr.cfg.myRow;
        --包括召唤区
        for i = 1,4 do
            table.insert(list,{i,1});
        end
    elseif(rangetType == 3)then
        --全部
        local rowCount = TeamUtil:IsEnemy(teamId) and FightGroundMgr.cfg.enemyRow or FightGroundMgr.cfg.myRow;
        local colCount = TeamUtil:IsEnemy(teamId) and FightGroundMgr.cfg.enemyCol or FightGroundMgr.cfg.myCol;
        for i = 1,4 do
            for j = 1,colCount do
                table.insert(list,{i,j});
            end
        end
    end
    return list;
end
--获取目标角色限制
function this:GetIdsLimit()
    local list = nil;
    if(self.currSelSkill ~= nil and self.currSelSkill.type == SkillType.Unite)then--合体目标限制
        local cfg = self.character.GetComboTargets();       
    elseif(self.currSelSkill ~= nil and self.currSelSkill.type == SkillType.Transform)then--变身目标只能选择自己
        list = { [self.fightAction:GetActorID()] = 1 };
    elseif(self.currSelSkill ~= nil and self.currSelSkill.isCanHurt)then
        --伤害型技能，判断是否有攻击目标限制（角色被嘲讽）
        list = self.character.GetSelLimits();
    elseif(self.currSelSkill ~= nil and TeamUtil:IsEnemyCamp(self.currSelSkill.target_camp) == false)then        
         local cfgSkillRange = Cfgs.skill_range:GetByKey(self.currSelSkill.range_key);
         if(cfgSkillRange)then
            local casterId = self.fightAction:GetActorID();
          

            if(cfgSkillRange.range_type == 5)then    
                --只能选择自己   
                list = list or {};
                list[casterId] = 1;
            elseif(cfgSkillRange.range_type == 4)then        
                --不能选择自己
                
                local all = CharacterMgr:GetAll();
                for id,targetCharacter in pairs(all) do
                    if(targetCharacter ~= nil and targetCharacter.IsMine())then
                        if(casterId ~= id)then
                            list = list or {};
                            list[id] = 1;
                        end
                    end
                end
            end
        end
    end
--    DebugLog("id列表=================================");
--    DebugLog(list);
    return list;
end


--场景输入开始
function this.OnInputSceneDown(param)
    this:InputSceneChanged(0);
end
--场景输入移动
function this.OnInputSceneMove(param)
    this:InputSceneChanged(1);
end
--场景输入结束
function this.OnInputSceneUp(param)
    this:InputSceneChanged(2);
end

local GetScenePos = CS.SceneInput.ins.GetScenePos;

function this:InputSceneChanged(inputState)    
    --self.sceneInputPos.x,self.sceneInputPos.y,self.sceneInputPos.z = GetScenePos(SceneInput);
    self.inputState = inputState;
    if(GetScenePos == nil or SceneInput == nil)then
        SceneInput = CS.SceneInput.ins;
        

        if(GetScenePos == nil)then
            LogError("获取不到场景输入！！");
            return;
        end
    end


    local x,y,z = GetScenePos(SceneInput);
    x = x * 0.01;
    y = y * 0.01;
    z = z * 0.01;
   
    FightGridSelMgr.SetPos(x,y,z,inputState);
    --LogError("inputState:" .. inputState);

    if(FightClient:GetInputCharacter())then
        self:DownInput(x,y,z,inputState);
    end
end

function this:DownInput(x,y,z,inputState)
    if(inputState == 2)then
        self.downTime = nil;
    else
        self.downTime = CSAPI.GetTime();
    end
  
    FuncUtil:Call(self.HandleDownInput,self,1000,x,y,z);
end
function this:HandleDownInput(x,y,z)
    if(g_FightMgr and IsPvpSceneType(g_FightMgr.type))then
        return;
    end
    if(not self.downTime)then
        return;
    end
    if(not FightClient:GetInputCharacter())then
        return;
    end

    local time = CSAPI.GetTime();
   
    if(time - self.downTime >= 0.9)then
        local characters = CharacterMgr:GetAll();

        local lastVal = 100;
        local selCharacter;
        for id,targetCharacter in pairs(characters) do
            local x1,y1,z1 = targetCharacter.GetPos();
            local val = math.abs(x1 - x) + math.abs(z1 - z);
            if(val < 4)then
                if(not selCharacter or val < lastVal)then
                    selCharacter = targetCharacter;
                    lastVal = val;
                end
            end
        end
        if(selCharacter)then    
            EventMgr.Dispatch(EventType.Input_Select_Cancel);    
            CSAPI.OpenView("FightRoleInfo",selCharacter.GetID());
        end
    end
end

function this.OnInputAutoChange()
    this:TrySendAuto(isComplete);
end
function this:TrySendAuto()
    if(self.fightAction)then
         FightClient:SendAutoFight();
    end
end

--选择格子
function this.OnInputSelectGrid(isComplete)   
    this:InputSelectGrid(isComplete);
end

function this.OnInputSelectCancel()
    this:CancelSelect();
end

--选择格子
function this.OnOverLoadOK()   
    this:ApplyInput(true);
end

function this:InputSelectGrid(isComplete)
    self:ApplyInput(isComplete); 
end

function this:ApplyInput(isComplete)
   
    if(self.character == nil)then
        return;
    end

    if(FightClient:IsAutoFight())then
        return;
    end

   
    local rowIndex = FightGridSelMgr.curRowIndex;
    local colIndex = FightGridSelMgr.curColIndex;

    local list = FightGridSelMgr.GetSelCharacterList();     

    local teamId = self.character.GetTeam();
    local cfgSkill = self.currSelSkill;
    if(not cfgSkill)then
        return;
    end
    
    if(TeamUtil:IsEnemyCamp(cfgSkill.target_camp))then
        teamId = TeamUtil:GetOpponent(teamId);
    end

    --测试镜像翻转用的
    if(_G.testFlip)then
        teamId = TeamUtil:GetOpponent(teamId);
    end

    teamId = TeamUtil:ToNetwork(teamId);
    
    local reliveId = nil;
    if(self.reliveData)then       
        reliveId = self.reliveData:GetID();
    end

    local transformState = nil;
    if(cfgSkill.type == SkillType.Transform)then      
        transformState = (self.transData and self.transData.index) or (self.character.GetTransformState() == 0 and 1 or 0);
    end

    local data = 
    {
        casterID = self.fightAction:GetActorID(),
        skillID = cfgSkill.id, 
        target =
            {
                teamID = teamId,
                pos = {rowIndex,colIndex},
                reliveID = reliveId;
                bTransfoState = transformState;
            }
    }
  

    if(self.overload)then       
        --self:PushInputData(data);
        data.skillID = self:GetOverloadSkillId();
    end


    --限制连续发送
    local sendTime = CSAPI.GetTime();
    local isSend = not self.lastSendTime or sendTime > self.lastSendTime + 1;

    if(isComplete and isSend)then
        self.lastSendTime = sendTime;
        DebugLog("战斗输入=============================" .. table.tostring(data));
        --记录发送的战斗协议
        ProtocolRecordMgr:RecordFight(data,1);
        CSAPI.DisableInput(1000);

        if(self.playerSkill)then
            FightProto:SendCmd(CMD_TYPE.Commander,data);  
            self.usePlayerSkill = 1;
        else
            FightProto:SendCmd(CMD_TYPE.Skill,data);     
        end
    end
end

function this:PushInputData(data)
    self.overloadData = self.overloadData or {}; 
    table.insert(self.overloadData,data);
end

function this:Reset()
    self.character = nil;
    self.fightAction = nil;
    self.overload = nil;
    self.overloadData = nil;
    self.reliveData = nil;
    self.playerSkill = nil;
    self.currSelSkill = nil;
    FightClient:SetInputCharacter();
end

--播放
function this:Play(fightAction)


--    if(_G.testTime)then
--        local myTime = CSAPI.GetTime();
--        LogError("输入开始" .. myTime .. "，耗时：" .. (myTime - _G.testTime));
--        _G.testTime = nil;
--    end


    --DebugLog("开始输入");
    --LogError(aa.b);
    self.fightAction = fightAction;

    if(not fightAction)then
        LogError("空的fight action！！！");
        self:ApplyComplete();
        return;
    end

    local character = fightAction:GetActorCharacter();
    if(character)then
        EventMgr.Dispatch(EventType.Fight_Action_Turn,character.GetID());
    else
        LogError("新回合，找不到目标角色，如果是强制结束战斗请忽略该报错！！！");
        LogError(fightAction.data);
        self:ApplyComplete();
        return;
    end
   
    self.character = character;
    FightClient:SetInputCharacter(character);
    local inputState = self:UpdateState();
    
    if(inputState)then

--        if(FightClient:IsAutoFight())then
--            FightClient:SendAutoFight();
--            return;
--        end

        if(self.character.uid ~= nil)then
            self.character.SetActionState(true);
        end
   
        if(self.usePlayerSkill)then
            self.usePlayerSkill = nil;
        else
            EventMgr.Dispatch(EventType.Character_FightInfo_Show,true); 
            CharacterMgr:SetAllShowState(true);
       
            self:SetCameraIdleState(true);

            self:PlayActionSound();
        end
    end
end

function this:SetCameraIdleState(state)
    if(state)then
        CameraMgr:ApplyCommonAction(self.fightAction,"idle_show0");         
    end
    CameraMgr:SetNoiseMoveState(state);
end

function this:PlayActionSound()
    self.character.PlayActionSound();  
end

function this:CancelSelect()
    self.currSelSkill = nil;    
    self:SetCameraIdleState(true);
    self:ApplySceneMaskOut();    
    FightGridSelMgr.Hide();
end

--播放完成
function this:ApplyComplete()       
    --LogError("完成输入===========");
    EventMgr.Dispatch(EventType.Net_Msg_Getted,"fight_input");--通知战斗输入完成

    local targetFightAction = self.fightAction;   

    EventMgr.Dispatch(EventType.Input_Target_Changed);
    EventMgr.Dispatch(EventType.Guide_Hint);
    FightGridSelMgr.Hide();
  
    if(self.character)then
        self.character.SetActionState(false);
    end   
    
    self:Reset();

    if(targetFightAction)then
        targetFightAction:Complete();
    end

    self:ApplySceneMaskOut(); 

    self:SetCameraIdleState(false);
end

this:Init();

return this;