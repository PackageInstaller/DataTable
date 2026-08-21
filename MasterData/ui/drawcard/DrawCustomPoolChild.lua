-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\DrawCard\\DrawCustomPoolChild.lua

local ActivityPanelMixin = require("UI/OpActivity/ActivityPanelMixin")
local DrawCardUtils = require("UI/DrawCard/DrawCardUtils")
local ResDrawFakeRand = require("ClientData/ResDrawFakeRand")
local ResRandClient = require("ClientData/ResRandClient")
local CustomPoolAwardDlg = require("UI/DrawCard/CustomPoolAwardDlg")
local ResColor = require("ClientData/ResColor")
local ResHeroStrengthenDes = require("ClientData/ResHeroStrengthenDes")
local HeroSkill = require("Common/Object/HeroSkill")
local SkillUpCell = Class("DrawCustomPoolChild_SkillUpCell", UIControls.Child)

function SkillUpCell:ctor()
	self.imgUp = UIControls.Image(self, "ImgUP")
	self.skillCell = UIControls.HeroSkillGridChild(self, "GridHeroSkill", "System/Hero/GridHeroSkill")
	self.skillCell.mEnableTips = false

	self.skillCell:setVisible(true)
end

function SkillUpCell:setData(skillObj, checkUp)
	self.skillCell:setObj(skillObj)
	self.imgUp:setVisible(checkUp)
end

local strClassName = "DrawCustomPoolChild"
local DrawCustomPoolChild = Class(strClassName, UIControls.Child)

MixinClass(DrawCustomPoolChild, ActivityPanelMixin)

function DrawCustomPoolChild:ctor(...)
	self:initUI()
end

function DrawCustomPoolChild:initUI(...)
	if self.uiInited then
		return
	end

	self.bannerBg = UIControls.RawImage(self, "Bg")
	self.needItemIcon = UIControls.Image(self, "PricePanel/IconPrice")
	self.priceTxt = UIControls.Label(self, "PricePanel/TextPriceNum")
	self.freeLineImg = UIControls.Image(self, "PricePanel/TextPriceNum/ImgLine")
	self.freeTxt = UIControls.Label(self, "PricePanel/TextFree")
	self.stableTextTime = UIControls.Label(self, "TextNumTime/TextTime")
	self.buyBtn = UIControls.Button(self, "BtnBuy")

	self.buyBtn:addEventClick(self._onClickDraw)

	self.buyFreeTxt = UIControls.Label(self, "BtnBuy/TextBuy")

	if UIControls.checkControlFunc(self, "BtnBuy/IconNew") then
		self.imgFreeBuy = UIControls.Image(self, "BtnBuy/IconNew")
	end

	self.buyOneBtn = UIControls.Button(self, "BtnBuyNumPanel/BtnOne", "Text")

	self.buyOneBtn:addEventClick(self._selectBuyOne)

	self.buyTenBtn = UIControls.Button(self, "BtnBuyNumPanel/BtnTen", "Text")

	self.buyTenBtn:addEventClick(self._selectBuyTen)

	self.freeTicketPanel = UIControls.Panel(self, "TextTitleFree")
	self.countdownTxt = UIControls.Label(self, "TextTitleFree/TextFreeTime")
	self.freeTicketImg = UIControls.Panel(self, "TextTitleFree/ImgFreeTicket")
	self.discountPanel = UIControls.Panel(self, "BtnBuyNumPanel/BtnTen/ImgSale")
	self.discountInfoTxt = UIControls.Label(self, "BtnBuyNumPanel/BtnTen/ImgSale/TextDiscount")
	self.discountItemImg = UIControls.Image(self, "BtnBuyNumPanel/BtnTen/ImgSale/Icon")
	self.discountNumTxt = UIControls.Label(self, "BtnBuyNumPanel/BtnTen/ImgSale/TextSaleNum")

	if UIControls.checkControlFunc(self, "ExpPanel/ExpText") then
		self.expTxt = UIControls.Label(self, "ExpPanel/ExpText")
		self.expSlider = UIControls.Slider(self, "ExpPanel/ExpSlider")
		self.expStateImg = UIControls.Image(self, "ExpPanel/ImgState")
		self.awardGridMountPath = "ExpPanel/BtnPreview/GridPanel"
		self.awardAni = UIControls.UIAni(self, "ExpPanel/BtnPreview")
		self.getAwardBtn = UIControls.Button(self, "ExpPanel/BtnPreview/BtnGet")

		self.getAwardBtn:addEventClick(self._onClickGetAward)

		self.tipsBtn = UIControls.Button(self, "ExpPanel/BtnTips")

		self.tipsBtn:addEventClick(self._onClickTips)
	end

	if UIControls.checkControlFunc(self, "SkillStrengthenPanel") then
		self.txtStrengthen = UIControls.Label(self, "SkillStrengthenPanel/TextSkill")
		self.btnStrengthen = UIControls.Button(self, "SkillStrengthenPanel/BtnDetails")

		self.btnStrengthen:addEventClick(self.onClickBtnStrengthen)
	end

	if UIControls.checkControlFunc(self, "limitNumPanel") then
		self.limitNumPanel = UIControls.Panel(self, "limitNumPanel")

		self.limitNumPanel:setVisible(false)

		self.node01 = UIControls.Panel(self, "limitNumPanel/Node01")
		self.node02 = UIControls.Panel(self, "limitNumPanel/Node02")
		self.remainTxt = UIControls.Label(self, "limitNumPanel/Node01/TextNum01")
	end

	self.uiInited = true
