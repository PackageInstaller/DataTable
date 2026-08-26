-- chunkname: @modules/logic/versionactivity1_2/jiexika/system/work/Activity114ChangeEventWork.lua

module("modules.logic.versionactivity1_2.jiexika.system.work.Activity114ChangeEventWork", package.seeall)

local Activity114ChangeEventWork = class("Activity114ChangeEventWork", Activity114BaseWork)

function Activity114ChangeEventWork:onStart()
	if self.context.preAttrs and self.context.nowWeek == Activity114Model.instance.serverData.week then
		local attrDict = Activity114Model.instance.attrDict

		for i = 1, Activity114Enum.Attr.End - 1 do
			if attrDict[i] ~= self.context.preAttrs[i] then
				Activity114Model.instance.attrChangeDict = Activity114Model.instance.attrChangeDict or {}
				Activity114Model.instance.attrChangeDict[i] = true
			end
		end
	else
		Activity114Model.instance.attrChangeDict = nil
	end

	Activity114Model.instance.preEventType = self.context.type
	Activity114Model.instance.preResult = self.context.result

	if self.context.type == Activity114Enum.EventType.KeyDay and self.context.eventCo.config.isCheckEvent == 0 then
		Activity114Model.instance.preResult = nil
	end

	for eventId in pairs(Activity114Model.instance.changeEventList) do
		Activity114Controller.instance:dispatchEvent(eventId)
	end

	Activity114Model.instance.changeEventList = {}

	Activity114Controller.instance:dispatchEvent(Activity114Event.UnLockRedDotUpdate)
	self:onDone(true)
end

return Activity114ChangeEventWork
