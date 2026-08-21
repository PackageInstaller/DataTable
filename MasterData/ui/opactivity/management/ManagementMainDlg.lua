-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\OpActivity\\Management\\ManagementMainDlg.lua

local ResBusinessToyConfig = require("ClientData/ResBusinessToyConfig")
local ResColor = require("ClientData/ResColor")
local ResClientNotice = require("ClientData/ResClientNotice")
local DeviceHelper = require("Helper/DeviceHelper")
local ActivityPanelMixin = require("UI/OpActivity/ActivityPanelMixin")
local ActivityDataManagement = require("Avatar/AvatarMixins/OpActivity/ActivityDataManagement")
local ManagementToyCell = require("UI/OpActivity/Management/ManagementToyCell")
local FlyIconUtils = require("UI/Common/FlyIconUtils")
local Screen = UnityEngine.Screen
local Vector3 = Vector3
local EventConst = require("EventConst")
local OprateState = {
	Delete = 3,
	Improve = 2,
	Normal = 1
}
local ToyCell = Class("ManagementMainDlg_ToyCell", UIControls.Child)

function ToyCell:ctor()
	self.panel = UIControls.Panel(self, "")

	local size = self.panel:getRectSize()

	self.halfWidth = size.width * 0.5
	self.halfHeight = size.height * 0.5
	self.transform = self.panel:getGameObject().transform
	self.dragPanel = UIControls.DragClickPanel(self, "")
	self.slotOnDrag = Slot(self.onDrag, self)
	self.slotOnDragBegin = Slot(self.onDragBegin, self)
	self.slotOnDragEnd = Slot(self.onDragEnd, self)
	self.slotOnClick = Slot(self.onClickBtn, self)

	self.dragPanel:setClickFunc(self.slotOnClick)
	self.dragPanel:setDragFunc(self.slotOnDrag)
	self.dragPanel:setDragBeginFunc(self.slotOnDragBegin)
	self.dragPanel:setDragEndFunc(self.slotOnDragEnd)

	self.raycast = UIControls.Panel(self, "raycast")

	self:setDragEnable(true)

	self.panelNml = UIControls.Panel(self, "NormalPanel")
	self.imgToy = UIControls.Image(self, "ImgToy")
	self.lvBgPanel = UIControls.Panel(self, "NormalPanel/Bg")

	self.lvBgPanel:setVisible(false)

	self.txtLv = UIControls.Label(self, "NormalPanel/Bg/TextLv")
	self.panelCanMergeNotice = UIControls.Panel(self, "CombinePanel")
	self.panelMergeNotice = UIControls.Panel(self, "NormalPanel/Efx")
	self.selectPanel = UIControls.Panel(self, "NormalPanel/ImgSel")
	self.lvUpPanel = UIControls.Panel(self, "NormalPanel/IconLvUp")
	self.lvLimitPanel = UIControls.Panel(self, "NormalPanel/IconLvLimit")
	self.lockPanel = UIControls.Panel(self, "ImgUnlock")
	self.deletePanel = UIControls.Panel(self, "ImgDelete")
	self.oprateState = OprateState.Normal
	self.slotPlayAnimCb = self.slotPlayAnimCb or Slot(self.playAnimCb, self)
end

function ToyCell:init(index, clickAction, dragBeginAction, dragAction, dragEndAction, parentPanelTransform, parentPos, moveBeginCb, moveEndCb)
	self.index = index
	self.clickAction = clickAction
	self.dragBeginAction = dragBeginAction
	self.dragAction = dragAction
	self.dragEndAction = dragEndAction
	self.moveBeginCb = moveBeginCb
	self.moveEndCb = moveEndCb
	self.startX = parentPos.x
	self.startY = parentPos.y
	self.minPosX = parentPos.x - self.halfWidth
	self.maxPosX = parentPos.x + self.halfWidth
	self.minPosY = parentPos.y - self.halfHeight
	self.maxPosY = parentPos.y + self.halfHeight
	self.parentPanelTransform = parentPanelTransform
end

function ToyCell:setData(data, isOpen, actObj, endCb)
	self.isOpen = isOpen
	self.data = data
	self.actObj = actObj
	self.actData = self.actObj.actData
	self.toyId = nil
	self.toyQuality = nil
	self.toyItemId = nil
	self.toyItem = nil
	self.maxQuality = nil
	self.checkMax = false
	self.checkUnlockMax = false

	self.lockPanel:setVisible(not isOpen)
	self.imgToy:setVisible(isOpen and data ~= nil)
	self.panelNml:setVisible(isOpen and data ~= nil)

	if isOpen and data then
		self.toyId = self.data.id
		self.toyQuality = self.data.quality
		self.toyItemId = self.data.item_id
		self.maxQuality = #ResBusinessToyConfig[self.actData.actId][self.toyId]
		self.checkMax = self.toyQuality >= self.maxQuality
		self.toyItem = BaseObject.GetObject(self.toyItemId, 1)

		local path = self.toyItem:getIconPath()

		if path then
			self.imgToy:setImage(path[1], path[2])
		end

		local str

		if self.checkMax then
			str = self.actData.miscData.str_lv_max
		else
			str = string.format(self.actData.miscData.str_lv_format, self.toyQuality)
		end

		self.txtLv:setText(str)
		self:refreshImprove()
	end

	self:playAni("ShowGoods", endCb)
end

function ToyCell:setOpenState(isOpen)
	self.isOpen = isOpen

	self.lockPanel:setVisible(not isOpen)
end

function ToyCell:checkCanDrag()
	if self.data and self.oprateState == OprateState.Normal then
		return true
	else
		return false
	end
end

function ToyCell:onDragBegin(delta)
	if not self:checkCanDrag() then
		return
	end

	self.dragBeginAction(self)
end

function ToyCell:onDrag(delta)
	if not self:checkCanDrag() then
		return
	end

	local pos = self.panel:getPosition()
	local screenW = DeviceHelper.curWidth
	local screenH = DeviceHelper.curHeight
	local designW = 1920
	local designH = 1080
	local designRatio = designW / designH
	local screenRatio = screenW / screenH

	if designRatio < screenRatio then
		designW = screenRatio * designH
	else
		designH = designW / screenRatio
	end

	local newX = pos.x + delta.x * Screen.currentResolution.width / screenW * designW
	local newY = pos.y + delta.y * Screen.currentResolution.height / screenH * designH

	self.panel:setPosition(newX, newY)
	self.dragAction(newX, newY, self)
end

function ToyCell:onDragEnd(delta)
	if not self:checkCanDrag() then
		return
	end

	self.transform:SetParent(self.parentPanelTransform, false)
	self.panel:setPosition(0, 0)
	self.dragEndAction(self)
end

function ToyCell:showCanMergeEffect(value)
	self.panelCanMergeNotice:setVisible(value)
end

function ToyCell:showMergeEffect(value)
	self.panelMergeNotice:setVisible(value)
end

function ToyCell:setDragEnable(value)
	self.raycast:setVisible(value)
end

function ToyCell:refreshImprove()
	if not self.data or self.oprateState ~= OprateState.Improve then
		return
	end

	self.lvBgPanel:setVisible(true)

	local unlockQuality = self.actData.unlockToyQuality

	self.checkUnlockMax = not self.checkMax and unlockQuality <= self.toyQuality

	self.lvLimitPanel:setVisible(self.checkUnlockMax)
	self.lvUpPanel:setVisible(not self.checkMax and not self.checkUnlockMax)
end

function ToyCell:enterImprove()
	self.oprateState = OprateState.Improve

	self:refreshImprove()
end

function ToyCell:exitImprove()
	self.oprateState = OprateState.Normal

	self.selectPanel:setVisible(false)
	self.lvUpPanel:setVisible(false)
	self.lvLimitPanel:setVisible(false)
	self.lvBgPanel:setVisible(false)
	BeginnerManager.CheckManagementCanCommitOrder()
end

function ToyCell:refreshDelete()
	if not self.data or self.oprateState ~= OprateState.Delete then
		return
	end

	self.deletePanel:setVisible(true)
end

function ToyCell:enterDelete()
	self.oprateState = OprateState.Delete

	self:refreshDelete()
end

function ToyCell:exitDelete()
	self.oprateState = OprateState.Normal

	self.deletePanel:setVisible(false)
end

function ToyCell:setSelect(value)
	self.selectPanel:setVisible(value)
end

function ToyCell:onClickBtn()
	if not self.data then
		return
	end

	if self.oprateState == OprateState.Improve then
		self.clickAction(self)
	elseif self.oprateState == OprateState.Delete then
		self.slotSendDeleteRPC = self.slotSendDeleteRPC or Slot(self.sendDeleteRPC, self)

		local strTitle = ResClientNotice[704].notice
		local deleteExp = self.actData:getToyDeleteExpByQuality(self.toyQuality)
		local strContent = utils.format(ResClientNotice[705].notice, self.data.quality, self.toyItem.name, deleteExp)

		UIManager.showConfirm(UIConst.CONFIRM_TWOBTN, strTitle, strContent, self.slotSendDeleteRPC)
	end
end

function ToyCell:sendDeleteRPC()
	RPC.opActBusinessMaterialDelete(self.actObj.opId, self.index)
end

function ToyCell:playUpgradeAnim(endCb)
	self.animEndCb = endCb

	self.moveBeginCb(self)
	self:playAni("CombineGoods", self.slotPlayAnimCb, true)
end

function ToyCell:playCostAnimcallback(endCb)
	self.animEndCb = endCb

	self.moveBeginCb(self)
	self:playAni("DeliveryGoods", self.slotPlayAnimCb, true)
end

function ToyCell:playMoveAnim(movePos)
	self.animEndCb = nil

	self.moveBeginCb(self)
	self:playAni("Move" .. movePos, self.slotPlayAnimCb, true)
end

function ToyCell:playAnimCb()
	if self.animEndCb then
		self.animEndCb()

		self.animEndCb = nil
	end

	self.moveEndCb(self)
end

local OrderCell = Class("ManagementMainDlg_OrderCell", UIControls.Child)

