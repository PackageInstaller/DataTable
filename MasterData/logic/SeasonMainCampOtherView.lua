-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/season/view/SeasonMainCampOtherView.lua

module("logic.extensions.season.view.SeasonMainCampOtherView", package.seeall)

local SeasonMainCampOtherView = class("SeasonMainCampOtherView", ViewComponent)

SeasonMainCampOtherView.boxEffect = "20221028/jinglingdian/fx_ui_baoxiang_saijiwanfa.prefab"
SeasonMainCampOtherView.levelupEffect = "20221028/jinglingdian/fx_ui_jiesuo01_jinglingdian.prefab"

function SeasonMainCampOtherView:ctor()
	SeasonMainCampOtherView.super.ctor(self)
end

function SeasonMainCampOtherView:unbindEvents()
	SeasonMainCampOtherView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnLockTip)
	GameUtil.rmClickHandler(self._maskCloseGo)
	self._tipsCustomInputComp:RemoveListener()

	for i = 1, #self._petGuardianGroups do
		local cell = self._petGuardianGroups[i]
		local btnAdd = goutil.findChild(cell, "btnAdd")

		GameUtil.rmClickHandler(btnAdd)
	end
end

function SeasonMainCampOtherView:bindEvents()
	SeasonMainCampOtherView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickRule, self)
	GameUtil.addClickHandler(self._btnLockTip, self._onClickLockPopTips, self)
	GameUtil.addClickHandler(self._maskCloseGo, self._onClickMaskClose, self)
	self._tipsCustomInputComp:AddListener(self._tipsCustomInputChanged, self)

	for i = 1, #self._petGuardianGroups do
		local cell = self._petGuardianGroups[i]
		local btnAdd = goutil.findChild(cell, "btnAdd")
	end
end

function SeasonMainCampOtherView:buildUI()
	SeasonMainCampOtherView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._btnTip = self:getGo("btnTip")
	self._txtLevel = self:getTxt("campInfo/txtLevel")
	self._lockTipGo = self:getGo("campInfo/lockTip")
	self._txtLockTip = self:getTxt("campInfo/lockTip/txtName")
	self._btnLockTip = self:getGo("campInfo/title/btnTip")
	self._lockPopTip = self:getGo("campInfo/lockpopTip")
	self._maskCloseGo = self:getGo("campInfo/maskClose")
	self._txtLockPopTip = self:getTxt("campInfo/lockpopTip/txtscrollContent/Viewport/Content")
	self._goldBarCon = self:getGo("goldBarCon")
	self._effectLevelUp = self:getGo("campInfo/effect")
	self._incomeInfo = self:getGo("income/incomeInfo")
	self._incomeInfoCell = self:getGo("income/incomeInfo/cell")

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

function SeasonMainCampOtherView:onExit()
	SeasonMainCampOtherView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.SeasonMainCampInfoUpdated, self._updateAll, self)
	GlobalDispatcher:removeListener(GlobalNotify.SeasonFmtTeamInfo, self._onGetFmtInfo, self)
	GlobalDispatcher:removeListener(GlobalNotify.SeasonFmtBagPetInfo, self._onGetBagInfo, self)
	GlobalDispatcher:removeListener(GlobalNotify.SeasonMainCampBoxEffectUpdate, self._onClearEffect, self)
	GlobalDispatcher:removeListener(GlobalNotify.SeasonMainCampLevelUpEffectUpdate, self._onPlayLevelUpEffect, self)

	for i, cell in ipairs(self._prizeCells) do
		local icon = goutil.findChild(cell, "icon")

		MaterialMgr.resetAll(icon)
		GameUtil.SetActive(cell, false)
	end

	for i, cell in ipairs(self._petGuardianGroups) do
		local item = goutil.findChild(cell, "item")

		MaterialMgr.resetAll(item)
	end
end

function SeasonMainCampOtherView:onEnter()
	SeasonMainCampOtherView.super.onEnter(self)
	GlobalDispatcher:addListener(GlobalNotify.SeasonMainCampInfoUpdated, self._updateAll, self)
	GlobalDispatcher:addListener(GlobalNotify.SeasonFmtTeamInfo, self._onGetFmtInfo, self)
	GlobalDispatcher:addListener(GlobalNotify.SeasonFmtBagPetInfo, self._onGetBagInfo, self)
	GlobalDispatcher:addListener(GlobalNotify.SeasonMainCampBoxEffectUpdate, self._onClearEffect, self)
	GlobalDispatcher:addListener(GlobalNotify.SeasonMainCampLevelUpEffectUpdate, self._onPlayLevelUpEffect, self)

	local seasonId = SeasonModel.instance:getSeasonId()

	self._mainCampConfig = SeasonMainCampConfig.instance:getMainCampConfig(seasonId)
	self._levelUpConfigs = SeasonMainCampConfig.instance:getMainCampUpgradeConfig(self._mainCampConfig.upgradePlanId)
	self._userId = SeasonModel.instance:getTeammateId()

	if checknumber(self._userId) > 0 then
		SeasonMainCampController.instance:sendGetSeasonMainCampInfo(self._userId)
	end

	self:_initLockPopTip()
	self:_updateAll()
	self:_sendMsg()
	SeasonMainCampController.instance:trySendTriggerHangingStartTime()
	GameUtil.SetActive(self._btnTip, false)
end

function SeasonMainCampOtherView:_onPlayLevelUpEffect()
	self:_playCellEff(self._effectLevelUp, false, SeasonMainCampOtherView.levelupEffect)

	local campLv = self:_getCampLevel()
	local params = SeasonMainCampConfig.instance:getUnlockInfo(campLv)

	if params.isUnLock == 1 then
		ViewMgr.instance:open(ViewName.SeasonMainCampLvUpView, params)
	end
