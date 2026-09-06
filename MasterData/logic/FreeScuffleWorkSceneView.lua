-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/freescuffle/view/FreeScuffleWorkSceneView.lua

module("logic.extensions.freescuffle.view.FreeScuffleWorkSceneView", package.seeall)

local FreeScuffleWorkSceneView = class("FreeScuffleWorkSceneView", ViewComponent)
local ViewState_Nor = 1
local ViewState_Edti = 2
local EventTriggerDuration = 5

function FreeScuffleWorkSceneView:ctor()
	FreeScuffleWorkSceneView.super.ctor(self)

	self._starScrollerListDic = {}
	self._blockMainGosInId = {}
	self._blockCells = {}
	self._viewState = ViewState_Nor
	self._selectBlockId = 0
	self._selectRaceId = 0
	self._lockGolds = {}
	self._isHaveFreePet = false
end

function FreeScuffleWorkSceneView:buildUI()
	FreeScuffleWorkSceneView.super.buildUI(self)

	self._layer1 = nil
	self._layer2 = self:getGo("layer2"):GetComponent(ComponentType.Canvas)
	self._layer3 = self:getGo("layer3"):GetComponent(ComponentType.Canvas)
	self._mapEffRoot = self:getGo("layer1/mapEffRoot")
	self._goldEffRoot = self:getGo("layer1/goldEffRoot")
	self._zoneEffRoot = self:getGo("layer1/zoneEffRoot")
	self._zoneEffGos = GameUtil.getChildren(self._zoneEffRoot)
	self._workingAccumulateEffRoot = self:getGo("layer1/workingAccumulateEffRoot")
	self._flyPackGo = self:getGo("layer1/flyPackEffRoot/flyPackGo")
	self._flyPackView = self:getGo("layer1/flyPackEffRoot/view")
	self._flyPackGoList = {}
	self._flyPackGoStack = {}

	local flyPackTargetPos = self:getGo("layer1/flyPackEffRoot/targetPos")

	self._flyPackTargetPosGoDic = GameUtil.getChildren(flyPackTargetPos)
	self._eggTrigger = self:getGo("layer2/eggTrigger")
	self._eggCon = self:getGo("layer2/eggTrigger/con")
	self._eggRoot = self:getGo("layer2/eggTrigger/con/root")
	self._blockView = self:getGo("layer2/blockCol/view")
	self._blockCell = self:getGo("layer2/blockCol/cell")
	self._topMask = self:getGo("layer2/blockCol/topMask")
	self._packageCol = self:getGo("layer2/packageCol")
	self._trainPackage = self:getGo("layer2/packageCol/train")
	self._packageView = self:getGo("layer2/packageCol/train/view")
	self._idlePackage = self:getGo("layer2/packageCol/idle")
	self._btnClose = self:getGo("layer3/leftTop/btnClose")
	self._btnTip = self:getGo("layer3/leftTop/btnTip")
	self._norUi = self:getGo("layer3/norUi")
	self._btnRank = self:getGo("layer3/norUi/btnRank")
	self._btnBook = self:getGo("layer3/norUi/btnBook")
	self._btnLottery = self:getGo("layer3/norUi/btnLottery")
	self._btnEnterEdti = self:getGo("layer3/norUi/btnEnterEdti")
	self._btnHarvest = self:getGo("layer3/norUi/btnHarvest")
	self._editUi = self:getGo("layer3/editUi")
	self._btnExitEdti = self:getGo("layer3/editUi/btnExitEdti")
	self._btnShowWorkPetCol = self:getGo("layer3/editUi/btnShowWorkPetCol")
	self._workPetCol = self:getGo("layer3/editUi/workPetCol")
	self._txtZone_workPet = self:getTxt("layer3/editUi/workPetCol/zone/txt")
	self._btnHideWorkPetCol_workPet = self:getGo("layer3/editUi/workPetCol/btnHideWorkPetCol")
	self._btnSure_workPet = self:getGo("layer3/editUi/workPetCol/btnSure")
	self._upgrade_workPet = self:getGo("layer3/editUi/workPetCol/upgrade")
	self._btnUpgradeOnce_workPetUpgrade = self:getGo("layer3/editUi/workPetCol/upgrade/btnUpgradeOnce")
	self._btnSure_workPetUpgrade = self:getGo("layer3/editUi/workPetCol/upgrade/btnSure")
	self._iconDesc_workPetUpgrade = self:getGo("layer3/editUi/workPetCol/upgrade/desc/txt/icon")
	self._txtDesc_workPetUpgrade = self:getTxt("layer3/editUi/workPetCol/upgrade/desc/txt")
	self._empty_workPet = self:getGo("layer3/editUi/workPetCol/empty")
	self._btnGetWork_workPet = self:getGo("layer3/editUi/workPetCol/empty/btnGetWork")

	local workPetScrView = self:getGo("layer3/editUi/workPetCol/scrView")
	local workPetScrCell = self:getGo("layer3/editUi/workPetCol/scrCell")

	self._workPetScrollerList = ScrollerList.create(workPetScrView, workPetScrCell, GameUtil.handler(self._updateWorkPetCell, self), GameUtil.handler(self._clearWorkPetCell, self))
	self._petInfo = self:getGo("layer3/editUi/petInfo")
	self._head_petInfo = self:getGo("layer3/editUi/petInfo/head")
	self._con_petInfo = self:getGo("layer3/editUi/petInfo/head/mask/con")
	self._txtName_petInfo = self:getTxt("layer3/editUi/petInfo/name/txt")
	self._txtShip_petInfo = self:getTxt("layer3/editUi/petInfo/desc/txtShip")
	self._txtProfit_petInfo = self:getTxt("layer3/editUi/petInfo/desc/txtProfit")
	self._txtNextEnergy_petInfo = self:getTxt("layer3/editUi/petInfo/txtNextEnergy")
	self._txtBaseWork_petInfo = self:getTxt("layer3/editUi/petInfo/work/txtBaseWork")
	self._txtExWork_petInfo = self:getTxt("layer3/editUi/petInfo/work/txtExWork")
	self._txtLevel_petInfo = self:getTxt("layer3/editUi/petInfo/txtLevel")
	self._btnUpgradeOnce_petInfo = self:getGo("layer3/editUi/petInfo/btnUpgradeOnce")
	self._btnUpgradeTen_petInfo = self:getGo("layer3/editUi/petInfo/btnUpgradeTen")
	self._onceCost = self:getGo("layer3/editUi/petInfo/onceCost")
	self._txtOnceCost_petInfo = self:getTxt("layer3/editUi/petInfo/onceCost/txt")
	self._iconOnceCost_petInfo = self:getGo("layer3/editUi/petInfo/onceCost/txt/icon")
	self._tenCost = self:getGo("layer3/editUi/petInfo/tenCost")
	self._txtTenCost_petInfo = self:getTxt("layer3/editUi/petInfo/tenCost/txt")
	self._iconTenCost_petInfo = self:getGo("layer3/editUi/petInfo/tenCost/txt/icon")

	local starScrCell_petInfo = self:getGo("layer3/editUi/petInfo/star/scrCell")
	local starScrView_petInfo = self:getGo("layer3/editUi/petInfo/star/scrView")

	self._starPetInfoScrollerList = ScrollerList.create(starScrView_petInfo, starScrCell_petInfo, GameUtil.handler(self._updateStarCell, self), GameUtil.handler(self._clearStarCell, self))
	self._shipCol = self:getGo("layer3/editUi/shipCol")
	self._btnShipDesc = self:getGo("layer3/editUi/shipCol/btnShipDesc")
	self._shipScrView = self:getGo("layer3/editUi/shipCol/scrView")

	local shipScrCell = self:getGo("layer3/editUi/shipCol/scrCell")

	self._shipScrollerList = ScrollerList.create(self._shipScrView, shipScrCell, GameUtil.handler(self._updateShipCell, self), GameUtil.handler(self._clearShipCell, self))
	self._txtWorkingAccumulate = self:getTxt("layer3/workingAccumulate/txt")
	self._txtCoinAccumulate = self:getTxt("layer3/workingAccumulate/txtCoin")
	self._iconCoinAccumulate = self:getGo("layer3/workingAccumulate/iconCoin")
	self._taskCol = self:getGo("layer3/taskCol")
	self._txtProgressTask = self:getTxt("layer3/taskCol/taskCell/txtProgress")
	self._txtNameTask = self:getTxt("layer3/taskCol/taskCell/txtName")
	self._itemScrCellInTask = self:getGo("layer3/taskCol/taskCell/itemScrCell")
	self._itemScrViewInTask = self:getGo("layer3/taskCol/taskCell/itemScrView")
	self._itemTaskScrollerList = ScrollerList.create(self._itemScrViewInTask, self._itemScrCellInTask, GameUtil.handler(self._updateItemTaskCell, self), GameUtil.handler(self._clearItemTaskCell, self))
	self._workFloatGo = self:getGo("layer3/workFloatRoot/floatGo")
	self._txtValueFloatWork = self:getTxt("layer3/workFloatRoot/floatGo/txtValue")
	self._txtDiffFloatWork = self:getTxt("layer3/workFloatRoot/floatGo/txtDiff")

	GameUtil.SetActive(self._workFloatGo, false)

	self._coinFloatGo = self:getGo("layer3/coinFloatRoot/floatGo")
	self._txtValueFloatCoin = self:getTxt("layer3/coinFloatRoot/floatGo/txtValue")

	GameUtil.SetActive(self._coinFloatGo, false)
