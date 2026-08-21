-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\MainState\\BagWearPart.lua

local BtnEquipWearingPanel = require("UI/MainState/BtnEquipWearingPanel")
local FilterSelectPanel = require("UI/MainState/FilterSelectPanel")
local FilterBtnSelPanel = require("UI/MainState/FilterBtnSelPanel")
local FilterMultiSelectPanel = require("UI/MainState/FilterMultiSelectPanel")
local ResClientNotice = require("ClientData/ResClientNotice")
local ResClientConfirm = require("ClientData/ResClientConfirm")
local UserData = require("Helper/UserData")
local strClassName = "BtnEquipPlan"
local BtnEquipPlan = Class(strClassName, UIControls.ScrollViewLoopCell)

function BtnEquipPlan:ctor()
	self:initUI()
end

function BtnEquipPlan:initUI()
	self.txtName = UIControls.Label(self, "TxtName")
	self.imgNew = UIControls.Image(self, "ImgNew")
	self.btnSelf = UIControls.Button(self, "")

	self.btnSelf:addEventClick(self.onBtnSelfClick)
end

function BtnEquipPlan:setSelectCallback(selectCallback)
	self.selectCallback = selectCallback
end

function BtnEquipPlan:onBtnSelfClick()
	if self.plan and self.selectCallback then
		self.selectCallback(self)
	end
end

function BtnEquipPlan:setPlan(plan)
	self.plan = plan

	self.txtName:setText(self.plan.name)
	self.txtName:setVisible(self.plan.id ~= Const.EQUIP_PLAN_CREATE_ID)
	self.imgNew:setVisible(self.plan.id == Const.EQUIP_PLAN_CREATE_ID)
	self.btnSelf:setEnable(self.plan.id ~= self.mWindow.panelWear.selectPlanId)
end

local strClassName = "BagWearPart"
local BagWearPart = Class(strClassName, UIControls.Child)

function BagWearPart:ctor()
	self:initUI()
end

function BagWearPart:initUI()
	self.cells = {}
	self.scroll = UIControls.ScrollViewLoopV(self, "ItemListScroll")

	self.scroll:addEventCellChanged(self.onCellChanged)

	self.imgNone = UIControls.Image(self, "ImgNone")
	self.btnEquipOff = UIControls.Button(self, "BtnEquipOff")

	self.btnEquipOff:addEventClick(self.onBtnEquipOffClick)

	self.btnSelectPlan = UIControls.Button(self, "ProgramPanel/BtnProgramName")

	self.btnSelectPlan:addEventClick(self.onBtnSelectPlanClick)

	self.txtPlanName = UIControls.Label(self, "ProgramPanel/BtnProgramName/TxtName")
	self.btnPetWear = UIControls.Button(self, "ProgramPanel/BtnPetWearing")

	self.btnPetWear:addEventClick(self.onClickBtnPetWear)

	self.petWearRed = UIControls.RedDot(self, "ProgramPanel/BtnPetWearing/IconNew")
	self.btnUsePlan = UIControls.Button(self, "ProgramPanel/BtnUse")

	self.btnUsePlan:addEventClick(self.onBtnUsePlanClick)

	self.btnRenamePlan = UIControls.Button(self, "ProgramPanel/BtnRename")

	self.btnRenamePlan:addEventClick(self.onBtnRenamePlanClick)

	self.btnDeletePlan = UIControls.Button(self, "ProgramPanel/BtnDelete")

	self.btnDeletePlan:addEventClick(self.onBtnDeletePlanClick)

	self.btnSave = UIControls.Button(self, "BtnSave")

	self.btnSave:addEventClick(self.onBtnSaveClick)

	self.btnCopyNew = UIControls.Button(self, "BtnCopyNew", "Text")

	self.btnCopyNew:addEventClick(self.onBtnCopyNewClick)
	self.btnCopyNew:setText(ResClientNotice[611].notice)

	self.btnSensor = UIControls.Button(self, "BtnSensor")

	self.btnSensor:addEventClick(self.onBtnSensorClick)

	self.panelPlanList = UIControls.Panel(self, "ProgramListPanel")
	self.imgStateTitleBar = UIControls.RawImage(self, "ProgramPanel")
	self.selectPlanId = 0
	self.btnEquipPlanList = {}
	self.scrollPlanList = UIControls.ScrollViewLoopV(self, "ProgramListPanel")

	self.scrollPlanList:addEventCellChanged(self.onPlanListChanged)
	self:initPlanList()

	self.filterSelectPanel = FilterSelectPanel(self, "ListSelectPanel")
	self.filterMultiSelectPanel = FilterMultiSelectPanel(self, "ListTeamSelPanel")
	self.filterBtnSelPanel = FilterBtnSelPanel(self, "SelPanel", self.filterSelectPanel, self.filterMultiSelectPanel, Slot(self.filterHeroCard, self), UIConst.WEAR_FILTER_PANEL_MAP)

	self.filterBtnSelPanel:initBtnSelPanel()

	if UIControls.checkControlFunc(self, "ProgramPanel/BgWearing") then
		self.bgWear = UIControls.Panel(self, "ProgramPanel/BgWearing")
		self.bgEdit = UIControls.Panel(self, "ProgramPanel/BgEdit")
	end

	if UIControls.checkControlFunc(self, "ProgramPanel/BtnRune") then
		self.btnRune = UIControls.Button(self, "ProgramPanel/BtnRune")

		self.btnRune:addEventClick(self.onBtnRuneClick)
		self.btnRune:setVisible(CurAvatar:petRuneSystemEnable())
	end
