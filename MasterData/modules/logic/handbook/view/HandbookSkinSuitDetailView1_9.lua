-- chunkname: @modules/logic/handbook/view/HandbookSkinSuitDetailView1_9.lua

module("modules.logic.handbook.view.HandbookSkinSuitDetailView1_9", package.seeall)

local HandbookSkinSuitDetailView1_9 = class("HandbookSkinSuitDetailView1_9", HandbookSkinSuitDetailViewBase)

function HandbookSkinSuitDetailView1_9:onOpen()
	HandbookSkinSuitDetailViewBase.onOpen(self)

	self._viewMatCtrl = self.viewGO:GetComponent(typeof(ZProj.MaterialPropsCtrl))

	if not self._isSuitSwitch and self._viewMatCtrl then
		self._viewMatCtrl.vector_02 = Vector4.New(1, 1, 0.18, 0)
	end
end

return HandbookSkinSuitDetailView1_9
