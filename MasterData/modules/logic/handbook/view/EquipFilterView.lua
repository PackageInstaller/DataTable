-- chunkname: @modules/logic/handbook/view/EquipFilterView.lua

module("modules.logic.handbook.view.EquipFilterView", package.seeall)

local EquipFilterView = class("EquipFilterView", BaseView)

function EquipFilterView:onInitView()
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_close")
	self._goobtain = gohelper.findChild(self.viewGO, "container/layoutgroup/#go_obtain")
	self._goget = gohelper.findChild(self.viewGO, "container/layoutgroup/#go_obtain/obtainContainer/#go_get")
	self._gonotget = gohelper.findChild(self.viewGO, "container/layoutgroup/#go_obtain/obtainContainer/#go_notget")
	self._goTag = gohelper.findChild(self.viewGO, "container/layoutgroup/#go_tag")
	self._goTagContainer = gohelper.findChild(self.viewGO, "container/layoutgroup/#go_tag/#go_tagContainer")
	self._gotagItem = gohelper.findChild(self.viewGO, "container/layoutgroup/#go_tag/#go_tagContainer/#go_tagItem")
	self._btnreset = gohelper.findChildButtonWithAudio(self.viewGO, "container/#btn_reset")
	self._btnconfirm = gohelper.findChildButtonWithAudio(self.viewGO, "container/#btn_confirm")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function EquipFilterView:addEvents()
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
	self._btnreset:AddClickListener(self._btnresetOnClick, self)
	self._btnconfirm:AddClickListener(self._btnconfirmOnClick, self)
end

function EquipFilterView:removeEvents()
	self._btnclose:RemoveClickListener()
	self._btnreset:RemoveClickListener()
	self._btnconfirm:RemoveClickListener()
end

EquipFilterView.Color = {
	SelectColor = Color.New(1, 0.486, 0.25, 1),
	NormalColor = Color.New(0.898, 0.898, 0.898, 1)
}

function EquipFilterView:_btncloseOnClick()
	self:closeThis()
end

function EquipFilterView:_btnresetOnClick()
	self.filterMo:reset()
	self:refreshUI()
end

function EquipFilterView:_btnconfirmOnClick()
	EquipFilterModel.instance:applyMo(self.filterMo)
	self:closeThis()
end

function EquipFilterView:_editableInitView()
	gohelper.setActive(self._gotagItem, false)
end

function EquipFilterView:initObtainItem()
	if not self.obtainItemGet then
		self.obtainItemGet = self:createObtainItem(self._goget)
		self.obtainItemGet.type = EquipFilterModel.ObtainEnum.Get
	end

	if not self.obtainItemNotGet then
		self.obtainItemNotGet = self:createObtainItem(self._gonotget)
		self.obtainItemNotGet.type = EquipFilterModel.ObtainEnum.NotGet
	end
end

function EquipFilterView:createObtainItem(go)
	local obtainItem = self:getUserDataTb_()

	obtainItem.go = go
	obtainItem.goUnSelect = gohelper.findChild(obtainItem.go, "unselected")
	obtainItem.goSelect = gohelper.findChild(obtainItem.go, "selected")
	obtainItem.btnClick = gohelper.findChildClick(obtainItem.go, "click")

	obtainItem.btnClick:AddClickListener(self.onClickObtainTypeItem, self, obtainItem)

	return obtainItem
end

function EquipFilterView:initTagItem()
	if self.tagItemList then
		return
	end

	self.tagItemList = {}

	local tagItem

	for _, tagCo in ipairs(EquipFilterModel.getAllTagList()) do
		tagItem = self:createTypeItem()
		tagItem.tagCo = tagCo

		gohelper.setActive(tagItem.go, true)

		tagItem.tagText.text = tagCo.name

		table.insert(self.tagItemList, tagItem)
	end
end

function EquipFilterView:createTypeItem()
	local tagItem = self:getUserDataTb_()

	tagItem.go = gohelper.cloneInPlace(self._gotagItem)
	tagItem.tagText = gohelper.findChildText(tagItem.go, "tagText")
	tagItem.goSelect = gohelper.findChild(tagItem.go, "selected")
	tagItem.goUnSelect = gohelper.findChild(tagItem.go, "unselected")
	tagItem.btnClick = gohelper.findChildClickWithAudio(tagItem.go, "click", AudioEnum.UI.UI_Common_Click)

	tagItem.btnClick:AddClickListener(self.onClickTagItem, self, tagItem)

	return tagItem
end

function EquipFilterView:onClickTagItem(tagItem)
	if self:isSelectTag(tagItem.tagCo.id) then
		tabletool.removeValue(self.filterMo.selectTagList, tagItem.tagCo.id)
	else
		table.insert(self.filterMo.selectTagList, tagItem.tagCo.id)
	end

	self:refreshTagIsSelect(tagItem)
end

function EquipFilterView:onClickObtainTypeItem(obtainItem)
	self.filterMo.obtainShowType = self.filterMo.obtainShowType == obtainItem.type and EquipFilterModel.ObtainEnum.All or obtainItem.type

	self:refreshObtainTypeUIContainer()
end

function EquipFilterView:initViewParam()
	self.isNotShowObtain = self.viewContainer.viewParam and self.viewContainer.viewParam.isNotShowObtain
	self.parentViewName = self.viewContainer.viewParam and self.viewContainer.viewParam.viewName
end

function EquipFilterView:onOpen()
	self:initViewParam()

	self.filterMo = EquipFilterModel.instance:getFilterMo(self.parentViewName):clone()

	if self.isNotShowObtain then
		gohelper.setActive(self._goobtain, false)
	else
		gohelper.setActive(self._goobtain, true)
		self:initObtainItem()
	end

	self:initTagItem()
	self:refreshUI()
end

function EquipFilterView:refreshUI()
	if not self.isNotShowObtain then
		self:refreshObtainTypeUIContainer()
	end

	self:refreshTagUIContainer()
end

function EquipFilterView:refreshObtainTypeUIContainer()
	self:refreshObtainTypeItemIsSelect(self.obtainItemGet)
	self:refreshObtainTypeItemIsSelect(self.obtainItemNotGet)
end

function EquipFilterView:refreshTagUIContainer()
	for _, tagItem in ipairs(self.tagItemList) do
		self:refreshTagIsSelect(tagItem)
	end
end

function EquipFilterView:refreshObtainTypeItemIsSelect(obtainItem)
	local isSelect = self.filterMo.obtainShowType == obtainItem.type

	gohelper.setActive(obtainItem.goSelect, isSelect)
	gohelper.setActive(obtainItem.goUnSelect, not isSelect)
end

function EquipFilterView:refreshTagIsSelect(tagItem)
	local isSelect = self:isSelectTag(tagItem.tagCo.id)

	gohelper.setActive(tagItem.goSelect, isSelect)
	gohelper.setActive(tagItem.goUnSelect, not isSelect)

	if isSelect then
		tagItem.tagText.color = EquipFilterView.Color.SelectColor or EquipFilterView.Color.NormalColor
	end
end

function EquipFilterView:isSelectTag(tagId)
	return next(self.filterMo.selectTagList) and tabletool.indexOf(self.filterMo.selectTagList, tagId)
end

function EquipFilterView:onClose()
	return
end

function EquipFilterView:onDestroyView()
	for _, tagItem in ipairs(self.tagItemList) do
		tagItem.btnClick:RemoveClickListener()
	end

	if not self.isNotShowObtain then
		self.obtainItemGet.btnClick:RemoveClickListener()
		self.obtainItemNotGet.btnClick:RemoveClickListener()
	end
end

return EquipFilterView
