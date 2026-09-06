-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/warriortower/view/WTowerView.lua

module("logic.extensions.warriortower.view.WTowerView", package.seeall)

local WTowerView = class("WTowerView", TableViewComponent)

function WTowerView:_getPath()
	return {
		cellPath = "Middle/Cell",
		viewPath = "Middle/ScrollView"
	}
end

function WTowerView:ctor()
	WTowerView.super.ctor(self)
end

function WTowerView:bindEvents()
	self._closeButton:AddClickListener(self._onClickClose, self)
	self._startButton:AddClickListener(self._onClickStart, self)
	self._btnRank:AddClickListener(self._onClickRank, self)
	self._btnAssignment:AddClickListener(function()
		UIStateManager.instance:push(ViewName.AssignmentView)
	end)
	self._btnFastRevenue:AddClickListener(self._onClickFastRevenue, self)
	self._btnTimeBox:AddClickListener(self._onClickTimeBox, self)
	GameUtil.addClickHandler(self.btnHelp, self._onClickBtnHelp, self)
end

function WTowerView:unbindEvents()
	self._closeButton:RemoveClickListener()
	self._startButton:RemoveClickListener()
	self._btnRank:RemoveClickListener()
	self._btnAssignment:RemoveClickListener()
	self._btnFastRevenue:RemoveClickListener()
	self._btnTimeBox:RemoveClickListener()
	GameUtil.rmClickHandler(self.btnHelp)
end

function WTowerView:buildUI()
	WTowerView.super.buildUI(self)

	self._closeButton = self:getBtn("Close")
	self._startButton = self:getBtn("Bottom/Right/BtnChallenge")
	self._challengeObj = self:getGo("Bottom/Right")
	self._loader = {}
	self._lastCallBack = {}
	self._preLeftTime = 0
	self._btnRank = self:getBtn("Bottom/Left/BtnRank")
	self._btnAssignment = self:getBtn("Bottom/Left/BtnAssignment")
	self._assignmentRed = self:getGo("Bottom/Left/BtnAssignment/red")
	self._btnFastRevenue = self:getBtn("Bottom/Left/BtnFastRevenue")
	self._fastRevenueRed = self:getGo("Bottom/Left/BtnFastRevenue/red")
	self._btnTimeBox = self:getBtn("Bottom/Left/BtnTimeBox")
	self._txtTimeBox = goutil.findChildTextComponent(self.mainGO, "Bottom/Left/BtnTimeBox/Text")
	self._TxtExp = goutil.findChildComponent(self.mainGO, "Bottom/Right/TxtExp", "Text")
	self._scrollrect = self:getGo("Middle/ScrollView"):GetComponent("ScrollRect")
	self._towerUp = self:getGo("Middle/ScrollView/Viewport/Content/up")
	self._towerUp2 = self:getGo("Middle/ScrollView/Viewport/Content/up/up2")
	self._towerDown = self:getGo("Middle/ScrollView/Viewport/Content/down")
	self._towerDown2 = self:getGo("Middle/ScrollView/Viewport/Content/down/down2")
	self._goLockStart = goutil.findChild(self.mainGO, "Bottom/Right/BtnChallenge/img_lock")
	self._txtTitle = goutil.findChildTextComponent(self.mainGO, "txtTitle")
	self._bg = self:getGo("Nego_Bg")
	self._switchEffGo = self:getGo("effect")
	self.btnHelp = self:getGo("btnHelp")
end

function WTowerView:_onClickBtnHelp()
	UIStateManager.instance:push(ViewName.RulesView, "warriormaintower")
end

function WTowerView:_itemCellSize()
	return 75, 100
end

function WTowerView:_updateItemCell(view, cell, data)
	self._itemProxy[cell] = MaterialMgr.setCellByCfg(data, goutil.findChild(cell.gameObject, "Bg/Icon"))
end

function WTowerView:_clearItemCell(cell)
	MaterialMgr.resetAll(goutil.findChild(cell.gameObject, "Bg/Icon"))
end

function WTowerView:destroyUI()
	WTowerView.super.destroyUI(self)
end

