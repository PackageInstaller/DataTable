-- chunkname: @modules/logic/rouge2/backpack/view/Rouge2_BackpackSkillShowItem.lua

module("modules.logic.rouge2.backpack.view.Rouge2_BackpackSkillShowItem", package.seeall)

local Rouge2_BackpackSkillShowItem = class("Rouge2_BackpackSkillShowItem", Rouge2_BackpackSkillShowItemBase)

Rouge2_BackpackSkillShowItem.PercentColor = "#F3A055"
Rouge2_BackpackSkillShowItem.BracketColor = "#60A0FE"

function Rouge2_BackpackSkillShowItem:init(go)
	Rouge2_BackpackSkillShowItem.super.init(self, go)

	self._goEmpty = gohelper.findChild(self.go, "#go_Empty")
	self._goEmptyEffect = gohelper.findChild(self.go, "#go_Empty/add_eff")
	self._goTips1 = gohelper.findChild(self.go, "#go_Empty/#go_Tips1")
	self._goTips2 = gohelper.findChild(self.go, "#go_Empty/#go_Tips2")
	self._goUnEmpty = gohelper.findChild(self.go, "#go_UnEmpty")
	self._simageSkillIcon = gohelper.findChildSingleImage(self.go, "#go_UnEmpty/#image_SkillIcon")
	self._goSelected = gohelper.findChild(self.go, "#go_Selected")
	self._txtSkillName = gohelper.findChildText(self.go, "#go_UnEmpty/#go_Skill/#txt_SkillName")
	self._imageAttribute = gohelper.findChildImage(self.go, "#go_UnEmpty/#go_Skill/#txt_SkillName/#image_Icon")
	self._goAssemblyList = gohelper.findChild(self.go, "#go_UnEmpty/Capacity/#go_AssemblyList")
	self._goAssemblyItem = gohelper.findChild(self.go, "#go_UnEmpty/Capacity/#go_AssemblyList/#go_AssemblyItem")
	self._scrollDesc = gohelper.findChild(self.go, "#go_UnEmpty/Scroll View"):GetComponent(gohelper.Type_LimitedScrollRect)
	self._txtDescr = gohelper.findChildText(self.go, "#go_UnEmpty/Scroll View/Viewport/#txt_Descr")

	SkillHelper.addHyperLinkClick(self._txtDescr)

	self._listener = Rouge2_CommonItemDescModeListener.Get(self.go, Rouge2_Enum.ItemDescModeDataKey.BackpackSkill)

	self._listener:initCallback(self._refreshItemDesc, self)
end

function Rouge2_BackpackSkillShowItem:addEventListeners()
	Rouge2_BackpackSkillShowItem.super.addEventListeners(self)
end

function Rouge2_BackpackSkillShowItem:removeEventListeners()
	Rouge2_BackpackSkillShowItem.super.removeEventListeners(self)
end

function Rouge2_BackpackSkillShowItem:refreshEmptyUI()
	self:refreshEmptyTips()
end

function Rouge2_BackpackSkillShowItem:refreshEquipUI()
	self._skillCo = Rouge2_CollectionConfig.instance:getActiveSkillConfig(self._skillId)
	self._txtSkillName.text = self._skillCo and self._skillCo.name

	self._listener:startListen()

	if self._skillCo then
		if not self._skillCo.assembleCost then
			local assemblyNum = 0

			gohelper.CreateNumObjList(self._goAssemblyList, self._goAssemblyItem, assemblyNum, self._refreshAssemblyItem, self)
			Rouge2_IconHelper.setActiveSkillIcon(self._skillId, self._simageSkillIcon)
			self:refreshAttrIcon()
		end
	end
end

function Rouge2_BackpackSkillShowItem:_refreshItemDesc(descMode)
	Rouge2_ItemDescHelper.setItemDescStr(Rouge2_Enum.ItemDataType.Server, self._skillUid, self._txtDescr, descMode, nil, Rouge2_BackpackSkillShowItem.PercentColor, Rouge2_BackpackSkillShowItem.BracketColor)
end

function Rouge2_BackpackSkillShowItem:refreshAttrIcon()
	local attrId = self._skillCo.attributeTag
	local isUseBXS = Rouge2_Model.instance:isUseBXSCareer()

	gohelper.setActive(self._imageAttribute.gameObject, not isUseBXS)

	if isUseBXS then
		return
	end

	Rouge2_IconHelper.setAttributeIcon(attrId, self._imageAttribute)
end

function Rouge2_BackpackSkillShowItem:refreshEmptyTips()
	local skillList = Rouge2_BackpackModel.instance:getItemList(Rouge2_Enum.BagType.ActiveSkill)
	local hasAnySkillEquip = skillList and #skillList > Rouge2_Enum.MaxActiveSkillNum

	gohelper.setActive(self._goTips1, not hasAnySkillEquip)
	gohelper.setActive(self._goTips2, hasAnySkillEquip)
	gohelper.setActive(self._goEmptyEffect, hasAnySkillEquip)
end

function Rouge2_BackpackSkillShowItem:_refreshAssemblyItem(obj, index)
	local goType1 = gohelper.findChild(obj, "go_Type1")
	local goType2 = gohelper.findChild(obj, "go_Type2")
	local useType1 = index % 2 ~= 0

	gohelper.setActive(goType1, useType1)
	gohelper.setActive(goType2, not useType1)
end

function Rouge2_BackpackSkillShowItem:setScrollParentGO(goParentScroll)
	self._scrollDesc.parentGameObject = goParentScroll
end

function Rouge2_BackpackSkillShowItem:onDestroy()
	self._simageSkillIcon:UnLoadImage()
end

return Rouge2_BackpackSkillShowItem
