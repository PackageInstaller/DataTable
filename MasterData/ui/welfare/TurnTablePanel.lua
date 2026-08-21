-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Welfare\\TurnTablePanel.lua

local welfareBase = require("UI/Welfare/WelfarePanelBase")
local DragTwoPages = require("UI/Control/DragTwoPages")
local ResTurnTableScroll = require("ClientData/ResTurnTableScroll")
local ResTurnTableMisc = require("ClientData/ResTurnTableMisc")
local ResRandClient = require("ClientData/ResRandClient")
local ResDrawFakeRandRule = require("ClientData/ResDrawFakeRandRule")
local ResClientNotice = require("ClientData/ResClientNotice")
local ResItem = require("ClientData/ResItem")
local ResColor = require("ClientData/ResColor")
local ResOpActivityConsumeReplaceDetail = require("ClientData/ResOpActivityConsumeReplaceDetail")
local UserData = require("Helper/UserData")
local DrawCardUtils = require("UI/DrawCard/DrawCardUtils")
local strClassName = "GridTurntableAward"
local GridTurntableAward = Class(strClassName, UIControls.Child)

function GridTurntableAward:ctor()
	self:initUI()
end

function GridTurntableAward:initUI()
	self.imgSelect = UIControls.Image(self, "ImgSelect")
	self.efxChoose = UIControls.LazyEffectPlayer(self, "EfxChoose")
	self.imgBg = UIControls.Image(self, "Bg")
	self.efxPanel = UIControls.LazyEffectPlayer(self, "Bg/EfxPanel")
end

function GridTurntableAward:setData(randId, index)
	local awardData = ResRandClient[randId]
	local show_flag = awardData.show_flag or {}
	local item = BaseObject.GetObject(awardData.show_ids[1], awardData.show_nums[1])

	if not self.grid then
		self.grid = UIControls.getGridAwardContainer(self, "GridPanel")
	end

	self.grid:setVisible(true)

	self.grid.mDisableWays = true

	self.grid:setContainerConfig(33)
	self.grid:setObj(item)

	self.turntableAtlas = self.mParent.turntableAtlas

	if show_flag[1] and show_flag[1] >= 1 then
		self.grid:setSpe(true, 3, show_flag[1])

		if index == 1 then
			self.imgBg:setImage(self.turntableAtlas, "BgBag1")
			self.efxPanel:setVisible(true)
		else
			self.imgBg:setImage(self.turntableAtlas, "BgBag2")
		end
	else
		self.grid:setSpe(false)
		self.imgBg:setImage(self.turntableAtlas, "BgBag3")
	end
end

local strClassName = "TurntableShowPanel"
local TurntableShowPanel = Class(strClassName, UIControls.Child)
local DRAW_TYPE = {
	FREE = 0,
	NORMAL_TEN = 2,
	SPECIAL_TEN = 3,
	ONCE = 1
}

function TurntableShowPanel:ctor()
	self:initUI()
end

function TurntableShowPanel:initUI()
	self.heroShowPanel = UIControls.Panel(self, "HeroShowPanel")
	self.skinShowPanel = UIControls.Panel(self, "SkinShowPanel")
	self.badgeShowPanel = UIControls.Panel(self, "BadgeShowPanel")
	self.imgHero = UIControls.Image(self, "HeroShowPanel/BgHero/ImgHero")
	self.btnPreview = UIControls.Button(self, "HeroShowPanel/BtnPreview")

	self.btnPreview:addEventClick(self.onBtnHeroPreviewClick)

	self.iconCareer = UIControls.Image(self, "HeroShowPanel/BtnPreview/IconCareer")
	self.iconGroup = UIControls.Image(self, "HeroShowPanel/BtnPreview/IconGroup")
	self.textHeroName = UIControls.Label(self, "HeroShowPanel/BtnPreview/TextName")
	self.imgSkin = UIControls.Image(self, "SkinShowPanel/BgSkin/ImgSkin")
	self.btnPreview = UIControls.Button(self, "SkinShowPanel/BtnPreview")

	self.btnPreview:addEventClick(self.onBtnSkinPreviewClick)

	self.textSkinName = UIControls.Label(self, "SkinShowPanel/BtnPreview/TextName")
	self.artifactBg = UIControls.Image(self, "BadgeShowPanel/BgBadge/IconBadge/Bg")
	self.artifactIcon = UIControls.Image(self, "BadgeShowPanel/BgBadge/IconBadge/Icon")
	self.btnPreview = UIControls.Button(self, "BadgeShowPanel/BtnPreview")

	self.btnPreview:addEventClick(self.onBtnArtifactPreviewClick)

	self.textArtifactName = UIControls.Label(self, "BadgeShowPanel/BtnPreview/TextName")
	self.imgEncore = UIControls.Image(self, "ImgEncore")
