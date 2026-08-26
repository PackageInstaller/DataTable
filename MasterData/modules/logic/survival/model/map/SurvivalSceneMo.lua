-- chunkname: @modules/logic/survival/model/map/SurvivalSceneMo.lua

module("modules.logic.survival.model.map.SurvivalSceneMo", package.seeall)

local SurvivalSceneMo = pureTable("SurvivalSceneMo")

function SurvivalSceneMo:init(data)
	self._mapInfo = GameUtil.rpcInfoToMo(data.mapInfo, SurvivalMapInfoMo)
	self.mapId = self._mapInfo.mapId
	self.player = GameUtil.rpcInfoToMo(data.player, SurvivalPlayerMo, self.player)
	self.units = {}
	self.unitsById = self.unitsById or {}
	self.blocks = {}
	self.blocksById = self.blocksById or {}
	self.allDestroyPos = {}

	for _, v in ipairs(data.unit) do
		if v.unitType == SurvivalEnum.UnitType.Born then
			-- block empty
		elseif v.unitType == SurvivalEnum.UnitType.Block then
			if not self.blocksById[v.id] then
				local unit = SurvivalUnitMo.New()

				unit:init(v)

				if unit:isDestory() then
					SurvivalHelper.instance:addNodeToDict(self.allDestroyPos, unit.pos)

					for _, pos in ipairs(unit.exPoints) do
						SurvivalHelper.instance:addNodeToDict(self.allDestroyPos, pos)
					end
				else
					table.insert(self.blocks, unit)

					self.blocksById[v.id] = unit
				end
			end
		elseif not self.unitsById[v.id] then
			local unit = SurvivalUnitMo.New()

			unit:init(v)
			table.insert(self.units, unit)

			self.unitsById[v.id] = unit
		end
	end

	self.groupId = self._mapInfo.groupId
	self.mapType = self._mapInfo.mapType
	self.sceneCo = SurvivalConfig.instance:getMapConfig(self.mapId)

	self.sceneCo:resetWalkables()

	self.exitPos = self.sceneCo.exitPos
	self.unitsById = {}

	for _, unitMo in ipairs(self.units) do
		self.unitsById[unitMo.id] = unitMo
	end

	self.blocksById = {}

	for _, unitMo in ipairs(self.blocks) do
		self.blocksById[unitMo.id] = unitMo
	end

	self.gameTime = data.gameTime
	self.currMaxGameTime = data.currMaxGameTime
	self.clockMaxTime = data.clockMaxTime
	self.circle = data.circle
	self.addTime = self.currMaxGameTime - self.clockMaxTime
	self.panel = nil

	if data.panel.type ~= SurvivalEnum.PanelType.None then
		self.panel = SurvivalPanelMo.New()

		self.panel:init(data.panel)
	end

	self.teamInfo = GameUtil.rpcInfoToMo(data.teamInfo, SurvivalTeamInfoMo)
	self.safeZone = GameUtil.rpcInfosToList(data.safeZone.shrinkInfo, SurvivalShrinkInfoMo)

	self:initUnitPosDict()
	self:initSpBlockPosDict()

	self.battleInfo = GameUtil.rpcInfoToMo(data.battleInfo, SurvivalExploreBattleInfoMo)
	self.mainTask = SurvivalFollowTaskMo.New()
	self.followTask = SurvivalFollowTaskMo.New()

	for i, v in ipairs(data.followTask) do
		if v.moduleId == SurvivalEnum.TaskModule.MapMainTarget then
			self.mainTask:init(v)
		elseif v.moduleId == SurvivalEnum.TaskModule.NormalTask then
			self.followTask:init(v)
		end
	end

	self.extraBlock = {}

	for _, v in ipairs(data.cells) do
		local mo = SurvivalHexCellMo.New()

		mo:init(v, self.mapType)
		table.insert(self.extraBlock, mo)
	end

	self.sceneProp = GameUtil.rpcInfoToMo(data.sceneProp, SurvivalScenePropMo)
	self.roleSkillMo = GameUtil.rpcInfoToMo(data.skillInfo, SurvivalRoleSkillMo, self.roleSkillMo)
