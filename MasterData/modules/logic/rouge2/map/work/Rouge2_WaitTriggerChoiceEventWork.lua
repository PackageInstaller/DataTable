-- chunkname: @modules/logic/rouge2/map/work/Rouge2_WaitTriggerChoiceEventWork.lua

module("modules.logic.rouge2.map.work.Rouge2_WaitTriggerChoiceEventWork", package.seeall)

local Rouge2_WaitTriggerChoiceEventWork = class("Rouge2_WaitTriggerChoiceEventWork", BaseWork)

function Rouge2_WaitTriggerChoiceEventWork:ctor()
	return
end

function Rouge2_WaitTriggerChoiceEventWork:onStart()
	local curNode = Rouge2_MapModel.instance:getCurNode()

	Rouge2_MapChoiceEventHelper.triggerEventHandle(curNode)

	return self:onDone(true)
end

return Rouge2_WaitTriggerChoiceEventWork
