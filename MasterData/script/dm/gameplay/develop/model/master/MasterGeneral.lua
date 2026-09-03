-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/develop/model/master/MasterGeneral.lua

require("dm.gameplay.develop.model.master.MasterSkill")

MasterGeneral = class("MasterGeneral", objectlua.Object, _M)

MasterGeneral:has("_generalSkills", {
	is = "r"
})

function MasterGeneral:initialize(player)
	super.initialize(self)

	self._player = player
	self._generalSkills = {}
end

function MasterGeneral:synchronize(data)
	if not data.generalSkillList then
		return
	end

	self._skillGeneralIndex = {}

	for k, v in pairs(data.generalSkillList) do
		local config = ConfigReader:getRecordById("Skill", tostring(v))

		if config and config.Type == 0 then
			table.insert(self._skillGeneralIndex, v)
		end
	end

	local removeIds = {}

	for skillId, skill in pairs(self._generalSkills) do
		if not data.generalSkills[skillId] then
			removeIds[#removeIds + 1] = skillId
		end
	end

	for i = 1, #removeIds do
		local skillId = removeIds[i]

		self._generalSkills[skillId]:getSkillAttrEffect():removeEffect()

		self._generalSkills[skillId] = nil
	end

	for k, v in pairs(data.generalSkills) do
		local isSpecial = ConfigReader:getRecordById("Skill", tostring(k))

		if isSpecial ~= nil then
			local skill = self._generalSkills[k]

			if not skill then
				skill = MasterSkill:new(k)

				skill:createAttrEffect(self._player, self._player, AttrSystemName.kMasterGeneral)

				self._generalSkills[k] = skill
			end

			skill:syncData(k, v)
		end
	end
end

function MasterGeneral:getSkillOfferCombat()
	local offerCombat = 0

	for skillId, skill in pairs(self._generalSkills) do
		-- block empty
	end

	return offerCombat
end

function MasterGeneral:syncMasterSkillData(data)
	local syncdata = data.master and data.master or data
	local id = syncdata.id
	local masterModel = self:getMasterById(id)

	masterModel:syncData(syncdata)
end

function MasterGeneral:getSkillByIndex(idx)
	local skillid = self._skillGeneralIndex[idx]

	for k, v in pairs(self._generalSkills) do
		if tostring(skillid) == k then
			return v
		end
	end

	return nil
end

function MasterGeneral:getSkillIndex(skillid)
	for k, v in pairs(self._skillGeneralIndex) do
		if v == skillid then
			return k
		end
	end

	return 1
end

function MasterGeneral:getSkillIndexs()
	return self._skillGeneralIndex
end

function MasterGeneral:getGeneralSkillById(skillid)
	for k, v in pairs(self._generalSkills) do
		if tostring(skillid) == k then
			return v
		end
	end

	return nil
end