end

function SurvivalSceneMo:getBlockTypeByPos(pos)
	local co = self:getBlockCoByPos(pos)

	return (co or nil) and (co.subType or -1)
end

function SurvivalSceneMo:getBlockCoByPos(pos)
	if not self._spBlockTypeDict[pos.q] then
		return
	end

	return self._spBlockTypeDict[pos.q][pos.r]
end

function SurvivalSceneMo:initSpBlockPosDict()
	self._spBlockTypeDict = {}

	for _, v in pairs(self.blocksById) do
		local pos = v.pos

		self:setPosSubType(pos, v.co)

		for i, vv in ipairs(v.exPoints) do
			self:setPosSubType(vv, v.co)
		end
	end
end

function SurvivalSceneMo:setPosSubType(pos, co)
	self._spBlockTypeDict[pos.q] = self._spBlockTypeDict[pos.q] or {}
	self._spBlockTypeDict[pos.q][pos.r] = co
end

function SurvivalSceneMo:initUnitPosDict()
	self._unitsByPos = {}

	for _, unitMo in ipairs(self.units) do
		local pos = unitMo.pos

		self:_addUnitPos(pos, unitMo)

		for _, exPos in ipairs(unitMo.exPoints) do
			self:_addUnitPos(exPos, unitMo)
		end
	end

	for q, list in pairs(self._unitsByPos) do
		for r, list2 in pairs(list) do
			if #list2 > 1 then
				table.sort(list2, SurvivalSceneMo.sortUnitMo)
			end
		end
	end
end

local _noShowIconDict

function SurvivalSceneMo:isNoShowIcon(unitMo)
	if not _noShowIconDict then
		_noShowIconDict = {}

		local constStr = SurvivalConfig.instance:getConstValue(SurvivalEnum.ConstId.NoShowIconUnitSubType)

		if not string.nilorempty(constStr) then
			for _, v in ipairs(string.splitToNumber(constStr, "#")) do
				_noShowIconDict[v] = true
			end
		end
	end

	if unitMo then
		::label_7_0::

		local var_7_0 = unitMo.co

		if unitMo.co then
			local unitType = unitMo.co.subType

			if not unitType or _noShowIconDict[unitType] then
				return true
			end

			if unitType == SurvivalEnum.UnitSubType.BlockEvent then
				return true
			end

			return false
		end
	end
end

function SurvivalSceneMo:getUnitIconListByPos(pos)
	local list = {}

	for _, v in ipairs(self.units) do
		if v.pos == pos and not v:isBlock() and not v:isBlockEvent() and not self:isNoShowIcon(v) then
			table.insert(list, v)
		end
	end

	if #list > 1 then
		table.sort(list, SurvivalSceneMo.sortUnitMo)
	end

	return list
end

function SurvivalSceneMo:_addUnitPos(pos, unitMo)
	local q = pos.q
	local r = pos.r

	self._unitsByPos[q] = self._unitsByPos[q] or {}

	local list = self._unitsByPos[q][r]

	if not list then
		list = {}
		self._unitsByPos[q][r] = list
	end

	local isChange = false

	if not tabletool.indexOf(list, unitMo) then
		table.insert(list, unitMo)

		isChange = true
	end

	return list, isChange
end

