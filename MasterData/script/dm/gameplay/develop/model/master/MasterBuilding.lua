-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/develop/model/master/MasterBuilding.lua

MasterBuilding = class("MasterBuilding", objectlua.Object, _M)

MasterBuilding:has("_owner", {
	is = "rw"
})

function MasterBuilding:initialize(owner)
	super.initialize(self)

	self._owner = owner
	self._player = owner
	self._roomEffectList = {}

	if self._owner then
		self:createAttrEffect(self._owner, self._player)
	end
end

function MasterBuilding:createAttrEffect(owner, player)
	local dataTable = ConfigReader:getDataTable("VillageRoom")

	for k, v in pairs(dataTable) do
		local roomId = v.Id
		local putEffect = v.PutEffect

		if putEffect.type == "SkillAttrEffect" then
			local id = putEffect.id
			local target = ConfigReader:getDataByNameIdAndKey("SkillAttrEffect", id, "Target")

			if target == "MASTER" then
				local effect = SkillAttrEffect:new(AttrSystemName.kMasterBuilding .. roomId)

				effect:setOwner(owner, player)

				self._roomEffectList[roomId] = {
					effect = effect,
					putEffectId = id
				}
			end
		end
	end
end

function MasterBuilding:refreshEffect()
	for roomId, effectInfo in pairs(self._roomEffectList) do
		local effect = effectInfo.effect

		effect:removeEffect()
	end

	self:rCreateEffect()
end

function MasterBuilding:rCreateEffect()
	if GameConfigs.closeHeroRelationAttr then
		return
	end

	for roomId, effectInfo in pairs(self._roomEffectList) do
		local effect = effectInfo.effect
		local effects, buffLv = self:getAttrEffects(roomId)

		if #effects > 0 then
			effect:refreshEffects(effects, buffLv)
			effect:rCreateEffect()
		end
	end
end

function MasterBuilding:getAttrEffects(roomId)
	local effects = {}
	local dispatcher = DmGame:getInstance()
	local injector = dispatcher._injector
	local buildingSystem = injector:getInstance("BuildingSystem")
	local buffLv = 0
	local room = buildingSystem:getRoom(roomId)

	if room then
		local heroList = room:getHeroList()

		buffLv = buildingSystem:getBuildPutHeroAddBuffLv(roomId, heroList)

		if buffLv > 0 then
			local putEffect = ConfigReader:getDataByNameIdAndKey("VillageRoom", roomId, "PutEffect") or {}

			effects[#effects + 1] = putEffect.id
		end
	end

	return effects, buffLv
end