function OrderCell:ctor()
	self.imgBg = UIControls.Image(self, "")
	self.txtTitle = UIControls.Label(self, "TextTitle")
	self.imgExp = UIControls.Image(self, "AwardPanel/ImgEXP")
	self.txtExp = UIControls.Label(self, "AwardPanel/ImgEXP/Text")
	self.imgExp2 = UIControls.Image(self, "AwardPanel/ImgAward")
	self.txtExp2 = UIControls.Label(self, "AwardPanel/ImgAward/Text")
	self.btnRefresh = UIControls.Button(self, "BtnRefresh")

	self.btnRefresh:addEventClick(self.onClickBtnRefresh)

	self.canOnlyRefreshEffect = UIControls.Panel(self, "BtnRefresh/Efx")
	self.commitPanel = UIControls.Panel(self, "DeliverPanel")
	self.btnCommit = UIControls.Button(self, "DeliverPanel/BtnDeliver")

	self.btnCommit:addEventClick(self.onClickBtnCommit)

	self.refreshEffect = UIControls.LazyEffectPlayer(self, "ToyNeedPanel/Efx")
	self.anim = UIControls.UIAni(self, "")
	self.toyCellList = {}
	self.slotOnClickToyCell = Slot(self.onClickToyCell, self)
end

function OrderCell:init(clickCb)
	self.clickCb = clickCb
end

function OrderCell:setData(data, actObj)
	self.data = data
	self.actObj = actObj
	self.actData = self.actObj.actData

	self:refresh()
end

function OrderCell:refresh()
	local quality = self.data.quality
	local itemId = self.actData.orderItemList[quality]
	local fakeItem = BaseObject.GetObject(itemId)

	self.txtTitle:setText(fakeItem.name)
	self.imgBg:setImage("Atlas/ActivityAtlas/ActivityManagement1/ActivityManagement1", "BgOrders0" .. quality)
	self.imgExp:setImage("Atlas/" .. self.actData.miscData.exp_altas, self.actData.miscData.exp_icon)

	local exp, exp2 = self.actData:getOrderExpByQuality(quality)

	self.txtExp:setText(exp)

	local checkShowExp2 = exp2 and exp2 > 0

	self.imgExp2:setVisible(checkShowExp2)

	if checkShowExp2 then
		self.imgExp2:setImage("Atlas/" .. self.actData.miscData.exp_altas2, self.actData.miscData.exp_icon2)
		self.txtExp2:setText(exp2)
	end

	self:refreshMaterialList()

	self.checkCanCommit, self.commitToyPosList = self.actObj.actData:checkOrderCanCommit(self.data)

	self.btnRefresh:setVisible(self.data.refresh == 0)
	self.canOnlyRefreshEffect:setVisible(self.data.refresh == 0 and self.actData:checkCanOnlyRefreshOrder())
	self.commitPanel:setVisible(self.checkCanCommit)
	self.anim:clearEventFinish()
	self.anim:startAni("ShowOrder")
end

function OrderCell:refreshMaterialList()
	local cellList = self.toyCellList
	local dataList = self.data.requireToyList
	local dataNum = #dataList
	local cellNum = #cellList

	for i = 1, dataNum do
		local cell

		if i <= cellNum then
			cell = cellList[i]
		else
			cell = ManagementToyCell(self, "ToyNeedPanel/Content", "System/Activity/ActivityManagement1/ToyNeedCell")

			cell:init(true, nil, self.slotOnClickToyCell)
			table.insert(cellList, cell)
		end

		cell:setVisible(true)

		local data = dataList[i]
		local toyConfig = data.toyConfig
		local itemId = toyConfig.item_id
		local toyNum = self.actData:getToyNum(itemId)

		if toyNum > data.num then
			toyNum = data.num
		end

		local str = toyNum .. "/" .. data.num

		cell:setData(self.actData.actId, toyConfig.id, toyConfig.quality, str)
		cell:setTxtNumColor(toyNum >= data.num and ResColor.QUALITYYELLOW or ResColor.WHITE)
	end

	if dataNum < cellNum then
		for i = dataNum + 1, cellNum do
			cellList[i]:setVisible(false)
		end
	end
end

function OrderCell:playRefreshEffect()
	self.refreshEffect:playEffect()
end

function OrderCell:playCommitAnim(callBack)
	self.anim:clearEventFinish()
	self.anim:addEventFinish(callBack)
	self.anim:startAni("OrderDelivery")
end

function OrderCell:onClickBtnCommit()
	if self.clickCb then
		self.clickCb(self)
	end
end

function OrderCell:onClickBtnRefresh()
	RPC.opActBusinessOrderUpdate(self.actObj.opId, self.data.gid)
end

function OrderCell:onClickToyCell(toyCell)
	local ui = UIManager.getUI("managementToyInfoDlg", true)

	if ui then
		ui:setData(self.actData.actId, toyCell.type, toyCell.quality, self.actData.unlockToyQuality)
	end
end

local StorehouseCell = Class("ManagementMainDlg_StorehouseCell", UIControls.Child)

function StorehouseCell:ctor()
	self.imgBg = UIControls.Image(self, "")
	self.txtName = UIControls.Label(self, "TextTitle")
	self.imgExp = UIControls.Image(self, "TextAward/AwardPanel1/Icon")
	self.txtExp = UIControls.Label(self, "TextAward/AwardPanel1/Text")
	self.exp2Panel = UIControls.Panel(self, "TextAward/AwardPanel2")
	self.imgExp2 = UIControls.Image(self, "TextAward/AwardPanel2/Icon")
	self.txtExp2 = UIControls.Label(self, "TextAward/AwardPanel2/Text")
	self.btn = UIControls.Button(self, "BtnReceive")

	self.btn:addEventClick(self.onClickBtn, 0.5)

	self.itemGrid = UIControls.ItemGridChild(self, "GridPanel", "System/Common/Grid/GridMaterialItem", 0, 0, true)
	self.itemGrid.mDisableWays = true
	self.imgDisable = UIControls.Image(self, "ImgDisable")
end

function StorehouseCell:setData(itemId, quality, checkFull, actObj)
	self.actObj = actObj
	self.actData = self.actObj.actData
	self.itemId = itemId
	self.checkFull = checkFull

	self.imgExp:setImage("Atlas/" .. self.actData.miscData.exp_altas, self.actData.miscData.exp_icon)

	self.num = CurAvatar:getItemNumById(itemId)

	self.imgDisable:setVisible(self.num == 0)

	local fakeItem = BaseObject.GetObject(itemId, self.num)

	self.imgBg:setImage("Atlas/ActivityAtlas/ActivityManagement1/ActivityManagement1", "BgTask0" .. quality)
	self.itemGrid:setObj(fakeItem)
	self.txtName:setText(fakeItem.name)

	local exp, exp2 = self.actData:getOrderExpByQuality(quality)

	self.txtExp:setText(exp)

	local checkShowExp2 = exp2 and exp2 > 0

	self.exp2Panel:setVisible(checkShowExp2)

	if checkShowExp2 then
		self.imgExp2:setImage("Atlas/" .. self.actData.miscData.exp_altas2, self.actData.miscData.exp_icon2)
		self.txtExp2:setText(exp2)
	end
end

function StorehouseCell:onClickBtn()
	if self.num == 0 then
		MsgManager.clientNotice(695)
	elseif self.checkFull then
		MsgManager.clientNotice(693)
	else
		local checkHaveBetterOrder = false
		local orderItemList = self.actData.orderItemList

		for i = #orderItemList, 1, -1 do
			local tmpId = orderItemList[i]

			if tmpId == self.itemId then
				break
			else
				local tmpNum = CurAvatar:getItemNumById(tmpId)

				if tmpNum > 0 then
					checkHaveBetterOrder = true
				end
			end
		end

		if checkHaveBetterOrder then
			self.slotSendUseItem = self.slotSendUseItem or Slot(self.sendUseItem, self)

			UIManager.showConfirmWithId(1088, self.slotSendUseItem)
		else
			self:sendUseItem()
		end
	end
end

function StorehouseCell:sendUseItem()
	RPC.itemUse({
		{
			data = {
				num = 1,
				id = self.itemId
			}
		}
	})
end

local FriendCell = Class("ManagementMainDlg_FriendCell", UIControls.Child)

function FriendCell:ctor()
	self.txtName = UIControls.Label(self, "TextName")
	self.txtReceiveNum = UIControls.Label(self, "TextCollectNum")
	self.btnReceive = UIControls.Button(self, "BtnCollect")

	self.btnReceive:addEventClick(self.onClickBtnReceive, 1)

	self.btnDonate = UIControls.Button(self, "BtnSend")

	self.btnDonate:addEventClick(self.onClickBtnDonate, 1)

	self.headCell = UIControls.PlayerHeadGridChild(self, "GridPlayerInfo", "System/Common/Grid/GridPlayerCommon")
end

function FriendCell:init(clickDonateAction, clickReceiveAction)
	self.clickDonateAction = clickDonateAction
	self.clickReceiveAction = clickReceiveAction
end

function FriendCell:setData(friendInfo, donateInfo, receiveInfo, actObj)
	self.actObj = actObj
	self.uid = friendInfo.uid

	self.headCell:setPlayer(friendInfo, false, self)
	self.txtName:setText(friendInfo.name)

	local receiveNum = receiveInfo and receiveInfo.receiveNum or 0

	self.txtReceiveNum:setText(string.format(Lang.get(80804), receiveNum))

	self.checkCanDonate = donateInfo == nil

	self.btnDonate:setEnable(self.checkCanDonate)

	self.checkCanReceive = receiveInfo and receiveInfo.checkCanReceive

	self.btnReceive:setEnable(self.checkCanReceive)
end

function FriendCell:onClickBtnReceive()
	if self.actObj:inFreeze() then
		MsgManager.notice(Lang.get(32793))
	elseif self.clickReceiveAction then
		self.clickReceiveAction(self)
	end
end

