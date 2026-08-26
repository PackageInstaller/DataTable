-- chunkname: @modules/logic/explore/model/mo/unit/ExploreArchiveUnitMO.lua

module("modules.logic.explore.model.mo.unit.ExploreArchiveUnitMO", package.seeall)

local ExploreArchiveUnitMO = class("ExploreArchiveUnitMO", ExploreBaseUnitMO)

function ExploreArchiveUnitMO:initTypeData()
	self.archiveId = tonumber(self.specialDatas[1])
	self.triggerEffects = tabletool.copy(self.triggerEffects)

	local data = {
		ExploreEnum.TriggerEvent.OpenArchiveView
	}
	local dialogueIndex

	for index, arr in ipairs(self.triggerEffects) do
		if arr[1] == ExploreEnum.TriggerEvent.Dialogue then
			dialogueIndex = index

			break
		end
	end

	if dialogueIndex then
		table.insert(self.triggerEffects, dialogueIndex + 1, data)
	else
		table.insert(self.triggerEffects, 1, data)
	end
end

return ExploreArchiveUnitMO
