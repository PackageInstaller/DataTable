-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/powerland/view/stage/StagePetShopView.lua

module("logic.extensions.powerland.view.stage.StagePetShopView", package.seeall)

local StagePetShopView = class("StagePetShopView", ViewComponent)

function StagePetShopView:ctor()
	StagePetShopView.super.ctor(self)
end

function StagePetShopView:buildUI()
	StagePetShopView.super.buildUI(self)

	self._btnClose = goutil.findChild(self.mainGO, "btnClose")
	self._btnChange = goutil.findChild(self.mainGO, "btnChange")
	self._btnChangeTxt = goutil.findChildTextComponent(self.mainGO, "btnChange/txt")
	self._btnTarget = goutil.findChild(self.mainGO, "btnTarget")
	self._btnNext = goutil.findChild(self.mainGO, "btnNext")
	self._btnPet = goutil.findChild(self.mainGO, "btnPet")
	self._goldBarCon = goutil.findChild(self.mainGO, "goldBarCon")
	self._goldItemCon = goutil.findChild(self.mainGO, "goldBarCon/goldItemCon")
	self._txtGoldNum = goutil.findChildTextComponent(self.mainGO, "goldBarCon/txtGoldNum")
	self._goldBarCost = goutil.findChild(self.mainGO, "goldBarCost")
	self._costItem = goutil.findChild(self.mainGO, "goldBarCost/costItem")
	self._txtCostNum = goutil.findChildTextComponent(self.mainGO, "goldBarCost/txtCostNum")
	self._itemScrollerview = goutil.findChild(self.mainGO, "itemCol/itemScrollerview")
	self._itemScrollercell = goutil.findChild(self.mainGO, "itemCol/itemScrollercell")
	self._itemScrollList = ScrollerList.create(self._itemScrollerview, self._itemScrollercell, GameUtil.handler(self._updateItemCell, self), GameUtil.handler(self._clearItemCell, self))
end

function StagePetShopView:bindEvents()
	StagePetShopView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnNext, self._onClickBtnNext, self)
	GameUtil.addClickHandler(self._btnChange, self._onClickBtnChange, self)
	GameUtil.addClickHandler(self._btnTarget, self._onClickBtnTarget, self)
	GameUtil.addClickHandler(self._btnPet, self._onClickBtnPet, self)
end

function StagePetShopView:unbindEvents()
	StagePetShopView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnNext)
	GameUtil.rmClickHandler(self._btnChange)
	GameUtil.rmClickHandler(self._btnTarget)
	GameUtil.rmClickHandler(self._btnPet)
end

function StagePetShopView:destroyUI()
	StagePetShopView.super.destroyUI(self)
end

function StagePetShopView:onEnter()
	StagePetShopView.super.onEnter(self)

	self._activityId = PowerLandModel.instance:getCurActivityId()

	local isInTime = ActivityDefineController.instance:isInActivityTimeById(GameEnum.ActivityType.PowerLand, self._activityId)

	if not isInTime then
		FloatWordMgr.instance:show("活动不在开启期限内( activityId = %d )", self._activityId)
		self:close()

		return
	end

	GlobalDispatcher:addListener(GlobalNotify.PowerLandGetInfoRes, self._onUpdate, self)
	GlobalDispatcher:addListener(GlobalNotify.PowerLandRefreshShopRes, self._onUpdate, self)
	GlobalDispatcher:addListener(GlobalNotify.PowerLandStageOverRes, self._handleChallengeRes, self)
	self:_onSetUI()
	self:_onUpdate()
end

function StagePetShopView:onExit()
	StagePetShopView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.PowerLandGetInfoRes, self._onUpdate, self)
	GlobalDispatcher:removeListener(GlobalNotify.PowerLandRefreshShopRes, self._onUpdate, self)
	GlobalDispatcher:removeListener(GlobalNotify.PowerLandStageOverRes, self._handleChallengeRes, self)
	self._itemScrollList:dispose()
	MaterialMgr.resetAll(self._goldItemCon)
	MaterialMgr.resetAll(self._costItem)
