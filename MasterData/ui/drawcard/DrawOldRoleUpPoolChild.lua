-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\DrawCard\\DrawOldRoleUpPoolChild.lua

local ActivityPanelMixin = require("UI/OpActivity/ActivityPanelMixin")
local DrawCardUtils = require("UI/DrawCard/DrawCardUtils")
local ResDrawFakeRand = require("ClientData/ResDrawFakeRand")
local ResRandClient = require("ClientData/ResRandClient")
local CustomPoolAwardDlg = require("UI/DrawCard/CustomPoolAwardDlg")
local ResColor = require("ClientData/ResColor")
local ResHeroStrengthenDes = require("ClientData/ResHeroStrengthenDes")
local HeroCell = Class("DrawOldRoleUpPoolChild_HeroCell", UIControls.Panel)

function HeroCell:ctor()
	if UIControls.checkControlFunc(self, self.mPath .. "/HeroHave") then
		self.panelHave = UIControls.Panel(self, self.mPath .. "/HeroHave")
	end

	if UIControls.checkControlFunc(self, self.mPath .. "/HeroDis") then
		self.panelDis = UIControls.Panel(self, self.mPath .. "/HeroDis")
	end

	self.heroCardCell = UIControls.HeroCardChild(self, self.mPath .. "/GrideCardItem", "System/Hero/GridHeroCard", 1, 1, true)

	self.heroCardCell:setSelectCallback(Slot(self.onClickHeroCardCell, self))

	if UIControls.checkControlFunc(self, self.mPath .. "/StrengthenTips") then
		self.panelStrengthen = UIControls.Panel(self, self.mPath .. "/StrengthenTips")
		self.btnStrengthenDetail = UIControls.Button(self, self.mPath .. "/StrengthenTips/BtnDetails")

		self.btnStrengthenDetail:addEventClick(self.onClickBtnStrengthenDetail)
	end
end

function HeroCell:setData(poolId, heroId, checkHave, checkStrengthen)
	self.poolId = poolId
	self.heroId = heroId or 0

	local checkHero = self.heroId > 0

	self.heroCardCell:setVisible(checkHero)

	if checkHero then
		self.hero = BaseObject.GetObject(self.heroId)
		self.hero.hideLv = true

		self.heroCardCell:setHero(self.hero)
	else
		self.hero = nil
	end

	if self.panelHave then
		self.panelHave:setVisible(checkHero and checkHave)
	end

	if self.panelStrengthen then
		self.panelStrengthen:setVisible(checkHero and checkStrengthen)
	end
end

function HeroCell:onClickHeroCardCell(hero)
	UIManager.getUI("heroPreviewTips"):showObj(self, self.hero)
end

function HeroCell:onClickBtnStrengthenDetail()
	local ui = UIManager.getUI("heroStrengthenDlg", true)

	if ui then
		ui:setData(self.poolId)
	end
end

local DrawOldRoleUpPoolChild = Class("DrawOldRoleUpPoolChild", UIControls.Child)

MixinClass(DrawOldRoleUpPoolChild, ActivityPanelMixin)

local ACHIEVE_STATE = {
	NotComplete = 2,
	Complete = 1
}

function DrawOldRoleUpPoolChild:ctor(...)
	self:initUI()
end

function DrawOldRoleUpPoolChild:initUI()
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

	if UIControls.checkControlFunc(self, "TaskList") then
		self.taskList = {}

		for i = 1, 3 do
			local imgCheck = UIControls.Image(self, "TaskList/Task0" .. i .. "/ImgCheck")
			local imgBack = UIControls.Image(self, "TaskList/Task0" .. i .. "/ImgBack")
			local taskInfo = UIControls.Label(self, "TaskList/Task0" .. i .. "/TextTaskInfo")
			local btnGet = UIControls.Button(self, "TaskList/Task0" .. i .. "/BtnGet")

			btnGet:addEventClick(self.onGetAwardClick)
			table.insert(self.taskList, {
				imgCheck = imgCheck,
				imgBack = imgBack,
				taskInfo = taskInfo,
				btnGet = btnGet
			})
		end
	end

	self.heroCellList = {}

	for i = 1, 3 do
		local heroCell = HeroCell(self, "GrideCardGroup/GrideCard0" .. i)

		table.insert(self.heroCellList, heroCell)
	end

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

	if UIControls.checkControlFunc(self, "limitNumPanel") then
		self.limitNumPanel = UIControls.Panel(self, "limitNumPanel")

		self.limitNumPanel:setVisible(false)

		self.node01 = UIControls.Panel(self, "limitNumPanel/Node01")
		self.node02 = UIControls.Panel(self, "limitNumPanel/Node02")
		self.remainTxt = UIControls.Label(self, "limitNumPanel/Node01/TextNum01")
	end

	self.uiInited = true
end

function DrawOldRoleUpPoolChild:initData(poolId, actId)
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
	local endTime = startEndTime[2]
	local startTimeTxt = ClientUtils.getServerTimeData(startTime, Lang.get(30270))
	local endTimeTxt = ClientUtils.getServerTimeData(endTime, Lang.get(30270))

	self.stableTextTime:setText(startTimeTxt .. "-" .. endTimeTxt)
	self:onShowActivity({
		actObj.clientTemplateData,
		actObj
	})
end

function DrawOldRoleUpPoolChild:refreshPanel(...)
	if not self.actId or not self.poolId then
		return
	end

	self:_refreshDrawInfo()
	self:_refreshOpActInfo()
	self:_refreshRemainCount()
end

function DrawOldRoleUpPoolChild:onPanelOpen(...)
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

function DrawOldRoleUpPoolChild:onPanelClose()
	return
end

