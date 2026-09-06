-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/lingshenconvene/view/LingShenConveneMainView.lua

module("logic.extensions.lingshenconvene.view.LingShenConveneMainView", package.seeall)

local LingShenConveneMainView = class("LingShenConveneMainView", ViewComponent)

function LingShenConveneMainView:ctor()
	LingShenConveneMainView.super.ctor(self)
end

function LingShenConveneMainView:buildUI()
	LingShenConveneMainView.super.buildUI(self)

	self._btnClose = self:getBtn("topleft/btnClose")
	self._btnTip = self:getBtn("topleft/btnTip")
	self._btnLeft = self:getGo("btnLeft")
	self._redpointLeft = self:getGo("btnLeft/redpoint")
	self._btnRight = self:getGo("btnRight")
	self._redpointRight = self:getGo("btnRight/redpoint")
	self._txtCollectingNum = self:getTxt("collectingNum/txtNum")
	self._progressBar = self:getSlider("progress/tableview/Viewport/Content/progressBar")

	local cellProgress = self:getGo("progress/cell")
	local tabProgress = self:getGo("progress/tableview")

	self._tableviewProgress = ScrollerList.create(tabProgress, cellProgress, GameUtil.handler(self._updateProgressCell, self), GameUtil.handler(self._clearProgressCell, self))
	self._btnReveal = self:getGo("btnReveal")
	self._redpointReveal = self:getGo("btnReveal/redpoint")
	self._btnGame = self:getGo("btnGame")
	self._redpointGame = self:getGo("btnGame/redpoint")
	self._iconListGo = self:getGo("iconList")
	self._iconCell = self:getGo("iconList/iconCell")

	goutil.setActive(self._iconCell, false)

	self._goldBar = self:getGo("goldBar")
	self._shadow = self:getGo("shadow")
	self._txtGameTime = self:getTxt("gameTime/txt")
	self._effPos = self:getGo("effPos")
end

function LingShenConveneMainView:bindEvents()
	LingShenConveneMainView.super.bindEvents(self)
	self._btnClose:AddClickListener(self.close, self)
	self._btnTip:AddClickListener(self._onClickTip, self)
	GameUtil.addClickHandler(self._btnLeft, GameUtil.handler(self._onClickSwitch, self, true))
	GameUtil.addClickHandler(self._btnRight, GameUtil.handler(self._onClickSwitch, self, false))
	GameUtil.addClickHandler(self._btnReveal, self._onClickReveal, self)
	GameUtil.addClickHandler(self._btnGame, self._onClickGame, self)
end

function LingShenConveneMainView:unbindEvents()
	LingShenConveneMainView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
	self._btnTip:RemoveClickListener()
	GameUtil.rmClickHandler(self._btnLeft)
	GameUtil.rmClickHandler(self._btnRight)
	GameUtil.rmClickHandler(self._btnReveal)
	GameUtil.rmClickHandler(self._btnGame)
end

function LingShenConveneMainView:onEnter()
	LingShenConveneMainView.super.onEnter(self)

	local params = self:getOpenParam()

	self._activityId = checknumber(params[1])

	if not ActivityDefineController.instance:isInActivityTimeById(GameEnum.ActivityType.LingShenConvene, self._activityId) then
		local text = string.format("活动不在开启期限内( activityId = %d )", self._activityId)

		local function func()
			self:close()
		end

		TipsFacade.instance:openTipWindow("提示", text, func, "确定", UnityEngine.TextAnchor.MiddleCenter)

		return
	end

	self._curTabId = nil

	self:_updateUIByCfg()
	self.addGEvent(self, GlobalNotify.LingShenConveneGetInfoRes, self._updateUIByInfo, self)
	self.addGEvent(self, GlobalNotify.LingShenConveneUnlockRes, self._updateUnlockState, self)
	self.addGEvent(self, GlobalNotify.LingShenConveneeGainProgressPrizeRes, self._updateProgress, self)
	self.addGEvent(self, GlobalNotify.LingShenConveneeGainPrizeRes, self._updateRevealRd, self)
	self.addGEvent(self, GlobalNotify.DuoLaMMGameGetInfoRes, self._updateGameTime, self)
	LingShenConveneController.instance:sendPM_LingShenConveneGetInfoReq(self._activityId)

	if ActivityDefineController.instance:isInActivityTimeById(GameEnum.ActivityType.DuoLaMMGame, self._actCfg.gameActId) then
		DuoLaMMGameController.instance:sendPM_DuoLaMMGameGetInfoReq(self._actCfg.gameActId)
	end
