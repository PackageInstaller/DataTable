-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/huanxinqing/view/HuanXinQingMainView.lua

module("logic.extensions.huanxinqing.view.HuanXinQingMainView", package.seeall)

local HuanXinQingMainView = class("HuanXinQingMainView", ViewComponent)

function HuanXinQingMainView:ctor()
	HuanXinQingMainView.super.ctor(self)
end

function HuanXinQingMainView:buildUI()
	HuanXinQingMainView.super.buildUI(self)

	self._btnClose = goutil.findChild(self.mainGO, "leftTop/btnClose")
	self._btnCostItem = goutil.findChild(self.mainGO, "left/btnCost/item")
	self._costTxt = self:getTxt("left/btnCost/txt")
	self._btnCost = self:getGo("left/btnCost")
	self._txtPetNameInInfo = goutil.findChildTextComponent(self.mainGO, "right/petInfo/txt")
	self._pointRare = goutil.findChild(self.mainGO, "right/petInfo/pointRare")
	self._con = goutil.findChild(self.mainGO, "right/con")
	self._txtOpenTime = goutil.findChildTextComponent(self.mainGO, "txtOpenTime/txt")
	self._btnBuyPet = goutil.findChild(self.mainGO, "right/btnBuyPet")
	self._hasBuyPetTxt = goutil.findChild(self.mainGO, "right/btnBuyPet/buyTxt/hasBuyTxt")
	self._noBuyPetTxt = goutil.findChild(self.mainGO, "right/btnBuyPet/buyTxt/noBuyTxt")
	self._lockTxt = goutil.findChild(self.mainGO, "right/btnBuyPet/buyTxt/lockTxt")
	self._buyPetImage = self:getGo("right/btnBuyPet/buyTxt/noBuyTxt/coinImage")
	self._buyPetRedPoint = goutil.findChild(self.mainGO, "right/btnBuyPet/redPoint")
	self._txtBgBuyPet = goutil.findChild(self.mainGO, "right/btnBuyPet/txtBg")
	self._hasGainPet = goutil.findChild(self.mainGO, "right/btnBuyPet/receive")
	self._btnAwake = goutil.findChild(self.mainGO, "right/btnAwake")
	self._hasBuyAwakeTxt = goutil.findChild(self.mainGO, "right/btnAwake/hasBuyTxt")
	self._noBuyAwakeTxt = goutil.findChild(self.mainGO, "right/btnAwake/noBuyTxt")
	self._buyAwakeImage = self:getGo("right/btnAwake/noBuyTxt/coinImage")
	self._buyAwakeRedPoint = goutil.findChild(self.mainGO, "right/btnAwake/redPoint")
	self._txtBgAwake = goutil.findChild(self.mainGO, "right/btnAwake/txtBg")
	self._hasGainAwake = goutil.findChild(self.mainGO, "right/btnAwake/receive")
	self._btnLevel = goutil.findChild(self.mainGO, "right/btnLevel")
	self._hasBuyLevelTxt = goutil.findChild(self.mainGO, "right/btnLevel/hasBuyTxt")
	self._noBuyLevelTxt = goutil.findChild(self.mainGO, "right/btnLevel/noBuyTxt")
	self._buyLevelImage = self:getGo("right/btnLevel/noBuyTxt/coinImage")
	self._buyLevelRedPoint = goutil.findChild(self.mainGO, "right/btnLevel/redPoint")
	self._txtBgLevel = goutil.findChild(self.mainGO, "right/btnLevel/txtBg")
	self._hasGainLevel = goutil.findChild(self.mainGO, "right/btnLevel/receive")
	self._buyLevelIndex = HuanXinQingEnum.ItemId_Level
	self._buyAwakeIndex = HuanXinQingEnum.ItemId_Awake
	self._buyPetIndex = HuanXinQingEnum.ItemId_Pet
	self._content = self:getGo("left/content")
	self._btnDirectBuyPet = goutil.findChild(self.mainGO, "right/btnTab")
	self._btnTip = goutil.findChild(self.mainGO, "leftTop/btnTip")
	self._btnCheckIn = goutil.findChild(self.mainGO, "btnCheckIn")
	self._btnCheckInRedPoint = goutil.findChild(self.mainGO, "btnCheckIn/redPoint")
end

function HuanXinQingMainView:bindEvents()
	HuanXinQingMainView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnTip, self._onClikBtnTip, self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnDirectBuyPet, self._onClikBtnDirectBuyPet, self)
	GameUtil.addClickHandler(self._btnAwake, self._onClikBtnAwake, self)
	GameUtil.addClickHandler(self._btnLevel, self._onClikBtnLevel, self)
	GameUtil.addClickHandler(self._btnBuyPet, self._onClikBtnBuyPet, self)
	GameUtil.addClickHandler(self._btnCost, self._onClickBtnCost, self)
	GameUtil.addClickHandler(self._btnCheckIn, self._onClickBtnCheckIn, self)
