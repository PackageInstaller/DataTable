-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Common\\Tips\\SkinPreviewTips.lua

local SkinPreviewTipsInfoPanel = require("UI/Common/Tips/SkinPreviewTipsInfoPanel")
local ResItemHeroBase = require("ClientData/ResItemHeroBase")
local ResHero = require("ClientData/ResHero")
local ModelTool = require("Entity/ModelTool")
local ModelFactory = Framework.Entity.ModelFactory
local ResClientNotice = require("ClientData/ResClientNotice")
local ResItem = require("ClientData/ResItem")
local WINDOW_TIPS_ORDER = 15
local strClassName = "SkinPreviewTips"
local SkinPreviewTips = Class(strClassName, UIControls.Window)

function SkinPreviewTips:ctor()
	if not self:getVisible() then
		self:setVisible(true)
	end

	self._slot4LoadNewModelEnd = Slot(self.initModelLoadedEnd, self)

	self:_initUI()
end

function SkinPreviewTips:_initUI()
	self.panelBaseInfo = SkinPreviewTipsInfoPanel(self, "MainInfoPanel")
	self.modelViewport = UIControls.RawImage(self, "ModelViewport")
	self.modelStage = ModelStageManager.createUIModelStage(self, "ModelStage/HandBookDlgModelStage")
	self.modelControl = UIControls.Panel(self, "ModelControl")
	self.modelStage.mEventOprFingerDown = Slot(self.onDragStart, self)
	self.modelStage.mEventOprFingerUp = Slot(self.onDragEnd, self)

	self.modelStage:connectImage(self.modelViewport)
	self.modelStage:initOperation(self.modelControl)

	self.btnClose = UIControls.Button(self, "BtnClose")

	self.btnClose:addEventClick(self.onBtnCloseClick)

	self.btnBuy = UIControls.Button(self, "MainInfoPanel/BtnBuy")

	self.btnBuy:addEventClick(self.onBuyBtnClick)

	self.imgMoney = UIControls.Image(self, "MainInfoPanel/BtnBuy/Icon")
	self.txtPrice = UIControls.Label(self, "MainInfoPanel/BtnBuy/TxtPrice")
	self.btnSkinStory = UIControls.Button(self, "MainInfoPanel/SkinInfoPanel/TxtPanel/TxtName/BtnSkinStory")

	self.btnSkinStory:addEventClick(self.onSkinStoryClick)

	self.toggleCoupon = UIControls.Toggle(self, "MainInfoPanel/BtnCoupon")

	self.toggleCoupon:addEventValueChanged(self.onCouponChanged)

	self.iconToggle = UIControls.Image(self, "MainInfoPanel/BtnCoupon/Icon")
	self.textCouponPriceOld = UIControls.Label(self, "MainInfoPanel/BtnCouponBuy/TxtPriceOld")
	self.textCouponPriceNew = UIControls.Label(self, "MainInfoPanel/BtnCouponBuy/TxtPriceNew")
	self.textCouponPrice = UIControls.Label(self, "MainInfoPanel/BtnCouponBuy/TxtPrice")
	self.btnCouponBuy = UIControls.Button(self, "MainInfoPanel/BtnCouponBuy")
	self.imgCouponBuy = UIControls.Image(self, "MainInfoPanel/BtnCouponBuy/Icon")

	self.btnCouponBuy:addEventClick(self.onBuyBtnClick)
end

function SkinPreviewTips:onCouponChanged()
	self:refreshCouponPart()
end

