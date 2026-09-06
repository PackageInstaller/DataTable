-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/passport/view/PassportCellItem.lua

module("logic.extensions.passport.view.PassportCellItem", package.seeall)

local PassportCellItem = class("PassportCellItem")

function PassportCellItem:ctor(go)
	self.mainGO = go

	self:buildUI()
	self:onEnter()
end

function PassportCellItem:OnDestroy()
	self:onExit()
end

function PassportCellItem:buildUI()
	self._txtProgress = goutil.findChildTextComponent(self.mainGO, "txtProgress")
	self._txtGetFreeGo = goutil.findChild(self.mainGO, "txtGetFree")
	self._txtGetSuperGo = goutil.findChild(self.mainGO, "txtGetSuper")
	self._txtDay = goutil.findChildTextComponent(self.mainGO, "txtDay")
	self._imgBg = goutil.findChild(self.mainGO, "imgBg")
	self._cells = {}
	self._cells.free = self:_getCell("freePrize")
	self._cells.super1 = self:_getCell("superPrize_1")
	self._cells.super2 = self:_getCell("superPrize_2")
	self._cellGroup = self.mainGO:GetComponent("UIChangeGroup")
	self._btnGetSuperGo = goutil.findChild(self.mainGO, "btnGetSuper")
	self._btnGetSuper = self._btnGetSuperGo and GameUtil.asBtn(self._btnGetSuperGo)
	self._btnGetFreeGo = goutil.findChild(self.mainGO, "btnGetFree")
	self._btnGetFree = self._btnGetFreeGo and GameUtil.asBtn(self._btnGetFreeGo)
	self._btnShowBuyPassportGo = goutil.findChild(self.mainGO, "btnShowBuyPassport")
	self._btnShowBuyPassport = self._btnShowBuyPassportGo and GameUtil.asBtn(self._btnShowBuyPassportGo)
end

function PassportCellItem:_getCell(path)
	local cell = {}

	cell.go = goutil.findChild(self.mainGO, path)

	if not cell.go then
		return nil
	end

	cell.point = goutil.findChild(cell.go, "cellPoint")
	cell.redpoint = goutil.findChild(cell.go, "redPoint")
	cell.imgPassed = goutil.findChild(cell.go, "imgPassed")

	return cell
end

function PassportCellItem:onEnter()
	if self._btnShowBuyPassport then
		self._btnShowBuyPassport:AddClickListener(self._onClickGetMore, self)
	end

	if self._btnGetFree then
		self._btnGetFree:AddClickListener(self._onClickGetFree, self)
	end

	if self._btnGetSuper then
		self._btnGetSuper:AddClickListener(self._onClickGetSuper, self)
	end
end

function PassportCellItem:onExit()
	if self._btnGetSuper then
		self._btnGetSuper:RemoveClickListener()
	end

	if self._btnGetFree then
		self._btnGetFree:RemoveClickListener()
	end

	if self._btnShowBuyPassport then
		self._btnShowBuyPassport:RemoveClickListener()
	end

	for _, v in pairs(self._cells) do
		MaterialMgr.resetAll(v.point)
	end

	if self._effs then
		for _, v in pairs(self._effs) do
			UIEffectManager.instance:stopEffect(v)
		end
	end

	self._effs = nil
	self._curPassportData = nil
	self._curData = nil
	self._scrollRect = nil
end

function PassportCellItem:setData(refTarget, scrollRect, curPassportData, data)
	self._refTarget = refTarget
	self._curPassportData = curPassportData
	self._curData = data
	self._scrollRect = scrollRect

	self:initView()
end

