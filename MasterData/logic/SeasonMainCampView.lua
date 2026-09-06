-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/season/view/SeasonMainCampView.lua

module("logic.extensions.season.view.SeasonMainCampView", package.seeall)

local SeasonMainCampView = class("SeasonMainCampView", ViewComponent)

SeasonMainCampView.boxEffect = "20221028/jinglingdian/fx_ui_baoxiang_saijiwanfa.prefab"
SeasonMainCampView.levelupEffect = "20221028/jinglingdian/fx_ui_jiesuo01_jinglingdian.prefab"

function SeasonMainCampView:ctor()
	SeasonMainCampView.super.ctor(self)
end

function SeasonMainCampView:unbindEvents()
	SeasonMainCampView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnLockTip)
	GameUtil.rmClickHandler(self._btnLevelUp)
	GameUtil.rmClickHandler(self._boxClick)
	GameUtil.rmClickHandler(self._maskCloseGo)
	self._tipsCustomInputComp:RemoveListener()

	for i = 1, #self._petGuardianGroups do
		local cell = self._petGuardianGroups[i]
		local btnAdd = goutil.findChild(cell, "btnAdd")

		GameUtil.rmClickHandler(btnAdd)
	end
end

function SeasonMainCampView:bindEvents()
	SeasonMainCampView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickRule, self)
	GameUtil.addClickHandler(self._btnLockTip, self._onClickLockPopTips, self)
	GameUtil.addClickHandler(self._btnLevelUp, self._onClickLevelUp, self)
	GameUtil.addClickHandler(self._boxClick, self._onClickBox, self)
	GameUtil.addClickHandler(self._maskCloseGo, self._onClickMaskClose, self)
	self._tipsCustomInputComp:AddListener(self._tipsCustomInputChanged, self)

	for i = 1, #self._petGuardianGroups do
		local cell = self._petGuardianGroups[i]
		local btnAdd = goutil.findChild(cell, "btnAdd")

		GameUtil.addClickHandler(btnAdd, GameUtil.handler(self._onClickPetGrid, self, i))
	end
end

function SeasonMainCampView:buildUI()
	SeasonMainCampView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._btnTip = self:getGo("btnTip")
	self._txtLevel = self:getTxt("campInfo/txtLevel")
	self._lockTipGo = self:getGo("campInfo/lockTip")
	self._txtLockTip = self:getTxt("campInfo/lockTip/txtName")
	self._btnLockTip = self:getGo("campInfo/title/btnTip")
	self._lockPopTip = self:getGo("campInfo/lockpopTip")
	self._maskCloseGo = self:getGo("campInfo/maskClose")
	self._txtLockPopTip = self:getTxt("campInfo/lockpopTip/txtscrollContent/Viewport/Content")
	self._btnLevelUp = self:getGo("campInfo/btnLevelUp")
	self._btnLevelUpRed = self:getGo("campInfo/btnLevelUp/redpoint")
	self._txtLevelUpCost = MaterialMgr.findGraphicText(self.mainGO, "campInfo/txtCost")
	self._goldBarCon = self:getGo("goldBarCon")
	self._effectLevelUp = self:getGo("campInfo/effect")
	self._effectBox = self:getGo("income/effect")
	self._incomeInfo = self:getGo("income/incomeInfo")
	self._incomeInfoCell = self:getGo("income/incomeInfo/cell")
	self._txtBox = self:getTxt("income/box/txt")
	self._boxClick = self:getGo("income/click")

	local petGuardianGo = self:getGo("petGuardian")

	self._petGuardianGroups = {}

	for i = 1, 3 do
		local item = goutil.findChild(petGuardianGo, string.format("pos_%s", i))

		table.insert(self._petGuardianGroups, item)
	end

	GameUtil.SetActive(self._incomeInfoCell, false)
	GameUtil.SetActive(self._lockPopTip, false)
	GameUtil.SetActive(self._maskCloseGo, false)

	self._tipsCustomInputComp = UICustomInput.Get(self._btnLockTip.gameObject)
	self._prizeCells = {}
	self._prizeTxts = {}
