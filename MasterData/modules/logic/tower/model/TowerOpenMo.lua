-- chunkname: @modules/logic/tower/model/TowerOpenMo.lua

module("modules.logic.tower.model.TowerOpenMo", package.seeall)

local TowerOpenMo = pureTable("TowerOpenMo")

function TowerOpenMo:init(id)
	self.id = id
end

function TowerOpenMo:updateInfo(info)
	self.type = info.type
	self.towerId = info.towerId
	self.id = info.towerId
	self.status = info.status
	self.round = info.round
	self.nextTime = info.nextTime
	self.towerStartTime = tonumber(info.towerStartTime)
	self.taskEndTime = tonumber(info.taskEndTime)
end

function TowerOpenMo:getTaskRemainTime(useEn)
	local offsetSecond = self.taskEndTime / 1000 - ServerTime.now()

	if offsetSecond > 0 then
		local date, dateFormat = TimeUtil.secondToRoughTime(offsetSecond, useEn)

		return date, dateFormat
	else
		return nil
	end
end

return TowerOpenMo
