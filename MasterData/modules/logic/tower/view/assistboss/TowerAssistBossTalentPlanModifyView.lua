-- chunkname: @modules/logic/tower/view/assistboss/TowerAssistBossTalentPlanModifyView.lua

module("modules.logic.tower.view.assistboss.TowerAssistBossTalentPlanModifyView", package.seeall)

local TowerAssistBossTalentPlanModifyView = class("TowerAssistBossTalentPlanModifyView", BaseView)

function TowerAssistBossTalentPlanModifyView:onInitView()
	self._goBtnReset = gohelper.findChild(self.viewGO, "BOSS/layout/btn_reset")
	self._btnHideTalentPlan = gohelper.findChildClickWithAudio(self.viewGO, "#btn_hideTalentPlan")
	self._goTalentPlanSelect = gohelper.findChild(self.viewGO, "talentPlanSelect")
	self._btnShowTalentPlan = gohelper.findChildClickWithAudio(self.viewGO, "talentPlanSelect/#btn_showTalentPlan")
	self._txtTalentPlanName = gohelper.findChildTextMesh(self.viewGO, "talentPlanSelect/#btn_showTalentPlan/#txt_talentPlanName")
	self._goArrow = gohelper.findChild(self.viewGO, "talentPlanSelect/#btn_showTalentPlan/#go_arrow")
	self._btnChangeName = gohelper.findChildClickWithAudio(self.viewGO, "talentPlanSelect/#btn_changeName")
	self._goModifyIcon = gohelper.findChild(self.viewGO, "talentPlanSelect/#btn_changeName/#go_modifyIcon")
	self._goAutoIcon = gohelper.findChild(self.viewGO, "talentPlanSelect/#btn_changeName/#go_autoIcon")
	self._goTalentPlanContent = gohelper.findChild(self.viewGO, "talentPlanSelect/#go_talentPlanContent")
	self._goTalentPlanItem = gohelper.findChild(self.viewGO, "talentPlanSelect/#go_talentPlanContent/#go_talentPlanItem")
	self._goTalentPlanTip = gohelper.findChild(self.viewGO, "talentPlanSelect/#go_talentPlanTip")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function TowerAssistBossTalentPlanModifyView:addEvents()
	self._btnShowTalentPlan:AddClickListener(self._onBtnShowTalentPlan, self)
	self._btnHideTalentPlan:AddClickListener(self._onBtnHideTalentPlan, self)
	self._btnChangeName:AddClickListener(self._onBtnChangeName, self)
	self.addEventCb(self, TowerController.instance, TowerEvent.ChangeTalentPlan, self.changeTalentPlan, self)
	self.addEventCb(self, TowerController.instance, TowerEvent.RenameTalentPlan, self.RenameTalentPlan, self)
end

function TowerAssistBossTalentPlanModifyView:removeEvents()
	self._btnShowTalentPlan:RemoveClickListener()
	self._btnHideTalentPlan:RemoveClickListener()
	self._btnChangeName:RemoveClickListener()
	self.removeEventCb(self, TowerController.instance, TowerEvent.ChangeTalentPlan, self.changeTalentPlan, self)
	self.removeEventCb(self, TowerController.instance, TowerEvent.RenameTalentPlan, self.RenameTalentPlan, self)
end

function TowerAssistBossTalentPlanModifyView:_onBtnChangeName()
	if self.curSelectTalentPlanData.isAutoPlan == 1 then
		return
	end

	local param = {}

	param.bossId = self.bossId

	ViewMgr.instance:openView(ViewName.TowerBossTalentModifyNameView, param)
end

function TowerAssistBossTalentPlanModifyView:_onBtnShowTalentPlan()
	if not self.isShowTalentPlane then
		self:showTalentPlane()
		AudioMgr.instance:trigger(AudioEnum.Tower.play_ui_activity_dog_page)
	else
		self:hideTalentPlane()
		AudioMgr.instance:trigger(AudioEnum.Tower.play_ui_wenming_cut)
	end
end

function TowerAssistBossTalentPlanModifyView:_onBtnHideTalentPlan()
	self:hideTalentPlane()
	AudioMgr.instance:trigger(AudioEnum.Tower.play_ui_wenming_cut)
end

function TowerAssistBossTalentPlanModifyView:showTalentPlane()
	gohelper.setActive(self._goTalentPlanContent, true)
	gohelper.setActive(self._btnHideTalentPlan.gameObject, true)
	transformhelper.setLocalScale(self._goArrow.transform, 1, -1, 1)

	self.isShowTalentPlane = true
end

function TowerAssistBossTalentPlanModifyView:hideTalentPlane()
	gohelper.setActive(self._goTalentPlanContent, false)
	gohelper.setActive(self._btnHideTalentPlan.gameObject, false)
	transformhelper.setLocalScale(self._goArrow.transform, 1, 1, 1)

	self.isShowTalentPlane = false
end

