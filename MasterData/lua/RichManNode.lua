local eventMgr=nil;
local curData=nil;
local isMain=true;--是否显示活动主界面，否则显示操作界面
local rollAnimator=nil;
local autoAnimator=nil;
local rollAnimator2=nil;
local isEvent=false;
local currNDiceNum=0;
local currSDiceNum=0;
local currTaskNum=0;
local queueIsPlaying=false;
function Awake()
    rollAnimator=ComUtil.GetCom(btnRoll,"Animator");
    autoAnimator=ComUtil.GetCom(Auto,"Animator");
    rollAnimator2=ComUtil.GetCom(btnRoll2,"Animator");
    eventMgr = ViewEvent.New();
    eventMgr:AddListener(EventType.RichMan_Mask_Changed,SetMask)
    eventMgr:AddListener(EventType.RichMan_ActionQueue_End,OnActionQueueEnd);
    -- eventMgr:AddListener(EventType.RichMan_data_Update,Refresh);
    eventMgr:AddListener(EventType.Mission_List,RefreshDice)--任务数据更新时刷新骰子数量
    eventMgr:AddListener(EventType.RedPoint_Refresh,OnRedUpdate)
    eventMgr:AddListener(EventType.RichMan_Dice_Refresh,RefreshDice)
    eventMgr:AddListener(EventType.RichMan_Throw_Ret,OnThrowRet)--扣除骰子数量
    eventMgr:AddListener(EventType.RichMan_ActionQueue_Start,OnQueueStart)
    eventMgr:AddListener(EventType.View_Lua_Closed,OnViewClosed);
    OnRedUpdate();
end

function OnDestroy()
    eventMgr:ClearListener();
end

function OnViewClosed(viewKey)
    if viewKey=="ShopView" then
        RefreshMoney();
    end
end

function OnRedUpdate()
    local _pData1 = RedPointMgr:GetData(RedPointType.RichMan)
    local isRed=_pData1 ==true;
    UIUtil:SetRedPoint(btnTask, isRed, 65, 85, 0)
end

function Refresh()
    curData=RichManMgr:GetCurData();
    if curData==nil then
        LogError("未获取到活动数据！");
        do return end
    end
    --处理显示
    CSAPI.SetGOActive(stateNode1,isMain);
    CSAPI.SetGOActive(stateNode2,not isMain);
    if isMain then
        --初始化活动信息
        local st= TimeUtil:GetTimeStampBySplit(curData:GetOpenTime())
        local et=TimeUtil:GetTimeStampBySplit(curData:GetCloseTime())
        local sTime=TimeUtil:GetTimeHMS(st)
        local eTime=TimeUtil:GetTimeHMS(et)
        local s1=LanguageMgr:GetByID(160010,sTime.month,sTime.day)..string.format(" %s:%s",sTime.hour<10 and "0"..sTime.hour or sTime.hour,sTime.min<10 and "0"..sTime.min or sTime.min);
        local s2=LanguageMgr:GetByID(160010,eTime.month,eTime.day)..string.format(" %s:%s",eTime.hour<10 and "0"..eTime.hour or eTime.hour,eTime.min<10 and "0"..eTime.min or eTime.min)
        local str=s1.."-"..s2;
        --初始化开始/结束时间
        CSAPI.SetText(txtTime,str);
        RefreshMoney();
    else
        RefreshTask();
        RefreshDice();
        SetEventState();
    end
end

function RefreshMoney()
    if isMain and curData then
        --初始化持有货币
        local coin=curData:GetCoinGoods();
        CSAPI.SetGOActive(moneyNode,coin~=nil);
        if coin then
            coin:GetIconLoader():Load(moneyIcon,coin:GetIcon().."_2");
            CSAPI.SetText(txtMoney,tostring(coin:GetCount()));
        end
    end
end

--刷新骰子数量
function RefreshDice(eventData)
    if curData==nil then
        do return end
    end
    --获取骰子数量
    local normal=curData:GetNormalDice();
    local sp=curData:GetSpecialDice();
    currNDiceNum=eventData~=nil and eventData.nDiceNum or normal:GetCount()
    currSDiceNum=eventData~=nil and eventData.sDiceNum or sp:GetCount()
    CSAPI.SetText(txtRollNum,tostring(currSDiceNum));
    CSAPI.SetText(txtRollNum2,tostring(currNDiceNum));
end

function OnThrowRet(isSPDice)
    --直接缓存数量-1
    RefreshDice({nDiceNum=isSPDice==true and currNDiceNum or currNDiceNum-1,sDiceNum=isSPDice==true and currSDiceNum-1 or currSDiceNum});
end

function SetEventState()
    --获取随机事件状态描述
    local events=curData:GetEventList();
    local isShow=false;
    if events~=nil and  #events>=1 then
        isShow=true;
        CSAPI.SetText(txtFixed,events[1]:GetDiceDesc());
    end
    if isShow==true and RichManMgr:GetAutoState()~=true  then
        isEvent=true;
        PlayTween(rollAnimator2,"btnRoll2_switch")
    else
        isEvent=false;
    end
end

--初始化tips内容，骰子数量,tips永远显示当前圈数起点格子的目标步数及其达成状态
function RefreshTask()
    local task = curData:GetCurrTask();
    CSAPI.SetGOActive(tipsObj, task ~= nil);
    local isShow=false;
    if task ~= nil then
        -- 获取当前执行的步数
        isShow=curData:GetThrowCnt()>task[2];
        --设置数量
        CSAPI.SetText(txtTipsNum,tostring(task[1].num));
        CSAPI.SetText(txtTipsDesc, LanguageMgr:GetByID(160004, task[2]));
        CSAPI.SetText(txtTipsInfo, LanguageMgr:GetByID(isShow and 160013 or 160011, curData:GetThrowCnt(), task[2]));
    end
    CSAPI.SetGOActive(tipsMask,isShow)
