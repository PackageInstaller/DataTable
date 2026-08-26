-- chunkname: @modules/logic/rouge2/common/comp/Rouge2_AttributeDetailAttrView.lua

module("modules.logic.rouge2.common.comp.Rouge2_AttributeDetailAttrView", package.seeall)

local Rouge2_AttributeDetailAttrView = class("Rouge2_AttributeDetailAttrView", BaseView)

Rouge2_AttributeDetailAttrView.PassiveSkillType = {
	Rouge2_Enum.PassiveSkillDescType.Career,
	Rouge2_Enum.PassiveSkillDescType.Fight,
	Rouge2_Enum.PassiveSkillDescType.Explore
}
Rouge2_AttributeDetailAttrView.PercentColor = "#F3A055"
Rouge2_AttributeDetailAttrView.BracketColor = "#5E7DD9"

function Rouge2_AttributeDetailAttrView:onInitView()
	self._goRoot = gohelper.findChild(self.viewGO, "#go_Root")
	self._goAttrContent = gohelper.findChild(self.viewGO, "#go_Root/#go_Content/#go_AttrContent")
	self._txtCareerDesc = gohelper.findChildText(self.viewGO, "#go_Root/#go_Content/#go_AttrContent/Viewport/Content/#go_AttrContainer/careerDesc/#txt_CareerDesc")
	self._goTagList = gohelper.findChild(self.viewGO, "#go_Root/#go_Content/#go_AttrContent/Viewport/Content/#go_AttrContainer/#go_TagList")
	self._goTagItem = gohelper.findChild(self.viewGO, "#go_Root/#go_Content/#go_AttrContent/Viewport/Content/#go_AttrContainer/#go_TagList/#go_TagItem")
	self._scrollRelics = gohelper.findChildScrollRect(self.viewGO, "#go_Root/#go_Content/#go_AttrContent/Viewport/Content/#go_AttrContainer/#scroll_Relics")
	self._goRelicsContent = gohelper.findChild(self.viewGO, "#go_Root/#go_Content/#go_AttrContent/Viewport/Content/#go_AttrContainer/#scroll_Relics/Viewport/Content")
	self._btnRelicsTips = gohelper.findChildButtonWithAudio(self.viewGO, "#go_Root/#go_Content/#go_AttrContent/Viewport/Content/#go_AttrContainer/#scroll_Relics/Viewport/#btn_RelicsTips")
	self._goSpDescList = gohelper.findChild(self.viewGO, "#go_Root/#go_Content/#go_AttrContent/Viewport/Content/#go_AttrContainer/#go_SpDescList")
	self._goSpDescItem = gohelper.findChild(self.viewGO, "#go_Root/#go_Content/#go_AttrContent/Viewport/Content/#go_AttrContainer/#go_SpDescList/#go_SpDescItem")
	self._goSpDescTitle = gohelper.findChild(self.viewGO, "#go_Root/#go_Content/#go_AttrContent/Viewport/Content/#go_AttrContainer/#go_SpDescTitle")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Rouge2_AttributeDetailAttrView:addEvents()
	self._btnRelicsTips:AddClickListener(self._btnRelicsTipsOnClick, self)
	self.addEventCb(self, Rouge2_Controller.instance, Rouge2_Event.OnSelectAttrTab, self._onSelectAttrTab, self)
end

function Rouge2_AttributeDetailAttrView:removeEvents()
	self._btnRelicsTips:RemoveClickListener()
end

function Rouge2_AttributeDetailAttrView:_btnCloseOnClick()
	self:closeThis()
end

function Rouge2_AttributeDetailAttrView:_btnRelicsTipsOnClick()
	if not self._hasAttrUpdateRelics then
		return
	end

	local showViewName = Rouge2_BackpackHelper.itemType2ShowViewName(Rouge2_Enum.BagType.Relics)

	ViewMgr.instance:openView(showViewName, {
		viewEnum = Rouge2_MapEnum.ItemDropViewEnum.Tips,
		dataType = Rouge2_Enum.ItemDataType.Config,
		itemList = self._attrUpdateRelicsIdList
	})
end

