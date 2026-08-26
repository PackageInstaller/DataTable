-- chunkname: @modules/logic/guide/controller/action/impl/GuideActionExploreUseItem.lua

module("modules.logic.guide.controller.action.impl.GuideActionExploreUseItem", package.seeall)

local GuideActionExploreUseItem = class("GuideActionExploreUseItem", BaseGuideAction)

function GuideActionExploreUseItem:onStart(context)
	local arr = string.splitToNumber(self.actionParam, "#")
	local itemId = arr[1]
	local isUse = arr[2] == 1
	local itemMo = ExploreBackpackModel.instance:getItem(itemId)

	if itemMo then
		local usingItem = ExploreModel.instance:getUseItemUid() == itemMo.id

		if usingItem ~= isUse then
			ExploreRpc.instance:sendExploreUseItemRequest(itemMo.id, 0, 0)
		end
	end

	self:onDone(true)
end

return GuideActionExploreUseItem
