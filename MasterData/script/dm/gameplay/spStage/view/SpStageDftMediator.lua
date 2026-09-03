-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/spStage/view/SpStageDftMediator.lua

SpStageDftMediator = class("SpStageDftMediator", DmPopupViewMediator, _M)

SpStageDftMediator:has("_spStageSystem", {
	is = "r"
}):injectWith("SpStageSystem")
SpStageDftMediator:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")
SpStageDftMediator:has("_customDataSystem", {
	is = "rw"
}):injectWith("CustomDataSystem")

local kBtnHandlers = {
	["bg.button_sweep"] = {
		clickAudio = "Se_Click_Common_1",
		func = "onClickSweep"
	},
	["bg.button_battle"] = {
		clickAudio = "Se_Click_Common_1",
		func = "onClickBattle"
	}
}
local kPicScore = {
	kB = "B",
	kA = "A",
	kC = "C",
	kS = "S"
}
local kPicPoint = {
	kGreen = "zyfb_bg_duigou_1.png",
	kRed = "zyfb_bg_duigou_2.png"
}
local kColor = {
	kRed = cc.c3b(200, 200, 200),
	kGreen = cc.c3b(255, 255, 255)
}
local BgAnim = {
	bg_ziyuanben_yingxiong = "d_ziyuanfuben",
	bg_ziyuanben_dashi = "c_ziyuanfuben",
	bg_ziyuanben_shenyuan = "d_ziyuanfuben",
	bg_ziyuanben_kunnan = "b_ziyuanfuben",
	bg_ziyuanben_putong = "a_ziyuanfuben",
	bg_ziyuanben_zongshi = "d_ziyuanfuben"
}

function SpStageDftMediator:initialize()
	super.initialize(self)
end

function SpStageDftMediator:dispose()
	super.dispose(self)
end

function SpStageDftMediator:onRegister()
	super.onRegister(self)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_REFRESH_SPVIEW, self, self.resumeWithData)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_SPSTAGE_SWEEP_SUCC, self, self.getSweepReward)
	self:mapButtonHandlersClick(kBtnHandlers)
	self:bindWidgets()
end

function SpStageDftMediator:bindWidgets()
	return
end

function SpStageDftMediator:enterWithData(data)
	self._data = data
	self._stageType = self._data.stageType
	self._config = self:getSpStageSystem():getPointConfigByType(self._stageType)

	assert(self._config ~= nil, string.format("special stage--> \"%s\" has no config", self._stageType))
	self:initWigetInfo()
	self:initScrollView()
	self:refreshLeaveTimes()
	self:refreshBtns()
	self:setupTopInfoWidget()
	self:setupClickEnvs()
end

function SpStageDftMediator:resumeWithData()
	local isOpenByActivity = self._spStageSystem:getOpenByActivity(self._data.stageId)
	local isOpen, str = self._spStageSystem:getOpenTimeStr(self._data.stageId)

	if not ((isOpenByActivity or nil) and isOpenByActivity) then
		self:close()

		return
	end

	local leaveTimes = self:getSpStageSystem():getStageLeaveTime(self._data.stageId)

	if leaveTimes <= 0 then
		self:close()

		return
	end

	local function callback()
		self._config = self:getSpStageSystem():getPointConfigByType(self._stageType)

		self:refreshView()
		self:refreshLeaveTimes()
		self:refreshBtns()
	end

	local params = {}

	params.spType = self:getSpStageSystem():getStageTypeById(self._data.stageId)

	self:getSpStageSystem():requesetGetBestReports(params, true, callback, self)
end

function SpStageDftMediator:initWigetInfo()
	self._winSize = cc.Director:getInstance():getWinSize()

	local bg = self:getView():getChildByName("bg")

	self._scrollView = bg:getChildByName("scrollview")
	self._cell = bg:getChildByName("pointNode")

	self._cell:setVisible(false)

	self._cellWidth = self._cell:getContentSize().width
	self._scrollHeight = self._scrollView:getContentSize().height
	self._cellHeight = self._scrollHeight / 2 + 24
	self._btnSweep = bg:getChildByName("button_sweep")
	self._btnBattle = bg:getChildByName("button_battle")
	self._originalBattlePos = self._btnBattle:getPositionX()
	self._sweepNotice = bg:getChildByName("sweep_notice_panel")

	self._sweepNotice:setVisible(false)
	self._scrollView:onScroll(function(event)
		self:onScroll(event)
	end)
	self._scrollView:onTouch(function(event)
		self:onTouch(event)
	end)
	GameStyle:setGreenCommonEffect(self._btnSweep:getChildByName("text"))
	self._btnBattle:getChildByName("text"):setAdditionalKerning(8)