end

function OnQueueStart()
    SetMask(true);
    queueIsPlaying=true;
end

function OnClickTask()
    CSAPI.PlaySound("temp/temp.acb","Monopoly_Effects_05");
    CSAPI.OpenView("MissionActivity", {
        type = eTaskType.RichMan,
        group = curData:GetTaskGroup()})
end

function OnClickTask2()
     CSAPI.PlaySound("temp/temp.acb","Monopoly_Effects_05");
     local task = curData:GetCurrTask();
     if task ~= nil then
        local fakeData=BagMgr:GetFakeData(task[1].id);
        CSAPI.OpenView("GoodsFullInfo",{data=fakeData});
     end
end

function OnClickShop()
    CSAPI.PlaySound("temp/temp.acb","Monopoly_Effects_05");
    curData:OpenShop();
end

function OnClickStart()
    CSAPI.PlaySound("temp/temp.acb","Monopoly_Effects_05");
    isMain=false;
    EventMgr.Dispatch(EventType.RichMan_UIState_Switch,isMain)
    Refresh();
end

--遥控骰子
function OnClickRoll()
    CSAPI.PlaySound("temp/temp.acb","Monopoly_Effects_05");
    PlayTween(rollAnimator,"btnRoll_sel");
    CSAPI.OpenView("RichRollSelect");
end

--随机骰子
function OnClickRoll2()
    -- local point=1;
    -- local gridInfo=curData:GetCurPosGridInfo();
    -- local pos=(gridInfo:GetSort()+point)%32==0 and 32 or (gridInfo:GetSort()+point)%32;
    -- local proto={point=point,sort=pos,mapId=1005,throwCnt=curData:GetThrowCnt()+1,stepCnt=point};
    -- OperateActiveProto:RichManThrowRet(proto);
    -- SetMask(true);
    -- LogError(proto);
    CSAPI.PlaySound("temp/temp.acb","Monopoly_Effects_05");
    if RichManMgr:GetAutoState()~=true then
        if isEvent then
            PlayTween(rollAnimator2,"btnRoll2_switch2");
        else
            PlayTween(rollAnimator2,"btnRoll_sel");
        end
    end
    SendRoll();
end

function SendRoll()
    local normal = curData:GetNormalDice();
    if normal:GetCount() >= 1 then
        -- 发送投掷协议
        OperateActiveProto:RichManThrow(RichManMgr:GetAutoState());
        EventMgr.Dispatch(EventType.RichMan_Mask_Changed,true)
    else
        -- 提示骰子数量不足
        Tips.ShowTips(LanguageMgr:GetTips(15000, normal:GetName()))
    end
end


function OnAutoSendRoll()
    local normal=curData:GetNormalDice();
    if normal:GetCount()>=1 then
    -- if count>0 then
        --发送投掷协议
        -- OperateActiveProto:RichManThrow(isAuto);
        SendRoll();
        -- count=count-1;
    else
        RichManMgr:SetAutoState(false)
        SetAutoThrow(false)
    end
end

--点击自动投掷
function OnClickAuto()
    -- count=3;
    local normal=curData:GetNormalDice();
    if isEvent and not IsNil(rollAnimator2) then
        PlayTween(rollAnimator2,"btnRoll2_switch2");
    end
    if normal:GetCount()>=1 then
        CSAPI.PlaySound("temp/temp.acb","Monopoly_Effects_05");
        PlayTween(autoAnimator,"btnAuto_sel");
        SetAutoThrow(true)
    else
        Tips.ShowTips(LanguageMgr:GetTips(15000, normal:GetName()))
    end
end

function OnClickAuto2()
    -- count=0;
    CSAPI.PlaySound("temp/temp.acb","Monopoly_Effects_05");
          PlayTween(autoAnimator,"btnAuto_Nsel");
    SetAutoThrow(false)
end

function SetMask(isShow)
    CSAPI.SetGOActive(mask,isShow==true);
end

function OnClickQuestion()
    local cfg = Cfgs.CfgModuleInfo:GetByID("RichMan")
    if(cfg)then 
        CSAPI.OpenView("ModuleInfoView", cfg)
    end
end

--播放完时
function OnActionQueueEnd()
    Refresh();
    if RichManMgr:GetAutoState() then
        OnAutoSendRoll();--抛骰子
    end
    SetMask(false);
    queueIsPlaying=false;
end

function PlayTween(animator,tweenName,delay,func)
    if animator~=nil and tweenName~=nil then
        animator:Play(tweenName,-1,0);
        if delay~=nil and func~=nil then
            FuncUtil:Call(func,nil,delay);
        end
    end
end

function SetAutoThrow(_isAuto)
    RichManMgr:SetAutoState(_isAuto);
    if _isAuto~=true then
        PlayTween(autoAnimator,"Idle");
    end
    CSAPI.SetGOActive(btnAuto,not _isAuto);
    CSAPI.SetGOActive(btnAuto2,_isAuto);
    if _isAuto~=true then
        CSAPI.SetRTSize(btnAuto,174,161)
    end
    if _isAuto and queueIsPlaying~=true then
        OnAutoSendRoll();
    elseif _isAuto~=true then
        OperateActiveProto:RichManStopAutoThrow();
    end
end

function Exit()
    local temp=isMain;
    isMain=true;
    EventMgr.Dispatch(EventType.RichMan_UIState_Switch,isMain)
    Refresh();
    return not temp;
end