end

function SeasonMainCampView:onExit()
	SeasonMainCampView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.SeasonMainCampInfoUpdated, self._updateAll, self)
	GlobalDispatcher:removeListener(GlobalNotify.SeasonFmtTeamInfo, self._onGetFmtInfo, self)
	GlobalDispatcher:removeListener(GlobalNotify.SeasonFmtBagPetInfo, self._onGetBagInfo, self)
	GlobalDispatcher:removeListener(GlobalNotify.SeasonMainCampBoxEffectUpdate, self._onClearEffect, self)
	GlobalDispatcher:removeListener(GlobalNotify.SeasonMainCampLevelUpEffectUpdate, self._onPlayLevelUpEffect, self)
	removetimer(self._updateTimer, self)

	for i, cell in ipairs(self._prizeCells) do
		local icon = goutil.findChild(cell, "icon")

		MaterialMgr.resetAll(icon)
		GameUtil.SetActive(cell, false)
	end

	for i, cell in ipairs(self._petGuardianGroups) do
		local item = goutil.findChild(cell, "item")

		MaterialMgr.resetAll(item)
	end

	self:_removeCellEff(self._effectBox)
end

function SeasonMainCampView:onEnter()
	SeasonMainCampView.super.onEnter(self)
	GlobalDispatcher:addListener(GlobalNotify.SeasonMainCampInfoUpdated, self._updateAll, self)
	GlobalDispatcher:addListener(GlobalNotify.SeasonFmtTeamInfo, self._onGetFmtInfo, self)
	GlobalDispatcher:addListener(GlobalNotify.SeasonFmtBagPetInfo, self._onGetBagInfo, self)
	GlobalDispatcher:addListener(GlobalNotify.SeasonMainCampBoxEffectUpdate, self._onClearEffect, self)
	GlobalDispatcher:addListener(GlobalNotify.SeasonMainCampLevelUpEffectUpdate, self._onPlayLevelUpEffect, self)

	local seasonId = SeasonModel.instance:getSeasonId()

	self._mainCampConfig = SeasonMainCampConfig.instance:getMainCampConfig(seasonId)
	self._levelUpConfigs = SeasonMainCampConfig.instance:getMainCampUpgradeConfig(self._mainCampConfig.upgradePlanId)

	self:_initLockPopTip()
	self:_updateAll()
	self:_updateTimer()
	settimer(1, self._updateTimer, self, true)
	GameUtil.SetActive(self._btnTip, true)
	self:_sendMsg()
	SeasonMainCampController.instance:trySendTriggerHangingStartTime()
	self:_openGoldBarCon()
end

function SeasonMainCampView:_onPlayLevelUpEffect()
	self:_playCellEff(self._effectLevelUp, false, SeasonMainCampView.levelupEffect)

	local campLv = SeasonMainCampModel.instance:getCampLv()
	local params = SeasonMainCampConfig.instance:getUnlockInfo(campLv)

	if params.isUnLock == 1 then
		ViewMgr.instance:open(ViewName.SeasonMainCampLvUpView, params)
	end
end

function SeasonMainCampView:_onClearEffect()
	self:_removeCellEff(self._effectBox)
end

function SeasonMainCampView:_openGoldBarCon()
	local seasonId = SeasonModel.instance:getSeasonId()
	local config = SeasonMainCampConfig.instance:getMainCampConfig(seasonId)
	local barList = string.split(config.barList or "", "#")
	local btnList = {}

	for i, v in ipairs(barList) do
		table.insert(btnList, {
			showAdd = false,
			id = v
		})
	end

	MainUIController.instance:showGlodBar(self._goldBarCon, self._viewPresentor, btnList)
end

function SeasonMainCampView:_sendMsg()
	SeasonController.instance:sendGetAllTeamInfo()
	SeasonController.instance:sendGetAllPetListInfo()
