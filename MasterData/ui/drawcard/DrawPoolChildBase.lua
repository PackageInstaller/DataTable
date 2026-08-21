-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\DrawCard\\DrawPoolChildBase.lua

local ResDrawFakeRand = require("ClientData/ResDrawFakeRand")
local DrawCardUtils = require("UI/DrawCard/DrawCardUtils")
local strClassName = "DrawPoolChildBase"
local DrawPoolChildBase = Class(strClassName, UIControls.Child)

function DrawPoolChildBase:ctor(...)
	return
end

function DrawPoolChildBase:initCommonUI(...)
	self.bannerTitle = UIControls.Label(self, "TextPoolTitle")
	self.bannerRule = UIControls.Label(self, "TextRule")
	self.bannerBg = UIControls.RawImage(self, "Bg")
	self.needItemIcon = UIControls.Image(self, "PricePanel/IconPrice")
	self.priceTxt = UIControls.Label(self, "PricePanel/TextPriceNum")
	self.freeLineImg = UIControls.Image(self, "PricePanel/TextPriceNum/ImgLine")
	self.freeTxt = UIControls.Label(self, "PricePanel/TextFree")
	self.buyBtn = UIControls.Button(self, "BtnBuy", "TextNum")

	self.buyBtn:addEventClick(self._onClickDraw)

	if UIControls.checkControlFunc(self, "limitNumPanel") then
		self.limitNumPanel = UIControls.Panel(self, "limitNumPanel")

		self.limitNumPanel:setVisible(false)

		self.node01 = UIControls.Panel(self, "limitNumPanel/Node01")
		self.node02 = UIControls.Panel(self, "limitNumPanel/Node02")
		self.remainTxt = UIControls.Label(self, "limitNumPanel/Node01/TextNum01")
	end
end

function DrawPoolChildBase:initData(poolType, poolId)
	self.poolType = poolType
	self.poolId = poolId

	local bannerTitle = ""
	local bannerRule = ""
	local bannerInfo = DrawCardUtils.getPoolClientInfo(poolId)

	if bannerInfo then
		bannerTitle = bannerInfo.title or ""
		bannerRule = bannerInfo.rule or ""

		local bannerImgPath = bannerInfo.banner

		if bannerImgPath then
			self.bannerBg:setImage(bannerImgPath)
		end
	end

	self.poolName = bannerTitle

	if self.bannerTitle then
		self.bannerTitle:setText(bannerTitle)
	end

	if self.bannerRule then
		self.bannerRule:setText(bannerRule)
	end

	self.drawFakeRandData = ResDrawFakeRand[poolId]

	if not self.drawFakeRandData then
		return
	end

	self.needItemId = self.drawFakeRandData.item_id
	self.needItemNum = self.drawFakeRandData.item_num or 1

	if self.needItemId then
		local needItemObj = BaseObject.GetObject(self.needItemId)

		if needItemObj then
			self.needItemIconPath = needItemObj:getIconPath()
		end
	end

	self.needMoneyId = self.drawFakeRandData.consume_id

	if self.needMoneyId then
		self.needMoneyNum = self.drawFakeRandData.consume_num or 30
		self.needMoneyNumTen = self.drawFakeRandData.ten_consume_num or 2700

		local needMoneyObj = BaseObject.GetObject(self.needMoneyId)

		if needMoneyObj then
			self.needMoneyIconPath = needMoneyObj:getIconPath()
		end
	end

	if self._initData then
		self:_initData()
	end
end

function DrawPoolChildBase:refreshPanel(...)
	if self._refreshPanel then
		self:_refreshPanel()
	end
end

function DrawPoolChildBase:onPanelOpen(...)
	return
end

function DrawPoolChildBase:onPanelClose(...)
	return
end

function DrawPoolChildBase:_onClickDraw(...)
	if not CurAvatar:playerNameInited() then
		CurAvatar:setRoleCreatedCallback(Slot(self._onClickDraw, self))

		local createRoleDlg = UIManager.getUI("createRoleDlg", true)

		return
	end

	if self.hasFreeCount and self.totalDrawCount == 1 then
		if not DrawCardUtils.checkBag(1) then
			return
		end

		DrawCardUtils.realDrawCard(self.poolType, 1, Const.DrawCostTypeNone, self.needItemId, self.needItemNum, self.poolId, self.currentSelectGroup)

		return
	end

	if not DrawCardUtils.checkBag(self.totalDrawCount) then
		return
	end

	local checkDrawCount = self.totalDrawCount

	if checkDrawCount <= 0 then
		checkDrawCount = 1
	end

	local drawCost = DrawCardUtils.checkDrawCost(self.poolId, checkDrawCount, true)

	if drawCost ~= false then
		CurAvatar:drawConfirmShow(self.poolId, checkDrawCount, Functor(self._realDrawCard, self, drawCost))
	elseif self.needMoneyId and self.needMoneyNum then
		local needMoney

		if checkDrawCount == 10 then
			needMoney = self.needMoneyNumTen
		else
			needMoney = self.needMoneyNum * checkDrawCount
		end

		ClientUtils.checkMoneyChange(self.needMoneyId, needMoney)
	else
		MsgManager.notice(Lang.get(200))
	end
end

function DrawPoolChildBase:_realDrawCard(costType)
	local checkDrawCount = self.totalDrawCount

	if checkDrawCount <= 0 then
		checkDrawCount = 1
	end

	DrawCardUtils.realDrawCard(self.poolType, checkDrawCount, costType, self.needItemId, self.needItemNum, self.poolId, self.currentSelectGroup)
end

return DrawPoolChildBase
