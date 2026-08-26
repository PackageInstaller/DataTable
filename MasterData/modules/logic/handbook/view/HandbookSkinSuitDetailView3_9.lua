-- chunkname: @modules/logic/handbook/view/HandbookSkinSuitDetailView3_9.lua

module("modules.logic.handbook.view.HandbookSkinSuitDetailView3_9", package.seeall)

local HandbookSkinSuitDetailView3_9 = class("HandbookSkinSuitDetailView3_9", HandbookSkinSuitDetailViewBase)

function HandbookSkinSuitDetailView3_9:initImageBg()
	self._imageBg = gohelper.findChildSingleImage(self.viewGO, "#simage_FullBG")
end

return HandbookSkinSuitDetailView3_9
