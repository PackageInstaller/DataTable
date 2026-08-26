-- chunkname: @modules/logic/gm/view/FightGmCustomFightSelectItem.lua

module("modules.logic.gm.view.FightGmCustomFightSelectItem", package.seeall)

local FightGmCustomFightSelectItem = class("FightGmCustomFightSelectItem", FightBaseView)

function FightGmCustomFightSelectItem:onInitView()
	self.select = gohelper.findChild(self.viewGO, "select")
	self.text = gohelper.findChildText(self.viewGO, "Text")
	self.btn = gohelper.findChildClickWithDefaultAudio(self.viewGO, "btn")
end

function FightGmCustomFightSelectItem:addEvents()
	self:com_registClick(self.btn, self._onClick)
end

function FightGmCustomFightSelectItem:onRefreshItemData(itemData)
	self.selectItemType = self.PARENT_VIEW.selectItemType
	self.itemData = itemData
	self.text.text = itemData.name
end

function FightGmCustomFightSelectItem:_onClick()
	if self.selectItemType == FightGmCustomFightView.SelectItemType.Team then
		self.PARENT_VIEW:setTeamData(self.itemData)
	elseif self.selectItemType == FightGmCustomFightView.SelectItemType.Character then
		self.PARENT_VIEW:setCharacterData(self.itemData)
	elseif self.selectItemType == FightGmCustomFightView.SelectItemType.Equip then
		self.PARENT_VIEW:setEquipData(self.itemData)
	end

	self.PARENT_VIEW.selectPart:SetActive(false)
end

function FightGmCustomFightSelectItem:onDestructor()
	return
end

return FightGmCustomFightSelectItem
