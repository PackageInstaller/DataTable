-- chunkname: @modules/logic/sodache/model/rpcmo/SodacheUnitMo.lua

module("modules.logic.sodache.model.rpcmo.SodacheUnitMo", package.seeall)

local SodacheUnitMo = pureTable("SodacheUnitMo")

function SodacheUnitMo:ctor()
	self.isMove = nil
end

function SodacheUnitMo:init(data)
	self.uid = data.uid
	self.type = data.type
	self.configId = data.configId
	self.locationId = data.locationId
	self.locationNo = data.locationNo
	self.status = data.status
	self.shop = GameUtil.rpcInfoToMo(data.shop, SodacheShopMo, self.shop)
	self.extraInfo = {}

	if not string.nilorempty(data.extraInfo) then
		self.extraInfo = cjson.decode(data.extraInfo)
	end

	self._offsetPos = nil

	if data.type == SodacheEnum.UnitType.Player then
		self.prefabPath = SodacheConfig.instance:getConstVal(SodacheEnum.ConstId.PlayerModel)

		return
	end

	self.eventCo = lua_sodache_event.configDict[self.configId]
	self.eventGroupCo = lua_sodache_event_group.configDict[self.eventCo and self.eventCo.group]

	if not self.eventCo then
		logError("事件ID不存在！！！" .. self.configId)

		self.prefabPath = ""
	else
		self.prefabPath = self.eventCo.path
	end

	if string.nilorempty(self.prefabPath) then
		self.locationNo = 0
	end
end

function SodacheUnitMo:setLocationId(locationId, subPosId)
	if locationId == self.locationId then
		return
	end

	self.locationId = locationId
	self.locationNo = subPosId
	self._offsetPos = nil
end

function SodacheUnitMo:getOffsetPos(locationId)
	if not self._offsetPos then
		local nodeCo = SodacheModel.instance:getInsideMo().mapCo.nodes[locationId]

		if nodeCo then
			self._offsetPos = nodeCo.offsetList[self.locationNo] or Vector3()
		end
	end

	return self._offsetPos
end

function SodacheUnitMo:isHide()
	return self.eventGroupCo and self.eventGroupCo.hide == 1
end

function SodacheUnitMo:getForceOrder()
	return (self.eventGroupCo or nil) and (self.eventGroupCo.force or 0)
end

function SodacheUnitMo:canTrigger()
	if self.type == SodacheEnum.UnitType.Empty then
		return false
	end

	return self.eventCo and self.eventCo.probability <= 0
end

function SodacheUnitMo:getShowIcon()
	if not self.eventGroupCo then
		return
	end

	if self.status == SodacheEnum.UnitStatus.Finish then
		return
	end

	return self.eventGroupCo.icon
end

function SodacheUnitMo:compareOrder(unitMo)
	if not unitMo then
		return self
	end

	if self:getForceOrder() ~= unitMo:getForceOrder() then
		return self:getForceOrder() > unitMo:getForceOrder() and self or unitMo
	end

	return self.uid < unitMo.uid
end

return SodacheUnitMo
