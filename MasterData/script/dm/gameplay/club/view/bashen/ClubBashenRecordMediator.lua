-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/club/view/bashen/ClubBashenRecordMediator.lua

ClubBashenRecordMediator = class("ClubBashenRecordMediator", DmPopupViewMediator, _M)

ClubBashenRecordMediator:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")
ClubBashenRecordMediator:has("_clubBashenSystem", {
	is = "r"
}):injectWith("ClubBashenSystem")

local kBtnHandlers = {
	["main.button_close"] = "onClickBack"
}

function ClubBashenRecordMediator:initialize()
	super.initialize(self)
end

function ClubBashenRecordMediator:dispose()
	self._viewClose = true

	super.dispose(self)
end

function ClubBashenRecordMediator:onRegister()
	self._getRewardWidget = self:bindWidget("main.button_get_reward", TwoLevelMainButton, {
		handler = bind1(self.onClickGetReward, self)
	})

	self.mapEventListener(self, self:getEventDispatcher(), EVT_PLAYER_SYNCHRONIZED, self, self.updateCostView)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_RESET_DONE, self, self.dailyReset)
	self:mapButtonHandlersClick(kBtnHandlers)
	super.onRegister(self)
end

function ClubBashenRecordMediator:updateCostView(event)
	self:refreshAllCostPanel()
end

function ClubBashenRecordMediator:enterWithData(data)
	super.enterWithData(self, data)

	self._bagSystem = self._developSystem:getBagSystem()

	self:setupView()
end

