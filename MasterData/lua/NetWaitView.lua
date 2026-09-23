--等待指定网络消息，等待期间禁用点击
--超时回调（默认3秒）
--成功无事发生
local netWait_maskIcon = nil
function OnInit()
	InitListener();
end

function InitListener()
	eventMgr = ViewEvent.New();
	eventMgr:AddListener(EventType.Net_Msg_Wait, OnMsgWait);	
    eventMgr:AddListener(EventType.Net_Msg_Getted, OnMsgGetted);	
    netWait_maskIcon = transform:Find("mask/subMask/icon").gameObject
end

function OnMsgWait(data)

    --LogError(data);

    local msgName = data and data.msg;
    if(not msgName)then
        return;
    end
    if netWait_maskIcon and CSAPI.IsDomestic() then
        CSAPI.SetGOActive(netWait_maskIcon,not msgName == "pay_wait");
    end

    if(waitingDic and waitingDic[msgName])then
        LogWarning("已存在相同的等待消息");
        return;
    end
   
    UpdateWaitingData(msgName,data);
    local time =3000;
    if data and data.time then
        time=data.time;
    end
    if time>=0 then--时间为负数则显示时间不受限制
        FuncUtil:Call(MsgTimer,nil,data and data.time or 3000,data);
    end
end
function MsgTimer(data)
    if(not data or data.getted)then
        return;
    end

    local msgName = data.msg;
    SetMsgGetState(msgName,false);
    ApplyCallBack(data);--超时反馈
end

function ApplyCallBack(data)
    local callBack = data and data.timeOutCallBack;
    if(callBack)then--自定义超时回调
        callBack(data and data.caller);
    end
end


function OnMsgGetted(msgName)
    --LogError(msgName);
    SetMsgGetState(msgName,true);
end

function SetMsgGetState(msgName,getState)
   if(not msgName)then
        return;
    end    

    local waitingData = waitingDic and waitingDic[msgName];
    if(waitingData)then
        waitingData.getted = getState;
        UpdateWaitingData(msgName,nil);
    end
end

function UpdateWaitingData(msgName,data)
    waitingDic = waitingDic or {};
    waitingDic[msgName] = data;

    UpdateMaskState();
end

--更新遮罩状态
function UpdateMaskState()
    local state = false;
    if(waitingDic)then
        for _,data in pairs(waitingDic)do
            if(data)then
                state = true;
                break;
            end
        end
    end
    
    CSAPI.SetGOActive(mask,state);
    if(state)then
        SetSubMaskState(false);
        FuncUtil:Call(SetSubMaskState,nil,1000,true);
    end
end

function SetSubMaskState(state)
    if(subMask)then
        CSAPI.SetGOActive(subMask,state);
    end
end