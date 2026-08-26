-- chunkname: @modules/versionactivitybase/fixed1/dungeon/controller/VersionActivityFixedDungeonLogicController1.lua

module("modules.versionactivitybase.fixed1.dungeon.controller.VersionActivityFixedDungeonLogicController1", package.seeall)

local VersionActivityFixedDungeonLogicController1 = class("VersionActivityFixedDungeonLogicController1", BaseController)

function VersionActivityFixedDungeonLogicController1:onInit()
	return
end

function VersionActivityFixedDungeonLogicController1:reInit()
	return
end

function VersionActivityFixedDungeonLogicController1:setDragFrameBegin()
	self._isDragging = true
end

function VersionActivityFixedDungeonLogicController1:setDragFrameEnd()
	self._dragFrameCount = Time.frameCount
	self._isDragging = false
end

function VersionActivityFixedDungeonLogicController1:setDragFrameFlag()
	self._dragFrameCount = Time.frameCount
end

function VersionActivityFixedDungeonLogicController1:isInDragFrame()
	return self._isDragging or self._dragFrameCount and Time.frameCount - self._dragFrameCount < 2
end

VersionActivityFixedDungeonLogicController1.instance = VersionActivityFixedDungeonLogicController1.New()

return VersionActivityFixedDungeonLogicController1
