--战斗行为管理器
require "FightActionUtil"
require "FightActionJumperMgr"
require "FightActionBase"

--战斗记录
require "FightRecordMgr";

--行动类型
FightActionType = 
{
    InitData		= 1, -- 初始化数据#
    AddCard		    = 2, -- 添加卡牌数据#
    --DelCard		    = 3, -- 删除卡牌
    Start			= 4, -- 战斗开始
    ChangeStage	    = 5, -- 切换周目
    Turn			= 6, -- 轮到我方回合
    Skill			= 7, -- 释放技能
    FightEnd		= 8, -- 战斗结束
    UpdateProgress	= 9, -- 更新进度条
    UpdateInfo 	    = 10, -- 更新信息
    Dead			= 11, -- 角色死亡
    Summon			= 12, -- 召唤
    Combo			= 13, -- 合体
    ComboBreak		= 14, -- 合体解除
    OverLoad		= 15, -- OverLoad
    Eff		        = 16, -- Buff
    HitResult		= 17, -- 战斗结果延迟显示
    Revive		    = 18, -- 复活
    OnStart         = 19,--战斗开始
    API             = 20,--API    
    Damage          = 21,--伤害
    TeamEvent       = 22,--队伍事件
    AddBuff         = 23,--添加Buff
    DeadChecker     = 24,--角色死亡检测
    Cure            = 25,--治疗
    APISpecial      = 26,--特殊API
    MissBuff        = 27,--MissBuff
    Plot            = 28,--战斗剧情
    DelBuff         = 29,--移除buff
    Transform       = 30,--变身
    Jumper          = 31,--特殊排队的API
    SkillAPI        = 32,--技能API
    OverLoadOn      = 33,--OverLoad启动
    StartPlay       = 34,--演出
    MainQueueBox    = 35,--主队列封装
    SummonTeammate  = 36,--召唤友军
    Skip            = 37,--跳过
}
FightActionTypeDesc = 
{
    [1] = "InitData",--		    = 1, -- 初始化数据#
    [2] = "AddCard",--		    = 2, -- 添加卡牌数据#
    --DelCard		            = 3, -- 删除卡牌
    [4] = "Start",--			= 4, -- 战斗开始
    [5] = "ChangeStage",--	    = 5, -- 切换周目
    [6] = "Turn",--			    = 6, -- 轮到我方回合
    [7] = "Skill",--			= 7, -- 释放技能
    [8] = "FightEnd",--		    = 8, -- 战斗结束
    [9] = "UpdateProgress",--	= 9, -- 更新进度条
    [10] = "UpdateInfo",-- 	    = 10, -- 更新信息
    [11] = "Dead",--			= 11, -- 角色死亡
    [12] =  "Summon",--			= 12, -- 召唤
    [13] =  "Combo",--			= 13, -- 合体
    [14] = "ComboBreak",--		= 14, -- 合体解除
    [15] = "OverLoad",--		= 15, -- OverLoad
    [16] = "Eff",--		        = 16, -- Buff
    [17] = "HitResult",--		= 17, -- 战斗结果延迟显示
    [18] = "Revive",--		    = 18, -- 复活
    [19] = "OnStart",--         = 19,--战斗开始
    [20] = "API",--             = 20,--API    
    [21] = "Damage",--          = 21,--伤害
    [22] = "TeamEvent",--       = 22,--队伍事件
    [23] = "AddBuff",--         = 23,--添加Buff
    [24] = "DeadChecker",--     = 24,--角色死亡检测
    [25] = "Cure",--            = 25,--治疗
    [26] = "APISpecial",--      = 26,--特殊API
    [27] = "MissBuff",--        = 27,--MissBuff
    [28] = "Plot";              --28,--剧情 
    [29] = "DelBuff";--         = 29,--移除buff
    [30] = "Transform";--       = 30,--变身
    [31] = "Jumper";--          = 31,--特殊排队的API
    [32] = "SkillAPI";--        = 32,--技能API
    [33] = "OverLoadOn";--      = 33,--OverLoad启动
    [34] = "StartPlay";--       = 32,--演出
    [35] = "MainQueueBox";--    = 35,--主队列封装
    [36] = "SummonTeammate";--  = 36,--召唤友军
    [37] = "Skip";--            = 37,--跳过
}