function WTowerView:onEnter()
	WTowerView.super.onEnter(self)

	local towerId = WTowerModel.instance:getTowerId()

	if WTowerModel.instance:getCurLevel(towerId) > 1 or towerId > 1 then
		WarriorTowerAgent.instance:sendGetWarriorTowerProfitInfoReq(function(msg)
			WTowerModel.instance:setTimeBoxInfo(msg.nextBalanceMillis, msg.turnHasBuyTotalTimes, msg.turnLeftBuyFreeTimes)
			goutil.setActive(self._fastRevenueRed, msg.turnLeftBuyFreeTimes > 0)

			self._agentFlag = true
		end)
		goutil.setActive(self._btnFastRevenue.gameObject, true)
		goutil.setActive(self._btnTimeBox.gameObject, true)
	else
		goutil.setActive(self._btnFastRevenue.gameObject, false)
		goutil.setActive(self._btnTimeBox.gameObject, false)
	end

	self._curViewDatas = {}
	self._extremum = 0
	self._preSweepLevel = 0
	self._cellHeight = self._tableview.gridHeight
	self.scList = {}
	self._itemProxy = {}
	self._changeSetId = nil

	local fromFmt = WTowerModel.instance:getTowerFromFmt(towerId)

	if towerId ~= WTowerModel.TowerType.Warrior then
		WTowerController.instance:sendGetFormation(towerId)
	else
		WTowerModel.instance:setTowerFromFmt(towerId, false)
	end

	uGuiUtil.setSpriteToImage(self._bg, uGuiUtil.SpriteType.BigBg, WTowerModel.TowerBg[towerId])
	uGuiUtil.setSpriteToImage(self._tableCell, uGuiUtil.SpriteType.BigBg, WTowerModel.TowerCellBg[towerId], self._refreshAll, self)

	self._maxTimeBoxTime = tonumber(WTowerConfig.instance:getParaCfg("profitTimeUnit")) * tonumber(WTowerConfig.instance:getParaCfg("profitMaxTimes"))

	GlobalDispatcher:addListener(WTowerModel.FAST_REVENUE_RED, self._updateFastRevenueRed, self)
	settimer(1, self._timeBox, self, true)
	RedPointController.instance:regRedPoint(self._assignmentRed, RedPointModel.ID_PETDISPATCH)
	GlobalDispatcher:addListener(WTowerModel.ReceiveAuto, self._autoChallenge, self)
end

function WTowerView:onEnterFinished()
	local towerId = WTowerModel.instance:getTowerId()

	uGuiUtil.setSpriteToImage(self._towerUp, uGuiUtil.SpriteType.BigBg, WTowerModel.TowerCellBg[towerId])
	uGuiUtil.setSpriteToImage(self._towerUp2, uGuiUtil.SpriteType.BigBg, WTowerModel.TowerCellBg[towerId])
	uGuiUtil.setSpriteToImage(self._towerDown, uGuiUtil.SpriteType.BigBg, WTowerModel.TowerCellBg[towerId])
	uGuiUtil.setSpriteToImage(self._towerDown2, uGuiUtil.SpriteType.BigBg, WTowerModel.TowerCellBg[towerId])
end

function WTowerView:onExit()
	WTowerView.super.onExit(self)
	self._tableview:Travel(self._clearTableview, self)
	self._tableview:Clear()

	self._curViewDatas = nil

	UIEffectManager.instance:stopEffect(self._timeBoxeff)

	self._timeBoxeff = nil

	if self.handle then
		UpdateBeat:RemoveListener(self.handle)
	end

	self.scList = nil

	GlobalDispatcher:removeListener(WTowerModel.FAST_REVENUE_RED, self._updateFastRevenueRed, self)
	GlobalDispatcher:removeListener(WTowerModel.ReceiveAuto, self._autoChallenge, self)
	removetimer(self._timeBox, self)
	RedPointController.instance:unregRedPoint(self._assignmentRed)
	uGuiUtil.clearImage(self._bg)
	uGuiUtil.clearImage(self._towerUp)
	uGuiUtil.clearImage(self._towerUp2)
	uGuiUtil.clearImage(self._towerDown)
	uGuiUtil.clearImage(self._towerDown2)

	if self._switchEffect then
		UIEffectManager.instance:stopEffect(self._switchEffect)

		if self._changeSetId then
			MaterialFacade.instance:popAndShowChangeSetItems(self._changeSetId)
		end

		self._switchEffect = nil
	end
end

function WTowerView:onExitFinished()
	return
end

