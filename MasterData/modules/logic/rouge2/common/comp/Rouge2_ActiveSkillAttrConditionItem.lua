-- chunkname: @modules/logic/rouge2/common/comp/Rouge2_ActiveSkillAttrConditionItem.lua

module("modules.logic.rouge2.common.comp.Rouge2_ActiveSkillAttrConditionItem", package.seeall)

local Rouge2_ActiveSkillAttrConditionItem = class("Rouge2_ActiveSkillAttrConditionItem", LuaCompBase)

function Rouge2_ActiveSkillAttrConditionItem.Get(go)
	return MonoHelper.addNoUpdateLuaComOnceToGo(go, Rouge2_ActiveSkillAttrConditionItem)
end

function Rouge2_ActiveSkillAttrConditionItem:init(go)
	self.go = go
	self._imageAttrIcon = gohelper.findChildImage(self.go, "image_AttrIcon")
	self._txtPreLv = gohelper.findChildText(self.go, "txt_PreLv")
	self._txtNextLv = gohelper.findChildText(self.go, "txt_NextLv")
	self._goNormalArrow = gohelper.findChild(self.go, "go_Arrow/#arrow_normal")
	self._goAddArrow = gohelper.findChild(self.go, "go_Arrow/#arrow_add")
	self._animator = gohelper.onceAddComponent(self.go, gohelper.Type_Animator)
	self._goLoopEffect = gohelper.findChild(self.go, "#effect/loop")

	gohelper.setActive(self._goAddArrow, false)
	gohelper.setActive(self._goNormalArrow, true)
	self.addEventCb(self, Rouge2_Controller.instance, Rouge2_Event.onLightAttr, self._onLightAttr, self)
end

function Rouge2_ActiveSkillAttrConditionItem:addEventListeners()
	return
end

function Rouge2_ActiveSkillAttrConditionItem:removeEventListeners()
	return
end

function Rouge2_ActiveSkillAttrConditionItem:onUpdateMO(index, conditionInfo)
	self._index = index
	self._conditionInfo = conditionInfo
	self._attrId = conditionInfo[1]
	self._attrValue = conditionInfo[2]
	self._curAttrValue = Rouge2_Model.instance:getAttrValue(self._attrId) or 0

	self:refreshUI()
end

function Rouge2_ActiveSkillAttrConditionItem:refreshUI()
	self._txtPreLv.text = self._curAttrValue
	self._txtNextLv.text = self._attrValue

	Rouge2_IconHelper.setAttributeIcon(self._attrId, self._imageAttrIcon)
	SLFramework.UGUI.GuiHelper.SetColor(self._txtPreLv, self._curAttrValue >= self._attrValue and "#73BE73" or "#D57E7E")
end

function Rouge2_ActiveSkillAttrConditionItem:_onLightAttr(lightAttrIdList)
	local isLight = lightAttrIdList and tabletool.indexOf(lightAttrIdList, self._attrId) ~= nil

	gohelper.setActive(self._goLoopEffect, isLight)
	gohelper.setActive(self._goNormalArrow, not isLight)
	gohelper.setActive(self._goAddArrow, isLight)

	if isLight then
		self._animator:Play("click", 0, 0)
	end
end

function Rouge2_ActiveSkillAttrConditionItem:onDestroy()
	return
end

return Rouge2_ActiveSkillAttrConditionItem