function SurvivalSceneMo:addUnit(unitMo)
	if unitMo.unitType == SurvivalEnum.UnitType.Born then
		return
	end

	local isBlock = unitMo.unitType == SurvivalEnum.UnitType.Block

	if isBlock then
		if not self.blocksById then
			local dict = self.unitsById

			if isBlock then
				if not self.blocks then
					local list = self.units
					local oldUnitMo = dict[unitMo.id]

					if oldUnitMo then
						local preCfgId = oldUnitMo.cfgId
						local oldPos = oldUnitMo.pos

						oldUnitMo:copyFrom(unitMo)

						if isBlock then
							if unitMo:isDestory() then
								SurvivalHelper.instance:addNodeToDict(self.allDestroyPos, unitMo.pos)

								for _, pos in ipairs(unitMo.exPoints) do
									SurvivalHelper.instance:addNodeToDict(self.allDestroyPos, pos)
								end

								self:deleteUnit(unitMo.id)
								SurvivalController.instance:dispatchEvent(SurvivalEvent.OnMapDestoryPosAdd, unitMo)
							end
						else
							if oldUnitMo.pos ~= oldPos then
								local newPos = oldUnitMo.pos

								oldUnitMo.pos = oldUnitMo

								self:onUnitUpdatePos(oldUnitMo, newPos)
							end

							SurvivalController.instance:dispatchEvent(SurvivalEvent.OnMapUnitChange, unitMo.id)

							if preCfgId ~= unitMo.cfgId then
								self:fixUnitExPos(unitMo)
							end
						end

						return
					end

					if isBlock and unitMo:isDestory() then
						logError("直接新增一个被摧毁的障碍？？？" .. tostring(unitMo.id))

						return
					end

					dict[unitMo.id] = unitMo

					table.insert(list, unitMo)

					if not isBlock then
						self:_addUnitPos(unitMo.pos, unitMo)
						SurvivalController.instance:dispatchEvent(SurvivalEvent.OnMapUnitAdd, unitMo)
						SurvivalController.instance:dispatchEvent(SurvivalEvent.OnMapUnitPosChange, unitMo.pos, unitMo)

						for _, exPos in ipairs(unitMo.exPoints) do
							self:_addUnitPos(exPos, unitMo)
							SurvivalController.instance:dispatchEvent(SurvivalEvent.OnMapUnitPosChange, exPos, unitMo)
						end
					else
						self:setPosSubType(unitMo.pos, unitMo.co)

						for i, v in ipairs(unitMo.exPoints) do
							self:setPosSubType(v, unitMo.co)
						end

						SurvivalController.instance:dispatchEvent(SurvivalEvent.OnSpBlockUpdate, unitMo.pos)
						SurvivalController.instance:dispatchEvent(SurvivalEvent.OnMapSpBlockAdd, unitMo)
					end
				end
			end
		end
	end
end

function SurvivalSceneMo:fixUnitExPos(unitMo)
	local _, isChange = self:_addUnitPos(unitMo.pos, unitMo)

	if isChange then
		SurvivalController.instance:dispatchEvent(SurvivalEvent.OnMapUnitPosChange, unitMo.pos, unitMo)
	end

	for _, exPos in ipairs(unitMo.exPoints) do
		_, isChange = self:_addUnitPos(exPos, unitMo)

		if isChange then
			SurvivalController.instance:dispatchEvent(SurvivalEvent.OnMapUnitPosChange, exPos, unitMo)
		end
	end
end

function SurvivalSceneMo:deleteUnit(unitId, isPlayDeadAnim)
	local isBlock = true
	local unitDict = self.blocksById
	local unitList = self.blocks
	local unitMo = unitDict[unitId]

	if not unitMo then
		isBlock = false
		unitDict = self.unitsById
		unitList = self.units
		unitMo = self.unitsById[unitId]
	end

	if not unitMo then
		logError("元件id不存在" .. tostring(unitId))

		return
	end

	unitDict[unitId] = nil

	tabletool.removeValue(unitList, unitMo)

	if not isBlock then
		local list = self:getListByPos(unitMo.pos)

		if list then
			tabletool.removeValue(list, unitMo)
		end

		SurvivalController.instance:dispatchEvent(SurvivalEvent.OnMapUnitDel, unitMo, isPlayDeadAnim)
		SurvivalController.instance:dispatchEvent(SurvivalEvent.OnMapUnitPosChange, unitMo.pos, unitMo, true)

		for _, exPos in ipairs(unitMo.exPoints) do
			list = self:getListByPos(exPos)

			if list then
				tabletool.removeValue(list, unitMo)
			end

			SurvivalController.instance:dispatchEvent(SurvivalEvent.OnMapUnitPosChange, exPos, unitMo, true)
		end
	else
		self:setPosSubType(unitMo.pos, nil)

		for i, v in ipairs(unitMo.exPoints) do
			self:setPosSubType(v, nil)
		end

		SurvivalController.instance:dispatchEvent(SurvivalEvent.OnSpBlockUpdate, unitMo.pos)
		SurvivalController.instance:dispatchEvent(SurvivalEvent.OnMapSpBlockDel, unitMo)
	end
