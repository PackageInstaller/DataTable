-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/goddessshop/view/GoddessShopMainView.lua

module("logic.extensions.goddessshop.view.GoddessShopMainView", package.seeall)

local GoddessShopMainView = class("GoddessShopMainView", ViewComponent)

function GoddessShopMainView:buildUI()
	GoddessShopMainView.super.buildUI(self)

	self._btnClose = self:getGo("leftTop/btnClose")
	self._btnTip = self:getGo("leftTop/btnTip")
	self._txtOpenTime = self:getTxt("openTime/txt")
	self._infoCol = self:getGo("infoCol")
	self._prizeItem = self:getGo("infoCol/prizeItem")
	self._imgHasGain = self:getGo("infoCol/imgHasGain")
	self._redpointInfo = self:getGo("infoCol/redpoint")
	self._txtStep = self:getTxt("infoCol/txtStep")
	self._txtWealth = self:getTxt("infoCol/txtWealth")
	self._strTxtWealth = self._txtWealth.text
	self._pointCell = self:getGo("pointCol/pointCell")
	self._pointView = self:getGo("pointCol/pointView")

	local txtFetter = self:getTxt("pointCol/pointCell/txtFetter")
	local txtWealth = self:getTxt("pointCol/pointCell/txtWealth")

	self._strTxtFetterPointCell = txtFetter.text
	self._strTxtWealthPointCell = txtWealth.text
	self._btnPlay = self:getGo("btnPlay")
	self._redBtnPlay = self:getGo("btnPlay/redPoint")
	self._imgCon = self:getGo("imgCon")
end

function GoddessShopMainView:bindEvents()
	GoddessShopMainView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTip, self)
	GameUtil.addClickHandler(self._btnPlay, self._onClickBtnPlay, self)
	GameUtil.addClickHandler(self._infoCol, self._onClickBtnInfoCol, self)
end

function GoddessShopMainView:unbindEvents()
	GoddessShopMainView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnPlay)
	GameUtil.rmClickHandler(self._infoCol)
end

function GoddessShopMainView:onEnter()
	GoddessShopMainView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])

	if self._activityId <= 0 then
		self._activityId = GoddessShopController.instance:getActivityId()
	end

	GoddessShopController.instance:enterInMgr(self._activityId)

	local isInTime = GoddessShopController.instance:isInActivityTime(self._activityId)

	if not isInTime then
		self:close()

		return
	end

	self._activityType = GoddessShopController.instance:getActivityType()
	self._goddessShopMgr = GoddessShopController.instance:getMgr(self._activityId)
	self._goddessShopMo = GoddessShopController.instance:getGoddessShopMo(self._activityId)
	self._actData = GoddessShopConfig.instance:getActData(self._activityId)

	self.addGEvent(self, GlobalNotify.HandlePM_SurroundByDreamGirlInfoRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.SurroundByDreamGirlShopMoneyUpdate, self._handleMoneyUpdate, self)
	self.addGEvent(self, GlobalNotify.HandlePM_SurroundByDreamGirlGainMoneyProgressPrizeRes, self._onUpdate, self)

	self._txtOpenTime.text = GameUtil.getActTimeDesc(self._activityType, self._activityId)

	GoddessShopController.instance:sendPM_SurroundByDreamGirlInfoReq(self._activityId)
	self:_onUpdate()
end

function GoddessShopMainView:onExit()
	GoddessShopMainView.super.onExit(self)

	self._goddessShopMgr = nil

	GoddessShopController.instance:exitInMgr(self._activityId)
	uGuiUtil.clearImage(self._imgCon)
	self:_onClearPointCol()
end

function GoddessShopMainView:_handleMoneyUpdate()
	self:_onUpdateMoneyUI()
end

function GoddessShopMainView:_onUpdate()
	self:_onUpdateData()
	self:_onUpdateUI()
end

function GoddessShopMainView:_onUpdateData()
	return
end

