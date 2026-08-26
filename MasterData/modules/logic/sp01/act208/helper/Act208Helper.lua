-- chunkname: @modules/logic/sp01/act208/helper/Act208Helper.lua

module("modules.logic.sp01.act208.helper.Act208Helper", package.seeall)

local Act208Helper = {}

function Act208Helper.getCurPlatformType()
	local subChannelId = SDKMgr.instance:getSubChannelId()

	if subChannelId == "1005" or subChannelId == "1025" then
		return Act208Enum.ChannelId.PC
	else
		return Act208Enum.ChannelId.Mobile
	end
end

return Act208Helper
