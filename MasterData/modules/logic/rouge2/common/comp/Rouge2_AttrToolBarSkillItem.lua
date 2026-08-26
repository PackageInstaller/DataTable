-- chunkname: @modules/logic/rouge2/common/comp/Rouge2_AttrToolBarSkillItem.lua

module("modules.logic.rouge2.common.comp.Rouge2_AttrToolBarSkillItem", package.seeall)

local Rouge2_AttrToolBarSkillItem = class("Rouge2_AttrToolBarSkillItem", LuaCompBase)

function Rouge2_AttrToolBarSkillItem.Get(go)
	return MonoHelper.addNoUpdateLuaComOnceToGo(go, Rouge2_AttrToolBarSkillItem)
end

function Rouge2_AttrToolBarSkillItem:init(go)
	self.go = go
	self._goRoot = gohelper.findChild(self.go, "go_Root")
	self._goSplitLine = gohelper.findChild(self.go, "go_SplitLine")
	self._isSelect = false
	self._isLight = false
	self._initResDone = false
	self._initDataDone = false
	self._isShowEmpty = true
	self._loader = PrefabInstantiate.Create(self._goRoot)

	self._loader:startLoad(Rouge2_Enum.ResPath.ActiveSkillAttrUpdateItem, self._onLoadDone, self)
end

function Rouge2_AttrToolBarSkillItem:addEventListeners()
	return
end

function Rouge2_AttrToolBarSkillItem:removeEventListeners()
	return
end

function Rouge2_AttrToolBarSkillItem:_onLoadDone(loader)
	local goAttrUpItem = loader:getInstGO()

	self._skillAttrUpItem = Rouge2_ActiveSkillAttrUpdateItem.Get(goAttrUpItem)

	self._skillAttrUpItem:initClickCallback(self._clickCallback, self)

	self._initResDone = true

	self:refreshUI()
end

function Rouge2_AttrToolBarSkillItem:onUpdateMO(index, dataType, dataId)
	self._index = index
	self._dataType = dataType
	self._dataId = dataId
	self._isEmpty = not self._dataType or not self._dataId
	self._initDataDone = true

	self:refreshUI()
end

function Rouge2_AttrToolBarSkillItem:refreshUI()
	if not self._initDataDone or not self._initResDone then
		return
	end

	if self._isEmpty and not self._isShowEmpty then
		gohelper.setActive(self.go, false)

		return
	end

	gohelper.setActive(self.go, true)
	self._skillAttrUpItem:onUpdateMO(self._index, self._dataType, self._dataId)
	self._skillAttrUpItem:onSelect(self._isSelect)
	self._skillAttrUpItem:showLight(self._isLight)
	gohelper.setActive(self._goSplitLine, self._index ~= 1)
end

function Rouge2_AttrToolBarSkillItem:_clickCallback()
	if self._isEmpty then
		return
	end

	Rouge2_ViewHelper.openActiveSkillAttrUpdateTipsView(self._dataType, self._dataId)
end

function Rouge2_AttrToolBarSkillItem:onSelect(isSelect)
	if self._isSelect == isSelect then
		return
	end

	self._isSelect = isSelect

	self:refreshUI()
end

function Rouge2_AttrToolBarSkillItem:setShowEmptyUI(isShow)
	if self._isShowEmpty == isShow then
		return
	end

	self._isShowEmpty = isShow

	self:refreshUI()
end

function Rouge2_AttrToolBarSkillItem:showLight(isLight)
	if self._isLight == isLight then
		return
	end

	self._isLight = isLight

	self:refreshUI()
end

function Rouge2_AttrToolBarSkillItem:onDestroy()
	return
end

return Rouge2_AttrToolBarSkillItem
