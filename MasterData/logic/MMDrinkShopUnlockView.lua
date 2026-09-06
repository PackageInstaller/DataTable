-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mmdrinkshop/view/MMDrinkShopUnlockView.lua

module("logic.extensions.mmdrinkshop.view.MMDrinkShopUnlockView", package.seeall)

local MMDrinkShopUnlockView = class("MMDrinkShopUnlockView", ViewComponent)

function MMDrinkShopUnlockView:ctor()
	MMDrinkShopUnlockView.super.ctor(self)
end

function MMDrinkShopUnlockView:unbindEvents()
	MMDrinkShopUnlockView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnUnlock)

	for i, cell in ipairs(self._showCelllist) do
		GameUtil.rmClickHandler(cell.btn)
	end
end

function MMDrinkShopUnlockView:bindEvents()
	MMDrinkShopUnlockView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnUnlock, self._onClickUnlock, self)

	for i, cell in ipairs(self._showCelllist) do
		GameUtil.addClickHandler(cell.btn, function()
			self:_onClickSelect(i)
		end, self)
	end
end

function MMDrinkShopUnlockView:buildUI()
	MMDrinkShopUnlockView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._txtOpenTime = self:getTxt("txtOpenTime/txt")
	self._prizecon = self:getGo("showDetail/prizecon")
	self._prizeCell = self:getGo("showDetail/prizeCell")
	self._btnUnlock = self:getGo("showDetail/btnUnlock")
	self._txtDesc = self:getTxt("showDetail/txtDesc")
	self._progress = self:getGo("showDetail/progress")
	self._txtProgress = self:getTxt("showDetail/progress/txt")
	self._txtTitle = self:getTxt("showDetail/txtTitle")
	self._conCells = self:getGo("conCells")
	self._showCelllist = {}

	for i = 1, 4 do
		local cell = {}

		cell.go = self:getGo("conCells/cell_" .. i)
		cell.btn = goutil.findChild(cell.go, "btn")
		cell.rd = goutil.findChild(cell.go, "rd")
		cell.conUnlock = goutil.findChild(cell.go, "roleCon/unlock")
		cell.conLock = goutil.findChild(cell.go, "roleCon/lock")
		cell.select = goutil.findChild(cell.go, "select")

		table.insert(self._showCelllist, cell)
	end
end

function MMDrinkShopUnlockView:onExit()
	MMDrinkShopUnlockView.super.onExit(self)
	self:_resetCurSelect()
	GameUtil.clearCells(self._prizecon, self._clearPrizeCell, self)
end

function MMDrinkShopUnlockView:onEnter()
	MMDrinkShopUnlockView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.PM_MMDrinkShopGetInfoRes, self._updateUIByInfo, self)
	self.addGEvent(self, GlobalNotify.PM_MMDrinkShopGainPrizeRes, self._handleGainLock, self)

	self._activityId = checknumber(self:getFirstParam())

	if self._activityId <= 0 then
		self._activityId = MMDrinkShopController.instance:getDefaultActivityId()
	end

	self:_updateUIByCfg()
	self:_updateUIByInfo()
	MMDrinkShopController.instance:getInfo(self._activityId)

	self._isFirstEnter = true
end

function MMDrinkShopUnlockView:_handleGainLock()
	TipsFacade.instance:openCommonTips(lang("解锁成功"))
	self:_updateUIByInfo()
end

function MMDrinkShopUnlockView:_updateUIByCfg()
	self._actCfg = MMDrinkShopConfig.instance:getActivityCfgByActivityId(self._activityId)
	self._txtOpenTime.text = TimeGateController.instance:getActTimeShow(self._activityId)
	self._prizeCfgs = MMDrinkShopConfig.instance:getAllPrizeCfgByActivityId(self._activityId)

	for i, cell in ipairs(self._showCelllist) do
		local prizeCfg = self._prizeCfgs[i]

		if prizeCfg then
			local lockPicpath = GameUrl.getBigbgPngUrl(prizeCfg.lockPicPath)

			if not prizeCfg.lockShowParams then
				local lockShowParams = {}

				uGuiUtil.setSpriteToImage(cell.conLock, uGuiUtil.SpriteType.BigBg, lockPicpath, function()
					cell.conLock:GetComponent("Image"):SetNativeSize()

					cell.conLock:GetComponent("Image").raycastTarget = false

					local posX = checknumber(lockShowParams[1])
					local posY = checknumber(lockShowParams[2])
					local scale = checknumber(lockShowParams[3])

					GameUtil.setAnchoredPos(cell.conLock, posX, posY)
					GameUtil.setLocalPos(cell.conLock, scale, scale, scale)
				end)

				local unlockPicpath = GameUrl.getBigbgPngUrl(prizeCfg.unlockPicPath)

				if not prizeCfg.unlockShowParams then
					local unlockShowParams = {}

					uGuiUtil.setSpriteToImage(cell.conUnlock, uGuiUtil.SpriteType.BigBg, unlockPicpath, function()
						cell.conUnlock:GetComponent("Image"):SetNativeSize()

						cell.conUnlock:GetComponent("Image").raycastTarget = false

						local posX = checknumber(unlockShowParams[1])
						local posY = checknumber(unlockShowParams[2])
						local scale = checknumber(unlockShowParams[3])

						GameUtil.setAnchoredPos(cell.conUnlock, posX, posY)
						GameUtil.setLocalPos(cell.conUnlock, scale, scale, scale)
					end)
				end
			end
		end
	end
