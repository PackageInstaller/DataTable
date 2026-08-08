---@class ClientMidw
local ClientMidw = class("ClientMidw", Standalone and nil or function (...)
	return NetHandler2.New(...)
end)

function ClientMidw.OpenPb(path)
--    local addr = io.open(path, "rb")
--    local buffer = addr:read "*a"

--    addr:close()
--    protobuf.register(buffer)
    
	-- *** use pbc ***
    -- local buffer = DFileUtil.ReadFile(path)
    -- protobuf.register(buffer)
	-- *** use pbc ***

	-- *** use lua-protobuf ***
	local buffer = DFileUtil.ReadFile(path)
	local pb = require "pb"
	pb.option("no_default_values")
	pb.option("encode_default_values")
	pb.load(buffer)
	-- *** use lua-protobuf ***
end

if not Standalone then
	return ClientMidw
end

LuaMgr:AddLuaSearchPath("../../../server/game/handler")

local DQueue = require "DQueue"
SrvSim = require "SrvSim":new()

function ClientMidw:ctor()
	self.protoQueue = DQueue:new()
	self.sessionId = 0
	self.updateEnabled = true
end

function ClientMidw:Connect(ip, port, callback)
	callback(true)
end

function ClientMidw:QueueSend(id, buf)
	self.sessionId = self.sessionId + 1
	self.protoQueue:pushBack({ id = id, buf = buf, sessionId = self.sessionId })
	return self.sessionId
end

function ClientMidw:SimUpdate()
	if not self.updateEnabled then
		self.updateEnabled = true
		return
	end
	self.updateEnabled = false
	GV.IsServerLogic = true
	while not self.protoQueue:empty() do
		local proto = self.protoQueue:popFront()
		local msg = SrvSim:dealProto(proto)
		-- 可能有通知消息
		for k,v in pairs(SrvSim:readNotifies()) do
			local notiMsg = v
			self:ProtoHandle(notiMsg.sessionId, notiMsg.id, notiMsg.buf)
		end
		if msg then -- 如果是客户端Report那么这里会空
			self:ProtoHandle(msg.sessionId, msg.id, msg.buf)
		end
	end
	GV.IsServerLogic = nil
end

return ClientMidw