end

function StagePetShopView:_onSetUI()
	local itemStr = PowerLandConfig.instance:getPlShowItem()

	if self._goldItemCon and not string.nilorempty(itemStr) then
		local arr = string.split(itemStr, ":")

		MaterialMgr.setIcon(self._goldItemCon, arr[1], arr[2])
	end

	if self._costItem and not string.nilorempty(itemStr) then
		local arr = string.split(itemStr, ":")

		MaterialMgr.setIcon(self._costItem, arr[1], arr[2])
	end

	self._txtCostNum.text = PowerLandConfig.instance:getPlRefreshShopCost()
end

function StagePetShopView:_onUpdate()
	self:_onUpdateData()
	self:_onUpdateUI()
end

function StagePetShopView:_onUpdateData()
	return
end

function StagePetShopView:_onUpdateUI()
	self:_onUpdatePlaneUI()
	self:_onUpdateItemScrollerList()
end

function StagePetShopView:_onUpdatePlaneUI()
	self._txtGoldNum.text = PowerLandModel.instance:getScore()
end

function StagePetShopView:_onUpdateItemScrollerList()
	local dataList = {}
	local petIds = PowerLandModel.instance:getStageShopPetIds()

	for _, petId in ipairs(petIds) do
		local data = PowerLandConfig.instance:getPlPetDataByActId(self._activityId, petId)

		table.insert(dataList, data)
	end

	self._itemScrollList:reloadData(dataList)
end