function FriendCell:onClickBtnDonate()
	if self.actObj:inFreeze() then
		MsgManager.notice(Lang.get(32793))
	elseif self.clickDonateAction then
		self.clickDonateAction(self)
	end
end

local RightState = {
	Friend = 3,
	SaleOrder = 1,
	Storehouse = 2
}
local ManagementMainDlg = Class("ManagementMainDlg", UIControls.Window)

MixinClass(ManagementMainDlg, ActivityPanelMixin)

function ManagementMainDlg:initUI()
	self.actData = self.actObj.actData
	self.miscData = self.actData.miscData
	self.btnClose = UIControls.Button(self, "BtnClose")

	self.btnClose:addEventClick(self.onClickBtnClose)

	self.btnTips = UIControls.Button(self, "BtnTips")

	self.btnTips:addEventClick(self.onClickBtnTips)

	self.btnInfo = UIControls.Button(self, "MainInfoPanel/ProductionPanel/BtnInfo")

	self.btnInfo:addEventClick(self.onClickBtnInfo)

	self.btnStamina = UIControls.Button(self, "MainInfoPanel/ProductionPanel/ControlPanel/EnergySlider/BtnMore")

	self.btnStamina:addEventClick(self.onClickBtnStamina)

	self.btnProduce = UIControls.Button(self, "MainInfoPanel/ProductionPanel/ControlPanel/BtnProduce")

	self.btnProduce:addEventClick(self.onClickBtnProduce, 0.5)

	self.btnMultiCompose = UIControls.Button(self, "MainInfoPanel/ProductionPanel/ControlPanel/BtnCombine")

	self.btnMultiCompose:addEventClick(self.onClickBtnMultiCompose, 0.5)

	self.uiAni = UIControls.UIAni(self, "")
	self.dragToy = UIControls.Panel(self, "MainInfoPanel/ProductionPanel/ToyProducePanel/GoodsPanel/DragToy")
	self.transDragToy = self.dragToy:getGameObject().transform
	self.slotOnClickToyCell = Slot(self.onClickToyCell, self)
	self.slotOnDragBeginToyCell = Slot(self.onDragBeginToyCell, self)
	self.slotOnDragToyCell = Slot(self.onDragToyCell, self)
	self.slotOnDragEndToyCell = Slot(self.onDragEndToyCell, self)
	self.slotOnToyCellMoveBegin = Slot(self.onToyCellMoveBegin, self)
	self.slotOnToyCellMoveEnd = Slot(self.onToyCellMoveEnd, self)
	self.toyCellList = {}

	local firstPosX

	self.stepX = 0

	for i = 1, self.actData.gridNum do
		local curPanel = UIControls.Panel(self, "MainInfoPanel/ProductionPanel/ToyProducePanel/GoodsPanel/GoodsGrid" .. i)
		local animBg = UIControls.UIAni(self, "MainInfoPanel/ProductionPanel/ToyProducePanel/GoodsPanel/GoodsGrid" .. i .. "/ImgNml")
		local pos = curPanel:getPosition()

		if not firstPosX then
			firstPosX = pos.x
		elseif self.stepX == 0 then
			self.stepX = firstPosX - pos.x
		end

		local newCell = ToyCell(self, "MainInfoPanel/ProductionPanel/ToyProducePanel/GoodsPanel/GoodsGrid" .. i, "System/Activity/ActivityManagement1/GridGoods")

		newCell:init(i, self.slotOnClickToyCell, self.slotOnDragBeginToyCell, self.slotOnDragToyCell, self.slotOnDragEndToyCell, curPanel:getGameObject().transform, pos, self.slotOnToyCellMoveBegin, self.slotOnToyCellMoveEnd)
		table.insert(self.toyCellList, newCell)
	end

	self.scrollGoodsPanel = UIControls.Panel(self, "MainInfoPanel/ProductionPanel/ToyProducePanel")
	self.goodsPanel = UIControls.Panel(self, "MainInfoPanel/ProductionPanel/ToyProducePanel/GoodsPanel")
	self.highQualityToyEffectList = {}
	self.conveyerLockPanelList = {}
	self.conveyerLockAniList = {}

	for i = 1, self.actData.gridNum / 5 do
		local highQualityToyEffect = UIControls.LazyEffectPlayer(self, "MainInfoPanel/ProductionPanel/BgPanel/Img" .. i .. "/Efx")

		table.insert(self.highQualityToyEffectList, highQualityToyEffect)

		local ani = UIControls.UIAni(self, "MainInfoPanel/ProductionPanel/ToyProducePanel/GoodsPanel/UnlockPanel" .. i)
		local lockPanel = UIControls.Panel(self, "MainInfoPanel/ProductionPanel/ToyProducePanel/GoodsPanel/UnlockPanel" .. i .. "/ImgUnlock")

		ani:setVisible(true)
		table.insert(self.conveyerLockAniList, ani)
		table.insert(self.conveyerLockPanelList, lockPanel)
	end

	self.txtStoreLv = UIControls.Label(self, "MainInfoPanel/SalesPanel/StoreLvPanel/TextNum")
	self.sliderStore = UIControls.Slider(self, "MainInfoPanel/SalesPanel/StoreLvPanel/EXPSlider")
	self.txtStoreExp = UIControls.Label(self, "MainInfoPanel/SalesPanel/StoreLvPanel/EXPSlider/TextNum")
	self.storeExpEffect = UIControls.LazyEffectPlayer(self, "MainInfoPanel/SalesPanel/StoreLvPanel/EXPSlider/Fill Area/Fill/Efx")
	self.btnStore = UIControls.Button(self, "MainInfoPanel/SalesPanel/StoreLvPanel/BtnStore")

	self.btnStore:addEventClick(self.onClickBtnStore)

	self.bpRed = UIControls.Panel(self, "MainInfoPanel/SalesPanel/StoreLvPanel/IconNew")
	self.sliderLucky = UIControls.Slider(self, "MainInfoPanel/ProductionPanel/ControlPanel/EnergyStoragePanel/EnergySlider")
	self.breakOutPanel = UIControls.Panel(self, "MainInfoPanel/ProductionPanel/ControlPanel/EnergyStoragePanel/StatePanel")
	self.txtMaxLucky = UIControls.Label(self, "MainInfoPanel/ProductionPanel/ControlPanel/EnergyStoragePanel/EnergySlider/Img/BurstNum")
	self.breakOutStatePanelList = {}
	self.breakOutMarkPanelList = {}
	self.breakOutDisPanelList = {}

	for i = 1, 8 do
		local str = "MainInfoPanel/ProductionPanel/ControlPanel/EnergyStoragePanel/StatePanel/StatePanel" .. i

		if UIControls.checkControlFunc(self, str) then
			local statePanel = UIControls.Panel(self, str)
			local markPanel = UIControls.Panel(self, str .. "/ImgNml")
			local disPanel = UIControls.Panel(self, str .. "/ImgDis")

			table.insert(self.breakOutStatePanelList, statePanel)
			table.insert(self.breakOutMarkPanelList, markPanel)
			table.insert(self.breakOutDisPanelList, disPanel)
		end
	end

	self.imgStamina = UIControls.Image(self, "MainInfoPanel/ProductionPanel/ControlPanel/EnergySlider/IconEnergy")
	self.txtStaminaNum = UIControls.Label(self, "MainInfoPanel/ProductionPanel/ControlPanel/EnergySlider/TextNum")
	self.txtStaminaTime = UIControls.Label(self, "MainInfoPanel/ProductionPanel/ControlPanel/EnergySlider/TextRecoveryTime")

	self.txtStaminaTime:setText("")

	self.sliderStamina = UIControls.Slider(self, "MainInfoPanel/ProductionPanel/ControlPanel/EnergySlider")
	self.staminaRecoveryPanel = UIControls.Panel(self, "MainInfoPanel/ProductionPanel/ControlPanel/EnergySlider/ImgRecoveryRate")
	self.txtStaminaRecovery = UIControls.Label(self, "MainInfoPanel/ProductionPanel/ControlPanel/EnergySlider/ImgRecoveryRate/Text")
	self.animStamina = UIControls.UIAni(self, "MainInfoPanel/ProductionPanel/ControlPanel/EnergySlider")
	self.isShowStaminaRecovery = false

	self:refreshStaminaRecoveryPanel()

	self.btnProduceNormalState = UIControls.Panel(self, "MainInfoPanel/ProductionPanel/ControlPanel/BtnProduce/ImgProduce")
	self.btnProduceBreakOutState = UIControls.Panel(self, "MainInfoPanel/ProductionPanel/ControlPanel/BtnProduce/ImgBurstProduce")
	self.btnProduceMultiState = UIControls.Panel(self, "MainInfoPanel/ProductionPanel/ControlPanel/BtnProduce/ImgMassProduce")
	self.imgProductConsumeStamina = UIControls.Image(self, "MainInfoPanel/ProductionPanel/ControlPanel/BtnProduce/Icon")
	self.txtProductConsumeStamina = UIControls.Label(self, "MainInfoPanel/ProductionPanel/ControlPanel/BtnProduce/TextNum")
	self.assignToyTypePanel = UIControls.Panel(self, "MainInfoPanel/ProductionPanel/ControlPanel/BtnProduce/ImgNextProduce")
	self.imgAssignToyType = UIControls.Image(self, "MainInfoPanel/ProductionPanel/ControlPanel/BtnProduce/ImgNextProduce/Icon")
	self.btnMultiComposeOpenState = UIControls.Panel(self, "MainInfoPanel/ProductionPanel/ControlPanel/BtnCombine/ImgUnlock")
	self.btnMultiComposeLockState = UIControls.Panel(self, "MainInfoPanel/ProductionPanel/ControlPanel/BtnCombine/ImgLock")
	self.sssignToyTypeTitlePanel = UIControls.Panel(self, "MainInfoPanel/ProductionPanel/ControlPanel/BtnChoose/ImgTitle")
	self.txtAssignToyTypeNum = UIControls.Label(self, "MainInfoPanel/ProductionPanel/ControlPanel/BtnChoose/ImgTitle/TextNum")
	self.assignToyTypeLockPanel = UIControls.Panel(self, "MainInfoPanel/ProductionPanel/ControlPanel/BtnChoose/ImgLock")
	self.btnAssignToyType = UIControls.Button(self, "MainInfoPanel/ProductionPanel/ControlPanel/BtnChoose")

	self.btnAssignToyType:addEventClick(self.onClickBtnAssignToyType)

	local panel1 = UIControls.Panel(self, "MainInfoPanel/ProductionPanel/ControlPanel/BtnChoose/ImgState1")
	local panel2 = UIControls.Panel(self, "MainInfoPanel/ProductionPanel/ControlPanel/BtnChoose/ImgState2")
	local panel3 = UIControls.Panel(self, "MainInfoPanel/ProductionPanel/ControlPanel/BtnChoose/EfxState3")

	self.assignToyTypeStagePanelList = {
		panel1,
		panel2,
		panel3
	}
	self.improveQualityTitlePanel = UIControls.Panel(self, "MainInfoPanel/ProductionPanel/ControlPanel/BtnImprove/ImgTitle")
	self.txtImproveToyQualityNum = UIControls.Label(self, "MainInfoPanel/ProductionPanel/ControlPanel/BtnImprove/ImgTitle/TextNum")
	self.improveToyQualityLockPanel = UIControls.Panel(self, "MainInfoPanel/ProductionPanel/ControlPanel/BtnImprove/ImgLock")
	self.btnEnterImprove = UIControls.Button(self, "MainInfoPanel/ProductionPanel/ControlPanel/BtnImprove")

	self.btnEnterImprove:addEventClick(self.onClickBtnEnterImprove)

	local panel4 = UIControls.Panel(self, "MainInfoPanel/ProductionPanel/ControlPanel/BtnImprove/ImgState1")
	local panel5 = UIControls.Panel(self, "MainInfoPanel/ProductionPanel/ControlPanel/BtnImprove/ImgState2")
	local panel6 = UIControls.Panel(self, "MainInfoPanel/ProductionPanel/ControlPanel/BtnImprove/EfxState3")

	self.improveToyQualityStagePanelList = {
		panel4,
		panel5,
		panel6
	}
	self.txtNormalTitle = UIControls.Label(self, "BtnClose/Text1")
	self.txtDeleteTitle = UIControls.Label(self, "BtnClose/Text3")
	self.maskPanel = UIControls.Panel(self, "MainInfoPanel/ProductionPanel/ImgMask")
	self.deletePanel = UIControls.Panel(self, "MainInfoPanel/ProductionPanel/ToyProducePanel/DeletePanel")
	self.btnEnterDelete = UIControls.Button(self, "MainInfoPanel/ProductionPanel/ToyProducePanel/DeletePanel/BtnDelete")

	self.btnEnterDelete:addEventClick(self.onClickBtnEnterDelete)

	self.noneImprovePanel = UIControls.Panel(self, "MainInfoPanel/ToyImprovePanel/NoneContent")
	self.improvePanel = UIControls.Panel(self, "MainInfoPanel/ToyImprovePanel/ImprovePanel")
	self.maxLvPanel = UIControls.Panel(self, "MainInfoPanel/ToyImprovePanel/ImprovePanel/CurrentLvPanel/ImgMax")
	self.curQualityToyCell = ManagementToyCell(self, "MainInfoPanel/ToyImprovePanel/ImprovePanel/CurrentLvPanel", "System/Activity/ActivityManagement1/ToyNeedCell")

	self.curQualityToyCell:init(true)
	self.curQualityToyCell:setVisible(true)

	self.nextQualityPanel = UIControls.Panel(self, "MainInfoPanel/ToyImprovePanel/ImprovePanel/NextLvPanel")
	self.nextQualityToyCell = ManagementToyCell(self, "MainInfoPanel/ToyImprovePanel/ImprovePanel/NextLvPanel", "System/Activity/ActivityManagement1/ToyNeedCell")

	self.curQualityToyCell:init(true)
	self.nextQualityToyCell:setVisible(true)

	self.btnImprove = UIControls.Button(self, "MainInfoPanel/ToyImprovePanel/ImprovePanel/BtnImprove")

	self.btnImprove:addEventClick(self.onClickBtnImprove)

	self.btnImproveDis = UIControls.Button(self, "MainInfoPanel/ToyImprovePanel/ImprovePanel/BtnImproveDis")

	self.btnImproveDis:addEventClick(self.onClickBtnImprove)

	self.txtLeftImproveTimes = UIControls.Label(self, "MainInfoPanel/ToyImprovePanel/ImprovePanel/BtnImprove/TextNum")
	self.btnOrder = UIControls.Button(self, "MainInfoPanel/SalesPanel/BtnOrder")

	self.btnOrder:addEventClick(self.onClickBtnOrder)

	self.orderRed = UIControls.Panel(self, "MainInfoPanel/SalesPanel/BtnOrder/IconNew")
	self.btnSaleOrder = UIControls.Button(self, "MainInfoPanel/SalesPanel/OrderPanel/BtnSalesOrder")

	self.btnSaleOrder:addEventClick(self.onClickBtnSaleOrder)

	self.saleOrderRed = UIControls.Panel(self, "MainInfoPanel/SalesPanel/OrderPanel/BtnSalesOrder/IconNew")
	self.btnStorehouse = UIControls.Button(self, "MainInfoPanel/SalesPanel/OrderPanel/BtnStorehouse")

	self.btnStorehouse:addEventClick(self.onClickBtnStorehouse)

	self.orderPanel = UIControls.Panel(self, "MainInfoPanel/SalesPanel/OrderPanel")
	self.saleOrderPanel = UIControls.Panel(self, "MainInfoPanel/SalesPanel/OrderPanel/SalesOrderPanel")
	self.noneSaleOrderPanel = UIControls.Panel(self, "MainInfoPanel/SalesPanel/OrderPanel/SalesOrderPanel/ImgNone")
	self.storehousePanel = UIControls.Panel(self, "MainInfoPanel/SalesPanel/OrderPanel/StorehousePanel")
	self.txtStorehouse = UIControls.Label(self, "MainInfoPanel/SalesPanel/OrderPanel/StorehousePanel/TextNum")
	self.btnFriend = UIControls.Button(self, "MainInfoPanel/SalesPanel/BtnFriend")

	self.btnFriend:addEventClick(self.onClickBtnFriend)

	self.friendRed = UIControls.Panel(self, "MainInfoPanel/SalesPanel/BtnFriend/IconNew")
	self.btnDonateAll = UIControls.Button(self, "MainInfoPanel/SalesPanel/FriendPanel/BtnSendAll")

	self.btnDonateAll:addEventClick(self.onClickBtnDonateAll, 1)

	self.btnReceiveAll = UIControls.Button(self, "MainInfoPanel/SalesPanel/FriendPanel/BtnGetAll")

	self.btnReceiveAll:addEventClick(self.onClickBtnReceiveAll, 1)

	self.friendPanel = UIControls.Panel(self, "MainInfoPanel/SalesPanel/FriendPanel")
	self.txtReceiveNum = UIControls.Label(self, "MainInfoPanel/SalesPanel/FriendPanel/TextNum")
	self.noFriendPanel = UIControls.Panel(self, "MainInfoPanel/SalesPanel/FriendPanel/FriendList/ImgNone")
	self.imgPet = UIControls.Image(self, "MainInfoPanel/SalesPanel/ImgPet")
	self.produceEffect = UIControls.LazyEffectPlayer(self, "MainInfoPanel/ProductionPanel/ControlPanel/EnergyStoragePanel/EnergySlider/Fill Area/Fill/Efx")
	self.breakOutQualityPermissionEffect = UIControls.LazyEffectPlayer(self, "MainInfoPanel/ProductionPanel/ControlPanel/EnergyStoragePanel/Efx1")
	self.breakOutTimesPermissionEffect = UIControls.LazyEffectPlayer(self, "MainInfoPanel/ProductionPanel/ControlPanel/EnergyStoragePanel/StatePanel/Efx")
	self.producePermissionEffect = UIControls.LazyEffectPlayer(self, "MainInfoPanel/ProductionPanel/ControlPanel/BtnProduce/Efx1")
	self.staminaPermissionEffect = UIControls.LazyEffectPlayer(self, "MainInfoPanel/ProductionPanel/ControlPanel/EnergySlider/Efx")
	self.assignToyTypeEffect = UIControls.LazyEffectPlayer(self, "MainInfoPanel/ProductionPanel/ControlPanel/BtnChoose/Efx1")
	self.improveToyQualityEffect = UIControls.LazyEffectPlayer(self, "MainInfoPanel/ProductionPanel/ControlPanel/BtnImprove/Efx1")
	self.multiComposePermissionEffect = UIControls.LazyEffectPlayer(self, "MainInfoPanel/ProductionPanel/ControlPanel/BtnCombine/Efx")
	self.getOrderEffect = UIControls.LazyEffectPlayer(self, "MainInfoPanel/SalesPanel/OrderPanel/StorehousePanel/TextNum/Efx")
	self.rightState = nil
	self.orderCellList = {}
	self.storehouseCellList = {}
	self.oprateState = OprateState.Normal
	self.slotRefreshRight = Slot(self.refreshRight, self)

	EventCenter.addEventListener(EventConst.FRIEND_DATA_CHANGE, self.slotRefreshRight)
	EventCenter.addEventListener(EventConst.ITEM_UPDATE, self.slotRefreshRight)
