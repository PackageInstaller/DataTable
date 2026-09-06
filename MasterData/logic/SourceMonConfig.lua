-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/sourcemon/config/SourceMonConfig.lua

module("logic.extensions.sourcemon.config.SourceMonConfig", package.seeall)

local SourceMonConfig = class("SourceMonConfig", BaseConfig)

SourceMonConfig.TotalZhandouli = 1000

local keyList = {
	"levelOneProps",
	"levelTwoProps",
	"levelThreeProps",
	"levelFourProps",
	"levelFiveProps",
	"levelSixProps",
	"levelSevenProps",
	"levelEightProps",
	"levelNineProps",
	"LevelTenProps"
}

function SourceMonConfig:onInit()
	SourceMonConfig.super.onInit(self)

	self._sourcemon_defineCfg = nil
end

function SourceMonConfig:getNames()
	return {
		"sourcemon_define",
		"sourcemon_skill",
		"sourcemon_mutation",
		"sourcemon_upgrade",
		"sourcemon_other_config"
	}
end

function SourceMonConfig:handleConfig(name, content)
	if name == "sourcemon_define" then
		self._sourcemon_defineCfg = content

		self:initSourcemonCfg()
	elseif name == "sourcemon_skill" then
		self._sourcemon_skillCfg = content
	elseif name == "sourcemon_mutation" then
		self._sourcemon_mutationCfg = content
	elseif name == "sourcemon_upgrade" then
		self._sourcemon_upgradeCfg = content
	elseif name == "sourcemon_other_config" then
		self._sourcemon_otherCfg = content

		self:initOtherCfg()
	end
end

function SourceMonConfig:initSourcemonCfg()
	self._sourceMonNameMap = {}

	for k, v in pairs(self._sourcemon_defineCfg) do
		if type(k) == "number" then
			local modelCo = CharacterConfig.instance:getModelCo(checknumber(v.modelId))

			v.icon = modelCo.headName
			self._sourceMonNameMap[v.typeName] = v
		end
	end
end

function SourceMonConfig:initOtherCfg()
	SourceMonConfig.TotalZhandouli = self._sourcemon_otherCfg.max_zhandouli.value
end

function SourceMonConfig:getSourceMonDefineByName(name)
	return self._sourceMonNameMap[name]
end

function SourceMonConfig:getOtherValue(key)
	return self._sourcemon_otherCfg[key].value
end

function SourceMonConfig:getMonName(id)
	local conf = self:getCfgById(id)

	return (conf ~= nil or nil) and conf.name
end

function SourceMonConfig:getCfgs()
	return self._sourcemon_defineCfg
end

function SourceMonConfig:getZhandouli(id, lvl, mutatedTypeId)
	local zdl = 0
	local tem = 0
	local cfg = self:getCfgById(id)

	if cfg ~= nil then
		local arr = cfg.zdls

		zdl = checknumber(arr[lvl])
	end

	local conf = self:getMutatedTypeById(mutatedTypeId or 0)

	if conf ~= nil then
		local arr = conf.mutatedZdls

		tem = checknumber(arr[lvl])
	end

	return zdl + tem
end

function SourceMonConfig:getDescByIdLvl(id, lvl, concat, len, count)
	local str = ""

	concat = concat or "\t\t"
	len = len or 2

	local conf = self:getCfgById(id)

	if conf ~= nil then
		local desc = conf[keyList[lvl]]
		local arr = string.split(desc, "#")

		for i, v in ipairs(arr) do
			local temStr = v
			local temArr = string.split(temStr, "+")

			str = str .. temArr[1] .. ":+" .. temArr[2] .. concat

			if i % len == 0 then
				str = str .. "\n"
			end

			if count ~= nil and count <= i then
				str = str .. "..."

				break
			end
		end
	end

	return str
end

function SourceMonConfig:getSourceMonAttrByLevel(id, lvl)
	local str = ""
	local conf = self:getCfgById(id)

	if conf ~= nil then
		return conf[keyList[lvl]]
	end

	return str
end

function SourceMonConfig:getSkillByIdLvl(id)
	local str = ""
	local conf = self:getCfgById(id)

	if conf ~= nil then
		local arr = conf.skillIds

		for i, v in ipairs(arr) do
			local sid = v
			local skCo = self:getSkillById(sid)

			if i > 1 then
				str = str .. "\n"
			end

			str = str .. skCo.name .. ":" .. skCo.desc .. "\n"
		end
	end

	return str
end

