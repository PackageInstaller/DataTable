-- chunkname: @modules/logic/rouge2/common/comp/Rouge2_AttributeToolBarItem.lua

module("modules.logic.rouge2.common.comp.Rouge2_AttributeToolBarItem", package.seeall)

local Rouge2_AttributeToolBarItem = class("Rouge2_AttributeToolBarItem", LuaCompBase)

Rouge2_AttributeToolBarItem.TipPosOffset = Vector2(0, 450)

function Rouge2_AttributeToolBarItem:init(go)
	self.go = go
	self._imageIcon = gohelper.findChildImage(self.go, "#image_Icon")
	self._txtValue = gohelper.findChildText(self.go, "layout/#txt_Value")
	self._goArrow = gohelper.findChild(self.go, "layout/#go_Arrow")
	self._goNormalArrow = gohelper.findChild(self.go, "layout/#go_Arrow/#arrow_normal")
	self._goAddArrow = gohelper.findChild(self.go, "layout/#go_Arrow/#arrow_add")
	self._txtNextValue = gohelper.findChildText(self.go, "layout/#txt_NextValue")
	self._goMax = gohelper.findChild(self.go, "layout/#go_Max")
	self._goRecommend = gohelper.findChild(self.go, "#go_Recommand")
	self._btnClick = gohelper.findChildButtonWithAudio(self.go, "#btn_Click")
	self._animator = gohelper.onceAddComponent(self.go, gohelper.Type_Animator)
	self._goLoopEffect = gohelper.findChild(self.go, "#effect/loop")
	self._goImportant = gohelper.findChild(self.go, "#go_Important")
	self._attrDropIndex = tonumber(lua_rouge2_const.configDict[Rouge2_MapEnum.ConstKey.AttrSpSkillIndex].value)

	gohelper.setActive(self._goAddArrow, false)
	gohelper.setActive(self._goNormalArrow, true)
end

function Rouge2_AttributeToolBarItem:addEventListeners()
	self._btnClick:AddClickListener(self._btnClickOnClick, self)
	self.addEventCb(self, Rouge2_Controller.instance, Rouge2_Event.onLightAttr, self._onLightAttr, self)
end

function Rouge2_AttributeToolBarItem:removeEventListeners()
	self._btnClick:RemoveClickListener()
end

function Rouge2_AttributeToolBarItem:_btnClickOnClick()
	local clickPos = GamepadController.instance:getMousePosition()

	Rouge2_ViewHelper.openCareerAttributeTipsView(self._careerId, self._attrId, self._attrValue, clickPos, Rouge2_AttributeToolBarItem.TipPosOffset)
end

function Rouge2_AttributeToolBarItem:refresh(index, careerId, attributeMo)
	self._index = index
	self._careerId = careerId
	self._mo = attributeMo
	self._attrId = attributeMo.attrId
	self._attrValue = attributeMo.value or 0
	self._attrCo = Rouge2_AttributeConfig.instance:getAttributeConfig(self._attrId)
	self._difficulty = Rouge2_Model.instance:getDifficulty()
	self._minAttrValue, self._maxAttrValue = Rouge2_BackpackController.instance:getAttrValueRange(self._difficulty, self._attrId)
	self._isMax = self._attrValue >= self._maxAttrValue
	self._isRecommend = Rouge2_BackpackController.instance:isAttrRecommend(self._careerId, self._attrId)
	self._nextAttrDropCo = Rouge2_AttributeConfig.instance:getNextAttrDropConfig(self._careerId, self._attrId, self._attrValue, self._difficulty)
	self._nextAttrDropLv = self._nextAttrDropCo and self._nextAttrDropCo.needNum
	self._indexDropCo = Rouge2_AttributeConfig.instance:getIndexAttrDropConfig(self._careerId, self._attrId, self._attrDropIndex)
	self._isIndexOver = self._indexDropCo and self._indexDropCo.needNum <= self._attrValue

	self:refreshUI()
end

function Rouge2_AttributeToolBarItem:refreshUI()
	self._txtValue.text = self._attrValue
	self._txtNextValue.text = self._nextAttrDropLv or self._attrValue

	local hasNextAttrDrop = self._nextAttrDropCo ~= nil

	gohelper.setActive(self._goArrow, hasNextAttrDrop)
	gohelper.setActive(self._txtNextValue.gameObject, hasNextAttrDrop)
	gohelper.setActive(self._goMax, self._isMax)
	gohelper.setActive(self._goRecommend, self._isRecommend)
	gohelper.setActive(self._goImportant, false)
	Rouge2_IconHelper.setAttributeIcon(self._attrId, self._imageIcon)
end

function Rouge2_AttributeToolBarItem:_onLightAttr(lightAttrIdList)
	local isLight = lightAttrIdList and tabletool.indexOf(lightAttrIdList, self._attrId) ~= nil

	gohelper.setActive(self._goLoopEffect, isLight)
	gohelper.setActive(self._goNormalArrow, not isLight)
	gohelper.setActive(self._goAddArrow, isLight)

	if isLight then
		self._animator:Play("click", 0, 0)
	end
end

function Rouge2_AttributeToolBarItem:onDestroy()
	return
end

return Rouge2_AttributeToolBarItem
