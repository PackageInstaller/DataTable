-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/threeelimination/view/ThreeEliminationOtherView.lua

module("logic.extensions.threeelimination.view.ThreeEliminationOtherView", package.seeall)

local ThreeEliminationOtherView = class("ThreeEliminationOtherView", ViewComponent)

function ThreeEliminationOtherView:ctor()
	ThreeEliminationOtherView.super.ctor(self)
end

function ThreeEliminationOtherView:bindEvents()
	GameUtil.addClickHandler(self._btnBattle, self._onClickBattle, self)
	GameUtil.addClickHandler(self._btnClose, self._onClickClose, self)
	GameUtil.addClickHandler(self._btnPrize, self._onClickPrize, self)
	GameUtil.addClickHandler(self._btnLevel, self._onClickLevel, self)
	GameUtil.addClickHandler(self._btnBuff, self._onClickBuff, self)
	GameUtil.addClickHandler(self._btnRule, self._onClickRule, self)
end

function ThreeEliminationOtherView:unbindEvents()
	GameUtil.rmClickHandler(self._btnBattle)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnPrize)
	GameUtil.rmClickHandler(self._btnLevel)
	GameUtil.rmClickHandler(self._btnBuff)
	GameUtil.rmClickHandler(self._btnRule)
end

function ThreeEliminationOtherView:buildUI()
	self._petTableView = self:getGo("petTableView")
	self._petTableCell = self:getGo("petTableCell")
	self._petTableContent = self:getGo("petTableView/Nego_Viewport/Nego_Content")
	self._petListEmptyGo = self:getGo("petListEmptyGo")
	self._btnBattle = self:getGo("btnBattle")
	self._txtStep = self:getTxt("txtStep")
	self._txtPower = self:getTxt("txtPower")
	self._txtBattleTime = self:getTxt("btnBattle/txtBattleTime")
	self._txtBattleTimeRecover = self:getTxt("btnBattle/txtRecoverTime")
	self._btnClose = self:getGo("btnClose")
	self._btnRule = self:getGo("btnTip")
	self._goldBarCon = self:getGo("goldBarCon")
	self._txtPlayerLevel = self:getTxt("level/txtPlayerLevel")
	self._btnLevel = self:getGo("level/btnLevel")
	self._redPointLevel = self:getGo("level/btnLevel/redpoint")
	self._headIcon = self:getGo("level/headIcon")
	self._btnPrize = self:getGo("prize")
	self._txtPrize = self:getTxt("prize/txtPrize")
	self._txtPrizeRecover = self:getTxt("prize/txtRecoveTime")
	self._coinCon = self:getGo("prize/txtRecoveTime/coinCon")
	self._imgPrize = self:getGo("prize/imgPrize")
	self._imgPrizeChange = self._imgPrize:GetComponent(ComponentType.UIImageSpriteChange)
	self._btnBuff = self:getGo("buff")
	self._txtBuffName = self:getTxt("buff/txtName")
	self._txtBuffDesc = self:getTxt("buff/txtDesc")
	self._iconBuff = self:getGo("buff/imgIcon")
	self._conBuff = self:getGo("buff/imgIcon/mask/con")
	self._goEmpty = self:getGo("buff/goEmpty")
	self._effectContainer = self:getGo("effectContainer")
	self._flyPetContainer = self:getGo("flyPetContainer")
	self._cellFlyClone = self:getGo("petCell")
end

function ThreeEliminationOtherView:destroyUI()
	return
end

