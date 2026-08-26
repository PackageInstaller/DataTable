-- chunkname: @modules/logic/versionactivity2_1/aergusi/view/AergusiClueView.lua

module("modules.logic.versionactivity2_1.aergusi.view.AergusiClueView", package.seeall)

local AergusiClueView = class("AergusiClueView", BaseView)

function AergusiClueView:onInitView()
	self._simagefullbg = gohelper.findChildSingleImage(self.viewGO, "#simage_fullbg")
	self._simagenotebg = gohelper.findChildSingleImage(self.viewGO, "Right/#simage_notebg")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function AergusiClueView:addEvents()
	return
end

function AergusiClueView:removeEvents()
	return
end

function AergusiClueView:_editableInitView()
	self:_addEvents()
end

function AergusiClueView:onUpdateParam()
	return
end

function AergusiClueView:onOpen()
	return
end

function AergusiClueView:_addEvents()
	return
end

function AergusiClueView:_removeEvents()
	return
end

function AergusiClueView:onClose()
	return
end

function AergusiClueView:onDestroyView()
	self:_removeEvents()
end

return AergusiClueView
