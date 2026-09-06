-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/component/mainplayer/NpcUnlockMo.lua

module("logicscene.scene.component.mainplayer.NpcUnlockMo", package.seeall)

local NpcUnlockMo = class("NpcUnlockMo")

function NpcUnlockMo:ctor(npcCo, scene)
	self.npcCo = npcCo
	self.scene = scene

	self:_calculate()
end

function NpcUnlockMo:_calculate()
	if self.npcCo.funcType == UnitConst.NPC_BYSERVEROPENDAYS then
		local days = string.split(self.npcCo.funcParams, ",")

		self.startTime = checknumber(days[1])
		self.endTime = checknumber(days[2])
		self.endTime = self.endTime == 0 and math.huge or self.endTime + self.startTime - 1
	elseif self.npcCo.funcType == UnitConst.NPC_BYSERVERDATE then
		local dates = string.split(self.npcCo.funcParams, "#")

		self.startTime = GameUtil.string2time(dates[1])
		self.endTime = string.nilorempty(dates[2]) and math.huge or GameUtil.string2time(dates[2])
	end

	self._hasUnlocked = self.scene.unitFactory:getUnit(UnitTag.Npc, self.npcCo.id) ~= nil
end

function NpcUnlockMo:isUnlock()
	if self.npcCo.funcType == UnitConst.NPC_BYSERVEROPENDAYS then
		local days = GameUtil.getOpenAreaDaysForFive()

		return days >= self.startTime and days <= self.endTime
	elseif self.npcCo.funcType == UnitConst.NPC_BYSERVERDATE then
		local nowTime = ServerTime.now()

		return nowTime >= self.startTime and nowTime < self.endTime
	end
end

function NpcUnlockMo:checkUnLock()
	if self:isUnlock() then
		self:_unlockNpc()
	else
		self:_lockNpc()
	end
end

function NpcUnlockMo:_unlockNpc()
	if not self._hasUnlocked then
		self._hasUnlocked = true

		self.scene.unitFactory:createNpcById(self.npcCo.id)
	end
end

function NpcUnlockMo:_lockNpc()
	if self._hasUnlocked then
		self._hasUnlocked = false

		self.scene.unitFactory:destroyNpcById(self.npcCo.id)
	end
end

return NpcUnlockMo
