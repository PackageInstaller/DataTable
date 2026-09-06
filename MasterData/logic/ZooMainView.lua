-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/zoo/view/ZooMainView.lua

module("logic.extensions.zoo.view.ZooMainView", package.seeall)

local ZooMainView = class("ZooMainView", ViewComponent)
local opButtonsLocalPos = {
	[2] = {
		{
			-9.5,
			-37.5
		},
		{
			232,
			-37.5
		}
	},
	[3] = {
		{
			-9.5,
			-37.5
		},
		{
			120,
			-80
		},
		{
			232,
			-37.5
		}
	},
	[4] = {
		{
			-9.5,
			-37.5
		},
		{
			60,
			-70
		},
		{
			160,
			-72
		},
		{
			232,
			-37.5
		}
	}
}

function ZooMainView:buildUI()
	ZooMainView.super.buildUI(self)

	self._closeBtn = self:getBtn("closeBtn")
	self._tipBtn = self:getBtn("txtTitle/tipBtn")
	self._rightBtnsGo = self:getGo("rightBtns")
	self._otherBtnsGo = self:getGo("otherBtns")
	self._handleBookBtn = self:getBtn("rightBtns/handlebook")
	self._placeBtn = self:getBtn("rightBtns/place")
	self._shopBtn = self:getBtn("rightBtns/shop")
	self._logBtn = self:getBtn("rightBtns/log")
	self._warehouseBtn = self:getBtn("rightBtns/warehouse")
	self._homeBtn = self:getBtn("otherBtns/home")
	self._chatBtn = self:getBtn("Nego_Chat")
	self._friendBtn = self:getBtn("Nego_Chat/Btn_Friend")
	self._friendBtnRed = self:getGo("Nego_Chat/Btn_Friend/imgPoint")
	self._pairBtn = self:getBtn("pairBtn")
	self._friendZooNameBg = self:getGo("friendZooName")
	self._friendZooName = self:getTxt("friendZooName/Text")

	self:_initBuildingOpBtns()
	self:_initRightTop()
end

function ZooMainView:_initRightTop()
	self._rightTop = self:getGo("rightTopBtn")
	self._loveIcon = self:getGo("rightTopBtn/loveNum/")
	self._loveNum = self:getTxt("rightTopBtn/loveNum/Text")
	self._quickCardIcon = self:getGo("rightTopBtn/quickCard")
	self._quickCard = self:getTxt("rightTopBtn/quickCard/Text")
end

function ZooMainView:_initBuildingOpBtns()
	self._buildingOpBtnsNode = self:getGo("buildingOpBtns")
	self._buildingOpBtns = {}

	for i = 1, 4 do
		local btnConfig = {}

		btnConfig.button = Framework.ButtonAdapter.GetFrom(self._buildingOpBtnsNode, "Btn" .. i)
		btnConfig.btnText = goutil.findChildTextComponent(btnConfig.button.gameObject, "Text")
		btnConfig.gameObject = btnConfig.button.gameObject
		self._buildingOpBtns[i] = btnConfig
	end

	self._opBuildingName = self:getTxt("buildingOpBtns/buildingName")

	self._buildingOpBtnsNode:SetActive(false)
end

function ZooMainView:bindEvents()
	ZooMainView.super.bindEvents(self)
	self._closeBtn:AddClickListener(self._onClickClose, self)
	self._tipBtn:AddClickListener(self._onClickTip, self)
	self._handleBookBtn:AddClickListener(self._onClickHandleBook, self)
	self._placeBtn:AddClickListener(self._onClickPlaceBtn, self)
	self._shopBtn:AddClickListener(self._onClickShop, self)
	self._logBtn:AddClickListener(self._onClickLog, self)
	self._warehouseBtn:AddClickListener(self._onClickWarehouseBtn, self)
	self._homeBtn:AddClickListener(self._onClickHome, self)
	self._chatBtn:AddClickListener(self._onClickChat, self)
	self._friendBtn:AddClickListener(self._onClickFriend, self)
	self._pairBtn:AddClickListener(self._onClickPair, self)

	for i = 1, #self._buildingOpBtns do
		self._buildingOpBtns[i].button:AddClickListener(function()
			self:_onBuildingOption(i)
		end)
	end
end

