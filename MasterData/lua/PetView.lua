--宠物动画控制脚本
local petId=nil;
local FSM=nil;
local currState=nil;
local data=nil;
local eventMgr=nil;
local animator=nil;
local clipTimes={};--记录动画时间长度
local talkBox=nil;
local emojiBox=nil;
local endTime=0;
-- local refreshTime=60;
local canvasGroup=nil;

function Awake()
    animator=ComUtil.GetComInChildren(root,"Animator");
    canvasGroup=ComUtil.GetCom(root,"CanvasGroup")
    -- local clipInfos=animator.runtimeAnimatorController.animationClips;
    -- if clipInfos and clipInfos.Length>0 then
    --     for i=0,clipInfos.Length-1 do
    --         local clipName=clipInfos[i].name;
    --         local time=clipInfos[i].length;
    --         clipTimes[clipName]=time;
    --     end
    -- end
    eventMgr = ViewEvent.New();
    eventMgr:AddListener(EventType.PetActivity_FSMState_Change,OnFSMStateChange)
    eventMgr:AddListener(EventType.PetActivity_TalkCond_Trigger,OnTalkCondTrigger);
    eventMgr:AddListener(EventType.PetActivity_EmojiCond_Trigger,OnEmojiCondTrigger);
    eventMgr:AddListener(EventType.PetActivity_Sport_Ret,SetDefaultState);
end

function OnDestroy()
    clipTimes={};
    eventMgr:ClearListener();
end

function Close()
    CSAPI.RemoveGO(gameObject);
end

function Init(_data)
    data=_data;
    if data==nil then
        LogError("宠物数据不得为空！");
        do return end;
    end
    -- LogError("OnOpen:"..tostring(feedNum).."\t"..tostring(data:GetStageExp()).."\t"..tostring(data:GetWash()).."\t"..tostring(data:GetHappy()).."\t"..tostring(data:GetFood()).."\tStarttime2:"..tostring(data:GetCurrSportStartTime()).."\tKeeptime1:"..tostring(data.data.keep_time).."\tKeeptime2:"..tostring(data:GetKeepTime()))
    clipTimes=PetTweenTimes[data:GetID()]
    PetActivityMgr:CountPetAttr(data:GetID())
    InitFSM();
    SetDefaultState();
    InitEmoji();
    InitTalkBox();
    CheckEmojiDialog();
    -- refreshTime=data:GetIntervalTime();
end


function InitEmoji()
    if emojiBox==nil then
        ResUtil:CreateUIGOAsync("Pet/PetEmojiBox",emojiNode,function(go)
            emojiBox=ComUtil.GetLuaTable(go);
            emojiBox.Hide();
        end);
    else
        emojiBox.Hide();
    end
end

function InitTalkBox()
    if talkBox==nil then
        ResUtil:CreateUIGOAsync("Pet/PetTalkBox",talkNode,function(go)
            talkBox=ComUtil.GetLuaTable(go);
            talkBox.Hide();
            if FSM then
                EventMgr.Dispatch(EventType.PetActivity_TalkCond_Trigger,{id=GetID(),type=FSM:GetCurrStateType(),trigger=PetTalkCondType.EnterView});
            end
        end);
    else
        talkBox.Hide();
    end
end

function InitFSM()
    FSM=PetFSMSystem.New();
    FSM:Reset();
    --添加该宠物的所有状态
    local idel=PetIdelState();
    idel:Init(PetTweenType.idle,this);
    FSM:AddState(PetTweenType.idle,idel); 
    local sleep=PetSleepState();
    sleep:Init(PetTweenType.sleep,this);
    FSM:AddState(PetTweenType.sleep,sleep); 
    local eat=PetEatState();
    eat:Init(PetTweenType.eat,this);
    FSM:AddState(PetTweenType.eat,eat); 
    local wash=PetWashState();
    wash:Init(PetTweenType.wash,this);
    FSM:AddState(PetTweenType.wash,wash); 
    local clean=PetCleanState();
    clean:Init(PetTweenType.clean,this);
    FSM:AddState(PetTweenType.clean,clean); 
    local play=PetPlayState();
    play:Init(PetTweenType.play,this);
    FSM:AddState(PetTweenType.play,play); 
    local walk=PetWalkState();
    walk:Init(PetTweenType.walk,this);
    FSM:AddState(PetTweenType.walk,walk); 
    local sport=PetSportState();
    sport:Init(PetTweenType.sport,this);
    FSM:AddState(PetTweenType.sport,sport); 
    local move=PetMoveState();
    move:Init(PetTweenType.move,this);
    FSM:AddState(PetTweenType.move,move); 
end

function Update()
    if FSM then
        FSM:Update();
    end
    --计算宠物能力值下降并显示
    if data and TimeUtil:GetTime()>=data:GetNextCountTime() then
        PetActivityMgr:ChecekRedInfo();--检查一次是否有红点
        CountAttr();
    end
    -- if endTime and refreshTime and refreshTime~=0 then
    --     endTime=endTime+Time.deltaTime;
    --     if endTime>=refreshTime then
    --         endTime=0;
    --         PetActivityMgr:ChecekRedInfo();--检查一次是否有红点
    --         CountAttr();
    --     end        
    -- end