function SourceMonConfig:getSkillByIdArr(id, bagPetMo, filterArr)
	local tem = {}
	local str = ""
	local arr
	local conf = self:getCfgById(id)

	if conf ~= nil then
		if bagPetMo then
			local mons = {}

			for i, v in ipairs(conf.skillIds) do
				local sid = v
				local skCo = self:getSkillById(sid)
				local num = skCo.num
				local lvl = skCo.level
				local count = self:getOverLvlCount(mons, sid, lvl)

				if num <= count then
					str = langPara("%s<color=#00ff00>[已激活]</color>:%s", skCo.name, skCo.desc)
				else
					local need = self:getSameSkNames(sid)

					str = langPara("<color=#ffffff>%s</color><color=#ff4949>[未激活]</color><color=#ffffff>:%s</color>\n<size=18><color=#ff4949>[需要%s只 %s 可激活源兽技]</color></size>", skCo.name, skCo.desc, num, need)
				end

				if filterArr ~= nil then
					if table.indexof(filterArr, sid) == false then
						table.insert(filterArr, sid)
						table.insert(tem, str)
					end
				else
					table.insert(tem, str)
				end
			end
		else
			for i, v in ipairs(conf.skillIds) do
				local sid = v
				local skCo = self:getSkillById(sid)

				str = skCo.name .. ":" .. skCo.desc

				if filterArr ~= nil then
					if table.indexof(filterArr, sid) == false then
						table.insert(filterArr, sid)
						table.insert(tem, str)
					end
				else
					table.insert(tem, str)
				end
			end
		end
	end

	return tem, filterArr
end

function SourceMonConfig:getCurActSkill(mons)
	local tem = {}
	local arr

	for j, smMo in ipairs(mons) do
		local conf = self:getCfgById(smMo.defineId)

		if conf ~= nil then
			for i, v in ipairs(conf.skillIds) do
				local sid = v

				if tem[sid] == nil then
					local skCo = self:getSkillById(sid)
					local num = skCo.num
					local lvl = skCo.level
					local count = self:getOverLvlCount(mons, sid, lvl)

					if num <= count then
						tem[sid] = skCo
					end
				end
			end
		end
	end

	return tem
end

function SourceMonConfig:getSameSkNames(sid)
	local str = ""
	local count = 0

	for i, cf in ipairs(self._sourcemon_defineCfg) do
		local arr = cf.skillIds

		if table.indexof(arr, sid) ~= false then
			str = count == 0 and str .. cf.name or str .. "/" .. cf.name
			count = count + 1
		end
	end

	return str
end

function SourceMonConfig:getOverLvlCount(mons, sid, lvl)
	local count = 0

	for j, smMo in ipairs(mons) do
		if lvl <= smMo.level then
			local cf = self:getCfgById(smMo.defineId)
			local ar = cf.skillIds

			if table.indexof(ar, sid) ~= false then
				count = count + 1
			end
		end
	end

	return count
end

function SourceMonConfig:getMutatedTypeId(id, lvl)
	local str = ""
	local conf = self:getMutatedTypeById(id)

	if conf ~= nil then
		local arr = conf.propDesc
		local desc = conf.desc
		local tem = arr[lvl]

		str = string.format(desc, tem)
	end

	return str
end

function SourceMonConfig:getCostByLvlup(mo1, mo2)
	local conf = self:getUpGradeConf(mo1, mo2)

	return (conf ~= nil or nil) and conf.beanCost
end

function SourceMonConfig:getUpGradeConf(mo1, mo2)
	local v1 = 0
	local v2 = 0

	if mo1 ~= nil and mo1.defineId > 0 then
		local conf1 = self:getCfgById(mo1.defineId)

		v1 = conf1.gradeUpValues[mo1.level]
	end

	if mo2 ~= nil and mo2.defineId > 0 then
		local conf2 = self:getCfgById(mo2.defineId)

		v2 = conf2.gradeUpValues[mo2.level]
	end

	local v = v1 + v2

	return (self:getMonUpgradeById(v))
end

function SourceMonConfig:getLvlRange(mo1, mo2)
	local conf = self:getUpGradeConf(mo1, mo2)
	local min = 1
	local max = 1

	if conf ~= nil then
		local races = conf.rates
		local isMin = false

		for i, v in ipairs(races) do
			if v > 0 then
				if isMin == false then
					isMin = true
					min = i
				end

				max = i
			end
		end
	end

	return min, max
end

function SourceMonConfig:getCfgById(defineId)
	return self._sourcemon_defineCfg[defineId]
end

function SourceMonConfig:getSkillById(id)
	return self._sourcemon_skillCfg[id]
end

function SourceMonConfig:getMonUpgradeById(id)
	return self._sourcemon_upgradeCfg[id]
end

function SourceMonConfig:getMutatedTypeById(id)
	if self._sourcemon_mutationCfg then
		return self._sourcemon_mutationCfg[id]
	end

	return nil
end

SourceMonConfig.instance = SourceMonConfig.New()

return SourceMonConfig
