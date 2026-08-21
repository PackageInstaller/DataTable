-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\DrawCard\\DrawNewbiePoolChild.lua

local ResColor = require("ClientData/ResColor")
local DrawCardUtils = require("UI/DrawCard/DrawCardUtils")
local ResDrawFakeRand = require("ClientData/ResDrawFakeRand")
local strClassName = "DrawNewbiePoolChild"
local DrawNewbiePoolChild = Class(strClassName, UIControls.Child)

function DrawNewbiePoolChild:ctor(...)
	self:initUI()
end

function DrawNewbiePoolChild:initUI(...)
	self.bannerTitle = UIControls.Label(self, "TextPoolTitle")
	self.bannerBg = UIControls.Image(self, "Bg")
	self.bannerHeroImg = UIControls.Image(self, "ImgHero")
	self.bubblePanel = UIControls.Panel(self, "ImgBubble")
	self.bubbleTxt = UIControls.Label(self, "ImgBubble/Text")
	self.buyBtn = UIControls.Button(self, "BtnBuy", "TextNum")

	self.buyBtn:addEventClick(self._onClickDraw)

	self.descTxt = UIControls.Label(self, "BtnBuy/TextBuy")
	self.costTxt = UIControls.Label(self, "PricePanel/TextSaleNum")
	self.fakeCostTxt = UIControls.Label(self, "PricePanel/TextPriceNum")
	self.costMoneyImg = UIControls.Image(self, "PricePanel/IconPrice")
	self.boughtImg = UIControls.Image(self, "PricePanel/ImgMark")
	self.gotoTaskBtn = UIControls.Button(self, "BtnTask")

	self.gotoTaskBtn:addEventClick(self._onClickGotoTask)
	self.gotoTaskBtn:setVisible(not CurAvatar:allNewbieTaskFinished())

	if UIControls.checkControlFunc(self, "limitNumPanel") then
		self.limitNumPanel = UIControls.Panel(self, "limitNumPanel")

		self.limitNumPanel:setVisible(false)

		self.node01 = UIControls.Panel(self, "limitNumPanel/Node01")
		self.node02 = UIControls.Panel(self, "limitNumPanel/Node02")
		self.remainTxt = UIControls.Label(self, "limitNumPanel/Node01/TextNum01")
	end
end

function DrawNewbiePoolChild:initData(poolType, poolId)
	self.poolType = poolType
	self.poolId = poolId

	local bannerTitle = ""
	local bannerInfo = DrawCardUtils.getPoolClientInfo(poolId)

	if bannerInfo then
		bannerTitle = bannerInfo.title or ""

		local bannerImgPath = bannerInfo.banner

		if bannerImgPath then
			local path = utils.splitString(bannerImgPath, ";")

			if path and #path == 2 then
				self.bannerBg:setImage(path[1], path[2])
			end
		end
	end

	self.poolName = bannerTitle

	self.bannerTitle:setText(bannerTitle)

	self.drawFakeRandData = ResDrawFakeRand[poolId]

	if not self.drawFakeRandData then
		return
	end

	self.needMoneyId = self.drawFakeRandData.consume_id

	if self.needMoneyId then
		self.needMoneyNum = self.drawFakeRandData.consume_num or 30
		self.needMoneyNumTen = self.drawFakeRandData.ten_consume_num or 2700

		self.costTxt:setText(self.needMoneyNum)
		self.fakeCostTxt:setText(self.needMoneyNumTen)

		local needMoneyObj = BaseObject.GetObject(self.needMoneyId)

		if needMoneyObj then
			local needMoneyIconPath = needMoneyObj:getIconPath()

			self.costMoneyImg:setImage(needMoneyIconPath[1], needMoneyIconPath[2])
		end
	end
end

function DrawNewbiePoolChild:onPanelOpen(...)
	return
end

function DrawNewbiePoolChild:onPanelClose(...)
	return
end

function DrawNewbiePoolChild:refreshPanel(...)
	local newbieData = CurAvatar.roleDrawData[Const.DrawTypeNewbie]

	if not newbieData then
		return
	end

	local hasChoosen = CurAvatar.newbieDrawHasChoosen

	self.drawEnable = CurAvatar:newbiePoolEnable()
	self.hasBought = CurAvatar:hasBoughtNewbieDraw()

	if hasChoosen then
		self.buyBtn:setVisible(false)
		self.bubblePanel:setVisible(false)
	else
		self.buyBtn:setVisible(true)

		local leftCount = DrawCardUtils.getNewbieLeftCount()
		local maxCount = DrawCardUtils.getNewbieMaxCount()

		self.hasResult = not DrawCardUtils.newbieDrawCountIs(0)

		self.boughtImg:setVisible(self.hasBought)

		if not self.hasResult then
			self.bubblePanel:setVisible(false)
			self.descTxt:setText(Lang.get(1271))
			self.buyBtn:setText(utils.format(Lang.get(30284), leftCount, maxCount))
		else
			self.descTxt:setText(Lang.get(30287))

			if leftCount <= 0 then
				self.bubblePanel:setVisible(true)
				self.bubbleTxt:setText(Lang.get(30288))
				self.buyBtn:setText(string.format(Lang.get(30285), maxCount))
			elseif leftCount <= DrawCardUtils.getNewbieRemainCount() then
				self.bubblePanel:setVisible(true)
				self.bubbleTxt:setText(Lang.get(1327))
				self.buyBtn:setText(utils.format(Lang.get(30286), ResColor.RED.ff, leftCount, maxCount))
			else
				self.bubblePanel:setVisible(false)
				self.buyBtn:setText(utils.format(Lang.get(30284), leftCount, maxCount))
			end
		end
	end

	self:_refreshRemainCount()
end

function DrawNewbiePoolChild:_refreshRemainCount(...)
	if self.limitNumPanel and CurAvatar:dayDrawCountLimitOpen() then
		self.limitNumPanel:setVisible(true)

		local todayRemain = CurAvatar:getDrawDayCount(self.poolType, Const.DayDrawMaxCountFree)

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

function DrawNewbiePoolChild:_onClickDraw(...)
	if not self.drawEnable then
		MsgManager.notice(ConditionLimitManager.getLimitUnlockDesc(Const.CONDITION_LIMIT_NEWBIE_DRAWCARD))
	elseif not self.hasBought then
		if DrawCardUtils.checkDrawCost(self.poolId, 1, true) then
			if Const.DRAW_CONFIRM_OPEN then
				local function yesFunc()
					DrawCardUtils.realDrawCard(Const.DrawTypeNewbie, 10)
				end

				local msgContent = string.format(Lang.get(111362), self.needMoneyNum)

				UIManager.showConfirm(UIConst.CONFIRM_TWOBTN, Lang.get(5), msgContent, yesFunc, nil, nil, Lang.get(104), Lang.get(7))
			else
				DrawCardUtils.realDrawCard(Const.DrawTypeNewbie, 10)
			end
		else
			ClientUtils.checkMoneyChange(self.needMoneyId, self.needMoneyNum)
		end
	elseif not DrawCardUtils.newbieDrawCountIs(0) then
		local newbieOptDlg = UIManager.getUI("drawNewbieOptDlg", true)

		newbieOptDlg:onViewResult()
	end
end

function DrawNewbiePoolChild:_onClickGotoTask(...)
	UIManager.getUI("newbieTaskDlg", true)
end

return DrawNewbiePoolChild
