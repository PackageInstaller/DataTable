-- chunkname: @modules/logic/versionactivity1_3/astrology/model/VersionActivity1_3AstrologyPlanetMo.lua

module("modules.logic.versionactivity1_3.astrology.model.VersionActivity1_3AstrologyPlanetMo", package.seeall)

local VersionActivity1_3AstrologyPlanetMo = pureTable("VersionActivity1_3AstrologyPlanetMo")

function VersionActivity1_3AstrologyPlanetMo:init(info)
	self.id = info.id
	self.angle = info.angle
	self.previewAngle = info.angle
	self.num = info.num

	local itemId = VersionActivity1_3AstrologyEnum.PlanetItem[self.id]

	self.config = ItemModel.instance:getItemConfig(MaterialEnum.MaterialType.Item, itemId)
end

function VersionActivity1_3AstrologyPlanetMo:updatePreviewAngle(angle)
	self.deltaAngle = angle
	self.previewAngle = self.previewAngle + angle

	local limitDegree = 360

	if limitDegree <= self.previewAngle then
		self.previewAngle = self.previewAngle - limitDegree
	elseif self.previewAngle <= -limitDegree then
		self.previewAngle = self.previewAngle + limitDegree
	end
end

function VersionActivity1_3AstrologyPlanetMo:getQuadrant()
	local angle = self.previewAngle % 360
	local quadrantAngle = 45
	local q = math.ceil(angle / quadrantAngle)

	if q == 0 then
		q = 1
	end

	return 9 - q
end

function VersionActivity1_3AstrologyPlanetMo:getItemName()
	return self.config.name
end

function VersionActivity1_3AstrologyPlanetMo:isFront(value)
	local angle = (value or self.previewAngle) % 360

	return angle >= 0 and angle <= 180
end

function VersionActivity1_3AstrologyPlanetMo:getRemainNum()
	return self.num - self:getCostNum()
end

function VersionActivity1_3AstrologyPlanetMo:getCostNum()
	local angle = self:minDeltaAngle()

	return angle / VersionActivity1_3AstrologyEnum.Angle
end

function VersionActivity1_3AstrologyPlanetMo:minDeltaAngle()
	local angle1 = math.abs(self.previewAngle % 360 - self.angle % 360)
	local angle2 = 360 - angle1

	return (math.min(angle1, angle2))
end

function VersionActivity1_3AstrologyPlanetMo:hasAdjust()
	return self.angle % 360 ~= self.previewAngle % 360
end

return VersionActivity1_3AstrologyPlanetMo
