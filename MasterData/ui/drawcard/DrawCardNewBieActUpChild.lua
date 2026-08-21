-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\DrawCard\\DrawCardNewBieActUpChild.lua

local ActivityPanelMixin = require("UI/OpActivity/ActivityPanelMixin")
local DrawCardUtils = require("UI/DrawCard/DrawCardUtils")
local ResDrawFakeRand = require("ClientData/ResDrawFakeRand")
local ResRandClient = require("ClientData/ResRandClient")
local HeroPoolWishCell = Class("HeroPoolWishCell", UIControls.Child)

function HeroPoolWishCell:ctor(...)
	self:initUI()
end

function HeroPoolWishCell:initUI(...)
	self.btnSelf = UIControls.Button(self, "")

	self.btnSelf:addEventClick(self.onBtnSelfClick)

	self.statePanel = UIControls.Panel(self, "StatePanel")
	self.getPanel = UIControls.Panel(self, "GetPanel")
	self.heroPanel = UIControls.HeroHeadGridPanel(self, "GridHeroPoolWish")
	self.heroPanel.mEventClick = Slot(self._onClickRootBtn, self)

	self.heroPanel.btnHeroHead:addEventHoldClick(Slot(self._onHoldRootBtn, self))
end

function HeroPoolWishCell:setWishHero(career, heroId, drawCount, maxDrawNum)
	self.heroId = heroId
	self.career = career

	self.heroPanel:setVisible(true)

	local hero = BaseObject.GetObject(heroId)

	self.heroPanel:setObj(hero)
	self.getPanel:setVisible(maxDrawNum <= drawCount)
	self.statePanel:setVisible(career == self.mParent.curCareer)
	self.btnSelf:setEnable(career ~= self.mParent.curCareer)
end

function HeroPoolWishCell:onBtnSelfClick()
	for i, cell in pairs(self.mParent.heroWishCells) do
		cell.statePanel:setVisible(false)
		cell.btnSelf:setEnable(true)
	end

	self.statePanel:setVisible(true)
	self.btnSelf:setEnable(false)
	self.mParent:playSwitchAni(self.career)
end

function HeroPoolWishCell:_onClickRootBtn()
	if self.mParent.cellClickCallback then
		self.mParent.cellClickCallback(self.heroId)
	end
end

function HeroPoolWishCell:_onHoldRootBtn(...)
	if self.heroId then
		local object = BaseObject.GetObject(self.heroId)

		UIManager.getUI("heroTips"):showObj(self, object)
	end
end

local DrawCardNewBieActUpChild = Class("DrawCardNewBieActUpChild", UIControls.Child)

MixinClass(DrawCardNewBieActUpChild, ActivityPanelMixin)

function DrawCardNewBieActUpChild:ctor(...)
	self:initUI()
end