end

function DrawCustomPoolChild:initData(poolId, actId)
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

	if self.drawFakeRandData.free_time then
		self.freeDrawCD = self.drawFakeRandData.free_time * 3600
	end

	self.freeTicketPanel:setVisible(self.freeDrawCD ~= nil)

	local actObj = CurAvatar:getActivityObj(self.actId)

	if not actObj or not actObj.actData then
		return
	end

	local startEndTime = actObj:getStartEndTime()
	local startTime = startEndTime[1]
	local endTime = startEndTime[2]
	local startTimeTxt = ClientUtils.getServerTimeData(startTime, Lang.get(30270))
	local endTimeTxt = ClientUtils.getServerTimeData(endTime, Lang.get(30270))

	self.stableTextTime:setText(startTimeTxt .. "-" .. endTimeTxt)
	self:onShowActivity({
		actObj.clientTemplateData,
		actObj
	})
end

function DrawCustomPoolChild:refreshPanel(...)
	if not self.actId or not self.poolId then
		return
	end

	self:_refreshDrawInfo()
	self:_refreshFreeCountDown()
	self:_refreshOpActInfo()
	self:_refreshRemainCount()
end

function DrawCustomPoolChild:onPanelOpen(...)
	self:_refreshFreeCountDown()

	if not self.hasFreeCount and DrawCardUtils.checkDrawCost(self.poolId, 10, true) ~= false then
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

	actObj.actData.skipCheckItemNew = true

	actObj:checkNew()
end

function DrawCustomPoolChild:onPanelClose()
	self:stopCountDown()
end

function DrawCustomPoolChild:_selectBuyOne(...)
	self.totalDrawCount = 1

	self.buyOneBtn:setEnable(false)
	self.buyTenBtn:setEnable(true)
	self:refreshPanel()
end

function DrawCustomPoolChild:_selectBuyTen(...)
	self.totalDrawCount = 10

	self.buyOneBtn:setEnable(true)
	self.buyTenBtn:setEnable(false)
	self:refreshPanel()
end

function DrawCustomPoolChild:_onClickDraw()
	if not DrawCardUtils.checkOpActCanDraw(self.actId) then
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

function DrawCustomPoolChild:_realDraw(costType)
	DrawCardUtils.realDrawOpActCard(self.actId, self.totalDrawCount, costType, self.needItemId, self.needItemNum, self.poolId)
end

function DrawCustomPoolChild:_onClickTips(...)
	local awardDlg = UIManager.getUI("customPoolAwardDlg", true)

	awardDlg:showPoolAwards(self.achieveData, self.alreadyDrawCount, self.gridConfigId)
end

function DrawCustomPoolChild:_onClickAward(...)
	self:_onClickTips()
end

function DrawCustomPoolChild:_onClickGetAward()
	if self.awardState == Const.ACT_ACHIEVE_STATE_ENOUGH and CurAvatar and self.awardIdx then
		CurAvatar:activityRPC(Functor(RPC.opActGetAward, self.opId, self.awardIdx - 1), self.opId)
	end
