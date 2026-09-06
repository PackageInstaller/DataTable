-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/richmanxplan/model/RichmanxplanModel.lua

module("logic.extensions.richmanxplan.view.RichmanxplanModel", package.seeall)

local RichmanxplanModel = class("RichmanxplanModel", BaseModel)

function RichmanxplanModel:ctor()
	return
end

function RichmanxplanModel:onInit()
	self:onReset()
end

function RichmanxplanModel:onReset()
	self._msgInfos = {}
	self._workInfo = nil
end

function RichmanxplanModel:setInfo(msg)
	self._msgInfos[msg.activityId] = GameUtil.pbToTable(msg)
	self._msgInfos[msg.activityId].zones = self._msgInfos[msg.activityId].zones or {}
end

function RichmanxplanModel:getInfo(activityId)
	return self._msgInfos[activityId]
end

function RichmanxplanModel:getLocation(activityId)
	return self:getInfo(activityId).location
end

function RichmanxplanModel:updateLocation(activityId, location)
	self:getLocation(activityId).zoneId = location.zoneId
	self:getLocation(activityId).gridId = location.gridId
end

function RichmanxplanModel:setEventState(activityId, state)
	local info = self:getInfo(activityId)

	if info.event then
		info.event.state = state
	end
end

function RichmanxplanModel:reduceBuffTime(activityId, reduceTime)
	reduceTime = reduceTime or 1

	local info = self:getInfo(activityId)

	if info.buffs then
		for i, v in ipairs(info.buffs) do
			v.leftTimes = math.max(v.leftTimes - reduceTime, 0)
		end
	end

	if info.lottery then
		for i, v in ipairs(info.lottery) do
			v.leftTimes = math.max(v.leftTimes - reduceTime, 0)
		end
	end
end

function RichmanxplanModel:setWorkInfo(msg)
	self._workInfo = GameUtil.pbToTable(msg) or {}
	self._workInfo.positions = self._workInfo.positions or {}
	self._workInfo.pets = self._workInfo.pets or {}
end

function RichmanxplanModel:getWorkInfo()
	return self._workInfo
end

function RichmanxplanModel:getBuffRate(activityId)
	if not self:getInfo(activityId).buffs then
		return 0
	end

	local rateValue = 0

	for i, v in ipairs(self:getInfo(activityId).buffs) do
		local buffCfg = RichmanxplanConfig.instance:getBuffCfg(activityId, v.buffId)

		if v.leftTimes > 0 then
			rateValue = rateValue + buffCfg.addRate
		end
	end

	return rateValue
end

function RichmanxplanModel:getPetData(petId)
	for i, v in ipairs(self._workInfo.pets) do
		if v.petId == petId then
			return v
		end
	end
end

function RichmanxplanModel:getPetDatas()
	return self._workInfo.pets or {}
end

function RichmanxplanModel:unlockWorkPosition(activityId, position)
	if self._workInfo.activityId == activityId then
		self._workInfo.positions = self._workInfo.positions or {}

		local successed = false

		for i, v in ipairs(self._workInfo.positions) do
			if v.posId == position.posId then
				self._workInfo.positions[i] = GameUtil.pbToTable(position)
				successed = true

				break
			end
		end

		if not successed then
			table.insert(self._workInfo.positions, GameUtil.pbToTable(position))
		end
	end
end

function RichmanxplanModel:getWorkPosData(activityId, posId)
	if self._workInfo.positions and self._workInfo.activityId == activityId then
		for i, v in ipairs(self._workInfo.positions) do
			if v.posId == posId then
				return v
			end
		end
	end
end

function RichmanxplanModel:getScore(activityId)
	local score = self:getInfo(activityId).score

	return checknumber(score)
end

function RichmanxplanModel:updatePositions(activityId, positions)
	if self._workInfo.activityId == activityId then
		self._workInfo.positions = GameUtil.pbToTable(positions) or {}
	end
end

function RichmanxplanModel:updatePositionsNotFull(activityId, positions)
	if self._workInfo.activityId == activityId then
		for i, v in ipairs(self._workInfo.positions) do
			for _, pd in ipairs(positions) do
				if pd.posId == v.posId then
					self._workInfo.positions[i] = GameUtil.pbToTable(pd)

					break
				end
			end
		end
	end
end

function RichmanxplanModel:updateCurrScore(activityId, curScore)
	local info = self:getInfo(activityId)

	if info then
		info.score = curScore
	end
end

function RichmanxplanModel:workPetsChange(msg)
	if self._workInfo and self._workInfo.activityId == msg.activityId then
		local delPetIds = {}

		for i, v in ipairs(msg.deletePetIds) do
			delPetIds[v] = v
		end

		self._workInfo.pets = self._workInfo.pets or {}

		for i = #self._workInfo.pets, 1, -1 do
			if delPetIds[self._workInfo.pets[i].petId] then
				table.remove(self._workInfo.pets, i)
			end
		end

		local pets = {}

		for i, v in ipairs(self._workInfo.pets) do
			pets[v.petId] = v
		end

		for i, v in ipairs(msg.addPets) do
			if pets[v.petId] then
				pets[v.petId].starLevel = v.starLevel
			else
				table.insert(self._workInfo.pets, GameUtil.pbToTable(v))
			end
		end
	end
end

function RichmanxplanModel:addBuffEvent(activityId, buffId)
	local info = self:getInfo(activityId)

	info.buffs = info.buffs or {}

	local isHit = false
	local cfg = RichmanxplanConfig.instance:getBuffCfg(activityId, buffId)

	for i, buff in ipairs(info.buffs) do
		if buff.buffId == buffId then
			isHit = true
			buff.leftTimes = buff.leftTimes + cfg.times

			break
		end
	end

	if not isHit then
		table.insert(info.buffs, {
			buffId = buffId,
			leftTimes = cfg.times
		})
	end
end

function RichmanxplanModel:buyTudiRes(msg)
	local info = self:getInfo(msg.activityId)

	info.zones = info.zones or {}

	for i, v in ipairs(info.zones) do
		if v.zoneId == msg.location.zoneId then
			v.grids = v.grids or {}

			for i, grid in ipairs(v.grids) do
				if grid.gridId == msg.location.gridId then
					return
				end
			end

			table.insert(v.grids, {
				zoneId = msg.location.zoneId,
				gridId = msg.location.gridId,
				eventType = RichmanxplanController.EventType.Tudi,
				eventId = msg.eventId,
				param = msg.resultParam
			})

			return
		end
	end

	table.insert(info.zones, {
		zoneId = msg.location.zoneId,
		grids = {
			{
				zoneId = msg.location.zoneId,
				gridId = msg.location.gridId,
				eventType = RichmanxplanController.EventType.Tudi,
				eventId = msg.eventId,
				param = msg.resultParam
			}
		}
	})
end

RichmanxplanModel.instance = RichmanxplanModel.New()

return RichmanxplanModel