--队列类型
QUEUE_TYPE =
{
    Main = 1,--主队列，默认队列，排队执行
    Green = 2,--绿色通道，立刻执行
    Curr = 3;--主队列，当前位置
};


local this = {};

--待处理列表
this.list = {};
--当前处理中
this.curr = nil;

this.index = 1;

this.jumpList = nil;

--this.handUpCount = 0;

function this:Reset()
    self.index = 1;
    self.list = {};
    self.curr = nil;

    self.jumpList = nil;

    self.bIsStart = false;  -- 真正开始接收命令
    --self.handUpCount = 0;
	self:StopSkip();
	FightActionDataMgr:Reset();
    self.applySurrender = nil;
    self.surrenderData = nil;
    self:SetPauseState(false);

    FightRecordMgr:Reset();
end

function this:Start()
    self.bIsStart = true;  -- 真正开始接收命令   
end

--申请投降
function this:Surrender(data)    
    self.applySurrender = 1;
    self.surrenderData = data;
    EventMgr.Dispatch(EventType.Fight_Surrender);

    if(self:IsLast())then        
        self:HandleNext();
    end

    EventMgr.Dispatch(EventType.Fight_SetSettingBtn,false); 
end
function this:IsSurrender()
    return self.applySurrender;
end

local fight_action_skill_skip_key = "fight_action_skill_skip_key";
function this:ApplySkip(callBack,caller)
    self.skiping = 1;
    self.skipCallBack = callBack;
    self.skipCaller = caller;    

    self.skipFA = self.curr;

    CSAPI.SetTimeScaleLockState(false);
    CSAPI.ClearTimeScaleCtrl();
    CSAPI.SetTimeScaleByKey(fight_action_skill_skip_key,50);
    CSAPI.SetTimeScaleLockState(true);
end

function this:TryStopSkip()
   if(self:IsSkiping())then
        self:StopSkip();
        return true;
    end
end

function this:StopSkip()
    if(not self.skiping)then
        return;
    end

    self.skiping = nil;
    CSAPI.SetTimeScaleLockState(false);
    CSAPI.RemoveTimeScaleByKey(fight_action_skill_skip_key);

    --还原播放速度
    FightClient:SetPlaySpeed();

    if(self.skipCallBack)then        
        self.skipCallBack(self.skipCaller);
        self.skipCallBack = nil;
        self.skipCaller = nil;
    end
    
end
function this:IsSkiping()
    return self.skiping;
end

function this:SetAutoSkipNext(state)
    --LogError("set:" .. tostring(state));
    self.autoSkipNext = state;
end
function this:GetAutoSkipNext()
    --LogError("get:" .. tostring(self.autoSkipNext));
    return self.autoSkipNext;
end

--申请结束战斗
function this:ApplyEnd(data)
    if(data == nil)then
        data = {bIsWin = false,queueType = QUEUE_TYPE.Green};
    end
    data.queueType = QUEUE_TYPE.Green;

    local endFightAction = FightActionMgr:Apply(FightActionType.FightEnd,data);

    return endFightAction;      
end

--强制队伍死亡
function this:ForceDead(teamId,playCompleteCallBack,playCompleteCaller)
    
    local deads = nil;
    local allCharacters = CharacterMgr:GetAll();
    if(allCharacters)then
        for _,character in pairs(allCharacters)do
            if(character and character.GetTeam() == teamId)then
                deads = deads or {};
                table.insert(deads,character.GetID());
            end
        end
    end

    if(deads)then
        local deadFightAction = self:Apply(FightActionType.Dead,{ deads = deads },true);
        deadFightAction.queueType = QUEUE_TYPE.Green;
        deadFightAction:SetPlayCompleteCallBack(playCompleteCallBack,playCompleteCaller);
        self:Push(deadFightAction,true);
        return true;
    else
        if(playCompleteCallBack)then
            playCompleteCallBack(playCompleteCaller);
        end
    end
