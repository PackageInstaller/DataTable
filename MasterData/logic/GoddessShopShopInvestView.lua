-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/goddessshop/view/GoddessShopShopInvestView.lua

module("logic.extensions.goddessshop.view.GoddessShopShopInvestView", package.seeall)

local GoddessShopShopInvestView = class("GoddessShopShopInvestView", ViewComponent)

function GoddessShopShopInvestView:buildUI()
	GoddessShopShopInvestView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._pointRare = self:getGo("petInfo/pointRare")
	self._txtPetName = self:getTxt("petInfo/txtName")
	self._txtShopName = self:getTxt("txtShopName")
	self._con = self:getGo("mask/con")
	self._txtFeel = self:getTxt("txtFeel")
	self._strTxtFeel = self._txtFeel.text
	self._levelScrView = self:getGo("levelCol/scrView")
	self._levelScrCell = self:getGo("levelCol/scrCell")
	self._levelScrollerList = ScrollerList.create(self._levelScrView, self._levelScrCell, GameUtil.handler(self._updateLevelCell, self), GameUtil.handler(self._clearLevelCell, self))
	self._txtDescLevelCell = self:getTxt("levelCol/scrCell/txtDesc")
	self._txtImgLockLevelCell = self:getTxt("levelCol/scrCell/imgLock/txt")
	self._strTxtDescLevelCell = self._txtDescLevelCell.text
	self._strTxtImgLockLevelCell = self._txtImgLockLevelCell.text
end

function GoddessShopShopInvestView:bindEvents()
	GoddessShopShopInvestView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
end

function GoddessShopShopInvestView:unbindEvents()
	GoddessShopShopInvestView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function GoddessShopShopInvestView:onEnter()
	GoddessShopShopInvestView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])
	self._girlId = checknumber(params[2])

	local isInTime = GoddessShopController.instance:isInActivityTime(self._activityId)

	if not isInTime then
		self:close()

		return
	end

	self._activityType = GoddessShopController.instance:getActivityType()
	self._goddessShopMo = GoddessShopController.instance:getGoddessShopMo(self._activityId)
	self._actData = GoddessShopConfig.instance:getActData(self._activityId)
	self._girlData = GoddessShopConfig.instance:getGirlData(self._activityId, self._girlId)

	self.addGEvent(self, GlobalNotify.HandlePM_SurroundByDreamGirlInfoRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.HandlePM_SurroundByDreamGirlInvestRes, self._handlePM_SurroundByDreamGirlInvestRes, self)
	self.addGEvent(self, GlobalNotify.SurroundByDreamGirlShopMoneyUpdate, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.SurroundByDreamGirlShopFetterUpdate, self._onUpdate, self)

	local modelCo = CharacterConfig.instance:getModelCo(self._girlData.skinId)

	uGuiUtil.setSpriteToImage(self._con, uGuiUtil.SpriteType.BigBg, GameUrl.getPetImgUrl(modelCo.cardName))
	self:_onUpdate()
end

function GoddessShopShopInvestView:onExit()
	GoddessShopShopInvestView.super.onExit(self)
	MaterialMgr.resetAll(self._pointRare)
	uGuiUtil.clearImage(self._con)
	self:_onClearLevelCol()
end

function GoddessShopShopInvestView:_handlePM_SurroundByDreamGirlInvestRes()
	GoddessShopController.instance:sendPM_SurroundByDreamGirlInfoReq(self._activityId)
end

function GoddessShopShopInvestView:_onUpdate()
	self:_onUpdateData()
	self:_onUpdateUI()
end

function GoddessShopShopInvestView:_onUpdateData()
	return
end

function GoddessShopShopInvestView:_onUpdateUI()
	self._txtShopName.text = self._girlData.shopName
	self._txtPetName.text = PetSkinConfig.instance:getPetSkinName(self._girlData.skinId)

	MaterialMgr.setCell(MatType.PetSkin_Rare, self._girlData.skinId, self._pointRare)

	if self._strTxtFeel then
		local cur = self._goddessShopMo:getFetterInShop(self._girlId)
		local max = self._girlData.maxFetter

		self._txtFeel.text = string.format(self._strTxtFeel, cur, max)
	end

	self:_onUpdateLevelCol()
