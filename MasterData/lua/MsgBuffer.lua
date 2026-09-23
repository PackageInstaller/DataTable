-----------------------------------------------------------
MsgBuffer = oo.class()
function MsgBuffer:Init()
	self.buffer = BufferUtil.New();
end

-- 设置数据
function MsgBuffer:SetData(data)
	self.buffer:SetBytes(data)
end

-- 追加数据
function MsgBuffer:Append(data)
	self.buffer:Append(data)
end

function MsgBuffer:AppendBuffer(data)
	self.buffer:AppendBuffer(data)
end
-- 获取buffer长度
function MsgBuffer:Size()
	return self.buffer:Size()
end

function MsgBuffer:Clear()
	self.buffer:Clean()
end

function MsgBuffer:GetBuffer()
	return self.buffer:GetBytes()
end
----------------------------------------
-- 写
function MsgBuffer:WriteString(val)
	self.buffer:WriteString(val)
end

function MsgBuffer:WriteUInt64(val)
	self.buffer:WriteLong(val)
end

function MsgBuffer:WriteUInt32(val)
	self.buffer:WriteUInt(val)
end

function MsgBuffer:WriteInt32(val)
	self.buffer:WriteInt(val)
end

function MsgBuffer:WriteUInt16(val)
	self.buffer:WriteUInt16(val)
end

function MsgBuffer:WriteInt16(val)
	self.buffer:WriteInt16(val)
end

function MsgBuffer:WriteUInt8(val)
	self.buffer:WriteInt8(val)
end

function MsgBuffer:WriteBool(val)
	if val then
		self.buffer:WriteInt8(1)
	else
		self.buffer:WriteInt8(0)
	end
end

function MsgBuffer:WriteFloat(val)
	self.buffer:WriteFloat(val)
end

function MsgBuffer:WriteDouble(val)
	self.buffer:WriteDouble(val)
end
----------------------------------------
-- 读
function MsgBuffer:ReadString()
	local val = self.buffer:ReadString()
	return val
end

function MsgBuffer:ReadUInt64()
	local val = self.buffer:ReadLong()
	return val
end

function MsgBuffer:ReadUInt32()
	local val = self.buffer:ReadUInt()
	return val
end

function MsgBuffer:ReadInt32()
	local val = self.buffer:ReadInt()
	return val
end

function MsgBuffer:ReadUInt16()
	local val = self.buffer:ReadUInt16()
	return val
end

function MsgBuffer:ReadInt16()
	local val = self.buffer:ReadInt16()
	return val
end

function MsgBuffer:ReadUInt8()
	local val = self.buffer:ReadInt8()
	return val
end

function MsgBuffer:ReadBool()
	local val = self.buffer:ReadInt8()
	if val ~= 0 then 
		return true 
	else
		return false
	end
end

function MsgBuffer:ReadFloat()
	local val = self.buffer:ReadFloat()
	-- Log( "MsgBuffer:ReadFloat"..(val or nil))
	return val
end

function MsgBuffer:ReadDouble()
	local val = self.buffer:ReadDouble()
	-- Log( "MsgBuffer:ReadDouble"..(val or nil))
	return val
end