function WTowerView:_refreshLevelInfos(towerId)
	local curLvl = WTowerModel.instance:getCurLevel(towerId)
	local infos = WTowerModel.instance:getLevelInfos(towerId)
	local maxLvl = WTowerConfig.instance:getCfgCount(towerId)

	self._curViewDatas = {}

	for i = curLvl - 2, curLvl + 2 do
		if i > 0 and i <= maxLvl then
			table.insert(self._curViewDatas, infos[i])
		end
	end

	self._tableview:ReloadData()

	local levelCfg = WTowerConfig.instance:getCfgById(curLvl, towerId)

	self._itemViewDatas = levelCfg and string.split(levelCfg.prize, "#") or {}
	self._TxtExp.text = levelCfg and tostring(levelCfg.fightWinExp) or ""

	self._challengeObj:SetActive(not WTowerModel.instance:passedAllLevel(towerId))
end

function WTowerView:_refreshAll()
	local towerId = WTowerModel.instance:getTowerId()
	local infos = WTowerModel.instance:getLevelInfos(towerId)

	if infos then
		self:_refreshLevelInfos(towerId)
	else
		WTowerController.instance:getWarriorInfo(function()
			self:_refreshLevelInfos(towerId)
		end)
	end

	self._goLockStart:SetActive(WTowerModel.instance:isCurMofangLock())

	self._txtTitle.text = WTowerModel.TowerTitle[WTowerModel.instance:getTowerId()]
end

function WTowerView:_timeBox()
	if WTowerModel.instance:getBoxGainTime() then
		local boxGaintime = WTowerModel.instance:getBoxGainTime() - ServerTime.now()

		self._boxTime = math.min(ServerTime.now() - WTowerModel.instance:getBoxGainTime() + 300, self._maxTimeBoxTime)
		self._txtTimeBox.text = TimeUtil:timeConvert2(self._boxTime, nil, true)

		if boxGaintime < 0 then
			if self._timeBoxeff then
				return
			end

			self._timeBoxeff = UIEffectManager.instance:playEffect(self, "fx_ui_fuli/fx_ui_fuli_lingqu.prefab", self._btnTimeBox.gameObject, 0, 0, true, nil, function(finishHandlerTarget, eff)
				eff:setParent(self._btnTimeBox.transform)
			end, nil)

			self._timeBoxeff:setParent(self._btnTimeBox.gameObject.transform)
			self._timeBoxeff:setScale(1)

			self._timeBoxeff.hideEffWhileNotOnTop = false
		end
	else
		self._txtTimeBox.text = "loading..."
	end
end

function WTowerView:_cellSize()
	return 826, 300
end

function WTowerView:_updateCell(view, cell, data)
	local towerId = WTowerModel.instance:getTowerId()
	local curStage = WTowerModel.instance:getCurLevel(towerId)
	local cfg = WTowerConfig.instance:getCfgById(data._id, towerId)
	local imgBgRect = goutil.findChildComponent(cell, "ImgBg", "RectTransform")
	local powerTxt = goutil.findChild(cell, "PowerBg/TxtPower"):GetComponent("ImgNumber")
	local levelTxt = goutil.findChild(cell, "LevelBg/TxtLevel"):GetComponent("Text")

	imgBgRect.anchoredPosition = Vector2.New(-270 * (data._id % 2 * 2 - 1), imgBgRect.anchoredPosition.y)
	levelTxt.text = langPara("tip_missionnum", data._id)

	if data._state == 4 then
		goutil.setActive(goutil.findChild(cell, "PowerBg"), true)

		if data._power ~= 0 then
			powerTxt:SetNum(data._power)
		else
			local levelCfg = WTowerConfig.instance:getCfgById(curStage, towerId)
			local cCfg = WTowerConfig.instance:getCrpCfg(levelCfg.creepsMasterId)
			local heroSkillId = checknumber(levelCfg.heroSkillId)

			powerTxt:SetNum(FightingPowerFormula.instance:getFightingPowerOfFmt(cCfg, heroSkillId))
		end
	else
		goutil.setActive(goutil.findChild(cell, "PowerBg"), false)
	end

	local itemViewGo = goutil.findChild(cell, "itemtableview")
	local dragTrigger = Framework.UIDragTrigger.Get(itemViewGo)

	dragTrigger:AddDragListener(self._onDrag, self)
	dragTrigger:AddBeginDragListener(self._onBeginDrag, self)
	dragTrigger:AddEndDragListener(self._onEndDrag, self)

	self.scList[cell] = self.scList[cell] or ScrollerList.create(itemViewGo, goutil.findChild(cell, "itemCell"), GameUtil.handler(self._updateItemCell, self), GameUtil.handler(self._clearItemCell, self))

	local sc = self.scList[cell]

	sc:reloadData(cfg and string.split(cfg.prize, "#") or {})

	local stateObjs = {}

	for i = 1, 5 do
		stateObjs[i] = goutil.findChild(cell, "ImgBg/ImgPetBase/States/S" .. i)

		stateObjs[i]:SetActive(data._state == i)
	end

	self:_updateModels(cell, data)