function DrawCardNewBieActUpChild:initUI()
	if self.uiInited then
		return
	end

	self.bannerBg = UIControls.RawImage(self, "Bg")
	self.needItemIcon = UIControls.Image(self, "PricePanel/IconPrice")
	self.priceTxt = UIControls.Label(self, "PricePanel/TextPriceNum")
	self.stableTextTime = UIControls.Label(self, "TextNumTime/TextTime")
	self.discountPanel = UIControls.Panel(self, "BtnBuyNumPanel/BtnTen/ImgSale")
	self.discountInfoTxt = UIControls.Label(self, "BtnBuyNumPanel/BtnTen/ImgSale/TextDiscount")
	self.discountItemImg = UIControls.Image(self, "BtnBuyNumPanel/BtnTen/ImgSale/Icon")
	self.discountNumTxt = UIControls.Label(self, "BtnBuyNumPanel/BtnTen/ImgSale/TextSaleNum")
	self.buyBtn = UIControls.Button(self, "BtnBuy")

	self.buyBtn:addEventClick(self._onClickDraw)

	self.buyOneBtn = UIControls.Button(self, "BtnBuyNumPanel/BtnOne", "Text")

	self.buyOneBtn:addEventClick(self._selectBuyOne)

	self.buyTenBtn = UIControls.Button(self, "BtnBuyNumPanel/BtnTen", "Text")

	self.buyTenBtn:addEventClick(self._selectBuyTen)

	self.btnNextRound = UIControls.Button(self, "BtnNextRound")

	self.btnNextRound:addEventClick(self.onBtnNextRoundClick)

	self.textSelect = UIControls.Label(self, "TextTips/TextSelect")
	self.textNextRound = UIControls.Label(self, "TextTips/TextNextRound")
	self.textSellOut = UIControls.Label(self, "TextTips/TextSellOut")
	self.textNumber = UIControls.Label(self, "TextTips/TextNumber")
	self.poolPanelUI = {}
	self.expPanelUI = {}

	for i = 1, 5 do
		local panelAni = UIControls.UIAni(self, "PoolPanel" .. i)
		local btnLock = UIControls.Button(self, "PoolPanel" .. i .. "/LockPanel")

		btnLock:addEventClick(Functor(self.onBtnLockClick, self, i))

		local lockPanel = UIControls.Panel(self, "PoolPanel" .. i .. "/LockPanel")
		local textNum = UIControls.Label(self, "PoolPanel" .. i .. "/LockPanel/TextNum")
		local heroPanel = UIControls.Panel(self, "PoolPanel" .. i .. "/BtnHeroPoolWish3")
		local addButton = UIControls.Button(self, "PoolPanel" .. i .. "/AddPanel")

		addButton:addEventClick(Functor(self.onAddButtonClick, self, i))

		local iconNew = UIControls.Image(self, "PoolPanel" .. i .. "/IconNew")

		table.insert(self.poolPanelUI, {
			panelAni = panelAni,
			lockPanel = lockPanel,
			textNum = textNum,
			addButton = addButton,
			heroPanel = heroPanel,
			iconNew = iconNew
		})

		local panelAni = UIControls.UIAni(self, "ExpPanel/ExpPanel" .. i)
		local expPanel = UIControls.Panel(self, "ExpPanel/ExpPanel" .. i)
		local imgRole = UIControls.Role(self, "ExpPanel/ExpPanel" .. i .. "/GridHeroPortrait", 0, 0)
		local achPanel = UIControls.Panel(self, "ExpPanel/ExpPanel" .. i .. "/ExpPanel")
		local expTxt = UIControls.Label(self, "ExpPanel/ExpPanel" .. i .. "/ExpPanel/ExpText")
		local expSlider = UIControls.Slider(self, "ExpPanel/ExpPanel" .. i .. "/ExpPanel/ExpSlider")
		local expStateImg = UIControls.Image(self, "ExpPanel/ExpPanel" .. i .. "/ExpPanel/ImgState")
		local awardAni = UIControls.UIAni(self, "ExpPanel/ExpPanel" .. i .. "/ExpPanel/BtnPreview")
		local emojiText = UIControls.Label(self, "ExpPanel/ExpPanel" .. i .. "/ExpPanel/BtnTips/BgText/EmojiText")
		local getAwardBtn = UIControls.Button(self, "ExpPanel/ExpPanel" .. i .. "/ExpPanel/BtnPreview/BtnGet")

		getAwardBtn:addEventClick(Functor(self._onClickGetAward, self, i))

		local tipsBtn = UIControls.Button(self, "ExpPanel/ExpPanel" .. i .. "/ExpPanel/BtnTips")

		tipsBtn:addEventClick(Functor(self._onClickTips, self, i))
		table.insert(self.expPanelUI, {
			panelAni = panelAni,
			expPanel = expPanel,
			achPanel = achPanel,
			imgRole = imgRole,
			expTxt = expTxt,
			expSlider = expSlider,
			getAwardBtn = getAwardBtn,
			expStateImg = expStateImg,
			awardAni = awardAni,
			emojiText = emojiText
		})
	end

	self.expPanel0Ani = UIControls.UIAni(self, "ExpPanel/ExpPanel0")
	self.expPanel0 = UIControls.Panel(self, "ExpPanel/ExpPanel0")
	self.expPanel0Text = UIControls.Label(self, "ExpPanel/ExpPanel0/Text")
	self.expPanel0Bg = UIControls.Image(self, "ExpPanel/ExpPanel0/Bg")

	if UIControls.checkControlFunc(self, "limitNumPanel") then
		self.limitNumPanel = UIControls.Panel(self, "limitNumPanel")

		self.limitNumPanel:setVisible(false)

		self.node01 = UIControls.Panel(self, "limitNumPanel/Node01")
		self.node02 = UIControls.Panel(self, "limitNumPanel/Node02")
		self.remainTxt = UIControls.Label(self, "limitNumPanel/Node01/TextNum01")
	end

	self.heroWishCells = {}
	self.uiInited = true
end