function StagePetShopView:_updateItemCell(view, cell, data, tag)
	local mainGo = cell.gameObject
	local pet = goutil.findChild(mainGo, "pet")
	local con = goutil.findChild(mainGo, "pet/mask/con")
	local txtCostCount = goutil.findChildTextComponent(mainGo, "txtCostCount")
	local txtPetName = goutil.findChildTextComponent(mainGo, "txtPetName")
	local targetCol = goutil.findChild(mainGo, "targetCol")
	local itemCost = goutil.findChild(mainGo, "txtCostCount/itemCost")
	local saleOut = goutil.findChild(mainGo, "saleOut")
	local petMo = PowerLandModel.instance:getPetMo(data.creepsId)

	txtPetName.text = MaterialMgr.getMaterialsName(MatType.PET_SKIN, petMo.curFaceId)

	local modelCo = CharacterConfig.instance:getModelCo(petMo.curFaceId)

	uGuiUtil.setSpriteToImage(con, uGuiUtil.SpriteType.BigBg, GameUrl.getCharacterIconUrl(modelCo.headName))

	local itemStr = PowerLandConfig.instance:getPlShowItem()

	if itemCost and not string.nilorempty(itemStr) then
		local arr = string.split(itemStr, ":")

		MaterialMgr.setIcon(itemCost, arr[1], arr[2])
	end

	txtCostCount.text = data.cost

	for i = 1, targetCol.transform.childCount do
		local trans = targetCol.transform:GetChild(i - 1)

		GameUtil.SetActive(trans.gameObject, i <= #data.targetIds)
	end

	for idx, targetId in ipairs(data.targetIds) do
		local targetIcon = goutil.findChild(targetCol, string.format("target_%s/icon", idx))
		local targetData
		local fmtTargetInfo = PowerLandModel.instance:getFmtTargetInfo()
		local level = fmtTargetInfo:getTargetLevel(targetId)
		local targetData = PowerLandConfig.instance:getRealPlTargetData(targetId, level)

		if targetIcon then
			local path = targetData.iconPath
			local bgGo = targetIcon

			if not string.nilorempty(path) and bgGo then
				local spriteType = uGuiUtil.SpriteType.BigBg
				local spriteName = string.format("ui/icon/expevents/%s.png", path)

				local function func()
					return
				end

				uGuiUtil.setSpriteToImage(bgGo, spriteType, spriteName, func)
			end
		else
			printError(string.format("助战精灵id%d,对应印记的预制无法寻到.( idx=%d )", data.creepsId, idx))
		end
	end

	local isHasBuy = PowerLandModel.instance:isStageShopPetHasBuy(data.creepsId)

	GameUtil.SetActive(saleOut, isHasBuy)

	local function clickItemHandler()
		CommonTipsMgr.instance:showMaxLvlPetTips(data.raceId, data.lv, data.awakenLv, data.faceId)
	end

	GameUtil.addClickHandler(pet, clickItemHandler)

	local handler

	GameUtil.addClickHandler(mainGo, isHasBuy and function()
		FloatWordMgr.instance:show("该精灵已购买")
	end or GameUtil.handler(self._onClickItemCell, self, mainGo, data, petMo))
end

function StagePetShopView:_clearItemCell(cell)
	local mainGo = cell.gameObject
	local pet = goutil.findChild(mainGo, "pet")
	local con = goutil.findChild(mainGo, "pet/mask/con")
	local itemCost = goutil.findChild(mainGo, "txtCostCount/itemCost")

	uGuiUtil.clearImage(con)
	MaterialMgr.clearIcon(itemCost)
	GameUtil.rmClickHandler(mainGo)
	GameUtil.rmClickHandler(pet)
end

function StagePetShopView:_onClickItemCell(mainGo, data, petMo)
	local matType, matId = MaterialMgr.getMatParams(PowerLandConfig.instance:getPlShowItem())
	local matNum = data.cost
	local txtTarget = string.format("<quad name=%s:%s|icon size=75 width=1 offsetY=-20/>", MatType.Pet, petMo.curFaceId)
	local txtCost = string.format("<quad name=%s:%s|icon size=40 width=1 offsetY=-8/>", matType, matId)
	local content = string.format("兑换%s需要消耗%sx%d", txtTarget, txtCost, matNum)

	local function successCallBack()
		self._opType = 1

		local activityId = self._activityId
		local selectPetId = data.creepsId
		local simpleForm

		PowerLandController.instance:onSendPowerLandChallengeReq(activityId, selectPetId, simpleForm)
	end

	local alignment = UnityEngine.TextAnchor.MiddleCenter

	TipsFacade.instance:openPopupCostMatViewNew(matType, matId, matNum, content, successCallBack, toggleFunc, togTxt, alignment, otherCallBack, autoOpenSource)
end

function StagePetShopView:_onClickBtnNext()
	local tipsContent = "离开商店后将无法返回，是否确认离开？"

	local function okFunc()
		self._opType = 2

		local activityId = self._activityId
		local selectPetId = -1
		local simpleForm

		PowerLandController.instance:onSendPowerLandChallengeReq(activityId, selectPetId, simpleForm)
	end

	local function cencelFunc()
		return
	end

	TipsFacade.instance:openPopupWindow("提示", tipsContent, okFunc, cencelFunc, "确定", "取消")
end

function StagePetShopView:_handleChallengeRes()
	if self._opType == 1 then
		FloatWordMgr.instance:show("购买精灵成功")
		self:_onUpdate()
	elseif self._opType == 2 then
		self:close()
	end
end

function StagePetShopView:_onClickBtnChange()
	local score = PowerLandModel.instance:getScore()
	local refreshShopCost = PowerLandConfig.instance:getPlRefreshShopCost()

	if refreshShopCost <= score then
		PowerLandController.instance:onSendPowerLandRefreshShopReq(self._activityId)
	else
		local matType, matId = MaterialMgr.getMatParams(PowerLandConfig.instance:getPlShowItem())
		local matName = MaterialMgr.getMaterialsName(matType, matId)

		FloatWordMgr.instance:show(string.format("%s数量不足", matName))
	end
end

function StagePetShopView:_onClickBtnTarget()
	UIStateManager.instance:push(ViewName.TargetDetailsView)
end

function StagePetShopView:_onClickBtnPet()
	UIStateManager.instance:push(ViewName.PetTargetShowView)
end

return StagePetShopView