end

function SpStageDftMediator:initScrollView()
	local stageId = self._data.stageId
	local stage = self:getSpStageSystem():getModel():getStageById(stageId)
	local index = self:getSpStageSystem():getMaxDftStage(stageId)

	if self._data.difficulty and index > self._data.difficulty then
		index = self._data.difficulty
	end

	self._curIndex = index

	local winSize = cc.Director:getInstance():getWinSize()

	self._centerPos = self._scrollView:getContentSize().width / 2

	self._scrollView:setScrollBarEnabled(false)
	self._scrollView:setInertiaScrollEnabled(false)

	local offset = winSize.width / 2 - self._cellWidth / 2
	local pointInfo = self:getSpStageSystem():getPointInfo(stageId)
	local showPointNum = self:getSpStageSystem():getShowPointNum(stageId)

	self._scrollView:setInnerContainerSize(cc.size(showPointNum * self._cellWidth + 2 * offset, self._scrollHeight))

	self._cellNode = {}

	for i = 1, showPointNum do
		local pointId = self._config[i].Id

		self._cellNode[i] = self._cell:clone()

		self._cellNode[i]:setVisible(true)
		self._cellNode[i]:setTag(i)
		self._cellNode[i]:setSwallowTouches(false)
		self._cellNode[i]:addClickEventListener(function(sender, eventType)
			self:onClickPointNode(sender, eventType)
		end)

		local bg = self._cellNode[i]:getChildByFullName("bg")
		local lightPanel = self._cellNode[i]:getChildByFullName("light_panel")
		local costNode = self._cellNode[i]:getChildByFullName("costNode")
		local darkPanel = self._cellNode[i]:getChildByFullName("dark_panel")
		local title = self._cellNode[i]:getChildByFullName("title")
		local combat = lightPanel:getChildByName("suggest_combat")
		local bottomPanel = lightPanel:getChildByName("bottom_bg")
		local noReplayNotice = lightPanel:getChildByName("empty")
		local playerName = lightPanel:getChildByFullName("bottom_bg.name")
		local btnReplay = lightPanel:getChildByFullName("bottom_bg.button_replay")

		btnReplay:addClickEventListener(function(sender, eventType)
			self:onReplayBtnClicked(sender, eventType)
		end)

		local playerCombat = lightPanel:getChildByFullName("bottom_bg.combat")
		local scoreBg = lightPanel:getChildByName("scoreBg")
		local score = scoreBg:getChildByName("score")

		if pointInfo and pointInfo[pointId] then
			if not pointInfo[pointId].progress then
				local progress = -1

				title:setString(Strings:get(self._config[i].PointName))

				local costIcon = costNode:getChildByName("icon")

				costIcon:removeAllChildren()

				local icon = IconFactory:createResourcePic({
					id = CurrencyIdKind.kPower
				})

				icon:addTo(costIcon)
				costNode:getChildByName("cost"):setString(self._config[i].StaminaCost)
				combat:setString(self._config[i].CombatValue)
				bg:loadTexture("asset/ui/spStageBg/" .. self._config[i].PointPic .. ".png")
				lightPanel:getChildByFullName("tipImage"):loadTexture("asset/ui/spStageBg/" .. self._config[i].PointPic .. "_1.png")

				local pointConfig = ConfigReader:requireRecordById("BlockSpPoint", pointId)
				local starCondition = pointConfig.StarCondition.value
				local close = self:getSpStageSystem():isPointClose(stageId, pointId)

				if close == true then
					bg = self._cellNode[i]:getChildByFullName("bg")

					do
						local condition1 = darkPanel:getChildByFullName("text_1")
						local condition2 = darkPanel:getChildByFullName("text_2")
						local point1 = darkPanel:getChildByFullName("level_point")
						local point2 = darkPanel:getChildByFullName("stage_point")

						condition1:setString(Strings:get("SPECIAL_STAGE_TEXT_5", {
							level = self._config[i].OpenLevel
						}))
						condition2:setString(Strings:get("SPECIAL_STAGE_TEXT_6"))

						local color1, color2, pointImg1, pointImg2
						local myselfLevel = self._developSystem:getPlayer():getLevel()
						local openLevel = self._config[i].OpenLevel
						local lastPointId = self._config[i - 1].Id
						local lastPoint = stage:getPointInfoById(lastPointId)

						if openLevel <= myselfLevel then
							color1 = kColor.kGreen
							pointImg1 = kPicPoint.kGreen
						else
							color1 = kColor.kRed
							pointImg1 = kPicPoint.kRed
						end

						point1:loadTexture(pointImg1, 1)

						if lastPoint and lastPoint.progress >= starCondition[4] then
							color2 = kColor.kGreen
							pointImg2 = kPicPoint.kGreen
						else
							color2 = kColor.kRed
							pointImg2 = kPicPoint.kRed
						end

						point2:loadTexture(pointImg2, 1)
					end
				else
					combat = pointInfo and pointInfo[pointId] and pointInfo[pointId].bestPlayerCombat or ""
				end

				if pointInfo and pointInfo[pointId] then
					if not pointInfo[pointId].bestPlayerNickname then
						do
							local nickname = ""

							playerCombat:setString(combat)
							playerName:setString(nickname)

							if not pointInfo or not pointInfo[pointId] or not pointInfo[pointId].bestPlayerNickname then
								bottomPanel:setVisible(false)
								noReplayNotice:setVisible(true)
							end
						end

						local picScore

						if pointConfig then
							scoreBg:setVisible(true)

							if progress >= starCondition[1] and progress < starCondition[2] then
								picScore = kPicScore.kC
							elseif progress >= starCondition[2] and progress < starCondition[3] then
								picScore = kPicScore.kB
							elseif progress >= starCondition[3] and progress < starCondition[4] then
								picScore = kPicScore.kA
							elseif progress >= starCondition[4] then
								picScore = kPicScore.kS

								if not self._cellNode[i]:getChildByFullName("BuffTip") then
									local _tab = GameStyle:getStageBuffInfo(BuffTypeSet.SPBlock)

									if _tab then
										local icon = ccui.ImageView:create(_tab.iconName)

										icon:addTo(self._cellNode[i]):setName("BuffTip")
										icon:setPosition(69, 324)
										icon:setTouchEnabled(true)
										IconFactory:bindTouchHander(icon, BuffTouchHandler:new(self), _tab, {})
									end
								end
							else
								scoreBg:setVisible(false)
							end

							score:setString(picScore)
							GameStyle:setGoldCommonEffect(score, true)
						end

						lightPanel:setVisible(not close)
						costNode:setVisible(not close)
						darkPanel:setVisible(close)

						local posX = winSize.width / 2 + self._cellWidth * (i - 1)

						self._cellNode[i]:setPosition(cc.p(posX, self._cellHeight))

						self._cellNode[i].position = {
							posX,
							self._cellHeight
						}

						self._scrollView:addChild(self._cellNode[i])
					end
				end
			end
		end
	end

	local scrollInnerWidth = self._scrollView:getInnerContainerSize().width - self._winSize.width
	local percent = (self._curIndex - 1) * self._cellWidth / scrollInnerWidth

	if percent == 0 then
		percent = 0.0001
	end

	self._scrollView:scrollToPercentHorizontal(percent * 100, 0.1, false)

	if self._cellNode[self._curIndex] then
		local anim1 = self._cellNode[self._curIndex]:getChildByFullName("anim1")

		anim1:removeAllChildren()

		local anim2 = self._cellNode[self._curIndex]:getChildByFullName("anim2")

		anim2:removeAllChildren()

		local videoSprite1 = cc.MovieClip:create(BgAnim[self._config[self._curIndex].PointPic])

		anim1:addChild(videoSprite1)

		local videoSprite2 = cc.MovieClip:create(BgAnim[self._config[self._curIndex].PointPic])

		anim2:addChild(videoSprite2)
		videoSprite2:setOpacity(51)
	end
