-- chunkname: @modules/logic/tower/view/fight/TowerHeroGroupBossView.lua

module("modules.logic.tower.view.fight.TowerHeroGroupBossView", package.seeall)

local TowerHeroGroupBossView = class("TowerHeroGroupBossView", BaseView)

function TowerHeroGroupBossView:onInitView()
	self.goAssistBoss = gohelper.findChild(self.viewGO, "herogroupcontain/assistBoss")
	self.goBossRoot = gohelper.findChild(self.goAssistBoss, "boss/root")
	self.imgCareer = gohelper.findChildImage(self.goBossRoot, "career")
	self.goLev = gohelper.findChild(self.goBossRoot, "image_Lv")
	self.txtLev = gohelper.findChildTextMesh(self.goBossRoot, "lev")
	self.txtName = gohelper.findChildTextMesh(self.goBossRoot, "name")
	self.simageBoss = gohelper.findChildSingleImage(self.goBossRoot, "icon")
	self._btnClick = gohelper.findChildButtonWithAudio(self.goAssistBoss, "boss/click")
	self.goAdd = gohelper.findChild(self.goAssistBoss, "boss/goAdd")
	self.goEmpty = gohelper.findChild(self.goAssistBoss, "boss/#go_Empty")
	self._btnAttr = gohelper.findChildButtonWithAudio(self.viewGO, "herogroupcontain/assistBoss/boss/root/#btn_attr")
	self.btnReset = gohelper.findChildButtonWithAudio(self.viewGO, "#go_container/#go_replayready/Reset")
	self._goreplayready = gohelper.findChild(self.viewGO, "#go_container/#go_replayready")
	self._dropherogroup = gohelper.findChildDropdown(self.viewGO, "#go_container/btnContain/horizontal/#drop_herogroup")
	self._gotalentPlane = gohelper.findChild(self.viewGO, "herogroupcontain/assistBoss/boss/talentPlan")
	self._txtTalentPlan = gohelper.findChildTextMesh(self.viewGO, "herogroupcontain/assistBoss/boss/talentPlan/txt_talentPlan")
	self._btnTalentPlan = gohelper.findChildButtonWithAudio(self.viewGO, "herogroupcontain/assistBoss/boss/talentPlan/btn_talentPlan")
	self.goArrow = gohelper.findChild(self.viewGO, "herogroupcontain/assistBoss/boss/talentPlan/#go_Arrow")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function TowerHeroGroupBossView:addEvents()
	self._btnClick:AddClickListener(self._btnClickOnClick, self)
	self._btnAttr:AddClickListener(self._btnAttrOnClick, self)
	self.btnReset:AddClickListener(self._btnResetOnClick, self)
	self._btnTalentPlan:AddClickListener(self._btnTalentPlanOnClick, self)
	self.addEventCb(self, HeroGroupController.instance, HeroGroupEvent.SelectHeroGroup, self._checkRestrictBoss, self)
	self.addEventCb(self, HeroGroupController.instance, HeroGroupEvent.OnModifyHeroGroup, self.refreshUI, self)
	self.addEventCb(self, HeroGroupController.instance, HeroGroupEvent.OnSnapshotSaveSucc, self.refreshUI, self)
	self.addEventCb(self, HeroGroupController.instance, HeroGroupEvent.OnModifyGroupSelectIndex, self._checkRestrictBoss, self)
	self.addEventCb(self, TowerController.instance, TowerEvent.OnTowerResetSubEpisode, self.onResetSubEpisode, self)
	self.addEventCb(self, TowerController.instance, TowerEvent.ResetTalent, self._onResetTalent, self)
	self.addEventCb(self, TowerController.instance, TowerEvent.ActiveTalent, self._onActiveTalent, self)
	self.addEventCb(self, TowerController.instance, TowerEvent.TowerUpdate, self._onTowerUpdate, self)
	self.addEventCb(self, TowerController.instance, TowerEvent.RefreshTalent, self.refreshTalent, self)
	self.addEventCb(self, TowerController.instance, TowerEvent.RenameTalentPlan, self.refreshTalent, self)
end