function SkinPreviewTips:refreshCouponPart(fromInit)
	self.selectCoupon = nil
	self.couponHigher = false
	self.needMoney = self._totalMoney

	local countInfo = self._curItem.data.discount_items

	if not countInfo or not countInfo[1] or not (countInfo[1] > 0) then
		self.toggleCoupon:setVisible(false)

		return
	end

	if CurAvatar:getItemNumById(countInfo[1]) <= 0 then
		self.toggleCoupon:setVisible(false)

		return
	end

	local itemData = ResItem[countInfo[1]] or {}
	local moneyInfo = self._curItem.data.use[1]
	local moneyId = moneyInfo.ID

	if not itemData or itemData.extend_args2 ~= moneyId then
		self.toggleCoupon:setVisible(false)

		return
	end

	if fromInit then
		self.toggleCoupon:setVisible(true)
		self.toggleCoupon:setOn(false)
		self.btnBuy:setVisible(false)
		self.btnCouponBuy:setVisible(true)

		local curValue = ClientUtils.getMoney(moneyId)

		self.textCouponPrice:setText(self._totalMoney)

		if curValue < self._totalMoney then
			self.textCouponPrice:setFontColor(ResColor.RED)
		end
	end

	local isOn = self.toggleCoupon:isOn()
	local couponIcon = ClientUtils.getMoneyIcon(countInfo[1])

	if couponIcon then
		self.iconToggle:setImage(couponIcon[1], couponIcon[2])
	end

	local curValue = ClientUtils.getMoney(moneyInfo.ID)

	if isOn then
		self.selectCoupon = countInfo[1]

		self.textCouponPrice:setVisible(false)
		self.textCouponPriceOld:setVisible(true)
		self.textCouponPriceNew:setVisible(true)
		self.textCouponPriceOld:setText(self._totalMoney)

		local newPrice = math.max(0, self._totalMoney - itemData.extend_args1)

		self.needMoney = newPrice
		self.couponHigher = self._totalMoney < itemData.extend_args1

		self.textCouponPriceNew:setText(newPrice)

		if curValue < self.needMoney then
			self.textCouponPriceNew:setFontColor(ResColor.RED)
			self.textCouponPriceOld:setFontColor(ResColor.RED)
		else
			self.textCouponPriceNew:setFontColor(ResColor.BLACK)
			self.textCouponPriceOld:setFontColor(ResColor.BLACK)
		end
	else
		self.textCouponPrice:setVisible(true)
		self.textCouponPriceOld:setVisible(false)
		self.textCouponPriceNew:setVisible(false)
	end
end

function SkinPreviewTips:onOpen()
	SkinPreviewTips.super.onOpen(self)
end

function SkinPreviewTips:onSkinStoryClick()
	if self.skinStoryData then
		UIManager.getUI("heroSkinStoryTips"):show(self)
	end
end

function SkinPreviewTips:onBtnCloseClick()
	self:setVisible(false)
end

function SkinPreviewTips:setObjectByGrid(skinGrid)
	local skinObj = skinGrid.object
	local modelId = skinObj:getSkinModelId()

	if modelId then
		self.skinObj = skinObj

		if self.curModelInsId then
			self.autoRotateComponent = nil

			self.modelStage:delModel(self.curModelInsId)
		end

		self.curModelInsId = self.modelStage:showHeroByModId(modelId, Const.MODEL_TYPE.ShowStepOne, nil, self._slot4LoadNewModelEnd, nil, modelId)

		if self.curModelInsId then
			self.modelStage:setOperateModel(self.curModelInsId)
		end

		self.panelBaseInfo:setData(skinObj.clientData)

		self.skinStoryData = skinObj.clientData
	else
		self:setVisible(false)
	end
end

function SkinPreviewTips:setBySkinObj(obj)
	self:setObject(obj.clientData, obj)
end

function SkinPreviewTips:setObject(skinData, obj, grid)
	self.skinObj = obj

	if self.curModelInsId then
		self.autoRotateComponent = nil

		self.modelStage:delModel(self.curModelInsId)
	end

	local modelId = skinData.model_id

	self.curModelInsId = self.modelStage:showHeroByModId(modelId, Const.MODEL_TYPE.ShowStepOne, nil, self._slot4LoadNewModelEnd, nil, modelId)

	if self.curModelInsId then
		self.modelStage:setOperateModel(self.curModelInsId)
	end

	self.panelBaseInfo:setData(skinData)
	self:_onChangeOrder(grid)

	self.skinStoryData = skinData
end

