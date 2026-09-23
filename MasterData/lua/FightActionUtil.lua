local this = {};
FightActionUtil = this;


APIType = 
{
    --数据初始化
    InitData = "InitData";

    --添加角色
    AddCard = "AddCard";

    --过载
    OverLoad = "OverLoad";

    --技能
    Skill = "OnSkill",
    --被动触发技能
    CallSkill = "CallSkill",
    --更新技能
    UpdateSkill = "UpdateSkill",
    --改变技能
    ChangeSkill = "ChangeSkill",
    --追击
    BeatAgain = "BeatAgain",
    --反击
    BeatBack = "BeatBack",

    --召唤
    Summon = "Summon",
    SummonUnite = "SummonUnite",
    --合体
    Combo = "Unite",
    --解体
    ComboBreak = "Resolve",
    -- 解体时 
    OnResolve     = "OnResolve",
    --死亡
    Dead = "Dead",
    --复活
    Revive = "Revive",
    --变身
    Transform = "Transform";

    --Buff
    Buff = "AddBuff",
    --更新Buff
    UpdateBuff = "UpdateBuffer",
    --移除Buff
    DelBuff = "DelBuffer",
    --抵抗Buff
    MissBuff = "MissBuff",

     --Miss
    MissDamage = "MissDamage",

    OnAddBuff = "OnAddBuff";
    OnDelBuff = "OnDelBuff";
    OnRemoveBuff = "OnRemoveBuff";
    OnTransform = "OnTransform";

    AddOwnerEquipSkill = "AddOwnerEquipSkill";
    
     --拉条
    AddProgress = "AddProgress",
     --更新时间条
    UpdateProgress = "UpdateProgress",  
    --属性变化
    AddAttrPercent = "AddAttrPercent",   
    --最大生命值变化
    AddMaxHpPercent = "AddMaxHpPercent",   
    --属性变化
    AddAttr = "AddAttr",
    --加血、减血
    AddHp = "AddHp",
    --设置HP
    SetHP = "SetHP",
    --回满血
    RestoreHP = "RestoreHP",    
    --加蓝
    AddNP = "AddNp",
    --加同步率
    AddSP = "AddSp",
    --加行动点
    AddXP = "AddXp",
    --嘲讽
    Sneer = "Sneer",
    --沉默
    Silence = "Silence",
    --加盾
    AddShield = "AddShield",
     --加盾
    AddLightShield = "AddLightShield",
     --加盾
    AddPhysicsShield = "AddPhysicsShield",

    --加牢笼
    AddCage = "AddCage",
    --更新牢笼
    UpdateCage = "UpdateCage",
    --移除牢笼
    DelCage = "DelCage",



    --持续治疗
    BuffCure = "BufferCure",
    --持续伤害
    BuffDamage = "BufferDamage";

    --伤害
    Damage = "Damage",
    --治疗
    Cure = "Cure",

    --协助攻击
    Help = "Help";
    OnHelp = "OnHelp";

    --回合切换
    OnTurn = "OnTurn", 
    --回合开始结算
    OnRoundBegin = "OnRoundBegin",  
    --回合结束结算
    OnRoundOver = "OnRoundOver",
    

    OnStart          = "OnStart",  -- 战斗开始
    OnBorn           = "OnBorn",  -- 入场时
    OnActionBegin    = "OnActionBegin",  -- 行动开始
    OnActionOver     = "OnActionOver",  -- 行动结束 
    OnAttackBegin    = "OnAttackBegin",  -- 攻击开始前
    OnAttackOver     = "OnAttackOver",  -- 攻击结束后 
    OnAttackOver2     = "OnAttackOver2",  -- 攻击结束后 
    --OnBefourHurt     = "OnBefourHurt",  -- 伤害前
    --OnAfterHurt      = "OnAfterHurt", -- 伤害后
    OnDeath          = "OnDeath", -- 死亡时
    OnCure           = "OnCure", -- 治疗时
    OnAddProgress    = "OnAddProgress", -- 拉条时
    OnReduceProgress = "OnReduceProgress",--退条时
    --切换周目
    ChangeStage = "ChangeStage"; 
    --切换周目
    OnChangeStage = "OnChangeStage"; 

    --强制死亡
    ForceDeath = "ForceDeath";

    --更新数值
    UpdateValue = "UpdateValue";
    --移除数值
    DelValue = "DelValue";

    --额外回合
    ExtraRound = "ExtraRound";

    --飘字
    Piaozi = "Piaozi";
    --中间飘字
    ShowTips = "ShowTips";

    --前端自定义API组
    APIs = "APIs";

    --演出(德拉苏出场)
    StartPlay = "StartPlay";

    --召唤队友
    SummonTeammate = "SummonTeammate";

    --破盾
    DeleteShield = "DeleteShield";

    ClosingBuff = "ClosingBuff";

    Custom = "custom";

    SetInvincible = "SetInvincible";--设置活动boss阶段信息
    UpdateDamage = "UpdateDamage";--更新总伤害

    Skip = "skip";--跳过回合

    SetFury = "SetFury";--设置怒气
    UpdateFury = "UpdateFury";--更新怒气
}


