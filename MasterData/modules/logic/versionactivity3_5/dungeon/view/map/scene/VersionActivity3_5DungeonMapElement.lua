-- chunkname: @modules/logic/versionactivity3_5/dungeon/view/map/scene/VersionActivity3_5DungeonMapElement.lua

module("modules.logic.versionactivity3_5.dungeon.view.map.scene.VersionActivity3_5DungeonMapElement", package.seeall)

local VersionActivity3_5DungeonMapElement = class("VersionActivity3_5DungeonMapElement", VersionActivityFixedDungeonMapElement)

function VersionActivity3_5DungeonMapElement:onClick()
	if VersionActivity3_5DungeonLogicController.instance:isInDragFrame() then
		return
	end

	VersionActivity3_5DungeonMapElement.super.onClick(self)
	VersionActivity3_5DungeonLogicController.instance:setDragFrameFlag()
end

function VersionActivity3_5DungeonMapElement:setScale(value)
	transformhelper.setLocalScale(self._transform, value, value, 1)
end

return VersionActivity3_5DungeonMapElement
