-- chunkname: @modules/logic/necrologiststory/view/item/NecrologistStoryAsideItem.lua

module("modules.logic.necrologiststory.view.item.NecrologistStoryAsideItem", package.seeall)

local NecrologistStoryAsideItem = class("NecrologistStoryAsideItem", NecrologistStoryTextItem)

function NecrologistStoryAsideItem.getResPath()
	return "ui/viewres/dungeon/rolestory/item/necrologiststoryasideitem.prefab"
end

return NecrologistStoryAsideItem