end

function TurntableShowPanel:setData(data)
	self.data = data

	self.heroShowPanel:setVisible(self.data.type == Const.TURNTABLE_SHOW_TYPE_ROLE)
	self.skinShowPanel:setVisible(self.data.type == Const.TURNTABLE_SHOW_TYPE_SKIN)
	self.badgeShowPanel:setVisible(self.data.type == Const.TURNTABLE_SHOW_TYPE_ARTIFACT)
	self.imgEncore:setVisible(self.mParent.mainActObj ~= nil and self.data.relate_activity ~= nil)

	if self.data.type == Const.TURNTABLE_SHOW_TYPE_ROLE then
		if self.data.icon_path and self.data.icon_name then
			self.imgHero:setImage(self.data.icon_path, self.data.icon_name)
		end

		local heroObj = BaseObject.GetObject(self.data.item_id)

		self.hero = heroObj

		if heroObj then
			local groupPath = heroObj:getGroupPath()

			if groupPath then
				self.iconGroup:setImage(groupPath[1], groupPath[2])
			end

			local careerPath = heroObj:getCareerPath()

			if careerPath then
				self.iconCareer:setImage(careerPath[1], careerPath[2])
			end

			self.textHeroName:setText(heroObj.name)
		end
	elseif self.data.type == Const.TURNTABLE_SHOW_TYPE_SKIN then
		if self.data.icon_path and self.data.icon_name then
			self.imgSkin:setImage(self.data.icon_path, self.data.icon_name)
		end

		local skinObj = BaseObject.GetObject(self.data.item_id)

		self.skinObj = skinObj

		if skinObj then
			self.textSkinName:setText(skinObj.name)
		end
	elseif self.data.type == Const.TURNTABLE_SHOW_TYPE_ARTIFACT then
		local artifactObj = BaseObject.GetObject(self.data.item_id)

		self.artifactObj = artifactObj

		if artifactObj then
			local iconPath = artifactObj:getIconPath()

			if iconPath then
				self.artifactIcon:setImage(iconPath[1], iconPath[2])
			end

			local bgPath = artifactObj:getCareerBgIconPath()

			if bgPath then
				self.artifactBg:setImage(bgPath[1], bgPath[2])
			end

			self.textArtifactName:setText(artifactObj.name)
		end
	end
end

function TurntableShowPanel:onBtnHeroPreviewClick()
	UIManager.getUI("heroPreviewTips"):showObj(self, self.hero)
end

function TurntableShowPanel:onBtnSkinPreviewClick()
	UIManager.getUI("skinPreviewTips"):setBySkinObj(self.skinObj)
end

function TurntableShowPanel:onBtnArtifactPreviewClick()
	BaseObject.ShowObjectTips(self.artifactObj.id, 1, self)
end

local strClassName = "TurnTablePanel"
local TurnTablePanel = Class(strClassName, welfareBase)
local ONE_DRAW_ANI_CIRCLE = 1
local TURN_TIME_DURATION = 0.05
local WAIT_TIME = 0.5
local SPEED_DURANTION = 0.15
local TURNTABLE_TYPE = {
	Act = 2,
	Normal = 1
}

function TurnTablePanel:ctor()
	self:initUI()
end

