-- chunkname: @modules/logic/store/model/ActivityStoreMo.lua

module("modules.logic.store.model.ActivityStoreMo", package.seeall)

local ActivityStoreMo = pureTable("ActivityStoreMo")

function ActivityStoreMo:init(actId, info)
	self.actId = actId
	self.id = info.id
	self.config = ActivityStoreConfig.instance:getStoreConfig(actId, self.id)

	self:updateData(info)
end

function ActivityStoreMo:updateData(info)
	self.buyCount = info.buyCount
end

return ActivityStoreMo
