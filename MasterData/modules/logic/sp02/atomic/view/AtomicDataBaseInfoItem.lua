-- chunkname: @modules/logic/sp02/atomic/view/AtomicDataBaseInfoItem.lua

module("modules.logic.sp02.atomic.view.AtomicDataBaseInfoItem", package.seeall)

local AtomicDataBaseInfoItem = class("AtomicDataBaseInfoItem", ListScrollCellExtend)

function AtomicDataBaseInfoItem:onInitView()
	self.txtTitle = gohelper.findChildTextMesh(self.viewGO, "namebg/#txt_name")
	self.simagePicture = gohelper.findChildSingleImage(self.viewGO, "#Image_picture")
	self.txtDesc = gohelper.findChildTextMesh(self.viewGO, "#scroll_descr/Viewport/#txt_desc")
end

function AtomicDataBaseInfoItem:addEvents()
	return
end

function AtomicDataBaseInfoItem:removeEvents()
	return
end

function AtomicDataBaseInfoItem:onUpdateMO(mo)
	self._mo = mo

	self:refreshView(self._mo)
end

function AtomicDataBaseInfoItem:refreshView(data)
	local config = data and data.config

	gohelper.setActive(self.viewGO, config ~= nil)

	if not config then
		return
	end

	self.txtTitle.text = config.title
	self.txtDesc.text = config.content

	self.simagePicture:LoadImage(string.format("singlebg/sp02_atomicforyou/%s.png", config.detail))
end

function AtomicDataBaseInfoItem:onDestroyView()
	if self.simagePicture then
		self.simagePicture:UnLoadImage()
	end
end

return AtomicDataBaseInfoItem