function TowerHeroGroupBossView:removeEvents()
	self._btnClick:RemoveClickListener()
	self._btnAttr:RemoveClickListener()
	self.btnReset:RemoveClickListener()
	self._btnTalentPlan:RemoveClickListener()
	self.removeEventCb(self, HeroGroupController.instance, HeroGroupEvent.SelectHeroGroup, self._checkRestrictBoss, self)
	self.removeEventCb(self, HeroGroupController.instance, HeroGroupEvent.OnModifyHeroGroup, self.refreshUI, self)
	self.removeEventCb(self, HeroGroupController.instance, HeroGroupEvent.OnSnapshotSaveSucc, self.refreshUI, self)
	self.removeEventCb(self, HeroGroupController.instance, HeroGroupEvent.OnModifyGroupSelectIndex, self._checkRestrictBoss, self)
	self.removeEventCb(self, TowerController.instance, TowerEvent.OnTowerResetSubEpisode, self.onResetSubEpisode, self)
	self.removeEventCb(self, TowerController.instance, TowerEvent.ResetTalent, self._onResetTalent, self)
	self.removeEventCb(self, TowerController.instance, TowerEvent.ActiveTalent, self._onActiveTalent, self)
	self.removeEventCb(self, TowerController.instance, TowerEvent.TowerUpdate, self._onTowerUpdate, self)
	self.removeEventCb(self, TowerController.instance, TowerEvent.RefreshTalent, self.refreshTalent, self)
	self.removeEventCb(self, TowerController.instance, TowerEvent.RenameTalentPlan, self.refreshTalent, self)
end

function TowerHeroGroupBossView:_onTowerUpdate()
	local param = TowerModel.instance:getRecordFightParam()

	TowerController.instance:checkTowerIsEnd(param.towerType, param.towerId)
end

function TowerHeroGroupBossView:_btnResetOnClick()
	local param = TowerModel.instance:getRecordFightParam()

	if param.isHeroGroupLock then
		if param.towerType == TowerEnum.TowerType.Limited then
			local towerInfoMo = TowerModel.instance:getTowerInfoById(param.towerType, param.towerId)
			local curMaxScore = towerInfoMo:getLayerScore(param.layerId)

			GameFacade.showMessageBox(MessageBoxIdDefine.TowerResetSubEpisode, MsgBoxEnum.BoxType.Yes_No, self.sendTowerResetSubEpisodeRequest, nil, nil, self, nil, nil, curMaxScore)
		else
			GameFacade.showMessageBox(MessageBoxIdDefine.TowerResetPermanentEpisode, MsgBoxEnum.BoxType.Yes_No, self.sendTowerResetSubEpisodeRequest, nil, nil, self)
		end
	end
end

function TowerHeroGroupBossView:sendTowerResetSubEpisodeRequest()
	local param = TowerModel.instance:getRecordFightParam()

	if param.towerType == TowerEnum.TowerType.Limited then
		TowerRpc.instance:sendTowerResetSubEpisodeRequest(param.towerType, param.towerId, param.layerId, 0)
	else
		TowerRpc.instance:sendTowerResetSubEpisodeRequest(param.towerType, param.towerId, param.layerId, param.episodeId)
	end
end

function TowerHeroGroupBossView:_btnAttrOnClick()
	if not self.bossId or self.bossId == 0 then
		return
	end

	ViewMgr.instance:openView(ViewName.TowerBossHeroGroupAttributeTipsView, {
		bossId = self.bossId
	})
end

function TowerHeroGroupBossView:_btnClickOnClick()
	local bossIsOpen = TowerController.instance:isBossTowerOpen()

	if not bossIsOpen then
		local layerNum = TowerConfig.instance:getTowerConstConfig(TowerEnum.ConstId.BossTowerOpen)

		GameFacade.showToast(ToastEnum.TowerBossLockTips, layerNum)

		return
	end

	local param = TowerModel.instance:getRecordFightParam()

	if param.isHeroGroupLock or param.towerType == TowerEnum.TowerType.Boss then
		if self.bossId and self.bossId > 0 then
			ViewMgr.instance:openView(ViewName.TowerAssistBossDetailView, {
				isFromHeroGroup = true,
				bossId = self.bossId
			})
		else
			GameFacade.showToast(ToastEnum.TowerHeroGroupCantEdit)
		end
	else
		TowerController.instance:openAssistBossView(self.bossId, true, param.towerType, param.towerId)
	end
end

function TowerHeroGroupBossView:_btnTalentPlanOnClick()
	if not self.bossId then
		return
	end

	ViewMgr.instance:openView(ViewName.TowerAssistBossTalentView, {
		bossId = self.bossId,
		isFromHeroGroup = self.isFromHeroGroup
	})
end

function TowerHeroGroupBossView:_onResetTalent(talentId)
	self:refreshTalent()
end

function TowerHeroGroupBossView:_onActiveTalent(talentId)
	self:refreshTalent()
end

function TowerHeroGroupBossView:_editableInitView()
	return
end

function TowerHeroGroupBossView:onResetSubEpisode()
	TowerModel.instance:refreshHeroGroupInfo()
	self:refreshUI()
end

function TowerHeroGroupBossView:onUpdateParam()
	return
end

function TowerHeroGroupBossView:onOpen()
	self:refreshUI()
	self:_checkRestrictBoss()
end

