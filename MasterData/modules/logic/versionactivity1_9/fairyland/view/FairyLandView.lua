-- chunkname: @modules/logic/versionactivity1_9/fairyland/view/FairyLandView.lua

module("modules.logic.versionactivity1_9.fairyland.view.FairyLandView", package.seeall)

local FairyLandView = class("FairyLandView", BaseView)

function FairyLandView:onInitView()
	if self._editableInitView then
		self:_editableInitView()
	end
end

function FairyLandView:addEvents()
	return
end

function FairyLandView:removeEvents()
	return
end

return FairyLandView
