-- chunkname: @modules/logic/signin/view/SigninPropItem.lua

module("modules.logic.signin.view.SigninPropItem", package.seeall)

local SigninPropItem = class("SigninPropItem", ListScrollCellExtend)

function SigninPropItem:onInitView()
	self._goicon = gohelper.findChild(self.viewGO, "#go_icon")
	self._gotag = gohelper.findChild(self.viewGO, "#go_icontag")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function SigninPropItem:addEvents()
	return
end

function SigninPropItem:removeEvents()
	return
end

function SigninPropItem:onUpdateMO(mo)
	self.itemIcon = IconMgr.instance:getCommonPropListItemIcon(self._goicon)
	self.itemIcon._index = self._index

	self.itemIcon:onUpdateMO(mo)

	if mo.getApproach then
		local tag = IconMgr.instance:getCommonIconTag(self._gotag)

		tag:showTag(mo.getApproach)
	end
end

return SigninPropItem
