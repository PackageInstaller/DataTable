-- chunkname: @modules/logic/guide/controller/action/impl/GuideActionExploreShowOutline.lua

module("modules.logic.guide.controller.action.impl.GuideActionExploreShowOutline", package.seeall)

local GuideActionExploreShowOutline = class("GuideActionExploreShowOutline", BaseGuideAction)

function GuideActionExploreShowOutline:onStart(context)
	local arr = string.splitToNumber(self.actionParam, "#")
	local id = arr[1]
	local isShowOutLine = arr[2] == 1
	local map = ExploreController.instance:getMap()

	if map then
		local unit = map:getUnit(id)

		if unit then
			unit:forceOutLine(isShowOutLine)
		end
	else
		logError("不在密室中？？？")
	end

	self:onDone(true)
end

return GuideActionExploreShowOutline
