-- chunkname: @modules/logic/rouge2/common/comp/Rouge2_ActiveSkillAttrUpdateItem.lua

module("modules.logic.rouge2.common.comp.Rouge2_ActiveSkillAttrUpdateItem", package.seeall)

local Rouge2_ActiveSkillAttrUpdateItem = class("Rouge2_ActiveSkillAttrUpdateItem", LuaCompBase)

function Rouge2_ActiveSkillAttrUpdateItem.Get(go)
	return MonoHelper.addNoUpdateLuaComOnceToGo(go, Rouge2_ActiveSkillAttrUpdateItem)
end

function Rouge2_ActiveSkillAttrUpdateItem:init(go)
	self.go = go
	self._goEmpty = gohelper.findChild(self.go, "#go_Empty")
	self._goHas = gohelper.findChild(self.go, "#go_Has")
	self._imageRareBg = gohelper.findChildImage(self.go, "#go_Has/#go_Info/#image_RareBg")
	self._simageIcon = gohelper.findChildSingleImage(self.go, "#go_Has/#go_Info/#simage_Icon")
	self._imageRareTag = gohelper.findChildImage(self.go, "#go_Has/#go_Info/#image_RareTag")
	self._goTeamTips = gohelper.findChild(self.go, "#go_Has/#go_Info/#go_TeamTips")
	self._goConditionList = gohelper.findChild(self.go, "#go_Has/#go_ConditionList")
	self._goConditionItem = gohelper.findChild(self.go, "#go_Has/#go_ConditionList/#go_ConditionItem")
	self._goSplitLine = gohelper.findChild(self.go, "#go_SplitLine")
	self._btnClick = gohelper.findChildButtonWithAudio(self.go, "#btn_Click")
	self._goSelect = gohelper.findChild(self.go, "#go_Select")
	self._goLight = gohelper.findChild(self.go, "#go_Pre")
	self._conditionItemTab = self:getUserDataTb_()
	self._teamTipsParam = {}
	self._teamTipsLoader = Rouge2_TeamRecommendTipsLoader.Load(self._goTeamTips, Rouge2_Enum.TeamRecommendTipType.ItemRecommend)

	self:showLight(false)
	self:onSelect(false)
end

function Rouge2_ActiveSkillAttrUpdateItem:addEventListeners()
	self._btnClick:AddClickListener(self._btnClickOnClick, self)
end

function Rouge2_ActiveSkillAttrUpdateItem:removeEventListeners()
	self._btnClick:RemoveClickListener()
end

function Rouge2_ActiveSkillAttrUpdateItem:_btnClickOnClick()
	if self._clickCallback then
		self._clickCallback(self._clickCallbackObj, self._index)
	end
end

function Rouge2_ActiveSkillAttrUpdateItem:initClickCallback(clickCallback, clickCallbackObj)
	self._clickCallback = clickCallback
	self._clickCallbackObj = clickCallbackObj
end

function Rouge2_ActiveSkillAttrUpdateItem:onUpdateMO(index, dataType, dataId)
	self._index = index
	self._dataType = dataType
	self._dataId = dataId
	self._hasSkill = self._dataType ~= nil and self._dataId ~= nil

	gohelper.setActive(self._goHas, self._hasSkill)
	gohelper.setActive(self._goEmpty, not self._hasSkill)
	gohelper.setActive(self._goSplitLine, self._hasSkill and self._index ~= 1)

	if not self._hasSkill then
		return
	end

	self._skillCo = Rouge2_BackpackHelper.getItemCofigAndMo(self._dataType, self._dataId)
	self._skillId = self._skillCo and self._skillCo.id

	self:refreshUI()
end

function Rouge2_ActiveSkillAttrUpdateItem:refreshUI()
	Rouge2_IconHelper.setItemIconAndRare(self._skillId, self._simageIcon, self._imageRareTag, Rouge2_Enum.ItemRareIconType.CircleIcon)
	Rouge2_IconHelper.setGameItemRare(self._skillId, self._imageRareBg, Rouge2_Enum.ItemRareIconType.CircleBg)

	self._teamTipsParam[Rouge2_Enum.TeamRecommendParam.ItemId] = self._skillId

	self._teamTipsLoader:initInfo(nil, self._teamTipsParam)
	self:refreshAttrUpdateList()
end

function Rouge2_ActiveSkillAttrUpdateItem:refreshAttrUpdateList()
	local updateAttrList = Rouge2_CollectionConfig.instance:getMaxSkillUpdateAttrList(self._skillId)

	gohelper.CreateObjList(self, self._refreshAttrItem, updateAttrList, self._goConditionList, self._goConditionItem, Rouge2_ActiveSkillAttrConditionItem)
end

function Rouge2_ActiveSkillAttrUpdateItem:_refreshAttrItem(conditionItem, conditionInfo, index)
	conditionItem:onUpdateMO(index, conditionInfo)
end

function Rouge2_ActiveSkillAttrUpdateItem:onSelect(isSelect)
	gohelper.setActive(self._goSelect, isSelect)
end

function Rouge2_ActiveSkillAttrUpdateItem:showLight(isLight)
	gohelper.setActive(self._goLight, isLight)
end

function Rouge2_ActiveSkillAttrUpdateItem:onDestroy()
	return
end

return Rouge2_ActiveSkillAttrUpdateItem