end

function SpStageDftMediator:refreshView()
	local stageId = self._data.stageId
	local stage = self:getSpStageSystem():getModel():getStageById(stageId)

	self._curIndex = self:getSpStageSystem():getMaxDftStage(stageId)

	local pointInfo = self:getSpStageSystem():getPointInfo(stageId)
	local showPointNum = self:getSpStageSystem():getShowPointNum(stageId)

	self._scrollView:removeAllChildren()

	local winSize = cc.Director:getInstance():getWinSize()
	local offset = winSize.width / 2 - self._cellWidth / 2

	self._scrollView:setInnerContainerSize(cc.size(showPointNum * self._cellWidth + 2 * offset, self._scrollHeight))

	self._cellNode = {}

	for i = 1, showPointNum do
		local pointId = self._config[i].Id

		self._cellNode[i] = self._cell:clone()

		self._cellNode[i]:setVisible(true)
		self._cellNode[i]:setTag(i)
		self._cellNode[i]:setSwallowTouches(false)
		self._cellNode[i]:addClickEventListener(function(sender, eventType)
			self:onClickPointNode(sender, eventType)
		end)

		local bg = self._cellNode[i]:getChildByFullName("bg")
		local lightPanel = self._cellNode[i]:getChildByFullName("light_panel")
		local costNode = self._cellNode[i]:getChildByFullName("costNode")
		local darkPanel = self._cellNode[i]:getChildByFullName("dark_panel")
		local title = self._cellNode[i]:getChildByFullName("title")
		local combat = lightPanel:getChildByName("suggest_combat")
		local bottomPanel = lightPanel:getChildByName("bottom_bg")
		local noReplayNotice = lightPanel:getChildByName("empty")
		local playerName = lightPanel:getChildByFullName("bottom_bg.name")
		local btnReplay = lightPanel:getChildByFullName("bottom_bg.button_replay")

		btnReplay:addClickEventListener(function(sender, eventType)
			self:onReplayBtnClicked(sender, eventType)
		end)

		local playerCombat = lightPanel:getChildByFullName("bottom_bg.combat")
		local scoreBg = lightPanel:getChildByName("scoreBg")
		local score = scoreBg:getChildByName("score")

		if pointInfo and pointInfo[pointId] then
			if not pointInfo[pointId].progress then
				local progress = -1

				title:setString(Strings:get(self._config[i].PointName))

				local costIcon = costNode:getChildByName("icon")

				costIcon:removeAllChildren()

				local icon = IconFactory:createPic({
					id = CurrencyIdKind.kPower
				})

				icon:addTo(costIcon)
				costNode:getChildByName("cost"):setString(self._config[i].StaminaCost)
				combat:setString(self._config[i].CombatValue)
				bg:loadTexture("asset/ui/spStageBg/" .. self._config[i].PointPic .. ".png")
				lightPanel:getChildByFullName("tipImage"):loadTexture("asset/ui/spStageBg/" .. self._config[i].PointPic .. "_1.png")

				local pointConfig = ConfigReader:requireRecordById("BlockSpPoint", pointId)
				local starCondition = pointConfig.StarCondition.value
				local close = self:getSpStageSystem():isPointClose(stageId, pointId)

				if close == true then
					bg = self._cellNode[i]:getChildByFullName("bg")

					do
						local condition1 = darkPanel:getChildByFullName("text_1")
						local condition2 = darkPanel:getChildByFullName("text_2")
						local point1 = darkPanel:getChildByFullName("level_point")
						local point2 = darkPanel:getChildByFullName("stage_point")

						condition1:setString(Strings:get("SPECIAL_STAGE_TEXT_5", {
							level = self._config[i].OpenLevel
						}))
						condition2:setString(Strings:get("SPECIAL_STAGE_TEXT_6"))

						local color1, color2, pointImg1, pointImg2
						local myselfLevel = self._developSystem:getPlayer():getLevel()
						local openLevel = self._config[i].OpenLevel
						local lastPointId = self._config[i - 1].Id
						local lastPoint = stage:getPointInfoById(lastPointId)

						if openLevel <= myselfLevel then
							color1 = kColor.kGreen
							pointImg1 = kPicPoint.kGreen
						else
							color1 = kColor.kRed
							pointImg1 = kPicPoint.kRed
						end

						point1:loadTexture(pointImg1, 1)

						if lastPoint and lastPoint.progress >= starCondition[4] then
							color2 = kColor.kGreen
							pointImg2 = kPicPoint.kGreen
						else
							color2 = kColor.kRed
							pointImg2 = kPicPoint.kRed
						end

						point2:loadTexture(pointImg2, 1)
					end
				else
					combat = pointInfo and pointInfo[pointId] and pointInfo[pointId].bestPlayerCombat or ""
				end

				if pointInfo and pointInfo[pointId] then
					if not pointInfo[pointId].bestPlayerNickname then
						do
							local nickname = ""

							playerCombat:setString(combat)
							playerName:setString(nickname)

							if not pointInfo or not pointInfo[pointId] or not pointInfo[pointId].bestPlayerNickname then
								bottomPanel:setVisible(false)
								noReplayNotice:setVisible(true)
							end
						end

						local picScore

						if pointConfig then
							scoreBg:setVisible(true)

							if progress >= starCondition[1] and progress < starCondition[2] then
								picScore = kPicScore.kC
							elseif progress >= starCondition[2] and progress < starCondition[3] then
								picScore = kPicScore.kB
							elseif progress >= starCondition[3] and progress < starCondition[4] then
								picScore = kPicScore.kA
							elseif progress >= starCondition[4] then
								picScore = kPicScore.kS

								if not self._cellNode[i]:getChildByFullName("BuffTip") then
									local _tab = GameStyle:getStageBuffInfo(BuffTypeSet.SPBlock)

									if _tab then
										local icon = ccui.ImageView:create(_tab.iconName)

										icon:addTo(self._cellNode[i]):setName("BuffTip")
										icon:setPosition(69, 324)
										icon:setTouchEnabled(true)
										IconFactory:bindTouchHander(icon, BuffTouchHandler:new(self), _tab, {})
									end
								end
							else
								scoreBg:setVisible(false)
							end

							score:setString(picScore)
							GameStyle:setGoldCommonEffect(score, true)
						end

						lightPanel:setVisible(not close)
						costNode:setVisible(not close)
						darkPanel:setVisible(close)

						local posX = winSize.width / 2 + self._cellWidth * (i - 1)

						self._cellNode[i]:setPosition(cc.p(posX, self._cellHeight))

						self._cellNode[i].position = {
							posX,
							self._cellHeight
						}

						self._scrollView:addChild(self._cellNode[i])
					end
				end
			end
		end
	end

	local scrollInnerWidth = self._scrollView:getInnerContainerSize().width - self._winSize.width
	local percent = (self._curIndex - 1) * self._cellWidth / scrollInnerWidth

	if percent == 0 then
		percent = 0.0001
	end

	self._scrollView:scrollToPercentHorizontal(percent * 100, 0.1, false)

	if self._cellNode[self._curIndex] then
		local anim1 = self._cellNode[self._curIndex]:getChildByFullName("anim1")

		anim1:removeAllChildren()

		local anim2 = self._cellNode[self._curIndex]:getChildByFullName("anim2")

		anim2:removeAllChildren()

		local videoSprite1 = cc.MovieClip:create(BgAnim[self._config[self._curIndex].PointPic])

		anim1:addChild(videoSprite1)

		local videoSprite2 = cc.MovieClip:create(BgAnim[self._config[self._curIndex].PointPic])

		anim2:addChild(videoSprite2)
		videoSprite2:setOpacity(51)
	end