end

function CountAttr()
    if data then
        local feedNum=data:GetStageExp();
        -- LogError("PreFeed:"..tostring(feedNum).."\t"..tostring(data:GetStageExp()).."\t"..tostring(data:GetWash()).."\t"..tostring(data:GetHappy()).."\t"..tostring(data:GetFood()).."\tStarttime2:"..tostring(data:GetCurrSportStartTime()).."\tKeeptime1:"..tostring(data.data.keep_time).."\tKeeptime2:"..tostring(data:GetKeepTime()))
        PetActivityMgr:CountPetAttr(data:GetID())
        data=PetActivityMgr:GetCurrPetInfo();
        -- LogError("PreFeed:"..tostring(feedNum).."\t"..tostring(data:GetStageExp()).."\t"..tostring(data:GetWash()).."\t"..tostring(data:GetHappy()).."\t"..tostring(data:GetFood()).."\tStarttime2:"..tostring(data:GetCurrSportStartTime()).."\tKeeptime1:"..tostring(data.data.keep_time).."\tKeeptime2:"..tostring(data:GetKeepTime()))
        if data:GetSport()~=0 and feedNum~=data:GetStageExp() then
            Tips.ShowTips(LanguageMgr:GetTips(42017));
        end
        CheckEmojiDialog();
        EventMgr.Dispatch(EventType.PetActivity_AttrCount_Ret,{id=data:GetID()});
    end
end

--输出宠物台词
function TalkDialog(tweenType,trigger)
    if talkBox and tweenType and trigger and data then
        local txt,time=data:GetWordInfo(tweenType,trigger);
        if txt and time then
            talkBox.Show(data:GetName(),txt,time);
        end
    end
end

-- 检查是否输出气泡
function CheckEmojiDialog()
    if data == nil or FSM == nil then
        emojiBox.Hide();
        do return end
    end
    local cfgs = data:GetEmojis();
    local count = data:GetTweenCount(FSM:GetCurrStateType());
    if cfgs ~= nil and (count<0 or PetActivityMgr:IsIdleState(FSM:GetCurrStateType())==true) then
        emojiBox.Show(cfgs);
    else
        emojiBox.Hide();
    end
end


function Play(tweenType)
    if tweenType and animator and data then
        local clipName,posInfo=data:GetTweenName(tweenType);
        if posInfo then
            local scale=posInfo[3] or 1;
            CSAPI.SetAnchor(gameObject,posInfo[1],posInfo[2]);
            CSAPI.SetScale(root,scale,scale,scale);
        end
        animator:Play(clipName,-1,0);
    end
end

function GetFSM()
    return FSM;
end

function GetData()
    return data;
end

function GetID()
    return data and data:GetID() or nil;
end

function GetClipTime(state)
    if state==nil then
        return 0;
    end
    local tweenName=data:GetTweenName(state);
    if tweenName and clipTimes and clipTimes[tweenName] then
        return clipTimes[tweenName]
    end
    return 0;
end

function OnTalkCondTrigger(eventData)
    if eventData and eventData.type and eventData.trigger and eventData.id==GetID() then
        TalkDialog(eventData.type,eventData.trigger)
    end
end

function OnEmojiCondTrigger(eventData)
    if eventData and eventData.id==GetID() then
        CheckEmojiDialog();
    end
end

--设置成默认状态
function SetDefaultState()
    -- LogError("SetDefaultState----------------->")
    if data then
        local defaultState=data:GetCurrAction();
        FSM:ChangeState(defaultState);
    end
end

--转换状态
function OnFSMStateChange(eventData)
    if eventData and data and eventData.id==data:GetID() and FSM then
        --播放特效，转换状态
        CSAPI.SetGOActive(changeTween,true);
        FuncUtil:Call(function()
            if FSM~=nil and not IsNil(gameObject) then
                CSAPI.SetGOActive(changeTween,false);
                canvasGroup.alpha=1;
                --计算当前状态持续时间并记录
                local time=nil;
                local onceTime=GetClipTime(eventData.state);
                local count=data:GetTweenCount(eventData.state);
                if eventData.autoChange==true then --指定次数后自动转换回默认状态
                    time=onceTime;
                    if  time>0 and count then
                        time=time*count
                    else
                        local tweenName=data:GetTweenName(eventData.state);
                        LogError(string.format("未获取到对应动画片段：%s信息信息！",tweenName));
                    end
                    if PetActivityMgr:IsIdleState(eventData.state)~=true then --不视为idle状态时才显示动作条
                        EventMgr.Dispatch(EventType.PetActivity_ActionBar_Set,{id=data:GetID(),time=time})
                    end
                end
                FSM:ChangeState(eventData.state,{count=count});
                CheckEmojiDialog();
            end
        end,nil,370);
    end
end