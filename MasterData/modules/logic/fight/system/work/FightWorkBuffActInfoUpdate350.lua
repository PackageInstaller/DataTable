-- chunkname: @modules/logic/fight/system/work/FightWorkBuffActInfoUpdate350.lua

module("modules.logic.fight.system.work.FightWorkBuffActInfoUpdate350", package.seeall)

local FightWorkBuffActInfoUpdate350 = class("FightWorkBuffActInfoUpdate350", FightEffectBase)

function FightWorkBuffActInfoUpdate350:onConstructor()
	self.SAFETIME = 4
end

function FightWorkBuffActInfoUpdate350:beforePlayEffectData()
	local entityMo = FightDataHelper.entityMgr:getById(self.actEffectData.targetId)
	local buffDict = entityMo and entityMo:getBuffDic()
	local buffUid = self.actEffectData.reserveId

	self.buffMo = buffDict and buffDict[buffUid]

	if self.buffMo then
		self.oldParam1 = self.buffMo and self.getBuffActListParam1(self.buffMo, self.actEffectData.buffActInfo.actId) or 0
	end
end

function FightWorkBuffActInfoUpdate350:onStart()
	FightWorkBuffActInfoUpdate350.initBuffActHandle()

	local handle = FightWorkBuffActInfoUpdate350.buffActHandleDict[self.actEffectData.buffActInfo.actId]

	handle = handle or self.defaultHandle

	handle(self)
	FightMsgMgr.sendMsg(FightMsgId.UpdateEntityBuffActInfo, self.actEffectData.targetId, self.actEffectData.reserveId, self.actEffectData.buffActInfo)
end

function FightWorkBuffActInfoUpdate350.initBuffActHandle()
	FightWorkBuffActInfoUpdate350.buffActHandleDict = FightWorkBuffActInfoUpdate350.buffActHandleDict or {
		[FightEnum.BuffActId.Rouge2CheckCount] = FightWorkBuffActInfoUpdate350.handleRouge2CheckCountUpdate,
		[FightEnum.BuffActId.LostHpToFakeHp] = FightWorkBuffActInfoUpdate350.handleLostHpToFakeHpUpdate,
		[FightEnum.BuffActId.DeviceExPointOverflowBank] = FightWorkBuffActInfoUpdate350.handleDeviceExPointOverflowBankUpdate,
		[FightEnum.BuffActId.HedoneCard] = FightWorkBuffActInfoUpdate350.handleHedoneCardUpdate
	}
end

function FightWorkBuffActInfoUpdate350:defaultHandle()
	local entityId = self.actEffectData.targetId
	local buffUid = self.actEffectData.reserveId

	self:com_sendFightEvent(FightEvent.UpdateBuffActInfo, entityId, buffUid, self.actEffectData.buffActInfo)
	self:onDone(true)
end

function FightWorkBuffActInfoUpdate350:handleLostHpToFakeHpUpdate()
	local entityId = self.actEffectData.targetId

	self:com_sendFightEvent(FightEvent.OnFakeHpChange, entityId)
	self:onDone(true)
end

function FightWorkBuffActInfoUpdate350:handleDeviceExPointOverflowBankUpdate()
	local entityId = self.actEffectData.targetId
	local entityMo = FightDataHelper.entityMgr:getById(entityId)

	if entityMo then
		entityMo:updateStoredDeviceExPoint()
	end

	self:com_sendFightEvent(FightEvent.OnDevice_StoreExPointChange, entityId)
	self:onDone(true)
end

function FightWorkBuffActInfoUpdate350:handleRouge2CheckCountUpdate()
	if self.buffMo then
		local buffId = self.buffMo.buffId

		if not buffId then
			logError("rouge 2 buffId is nil， buff not added ?")
			self:defaultHandle()

			return
		end

		local customData = FightDataHelper.fieldMgr.customData
		local buffId2RelicListDict = customData and customData:getRouge2BuffId2RelicDict()

		if not buffId2RelicListDict then
			logError("buffId2RelicListDict is nil")
			self:defaultHandle()

			return
		end

		local relicList = buffId2RelicListDict[tostring(buffId)]

		if not relicList then
			logError(string.format("relic list is nil, buffId : %s, data : %s", buffId, cjson.encode(buffId2RelicListDict)))
			self:defaultHandle()

			return
		end

		local oldValue = self.oldParam1
		local curValue = self.getBuffActInfoParam1(self.actEffectData.buffActInfo)
		local offset = curValue - oldValue

		if offset < 1 then
			logNormal("FightWorkBuffActInfoUpdate350 : offset .. " .. tostring(offset))
			self:defaultHandle()

			return
		end

		ViewMgr.instance:openView(ViewName.FightRouge2Check362View, {
			offset = offset,
			buffId = buffId
		})
		self:com_registTimer(self.defaultHandle, FightRouge2Check362View.DurationTime)
	end
end

function FightWorkBuffActInfoUpdate350:handleHedoneCardUpdate()
	local entityId = self.actEffectData.targetId

	self:com_sendFightEvent(FightEvent.OnHeDuoNieBuffDataUpdate, entityId)
	self:onDone(true)
end

function FightWorkBuffActInfoUpdate350.getBuffActInfoParam1(buffActMo)
	local param = buffActMo and buffActMo.param

	return (param or nil) and (param[1] or 0)
end

function FightWorkBuffActInfoUpdate350.getBuffActListParam1(buffActList, buffActId)
	if not buffActList then
		return 0
	end

	for _, buffActInfo in ipairs(buffActList) do
		if buffActInfo.actId == buffActId then
			return FightWorkBuffActInfoUpdate350.getBuffActInfoParam1(buffActInfo)
		end
	end

	return 0
end

return FightWorkBuffActInfoUpdate350