end

function LingShenConveneMainView:onExit()
	LingShenConveneMainView.super.onExit(self)
	self._tableviewProgress:dispose()

	if self._fanshuEff then
		UIEffectManager.instance:stopEffect(self._fanshuEff)

		self._fanshuEff = nil
	end

	self:_clearIconList()
end

function LingShenConveneMainView:_updateUIByCfg()
	self._actCfg = LingShenConveneConfig.instance:getActCfg(self._activityId)
	self._tabCfgs = LingShenConveneConfig.instance:getTabCfgs(self._activityId)
	self._progressCfgs = LingShenConveneConfig.instance:getProgressCfgs(self._activityId)
	self._revealCfgs = LingShenConveneConfig.instance:getRevealCfgs(self._activityId)
	self._showTabDataList = {}

	for _, tabCfg in ipairs(self._tabCfgs) do
		local tabData = {}
		local unlockDataList = {}
		local iconCfgs = LingShenConveneConfig.instance:getUnlockPetCfgs(tabCfg.iconPlanId)

		for iconId, iconCfg in ipairs(iconCfgs) do
			local unlockData = {}

			unlockData.cfg = iconCfg
			unlockData.matchCost = false
			unlockData.matchTime = false
			unlockData.isUnlock = false

			table.insert(unlockDataList, unlockData)
		end

		table.sort(unlockDataList, function(a, b)
			return a.cfg.sortId < b.cfg.sortId
		end)

		tabData.unlockDataList = unlockDataList
		tabData.isShowRd = false

		table.insert(self._showTabDataList, tabData)
	end

	self:_switchTab(1)

	local showMat = self._actCfg.showCostCoin
	local list = {
		{
			showAdd = false,
			id = showMat
		}
	}

	MainUIController.instance:showGlodBar(self._goldBar, self._viewPresentor, list)
end

function LingShenConveneMainView:_updateUIByInfo()
	self:_updateUnlockState()
end

function LingShenConveneMainView:_updateUnlockState()
	local timeNow = ServerTime.now()

	for tabId, tabData in ipairs(self._showTabDataList) do
		tabData.isShowRd = false

		for iconId, unlockData in ipairs(tabData.unlockDataList) do
			unlockData.isUnlock = LingShenConveneModel.instance:getIsHasUnlockIcon(self._activityId, tabId, unlockData.cfg.iconId)
			unlockData.matchTime = timeNow >= GameUtil.string2time(unlockData.cfg.startUnlockTime)
			unlockData.matchCost = MaterialMgr.getMatEnough(unlockData.cfg.unlockCost)

			if unlockData.matchCost and unlockData.matchTime and not unlockData.isUnlock then
				tabData.isShowRd = true
			end
		end
	end

	for tabId, tabData in ipairs(self._showTabDataList) do
		if tabId < self._curTabId then
			goutil.setActive(self._redpointLeft, tabData.isShowRd)
		elseif tabId > self._curTabId then
			goutil.setActive(self._redpointRight, tabData.isShowRd)
		end
	end

	local curTabData = self._showTabDataList[self._curTabId]

	if curTabData then
		if not curTabData.unlockDataList then
			local dataList = {}

			for i, data in ipairs(dataList) do
				self:_refreshState(self:_getIconCell(i))
			end

			self:_updateProgress()
		end
	end
end

function LingShenConveneMainView:_updateProgress()
	self._curProgress = LingShenConveneModel.instance:getUnlockProgress(self._activityId)
	self._txtCollectingNum.text = self._curProgress

	self._tableviewProgress:reloadData(self._progressCfgs)

	local scoreList = {}

	for i, v in ipairs(self._progressCfgs) do
		table.insert(scoreList, v.unlockCount)
	end

	self._tableviewProgress:updateUnderSlider(self._progressBar, self._curProgress, scoreList)
	self._tableviewProgress:reloadData(self._progressCfgs)
	self:_updateRevealRd()
end

function LingShenConveneMainView:_updateRevealRd()
	local showRd = false

	for _, cfg in ipairs(self._revealCfgs) do
		if not LingShenConveneModel.instance:getIsHasGainRevealPrize(self._activityId, cfg.prizeId) and self._curProgress >= cfg.unlockCount then
			showRd = true

			break
		end
	end

	goutil.setActive(self._redpointReveal, showRd)
