-- chunkname: @modules/logic/bgmswitch/model/BGMSwitchInfoMo.lua

module("modules.logic.bgmswitch.model.BGMSwitchInfoMo", package.seeall)

local BGMSwitchInfoMo = pureTable("BGMSwitchInfoMo")

function BGMSwitchInfoMo:ctor()
	self.bgmId = 0
	self.unlock = 0
	self.favorite = false
	self.isRead = false
end

function BGMSwitchInfoMo:init(info)
	self.bgmId = info.bgmId
	self.unlock = info.unlock
	self.favorite = info.favorite
	self.isRead = info.isRead
end

function BGMSwitchInfoMo:reset(info)
	self.bgmId = info.bgmId
	self.unlock = info.unlock
	self.favorite = info.favorite
	self.isRead = info.isRead
end

return BGMSwitchInfoMo