end

function HuanXinQingMainView:unbindEvents()
	HuanXinQingMainView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnDirectBuyPet)
	GameUtil.rmClickHandler(self._btnAwake)
	GameUtil.rmClickHandler(self._btnLevel)
	GameUtil.rmClickHandler(self._btnBuyPet)
	GameUtil.rmClickHandler(self._btnCost)
	GameUtil.rmClickHandler(self._btnCheckIn)
end

function HuanXinQingMainView:onEnter()
	HuanXinQingMainView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])

	if self._activityId <= 0 then
		-- block empty
	end

	self._activityType = HuanXinQingController.instance:getActivityType()

	local isInTime = HuanXinQingController.instance:isInActivityTime(self._activityId)

	if not isInTime then
		local text = string.format("活动不在开启期限内( activityId = %d )", self._activityId)

		local function func()
			self:close()
		end

		TipsFacade.instance:openTipWindow("提示", text, func, "确定", UnityEngine.TextAnchor.MiddleCenter)

		return
	end

	self._raceId = HuanXinQingConfig.instance:getActData(self._activityId).raceId

	self:_onSetUI()
	self:showTabAt(self._content, ViewName.HuanXinQingTaskFrameView, self._activityId)
	self.addGEvent(self, GlobalNotify.HandlePM_PetActiveGetInfoRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.HandlePM_PetActiveGetUnlockRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.HandlePM_PetActiveGetDirectBuyRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.OnMaterialItemChange, self.onItemCountChange, self)
	HuanXinQingController.instance:sendPM_PetActiveGetInfoReq(self._activityId)
	RedPointController.instance:regRedPoint(self._btnCheckInRedPoint, 122)
end

function HuanXinQingMainView:onExit()
	HuanXinQingMainView.super.onExit(self)

	if self._role then
		self._role = RoleObjectPool.instance:removeRole(self._role)
		self._role = nil
	end

	self:showTabAt(self._content, "")
	MaterialMgr.resetAll(self._btnCostItem)
	RedPointController.instance:unregRedPoint(self._btnCheckInRedPoint)
end

function HuanXinQingMainView:_onUpdate()
	self._model = HuanXinQingModel.instance:GetModel(self._activityId)
	self._costMatNum = MaterialModel.instance:getMaterialsNumber(self._costMatType, self._costMatId)
	self._costTxt.text = self._costMatNum

	self:_updateButton()
end

function HuanXinQingMainView:_onClikBtnTip()
	local key = HuanXinQingConfig.instance:getCommonData(self._activityId).ruleKeyMain

	TipsFacade.instance:openRulesView(key)
end

function HuanXinQingMainView:_onClickBtnCheckIn()
	UIStateManager.instance:push(ViewName.OperationCheckInView, self._activityId)
end

function HuanXinQingMainView:_onClikBtnDirectBuyPet()
	local petName
	local petData = CharacterConfig.instance:getPetCo(self._raceId)
	local directBuyKey = HuanXinQingConfig.instance:getActData(self._activityId).payPrice
	local arr = string.split(directBuyKey, ":")

	if arr then
		if not arr[3] then
			local toCostNum = 0

			if HuanXinQingModel.instance:hasBuy(self._activityId, self._buyPetIndex) then
				FloatWordMgr.instance:show("已购买过，无法再次购买！")
			else
				local type, id, num = MaterialMgr.getMatParams(directBuyKey)
				local content = langPara("确定花费%s%s直接购买100级满觉醒%s吗？", toCostNum, MaterialMgr.getMaterialsName(type, id), (petData or nil) and petData.name)

				TipsFacade.instance:openPopupCostMatViewNew(type, id, toCostNum, content, GameUtil.handler(self._onClickDirectBuyPet, self))
				self:_updateButton()
			end
		end
	end
end

function HuanXinQingMainView:_onClickBtnCost()
	TipsFacade.instance:openItemSourceView(MaterialMgr.createSerName(self._costMatType, self._costMatId))
end

function HuanXinQingMainView:_onClickDirectBuyPet()
	HuanXinQingController.instance:sendPM_PetActiveGetDirectBuyReq(self._activityId)
	self:_updateButton()
end

