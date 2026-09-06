-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mount/config/MountConfig.lua

module(..., package.seeall)

local MountConfig = class("MountConfig", BaseConfig)
local json = require("cjson")

function MountConfig:onInit()
	self._mount = nil
end

function MountConfig:getNames()
	return {
		"mount",
		"mount_level",
		"mount_property_plan",
		"mount_property_zdl",
		"mount_common"
	}
end

function MountConfig:handleConfig(name, content)
	if name == "mount" then
		self._mount = content

		self:createMountMap()
	elseif name == "mount_level" then
		self._mount_level = content
	elseif name == "mount_property_plan" then
		self._mount_att_plan = content
	elseif name == "mount_property_zdl" then
		self._mount_property_zdl = content
	elseif name == "mount_common" then
		self._mount_common = content
	end
end

function MountConfig:getAllMounts()
	return self._mount.dataList
end

function MountConfig:createMountMap()
	self._mountMap = {}

	for i, v in ipairs(self:getAllMounts() or {}) do
		local type, id, num = MaterialMgr.getMatParams(v.activationItem)

		if id then
			self._mountMap[type .. "_" .. id] = v.id
		end
	end
end

function MountConfig:getMountInMap(type, id)
	if self._mountMap then
		return self._mountMap[type .. "_" .. id]
	end

	return nil
end

function MountConfig:getMountCo(id)
	if id == DressModel.EscortMountId then
		return self:getEscortMountCo()
	end

	return self._mount[id]
end

function MountConfig:getEscortMountCo()
	if not self._escortMountCo then
		self._escortMountCo = {}
		self._escortMountCo.id = DressModel.EscortMountId
		self._escortMountCo.mountMod = DressModel.EscortMountModel
		self._escortMountCo.mountLayer = AnimatorHash.escortLayer
		self._escortMountCo.shadowOffset = {
			0,
			0
		}
		self._escortMountCo.shadowScale = 5
		self._escortMountCo.nameHeight = 1.7
		self._escortMountCo.speed = EscortConfig.instance:GetPlayerSpeedRatio()
	end

	return self._escortMountCo
end

function MountConfig:getlevelupPlan()
	return self._mount_level.dataList
end

function MountConfig:getMountLevel(levelupPlan, level)
	for k, v in pairs(self._mount_level.dataList) do
		if v.levelUpPlan == levelupPlan and v.level == level then
			return v
		end
	end
end

function MountConfig:getAttAddValue(attributePlan, attrType)
	return self._mount_att_plan[attributePlan][attrType].addValue
end

function MountConfig:getAttrByPlanLvl(id, lvl)
	local plan = checknumber(self._mount[id].levelUpPlan)
	local arr = self._mount_level[plan]

	if arr then
		if not arr[lvl] then
			local cfg

			return cfg
		end
	end
end

function MountConfig:getMaxLevel(id)
	local plan = checknumber(self._mount[id].levelUpPlan)

	if plan > 0 then
		local arr = self._mount_level[plan]

		return #arr
	else
		return -1
	end
end

function MountConfig:getCommonValue(key)
	if self._mount_common[key] then
		return self._mount_common[key].value
	end

	return nil
end

function MountConfig:getMountLimitNum()
	return checknumber(self:getCommonValue("ACTIVE_MOUNT_NUM"))
end

function MountConfig:getMaxAttr()
	if self.maxAttrs == nil then
		self.maxAttrs = {}

		local tempAttrs = {}

		for k, v in pairs(self._mount.dataList) do
			local plan = checknumber(v.levelUpPlan)

			if plan > 0 then
				local arr = self._mount_level[plan]
				local cfg = arr[#arr]
				local attrs1 = FightingPowerFormula.instance:parseAttrValues(cfg.attributeMax) or {}
				local attrs2 = FightingPowerFormula.instance:parseAttrValues(cfg.attribute) or {}

				AttrMo.addSameAttrs(attrs2, attrs1)

				local zdl = AttrMo.calcFightPowerByAttrs(attrs1)

				table.insert(tempAttrs, {
					zdl = zdl,
					attrs = attrs1
				})
			end
		end

		local limitNum = self:getMountLimitNum()

		if limitNum < #tempAttrs then
			table.sort(tempAttrs, function(a, b)
				return a.zdl > b.zdl
			end)
		end

		for i = 1, limitNum do
			if not tempAttrs[i] then
				break
			end

			AttrMo.addSameAttrs(tempAttrs[i].attrs, self.maxAttrs)
		end
	end

	return self.maxAttrs
end

function MountConfig:getMountLogicParams(mountId)
	if self._mountParams and self._mountParams[mountId] then
		return self._mountParams[mountId]
	end

	local mountCo = MountConfig.instance:getMountCo(mountId)

	if mountCo and not string.nilorempty(mountCo.logic_cls) and not string.nilorempty(mountCo.logic_params) then
		self._mountParams = self._mountParams or {}
		self._mountParams[mountId] = json.decode(mountCo.logic_params)

		return self._mountParams[mountId]
	end
end

function MountConfig:getCultivateTimeConfigs(levelUpPlan)
	self._cultivateTimeMap = self._cultivateTimeMap or {}

	if not self._cultivateTimeMap[levelUpPlan] then
		self._cultivateTimeMap[levelUpPlan] = {}

		local lastAttrs

		for i, cfg in ipairs(self._mount_level[levelUpPlan]) do
			local singleAttrCfgs = self._mount_att_plan[cfg.attributePlan]
			local totalTime = 0
			local strs = string.split(cfg.attributeMax, "#")
			local cutTb = {}

			for index = 1, 4 do
				local strs2 = string.split(strs[index], "+")
				local attrType = strs2[1]
				local idx = table.indexof(GameEnum.AttrTypeName, attrType)

				cutTb[attrType] = {
					type = idx,
					value = tonumber(strs2[2]),
					attrType = attrType
				}
			end

			if lastAttrs then
				for attrType, attrInfo in pairs(cutTb) do
					local attrTypeCfg = singleAttrCfgs[attrType]
					local lastAttrInfo = lastAttrs[attrType]
					local diff = attrInfo.value - lastAttrInfo.value

					totalTime = totalTime + math.ceil(diff / attrTypeCfg.addValue)
				end
			else
				for attrType, attrInfo in pairs(cutTb) do
					local attrTypeCfg = singleAttrCfgs[attrType]
					local diff = attrInfo.value

					totalTime = totalTime + math.ceil(diff / attrTypeCfg.addValue)
				end
			end

			lastAttrs = cutTb
			self._cultivateTimeMap[levelUpPlan][cfg.level] = totalTime
		end
	end

	return self._cultivateTimeMap[levelUpPlan]
end

MountConfig.instance = MountConfig.New()

return MountConfig