end

function SpStageDftMediator:refreshLeaveTimes()
	local textLeaveTimes = self:getView():getChildByFullName("bg.leave_time")
	local leaveTimes = self:getSpStageSystem():getStageLeaveTime(self._data.stageId)

	textLeaveTimes:setString(leaveTimes)

	if leaveTimes <= 0 then
		textLeaveTimes:setTextColor(cc.c4b(255, 255, 255, 255))
		self:setBtnGray()
	end
end

function SpStageDftMediator:setBtnGray()
	self._btnSweep:setGray(true)
	self._btnBattle:setGray(true)
end

function SpStageDftMediator:refreshBtns()
	local pointId = self._config[self._curIndex].Id
	local leaveTimes = self:getSpStageSystem():getStageLeaveTime(self._data.stageId)
	local close = self:getSpStageSystem():isPointClose(self._data.stageId, pointId)
	local isShowSweepBtn = self:isShowSweepBtn()

	self._btnSweep:setVisible(isShowSweepBtn)
	self._btnBattle:setVisible(not close)

	if not isShowSweepBtn then
		self._btnBattle:setPositionX(self._sweepNotice:getPositionX())
	else
		self._btnBattle:setPositionX(self._originalBattlePos)
	end

	if leaveTimes <= 0 then
		self:setBtnGray()
	end