function HuanXinQingMainView:_onClikBtnBuyPet()
	if HuanXinQingModel.instance:hasBuy(self._activityId, self._buyPetIndex) then
		FloatWordMgr.instance:show("已完成，无法再次购买")

		return
	end

	local petName
	local petData = CharacterConfig.instance:getPetCo(self._raceId)
	local curModel = HuanXinQingModel.instance:GetModel(self._activityId)

	if curModel.unlockItems[1] and curModel.unlockItems[2] then
		local costNum = HuanXinQingConfig.instance:getActData(self._activityId).gainPetCost
		local content = langPara("确定花费%s%s获得%s吗？", costNum, MaterialMgr.getMaterialsName(self._costMatType, self._costMatId), (petData or nil) and petData.name)

		TipsFacade.instance:openPopupCostMatViewNew(self._costMatType, self._costMatId, costNum, content, function()
			HuanXinQingController.instance:sendPM_PetActiveGetUnlockReq(self._activityId, self._buyPetIndex)
			GameUtil.SetActive(self._buyPetRedPoint, false)
		end)
	else
		FloatWordMgr.instance:show("未完成觉醒与等级，无法解锁精灵")
	end
end

function HuanXinQingMainView:_onClikBtnLevel()
	if HuanXinQingModel.instance:hasBuy(self._activityId, self._buyLevelIndex) then
		FloatWordMgr.instance:show("已完成，无法再次升级")

		return
	end

	local costNum = HuanXinQingConfig.instance:getActData(self._activityId).lvUpCost
	local content = langPara("确定花费%s%s升级等级吗？", costNum, MaterialMgr.getMaterialsName(self._costMatType, self._costMatId))

	TipsFacade.instance:openPopupCostMatViewNew(self._costMatType, self._costMatId, costNum, content, function()
		HuanXinQingController.instance:sendPM_PetActiveGetUnlockReq(self._activityId, self._buyLevelIndex)
		GameUtil.SetActive(self._buyLevelRedPoint, false)
		FloatWordMgr.instance:show("升级成功")
	end)
end

function HuanXinQingMainView:_onClikBtnAwake()
	if HuanXinQingModel.instance:hasBuy(self._activityId, self._buyAwakeIndex) then
		FloatWordMgr.instance:show("已完成，无法再次觉醒")

		return
	end

	local costNum = HuanXinQingConfig.instance:getActData(self._activityId).awakenUpCost
	local content = langPara("确定花费%s%s升级觉醒等级吗？", costNum, MaterialMgr.getMaterialsName(self._costMatType, self._costMatId))

	TipsFacade.instance:openPopupCostMatViewNew(self._costMatType, self._costMatId, costNum, content, function()
		HuanXinQingController.instance:sendPM_PetActiveGetUnlockReq(self._activityId, self._buyAwakeIndex)
		GameUtil.SetActive(self._buyAwakeRedPoint, false)
		FloatWordMgr.instance:show("觉醒成功")
	end)
end

function HuanXinQingMainView:_onSetUI()
	local skinId = self:_getSkinId()

	self._role = RoleObjectPool.instance:addRoleToParent(self._role, skinId, self._con, nil, nil, true, nil, nil)

	local skinId = self:_getSkinId()

	if skinId > 0 then
		MaterialMgr.setCell(MatType.Rare, skinId, self._pointRare)
	end

	self._txtPetNameInInfo.text = PetSkinConfig.instance:getPetSkinName(self:_getSkinId())

	local costMaterialKey = HuanXinQingConfig.instance:getActData(self._activityId).costMaterialKey
	local type, id, num = MaterialMgr.getMatParams(costMaterialKey)

	self._costMatType = type
	self._costMatId = id
	self._costMatNum = MaterialModel.instance:getMaterialsNumber(self._costMatType, self._costMatId)
	self._costTxt.text = self._costMatNum

	MaterialMgr.setIcon(self._btnCostItem, self._costMatType, self._costMatId, nil, nil)
end

function HuanXinQingMainView:onItemCountChange(mo)
	if self._costMatType == mo:GetMatType() then
		self._costMatNum = mo:GetCount()

		self:_onUpdate()
	end
end

function HuanXinQingMainView:_updateBtnRedPoint(btnId)
	local actData = HuanXinQingConfig.instance:getActData(self._activityId)
	local lvUpCost = actData.lvUpCost
	local awakenUpCost = actData.awakenUpCost
	local gainPetCost = actData.gainPetCost

	if btnId == self._buyLevelIndex then
		if lvUpCost <= self._costMatNum and not HuanXinQingModel.instance:hasBuy(self._activityId, self._buyLevelIndex) then
			GameUtil.SetActive(self._buyLevelRedPoint, true)
		else
			GameUtil.SetActive(self._buyLevelRedPoint, false)
		end
	elseif btnId == self._buyAwakeIndex then
		if awakenUpCost <= self._costMatNum and not HuanXinQingModel.instance:hasBuy(self._activityId, self._buyAwakeIndex) then
			GameUtil.SetActive(self._buyAwakeRedPoint, true)
		else
			GameUtil.SetActive(self._buyAwakeRedPoint, false)
		end
	elseif btnId == self._buyPetIndex then
		if gainPetCost <= self._costMatNum and not HuanXinQingModel.instance:hasBuy(self._activityId, self._buyPetIndex) then
			GameUtil.SetActive(self._buyPetRedPoint, true)
		else
			GameUtil.SetActive(self._buyPetRedPoint, false)
		end
	end