function DrawOldRoleUpPoolChild:_selectBuyOne(...)
	self.totalDrawCount = 1

	self.buyOneBtn:setEnable(false)
	self.buyTenBtn:setEnable(true)
	self:refreshPanel()
end

function DrawOldRoleUpPoolChild:_selectBuyTen(...)
	self.totalDrawCount = 10

	self.buyOneBtn:setEnable(true)
	self.buyTenBtn:setEnable(false)
	self:refreshPanel()
end

function DrawOldRoleUpPoolChild:_onClickDraw()
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

function DrawOldRoleUpPoolChild:_realDraw(costType)
	DrawCardUtils.realDrawOpActCard(self.actId, self.totalDrawCount, costType, self.needItemId, self.needItemNum, self.poolId)
end

function DrawOldRoleUpPoolChild:onGetAwardClick(sender)
	CurAvatar:activityRPC(Functor(RPC.opActGetAward, self.actObj.opId, 0), self.actObj.opId)
end

function DrawOldRoleUpPoolChild:_onClickBtnStore()
	CurAvatar:jumpToShowActivity(self.relateGiftId)
end

function DrawOldRoleUpPoolChild:_refreshOpActInfo()
	local actObj = CurAvatar:getActivityObj(self.actId)

	if not actObj or not actObj.actData then
		return
	end

	local actData = actObj.actData

	self.opId = actObj.opId
	self.relateGiftId = actData.clientData.gift_id
	self.alreadyDrawCount = actData.serverData.totalDrawCount
	self.heroGotList = actData.serverData.heroGotList or {}
	self.upHeros = actData.clientData.hero_id

	local heroStrengthenPool = ResHeroStrengthenDes[self.poolId]

	self.checkHeroStrengthenPool = heroStrengthenPool ~= nil

	local heroNum = self.upHeros and #self.upHeros or 0

	for i = 1, #self.heroCellList do
		local checkHero = i <= heroNum
		local heroCell = self.heroCellList[i]

		if checkHero then
			local heroId = self.upHeros[i]
			local checkHave = utils.tableIsContainsElement(self.heroGotList, i)
			local checkStrengthen = self.checkHeroStrengthenPool and heroId == heroStrengthenPool.hero_id

			heroCell:setData(self.poolId, heroId, checkHave, checkStrengthen)
		else
			heroCell:setData(self.poolId, 0, false, false)
		end
	end

	if self.taskList then
		self.taskData = {}

		for i = 1, 3 do
			if i == 1 then
				local desc1 = self.clientTemplateData.replace_resource[1].value

				table.insert(self.taskData, {
					count = 10,
					desc = desc1
				})
			elseif i == 2 then
				table.insert(self.taskData, actData.clientData.achieve[1])
			elseif i == 3 then
				local desc2 = self.clientTemplateData.replace_resource[2].value

				table.insert(self.taskData, {
					desc = desc2
				})
			end
		end

		local gotList = actData.serverData.awardGotList or {}

		for i, data in ipairs(self.taskData or {}) do
			if data.desc then
				self.taskList[i].taskInfo:setText(data.desc)
			end

			local state = self:getDrawAchieveState(i, data)

			self.taskList[i].imgCheck:setVisible(state ~= ACHIEVE_STATE.NotComplete)
			self.taskList[i].imgBack:setVisible(state ~= ACHIEVE_STATE.Complete)

			if i == 2 and data.award then
				self.taskList[i].btnGet:setVisible(state == ACHIEVE_STATE.Complete and not gotList[1])

				for _, gridItem in ipairs(self.grids or {}) do
					gridItem:destroy()
				end

				self.grids = {}

				ClientUtils.CreateBonusGrid(self, self.grids, "TaskList/Task02/GridItem", data.award, true, nil, true)

				if gotList[1] then
					self.grids[1]:setObjGray(true)
				else
					self.grids[1]:setObjGray(false)
				end
			else
				self.taskList[i].btnGet:setVisible(false)
			end
		end
	end

	if self.expTxt then
		self.gridConfigId = actObj.clientTemplateData.grid_id or nil
		self.achieveData = actData.clientData.achieve

		local focusIdx = actData:getFocusAchieveIdx()
		local awardInfo = self.achieveData[focusIdx]

		if not awardInfo or not awardInfo.award or not awardInfo.count then
			return
		end

		local focusAward = awardInfo.award
		local targetCount = awardInfo.count

		self.awardState = actData:focusAchieveState()

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
	end
end

function DrawOldRoleUpPoolChild:getDrawAchieveState(idx, data)
	if idx == 1 or idx == 2 then
		if self.alreadyDrawCount >= data.count then
			return ACHIEVE_STATE.Complete
		else
			return ACHIEVE_STATE.NotComplete
		end
	elseif idx == 3 then
		if #self.heroGotList >= 2 then
			return ACHIEVE_STATE.Complete
		else
			return ACHIEVE_STATE.NotComplete
		end
	end
end

function DrawOldRoleUpPoolChild:_refreshDrawInfo()
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

function DrawOldRoleUpPoolChild:_refreshRemainCount(...)
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

function DrawOldRoleUpPoolChild:_onClickGetAward()
	if self.awardState == Const.ACT_ACHIEVE_STATE_ENOUGH and self.awardIdx then
		CurAvatar:activityRPC(Functor(RPC.opActGetAward, self.opId, self.awardIdx - 1), self.opId)
	end
end

function DrawOldRoleUpPoolChild:_onClickTips(...)
	local awardDlg = UIManager.getUI("customPoolAwardDlg", true)

	awardDlg:showPoolAwards(self.achieveData, self.alreadyDrawCount, self.gridConfigId)
end

return DrawOldRoleUpPoolChild
