-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\DrawCard\\DrawCardNewbieLightChild.lua

local ActivityPanelMixin = require("UI/OpActivity/ActivityPanelMixin")
local DrawCardUtils = require("UI/DrawCard/DrawCardUtils")
local ResDrawFakeRand = require("ClientData/ResDrawFakeRand")
local ResRandClient = require("ClientData/ResRandClient")
local CustomPoolAwardDlg = require("UI/DrawCard/CustomPoolAwardDlg")
local ResColor = require("ClientData/ResColor")
local ResHeroStrengthenDes = require("ClientData/ResHeroStrengthenDes")
local HeroCell = Class("DrawCardNewbieLightChild_HeroCell", UIControls.Panel)

function HeroCell:ctor()
	if UIControls.checkControlFunc(self, self.mPath .. "/HeroHave") then
		self.panelHave = UIControls.Panel(self, self.mPath .. "/HeroHave")
	end

	if UIControls.checkControlFunc(self, self.mPath .. "/HeroDis") then
		self.panelDis = UIControls.Panel(self, self.mPath .. "/HeroDis")
	end

	self.heroCardCell = UIControls.HeroCardChild(self, self.mPath .. "/GrideCardItem", "System/Hero/GridHeroCard", 1, 1, true)

	self.heroCardCell:setSelectCallback(Slot(self.onClickHeroCardCell, self))

	self.btnChoice = UIControls.Button(self, self.mPath .. "/BtnChoice")

	self.btnChoice:addEventClick(self.onBtnChoiceClick)

	self.btnChange = UIControls.Button(self, self.mPath .. "/BtnChange")

	self.btnChange:addEventClick(self.onBtnChangeClick)
end

function HeroCell:setData(data)
	self.heroId = data.heroId or 0
	self.groupId = data.groupId

	local checkHero = self.heroId > 0

	self.heroCardCell:setVisible(checkHero)

	if checkHero then
		self.hero = BaseObject.GetObject(self.heroId)
		self.hero.hideLv = true

		self.heroCardCell:setHero(self.hero)
	else
		self.hero = nil
	end

	self.btnChoice:setVisible(not checkHero)
	self.btnChange:setVisible(checkHero)

	if self.panelHave then
		self.panelHave:setVisible(checkHero)
	end

	if self.panelDis then
		local checkDis = false

		if checkHero then
			local curStar = CurAvatar:getHeroMaxStar(self.heroId)
			local maxStar = self.hero:getMaxStar()

			checkDis = maxStar <= curStar
		end

		self.panelDis:setVisible(checkDis)
	end
end

function HeroCell:onClickHeroCardCell(hero)
	UIManager.getUI("heroPreviewTips"):showObj(self, self.hero)
end

function HeroCell:onBtnChoiceClick()
	UIManager.getUI("drawNewbieLightChooseHeroDlg", true):initHeroChooseData(self.mParent.actObj, self.groupId)
end

function HeroCell:onBtnChangeClick()
	UIManager.getUI("drawNewbieLightChooseHeroDlg", true):initHeroChooseData(self.mParent.actObj, self.groupId, self.heroId)
end

local DrawCardNewbieLightChild = Class("DrawCardNewbieLightChild", UIControls.Child)

MixinClass(DrawCardNewbieLightChild, ActivityPanelMixin)

local ACHIEVE_STATE = {
	NotComplete = 2,
	Complete = 1
}

function DrawCardNewbieLightChild:ctor(...)
	self:initUI()
end