function TurnTablePanel:initUI()
	self.dragPages = DragTwoPages(self, "AwardShowPanel/ContentPanel1", "AwardShowPanel/ContentPanel2", nil, nil, 5, "AwardShowPanel/PagePanel/Page", true)
	self.dragPages.dragEvent = Slot(self.onDragEvent, self)
	self.pages = {}
	self.awardShowPanel = UIControls.Panel(self, "AwardShowPanel")
	self.pagePanel = UIControls.Panel(self, "AwardShowPanel/PagePanel")
	self.btnGet = UIControls.Button(self, "AwardShowPanel/BtnGet")

	self.btnGet:addEventClick(self.onBtnGetClick)

	self.btnProbability = UIControls.Button(self, "BtnProbability")

	self.btnProbability:addEventClick(self.onBtnProbabilityClick)

	self.btnDrawLog = UIControls.Button(self, "BtnDrawLog")

	self.btnDrawLog:addEventClick(self.onBtnDrawLogClick)

	self.btnEmpty = UIControls.Button(self, "EmptyPanel")

	self.btnEmpty:addEventClick(self.onBtnEmptyClick)

	self.awardPanels = {}
	self.awardGrids = {}

	for i = 1, 10 do
		local panel = UIControls.Panel(self, "TurntableInfoPanel/AwardPanel/Panel" .. i)

		table.insert(self.awardPanels, panel)
	end

	self.attentionSwitch = UIControls.Toggle(self, "TurntableInfoPanel/BgSkip/AttentionSwitch")

	self.attentionSwitch:addEventValueChanged(self.onToggleChange)

	self.btnFree = UIControls.Button(self, "TurntableInfoPanel/BgBtn/BtnBuyOnePanel/BtnFree")

	self.btnFree:addEventClick(Functor(self.onBtnDrawClick, self, DRAW_TYPE.FREE))

	self.btnBuyOne = UIControls.Button(self, "TurntableInfoPanel/BgBtn/BtnBuyOnePanel/BtnBuy")

	self.btnBuyOne:addEventClick(Functor(self.onBtnDrawClick, self, DRAW_TYPE.ONCE))

	self.textOnePrice = UIControls.Label(self, "TurntableInfoPanel/BgBtn/BtnBuyOnePanel/BtnBuy/TextPrice")
	self.iconOneCost = UIControls.Image(self, "TurntableInfoPanel/BgBtn/BtnBuyOnePanel/BtnBuy/TextPrice/IconCost")
	self.btnBuyCost = UIControls.Button(self, "TurntableInfoPanel/BgBtn/BtnBuyDiamondPanel/BtnBuy")

	self.btnBuyCost:addEventClick(Functor(self.onBtnDrawClick, self, DRAW_TYPE.SPECIAL_TEN))

	self.btnBuyTen = UIControls.Button(self, "TurntableInfoPanel/BgBtn/BtnBuyMorePanel/BtnBuy")

	self.btnBuyTen:addEventClick(Functor(self.onBtnDrawClick, self, DRAW_TYPE.NORMAL_TEN))

	self.textTenPrice = UIControls.Label(self, "TurntableInfoPanel/BgBtn/BtnBuyMorePanel/BtnBuy/TextPrice")
	self.iconTenCost = UIControls.Image(self, "TurntableInfoPanel/BgBtn/BtnBuyMorePanel/BtnBuy/TextPrice/IconCost")
	self.btnBuyDiamondPanel = UIControls.Panel(self, "TurntableInfoPanel/BgBtn/BtnBuyDiamondPanel")
	self.remainText = UIControls.Label(self, "TurntableInfoPanel/BgTextHint/Text")
	self.textTime = UIControls.Label(self, "TipsPanel/TextTime")
	self.textDiamondLimit = UIControls.Label(self, "TurntableInfoPanel/BgBtn/BtnBuyDiamondPanel/TextLimit")
	self.iconCost = UIControls.Image(self, "TurntableInfoPanel/BgBtn/BtnBuyDiamondPanel/BtnBuy/TextPrice/IconCost")
	self.textPrice = UIControls.Label(self, "TurntableInfoPanel/BgBtn/BtnBuyDiamondPanel/BtnBuy/TextPrice")
	self.iconOneNew = UIControls.Image(self, "TurntableInfoPanel/BgBtn/BtnBuyOnePanel/BtnBuy/IconNew")
	self.iconMoreNew = UIControls.Image(self, "TurntableInfoPanel/BgBtn/BtnBuyMorePanel/IconNew")
	self.iconCostNew = UIControls.Image(self, "TurntableInfoPanel/BgBtn/BtnBuyDiamondPanel/IconNew")

	if UIControls.checkControlFunc(self, "limitNumPanel") then
		self.limitNumPanel = UIControls.Panel(self, "limitNumPanel")

		self.limitNumPanel:setVisible(false)

		self.node01 = UIControls.Panel(self, "limitNumPanel/Node01")
		self.node02 = UIControls.Panel(self, "limitNumPanel/Node02")
		self.remainTxt = UIControls.Label(self, "limitNumPanel/Node01/TextNum01")
	end