end

function SurvivalSceneMo:onUnitUpdatePos(unitMo, newPos)
	if unitMo.pos == newPos then
		return
	end

	local rawPos = unitMo.pos
	local list = self:getListByPos(unitMo.pos)

	if not list then
		return
	end

	tabletool.removeValue(list, unitMo)

	unitMo.pos = newPos

	local newList = self:_addUnitPos(newPos, unitMo)

	if #newList > 1 then
		table.sort(newList, SurvivalSceneMo.sortUnitMo)
	end

	SurvivalController.instance:dispatchEvent(SurvivalEvent.OnMapUnitPosChange, rawPos, unitMo)
	SurvivalController.instance:dispatchEvent(SurvivalEvent.OnMapUnitPosChange, newPos, unitMo)
end

function SurvivalSceneMo.sortUnitMo(unitMoA, unitMoB)
	local priorityA = SurvivalSceneMo.getUnitPriority(unitMoA)
	local priorityB = SurvivalSceneMo.getUnitPriority(unitMoB)

	if priorityA ~= priorityB then
		return priorityB < priorityA
	end

	return unitMoA.id < unitMoB.id
end

function SurvivalSceneMo.getUnitPriority(unitMo)
	return (unitMo.co or nil) and (unitMo.exPoints[1] and 1000 or unitMo.co.priority)
end

function SurvivalSceneMo:getListByPos(pos)
	local list = self._unitsByPos[pos.q]

	if not list then
		return
	end

	return list[pos.r]
end

function SurvivalSceneMo:isInTop(unitMo)
	if unitMo.co and unitMo.co.subType == SurvivalEnum.UnitSubType.BlockEvent then
		return true
	end

	local list = self:getListByPos(unitMo.pos)

	if not list then
		return false
	end

	for _, v in ipairs(list) do
		if v == unitMo then
			return true
		elseif not v.co or v.co.subType ~= SurvivalEnum.UnitSubType.BlockEvent then
			return false
		end
	end

	return false
end

function SurvivalSceneMo:getUnitByPos(pos, isAll, includeNotTrigger)
	local allUnit

	if isAll then
		allUnit = {}
	end

	local list = self:getListByPos(pos)

	if not list then
		if isAll then
			return allUnit
		else
			return
		end
	end

	for _, unitMo in pairs(list) do
		if includeNotTrigger or unitMo:canTrigger() then
			if not isAll then
				return unitMo
			else
				table.insert(allUnit, unitMo)
			end
		end
	end

	return allUnit
end

function SurvivalSceneMo:isHaveIceEvent()
	if not self.panel or self.panel.type ~= SurvivalEnum.PanelType.TreeEvent then
		return
	end

	local unitMo = self.unitsById[self.panel.unitId]
	local cfgId = unitMo and unitMo.cfgId
	local iceSpEventId = SurvivalConfig.instance:getConstValue(SurvivalEnum.ConstId.IceSpEvent)

	iceSpEventId = tonumber(iceSpEventId) or 0

	return cfgId == iceSpEventId
end

function SurvivalSceneMo:getRoleSkillInfo()
	return self.roleSkillMo
end

return SurvivalSceneMo
