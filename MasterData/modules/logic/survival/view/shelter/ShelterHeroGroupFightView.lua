-- chunkname: @modules/logic/survival/view/shelter/ShelterHeroGroupFightView.lua

module("modules.logic.survival.view.shelter.ShelterHeroGroupFightView", package.seeall)

local ShelterHeroGroupFightView = class("ShelterHeroGroupFightView", HeroGroupFightView)

function ShelterHeroGroupFightView:_editableInitView()
	self:checkHeroList()
	ShelterHeroGroupFightView.super._editableInitView(self)

	self._goSwitch = gohelper.findChild(self.viewGO, "#go_righttop/#go_switch")
	self._goSwitchItem = gohelper.findChild(self.viewGO, "#go_righttop/#go_switch/#go_switchitem")
	self._goHeroEffect = gohelper.findChild(self.viewGO, "#go_container/#go_HeroEffect")

	gohelper.setActive(self._goSwitchItem, false)

	self.simage_hero = gohelper.findChildImage(self.viewGO, "#go_container/#go_HeroEffect/#simage_hero")
end

function ShelterHeroGroupFightView:onOpen()
	ShelterHeroGroupFightView.super.onOpen(self)

	self.selectIndex = HeroGroupSnapshotModel.instance:getSelectIndex(ModuleEnum.HeroGroupSnapshotType.Shelter)

	self:_refreshSwitchItems()

	local weekInfo = SurvivalShelterModel.instance:getWeekInfo()
	local fight = weekInfo.intrudeBox.fight
	local curRound = fight.currRound

	self._canClickStart = curRound == self.selectIndex

	if curRound ~= self.selectIndex then
		self.selectIndex = curRound

		TaskDispatcher.runDelay(self._autoSwitchSuccessRound, self, 0.5)
	end

	local roleInfo = weekInfo:getRoleInfo()
	local roleId = roleInfo.roleId

	if roleId == SurvivalRoleConfig.instance:getDefaultRoleId() then
		roleId = SurvivalRoleConfig.instance:getDefaultRoleIdSwitch()
	end

	local path = "survival_herogroup_role_" .. roleId

	if not string.nilorempty(path) then
		UISpriteSetMgr.instance:setSurvivalSprite2(self.simage_hero, path)
	end
end

function ShelterHeroGroupFightView:_autoSwitchSuccessRound()
	if HeroGroupSnapshotModel.instance:setSelectIndex(ModuleEnum.HeroGroupSnapshotType.Shelter, self.selectIndex) then
		self:_refreshSwitchItems()
		self:checkHeroList()
		self:_checkEquipClothSkill()
		HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnModifyHeroGroup)
		gohelper.setActive(self._goherogroupcontain, false)
		gohelper.setActive(self._goherogroupcontain, true)

		self._canClickStart = true
	end
end

function ShelterHeroGroupFightView:_refreshBtns(isCostPower)
	ShelterHeroGroupFightView.super._refreshBtns(self, isCostPower)
	gohelper.setActive(self._dropherogroup, false)
	TaskDispatcher.cancelTask(self._checkDropArrow, self)
end

function ShelterHeroGroupFightView:_onClickStart()
	if not self._canClickStart then
		return
	end

	if HeroGroupSnapshotModel.instance:setSelectIndex(ModuleEnum.HeroGroupSnapshotType.Shelter, self.selectIndex) then
		self:_refreshSwitchItems()
		self:checkHeroList()
		HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnModifyHeroGroup)
		gohelper.setActive(self._goherogroupcontain, false)
		gohelper.setActive(self._goherogroupcontain, true)
	end

	local weekInfo = SurvivalShelterModel.instance:getWeekInfo()
	local fight = weekInfo.intrudeBox.fight

	if SurvivalEquipRedDotHelper.instance.reddotType >= 0 then
		GameFacade.showMessageBox(MessageBoxIdDefine.SurvivalEnterFightEquipRed, MsgBoxEnum.BoxType.Yes_No, self._realClickStart, nil, nil, self, nil, nil)
	elseif self.selectIndex >= fight.maxRound then
		GameFacade.showMessageBox(MessageBoxIdDefine.SurvivalEnterLastFightTip, MsgBoxEnum.BoxType.Yes_No, self._realClickStart, nil, nil, self, nil, nil)
	else
		ShelterHeroGroupFightView.super._onClickStart(self)
	end
end

function ShelterHeroGroupFightView:_realClickStart()
	ShelterHeroGroupFightView.super._onClickStart(self)
end