function ClubBashenRecordMediator:setupView()
	local view = self:getView()
	local main = view:getChildByName("main")
	local bashenPic, jsonPath = IconFactory:createRoleIconSpriteNew({
		id = "Model_SP_PNCao",
		frameId = "bustframe9"
	})

	bashenPic:setScale(-0.7, 0.7)
	bashenPic:addTo(main, -1):offset(120, 280)

	local modelBg = main:getChildByName("model")

	self._listView = main:getChildByName("listview")

	self._listView:offset(0, 2)
	self._listView:setScrollBarEnabled(false)

	local cellModel = view:getChildByName("cell")

	cellModel:setVisible(false)
	self:refreshCostPanel()

	local recordList = self._clubBashenSystem:getRecordList()

	if #recordList <= 0 then
		local emptyNotice = main:getChildByName("empty_notice")
		local titleFree = main:getChildByName("title_free")
		local title = main:getChildByName("title_times")
		local num = main:getChildByName("times")

		emptyNotice:setVisible(true)
		titleFree:setVisible(false)
		title:setVisible(false)
		num:setVisible(false)

		return
	end

	self._cellList = {}
	self._btnWidget = {}

	for k, record in pairs(recordList) do
		local cell = cellModel:clone()

		cell:setVisible(true)
		cell:setTag(k)

		cell.record = record

		self:refreshListCell(cell, record)
		self:refreshCellCostPanel(cell)
		self._listView:pushBackCustomItem(cell)

		self._cellList[#self._cellList + 1] = cell
	end

	local isManualFinish = self._clubBashenSystem:getManualFinish()

	if isManualFinish then
		self:hideUnusedUI()
	end
end

function ClubBashenRecordMediator:refreshAllCostPanel()
	local recordList = self._clubBashenSystem:getRecordList()

	if #recordList > 0 then
		for i = 1, #self._cellList do
			local cell = self._cellList[i]

			self:refreshCellCostPanel(cell)
		end
	end

	self:refreshCostPanel()
end

function ClubBashenRecordMediator:refreshCostPanel()
	local titleFree = self:getView():getChildByFullName("main.title_free")
	local titleTimes = self:getView():getChildByFullName("main.title_times")
	local times = self:getView():getChildByFullName("main.times")
	local freeReopenCount = self._clubBashenSystem:getFreeReopenCount()
	local leaveDiamondReopenCount = self._clubBashenSystem:getLeaveDiamondReopenCount()

	if freeReopenCount > 0 then
		titleFree:setVisible(true)
		times:setVisible(true)
		titleTimes:setVisible(true)

		local freeReopenMaxCount = self._clubBashenSystem:getFreeReopenMaxCount()

		titleFree:setString(Strings:get("EightPieceText34"))
		times:setString(freeReopenCount .. "/" .. freeReopenMaxCount)
	else
		titleFree:setVisible(false)
		times:setVisible(false)
		titleTimes:setVisible(false)
	end

	local leaveOpenCount = self._clubBashenSystem:getLeaveOpenCount()

	dump(leaveOpenCount, "leaveOpenCount____")

	if leaveOpenCount > 0 then
		self._getRewardWidget:setVisible(false)
	else
		self._getRewardWidget:setVisible(true)
	end
end

function ClubBashenRecordMediator:refreshListCell(cell, data)
	local gems = {}

	for i = 1, 5 do
		local quality = data.gemsQualityList[i]

		gems[i] = cell:getChildByName("gem_" .. i)

		gems[i]:removeAllChildren()

		local sprite = cc.Sprite:createWithSpriteFrameName(GemPath[quality])

		sprite:setScale(0.27)
		sprite:addTo(gems[i]):center(gems[i]:getContentSize())

		local animLight

		if quality == GemQuality.purple then
			animLight = cc.MovieClip:create("ziseguang_bashenbaozangnew")
		elseif quality == GemQuality.orange then
			animLight = cc.MovieClip:create("huangsexunhuan_bashenbaozangnew")
		end

		if animLight then
			animLight:setScale(0.27)
			animLight:addTo(gems[i]):center(gems[i]:getContentSize())
		end
	end

	for i = 1, 3 do
		local iconBg = cell:getChildByName("icon_" .. i)

		iconBg:removeAllChildren()
	end

	local rewards = ConfigReader:getDataByNameIdAndKey("Reward", data.rewardId, "Content")

	for index, reward in pairs(rewards) do
		local iconBg = cell:getChildByName("icon_" .. index)
		local icon = IconFactory:createRewardIcon(reward, {
			ignoreAnim = true,
			isWidget = true
		})

		icon:addTo(iconBg):center(iconBg:getContentSize())
		icon:setScale(0.5)
		IconFactory:bindTouchHander(icon, IconTouchHandler:new(self), reward, {
			swallowTouches = true,
			needDelay = true
		})
	end

	local reopenBtnBg = cell:getChildByName("button_bg")
	local reopenNode = TwoLevelViceButton:createWidgetNode()

	reopenNode:setScale(0.8)

	local reopenBtnWidget = TwoLevelViceButton:new(reopenNode, {
		handler = bind2(self.onClickReopen, self, cell:getTag())
	})

	reopenBtnWidget:getView():addTo(reopenBtnBg, 1):center(reopenBtnBg:getContentSize()):offset(110, 0)
	reopenBtnWidget:setButtonName(Strings:get("EightPieceText14"))

	self._btnWidget[#self._btnWidget + 1] = reopenBtnWidget
end

function ClubBashenRecordMediator:runReopenAnim(cell, record)
	local touchLayer = ccui.Layout:create()

	touchLayer:setTouchEnabled(true)
	touchLayer:setContentSize(cc.size(1386, 852))
	touchLayer:addTo(self:getView()):center(self:getView():getContentSize())

	local qualityList = record.gemsQualityList

	self._clubBashenSystem:sortQualityList(qualityList)

	for i = 1, 5 do
		local quality = qualityList[i]
		local gemsBg = cell:getChildByName("gem_" .. i)

		gemsBg:removeAllChildren()

		local gemsAnim = cc.MovieClip:create("bashenBall_bashenbaozangnew")

		gemsAnim:addTo(gemsBg):center(gemsBg:getContentSize()):offset(0, 0)
		gemsAnim:setScale(0.7)

		if i == 1 then
			gemsAnim:addCallbackAtFrame(20, function()
				gemsAnim:gotoAndPlay(63)
			end)
		elseif i == 2 then
			gemsAnim:addCallbackAtFrame(30, function()
				gemsAnim:gotoAndPlay(63)
			end)
		elseif i == 3 then
			gemsAnim:addCallbackAtFrame(40, function()
				gemsAnim:gotoAndPlay(63)
			end)
		elseif i == 4 then
			gemsAnim:addCallbackAtFrame(50, function()
				gemsAnim:gotoAndPlay(63)
			end)
		end

		gemsAnim:addCallbackAtFrame(63, function(fid, mc)
			local boomAnim = gemsAnim:getChildByName("boom_1")

			boomAnim:addEndCallback(function()
				boomAnim:stop()
			end)
			boomAnim:addCallbackAtFrame(21, function()
				local animBoom = boomAnim:getChildByName("gems")
				local gemsSprite = cc.Sprite:createWithSpriteFrameName(GemPath[quality])

				gemsSprite:addTo(animBoom):center(animBoom:getContentSize())
				animBoom:addEndCallback(function(fid, mc)
					animBoom:stop()
				end)
				self._clubBashenSystem:playOpenGemsAudio(quality)

				local animLight

				if quality == GemQuality.purple then
					animLight = cc.MovieClip:create("ziseguang_bashenbaozangnew")
				elseif quality == GemQuality.orange then
					animLight = cc.MovieClip:create("huangsexunhuan_bashenbaozangnew")
				end

				if animLight then
					animLight:addTo(animBoom):center(animBoom:getContentSize())
				end
			end)
		end)
		gemsAnim:addEndCallback(function(fid, mc)
			gemsAnim:stop()
		end)
	end

	for i = 1, 3 do
		local iconBg = cell:getChildByName("icon_" .. i)

		iconBg:removeAllChildren()
	end

	local scale = 1.08
	local rewardBg = cell:getChildByName("icon_1")
	local rewardId = record.rewardId
	local rewards = ConfigReader:getDataByNameIdAndKey("Reward", rewardId, "Content")

	if rewards then
		local rewardsNum = #rewards
		local rewardsAnim

		if rewardsNum == 1 then
			rewardsAnim = cc.MovieClip:create("zhuandong01_bashenbaozangnew")

			rewardsAnim:addCallbackAtFrame(73, function(fid, mc)
				local animIcon = rewardsAnim:getChildByName("icon_1")
				local icon = IconFactory:createRewardIcon(rewards[1], {
					ignoreAnim = true,
					isWidget = true
				})

				icon:addTo(animIcon):center(animIcon:getContentSize())
				IconFactory:bindTouchHander(icon, IconTouchHandler:new(self), rewards[1], {
					swallowTouches = true,
					needDelay = true
				})
				icon:setScale(scale)
			end)
		elseif rewardsNum == 2 then
			rewardsAnim = cc.MovieClip:create("zhuandong02_bashenbaozangnew")

			rewardsAnim:addCallbackAtFrame(53, function(fid, mc)
				local animIcon = rewardsAnim:getChildByName("icon_1")
				local icon = IconFactory:createRewardIcon(rewards[1], {
					ignoreAnim = true,
					isWidget = true
				})

				icon:addTo(animIcon):center(animIcon:getContentSize())
				icon:setScale(scale)
				IconFactory:bindTouchHander(icon, IconTouchHandler:new(self), rewards[1], {
					swallowTouches = true,
					needDelay = true
				})
			end)
			rewardsAnim:addCallbackAtFrame(74, function(fid, mc)
				local animIcon = rewardsAnim:getChildByName("icon_2")
				local icon = IconFactory:createRewardIcon(rewards[2], {
					ignoreAnim = true,
					isWidget = true
				})

				icon:setScale(scale)
				icon:addTo(animIcon):center(animIcon:getContentSize())
				IconFactory:bindTouchHander(icon, IconTouchHandler:new(self), rewards[2], {
					swallowTouches = true,
					needDelay = true
				})
			end)
		elseif rewardsNum == 3 then
			rewardsAnim = cc.MovieClip:create("zhuandong03_bashenbaozangnew")

			rewardsAnim:addCallbackAtFrame(44, function(fid, mc)
				local animIcon = rewardsAnim:getChildByName("icon_1")
				local icon = IconFactory:createRewardIcon(rewards[1], {
					ignoreAnim = true,
					isWidget = true
				})

				icon:setScale(scale)
				icon:addTo(animIcon):center(animIcon:getContentSize())
				IconFactory:bindTouchHander(icon, IconTouchHandler:new(self), rewards[1], {
					swallowTouches = true,
					needDelay = true
				})
			end)
			rewardsAnim:addCallbackAtFrame(67, function(fid, mc)
				local animIcon = rewardsAnim:getChildByName("icon_2")
				local icon = IconFactory:createRewardIcon(rewards[2], {
					ignoreAnim = true,
					isWidget = true
				})

				icon:setScale(scale)
				icon:addTo(animIcon):center(animIcon:getContentSize())
				IconFactory:bindTouchHander(icon, IconTouchHandler:new(self), rewards[2], {
					swallowTouches = true,
					needDelay = true
				})
			end)
			rewardsAnim:addCallbackAtFrame(78, function(fid, mc)
				local animIcon = rewardsAnim:getChildByName("icon_3")
				local icon = IconFactory:createRewardIcon(rewards[3], {
					ignoreAnim = true,
					isWidget = true
				})

				icon:setScale(scale)
				icon:addTo(animIcon):center(animIcon:getContentSize())
				IconFactory:bindTouchHander(icon, IconTouchHandler:new(self), rewards[3], {
					swallowTouches = true,
					needDelay = true
				})
			end)
		end

		rewardsAnim:addTo(rewardBg):center(rewardBg:getContentSize()):offset(0, 2)
		rewardsAnim:addEndCallback(function(fid, mc)
			rewardsAnim:stop()
			touchLayer:removeFromParent(true)
		end)
	end
end

function ClubBashenRecordMediator:refreshCellCostPanel(cell)
	local freeReopenCount = self._clubBashenSystem:getFreeReopenCount()
	local leaveDiamondReopenCount = self._clubBashenSystem:getLeaveDiamondReopenCount()
	local costNum = self._clubBashenSystem:getDiamondReopenCost()
	local costNumLabel = cell:getChildByFullName("cost_panel.cost_num")
	local imgDiamond = cell:getChildByFullName("cost_panel.img_diamond")
	local reopenBtnWidget = self._btnWidget[cell:getTag()]

	setTextWithFontStyle(costNumLabel, "FontZWMBText")

	if freeReopenCount > 0 then
		imgDiamond:setVisible(false)
		costNumLabel:setPositionX(17)
		costNumLabel:setString(Strings:get("EightPieceText34"))
		setTextWithFontStyle(costNumLabel, "FontLSTCHLineText")
	elseif leaveDiamondReopenCount > 0 then
		imgDiamond:setVisible(true)
		costNumLabel:setPositionX(37)
		costNumLabel:setString(costNum)
		setTextWithFontStyle(costNumLabel, "FontZWMBText")

		local canReset = self._bagSystem:checkCostEnough(CurrencyIdKind.kDiamond, costNum, {
			notShowTip = true
		})

		if not canReset then
			setTextWithFontStyle(costNumLabel, "FontZWMBText")
		end
	else
		imgDiamond:setVisible(true)
		costNumLabel:setPositionX(37)
		costNumLabel:setString(0)
		reopenBtnWidget:getButton():setGray(true)
	end
end

function ClubBashenRecordMediator:refreshView(index, data)
	local record = self._clubBashenSystem:clearupRecordData(data)
	local cell = self._cellList[index]

	self:refreshCellView()
	self:runReopenAnim(cell, record)
end

function ClubBashenRecordMediator:refreshCellView()
	self:refreshCostPanel()

	for _, cell in pairs(self._cellList) do
		self:refreshCellCostPanel(cell)
	end
end

function ClubBashenRecordMediator:hideUnusedUI()
	for k, widget in pairs(self._btnWidget) do
		widget:setVisible(false)
	end

	for k, cell in pairs(self._cellList) do
		local costPanel = cell:getChildByName("cost_panel")

		costPanel:setVisible(false)
	end

	local times = self:getView():getChildByFullName("main.times")
	local titleTimes = self:getView():getChildByFullName("main.title_times")
	local titleFree = self:getView():getChildByFullName("main.title_free")

	self._getRewardWidget:setVisible(false)
	times:setVisible(false)
	titleFree:setVisible(false)
	titleTimes:setVisible(false)
end

function ClubBashenRecordMediator:dailyReset()
	self:close()
end

function ClubBashenRecordMediator:onTouchMaskLayer()
	return
end

function ClubBashenRecordMediator:onClickReopen(index, sender, eventType)
	if eventType == ccui.TouchEventType.ended then
		local leaveDiamondReopenCount = self._clubBashenSystem:getLeaveDiamondReopenCount()

		if leaveDiamondReopenCount <= 0 then
			self:dispatch(ShowTipEvent({
				tip = Strings:get("EightPieceText21")
			}))

			return
		end

		local freeReopenCount = self._clubBashenSystem:getFreeReopenCount()

		if freeReopenCount <= 0 then
			local costNum = self._clubBashenSystem:getDiamondReopenCost()
			local canReset = CurrencySystem:checkEnoughCurrency(self, CurrencyIdKind.kDiamond, costNum, {
				tipType = "popup"
			})

			if not canReset then
				return
			end
		end

		self._clubBashenSystem:requestReopenPack(index, function(data)
			if self._viewClose then
				return
			end

			self:refreshView(index, data)
		end)
	end
end

function ClubBashenRecordMediator:onClickGetReward(sender, eventType)
	if eventType == ccui.TouchEventType.ended then
		self._clubBashenSystem:requestBashenManualFinish(function(response)
			if self._viewClose then
				return
			end

			local rewards = response.data

			table.sort(rewards, function(a, b)
				local itemConfigA = ConfigReader:getRecordById("ItemConfig", tostring(a.code))
				local itemConfigB = ConfigReader:getRecordById("ItemConfig", tostring(b.code))

				return itemConfigA.Quality > itemConfigB.Quality or itemConfigA.Quality == itemConfigB.Quality and b.code == "IR_Gold"
			end)

			local view = self:getInjector():getInstance("getRewardView")

			self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, nil, {
				rewards = response.data
			}))
			self:hideUnusedUI()
		end)
	end
end

function ClubBashenRecordMediator:onClickBack(sender, eventType)
	if eventType == ccui.TouchEventType.ended then
		self:close()
	end
end