function DrawCardNewBieActUpChild:initData(poolId, actId)
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

	self.needMoneyId = self.drawFakeRandData.consume_id
	self.needMoney = self.needMoneyId ~= nil

	if self.needMoney then
		self.needMoneyNum = self.drawFakeRandData.consume_num or 30
		self.needMoneyNumTen = self.drawFakeRandData.ten_consume_num or 2700

		local needMoneyObj = BaseObject.GetObject(self.needMoneyId)

		if needMoneyObj then
			self.needMoneyIconPath = needMoneyObj:getIconPath()

			self.discountItemImg:setImage(self.needMoneyIconPath[1], self.needMoneyIconPath[2])
		end

		self.discountNumTxt:setText(self.needMoneyNumTen)
		self.discountInfoTxt:setText(DrawCardUtils.calcDisconnectTex())
	end

	self.discountPanel:setVisible(self.needMoney and self.needMoneyNumTen < self.needMoneyNum * 10)

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

function DrawCardNewBieActUpChild:getCurCareer()
	return self.curCareer
end

function DrawCardNewBieActUpChild:refreshPanel(...)
	if not self.actId or not self.poolId then
		return
	end

	self:_refreshDrawInfo()
	self:_refreshOpActInfo()
	self:_refreshRemainCount()
end

function DrawCardNewBieActUpChild:onPanelClose()
	return
end

function DrawCardNewBieActUpChild:onPanelOpen(...)
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

function DrawCardNewBieActUpChild:_refreshDrawInfo()
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

function DrawCardNewBieActUpChild:changePanelInfo(career)
	if career then
		self.curCareer = career
	end
end

function DrawCardNewBieActUpChild:_refreshOpActInfo()
	local actObj = CurAvatar:getActivityObj(self.actId)

	if not actObj or not actObj.actData then
		return
	end

	self.actObj = actObj
	self.actData = actObj.actData
	self.opId = actObj.opId
	self.gridConfigId = actObj.clientTemplateData.grid_id or nil
	self.alreadyAllDrawCount = self.actData.totalDrawCount or 0
	self.unlockCareer = self.actData:getUnlockCareer()

	if self.curCareer == nil then
		if self.actData:checkAllCareerDrawOver() then
			self.curCareer = self.unlockCareer[1]
		else
			for i, v in ipairs(self.unlockCareer) do
				if not self.actData:checkOneCareerDrawOver(v) then
					self.curCareer = v

					break
				end
			end

			if self.curCareer == nil then
				self.curCareer = self.unlockCareer[1]
			end
		end
	end

	for index, panel in ipairs(self.poolPanelUI) do
		local unlockDrawNum = self.actData.miscData.unlock_draw_count[index]
		local career = self.unlockCareer[index]

		if career or unlockDrawNum <= self.alreadyAllDrawCount then
			local heroId = self.actData:getSetHeroId(career)

			panel.lockPanel:setVisible(false)

			if heroId and heroId ~= 0 then
				panel.addButton:setVisible(false)

				local cell = self.heroWishCells[index]

				cell = cell or HeroPoolWishCell(self, "PoolPanel" .. index .. "/BtnHeroPoolWish3", "System/HeroPool/BtnHeroPoolWish3", 0, 0, true)

				local careerDrawCount = self.actData.careerDrawData[career].totalDrawCount
				local maxDrawNum = self.actData.clientData[career].max_count_one_cycle * self.actData.cycle

				cell:setWishHero(career, heroId, careerDrawCount, maxDrawNum)
				cell:setVisible(true)

				self.heroWishCells[index] = cell
			else
				panel.addButton:setVisible(true)

				if self.heroWishCells[index] then
					self.heroWishCells[index]:setVisible(false)
				end
			end

			panel.heroPanel:setVisible(true)
			panel.iconNew:setVisible(self.actData:focusAchieveStateByCareer(career) == Const.ACT_ACHIEVE_STATE_ENOUGH)
		else
			panel.addButton:setVisible(false)
			panel.heroPanel:setVisible(false)
			panel.lockPanel:setVisible(true)
			panel.textNum:setText(unlockDrawNum - self.alreadyAllDrawCount)
		end
	end

	if self.actData:getSetHeroId(self.unlockCareer[1]) == 0 then
		self.expPanel0:setVisible(true)
		self.expPanel0Ani:startAni("RightIn")

		for i, panel in pairs(self.expPanelUI) do
			panel.expPanel:setVisible(false)
		end

		local isHaveAchieve = self.actData:checkCurCycleHaveAchieve()

		self.expPanel0Text:setVisible(isHaveAchieve)
		self.expPanel0Bg:setVisible(isHaveAchieve)
	else
		self.expPanel0:setVisible(false)
		self:refreshAchievePanel()
	end

	self.btnNextRound:setVisible(self.actData:checkAllCareerDrawOver() and not self.actData:isMaxCycle())
	self.textNextRound:setVisible(self.actData:checkAllCareerDrawOver() and not self.actData:isMaxCycle())
	self.buyBtn:setVisible(not self.actData:checkAllCareerDrawOver())

	local heroId = self.actData:getSetHeroId(self.curCareer)

	self.textSelect:setVisible(not heroId or heroId == 0)

	if not self.actData:checkAllCareerDrawOver() then
		if not self.textSelect:getVisible() then
			local remainCount = self.actData:getCareerRemainCount(self.curCareer)

			self.textSellOut:setVisible(remainCount <= 0)
			self.textNumber:setVisible(remainCount > 0)
			self.textNumber:setText(string.format(Lang.get(92476), remainCount))
		else
			self.textSellOut:setVisible(false)
			self.textNumber:setVisible(false)
		end
	else
		self.textSellOut:setVisible(false)
		self.textNumber:setVisible(false)
	end
