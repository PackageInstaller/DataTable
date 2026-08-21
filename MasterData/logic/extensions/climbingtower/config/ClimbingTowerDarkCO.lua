-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/climbingtower/config/ClimbingTowerDarkCO.lua

module("logic.extensions.climbingtower.config.ClimbingTowerDarkCO", package.seeall)

local M = class("ClimbingTowerDarkCO")

function M:ctor(cfg)
	self._cfg = cfg
	self._id = cfg.id
	self._dungeon = cfg.dungeon
	self._prosEffect = {}

	if cfg.prosEffect and #cfg.prosEffect > 0 then
		for _, towerEffectId in ipairs(cfg.prosEffect) do
			table.insert(self._prosEffect, towerEffectId)
		end
	end

	self._consEffect = {}

	if cfg.consEffect and #cfg.consEffect > 0 then
		for _, towerEffectId in ipairs(cfg.consEffect) do
			table.insert(self._consEffect, towerEffectId)
		end
	end

	self._careerLimit = {}
	self._careerLimitCount = cfg.careerLimit and #cfg.careerLimit or 0

	if self._careerLimitCount > 0 then
		for _, career in ipairs(cfg.careerLimit) do
			self._careerLimit[career] = 1
		end
	end

	self._campLimit = {}
	self._campLimitCount = cfg.campLimit and #cfg.campLimit or 0

	if self._campLimitCount > 0 then
		for _, camp in ipairs(cfg.campLimit) do
			self._campLimit[camp] = 1
		end
	end

	self._roleLimit = {}
	self._roleLimitCount = cfg.roleLimit and #cfg.roleLimit or 0

	if self._roleLimitCount > 0 then
		for _, roleId in ipairs(cfg.roleLimit) do
			self._roleLimit[roleId] = 1
		end
	end
end

function M:getId()
	return self._id
end

function M:getDungeonId()
	return self._dungeon
end

function M:getEffectProsIdLst()
	return self._prosEffect
end

function M:getEffectIdLstCons()
	return self._consEffect
end

function M:getCareerLimitMap()
	return self._careerLimit
end

function M:isCareerLimit(career)
	return self._careerLimit[career] ~= nil
end

function M:getCareerLimitCount()
	return self._careerLimitCount
end

function M:getCampLimitMap()
	return self._campLimit
end

function M:isCampLimit(camp)
	return self._campLimit[camp] ~= nil
end

function M:getCampLimitCount()
	return self._campLimitCount
end

function M:getRoleLimitMap()
	return self._roleLimit
end

function M:isRoleLimit(roleId)
	return self._roleLimit[roleId] ~= nil
end

function M:getRoleLimitCount()
	return self._roleLimitCount
end

function M:getEffectDetailLstPros()
	if not self._effectDetailLstPros then
		self._effectDetailLstPros = {}

		for _, towerEffId in ipairs(self:getEffectProsIdLst() or {}) do
			local data = self:_createTowerEffDetailItem(towerEffId)

			table.insert(self._effectDetailLstPros, data)
		end
	end

	return self._effectDetailLstPros
end

function M:getEffectDetailLstCons()
	if not self._effectDetailLstCons then
		self._effectDetailLstCons = {}

		if self:getCareerLimitCount() > 0 then
			local name = lang("tip_forbid_career")
			local t = {}

			for _, career in ipairs(self._cfg.careerLimit) do
				table.insert(t, CommEnum.Career2Name[career])
			end

			local desc = string.format(lang("tip_not_out"), table.concat(t, "、"))
			local data = self:_createEffectDetailItem(name, desc)

			table.insert(self._effectDetailLstCons, data)
		end

		if self:getCampLimitCount() > 0 then
			local name = lang("tip_forbid_team")
			local t = {}

			for _, camp in ipairs(self._cfg.campLimit) do
				table.insert(t, CommEnum.CampType2Name[camp])
			end

			local desc = string.format(lang("tip_not_out"), table.concat(t, "、"))
			local data = self:_createEffectDetailItem(name, desc)

			table.insert(self._effectDetailLstCons, data)
		end

		if self:getRoleLimitCount() > 0 then
			local name = lang("tip_forbid_role")
			local t = {}

			for _, roleId in ipairs(self._cfg.roleLimit) do
				local roleName = ContainmentUtil.getHeroName(roleId)

				table.insert(t, roleName)
			end

			local desc = string.format(lang("tip_not_out"), table.concat(t, "、"))
			local data = self:_createEffectDetailItem(name, desc)

			table.insert(self._effectDetailLstCons, data)
		end

		for _, towerEffId in ipairs(self:getEffectIdLstCons() or {}) do
			local data = self:_createTowerEffDetailItem(towerEffId)

			table.insert(self._effectDetailLstCons, data)
		end
	end

	return self._effectDetailLstCons
end

function M:_createTowerEffDetailItem(towerEffectId)
	local towerEffCO = ClimbingTowerConfig.instance:getTowerEffectCO(towerEffectId)
	local name, desc

	if towerEffCO then
		name = towerEffCO:getSkillName()
		desc = towerEffCO:getSkillDesc()
	end

	return self:_createEffectDetailItem(name, desc)
end

function M:_createEffectDetailItem(name, desc)
	local data = {
		name = name,
		desc = desc
	}

	return data
end

return M