end

function TurnTablePanel:onOpenPanel()
	self.gridAwardPath = "System/Store/Turntable/GridTurntableAward"
	self.showPanelPath = "System/Store/Turntable/TurntableShowPanel"
	self.turntableAtlas = "Atlas/StoreAtlas/StoreTurntableAtlas"

	if self.panelConfigData and self.panelConfigData.arg1 then
		self.turnTableType = TURNTABLE_TYPE.Act
		self.actId = self.panelConfigData.arg1
		self.actObj = CurAvatar:getActivityObj(self.actId)

		if self.actObj and self.actObj:isValid() then
			self.miscIndex = self.actObj.templateData.param[1] or 1

			if self.actObj.clientTemplateData then
				local replaceableCellPath = self.actObj.clientTemplateData.src_replace

				if replaceableCellPath and replaceableCellPath[1] then
					self.gridAwardPath = "System/Store/" .. replaceableCellPath[1] .. "/GridTurntableAward"
					self.showPanelPath = "System/Store/" .. replaceableCellPath[1] .. "/TurntableShowPanel"
				end

				if replaceableCellPath and replaceableCellPath[2] then
					self.turntableAtlas = "Atlas/StoreAtlas/" .. replaceableCellPath[2]
				end
			end
		else
			self.miscIndex = 1
		end
	else
		self.turnTableType = TURNTABLE_TYPE.Normal
		self.miscIndex = 1
	end

	self.miscInfo = ResTurnTableMisc[self.miscIndex]
	self.poolId = self.miscInfo.pool_id
	self.randIds = self.miscInfo.rand_id
	self.drawItemId = self.miscInfo.turn_item_id
	self.relaActIds = self.miscInfo.relate_acts or {}
	self.limitGetTimes = 0

	for i, v in pairs(ResDrawFakeRandRule) do
		if v.lib_id == self.poolId then
			self.limitGetTimes = v.limit_count

			break
		end
	end

	local isCloseAnimation = UserData.loadCommonData(CurAvatar.uid .. "TurnTableAnimation" .. self.miscIndex)

	if isCloseAnimation and isCloseAnimation == "1" then
		self.attentionSwitch:setOn(true)

		self.toggleIsOn = true
	else
		self.attentionSwitch:setOn(false)

		self.toggleIsOn = false
		isCloseAnimation = "0"
	end

	UserData.saveCommonData(CurAvatar.uid .. "TurnTableAnimation" .. self.miscIndex, isCloseAnimation)

	self.turnItemNum = self.miscInfo.turn_item_num or 1

	self.textOnePrice:setText(self.turnItemNum)
	self.textTenPrice:setText(self.turnItemNum * 10)

	local iconPath = BaseObject.getItemIconPath(self.miscInfo.turn_item_id)

	if iconPath and #iconPath == 2 then
		self.iconOneCost:setImage(iconPath[1], iconPath[2])
		self.iconTenCost:setImage(iconPath[1], iconPath[2])
	end

	self:refreshData()
end