function DrawCardNewbieLightChild:initUI()
	if self.uiInited then
		return
	end

	self.bannerBg = UIControls.RawImage(self, "Bg")
	self.needItemIcon = UIControls.Image(self, "PricePanel/IconPrice")
	self.priceTxt = UIControls.Label(self, "PricePanel/TextPriceNum")
	self.stableTextTime = UIControls.Label(self, "TextHeroUpTime/Num")
	self.buyBtn = UIControls.Button(self, "BtnBuy")

	self.buyBtn:addEventClick(self._onClickDraw)

	self.buyOneBtn = UIControls.Button(self, "BtnBuyNumPanel/BtnOne", "Text")

	self.buyOneBtn:addEventClick(self._selectBuyOne)

	self.buyTenBtn = UIControls.Button(self, "BtnBuyNumPanel/BtnTen", "Text")

	self.buyTenBtn:addEventClick(self._selectBuyTen)

	self.btnStore = UIControls.Button(self, "BtnStore")

	self.btnStore:addEventClick(self._onClickBtnStore)

	self.heroCellList = {}

	for i = 1, 3 do
		local heroCell = HeroCell(self, "GrideCardGroup/GrideCard0" .. i)

		table.insert(self.heroCellList, heroCell)
	end

	self.textSelect = UIControls.Label(self, "TextSelect")

	if UIControls.checkControlFunc(self, "limitNumPanel") then
		self.limitNumPanel = UIControls.Panel(self, "limitNumPanel")

		self.limitNumPanel:setVisible(false)

		self.node01 = UIControls.Panel(self, "limitNumPanel/Node01")
		self.node02 = UIControls.Panel(self, "limitNumPanel/Node02")
		self.remainTxt = UIControls.Label(self, "limitNumPanel/Node01/TextNum01")
	end

	self.uiInited = true
end

function DrawCardNewbieLightChild:initData(poolId, actId)
	self.actId = actId
	self.poolId = poolId

	local poolInfo = DrawCardUtils.getPoolClientInfo(poolId)

	if poolInfo then
		local bannerImgPath = poolInfo.banner

		if bannerImgPath then
			self.bannerBg:setImage(bannerImgPath)
		end

		self.poolName = poolInfo.title or ""
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

	local actObj = CurAvatar:getActivityObj(self.actId)

	if not actObj or not actObj.actData then
		return
	end

	local startEndTime = actObj:getStartEndTime()
	local startTime = startEndTime[1]

	startTime = startTime or CurAvatar.roleCreateTick

	local endTime = startEndTime[2]
	local startTimeTxt = ClientUtils.getServerTimeData(startTime, Lang.get(30270))
	local endTimeTxt = ClientUtils.getServerTimeData(endTime, Lang.get(30270))

	self.stableTextTime:setText(startTimeTxt .. "-" .. endTimeTxt)
	self:onShowActivity({
		actObj.clientTemplateData,
		actObj
	})
end

function DrawCardNewbieLightChild:refreshPanel(...)
	if not self.actId or not self.poolId then
		return
	end

	self:_refreshDrawInfo()
	self:_refreshOpActInfo()
	self:_refreshRemainCount()
end

function DrawCardNewbieLightChild:onPanelOpen(...)
	if DrawCardUtils.checkDrawCost(self.poolId, 10, true) ~= false then
		self.totalDrawCount = 10

		self.buyOneBtn:setEnable(true)
		self.buyTenBtn:setEnable(false)
	else
		self.totalDrawCount = 1

		self.buyOneBtn:setEnable(false)
		self.buyTenBtn:setEnable(true)
	end

	local actObj = CurAvatar:getActivityObj(self.actId)

	if not actObj or not actObj.actData then
		return
	end

	if actObj and actObj:isNewOpened() then
		self.showStoreRed = true

		RPC.opActSetFocus(actObj.opId, 1)
	end

	actObj.actData.skipCheckItemNew = true

	actObj:checkNew()
end

function DrawCardNewbieLightChild:onPanelClose()
	return
end

function DrawCardNewbieLightChild:_selectBuyOne(...)
	self.totalDrawCount = 1

	self.buyOneBtn:setEnable(false)
	self.buyTenBtn:setEnable(true)
	self:refreshPanel()
end

function DrawCardNewbieLightChild:_selectBuyTen(...)
	self.totalDrawCount = 10

	self.buyOneBtn:setEnable(true)
	self.buyTenBtn:setEnable(false)
	self:refreshPanel()
end

function DrawCardNewbieLightChild:checkSelectAllUpHero()
	if self.mainUpHero.heroId > 0 and self.otherUpHeros[1].heroId > 0 and self.otherUpHeros[2].heroId > 0 then
		return true
	end

	return false
end

function DrawCardNewbieLightChild:_onClickDraw()
	if not DrawCardUtils.checkOpActCanDraw(self.actId) then
		return
	end

	if not self:checkSelectAllUpHero() then
		MsgManager.notice(Lang.get(90306))

		return
	end

	self:_realConfirm()
end

function DrawCardNewbieLightChild:_realConfirm()
	if self.hasFreeCount and self.totalDrawCount == 1 then
		if not DrawCardUtils.checkBag(1) then
			return
		end

		self:_realDraw(Const.DrawCostTypeNone)

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
		CurAvatar:drawConfirmShow(self.poolId, checkDrawCount, Functor(self._realDraw, self, drawCost))
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

