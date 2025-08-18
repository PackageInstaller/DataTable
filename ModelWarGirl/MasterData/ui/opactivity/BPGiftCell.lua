-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\OpActivity\\BPGiftCell.lua

local RechargeManager = require("System/Recharge/RechargeManager")
local ResOpActivityAchieveMisc = require("ClientData/ResOpActivityAchieveMisc")
local GridHeroStarUp = require("UI/Hero/StarUp/GridHeroStarUp")
local ResRechargeSelLib = require("ClientData/ResRechargeSelLib")
local BPGiftCell = Class("BPGiftCell", UIControls.ScrollViewLoopCell)
local UI_STATE_INFO = {
	{
		"NmlGrowthGiftItemPay",
		"BgRewardNml2",
		"BgRewardNml"
	},
	{
		"HighGrowthGiftItemPay",
		"BgRewardFreeSel",
		"BgRewardPaySel"
	},
	{
		"DisGrowthGiftItemPay",
		"BgRewardDis2",
		"BgRewardDis"
	}
}

function BPGiftCell:ctor()
	self:initUI()
end

function BPGiftCell:initUI()
	self.starLockPanel = UIControls.Panel(self, "LockPanel")

	if UIControls.checkControlFunc(self, "TextDay") then
		self.textCondition = UIControls.Label(self, "TextDay")
	else
		self.imgStar = UIControls.Image(self, "UnLockText/Image")
	end

	self.freeGiftPanel = UIControls.Panel(self, "FreeGiftPanel")
	self.imgBgFree = UIControls.Image(self, "FreeGiftPanel/BgImage")
	self.btnConfirmFree = UIControls.Button(self, "FreeGiftPanel/BtnConfirm")

	self.btnConfirmFree:addEventClick(self.onBtnFreeClick)

	self.imgSoldOutFree = UIControls.Panel(self, "FreeGiftPanel/SoldOutImage")
	self.iconNew = UIControls.Panel(self, "FreeGiftPanel/BtnConfirm/IconNew")
	self.payGiftPanel = UIControls.Panel(self, "PayGiftPanel")
	self.imgBgPay = UIControls.Image(self, "PayGiftPanel/BgImage")
	self.btnConfirmPay = UIControls.Button(self, "PayGiftPanel/BtnConfirm", "Text")

	self.btnConfirmPay:addEventClick(self.onBtnPayClick)

	self.txtBuyCount = UIControls.Label(self, "PayGiftPanel/PayNum")
	self.imgSoldOutPay = UIControls.Panel(self, "PayGiftPanel/SoldOutImage")
	self.freeItems = {}
	self.payItems = {}
	self.resPath = "Atlas/ActivityAtlas/"
	self.resName = "ActivityHeroGrowthGiftAtlas1"

	if self.mParent.replaceableCellPath and self.mParent.replaceableCellPath[2] then
		self.resName = self.mParent.replaceableCellPath[2]
	end

	self.gridConfig = {}
	self.gridConfig.checkNeedConvertObject = true

	if UIControls.checkControlFunc(self, "UnLockText") then
		self.unLockText = UIControls.Image(self, "UnLockText")
	end

	if UIControls.checkControlFunc(self, "GirdPanel") then
		self.girdPanel = UIControls.Panel(self, "GirdPanel")
	end

	if UIControls.checkControlFunc(self, "BgTextLv/Text") then
		self.textLv = UIControls.Label(self, "BgTextLv/Text")
	end

	if UIControls.checkControlFunc(self, "BgTextSlider/Text") then
		self.textSlider = UIControls.Label(self, "BgTextSlider/Text")
	end

	if UIControls.checkControlFunc(self, "Slider") then
		self.slider = UIControls.Slider(self, "Slider")
	end

	if ChannelUtil.isDMMGame() and UIControls.checkControlFunc(self, "PayGiftPanel/BtnConfirm/TextPt") then
		self.priceDmmPanel = UIControls.Panel(self, "PayGiftPanel/BtnConfirm/TextPt")

		self.priceDmmPanel:setVisible(true)
	end
end

function BPGiftCell:setData(data, svrData, objGift, rechargeId)
	self.actId = self.mParent.actObj.actId
	self.data = data
	self.svrData = svrData
	self.rechargeId = rechargeId
	self.objGift = objGift
	self.state = svrData:getAchieveState(data.type, data.index)

	self:refreshFreePart()
	self:refreshPayPart(objGift, rechargeId)
	self:refreshHeroPart()
end