end

--申请一个FightAction
function this:Apply(fightActionType,fightActionData,force)    
    --LogError("构造FightAction=============" .. tostring(fightActionType) .. "\n" .. table.tostring(fightActionData));

    if(not force)then
        if not self.bIsStart then return end
    end
    local fa = nil;
    
    if(self.pools and self.pools[fightActionType] and #self.pools[fightActionType] > 0)then
        --缓冲池中存在目标类型FightAction
        local pool = self.pools[fightActionType];
        local lastPos = #pool;
        fa = table.remove(pool,lastPos);
        fa.isRecycle = nil;
        fa:Clean();
        --LogError(fa);
    else
        --新建一个
        if(self.faClasses == nil)then
            local arr = {};
            arr[FightActionType.InitData] = require "FightActionInitData";
            arr[FightActionType.AddCard] = require "FightActionAddCard";
            arr[FightActionType.Start] = require "FightActionStart";            
            arr[FightActionType.OnStart] = require "FightActionOnStart";  

            arr[FightActionType.Turn] = require "FightActionTurn"; 

            arr[FightActionType.Skill] = require "FightActionSkill";             
            arr[FightActionType.Summon] = require "FightActionSummon"; 
            arr[FightActionType.SummonTeammate] = require "FightActionSummonTeammate"; 
            arr[FightActionType.Combo] = require "FightActionCombo"; 
            arr[FightActionType.ComboBreak] = require "FightActionComboBreak"; 
            arr[FightActionType.Revive] = require "FightActionRevive"; 
            arr[FightActionType.Transform] = require "FightActionTransform"; 

            arr[FightActionType.OverLoad] = require "FightActionOverload1"; 

            arr[FightActionType.Damage] = require "FightActionDamage"; 
            arr[FightActionType.Dead] = require "FightActionDead";             
            arr[FightActionType.DeadChecker] = require "FightActionDeadChecker";             
            arr[FightActionType.Cure] = require "FightActionCure"; 


            arr[FightActionType.TeamEvent] = require "FightActionTeamEvent";   

            arr[FightActionType.AddBuff] = require "FightActionAddBuff";  
            arr[FightActionType.MissBuff] = require "FightActionMissBuff";  
            arr[FightActionType.DelBuff] = require "FightActionDelBuff";  

            arr[FightActionType.HitResult] = require "FightActionHitResult"; 
            arr[FightActionType.ChangeStage] = require "FightActionChangeStage"; 
            arr[FightActionType.FightEnd] = require "FightActionFightEnd";             

            arr[FightActionType.API] = require "FightActionAPI"; 
            arr[FightActionType.APISpecial] = require "FightActionAPISpecial"; 

            arr[FightActionType.Plot] = require "FightActionPlot"; 
            arr[FightActionType.Jumper] = require "FightActionJumper"; 
            arr[FightActionType.SkillAPI] = require "FightActionSkillAPI"; 
            arr[FightActionType.OverLoadOn] = require "FightActionOverloadOn"; 
            arr[FightActionType.StartPlay] = require "FightActionStartPlay"; 
            arr[FightActionType.MainQueueBox] = require "FightActionMainQueueBox"; 
            arr[FightActionType.Skip] = require "FightActionSkip"; 
            self.faClasses = arr;
        end
        local targetClass = self.faClasses[fightActionType];
        if(targetClass == nil)then
            LogError("不存在FightAction类型" .. fightActionType);
        end
        fa = oo.class(targetClass);       
        fa:SetType(fightActionType);

--        -----------------------------------------------------------------------------------------------------------------
--        --测试用
--        self.faArr = self.faArr or {};
--        self.faTypeArr = self.faTypeArr or {};
--        self.faArrIndex = self.faArrIndex and (self.faArrIndex + 1) or 1;
--        self.faArr[self.faArrIndex] = fa;
--        self.faTypeArr[self.faArrIndex] = fightActionType;
--        -----------------------------------------------------------------------------------------------------------------
    end

    --初始化
    if(fightActionData)then
        fa:SetData(fightActionData);
    end   
    return fa;
end
--打印fightaction信息
function this:LogNoRecycles()
    if(self.faArr)then
        for i,fa in pairs(self.faArr)do
            if(fa)then
                if(not fa.isRecycle)then
                    LogError("未回收" .. FightActionTypeDesc[fa:GetType()]);
                    LogError(fa.data);
                end
            else
                LogError("被销毁" .. FightActionTypeDesc[self.faTypeArr[i]]);
            end
        end
    end
end

--回收FightAction
function this:Recycle(fightAction)
    local fightActionType = fightAction:GetType();
    if(fightActionType == FightActionType.Skill)then
        FuncUtil:Call(self.ApplyRecycle,self,10000,fightAction);    
    else
        self:ApplyRecycle(fightAction);
    end
end

function this:ApplyRecycle(fightAction)
    local fightActionType = fightAction:GetType();
    --技能FightAction容易出bug，暂时不回收
--    if(fightActionType == FightActionType.Skill)then
--        fightAction:Clean();
--        fightAction = nil;
--        return;
--    end


    if(fightAction.isRecycle)then
        return;
    end
    fightAction.isRecycle = 1;
   
    self.pools = self.pools or {};
    local pool = self.pools[fightActionType];
    if(pool == nil)then
        pool = {};
        self.pools[fightActionType] = pool;
    end
    --LogError("回收" .. FightActionTypeDesc[fightActionType]);
    fightAction:Clean();
    table.insert(pool,fightAction);
end


--API入列
function this:PushSkill(datas)    
    if not self.bIsStart then
        --LogError(string.format("拒收%s",table.tostring(datas,true)));
        return 
    end
    if table.empty(datas) then return end

    if(_G.debug_model)then
        LogWarning("服务器数据：" .. table.tostring(datas));
    end

    --记录收到的战斗协议
    --ProtocolRecordMgr:RecordFight(datas);
    FightRecordMgr:Push(datas);
    --FightActionDataMgr:Push(datas);
    if(datas and datas.api)then
        FightActionUtil:PushServerDatas({datas});
        return;
    end
    FightActionUtil:PushServerDatas(datas);
end

--入列
function this:Push(fightAction,force)    
    if(not fightAction)then
        return;
    end
    if(not force)then
        if not self.bIsStart then return end
    end
--    LogError("====================================================","00ff00");
--    if(fightAction:GetType() == FightActionType.Skill)then
--        LogError("新FighAction入列,类型 = " .. fightAction:GetType() .. "\n" .. table.tostring(fightAction:GetData()),"aaffee");
--    else
--        LogError("新FighAction入列,类型 = " .. fightAction:GetType() .. "\n" .. table.tostring(fightAction:GetData()),"00ff00");
--    end

--    LogError(fightAction,"00ff00");

    if(fightAction:GetType() == FightActionType.FightEnd)then
        EventMgr.Dispatch(EventType.Fight_SetSettingBtn,false); 
    end

   if(fightAction.queueType == QUEUE_TYPE.Green)then
--        DebugLog("====================================================","00ff00");
--        DebugLog("绿色通道：新FighAction入列,类型 = " .. fightAction.actionType,"00ff00");
--        DebugLog(fightAction,"00ff00");
        fightAction:Play(self.OnGreenFightActionComplete);
    else       
--        DebugLog("====================================================","ffff00");
--        DebugLog("主队列：新FighAction入列,类型 = " .. fightAction.actionType,"ffff00");
--        DebugLog(fightAction,"ffff00");
       if(fightAction.queueType == QUEUE_TYPE.Curr)then
           self.jumpList = self.jumpList or {};
           table.insert(self.jumpList,fightAction);
--           LogError("入列=================================")
--           LogError(fightAction.data);
       else
           table.insert(self.list,fightAction);
       end
      
       EventMgr.Dispatch(EventType.Fight_Action_Enqueue,fightAction,false);
       self:HandleNext();
    end   
end

function this:SetTopFightAction(fightAction)
    self.topFightAction = fightAction;
end

function this:Continue()
    self:SetPauseState(false);
    self:HandleNext();
end
function this:Pause()
    self:SetPauseState(true);
end
function this:SetPauseState(state)
    self.pauseState = state;
end


--处理下一个
function this:HandleNext()        
--    if(self.handUpCount > 0)then       
--        return;
--    end

    if(self.pauseState)then
        return;
    end

    if(self.curr)then  
--        DebugLog("当前FighAction未完成");
--        DebugLog(self.curr);        
        return;
    end
      
    local nextFightAction = nil;

    if(self.jumpList)then
        if(#self.jumpList == 0)then
            self.jumpList = nil;
        else
            nextFightAction = table.remove(self.jumpList,1);
--            LogError("执行插队FightAction");
--            LogError(nextFightAction.data);
        end        
    end

    if(nextFightAction == nil)then
        nextFightAction = self:PullNext();
        if(nextFightAction == nil)then
            --DebugLog("队列中FighAction全部执行完成==============================================");
            return;
        end
    end
   
    self.curr = nextFightAction;

    --self:LogInfo(self.curr);--输出日志
       
    self.curr:Play(self.OnFightActionComplete);
end
function this:GetCurr()
    return self.curr;
end
--获取下一个
function this:GetNext()
    if(self:IsLast())then        
        return nil;
    end
    local fightAction = self.list[self.index];   
    return fightAction;
end
--取出下一个
function this:PullNext()   
    if(self:IsSurrender())then      
        if(FightClient.isLoadingComplete)then  
            local endFightAction = self:ApplyEnd(self.surrenderData);
            self:Reset();
            return endFightAction;
        end
    end
    
    if(self:IsLast())then        
        return nil;
    end

    local fightAction = self.list[self.index];
    self.index = self.index + 1;    
    return fightAction;
end

--是否最后一个
function this:IsLast()
    local count = self.list and #self.list or 0;
    
    return self.index > count; 
end

function this:HasFightEnd()
    return self:FindNextByType(FightActionType.FightEnd);
end

--查找队列中下一个指定类型的FightAction
function this:FindNextByType(fightActionType)
    if(self.index == nil)then
        return nil;
    end

    local total = #self.list;

    for i = self.index,total do
        local fightAction = self.list[i];
        if(fightAction == nil)then
            break;
        end

        if(fightAction.actionType == fightActionType)then
            return fightAction;
        end
    end
    return nil;
end

--当前行为完成处理
function this:FightActionCompleteHandle(fa)
--    if(self.curr)then
--        DebugLog("FightAction完成，命令类型：" .. FightActionTypeDesc[self.curr.actionType]);    
--    end
    if(self:IsSkiping())then        
        self:StopSkip();
        FuncUtil:Call(self.FightActionCompleteHandle,self,1000,fa);
        return;
    end

    if(self.skipFA and self.skipFA == self.curr)then
        self.skipFA = nil;
        self.curr.skip = nil;
        FuncUtil:Call(self.FightActionCompleteHandle,self,300,fa);
        return;
    end

    self.curr = nil;    
    self:HandleNext();
end

--行为完成
function this.OnFightActionComplete(fightAction)       
   this:FightActionCompleteHandle();
   this:Recycle(fightAction);
end

--绿色队列行为完成
function this.OnGreenFightActionComplete(fightAction)    
   this:Recycle(fightAction);
end

--输出信息
function this:LogInfo(fightAction)
    --DebugLog("====================================================");
    --DebugLog("FightAction执行器挂起数值：" .. self.handUpCount);
    if(fightAction == nil)then
        DebugLog("空FightAction");
    else
        LogError("执行FightAction，命令类型：" .. FightActionTypeDesc[fightAction.actionType]);
        LogError(fightAction:GetData());
        --DebugLog(fightAction);
    end
end


return this;