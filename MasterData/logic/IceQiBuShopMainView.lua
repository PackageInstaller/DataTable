-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/huanxinqing/view/IceQiBuShopMainView.lua

module("logic.extensions.huanxinqing.view.IceQiBuShopMainView", package.seeall)

local IceQiBuShopMainView = class("IceQiBuShopMainView", ViewComponent)

function IceQiBuShopMainView:ctor()
	IceQiBuShopMainView.super.ctor(self)
end

function IceQiBuShopMainView:buildUI()
	IceQiBuShopMainView.super.buildUI(self)

	self._btnClose = self:getGo("leftTop/btnClose")
	self._btnTip = self:getGo("leftTop/btnTip")
	self._txtOpenTime = self:getTxt("txtOpenTime/txt")
	self._goldBarCon = self:getGo("goldBarCon")
	self._content = self:getGo("left/content")
	self._txtPetNameInInfo = self:getTxt("right/petInfo/txt")
	self._pointRare = self:getGo("right/petInfo/pointRare")
	self._con = self:getGo("right/con")
	self._btnTab = self:getGo("right/btnTab")

	local itemScrCell = self:getGo("right/itemCol/scrCell")
	local itemScrView = self:getGo("right/itemCol/scrView")

	self._itemScrollerList = ScrollerList.create(itemScrView, itemScrCell, GameUtil.handler(self._updateItemCell, self), GameUtil.handler(self._clearItemCell, self))
end

function IceQiBuShopMainView:bindEvents()
	IceQiBuShopMainView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnTip, self._onClikBtnTip, self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTab, self._onClikBtnTab, self)
end

function IceQiBuShopMainView:unbindEvents()
	IceQiBuShopMainView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTab)
end

function IceQiBuShopMainView:onEnter()
	IceQiBuShopMainView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])

	if self._activityId <= 0 then
		self._activityId = 401003
	end

	self._activityType = HuanXinQingController.instance:getActivityType()

	local isInTime = HuanXinQingController.instance:isInActivityTime(self._activityId)

	if not isInTime then
		self:close()

		return
	end

	self._actData = HuanXinQingConfig.instance:getActData(self._activityId)

	local propData = HuanXinQingConfig.instance:getPropData(self._activityId, 1)

	self._costMat = propData and propData.exchangeCost

	self:_onSetUI()
	self:showTabAt(self._content, ViewName.IceQiBuShopTaskFrameView, self._activityId)
	self.addGEvent(self, GlobalNotify.HandlePM_PetActiveGetInfoRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.HandlePM_PetActiveGetExchangePropRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.HandlePM_PetActiveGetDirectBuyRes, self._onUpdate, self)
	self:_onUpdate()
	HuanXinQingController.instance:sendPM_PetActiveGetInfoReq(self._activityId)
end

function IceQiBuShopMainView:onExit()
	IceQiBuShopMainView.super.onExit(self)

	if self._role then
		self._role = RoleObjectPool.instance:removeRole(self._role)
	end

	self:showTabAt(self._content, "")
	self:_onClearItemCol()
end

function IceQiBuShopMainView:_onSetUI()
	local skinId = HuanXinQingController.instance:getSkinId(self._activityId)

	self._role = RoleObjectPool.instance:addRoleToParent(self._role, skinId, self._con, nil, nil, true, nil, nil)

	if skinId > 0 then
		MaterialMgr.setCell(MatType.Rare, skinId, self._pointRare)
	end

	self._txtPetNameInInfo.text = PetSkinConfig.instance:getPetSkinName(skinId)

	local goldInfo = {
		showAdd = false,
		id = self._costMat
	}

	MainUIController.instance:showGlodBar(self._goldBarCon, self._viewPresentor, {
		goldInfo
	})
end

function IceQiBuShopMainView:_onUpdate()
	self:_onUpdateItemCol()

	local hasBuy = HuanXinQingModel.instance:hasBuy(self._activityId, HuanXinQingEnum.ItemId_Pet)

	GameUtil.SetGray(self._btnTab, hasBuy)
end

function IceQiBuShopMainView:_onUpdateItemCol()
	local datas = HuanXinQingConfig.instance:getPropDatas(self._activityId) or {}

	self._itemScrollerList:reloadData(datas)
end

