require "CallFunc";
require "LoginCommFuns"

function Awake()
    EventMgr.AddListener(EventType.Net_Msg,OnNetMsg);
    EventMgr.AddListener(EventType.Net_Msg_New,OnNetMsgNew);
    --EventMgr.AddListener(EventType.Net_Disconnect,OnNetDisconnect);
    EventMgr.AddListener(EventType.Net_Weak,OnNetWeak);
    EventMgr.AddListener(EventType.Net_Ping,OnNetPing);
end

function OnNetMsg(param)
    -- local table = Json.decode(param);
--    DebugLog("收到消息包=======================");
--    DebugLog(table);
    -- if(table == nil)then
    --     LogError("无法解析消息：");
    --     LogError(param);
    -- end
    -- CallRecv(table[1], table[2]);
end

function OnNetMsgNew(csBuffer)   
    local buffer = BufferUtil.New(csBuffer);
    --ASSERT(buffer)
	local cmdNo, cmdstr, data, bufflen = IVProto:Decoder(buffer:GetBytes())
    if cmdstr == "LoginProto:Heartbeat" then
    else
    	--DebugLog("收到消息包======================= ".. buffer:Size());        
    	LogTable(data, cmdstr)
        
        --ProtocolRecordMgr:Record({[1] = cmdstr,[2] = data});
    end
    -- LogTable("data", "cmdstr")
    if(data == nil)then
        LogError("无法解析消息：");
        LogError(data);
    end    
	CallRecv(cmdstr, data);


    local realTime = CSAPI.GetRealTime();
    lastMsgTime = realTime;
    --EventMgr.Dispatch(EventType.Net_Msg_Getted,cmdstr);
end

--长时间未获得任何消息
function NoMsgLongTime()
    if(not lastMsgTime)then
        return
    end
    local realTime = CSAPI.GetRealTime();
    return realTime - lastMsgTime > 500;
end

--function OnNetDisconnect(param)
--    LogError("重连中......");
--    ReloginAccount();    
--end


function OnNetWeak(param)
    LogWarning("网络不佳......");
    --LogError("网络不佳......");
    if(not PlayerClient:GetUid())then
        return;
    end
    if(NoMsgLongTime())then
        NetMgr.net:Disconnect();
        BackToLogin();
    else
        CSAPI.OpenView("NetWeak");
    end
end


function OnNetPing(param)
    LoginProto:SendHeartbeat();
end
