-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/starequipment/config/StarEquipmentConfig.lua

module("logic.extensions.starequipment.config.StarEquipmentConfig", package.seeall)

local StarEquipmentConfig = class("StarEquipmentConfig", BaseConfig)

StarEquipmentConfig.MaxStarEquipmentLv = 6

function StarEquipmentConfig:onInit()
	return
end

function StarEquipmentConfig:getNames()
	return {
		"star_equipment",
		"star_equipment_level_config",
		"star_equipment_other_config"
	}
end

function StarEquipmentConfig:handleConfig(name, content)
	if name == "star_equipment" then
		self._equipCfgs = content
	elseif name == "star_equipment_level_config" then
		self._equipLvCfgs = content
	elseif name == "star_equipment_other_config" then
		self._equipOtherCfgs = content
	end
end

function StarEquipmentConfig:getEquipCfg(id)
	return self._equipCfgs[id]
end

function StarEquipmentConfig:getEquipCfgs()
	return self._equipCfgs.dataList
end

function StarEquipmentConfig:getEquipLvCfg(id, level)
	return self._equipLvCfgs[id][level]
end

function StarEquipmentConfig:getCurLvAndExp(id, exp)
	local level

	exp = checknumber(exp)

	local maxLv = StarEquipmentConfig.MaxStarEquipmentLv

	for level = maxLv, 1, -1 do
		local cfg = self:getEquipLvCfg(id, level)

		if exp >= cfg.exp then
			if level == maxLv then
				return level, 0
			else
				return level, exp - cfg.exp
			end
		end
	end

	return 1, exp
end

function StarEquipmentConfig:getCurLvNeedExp(id, level)
	if level >= StarEquipmentConfig.MaxStarEquipmentLv or level < 1 then
		return 0
	else
		local nextCfg = self:getEquipLvCfg(id, level + 1)
		local curCfg = self:getEquipLvCfg(id, level)

		return nextCfg.exp - curCfg.exp
	end

	return 0
end

function StarEquipmentConfig:getTargetLvNeedExp(id, exp, targetLv)
	if targetLv > StarEquipmentConfig.MaxStarEquipmentLv or targetLv < 1 then
		return 0
	else
		local cfg = self:getEquipLvCfg(id, targetLv)

		return cfg.exp - exp
	end

	return 0
end

function StarEquipmentConfig:getEquipAttrs(id, level)
	local cfg = self:getEquipLvCfg(id, level)
	local attrs = {}

	if cfg ~= nil and not string.nilorempty(cfg.propertyApp) then
		local t = string.split(cfg.propertyApp, "#")

		for _, str in ipairs(t) do
			local t2 = string.split(str, "+")
			local key = t2[1]

			attrs[key] = t2[2]
		end
	end

	return attrs
end

function StarEquipmentConfig:getEquipAttrsDes(id, level)
	local text = ""
	local attrs = self:getEquipAttrs(id, level)

	for key, value in pairs(attrs) do
		if not string.nilorempty(text) then
			text = text .. "\t"
		end

		if string.find(key, "率") then
			value = checknumber(value) * 100 .. "%"
		end

		text = text .. string.format("%s+%s", ConstString.langAttr(key), value)
	end

	return text
end

function StarEquipmentConfig:getTargetLvAndExp()
	return
end

function StarEquipmentConfig:getEquipUpMatId()
	return checknumber(self._equipOtherCfgs.UPGRADE_MATERIAL_ITEM_ID.value)
end

function StarEquipmentConfig:getEquipUpMatExp()
	return checknumber(self._equipOtherCfgs.UPGRADE_MATERIAL_ITEM_EXP.value)
end

function StarEquipmentConfig:getEquipmentsByLv(raceId, lv)
	local cf = CharacterConfig.instance:getPetEquipByLvlCfg(raceId, lv)

	if not cf or not cf.slots or #cf.slots == 0 then
		cf = CharacterConfig.instance:getPetEquipByLvlCfg(raceId, lv - 1)
	end

	local equipments

	if cf and cf.slots then
		local slots = cf.slots

		for j, a in ipairs(slots) do
			for k, b in pairs(a) do
				local scf = self:getEquipCfg(b)
				local id = b

				if checknumber(scf.breakThrough) > 0 then
					id = scf.breakThrough
				end

				equipments = equipments or {}

				table.insert(equipments, id)
			end
		end
	end

	return equipments
end

function StarEquipmentConfig:getMaxZDL(raceId)
	local zdl = 0
	local cf = CharacterConfig.instance:getPetEquipCfg(raceId)

	if cf then
		for i, v in pairs(cf) do
			local slots = v.slots

			if slots then
				for j, a in ipairs(slots) do
					for k, b in pairs(a) do
						local scf = self:getEquipCfg(b)
						local starCf = self._equipLvCfgs[(checknumber(scf.breakThrough) > 0 or nil) and scf.breakThrough]

						if starCf and #starCf > 0 then
							ArraySort.sortOn(starCf, "level")

							zdl = zdl + starCf[#starCf].zhanDouLi
						end
					end
				end
			end
		end
	end

	return zdl
end

function StarEquipmentConfig:getPetZdl(raceId, eqLvl, equipSlots, callback)
	local zdl = 0

	for lvl = 0, eqLvl - 1 do
		local cf = CharacterConfig.instance:getPetEquipByLvlCfg(raceId, lvl)

		if cf then
			local slots = cf.slots

			if slots then
				for i, v in ipairs(slots) do
					local sid = v[1]
					local starCf = self._equipLvCfgs[sid]

					if starCf and #starCf > 0 then
						ArraySort.sortOn(starCf, "level")

						local cfg = starCf[#starCf]

						zdl = zdl + cfg.zhanDouLi

						GameUtil.callBack(callback, cfg)
					end
				end
			end
		end
	end

	if eqLvl >= 0 and equipSlots then
		for _, slotInfo in pairs(equipSlots) do
			if slotInfo.slotItems then
				if not slotInfo.slotItems[1] then
					local equip

					if equip ~= nil then
						local equipLvCfg = self:getEquipLvCfg(equip.equipmentId, equip.level)

						if equipLvCfg then
							zdl = zdl + equipLvCfg.zhanDouLi

							GameUtil.callBack(callback, equipLvCfg)
						end
					end
				end
			end
		end
	end

	return zdl
end

StarEquipmentConfig.instance = StarEquipmentConfig.New()

return StarEquipmentConfig
