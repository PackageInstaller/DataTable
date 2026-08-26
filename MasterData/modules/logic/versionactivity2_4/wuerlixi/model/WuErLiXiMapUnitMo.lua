-- chunkname: @modules/logic/versionactivity2_4/wuerlixi/model/WuErLiXiMapUnitMo.lua

module("modules.logic.versionactivity2_4.wuerlixi.model.WuErLiXiMapUnitMo", package.seeall)

local WuErLiXiMapUnitMo = pureTable("WuErLiXiMapUnitMo")

function WuErLiXiMapUnitMo:ctor()
	self.id = 0
	self.x = 0
	self.y = 0
	self.unitType = 0
	self.dir = 0
	self.isActive = false
end

function WuErLiXiMapUnitMo:init(unit)
	self.id = unit[1]
	self.x = unit[2]
	self.y = unit[3]
	self.unitType = unit[4]
	self.dir = unit[5]
	self.outDir = self.dir
	self.isActive = self.unitType == WuErLiXiEnum.UnitType.SignalStart or self.unitType == WuErLiXiEnum.UnitType.KeyStart
end

function WuErLiXiMapUnitMo:initByActUnitMo(actUnitMo, x, y)
	self.id = actUnitMo.id
	self.x = x
	self.y = y
	self.unitType = actUnitMo.type
	self.dir = actUnitMo.dir
	self.outDir = self.dir
	self.isActive = self.unitType == WuErLiXiEnum.UnitType.SignalStart or self.unitType == WuErLiXiEnum.UnitType.KeyStart
end

function WuErLiXiMapUnitMo:initByUnitMo(unitMo, x, y)
	self.id = unitMo.id
	self.x = x
	self.y = y
	self.unitType = unitMo.unitType
	self.dir = unitMo.dir
	self.outDir = unitMo.outDir
	self.isActive = self.unitType == WuErLiXiEnum.UnitType.SignalStart or self.unitType == WuErLiXiEnum.UnitType.KeyStart
end

function WuErLiXiMapUnitMo:getId()
	return self.id
end

function WuErLiXiMapUnitMo:isUnitActive(rayDir)
	if self.unitType == WuErLiXiEnum.UnitType.SignalStart then
		self.isActive = true
	elseif self.unitType == WuErLiXiEnum.UnitType.KeyStart then
		self.isActive = true
	end

	if rayDir and self.unitType == WuErLiXiEnum.UnitType.Reflection then
		return rayDir == WuErLiXiHelper.getOppositeDir(self.dir) or rayDir == WuErLiXiHelper.getNextDir(self.dir)
	end

	if rayDir and self.unitType == WuErLiXiEnum.UnitType.SignalMulti then
		return rayDir == self.dir
	end

	return self.isActive
end

function WuErLiXiMapUnitMo:couldSetRay(rayType)
	if self.unitType == WuErLiXiEnum.UnitType.SignalStart then
		return false
	elseif self.unitType == WuErLiXiEnum.UnitType.KeyStart then
		return false
	elseif self.unitType == WuErLiXiEnum.UnitType.Obstacle then
		return false
	elseif self.unitType == WuErLiXiEnum.UnitType.Key then
		return rayType == WuErLiXiEnum.RayType.SwitchSignal
	elseif self.unitType == WuErLiXiEnum.UnitType.Switch then
		return self.isActive
	end

	return true
end