function this:IsSubSkill(data)
    if(not data)then
        return;
    end

    local apiKey = data.api;
    return apiKey == APIType.CallSkill or apiKey == APIType.BeatAgain or apiKey == APIType.BeatBack or apiKey == APIType.Revive;
end

--忽略的API
APIIgonre =
{
    BeginOnStart = 1,
--    OnAddBuff = 1,
--    OnDelBuff = 1,
}

function this:IsSkillTargetAPI(data) 

    if(self.skillTargetAPIs == nil)then
        self.skillTargetAPIs = {};
        self.skillTargetAPIs[APIType.AddProgress] = 1;
        self.skillTargetAPIs[APIType.AddHp] = 1;
        self.skillTargetAPIs[APIType.SetHP] = 1;        
        self.skillTargetAPIs[APIType.AddNP] = 1;
        self.skillTargetAPIs[APIType.AddSP] = 1;
        self.skillTargetAPIs[APIType.AddXP] = 1;
        self.skillTargetAPIs[APIType.UpdateBuff] = 1;
    end

    return data and data.api and self.skillTargetAPIs[data.api];
end


--转换服务器数据成FightAction
function this:PushServerDatas(dataArr)
    if(self.hangupArr)then
        --挂起服务器数据
        table.insert(self.hangupArr,dataArr);
        return;
    end
    for _,data in ipairs(dataArr) do
        --LogError(data);
        local fightAction,subDatas = self:HandleAPIData(data);
		--FightActionDataMgr:Push(data);
        if(fightAction ~= nil)then
            FightActionMgr:Push(fightAction);
        end
        if(subDatas)then
            self:PushServerDatas(subDatas);
        end
    end    
end
--设置是否挂起服务端数据
function this:SetServerDatasHangUpState(isHangUp)
    if(isHangUp)then
        self.hangupArr = self.hangupArr or {};
    elseif(self.hangupArr)then
        local arr = self.hangupArr;
        self.hangupArr = nil;
        for _,serverDatas in ipairs(arr)do
            --LogError("处理挂起数据：=====\n" .. table.tostring(serverDatas));
            self:PushServerDatas(serverDatas);
        end

        local fightResultData = self.fightResultData;
        self.fightResultData = nil;
        if(fightResultData)then
            DungeonMgr:FightOver(fightResultData);
        end
    end
end

function this:IsHangup()
    return self.hangupArr;
end

function this:HangupFightResult(fightResultData)
    if(self.hangupArr)then
        self.fightResultData = fightResultData;
    end

    return self.hangupArr;
end

function this:Clean()
    self.hangupArr = nil;
end

--处理后端发过来的API数据
function this:HandleAPIData(data)  
    local handler = self:GetAPIHandler(data.api);
    if(handler)then
        return handler:Handle(data);   
    end
end