end

function SeasonMainCampView:_onGetBagInfo()
	self._bagPetMap = {}

	for _, mo in ipairs(SeasonPetsModel.instance:getSeasonBagPetList() or {}) do
		if self._bagPetMap[mo.raceId] == nil then
			self._bagPetMap[mo.raceId] = mo
		elseif mo.awakenLv >= self._bagPetMap[mo.raceId].awakenLv then
			self._bagPetMap[mo.raceId] = mo
		end
	end

	self:_updateAll()
end

function SeasonMainCampView:_onGetFmtInfo()
	self._fmtPetMap = {}

	for _, teamMo in ipairs(SeasonTeamsModel.instance:getTeams() or {}) do
		for _, mo in ipairs(teamMo:getPetMoList() or {}) do
			if self._fmtPetMap[mo.raceId] == nil then
				self._fmtPetMap[mo.raceId] = mo
			elseif mo.awakenLv >= self._fmtPetMap[mo.raceId].awakenLv then
				self._fmtPetMap[mo.raceId] = mo
			end
		end
	end

	self:_updateAll()
end

function SeasonMainCampView:_getMo(raceId)
	local mo1

	if self._bagPetMap then
		mo1 = self._bagPetMap[raceId]
	end

	local mo2

	if self._fmtPetMap then
		mo2 = self._fmtPetMap[raceId]
	end

	if mo1 and mo2 then
		if mo1.awakenLv >= mo2.awakenLv then
			return mo1
		else
			return mo2
		end
	elseif mo1 then
		return mo1
	elseif mo2 then
		return mo2
	end
end

function SeasonMainCampView:_updateAll()
	local model = SeasonMainCampModel.instance

	self._totalRate = 0

	for i = 1, 3 do
		local raceIdT = model:getPetGuardByPos(i)
		local petMo = self:_getMo(raceIdT)

		self._totalRate = self._totalRate + model:getPetGuardUpRate(petMo)
	end

	self:_updatePrizeList()
	self:_updateInfo()
	self:_updatePetGuardian()
	self:_updateTimer()
	self:_updatePrizeDetail()
end

function SeasonMainCampView:_updatePrizeList()
	local model = SeasonMainCampModel.instance
	local level = model:getCampLv()
	local config = self._levelUpConfigs[level]

	if config then
		if self._prizeCells then
			for i = 1, #self._prizeCells do
				GameUtil.SetActive(self._prizeCells[i], false)
			end
		end

		local prizeArray = string.split(config.hangingPrize, "#")

		self._prizeTxts = {}
		self._prizeBaseNums = {}

		for i = 1, #prizeArray do
			local cell = self._prizeCells[i]

			if not cell then
				cell = goutil.cloneAndSetParent(self._incomeInfoCell, self._incomeInfo.transform)

				table.insert(self._prizeCells, cell)
			end

			GameUtil.SetActive(cell, true)

			local txtDesc = goutil.findChildTextComponent(cell, "txtDesc")

			txtDesc.text = ""
			self._prizeTxts[i] = txtDesc

			local matType, id, matNum = MaterialMgr.getMatParams(prizeArray[i])

			self._prizeBaseNums[i] = matNum * 12

			local icon = goutil.findChild(cell, "icon")
			local proxy = MaterialMgr.setCellByCfg(prizeArray[i], icon)

			if proxy then
				proxy.binder:setBgActive(false)
				proxy.binder:setNumStr("")
				proxy.binder:setNumBg(false)
				proxy.binder:setEffStatus(false)
			end
		end
	end
end

function SeasonMainCampView:_updatePrizeDetail()
	if self._prizeTxts then
		for i, txtDesc in ipairs(self._prizeTxts) do
			txtDesc.text = self._totalRate > 0 and langPara("%s(+%s%%)/小时", self._prizeBaseNums[i], self._totalRate) or langPara("%s/小时", self._prizeBaseNums[i])
		end
	end
