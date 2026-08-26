-- chunkname: @modules/logic/reddot/model/RedDotGroupMo.lua

module("modules.logic.reddot.model.RedDotGroupMo", package.seeall)

local RedDotGroupMo = pureTable("RedDotGroupMo")

function RedDotGroupMo:init(info)
	self.id = tonumber(info.defineId)
	self.infos = self:_buildDotInfo(info.infos)
	self.replaceAll = info.replaceAll
end

function RedDotGroupMo:_buildDotInfo(infos)
	local infoMos = {}
	local isIos = BootNativeUtil.isIOS()

	for _, v in ipairs(infos) do
		if isIos and ActivityEnum.IOSHideActIdMap[tonumber(v.id)] then
			logNormal("红点初始化 iOS临时屏蔽双端登录活动红点")
		else
			local dotInfoMo = RedDotInfoMo.New()

			dotInfoMo:init(v)

			infoMos[tonumber(v.id)] = dotInfoMo
		end
	end

	return infoMos
end

function RedDotGroupMo:_resetDotInfo(info)
	if info.replaceAll then
		self.infos = {}
	end

	local isIos = BootNativeUtil.isIOS()

	for _, v in ipairs(info.infos) do
		if isIos and ActivityEnum.IOSHideActIdMap[tonumber(v.id)] then
			logNormal("红点更新 iOS临时屏蔽双端登录活动红点")
		elseif self.infos[tonumber(v.id)] then
			self.infos[tonumber(v.id)]:reset(v)
		else
			local dotInfoMo = RedDotInfoMo.New()

			dotInfoMo:init(v)

			self.infos[tonumber(v.id)] = dotInfoMo
		end
	end

	self.replaceAll = info.replaceAll
end

return RedDotGroupMo
