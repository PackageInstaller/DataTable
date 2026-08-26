-- chunkname: @modules/logic/handbook/view/HandbookSkinSuitDetailView2_0.lua

module("modules.logic.handbook.view.HandbookSkinSuitDetailView2_0", package.seeall)

local HandbookSkinSuitDetailView2_0 = class("HandbookSkinSuitDetailView2_0", HandbookSkinSuitDetailViewBase)

function HandbookSkinSuitDetailView2_0:onOpen()
	HandbookSkinSuitDetailViewBase.onOpen(self)

	self._viewMatCtrl = self.viewGO:GetComponent(typeof(ZProj.MaterialPropsCtrl))

	if not self._isSuitSwitch and self._viewMatCtrl then
		self._viewMatCtrl.vector_02 = Vector4.New(1, 1, 0.18, 0)
	end
end

return HandbookSkinSuitDetailView2_0