end

function DrawCardNewBieActUpChild:_refreshRemainCount(...)
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

function DrawCardNewBieActUpChild:refreshAchievePanel()
	for i, panel in pairs(self.expPanelUI) do
		panel.expPanel:setVisible(i == self.curCareer)
	end

	local curExpPanel = self.expPanelUI[self.curCareer]

	self.achieveData = self.actData:_clientDataAchievePostInit()
	self.achieveObj = self.actData:getRelaAchieveObj()

	if self.achieveObj then
		self.opAchieveId = self.achieveObj.opId

		local achieveType = self.actData:getCareerAchieveType(self.curCareer)
		local focusIdx = self.actData:getFocusAchieveIdxByCareer(self.curCareer)
		local isHaveAchieve = self.actData:checkCurCycleHaveAchieve(self.curCareer)

		if not isHaveAchieve then
			curExpPanel.achPanel:setVisible(false)
		else
			curExpPanel.achPanel:setVisible(true)

			local awardInfo = self.achieveData[self.curCareer][focusIdx]

			if not awardInfo or not awardInfo.award or not awardInfo.count then
				return
			end

			local focusAward = awardInfo.award
			local targetCount = awardInfo.count

			self.awardState = self.actData:focusAchieveStateByCareer(self.curCareer)

			local needReduceNum = (self.actData.cycle - 1) * self.actData.clientData[self.curCareer].max_count_one_cycle
			local mom = targetCount - needReduceNum >= 0 and targetCount - needReduceNum or 0

			if self.awardState == Const.ACT_ACHIEVE_STATE_ENOUGH then
				curExpPanel.expTxt:setText(mom .. "/" .. mom)
				curExpPanel.expSlider:setValue(1)
				curExpPanel.expStateImg:setVisible(false)
				curExpPanel.awardAni:startAniLoop("LoopHeroUpCardGet")
			elseif self.awardState == Const.ACT_ACHIEVE_STATE_NOT_ENOUGH then
				local son = self.achieveObj.actData:getAchieveProgress(achieveType)

				son = son - needReduceNum >= 0 and son - needReduceNum or 0

				curExpPanel.expTxt:setText(son .. "/" .. mom)

				local percent = math.min(1, son / mom)

				curExpPanel.expSlider:setValue(percent)
				curExpPanel.expStateImg:setVisible(false)
				curExpPanel.awardAni:startAni("ResetHeroUpCardGet", true)
			elseif self.awardState == Const.ACT_ACHIEVE_STATE_GOT then
				curExpPanel.expTxt:setText(mom .. "/" .. mom)
				curExpPanel.expSlider:setValue(1)
				curExpPanel.expStateImg:setVisible(true)
				curExpPanel.awardAni:startAni("ResetHeroUpCardGet", true)
			end

			curExpPanel.getAwardBtn:setVisible(self.awardState == Const.ACT_ACHIEVE_STATE_ENOUGH)

			self.awardIdx = focusIdx

			for _, grid in ipairs(self.targetAwardGrids or {}) do
				grid:destroy()
			end

			self.targetAwardGrids = {}

			local itemList = ResRandClient[focusAward].show_ids

			for i, itemId in ipairs(itemList) do
				local itemNum = ResRandClient[focusAward].show_nums[i] or 1
				local fakeItem = BaseObject.GetObject(itemId, itemNum)
				local awardGrid = UIControls.getGridChild(fakeItem, self, "ExpPanel/ExpPanel" .. self.curCareer .. "/ExpPanel/BtnPreview/GridPanel")

				awardGrid:setObj(fakeItem)
				awardGrid:setVisible(true)

				awardGrid.mDisableWays = true
				awardGrid.mEnableTips = false
				awardGrid._onGridClick = Slot(self._onClickAward, self)

				table.insert(self.targetAwardGrids, awardGrid)
			end
		end
	end

	local heroId = self.actData:getSetHeroId(self.curCareer)

	if heroId and heroId ~= 0 then
		local hero = BaseObject.GetObject(heroId)

		curExpPanel.emojiText:setText(string.format(Lang.get(93287), hero.name))

		local portId = hero:getShowPortId()

		curExpPanel.imgRole:showRole(portId)

		local pos = curExpPanel.imgRole:getPosition()

		curExpPanel.imgRole:setAbsPosition(pos.x, pos.y - 120)
	end