end

function FreeScuffleWorkSceneView:bindEvents()
	FreeScuffleWorkSceneView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTips, self)
	GameUtil.addClickHandler(self._btnRank, self._onClickBtnRank, self)
	GameUtil.addClickHandler(self._btnBook, self._onClickBtnBook, self)
	GameUtil.addClickHandler(self._btnLottery, self._onClickBtnLottery, self)
	GameUtil.addClickHandler(self._btnHarvest, self._onClickBtnHarvest, self)
	GameUtil.addClickHandler(self._btnEnterEdti, GameUtil.handler(self._switchViewState, self, ViewState_Edti))
	GameUtil.addClickHandler(self._btnExitEdti, GameUtil.handler(self._switchViewState, self, ViewState_Nor))
	GameUtil.addClickHandler(self._btnHideWorkPetCol_workPet, self._btnHideWorkPetCol_InWork, self)
	GameUtil.addClickHandler(self._btnShowWorkPetCol, self._btnHideWorkPetCol_InWork, self)
	GameUtil.addClickHandler(self._btnSure_workPet, self._onClickBtnSureInWork, self)
	GameUtil.addClickHandler(self._btnSure_workPetUpgrade, self._onClickBtnSureInWork, self)
	GameUtil.addClickHandler(self._btnUpgradeOnce_workPetUpgrade, GameUtil.handler(self._upgradePetLevel, self, 1), self)
	GameUtil.addClickHandler(self._btnUpgradeOnce_petInfo, GameUtil.handler(self._upgradePetLevel, self, 1), self)
	GameUtil.addClickHandler(self._btnUpgradeTen_petInfo, GameUtil.handler(self._upgradePetLevel, self, 10), self)
	GameUtil.addClickHandler(self._eggCon, self._onClickEggCon, self)
	GameUtil.addClickHandler(self._taskCol, self._onCliTaskCol, self)
	GameUtil.addClickHandler(self._btnGetWork_workPet, self._onClickBtnLottery, self)
	GameUtil.addClickHandler(self._btnShipDesc, self._onClickBtnShipDesc, self)
end

function FreeScuffleWorkSceneView:unbindEvents()
	FreeScuffleWorkSceneView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnRank)
	GameUtil.rmClickHandler(self._btnBook)
	GameUtil.rmClickHandler(self._btnLottery)
	GameUtil.rmClickHandler(self._btnHarvest)
	GameUtil.rmClickHandler(self._btnEnterEdti)
	GameUtil.rmClickHandler(self._btnExitEdti)
	GameUtil.rmClickHandler(self._btnHideWorkPetCol_workPet)
	GameUtil.rmClickHandler(self._btnSure_workPet)
	GameUtil.rmClickHandler(self._btnSure_workPetUpgrade)
	GameUtil.rmClickHandler(self._btnUpgradeOnce_workPetUpgrade)
	GameUtil.rmClickHandler(self._btnUpgradeOnce_petInfo)
	GameUtil.rmClickHandler(self._btnUpgradeTen_petInfo)
	GameUtil.rmClickHandler(self._eggCon)
	GameUtil.rmClickHandler(self._taskCol)
	GameUtil.rmClickHandler(self._btnGetWork_workPet)
	GameUtil.rmClickHandler(self._btnShipDesc)
end

function FreeScuffleWorkSceneView:onEnter()
	FreeScuffleWorkSceneView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])

	FreeScuffleController.instance:enterFreeScuffleRunning(self._activityId, true)

	local isInTime = ActivityDefineController.instance:checkIsInActivityTimeByActivityId(self._activityId)

	if not isInTime then
		self:close()

		return
	end

	self._subMo = FreeScuffleController.instance:getSubMo(self._activityId)
	self._actData = FreeScuffleConfig.instance:getActData(self._activityId)

	local blockCfg = FreeScuffleConfig.instance:getBlockCfg(self._activityId) or {}

	self._blockIdList = {}

	for _, data in ipairs(blockCfg) do
		table.insert(self._blockIdList, data.blockId)
	end

	self._isPlayingPackage = false
	self._isPlayingEgg = false
	self._isPlayingLottery = false
	self._isPlayingEvent = false
	self._curEventTriggerDuration = EventTriggerDuration
	self._oldTotalInCreaseRatio = 0
	self._viewState = ViewState_Nor

	table.clear(self._lockGolds)
	self.addGEvent(self, GlobalNotify.HandlePM_FreeScuffleGetInfoRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.HandlePM_FreeScuffleEnterInterfaceRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.HandlePM_FreeScuffleScheduleRes, self._handlePM_FreeScuffleScheduleRes, self)
	self.addGEvent(self, GlobalNotify.HandlePM_FreeScuffleUnlockBlockRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.HandlePM_FreeScuffleUpgradlePetRes, self._handlePM_FreeScuffleUpgradlePetRes, self)
	self.addGEvent(self, GlobalNotify.HandlePM_FreeScuffleGainCoinRes, self._handlePM_FreeScuffleGainCoinRes, self)
	self.addGEvent(self, GlobalNotify.FreeScuffleFinishLotteryEvent, self._freeScuffleFinishLotteryEvent, self)
	self.addGEvent(self, GlobalNotify.FreeScuffleFinishEggEvent, self._freeScuffleFinishEggEvent, self)
	self.addGEvent(self, GlobalNotify.HandlePM_FreeScuffleTaskInfoRes, self._onUpdateTaskColUI, self)
	self.addGEvent(self, GlobalNotify.HandlePM_FreeScuffleTaskNotifyRes, self._onUpdateTaskColUI, self)
	self.addGEvent(self, GlobalNotify.HandlePM_FreeScuffleGainTaskPrizeRes, self._onUpdateTaskColUI, self)
	self.addGEvent(self, GlobalNotify.HandlePM_FreeScuffleDeliverPackageRes, self._handlePM_FreeScuffleDeliverPackageRes, self)
	self.addGEvent(self, GlobalNotify.HandlePM_FreeScuffleResetNextPackageRes, self._handlePM_FreeScuffleResetNextPackageRes, self)
	self.addGEvent(self, GlobalNotify.FreeScufflePackageEnd, self._freeScufflePackageEnd, self)
	self.addGEvent(self, GlobalNotify.OnMaterialItemChange, self._onMaterialItemChange, self)
	self.addGEvent(self, GlobalNotify.FreeScuffleTriggerEvent, self._freeScuffleTriggerEvent, self)

	self._coinItem = self._subMo:getCostCoinItem()

	MaterialMgr.setIcon(self._iconCoinAccumulate, self._coinItem.matType, self._coinItem.matId, nil, nil)
	GameUtil.SetActive(self._eggTrigger, false)

	self._enterWorkScene = true

	FreeScuffleController.instance:enterWorkScene(self._activityId, true, true)

	self._layer2.overrideSorting = true
	self._layer2.sortingOrder = UGUIToolHelper.GetNodeCanvansSortingOrder(self.mainGO) + 10
	self._layer3.overrideSorting = true
	self._layer3.sortingOrder = UGUIToolHelper.GetNodeCanvansSortingOrder(self.mainGO) + 20

	for idx = 1, self._mapEffRoot.transform.childCount do
		local go = self._mapEffRoot.transform:GetChild(idx - 1).gameObject
		local effPath = string.format("20250627/ziyouluandou/%s.prefab", go.name)

		self:playViewEffectUniGo(effPath, go, nil, true)
	end

	self:_onUpdate()
	settimer(0, self._onTicking, self, true)
	self:_onTicking()
end