function Rouge2_AttributeDetailAttrView:_editableInitView()
	self._goRelicsItem = self:getResInst(Rouge2_Enum.ResPath.CareerAttrActiveItem, self._goRelicsContent, "#go_RelicsItem")
end

function Rouge2_AttributeDetailAttrView:onOpen()
	self._careerId = self.viewParam and self.viewParam.careerId
end

function Rouge2_AttributeDetailAttrView:refresh(groupType, subId)
	local isAttrInfo = groupType == Rouge2_Enum.AttrDetailTabGroupType.AttrList
	local isSelectSub = subId and subId ~= 0

	gohelper.setActive(self._goAttrContent, isAttrInfo and isSelectSub)

	if not isAttrInfo then
		return
	end

	self._selectAttrInfo = self.viewContainer:getAttrInfoByIndex(subId)

	self:refreshInfo()
	self:refreshUI()
end

function Rouge2_AttributeDetailAttrView:refreshInfo()
	self._selectAttrId = self._selectAttrInfo and self._selectAttrInfo.attrId
	self._selectAttrValue = self._selectAttrInfo and self._selectAttrInfo.value
	self._selectAttrCo = Rouge2_AttributeConfig.instance:getAttributeConfig(self._selectAttrId)
end

function Rouge2_AttributeDetailAttrView:refreshUI()
	self._txtCareerDesc.text = self._selectAttrCo and self._selectAttrCo.careerDesc
	self._attrDropList = Rouge2_AttributeConfig.instance:getLimitAttrDropList(self._careerId, self._selectAttrId) or {}

	gohelper.CreateObjList(self, self._refreshTagItem, Rouge2_AttributeDetailAttrView.PassiveSkillType, self._goTagList, self._goTagItem, Rouge2_AttributeDetailTagItem)
	gohelper.setActive(self._goSpDescTitle, self._attrDropList and #self._attrDropList > 0)
	gohelper.CreateObjList(self, self._refreshAttrDropDesc, self._attrDropList, self._goSpDescList, self._goSpDescItem)
	self:refreshAttrUpdateRelics()
end

function Rouge2_AttributeDetailAttrView:_refreshAttrDropDesc(obj, attrDropCo, index)
	Rouge2_AttrDropDescHelper.LoadAttrDropDesc(attrDropCo.id, obj, Rouge2_AttributeDetailAttrView.PercentColor, Rouge2_AttributeDetailAttrView.BracketColor)
end

function Rouge2_AttributeDetailAttrView:refreshAttrUpdateRelics()
	self._attrUpdateRelicsList, self._attrUpdateRelicsIdList = Rouge2_BackpackModel.instance:getAttrUpdateActiveRelicsList(self._selectAttrId, self._selectAttrValue)
	self._hasAttrUpdateRelics = self._attrUpdateRelicsList and #self._attrUpdateRelicsList > 0

	gohelper.setActive(self._scrollRelics.gameObject, self._hasAttrUpdateRelics)

	if not self._hasAttrUpdateRelics then
		return
	end

	gohelper.CreateObjList(self, self._refreshAttrUpdateRelicsItem, self._attrUpdateRelicsList, self._goRelicsContent, self._goRelicsItem, Rouge2_CareerAttributeActiveItem)
end

function Rouge2_AttributeDetailAttrView:_refreshAttrUpdateRelicsItem(activeItem, relicsInfo, index)
	activeItem:onUpdateMO(self._selectAttrValue, relicsInfo)
end

function Rouge2_AttributeDetailAttrView:_refreshAttrTabItem(tabItem, attrInfo, index)
	tabItem:onUpdateMO(self._careerId, attrInfo, self._selectAttrInfo == attrInfo)
end

function Rouge2_AttributeDetailAttrView:_refreshTagItem(tagItem, descType, index)
	tagItem:onUpdateMO(self._careerId, self._selectAttrInfo, descType)
end

function Rouge2_AttributeDetailAttrView:_onSelectAttrTab(groupType, subId)
	self:refresh(groupType, subId)
end

function Rouge2_AttributeDetailAttrView:onClose()
	return
end

function Rouge2_AttributeDetailAttrView:onDestroyView()
	return
end

return Rouge2_AttributeDetailAttrView
