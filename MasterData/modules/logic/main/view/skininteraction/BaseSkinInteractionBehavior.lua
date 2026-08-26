-- chunkname: @modules/logic/main/view/skininteraction/BaseSkinInteractionBehavior.lua

module("modules.logic.main.view.skininteraction.BaseSkinInteractionBehavior", package.seeall)

local BaseSkinInteractionBehavior = class("BaseSkinInteractionBehavior")

function BaseSkinInteractionBehavior:init(view, skinId)
	self._view = view
	self._skinId = skinId

	self:_onInit()
end

function BaseSkinInteractionBehavior:_onInit()
	return
end

function BaseSkinInteractionBehavior:_onBodyChange(prevBodyName, curBodyName)
	return
end

function BaseSkinInteractionBehavior:_onDestroy()
	return
end

return BaseSkinInteractionBehavior