function BPGiftCell:refreshFreePart()
	for _, gridItem in ipairs(self.freeItems) do
		gridItem:destroy()
	end

	self.freeItems = {}

	ClientUtils.CreateBonusGrid(self, self.freeItems, "FreeGiftPanel/ItemNode", self.data.award, true, nil, true, nil, nil, self.gridConfig)

	for index, grid in ipairs(self.freeItems) do
		grid:setGet(self.state == Const.ACT_ACHIEVE_STATE_GOT)
	end

	self.starLockPanel:setVisible(self.state == Const.ACT_ACHIEVE_STATE_NOT_ENOUGH)
	self.btnConfirmFree:setVisible(self.state ~= Const.ACT_ACHIEVE_STATE_GOT)

	if self.state == Const.ACT_ACHIEVE_STATE_NOT_ENOUGH then
		self.btnConfirmFree:setImage("Atlas/CommonAtlas/BtnAtlas2", "BtnCommonFir01Dis")
	else
		self.btnConfirmFree:setImage("Atlas/CommonAtlas/BtnAtlas2", "BtnCommonFir01Nml")
	end

	self.iconNew:setVisible(self.state == Const.ACT_ACHIEVE_STATE_ENOUGH)
	self.imgSoldOutFree:setVisible(self.state == Const.ACT_ACHIEVE_STATE_GOT)

	local uiInfo = UI_STATE_INFO[self.state]

	self.imgBgFree:setImage(self.resPath .. self.resName, uiInfo[2])
end

function BPGiftCell:refreshPayPart(objGift, rechargeId)
	if not rechargeId then
		self.payGiftPanel:setVisible(false)

		return
	end

	self.giftChooseLib = nil
	self.chooseResult = nil

	local clientActCachedData = CurAvatar:getClientActivityCachedData(self.actId)

	self.chooseResult = clientActCachedData[rechargeId] or {}

	self.payGiftPanel:setVisible(true)

	for _, gridItem in ipairs(self.payItems) do
		gridItem:destroy()
	end

	self.payItems = {}

	local product = RechargeManager.getProductByRechargeId(rechargeId)
	local buyCount = 0

	if objGift.actData.serverData[rechargeId] then
		buyCount = objGift.actData.serverData[rechargeId].count or 0
	end

	self.canBuyCount = product.buyTimesMax - buyCount

	ClientUtils.CreateBonusGrid(self, self.payItems, "PayGiftPanel/ItemNode", product.randId, true, nil, true, nil, nil, self.gridConfig)

	self.giftBonusNum = 0

	for index, grid in ipairs(self.payItems) do
		grid:setGet(self.canBuyCount <= 0)
		grid:setAddMode(false)

		if grid:getVisible() then
			self.giftBonusNum = index
		end
	end

	self:_refreshGiftChoosenState(product)
	self.txtBuyCount:setText(string.format(Lang.get(30608), buyCount, product.buyTimesMax))
	self.btnConfirmPay:setVisible(self.canBuyCount > 0)

	if self.state == Const.ACT_ACHIEVE_STATE_NOT_ENOUGH then
		self.btnConfirmPay:setImage("Atlas/CommonAtlas/BtnAtlas2", "BtnCommonFir01Dis")
	else
		self.btnConfirmPay:setImage("Atlas/CommonAtlas/BtnAtlas2", "BtnCommonFir02Nml")
	end

	self.imgSoldOutPay:setVisible(self.canBuyCount <= 0)
	self.btnConfirmPay:setText(product.priceText)

	local state = Const.ACT_ACHIEVE_STATE_NOT_ENOUGH

	if self.state ~= Const.ACT_ACHIEVE_STATE_NOT_ENOUGH then
		state = self.canBuyCount > 0 and Const.ACT_ACHIEVE_STATE_ENOUGH or Const.ACT_ACHIEVE_STATE_GOT
	end

	local uiInfo = UI_STATE_INFO[state]

	self.imgBgPay:setImage(self.resPath .. self.resName, uiInfo[3])
	self.payGiftPanel:playStateAnimator(UI_STATE_INFO[state][1])
end

function BPGiftCell:_refreshGiftChoosenState(product)
	product = product or RechargeManager.getProductByRechargeId(self.rechargeId)

	if product and product.selLib and #product.selLib > 0 then
		self.giftChooseLib = product.selLib

		for index = #self.payItems + 1, self.giftBonusNum + #product.selLib do
			local newGrid = UIControls.getGridAwardContainer(self, "PayGiftPanel/ItemNode")

			table.insert(self.payItems, newGrid)
		end

		for index = 1, #product.selLib do
			local grid = self.payItems[self.giftBonusNum + index]

			grid:setVisible(true)

			local changeFunc = Functor(self.onChangeGift, self, index)

			grid:setAddMode(true, changeFunc, changeFunc)
			grid:setObj(nil)
			grid:setGet(self.canBuyCount <= 0)
		end

		self:_refreshGiftChoosenResult()
	end
