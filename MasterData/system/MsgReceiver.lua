-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/System\\MsgReceiver.lua

local strClassName = "MsgReceiver"
local MsgReceiver = Class(strClassName)

function MsgReceiver:ctor(channelIDs)
	self.cIDs = channelIDs or {}
	self.mEventReceive = nil
	self.mEventUpdate = nil
	self.id = MsgManager.registReceiver(self)
end

function MsgReceiver:destroy()
	MsgManager.unregistReceiver(self.id)
end

function MsgReceiver:changeChannel(channelIDs)
	local isHit = false

	self.cIDs = channelIDs

	local msgDatas = MsgManager.getChannelMsgs(self.cIDs)

	self:onUpdate(msgDatas)
end

function MsgReceiver:update()
	self:changeChannel(self.cIDs)
end

function MsgReceiver:onReceive(msgData)
	local isHit = false

	for i, cid in pairs(self.cIDs) do
		if cid == msgData.channel then
			isHit = true

			break
		end
	end

	if not isHit then
		return
	end

	if self.mEventReceive ~= nil then
		self.mEventReceive(msgData)
	end
end

function MsgReceiver:onUpdate(msgDatas)
	if self.mEventUpdate ~= nil then
		self.mEventUpdate(msgDatas)
	end
end

return MsgReceiver
