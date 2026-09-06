-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/zoo/model/building/ZooBuildingTreeMO.lua

module("logic.extensions.zoo.model.building.ZooBuildingTreeMO", package.seeall)

local ZooBuildingTreeMO = class("ZooBuildingTreeMO", ZooBuildingMO)

function ZooBuildingTreeMO:ctor()
	ZooBuildingTreeMO.super.ctor(self)

	self.treeRefreshTime = 0
	self.treeFruitNum = 0
end

function ZooBuildingTreeMO:getMaxNum()
	local buildingCo = ZooConfig.instance:getTreeBuildingCo(self.buildingLevel)

	if buildingCo then
		return buildingCo.maxNum
	end

	return 0
end

function ZooBuildingTreeMO:getIntervalPerNum()
	local buildingCo = ZooConfig.instance:getTreeBuildingCo(self.buildingLevel)

	if buildingCo then
		return buildingCo.intervalPerNum * 60
	end

	return 0
end

function ZooBuildingTreeMO:getUpgradeCost()
	local buildingCo = ZooConfig.instance:getTreeBuildingCo(self.buildingLevel + 1)

	if buildingCo then
		return buildingCo.upgradeCost
	end
end

function ZooBuildingTreeMO:getMaxLevel()
	return #ZooConfig.instance:getAllTreeBuildingCos()
end

function ZooBuildingTreeMO:getNeedMainBuildingLv()
	local buildingCo = ZooConfig.instance:getTreeBuildingCo(self.buildingLevel + 1)

	if buildingCo then
		return buildingCo.needMainBuildingLv
	end

	return 0
end

function ZooBuildingTreeMO:getBuildingOpTypes()
	return {
		ZooBuildingOpType.Infomation,
		ZooBuildingOpType.Upgrade,
		ZooBuildingOpType.Get
	}
end

function ZooBuildingTreeMO:getCurrTreeFriutsNum()
	local num = self.treeFruitNum
	local refreshSec = self:getIntervalPerNum()
	local now = ServerTime.now()
	local maxNum = self:getMaxNum()

	num = now >= self.treeRefreshTime and num + math.floor((now - self.treeRefreshTime) / refreshSec) or num + math.floor((self.treeRefreshTime - now) / refreshSec)

	if maxNum < num then
		num = maxNum
	end

	return num
end

function ZooBuildingTreeMO:_onClickGet()
	local num = self:getCurrTreeFriutsNum()

	if not self.zooMo:isMyZoo() then
		local myZoo = ZooModel.instance:getMyZoo()
		local stealFruitNum = myZoo:getStealFruitNum()
		local hasBeenStealNum = self.zooMo:getHasBeenStealFruitNum()

		if hasBeenStealNum >= ZooConfig.instance:getBeStolenFriutMaxNum() then
			FloatWordMgr.instance:show(lang("petzoo_bestolentimes_limit"))
		elseif stealFruitNum >= ZooConfig.instance:getStealFriutMaxNum() then
			FloatWordMgr.instance:show(lang("petzoo_stealtimes_tomax"))
		elseif num > 0 then
			ZooController.instance:sendPM_ZooStealFruitReq(self.zooMo:getZooUserId())
		else
			FloatWordMgr.instance:show(lang("petzoo_gainfriuts_empty"))
		end
	elseif num > 0 then
		ZooAgent.instance:sendPM_ZooGainFruitReq()
	else
		FloatWordMgr.instance:show(lang("petzoo_stealfriuts_empty"))
	end
end

function ZooBuildingTreeMO:getBuildingLvInstructions()
	local buildingCos = ZooConfig.instance:getAllTreeBuildingCos()
	local instructions = {}

	for i = 1, #buildingCos do
		local instruction = BuildingInstructionMO.New()

		instruction.level = buildingCos[i].level
		instruction.instruction = string.format(lang("petzoo_tree_lvdesc"), buildingCos[i].intervalPerNum, buildingCos[i].maxNum)

		table.insert(instructions, instruction)
	end

	return instructions
end

function ZooBuildingTreeMO:getBuildingAttrDescs(level)
	local buildingCo = ZooConfig.instance:getTreeBuildingCo(level)

	if not buildingCo then
		return
	end

	local attrsDesc = {}
	local intervalPerNumMo = ZooBuildingAttrDescMO.New()

	intervalPerNumMo.attrName = lang("petzoo_building_fruit_interval")
	intervalPerNumMo.attrDesc = tostring(buildingCo.intervalPerNum)

	table.insert(attrsDesc, intervalPerNumMo)

	local maxNumMo = ZooBuildingAttrDescMO.New()

	maxNumMo.attrName = lang("petzoo_building_fruit_max")
	maxNumMo.attrDesc = tostring(buildingCo.maxNum)

	table.insert(attrsDesc, maxNumMo)

	return attrsDesc
end

function ZooBuildingTreeMO:_requestLevelup()
	ZooAgent.instance:sendPM_ZooUpgradeResourceTreeReq()
end

function ZooBuildingTreeMO:onSelected()
	if not self.zooMo:isMyZoo() then
		self:_onClickGet()

		return
	end

	ZooBuildingTreeMO.super.onSelected(self)
end

return ZooBuildingTreeMO
