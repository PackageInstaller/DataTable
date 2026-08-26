-- chunkname: @modules/logic/skin/view/SkinOffsetSkinItem.lua

module("modules.logic.skin.view.SkinOffsetSkinItem", package.seeall)

local SkinOffsetSkinItem = class("SkinOffsetSkinItem", ListScrollCellExtend)

function SkinOffsetSkinItem:onInitView()
	self.goselect = gohelper.findChild(self.viewGO, "#go_select")
	self.txtskinname = gohelper.findChildText(self.viewGO, "#txt_skinname")

	self.addEventCb(self, SkinOffsetController.instance, SkinOffsetController.Event.OnSelectSkinChange, self.refreshSelect, self)

	if self._editableInitView then
		self:_editableInitView()
	end
end

function SkinOffsetSkinItem:addEvents()
	return
end

function SkinOffsetSkinItem:removeEvents()
	return
end

function SkinOffsetSkinItem:onClick()
	if self.isSelect then
		return
	end

	SkinOffsetSkinListModel.instance:setSelectSkin(self.mo.skinId)
	AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_Universal_Click)
end

function SkinOffsetSkinItem:_editableInitView()
	self.click = gohelper.getClick(self.viewGO)

	self.click:AddClickListener(self.onClick, self)
end

function SkinOffsetSkinItem:onUpdateMO(mo)
	gohelper.setActive(self.goselect, false)

	self.txtskinname.text = mo.skinId .. "#" .. mo.skinName
	self.mo = mo

	self:refreshSelect()
end

function SkinOffsetSkinItem:getMo()
	return self.mo
end

function SkinOffsetSkinItem:refreshSelect()
	self.isSelect = SkinOffsetSkinListModel.instance:isSelect(self.mo.skinId)

	gohelper.setActive(self.goselect, self.isSelect)
end

function SkinOffsetSkinItem:onDestroyView()
	self.click:RemoveClickListener()
end

return SkinOffsetSkinItem
