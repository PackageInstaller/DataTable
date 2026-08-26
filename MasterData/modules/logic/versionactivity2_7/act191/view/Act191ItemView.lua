-- chunkname: @modules/logic/versionactivity2_7/act191/view/Act191ItemView.lua

module("modules.logic.versionactivity2_7.act191.view.Act191ItemView", package.seeall)

local Act191ItemView = class("Act191ItemView", BaseView)

function Act191ItemView:onInitView()
	self._goRoot = gohelper.findChild(self.viewGO, "#go_Root")
	self._imageRare = gohelper.findChildImage(self.viewGO, "#go_Root/#image_Rare")
	self._imageIcon = gohelper.findChildImage(self.viewGO, "#go_Root/#image_Icon")
	self._txtName = gohelper.findChildText(self.viewGO, "#go_Root/#txt_Name")
	self._txtDesc = gohelper.findChildText(self.viewGO, "#go_Root/scroll_desc/Viewport/go_desccontent/#txt_Desc")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Act191ItemView:onClickModalMask()
	self:closeThis()
end

function Act191ItemView:onOpen()
	self.config = self.viewParam

	if self.config.rare ~= 0 then
		UISpriteSetMgr.instance:setAct174Sprite(self._imageRare, "act174_roleframe_" .. self.config.rare)
	end

	gohelper.setActive(self._imageRare, self.config.rare ~= 0)
	UISpriteSetMgr.instance:setAct174Sprite(self._imageIcon, self.config.icon)

	self._txtName.text = self.config.name
	self._txtDesc.text = self.config.desc

	if self.config.id == 1001 then
		transformhelper.setLocalScale(self._imageIcon.gameObject.transform, 0.75, 0.75, 1)
	end
end

return Act191ItemView