function FreeScuffleWorkSceneView:onExit()
	FreeScuffleWorkSceneView.super.onExit(self)
	removetimer(self._onTicking, self)
	FreeScuffleController.instance:enterFreeScuffleRunning(self._activityId, false)

	if self._enterWorkScene then
		self._enterWorkScene = false

		FreeScuffleController.instance:enterWorkScene(self._activityId, false, true)
	end

	self._layer2.overrideSorting = false
	self._layer3.overrideSorting = false

	MaterialMgr.clearIcon(self._iconCoinAccumulate)
	self:_onClearBlockColUI()
	self:_onClearWorkPetColUI()
	self:_onClearPetInfoCol()
	self:_onClearShipCol()
	self:_onClearPackageCol()
	self:_onClearTaskColUI()
	self:_clearWorkFloatAnim()
	self:_clearCoinFloatAnim()
	self:_clearAllFlyPackAnim()
	self:_onClearEggColUI()
end

function FreeScuffleWorkSceneView:destroyUI()
	FreeScuffleWorkSceneView.super.destroyUI(self)

	if self._fangKeSpineCtrl then
		self._fangKeSpineCtrl:onDestory()
	end
end

function FreeScuffleWorkSceneView:_handlePM_FreeScuffleScheduleRes()
	local cur = self._subMo:getTotalInCreaseRatio()
	local diff = cur - self._oldTotalInCreaseRatio

	self._oldTotalInCreaseRatio = cur

	self:_playWrokFloatAnim(cur, diff)
	self:_playWorkingAccumulateEff()
	self:_onUpdate()
	self:_tryReqNextPackage()
end

function FreeScuffleWorkSceneView:_handlePM_FreeScuffleUpgradlePetRes(msg)
	local raceId = msg.pet.raceId

	if self._subMo:isWorkingPet(raceId) then
		local cur = self._subMo:getTotalInCreaseRatio()
		local diff = cur - self._oldTotalInCreaseRatio

		self._oldTotalInCreaseRatio = cur

		self:_playWrokFloatAnim(cur, diff)
		self:_playWorkingAccumulateEff()
	end

	self:_onUpdate()
end

function FreeScuffleWorkSceneView:_handlePM_FreeScuffleGainCoinRes(status, msg)
	if status == 0 then
		for i, v in ipairs(msg.blockList) do
			self._lockGolds[v.blockId] = false

			local cell = self._blockCells[v.blockId]

			if cell then
				local function loadedHandler(handlerTarget, eff)
					local x, y, z = Framework.TransformUtil.GetPos(cell._goldEffRoot.transform, 0, 0, 0)

					GameUtil.setPos(eff.effGo, x, y, z)
				end

				self:playViewEffect("20250627/ziyouluandou/fx_ui_zyld_jinbi.prefab", self._goldEffRoot, cell._goldEffRoot, false, 0, 0, nil, loadedHandler)
			end
		end
	else
		table.clear(self._lockGolds)
	end

	self:_playCoinFloatAnim(msg.curGainCoin)
end

function FreeScuffleWorkSceneView:_handlePM_FreeScuffleDeliverPackageRes()
	if not self._subMo:isOverPackage() then
		self._isPlayingPackage = false

		self:_onUpdatePackageCol()
	end

	self:_tryReqNextPackage()
end

function FreeScuffleWorkSceneView:_tryReqNextPackage()
	if self._subMo:isPackageEmpty() and self._subMo:getTodayLeftPackageTime() > 0 then
		FreeScuffleController.instance:sendPM_FreeScuffleResetNextPackageReq(self._activityId)
	end
end

function FreeScuffleWorkSceneView:_handlePM_FreeScuffleResetNextPackageRes()
	self:_onUpdateTriggerEvent()
end

function FreeScuffleWorkSceneView:_freeScufflePackageEnd()
	if not self._subMo:isPackageEmpty() then
		FloatWordMgr.instance:show("包裹留存时间已达，包裹消失")
	end

	self:_onUpdateTriggerEvent()
	self:_tryReqNextPackage()
end

function FreeScuffleWorkSceneView:_onMaterialItemChange(mo)
	if mo.type == self._coinItem.matType and mo.id == self._coinItem.matId then
		self._txtCoinAccumulate.text = MmUtil.formatNumber(mo.num, FreeScuffleEnum.Units_Coin, 1)
	end
end

function FreeScuffleWorkSceneView:_freeScuffleTriggerEvent()
	self:_onUpdateTriggerEvent()
end

function FreeScuffleWorkSceneView:_freeScuffleFinishLotteryEvent()
	self._isPlayingLottery = false
	self._curEventTriggerDuration = 0

	self:_onUpdateTriggerEvent()
end

function FreeScuffleWorkSceneView:_freeScuffleFinishEggEvent()
	self._isPlayingEgg = false
	self._curEventTriggerDuration = 0

	self:_onUpdateTriggerEvent()
end

function FreeScuffleWorkSceneView:_onTicking()
	self._curEventTriggerDuration = self._curEventTriggerDuration + UnityEngine.Time.deltaTime

	for _, blockId in ipairs(self._blockIdList) do
		if self._subMo:isUnlockBlock(blockId) then
			local cell = self._blockCells[blockId]

			if cell then
				if self._lockGolds[blockId] then
					GameUtil.SetActive(cell._gold, false)
				else
					cell._imgProgressGold.fillAmount = self._subMo:getProgressBlocks(blockId)

					local num = self._subMo:getAccumulateCoinInBlock(blockId)

					cell._txtCount.text = MmUtil.formatNumber(num, FreeScuffleEnum.Units_Coin, 1)

					GameUtil.SetActive(cell._gold, num > 0)
				end
			end
		end
	end

	self:_onUpdateTriggerEvent()
end

function FreeScuffleWorkSceneView:_onUpdateTriggerEvent()
	if self._viewState == ViewState_Nor and not self._isPlayingPackage and self._subMo:isOverPackage() then
		self:_triggerPackage()
	end

	if self._viewState == ViewState_Nor and self._curEventTriggerDuration > EventTriggerDuration and not self._isPlayingEgg and not self._isPlayingLottery then
		local actions = {
			{
				check = function()
					return self._subMo:isOverLastEggGame()
				end,
				action = function()
					self:_triggerEggGame()
				end
			},
			{
				check = function()
					return self._subMo:isOverLastRandomEventLottery()
				end,
				action = function()
					self:_triggerLottery()
				end
			}
		}

		if Mathf.Random(1, 100) % 2 == 1 then
			actions[1], actions[2] = actions[2], actions[1]
		end

		for _, v in ipairs(actions) do
			if v.check() then
				v.action()

				break
			end
		end
	end

	if self._isPlayingPackage and not self._subMo:isOverPackage() then
		self._isPlayingPackage = false

		self:_onUpdatePackageCol()
	end
end

function FreeScuffleWorkSceneView:_triggerPackage()
	self._isPlayingPackage = true

	self:_onUpdatePackageCol()
end

function FreeScuffleWorkSceneView:_triggerEggGame()
	self._isPlayingEgg = true

	self:_onUpdateEggColUI()
end

function FreeScuffleWorkSceneView:_triggerLottery()
	UIStateManager.instance:closeAllModalViews()

	self._isPlayingLottery = true

	UIStateManager.instance:push(ViewName.FreeScuffleCardDrawView, self._activityId)
end

function FreeScuffleWorkSceneView:_onClickEggCon()
	if not self._isPlayingEgg then
		return
	end

	GameUtil.SetActive(self._eggTrigger, false)
	UIStateManager.instance:push(ViewName.FreeScuffleEggView, self._activityId)
end

function FreeScuffleWorkSceneView:_onUpdate()
	self:_onUpdateData()
	self:_onUpdateUI()
end

function FreeScuffleWorkSceneView:_onUpdateData()
	self._oldTotalInCreaseRatio = self._subMo:getTotalInCreaseRatio()

	local petInfos = self._subMo:getPetInfos()

	self._workRaceList = {}

	for raceId, _ in pairs(petInfos) do
		table.insert(self._workRaceList, raceId)
	end

	self._isHaveFreePet = false

	for _, raceId in ipairs(self._workRaceList) do
		if not self._subMo:isWorkingPet(raceId) then
			self._isHaveFreePet = true

			break
		end
	end
end

function FreeScuffleWorkSceneView:_onUpdateUI()
	GameUtil.SetActive(self._norUi, self._viewState == ViewState_Nor)
	GameUtil.SetActive(self._editUi, self._viewState == ViewState_Edti)

	self._txtWorkingAccumulate.text = MmUtil.formatNumber(self._subMo:getTotalInCreaseRatio(), FreeScuffleEnum.Units_Coin, 1)

	local coinNum = self._subMo:getCurCoin()

	self._txtCoinAccumulate.text = MmUtil.formatNumber(coinNum, FreeScuffleEnum.Units_Coin, 1)

	self:_onUpdatePackageCol()
	self:_onUpdateBlockColUI()
	self:_onUpdateWorkPetColUI()
	self:_onUpdatePetInfoCol()
	self:_onUpdateShipColUI()
	self:_onUpdateTaskColUI()
	self:_onUpdateEggColUI()