end

function SpStageDftMediator:scrollToCurIndex(curIndex)
	local scrollInnerWidth = self._scrollView:getInnerContainerSize().width - self._winSize.width
	local percent = (curIndex - 1) * self._cellWidth / scrollInnerWidth

	if self._curIndex ~= curIndex then
		local showPointNum = self:getSpStageSystem():getShowPointNum(self._data.stageId)

		self._curIndex = math.min(showPointNum, curIndex)

		AudioEngine:getInstance():playEffect("Se_Click_Common_1", false)
	end

	self._scrollView:scrollToPercentHorizontal(percent * 100, 0.1, false)
	self:refreshBtns()
end

function SpStageDftMediator:onScroll(event)
	if event.name == "CONTAINER_MOVED" then
		for k, v in pairs(self._scrollView:getChildren()) do
			local position = v.position

			self._cellNode[k]:setPosition(cc.p(position[1], position[2]))

			local itemPosX = position[1]
			local innerPosX = self._scrollView:getInnerContainerPosition().x
			local offset = itemPosX + innerPosX
			local centerOffset = (self._centerPos - offset) / self._cellWidth
			local anim1 = self._cellNode[k]:getChildByFullName("anim1")

			anim1:removeAllChildren()

			local anim2 = self._cellNode[k]:getChildByFullName("anim2")

			anim2:removeAllChildren()

			local scale = 1
			local offsetX = 0

			if math.round(centerOffset) < 0 then
				scale = 1 - centerOffset * -0.2
				offsetX = (1 - centerOffset * -0.2 - 1) * 40
			elseif math.round(centerOffset) > 0 then
				scale = 1 - centerOffset * 0.2
				offsetX = (1 - (1 - centerOffset * 0.2)) * 40
			end

			v:setScale(scale)
			v:offset(offsetX, 0)

			if scale == 1 then
				local videoSprite1 = cc.MovieClip:create(BgAnim[self._config[k].PointPic])

				anim1:addChild(videoSprite1)

				local videoSprite2 = cc.MovieClip:create(BgAnim[self._config[k].PointPic])

				anim2:addChild(videoSprite2)
				videoSprite2:setOpacity(51)
			end
		end
	end
