-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/showdown/view/ShowDownPetShopView.lua

module("logic.extensions.dragonpsychicclg.view.ShowDownPetShopView", package.seeall)

local ShowDownPetShopView = class("ShowDownPetShopView", ViewComponent)

function ShowDownPetShopView:buildUI()
	ShowDownPetShopView.super.buildUI(self)

	local petScrView = goutil.findChild(self.mainGO, "petCol/scrView")
	local petScrCell = goutil.findChild(self.mainGO, "petCol/scrCell")

	self._petScrollList = ScrollerList.create(petScrView, petScrCell, GameUtil.handler(self._updatePetCell, self), GameUtil.handler(self._clearPetCell, self))
	self._petTableview = self._petScrollList:getView()
	self._leftTimes = goutil.findChild(self.mainGO, "leftTimes")
	self._txtLeftTimes = goutil.findChildTextComponent(self.mainGO, "leftTimes/txt")
	self._txtTips = goutil.findChildTextComponent(self.mainGO, "tips/txt")
	self._btnClose = goutil.findChild(self.mainGO, "btnClose")
	self._btnSure = goutil.findChild(self.mainGO, "btnSure")
	self._btnSureInOut = goutil.findChild(self.mainGO, "btnSureInOut")
	self._btnReset = goutil.findChild(self.mainGO, "btnReset")
	self._btnDraw = goutil.findChild(self.mainGO, "btnDraw")
end

function ShowDownPetShopView:bindEvents()
	ShowDownPetShopView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnSure, self._onClickBtnSure, self)
	GameUtil.addClickHandler(self._btnSureInOut, self._onClickBtnSureInOut, self)
	GameUtil.addClickHandler(self._btnReset, self._onClickBtnReset, self)
	GameUtil.addClickHandler(self._btnDraw, self._onClickBtnDraw, self)
	self._petTableview:RegisterReloadFinishCallback(self._onReloadFinish, self)
end

function ShowDownPetShopView:unbindEvents()
	ShowDownPetShopView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnSure)
	GameUtil.rmClickHandler(self._btnReset)
	GameUtil.rmClickHandler(self._btnDraw)
end

function ShowDownPetShopView:onEnter()
	ShowDownPetShopView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])
	self._roundId = checknumber(params[2])
	self._activityType = ShowDownController.instance:getActivityType()

	ShowDownController.instance:enterInStepMgr(self._activityId)

	local isInTime = ShowDownController.instance:isInActivityTime(self._activityId)

	if not isInTime then
		self:close()

		return
	end

	self._actData = ShowDownConfig.instance:getActData(self._activityId)
	self._isHasFirstDraw = true

	self.addGEvent(self, GlobalNotify.ShowDownStepChange, self._handleShowDownStepChange, self)
	self.addGEvent(self, GlobalNotify.HandlePM_ShowDown_GetQualifyMainInfoRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.HandlePM_ShowDown_RollPetsRes, self._handlePM_ShowDown_RollPetsRes, self)
	self.addGEvent(self, GlobalNotify.HandlePM_ShowDown_ConfirmPetsRes, self._handlePM_ShowDown_ConfirmPetsRes, self)
	self.addGEvent(self, GlobalNotify.HandlePM_ShowDown_SetWishListRes, self._onUpdate, self)
	self:_onUpdate()
end

function ShowDownPetShopView:onExit()
	ShowDownPetShopView.super.onExit(self)
	ShowDownController.instance:exitInStepMgr(self._activityId)
	self:_clearAllFlashEff()
	self:_stopTickingCellShow()
	self:_onClear()
end

function ShowDownPetShopView:_handleShowDownStepChange()
	if self._roundId == ShowDownEnum.Round_Func then
		return
	end

	local curStepId = ShowDownController.instance:getCurStepId(self._activityId)
	local curRoundId = ShowDownController.instance:getRoundIdByStep(self._activityId, curStepId)

	if curRoundId == self._roundId then
		self:_onUpdate()
	else
		self:close()
	end
end

function ShowDownPetShopView:_handlePM_ShowDown_RollPetsRes()
	FloatWordMgr.instance:show("精灵已重置")

	self._isNeedShowAnim = true

	self:_onUpdate()
end

function ShowDownPetShopView:_handlePM_ShowDown_ConfirmPetsRes(status)
	if status == 0 then
		FloatWordMgr.instance:show("确认成功")
		self:close()
	else
		printError("确认失败")
		FloatWordMgr.instance:show("确认失败")
		self:close()
	end
end

function ShowDownPetShopView:_onUpdate()
	self:_onUpdateData()
	self:_onUpdateUI()
end

function ShowDownPetShopView:_onClear()
	self:_onClearPetColUI()
end