end

function SeasonMainCampOtherView:_onClearEffect()
	return
end

function SeasonMainCampOtherView:_sendMsg()
	SeasonController.instance:sendGetAllTeamInfo()
	SeasonController.instance:sendGetAllPetListInfo()
end

function SeasonMainCampOtherView:_onGetBagInfo()
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

function SeasonMainCampOtherView:_onGetFmtInfo()
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

function SeasonMainCampOtherView:_getMo(raceId)
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

function SeasonMainCampOtherView:_updateAll()
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
	self:_updatePrizeDetail()
end

function SeasonMainCampOtherView:_updatePrizeList()
	local level = self:_getCampLevel()
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

function SeasonMainCampOtherView:_updatePrizeDetail()
	if self._prizeTxts then
		for i, txtDesc in ipairs(self._prizeTxts) do
			txtDesc.text = self._totalRate > 0 and langPara("%s(+%s%%)/小时", self._prizeBaseNums[i], self._totalRate) or langPara("%s/小时", self._prizeBaseNums[i])
		end
	end
end

function SeasonMainCampOtherView:_playCellEff(go, loop, path)
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

function SeasonMainCampOtherView:_removeCellEff(go)
	if not go then
		return
	end

	self._effs = self._effs or {}

	if self._effs[go] then
		UIEffectManager.instance:stopEffect(self._effs[go])

		self._effs[go] = nil
	end
end

function SeasonMainCampOtherView:_updateInfo()
	local level = self:_getCampLevel()

	self._txtLevel.text = langPara("Lv.%s", level)

	local strUpgradeTips = self:_findNextUpgradeTips()

	self._txtLockTip.text = strUpgradeTips or ""
	self._nextConfig = self._levelUpConfigs[level + 1]

	if self._nextConfig and not string.nilorempty(self._nextConfig.cost) then
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
	end
end

function SeasonMainCampOtherView:_updatePetGuardian()
	for index, cell in ipairs(self._petGuardianGroups) do
		self:_updateOnPetGuardian(cell, index)
	end
end

function SeasonMainCampOtherView:_updateOnPetGuardian(cell, index)
	local level = self:_getCampLevel()
	local raceId = self:_getPetGuardByPos(index)
	local config = SeasonMainCampConfig.instance:getPetGuardRecommendConfig(self._mainCampConfig.petGuardPlanId)
	local unlockLv = SeasonMainCampConfig.instance:getPetGuardUnlockLevel(config.gridPlanId, index)
	local lockGo = goutil.findChild(cell, "lock")
	local txtLock = goutil.findChildTextComponent(cell, "lock/txtLock")
	local txtEffect = goutil.findChildTextComponent(cell, "txtEffect")
	local btnAdd = goutil.findChild(cell, "btnAdd")
	local item = goutil.findChild(cell, "item")

	MaterialMgr.resetAll(item)

	local bHasPet = raceId ~= nil and raceId > 0
	local bLock = unlockLv ~= nil and level < unlockLv

	GameUtil.SetActive(btnAdd, false)
	GameUtil.SetActive(lockGo, bLock)
	GameUtil.SetActive(txtEffect, bHasPet)

	if bHasPet then
		local proxy = MaterialMgr.setCellByCfg(MaterialMgr.createSerName(MatType.Pet, raceId, 1), item)

		proxy.binder:setAutoTips(false)
		proxy:setCallBack(function()
			self:_onClickPetGrid(index)
		end)

		local raceIdT = self:_getPetGuardByPos(index)
		local petMo = self:_getMo(raceIdT)

		txtEffect.text = langPara("增益：%s%%", SeasonMainCampModel.instance:getPetGuardUpRate(petMo))
	end

	if bLock then
		txtLock.text = langPara("主营地%s级解锁", unlockLv)
	end
end

function SeasonMainCampOtherView:_findNextUpgradeTips()
	local campLv = self:_getCampLevel()

	for i, v in ipairs(self._levelUpConfigs) do
		if campLv < v.lv and not string.nilorempty(v.upgradeTips) then
			return v.upgradeTips, v.lv
		end
	end

	return nil
end

function SeasonMainCampOtherView:_initLockPopTip()
	local array = {}

	for i, v in ipairs(self._levelUpConfigs) do
		if not string.nilorempty(v.upgradeTips) then
			table.insert(array, string.format("%s、%s", #array + 1, v.upgradeTips))
		end
	end

	self._txtLockPopTip.text = table.concat(array, "\n")
end

function SeasonMainCampOtherView:_onClickLockPopTips()
	GameUtil.SetActive(self._lockPopTip, true)
	GameUtil.SetActive(self._maskCloseGo, true)
end

function SeasonMainCampOtherView:_tipsCustomInputChanged(isHover)
	if isHover == false then
		-- block empty
	end
end

function SeasonMainCampOtherView:_onClickMaskClose()
	GameUtil.SetActive(self._lockPopTip, false)
	GameUtil.SetActive(self._maskCloseGo, false)
end

function SeasonMainCampOtherView:_onClickPetGrid(index)
	UIStateManager.instance:push(ViewName.SeasonPetGuardianView, index)
end

function SeasonMainCampOtherView:_onClickRule()
	UIStateManager.instance:open(ViewName.RulesView, "SeasonMainCampOtherView")
end

function SeasonMainCampOtherView:_getCampLevel()
	return SeasonMainCampModel.instance:getMainCampLevelOfOther()
end

function SeasonMainCampOtherView:_getPetGuardByPos(slotId)
	return SeasonMainCampModel.instance:getPetGuardByPosOfOther(slotId)
end

return SeasonMainCampOtherView
