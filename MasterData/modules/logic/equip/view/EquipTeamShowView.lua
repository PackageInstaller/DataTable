-- chunkname: @modules/logic/equip/view/EquipTeamShowView.lua

module("modules.logic.equip.view.EquipTeamShowView", package.seeall)

local EquipTeamShowView = class("EquipTeamShowView", BaseView)

function EquipTeamShowView:onInitView()
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_close")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function EquipTeamShowView:addEvents()
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
	self.addEventCb(self, HeroGroupController.instance, HeroGroupEvent.OnCloseEquipTeamShowView, self._closeThisView, self)
end

function EquipTeamShowView:removeEvents()
	self._btnclose:RemoveClickListener()
end

function EquipTeamShowView:_btncloseOnClick()
	local equipList = EquipTeamListModel.instance:getTeamEquip()

	self._inTeam = true
	self._targetEquipUid = equipList[1]

	self:_refreshUI()
	HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnCompareEquip, false)
end

function EquipTeamShowView:_closeThisView()
	self:closeThis()
end

function EquipTeamShowView:_editableInitView()
	return
end

function EquipTeamShowView:onUpdateParam()
	self._targetEquipUid = self.viewParam[1]
	self._inTeam = self.viewParam[2]

	self:_refreshUI()
end

function EquipTeamShowView:onOpen()
	self._showHideItem2 = false
	self._lastItem2Uid = nil
	self._itemList = self._itemList or self:getUserDataTb_()
	self._itemTipList = self._itemTipList or self:getUserDataTb_()
	self._targetEquipUid = self.viewParam[1]
	self._inTeam = self.viewParam[2]

	self:_refreshUI()
end

EquipTeamShowView.TeamShowItemPosList = {
	{
		-134.1,
		23.4
	},
	{
		420,
		23.4
	}
}

function EquipTeamShowView:_refreshUI()
	local heroMO = EquipTeamListModel.instance:getHero()

	self._heroId = heroMO and heroMO.heroId
	self._showHideItem2 = false

	local targetPosIndex = 2

	if self._inTeam then
		self:addItem(EquipTeamShowView.TeamShowItemPosList[targetPosIndex][1], EquipTeamShowView.TeamShowItemPosList[targetPosIndex][2], self._targetEquipUid, true, nil, 1)
		HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnCompareEquip, false)

		return
	end

	local equipList = EquipTeamListModel.instance:getTeamEquip()
	local equipUid = equipList[1]
	local targetPos = EquipTeamShowView.TeamShowItemPosList[targetPosIndex]

	if equipUid and EquipModel.instance:getEquip(equipUid) then
		self._showHideItem2 = true

		self:addItem(targetPos[1], targetPos[2], self._targetEquipUid, false, true, 1)

		targetPosIndex = targetPosIndex - 1
		targetPos = EquipTeamShowView.TeamShowItemPosList[targetPosIndex]

		self:addItem(EquipTeamShowView.TeamShowItemPosList[targetPosIndex][1], EquipTeamShowView.TeamShowItemPosList[targetPosIndex][2], equipUid, true, true, 2)
		HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnCompareEquip, true)
	else
		self:addItem(EquipTeamShowView.TeamShowItemPosList[targetPosIndex][1], EquipTeamShowView.TeamShowItemPosList[targetPosIndex][2], self._targetEquipUid, false, false, 1)
		HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnCompareEquip, false)
	end

	if self.viewContainer.animBgUpdate then
		self.viewContainer:animBgUpdate()
	end
end

function EquipTeamShowView:addItem(x, y, uid, inTeam, compare, index)
	local path = self.viewContainer:getSetting().otherRes[1]
	local child = self._itemTipList[index]

	if not child then
		child = self:getResInst(path, self.viewGO, "item" .. index)

		table.insert(self._itemTipList, index, child)
	end

	if self._itemTipList[2] then
		gohelper.setActive(self._itemTipList[2], self._showHideItem2)

		if index == 2 and self._lastItem2Uid ~= uid then
			gohelper.setActive(self._itemTipList[2], false)

			self._lastItem2Uid = uid
		end
	end

	gohelper.setActive(child, true)
	recthelper.setAnchor(child.transform, x, y)

	local item = self._itemList[index]

	if not item then
		item = EquipTeamShowItem.New()

		table.insert(self._itemList, index, item)
		item:initView(child, {
			uid,
			inTeam,
			compare,
			self,
			self._heroId,
			index
		})
	else
		item.viewParam = {
			uid,
			inTeam,
			compare,
			self,
			self._heroId,
			index
		}

		item:onUpdateParam()
	end
end

function EquipTeamShowView:onClose()
	return
end

function EquipTeamShowView:onDestroyView()
	for i, v in pairs(self._itemList) do
		v:destroyView()
	end
end

return EquipTeamShowView
