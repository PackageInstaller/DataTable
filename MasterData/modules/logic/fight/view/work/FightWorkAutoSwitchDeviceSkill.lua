-- chunkname: @modules/logic/fight/view/work/FightWorkAutoSwitchDeviceSkill.lua

module("modules.logic.fight.view.work.FightWorkAutoSwitchDeviceSkill", package.seeall)

local FightWorkAutoSwitchDeviceSkill = class("FightWorkAutoSwitchDeviceSkill", FightWorkItem)

function FightWorkAutoSwitchDeviceSkill:onConstructor(devicesOperList)
	self.devicesOperList = devicesOperList
	self.SAFETIME = 1
end

function FightWorkAutoSwitchDeviceSkill:onStart()
	if not self.devicesOperList then
		return self:onDone(true)
	end

	local deviceArea = FightDataHelper.getDeviceArea()

	if not deviceArea then
		return self:onDone(true)
	end

	for _, op in ipairs(self.devicesOperList) do
		local uid = op.uid
		local index = op.index
		local data = deviceArea:getServerDeviceInfo(uid)

		if data then
			data:autoRoundSetIndex(index)
		end

		data = deviceArea:getClientDeviceInfo(uid)

		if data then
			data:autoRoundSetIndex(index)
		end
	end

	FightController.instance:dispatchEvent(FightEvent.RefreshDeviceArea)
	self:onDone(true)
end

return FightWorkAutoSwitchDeviceSkill