end

function LingShenConveneMainView:_updateGameTime()
	local actId = self._actCfg.gameActId
	local playTimes = DuoLaMMGameModel.instance:getGameTimes(actId)
	local actCfg = DuoLaMMGameConfig.instance:getActCfg(actId)
	local totalTimes = actCfg.dailyFreeGameTimes

	self._txtGameTime.text = string.format("今日剩余次数：%s/%s", totalTimes - playTimes, totalTimes)
end

function LingShenConveneMainView:_updateProgressCell(view, cellGo, data)
	local cell = self:_clearProgressCell(cellGo)

	cell.txtNum.text = data.unlockCount

	MaterialMgr.setCellByCfg(data.prize, cell.item)

	local isGain = LingShenConveneModel.instance:getIsHasGainProgressPrize(self._activityId, data.prizeId)
	local isMatchGain = not isGain and self._curProgress >= data.unlockCount

	goutil.setActive(cell.btnGet, isMatchGain)

	if isMatchGain then
		self:_playCellEffect(cell.effect)
		GameUtil.addClickHandler(cell.btnGet, GameUtil.handler(self._onClickGainPrize, self, data.prizeId))
	end

	goutil.setActive(cell.geted, isGain)
end

function LingShenConveneMainView:_clearProgressCell(cellGo)
	local cell = {}

	cell.go = cellGo
	cell.item = goutil.findChild(cell.go, "item")

	MaterialMgr.resetAll(cell.item)

	cell.txtNum = goutil.findChildTextComponent(cell.go, "txtNum")
	cell.btnGet = goutil.findChild(cell.go, "btnGet")
	cell.effect = goutil.findChild(cell.go, "effect")
	cell.geted = goutil.findChild(cell.go, "geted")

	GameUtil.rmClickHandler(cell.btnGet)
	self:_clearCellEffect(cell.effect)

	return cell
end

function LingShenConveneMainView:_playCellEffect(effGo)
	self:_clearCellEffect(effGo)

	local effPath = "fx_ui_juqingfuben/fx_ui_juqingfuben02.prefab"
	local uiEffect = UIEffectManager.instance:playEffect(self, effPath, effGo.transform, 0, 0, true, false, nil, function(target, eff)
		eff:setClipping(self:getGo("progress/tableview/Viewport").transform)
	end)

	uiEffect:setParent(effGo.transform)
	uiEffect:setLocalPos(0, 0, 0)
	uiEffect:setScaleXYZ(0.96, 1, 0.87)

	self._cellEffects = self._cellEffects or {}
	self._cellEffects[effGo] = uiEffect
end

function LingShenConveneMainView:_clearCellEffect(effGo)
	if self._cellEffects and self._cellEffects[effGo] then
		UIEffectManager.instance:stopEffect(self._cellEffects[effGo])

		self._cellEffects[effGo] = nil
	end
end

function LingShenConveneMainView:_onClickTip()
	local key = self._actCfg.ruleKey

	TipsFacade.instance:openRulesView(key)
end

function LingShenConveneMainView:_onClickReveal()
	UIStateManager.instance:push(ViewName.LingShenConveneRevealView, self._activityId, 1)
end

function LingShenConveneMainView:_onClickGame()
	DuoLaMMGameController.instance:startGame(self._actCfg.gameActId)
end

function LingShenConveneMainView:_onClickGainPrize(prizeId)
	LingShenConveneController.instance:sendPM_LingShenConveneGainProgressPrizeReq(self._activityId, prizeId)
end

function LingShenConveneMainView:_onClickDetail(cell)
	if cell then
		local info = cell.info

		if info then
			UIStateManager.instance:push(ViewName.LingShenConveneDetailView, info.cfg.detailId)
		else
			self:_clearIconCell(cell)
		end
	end
end

function LingShenConveneMainView:_onClickUnlock(cell)
	if cell then
		local info = cell.info

		if info then
			if info.isUnlock then
				return
			end

			if not info.matchTime then
				local openDate = GameUtil.string2date(info.cfg.startUnlockTime)
				local showTips = langPara("%d.%02d.%02d后开启", openDate.year, openDate.month, openDate.day)

				FloatWordMgr.instance:show(showTips)

				return
			end

			if not info.matchCost then
				local costType, costId, costNum = MaterialMgr.getMatParams(info.cfg.unlockCost)
				local showTips = langPara("%s不足", MaterialMgr.getMaterialsName(costType, costId))

				FloatWordMgr.instance:show(showTips)

				return
			end

			LingShenConveneController.instance:sendPM_LingShenConveneUnlockReq(self._activityId, self._curTabId, info.cfg.iconId)
		else
			self:_clearIconCell(cell)
		end
	end