end

function SpStageDftMediator:onTouch(event)
	if event.name == "ended" or event.name == "cancelled" then
		if self._isClickPoint then
			return
		end

		local scrollPosX = self._scrollView:getInnerContainerPosition().x
		local curIndex = math.floor(math.abs(scrollPosX) / self._cellWidth + 0.5) + 1

		self:scrollToCurIndex(curIndex)
	end
end

function SpStageDftMediator:getSweepReward(event)
	self:refreshLeaveTimes()

	local data = event:getData().data
	local type = self:getSpStageSystem():getStageTypeById(self._data.stageId)
	local rewards = {}

	for _, reward in pairs(data) do
		if reward[type] and (reward[type].rewards or reward[type].spNmReward or reward[type].spExRewards) then
			if not reward[type].rewards then
				local baseRewards = {}

				if not reward[type].spNmReward then
					local spNmRewards = {}

					if not reward[type].spExRewards then
						local spExRewards = {}

						if not reward[type].activityExtraReward then
							local activityExtraReward = {}

							for i, value in pairs(baseRewards) do
								for j = 1, #value do
									local has = false

									for k = 1, #rewards do
										if rewards[k].code == value[j].code then
											has = true
											rewards[k].amount = rewards[k].amount + value[j].amount
										end
									end

									if not has then
										table.insert(rewards, value[j])
									end
								end
							end

							for i, value in ipairs(spNmRewards) do
								local has = false

								for j = 1, #rewards do
									if rewards[j].code == value.code then
										has = true
										rewards[j].amount = rewards[j].amount + value.amount
									end
								end

								if not has then
									table.insert(rewards, value)
								end
							end

							for i, value in ipairs(spExRewards) do
								local has = false

								for j = 1, #rewards do
									if rewards[j].code == value.code then
										has = true
										rewards[j].amount = rewards[j].amount + value.amount
									end
								end

								if not has then
									table.insert(rewards, value)
								end
							end

							for i, value in ipairs(activityExtraReward) do
								local has = false

								for j = 1, #rewards do
									if rewards[j].code == value.code then
										has = true
										rewards[j].amount = rewards[j].amount + value.amount
									end
								end

								if not has then
									table.insert(rewards, value)
								end
							end
						end
					end
				end
			end
		end
	end

	if #rewards > 0 then
		local view = self:getInjector():getInstance("getRewardView")

		self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
			maskOpacity = 0
		}, {
			rewards = rewards
		}))
	end