end

function FreeScuffleWorkSceneView:_onUpdateBlockColUI()
	self._blockMainGosInId = {}

	local children = GameUtil.getChildren(self._topMask)

	for _, go in ipairs(children) do
		goutil.addChildToParent(go, self._blockView.transform)
	end

	for blockId = 1, #self._blockIdList do
		local cell = self._blockCells[blockId]

		if cell == nil then
			cell = {}
			self._blockCells[blockId] = cell

			local mainGo = self._blockView.transform:GetChild(blockId - 1).gameObject

			cell._mainGo = mainGo
			cell._seat = goutil.findChild(mainGo, "seat")
			cell._btnSeat = goutil.findChild(mainGo, "seat/btn")
			cell._tagLock = goutil.findChild(mainGo, "seat/btn/tagLock")
			cell._tagAdd = goutil.findChild(mainGo, "seat/btn/tagAdd")
			cell._tagAddRed = goutil.findChild(mainGo, "seat/btn/red")
			cell._tipsUnlock = goutil.findChild(mainGo, "seat/tipsUnlock")
			cell._iconTipsUnlock = goutil.findChild(mainGo, "seat/tipsUnlock/icon")
			cell._txtTipsUnlock = goutil.findChildTextComponent(mainGo, "seat/tipsUnlock/txt")
			cell._pet = goutil.findChild(mainGo, "pet")
			cell._petRoot = goutil.findChild(mainGo, "pet/petRoot")
			cell._con = goutil.findChild(mainGo, "pet/petRoot/con")
			cell._txtLevel = goutil.findChildTextComponent(mainGo, "pet/info/txtLevel")
			cell._starScrView = goutil.findChild(mainGo, "pet/info/star/scrView")
			cell._starScrCell = goutil.findChild(mainGo, "pet/info/star/scrCell")
			cell._tagShip = goutil.findChild(mainGo, "pet/info/tagShip")
			cell._gold = goutil.findChild(mainGo, "pet/gold")
			cell._imgProgressGold = goutil.findChild(mainGo, "pet/gold/imgProgress"):GetComponent(ComponentType.Image)
			cell._iconGold = goutil.findChild(mainGo, "pet/gold/icon")
			cell._txtCount = goutil.findChildTextComponent(mainGo, "pet/gold/txtCount")
			cell._goldEffRoot = goutil.findChild(mainGo, "pet/goldEffRoot")
			cell._spineCtrl = FreeScuffleWorkSpineCtrl.New()
		end

		self:_updateBlockCell(cell, blockId)
	end

	for idx = 1, Mathf.Max(#self._blockIdList, #self._blockCells) do
		local cell = self._blockCells[idx]

		GameUtil.SetActive(cell._mainGo, idx <= #self._blockIdList)
	end

	if self._viewState == ViewState_Edti then
		for blockId = 1, #self._blockIdList do
			local cell = self._blockCells[blockId]
			local raceId = self._subMo:getRaceIdBlock(blockId)

			if raceId > 0 and self._selectRaceId == raceId then
				goutil.addChildToParent(cell._mainGo, self._topMask.transform)
			end
		end
	end

	GameUtil.SetActive(self._topMask, self._topMask.transform.childCount > 0)
end

function FreeScuffleWorkSceneView:_onClearBlockColUI()
	local children = GameUtil.getChildren(self._topMask)

	for _, go in ipairs(children) do
		goutil.addChildToParent(go, self._blockView.transform)
	end

	for blockId, cell in pairs(self._blockCells) do
		self:_clearBlockCell(cell)
	end
end

function FreeScuffleWorkSceneView:_updateBlockCell(cell, blockId)
	local data = FreeScuffleConfig.instance:getBlockData(self._activityId, blockId)
	local mainGo = cell._mainGo
	local isUnlock = self._subMo:isUnlockBlock(blockId)
	local raceId = self._subMo:getRaceIdBlock(blockId)
	local isEmptyPet = raceId <= 0
	local petStar = self._subMo:getPetStar(raceId)
	local maxPetStar = self._subMo:getMaxPetStar(raceId)
	local petLevel = self._subMo:getPetLevel(raceId)
	local unlockCost = self._subMo:getUnlockCostCoin(blockId)
	local shipIdList = self._subMo:getActiveShipInPet(raceId)
	local isHaveShip = self._subMo:isHaveShipInPet(raceId)
	local coinItem = self._subMo:getCostCoinItem()
	local blockData = FreeScuffleConfig.instance:getBlockData(self._activityId, blockId)
	local petData = FreeScuffleConfig.instance:getPetData(self._activityId, raceId)

	GameUtil.SetActive(cell._seat, isEmptyPet)
	GameUtil.SetActive(cell._pet, not isEmptyPet)
	GameUtil.SetActive(cell._tagLock, not isUnlock)
	GameUtil.SetActive(cell._tagAdd, isUnlock and isEmptyPet)
	GameUtil.SetActive(cell._tipsUnlock, not isUnlock)
	GameUtil.SetActive(cell._tagShip, isHaveShip)
	GameUtil.SetGray(cell._tagShip, #shipIdList <= 0)
	GameUtil.SetActive(cell._tagAddRed, isUnlock and isEmptyPet and self._isHaveFreePet)

	cell._txtLevel.text = string.format("等级 %s", petLevel)
	cell._txtTipsUnlock.text = string.format("消耗%s%s解锁", MmUtil.formatNumber(unlockCost, FreeScuffleEnum.Units_Coin, 0), coinItem.matName)

	MaterialMgr.setIcon(cell._iconTipsUnlock, coinItem.matType, coinItem.matId, nil, nil)
	MaterialMgr.setIcon(cell._iconGold, coinItem.matType, coinItem.matId, nil, nil)

	if not isEmptyPet then
		if not petData.lihuiPos then
			local pos = {}

			if not pos[3] then
				local x, y, scale = checknumber(pos[1]), checknumber(pos[2]), 1

				GameUtil.setLocalPos(cell._con, x, y)
				GameUtil.setLocalScale(cell._con, pos[3])
				cell._spineCtrl:onInit(cell._con, self, petData.lihui)
			end
		end
	else
		cell._spineCtrl:onClear()
	end

	local starInfoList = {}

	for idx = 1, petStar do
		table.insert(starInfoList, {
			isActive = idx <= petStar
		})
	end

	if not self._starScrollerListDic[mainGo] then
		local scrollList = ScrollerList.create(cell._starScrView, cell._starScrCell, GameUtil.handler(self._updateStarCell, self), GameUtil.handler(self._clearStarCell, self))

		self._starScrollerListDic[mainGo] = scrollList

		scrollList:dragNotifyParent()
		scrollList:reloadData(starInfoList)

		local function openWorkPetColFunc()
			self._selectBlockId = blockId
			self._selectRaceId = self._subMo:getRaceIdBlock(blockId)

			self:_switchViewState(ViewState_Edti)
			self:_setWorkPetColVisible(true)
		end

		GameUtil.addClickHandler(cell._petRoot, openWorkPetColFunc)
		GameUtil.addClickHandler(cell._btnSeat, function()
			if not isUnlock then
				if self._subMo:isUnlockBlock(blockId) then
					FloatWordMgr.instance:show("已解锁")

					return
				end

				if self._subMo:getCurCoin() < unlockCost then
					FloatWordMgr.instance:show(string.format("解锁%s不足", coinItem.matName))

					return
				end

				local tipsContent = string.format("是否花费%s%s解锁%s？", MmUtil.formatNumber(unlockCost, FreeScuffleEnum.Units_Coin, 0), coinItem.matName, blockData.decs)

				local function okFunc()
					FreeScuffleController.instance:sendPM_FreeScuffleUnlockBlockReq(self._activityId, blockId)
				end

				TipsFacade.instance:openPopupWindow("提示", tipsContent, okFunc, nil, "确定", "取消")
			else
				openWorkPetColFunc()
			end
		end)
		GameUtil.addClickHandler(cell._gold, function()
			if self._subMo:getAccumulateCoinInBlock(blockId) <= 0 then
				return
			end

			if self._lockGolds[blockId] then
				return
			end

			self._lockGolds[blockId] = true

			GameUtil.SetActive(cell._gold, false)
			FreeScuffleController.instance:sendPM_FreeScuffleGainCoinReq(self._activityId, {
				blockId
			})
		end)
	end
end

function FreeScuffleWorkSceneView:_clearBlockCell(cell)
	cell._spineCtrl:onClear()
	cell._spineCtrl:onDestory()

	local scrollList = self._starScrollerListDic[cell._mainGo]

	if scrollList then
		scrollList:dispose()

		self._starScrollerListDic[cell._mainGo] = nil
	end

	MaterialMgr.clearIcon(cell._iconGold)
	MaterialMgr.clearIcon(cell._iconTipsUnlock)
	GameUtil.rmClickHandler(cell._petRoot)
	GameUtil.rmClickHandler(cell._btnSeat)
	GameUtil.rmClickHandler(cell._gold)
end

function FreeScuffleWorkSceneView:_updateStarCell(view, cell, info, tag)
	local isActive = info.isActive
	local mainGo = cell.gameObject
	local icon = goutil.findChild(mainGo, "icon")

	GameUtil.setUIGroupIdx(mainGo, isActive and 1 or 0)
end

function FreeScuffleWorkSceneView:_clearStarCell(cell)
	return
end

function FreeScuffleWorkSceneView:_setWorkPetColVisible(isVisible)
	GameUtil.SetActive(self._workPetCol, isVisible)
	GameUtil.SetActive(self._btnShowWorkPetCol, not isVisible)
end

function FreeScuffleWorkSceneView:_onUpdateWorkPetColUI()
	local curRaceIdInBlock = self._subMo:getRaceIdBlock(self._selectBlockId)

	table.sort(self._workRaceList, function(a, b)
		local blockA = a == curRaceIdInBlock and 1 or 0
		local blockB = b == curRaceIdInBlock and 1 or 0

		if blockA ~= blockB then
			return blockB < blockA
		end

		local isWithA = self._subMo:isWithPet(a)
		local isWithB = self._subMo:isWithPet(b)

		if isWithA ~= isWithB then
			return isWithA
		end

		local isWorkingA = self._subMo:isWorkingPet(a)
		local isWorkingB = self._subMo:isWorkingPet(b)

		if isWorkingA ~= isWorkingB then
			return not isWorkingA
		end

		local petLevelA = self._subMo:getPetLevel(a)
		local petLevelB = self._subMo:getPetLevel(b)

		if petLevelA ~= petLevelB then
			return petLevelB < petLevelA
		end

		return b < a
	end)
	self._workPetScrollerList:reloadData(self._workRaceList)

	if self._selectRaceId > 0 then
		local index = 0

		for idx, raceId in ipairs(self._workRaceList) do
			if self._selectRaceId == raceId then
				index = idx - 1

				break
			end
		end

		self._workPetScrollerList:MoveCellToBegin(index, true)
	end

	GameUtil.SetActive(self._empty_workPet, #self._workRaceList <= 0)

	local costItem = self._subMo:getCostCoinItem()

	MaterialMgr.setIcon(self._iconDesc_workPetUpgrade, costItem.matType, costItem.matId, nil, nil)

	local blockData = FreeScuffleConfig.instance:getBlockData(self._activityId, self._selectBlockId)

	if blockData then
		self._txtZone_workPet.text = blockData.decs or "无"
	end

	self:_updateWorkPetUpgradeUI()
end

function FreeScuffleWorkSceneView:_updateWorkPetUpgradeUI()
	local raceId = self._selectRaceId
	local curLevel = self._subMo:getPetLevel(raceId)
	local maxLevel = self._subMo:getMaxPetLevel(raceId)
	local upgradeResult = self._subMo:getTryUpgradePetResultAndTips(false, raceId, 1)
	local setWorkResult = self._subMo:getTrySetWorkBlockPetResultAndTips(false, self._selectBlockId, self._selectRaceId)
	local isFullLevel = maxLevel <= curLevel
	local cosCoin = self._subMo:getCostCoinInPet(raceId, curLevel + 1)

	self._txtDesc_workPetUpgrade.text = cosCoin > 0 and MmUtil.formatNumber(cosCoin, FreeScuffleEnum.Units_Coin, 0) or "无"

	GameUtil.SetGray(self._btnUpgradeOnce_workPetUpgrade, upgradeResult ~= GameEnum.ResultCode.Success)
	GameUtil.SetGray(self._btnSure_workPetUpgrade, setWorkResult ~= GameEnum.ResultCode.Success)
	GameUtil.SetActive(self._btnSure_workPet, isFullLevel)
	GameUtil.SetActive(self._upgrade_workPet, not isFullLevel)
end

function FreeScuffleWorkSceneView:_onClearWorkPetColUI()
	self._workPetScrollerList:dispose()
	MaterialMgr.clearIcon(self._iconDesc_workPetUpgrade)
end

function FreeScuffleWorkSceneView:_updateWorkPetCell(view, cell, raceId, tag)
	local isWorking = self._subMo:isWorkingPet(raceId)
	local petStar = self._subMo:getPetStar(raceId)
	local maxPetStar = self._subMo:getMaxPetStar(raceId)
	local petLevel = self._subMo:getPetLevel(raceId)
	local isWithPet = self._subMo:isWithPet(raceId)
	local blockId = self._subMo:getPetWorkingBlock(raceId)
	local petData = FreeScuffleConfig.instance:getPetData(self._activityId, raceId)
	local mainGo = cell.gameObject
	local head = goutil.findChild(mainGo, "head")
	local con = goutil.findChild(mainGo, "head/mask/con")
	local txtLevel = goutil.findChildTextComponent(mainGo, "txtLevel")
	local txtName = goutil.findChildTextComponent(mainGo, "txtName")
	local txtBaseWork = goutil.findChildTextComponent(mainGo, "txtBaseWork")
	local txtExWork = goutil.findChildTextComponent(mainGo, "txtBaseWork/txtExWork")
	local txtDesc = goutil.findChildTextComponent(mainGo, "txtDesc")
	local tagWorking = goutil.findChild(mainGo, "tagWorking")
	local starScrView = goutil.findChild(mainGo, "star/scrView")
	local starScrCell = goutil.findChild(mainGo, "star/scrCell")
	local headName = string.format("icon_%s", petData.lihui)

	uGuiUtil.setSpriteToImage(con, uGuiUtil.SpriteType.BigBg, GameUrl.getCharacterIconUrl(headName))
	GameUtil.setUIImageSpriteIdx(head, petData.quality - 1)

	txtLevel.text = petLevel < 0 and "等级 未拥有" or string.format("等级 %s", petLevel)
	txtName.text = petData.name

	local baseRatio = self._subMo:getBaseIncreaseRatioRace(raceId, petLevel, petStar)

	txtBaseWork.text = string.format("收入：%s/秒", MmUtil.formatNumber(baseRatio, FreeScuffleEnum.Units_Coin, 1))

	if blockId > 0 then
		local exRatio = Mathf.Max(self._subMo:getCoinIncreaseRatioBlock(blockId) - baseRatio, 0)

		txtExWork.text = exRatio > 0 and string.format("+%s", MmUtil.formatNumber(exRatio, FreeScuffleEnum.Units_Coin, 1)) or ""
	else
		txtExWork.text = ""
	end

	local idList = self._subMo:getShipInPet(raceId)
	local shipDesc = ""

	for idx, relationshipId in ipairs(idList) do
		local data = FreeScuffleConfig.instance:getShipData(self._activityId, relationshipId)

		shipDesc = shipDesc .. data.desc .. (idx ~= #idList and "\n" or "")
	end

	if not petData.effectIds then
		local effectIds = {}

		shipDesc = shipDesc .. (#effectIds > 0 and "\n" or "")

		for idx, effectId in ipairs(petData.effectIds or {}) do
			local data = FreeScuffleConfig.instance:getIncreaseEffectData(self._activityId, effectId)

			shipDesc = shipDesc .. data.desc .. (idx ~= #effectIds and "\n" or "")
		end

		txtDesc.text = shipDesc

		GameUtil.SetGray(con, not isWithPet)
		GameUtil.SetActive(tagWorking, isWorking)
		GameUtil.setUIGroupIdx(mainGo, self._selectRaceId == raceId and 1 or 0)

		local starInfoList = {}

		for idx = 1, petStar do
			table.insert(starInfoList, {
				isActive = idx <= petStar
			})
		end

		if not self._starScrollerListDic[mainGo] then
			local scrollerList = ScrollerList.create(starScrView, starScrCell, GameUtil.handler(self._updateStarCell, self), GameUtil.handler(self._clearStarCell, self))

			self._starScrollerListDic[mainGo] = self._starScrollerListDic[mainGo]

			self._starScrollerListDic[mainGo]:dragNotifyParent()
			self._starScrollerListDic[mainGo]:reloadData(starInfoList)
			GameUtil.addClickHandler(mainGo, function()
				if self._selectRaceId == raceId then
					return
				end

				local oldSelectRaceId = self._selectRaceId

				self._selectRaceId = raceId

				local list = self._workPetScrollerList:getData()

				if list then
					for i, v in ipairs(list) do
						if v == raceId or v == oldSelectRaceId then
							self._workPetScrollerList:updateCellInViewByIndex(i - 1)
						end
					end
				end

				self:_updateWorkPetUpgradeUI()
			end)
		end
	end
end

function FreeScuffleWorkSceneView:_clearWorkPetCell(cell)
	local mainGo = cell.gameObject
	local con = goutil.findChild(mainGo, "head/mask/con")

	uGuiUtil.clearImage(con)

	local scrollList = self._starScrollerListDic[mainGo]

	if scrollList then
		scrollList:dispose()

		self._starScrollerListDic[mainGo] = nil
	end

	GameUtil.rmClickHandler(mainGo)
end

function FreeScuffleWorkSceneView:_btnHideWorkPetCol_InWork()
	self:_setWorkPetColVisible(not GameUtil.GetActive(self._workPetCol))
end

function FreeScuffleWorkSceneView:_onClickBtnSureInWork()
	local result = self._subMo:getTrySetWorkBlockPetResultAndTips(true, self._selectBlockId, self._selectRaceId)

	if result ~= GameEnum.ResultCode.Success then
		return
	end

	local function okFunc()
		local diction = {}
		local cfg = FreeScuffleConfig.instance:getBlockCfg(self._activityId) or {}

		for blockId, data in ipairs(cfg) do
			if self._subMo:isUnlockBlock(blockId) then
				diction[blockId] = self._subMo:getRaceIdBlock(blockId)
			end
		end

		local oldBlockId = self._subMo:getPetWorkingBlock(self._selectRaceId)

		diction[oldBlockId] = 0
		diction[self._selectBlockId] = self._selectRaceId

		local list = {}

		for blockId, raceId in pairs(diction) do
			if blockId > 0 then
				table.insert(list, {
					blockId = blockId,
					raceId = raceId
				})
			end
		end

		FreeScuffleController.instance:sendPM_FreeScuffleScheduleReq(self._activityId, list)
		self:_setWorkPetColVisible(false)
	end

	local workingBlockId = self._subMo:getPetWorkingBlock(self._selectRaceId)

	if workingBlockId > 0 then
		local tipsContent = "该精灵在其它区域生产，是否将其替换？"

		TipsFacade.instance:openPopupWindow("提示", tipsContent, okFunc, nil, "确定", "取消")
	else
		okFunc()
	end
end

function FreeScuffleWorkSceneView:_upgradePetLevel(upgradeLevel)
	local raceId = self._selectRaceId
	local result = self._subMo:getTryUpgradePetResultAndTips(true, raceId, upgradeLevel)

	if result ~= GameEnum.ResultCode.Success then
		return
	end

	FreeScuffleController.instance:sendPM_FreeScuffleUpgradlePetReq(self._activityId, raceId, upgradeLevel)
end

function FreeScuffleWorkSceneView:_onUpdatePetInfoCol()
	local blockId = self._selectBlockId
	local raceId = self._subMo:getRaceIdBlock(blockId)

	GameUtil.SetActive(self._petInfo, raceId > 0)

	if raceId <= 0 then
		self:_onClearPetInfoCol()

		return
	end

	local curLevel = self._subMo:getPetLevel(raceId)
	local maxLevel = self._subMo:getMaxPetLevel(raceId)
	local petStar = self._subMo:getPetStar(raceId)
	local maxPetStar = self._subMo:getMaxPetStar(raceId)
	local petData = FreeScuffleConfig.instance:getPetData(self._activityId, raceId)
	local upgradeOneResult = self._subMo:getTryUpgradePetResultAndTips(false, raceId, 1)
	local upgradeTenResult = self._subMo:getTryUpgradePetResultAndTips(false, raceId, 10)
	local costItem = self._subMo:getCostCoinItem()

	MaterialMgr.setIcon(self._iconOnceCost_petInfo, costItem.matType, costItem.matId, nil, nil)
	MaterialMgr.setIcon(self._iconTenCost_petInfo, costItem.matType, costItem.matId, nil, nil)

	local cosCoin = self._subMo:getCostNumUpgradePet(raceId, curLevel, curLevel + 1)

	self._txtOnceCost_petInfo.text = cosCoin > 0 and MmUtil.formatNumber(cosCoin, FreeScuffleEnum.Units_Coin, 0) or "无"

	GameUtil.SetActive(self._onceCost, cosCoin > 0)

	local tenCostCoin = self._subMo:getCostNumUpgradePet(raceId, curLevel, curLevel + 10)

	self._txtTenCost_petInfo.text = tenCostCoin > 0 and MmUtil.formatNumber(tenCostCoin, FreeScuffleEnum.Units_Coin, 0) or "无"

	GameUtil.SetActive(self._tenCost, tenCostCoin > 0)
	GameUtil.SetGray(self._btnUpgradeOnce_petInfo, upgradeOneResult ~= GameEnum.ResultCode.Success)
	GameUtil.SetGray(self._btnUpgradeTen_petInfo, upgradeTenResult ~= GameEnum.ResultCode.Success)

	local headName = string.format("icon_%s", petData.lihui)

	uGuiUtil.setSpriteToImage(self._con_petInfo, uGuiUtil.SpriteType.BigBg, GameUrl.getCharacterIconUrl(headName))

	self._txtLevel_petInfo.text = string.format("等级 %s", curLevel)

	local baseRatio = self._subMo:getBaseIncreaseRatioRace(raceId, curLevel, petStar)
	local exRatio = self._subMo:getCoinIncreaseRatioBlock(blockId) - baseRatio

	self._txtBaseWork_petInfo.text = string.format("%s/秒", MmUtil.formatNumber(baseRatio, FreeScuffleEnum.Units_Coin, 1))
	self._txtExWork_petInfo.text = string.format("+%s", MmUtil.formatNumber(exRatio, FreeScuffleEnum.Units_Coin, 1))

	local nextLvel = Mathf.Min(curLevel + 1, maxLevel)

	if nextLvel == curLevel then
		self._txtNextEnergy_petInfo.text = "已满级"
	else
		local nextBaseRatio = self._subMo:getBaseIncreaseRatioRace(raceId, Mathf.Min(curLevel + 1, maxLevel), petStar)

		self._txtNextEnergy_petInfo.text = string.format("%s/秒", MmUtil.formatNumber(nextBaseRatio, FreeScuffleEnum.Units_Coin, 1))
	end

	self._txtName_petInfo.text = petData.name

	GameUtil.setUIImageSpriteIdx(self._head_petInfo, petData.quality - 1)

	local shipDesc = ""
	local idList = self._subMo:getShipInPet(raceId)

	for idx, relationshipId in ipairs(idList) do
		local data = FreeScuffleConfig.instance:getShipData(self._activityId, relationshipId)

		shipDesc = shipDesc .. data.desc .. (idx ~= #idList and "\n" or "")
	end

	self._txtShip_petInfo.text = shipDesc

	GameUtil.SetActive(self._txtShip_petInfo.gameObject, not string.nilorempty(shipDesc))

	local effectDesc = ""

	if not petData.effectIds then
		local effectIds = {}

		for idx, effectId in ipairs((not petData.effectIds or nil) and {}) do
			local data = FreeScuffleConfig.instance:getIncreaseEffectData(self._activityId, effectId)

			effectDesc = effectDesc .. data.desc .. (idx ~= #effectIds and "\n" or "")
		end

		self._txtProfit_petInfo.text = effectDesc

		GameUtil.SetActive(self._txtProfit_petInfo.gameObject, not string.nilorempty(effectDesc))

		local starInfoList = {}

		for idx = 1, petStar do
			table.insert(starInfoList, {
				isActive = idx <= petStar
			})
		end

		local scrollList = self._starPetInfoScrollerList

		scrollList:dragNotifyParent()
		scrollList:reloadData(starInfoList)
	end
end

function FreeScuffleWorkSceneView:_onClearPetInfoCol()
	self._starPetInfoScrollerList:dispose()
	MaterialMgr.clearIcon(self._iconOnceCost_petInfo)
	MaterialMgr.clearIcon(self._iconTenCost_petInfo)
	uGuiUtil.clearImage(self._con_petInfo)
end

function FreeScuffleWorkSceneView:_onUpdateShipColUI()
	local list = {}
	local cfg = FreeScuffleConfig.instance:getShipCfg(self._activityId) or {}

	for _, data in ipairs(cfg) do
		if self._subMo:isActiveShip(data.relationshipId) then
			table.insert(list, data.relationshipId)
		end
	end

	GameUtil.SetActive(self._shipScrView, #list > 0)
	self._shipScrollerList:reloadData(list)
end

function FreeScuffleWorkSceneView:_onClearShipCol()
	self._shipScrollerList:dispose()
end

function FreeScuffleWorkSceneView:_updateShipCell(view, cell, relationshipId, tag)
	local data = FreeScuffleConfig.instance:getShipData(self._activityId, relationshipId)

	if not data.petIds then
		local mainGo = cell.gameObject
		local petView = goutil.findChild(mainGo, "petView/Viewport/content")
		local petCell = goutil.findChild(mainGo, "petCell")

		GameUtil.updateCellsList(petView, petCell, data.petIds, function(go, raceId, i)
			local isStart = i == 1
			local petData = FreeScuffleConfig.instance:getPetData(self._activityId, raceId)
			local con = goutil.findChild(go, "mask/con")
			local tag = goutil.findChild(go, "tag")

			GameUtil.setUIImageSpriteIdx(go, petData.quality - 1)

			local headPath = GameUrl.getCharacterIconUrl(string.format("icon_%s", petData.lihui))

			uGuiUtil.setSpriteToImage(con, uGuiUtil.SpriteType.BigBg, headPath)
			GameUtil.SetActive(tag, not isStart)
		end)
	end
end

function FreeScuffleWorkSceneView:_clearShipCell(cell)
	local mainGo = cell.gameObject
	local petView = goutil.findChild(mainGo, "petView/Viewport/content")

	GameUtil.clearCells(petView, function(go, i)
		local con = goutil.findChild(go, "mask/con")

		uGuiUtil.clearImage(con)
	end, nil, false)
end

function FreeScuffleWorkSceneView:_onUpdatePackageCol()
	GameUtil.SetActive(self._trainPackage, false)
	GameUtil.SetActive(self._idlePackage, true)

	if not self._isPlayingPackage or self._viewState == ViewState_Edti then
		return
	end

	local packageInfos = self._subMo:getPackageInfos()
	local infos = {}

	for onlyId, v in pairs(packageInfos) do
		local packageData = FreeScuffleConfig.instance:getPackageData(self._activityId, v.blockId, v.packageId)
		local blockData = FreeScuffleConfig.instance:getBlockData(self._activityId, v.blockId)
		local quality = packageData.quality
		local key = string.format("%s_%s_%s", v.zoneId, v.packageId, quality)
		local info = infos[key]

		if info == nil then
			info = {
				onlyIdList = {},
				blockId = v.blockId,
				packageId = v.packageId,
				quality = quality,
				zoneId = blockData.zoneId
			}
			info.num = 0
		end

		if v.num > 0 then
			info.num = info.num + v.num

			table.insert(info.onlyIdList, onlyId)
		end

		if info.num > 0 then
			infos[key] = info
		end
	end

	local infoList = TableUtil.toList(infos)

	if #infoList > 0 then
		GameUtil.SetActive(self._trainPackage, true)
		GameUtil.SetActive(self._idlePackage, false)

		local dataLen = #infoList
		local childCount = self._packageView.transform.childCount
		local length = Mathf.Max(dataLen, childCount)

		for index = 1, length do
			local mainGo

			if index <= childCount then
				mainGo = self._packageView.transform:GetChild(index - 1).gameObject
			else
				local info = infoList[index]

				printError(string.format("错误，配置获得包裹数量比预制里包裹多，需要改写预制( acitivityId:%s, blockId:%s, packageId:%s )", self._activityId, info.blockId, info.packageId))

				break
			end

			GameUtil.SetActive(mainGo, index <= dataLen)

			if index <= dataLen then
				local info = infoList[index]

				self:_updatePackageCell(mainGo, info, index)
			else
				self:_clearPackageCell(mainGo)
			end
		end
	else
		GameUtil.SetActive(self._trainPackage, false)
		GameUtil.SetActive(self._idlePackage, true)
	end
end

function FreeScuffleWorkSceneView:_onClearPackageCol()
	self._isPlayingPackage = false

	local childCount = self._packageView.transform.childCount

	for index = 1, childCount do
		local mainGo = self._packageView.transform:GetChild(index - 1).gameObject

		self._clearPackageCell(mainGo)
	end
end

function FreeScuffleWorkSceneView:_updatePackageCell(mainGo, info, index)
	local onlyIdList = info.onlyIdList
	local quality = info.quality
	local zoneId = info.zoneId
	local imgBg = goutil.findChild(mainGo, "imgBg")
	local icon = goutil.findChild(mainGo, "imgBg/icon")
	local txtCount = goutil.findChildTextComponent(mainGo, "count/txt")

	txtCount.text = info.num

	GameUtil.setUIImageSpriteIdx(imgBg, quality > 1 and 1 or 0)
	GameUtil.setUIImageSpriteIdx(icon, Mathf.Max(zoneId - 1, 0))
	GameUtil.addClickHandler(mainGo, function()
		if self._subMo:getTodayLeftPackageTime() <= 0 then
			FloatWordMgr.instance:show("剩余包裹领取次数不足")

			return
		end

		if #onlyIdList <= 0 then
			printError("错误，包裹数量为0")

			return
		end

		local onlyId = table.remove(onlyIdList, #onlyIdList)
		local packageInfo = self._subMo:getPackageInfo(onlyId)

		if packageInfo == nil then
			printError("错误，包裹数据无法找到")

			return
		end

		info.num = info.num - packageInfo.num

		if info.num <= 0 then
			GameUtil.SetActive(mainGo, false)
		end

		txtCount.text = info.num

		local pos = GameUtil.getPos(mainGo)

		self:_playFlyPackAnim(pos, zoneId)
		FreeScuffleController.instance:sendPM_FreeScuffleDeliverPackageReq(self._activityId, packageInfo.packageId, packageInfo.blockId)
	end)
end

function FreeScuffleWorkSceneView:_clearPackageCell(mainGo)
	GameUtil.rmClickHandler(mainGo)
end

function FreeScuffleWorkSceneView:_onUpdateEggColUI()
	if not self._isPlayingEgg or self._viewState == ViewState_Edti then
		self:_onClearEggColUI()
		GameUtil.SetActive(self._eggTrigger, false)

		return
	end

	GameUtil.SetActive(self._eggTrigger, true)

	self._fangKeSpineCtrl = self._fangKeSpineCtrl or FreeScuffleFangKeSpineCtrl.New()

	self._fangKeSpineCtrl:onInit(self._eggRoot, self, "character/80033_lvxingniao/80033_lvxingniao-ui_p.prefab")
end

function FreeScuffleWorkSceneView:_onClearEggColUI()
	if self._fangKeSpineCtrl == nil then
		return
	end

	self._fangKeSpineCtrl:onClear()
end

function FreeScuffleWorkSceneView:_onUpdateTaskColUI()
	local cfg = FreeScuffleConfig.instance:getTaskDataListByGroup(self._activityId, FreeScuffleEnum.TaskGroup_Day) or {}
	local taskInfoList = {}

	for _, data in ipairs(cfg) do
		local info = {}

		info.taskId = data.taskId
		info.state = self._subMo:getTaskState(data.taskId)
		info.data = data

		table.insert(taskInfoList, info)
	end

	table.sort(taskInfoList, function(a, b)
		if a.state == b.state then
			if a.taskId < b.taskId then
				return true
			end

			return false
		end

		return a.state < b.state
	end)

	local taskInfo = taskInfoList[1]

	if taskInfo then
		local data = taskInfo.data

		self._txtNameTask.text = data.title

		local cur = self._subMo:getProgressTask(taskInfo.taskId)
		local max = data.maxProgress

		self._txtProgressTask.text = string.format("（%s/%s）", Mathf.Min(cur, max), max)

		local isCanGain = self._subMo:isCanGainOfTask(taskInfo.taskId)
		local prizeInfoArr = {}

		if not string.nilorempty(data.prize) then
			local array = string.split(data.prize, "#")

			for i, v in ipairs(array) do
				table.insert(prizeInfoArr, {
					matStr = v,
					isCanGain = isCanGain
				})
			end
		end

		if checknumber(data.increaseCoin) > 0 then
			local matStr = string.format("%s:%s:%s", self._coinItem.matType, self._coinItem.matId, data.increaseCoin)

			table.insert(prizeInfoArr, {
				matStr = matStr,
				isCanGain = isCanGain
			})
		end

		GameUtil.SetActive(self._itemScrViewInTask, #prizeInfoArr > 0)

		if #prizeInfoArr > 0 then
			self._itemTaskScrollerList:reloadData(prizeInfoArr)
		else
			self._itemTaskScrollerList:dispose()
		end
	else
		self._txtNameTask.text = "任务"
		self._txtProgressTask.text = string.format("（0/0）")

		self._itemTaskScrollerList:dispose()
		GameUtil.SetActive(self._itemScrViewInTask, false)
	end
end

function FreeScuffleWorkSceneView:_onClearTaskColUI()
	self._itemTaskScrollerList:dispose()
	GameUtil.SetActive(self._itemScrViewInTask, false)
end

function FreeScuffleWorkSceneView:_updateItemTaskCell(view, cell, info, tag)
	local mainGo = cell.gameObject
	local item = goutil.findChild(mainGo, "item")
	local effRoot = goutil.findChild(mainGo, "effRoot")

	MaterialMgr.setCellByCfg(info.matStr, item)

	if info.isCanGain then
		self:playViewEffectUniGo("fx_ui_juqingfuben/fx_ui_juqingfuben02.prefab", effRoot, self._itemScrViewInTask, true)
	else
		self:stopViewEffectUniGo(effRoot)
	end
end

function FreeScuffleWorkSceneView:_clearItemTaskCell(cell)
	local mainGo = cell.gameObject
	local item = goutil.findChild(mainGo, "item")
	local effRoot = goutil.findChild(mainGo, "effRoot")

	MaterialMgr.resetAll(item)
	self:stopViewEffectUniGo(effRoot)
end

function FreeScuffleWorkSceneView:_playWrokFloatAnim(value, diff)
	self._txtValueFloatWork.text = string.format("%s/秒", MmUtil.formatNumber(value, FreeScuffleEnum.Units_Coin, 1))

	local isUp = checknumber(diff) >= 0

	self._txtDiffFloatWork.text = isUp and string.format("+%s", MmUtil.formatNumber(diff, FreeScuffleEnum.Units_Coin, 1)) or string.format("%s", MmUtil.formatNumber(diff, FreeScuffleEnum.Units_Coin, 1))

	self:_clearWorkFloatAnim()

	local sequence = DG.Tweening.DOTween.Sequence()

	self._sequenceWork = sequence

	local targeGo = self._workFloatGo

	GameUtil.setUIGroupIdx(targeGo, isUp and 1 or 0)
	GameUtil.setLocalPos(targeGo, 0, 0, 0)
	GameUtil.SetActive(targeGo, true)

	local toPos = GameUtil.getLocalPos(targeGo)

	toPos.y = toPos.y + 34

	local tweenerMove = targeGo.transform:DOLocalMove(toPos, 0.2)

	tweenerMove:SetEase(DG.Tweening.Ease.Linear)
	sequence:Join(tweenerMove)
	sequence:AppendInterval(1)
	sequence:OnComplete(function()
		GameUtil.SetActive(targeGo, false)
	end)
end

function FreeScuffleWorkSceneView:_clearWorkFloatAnim()
	if self._sequenceWork then
		self._sequenceWork:Kill(true)

		self._sequenceWork = nil
	end
end

function FreeScuffleWorkSceneView:_playWorkingAccumulateEff()
	self:playViewEffectUniGo("20250627/ziyouluandou/fx_ui_zyld_lankuang.prefab", self._workingAccumulateEffRoot, nil, false)
end

function FreeScuffleWorkSceneView:_playFlyPackAnim(pos, zoneId)
	local function finishHandle(handlerTarget, eff)
		return
	end

	local function loadedHandler(handlerTarget, eff)
		local mainGo = eff.effGo

		GameUtil.SetActive(mainGo, false)
		GameUtil.setPos(mainGo, pos.x, pos.y, pos.z)

		local toGo = self._flyPackTargetPosGoDic[zoneId]
		local toPos = GameUtil.getPos(toGo)
		local sequence = DG.Tweening.DOTween.Sequence()
		local tweenerMove = mainGo.transform:DOMove(toPos, 1)

		tweenerMove:SetEase(DG.Tweening.Ease.Linear)
		sequence:Join(tweenerMove)
		sequence:InsertCallback(0.05, function()
			GameUtil.SetActive(mainGo, true)
		end)
		sequence:AppendInterval(0.1)
		sequence:OnComplete(function()
			self._flyPackSequenceDic[mainGo] = nil

			GameUtil.SetActive(mainGo, false)
			self:stopViewEffect(eff)

			local go = self._zoneEffGos[zoneId]
			local effPath = string.format("20250627/ziyouluandou/%s.prefab", go.name)

			self:playViewEffect(effPath, go, nil, false)
		end)

		self._flyPackSequenceDic = self._flyPackSequenceDic or {}
		self._flyPackSequenceDic[mainGo] = sequence
	end

	self:playViewEffect("20250627/ziyouluandou/fx_ui_zyld_shouqu.prefab", self._flyPackView, nil, true, 0, 0, finishHandle, loadedHandler)
end

function FreeScuffleWorkSceneView:_clearAllFlyPackAnim()
	if self._flyPackSequenceDic == nil then
		return
	end

	for _, sequence in pairs(self._flyPackSequenceDic) do
		sequence:Kill(false)
	end

	table.clear(self._flyPackSequenceDic)
end

function FreeScuffleWorkSceneView:_playCoinFloatAnim(value)
	self._txtValueFloatCoin.text = checknumber(value) < 0 and string.format("%s", MmUtil.formatNumber(value, FreeScuffleEnum.Units_Coin, 1)) or string.format("+%s", MmUtil.formatNumber(value, FreeScuffleEnum.Units_Coin, 1))

	self:_clearCoinFloatAnim()

	local sequence = DG.Tweening.DOTween.Sequence()

	self._sequenceCoin = sequence

	local targeGo = self._coinFloatGo

	GameUtil.setLocalPos(targeGo, 0, 0, 0)
	GameUtil.SetActive(targeGo, true)

	local toPos = GameUtil.getLocalPos(targeGo)

	toPos.y = toPos.y + 34

	local tweenerMove = targeGo.transform:DOLocalMove(toPos, 0.2)

	tweenerMove:SetEase(DG.Tweening.Ease.Linear)
	sequence:Join(tweenerMove)
	sequence:AppendInterval(1)
	sequence:OnComplete(function()
		GameUtil.SetActive(targeGo, false)
	end)
end

function FreeScuffleWorkSceneView:_clearCoinFloatAnim()
	if self._sequenceCoin then
		self._sequenceCoin:Kill(true)

		self._sequenceCoin = nil
	end
end

function FreeScuffleWorkSceneView:_switchViewState(viewState)
	self._viewState = viewState

	self:_onUpdateUI()

	if self._viewState == ViewState_Edti then
		self:_setWorkPetColVisible(true)
	end
end

function FreeScuffleWorkSceneView:_onClickBtnTips()
	local key = self._actData.imgRuleKeyMain

	TipsFacade.instance:openImageRuleViewByKey(key)
end

function FreeScuffleWorkSceneView:_onClickBtnRank()
	FreeScuffleController.instance:openCommonTabRankView(self._activityId)
end

function FreeScuffleWorkSceneView:_onClickBtnLottery()
	UIStateManager.instance:push(ViewName.FreeScuffleCardPoolView, self._activityId)
end

function FreeScuffleWorkSceneView:_onClickBtnHarvest()
	local blockIds = {}

	for _, blockId in ipairs(self._blockIdList) do
		if self._subMo:isUnlockBlock(blockId) and self._subMo:getRaceIdBlock(blockId) > 0 and self._subMo:getAccumulateCoinInBlock(blockId) > 0 and not self._lockGolds[blockId] then
			table.insert(blockIds, blockId)

			self._lockGolds[blockId] = true

			local cell = self._blockCells[blockId]

			if cell then
				GameUtil.SetActive(cell._gold, false)
			end
		end
	end

	if #blockIds > 0 then
		FreeScuffleController.instance:sendPM_FreeScuffleGainCoinReq(self._activityId, blockIds)
	end
end

function FreeScuffleWorkSceneView:_onClickBtnBook()
	UIStateManager.instance:push(ViewName.FreeScuffleBookView, self._activityId)
end

function FreeScuffleWorkSceneView:_onCliTaskCol()
	UIStateManager.instance:push(ViewName.FreeScuffleTaskView, self._activityId, FreeScuffleEnum.TaskGroup_Day)
end

function FreeScuffleWorkSceneView:_onClickBtnShipDesc()
	UIStateManager.instance:push(ViewName.FreeScuffleShipDescView, self._activityId)
end

return FreeScuffleWorkSceneView
