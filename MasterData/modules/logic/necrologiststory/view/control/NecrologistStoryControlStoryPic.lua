-- chunkname: @modules/logic/necrologiststory/view/control/NecrologistStoryControlStoryPic.lua

module("modules.logic.necrologiststory.view.control.NecrologistStoryControlStoryPic", package.seeall)

local NecrologistStoryControlStoryPic = class("NecrologistStoryControlStoryPic", NecrologistStoryControlMgrItem)

function NecrologistStoryControlStoryPic:onPlayControl()
	local picName = self.controlParam

	NecrologistStoryController.instance:dispatchEvent(NecrologistStoryEvent.OnChangePic, picName)
	self:onPlayControlFinish()
end

return NecrologistStoryControlStoryPic
