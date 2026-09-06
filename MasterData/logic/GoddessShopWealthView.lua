-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/goddessshop/view/GoddessShopWealthView.lua

module("logic.extensions.goddessshop.view.GoddessShopWealthView", package.seeall)

local GoddessShopWealthView = class("GoddessShopWealthView", ViewComponent)

function GoddessShopWealthView:buildUI()
	GoddessShopWealthView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._con = self:getGo("mask/con")
	self._txtStep = self:_getFormatTxt("txtStep")
	self._txtWealth = self:_getFormatTxt("txtWealth")
	self._txtProfit = self:_getFormatTxt("txtProfit")
	self._levelScrView = self:getGo("levelCol/scrView")
	self._levelScrCell = self:getGo("levelCol/scrCell")
	self._levelScrollerList = ScrollerList.create(self._levelScrView, self._levelScrCell, GameUtil.handler(self._updateLevelCell, self), GameUtil.handler(self._clearLevelCell, self))
	self._txtWealthLevelCell = self:_getFormatTxt("levelCol/scrCell/txtWealth")
	self._txtStepLevelCell = self:_getFormatTxt("levelCol/scrCell/txtStep")
end

function GoddessShopWealthView:_getFormatTxt(field)
	local txt = self:getTxt(field)

	self._defaultStrs = self._defaultStrs or {}
	self._defaultStrs[txt] = txt.text

	return txt
end

function GoddessShopWealthView:_setFormatTxt(txt, ...)
	local defaultStr = self._defaultStrs[txt]

	txt.text = string.format(defaultStr, ...)
end

function GoddessShopWealthView:_getFormatStr(txt)
	return self._defaultStrs[txt]
end

function GoddessShopWealthView:bindEvents()
	GoddessShopWealthView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
end

function GoddessShopWealthView:unbindEvents()
	GoddessShopWealthView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function GoddessShopWealthView:onEnter()
	GoddessShopWealthView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])

	GoddessShopController.instance:enterInMgr(self._activityId)

	local isInTime = GoddessShopController.instance:isInActivityTime(self._activityId)

	if not isInTime then
		self:close()

		return
	end

	self._activityType = GoddessShopController.instance:getActivityType()
	self._goddessShopMo = GoddessShopController.instance:getGoddessShopMo(self._activityId)
	self._actData = GoddessShopConfig.instance:getActData(self._activityId)

	self.addGEvent(self, GlobalNotify.HandlePM_SurroundByDreamGirlInfoRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.HandlePM_SurroundByDreamGirlInvestRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.SurroundByDreamGirlShopMoneyUpdate, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.HandlePM_SurroundByDreamGirlGainMoneyProgressPrizeRes, self._onUpdate, self)
	self:_onUpdate()
end

function GoddessShopWealthView:onExit()
	GoddessShopWealthView.super.onExit(self)
	GoddessShopController.instance:exitInMgr(self._activityId)
	uGuiUtil.clearImage(self._con)
	self:_onClearLevelCol()
end

function GoddessShopWealthView:_onUpdate()
	local money = self._goddessShopMo:getClientMoney()
	local curLevel = GoddessShopConfig.instance:getLevelByMoney(self._activityId, money)
	local curProgressData = GoddessShopConfig.instance:getMoneyProgressData(self._activityId, curLevel)

	self:_setFormatTxt(self._txtWealth, money)
	self:_setFormatTxt(self._txtStep, curProgressData.levelDesc)

	local totalMoneyAddSpeed = self._goddessShopMo:getTotalMoneyAddSpeed()

	self:_setFormatTxt(self._txtProfit, totalMoneyAddSpeed * 60)

	local spriteName = GameUrl.getBigbgPngUrl(curProgressData.conPath)

	uGuiUtil.setSpriteToImage(self._con, uGuiUtil.SpriteType.BigBg, spriteName, function()
		self._con:GetComponent(goutil.Type_UIImage):SetNativeSize()
	end)
	self:_onUpdateLevelCol()
end

function GoddessShopWealthView:_onUpdateLevelCol()
	local cfg = GoddessShopConfig.instance:getMoneyProgressCfg(self._activityId) or {}

	self._levelScrollerList:reloadData(cfg)
end

function GoddessShopWealthView:_onClearLevelCol()
	self._levelScrollerList:dispose()
end

function GoddessShopWealthView:_updateLevelCell(view, cell, data, tag)
	local level = data.level
	local money = self._goddessShopMo:getClientMoney()
	local isHasGain = self._goddessShopMo:isHasGainPrizeInProgress(level)
	local isEnoughGet = self._goddessShopMo:isEnoughGetPrizeInProgress(level, money)
	local isCanGet = self._goddessShopMo:isCanGetPrizeInProgress(level, money)
	local mainGo = cell.gameObject
	local txtWealth = goutil.findChildTextComponent(mainGo, "txtWealth")
	local txtStep = goutil.findChildTextComponent(mainGo, "txtStep")
	local prize = goutil.findChild(mainGo, "prize")
	local item = goutil.findChild(mainGo, "prize/item")
	local imgReceived = goutil.findChild(mainGo, "prize/imgReceived")
	local btnGet = goutil.findChild(mainGo, "prize/btnGet")
	local effectRoot = goutil.findChild(mainGo, "prize/effectRoot")
	local isHavePrize = not string.nilorempty(data.prize)

	if isHavePrize then
		MaterialMgr.setCellByCfg(data.prize, item)
		GameUtil.SetActive(prize, true)
	else
		MaterialMgr.resetAll(item)
		GameUtil.SetActive(prize, false)
	end

	GameUtil.SetActive(imgReceived, isHavePrize and isHasGain)
	GameUtil.SetActive(btnGet, isCanGet)

	txtWealth.text = string.format(self:_getFormatStr(self._txtWealthLevelCell), data.progress)
	txtStep.text = string.format(self:_getFormatStr(self._txtStepLevelCell), data.levelDesc)
	self._prizeEffPool = self._prizeEffPool or {}

	UIEffectManager.instance:stopEffect(self._prizeEffPool[mainGo])

	if isCanGet == true then
		local effPath = "fx_ui_juqingfuben/fx_ui_juqingfuben02.prefab"

		local function func(_, eff)
			eff:setScrollRectClipping(self._levelScrView:GetComponent(ComponentType.ScrollRect))
			eff:setParent(effectRoot.transform)
			eff:setLocalPos(0, 0, 0)
			eff:setScale(1, 1, 1)
		end

		self._prizeEffPool[mainGo] = UIEffectManager.instance:playEffect(self, effPath, effectRoot, 0, 0, true, false, nil, func, nil)
	end

	GameUtil.addClickHandler(btnGet, function()
		if not isCanGet then
			FloatWordMgr.instance:show("不可领取")

			return
		end

		GoddessShopController.instance:sendPM_SurroundByDreamGirlGainMoneyProgressPrizeReq(self._activityId, level)
	end)
end

function GoddessShopWealthView:_clearLevelCell(cell)
	local mainGo = cell.gameObject
	local item = goutil.findChild(mainGo, "prize/item")
	local btnGet = goutil.findChild(mainGo, "prize/btnGet")

	if self._prizeEffPool then
		UIEffectManager.instance:stopEffect(self._prizeEffPool[mainGo])
	end

	MaterialMgr.resetAll(item)
	GameUtil.rmClickHandler(btnGet)
end

return GoddessShopWealthView