function ShowDownPetShopView:_onUpdateData()
	self._seatList = {}

	local count = ShowDownController.instance:getMaxPetCountInPetShop(self._activityId, self._roundId)

	for seatId = 1, count do
		table.insert(self._seatList, seatId)
	end

	self._wishPetList = ShowDownController.instance:getWishPetListInPetShop(self._activityId, self._roundId)
	self._petList = ShowDownController.instance:getBagPetListInPetShop(self._activityId, self._roundId)
	self._maxWishPetCount = ShowDownController.instance:getMaxWishPetCountInPetShop(self._activityId, self._roundId)
	self._isHasFirstDraw = ShowDownController.instance:isHasFirstDrawInPetShop(self._activityId, self._roundId)
end

function ShowDownPetShopView:_onUpdateUI()
	local left = ShowDownController.instance:getLeftRefreshTimesInPetShop(self._activityId, self._roundId)
	local max = ShowDownController.instance:getMaxRefreshTimesInPetShop(self._activityId, self._roundId)

	GameUtil.SetActive(self._btnSure, self._isHasFirstDraw and left > 0)
	GameUtil.SetActive(self._btnReset, self._isHasFirstDraw and left > 0)
	GameUtil.SetActive(self._btnDraw, not self._isHasFirstDraw)
	GameUtil.SetActive(self._btnSureInOut, left <= 0)

	self._txtLeftTimes.text = string.format("%s/%s", left, max)

	GameUtil.SetActive(self._leftTimes, GameUtil.GetActive(self._btnReset))
	self:_onUpdatePetColUI()
end

function ShowDownPetShopView:_onUpdatePetColUI()
	self:_clearAllFlashEff()
	self._petScrollList:reloadData(self._seatList)
	self._petScrollList:MoveCellToBegin(0)
end

function ShowDownPetShopView:_onReloadFinish()
	if not self._isNeedShowAnim then
		return
	end

	self._rootIndex = 0
	self._rootList = {}

	local curVisibleCount = self._petTableview:GetVisibleCount()

	for index = 1, curVisibleCount do
		local cell = self._petTableview:GetCellByIndex(index - 1)
		local root = goutil.findChild(cell, "root")
		local isWishSeat = index <= self._maxWishPetCount

		if not isWishSeat then
			table.insert(self._rootList, root)
		end
	end

	settimer(0.2, self._tickingCellShow, self, true)
end

function ShowDownPetShopView:_tickingCellShow()
	self._rootIndex = self._rootIndex + 1

	local root = self._rootList[self._rootIndex]

	if root then
		GameUtil.SetActive(root, true)
		self:_playFlashEff(root)
	end

	if self._rootIndex > #self._rootList then
		self:_stopTickingCellShow()
	end
end

function ShowDownPetShopView:_stopTickingCellShow()
	self._isNeedShowAnim = false
	self._rootList = nil

	removetimer(self._tickingCellShow, self)
end

function ShowDownPetShopView:_onClearPetColUI()
	self._petScrollList:dispose()
end

function ShowDownPetShopView:_updatePetCell(view, cell, seatId, tag)
	local left = ShowDownController.instance:getLeftRefreshTimesInPetShop(self._activityId, self._roundId)

	if not self._petList[seatId] then
		local creepsId = 0

		if not self._wishPetList[seatId] then
			local creepsIdOfWish = 0
			local creepsData = ShowDownConfig.instance:getSystemPetData(creepsId)
			local creepsDataOfWish = ShowDownConfig.instance:getSystemPetData(creepsIdOfWish)
			local isWishSeat = seatId <= self._maxWishPetCount
			local isCanEnterWish = isWishSeat and not self._isHasFirstDraw and creepsData == nil and creepsDataOfWish == nil
			local mainGo = cell.gameObject
			local root = goutil.findChild(mainGo, "root")
			local pet = goutil.findChild(mainGo, "root/pet")
			local con = goutil.findChild(mainGo, "root/pet/con")
			local imgAdd = goutil.findChild(mainGo, "root/imgAdd")
			local imgHeart = goutil.findChild(mainGo, "root/imgHeart")
			local name = goutil.findChild(mainGo, "root/name")
			local txtName = goutil.findChildTextComponent(mainGo, "root/name/txt")
			local tips = goutil.findChild(mainGo, "root/tips")
			local txtTips = goutil.findChildTextComponent(mainGo, "root/tips/txt")

			GameUtil.SetActive(root, isWishSeat or not self._isNeedShowAnim)

			if creepsDataOfWish then
				GameUtil.SetActive(pet, true)

				local skinId = checknumber(creepsDataOfWish.faceId)

				if skinId <= 0 then
					skinId = creepsDataOfWish.raceId
				end

				MaterialMgr.setIcon(con, MatType.PET_SKIN, skinId, nil, nil)
			elseif creepsData then
				GameUtil.SetActive(pet, true)

				local skinId = checknumber(creepsData.faceId)

				if skinId <= 0 then
					skinId = creepsData.raceId
				end

				MaterialMgr.setIcon(con, MatType.PET_SKIN, skinId, nil, nil)
			else
				GameUtil.SetActive(pet, false)
				MaterialMgr.clearIcon(con)
			end

			GameUtil.SetActive(imgHeart, isWishSeat)
			GameUtil.SetActive(imgAdd, isWishSeat and creepsData == nil and creepsDataOfWish == nil and left > 0)
			GameUtil.SetActive(tips, GameUtil.GetActive(imgAdd))

			local nameStr = ""

			if creepsDataOfWish then
				nameStr = creepsDataOfWish.creepsName
			elseif creepsData then
				nameStr = creepsData.creepsName
			end

			txtName.text = nameStr

			GameUtil.SetActive(name, not string.nilorempty(nameStr))
			GameUtil.addClickHandler(imgAdd, function()
				if isCanEnterWish then
					UIStateManager.instance:push(ViewName.ShowDownPetShopHeartView, self._activityId, self._roundId, creepsIdOfWish)
				end
			end)
			GameUtil.addClickHandler(con, function()
				if isCanEnterWish then
					UIStateManager.instance:push(ViewName.ShowDownPetShopHeartView, self._activityId, self._roundId, creepsIdOfWish)
				elseif not creepsData then
					local data = creepsDataOfWish

					if data then
						local raceId = data.raceId
						local level = data.lv
						local awakenLv = data.awakenLv
						local skinId = data.faceId
						local tmpMo = FightingPowerPetMo.createPetByLevel(raceId, level, awakenLv, skinId)

						CommonTipsMgr.instance:showPetTips(tmpMo, true)
					end
				end
			end)
		end
	end