function ThreeEliminationOtherView:onEnter()
	self.addGEvent(self, GlobalNotify.ThreeMathesComboFish, self._onFinishStep, self)
	self.addGEvent(self, GlobalNotify.NextStep, self._onFindScore, self)
	self.addGEvent(self, GlobalNotify.ThreeEliminationContinue, self._onRemoveCell, self)
	self.addGEvent(self, GlobalNotify.PM_ThreeEliminationGameOpenFuncRes, self.refreshView, self)
	self.addGEvent(self, GlobalNotify.PM_ThreeEliminationGameMoveStepRes, self.refreshView, self)
	self.addGEvent(self, GlobalNotify.PM_ThreeEliminationGameLvlUpPlayerRes, self.refreshView, self)
	self.addGEvent(self, GlobalNotify.PM_ThreeEliminationGameSetBuffUsingRes, self.refreshView, self)
	self.addGEvent(self, GlobalNotify.PM_ThreeEliminationGameGainHangUpPrizeRes, self.refreshView, self)
	self.addGEvent(self, GlobalNotify.PM_ThreeEliminationGameGainHangUpPrizeRes, self.refreshView, self)
	self.addGEvent(self, GlobalNotify.ThreeEliminationEffectFly, self._showFlyEffect, self)
	self.addGEvent(self, GlobalNotify.ThreeEliminationPetFly, self._showFlyPet, self)

	self._activityId = self:getFirstParam()
	self._activityCfg = ThreeEliminationConfig.instance:getActivityCfg(self._activityId)
	self._petTableList = ScrollerList.create(self._petTableView, self._petTableCell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._colCount = 0

	for i = 1, self._petTableCell.transform.childCount do
		if goutil.findChild(self._petTableCell, "petCon_" .. i) ~= nil then
			self._colCount = self._colCount + 1
		end
	end

	ThreeEliminationModel.instance:waitMoveRes()
	ThreeEliminationGameAgent.instance:sendPM_ThreeEliminationGameOpenFuncReq(self._activityId)

	local proxy = HeadItemController.instance:setHeadCellByInfo(self._headIcon, RoleModel.instance:getHeadInfo())

	if proxy then
		proxy:setCallBack(function()
			self:onHeadClick(RoleModel.instance:getUserId(), self._headIcon)
		end)
	end

	self:_initGoldBar()
	RedPointController.instance:regRedPoint(self._redPointLevel, RedPointModel.ID_THREEELIMINATION_LEVEL)

	if not ThreeEliminationOtherModel.instance:getIsReadImgRule(self._activityId) then
		self:_onClickRule()
		ThreeEliminationOtherModel.instance:saveIsReadImgRule(self._activityId)
	end

	self._petShowList = nil
end

function ThreeEliminationOtherView:onExit()
	self._petTableList:dispose()
	removetimer(self._onClock, self)
	HeadItemController.instance:resetHeadCell(self._headIcon)
	RedPointController.instance:unregRedPoint(self._redPointLevel)

	if not ViewMgr.instance:isOpen(ViewName.ThreeEliminationMainView) and not ViewMgr.instance:isOpen(ViewName.ThreeEliminationBattleView) then
		-- block empty
	end

	MaterialMgr.resetAll(self._coinCon)

	if self._prizeEffect then
		UIEffectManager.instance:stopEffect(self._prizeEffect)

		self._prizeEffect = nil
	end
end

function ThreeEliminationOtherView:onExitFinished()
	if self._flyCellPools then
		self._flyCellPools:clear()

		self._flyCellPools = nil
	end
end

function ThreeEliminationOtherView:refreshPetList()
	if not self._petShowList then
		self:initPetShowListByMsg()
	end

	self._findIndex = {}

	local showList = {}
	local showLine = {}
	local lineCount = 1

	for i, v in ipairs(self._petShowList) do
		showLine.line = lineCount

		table.insert(showLine, v)

		if #showLine == self._colCount then
			table.insert(showList, showLine)

			showLine = {}
			lineCount = lineCount + 1
		end
	end

	if #showLine > 0 then
		table.insert(showList, showLine)
	end

	self._petTableList:reloadData(showList)
	self._petTableList:MoveCellToCenter(#showList)
	GameUtil.SetActive(self._petListEmptyGo, #showList <= 0)

	local allPet = ThreeEliminationOtherModel.instance:getAllPet()
	local playerLv = ThreeEliminationOtherModel.instance:getPlayerLv()
	local totalPower = 0

	for petType, v in pairs(allPet) do
		local petCfg = ThreeEliminationConfig.instance:getPetCfg(self._activityId, petType)
		local qualityCfg = ThreeEliminationConfig.instance:getQualityCfg(self._activityId, petCfg.quality)

		totalPower = totalPower + (qualityCfg[playerLv].zdl + ThreeEliminationOtherModel.instance:getAddPowerByRaceType(petCfg.raceType)) * v
	end

	self._txtPower.text = langPara("总战力：<color=#FFE44CFF>%d万</color>", totalPower)
end

function ThreeEliminationOtherView:initPetShowListByMsg()
	self._petShowList = {}

	local allPet = ThreeEliminationOtherModel.instance:getAllPet()
	local allPetList = {}
	local playerLv = ThreeEliminationOtherModel.instance:getPlayerLv()
	local totalPower = 0

	for petType, v in pairs(allPet) do
		local petCfg = ThreeEliminationConfig.instance:getPetCfg(self._activityId, petType)
		local qualityCfg = ThreeEliminationConfig.instance:getQualityCfg(self._activityId, petCfg.quality)

		totalPower = totalPower + (qualityCfg[playerLv].zdl + ThreeEliminationOtherModel.instance:getAddPowerByRaceType(petCfg.raceType)) * v

		table.insert(allPetList, {
			type = petType,
			num = v
		})
	end

	table.sort(allPetList, function(a, b)
		local cfgA = ThreeEliminationConfig.instance:getPetCfg(self._activityId, a.type)
		local cfgB = ThreeEliminationConfig.instance:getPetCfg(self._activityId, b.type)

		if cfgA.quality ~= cfgB.quality then
			return cfgA.quality > cfgB.quality
		else
			return cfgA.uniqueId < cfgB.uniqueId
		end
	end)

	for i, v in ipairs(allPetList) do
		for j = 1, v.num do
			table.insert(self._petShowList, v.type)
		end
	end

	self._curShowPetCount = #self._petShowList
end

function ThreeEliminationOtherView:refreshView()
	self:refreshPetList()

	if not ThreeEliminationController.instance:checkMoveStateAndTip() then
		ThreeEliminationModel.instance:waitMoveRes()
	else
		ThreeEliminationModel.instance:getMoveRes()
	end

	self._txtStep.text = ThreeEliminationOtherModel.instance:getAttackValue() > 0 and langPara("剩余移动步数：%d", self._activityCfg.maxStepPerRound - ThreeEliminationOtherModel.instance:getStepCount()) or lang("剩余移动步数：0")
	self._txtBattleTime.text = langPara("剩余次数：<color=#FBE886FF>%d/%d</color>", ThreeEliminationOtherModel.instance:getAttackValue(), self._activityCfg.attackMaxValue)

	local matType, matId, matNum = MaterialMgr.getMatParams(self._activityCfg.hangUpMp)
	local rate = ThreeEliminationOtherModel.instance:getHangUpAddRate()

	self._addHanUpMatNum = matNum * (1 + rate)

	removetimer(self._onClock, self)
	self:_onClock()
	settimer(1, self._onClock, self, true)

	self._txtPlayerLevel.text = langPara("%d级", ThreeEliminationOtherModel.instance:getPlayerLv())

	if ThreeEliminationOtherModel.instance:getBuffUsing() ~= 0 then
		GameUtil.SetActive(self._iconBuff, true)

		local buffCfg = ThreeEliminationConfig.instance:getBuffCfg(self._activityId, ThreeEliminationOtherModel.instance:getBuffUsing())

		uGuiUtil.setSpriteToImage(self._conBuff, nil, buffCfg.buffResName)

		self._txtBuffName.text = buffCfg.name
		self._txtBuffDesc.text = buffCfg.desc

		GameUtil.SetActive(self._goEmpty, false)
	else
		GameUtil.SetActive(self._goEmpty, true)
		GameUtil.SetActive(self._iconBuff, false)
		uGuiUtil.clearImage(self._conBuff)

		self._txtBuffName.text = ""
		self._txtBuffDesc.text = ""
	end

	self._txtPrize.text = ThreeEliminationOtherModel.instance:getHangUpValue() < self._activityCfg.hangUpMaxValue and ThreeEliminationOtherModel.instance:getHangUpValue() or lang("已达上限")

	GameUtil.SetActive(self._txtBattleTimeRecover, self._activityCfg.attackMaxValue > ThreeEliminationOtherModel.instance:getAttackValue())
	GameUtil.SetActive(self._txtPrizeRecover, self._activityCfg.hangUpMaxValue > ThreeEliminationOtherModel.instance:getHangUpValue())

	local prizeEffectName = "fx_ui_shouchong/fx_ui_leichong_shouchong.prefab"

	if ThreeEliminationOtherModel.instance:getHangUpValue() > 0 then
		if not self._prizeEffect then
			self._prizeEffect = UIEffectManager.instance:playEffect(self, prizeEffectName, nil, 0, 0, true)

			self._prizeEffect:setParent(self._imgPrize.transform)
			self._prizeEffect:setScale(1)
			self._prizeEffect:setLocalPos(0, 0, 0)
		end

		self._imgPrizeChange:SetState(1)
	else
		if self._prizeEffect then
			UIEffectManager.instance:stopEffect(self._prizeEffect)

			self._prizeEffect = nil
		end

		self._imgPrizeChange:SetState(0)
	end
end

function ThreeEliminationOtherView:_updateCell(view, cell, data, tag)
	local go = cell.gameObject

	for i = 1, self._colCount do
		local cellGo = goutil.findChild(go, "petCon_" .. i)

		if cellGo then
			local colorChange = cellGo:GetComponent(ComponentType.UIImageSpriteChange)

			if i > #data then
				GameUtil.SetActive(cellGo, false)
			else
				local curIndex = (data.line - 1) * self._colCount + i

				GameUtil.SetActive(cellGo, curIndex <= self._curShowPetCount)

				local con = goutil.findChild(cellGo, "con")
				local cfg = ThreeEliminationConfig.instance:getPetCfg(self._activityId, data[i])

				MaterialMgr.setIcon(con, MatType.Pet, cfg.raceId)
				colorChange:SetState(cfg.quality - 1)
			end
		end
	end
end

function ThreeEliminationOtherView:_clearCell(cell)
	local go = cell.gameObject

	for i = 1, self._colCount do
		local cellGo = goutil.findChild(go, "petCon_" .. i)
		local con = goutil.findChild(cellGo, "con")

		GameUtil.SetActive(cellGo, false)
		MaterialMgr.resetAll(con)
	end
end

function ThreeEliminationOtherView:_initGoldBar()
	local lv1PlayerCfg = ThreeEliminationConfig.instance:getPlayerLevelCfg(self._activityId, 1)
	local barShow = string.split(lv1PlayerCfg.lvlUpCost, "#")
	local btn_list = {}

	for i, v in ipairs(barShow) do
		local matType, matId, num = MaterialMgr.getMatParams(v)

		table.insert(btn_list, {
			showAdd = false,
			id = string.format("%d:%d", matType, matId)
		})
	end

	MainUIController.instance:showGlodBar(self._goldBarCon, self._viewPresentor, btn_list, false)

	local firstType, firstMatId, firstNum = MaterialMgr.getMatParams(barShow[1])

	MaterialMgr.setIcon(self._coinCon, firstType, firstMatId)
end

function ThreeEliminationOtherView:_showFlyEffect(pos, moveTime, type)
	local effName = "20220401/caijingling/fx_ui_jindu_trail_cjl.prefab"
	local effect = UIEffectManager.instance:playEffect(self, effName, nil, 0, 0, true, false, nil, function(handler, eff)
		local trs = eff.effGo:GetComponentsInChildren(typeof(UnityEngine.TrailRenderer))

		for i = 0, trs.Length - 1 do
			trs[i]:Clear()
		end

		local lineGo, maxCell, index = self:_findCellByType(type)

		GameUtil.SetActive(maxCell, false)

		local tween = UnityTweens.TweenPosition.StartTween(eff.effGo, pos, self._petTableView.transform.localPosition + self._petTableContent.transform.localPosition + lineGo.transform.localPosition + maxCell.transform.localPosition, 0.3, UnityTweens.EaseType.linear, moveTime)

		tween:AddListener(function()
			if index > self._curShowPetCount then
				self._curShowPetCount = index

				self:refreshPetList()
			end

			GameUtil.SetActive(maxCell, true)
			UIEffectManager.instance:stopEffect(effect)
			GameUtil.SetActive(eff.effGo, false)
		end)
	end)

	effect:setParent(self._effectContainer.transform)
	effect:setScale(1)
	effect:setLocalPos(pos.x, pos.y)
end

function ThreeEliminationOtherView:_showFlyPet(pos, type)
	local obj = self:genarateFlyPetCell(type, self._cellFlyClone)

	GameUtil.setLocalPos(obj, pos.x, pos.y)

	local lineGo, maxCell, index = self:_findCellByType(type)

	GameUtil.SetActive(maxCell, false)

	local tween = UnityTweens.TweenPosition.StartTween(obj, pos, self._petTableView.transform.localPosition + self._petTableContent.transform.localPosition + lineGo.transform.localPosition + maxCell.transform.localPosition, 0.5, UnityTweens.EaseType.linear, 1)

	tween:AddListener(function()
		if index > self._curShowPetCount then
			self._curShowPetCount = index

			self:refreshPetList()
		end

		GameUtil.SetActive(maxCell, true)
		GameUtil.SetActive(obj, false)
		self._flyCellPools:returnObject(obj)
	end)
end

function ThreeEliminationOtherView:genarateFlyPetCell(type, cellObjClone)
	function resetFunc(obj)
		self:_resetFunc(obj)
	end

	function disposeFunc(obj)
		self:_disposeFunc(obj)
	end

	self._flyCellPools = self._flyCellPools or ObjectPool.New(2, nil, disposeFunc, resetFunc)

	local cellObj

	if self._flyCellPools then
		cellObj = self._flyCellPools:fetchObject()
	end

	if not cellObj then
		cellObj = goutil.clone(cellObjClone)

		if cellObj then
			GameUtil.SetActive(cellObj, true)
			goutil.addChildToParent(cellObj.gameObject, self._flyPetContainer.gameObject.transform)
			self:initFlyPetCell(cellObj, type)
		end
	else
		GameUtil.SetActive(cellObj, true)
		goutil.addChildToParent(cellObj.gameObject, self._flyPetContainer.gameObject.transform)
		self:initFlyPetCell(cellObj, type)
	end

	return cellObj
end

function ThreeEliminationOtherView:initFlyPetCell(go, type)
	local cellCfg = ThreeEliminationConfig.instance:getPetCfg(self._activityId, type)
	local imgIcon = goutil.findChild(go, "imgMask/imgIcon")
	local imgQualityChange = go:GetComponent(ComponentType.UIChangeGroup)

	imgQualityChange:SetState(cellCfg.quality - 1)
	MaterialMgr.setIcon(imgIcon, MatType.Pet, cellCfg.raceId)
end

function ThreeEliminationOtherView:_resetFunc(go)
	goutil.addChildToParent(go.gameObject, self._flyPetContainer.gameObject.transform)

	local canvasGroup = go:GetComponent(ComponentType.CanvasGroup)

	canvasGroup.alpha = 1
end

function ThreeEliminationOtherView:_disposeFunc(go)
	local imgIcon = goutil.findChild(go, "imgMask/imgIcon")

	MaterialMgr.resetAll(imgIcon)
	goutil.destroy(go.gameObject)
end

function ThreeEliminationOtherView:_findCellByType(type)
	local index = #self._petShowList

	for i = #self._petShowList, 1, -1 do
		if self._petShowList[i] == type then
			index = i

			if not self._findIndex[i] then
				self._findIndex[i] = true

				break
			end
		end
	end

	local cell, lineGo

	lineGo = self._petTableList:getView():GetCellAtIndex(math.ceil(index / self._colCount) - 1)

	if not lineGo then
		lineGo = self._petTableList:getView():GetCellByIndex(#self._petTableList:getData() - 1).gameObject
		cell = goutil.findChild(lineGo, "petCon_3")
	else
		lineGo = lineGo.gameObject

		local cellIndex = index % self._colCount

		if cellIndex == 0 then
			cellIndex = self._colCount
		end

		cell = goutil.findChild(lineGo, "petCon_" .. cellIndex)
	end

	return lineGo, cell, index
end

function ThreeEliminationOtherView:_addPetFormIns()
	self._curShowPetCount = #self._petShowList

	local insPet = ThreeEliminationModel.instance:getIncreasePet()
	local insList = {}

	for k, v in pairs(insPet) do
		if v > 0 then
			for i = 1, v do
				table.insert(insList, k)
			end
		end
	end

	table.sort(insList, function(a, b)
		local cfgA = ThreeEliminationConfig.instance:getPetCfg(self._activityId, a)
		local cfgB = ThreeEliminationConfig.instance:getPetCfg(self._activityId, b)

		if cfgA.evolvedId == 0 and cfgB.evolvedId ~= 0 then
			return false
		elseif cfgA.evolvedId ~= 0 and cfgB.evolvedId == 0 then
			return true
		else
			return a < b
		end
	end)

	for i, v in ipairs(insList) do
		table.insert(self._petShowList, v)
	end

	ThreeEliminationOtherModel.instance:addPetFromIncrease()
	self:refreshPetList()
end

function ThreeEliminationOtherView:_onFindScore()
	self._petTableList:regReloadFinish(function()
		ThreeEliminationController.instance:scoreAction()
		self._petTableList:regReloadFinish(nil)
	end)
	self:_addPetFormIns()
end

function ThreeEliminationOtherView:_onRemoveCell()
	self:_addPetFormIns()
	ThreeEliminationController.instance:continueRemove()
end

function ThreeEliminationOtherView:_onFinishStep()
	self._curShowPetCount = #self._petShowList

	if self._activityCfg.maxStepPerRound > ThreeEliminationOtherModel.instance:getStepCount() then
		ThreeEliminationModel.instance:waitMoveRes()
		ThreeEliminationOtherModel.instance:addPetFromIncrease()

		self._curShowPetCount = #self._petShowList

		local petsByStep = ThreeEliminationOtherModel.instance:getTempRemoveByStep()
		local mapArr = ThreeEliminationModel.instance:getGameMapArr()
		local mapSize = ThreeEliminationModel.instance:getGameMapSize()
		local mapList = {}

		for i = 1, mapSize.y do
			mapArr[i] = mapArr[i] or {}

			for j = 1, mapSize.x do
				local index = (i - 1) * mapSize.y + j
				local mo = mapArr[i][j]

				mapList[index] = mo._type
			end
		end

		ThreeEliminationController.instance:sendPM_ThreeEliminationGameMoveOneStepReq(self._activityId, petsByStep, mapList)
	else
		FloatWordMgr.instance:show(lang("步数用完啦，快去出击吧！"))
	end
end

function ThreeEliminationOtherView:_onClock()
	if ThreeEliminationOtherModel.instance:getAttackBalanceTime() > 0 then
		local remainingTime = ThreeEliminationOtherModel.instance:getAttackBalanceTime() / 1000 + self._activityCfg.attckUnitSecd - ServerTime.now()

		if remainingTime > 0 then
			if self._txtBattleTimeRecover then
				local hour, min, sce = GameUtil.getTimeHHMMSS(remainingTime)

				self._txtBattleTimeRecover.text = langPara("<color=#FBE886FF>%02d：%02d：%02d</color>后恢复一次", hour, min, sce)
			end
		else
			ThreeEliminationOtherModel.instance:onAttackBalanceTimeUp(self._activityId)
			self:refreshView()
		end
	end

	if ThreeEliminationOtherModel.instance:getHangUpBalanceTime() > 0 then
		local remainingTime = ThreeEliminationOtherModel.instance:getHangUpBalanceTime() / 1000 + self._activityCfg.hangUpUnitSecd - ServerTime.now()

		if remainingTime > 0 then
			if self._txtPrizeRecover then
				local hour, min, sce = GameUtil.getTimeHHMMSS(remainingTime)

				self._txtPrizeRecover.text = langPara("<color=#E93F3FFF>%02d:%02d</color>后获得%d点", min, sce, self._addHanUpMatNum or 1)
			end
		else
			ThreeEliminationOtherModel.instance:onHangUpBalanceTimeUp(self._activityId)
			self:refreshView()
		end
	end
end

function ThreeEliminationOtherView:_onClickPrize()
	if ThreeEliminationOtherModel.instance:getHangUpValue() > 0 then
		ThreeEliminationGameAgent.instance:sendPM_ThreeEliminationGameGainHangUpPrizeReq(self._activityId)
	else
		FloatWordMgr.instance:show("未有可领取的奖励")
	end
end

function ThreeEliminationOtherView:_onClickLevel()
	if ThreeEliminationController.instance:getCurrStateName() == "ThreeEliminationDefaultState" then
		UIStateManager.instance:push(ViewName.ThreeEliminationLevelView, self._activityId)
	else
		FloatWordMgr.instance:show("正在消除中，请稍后")
	end
end

function ThreeEliminationOtherView:_onClickBuff()
	if ThreeEliminationController.instance:getCurrStateName() == "ThreeEliminationDefaultState" then
		UIStateManager.instance:push(ViewName.ThreeEliminationBufflView, self._activityId)
	else
		FloatWordMgr.instance:show("正在消除中，请稍后")
	end
end

function ThreeEliminationOtherView:_onClickBattle()
	if ThreeEliminationController.instance:getCurrStateName() ~= "ThreeEliminationDefaultState" then
		FloatWordMgr.instance:show("正在消除中，请稍后")

		return
	end

	local stepCount = ThreeEliminationOtherModel.instance:getStepCount()
	local leftStepCount = self._activityCfg.maxStepPerRound - stepCount

	local function func1()
		local allPet = ThreeEliminationOtherModel.instance:getAllPet()
		local hasPet = false

		for i, v in pairs(allPet) do
			if v > 0 then
				hasPet = true

				break
			end
		end

		local stepCount = ThreeEliminationOtherModel.instance:getStepCount()

		if hasPet or leftStepCount <= 0 and hasPet == false then
			self._petShowList = nil

			ThreeEliminationGameAgent.instance:sendPM_ThreeEliminationGameFightReq(self._activityId)
		else
			FloatWordMgr.instance:show(lang("未有出战精灵"))
		end
	end

	if ThreeEliminationOtherModel.instance:getAttackValue() <= 0 then
		FloatWordMgr.instance:show(lang("出战次数不足"))
	elseif leftStepCount > 0 then
		TipsFacade.instance:openPopupWindow(lang("提示"), lang("移动步数未消耗完毕，是否确认出击"), func1)
	else
		func1()
	end
end

function ThreeEliminationOtherView:_onClickClose()
	if ThreeEliminationController.instance:getCurrStateName() == "ThreeEliminationDefaultState" then
		self:close()
	else
		FloatWordMgr.instance:show("正在消除中，请稍后")
	end
end

function ThreeEliminationOtherView:_onClickRule()
	local list = {}

	for i, v in ipairs(ThreeEliminationConfig.instance:getImgRule(self._activityCfg.ruleId)) do
		local pageInfo = {}

		pageInfo.url = v.res
		pageInfo.desc = v.desc

		table.insert(list, pageInfo)
	end

	TipsFacade.instance:openImageRuleView(list, lang("规则说明"))
end

function ThreeEliminationOtherView:onHeadClick(userId, imgIcon)
	return
end

return ThreeEliminationOtherView