function TowerAssistBossTalentPlanModifyView:_editableInitView()
	self.talentPlanItemList = self:getUserDataTb_()
	self.curSelectTalentPlanData = nil

	gohelper.setActive(self._goTalentPlanItem, false)
	self:hideTalentPlane()

	self.isShowTalentPlane = false
end

function TowerAssistBossTalentPlanModifyView:onUpdateParam()
	return
end

function TowerAssistBossTalentPlanModifyView:onOpen()
	self:initData()
	self:initTalentPlan()
	self:createOrRefreshTalentPlanItem()
	self:initCurSelectItem()
	self:_onBtnHideTalentPlan()
end

function TowerAssistBossTalentPlanModifyView:initData()
	self.bossId = self.viewParam.bossId
	self.bossMo = TowerAssistBossModel.instance:getBoss(self.bossId)
	self.bossLevel = self.bossMo.level
	self.talentTree = self.bossMo:getTalentTree()
end

function TowerAssistBossTalentPlanModifyView:initTalentPlan()
	self.talentPlanDataMap = self:getUserDataTb_()
	self.talentPlanDataList = self:getUserDataTb_()

	local curTowerType = TowerModel.instance:getCurTowerType()

	self.isTeach = curTowerType and curTowerType == TowerEnum.TowerType.Boss and self.bossMo.trialLevel > 0
	self.isTempBoss = curTowerType and curTowerType == TowerEnum.TowerType.Boss and self.bossMo:getTempState()

	local limitedTrialLevel = tonumber(TowerConfig.instance:getTowerConstConfig(TowerEnum.ConstId.BalanceBossLevel))

	self.isLimitedTrial = curTowerType and curTowerType == TowerEnum.TowerType.Limited and self.bossMo.trialLevel > 0 and limitedTrialLevel > self.bossMo.level

	gohelper.setActive(self._goTalentPlanSelect, true)

	if self.isTeach then
		local trialPlanId = self.bossMo.trialTalentPlan
		local planCo = TowerConfig.instance:getTalentPlanConfig(self.bossId, trialPlanId)

		self:addAutoTalentPlan({
			planCo
		})
	elseif self.isLimitedTrial then
		self:addAutoTalentPlan()
	elseif self.isTempBoss then
		gohelper.setActive(self._goTalentPlanSelect, false)
	else
		self:addAutoTalentPlan()
		self:addCustomTalentPlan()
	end

	table.sort(self.talentPlanDataList, function(a, b)
		if a.isAutoPlan ~= b.isAutoPlan then
			return a.isAutoPlan > b.isAutoPlan
		end

		return a.planId < b.planId
	end)
end

function TowerAssistBossTalentPlanModifyView:addAutoTalentPlan(planCoList)
	if not planCoList then
		::label_15_0::

		local talentPlanCoList = TowerConfig.instance:getAllTalentPlanConfig(self.bossId)

		for index, config in ipairs(talentPlanCoList) do
			local planData = {}

			planData.planId = config.planId
			planData.talentIds = TowerConfig.instance:getTalentPlanNodeIds(self.bossId, planData.planId, self.bossLevel)
			planData.planName = config.planName
			planData.isAutoPlan = 1
			self.talentPlanDataMap[planData.planId] = planData

			table.insert(self.talentPlanDataList, planData)
		end
	end
end

function TowerAssistBossTalentPlanModifyView:addCustomTalentPlan()
	local talentPlanInfos = self.bossMo:getTalentPlanInfos()

	for index, info in pairs(talentPlanInfos) do
		local planData = {}

		planData.planId = info.planId
		planData.talentIds = info.talentIds
		planData.planName = info.planName
		planData.isAutoPlan = 0
		self.talentPlanDataMap[planData.planId] = planData

		table.insert(self.talentPlanDataList, planData)
	end
end

function TowerAssistBossTalentPlanModifyView:createOrRefreshTalentPlanItem()
	for i = 1, #self.talentPlanDataList do
		local talentPlanItem = self.talentPlanItemList[i]

		if not talentPlanItem then
			talentPlanItem = {
				data = self.talentPlanDataList[i],
				go = gohelper.cloneInPlace(self._goTalentPlanItem)
			}
			talentPlanItem.goSelect = gohelper.findChild(talentPlanItem.go, "go_select")
			talentPlanItem.goAutoTypeIcon = gohelper.findChild(talentPlanItem.go, "txt_planName/go_autoTypeIcon")
			talentPlanItem.txtPlanName = gohelper.findChildTextMesh(talentPlanItem.go, "txt_planName")
			talentPlanItem.btnClick = gohelper.findChildClickWithAudio(talentPlanItem.go, "btn_click")

			talentPlanItem.btnClick:AddClickListener(self.onTalentPlanItemClick, self, talentPlanItem)

			self.talentPlanItemList[i] = talentPlanItem
		end

		gohelper.setActive(talentPlanItem.go, true)

		local isAutoType = talentPlanItem.data.isAutoPlan == 1

		SLFramework.UGUI.GuiHelper.SetColor(talentPlanItem.txtPlanName, isAutoType and "#EFB785" or "#C3BEB6")

		talentPlanItem.txtPlanName.text = talentPlanItem.data.planName

		gohelper.setActive(talentPlanItem.goAutoTypeIcon, isAutoType)
	end