end

function ManagementMainDlg:destroy()
	EventCenter.removeEventListener(EventConst.FRIEND_DATA_CHANGE, self.slotRefreshRight)
	EventCenter.removeEventListener(EventConst.ITEM_UPDATE, self.slotRefreshRight)
	self:clearStaminaTimer()
	self:clearPerMissionTimer()
	self:clearToyCellMoveTimer()
	self:clearProduceAnimCoroutine()
	ManagementMainDlg.super.destroy(self)
end

function ManagementMainDlg:_setData()
	self:refreshData()
	self.actData:clearStaminaRed()

	if self.replaceableCellPath and self.replaceableCellPath[1] and self.replaceableCellPath[2] then
		self.imgPet:setImage("Atlas/" .. self.replaceableCellPath[1], self.replaceableCellPath[2])
	end
end

function ManagementMainDlg:updateActivityData()
	self:refreshData()
end

function ManagementMainDlg:refreshData()
	if not self.actObj.roleData then
		return
	end

	self:refreshConveyer()
	self:refreshToy()
	self:refreshShop()

	if self.rightState then
		self:refreshRight()
	else
		self:onClickBtnOrder()
	end

	self:refreshRed()
end

function ManagementMainDlg:refreshRed()
	self.orderRed:setVisible(self.actData.checkOrderRed)
	self.saleOrderRed:setVisible(self.actData.checkOrderRed)
	self.friendRed:setVisible(self.actData.checkFriendRed)
	self.bpRed:setVisible(self.actData.checkBpRed)