end

function SeasonMainCampView:_playCellEff(go, loop, path)
	if not go then
		return
	end

	self._effs = self._effs or {}

	if loop then
		if self._effs[go] then
			return
		end
	else
		self:_removeCellEff(go)
	end

	local resPath = path

	local function finishHandler()
		if not loop then
			self:_removeCellEff(go)
		end
	end

	self._effs[go] = UIEffectManager.instance:playEffect(self, resPath, nil, nil, nil, loop, nil, finishHandler, loadCallBack)

	self._effs[go]:setParent(go.transform)
	self._effs[go]:setScaleXYZ(1, 0.6, 1)
	self._effs[go]:setLocalPos(0, 0, 0)
end

function SeasonMainCampView:_removeCellEff(go)
	if not go then
		return
	end

	self._effs = self._effs or {}

	if self._effs[go] then
		UIEffectManager.instance:stopEffect(self._effs[go])

		self._effs[go] = nil
	end
end

function SeasonMainCampView:_updateTimer()
	local model = SeasonMainCampModel.instance
	local startMS = model:getHangingStartTime()

	if model:hasTriggerHangingStartTime() then
		local over = ServerTime.now() - startMS / 1000

		over = math.min(self._mainCampConfig.hangingMaxMinute * 60, over)

		local hour, min, sec = GameUtil.getTimeHHMMSS(over)

		self._txtBox.text = string.format("%02d:%02d:%02d", hour, min, sec)

		if math.floor(over) >= self._mainCampConfig.hangingMinMinute * 60 then
			self:_playCellEff(self._effectBox, true, SeasonMainCampView.boxEffect)
		end
	else
		self._txtBox.text = ""
	end
end

function SeasonMainCampView:_updateInfo()
	local model = SeasonMainCampModel.instance
	local level = model:getCampLv()

	self._txtLevel.text = langPara("Lv.%s", level)

	local strUpgradeTips = self:_findNextUpgradeTips()

	self._txtLockTip.text = strUpgradeTips or ""
	self._nextConfig = self._levelUpConfigs[level + 1]

	GameUtil.SetActive(self._btnLevelUpRed, false)
	GameUtil.SetActive(self._btnLevelUp, self._nextConfig ~= nil)

	self._txtLevelUpCost.text = ""

	if self._nextConfig and not string.nilorempty(self._nextConfig.cost) then
		GameUtil.SetActive(self._txtLevelUpCost, true)

		local content = ""

		self._costArray = string.split(self._nextConfig.cost, "#")

		local isAll = true

		for i, cfgStr in ipairs(self._costArray) do
			local type, id, num = MaterialMgr.getMatParams(cfgStr)

			content = content .. MaterialMgr.getContentMatStr(cfgStr, 35, -10, MaterialMgr.ICON_TYPE_ICON) .. "x"

			if not MaterialModel.instance:IsEnough(type, id, num) then
				content = content .. string.format("<color=#FF0000>%s</color> ", num)
				isAll = false
			else
				content = content .. num .. " "
			end
		end

		self._txtLevelUpCost.text = langPara("消耗：%s", content)

		GameUtil.SetActive(self._btnLevelUpRed, isAll)
	else
		GameUtil.SetActive(self._txtLevelUpCost, false)
	end
end

function SeasonMainCampView:_updatePetGuardian()
	local model = SeasonMainCampModel.instance
	local configInstance = SeasonMainCampConfig.instance

	for index, cell in ipairs(self._petGuardianGroups) do
		self:_updateOnPetGuardian(cell, index, model, configInstance)
	end
end