end

function ShowDownPetShopView:_clearPetCell(cell)
	local mainGo = cell.gameObject
	local con = goutil.findChild(mainGo, "con")
	local imgAdd = goutil.findChild(mainGo, "imgAdd")

	MaterialMgr.clearIcon(con)
	GameUtil.rmClickHandler(con)
	GameUtil.rmClickHandler(imgAdd)
end

function ShowDownPetShopView:_playFlashEff(effParent)
	local pathName = "20240430/leitaisai/fx_ui_choujiang_baokai"

	self:_stopFlashtEff(effParent)

	if not goutil.isNil(effParent) and not string.nilorempty(pathName) then
		local path = pathName .. ".prefab"

		local function finishHandler(handlerTarget, eff)
			return
		end

		local function loadedHandler(handlerTarget, eff)
			eff:setParent(effParent.transform)
			eff:setLocalPos(0, 0, 0)
			eff:setScale(1, 1, 1)

			eff.hideEffWhileNotOnTop = true
		end

		local handlerTarget

		if self._flashEffPool == nil then
			self._flashEffPool = {}
		end

		self._flashEffPool[effParent] = UIEffectManager.instance:playEffect(self, path, effParent, 0, 0, false, false, finishHandler, loadedHandler, handlerTarget)
	end
end

function ShowDownPetShopView:_stopFlashtEff(effParent)
	if self._flashEffPool then
		UIEffectManager.instance:stopEffect(self._flashEffPool[effParent])

		self._flashEffPool[effParent] = nil
	end
end

function ShowDownPetShopView:_clearAllFlashEff()
	if self._flashEffPool then
		for key, eff in pairs(self._flashEffPool) do
			UIEffectManager.instance:stopEffect(eff)

			self._flashEffPool[key] = nil
		end
	end
end

function ShowDownPetShopView:_onClickBtnSure()
	local isHasConfirm = ShowDownController.instance:isHasConfirmInPetShop(self._activityId, self._roundId)

	if isHasConfirm then
		self:close()
	else
		ShowDownController.instance:sendPM_ShowDown_ConfirmPetsReq(self._activityId, self._roundId)
	end
end

function ShowDownPetShopView:_onClickBtnSureInOut()
	local isHasConfirm = ShowDownController.instance:isHasConfirmInPetShop(self._activityId, self._roundId)

	if isHasConfirm then
		self:close()
	else
		ShowDownController.instance:sendPM_ShowDown_ConfirmPetsReq(self._activityId, self._roundId)
	end
end

function ShowDownPetShopView:_onClickBtnReset()
	local left = ShowDownController.instance:getLeftRefreshTimesInPetShop(self._activityId, self._roundId)

	if left <= 0 then
		FloatWordMgr.instance:show("剩余刷新次数不足")

		return
	end

	ShowDownController.instance:sendPM_ShowDown_RollPetsReq(self._activityId, self._roundId)
end

function ShowDownPetShopView:_onClickBtnDraw()
	if self._isHasFirstDraw then
		FloatWordMgr.instance:show("已经抽过精灵")

		return
	end

	if #self._wishPetList < self._maxWishPetCount then
		FloatWordMgr.instance:show("必须选择心愿精灵")

		return
	end

	ShowDownController.instance:sendPM_ShowDown_RollPetsReq(self._activityId, self._roundId)
end

return ShowDownPetShopView