end

function ManagementMainDlg:refreshRight()
	if self.rightState ~= RightState.Storehouse then
		self.orderNum = nil
	end

	if self.rightState ~= RightState.SaleOrder then
		self.lockOrderRefresh = false
	end

	if self.rightState == RightState.SaleOrder then
		self:refreshSaleOrder()
	elseif self.rightState == RightState.Storehouse then
		self:refreshStorehouse()
	elseif self.rightState == RightState.Friend then
		self:refreshFriend()
	end
end

function ManagementMainDlg:refreshShop()
	local curLucky = self.actData.curLucky
	local maxLucky = self.actData.maxLucky

	self.checkBreakOut = maxLucky <= curLucky

	self:refreshProduce()
	BeginnerManager.CheckManagementBreakOutOpen()
	self.breakOutPanel:setVisible(self.checkBreakOut)

	local maxTimes = self.actData.miscData.breakOut_max_times
	local totalTimes = self.actData.totalBreakOutTimes
	local usedTimes = self.actData.usedBreakOutTimes
	local panelNum = #self.breakOutStatePanelList

	for i = 1, panelNum do
		local checkShow = i <= maxTimes

		self.breakOutStatePanelList[i]:setVisible(checkShow)

		if checkShow then
			local checkDis = not self.checkBreakOut or totalTimes < i

			self.breakOutDisPanelList[i]:setVisible(checkDis)
			self.breakOutMarkPanelList[i]:setVisible(not checkDis and i <= totalTimes - usedTimes)
		end
	end

	self.sliderLucky:setVisible(not self.checkBreakOut)

	if not self.checkBreakOut then
		local ratio = maxLucky > 0 and curLucky / maxLucky or 0

		self.sliderLucky:setValue(ratio)
		self.txtMaxLucky:setText(maxLucky)
	end

	self:clearStaminaTimer()

	local curStamina = self.actData:getCurStamina()

	if not self.actObj:inFreeze() and curStamina < self.actData.maxStamina then
		self.slotStaminaTimerAction = self.slotStaminaTimerAction or Slot(self.staminaTimerAction, self)

		self:staminaTimerAction()

		self.staminaTimer = Timer.New(self.slotStaminaTimerAction, 1, -1)

		self.staminaTimer:Start()
	else
		self.txtStaminaTime:setText("")
	end

	self:refreshStamina()
	self.txtStaminaRecovery:setText(utils.format(self.actData.miscData.stamina_recovery_format, self.actData.staminaRefreshStep / 60, self.actData.staminaRecoverySpeed))
	self:refreshPrivilege()
	self:refreshBp()
	self:refreshImprovePanel()
	self:refreshDeletePanel()
	self.btnMultiComposeOpenState:setVisible(self.actData.checkMultiComposeOpen)
	self.btnMultiComposeLockState:setVisible(not self.actData.checkMultiComposeOpen)
end

function ManagementMainDlg:refreshStamina()
	local curStamina = self.actData:getCurStamina()

	self.txtStaminaNum:setText(curStamina .. "/" .. self.actData.maxStamina)

	local ratio = self.actData.maxStamina > 0 and curStamina / self.actData.maxStamina or 0

	self.sliderStamina:setValue(ratio)
end

function ManagementMainDlg:staminaTimerAction()
	local serverTime = ClientUtils.getServerTime()
	local remainder = (serverTime - self.actData.lastStaminaRefreshTime) % self.actData.staminaRefreshStep
	local left = self.actData.staminaRefreshStep - remainder

	if remainder == 0 then
		self:refreshStamina()
	end

	if self.actData:getCurStamina() == self.actData.maxStamina then
		self.txtStaminaTime:setText("")
	else
		self.txtStaminaTime:setText(ClientUtils.getTimeStrBySecond(left))
	end
end

function ManagementMainDlg:clearStaminaTimer()
	if self.staminaTimer then
		self.staminaTimer:Stop()

		self.staminaTimer = nil
	end
end

function ManagementMainDlg:onClickBtnStamina()
	self.isShowStaminaRecovery = not self.isShowStaminaRecovery and true or false

	self:refreshStaminaRecoveryPanel()
end

function ManagementMainDlg:refreshStaminaRecoveryPanel()
	self.btnStamina:setRotateByXYZ(0, 0, self.isShowStaminaRecovery and 180 or 0)
	self.txtStaminaTime:setVisible(not self.isShowStaminaRecovery)
	self.staminaRecoveryPanel:setVisible(self.isShowStaminaRecovery)
end

function ManagementMainDlg:refreshProduce()
	local checkAssignToyType = self.actData.assignToyType > 0

	self.assignToyTypePanel:setVisible(checkAssignToyType)

	if checkAssignToyType then
		local itemId = ResBusinessToyConfig[self.actData.actId][self.actData.assignToyType][1].item_id
		local path = BaseObject.getItemIconPath(itemId)

		if path then
			self.imgAssignToyType:setImage(path[1], path[2])
		end
	end

	self.checkShowMultiProduce = not self.checkBreakOut and self.actData.checkMultiProduceOpen and not checkAssignToyType

	self.btnProduceBreakOutState:setVisible(self.checkBreakOut)
	self.btnProduceMultiState:setVisible(self.checkShowMultiProduce)
	self.btnProduceNormalState:setVisible(not self.checkBreakOut and not self.checkShowMultiProduce)

	local checkShowConsumeStamina = not self.checkBreakOut and not self.checkShowMultiProduce

	self.imgProductConsumeStamina:setVisible(checkShowConsumeStamina)
	self.txtProductConsumeStamina:setVisible(checkShowConsumeStamina)

	if checkShowConsumeStamina then
		self.txtProductConsumeStamina:setText(self.actData.productUseStamina)
	end
end