function ZooMainView:unbindEvents()
	ZooMainView.super.unbindEvents(self)
	self._closeBtn:RemoveClickListener()
	self._tipBtn:RemoveClickListener()
	self._handleBookBtn:RemoveClickListener()
	self._placeBtn:RemoveClickListener()
	self._shopBtn:RemoveClickListener()
	self._logBtn:RemoveClickListener()
	self._warehouseBtn:RemoveClickListener()
	self._homeBtn:RemoveClickListener()
	self._chatBtn:RemoveClickListener()
	self._friendBtn:RemoveClickListener()
	self._pairBtn:RemoveClickListener()

	for i = 1, #self._buildingOpBtns do
		self._buildingOpBtns[i].button:RemoveClickListener()
	end
end

function ZooMainView:onEnter()
	ZooMainView.super.onEnter(self)
	math.randomseed(os.time())
	GlobalDispatcher:addListener(GlobalNotify.MainPlayerPos, self._playerMove, self)
	RedPointController.instance:regRedPoint(self._pairBtn.gameObject, RedPointModel.ID_ZOO_PAIR)
	RedPointController.instance:regRedPoint(self._friendBtnRed, RedPointModel.ID_FRIEND)

	local proxy = MaterialMgr.setCellByCfg(ZooConfig.instance:getZooParamsByKey("ZOO_FRUIT_ITEM"), self._loveIcon)

	proxy.binder:setNum(0)
	Framework.TransformUtil.SetLocalScale(proxy.view.transform, 0.5, 0.5, 1)
	self:_onZooChanged()
	GlobalDispatcher:addListener(GlobalNotify.OnZooChange, self._onZooChanged, self)
	GlobalDispatcher:addListener(GlobalNotify.OnStealFriendFruits, self._updateFruitNum, self)
	GlobalDispatcher:addListener(GlobalNotify.OnZooGainFriuts, self._updateFruitNum, self)
	GlobalDispatcher:addListener(GlobalNotify.OnZooHandleLostAnimal, self._handleLostAnimal, self)
	GlobalDispatcher:addListener(GlobalNotify.OnSelectZooBuilding, self._onSelectZooBuilding, self)
end

function ZooMainView:onEnterFinished()
	ZooMainView.super.onEnterFinished(self)
end

function ZooMainView:onExit()
	ZooMainView.super.onExit(self)
	RedPointController.instance:unregRedPoint(self._pairBtn.gameObject)
	RedPointController.instance:unregRedPoint(self._friendBtnRed)
	GlobalDispatcher:removeListener(GlobalNotify.OnZooChange, self._onZooChanged, self)
	GlobalDispatcher:removeListener(GlobalNotify.OnSelectZooBuilding, self._onSelectZooBuilding, self)
	GlobalDispatcher:removeListener(GlobalNotify.MainPlayerPos, self._playerMove, self)
	GlobalDispatcher:removeListener(GlobalNotify.OnStealFriendFruits, self._updateFruitNum, self)
	GlobalDispatcher:removeListener(GlobalNotify.OnZooGainFriuts, self._updateFruitNum, self)
	GlobalDispatcher:removeListener(GlobalNotify.OnZooHandleLostAnimal, self._handleLostAnimal, self)
	self:_clearSelectBuilding()
	MaterialMgr.resetAll(self._quickCardIcon)
	MaterialMgr.resetAll(self._loveIcon)
end

function ZooMainView:onExitFinished()
	ZooMainView.super.onExitFinished(self)
	UIStateManager.instance:popByName(ViewName.ZooDigView)
end

function ZooMainView:_onZooChanged()
	self._currZoo = ZooModel.instance:getCurrZoo()

	local isMyZoo = self._currZoo:isMyZoo()

	GameUtil.SetActive(self._rightTop, isMyZoo)
	GameUtil.SetActive(self._rightBtnsGo, isMyZoo)
	GameUtil.SetActive(self._otherBtnsGo, not isMyZoo)
	goutil.setActive(self._friendZooNameBg, not isMyZoo)

	if not isMyZoo then
		local friendMo = FriendModel.instance:getFriendMo(self._currZoo:getZooUserId())

		self._friendZooName.text = string.format("%s的宠物园", friendMo:getValue("name"))
	else
		self._loveNum.text = MaterialMgr.getMatCount(ZooConfig.instance:getZooParamsByKey("ZOO_FRUIT_ITEM"))
	end
end

function ZooMainView:_updateFruitNum()
	self._loveNum.text = MaterialMgr.getMatCount(ZooConfig.instance:getZooParamsByKey("ZOO_FRUIT_ITEM"))
end

function ZooMainView:_handleLostAnimal()
	self._loveNum.text = MaterialMgr.getMatCount(ZooConfig.instance:getZooParamsByKey("ZOO_FRUIT_ITEM"))
end

