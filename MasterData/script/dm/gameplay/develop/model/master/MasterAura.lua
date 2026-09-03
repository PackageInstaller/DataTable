-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/develop/model/master/MasterAura.lua

require("dm.gameplay.develop.model.master.MasterSkill")

MasterAura = class("MasterAura", objectlua.Object, _M)

MasterAura:has("_generalSkills", {
	is = "r"
})
MasterAura:has("_auraData", {
	is = "r"
})

function MasterAura:initialize(player)
	super.initialize(self)

	self._player = player
	self._auraData = {}
end

function MasterAura:synchronize(data)
	if data.masterAura then
		for k, v in pairs(data.masterAura) do
			self._auraData[k] = ConfigReader:getRecordById("MasterAura", v)
		end
	end
end

function MasterAura:getSkillOfferCombat()
	local offerCombat = 0

	for skillId, skill in pairs(self._generalSkills) do
		-- block empty
	end

	return offerCombat
end

function MasterAura:getSkillIndexs()
	return self._skillGeneralIndex
end

function MasterAura:getGeneralSkillById(skillid)
	for k, v in pairs(self._generalSkills) do
		if tostring(skillid) == k then
			return v
		end
	end

	return nil
end
