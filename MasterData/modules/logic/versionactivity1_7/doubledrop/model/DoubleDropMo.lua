-- chunkname: @modules/logic/versionactivity1_7/doubledrop/model/DoubleDropMo.lua

module("modules.logic.versionactivity1_7.doubledrop.model.DoubleDropMo", package.seeall)

local DoubleDropMo = pureTable("DoubleDropMo")

function DoubleDropMo:init(info)
	self.id = info.activityId
	self.totalCount = info.totalCount
	self.dailyCount = info.dailyCount

	self:initConfig()
end

function DoubleDropMo:initConfig()
	if self.config then
		return
	end

	self.config = DoubleDropConfig.instance:getAct153Co(self.id)
end

function DoubleDropMo:isDoubleTimesout()
	if not self.config then
		return true
	end

	local remainDaily, dailyLimit = self:getDailyRemainTimes()

	return remainDaily == 0, remainDaily, dailyLimit
end

function DoubleDropMo:getDailyRemainTimes()
	if not self.dailyCount then
		local dailyCount = 0

		if not self.config.dailyLimit then
			local dailyLimit = 0
			local remainTotal = self.config.totalLimit - self.totalCount
			local remainDaily = dailyLimit - dailyCount

			if remainTotal < dailyLimit then
				remainDaily = math.min(remainDaily, remainTotal)
			end

			if remainDaily < 0 then
				remainDaily = 0
			end

			return remainDaily, dailyLimit
		end
	end
end

return DoubleDropMo