function TowerHeroGroupBossView:refreshUI()
	local curGroupMO = HeroGroupModel.instance:getCurGroupMO()
	local bossId = curGroupMO:getAssistBossId()
	local param = TowerModel.instance:getRecordFightParam()

	TowerModel.instance:setCurTowerType(param.towerType)

	self.isTeach = param.layerId == 0 and param.towerType == TowerEnum.TowerType.Boss

	gohelper.setActive(self._dropherogroup, not param.isHeroGroupLock and param.towerType ~= TowerEnum.TowerType.Boss)
	gohelper.setActive(self._goreplayready, param.isHeroGroupLock)

	local bossIsOpen = TowerController.instance:isBossTowerOpen()

	if bossIsOpen then
		local isBossTower = param.towerType == TowerEnum.TowerType.Boss

		if isBossTower and not self.isTeach then
			local towerConfig = TowerConfig.instance:getBossTowerConfig(param.towerId)
			local bossMo = TowerAssistBossModel.instance:getById(towerConfig.bossId)

			bossId = not bossMo and 0 or bossMo:getTempState() and 0 or towerConfig.bossId

			curGroupMO:setAssistBossId(bossId)

			bossId = towerConfig.bossId
		elseif self.isTeach then
			local towerConfig = TowerConfig.instance:getBossTowerConfig(param.towerId)

			curGroupMO:setAssistBossId(towerConfig.bossId)

			bossId = towerConfig.bossId
		end
	else
		bossId = 0

		curGroupMO:setAssistBossId(0)
	end

	local curBossMo = TowerAssistBossModel.instance:getById(bossId)

	if param.towerType == TowerEnum.TowerType.Normal and (curBossMo and curBossMo:getTempState() or not curBossMo) then
		self.bossId = 0

		curGroupMO:setAssistBossId(0)
	else
		self.bossId = bossId
	end

	self:refreshBoss()
end

function TowerHeroGroupBossView:refreshBoss()
	local bossConfig = TowerConfig.instance:getAssistBossConfig(self.bossId)
	local param = TowerModel.instance:getRecordFightParam()

	gohelper.setActive(self.goEmpty, bossConfig == nil)
	gohelper.setActive(self._btnAttr, bossConfig ~= nil)
	gohelper.setActive(self.goBossRoot, bossConfig ~= nil)

	if bossConfig then
		self.txtName.text = bossConfig.name

		UISpriteSetMgr.instance:setCommonSprite(self.imgCareer, string.format("lssx_%s", bossConfig.career))

		local bossMo = TowerAssistBossModel.instance:getById(self.bossId)
		local isLimited = param.towerType == TowerEnum.TowerType.Limited

		if not bossMo then
			if isLimited then
				bossMo = TowerAssistBossModel.instance:getTempUnlockTrialBossMO(self.bossId)

				gohelper.setActive(self.goLev, true)

				self.txtLev.text = TowerConfig.instance:getTowerConstConfig(TowerEnum.ConstId.BalanceBossLevel)
			elseif param.towerType == TowerEnum.TowerType.Boss then
				bossMo = TowerAssistBossModel.instance:getTempUnlockTrialBossMO(self.bossId)

				gohelper.setActive(self.goLev, true)

				self.txtLev.text = 1

				if self.isTeach then
					local curLevel = tonumber(TowerConfig.instance:getTowerConstConfig(TowerEnum.ConstId.TeachBossLevel))
					local teachConfig = TowerConfig.instance:getBossTeachConfig(param.towerId, param.difficulty)

					bossMo:setTrialInfo(curLevel, teachConfig.planId)

					self.txtLev.text = curLevel
				else
					bossMo:setTrialInfo(0, 0)
				end

				bossMo:refreshTalent()
			else
				local curGroupMO = HeroGroupModel.instance:getCurGroupMO()

				curGroupMO:setAssistBossId(0)
				gohelper.setActive(self.goLev, false)

				self.txtLev.text = ""
			end
		else
			gohelper.setActive(self.goLev, true)

			local limitedTrialLevel = tonumber(TowerConfig.instance:getTowerConstConfig(TowerEnum.ConstId.BalanceBossLevel))
			local isLimitedTrial = param.towerType == TowerEnum.TowerType.Limited and limitedTrialLevel > bossMo.level

			if self.isTeach then
				local curLevel = tonumber(TowerConfig.instance:getTowerConstConfig(TowerEnum.ConstId.TeachBossLevel))
				local teachConfig = TowerConfig.instance:getBossTeachConfig(param.towerId, param.difficulty)

				bossMo:setTrialInfo(curLevel, teachConfig.planId)
				bossMo:refreshTalent()

				self.txtLev.text = tostring(curLevel)
			elseif isLimitedTrial then
				local curLevel = limitedTrialLevel
				local defaultPlanId = TowerAssistBossModel.instance:getLimitedTrialBossLocalPlan(bossMo)

				bossMo:setTrialInfo(curLevel, defaultPlanId)
				bossMo:refreshTalent()

				self.txtLev.text = tostring(Mathf.Max(curLevel, 1))
			else
				bossMo:setTrialInfo(0, 0)
				bossMo:refreshTalent()

				self.txtLev.text = tostring(Mathf.Max(bossMo.level, 1))
			end
		end

		self.simageBoss:LoadImage(bossConfig.bossPic)
	end

	local bossIsOpen = TowerController.instance:isBossTowerOpen()
	local isBossTower = param.towerType == TowerEnum.TowerType.Boss
	local canShowAdd = bossIsOpen and bossConfig == nil and not isBossTower and not param.isHeroGroupLock

	gohelper.setActive(self.goAdd, canShowAdd)
	self:refreshTalent()
