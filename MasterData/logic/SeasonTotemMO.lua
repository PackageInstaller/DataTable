-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/season/model/SeasonTotemMO.lua

module("logic.extensions.season.model.SeasonTotemMO", package.seeall)

local SeasonTotemMO = class("SeasonTotemMO")

function SeasonTotemMO:ctor(totemPoleRaceTypePlanId, totemItemPlanId, mainTotemPlanId)
	self.raceType = nil
	self.mainTotemPoleLv = nil
	self.curZdl = nil
	self.itemInfos = nil
	self.totemPoleRaceTypePlanId = totemPoleRaceTypePlanId
	self.totemItemPlanId = totemItemPlanId
	self.mainTotemPlanId = mainTotemPlanId
end

function SeasonTotemMO:update(msg)
	local itemInfos = {}

	for _, itemInfo in ipairs(msg.itemInfos) do
		itemInfos[itemInfo.itemId] = itemInfo.itemLv
	end

	self.raceType = msg.raceType
	self.mainTotemPoleLv = msg.mainTotemPoleLv
	self.curZdl = msg.curZdl
	self.itemInfos = itemInfos
end

function SeasonTotemMO:getSubItemLv(itemId)
	return self.itemInfos[itemId]
end

function SeasonTotemMO:isSmallTotemCanUpgrade(itemId)
	local itemLv = self.itemInfos[itemId]

	if itemLv <= self.mainTotemPoleLv then
		local config = SeasonMainCampConfig.instance:getTotemPoleItemConfig(self.totemItemPlanId, itemId, itemLv + 1)

		if config then
			return true
		end
	end

	return false
end

function SeasonTotemMO:isMainTotemCanUpgrade()
	for i, v in pairs(self.itemInfos) do
		if v <= self.mainTotemPoleLv then
			return false
		end
	end

	local config = SeasonMainCampConfig.instance:getMainTotemConfig(self.mainTotemPlanId, self.mainTotemPoleLv + 1)

	if not config then
		return false
	end

	return true
end

function SeasonTotemMO:getSubEntry(itemId, itemLv)
	local res = {}

	if itemLv == nil then
		itemLv = self.itemInfos[itemId]
	end

	if itemLv > 0 then
		local config = SeasonMainCampConfig.instance:getTotemPoleItemConfig(self.totemItemPlanId, itemId, itemLv)
		local attrs = FightingPowerFormula.instance:parseAttrValues(config.propertyApp) or {}

		res = AttrMo.addSameAttrs(attrs, res)
	end

	return res
end

function SeasonTotemMO:getTotalEntry()
	local res = {}

	for i, v in pairs(self.itemInfos) do
		local attrs = self:getSubEntry(checknumber(i))

		res = AttrMo.addSameAttrs(attrs, res)
	end

	local attrsMain = self:getMainEntry()

	res = AttrMo.addSameAttrs(attrsMain, res)

	return res
end

function SeasonTotemMO:getMainEntry(level)
	if level == nil then
		level = self.mainTotemPoleLv
	end

	local res = {}
	local config = SeasonMainCampConfig.instance:getMainTotemConfig(self.mainTotemPlanId, level)

	if config then
		local attrsMain = FightingPowerFormula.instance:parseAttrValues(config.propertyApp) or {}

		res = AttrMo.addSameAttrs(attrsMain, res)
		attrsMain = FightingPowerFormula.instance:parseAttrValues(config.FormPropertyAppRate) or {}
		res = AttrMo.addSameAttrs(attrsMain, res)
	end

	return res
end

function SeasonTotemMO:isSubEnoughCost(itemId)
	local itemLv = self.itemInfos[itemId]
	local nextConfig = SeasonMainCampConfig.instance:getTotemPoleItemConfig(self.totemItemPlanId, itemId, itemLv)

	if nextConfig then
		if not string.nilorempty(nextConfig.cost) then
			local costArray = string.split(nextConfig.cost, "#")

			for i, cfgStr in ipairs(costArray) do
				local type, id, num = MaterialMgr.getMatParams(cfgStr)

				if not MaterialModel.instance:IsEnough(type, id, num) then
					return false
				end
			end
		end

		return true
	end

	return false
end

return SeasonTotemMO