end

function DrawCustomPoolChild:_refreshDrawInfo()
	if self.needItemId then
		local curItemNum = CurAvatar:getItemNumById(self.needItemId)

		self.totalNeedItem = 0
		self.totalNeedItem = self.needItemNum * self.totalDrawCount

		if curItemNum >= self.totalNeedItem then
			self.needItemIcon:setImage(self.needItemIconPath[1], self.needItemIconPath[2])
			self.priceTxt:setText(self.totalNeedItem)
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

function DrawCustomPoolChild:_refreshOpActInfo()
	local actObj = CurAvatar:getActivityObj(self.actId)

	if not actObj or not actObj.actData then
		return
	end

	self.alreadyDrawCount = actObj.actData.serverData.totalDrawCount
	self.achieveData = actObj.actData.clientData.achieve
	self.gridConfigId = actObj.clientTemplateData.grid_id or nil
	self.opId = actObj.opId

	local heroStrengthenConfig = ResHeroStrengthenDes[self.poolId]
	local checkHeroStrengthenPool = heroStrengthenConfig ~= nil

	if not checkHeroStrengthenPool and self.expTxt then
		local focusIdx = actObj.actData:getFocusAchieveIdx()
		local awardInfo = self.achieveData[focusIdx]

		if not awardInfo or not awardInfo.award or not awardInfo.count then
			return
		end

		local focusAward = awardInfo.award
		local targetCount = awardInfo.count

		self.awardState = actObj.actData:focusAchieveState()

		local mom = targetCount

		if self.awardState == Const.ACT_ACHIEVE_STATE_ENOUGH then
			self.expTxt:setText(mom .. "/" .. mom)
			self.expSlider:setValue(1)
			self.expStateImg:setVisible(false)
			self.awardAni:startAniLoop("LoopHeroUpCardGet")
		elseif self.awardState == Const.ACT_ACHIEVE_STATE_NOT_ENOUGH then
			local son = self.alreadyDrawCount

			self.expTxt:setText(son .. "/" .. mom)

			local percent = math.min(1, son / mom)

			self.expSlider:setValue(percent)
			self.expStateImg:setVisible(false)
			self.awardAni:startAni("ResetHeroUpCardGet", true)
		elseif self.awardState == Const.ACT_ACHIEVE_STATE_GOT then
			self.expTxt:setText(mom .. "/" .. mom)
			self.expSlider:setValue(1)
			self.expStateImg:setVisible(true)
			self.awardAni:startAni("ResetHeroUpCardGet", true)
		end

		self.getAwardBtn:setVisible(self.awardState == Const.ACT_ACHIEVE_STATE_ENOUGH)

		self.awardIdx = focusIdx

		if self.targetAwardGrids and self.targetAward ~= focusAward then
			for _, grid in ipairs(self.targetAwardGrids) do
				grid:destroy()
			end

			self.targetAwardGrids = nil
		end

		if not self.targetAwardGrids then
			self.targetAwardGrids = {}

			local itemList = ResRandClient[focusAward].show_ids

			for i, itemId in ipairs(itemList) do
				local itemNum = ResRandClient[focusAward].show_nums[i] or 1
				local fakeItem = BaseObject.GetObject(itemId, itemNum)
				local awardGrid = UIControls.getGridChild(fakeItem, self, self.awardGridMountPath)

				awardGrid:setObj(fakeItem)
				awardGrid:setVisible(true)

				awardGrid.mDisableWays = true
				awardGrid.mEnableTips = false
				awardGrid._onGridClick = Slot(self._onClickAward, self)

				table.insert(self.targetAwardGrids, awardGrid)
			end
		end

		self.targetAward = focusAward
	end

	if checkHeroStrengthenPool and self.btnStrengthen then
		self.txtStrengthen:setText(heroStrengthenConfig.change_title)

		self.skillCellList = self.skillCellList or {}
		self.hero = BaseObject.GetObject(heroStrengthenConfig.hero_id)

		local skillInfoList = heroStrengthenConfig.skill_list
		local skillUpIdList = {}

		for _, skillInfo in ipairs(skillInfoList) do
			table.insert(skillUpIdList, skillInfo.new_skill_id)
		end

		local showSkillIdList = {
			self.hero.resData.attack_id,
			self.hero.resData.skill_id,
			self.hero.resData.enter_passive,
			self.hero.resData.hero_passive
		}
		local skillNum = #showSkillIdList
		local cellNum = #self.skillCellList

		for i = 1, skillNum do
			local cell

			if i <= cellNum then
				cell = self.skillCellList[i]
			else
				cell = SkillUpCell(self, "SkillStrengthenPanel/SkillList", "System/HeroPool/SkillCell")

				table.insert(self.skillCellList, cell)
			end

			cell:setVisible(true)

			local skillId = showSkillIdList[i]
			local skillField = self.hero:getSkillFieldBySkillId(skillId)
			local newSkillObj = HeroSkill(skillId, utils.getHeroMaxSkillLevel(self.hero, skillField), skillField)
			local checkUp = utils.getIndexByValue(skillUpIdList, skillId) > 0

			cell:setData(newSkillObj, checkUp)
		end

		if skillNum < cellNum then
			for i = skillNum + 1, cellNum do
				self.skillCellList[i]:setVisible(false)
			end
		end
	end