end

function LingShenConveneMainView:_onClickSwitch(isLeft)
	if isLeft then
		if not (self._curTabId - 1) then
			local newTabId = self._curTabId + 1
			local tabNum = #self._tabCfgs

			if newTabId < 1 then
				newTabId = tabNum
			elseif tabNum < newTabId then
				newTabId = 1
			end

			self:_switchTab(newTabId)
			self:_playEff(isLeft)
		end
	end
end

function LingShenConveneMainView:_switchTab(tabId, isLeft)
	if self._curTabId ~= tabId then
		self._curTabId = tabId

		goutil.setActive(self._btnLeft, self._curTabId > 1)
		goutil.setActive(self._btnRight, self._curTabId < #self._tabCfgs)
		goutil.setActive(self._shadow, self._curTabId == 2)
		self:_clearIconList()

		local curTabData = self._showTabDataList[self._curTabId]

		if curTabData then
			if not curTabData.unlockDataList then
				local dataList = {}

				for i, data in ipairs(dataList) do
					self:_updateIcon(self:_getIconCell(i), data)
				end
			end
		end
	end
end

function LingShenConveneMainView:_getIconCell(iconId)
	local cell = self._iconList[iconId]

	if not cell then
		cell = {}

		local goName = "icon_" .. iconId
		local goCell = goutil.findChild(self._iconListGo, goName)

		cell.go = goCell or goutil.cloneAndSetParent(self._iconCell, self._iconListGo.transform, goName)
		cell.info = nil
		cell.btnDetail = goutil.findChild(cell.go, "btnDetail")
		cell.role = goutil.findChild(cell.go, "role")
		cell.btnUnlock = goutil.findChild(cell.go, "btnUnlock")
		cell.lock = goutil.findChild(cell.go, "lock")
		cell.time = goutil.findChild(cell.lock, "time")
		cell.txtTime = goutil.findChildTextComponent(cell.time, "txt")
		cell.cost = goutil.findChild(cell.lock, "cost")
		cell.txtCost = goutil.findChildTextComponent(cell.cost, "txt")
		cell.iconCost = goutil.findChild(cell.cost, "txt/icon")
		self._iconList[iconId] = cell
	end

	return cell
end

function LingShenConveneMainView:_updateIcon(cell, data)
	if cell and data then
		cell.info = data

		if not data.cfg.pos then
			local goPos = {}
			local var_29_1

			if goPos then
				var_29_1 = goPos[1] or 0

				local var_29_2

				if goPos then
					var_29_2 = goPos[2] or 0
				end
			end

			GameUtil.setAnchoredPos(cell.go, var_29_1, var_29_2)

			if not data.cfg.lihuiPos then
				local lihuiPos = {}
				local var_29_4

				if lihuiPos then
					var_29_4 = lihuiPos[1] or 0

					local var_29_5

					if lihuiPos then
						var_29_5 = lihuiPos[2] or 0
					end
				end

				GameUtil.setAnchoredPos(cell.role, var_29_4, var_29_5)

				local lihuiScale = data.cfg.lihuiScale

				GameUtil.setLocalScale(cell.role, lihuiScale, lihuiScale, lihuiScale)
				GameUtil.addClickHandler(cell.btnDetail, GameUtil.handler(self._onClickDetail, self, cell))
				GameUtil.addClickHandler(cell.btnUnlock, GameUtil.handler(self._onClickUnlock, self, cell))

				if not GameUtil.isEmptyString(data.cfg.lihuiResPath) then
					local path = string.format("ui/bigbg/lingshenconvene/%s.png", data.cfg.lihuiResPath)

					uGuiUtil.setSpriteToImage(cell.role, uGuiUtil.SpriteType.BigBg, path, function()
						goutil.setActive(cell.go, true)
						cell.role:GetComponent("Image"):SetNativeSize()

						cell.role:GetComponent("Image").raycastTarget = false
					end)
				end

				local costType, costId, costNum = MaterialMgr.getMatParams(data.cfg.unlockCost)

				MaterialMgr.setIcon(cell.iconCost, costType, costId)

				cell.txtCost.text = langPara("消耗%s个", costNum)

				local openDate = GameUtil.string2date(data.cfg.startUnlockTime)

				cell.txtTime.text = langPara("%d.%02d.%02d后开启", openDate.year, openDate.month, openDate.day)
			end
		end
	end

	self:_refreshState(cell)
end

function LingShenConveneMainView:_refreshState(cell)
	if cell then
		local info = cell.info

		GameUtil.SetGray(cell.role, not info.isUnlock)
		goutil.setActive(cell.btnDetail, info.isUnlock)
		goutil.setActive(cell.btnUnlock, not info.isUnlock)

		if not info.isUnlock and info.matchtim and info.matchCost then
			local effPath = "fx_ui_tujianshouji/fx_ui_tujianshouji_tubiao.prefab"

			cell.showEff = UIEffectManager.instance:playEffect(self, effPath, cell.btnUnlock, 0, 0, true, false, nil, function(target, eff)
				eff.effGo.transform:SetParent(cell.btnUnlock.transform)
				GameUtil.setLocalPos(eff.effGo.transform, 0, 0, 0)
				GameUtil.setLocalScale(eff.effGo.transform, 1, 1, 1)
			end)
		end

		GameUtil.SetGray(cell.role, not info.isUnlock)
		goutil.setActive(cell.btnDetail, info.isUnlock)
		goutil.setActive(cell.lock, not info.isUnlock)

		if not info.isUnlock then
			if info.matchTime then
				goutil.setActive(cell.lock, true)
				goutil.setActive(cell.time, false)
				goutil.setActive(cell.cost, true)

				if info.matchCost then
					local effPath = "fx_ui_tujianshouji/fx_ui_tujianshouji_tubiao.prefab"

					cell.showEff = UIEffectManager.instance:playEffect(self, effPath, cell.btnUnlock, 0, 0, true, false, nil, function(target, eff)
						eff.effGo.transform:SetParent(cell.btnUnlock.transform)
						GameUtil.setLocalPos(eff.effGo.transform, 0, 0, 0)
						GameUtil.setLocalScale(eff.effGo.transform, 1, 1, 1)
					end)
				end
			else
				goutil.setActive(cell.lock, true)
				goutil.setActive(cell.time, true)
				goutil.setActive(cell.cost, false)
			end
		end
	end
end

function LingShenConveneMainView:_clearIconList()
	self._iconList = self._iconList or {}

	for i, cell in ipairs(self._iconList) do
		self:_clearIconCell(cell)
	end
end

function LingShenConveneMainView:_clearIconCell(cell)
	if cell then
		goutil.setActive(cell.go, false)
		GameUtil.rmClickHandler(cell.btnDetail)
		uGuiUtil.clearImage(cell.role)

		cell.btnUnlock = goutil.findChild(cell.go, "btnUnlock")

		GameUtil.rmClickHandler(cell.btnUnlock)

		if cell.showEff then
			UIEffectManager.instance:stopEffect(cell.showEff)

			cell.showEff = nil
		end

		MaterialMgr.resetAll(cell.iconCost)

		cell.info = nil
	end
end

function LingShenConveneMainView:_playEff(isLeft)
	goutil.setActive(self._btnLeft, false)
	goutil.setActive(self._btnRight, false)
	goutil.setActive(self._shadow, false)
	goutil.setActive(self._iconListGo, false)

	if self._fanshuEff then
		UIEffectManager.instance:stopEffect(self._fanshuEff)

		self._fanshuEff = nil
	end

	local effPath = "fx_ui_jijiefanshu/jijiefanshu-ui_p.prefab"

	self._fanshuEff = UIEffectManager.instance:playEffect(self, effPath, self._effPos, 0, 0, false, false, nil, function(target, eff)
		local aniName = isLeft and "fs2" or "fs"

		eff.effGo.transform:SetParent(self._effPos.transform)
		GameUtil.setLocalPos(eff.effGo.transform, 0, 0, 0)
		GameUtil.setLocalScale(eff.effGo.transform, 1, 1, 1)
		RoleObjectPool.instance:playAnimation(eff.effGo, aniName, false, function()
			goutil.setActive(self._btnLeft, self._curTabId > 1)
			goutil.setActive(self._btnRight, self._curTabId < #self._tabCfgs)
			goutil.setActive(self._shadow, self._curTabId == 2)
			goutil.setActive(self._iconListGo, true)
			goutil.setActive(eff.effGo, false)
		end)
	end)
end

return LingShenConveneMainView