function this:GetAPIHandler(apiName)
      if(not apiName)then
        return;
      end
      if(self.handers == nil)then
        self.handers = {};


         --数据初始化
        self.handers[APIType.InitData] = require "FightAPIHandler_InitData";
        --添加角色
        self.handers[APIType.AddCard] = require "FightAPIHandler_AddCard";
        --OverLoad
        self.handers[APIType.OverLoad] = require "FightAPIHandler_OverLoad";

        --伤害
        self.handers[APIType.Damage] = require "FightAPIHandler_Damage";
        --治疗
        self.handers[APIType.Cure] = require "FightAPIHandler_Cure";
    
        
        --技能
        self.handers[APIType.Skill] = require "FightAPIHandler_Skill";
         --协助
        self.handers[APIType.OnHelp] = require "FightAPIHandler_Skill";

        --被动触发技能
        self.handers[APIType.CallSkill] = require "FightAPIHandler_Skill";--"FightAPIHandler_Jumper";
        --追击
        self.handers[APIType.BeatAgain] = require "FightAPIHandler_Skill";--"FightAPIHandler_Jumper";
        --反击
        self.handers[APIType.BeatBack] = require "FightAPIHandler_Skill";--"FightAPIHandler_Jumper";
       
        self.handers[APIType.Skip] = require "FightAPIHandler_Skip";

        --协助提示信息
        self.handers[APIType.Help] = require "FightAPIHandler_Help";
        --合体
        self.handers[APIType.Combo] = require "FightAPIHandler_Combo";
        --解体
        --self.handers[APIType.ComboBreak] = require "FightAPIHandler_ComboBreak";
        --self.handers[APIType.ComboBreak] = require "FightAPIHandler_Jumper";
        self.handers[APIType.ComboBreak] = require "FightAPIHandler_Resolve";
        --召唤
        self.handers[APIType.Summon] = require "FightAPIHandler_Summon";
        self.handers[APIType.SummonUnite] = require "FightAPIHandler_Summon";
        
        self.handers[APIType.SummonTeammate] = require "FightAPIHandler_SummonTeammate";
        --死亡
        self.handers[APIType.Dead] = require "FightAPIHandler_Dead";
        --复活
        self.handers[APIType.Revive] = require "FightAPIHandler_Revive";
        --变身
        self.handers[APIType.Transform] = require "FightAPIHandler_Transform";

         --回合切换
        self.handers[APIType.OnTurn] = require "FightAPIHandler_OnTurn";
        -- 战斗开始
         self.handers[APIType.OnStart]  =  require "FightAPIHandler_OnStart";
        --切换周目
        self.handers[APIType.ChangeStage] = require "FightAPIHandler_ChangeStage";
        
        --添加Buff
        self.handers[APIType.Buff] = require "FightAPIHandler_Buff";
        --抵抗Buff
        self.handers[APIType.MissBuff] = require "FightAPIHandler_MissBuff";
         --移除Buff
        self.handers[APIType.DelBuff] = require "FightAPIHandler_DelBuff";

        self.handers[APIType.StartPlay] = require "FightAPIHandler_StartPlay";

        ----------------------------------------------单独一个API----------------------------------------------        
        local apiHandler = require "FightAPIHandler_API";

        --更新Buff
        self.handers[APIType.UpdateBuff] = apiHandler;
        --破盾
        self.handers[APIType.DeleteShield] = apiHandler;
        self.handers[APIType.ClosingBuff] = apiHandler;

        
        --飘字
        self.handers[APIType.Piaozi] = apiHandler;
        --中间飘字
        self.handers[APIType.ShowTips] = apiHandler;
        
        --加血、减血
        self.handers[APIType.AddHp] = apiHandler;
        --设置HP
        self.handers[APIType.SetHP] = apiHandler;
        --回满血
        self.handers[APIType.RestoreHP] = apiHandler;
        
        --加蓝
        self.handers[APIType.AddNP] = apiHandler;
        --加同步率
        self.handers[APIType.AddSP] = apiHandler;
        --加行动点
        self.handers[APIType.AddXP] = apiHandler;
        --嘲讽
        self.handers[APIType.Sneer] = apiHandler;
        --沉默
        self.handers[APIType.Silence] = apiHandler;
        --加属性
        self.handers[APIType.AddAttrPercent] = apiHandler;           
        --加属性
        self.handers[APIType.AddAttr] = apiHandler;
         --最大生命值
        self.handers[APIType.AddMaxHpPercent] = apiHandler;    
        --加盾
        self.handers[APIType.AddShield] = apiHandler;
        --加光束盾
        self.handers[APIType.AddLightShield] = apiHandler;
        --加物理盾
        self.handers[APIType.AddPhysicsShield] = apiHandler;
        
        self.handers[APIType.SetInvincible] = apiHandler;
        self.handers[APIType.UpdateDamage] = apiHandler;
        

        --拉条
        self.handers[APIType.AddProgress] = apiHandler;
        --持续治疗
        self.handers[APIType.BuffCure] = apiHandler;
        --持续伤害
        self.handers[APIType.BuffDamage] = apiHandler;               
        --更新时间条
        self.handers[APIType.UpdateProgress] = apiHandler;
        --强制死亡
        self.handers[APIType.ForceDeath] = apiHandler;
        --更新技能
        self.handers[APIType.UpdateSkill] = apiHandler;
        --改变技能
        self.handers[APIType.ChangeSkill] = apiHandler;

        --额外回合
        self.handers[APIType.ExtraRound] = apiHandler;

         --加牢笼
        self.handers[APIType.AddCage] = apiHandler
        --移除牢笼
        self.handers[APIType.DelCage] = apiHandler;

        --更新数值
        self.handers[APIType.UpdateValue] = apiHandler
        --移除数值
        self.handers[APIType.DelValue] = apiHandler;

        --设置怒气
        self.handers[APIType.SetFury] = apiHandler;
        --更新怒气
        self.handers[APIType.UpdateFury] = apiHandler;
        --添加武器技能
        self.handers[APIType.AddOwnerEquipSkill] = apiHandler;
        --自定义
        self.handers[APIType.Custom] = apiHandler;


        local cageHandler = require "FightAPIHandler_UpdateCage";
        --更新牢笼
        self.handers[APIType.UpdateCage] = cageHandler;
        

        ----------------------------------------------结算事件----------------------------------------------
        local eventHandler = require "FightAPIHandler_Event";
        local eventSpecialHandler = require "FightAPIHandler_Event_Special";

        --回合开始结算
        self.handers[APIType.OnRoundBegin]      = require "FightAPIHandler_RoundBegin";
        --回合结束结算
        self.handers[APIType.OnRoundOver]       = require "FightAPIHandler_SplitDatas";;
        -- 行动开始
        self.handers[APIType.OnActionBegin]     = eventSpecialHandler;
        -- 行动结束
        self.handers[APIType.OnActionOver]      = require "FightAPIHandler_SkillAPI";   
         --攻击开始前
        self.handers[APIType.OnAttackBegin]     = eventSpecialHandler;
        -- 攻击结束后
        self.handers[APIType.OnAttackOver]      = eventSpecialHandler;   
        self.handers[APIType.OnAttackOver2]      = eventSpecialHandler;       
       -- 角色出生时   
        self.handers[APIType.OnBorn]           = eventSpecialHandler;

        ----------------------------------------------一组API----------------------------------------------
        local apisHandler = require "FightAPIHandler_APIs";

        -- 死亡时
        self.handers[APIType.OnDeath]          = apisHandler;
        -- 治疗时
        self.handers[APIType.OnCure]           = apisHandler;
        -- 拉条时
        self.handers[APIType.OnAddProgress]           = apisHandler; 
        --退条时
        self.handers[APIType.OnReduceProgress]           = apisHandler;        
        --添加Buff时触发
        self.handers[APIType.OnAddBuff] = apisHandler;
        --删除Buff时触发（后端给的api）
        self.handers[APIType.OnDelBuff] = apisHandler;
         --移除Buff时触发（后端给的api）
        self.handers[APIType.OnRemoveBuff] = apisHandler;
        --变身时
        self.handers[APIType.OnTransform] = apisHandler;
        
        -- 前端自定义API
        self.handers[APIType.APIs]           = apisHandler;

        --切换周目
        self.handers[APIType.OnChangeStage] = apisHandler;        

        --解体时
        self.handers[APIType.OnResolve]           = apisHandler;
    end
    if(APIIgonre[apiName])then
        return;
    end
    local handler = self.handers[apiName];
    if(handler == nil)then
        LogError("找不到API处理器：" .. tostring(apiName));
    end

    return handler;
