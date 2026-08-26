-- chunkname: @modules/logic/survival/model/map/SurvivalUnitMo.lua

module("modules.logic.survival.model.map.SurvivalUnitMo", package.seeall)

local SurvivalUnitMo = pureTable("SurvivalUnitMo")

function SurvivalUnitMo:init(data)
	self.id = data.id
	self.cfgId = data.cfgId
	self.unitType = data.unitType
	self.dir = data.position.dir
	self.visionVal = data.visionVal
	self.fall = data.fall
	self.force = data.force
	self.mark = data.mark
	self.extraParam = {}

	if not string.nilorempty(data.extraParam) then
		local ok, json = pcall(cjson.decode, data.extraParam)

		if ok then
			self.extraParam = json
		else
			logError("非法json" .. data.extraParam)
		end
	end

	self.pos = SurvivalHexNode.New(data.position.hex.q, data.position.hex.r)

	if self.unitType == SurvivalEnum.UnitType.Battle then
		self.co = lua_survival_fight.configDict[self.cfgId]
	elseif self.unitType == SurvivalEnum.UnitType.NPC then
		self.co = SurvivalConfig.instance:getNpcConfig(self.cfgId)
	elseif self.unitType == SurvivalEnum.UnitType.Search then
		self.co = lua_survival_search.configDict[self.cfgId]
	elseif self.unitType == SurvivalEnum.UnitType.Treasure then
		self.co = lua_survival_mission.configDict[self.cfgId]
	elseif self.unitType == SurvivalEnum.UnitType.Task then
		self.co = lua_survival_mission.configDict[self.cfgId]
	elseif self.unitType == SurvivalEnum.UnitType.Door then
		self.co = lua_survival_mission.configDict[self.cfgId]
	elseif self.unitType == SurvivalEnum.UnitType.Exit then
		self.co = lua_survival_mission.configDict[self.cfgId]
	elseif self.unitType == SurvivalEnum.UnitType.Block then
		self.co = lua_survival_block.configDict[self.cfgId]
	end

	if not self.co and self.unitType ~= SurvivalEnum.UnitType.Born then
		logError("没有元件配置" .. self.cfgId .. " >> " .. self.unitType)
	end

	self.exPoints = {}

	if self.co and not string.nilorempty(self.co.grid) then
		local dict = GameUtil.splitString2(self.co.grid, true, ",", "#")

		for index, arr in ipairs(dict) do
			local point = SurvivalHexNode.New(arr[1], arr[2])

			point:Add(self.pos)
			point:rotateDir(self.pos, self.dir)

			self.exPoints[index] = point
		end
	end
end

function SurvivalUnitMo:isSearched()
	return self.extraParam.panelUid and self.extraParam.panelUid > 0
end

function SurvivalUnitMo:isDestory()
	return self.extraParam.destroy
end

function SurvivalUnitMo:copyFrom(unitMo)
	tabletool.clear(self)

	for k, v in pairs(unitMo) do
		self[k] = v
	end
end

function SurvivalUnitMo:getResPath()
	if self.co then
		return self.co.resource
	end
end

function SurvivalUnitMo:getSceneResPath()
	local isInWater = SurvivalMapModel.instance:getSceneMo():getBlockTypeByPos(self.pos) == SurvivalEnum.UnitSubType.Water

	if isInWater and self.co and not string.nilorempty(self.co.waterResource) then
		return self.co.waterResource
	end

	return self:getResPath()
end

function SurvivalUnitMo:isInNode(node, includeNotTrigger)
	if not includeNotTrigger and not self:canTrigger() then
		return false
	end

	if node == self.pos then
		return true
	end

	for _, exPoint in pairs(self.exPoints) do
		if exPoint == node then
			return true
		end
	end

	return false
end

function SurvivalUnitMo:canTrigger()
	if not self.co or self.co.enforce == 1 then
		return false
	end

	if self:isBlock() then
		return false
	end

	return true
end

function SurvivalUnitMo:getWarmingRange()
	if not self.co or self.unitType ~= SurvivalEnum.UnitType.Battle then
		return false
	end

	local weekMo = SurvivalShelterModel.instance:getWeekInfo()

	if not weekMo then
		return false
	end

	if self.fall then
		return false
	end

	if SurvivalMapHelper.instance:isPetrifactionTar(self) then
		local sceneMo = SurvivalMapModel.instance:getSceneMo()
		local blockType = sceneMo:getBlockTypeByPos(self.pos)

		if blockType and blockType == SurvivalEnum.UnitSubType.Petrifaction then
			return 0
		end
	end

	local roleLevel = SurvivalShelterModel.instance:getWeekInfo().survivalShelterRoleMo.level

	if self.co.skip == 1 and roleLevel >= self.co.fightLevel then
		return false
	end

	local warmingRange = self.co.warningRange

	if warmingRange > 0 then
		warmingRange = warmingRange + weekMo:getAttr(SurvivalEnum.AttrType.WarningRange)
	end

	if warmingRange > 0 and self.visionVal ~= 8 then
		return warmingRange
	end
end

function SurvivalUnitMo:isPointInWarming(hexNode)
	local warmingRange = self:getWarmingRange()

	if not warmingRange then
		return false
	end

	return warmingRange >= SurvivalHelper.instance:getDistance(hexNode, self.pos)
end

function SurvivalUnitMo:isBlock()
	return self.unitType == SurvivalEnum.UnitType.Block
end

function SurvivalUnitMo:isBattle()
	return self.unitType == SurvivalEnum.UnitType.Battle
end

function SurvivalUnitMo:isBlockEvent()
	return self.co and self.co.subType == SurvivalEnum.UnitSubType.BlockEvent
end

function SurvivalUnitMo:getSubType()
	return (self.co or nil) and (self.co.subType or 0)
end

function SurvivalUnitMo:isMark(markType)
	local value = bit.lshift(1, markType - 1)

	return bit.band(self.mark, value) ~= 0
end

function SurvivalUnitMo:getMark()
	return self.mark
end

return SurvivalUnitMo