end

function WTowerView:_updateModels(cell, data)
	local petBase = goutil.findChild(cell, "ImgBg/ImgPetBase/States/PetBase")

	Framework.TransformUtil.SetLocalScale(petBase:GetComponent("RectTransform"), data._id % 2 * 2 - 1, 1, 1)

	local towerId = WTowerModel.instance:getTowerId()
	local curStage = WTowerModel.instance:getCurLevel(towerId)

	if math.abs(data._id - curStage) < 3 then
		petBase:SetActive(true)

		local offset = CharactorFacade.instance:getTowerModelUIPosAndScale(data._faceId)
		local x, y, scale = 0, 0, 1

		if offset then
			x = checknumber(offset[1])
			y = checknumber(offset[2])
			scale = offset[3] or 1
		end

		scale = scale * 0.3
		self._loader[cell] = RoleObjectPool.instance:addRoleToParent(self._loader[cell], data._faceId, petBase, scale, nil, false, x, y)
	else
		petBase:SetActive(false)
	end
end

function WTowerView:_clearTableview(cell)
	self._loader[cell] = RoleObjectPool.instance:removeRole(self._loader[cell])

	if self.scList[cell] then
		self.scList[cell]:dispose()
	end

	local itemViewGo = goutil.findChild(cell, "itemtableview")
	local dragTrigger = Framework.UIDragTrigger.Get(itemViewGo)

	dragTrigger:RemoveDragListener()
	dragTrigger:RemoveBeginDragListener()
	dragTrigger:RemoveEndDragListener()
end

function WTowerView:_updateFastRevenueRed()
	local _, freeTimes = WTowerModel.instance:getTimeBoxTimes()

	goutil.setActive(self._fastRevenueRed, freeTimes > 0)
end

function WTowerView:_effStatus(flag)
	if self._timeBoxeff then
		goutil.setActive(self._timeBoxeff.effGo, flag)
	end

	for k, proxy in ipairs(self._itemProxy) do
		proxy.binder:setEffStatus(flag)
	end

	WTowerController.instance:localNotify(WTowerModel.ReceiveEff, flag)
end