function ZooMainView:_playerMove(x, y)
	self:_clearSelectBuilding()
end

function ZooMainView:_onClickTip()
	TipsFacade.instance:openRulesView("zoorule")
end

function ZooMainView:_onClickHandleBook()
	UIStateManager.instance:push(ViewName.ZoogeneatlasView)
end

function ZooMainView:_onClickPlaceBtn()
	UIStateManager.instance:push(ViewName.ZooplaceView)
end

function ZooMainView:_onClickShop()
	ViewMgr.instance:open(ViewName.ZooShopView)
end

function ZooMainView:_onClickLog()
	UIStateManager.instance:push(ViewName.ZooLogView)
end

function ZooMainView:_onClickWarehouseBtn()
	UIStateManager.instance:push(ViewName.ZoowarehouseView)
end

function ZooMainView:_onClickHome()
	UIStateManager.instance:popByName(ViewName.ZooDigView)
	ZooSceneController.instance:enterMyZoo()
end

function ZooMainView:_onClickChat()
	UIStateManager.instance:open(ViewName.chat)
end

function ZooMainView:_onClickFriend()
	FuncOpenController.instance:openFunc(22)
end

function ZooMainView:_onClickClose()
	ZooSceneController.instance:leaveZooScene()
end

function ZooMainView:_onSelectZooBuilding(buildingMO)
	local buildingOpTypes = buildingMO:getBuildingOpTypes()

	self:_showBuildingOpBtns(buildingOpTypes)

	self._opBuildingName.text = buildingMO:getBuildingName()
end

function ZooMainView:_showBuildingOpBtns(buildingOpTypes)
	self._buildingOpTypes = buildingOpTypes

	if not self._buildingOpTypes or #self._buildingOpTypes == 0 then
		self._buildingOpBtnsNode:SetActive(false)

		return
	end

	local positions = opButtonsLocalPos[#self._buildingOpTypes]

	self._buildingOpBtnsNode:SetActive(true)
	self:_setupBtnsFollowTargets()

	for i = 1, #self._buildingOpTypes do
		local opConfig = self._buildingOpBtns[i]

		opConfig.gameObject:SetActive(true)

		opConfig.btnText.text = lang(ZooBuildingOpName[self._buildingOpTypes[i]])

		Framework.TransformUtil.SetLocalPos(opConfig.gameObject.transform, positions[i][1], positions[i][2], 0)
	end

	for i = #self._buildingOpTypes + 1, #self._buildingOpBtns do
		local opConfig = self._buildingOpBtns[i]

		opConfig.gameObject:SetActive(false)
	end
end

function ZooMainView:_setupBtnsFollowTargets()
	local followCom = self._buildingOpBtnsNode:GetComponent(ComponentType.UIFollowTarget)

	if not followCom then
		followCom = self._buildingOpBtnsNode:AddComponent(ComponentType.UIFollowTarget)

		local mainCamera = CameraTargetMgr.instance:getMainCameraTarget()

		followCom.uiCamera = GlobalModel.instance.uiCamera
		followCom.gameCamera = mainCamera:getCamera()
		followCom.canvas = UGUIToolHelper.FindCanvas(self._buildingOpBtnsNode)
	end

	local selectBuildingMo = ZooSceneController.instance:getSelectBuilding()
	local offset = selectBuildingMo:getBuildingOpTypesOffset()
	local scene = SceneMgr.instance:getCurScene()
	local unit = scene.unitFactory:getUnit(UnitTag.SceneElement, selectBuildingMo:getBuildingId())

	followCom.target = unit.go.transform
	followCom.enabled = true
	followCom.offsetX3D = offset[1]
	followCom.offsetY3D = offset[2]

	followCom:LateUpdate()
end

function ZooMainView:_onBuildingOption(idx)
	self._buildingOpBtnsNode:SetActive(false)

	if not self._buildingOpTypes then
		return
	end

	local opType = self._buildingOpTypes[idx]

	if not opType then
		return
	end

	local selectBuildingMo = ZooSceneController.instance:getSelectBuilding()

	if not selectBuildingMo then
		return
	end

	selectBuildingMo:onBuildingOpType(opType)
	self:_clearSelectBuilding()
end

function ZooMainView:_clearSelectBuilding()
	self._buildingOpBtnsNode:SetActive(false)

	self._buildingOpTypes = nil

	ZooSceneController.instance:setSelectBuilding(mo)
end

function ZooMainView:_onClickPair()
	UIStateManager.instance:push(ViewName.ZoonewsView)
end

return ZooMainView
