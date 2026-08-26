-- chunkname: @modules/logic/rouge2/common/comp/Rouge2_AttributeDetailTagItem.lua

module("modules.logic.rouge2.common.comp.Rouge2_AttributeDetailTagItem", package.seeall)

local Rouge2_AttributeDetailTagItem = class("Rouge2_AttributeDetailTagItem", LuaCompBase)

function Rouge2_AttributeDetailTagItem:init(go)
	self.go = go
	self._txtTagTitle = gohelper.findChildText(self.go, "go_TagTitle/txt_TagTitle")
	self._goDescList = gohelper.findChild(self.go, "go_DescList")
	self._goDescItem = gohelper.findChild(self.go, "go_DescList/go_DescItem")
end

function Rouge2_AttributeDetailTagItem:addEventListeners()
	return
end

function Rouge2_AttributeDetailTagItem:removeEventListeners()
	return
end

function Rouge2_AttributeDetailTagItem:onUpdateMO(careerId, attrInfo, descType)
	self._descType = descType
	self._careerId = careerId
	self._attrId = attrInfo and attrInfo.attrId
	self._attrValue = attrInfo and attrInfo.value
	self._careerCo = Rouge2_CareerConfig.instance:getCareerConfig(self._careerId)
	self._attrCo = Rouge2_AttributeConfig.instance:getAttributeConfig(self._attrId)
	self._descList = Rouge2_AttributeConfig.instance:getPassiveSkillDescListByType(self._careerId, self._attrId, self._attrValue, self._descType)

	if self._descList then
		self._descNum = #self._descList or 0
	end

	self._hasDesc = self._descNum > 0

	gohelper.setActive(self.go, self._hasDesc)

	if not self._hasDesc then
		return
	end

	self:refreshTagTitle()
	gohelper.CreateObjList(self, self._refreshDescItem, self._descList, self._goDescList, self._goDescItem)
end

function Rouge2_AttributeDetailTagItem:refreshTagTitle()
	local langId = Rouge2_Enum.PassiveSkillDescType2LangId[self._descType]

	self._txtTagTitle.text = self._descType == Rouge2_Enum.PassiveSkillDescType.Career and GameUtil.getSubPlaceholderLuaLangOneParam(luaLang(langId), self._careerCo.name) or luaLang(langId)
end

function Rouge2_AttributeDetailTagItem:_refreshDescItem(obj, desc, index)
	local txtDesc = gohelper.findChildText(obj, "txt_Desc")

	txtDesc.text = Rouge2_ItemDescHelper.buildDesc(desc, Rouge2_AttributeDetailView.PercentColor, Rouge2_AttributeDetailView.BracketColor)

	SkillHelper.addHyperLinkClick(txtDesc)
end

return Rouge2_AttributeDetailTagItem