end

function SpStageDftMediator:isClose()
	local config = self._config[self._curIndex]
	local pointId = config.Id
	local close = self:getSpStageSystem():isPointClose(self._data.stageId, pointId)

	if close then
		self:dispatch(ShowTipEvent({
			tip = Strings:get("SPECIAL_STAGE_TEXT_7")
		}))

		return true
	end

	return false
end

function SpStageDftMediator:isTimeEnough()
	local leaveTimes = self:getSpStageSystem():getStageLeaveTime(self._data.stageId)

	if leaveTimes <= 0 then
		self:dispatch(ShowTipEvent({
			tip = Strings:get("SPECIAL_STAGE_TEXT_8")
		}))

		return false
	end

	return true
end

function SpStageDftMediator:isStaminaCostEnough(times)
	times = times or 1

	local config = self._config[self._curIndex]
	local staminaCost = config.StaminaCost * times
	local energy = self._developSystem:getEnergy()

	if energy < staminaCost then
		CurrencySystem:buyCurrencyByType(self, CurrencyType.kActionPoint)

		return false
	end

	return true
end

function SpStageDftMediator:isLevelEnough()
	local config = self._config[self._curIndex]
	local openLevel = config.OpenLevel
	local level = self._developSystem:getPlayer():getLevel()

	if level < openLevel then
		self:dispatch(ShowTipEvent({
			tip = Strings:get("Common_Tip5")
		}))

		return
	end

	return true
end

function SpStageDftMediator:getSweepEffect()
	local function func()
		local url = ConfigReader:getDataByNameIdAndKey("ConfigValue", "MonthCard_Subscribe_ButtonUrl", "content")

		if url and url ~= "" then
			local context = self:getInjector():instantiate(URLContext)
			local entry, params = UrlEntryManage.resolveUrlWithUserData(url)

			if not entry then
				self:dispatch(ShowTipEvent({
					tip = Strings:get("Function_Not_Open")
				}))
			else
				entry:response(context, params)
			end
		end
	end

	local outSelf, delegate = self, {}

	function delegate:willClose(popupMediator, data)
		if data.response == "ok" then
			func()
		elseif data.response == "cancel" then
			-- block empty
		elseif data.response == "close" then
			-- block empty
		end
	end

	local data = {
		title = Strings:get("SHOP_REFRESH_DESC_TEXT1"),
		content = Strings:get("Scribe_AutoClean_OpenTips"),
		sureBtn = {},
		cancelBtn = {}
	}
	local view = self:getInjector():getInstance("AlertView")

	self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
		transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
	}, data, delegate))
end

function SpStageDftMediator:isShowSweepBtn()
	local config = self._config[self._curIndex]
	local pointId = config.Id
	local pointInfo = self:getSpStageSystem():getPointInfo(self._data.stageId)

	if pointInfo and pointInfo[pointId] then
		if not pointInfo[pointId].progress then
			local progress = 0

			if progress <= 0 then
				return false
			end

			local close = self:getSpStageSystem():isPointClose(self._data.stageId, pointId)

			return not close
		end
	end
end

function SpStageDftMediator:onClickSweep(sender, eventType)
	local canSweep = self._spStageSystem:getHasSweepEffect()

	if not canSweep then
		self:getSweepEffect()

		return
	end

	if self:isClose() then
		return
	end

	if not self:isTimeEnough() then
		return
	end

	if not self:isStaminaCostEnough() then
		return
	end

	if not self:isLevelEnough() then
		return
	end

	local config = self._config[self._curIndex]
	local pointId = config.Id
	local pointInfo = self:getSpStageSystem():getPointInfo(self._data.stageId)

	if pointInfo and pointInfo[pointId] then
		if not pointInfo[pointId].progress then
			local progress = 0
			local pointConfig = ConfigReader:requireRecordById("BlockSpPoint", pointId)
			local starCondition = pointConfig.StarCondition.value

			if progress < starCondition[4] then
				self:dispatch(ShowTipEvent({
					tip = Strings:get("Block_Sweep_Unlock")
				}))

				return
			end

			local stageId = self._data.stageId
			local leaveTimes = math.min(self:getSpStageSystem():getStageLeaveTime(stageId), 5)
			local outSelf, delegate = self, {}

			function delegate:willClose(popupMediator, data)
				if not data then
					return
				end

				if data.returnValue == 1 then
					outSelf:onClickBattle()
				elseif data.returnValue == 2 then
					outSelf:onClickWipeTimes(leaveTimes)
				elseif data.returnValue == 3 then
					outSelf:onClickWipeTimes(1)
				end
			end

			local data = {
				normalType = 1,
				stageType = StageType.kElite,
				challengeTimes = leaveTimes
			}

			AudioEngine:getInstance():playEffect("Se_Click_Common_1", false)
			self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, self:getInjector():getInstance("SweepBoxPopView"), {
				transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
			}, data, delegate))
		end
	end