function ShelterHeroGroupFightView:checkHeroList()
	local roleNum = 5
	local groupMO = HeroGroupModel.instance:getCurGroupMO()

	HeroSingleGroupModel.instance:setMaxHeroCount(roleNum)
	HeroSingleGroupModel.instance:setSingleGroup(groupMO)

	local weekInfo = SurvivalShelterModel.instance:getWeekInfo()
	local currPlanId = weekInfo.equipBox.currPlanId
	local fight = weekInfo.intrudeBox.fight

	while fight.usedEquipPlan[currPlanId] do
		currPlanId = currPlanId + 1

		if currPlanId > 4 then
			currPlanId = 1
		end

		if currPlanId == weekInfo.equipBox.currPlanId then
			logError("所有装备方案都用过了？？？？？")

			return
		end
	end

	if currPlanId ~= weekInfo.equipBox.currPlanId then
		SurvivalWeekRpc.instance:sendSurvivalEquipSwitchPlan(currPlanId)
	end
end

function ShelterHeroGroupFightView:_onClickHeroGroupItem(id)
	local selectIndex = HeroGroupSnapshotModel.instance:getSelectIndex(ModuleEnum.HeroGroupSnapshotType.Shelter)
	local weekInfo = SurvivalShelterModel.instance:getWeekInfo()
	local fight = weekInfo.intrudeBox.fight
	local curRound = fight.currRound

	if curRound ~= selectIndex then
		GameFacade.showToast(ToastEnum.SurvivalOtherRoundNoEditor)

		return
	end

	ShelterHeroGroupFightView.super._onClickHeroGroupItem(self, id)
end

function ShelterHeroGroupFightView:openHeroGroupEditView()
	ViewMgr.instance:openView(ViewName.SurvivalHeroGroupEditView, self._param)
end

function ShelterHeroGroupFightView:_refreshReplay()
	gohelper.setActive(self._goReplayBtn, false)
	gohelper.setActive(self._gomemorytimes, false)
end

function ShelterHeroGroupFightView:_refreshPowerShow()
	gohelper.setActive(self._gopowercontent, false)
end

function ShelterHeroGroupFightView:_refreshSwitchItems()
	if self._switchItems == nil then
		self._switchItems = self:getUserDataTb_()
	end

	for i = 1, 3 do
		local item = self._switchItems[i]

		if item == nil then
			local go = gohelper.cloneInPlace(self._goSwitchItem)

			item = self:getUserDataTb_()
			item.go = go
			item.goNormal = gohelper.findChild(go, "#go_Normal")
			item.goSelect = gohelper.findChild(go, "#go_Select")
			item.txtName = gohelper.findChildText(go, "#go_Normal/#txt_normal")
			item.txtName2 = gohelper.findChildText(go, "#go_Select/#txt_select")

			local txt = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("shelterHeroGroupFightView_item"), i)

			item.txtName.text = txt
			item.txtName2.text = txt
			item.btn = gohelper.findChildClickWithAudio(go, "#btn_click")

			item.btn:AddClickListener(function()
				local selectIndex = HeroGroupSnapshotModel.instance:getSelectIndex(ModuleEnum.HeroGroupSnapshotType.Shelter)

				if selectIndex == i then
					return
				end

				if self.selectIndex ~= i then
					GameFacade.showToast(ToastEnum.SurvivalOtherRoundNoEditor)

					return
				end

				if HeroGroupSnapshotModel.instance:setSelectIndex(ModuleEnum.HeroGroupSnapshotType.Shelter, i) then
					self:_refreshSwitchItems()
					self:checkHeroList()
					HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnModifyHeroGroup)
					gohelper.setActive(self._goherogroupcontain, false)
					gohelper.setActive(self._goherogroupcontain, true)
				end
			end, self, nil)

			self._switchItems[i] = item

			gohelper.setActive(go, true)
		end

		local selectIndex = HeroGroupSnapshotModel.instance:getSelectIndex(ModuleEnum.HeroGroupSnapshotType.Shelter)

		gohelper.setActive(item.goNormal, selectIndex ~= i)
		gohelper.setActive(item.goSelect, selectIndex == i)
	end
end

function ShelterHeroGroupFightView:onClose()
	if self._switchItems ~= nil then
		for i = 1, tabletool.len(self._switchItems) do
			local item = self._switchItems[i]

			if item ~= nil then
				item.btn:RemoveClickListener()

				item.go = nil
				item.goNormal = nil
				item.goSelect = nil
				item.btn = nil
			end
		end

		self._switchItems = nil
	end

	ShelterHeroGroupFightView.super.onClose(self)
	HeroSingleGroupModel.instance:setMaxHeroCount()

	HeroGroupTrialModel.instance.curBattleId = nil
end

function ShelterHeroGroupFightView:_setTrialNumTips()
	ShelterHeroGroupFightView.super._setTrialNumTips(self)

	if self._goTrialTips.activeSelf then
		recthelper.setAnchorY(self._goHeroEffect.transform, 250)
	else
		recthelper.setAnchorY(self._goHeroEffect.transform, 200)
	end
end

return ShelterHeroGroupFightView
