-- chunkname: @modules/logic/versionactivity2_2/eliminate/model/mo/WarChessFightResultMO.lua

module("modules.logic.versionactivity2_2.eliminate.model.mo.WarChessFightResultMO", package.seeall)

local WarChessFightResultMO = class("WarChessFightResultMO")

function WarChessFightResultMO:updateInfo(info)
	self.resultCode = info.resultCode

	if not string.nilorempty(info.extraData) then
		self.result = cjson.decode(info.extraData)
	end
end

function WarChessFightResultMO:getResultInfo()
	return (self.result or nil) and (self.result or {})
end

function WarChessFightResultMO:getRewardCount()
	local count = 0

	if self.result then
		for key, value in pairs(self.result) do
			if key ~= "star" then
				count = count + tabletool.len(value)
			end
		end
	end

	return count
end

function WarChessFightResultMO:getStar()
	return (self.result or nil) and tonumber(self.result.star)
end

function WarChessFightResultMO:haveReward()
	local count = self:getRewardCount()

	return count > 0
end

return WarChessFightResultMO