end

function GoddessShopShopInvestView:_onUpdateLevelCol()
	local list = {}
	local cfg = GoddessShopConfig.instance:getGirlInvestCfg(self._activityId, self._girlId) or {}

	for i = 0, 10 do
		local data = cfg[i]

		if data then
			table.insert(list, data)
		end
	end

	local index = 0

	for idx, data in ipairs(list) do
		index = idx - 1

		local isHasReach = self._goddessShopMo:isHasReachInvestLvInShop(self._girlId, data.level)

		if not isHasReach then
			break
		end
	end

	self._levelScrollerList:reloadData(list)
	self._levelScrollerList:MoveCellToCenter(index)
end

function GoddessShopShopInvestView:_onClearLevelCol()
	self._levelScrollerList:dispose()
end

function GoddessShopShopInvestView:_updateLevelCell(view, cell, data, tag)
	local level = data.level
	local isEnoughFetter = self._goddessShopMo:isEnoughFetterInvestLvInShop(self._girlId, level)
	local isEnoughCost = self._goddessShopMo:isEnoughCostInvestLvInShop(self._girlId, level)
	local isEnough = self._goddessShopMo:isEnoughInvestLvInShop(self._girlId, level)
	local isHasReach = self._goddessShopMo:isHasReachInvestLvInShop(self._girlId, level)
	local isCanInvest = self._goddessShopMo:isCanInvestLvInShopLevel(self._girlId, level)
	local mainGo = cell.gameObject
	local btnInvest = goutil.findChild(mainGo, "btnInvest")
	local txtBtnInvest = goutil.findChildTextComponent(mainGo, "btnInvest/txt")
	local txtDesc = goutil.findChildTextComponent(mainGo, "txtDesc")
	local imgLock = goutil.findChild(mainGo, "imgLock")
	local txtImgLock = goutil.findChildTextComponent(mainGo, "imgLock/txt")
	local prize = goutil.findChild(mainGo, "prize")
	local item = goutil.findChild(mainGo, "prize/item")
	local imgReceived = goutil.findChild(mainGo, "prize/imgReceived")
	local effectRoot = goutil.findChild(mainGo, "prize/effectRoot")
	local isHavePrize = not string.nilorempty(data.prize)

	if isHavePrize then
		MaterialMgr.setCellByCfg(data.prize, item)
	else
		MaterialMgr.resetAll(item)
	end

	GameUtil.SetActive(imgReceived, isHavePrize and isHasReach)
	GameUtil.SetActive(imgLock, not isEnoughFetter and not isHasReach)
	GameUtil.SetActive(btnInvest, isHasReach or isEnoughFetter)
	GameUtil.SetGray(btnInvest, not isCanInvest)

	txtBtnInvest.text = isHasReach and "已投资" or "投资"
	txtDesc.text = string.format(self._strTxtDescLevelCell, data.cost, data.shopSizeDesc, data.moneyAddSpeed * 60)
	txtImgLock.text = string.format(self._strTxtImgLockLevelCell, data.fetterLimit)
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

	GameUtil.addClickHandler(btnInvest, function()
		local tips

		if isHasReach then
			tips = "已投资"
		elseif not isEnoughFetter then
			tips = "好感度不足"
		elseif not isEnoughCost then
			tips = "财富不足"
		elseif not isCanInvest then
			tips = "不可投资"
		end

		if tips then
			FloatWordMgr.instance:show(tips)

			return
		end

		GoddessShopController.instance:sendPM_SurroundByDreamGirlInvestReq(self._activityId, self._girlId)
	end)
end

function GoddessShopShopInvestView:_clearLevelCell(cell)
	local mainGo = cell.gameObject
	local item = goutil.findChild(mainGo, "prize/item")
	local btnInvest = goutil.findChild(mainGo, "btnInvest")

	if self._prizeEffPool then
		UIEffectManager.instance:stopEffect(self._prizeEffPool[mainGo])
	end

	MaterialMgr.resetAll(item)
	GameUtil.rmClickHandler(btnInvest)
end

return GoddessShopShopInvestView
