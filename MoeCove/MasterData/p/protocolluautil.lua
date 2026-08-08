
local PROTO_HEAD_SIZE = 2
local PROTO_TAIL_SIZE_SEND = 4
local PROTO_TAIL_SIZE_RECEIVE = 5

local struct = require "struct"

-- *** use pbc ***
-- require "3rd/pbc/protobuf"
-- local buffer = DFileUtil.ReadFile("netmsg.pb")
-- protobuf.register(buffer)
-- *** use pbc ***

-- *** use lua-protobuf ***
local buffer = DFileUtil.ReadFile("netmsg.pb")
local pb = require "pb"
pb.option("no_default_values")
pb.option("encode_default_values")
pb.load(buffer)
-- *** use lua-protobuf ***

function Parse(buffer, offset, size)
	
	if size < PROTO_HEAD_SIZE then
		return 0,nil
	end

	local DataLen, s = struct.unpack(">I" .. PROTO_HEAD_SIZE .. "c"..tostring(size - PROTO_HEAD_SIZE), buffer)

	local ret = PROTO_HEAD_SIZE + DataLen

	if size < ret then
		return 0,nil
	end

	if DataLen < PROTO_TAIL_SIZE_RECEIVE then
		return -2,nil
	end

	local content, result, sessionId
	if DataLen == PROTO_TAIL_SIZE_RECEIVE then
		result, sessionId = struct.unpack(">BI4", s)
		return -1, sessionId
	else
		content, result, sessionId = struct.unpack("c"..tostring(DataLen - PROTO_TAIL_SIZE_RECEIVE)..">BI4", s)
	end

	if result ~= 0 then
		return result,nil
	end

	-- if content == nil then
	-- 	return -1,nil
	-- end

	local tb = protobuf.decode("netmsg.NetMsg", content)

	-- if tb == nil then
	-- 	return -1,nil
	-- end
	
	local protoId = tb.action
	local data = tb.payload

	local protocolObj = nil

	if protoId and data and sessionId then
		protocolObj = Protocol2.New(protoId, data, sessionId)
	end

	return ret,protocolObj
end

function Make(protocolObj)

	if protocolObj == nil then
		return nil
	end

	local protocolData = protocolObj:Bytes()
	local protoId = protocolObj:ProtocolId()
	local sessionId = protocolObj:SessionId()

	local buf = protobuf.encode("netmsg.NetMsg", { action = protoId, payload = protocolData })

	local size = #buf + PROTO_TAIL_SIZE_SEND
    local data = struct.pack(">I2", size) .. buf .. struct.pack(">I4", sessionId)

    local byteBuffer = Protocol2Buffer.New(data)

    return byteBuffer
end