end

function DrawCardNewBieActUpChild:playSwitchAni(career)
	if self.expPanel0:getVisible() then
		self.expPanel0Ani:startAni("LeftOut")
	else
		self.expPanelUI[self.curCareer].panelAni:startAni("LeftOut")
	end

	self.curCareer = career

	self:refreshPanel()
	self.expPanelUI[career].panelAni:startAni("RightIn")
end

function DrawCardNewBieActUpChild:onBtnLockClick(index)
	MsgManager.notice(string.format(Lang.get(92477), self.actData.miscData.unlock_draw_count[index] - self.alreadyAllDrawCount))
end

function DrawCardNewBieActUpChild:onAddButtonClick()
	UIManager.getUI("drawCareerChooseHeroDlg", true):setData(self.actObj)
end

function DrawCardNewBieActUpChild:_onClickTips(career)
	if self.actData.careerDrawData[career] then
		local awardDlg = UIManager.getUI("customPoolAwardDlg", true)
		local needReduceNum = self.actData.clientData[career].max_count_one_cycle * (self.actData.cycle - 1)
		local nowProgress = self.actData.careerDrawData[career].totalDrawCount - needReduceNum
		local achieveData = self:getCurCycleAchieveData(career)

		awardDlg:showPoolAwards(achieveData, nowProgress, self.gridConfigId, needReduceNum)
	end
end

function DrawCardNewBieActUpChild:getCurCycleAchieveData(career)
	local achieveData = {}
	local needReduceNum = self.actData.clientData[career].max_count_one_cycle * (self.actData.cycle - 1)

	for i, data in ipairs(self.achieveData[career] or {}) do
		if data.count - needReduceNum > 0 and data.count - needReduceNum <= self.actData.clientData[career].max_count_one_cycle then
			table.insert(achieveData, data)
		end
	end

	return achieveData
end

function DrawCardNewBieActUpChild:_onClickAward()
	self:_onClickTips(self.curCareer)
end

function DrawCardNewBieActUpChild:_onClickGetAward(career)
	if self.awardState == Const.ACT_ACHIEVE_STATE_ENOUGH and CurAvatar and self.awardIdx then
		local achieveType = self.actData:getCareerAchieveType(self.curCareer)

		CurAvatar:activityRPC(Functor(RPC.opActGetAward, self.opAchieveId, self.awardIdx, achieveType), self.opAchieveId)
	end
end

function DrawCardNewBieActUpChild:_selectBuyOne(...)
	self.totalDrawCount = 1

	self.buyOneBtn:setEnable(false)
	self.buyTenBtn:setEnable(true)
	self:refreshPanel()
end

function DrawCardNewBieActUpChild:_selectBuyTen(...)
	self.totalDrawCount = 10

	self.buyOneBtn:setEnable(true)
	self.buyTenBtn:setEnable(false)
	self:refreshPanel()
end

function DrawCardNewBieActUpChild:_onClickDraw()
	if not DrawCardUtils.checkOpActCanDraw(self.actId) then
		return
	end

	local heroId = self.actData:getSetHeroId(self.curCareer)

	if not heroId or heroId == 0 then
		MsgManager.notice(ClientUtils.getClientNotice(751))

		return
	end

	local remainCount = self.actObj.actData:getCareerRemainCount(self.curCareer)

	if remainCount <= 0 then
		MsgManager.notice(ClientUtils.getClientNotice(753))

		return
	elseif self.totalDrawCount == 10 and remainCount < 10 then
		MsgManager.notice(ClientUtils.getClientNotice(752))

		return
	end

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

	self.poolId = self.actData:getPoolIdByCareer(self.curCareer)

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

function DrawCardNewBieActUpChild:_realDraw(costType)
	self.actData.curDrawCareer = self.curCareer

	DrawCardUtils.realDrawOpActCard(self.actId, self.totalDrawCount, costType, self.needItemId, self.needItemNum, self.poolId)
end

function DrawCardNewBieActUpChild:onBtnNextRoundClick()
	RPC.opActDrawNewbieUpNewCycle(self.opId, self.actData.cycle)
end

return DrawCardNewBieActUpChild