function WTowerView:_onReloadFinish()
	WTowerView.super._onReloadFinish(self)

	if #self._curViewDatas > 0 then
		local towerId = WTowerModel.instance:getTowerId()
		local curLvl = WTowerModel.instance:getCurLevel(towerId)
		local infos = WTowerModel.instance:getLevelInfos(towerId)
		local info = infos[curLvl]
		local idx = table.indexof(self._curViewDatas, info)

		if idx ~= false then
			self._tableview:ForceMoveCellToCenter(idx - 1)
		end

		local anchor = GameUtil.getAnchoredPos(self._tableview:GetCellAtIndex(1))

		self._extremum = (#self._curViewDatas - 1 + (#self._curViewDatas + 1) % 2 * 0.5) * self._cellHeight

		GameUtil.setAnchoredPos(self._towerUp, anchor.x, self._extremum)
		GameUtil.setAnchoredPos(self._towerDown, anchor.x, self._extremum * -1)
		goutil.setActive(goutil.findChild(self._towerUp, "tip"), self._curViewDatas[#self._curViewDatas]._id == WTowerConfig.instance:getCfgCount(towerId))
	end
end

function WTowerView:_onClickClose()
	self._tableview:Travel(self._clearTableview, self)
	self._tableview:Clear()
	self:close()
end

function WTowerView:_onClickStart()
	local towerId = WTowerModel.instance:getTowerId()
	local curStage = WTowerModel.instance:getCurLevel(towerId)
	local cfg = WTowerConfig.instance:getCfgById(curStage, towerId)
	local curZdl = WTowerController.instance:getFmtZdl(towerId)
	local fmtMo = towerId ~= WTowerModel.TowerType.Warrior and WTowerModel.instance:getCurFormation() or PetHireModel.instance:getFormationMoByFormId(PetHireModel.ID_TYPE_NORMAL)
	local isCheckOldSummon = false

	if checknumber(fmtMo.summonMasterPetId) <= 0 and checknumber(fmtMo.summonedPetId) <= 0 then
		local nums = fmtMo:getCurExistPetNumber(true)

		if nums > 5 then
			isCheckOldSummon = true
		end
	end

	local function enterMission()
		UIStateManager.instance:push(ViewName.Wtmission, curStage)
		WTowerController.instance:setStart(true)
	end

	if curZdl > checknumber(cfg.checkZdl) and not isCheckOldSummon then
		local maxLevel = WTowerConfig.instance:getCfgCount(towerId)
		local i = curStage

		while i < maxLevel do
			local tempCfg = WTowerConfig.instance:getCfgById(i, towerId)

			if curZdl >= checknumber(tempCfg.checkZdl) then
				i = i + 1
			else
				break
			end
		end

		SurveyController.instance:reportBehavior(200433)

		local levelStr = curStage == i - 1 and curStage or curStage .. "-" .. i - 1
		local str = langPara("您的实力非常强大\n眼前这些弱小的存在简直不堪一击！\n\n您将直接提升至<color=#EB4642FF>%s关</color>\n并获得<color=#EB4642FF>%s关</color>的全部首通奖励", i, levelStr)

		TipsFacade.instance:openPopupWindow("提示", str, function()
			WarriorTowerAgent.instance:sendWarriorTowerAutoFightReq(towerId)
		end, function()
			enterMission()
		end, nil, nil, UnityEngine.TextAnchor.MiddleCenter)
	else
		enterMission()
	end
end

function WTowerView:_onClickRank()
	UIStateManager.instance:push(ViewName.Rank, GameEnum.RankType.WTower, 1)
end

function WTowerView:_onClickFastRevenue()
	if not self._agentFlag then
		return
	end

	self:_effStatus(false)
	UIStateManager.instance:push(ViewName.WTowerFastRevenueView, function()
		self:_effStatus(true)
	end)
end

function WTowerView:_onClickTimeBox()
	if self._timeBoxeff then
		WarriorTowerAgent.instance:sendGainWarriorTowerProfitPrizeReq(function(msg)
			WTowerModel.instance:setBoxGainTime(msg.nextBalanceMillis)
			UIEffectManager.instance:stopEffect(self._timeBoxeff)

			self._timeBoxeff = nil
		end)
	else
		self:_effStatus(false)
		UIStateManager.instance:push(ViewName.WtowerTimeboxTipView, function()
			self:_effStatus(true)
		end)
	end
end

function WTowerView:_onDrag(eventData)
	if self._scrollrect then
		self._scrollrect:OnDrag(eventData)
	end
end

function WTowerView:_onBeginDrag(eventData)
	if self._scrollrect then
		self._scrollrect:OnBeginDrag(eventData)
	end
end

function WTowerView:_onEndDrag(eventData)
	if self._scrollrect then
		self._scrollrect:OnEndDrag(eventData)
	end
end

function WTowerView:_autoChallenge(changeSetId)
	self._changeSetId = changeSetId

	self:_refreshAll()

	if self._switchEffect then
		UIEffectManager.instance:stopEffect(self._switchEffect)

		self._switchEffect = nil
	end

	local effectPath = "fx_ui_mangtiaozhan/fx_ui_mangtiaozhan_05_blue.prefab"

	self._switchEffect = UIEffectManager.instance:playEffect(self, effectPath, self._switchEffGo.transform, 0, 0, false, false, function()
		self:_autoEffectEnd()
	end, function(self, uiEffect)
		uiEffect.hideEffWhileNotOnTop = true
	end, self)

	self._switchEffect:setParent(self._switchEffGo.transform)
	self._switchEffect:setLocalPos(0, 0, 0)
	self._switchEffect:setScale(1)
end

function WTowerView:_autoEffectEnd()
	if self._changeSetId then
		MaterialFacade.instance:popAndShowChangeSetItems(self._changeSetId)

		self._changeSetId = nil
	end
end

return WTowerView