function IceQiBuShopMainView:_onClearItemCol()
	self._itemScrollerList:dispose()
end

function IceQiBuShopMainView:_updateItemCell(view, cell, data, tag)
	local itemMat = data.prop
	local costMat = data.exchangeCost
	local itemArr

	if itemMat then
		local matType, matId, matNum = MaterialMgr.getMatParams(itemMat)
		local matName = MaterialMgr.getMaterialsName(matType, matId)

		itemArr = {
			matType = matType,
			matId = matId,
			matNum = matNum,
			matName = matName
		}
	end

	local costArr

	if costMat then
		local matType, matId, matNum = MaterialMgr.getMatParams(costMat)
		local matName = MaterialMgr.getMaterialsName(matType, matId)

		costArr = {
			matType = matType,
			matId = matId,
			matNum = matNum,
			matName = matName
		}
	end

	local buyTimes = HuanXinQingModel.instance:getPropBuyTimes(self._activityId, data.propId)
	local maxItemNum = data.exchangeTimesLimit
	local leftItemNum = Mathf.Max(0, maxItemNum - buyTimes)
	local mainGo = cell.gameObject
	local item = goutil.findChild(mainGo, "item")
	local tagLock = goutil.findChild(mainGo, "tagLock")
	local tagOut = goutil.findChild(mainGo, "tagOut")
	local txtCount = goutil.findChildTextComponent(mainGo, "count/txt")
	local iconCost = goutil.findChild(mainGo, "txtCost/icon")
	local txtCost = goutil.findChildTextComponent(mainGo, "txtCost")
	local txtName = goutil.findChildTextComponent(mainGo, "txtName")

	MaterialMgr.setCellByCfg(itemMat, item)
	GameUtil.SetActive(tagOut, leftItemNum <= 0)

	txtName.text = MaterialMgr.getMaterialsName(itemArr.matType, itemArr.matId)
	txtCount.text = string.format("限购次数：%s/%s", leftItemNum, maxItemNum)
	txtCost.text = costArr.matNum

	MaterialMgr.setIcon(iconCost, costArr.matType, costArr.matId, nil, nil)
	GameUtil.addClickHandler(mainGo, function()
		if leftItemNum <= 0 then
			FloatWordMgr.instance:show("已售罄")

			return
		end

		local content = string.format("确定要花费%s%s，购买1个%s吗？", costArr.matNum, costArr.matName, itemArr.matName)

		local function successCallBack()
			HuanXinQingController.instance:sendPM_PetActiveGetExchangePropReq(self._activityId, data.propId, 1)
		end

		TipsFacade.instance:openPopupCostMatViewNew(costArr.matType, costArr.matId, costArr.matNum, content, successCallBack)
	end)
end

function IceQiBuShopMainView:_clearItemCell(cell)
	local mainGo = cell.gameObject
	local item = goutil.findChild(mainGo, "item")
	local iconCost = goutil.findChild(mainGo, "txtCost/icon")

	MaterialMgr.resetAll(item)
	MaterialMgr.clearIcon(iconCost)
	GameUtil.rmClickHandler(mainGo)
end

function IceQiBuShopMainView:_onClikBtnTip()
	local data = HuanXinQingConfig.instance:getCommonData(self._activityId)
	local key = data and data.ruleKeyMain

	TipsFacade.instance:openRulesView(key)
end

function IceQiBuShopMainView:_onClikBtnTab()
	local petName = CharacterConfig.instance:getPetName(self._actData.raceId)
	local matStr = self._actData.payPrice
	local matType, matId, matNum = MaterialMgr.getMatParams(matStr)
	local matName = MaterialMgr.getMaterialsName(matType, matId)
	local hasBuy = HuanXinQingModel.instance:hasBuy(self._activityId, HuanXinQingEnum.ItemId_Pet)

	if hasBuy then
		FloatWordMgr.instance:show("已购买过，无法再次购买！")
	else
		local content = langPara("确定花费%s%s直接购买100级满觉醒%s吗？", matNum, matName, petName)

		local function successCallBack()
			HuanXinQingController.instance:sendPM_PetActiveGetDirectBuyReq(self._activityId)
		end

		TipsFacade.instance:openPopupCostMatViewNew(matType, matId, matNum, content, successCallBack)
	end
end

return IceQiBuShopMainView
