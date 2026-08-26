-- chunkname: @modules/versionactivitybase/fixed1/dungeon/view/map/scene/VersionActivityFixedDungeonMapElement1.lua

module("modules.versionactivitybase.fixed1.dungeon.view.map.scene.VersionActivityFixedDungeonMapElement1", package.seeall)

local VersionActivityFixedDungeonMapElement1 = class("VersionActivityFixedDungeonMapElement1", VersionActivityFixedDungeonMapElement)

function VersionActivityFixedDungeonMapElement1:onClick()
	if VersionActivityFixedDungeonLogicController1.instance:isInDragFrame() then
		return
	end

	VersionActivityFixedDungeonMapElement1.super.onClick(self)
	VersionActivityFixedDungeonLogicController1.instance:setDragFrameFlag()
end

function VersionActivityFixedDungeonMapElement1:setScale(value)
	transformhelper.setLocalScale(self._transform, value, value, 1)
end

return VersionActivityFixedDungeonMapElement1