function SeasonMainCampView:_updateOnPetGuardian(cell, index, model, configInstance)
	local level = model:getCampLv()
	local raceId = model:getPetGuardByPos(index)
	local config = configInstance:getPetGuardRecommendConfig(self._mainCampConfig.petGuardPlanId)
	local unlockLv = configInstance:getPetGuardUnlockLevel(config.gridPlanId, index)
	local lockGo = goutil.findChild(cell, "lock")
	local txtLock = goutil.findChildTextComponent(cell, "lock/txtLock")
	local txtEffect = goutil.findChildTextComponent(cell, "txtEffect")
	local btnAdd = goutil.findChild(cell, "btnAdd")
	local item = goutil.findChild(cell, "item")

	MaterialMgr.resetAll(item)

	local bHasPet = raceId ~= nil and raceId > 0
	local bLock = unlockLv ~= nil and level < unlockLv

	GameUtil.SetActive(btnAdd, not bLock and not bHasPet)
	GameUtil.SetActive(lockGo, bLock)
	GameUtil.SetActive(txtEffect, bHasPet)

	if bHasPet then
		local proxy = MaterialMgr.setCellByCfg(MaterialMgr.createSerName(MatType.Pet, raceId, 1), item)

		proxy.binder:setAutoTips(false)
		proxy:setCallBack(function()
			self:_onClickPetGrid(index)
		end)

		local raceIdT = model:getPetGuardByPos(index)
		local petMo = self:_getMo(raceIdT)

		txtEffect.text = langPara("增益：%s%%", model:getPetGuardUpRate(petMo))
	end

	if bLock then
		txtLock.text = langPara("主营地%s级解锁", unlockLv)
	end
end

function SeasonMainCampView:_findNextUpgradeTips()
	local model = SeasonMainCampModel.instance
	local campLv = model:getCampLv()

	for i, v in ipairs(self._levelUpConfigs) do
		if campLv < v.lv and not string.nilorempty(v.upgradeTips) then
			return v.upgradeTips, v.lv
		end
	end

	return nil
end

function SeasonMainCampView:_initLockPopTip()
	local array = {}

	for i, v in ipairs(self._levelUpConfigs) do
		if not string.nilorempty(v.upgradeTips) then
			table.insert(array, string.format("%s、%s", #array + 1, v.upgradeTips))
		end
	end

	self._txtLockPopTip.text = table.concat(array, "\n")
end

function SeasonMainCampView:_onClickLockPopTips()
	GameUtil.SetActive(self._lockPopTip, true)
	GameUtil.SetActive(self._maskCloseGo, true)
end

function SeasonMainCampView:_onClickLevelUp()
	if not self._nextConfig then
		return
	end

	if self._costArray then
		for i, cfgStr in ipairs(self._costArray) do
			local type, id, num = MaterialMgr.getMatParams(cfgStr)

			if not MaterialFacade.instance:checkMatEnough(type, id, num, nil, true) then
				return
			end
		end
	end

	SeasonModePveAgent.instance:sendPM_SMPVEUpgradeCampLvReq()
end

function SeasonMainCampView:_tipsCustomInputChanged(isHover)
	if isHover == false then
		-- block empty
	end
end

function SeasonMainCampView:_onClickMaskClose()
	GameUtil.SetActive(self._lockPopTip, false)
	GameUtil.SetActive(self._maskCloseGo, false)
end

function SeasonMainCampView:_onClickPetGrid(index)
	UIStateManager.instance:push(ViewName.SeasonPetGuardianView, index)
end

function SeasonMainCampView:_onClickRule()
	UIStateManager.instance:open(ViewName.RulesView, "SeasonMainCampView")
end

function SeasonMainCampView:_onClickBox()
	local model = SeasonMainCampModel.instance
	local startMS = model:getHangingStartTime()

	if model:hasTriggerHangingStartTime() then
		local over = ServerTime.now() - startMS / 1000
		local min = math.floor(over / 60)

		if min < self._mainCampConfig.hangingMinMinute then
			FloatWordMgr.instance:show(langPara("%s分钟后可领取", self._mainCampConfig.hangingMinMinute - min))

			return
		end

		SeasonModePveAgent.instance:sendPM_SMPVEGainHangingPrizeReq()
	end
end

return SeasonMainCampView
