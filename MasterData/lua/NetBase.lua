local this = {};

function this.New(socketName)
    this.__index = this.__index or this;
	local ins = {};
	setmetatable(ins,this);	    
    ins:Init(socketName);
	return ins; 
end

this.socketName = nil;

function this:Init(socketName)
    self.socketName = socketName;
    local socketMgr = CSAPI.GetSocketMgr(socketName);
    if(socketMgr == nil)then
        return;
    end

    self.socketMgr = socketMgr;
end
--连接
function this:Connect(ip,port,callBack)
    self.socketMgr:Connect(ip,port,callBack);
end
--断开连接
function this:Disconnect()
    self.socketMgr:Disconnect();
end

--发送协议
function this:Send(proto)  
    -- local json = Json.encode(proto);
    -- self:SendJson(json);
    if proto and proto[1] ~= "ClientProto:Heartbeat" then
        -- Log( "client send :".. proto[1])
        LogTable(proto, "client send :".. proto[1])        
        --ProtocolRecordMgr:Record(proto,1);
    end
    local buffer = IVProto:ClientEncoder(proto[1], proto[2])
    ASSERT(buffer.buffer)
    return self:SendBuffer(buffer.buffer);
end
--发送
function this:SendJson(json)
    return self.socketMgr:SendJson(json);
end

--发送Buffer
function this:SendBuffer(buffer)
    return self.socketMgr:SendBuffer(buffer.buffer);
end

function this:IsConnected()
    return self.socketMgr and self.socketMgr.isConnected;
end

return this;