end

function DrawCustomPoolChild:_refreshFreeCountDown()
	if self.freeDrawCD == nil then
		return
	end

	local actObj = CurAvatar:getActivityObj(self.actId)

	if not actObj or not actObj.actData then
		return
	end

	local actData = actObj.actData
	local nextFreeTick = actData.serverData.lastDrawTick + self.freeDrawCD
	local needTick = nextFreeTick - ClientUtils.getServerTime()

	self.hasFreeCount = needTick <= 0

	if self.totalDrawCount ~= 1 then
		self:stopCountDown()
		self.freeTicketPanel:setVisible(false)
		self.freeLineImg:setVisible(false)
		self.freeTxt:setVisible(false)
		self.priceTxt:setFontColor(ResColor.WHITE)
		self.buyFreeTxt:setText(Lang.get(1271))

		if self.imgFreeBuy then
			self.imgFreeBuy:setVisible(false)
		end
	else
		self.freeLineImg:setVisible(self.hasFreeCount)
		self.freeTxt:setVisible(self.hasFreeCount)
		self.freeTicketPanel:setVisible(true)
		self.freeTicketImg:setVisible(self.hasFreeCount)

		if self.imgFreeBuy then
			self.imgFreeBuy:setVisible(self.hasFreeCount)
		end

		self.countdownTxt:setVisible(not self.hasFreeCount)

		if not self.hasFreeCount then
			self:_startFreeCountDown(nextFreeTick)
			self.priceTxt:setFontColor(ResColor.WHITE)
			self.buyFreeTxt:setText(Lang.get(1271))
		else
			self.priceTxt:setFontColor(ResColor.BLACK)
			self.buyFreeTxt:setText(Lang.get(32776))
		end
	end
end

function DrawCustomPoolChild:_startFreeCountDown(nextFreeTick)
	self.nextFreeTick = nextFreeTick

	self.countdownTxt:setVisible(true)
	self:_countDownFunc()

	if not self.freeCountDownTimer then
		self.freeCountDownTimer = Timer.New(Slot(self._countDownFunc, self), 1, -1)

		self.freeCountDownTimer:Start()
	else
		self.freeCountDownTimer:Restart()
	end
end

function DrawCustomPoolChild:stopCountDown(...)
	self.countdownTxt:setVisible(false)

	if self.freeCountDownTimer then
		self.freeCountDownTimer:Stop()
	end
end

function DrawCustomPoolChild:_countDownFunc()
	local leftTime = self.nextFreeTick - ClientUtils.getServerTime()

	if leftTime > 0 then
		local displayTime = utils.calcTimeTxt(leftTime)

		self.countdownTxt:setText(string.format(Lang.get(30269), displayTime))
	else
		self:stopCountDown()
		self:refreshPanel()
	end
end

function DrawCustomPoolChild:_refreshRemainCount(...)
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

function DrawCustomPoolChild:onClickBtnStrengthen()
	local ui = UIManager.getUI("heroStrengthenDlg", true)

	if ui then
		ui:setData(self.poolId)
	end
end

return DrawCustomPoolChild