function TurnTablePanel:refreshData()
	self.bannerData = {}

	for _, info in pairs(ResTurnTableScroll) do
		if self.turnTableType == info.turn_table_type then
			if info.relate_activity then
				local actObj = CurAvatar:getActivityObj(info.relate_activity)

				if actObj and actObj:isValid() then
					self.mainActObj = actObj

					if info.time_desc then
						self.timeDesc = info.time_desc
					end
				end
			elseif not self.timeDesc then
				self.timeDesc = info.time_desc
			end

			if self:_checkValid(info) then
				table.insert(self.bannerData, info)
			end
		end
	end

	if #self.bannerData == 0 then
		for _, info in ipairs(ResTurnTableScroll) do
			if not info.relate_activity then
				table.insert(self.bannerData, info)

				break
			end
		end
	end

	table.sort(self.bannerData, function(a, b)
		return a.priority < b.priority
	end)

	if #self.bannerData == 0 then
		self.awardShowPanel:setVisible(false)
	else
		self.awardShowPanel:setVisible(true)
		self.dragPages:initPage(#self.bannerData, 1, #self.bannerData)
	end

	self.pagePanel:setVisible(#self.bannerData > 1)

	for i, actId in ipairs(self.relaActIds) do
		local actObj = CurAvatar:getActivityObj(actId)

		if actObj and actObj:isValid() then
			self.relaActObj = actObj
		end
	end

	for i = 1, 10 do
		local grid = self.awardGrids[i]

		if not grid then
			grid = GridTurntableAward(self, "TurntableInfoPanel/AwardPanel/Panel" .. i .. "/GridAwardPanel", self.gridAwardPath, 0, 0, true)

			table.insert(self.awardGrids, grid)
		end

		grid:setData(self.randIds[i], i)
	end

	local drawNoneTimes = self:getRareRoundCount()
	local remainTimes = self.limitGetTimes - drawNoneTimes > 0 and self.limitGetTimes - drawNoneTimes or 0

	self.remainText:setText(string.format(ResClientNotice[674].notice, remainTimes))

	if self.mainActObj and self.timeDesc then
		self.textTime:setVisible(true)
		ClientTimerManager.AddSecondFormatTickUI(self.textTime, self.mainActObj:getRemainOpenTime(), false, self.timeDesc)
	elseif self.timeDesc then
		self.textTime:setText(self.timeDesc)
		self.textTime:setVisible(true)
	else
		self.textTime:setVisible(false)
	end

	self.drawItemNum = CurAvatar:getItemNumById(self.drawItemId)

	self.iconMoreNew:setVisible(self.drawItemNum >= self.turnItemNum * 10)
	self.textTenPrice:setFontColor(self.drawItemNum >= self.turnItemNum * 10 and ResColor.WHITE or ResColor.RED)
	self.textOnePrice:setFontColor(self.drawItemNum >= self.turnItemNum and ResColor.WHITE or ResColor.RED)
	self:_refreshDrawOneState()
	self:_refreshDrawTenState()
	self:_refreshRemainCount()
end

function TurnTablePanel:_refreshRemainCount(...)
	if self.limitNumPanel and CurAvatar:dayDrawCountLimitOpen() then
		self.limitNumPanel:setVisible(true)

		local todayRemain

		if self.turnTableType == TURNTABLE_TYPE.Normal then
			todayRemain = CurAvatar:getDrawDayCount(Const.DrawTypeTurnTable, Const.DayDrawMaxCountFree)
		else
			todayRemain = CurAvatar:getDrawDayCount(self.actObj.opId, Const.DayDrawMaxCountFree)
		end

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

function TurnTablePanel:_refreshDrawOneState()
	if self.relaActObj then
		if not self:checkHasFreeTime() then
			self.btnFree:setVisible(false)
			self.btnBuyOne:setVisible(true)

			if not self.freeCountDownTimer then
				self.freeCountDownTimer = Timer.New(Slot(self._countDownFunc, self), 1000, -1)
			end

			if self.relaActObj.actData.oneDrawRefreshTime and self.relaActObj.actData.oneDrawRefreshTime ~= 0 then
				self.freeCountDownTimer.duration = self.relaActObj.actData.oneDrawRefreshTime - ClientUtils.getServerTime()

				self.freeCountDownTimer:Restart()
			else
				self.freeCountDownTimer:Stop()
			end

			CurAvatar:unsetDrawCardItemReddot(self.poolId)
			self.iconOneNew:setVisible(self.drawItemNum >= 1)
		else
			self.iconOneNew:setVisible(false)
			self.btnFree:setVisible(true)
			self.btnBuyOne:setVisible(false)
		end
	else
		self.btnFree:setVisible(false)
		self.btnBuyOne:setVisible(true)
		self.iconOneNew:setVisible(self.drawItemNum >= 1)
		CurAvatar:unsetDrawCardItemReddot(self.poolId)
	end
end

function TurnTablePanel:checkHasFreeTime()
	if self.relaActObj then
		local count = self.relaActObj.actData:getFreeTime()

		return count > 0
	end

	return false
end

function TurnTablePanel:checkHasCostTime()
	if self.relaActObj then
		local count = self.relaActObj.actData:getConsumeTenTime()

		return count > 0, count
	end

	return false
end

function TurnTablePanel:_refreshDrawTenState()
	if self.relaActObj and self.relaActObj.actData.detailData.consume_tendraw_maxtimes ~= 0 then
		local hasCostTime, remainTimes = self:checkHasCostTime()
		local itemId = self.relaActObj.actData.detailData.consume_id or Const.MONEY_ID_DIAMOND
		local itemNum = CurAvatar:getItemNumById(itemId)
		local needNum = self.relaActObj.actData.detailData.ten_consume_num or 2700

		self.iconCostNew:setVisible(needNum <= itemNum and hasCostTime)

		if itemNum < needNum then
			self.textPrice:setFontColor(ResColor.RED)
		else
			self.textPrice:setFontColor(ResColor.WHITE)
		end

		if not hasCostTime then
			self.btnBuyCost:setEnable(false)

			if not self.freeCountDownTimer then
				self.freeCountDownTimer = Timer.New(Slot(self._countDownFunc, self), 1000, -1)
			end

			if self.relaActObj.actData.tenDrawRefreshTime and self.relaActObj.actData.tenDrawRefreshTime ~= 0 then
				self.freeCountDownTimer.duration = self.relaActObj.actData.tenDrawRefreshTime - ClientUtils.getServerTime()

				self.freeCountDownTimer:Restart()
			else
				self.freeCountDownTimer:Stop()
			end
		else
			self.btnBuyCost:setEnable(true)

			local iconPath = BaseObject.getItemIconPath(itemId)

			if iconPath and #iconPath == 2 then
				self.iconCost:setImage(iconPath[1], iconPath[2])
			end

			self.textPrice:setText(needNum)
		end

		self.btnBuyDiamondPanel:setVisible(true)

		if remainTimes then
			self.textDiamondLimit:setVisible(true)
			self.textDiamondLimit:setText(string.format(Lang.get(71078), remainTimes))
		end
	else
		self.btnBuyDiamondPanel:setVisible(false)
	end
end

function TurnTablePanel:_countDownFunc()
	if self.freeCountDownTimer then
		self.freeCountDownTimer:Stop()
	end

	self:refreshData()
end

function TurnTablePanel:onDragEvent(sender, currentPageIndex, panelIndex, isOnOpen)
	self.currentPageIndex = currentPageIndex
	self.currentPanelIndex = panelIndex

	local bannerData = self.bannerData[self.currentPageIndex]
	local page = self.pages[panelIndex]

	if not page then
		local newPage = TurntableShowPanel(self, "AwardShowPanel/ContentPanel" .. panelIndex, self.showPanelPath)

		newPage:setVisible(true)

		self.pages[panelIndex] = newPage
	end

	self.pages[panelIndex]:setData(bannerData)
end

function TurnTablePanel:_checkValid(info)
	if info.condition_id and ConditionLimitManager.inLimitState(info.condition_id) then
		return false
	end

	if info.is_hide and info.is_hide == 1 then
		return false
	end

	if info.turn_table_type == TURNTABLE_TYPE.Normal then
		if info.relate_activity then
			local actObj = CurAvatar:getActivityObj(info.relate_activity)

			if actObj and actObj:isValid() then
				return true
			else
				return false
			end
		else
			return true
		end
	elseif info.relate_activity and self.actId == info.relate_activity then
		return true
	else
		return false
	end
end

function TurnTablePanel:onToggleChange(sender, isOn)
	local isCloseAnimation = isOn == true and "1" or "0"

	self.toggleIsOn = isOn

	UserData.saveCommonData(CurAvatar.uid .. "TurnTableAnimation" .. self.miscIndex, isCloseAnimation)
end

function TurnTablePanel:playOneDrawAnimation(items)
	local index = 1

	for i, id in ipairs(self.randIds) do
		local awardData = ResRandClient[id]

		if items[1].id == awardData.show_ids[1] and items[1].num == awardData.show_nums[1] then
			index = i
		end
	end

	self.refreshSelectShowTimer = Timer.New(Functor(self.playSelectShow, self, items), TURN_TIME_DURATION, 10 * ONE_DRAW_ANI_CIRCLE + index)

	self.refreshSelectShowTimer:Start()
end

function TurnTablePanel:playTenDrawAnimation(items)
	local index = 1

	for i, id in ipairs(self.randIds) do
		local awardData = ResRandClient[id]

		if items[self.curPlayAniIndex].id == awardData.show_ids[1] and items[self.curPlayAniIndex].num == awardData.show_nums[1] then
			index = i
		end
	end

	local curShowIndex = 0

	for i, grid in ipairs(self.awardGrids) do
		if grid.imgSelect:getVisible() then
			curShowIndex = i
		end

		if grid.efxChoose:getVisible() then
			grid.efxChoose:setVisible(false)
		end
	end

	local loopTimes = index - curShowIndex > 5 and index - curShowIndex or 10 + index - curShowIndex

	loopTimes = loopTimes > 5 and loopTimes or loopTimes + 10
	self.refreshSelectShowTimer = Timer.New(Functor(self.playSelectShow, self, items), TURN_TIME_DURATION, loopTimes)

	self.refreshSelectShowTimer:Start()
end

function TurnTablePanel:playSelectShow(items)
	local curShowIndex = 0

	for i, grid in ipairs(self.awardGrids) do
		if grid.imgSelect:getVisible() then
			grid.imgSelect:setVisible(false)

			curShowIndex = i
		end
	end

	local needShowIndex = curShowIndex + 1 > 10 and 1 or curShowIndex + 1

	self.awardGrids[needShowIndex].imgSelect:setVisible(true)

	if self.refreshSelectShowTimer.loop < 4 then
		self.refreshSelectShowTimer.duration = TURN_TIME_DURATION + (4 - self.refreshSelectShowTimer.loop) * SPEED_DURANTION
	end

	if self.refreshSelectShowTimer.loop == 0 then
		self.awardGrids[needShowIndex].efxChoose:setVisible(true)
		self.refreshSelectShowTimer:Stop()

		self.refreshSelectShowTimer = nil
		self.coFunc = coroutine.start(function(...)
			coroutine.wait(WAIT_TIME)

			if #items == 1 or self.curPlayAniIndex == #items then
				self:showTurnTableBonus(items)
			else
				self.curPlayAniIndex = self.curPlayAniIndex + 1

				self:playTenDrawAnimation(items)
			end
		end)
	end
end

function TurnTablePanel:showTurnTableBonus(items)
	local showItems = items

	CurAvatar:onGetBonusNotice("commonBonusDlg", "onShow", {
		{},
		{},
		showItems,
		{},
		{},
		{},
		{},
		Lang.get(338)
	})

	for i, grid in ipairs(self.awardGrids) do
		if grid.imgSelect:getVisible() then
			grid.imgSelect:setVisible(false)
		end

		if grid.efxChoose:getVisible() then
			grid.efxChoose:setVisible(false)
		end
	end

	self.btnEmpty:setVisible(false)
	self:refreshData()
end

function TurnTablePanel:onTurnTableDrawResp(serverItems)
	local items = {}

	for i, v in ipairs(serverItems) do
		table.insert(items, {
			id = v.id,
			num = v.common_param
		})
	end

	self.item = items

	if not self.toggleIsOn then
		for i, grid in ipairs(self.awardGrids) do
			if grid.imgSelect:getVisible() then
				grid.imgSelect:setVisible(false)
			end

			if grid.efxChoose:getVisible() then
				grid.efxChoose:setVisible(false)
			end
		end

		if #items == 1 then
			self:playOneDrawAnimation(items)
		else
			self.curPlayAniIndex = 1

			self:playTenDrawAnimation(items)
		end
	else
		self:showTurnTableBonus(items)
	end
end

function TurnTablePanel:getRareRoundCount()
	if self.turnTableType == TURNTABLE_TYPE.Normal then
		if CurAvatar.roleDrawData and CurAvatar.roleDrawData[Const.DrawTypeTurnTable] then
			return CurAvatar.roleDrawData[Const.DrawTypeTurnTable].rareRoundCont or 0
		end
	elseif self.actObj then
		return self.actObj.actData.rareRoundCount or 0
	end

	return 0
end

function TurnTablePanel:getTotalDrawCount()
	if self.turnTableType == TURNTABLE_TYPE.Normal then
		if CurAvatar.roleDrawData and CurAvatar.roleDrawData[Const.DrawTypeTurnTable] then
			return CurAvatar.roleDrawData[Const.DrawTypeTurnTable].totalDrawCount or 0
		end
	elseif self.actObj then
		return self.actObj.actData.totalDrawCount
	end

	return 0
end

function TurnTablePanel:onBtnDrawClick(type)
	local nowTotalDraw = self:getTotalDrawCount()

	if self.turnTableType == TURNTABLE_TYPE.Normal then
		if type == DRAW_TYPE.FREE then
			RPC.draw(Const.DrawTypeTurnTable, 1, Const.DrawCostTypeNone, nil, nowTotalDraw)
			self.btnEmpty:setVisible(true)
		elseif type == DRAW_TYPE.ONCE then
			self:_realItemDraw(1, nowTotalDraw, self.turnTableType)
		elseif type == DRAW_TYPE.NORMAL_TEN then
			self:_realItemDraw(10, nowTotalDraw, self.turnTableType)
		elseif type == DRAW_TYPE.SPECIAL_TEN and self.relaActObj then
			local itemId = self.relaActObj.actData.detailData.consume_id or Const.MONEY_ID_DIAMOND
			local needNum = self.relaActObj.actData.detailData.ten_consume_num or 2700
			local itemNum = CurAvatar:getItemNumById(itemId)

			ClientUtils.checkMoneyChange(Const.MONEY_ID_DIAMOND, needNum, Slot(self._realDrawDiamond, self))
		end
	elseif type == DRAW_TYPE.ONCE then
		self:_realItemDraw(1, nowTotalDraw, self.turnTableType)
	elseif type == DRAW_TYPE.NORMAL_TEN then
		self:_realItemDraw(10, nowTotalDraw, self.turnTableType)
	end
end

function TurnTablePanel:checkItemEnough(num)
	local drawItemNum = CurAvatar:getItemNumById(self.drawItemId)

	if drawItemNum < num then
		local fakeItem = BaseObject.GetObject(self.drawItemId)

		UIManager.getUI("itemTips"):showObj(self, fakeItem, {
			AutoOpenGuide = 1
		})
		MsgManager.notice(string.format(ResClientNotice[675].notice, ResItem[self.drawItemId].name))

		return false
	end

	return true
end

function TurnTablePanel:_realItemDraw(drawNum, nowTotalDraw, turnTableType)
	if not self:checkItemEnough(drawNum) then
		return
	end

	if turnTableType == TURNTABLE_TYPE.Normal then
		if not DrawCardUtils.checkRemainCount(Const.DrawTypeTurnTable, drawNum) then
			MsgManager.notice(Lang.get(30265))

			return
		end

		RPC.draw(Const.DrawTypeTurnTable, drawNum, Const.DrawCostTypeItem, nil, nowTotalDraw)
	else
		if not DrawCardUtils.checkRemainCount(self.actObj.opId, drawNum) then
			MsgManager.notice(Lang.get(30265))

			return
		end

		RPC.opActTurnTableDraw(self.actObj.opId, drawNum, Const.DrawCostTypeItem, nowTotalDraw)
	end

	self.btnEmpty:setVisible(true)
end

function TurnTablePanel:_realDrawDiamond()
	if not DrawCardUtils.checkRemainCount(Const.DrawTypeTurnTable, 10) then
		MsgManager.notice(Lang.get(30265))

		return
	end

	local nowTotalDraw = self:getTotalDrawCount()

	RPC.draw(Const.DrawTypeTurnTable, 10, Const.DrawCostTypeConsume, nil, nowTotalDraw)
	self.btnEmpty:setVisible(true)
end

function TurnTablePanel:onBtnGetClick()
	JumpGuideManager.jump(Const.JUMPSHOPTYPE_MIXSHOP)
end

function TurnTablePanel:onBtnProbabilityClick()
	UIManager.getUI("heroPoolProbabilityDlg", true):setData(self.poolId)
end

function TurnTablePanel:onBtnDrawLogClick()
	if self.turnTableType == TURNTABLE_TYPE.Normal then
		UIManager.getUI("heroPoolDrawLogDlg", true):setData(Const.DrawPoolIdTurnTable)
	else
		UIManager.getUI("heroPoolDrawLogDlg", true):setData(nil, self.actObj.opId)
	end
end

function TurnTablePanel:onBtnEmptyClick()
	MsgManager.notice(Lang.get(71079))
end

function TurnTablePanel:onClosePanel()
	TurnTablePanel.super.onClosePanel(self)
end

function TurnTablePanel:onDestroy()
	if self.refreshSelectShowTimer then
		self.refreshSelectShowTimer:Stop()

		self.refreshSelectShowTimer = nil
	end

	if self.freeCountDownTimer then
		self.freeCountDownTimer:Stop()

		self.freeCountDownTimer = nil
	end

	if self.coFunc then
		coroutine.stop(self.coFunc)
	end

	self.coFunc = nil

	self.dragPages:destroy()
end

return TurnTablePanel