end

function SpStageDftMediator:onClickWipeTimes(times)
	AudioEngine:getInstance():playEffect("Se_Click_Common_1", false)

	if not self:isStaminaCostEnough(times) then
		return
	end

	local params = {}

	params.spType = self:getSpStageSystem():getStageTypeById(self._data.stageId)
	params.pointId = self._config[self._curIndex].Id
	params.times = times

	self:getSpStageSystem():requestSweepSpStage(params, true, function()
		self:onClickSweep()
	end)
end

function SpStageDftMediator:onClickBattle(sender, eventType)
	local config = self._config[self._curIndex]

	if self:isClose() then
		return
	end

	if not self:isTimeEnough() then
		return
	end

	if not self:isStaminaCostEnough() then
		return
	end

	if not self:isLevelEnough() then
		return
	end

	local data = {}

	function data.battleCallback(data)
		local params = {}

		params.spType = self:getSpStageSystem():getStageTypeById(self._data.stageId)
		params.pointId = config.Id
		params.stageId = self._data.stageId
		params.heros = data.heros
		params.masterId = data.masterId

		self:getSpStageSystem():requestEnterSpStage(params)
	end

	data.specialRule = config.SpecialRule
	data.combat = config.CombatValue
	data.cardsExcept = config.CardsExcept

	local teamType = self._spStageSystem:getPointTeamByType(self._stageType)
	local view = self:getInjector():getInstance("StageTeamView")

	self:dispatch(ViewEvent:new(EVT_PUSH_VIEW, view, nil, {
		stageType = teamType,
		stageId = self._data.stageId,
		data = data,
		spStageType = config.Type
	}))
end

function SpStageDftMediator:onClickPointNode(sender, eventType)
	AudioEngine:getInstance():playEffect("Se_Click_Common_1", false)

	self._isClickPoint = true

	local tag = sender:getTag()

	self:scrollToCurIndex(tag)
	delayCallByTime(100, function()
		self._isClickPoint = false
	end)
end

function SpStageDftMediator:onClickBack(sender, eventType)
	self:close()
end

function SpStageDftMediator:onReplayBtnClicked(sender, eventType)
	AudioEngine:getInstance():playEffect("Se_Click_Common_1", false)
	self:dispatch(ShowTipEvent({
		tip = Strings:get("ARENAVIEW_NOTICE")
	}))
end

function SpStageDftMediator:setupTopInfoWidget()
	local topInfoNode = self:getView():getChildByFullName("topinfo_node")
	local config = {
		style = 1,
		currencyInfo = {},
		btnHandler = {
			clickAudio = "Se_Click_Close_1",
			func = bind1(self.onClickBack, self)
		}
	}
	local injector = self:getInjector()

	self._topInfoWidget = self:autoManageObject(injector:injectInto(TopInfoWidget:new(topInfoNode)))

	self._topInfoWidget:updateView(config)
end

function SpStageDftMediator:setupClickEnvs()
	if GameConfigs.closeGuide then
		return
	end

	local storyDirector = self:getInjector():getInstance(story.StoryDirector)
	local sequence = cc.Sequence:create(cc.DelayTime:create(0.5), cc.CallFunc:create(function()
		local btnBattle = self._btnBattle

		storyDirector:setClickEnv("SpStageDftMediator.btnBattle", btnBattle, function()
			AudioEngine:getInstance():playEffect("Se_Click_Close_1", false)
			self:onClickBattle()
		end)
		storyDirector:notifyWaiting("enter_SpStageDftMediator")
	end))

	self:getView():runAction(sequence)
end
