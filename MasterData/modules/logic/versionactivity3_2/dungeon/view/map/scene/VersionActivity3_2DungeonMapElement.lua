-- chunkname: @modules/logic/versionactivity3_2/dungeon/view/map/scene/VersionActivity3_2DungeonMapElement.lua

module("modules.logic.versionactivity3_2.dungeon.view.map.scene.VersionActivity3_2DungeonMapElement", package.seeall)

local VersionActivity3_2DungeonMapElement = class("VersionActivity3_2DungeonMapElement", VersionActivityFixedDungeonMapElement)

function VersionActivity3_2DungeonMapElement:onClick()
	if VersionActivity3_2DungeonLogicController.instance:isInDragFrame() then
		return
	end

	VersionActivity3_2DungeonMapElement.super.onClick(self)
	VersionActivity3_2DungeonLogicController.instance:setDragFrameFlag()
end

function VersionActivity3_2DungeonMapElement:setScale(value)
	transformhelper.setLocalScale(self._transform, value, value, 1)
end

return VersionActivity3_2DungeonMapElement