function SkinPreviewTips:_onChangeOrder(grid)
	if grid and grid.mWindow then
		self:setOrder(grid.mWindow:getOrder() + WINDOW_TIPS_ORDER)
	end
end

function SkinPreviewTips:initModelLoadedEnd(modelInsId, modelResID)
	self.autoRotateComponent = ModelTool.addAutoRotateComponent(modelInsId)

	if self.skinObj then
		ModelTool.addBaseModel(modelInsId, modelResID, 1, Const.HERO_BASE_TYPE.Hero1)
	end

	if modelInsId then
		local modelAux = ModelFactory.GetModelAux(modelInsId)

		if modelAux then
			modelAux:SetAnimatorNoCulling()
			modelAux:PlayAnimator("Newshow_idle")
		end
	end
end

function SkinPreviewTips:onDragStart()
	if self.autoRotateComponent then
		self.autoRotateComponent:EndRotate()
	end
end

function SkinPreviewTips:onDragEnd()
	if self.autoRotateComponent then
		self.autoRotateComponent:StartRotate()
	end
end

function SkinPreviewTips:playShowAnimation(modelInsId)
	if modelInsId then
		local modelAux = ModelFactory.GetModelAux(modelInsId)

		if modelAux then
			modelAux:PlayAnimatorNow("Newshow_idle")
		end
	end
end

function SkinPreviewTips:hideModel(isHide)
	self.modelControl:setVisible(not isHide)
	self.modelStage:setModelVisible(self.curModelInsId, not isHide)

	if not isHide then
		self:playShowAnimation(self.curModelInsId)
	end
end

function SkinPreviewTips:onShowSkinBuy(shopItem)
	self._curItem = shopItem

	local moneyInfo = shopItem.data.use[1]

	self._totalMoney = moneyInfo.discount

	local moneyPath = ClientUtils.getMoneyIcon(moneyInfo.ID)

	if moneyPath then
		self.imgMoney:setImage(moneyPath[1], moneyPath[2])
		self.imgCouponBuy:setImage(moneyPath[1], moneyPath[2])
	end

	local curValue = ClientUtils.getMoney(moneyInfo.ID)

	self.txtPrice:setText(self._totalMoney)

	if curValue < self._totalMoney then
		self.txtPrice:setFontColor(ResColor.RED)
	end

	self.btnBuy:setVisible(true)
	self:refreshCouponPart(true)
end

local NO_HERO_NOTICE = 280

function SkinPreviewTips:onBuyBtnClick()
	if self.skinObj then
		local heroId = self.skinObj.heroID
		local geted = CurAvatar.handBookHeroDic[heroId] ~= nil

		if geted == true then
			self:onItemBuy()
		else
			local str = ResClientNotice[NO_HERO_NOTICE].notice

			UIManager.showConfirm(UIConst.CONFIRM_TWOBTN, nil, str, Slot(self.onItemBuy, self))
		end
	end
end

function SkinPreviewTips:onItemBuy()
	local moneyInfo = self._curItem.data.use[1]

	ClientUtils.checkMoneyChange(moneyInfo.ID, self.needMoney, self._doBuy, self, true)
end

function SkinPreviewTips:_doBuy()
	if self.selectCoupon and self.couponHigher then
		local func = Functor(CurAvatar.checkItemsFull, CurAvatar, {
			self._curItem.object
		}, Slot(self.itemBuyCb, self), {
			1
		})

		UIManager.showConfirmWithId(1092, func)
	else
		CurAvatar:checkItemsFull({
			self._curItem.object
		}, Slot(self.itemBuyCb, self), {
			1
		})
	end
end

function SkinPreviewTips:itemBuyCb()
	if self.selectCoupon then
		RPC.shopExchange(self._curItem.shopID, self._curItem.id, 1, 0, nil, nil, {
			self.selectCoupon
		})
	else
		RPC.shopExchange(self._curItem.shopID, self._curItem.id, 1, 0)
	end

	self:setVisible(false)
end

return SkinPreviewTips
