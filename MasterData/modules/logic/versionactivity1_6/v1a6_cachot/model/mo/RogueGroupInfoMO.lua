-- chunkname: @modules/logic/versionactivity1_6/v1a6_cachot/model/mo/RogueGroupInfoMO.lua

module("modules.logic.versionactivity1_6.v1a6_cachot.model.mo.RogueGroupInfoMO", package.seeall)

local RogueGroupInfoMO = pureTable("RogueGroupInfoMO")

function RogueGroupInfoMO:init(info)
	self.id = info.id
	self.name = info.name
	self.clothId = info.clothId
	self.heroList = {}

	for i, v in ipairs(info.heroList) do
		local heroMO = HeroModel.instance:getByHeroId(v)

		table.insert(self.heroList, (heroMO or nil) and (heroMO.uid or "0"))
	end

	self.equips = {}

	for i, v in ipairs(info.equips) do
		local mo = HeroGroupEquipMO.New()

		mo:init(v)
		table.insert(self.equips, mo)
	end
end

function RogueGroupInfoMO:getFirstEquipMo(index)
	local mo = self.equips[index]

	if not mo then
		return nil
	end

	local uid = mo.equipUid[1]

	return EquipModel.instance:getEquip(uid)
end

return RogueGroupInfoMO