function WuErLiXiMapUnitMo:setUnitActive(active, signalType, inDir)
	if not active then
		self.isActive = false

		return
	end

	if self.unitType == WuErLiXiEnum.UnitType.SignalEnd then
		self.isActive = signalType == WuErLiXiEnum.RayType.NormalSignal
	elseif self.unitType == WuErLiXiEnum.UnitType.Reflection then
		if not inDir then
			self.isActive = false

			return
		end

		self.isActive = inDir == WuErLiXiHelper.getOppositeDir(self.dir) or inDir == WuErLiXiHelper.getNextDir(self.dir)
		self.outDir = inDir == WuErLiXiHelper.getNextDir(self.dir) and self.dir or inDir == WuErLiXiHelper.getOppositeDir(self.dir) and WuErLiXiHelper.getNextDir(inDir) or nil
	elseif self.unitType == WuErLiXiEnum.UnitType.SignalMulti then
		if inDir == self.dir then
			self.outDir = self.dir or nil
		end

		self.isActive = inDir == self.dir
	else
		self.isActive = self.unitType == WuErLiXiEnum.UnitType.Key and signalType == WuErLiXiEnum.RayType.SwitchSignal or self.unitType == WuErLiXiEnum.UnitType.Switch and true or self.unitType == WuErLiXiEnum.UnitType.SignalStart and true or self.unitType == WuErLiXiEnum.UnitType.KeyStart
	end
end

function WuErLiXiMapUnitMo:setDir(dir)
	self.dir = dir

	if not self.isActive then
		self.ourDir = nil

		return
	end

	self.outDir = self.dir
end

function WuErLiXiMapUnitMo:setUnitOutDirByRayDir(rayDir)
	if not self.isActive then
		self.outDir = nil

		return
	end

	if self.unitType == WuErLiXiEnum.UnitType.Reflection then
		self.outDir = rayDir == WuErLiXiHelper.getNextDir(self.dir) and self.dir or rayDir == WuErLiXiHelper.getOppositeDir(self.dir) and WuErLiXiHelper.getNextDir(rayDir) or nil

		return
	end

	if self.isActive then
		self.outDir = self.dir or nil
	end
end

function WuErLiXiMapUnitMo:getUnitSignalOutDir()
	if not self.isActive then
		return
	end

	return self.outDir
end

function WuErLiXiMapUnitMo:getUnitDir()
	return self.dir
end

function WuErLiXiMapUnitMo:isIgnoreSignal()
	if self.isActive and self.unitType == WuErLiXiEnum.UnitType.Switch then
		return true
	end

	return false
end

function WuErLiXiMapUnitMo:getUnitSignals(inDir)
	if not self.isActive then
		return {}
	end

	local signals = {}

	if self.unitType == WuErLiXiEnum.UnitType.SignalStart then
		table.insert(signals, {
			self.x,
			self.y
		})
	elseif self.unitType == WuErLiXiEnum.UnitType.KeyStart then
		table.insert(signals, {
			self.x,
			self.y
		})
	elseif self.unitType == WuErLiXiEnum.UnitType.Reflection then
		if inDir then
			if inDir == WuErLiXiHelper.getNextDir(self.dir) or inDir == WuErLiXiHelper.getOppositeDir(self.dir) then
				table.insert(signals, {
					self.x,
					self.y
				})
			end
		elseif self.outDir then
			table.insert(signals, {
				self.x,
				self.y
			})
		end
	elseif self.unitType == WuErLiXiEnum.UnitType.SignalMulti then
		if inDir then
			if inDir == self.dir then
				if self.dir == WuErLiXiEnum.Dir.Up or self.dir == WuErLiXiEnum.Dir.Down then
					table.insert(signals, {
						self.x - 1,
						self.y
					})
					table.insert(signals, {
						self.x + 1,
						self.y
					})
				else
					table.insert(signals, {
						self.x,
						self.y - 1
					})
					table.insert(signals, {
						self.x,
						self.y + 1
					})
				end
			end
		elseif self.dir == WuErLiXiEnum.Dir.Up or self.dir == WuErLiXiEnum.Dir.Down then
			table.insert(signals, {
				self.x - 1,
				self.y
			})
			table.insert(signals, {
				self.x + 1,
				self.y
			})
		else
			table.insert(signals, {
				self.x,
				self.y - 1
			})
			table.insert(signals, {
				self.x,
				self.y + 1
			})
		end
	end

	return signals
end

return WuErLiXiMapUnitMo
