-- chunkname: @modules/logic/sp02/dungeonmap/view/AtomicDungeonHeroGroupView.lua

module("modules.logic.sp02.dungeonmap.view.AtomicDungeonHeroGroupView", package.seeall)

local AtomicDungeonHeroGroupView = class("AtomicDungeonHeroGroupView", HeroGroupFightView)

function AtomicDungeonHeroGroupView:_editableInitView()
	AtomicDungeonHeroGroupView.super._editableInitView(self)
	self.addEventCb(self, AtomicTalentController.instance, AtomicEvent.TalentUpdate, self.refreshTalent, self)
end

function AtomicDungeonHeroGroupView:_enterFight()
	if AtomicModel.instance:canInstallTalent(self._realEnterFight, self) then
		return
	end

	self:_realEnterFight()
end

function AtomicDungeonHeroGroupView:_realEnterFight()
	if HeroGroupModel.instance.episodeId then
		self._closeWithEnteringFight = true

		local result = FightController.instance:setFightHeroSingleGroup()

		if result then
			self.viewContainer:dispatchEvent(HeroGroupEvent.BeforeEnterFight)

			local fightParam = FightModel.instance:getFightParam()

			fightParam.isReplay = false
			fightParam.multiplication = 1

			DungeonFightController.instance:sendStartDungeonRequest(fightParam.chapterId, fightParam.episodeId, fightParam, 1)
			AudioMgr.instance:trigger(AudioEnum.UI.Stop_HeroNormalVoc)
		end
	else
		logError("没选中关卡，无法开始战斗")
	end
end

function AtomicDungeonHeroGroupView:_refreshUI()
	AtomicDungeonHeroGroupView.super._refreshUI(self)
	self:refreshTalent()
end

function AtomicDungeonHeroGroupView:refreshTalent()
	self.slotItemList = self.slotItemList or {}

	local equipTalentList = AtomicModel.instance:getTalentEquipList()

	for index = 1, 2 do
		local slotItem = self.slotItemList[index]

		if not slotItem then
			slotItem = self:getUserDataTb_()
			slotItem.go = gohelper.findChild(self.viewGO, string.format("talent/skillslot/#go_slot%d", index))
			slotItem.icon = gohelper.findChildImage(slotItem.go, "icon")
			slotItem.btn = gohelper.findChildButtonWithAudio(slotItem.go, "btn_click")

			slotItem.btn:AddClickListener(self.onClickTalentSlot, self, slotItem)

			self.slotItemList[index] = slotItem
		end

		local nodeId = equipTalentList[index]

		gohelper.setActive(slotItem.icon, nodeId and nodeId > 0)

		if nodeId > 0 then
			local talentConfig = AtomicConfig.instance:getTalentConfig(nodeId)

			if not talentConfig then
				logError("天赋配置不存在，请检查：", nodeId)

				return
			end

			UISpriteSetMgr.instance:setSp02AtomicIconSprite(slotItem.icon, talentConfig.icon)
		end
	end
end

function AtomicDungeonHeroGroupView:onClickTalentSlot(slotItem)
	AtomicController.instance:openTalentView()
end

function AtomicDungeonHeroGroupView:_refreshCloth()
	gohelper.setActive(self._btncloth.gameObject, false)
end

function AtomicDungeonHeroGroupView:_initFightGroupDrop()
	local heroGroupType = HeroGroupModel.instance:getPresetHeroGroupType()

	if heroGroupType then
		self._dropherogroup.dropDown.enabled = false

		return
	end

	local list = {}

	for i = 1, 4 do
		list[i] = HeroGroupModel.instance:getCommonGroupName(i)
	end

	local selectIndex = HeroGroupModel.instance.curGroupSelectIndex

	gohelper.setActive(self._btnmodifyname, selectIndex ~= 0)

	local name = HeroGroupModel.instance:getGroupTypeName()

	if name then
		table.insert(list, 1, name)
	else
		selectIndex = selectIndex - 1
	end

	self._dropherogroup:ClearOptions()
	self._dropherogroup:AddOptions(list)
	self._dropherogroup:SetValue(selectIndex)
end

function AtomicDungeonHeroGroupView:isShowDropHeroGroup()
	return true
end

function AtomicDungeonHeroGroupView:onClose()
	AtomicDungeonHeroGroupView.super.onClose(self)

	for _, slotItem in pairs(self.slotItemList) do
		slotItem.btn:RemoveClickListener()
	end

	self.removeEventCb(self, AtomicTalentController.instance, AtomicEvent.TalentUpdate, self.refreshTalent, self)
end

return AtomicDungeonHeroGroupView