end

function MMDrinkShopUnlockView:_updateUIByInfo()
	self._curTotalCupCount = MMDrinkShopModel.instance:getTotalCupCount(self._activityId)

	local firstSelectId = 1

	for i, cell in ipairs(self._showCelllist) do
		local prizeCfg = self._prizeCfgs[i]

		if prizeCfg then
			goutil.setActive(cell.go, true)

			local isGained = MMDrinkShopModel.instance:isPrizeGained(self._activityId, prizeCfg.prizeId)

			goutil.setActive(cell.conUnlock, isGained)
			goutil.setActive(cell.conLock, not isGained)

			local isCanGain = not isGained and self._curTotalCupCount >= checknumber(prizeCfg.needCupCount)

			if firstSelectId == 1 and isCanGain then
				firstSelectId = i
			end

			goutil.setActive(cell.rd, isCanGain)
		else
			goutil.setActive(cell.go, false)
		end
	end

	if self._isFirstEnter then
		self._isFirstEnter = false
		self._curSelectId = firstSelectId
	end

	self:_updateUIBySelect()
end

function MMDrinkShopUnlockView:_updateUIBySelect()
	local prizeCfg = self._prizeCfgs[self._curSelectId]

	if not prizeCfg then
		return
	end

	self:_resetCurSelect()

	self._txtTitle.text = prizeCfg.title or ""
	self._txtDesc.text = prizeCfg.desc or ""

	if not prizeCfg.prize then
		local prizeStrs = string.split(prizeCfg.prize, "#") or {}

		GameUtil.updateCellsList(self._prizecon, self._prizeCell, prizeStrs, self._updatePrizeCell, self)

		self._txtProgress.text = langPara("完成订单(%s/%s杯)", self._curTotalCupCount, prizeCfg.needCupCount or 0)

		local isGained = MMDrinkShopModel.instance:isPrizeGained(self._activityId, prizeCfg.prizeId)
		local canGain = ((not prizeCfg.needCupCount or nil) and 0) <= self._curTotalCupCount

		if isGained then
			goutil.setActive(self._btnUnlock, false)
			goutil.setActive(self._progress, false)
			GameUtil.SetGray(self._btnUnlock, false)
		else
			goutil.setActive(self._btnUnlock, true)
			goutil.setActive(self._progress, true)
			GameUtil.SetGray(self._btnUnlock, not canGain)
		end

		for i, cell in ipairs(self._showCelllist) do
			local showSelect = i == self._curSelectId

			goutil.setActive(cell.select, showSelect)

			if showSelect then
				cell.go.transform:SetAsLastSibling()
			end
		end
	end
end

function MMDrinkShopUnlockView:_resetCurSelect()
	MaterialMgr.resetAll(self._prizecon)
end

function MMDrinkShopUnlockView:_updatePrizeCell(cellGo, data, tabIdx)
	local item = goutil.findChild(cellGo, "item")

	MaterialMgr.setCellByCfg(data, item)

	local markGained = goutil.findChild(cellGo, "markGained")
	local isCurGained = MMDrinkShopModel.instance:isPrizeGained(self._activityId, self._curSelectId)

	goutil.setActive(markGained, isCurGained)
end

function MMDrinkShopUnlockView:_clearPrizeCell(cellGo)
	local item = goutil.findChild(cellGo, "item")

	MaterialMgr.resetAll(item)
end

function MMDrinkShopUnlockView:_onClickBtnTip()
	if self._actCfg then
		if not self._actCfg.ruleKey then
			local ruleKey = ""

			TipsFacade.instance:openRulesView(ruleKey)
		end
	end
end

function MMDrinkShopUnlockView:_onClickSelect(selectId)
	if self._curSelectId == selectId then
		return
	end

	self._curSelectId = selectId

	self:_updateUIBySelect()
end

function MMDrinkShopUnlockView:_onClickUnlock()
	local prizeCfg = self._prizeCfgs[self._curSelectId]

	if not prizeCfg then
		return
	end

	local canGain = (prizeCfg.needCupCount or 0) <= self._curTotalCupCount

	if canGain then
		MMDrinkShopController.instance:gainPrize(self._activityId, prizeCfg.prizeId)
	else
		TipsFacade.instance:openCommonTips(lang("暂未满足订单数量，无法解锁"))
	end
end

return MMDrinkShopUnlockView
