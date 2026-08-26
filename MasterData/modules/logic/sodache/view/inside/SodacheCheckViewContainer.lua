-- chunkname: @modules/logic/sodache/view/inside/SodacheCheckViewContainer.lua

module("modules.logic.sodache.view.inside.SodacheCheckViewContainer", package.seeall)

local SodacheCheckViewContainer = class("SodacheCheckViewContainer", BaseViewContainer)

function SodacheCheckViewContainer:buildViews()
	return {
		SodacheCheckView.New()
	}
end

function SodacheCheckViewContainer:setCloseAnimName(animName)
	self._closeAnimName = animName
end

function SodacheCheckViewContainer:playOpenTransition()
	SodacheCheckViewContainer.super.playOpenTransition(self, {
		duration = 0.7,
		anim = "event_open"
	})
end

function SodacheCheckViewContainer:playCloseTransition()
	if not self._closeAnimName then
		SodacheCheckViewContainer.super.playCloseTransition(self, {
			duration = 0.5,
			anim = self._closeAnimName
		})
	end
end

return SodacheCheckViewContainer