end

--处理子FightAction
function this:HanderSubFightAction(fightAction,datas)
    if(fightAction and datas)then
        for _,data in ipairs(datas)do
            local subFightAction = self:HandleAPIData(data);           
            if(subFightAction)then
                --LogError("生成子FightAction" .. FightActionTypeDesc[subFightAction:GetType()] .. table.tostring(subFightAction:GetData()));
                fightAction:PushSub(subFightAction);
            end
        end
    end
end

--顺序播放API
function this:PlayAPIsByOrder(apiDatas)
    if(apiDatas == nil)then
        return;
    end

    local data = {datas = apiDatas,api = APIType.APIs};
    local fightAction = self:HandleAPIData(data);
    
    if(fightAction)then
        fightAction.queueType = QUEUE_TYPE.Green;   
        FightActionMgr:Push(fightAction);
    end
end
--播放FightAction列表
function this:PlayFightActions(faArr)
    if(faArr == nil)then
        return;
    end

    local data = {api = APIType.APIs};
    local fightAction = self:HandleAPIData(data);

    if(fightAction)then
        for _,fa in ipairs(faArr)do
            --LogError("入列类型：" .. FightActionTypeDesc[fa:GetType()] .. "\n" .. table.tostring(fa:GetData()));
            fightAction:PushSub(fa);
        end       
        fightAction.queueType = QUEUE_TYPE.Green;   
        FightActionMgr:Push(fightAction);
    end
end


return this;