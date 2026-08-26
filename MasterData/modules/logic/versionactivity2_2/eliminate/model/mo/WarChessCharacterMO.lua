-- chunkname: @modules/logic/versionactivity2_2/eliminate/model/mo/WarChessCharacterMO.lua

module("modules.logic.versionactivity2_2.eliminate.model.mo.WarChessCharacterMO", package.seeall)

local WarChessCharacterMO = class("WarChessCharacterMO")

function WarChessCharacterMO:init(data)
	self.id = data.id
	self.slotIds = {}
	self.diamonds = {}
	self.addDiamonds = {}
	self.removeDiamonds = {}
	self.powerMax = data.powerMax
	self.hpInjury = 0

	self:updateInfo(data)
	self:updateSlotInfo(data.slotBox)
end

function WarChessCharacterMO:updateInfo(data)
	self.hp = data.hp
	self.power = data.power
	self.forecastBehavior = tabletool.copy(data.forecastBehavior)

	self:updateDiamondBox(data.diamondBox)
end

function WarChessCharacterMO:updateSlotInfo(slotBox)
	if slotBox then
		self.slotIds = tabletool.copy(slotBox.pieceId)
	end
end

function WarChessCharacterMO:updateDiamondBox(diamondBox)
	if diamondBox and diamondBox.diamond then
		tabletool.clear(self.diamonds)

		for _, data in ipairs(diamondBox.diamond) do
			local id = data.type

			self.diamonds[id] = data.count
		end
	end
end

function WarChessCharacterMO:updateHp(diffValue)
	if diffValue < 0 then
		self.hpInjury = self.hpInjury + math.abs(diffValue)
	end

	self.hp = self.hp + diffValue

	if self.hp < 0 then
		self.hp = 0
	end
end

function WarChessCharacterMO:updatePower(diffValue)
	self.power = self.power + diffValue
end

function WarChessCharacterMO:updateForecastBehavior(forecastBehavior)
	self.forecastBehavior = tabletool.copy(forecastBehavior)
end

function WarChessCharacterMO:updateDiamondInfo(id, diffValue)
	self.diamonds[id] = self.diamonds[id] == nil and diffValue or self.diamonds[id] + diffValue

	if diffValue > 0 then
		if not self.addDiamonds[id] then
			local num = 0

			self.addDiamonds[id] = num + diffValue
		end
	elseif not self.removeDiamonds[id] then
		local num = 0

		self.removeDiamonds[id] = num + math.abs(diffValue)
	end
end

function WarChessCharacterMO:diamondsIsEnough(diamondId, needCount)
	if not self.diamonds or not self.diamonds[diamondId] then
		return false
	end

	return needCount <= self.diamonds[diamondId]
end

function WarChessCharacterMO:diffData(data)
	local isSame = self.id == data.id

	if self.power ~= data.power then
		isSame = false
	end

	if self.hp ~= data.hp then
		isSame = false
	end

	if self.diamonds and data.diamonds then
		for key, value in pairs(self.diamonds) do
			if value ~= data.diamonds[key] then
				isSame = false
			end
		end
	end

	if self.slotIds and data.slotIds then
		for key, value in ipairs(self.slotIds) do
			if value ~= data.slotIds[key] then
				isSame = false
			end
		end
	end

	return isSame
end

return WarChessCharacterMO
