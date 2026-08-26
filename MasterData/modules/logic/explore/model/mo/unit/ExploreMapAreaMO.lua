-- chunkname: @modules/logic/explore/model/mo/unit/ExploreMapAreaMO.lua

module("modules.logic.explore.model.mo.unit.ExploreMapAreaMO", package.seeall)

local ExploreMapAreaMO = pureTable("ExploreMapAreaMO")

function ExploreMapAreaMO:init(config)
	self.id = config[1]
	self._unitData = config[2]
	self.isCanReset = config[3]
	self.visible = ExploreModel.instance:isAreaShow(self.id)
	self.unitList = {}

	for _, item in ipairs(self._unitData) do
		local id = item[1]

		if ExploreModel.instance:hasInteractInfo(id) then
			local mo = ExploreMapModel.instance:createUnitMO(item)

			if mo then
				table.insert(self.unitList, mo)
			end
		end
	end
end

return ExploreMapAreaMO
