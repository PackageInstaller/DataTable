local this = {};
    
function this.New(csBuffer)
    this.__index = this.__index or this;
	local ins = {};
	setmetatable(ins,this);	    
    ins:Init(csBuffer);
	return ins; 
end

function this:Init(csBuffer)
    if(csBuffer == nil)then
        csBuffer = CS.Buffer:GetBuffer();
    end
    self.buffer = csBuffer;
end

function this:WriteInt8(value)
    self.buffer:WriteInt8(value);
end
function this:ReadInt8()
    return self.buffer:ReadInt8();
end

function this:WriteInt16(value)
    self.buffer:WriteInt16(value);
end
function this:ReadInt16()
    return self.buffer:ReadInt16();
end

function this:WriteUInt16(value)
    self.buffer:WriteInt16(value);
end
function this:ReadUInt16()
    local val = self.buffer:ReadInt16();
    ASSERT(val >= 0)
    return val
end

function this:WriteInt(value)
    self.buffer:WriteInt(value);
end
function this:ReadInt()
    return self.buffer:ReadInt();
end
function this:WriteUInt(value)
    self.buffer:WriteUInt(value);
end
function this:ReadUInt()
    return self.buffer:ReadUInt();
end

function this:WriteLong(value)
    self.buffer:WriteLong(value);
end
function this:ReadLong()
    return self.buffer:ReadLong();
end

function this:WriteFloat(value)
    self.buffer:WriteFloat(value);
end
function this:ReadFloat()
    return self.buffer:ReadFloat();
end

function this:ReadDouble()
    return self.buffer:ReadDouble();
end
function this:WriteDouble(value)
    self.buffer:WriteDouble(value);
end

function this:WriteString(value)
    self.buffer:WriteString(value);
end
function this:ReadString()
    return self.buffer:ReadString();
end

function this:GetBytes()
    local bytes = {};

    local datas = self.buffer:GetBytes();
    local count = datas.Count;
    for i = 0,(count - 1) do
        local data = datas[i];
        
        table.insert(bytes,data);
    end
    return bytes;
end

function this:SetBytes(datas)   
    self.buffer:SetBytes(datas);
end

function this:Append(datas)   
    self.buffer:Append(datas);
end

function this:AppendBuffer(buffer)
    self.buffer:AppendBuffer(buffer.buffer);
end

function this:Clean()
    self.buffer:Clean()
end

function this:Size()
    return self.buffer:Size();
end



return this;