end

function TowerHeroGroupBossView:refreshTalent()
	local param = TowerModel.instance:getRecordFightParam()
	local curTowerType = TowerModel.instance:getCurTowerType()
	local limitedTrialLevel = tonumber(TowerConfig.instance:getTowerConstConfig(TowerEnum.ConstId.BalanceBossLevel))
	local bossMo = TowerAssistBossModel.instance:getById(self.bossId)
	local isLimitedTrial = bossMo and curTowerType and curTowerType == TowerEnum.TowerType.Limited and bossMo.trialLevel > 0 and limitedTrialLevel > bossMo.level
	local bossConfig = TowerConfig.instance:getAssistBossConfig(self.bossId)

	if bossConfig and not self.isTeach and not isLimitedTrial then
		gohelper.setActive(self.goArrow, bossMo and bossMo:hasTalentCanActive() or false)
	else
		gohelper.setActive(self.goArrow, false)
	end

	local defaultPlanId = 0
	local talentName = ""
	local hideTalentPlane = false

	if bossMo then
		if self.isTeach then
			defaultPlanId = bossMo.trialTalentPlan

			local planCo = TowerConfig.instance:getTalentPlanConfig(self.bossId, bossMo.trialTalentPlan)

			talentName = planCo.planName
		elseif isLimitedTrial then
			defaultPlanId = TowerAssistBossModel.instance:getLimitedTrialBossLocalPlan(bossMo)

			local planCo = TowerConfig.instance:getTalentPlanConfig(self.bossId, defaultPlanId)

			talentName = planCo.planName
		elseif param.towerType == TowerEnum.TowerType.Boss and bossMo:getTempState() then
			hideTalentPlane = true
		else
			defaultPlanId = bossMo:getCurUseTalentPlan()

			local customPlanCount = tonumber(TowerConfig.instance:getTowerConstConfig(TowerEnum.ConstId.CustomTalentPlanCount))

			if defaultPlanId <= customPlanCount then
				local talentPlanInfos = bossMo:getTalentPlanInfos()

				for _, info in pairs(talentPlanInfos) do
					if info.planId == defaultPlanId then
						talentName = info.planName

						break
					end
				end
			else
				local planCo = TowerConfig.instance:getTalentPlanConfig(self.bossId, defaultPlanId)

				talentName = planCo.planName
			end
		end
	end

	gohelper.setActive(self._gotalentPlane, bossMo and not hideTalentPlane)

	self._txtTalentPlan.text = talentName
end

function TowerHeroGroupBossView:_checkRestrictBoss()
	local param = TowerModel.instance:getRecordFightParam()

	if param.isHeroGroupLock then
		return
	end

	if TowerModel.instance:isBossLocked(self.bossId) then
		return
	end

	if TowerModel.instance:isBossBan(self.bossId) or TowerModel.instance:isLimitTowerBossBan(param.towerType, param.towerId, self.bossId) then
		UIBlockMgr.instance:startBlock("removeTowerBoss")
		TaskDispatcher.runDelay(self._removeTowerBoss, self, 1.5)
	end
end

function TowerHeroGroupBossView:_removeTowerBoss()
	UIBlockMgr.instance:endBlock("removeTowerBoss")

	local param = TowerModel.instance:getRecordFightParam()

	if TowerModel.instance:isBossBan(self.bossId) or TowerModel.instance:isLimitTowerBossBan(param.towerType, param.towerId, self.bossId) then
		self.bossId = 0

		local curGroupMO = HeroGroupModel.instance:getCurGroupMO()

		curGroupMO:setAssistBossId(self.bossId)
		self:refreshBoss()
	end
end

function TowerHeroGroupBossView:onClose()
	return
end

function TowerHeroGroupBossView:onDestroyView()
	UIBlockMgr.instance:endBlock("removeTowerBoss")
	TaskDispatcher.cancelTask(self._removeTowerBoss, self)
end

return TowerHeroGroupBossView