end

function HuanXinQingMainView:_updateButton()
	if HuanXinQingModel.instance:hasBuy(self._activityId, self._buyLevelIndex) then
		GameUtil.SetActive(self._hasBuyLevelTxt, true)
		GameUtil.SetActive(self._noBuyLevelTxt, false)
		GameUtil.setLocalScale(self._txtBgLevel, 1, 1.3, 1)
		GameUtil.SetActive(self._hasGainLevel, true)
	else
		self._noBuyLevelTxt:GetComponent("Text").text = "等级100\n" .. "<color=#fffbd2>" .. HuanXinQingConfig.instance:getActData(self._activityId).lvUpCost .. "</color>"

		MaterialMgr.setIcon(self._buyLevelImage, self._costMatType, self._costMatId, nil, nil)
		GameUtil.SetActive(self._hasBuyLevelTxt, false)
		GameUtil.SetActive(self._noBuyLevelTxt, true)
		GameUtil.SetActive(self._buyLevelImage, true)
		GameUtil.setLocalScale(self._txtBgLevel, 1, 2.2, 1)
		GameUtil.SetActive(self._hasGainLevel, false)
	end

	self:_updateBtnRedPoint(self._buyLevelIndex)

	if HuanXinQingModel.instance:hasBuy(self._activityId, self._buyAwakeIndex) then
		GameUtil.SetActive(self._hasBuyAwakeTxt, true)
		GameUtil.SetActive(self._noBuyAwakeTxt, false)
		GameUtil.setLocalScale(self._txtBgAwake, 1, 1.3, 1)
		GameUtil.SetActive(self._hasGainAwake, true)
	else
		self._noBuyAwakeTxt:GetComponent("Text").text = "觉醒Ⅵ级\n" .. "<color=#fffbd2>" .. HuanXinQingConfig.instance:getActData(self._activityId).awakenUpCost .. "</color>"

		MaterialMgr.setIcon(self._buyAwakeImage, self._costMatType, self._costMatId, nil, nil)
		GameUtil.SetActive(self._hasBuyAwakeTxt, false)
		GameUtil.SetActive(self._noBuyAwakeTxt, true)
		GameUtil.SetActive(self._buyAwakeImage, true)
		GameUtil.setLocalScale(self._txtBgAwake, 1, 2.2, 1)
		GameUtil.SetActive(self._hasGainAwake, false)
	end

	self:_updateBtnRedPoint(self._buyAwakeIndex)

	if HuanXinQingModel.instance:hasBuy(self._activityId, self._buyPetIndex) then
		GameUtil.SetActive(self._hasBuyPetTxt, true)
		GameUtil.SetActive(self._noBuyPetTxt, false)
		GameUtil.SetActive(self._lockTxt, false)
		GameUtil.setLocalScale(self._txtBgBuyPet, 1, 1.3, 1)
		GameUtil.SetActive(self._hasGainPet, true)
	else
		GameUtil.SetActive(self._hasBuyPetTxt, false)
		GameUtil.SetActive(self._noBuyPetTxt, true)
		GameUtil.SetActive(self._hasGainPet, false)
		GameUtil.SetActive(self._lockTxt, false)

		if HuanXinQingModel.instance:hasBuy(self._activityId, self._buyAwakeIndex) and HuanXinQingModel.instance:hasBuy(self._activityId, self._buyLevelIndex) then
			self._noBuyPetTxt:GetComponent("Text").text = "解锁精灵：\n" .. "<color=#fffbd2>" .. HuanXinQingConfig.instance:getActData(self._activityId).gainPetCost .. "</color>"

			MaterialMgr.setIcon(self._buyPetImage, self._costMatType, self._costMatId, nil, nil)
			GameUtil.SetActive(self._buyPetImage, true)
			GameUtil.setLocalScale(self._txtBgBuyPet, 1, 2.2, 1)
		else
			GameUtil.SetActive(self._lockTxt, true)
			GameUtil.SetActive(self._hasBuyPetTxt, false)
			GameUtil.SetActive(self._noBuyPetTxt, false)
			GameUtil.SetActive(self._buyPetImage, false)
			GameUtil.setLocalScale(self._txtBgBuyPet, 1, 1.3, 1)
		end
	end

	self:_updateBtnRedPoint(self._buyPetIndex)
end

function HuanXinQingMainView:_getSkinId()
	return HuanXinQingController.instance:getSkinId(self._activityId)
end

return HuanXinQingMainView
