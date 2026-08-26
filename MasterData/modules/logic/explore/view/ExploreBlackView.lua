-- chunkname: @modules/logic/explore/view/ExploreBlackView.lua

module("modules.logic.explore.view.ExploreBlackView", package.seeall)

local ExploreBlackView = class("ExploreBlackView", BaseView)

function ExploreBlackView:onInitView()
	self.anim = self.viewGO:GetComponent(typeof(UnityEngine.Animator))
end

function ExploreBlackView:onOpenFinish()
	if self._has_onOpen then
		self.anim.enabled = true

		self.anim:Play("loop", 0, 0)
	end
end

return ExploreBlackView
