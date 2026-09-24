-- chunkname: @modules/logic/assist/model/rpcmo/RoleBadgeInfoMo.lua

module("modules.logic.assist.model.rpcmo.RoleBadgeInfoMo", package.seeall)

local RoleBadgeInfoMo = pureTable("RoleBadgeInfoMo")

function RoleBadgeInfoMo:init(data)
	self.records, self.recordsMap = GameUtil.rpcInfosToListAndMap(data.records, RoleBadgeRecordMo, "heroUid")
end

function RoleBadgeInfoMo:updateRecordMos(datas)
	for _, data in ipairs(datas) do
		local recordMo = self:getRecordMo(data.heroUid)

		if not recordMo then
			recordMo = RoleBadgeRecordMo.New()
			self.recordsMap[data.heroUid] = recordMo
			self.records[#self.records + 1] = recordMo
		end

		recordMo:updateBadge(data)
	end

	AssistController.instance:dispatchEvent(AssistEvent.UpdateBadgeInfo)
end

function RoleBadgeInfoMo:getRecordMo(heroUid)
	return self.recordsMap[heroUid]
end

return RoleBadgeInfoMo
