-- chunkname: @modules/logic/necrologiststory/view/item/NecrologistStorySystemItem.lua

module("modules.logic.necrologiststory.view.item.NecrologistStorySystemItem", package.seeall)

local NecrologistStorySystemItem = class("NecrologistStorySystemItem", NecrologistStoryTextItem)

function NecrologistStorySystemItem.getResPath()
	return "ui/viewres/dungeon/rolestory/item/necrologiststorysystemitem.prefab"
end

return NecrologistStorySystemItem
