-- chunkname: @modules/logic/rouge2/outside/view/finish/Rouge2_ResultUnlockInfoView.lua

module("modules.logic.rouge2.outside.view.finish.Rouge2_ResultUnlockInfoView", package.seeall)

local Rouge2_ResultUnlockInfoView = class("Rouge2_ResultUnlockInfoView", BaseView)

function Rouge2_ResultUnlockInfoView:onInitView()
	self._simagefullbg = gohelper.findChildSingleImage(self.viewGO, "#simage_fullbg")
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_close")
	self._scrollGet = gohelper.findChildScrollRect(self.viewGO, "#scroll_Get")
	self._goRoot = gohelper.findChild(self.viewGO, "#scroll_Get/Viewport/Content/#go_Root")
	self._txttitle = gohelper.findChildText(self.viewGO, "#scroll_Get/Viewport/Content/#go_Root/title/#txt_title")
	self._goitem = gohelper.findChild(self.viewGO, "#scroll_Get/Viewport/Content/#go_Root/layout/#go_item")
	self._imagebg = gohelper.findChildImage(self.viewGO, "#scroll_Get/Viewport/Content/#go_Root/layout/#go_item/#image_bg")
	self._simageicon = gohelper.findChildSingleImage(self.viewGO, "#scroll_Get/Viewport/Content/#go_Root/layout/#go_item/#simage_icon")
	self._gotopleft = gohelper.findChild(self.viewGO, "#go_topleft")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Rouge2_ResultUnlockInfoView:addEvents()
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
end

function Rouge2_ResultUnlockInfoView:removeEvents()
	self._btnclose:RemoveClickListener()
end

function Rouge2_ResultUnlockInfoView:_btncloseOnClick()
	self:closeThis()
end

function Rouge2_ResultUnlockInfoView:_editableInitView()
	self._groupItemList = {}

	gohelper.setActive(self._goRoot, false)
end

function Rouge2_ResultUnlockInfoView:onUpdateParam()
	return
end

function Rouge2_ResultUnlockInfoView:onOpen()
	self.resultInfo = Rouge2_Model.instance:getRougeResult()

	self:refreshUI()
end

function Rouge2_ResultUnlockInfoView:refreshUI()
	local unlockCollectionList = Rouge2_OutsideModel.instance:getNewUnlockCollectionList()
	local unlockFormulaList = Rouge2_AlchemyModel.instance:getNewUnlockFormula()
	local moList = {}

	if #unlockCollectionList > 0 then
		local mo = {}

		mo.type = Rouge2_OutsideEnum.CollectionType.Collection
		mo.itemList = unlockCollectionList

		table.insert(moList, mo)
	end

	if #unlockFormulaList > 0 then
		local mo = {}

		mo.type = Rouge2_OutsideEnum.CollectionType.Formula
		mo.itemList = unlockFormulaList

		table.insert(moList, mo)
	end

	self:refreshGroupItem(moList)
end

function Rouge2_ResultUnlockInfoView:refreshGroupItem(moList)
	for index, mo in ipairs(moList) do
		local groupItem = self:getGroupItem(index)

		groupItem:setInfo(mo)
	end
end

function Rouge2_ResultUnlockInfoView:getGroupItem(index)
	if not self._groupItemList[index] then
		local go = gohelper.cloneInPlace(self._goRoot)
		local item = MonoHelper.addNoUpdateLuaComOnceToGo(go, Rouge2_ResultUnlockInfoGroupItem)

		table.insert(self._groupItemList, item)
		gohelper.setActive(go, true)

		return item
	end

	return self._groupItemList[index]
end

function Rouge2_ResultUnlockInfoView:onClose()
	return
end

function Rouge2_ResultUnlockInfoView:onDestroyView()
	return
end

return Rouge2_ResultUnlockInfoView