function DrawCardNewbieLightChild:_realDraw(costType)
	DrawCardUtils.realDrawOpActCard(self.actId, self.totalDrawCount, costType, self.needItemId, self.needItemNum, self.poolId, Const.DrawNewBieCampLightDark)
end

function DrawCardNewbieLightChild:_onClickBtnStore()
	self.relateGiftId = self.actObj.actData.clientData.related_gift_id

	CurAvatar:jumpToShowActivity(self.relateGiftId)
end

function DrawCardNewbieLightChild:_refreshOpActInfo()
	local actObj = CurAvatar:getActivityObj(self.actId)

	if not actObj or not actObj.actData then
		return
	end

	local actData = actObj.actData

	self.actObj = actObj
	self.opId = actObj.opId
	self.alreadyDrawCount = actData.serverData.totalDrawCount
	self.heroGotList = actData.serverData.heroGotList or {}
	self.mainUpHero = actData:getMainUpHeroId()
	self.otherUpHeros = actData:getOtherHeroIds()

	for i = 1, #self.heroCellList do
		local heroCell = self.heroCellList[i]

		if i == 2 then
			heroCell:setData(self.mainUpHero)
		elseif i == 1 then
			heroCell:setData(self.otherUpHeros[1])
		else
			heroCell:setData(self.otherUpHeros[2])
		end
	end

	self.textSelect:setVisible(not self:checkSelectAllUpHero())
end

function DrawCardNewbieLightChild:_refreshDrawInfo()
	if self.needItemId then
		local curItemNum = CurAvatar:getItemNumById(self.needItemId)

		self.totalNeedItem = 0
		self.totalNeedItem = self.needItemNum * self.totalDrawCount

		if curItemNum >= self.totalNeedItem then
			self.needItemIcon:setImage(self.needItemIconPath[1], self.needItemIconPath[2])
			self.priceTxt:setText(self.totalNeedItem)
			self.priceTxt:setTextWithColorHexadecimal(self.totalNeedItem, "ffffff")
		elseif self.needMoney then
			local curMoneyNum = ClientUtils.getMoney(self.needMoneyId)

			if self.totalDrawCount == 1 then
				self.totalNeedMoney = self.needMoneyNum
			else
				self.totalNeedMoney = self.needMoneyNumTen
			end

			self.needItemIcon:setImage(self.needMoneyIconPath[1], self.needMoneyIconPath[2])

			if curMoneyNum >= self.totalNeedMoney then
				self.priceTxt:setText(self.totalNeedMoney)
			else
				self.priceTxt:setTextWithColorHexadecimal(self.totalNeedMoney, "af1202")
			end
		else
			self.needItemIcon:setImage(self.needItemIconPath[1], self.needItemIconPath[2])
			self.priceTxt:setTextWithColorHexadecimal(self.totalNeedItem, "af1202")
		end
	elseif self.needMoney then
		local curMoneyNum = ClientUtils.getMoney(self.needMoneyId)

		if self.totalDrawCount == 1 then
			self.totalNeedMoney = self.needMoneyNum
		else
			self.totalNeedMoney = self.needMoneyNumTen
		end

		self.needItemIcon:setImage(self.needMoneyIconPath[1], self.needMoneyIconPath[2])

		if curMoneyNum >= self.totalNeedMoney then
			self.priceTxt:setText(self.totalNeedMoney)
		else
			self.priceTxt:setTextWithColorHexadecimal(self.totalNeedMoney, "af1202")
		end
	end
end

function DrawCardNewbieLightChild:_refreshRemainCount(...)
	if self.limitNumPanel and CurAvatar:dayDrawCountLimitOpen() then
		self.limitNumPanel:setVisible(true)

		local todayRemain = CurAvatar:getDrawDayCount(self.opId, Const.DayDrawMaxCountFree)

		if todayRemain >= Const.DayDrawMaxCountFree then
			self.node01:setVisible(false)
			self.node02:setVisible(true)
		else
			self.node01:setVisible(true)
			self.node02:setVisible(false)
			self.remainTxt:setText(todayRemain .. "/" .. Const.DayDrawMaxCountFree)
		end
	end
end

return DrawCardNewbieLightChild