function ManagementMainDlg:refreshPrivilege()
	self.checkAssignToyTypeUnlock = self.actData.totalAssignToyTypeTimes > 0

	self.sssignToyTypeTitlePanel:setVisible(self.checkAssignToyTypeUnlock)
	self.assignToyTypeLockPanel:setVisible(not self.checkAssignToyTypeUnlock)

	if self.checkAssignToyTypeUnlock then
		self.leftAssignToyTypeTimes = self.actData:getLeftAssignToyTypeTimes()

		self.txtAssignToyTypeNum:setText(string.format(Lang.get(80593), self.leftAssignToyTypeTimes))

		local stage = 1
		local stageList = self.actData.assignToyTypeStageList

		for i = 1, #stageList do
			if self.actData.totalAssignToyTypeTimes >= stageList[i] then
				stage = i
			else
				break
			end
		end

		stage = math.min(stage, #self.assignToyTypeStagePanelList)

		for i = 1, #self.assignToyTypeStagePanelList do
			local check = i == 1 and stage == 1 or i > 1 and i <= stage

			self.assignToyTypeStagePanelList[i]:setVisible(check)
		end
	end

	self.checkImproveToyQualityUnlock = self.actData.totalImproveToyQualityTimes > 0

	self.improveQualityTitlePanel:setVisible(self.checkImproveToyQualityUnlock)
	self.improveToyQualityLockPanel:setVisible(not self.checkImproveToyQualityUnlock)

	if self.checkImproveToyQualityUnlock then
		self.leftImproveToyQualityTimes = self.actData:getLeftImproveToyQualityTimes()

		self.txtImproveToyQualityNum:setText(string.format(Lang.get(80593), self.leftImproveToyQualityTimes))

		local stage = 1
		local stageList = self.actData.improveToyQualityStageList

		for i = 1, #stageList do
			if self.actData.totalImproveToyQualityTimes >= stageList[i] then
				stage = i
			else
				break
			end
		end

		stage = math.min(stage, #self.improveToyQualityStagePanelList)

		for i = 1, #self.improveToyQualityStagePanelList do
			local check = i == 1 and stage == 1 or i > 1 and i <= stage

			self.improveToyQualityStagePanelList[i]:setVisible(check)
		end
	end

	BeginnerManager.CheckManagementAssignToyTypeOpen()
	BeginnerManager.CheckManagementImproveToyQualityOpen()
end

function ManagementMainDlg:refreshBp()
	local lv = 0
	local curExp = 0
	local lastExp = 0
	local nextExp = 0

	if self.actObj.templateData.relate_act and #self.actObj.templateData.relate_act > 0 then
		local actId = self.actObj.templateData.relate_act[1]
		local relateActObj = CurAvatar:getActivityObj(actId)

		if relateActObj then
			local relateActData = relateActObj.actData

			for actType, cData in pairs(relateActData.clientData) do
				curExp = relateActData:getAchieveProgress(actType)

				for index, data in ipairs(cData) do
					if curExp >= data.param then
						lv = index
						lastExp = data.param
					else
						nextExp = data.param

						break
					end
				end

				break
			end
		end
	end

	self.txtStoreLv:setText(string.format(Lang.get(80803), lv))

	if nextExp == 0 then
		self.txtStoreExp:setText(utils.format("%1s/%2s", curExp, curExp))
		self.sliderStore:setValue(1)
	else
		local numerator = curExp - lastExp
		local denominator = nextExp - lastExp

		self.txtStoreExp:setText(utils.format("%1s/%2s", numerator, denominator))
		self.sliderStore:setValue(denominator == 0 and 0 or numerator / denominator)
	end

	if self.storeExp and curExp > self.storeExp then
		self.storeExpEffect:playEffect()
	end

	self.storeExp = curExp
end

function ManagementMainDlg:refreshConveyer()
	local openNum = self.actData.serverOpenNum

	for i = 1, #self.conveyerLockPanelList do
		self.conveyerLockPanelList[i]:setVisible(openNum < i * 5)
	end
end

function ManagementMainDlg:refreshToy()
	if self.checkInitToy then
		return
	end

	self.checkInitToy = true
	self.hasOpenNum = self.actData.serverOpenNum

	local dataList = self.actData.gridDataList

	for i, cell in ipairs(self.toyCellList) do
		cell:setData(dataList[i], i <= self.hasOpenNum, self.actObj)
		cell:setVisible(true)
	end
end

function ManagementMainDlg:onDragBeginToyCell(toyCell)
	toyCell.transform:SetParent(self.transDragToy, false)
	toyCell.panel:setPosition(toyCell.startX, toyCell.startY)

	for _, cell in ipairs(self.toyCellList) do
		if cell.index ~= toyCell.index and toyCell.toyItemId == cell.toyItemId and toyCell.toyQuality < self.actData.unlockToyQuality then
			cell:showCanMergeEffect(true)
		end
	end
end

function ManagementMainDlg:onDragToyCell(x, y, toyCell)
	local endToyCell

	for _, cell in ipairs(self.toyCellList) do
		if cell.index ~= toyCell.index and x > cell.minPosX and x < cell.maxPosX and y > cell.minPosY and y < cell.maxPosY then
			endToyCell = cell

			break
		end
	end

	if self.targetEndJoyCell ~= endToyCell then
		if self.targetEndJoyCell then
			self.targetEndJoyCell:showMergeEffect(false)
		end

		self.targetEndJoyCell = endToyCell

		if self.targetEndJoyCell and self.targetEndJoyCell.toyItemId == toyCell.toyItemId then
			self.targetEndJoyCell:showMergeEffect(true)
		end
	end
end

function ManagementMainDlg:onDragEndToyCell(toyCell)
	local fromToyItemId = toyCell.toyItemId

	if self.targetEndJoyCell then
		if not self.targetEndJoyCell.data then
			MsgManager.clientNotice(696)
		elseif fromToyItemId == self.targetEndJoyCell.toyItemId then
			if self.targetEndJoyCell.toyQuality >= self.actData.unlockToyQuality then
				MsgManager.clientNotice(690)
			else
				local checkNeed = false

				for i = 1, #self.orderCellList do
					local orderCell = self.orderCellList[i]

					if orderCell._visible and orderCell.checkCanCommit then
						local requireToyList = orderCell.data.requireToyList

						for j = 1, #requireToyList do
							local requireToy = requireToyList[j]

							if requireToy.toyConfig.item_id == fromToyItemId then
								checkNeed = true

								break
							end
						end
					end
				end

				if checkNeed then
					local yesCb = Functor(self.sendComposeRPC, self, toyCell.index, self.targetEndJoyCell.index)

					UIManager.showConfirmWithId(1087, yesCb)
				else
					RPC.opActBusinessMaterialCompose(self.actObj.opId, {
						{
							pos_from = toyCell.index,
							pos_dest = self.targetEndJoyCell.index
						}
					})
				end
			end
		else
			MsgManager.clientNotice(694)
		end

		self.targetEndJoyCell:showMergeEffect(false)
	end

	for _, cell in ipairs(self.toyCellList) do
		if cell.index ~= toyCell.index and toyCell.toyItemId == cell.toyItemId then
			cell:showCanMergeEffect(false)
		end
	end
end

function ManagementMainDlg:sendComposeRPC(startPos, endPos)
	RPC.opActBusinessMaterialCompose(self.actObj.opId, {
		{
			pos_from = startPos,
			pos_dest = endPos
		}
	})
end

function ManagementMainDlg:onToyCellMoveBegin(toyCell)
	self:clearToyCellMoveTimer()

	self.moveToyCellIdx = toyCell.index
	self.slotToyCellMoveTimerCb = self.slotToyCellMoveTimerCb or Slot(self.toyCellMoveTimerCb, self)
	self.toyCellMoveTimer = Timer.New(self.slotToyCellMoveTimerCb, 1)

	self.toyCellMoveTimer:Start()

	self.checkInToyCellMove = true

	self:setToyCellDragEnable(false)
end

function ManagementMainDlg:toyCellMoveTimerCb()
	self.toyCellMoveTimer = nil
	self.checkInToyCellMove = false

	self:setToyCellDragEnable(true)

	self.moveToyCellIdx = nil
end

function ManagementMainDlg:onToyCellMoveEnd(toyCell)
	if toyCell.index == self.moveToyCellIdx then
		self:clearToyCellMoveTimer()
	end
end

function ManagementMainDlg:clearToyCellMoveTimer()
	if self.toyCellMoveTimer then
		self.toyCellMoveTimer:Stop()

		self.toyCellMoveTimer = nil
		self.checkInToyCellMove = false

		self:setToyCellDragEnable(true)

		self.moveToyCellIdx = nil
	end
end

function ManagementMainDlg:setToyCellDragEnable(value)
	for i = 1, #self.toyCellList do
		self.toyCellList[i]:setDragEnable(value)
	end
end

function ManagementMainDlg:onClickBtnEnterImprove()
	if self.checkImproveToyQualityUnlock then
		if self.leftImproveToyQualityTimes > 0 then
			self:enterImprove()
		else
			MsgManager.clientNotice(698)
		end
	else
		MsgManager.clientNotice(703)
	end
end

function ManagementMainDlg:onClickBtnExitImprove()
	self:exitImprove()
end

function ManagementMainDlg:enterImprove()
	self.oprateState = OprateState.Improve

	self.uiAni:startAni("ShowImprove")
	self:refreshImprovePanel()

	for i = 1, #self.toyCellList do
		self.toyCellList[i]:enterImprove()
	end

	self.btnClose:clearEventClick()
	self.btnClose:addEventClick(self.onClickBtnExitImprove)
end

function ManagementMainDlg:exitImprove()
	self.oprateState = OprateState.Normal

	self.uiAni:startAni("HideImprove")

	for i = 1, #self.toyCellList do
		self.toyCellList[i]:exitImprove()
	end

	self.selectImproveToyCell = nil

	self.btnClose:clearEventClick()
	self.btnClose:addEventClick(self.onClickBtnClose)
end

function ManagementMainDlg:onClickToyCell(toyCell)
	if toyCell == self.selectImproveToyCell then
		self.selectImproveToyCell:setSelect(false)

		self.selectImproveToyCell = nil
	else
		if self.selectImproveToyCell then
			self.selectImproveToyCell:setSelect(false)
		end

		self.selectImproveToyCell = toyCell

		self.selectImproveToyCell:setSelect(true)
	end

	self:refreshImprovePanel()
end

function ManagementMainDlg:refreshImprovePanel()
	if self.oprateState ~= OprateState.Improve then
		return
	end

	local checkSelectCell = self.selectImproveToyCell ~= nil

	self.noneImprovePanel:setVisible(not checkSelectCell)
	self.improvePanel:setVisible(checkSelectCell)

	if checkSelectCell then
		local data = self.selectImproveToyCell.data
		local checkMax = self.selectImproveToyCell.checkMax
		local checkUnlockMax = self.selectImproveToyCell.checkUnlockMax

		self.curQualityToyCell:setData(self.actData.actId, data.id, data.quality)
		self.nextQualityPanel:setVisible(not checkMax)
		self.maxLvPanel:setVisible(checkMax)
		self.btnImproveDis:setVisible(checkUnlockMax)
		self.btnImprove:setVisible(not checkMax and not checkUnlockMax)

		if not checkMax then
			self.nextQualityToyCell:setData(self.actData.actId, data.id, data.quality + 1, nil, checkUnlockMax)
			self.txtLeftImproveTimes:setText(string.format(Lang.get(80597), self.leftImproveToyQualityTimes))
		end
	end
end

function ManagementMainDlg:onClickBtnImprove()
	if self.selectImproveToyCell ~= nil then
		if self.leftImproveToyQualityTimes > 0 then
			RPC.opActBusinessMaterialUpgrade(self.actObj.opId, self.selectImproveToyCell.index, UIConst.enumResBusinessPermission.ImproveToyQuality)
		else
			MsgManager.clientNotice(698)
		end
	end
end

function ManagementMainDlg:refreshDeletePanel()
	local checkShowDelete = self.oprateState == OprateState.Normal and self.actData:checkCanDelete()

	self.deletePanel:setVisible(checkShowDelete)
end

function ManagementMainDlg:onClickBtnEnterDelete()
	self:enterDelete()
end

function ManagementMainDlg:enterDelete()
	self.oprateState = OprateState.Delete

	for i = 1, #self.toyCellList do
		self.toyCellList[i]:enterDelete()
	end

	self.deletePanel:setVisible(false)
	self.txtDeleteTitle:setVisible(true)
	self.txtNormalTitle:setVisible(false)
	self.maskPanel:setVisible(true)
	self.btnClose:clearEventClick()
	self.btnClose:addEventClick(self.exitDelete)
end

function ManagementMainDlg:exitDelete()
	self.oprateState = OprateState.Normal

	for i = 1, #self.toyCellList do
		self.toyCellList[i]:exitDelete()
	end

	self.txtDeleteTitle:setVisible(false)
	self.txtNormalTitle:setVisible(true)
	self.maskPanel:setVisible(false)
	self.btnClose:clearEventClick()
	self.btnClose:addEventClick(self.onClickBtnClose)
	self:refreshShop()
end

function ManagementMainDlg:onClickBtnOrder()
	self.orderPanel:setVisible(true)
	self.friendPanel:setVisible(false)
	self.btnOrder:setEnable(false)
	self.btnFriend:setEnable(true)
	self:onClickBtnSaleOrder()
end

function ManagementMainDlg:onClickBtnSaleOrder()
	self.saleOrderPanel:setVisible(true)
	self.storehousePanel:setVisible(false)
	self.btnSaleOrder:setEnable(false)
	self.btnStorehouse:setEnable(true)

	self.rightState = RightState.SaleOrder

	self:refreshRight()
end

function ManagementMainDlg:onClickBtnStorehouse()
	self.saleOrderPanel:setVisible(false)
	self.storehousePanel:setVisible(true)
	self.btnSaleOrder:setEnable(true)
	self.btnStorehouse:setEnable(false)

	self.rightState = RightState.Storehouse

	self:refreshRight()
end

function ManagementMainDlg:refreshSaleOrder()
	if self.lockOrderRefresh then
		return
	end

	local cellList = self.orderCellList
	local dataList = self.actData.orderDataList
	local dataNum = #dataList
	local cellNum = #cellList

	self.slotOnClickOrderCell = self.slotOnClickOrderCell or Slot(self.onClickOrderCell, self)

	for i = 1, dataNum do
		local cell

		if i <= cellNum then
			cell = cellList[i]
		else
			cell = OrderCell(self, "MainInfoPanel/SalesPanel/OrderPanel/SalesOrderPanel/Content", "System/Activity/ActivityManagement1/OrderCell")

			cell:init(self.slotOnClickOrderCell)
			table.insert(cellList, cell)
		end

		cell:setVisible(true)
		cell:setData(dataList[i], self.actObj)
	end

	if dataNum < cellNum then
		for i = dataNum + 1, cellNum do
			cellList[i]:setVisible(false)
		end
	end

	self.noneSaleOrderPanel:setVisible(dataNum == 0)

	if self.oprateState == OprateState.Normal then
		BeginnerManager.CheckManagementCanCommitOrder()
	end
end

function ManagementMainDlg:onClickOrderCell(cell)
	if self.checkInToyCellMove then
		MsgManager.clientNotice(167)

		return
	end

	if self.lastCommitOrderTime and self.lastCommitOrderTime > 0 then
		local serverTime = ClientUtils.getServerTime()

		if serverTime - self.lastCommitOrderTime < 2 then
			MsgManager.clientNotice(167)

			return
		end
	end

	self.lastCommitOrderTime = ClientUtils.getServerTime()

	RPC.opActBusinessOrderCommit(self.actObj.opId, cell.data.gid, cell.commitToyPosList)
end

function ManagementMainDlg:refreshStorehouse()
	local orderNum = #self.actData.orderDataList

	if self.orderNum and orderNum > self.orderNum then
		self.getOrderEffect:setVisible(true)
		self.getOrderEffect:playEffect()
		MsgManager.clientNotice(709)
	end

	self.orderNum = orderNum

	local checkFull = self.orderNum >= self.actData.maxOrderNum

	self.txtStorehouse:setText(utils.format(Lang.get(80599), self.orderNum, self.actData.maxOrderNum))

	local cellList = self.storehouseCellList
	local dataList = self.actData.orderItemList
	local dataNum = #dataList
	local cellNum = #cellList

	for i = 1, dataNum do
		local cell

		if i <= cellNum then
			cell = cellList[i]
		else
			cell = StorehouseCell(self, "MainInfoPanel/SalesPanel/OrderPanel/StorehousePanel/Content", "System/Activity/ActivityManagement1/GetOrderCell")

			table.insert(cellList, cell)
		end

		cell:setVisible(true)
		cell:setData(dataList[i], i, checkFull, self.actObj)
	end

	if dataNum < cellNum then
		for i = dataNum + 1, cellNum do
			cellList[i]:setVisible(false)
		end
	end
end

function ManagementMainDlg:onClickBtnFriend()
	self.orderPanel:setVisible(false)
	self.friendPanel:setVisible(true)
	self.btnOrder:setEnable(true)
	self.btnFriend:setEnable(false)

	self.rightState = RightState.Friend

	self:refreshRight()
end

function ManagementMainDlg:refreshFriend()
	self.friendCellList = self.friendCellList or {}
	self.slotOnClickFriendCellBtnDonate = self.slotOnClickFriendCellBtnDonate or Slot(self.onClickFriendCellBtnDonate, self)
	self.slotOnClickFriendCellBtnReceive = self.slotOnClickFriendCellBtnReceive or Slot(self.onClickFriendCellBtnReceive, self)

	local friendList = CurAvatar:getSortedFriends() or {}

	self.noFriendPanel:setVisible(#friendList == 0)

	friendList = self.actData:getSortedFriendList(friendList)

	local donateDic = self.actData:getDonateDic()
	local receiveDic = self.actData.receiveDic

	self.receiveNum = self.actData:getReceieveNum()
	self.donateNum = utils.getTableElemCount(donateDic)
	self.canDonateUidList = {}
	self.canReceiveUidList = {}

	local cellList = self.friendCellList
	local dataList = friendList
	local dataNum = #dataList
	local cellNum = #cellList

	for i = 1, dataNum do
		local cell

		if i <= cellNum then
			cell = cellList[i]
		else
			cell = FriendCell(self, "MainInfoPanel/SalesPanel/FriendPanel/FriendList/Content", "System/Activity/ActivityManagement1/ActivityManagementFriendsInfoCell")

			cell:init(self.slotOnClickFriendCellBtnDonate, self.slotOnClickFriendCellBtnReceive)
			table.insert(cellList, cell)
		end

		cell:setVisible(true)

		local data = dataList[i]
		local uid = data.uid

		cell:setData(data, donateDic[uid], receiveDic[uid], self.actObj)

		if cell.checkCanDonate then
			table.insert(self.canDonateUidList, cell.uid)
		end

		if cell.checkCanReceive then
			table.insert(self.canReceiveUidList, cell.uid)
		end
	end

	if dataNum < cellNum then
		for i = dataNum + 1, cellNum do
			cellList[i]:setVisible(false)
		end
	end

	self.txtReceiveNum:setText(utils.format(Lang.get(53352), self.receiveNum, self.actData.maxReceiveNum))
end

function ManagementMainDlg:onClickFriendCellBtnDonate(friendCell)
	if self.donateNum >= self.actData.maxDonateNum then
		MsgManager.clientNotice(699)
	else
		RPC.opActBusinessStaminaDonated(self.actObj.opId, {
			friendCell.uid
		})
	end
end

function ManagementMainDlg:onClickFriendCellBtnReceive(friendCell)
	if self.receiveNum >= self.actData.maxReceiveNum then
		MsgManager.clientNotice(700)
	else
		RPC.opActBusinessStaminaReceive(self.actObj.opId, {
			friendCell.uid
		})
	end
end

function ManagementMainDlg:onClickBtnDonateAll()
	if self.actObj:inFreeze() then
		MsgManager.notice(Lang.get(32793))

		return
	end

	if self.donateNum >= self.actData.maxDonateNum then
		MsgManager.clientNotice(699)
	else
		local num = self.actData.maxDonateNum - self.donateNum
		local uidList = self.canDonateUidList
		local list = {}

		for i = 1, math.min(#uidList, num) do
			table.insert(list, uidList[i])
		end

		if #list > 0 then
			RPC.opActBusinessStaminaDonated(self.actObj.opId, list)
		else
			MsgManager.clientNotice(692)
		end
	end
end

function ManagementMainDlg:onClickBtnReceiveAll()
	if self.actObj:inFreeze() then
		MsgManager.notice(Lang.get(32793))

		return
	end

	if self.receiveNum >= self.actData.maxReceiveNum then
		MsgManager.clientNotice(700)
	else
		local num = self.actData.maxReceiveNum - self.receiveNum
		local uidList = self.canReceiveUidList
		local list = {}

		for i = 1, math.min(#uidList, num) do
			table.insert(list, uidList[i])
		end

		if #list > 0 then
			RPC.opActBusinessStaminaReceive(self.actObj.opId, list)
		else
			MsgManager.clientNotice(691)
		end
	end
end

function ManagementMainDlg:refreshPermissionEffect()
	local num = utils.getTableElemCount(self.actData.newUnlockPermissionDic)

	if num > 0 then
		self:clearPerMissionTimer()

		self.slotRealRefreshPermissionEffect = Slot(self.realRefreshPermissionEffect, self)
		self.permissionTimer = Timer.New(self.slotRealRefreshPermissionEffect, 0.2)

		self.permissionTimer:Start()
	end
end

function ManagementMainDlg:clearPerMissionTimer()
	if self.permissionTimer then
		self.permissionTimer:Stop()

		self.permissionTimer = nil
	end
end

function ManagementMainDlg:realRefreshPermissionEffect()
	for permission_type, paramList in pairs(self.actData.newUnlockPermissionDic) do
		if permission_type == UIConst.enumResBusinessPermission.UnlockGrid then
			for i = 1, #paramList do
				local idx = math.ceil(paramList[i] / 5)

				if i == 1 then
					local functorPlayConveyerAnimCallBack = Functor(self.playConveyerAnimCallBack, self, paramList)

					self.conveyerLockAniList[idx]:clearEventFinish()
					self.conveyerLockAniList[idx]:addEventFinish(functorPlayConveyerAnimCallBack)
					self.conveyerLockAniList[idx]:startAni("UnlockGrid")
				else
					self.conveyerLockAniList[idx]:startAni("UnlockGrid")
				end
			end
		elseif permission_type == UIConst.enumResBusinessPermission.StaminaLimit then
			self.staminaPermissionEffect:setVisible(true)
			self.staminaPermissionEffect:playEffect()
		elseif permission_type == UIConst.enumResBusinessPermission.StaminaRecoverySpeed then
			self.staminaPermissionEffect:setVisible(true)
			self.staminaPermissionEffect:playEffect()
		elseif permission_type == UIConst.enumResBusinessPermission.UnlockToyType then
			self.producePermissionEffect:setVisible(true)
			self.producePermissionEffect:playEffect()
		elseif permission_type == UIConst.enumResBusinessPermission.UnlockToyQuality then
			self.producePermissionEffect:setVisible(true)
			self.producePermissionEffect:playEffect()
		elseif permission_type == UIConst.enumResBusinessPermission.BreakOutQualityRandom then
			self.breakOutQualityPermissionEffect:setVisible(true)
			self.breakOutQualityPermissionEffect:playEffect()
		elseif permission_type == UIConst.enumResBusinessPermission.BreakOutFreeTimes then
			self.breakOutTimesPermissionEffect:setVisible(true)
			self.breakOutTimesPermissionEffect:playEffect()
		elseif permission_type == UIConst.enumResBusinessPermission.AssignToyType then
			self.assignToyTypeEffect:setVisible(true)
			self.assignToyTypeEffect:playEffect()
		elseif permission_type == UIConst.enumResBusinessPermission.ImproveToyQuality then
			self.improveToyQualityEffect:setVisible(true)
			self.improveToyQualityEffect:playEffect()
		elseif permission_type == UIConst.enumResBusinessPermission.MultiCompose then
			self.multiComposePermissionEffect:setVisible(true)
			self.multiComposePermissionEffect:playEffect()
		end
	end

	self:refreshShop()

	self.actData.newUnlockPermissionDic = {}
	self.permissionTimer = nil
end

function ManagementMainDlg:playConveyerAnimCallBack(paramList)
	for i = paramList[1] - 4, paramList[#paramList] do
		local cell = self.toyCellList[i]

		if cell then
			cell:setOpenState(true)
		end
	end
end

function ManagementMainDlg:onClickBtnProduce()
	if self.actData:checkGridsFull() then
		MsgManager.clientNotice(701)
	elseif self.checkBreakOut or self.actData:getCurStamina() >= self.actData.productUseStamina then
		if self.checkInToyCellMove or self.produceAnimCoroutine then
			return
		end

		self.checkBreakOutProduce = self.checkBreakOut

		local checkAssignToyType = self.actData.assignToyType > 0 and self.actData:getLeftAssignToyTypeTimes() > 0

		if checkAssignToyType then
			RPC.opActBusinessMaterialProduct(self.actObj.opId, UIConst.enumResBusinessPermission.AssignToyType, self.actData.assignToyType)
		elseif self.actData.checkMultiProduceOpen then
			RPC.opActBusinessMaterialProduct(self.actObj.opId, nil, nil, 1)
		else
			RPC.opActBusinessMaterialProduct(self.actObj.opId)
		end
	else
		MsgManager.clientNotice(689)
	end
end

function ManagementMainDlg:onClickBtnAssignToyType()
	if self.checkAssignToyTypeUnlock then
		if self.leftAssignToyTypeTimes > 0 then
			local ui = UIManager.getUI("managementToyChooseDlg", true)

			if ui then
				ui:setData(self.actData)
			end
		else
			MsgManager.clientNotice(697)
		end
	else
		MsgManager.clientNotice(702)
	end
end

function ManagementMainDlg:onClickBtnInfo()
	local ui = UIManager.getUI("managementInfoDlg", true)

	ui:setData(self.actData)
end

function ManagementMainDlg:onClickBtnStore()
	if self.actObj.templateData.relate_act and #self.actObj.templateData.relate_act > 0 then
		local actId = self.actObj.templateData.relate_act[1]
		local relateActObj = CurAvatar:getActivityObj(actId)

		if relateActObj then
			CurAvatar:jumpToShowActivity(actId)

			local managementBattlePassDlg = UIManager.getUI("managementBattlePassDlg")

			if managementBattlePassDlg then
				managementBattlePassDlg:setOnlyFastReceive(true)
			end
		end
	end
end

function ManagementMainDlg:onClickBtnTips()
	return
end

function ManagementMainDlg:onClickBtnClose()
	self:setVisible(false)
end

function ManagementMainDlg:onClickBtnMultiCompose()
	if self.actData.checkMultiComposeOpen then
		if self.checkInToyCellMove or self.produceAnimCoroutine then
			return
		end

		local list = self.actData:getMultiComposePosList()

		if #list > 0 then
			RPC.opActBusinessMaterialCompose(self.actObj.opId, list, 1)
		else
			MsgManager.clientNotice(717)
		end
	else
		MsgManager.clientNotice(716)
	end
end

function ManagementMainDlg:onOpActBusinessMaterialProductResp(posList, dataList)
	if not self.checkBreakOutProduce then
		self.produceEffect:setVisible(true)
		self.produceEffect:playEffect()
	end

	self.produceAnimCoroutine = coroutine.create(Functor(self.produceAnim, self, posList, dataList))

	coroutine.resume(self.produceAnimCoroutine)
end

function ManagementMainDlg:produceAnim(posList, dataList)
	for i = 1, #posList do
		local grid_pos = posList[i]
		local data = dataList[i]
		local grid = self.toyCellList[grid_pos]

		if grid then
			local movePos = 5 - (grid_pos - 1) % 5

			grid:setData(data, true, self.actObj)
			grid:playMoveAnim(movePos)
		end

		if data.quality > 1 then
			local idx = math.ceil(grid_pos / 5)

			if idx <= #self.highQualityToyEffectList then
				local effect = self.highQualityToyEffectList[idx]

				effect:setVisible(true)
				effect:playEffect()
			end
		end

		if i < #posList then
			coroutine.step(7)
		end
	end

	self.produceAnimCoroutine = nil
end

function ManagementMainDlg:clearProduceAnimCoroutine()
	if self.produceAnimCoroutine then
		coroutine.stop(self.produceAnimCoroutine)

		self.produceAnimCoroutine = nil
	end
end

function ManagementMainDlg:onOpActBusinessMaterialComposeResp(infoList, moveGrids, gridDataList)
	for i, info in ipairs(infoList) do
		local pos_from = info.pos_from
		local pos_dest = info.pos_dest
		local grid_from = info.grid_from
		local grid_dest = info.grid_dest
		local destData = ResBusinessToyConfig[self.actData.actId][grid_dest.material.type][grid_dest.material.quality]

		self.toyCellList[pos_from]:setData(nil, true, self.actObj)
		self.toyCellList[pos_dest]:setData(destData, true, self.actObj)

		if i == 1 then
			local endCb = Functor(self.playMoveAnim, self, moveGrids, gridDataList)

			self.toyCellList[pos_dest]:playUpgradeAnim(endCb)
		else
			self.toyCellList[pos_dest]:playUpgradeAnim()
		end
	end

	if self.rightState == RightState.SaleOrder then
		self:refreshRight()
	end
end

function ManagementMainDlg:onOpActBusinessOrderCommitResp(order_index, grid_pos, moveGrids, gridDataList)
	if self.rightState == RightState.SaleOrder then
		self.lockOrderRefresh = true
		self.slotPlayOrderCommitAnimCallBack = self.slotPlayOrderCommitAnimCallBack or Slot(self.playOrderCommitAnimCallBack, self)

		for i = 1, #self.orderCellList do
			local cell = self.orderCellList[i]

			if cell.data and cell.data.gid == order_index then
				cell:playCommitAnim(self.slotPlayOrderCommitAnimCallBack)
				FlyIconUtils.setFlyUItoUI(cell.imgExp, self.txtStoreExp)
			else
				cell:refresh()
			end
		end
	end

	local check = false

	for _, pos in pairs(grid_pos) do
		local cell = self.toyCellList[pos]

		if check then
			cell:playCostAnimcallback()
		else
			check = true

			local endCb = Functor(self.commitCb, self, grid_pos, moveGrids, gridDataList)

			cell:playCostAnimcallback(endCb)
		end
	end
end

function ManagementMainDlg:playOrderCommitAnimCallBack()
	self.lockOrderRefresh = false

	if self.rightState == RightState.SaleOrder then
		self:refreshRight()
	end
end

function ManagementMainDlg:commitCb(grid_pos, moveGrids, gridDataList)
	local check = false

	for _, pos in pairs(grid_pos) do
		local cell = self.toyCellList[pos]

		if check then
			cell:setData(nil, true, self.actObj)
		else
			check = true

			local functor = Functor(self.playMoveAnim, self, moveGrids, gridDataList)

			cell:setData(nil, true, self.actObj, functor)
		end
	end
end

function ManagementMainDlg:onOpActBusinessOrderDeleteResp(pos, moveGrids, gridDataList)
	self:exitDelete()

	local cell = self.toyCellList[pos]
	local grid_pos = {
		pos
	}
	local endCb = Functor(self.commitCb, self, grid_pos, moveGrids, gridDataList)

	cell:playCostAnimcallback(endCb)
end

function ManagementMainDlg:onOpActBusinessOrderUpdateResp(order_index, order)
	for i = 1, #self.orderCellList do
		local orderCell = self.orderCellList[i]

		if orderCell.data and orderCell.data.gid == order_index then
			orderCell:playRefreshEffect()

			break
		end
	end
end

function ManagementMainDlg:playMoveAnim(moveGrids, gridDataList)
	self.lastCommitOrderTime = 0

	for pos, changeInfo in pairs(moveGrids) do
		self.toyCellList[pos]:setData(gridDataList[pos], true, self.actObj)

		if changeInfo > 0 then
			self.toyCellList[pos]:playMoveAnim(changeInfo)
		end
	end
end

function ManagementMainDlg:onOpActBusinessMaterialUpgradeResp(pos, gridDataList)
	self.toyCellList[pos]:setData(gridDataList[pos], true, self.actObj)
	self.toyCellList[pos]:playUpgradeAnim()
	self:refreshPrivilege()
	self:refreshImprovePanel()
end

function ManagementMainDlg:onOpActBusinessStaminaReceiveResp(buddy_uid)
	self.animStamina:startAni("GetFriendEnergy")

	local num = buddy_uid and #buddy_uid or 1
	local stamina = num * self.actData.miscData.once_receive_stamina_value

	MsgManager.notice(string.format(ResClientNotice[708].notice, stamina))
end

function ManagementMainDlg:onOpActBusinessStaminaDonatedResp(buddy_uid)
	MsgManager.clientNotice(706)
end

return ManagementMainDlg