function GoddessShopMainView:_onUpdateUI()
	local curLevel = self._goddessShopMo:getNewestLvInProgress()
	local maxLevel = GoddessShopConfig.instance:getMaxLevelInProgress(self._activityId)
	local nextLevel = Mathf.Min(curLevel + 1, maxLevel)
	local curProgressData = GoddessShopConfig.instance:getMoneyProgressData(self._activityId, curLevel)
	local nextProgressData = GoddessShopConfig.instance:getMoneyProgressData(self._activityId, nextLevel)

	self._txtStep.text = curProgressData.levelDesc

	if not string.nilorempty(nextProgressData.prize) then
		MaterialMgr.setCellByCfg(nextProgressData.prize, self._prizeItem)
	else
		MaterialMgr.resetAll(self._prizeItem)
	end

	GameUtil.SetActive(self._imgHasGain, self._goddessShopMo:isHasGainPrizeInProgress(nextLevel))

	local isCanGet = false
	local levelCfg = GoddessShopConfig.instance:getMoneyProgressCfg(self._activityId) or {}

	for _, data in ipairs(levelCfg) do
		local money = self._goddessShopMo:getClientMoney()

		if self._goddessShopMo:isCanGetPrizeInProgress(data.level, money) then
			isCanGet = true

			break
		end
	end

	GameUtil.SetActive(self._redpointInfo, isCanGet)

	local spriteName = GameUrl.getBigbgPngUrl(curProgressData.conPath)

	uGuiUtil.setSpriteToImage(self._imgCon, uGuiUtil.SpriteType.BigBg, spriteName, function()
		self._imgCon:GetComponent(goutil.Type_UIImage):SetNativeSize()
	end)
	self:_onUpdateMoneyUI()
	self:_onUpdatePointCol()
end

function GoddessShopMainView:_onUpdateMoneyUI()
	local money = self._goddessShopMo:getClientMoney()
	local totalMoneyAddSpeed = self._goddessShopMo:getTotalMoneyAddSpeed()

	self._txtWealth.text = string.format(self._strTxtWealth, money, totalMoneyAddSpeed * 60)
end

function GoddessShopMainView:_onUpdatePointCol()
	local cfg = GoddessShopConfig.instance:getGirlCfg(self._activityId) or {}

	GameUtil.updateCellsList(self._pointView, self._pointCell, cfg, self._updatePointCell, self)
end

function GoddessShopMainView:_onClearPointCol()
	GameUtil.clearCells(self._pointView, self._clearPointCell, self)
end

function GoddessShopMainView:_updatePointCell(mainGo, data, index)
	local girlId = data.dreamGirlId
	local mask = goutil.findChild(mainGo, "mask")
	local icon = goutil.findChild(mainGo, "mask/icon")
	local redpoint = goutil.findChild(mainGo, "redpoint")
	local txtFetter = goutil.findChildTextComponent(mainGo, "txtFetter")
	local txtName = goutil.findChildTextComponent(mainGo, "txtName")
	local txtWealth = goutil.findChildTextComponent(mainGo, "txtWealth")

	if not data.pos then
		if not data.pos[3] then
			local x, y, scale = checknumber(data.pos[1]), checknumber(data.pos[2]), 1

			GameUtil.setLocalPos(mainGo, x, y, 0)
			GameUtil.setLocalScale(mainGo, data.pos[3], data.pos[3], data.pos[3])
			MaterialMgr.setIcon(icon, MatType.Pet, data.skinId, nil, nil)

			txtName.text = data.shopName
			txtWealth.text = string.format(self._strTxtWealthPointCell, self._goddessShopMo:getMoneyAddSpeed(girlId) * 60)
			txtFetter.text = string.format(self._strTxtFetterPointCell, self._goddessShopMo:getFetterInShop(girlId), data.maxFetter)

			GameUtil.SetActive(redpoint, self._goddessShopMo:isCanInvestLvInShop(girlId))
			GameUtil.addClickHandler(mask, function()
				UIStateManager.instance:push(ViewName.GoddessShopShopView, self._activityId, girlId)
			end)
		end
	end
end

function GoddessShopMainView:_clearPointCell(mainGo)
	local mask = goutil.findChild(mainGo, "mask")
	local icon = goutil.findChild(mainGo, "mask/icon")

	MaterialMgr.clearIcon(icon)
	GameUtil.rmClickHandler(mask)
end

function GoddessShopMainView:_onClickBtnTip()
	TipsFacade.instance:openRulesView(self._actData.ruleKeyMain)
end

function GoddessShopMainView:_onClickBtnPlay()
	UIStateManager.instance:push(ViewName.ExploreUnderMainView, self._activityId)
end

function GoddessShopMainView:_onClickBtnInfoCol()
	UIStateManager.instance:push(ViewName.GoddessShopWealthView, self._activityId)
end

return GoddessShopMainView