end

local function _sortPlanList(planA, planB)
	return planA.id < planB.id
end

function BagWearPart:initPlanList()
	self.maxPlanCount = CurAvatar:addEquipMaxPlanCount()
	self.planDataList = {
		{
			id = 0,
			name = Lang.get(551)
		}
	}

	for _, plan in pairs(CurAvatar.equipPlanDic) do
		table.insert(self.planDataList, plan)
	end

	table.sort(self.planDataList, _sortPlanList)

	local canCreatePlan = CurAvatar:checkPlanCountNotOverMax()

	if canCreatePlan then
		table.insert(self.planDataList, 1, {
			name = Lang.get(30467),
			id = Const.EQUIP_PLAN_CREATE_ID
		})
	end

	self.scrollPlanList:setTotalCount(#self.planDataList, nil, false)
end

function BagWearPart:addNewPlan(planData)
	self:initPlanList()

	self.selectPlanId = planData.id
	self.planData = utils.deepcopy(planData)

	self.scrollPlanList:setTotalCount(#self.planDataList)
	self.panelPlanList:setVisible(false)
	self.btnSensor:setVisible(false)

	self.filterCheckFunc = self.filterBtnSelPanel:filterAllFuncNoCallBack()

	self:refreshData(true)

	self.canSave = false

	self.btnSave:setVisible(false)
	self.btnUsePlan:setVisible(true)
end

function BagWearPart:updatePlan(planData)
	if not self.isEditPlan or not self.planData or self.planData.id ~= planData.id then
		return
	end

	self.canApply = true

	if UIManager.tryGetUI("bagPetWearDlg") or UIManager.tryGetUI("petRuneMainDlg") then
		self.planData.petWearDic = planData.petWearDic
		self.planData.runeList = planData.runeList

		return
	end

	self.selectPlanId = planData.id
	self.planData = utils.deepcopy(planData)

	self.panelPlanList:setVisible(false)
	self.btnSensor:setVisible(false)

	self.canSave = false

	self.btnSave:setVisible(false)

	if self.isEditPlan then
		self.btnUsePlan:setVisible(true)
	else
		self.btnUsePlan:setVisible(false)
	end
end

function BagWearPart:onPlanListChanged(sender, targetCell, newIdx)
	targetCell = targetCell or BtnEquipPlan(sender, "System/Bag/BtnEquipProgram", newIdx)

	if not self.planDataList or #self.planDataList == 0 then
		return
	end

	if self.planDataList[newIdx] ~= nil then
		targetCell:setPlan(self.planDataList[newIdx])
		targetCell:setSelectCallback(Slot(self.selectPlanCallBack, self))
	end

	self.btnEquipPlanList[newIdx] = targetCell
end

function BagWearPart:selectPlanCallBack(btnEquipPlan)
	if btnEquipPlan.plan.id == Const.EQUIP_PLAN_CREATE_ID then
		local editProgramDlg = UIManager.getUI("editProgramDlg", true)

		if self.battleType then
			editProgramDlg:setPlan(btnEquipPlan.plan, nil, self.battleType)
		else
			editProgramDlg:setPlan(btnEquipPlan.plan)
		end
	else
		self.selectPlanId = btnEquipPlan.plan.id
		self.planData = nil

		self:setPlanListPanelVisible(false)
		self.scrollPlanList:setTotalCount(#self.planDataList)

		self.canSave = false
		self.filterCheckFunc = self.filterBtnSelPanel:filterAllFuncNoCallBack()

		self:refreshData(true)
	end

	self.canApply = false
end

function BagWearPart:revertToCurWear()
	if self.selectPlanId ~= 0 and self.planData ~= nil then
		self.selectPlanId = 0
		self.planData = nil

		self:setPlanListPanelVisible(false)

		self.filterCheckFunc = self.filterBtnSelPanel:filterAllFuncNoCallBack()

		self.scrollPlanList:setTotalCount(#self.planDataList)

		self.canSave = false

		self:refreshData(true)
	end
end

function BagWearPart:onBtnSaveClick(sender, isSync)
	if self.planData then
		CurAvatar.isSaveingPlan = true

		local planItem = CurAvatar:getPlanItembyPlanData(self.planData)
		local rpcData = {
			{
				item_id = self.planData.id,
				item = planItem,
				name = planItem.name
			}
		}
		local update = 0

		if isSync then
			local oldPlanData = CurAvatar.equipPlanDic[self.planData.id]
			local syncPlans = CurAvatar:getNeedUpdateHeroInAllProgram(oldPlanData, self.planData)

			for i, plan in pairs(syncPlans or {}) do
				table.insert(rpcData, plan)
			end
		end

		RPC.equipSchemeUpdate(rpcData, CurAvatar.equipPlanVersion, update)
	end
end

function BagWearPart:onBtnCopyNewClick()
	local editPlanListDlg = UIManager.getUI("editPlanListDlg", true)

	editPlanListDlg:setData(self.battleType)
end

function BagWearPart:onBtnRenamePlanClick()
	local editProgramDlg = UIManager.getUI("editProgramDlg", true)

	editProgramDlg:setPlan(self.planData)
end

function BagWearPart:onBtnDeletePlanClick()
	if self.planData then
		local function yesFunc()
			RPC.equipSchemeDelete(self.planData.id, CurAvatar.equipPlanVersion)
		end

		local msgContent = string.format(Lang.get(30466), self.planData.name)

		UIManager.showConfirm(UIConst.CONFIRM_TWOBTN, Lang.get(5), msgContent, yesFunc, nil, -1)
	end
end

function BagWearPart:onBtnUsePlanClick()
	if self.planData then
		RPC.equipSchemeApply(self.planData.id, CurAvatar.equipPlanVersion)

		self.canApply = false
	end
end

function BagWearPart:onBtnSensorClick()
	self:setPlanListPanelVisible(false)
end

function BagWearPart:setPlanListPanelVisible(value)
	self.panelPlanList:setVisible(value)
	self.btnSensor:setVisible(value)
end

function BagWearPart:onBtnSelectPlanClick()
	local function func()
		self:setPlanListPanelVisible(true)
	end

	self:closeDuel(Slot(func, self))
end

function BagWearPart:closeDuel(cb)
	if not self.isEditPlan then
		local isSame = CurAvatar:compareCurWearAndLastUsePlan(CurAvatar.oldCurWearData)

		if not isSame and CurAvatar.lastUsePlanID and CurAvatar.equipPlanDic[CurAvatar.lastUsePlanID] then
			CurAvatar.oldCurWearData = CurAvatar:genNewPlanData(Lang.get(551))
			self.opPlanId = CurAvatar.lastUsePlanID

			local oldPlanData = CurAvatar.equipPlanDic[self.opPlanId]

			self.newPlanData = CurAvatar:genNewPlanData(oldPlanData.name)
			self.syncPlans = CurAvatar:getNeedUpdateHeroInAllProgram(oldPlanData, self.newPlanData)
			self.isShowSync = false

			if utils.getTableElemCount(self.syncPlans) > 0 then
				self.isShowSync = true
			end

			local function yesFunc()
				local planItem = CurAvatar:getPlanItembyPlanData(self.newPlanData)
				local rpcData = {
					{
						item_id = self.opPlanId,
						item = planItem,
						name = planItem.name
					}
				}
				local update = 1
				local isSync = UserData.loadCommonData("DefaultSync")

				if isSync == "1" and self.isShowSync then
					for i, plan in pairs(self.syncPlans or {}) do
						table.insert(rpcData, plan)
					end
				end

				RPC.equipSchemeUpdate(rpcData, CurAvatar.equipPlanVersion, update)

				if cb then
					cb()
				end
			end

			local function otherFunc()
				local function func()
					if cb then
						cb()
					end
				end

				local editProgramDlg = UIManager.getUI("editProgramDlg", true)

				if self.battleType then
					editProgramDlg:setPlan({
						name = Lang.get(30467),
						id = Const.EQUIP_PLAN_CREATE_ID
					}, Slot(func, self), self.battleType)
				else
					editProgramDlg:setPlan({
						name = Lang.get(30467),
						id = Const.EQUIP_PLAN_CREATE_ID
					}, Slot(func, self))
				end
			end

			local function noFunc()
				if cb then
					cb()
				end
			end

			local isShowOther = CurAvatar:checkPlanCountNotOverMax()

			UIManager.showConfirmWithId(1123, noFunc, Slot(yesFunc, self), Slot(otherFunc, self))

			local ui = UIManager.tryGetUI("confirmui")

			if ui and ui.textContent then
				ui.textContent:setText(string.format(ResClientConfirm[1123].content, oldPlanData.name))
			end

			if not isShowOther and ui and ui.btnOtherFunc then
				ui.btnOtherFunc:setVisible(false)
			end
		elseif cb then
			cb()
		end
	elseif self.canSave then
		self.opPlanId = self.planData.id

		local oldPlanData = CurAvatar.equipPlanDic[self.opPlanId]

		self.newPlanData = self.planData
		self.syncPlans = CurAvatar:getNeedUpdateHeroInAllProgram(oldPlanData, self.newPlanData)
		self.isShowSync = false

		if utils.getTableElemCount(self.syncPlans) > 0 then
			self.isShowSync = true
		end

		local function yesFunc()
			local isSync = UserData.loadCommonData("DefaultSync")

			if isSync == "1" and self.isShowSync then
				self:onBtnSaveClick(nil, true)
			else
				self:onBtnSaveClick()
			end
		end

		local function otherFunc()
			if cb then
				cb()
			end
		end

		local coverPlanPanel = UIManager.getUI("coverAndSyncPlan", true)

		coverPlanPanel:show(self.planData.id, 1065, Slot(yesFunc, self), nil, Slot(otherFunc, self), true, self.isShowSync)
	elseif CurAvatar.lastUsePlanID and self.planData.id == CurAvatar.lastUsePlanID then
		if self.canApply then
			self.canApply = false

			local function yesFunc()
				RPC.equipSchemeApply(self.planData.id, CurAvatar.equipPlanVersion)

				if cb then
					cb()
				end
			end

			local function noFunc()
				if cb then
					cb()
				end
			end

			local msgContent = utils.format(ResClientConfirm[1061].content, self.planData.name)

			UIManager.showConfirm(UIConst.CONFIRM_TWOBTN, nil, msgContent, Slot(yesFunc, self), Slot(noFunc, self), -1)
		elseif cb then
			cb()
		end
	elseif cb then
		cb()
	end
end

function BagWearPart:trySwitchRelicBgm()
	return
end

local function confirmToOffAllEquips(offInfo)
	local heroGids = offInfo[1]
	local offEvoEquip = offInfo[2]
	local equipedNum = offInfo[3]

	if equipedNum and equipedNum == 0 and offEvoEquip == Const.HREO_OFF_ALL_EQUIPS_TYPE_NORMAL then
		MsgManager.clientNotice(296)

		return
	end

	RPC.heroOffWears(offEvoEquip, heroGids)
end

local function confirmToOffAllPlanEquips(self)
	for _, hero in ipairs(self.filterList) do
		self:clearHeroWearInfo(hero)
	end

	self.canSave = true

	self:updateWearList()
	MsgManager.clientNotice(296)
end

function BagWearPart:clearHeroWearInfo(hero, refreshUI)
	if self.planData and self.planData.equipInfoDic[hero.gid] then
		for _, gid in ipairs(self.planData.equipInfoDic[hero.gid].equipGids) do
			if self.bagWears.equips and self.bagWears.equips[gid] then
				self.bagWears.equips[gid].inWearing = nil
			end
		end

		if self.bagWears.artifacts and self.bagWears.artifacts[self.planData.equipInfoDic[hero.gid].artifactGid] then
			self.bagWears.artifacts[self.planData.equipInfoDic[hero.gid].artifactGid].inWearing = nil
		end

		if self.bagWears.relics and self.bagWears.relics[self.planData.equipInfoDic[hero.gid].relicId] then
			self.bagWears.relics[self.planData.equipInfoDic[hero.gid].relicId].inWearing = nil
		end

		self.planData.equipInfoDic[hero.gid] = nil

		self:updateWearedHero(hero)

		if refreshUI then
			self.canSave = true

			self:updateWearList()
		end
	else
		return true
	end
end

function BagWearPart:onBtnEquipOffClick()
	if self.isEditPlan then
		if self.filterList and #self.filterList > 0 then
			local allEquipNum = 0

			for _, hero in ipairs(self.filterList) do
				local tempEquips = hero:getEquips()

				for _, equip in pairs(tempEquips) do
					allEquipNum = allEquipNum + 1
				end

				local artifact = hero:getArtifact()

				if artifact then
					allEquipNum = allEquipNum + 1
				end

				local relic = hero:getRelic()

				if relic then
					allEquipNum = allEquipNum + 1
				end
			end

			if allEquipNum == 0 then
				MsgManager.clientNotice(298)
			else
				UIManager.showConfirmWithId(1015, Slot(confirmToOffAllPlanEquips, self))
			end
		else
			MsgManager.clientNotice(352)
		end
	elseif self.filterList and #self.filterList > 0 then
		local heroGids = {}
		local costId = 0
		local costNum = 0
		local otherNum = 0
		local allEquipNum = 0
		local unEvoEquipNum = 0

		for _, hero in ipairs(self.filterList) do
			table.insert(heroGids, hero.gid)

			local tempEquips = hero:getEquips()

			for _, equip in pairs(tempEquips) do
				allEquipNum = allEquipNum + 1

				if equip.evolve > 0 then
					local needMaterial = equip:getOffMaterialNeed()

					costId = needMaterial[1]
					costNum = costNum + needMaterial[2]
				else
					unEvoEquipNum = unEvoEquipNum + 1
				end
			end

			local artifact = hero:getArtifact()

			if artifact then
				allEquipNum = allEquipNum + 1
				otherNum = otherNum + 1
			end

			local relic = hero:getRelic()

			if relic then
				allEquipNum = allEquipNum + 1
				otherNum = otherNum + 1
			end
		end

		if allEquipNum == 0 then
			MsgManager.clientNotice(298)
		else
			UIManager.showConfirmWithId(1015, Slot(confirmToOffAllEquips, {
				heroGids,
				Const.HREO_OFF_ALL_EQUIPS_TYPE_ALL
			}))
		end
	else
		MsgManager.clientNotice(352)
	end
end

function BagWearPart:setEquipWearingPanelData(name, heroInfos, battleType, petId)
	if name then
		self.equipWearingPanelName = name
	end

	self.heroInfos = heroInfos
	self.battleType = battleType
	self.petId = petId
end

function BagWearPart:onCellChanged(sender, targetCell, newIdx)
	local panelName = "BtnEquipWearingPanel"

	if self.equipWearingPanelName then
		panelName = self.equipWearingPanelName
	end

	if targetCell == nil then
		targetCell = BtnEquipWearingPanel(sender, "System/Bag/" .. panelName, newIdx)
	else
		self.cells[targetCell.mIndex] = nil
		targetCell.mIndex = newIdx
	end

	self.cells[newIdx] = targetCell

	targetCell:setHighlightTeamDic(self.highLightTeamDic)
	targetCell:setHero(self.filterList[newIdx], self.bagEquipMaxRankDic, self.bagArtifactMaxRankDic, self.bagCustomMadeArtifactDic, self.isEditPlan, self.bagWears)
end

function BagWearPart:refreshData(gotoTop)
	if not CurAvatar then
		return
	end

	self.isEditPlan = nil
	self.bagWears = {}

	if self.selectPlanId ~= 0 and not self.planData then
		local planData = CurAvatar:getEquipPlanData(self.selectPlanId)

		if planData then
			self.planData = utils.deepcopy(planData)
		end
	end

	self.preReplaceHero = nil

	if self.planData then
		self.isEditPlan = true
		self.wearedHeroList, self.bagEquips, self.bagArtifacts, self.bagRelics = CurAvatar:getWearedOrInTeamHero(self.planData, self.heroInfos)
		self.bagWears.equips = self.bagEquips
		self.bagWears.artifacts = self.bagArtifacts
		self.bagWears.relics = self.bagRelics
	else
		self.wearedHeroList = CurAvatar:getWearedOrInTeamHero(nil, self.heroInfos)
		CurAvatar.oldCurWearData = CurAvatar:genNewPlanData(Lang.get(551))
	end

	self.highLightTeamDic = {}

	local activitySeasonTowerInfoDlg = UIManager.getUI("activitySeasonTowerInfoDlg", nil, false)

	if activitySeasonTowerInfoDlg then
		self.highLightTeamDic = activitySeasonTowerInfoDlg:getLimitTeamDic()
	end

	self:updateWearList(gotoTop)
	self:trySwitchRelicBgm()
	self:refreshBtnPetWear()
end

function BagWearPart:refreshNoSort()
	if not CurAvatar or self.isEditPlan and self.planData then
		return
	end

	self.isEditPlan = nil
	self.bagWears = {}
	self.preReplaceHero = nil

	local preHeroList = self.wearedHeroList
	local newWearedList = CurAvatar:getWearedOrInTeamHero(nil, self.heroInfos)
	local newWearedDic = {}

	for _, hero in ipairs(newWearedList) do
		newWearedDic[hero.gid] = hero
	end

	local noSortNewWearedList = {}

	for _, hero in ipairs(preHeroList) do
		if newWearedDic[hero.gid] then
			table.insert(noSortNewWearedList, newWearedDic[hero.gid])

			newWearedDic[hero.gid] = nil
		elseif CurAvatar.heroDic[hero.gid] then
			CurAvatar.heroDic[hero.gid].weared = 0

			table.insert(noSortNewWearedList, CurAvatar.heroDic[hero.gid])
		end
	end

	for _, hero in pairs(newWearedDic) do
		if #hero.equipList > 0 or self.bagArtifacts[hero.artifactGid] or self.bagRelics[hero.relicId] then
			hero.weared = 1
		else
			hero.weared = 0
		end

		table.insert(noSortNewWearedList, hero)
	end

	self.wearedHeroList = noSortNewWearedList

	self:updateWearList()
	self:trySwitchRelicBgm()
end

function BagWearPart:checkCanEditHero(hero)
	if self.isEditPlan and self.planData and self.planData.equipInfoDic and not self.planData.equipInfoDic[hero.gid] then
		return utils.getTableElemCount(self.planData.equipInfoDic) < Const.EQUIP_PLAN_MAX_HERO_COUNT
	else
		return true
	end
end

function BagWearPart:changePlanData(hero, equipGids, artifactGid, relicId, refreshUI)
	if not self.planData.equipInfoDic[hero.gid] then
		self.planData.equipInfoDic[hero.gid] = {}
		self.planData.equipInfoDic[hero.gid].equipGids = {}
		self.planData.equipInfoDic[hero.gid].artifactGid = 0
		self.planData.equipInfoDic[hero.gid].relicId = 0
	end

	if equipGids then
		for _, gid in ipairs(self.planData.equipInfoDic[hero.gid].equipGids) do
			if self.bagWears.equips and self.bagWears.equips[gid] then
				self.bagWears.equips[gid].inWearing = nil
			end
		end

		self.planData.equipInfoDic[hero.gid].equipGids = equipGids
	end

	if artifactGid then
		if self.bagWears.artifacts and self.bagWears.artifacts[self.planData.equipInfoDic[hero.gid].artifactGid] then
			self.bagWears.artifacts[self.planData.equipInfoDic[hero.gid].artifactGid].inWearing = nil
		end

		self.planData.equipInfoDic[hero.gid].artifactGid = artifactGid
	end

	if relicId then
		if self.bagWears.relics and self.bagWears.relics[self.planData.equipInfoDic[hero.gid].relicId] then
			self.bagWears.relics[self.planData.equipInfoDic[hero.gid].relicId].inWearing = nil
		end

		self.planData.equipInfoDic[hero.gid].relicId = relicId
	end

	local hero = CurAvatar:getEquipPlanHero(self.planData, hero, self.bagWears.equips, self.bagWears.artifacts, self.bagWears.relics)

	if #hero:getEquipedList() == 0 then
		self:clearHeroWearInfo(hero, refreshUI)

		return
	else
		self:updateWearedHero(hero)
	end

	if refreshUI then
		self.canSave = true

		self:updateWearList()
	end
end

function BagWearPart:playEquipPartEfx(heroGid, effectPartList, suitEffPartList)
	if self.mWindow:isInShow() and not self.mWindow.mOpening then
		self:playPartEfx(heroGid, effectPartList, suitEffPartList)
	else
		self.effectPartList = effectPartList
		self.suitEffPartList = suitEffPartList
		self.heroGid = heroGid
	end
end

function BagWearPart:playPartEfx(heroGid, effectPartList, suitEffPartList)
	effectPartList = effectPartList or self.effectPartList
	suitEffPartList = suitEffPartList or self.suitEffPartList
	heroGid = heroGid or self.heroGid

	if heroGid then
		for _, cell in pairs(self.cells) do
			if cell.hero.gid == heroGid then
				cell:playPartEfx(effectPartList, suitEffPartList)
			end
		end

		self.effectPartList = nil
		self.suitEffPartList = nil
		self.heroGid = nil
	end
end

function BagWearPart:playEquipPartWearAnim(heroGid, playAnimParts, type)
	playAnimParts = playAnimParts or self.playAnimParts
	heroGid = heroGid or self.heroGid

	if heroGid then
		for _, cell in pairs(self.cells) do
			if cell.hero.gid == heroGid and cell.gridHero and cell.gridHero.heroEquipInfoPanel then
				cell.gridHero.heroEquipInfoPanel:playWearOrOffAnim(playAnimParts, type)
			end
		end
	end
end

function BagWearPart:clearEfx()
	self.effectPartList = nil
	self.suitEffPartList = nil
	self.heroGid = nil
end

function BagWearPart:updateWearedHero(hero)
	for idx, _hero in ipairs(self.wearedHeroList) do
		if _hero.gid == hero.gid then
			self.wearedHeroList[idx] = CurAvatar:getEquipPlanHero(self.planData, _hero, self.bagWears.equips, self.bagWears.artifacts, self.bagWears.relics)

			if not CurAvatar:canBeQuickWear(self.wearedHeroList[idx]) then
				table.remove(self.wearedHeroList, idx)
			end

			return self.wearedHeroList[idx]
		end
	end
end

function BagWearPart:updateWearList(gotoTop)
	if self.filterCheckFunc then
		self:filterHeroCard(self.filterCheckFunc, nil, gotoTop)
	else
		self.filterList = self.wearedHeroList

		self:updateScroll(gotoTop)
	end
end

function BagWearPart:filterHeroCard(filterCheckFunc, toggleGroupTypeFilter, gotoTop)
	self.filterCheckFunc = filterCheckFunc
	self.toggleGroupTypeFilter = toggleGroupTypeFilter

	local tempFilterList = {}

	for _, hero in ipairs(self.wearedHeroList) do
		if self.filterCheckFunc(hero) then
			table.insert(tempFilterList, hero)
		end
	end

	self.filterList = tempFilterList

	self:updateScroll(gotoTop)
end

function BagWearPart:checkEquipOffVisible()
	self.btnEquipOff:setVisible(false)
	self.btnCopyNew:setVisible(false)

	for _, targetCell in pairs(self.cells) do
		if targetCell.panelStatus == Const.HERO_WEARPANEL_STATUS_CANPRE or targetCell.panelStatus == Const.HERO_WEARPANEL_STATUS_NONE then
			self.btnCopyNew:setVisible(self.isEditPlan ~= true)
			self.btnEquipOff:setVisible(true)

			break
		end
	end
end

function BagWearPart:checkHaveDragHeroInFilterList(heroGid)
	for _, hero in ipairs(self.filterList or {}) do
		if hero.gid == heroGid then
			return true
		end
	end

	return false
end

function BagWearPart:updateScroll(gotoTop)
	if self.isEditPlan then
		self.bagEquipMaxRankDic, self.bagArtifactMaxRankDic, self.bagCustomMadeArtifactDic = CurAvatar:getBagEquipMaxRank(nil, self.bagWears)
	else
		self.bagEquipMaxRankDic, self.bagArtifactMaxRankDic, self.bagCustomMadeArtifactDic = CurAvatar:getBagEquipMaxRank()
	end

	self.cells = {}

	if not self.isEditPlan then
		self.txtPlanName:setText(Lang.get(551))

		if self.heroInfos and self.bgWear and self.bgEdit then
			self.bgWear:setVisible(true)
			self.bgEdit:setVisible(false)
		end

		self.imgStateTitleBar:setImage("NoAlpha/Bag/BgBagWearingTop1")
		self.btnSave:setVisible(false)
		self.btnRenamePlan:setVisible(false)
		self.btnDeletePlan:setVisible(false)
		self.btnCopyNew:setVisible(true)
		self.btnUsePlan:setVisible(false)
	else
		if self.heroInfos and self.bgWear and self.bgEdit then
			self.bgWear:setVisible(false)
			self.bgEdit:setVisible(true)
		end

		self.imgStateTitleBar:setImage("NoAlpha/Bag/BgBagWearingTop2")
		self.txtPlanName:setText(self.planData.name)
		self.btnRenamePlan:setVisible(true)
		self.btnDeletePlan:setVisible(true)
		self.btnCopyNew:setVisible(false)
		self.btnUsePlan:setVisible(self.canSave ~= true)
		self.btnSave:setVisible(self.canSave)
	end

	if #self.filterList == 0 then
		self.imgNone:setVisible(true)
		self.scroll:setVisible(false)
		self.btnUsePlan:setVisible(false)
		self.btnSave:setVisible(false)
		self.imgStateTitleBar:setVisible(false)
	else
		self.imgNone:setVisible(false)
		self.scroll:setVisible(true)

		if gotoTop then
			self.scroll:setTotalCount(#self.filterList, 1)
		else
			self.scroll:setTotalCount(#self.filterList)
		end

		self.imgStateTitleBar:setVisible(true)
	end

	self:checkEquipOffVisible()

	if self.isEditPlan then
		self.petWearRed:clearHint()
	else
		self.petWearRed:addHint({
			UIConst.RD_HINT_BATTLE_PET_WEAR
		})
	end
end

function BagWearPart:refreshPlanName(name)
	if not self.isEditPlan then
		self.txtPlanName:setText(Lang.get(551))
	else
		self.txtPlanName:setText(name)

		self.planData.name = name
	end
end

function BagWearPart:onBtnRuneClick()
	local petRuneMainDlg = UIManager.getUI("petRuneMainDlg", true)

	petRuneMainDlg:setPlanData(self.isEditPlan, self.selectPlanId)
	petRuneMainDlg:hideChangeBtn()
end

function BagWearPart:refreshBtnPetWear()
	self.btnPetWear:setVisible(CurAvatar:petSystemEnable())
end

function BagWearPart:onClickBtnPetWear()
	local ui = UIManager.getUI("bagPetWearDlg", true)

	if ui then
		ui:setData(self.isEditPlan, self.selectPlanId, self.petId)
	end
end

return BagWearPart