function PassportCellItem:initView()
	local trs = self.mainGO.transform
	local count = trs.childCount

	if not self._curData.id then
		for i = count, 1, -1 do
			local child = trs:GetChild(i - 1)

			goutil.setActive(child.gameObject, false)
		end

		return
	else
		for i = count, 1, -1 do
			local child = trs:GetChild(i - 1)

			goutil.setActive(child.gameObject, true)
		end
	end

	for _, v in pairs(self._cells) do
		MaterialMgr.resetAll(v.point)
		GameUtil.SetActive(v.go, false)
	end

	self._effs = self._effs or {}

	for _, v in pairs(self._effs) do
		UIEffectManager.instance:stopEffect(v)
	end

	GameUtil.SetActive(self._btnGetSuperGo, false)
	GameUtil.SetActive(self._btnGetFreeGo, false)
	GameUtil.SetActive(self._btnShowBuyPassportGo, false)
	GameUtil.SetActive(self._txtGetFreeGo, false)
	GameUtil.SetActive(self._txtGetSuperGo, false)

	if self._cells.free and self._cells.free.redpoint then
		GameUtil.SetActive(self._cells.free.redpoint, false)
	end

	if self._cells.super1 and self._cells.super1.redpoint then
		GameUtil.SetActive(self._cells.super1.redpoint, false)
	end

	if self._cells.super2 and self._cells.super2.redpoint then
		GameUtil.SetActive(self._cells.super2.redpoint, false)
	end

	if self._cellGroup and self._curPassportData.funcId <= 3 then
		self._cellGroup:SetState(self._curPassportData.funcId - 1)
	end

	if self._imgBg then
		local isNeedShow = self._curPassportData.funcId <= 3 or self._curPassportData.funcId == 7

		GameUtil.SetActive(self._imgBg, isNeedShow)
	end

	if self._txtProgress and not string.nilorempty(self._curData.progressKey) then
		self._txtProgress.text = self._curData.progressKey
	end

	if self._txtDay then
		self._txtDay.text = langPara("text_The_What_Day", self._curData.id)
	end

	if not GameUtil.isEmptyString(self._curData.freePrize) then
		GameUtil.SetActive(self._cells.free.go, true)

		if self._cells.free.point then
			MaterialMgr.setCellByCfg(self._curData.freePrize, self._cells.free.point)
		end

		if self._cells.free.imgPassed then
			GameUtil.SetActive(self._cells.free.imgPassed, self._curData.freeState)
		end
	end

	local superPrizeStr = self._curData.payedPrize

	superPrizeStr = GameUtil.isEmptyString(superPrizeStr) and "" or superPrizeStr

	local supersPrizes = string.split(superPrizeStr, "#")

	if not GameUtil.isEmptyString(supersPrizes[1]) and self._cells.super1 then
		GameUtil.SetActive(self._cells.super1.go, true)

		if self._cells.super1.point then
			MaterialMgr.setCellByCfg(supersPrizes[1], self._cells.super1.point)
		end

		if self._cells.super1.imgPassed then
			GameUtil.SetActive(self._cells.super1.imgPassed, self._curData.superState)
		end
	end

	if not GameUtil.isEmptyString(supersPrizes[2]) and self._cells.super2 then
		GameUtil.SetActive(self._cells.super2.go, true)

		if self._cells.super2.point then
			MaterialMgr.setCellByCfg(supersPrizes[2], self._cells.super2.point)
		end

		if self._cells.super2.imgPassed then
			GameUtil.SetActive(self._cells.super2.imgPassed, self._curData.superState)
		end
	end

	if self._curData.id < self._curPassportData.unlockIndex then
		GameUtil.SetActive(self._txtGetFreeGo, true)
		GameUtil.SetActive(self._txtGetSuperGo, true)

		if not self._curData.freeState and self._cells.free then
			GameUtil.SetActive(self._btnGetFreeGo, true)
			GameUtil.SetActive(self._txtGetFreeGo, false)
			self:_playCellEff(self._cells.free.point)

			if self._cells.free.redpoint then
				GameUtil.SetActive(self._cells.free.redpoint, true)
			end
		end

		if not self._curData.superState then
			if self._cells.super1 then
				self:_playCellEff(self._cells.super1.point)
				GameUtil.SetActive(self._cells.super1.redpoint, self._curPassportData.hasPay)
			end

			if self._cells.super2 then
				self:_playCellEff(self._cells.super2.point)
				GameUtil.SetActive(self._cells.super2.redpoint, self._curPassportData.hasPay)
			end

			if not self._curPassportData.hasPay then
				GameUtil.SetActive(self._btnShowBuyPassportGo, true)
			else
				GameUtil.SetActive(self._btnGetSuperGo, true)
			end

			GameUtil.SetActive(self._txtGetSuperGo, false)
		end
	end
end

function PassportCellItem:_showTips()
	FloatWordMgr.instance:show(self._curPassportData.funcCfg.unlockTips)
end

function PassportCellItem:_onClickGetFree()
	PassportController.instance:sendGainPrizeReq(self._curPassportData.actId, self._curPassportData.funcId, self._curData.id - 1, false)
end

function PassportCellItem:_onClickGetSuper()
	PassportController.instance:sendGainPrizeReq(self._curPassportData.actId, self._curPassportData.funcId, self._curData.id - 1, true)
end

function PassportCellItem:_onClickGetMore()
	if self._curPassportData.hasPay then
		GameUtil.SetActive(self._btnShowBuyPassportGo, false)

		return
	end

	local cfg = self._curPassportData.actCfg

	if cfg and not string.nilorempty(cfg.buyEndTime) then
		local timeNow = ServerTime.now()
		local timeEnd = GameUtil.string2time(cfg.buyEndTime)

		if timeEnd <= timeNow then
			return
		end
	end

	if self._curPassportData.funcCfg.id == 1 then
		if self._refTarget and self._refTarget._buyView then
			UIStateManager.instance:push(self._refTarget._buyView, self._curPassportData.actCfg, self._curPassportData.funcCfg, 1)
		else
			UIStateManager.instance:push(ViewName.PassportwpbuyView, self._curPassportData.actCfg, self._curPassportData.funcCfg, 1)
		end
	elseif self._curPassportData.funcCfg.id == 2 then
		UIStateManager.instance:push(ViewName.PassportyzbuyView, self._curPassportData.actCfg, self._curPassportData.funcCfg, 1)
	else
		UIStateManager.instance:push(ViewName.PassportbuyView, self._curPassportData.actCfg, self._curPassportData.funcCfg, 1, self._curPassportData.sldValue)
	end
end

function PassportCellItem:_playCellEff(go)
	if not go then
		return
	end

	self._effs = self._effs or {}

	if self._effs[go] then
		UIEffectManager.instance:stopEffect(self._effs[go])

		self._effs[go] = nil
	end

	local resPath = "fx_ui_juqingfuben/fx_ui_juqingfuben02.prefab"

	local function loadCallBack()
		self._effs[go]:setScrollRectClipping(self._scrollRect)
	end

	self._effs[go] = UIEffectManager.instance:playEffect(self._refTarget, resPath, nil, nil, nil, true, nil, nil, loadCallBack)

	self._effs[go]:setParent(go.transform)
	self._effs[go]:setScale(1)
	self._effs[go]:setLocalPos(0, 0, 0)

	self._effs[go].hideEffWhileNotOnTop = true
end

return PassportCellItem