end

function BPGiftCell:onChangeGift(pos, grid)
	if self.giftChooseLib then
		UIManager.getUI("giftChooseBox", true):onShow(self.giftChooseLib, self, Slot(self.onChooseGift, self), self.chooseResult, pos)
	end
end

function BPGiftCell:_refreshGiftChoosenResult()
	local chooseResult = self.chooseResult or {}

	for index, libId in ipairs(self.giftChooseLib) do
		local grid = self.payItems[self.giftBonusNum + index]
		local libData = ResRechargeSelLib[libId]
		local chooseIndex = chooseResult[index]

		if chooseIndex and libData and libData[chooseIndex] then
			grid:onShowRandClient(libData[chooseIndex].rand_id)
		else
			grid:setObj(nil)
		end

		grid:setGet(self.canBuyCount <= 0)
	end
end

function BPGiftCell:onChooseGift(chooseResult)
	self.chooseResult = chooseResult

	local clientActCachedData = CurAvatar:getClientActivityCachedData(self.actId)

	clientActCachedData[self.rechargeId] = chooseResult

	CurAvatar:saveClientActivityCachedData(self.actId, clientActCachedData)
	self:_refreshGiftChoosenResult()
end

function BPGiftCell:refreshHeroPart()
	if self.gridHero then
		self.gridHero:destroy()

		self.gridHero = nil
	end

	local miscData = ResOpActivityAchieveMisc[self.data.detail_id] and ResOpActivityAchieveMisc[self.data.detail_id][self.data.type] or nil

	if miscData and miscData.arg then
		local heroId = miscData.arg
		local fakeHero = BaseObject.GetObject(heroId)

		fakeHero.star = self.data.param
		self.gridHero = GridHeroStarUp(self, "GirdPanel", "System/StarUp/GridHeroStarUp")

		self.gridHero:setHero(fakeHero)
		self.gridHero:setOnlyShowHead()
		self.gridHero.btnHeroHead:setEnable(false)
		self.gridHero.panelOtherInfo:setVisible(true)
		self.gridHero:setVisible(true)
	end

	if self.textCondition then
		self.textCondition:setText(self.data.desc_name or "")
	else
		local iconName

		if self.data.param < 10 then
			iconName = "IconStarL0" .. self.data.param
		else
			iconName = "IconStarL" .. self.data.param
		end

		self.imgStar:setImage("Atlas/HeroAtlas/HeroAtlas", iconName)
	end

	if self.data.type == Const.ACT_TYPE_ENCORE_HERO or self.data.type == Const.ACT_TYPE_ENCORE_HERO_LIGHT_DARK then
		if self.unLockText then
			self.unLockText:setVisible(false)
		end

		if self.girdPanel then
			self.girdPanel:setVisible(false)
		end

		if self.textLv then
			if Const.REVIEW_VERSION then
				self.textLv:setText(string.format(Lang.get(111361), self.data.index))
			else
				self.textLv:setText(string.format("LV.%d", self.data.index))
			end
		end

		if self.textSlider then
			self.textSlider:setText(self.data.param)
		end

		if self.slider then
			if self.state ~= Const.ACT_ACHIEVE_STATE_NOT_ENOUGH then
				self.slider:setValue(1)
			else
				local progress = 0

				if self.svrData.serverData[self.data.type] then
					progress = self.svrData:getAchieveProgress(self.data.type)
				end

				if self.mParent.cellsData then
					local lastPro = 0

					if self.mParent.cellsData[self.data.index - 1] then
						lastPro = self.mParent.cellsData[self.data.index - 1].param
					end

					if progress - lastPro > 0 then
						self.slider:setValue((progress - lastPro) / (self.data.param - lastPro))
					else
						self.slider:setValue(0)
					end
				end
			end
		end
	end
end

function BPGiftCell:onBtnFreeClick()
	if self.mEventClickFree then
		self:mEventClickFree()
	end
end

function BPGiftCell:onBtnPayClick()
	if self.giftChooseLib then
		local chooseResult = self.chooseResult or {}

		for index, _ in ipairs(self.giftChooseLib) do
			if not chooseResult[index] then
				MsgManager.clientNotice(429)

				return
			end
		end
	end

	if self.mEventClickPay then
		self:mEventClickPay()
	end
end

return BPGiftCell
