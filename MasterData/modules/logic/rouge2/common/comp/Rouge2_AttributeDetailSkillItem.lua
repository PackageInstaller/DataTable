-- chunkname: @modules/logic/rouge2/common/comp/Rouge2_AttributeDetailSkillItem.lua

module("modules.logic.rouge2.common.comp.Rouge2_AttributeDetailSkillItem", package.seeall)

local Rouge2_AttributeDetailSkillItem = class("Rouge2_AttributeDetailSkillItem", LuaCompBase)

function Rouge2_AttributeDetailSkillItem.Get(go)
	return MonoHelper.addNoUpdateLuaComOnceToGo(go, Rouge2_AttributeDetailSkillItem)
end

function Rouge2_AttributeDetailSkillItem:init(go)
	self.go = go
	self._goRoot = gohelper.findChild(self.go, "go_Root")
end

function Rouge2_AttributeDetailSkillItem:addEventListeners()
	self.addEventCb(self, Rouge2_Controller.instance, Rouge2_Event.OnSelectSkillAttrUpdate, self._onSelectSkillItem, self)
end

function Rouge2_AttributeDetailSkillItem:initParentView(parentView)
	if not self._skillAttrUpItem then
		local goAttrUpItem = parentView:getResInst(Rouge2_Enum.ResPath.ActiveSkillAttrUpdateItem, self._goRoot)

		self._skillAttrUpItem = Rouge2_ActiveSkillAttrUpdateItem.Get(goAttrUpItem)

		self._skillAttrUpItem:initClickCallback(self._clickCallback, self)
	end
end

function Rouge2_AttributeDetailSkillItem:onUpdateMO(index, dataType, dataId)
	self._index = index
	self._dataType = dataType
	self._dataId = dataId

	self._skillAttrUpItem:onUpdateMO(index, dataType, dataId)
end

function Rouge2_AttributeDetailSkillItem:_clickCallback()
	if self._isSelect then
		return
	end

	Rouge2_Controller.instance:dispatchEvent(Rouge2_Event.OnSelectSkillAttrUpdate, self._index)
end

function Rouge2_AttributeDetailSkillItem:onSelect(isSelect)
	if self._isSelect == isSelect then
		return
	end

	gohelper.setActive(self._goSelect, isSelect)
	self._skillAttrUpItem:onSelect(isSelect)

	self._isSelect = isSelect
end

function Rouge2_AttributeDetailSkillItem:_onSelectSkillItem(index)
	self:onSelect(index == self._index)
end

function Rouge2_AttributeDetailSkillItem:onDestroy()
	return
end

return Rouge2_AttributeDetailSkillItem