end

function TowerAssistBossTalentPlanModifyView:initCurSelectItem()
	if self.isTempBoss then
		gohelper.setActive(self._goBtnReset, false)

		if not self.isTeach then
			return
		end
	end

	local defaultPlanId = 0

	defaultPlanId = self.isTeach and self.bossMo.trialTalentPlan or self.isLimitedTrial and TowerAssistBossModel.instance:getLimitedTrialBossLocalPlan(self.bossMo) or self.bossMo:getCurUseTalentPlan()

	for index, planData in pairs(self.talentPlanDataList) do
		if planData.planId == defaultPlanId then
			self.curSelectTalentPlanData = planData

			break
		end
	end

	if not self.curSelectTalentPlanData then
		logError("当前保存的天赋id不存在： " .. defaultPlanId)

		self.curSelectTalentPlanData = self.talentPlanDataList[1]
	end

	self:refreshPlanUI(self.curSelectTalentPlanData)
end

function TowerAssistBossTalentPlanModifyView:onTalentPlanItemClick(item)
	if self.curSelectTalentPlanData and self.curSelectTalentPlanData.planId == item.data.planId then
		self:_onBtnHideTalentPlan()

		return
	end

	self.curSelectTalentPlanData = item.data

	if self.isLimitedTrial then
		local info = {}

		info.planId = self.curSelectTalentPlanData.planId

		local saveKey = TowerAssistBossModel.instance:getLimitedTrialBossSaveKey(self.bossMo)

		TowerController.instance:setPlayerPrefs(saveKey, self.curSelectTalentPlanData.planId)
		self:changeTalentPlan(info)
	elseif self.isTeach or self.isTempBoss then
		-- block empty
	else
		TowerRpc.instance:sendTowerChangeTalentPlanRequest(self.bossId, item.data.planId)
	end

	self:_onBtnHideTalentPlan()
end

function TowerAssistBossTalentPlanModifyView:changeTalentPlan(info)
	local selectPlanId = info.planId

	self.curSelectTalentPlanData = self.talentPlanDataMap[selectPlanId]

	self:refreshPlanUI(self.curSelectTalentPlanData)
	self.bossMo:setCurUseTalentPlan(self.curSelectTalentPlanData.planId, self.isLimitedTrial)
	TowerController.instance:dispatchEvent(TowerEvent.RefreshTalent)
	GameFacade.showToast(ToastEnum.TowerBossTalentPlanChange)
end

function TowerAssistBossTalentPlanModifyView:refreshPlanUI(planData)
	self.curSelectTalentPlanData = planData

	for index, talentPlanItem in pairs(self.talentPlanItemList) do
		local isAutoType = talentPlanItem.data.isAutoPlan == 1
		local isSelect = talentPlanItem.data.planId == planData.planId

		gohelper.setActive(talentPlanItem.goSelect, isSelect)

		if isAutoType then
			SLFramework.UGUI.GuiHelper.SetColor(talentPlanItem.txtPlanName, "#EFB785")
		else
			SLFramework.UGUI.GuiHelper.SetColor(talentPlanItem.txtPlanName, isSelect and "#EAF8FF" or "#C3BEB6")
		end
	end

	local isSelectAutoType = self.curSelectTalentPlanData.isAutoPlan == 1

	self._txtTalentPlanName.text = self.curSelectTalentPlanData.planName

	gohelper.setActive(self._goModifyIcon, not isSelectAutoType)
	gohelper.setActive(self._goAutoIcon, isSelectAutoType)
	gohelper.setActive(self._goTalentPlanTip, isSelectAutoType)
	gohelper.setActive(self._goBtnReset, not isSelectAutoType)
	TowerAssistBossTalentListModel.instance:setAutoTalentState(isSelectAutoType)
end

function TowerAssistBossTalentPlanModifyView:saveLimitedTalent()
	local saveKey = self:getLimitedTrialBossSaveKey(self.bossMO)

	TowerController.instance:setPlayerPrefs(saveKey, self.curSelectTalentPlanData.planId)
end

function TowerAssistBossTalentPlanModifyView:RenameTalentPlan(name)
	self.curSelectTalentPlanData.planName = name

	for index, talentPlanItem in pairs(self.talentPlanItemList) do
		if talentPlanItem.data.planId == self.curSelectTalentPlanData.planId then
			talentPlanItem.txtPlanName.text = name

			break
		end
	end

	self._txtTalentPlanName.text = name
end

function TowerAssistBossTalentPlanModifyView:onClose()
	for _, talentPlanItem in ipairs(self.talentPlanItemList) do
		talentPlanItem.btnClick:RemoveClickListener()
	end
end

function TowerAssistBossTalentPlanModifyView:onDestroyView()
	return
end

return TowerAssistBossTalentPlanModifyView
