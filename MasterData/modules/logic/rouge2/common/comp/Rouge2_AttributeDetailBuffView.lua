-- chunkname: @modules/logic/rouge2/common/comp/Rouge2_AttributeDetailBuffView.lua

module("modules.logic.rouge2.common.comp.Rouge2_AttributeDetailBuffView", package.seeall)

local Rouge2_AttributeDetailBuffView = class("Rouge2_AttributeDetailBuffView", BaseView)

function Rouge2_AttributeDetailBuffView:onInitView()
	self._goBuffContent = gohelper.findChild(self.viewGO, "#go_Root/#go_Content/#go_BuffContent")
	self._goBuffList = gohelper.findChild(self.viewGO, "#go_Root/#go_Content/#go_BuffContent/Viewport/Content/#go_BuffContainer/#go_BuffList")
	self._goBuffItem = gohelper.findChild(self.viewGO, "#go_Root/#go_Content/#go_BuffContent/Viewport/Content/#go_BuffContainer/#go_BuffList/#go_BuffItem")
	self._goEmptyBuff = gohelper.findChild(self.viewGO, "#go_Root/#go_Content/#go_BuffContent/Viewport/Content/#go_BuffContainer/#go_EmptyBuff")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Rouge2_AttributeDetailBuffView:addEvents()
	self.addEventCb(self, Rouge2_Controller.instance, Rouge2_Event.OnSelectAttrTab, self._onSelectAttrTab, self)
end

function Rouge2_AttributeDetailBuffView:removeEvents()
	return
end

function Rouge2_AttributeDetailBuffView:_editableInitView()
	return
end

function Rouge2_AttributeDetailBuffView:onOpen()
	self._careerId = self.viewParam and self.viewParam.careerId
end

function Rouge2_AttributeDetailBuffView:refresh(groupType, subId)
	local isOverview = groupType == Rouge2_Enum.AttrDetailTabGroupType.Overview

	gohelper.setActive(self._goBuffContent, isOverview)

	if not isOverview then
		return
	end

	self:refreshInfo()
end

function Rouge2_AttributeDetailBuffView:refreshInfo()
	self._hasAttrBUff = false
	self._attrInfoList = {}

	if self.viewParam then
		for _, attrInfo in ipairs(self.viewParam or {}) do
			table.insert(self._attrInfoList, attrInfo)
		end

		table.sort(self._attrInfoList, self._attrInfoSortFunc)
		gohelper.CreateObjList(self, self._refreshAttrItem, self._attrInfoList, self._goBuffList, self._goBuffItem)
		gohelper.setActive(self._goBuffList, self._hasAttrBUff)
		gohelper.setActive(self._goEmptyBuff, not self._hasAttrBUff)
	end
end

function Rouge2_AttributeDetailBuffView._attrInfoSortFunc(aAttrInfo, bAttrInfo)
	if not aAttrInfo.value then
		if not bAttrInfo.value then
			local bAttrValue = 0

			if aAttrInfo.value ~= bAttrValue then
				return bAttrValue < aAttrInfo.value
			end

			return aAttrInfo.attrId < bAttrInfo.attrId
		end
	end
end

function Rouge2_AttributeDetailBuffView:_refreshAttrItem(obj, attrInfo, index)
	local attrId = attrInfo.attrId
	local attrBuffList = Rouge2_AttrDropController.instance:getAttrBuffList(attrId)

	if attrBuffList then
		if not #attrBuffList then
			local attrBuffNum = 0

			gohelper.setActive(obj, attrBuffNum > 0)

			if attrBuffNum <= 0 then
				return
			end

			self._hasAttrBUff = true

			local attrValue = attrInfo.value
			local attrCo = Rouge2_AttributeConfig.instance:getAttributeConfig(attrId)

			if attrCo then
				if not attrCo.name then
					local attrName = ""
					local txtAttrTitle = gohelper.findChildText(obj, "banner/txt_AttrTitle")
					local txtSpLevel = gohelper.findChildText(obj, "banner/txt_AttrTitle/txt_SpLevel")
					local imageAttr = gohelper.findChildImage(obj, "banner/image_Attr")

					txtAttrTitle.text = GameUtil.getSubPlaceholderLuaLangTwoParam(luaLang("rouge2_attributedetailview_attrtabitem"), attrName, attrValue)

					Rouge2_IconHelper.setAttributeIcon(attrId, imageAttr)
					Rouge2_AttrDropDescHelper.loadAttrDropLevelList(self._careerId, attrId, txtSpLevel)

					local goBuffDescList = gohelper.findChild(obj, "go_BuffDescList")
					local goBuffDescItem = gohelper.findChild(obj, "go_BuffDescList/go_BuffDescItem")

					gohelper.CreateObjList(self, self._refreshAttrBuffDesc, attrBuffList, goBuffDescList, goBuffDescItem)
				end
			end
		end
	end
end

function Rouge2_AttributeDetailBuffView:_refreshAttrBuffDesc(obj, itemMo, index)
	local txtDesc = gohelper.findChildText(obj, "txt_Desc")
	local imageRare = gohelper.findChildImage(obj, "txt_Desc/image_Icon")
	local descStr = Rouge2_ItemDescHelper.getItemDescStr(Rouge2_Enum.ItemDataType.Server, itemMo:getUid())
	local itemCo = itemMo and itemMo:getConfig()

	if itemCo then
		if not itemCo.name then
			local itemName = ""
			local result = GameUtil.getSubPlaceholderLuaLang(luaLang("rouge2_careerattributetipsview_attrbuff"), {
				itemName,
				descStr
			})

			Rouge2_ItemDescHelper.buildAndSetDesc(txtDesc, result)
			Rouge2_IconHelper.setGameItemRare(itemCo.id, imageRare)
		end
	end
end

function Rouge2_AttributeDetailBuffView:_onSelectAttrTab(groupType, subId)
	self:refresh(groupType, subId)
end

function Rouge2_AttributeDetailBuffView:onClose()
	return
end

function Rouge2_AttributeDetailBuffView:onDestroyView()
	return
end

return Rouge2_AttributeDetailBuffView
