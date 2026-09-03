-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/popup/FunctionEntranceMediator.lua

FunctionEntranceMediator = class("FunctionEntranceMediator", DmAreaViewMediator, _M)

FunctionEntranceMediator:has("_arenaSystem", {
	is = "r"
}):injectWith("ArenaSystem")
FunctionEntranceMediator:has("_petRaceSystem", {
	is = "r"
}):injectWith("PetRaceSystem")
FunctionEntranceMediator:has("_systemKeeper", {
	is = "r"
}):injectWith("SystemKeeper")
FunctionEntranceMediator:has("_stagePracticeSystem", {
	is = "r"
}):injectWith("StagePracticeSystem")
FunctionEntranceMediator:has("_spStageSystem", {
	is = "r"
}):injectWith("SpStageSystem")
FunctionEntranceMediator:has("_exploreSystem", {
	is = "r"
}):injectWith("ExploreSystem")
FunctionEntranceMediator:has("_rtpkSystem", {
	is = "r"
}):injectWith("RTPKSystem")
FunctionEntranceMediator:has("_cooperateBossSystem", {
	is = "r"
}):injectWith("CooperateBossSystem")
FunctionEntranceMediator:has("_leadStageArenaSystem", {
	is = "r"
}):injectWith("LeadStageArenaSystem")
FunctionEntranceMediator:has("_arenaNewSystem", {
	is = "r"
}):injectWith("ArenaNewSystem")
FunctionEntranceMediator:has("_gameServerAgent", {
	is = "r"
}):injectWith("GameServerAgent")

local kFunctionData = {
	{
		cellNode = "arenaCell",
		switchKey = "fn_arena_normal",
		des = "BlockArena_ShowUI_Des"
	},
	{
		cellNode = "petRaceCell",
		switchKey = "fn_arena_pet_race",
		des = "BlockPet_ShowUI_Des"
	},
	{
		cellNode = "friendCell",
		switchKey = "fn_arena_friend",
		des = "BlockSP_ShowUI_Desc"
	},
	{
		cellNode = "cooperateBossCell",
		switchKey = "fn_arena_cooperate_boss",
		des = "BlockSP_ShowUI_Desc"
	},
	{
		cellNode = "rtpkCell",
		switchKey = "fn_arena_rtpk",
		des = "BlockSP_ShowUI_Desc"
	},
	{
		cellNode = "leadStageAreaCell",
		switchKey = "fn_arena_leadStage",
		des = "BlockSP_ShowUI_Desc"
	},
	{
		cellNode = "arenaNewCell",
		switchKey = "fn_arena_new",
		des = "BlockSP_ShowUI_Desc"
	}
}
local EVENT_LOCAL_REFRESH_COOPERATE_STATE = "EVENT_LOCAL_REFRESH_COOPERATE_STATE"

function FunctionEntranceMediator:initialize()
	super.initialize(self)
end

function FunctionEntranceMediator:dispose()
	self._viewClose = true

	if self._rtpkTimer then
		self._rtpkTimer:stop()

		self._rtpkTimer = nil
	end

	if self._stageArenaTimer then
		self._stageArenaTimer:stop()

		self._stageArenaTimer = nil
	end

	if self._aenaNewTimer then
		self._aenaNewTimer:stop()

		self._aenaNewTimer = nil
	end

	super.dispose(self)
end

function FunctionEntranceMediator:onRegister()
	super.onRegister(self)
	self.mapEventListener(self, self:getEventDispatcher(), EVENT_LOCAL_REFRESH_COOPERATE_STATE, self, self.refreshCooperateBossStateLab)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_LEADSTAGE_AEANA_SEASONINFO, self, self.refreshRed)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_NEW_ARENA_FRESH_RIVAL, self, self.refreshAreaNewCell)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_NEW_ARENA_MAIN_INFO, self, self.refreshAreaNewCell)
end

function FunctionEntranceMediator:setupTopInfoWidget(data)
	local topInfoNode = self:getView():getChildByFullName("topinfo_node")
	local var_4_0 = {}

	if data then
		var_4_0.currencyInfo = data.currencyInfo or {}
	end

	var_4_0.btnHandler = {
		clickAudio = "Se_Click_Close_1",
		func = bind1(self.onClickBack, self)
	}
	var_4_0.title = data.title
	var_4_0.style = data.style

	local config = var_4_0
	local injector = self:getInjector()

	self._topInfoWidget = self:autoManageObject(injector:injectInto(TopInfoWidget:new(topInfoNode)))

	self._topInfoWidget:updateView(config)
end

function FunctionEntranceMediator:enterWithData(data)
	self._data = data

	self:setupView(data)
	self:setupClickEnvs()
	self:setLeadStageArenaData()

	if CommonUtils.GetSwitch("fn_arena_rtpk") then
		self._rtpkSystem:checkSeasonData(function()
			if self._viewClose then
				return
			end

			self:refreshRTPKCell()
		end)

		local developSystem = self:getInjector():getInstance(DevelopSystem)
		local playerId = developSystem:getPlayer():getRid()
		local key = playerId .. "rtpk_entertime"
		local curTime = self._gameServerAgent:remoteTimestamp()

		cc.UserDefault:getInstance():setIntegerForKey(key, curTime)
	end
end

function FunctionEntranceMediator:resumeWithData()
	self:refreshRed()
	self:refreshCooperateBoss()

	if CommonUtils.GetSwitch("fn_arena_rtpk") then
		self:refreshRTPKCell()
	end

	self:refreshLeadStageAreanaCell()
	self:refreshAreaNewCell()
end

function FunctionEntranceMediator:setupView(data)
	self:setupTopInfoWidget(data)
	self:initWidgetInfo(data)
end

function FunctionEntranceMediator:setLeadStageArenaData()
	if CommonUtils.GetSwitch("fn_arena_leadStage") then
		self._leadStageArenaSystem:checkSeasonData(function()
			if self._viewClose then
				return
			end

			self:refreshLeadStageAreanaCell()

			local storyDirector = self:getInjector():getInstance(story.StoryDirector)

			storyDirector:notifyWaiting("enter_FunctionEntrance_StageArena_view")
		end)
	end

	if CommonUtils.GetSwitch("fn_arena_new") then
		self._arenaNewSystem:checkSeasonData(function()
			if self._viewClose then
				return
			end

			self:refreshAreaNewCell()
		end)
	end
end

function FunctionEntranceMediator:initWidgetInfo(data)
	self._main = self:getView():getChildByFullName("main")
	self._arenaPanel = self._main:getChildByFullName("arenaPanel")
	self._scrollView = self._main:getChildByFullName("scrollView")

	self._scrollView:setScrollBarEnabled(false)
	self._scrollView:removeAllChildren()

	if not data then
		return
	end

	self._showPanel = self._scrollView

	local action = cc.CSLoader:createTimeline("asset/ui/Athletics.csb")

	action:clearFrameEventCallFunc()
	self._main:stopAllActions()
	self._main:runAction(action)

	local backgroundBG = self._main:getChildByFullName("backgroundBG")

	backgroundBG:setPosition(cc.p(568, 310))
	backgroundBG:runAction(cc.MoveTo:create(0.26666666666666666, cc.p(568, 320)))

	local animPanel = self._arenaPanel:getChildByFullName("animPanel")
	local jjAnim = cc.MovieClip:create("jingjirukou_jingjirukou")

	jjAnim:setPosition(cc.p(0, 0))
	animPanel:addChild(jjAnim)
	jjAnim:addCallbackAtFrame(15, function()
		jjAnim:stop()
	end)

	for i, v in pairs(kFunctionData) do
		local cell = self._arenaPanel:getChildByFullName(v.cellNode)

		cell:setVisible(false)
	end

	action:gotoFrameAndPlay(0, 30, false)

	local index = 1
	local startUpX = 240
	local offsetUp = 330
	local startDownpX = 410
	local offsetDown = 350
	local endX = 0

	if CommonUtils.GetSwitch("fn_arena_normal") then
		local arenaCell = self:createArenaAnim()

		arenaCell:addTo(self._scrollView)
		arenaCell:setName(kFunctionData[1].cellNode)

		local x = startUpX + (index - 1) * offsetUp

		index = index + 1

		arenaCell:setPosition(cc.p(x, 410))

		endX = math.max(endX, x)
	end

	if CommonUtils.GetSwitch("fn_arena_new") and self._systemKeeper:canShow("ChessArena_System") then
		local newArenaCell = self:creatAreaNewCellAnim()

		newArenaCell:addTo(self._scrollView)
		newArenaCell:setName(kFunctionData[7].cellNode)

		local x = startUpX + (index - 1) * offsetUp

		index = index + 1

		newArenaCell:setPosition(cc.p(x, 410))
		self:refreshAreaNewCell()

		endX = math.max(endX, x)
	end

	if CommonUtils.GetSwitch("fn_arena_pet_race") then
		local petRaceCell = self:createPetRaceAnim()

		petRaceCell:addTo(self._scrollView)
		petRaceCell:setName(kFunctionData[2].cellNode)

		local x = startUpX + (index - 1) * offsetUp

		index = index + 1

		petRaceCell:setPosition(cc.p(x, 410))

		endX = math.max(endX, x)
	end

	if CommonUtils.GetSwitch("fn_arena_rtpk") then
		local rtpkCell = self:createRTPKAnim()

		rtpkCell:addTo(self._scrollView)
		rtpkCell:setName(kFunctionData[5].cellNode)

		local x = startUpX + (index - 1) * offsetUp

		index = index + 1

		rtpkCell:setPosition(cc.p(x, 410))
		self:refreshRTPKCell()

		endX = math.max(endX, x)
	end

	index = 1

	if CommonUtils.GetSwitch(kFunctionData[4].switchKey) then
		if self._cooperateBossSystem:cooperateBossShow() then
			local petRaceCell = self:createCooperateBossAnim()

			petRaceCell:addTo(self._scrollView)
			petRaceCell:setName(kFunctionData[4].cellNode)

			local x = startDownpX + (index - 1) * offsetDown

			petRaceCell:setPosition(cc.p(x, 165))

			endX = math.max(endX, x)
		end

		index = index + 1
	end

	if CommonUtils.GetSwitch("fn_arena_leadStage") and self._systemKeeper:canShow("StageArena") then
		local leadStageCell = self:creatLeadStageAnim()

		leadStageCell:addTo(self._scrollView)
		leadStageCell:setName(kFunctionData[6].cellNode)

		local x = startDownpX + (index - 1) * offsetDown

		index = index + 1

		leadStageCell:setPosition(cc.p(x, 165))

		endX = math.max(endX, x)

		self:refreshLeadStageAreanaCell()
	end

	if CommonUtils.GetSwitch("fn_arena_friend") then
		local petRaceCell = self:createFriendAnim()

		petRaceCell:addTo(self._scrollView)
		petRaceCell:setName(kFunctionData[3].cellNode)

		local x = startDownpX + (index - 1) * offsetDown

		index = index + 1

		petRaceCell:setPosition(cc.p(x, 165))

		endX = math.max(endX, x)
	end

	local size = self._scrollView:getContentSize()
	local cellX = endX + 200 + AdjustUtils.getAdjustX()
	local width = math.max(size.width, cellX)

	self._scrollView:setInnerContainerSize(cc.size(width, size.height))

	if cellX < width then
		local offsetX = width - cellX

		self._scrollView:offset(offsetX * 0.5 - 50, 0)
	end

	local function onFrameEvent(frame)
		if frame == nil then
			return
		end

		local str = frame:getEvent()

		if str == "ArenaAnim" and CommonUtils.GetSwitch("fn_arena_normal") then
			self._showPanel:getChildByFullName("arenaCell.ShowAnim"):setVisible(true)
			self._showPanel:getChildByFullName("arenaCell.ShowAnim"):gotoAndPlay(0)
		end

		if str == "ArenaNewAnim" and CommonUtils.GetSwitch("fn_arena_new") and self._systemKeeper:canShow("ChessArena_System") then
			self._showPanel:getChildByFullName("arenaNewCell.ShowAnim"):setVisible(true)
			self._showPanel:getChildByFullName("arenaNewCell.ShowAnim"):gotoAndPlay(0)
		end

		if str == "PetRaceAnim" and CommonUtils.GetSwitch("fn_arena_pet_race") then
			self._showPanel:getChildByFullName("petRaceCell.ShowAnim"):setVisible(true)
			self._showPanel:getChildByFullName("petRaceCell.ShowAnim"):gotoAndPlay(0)
		end

		if str == "FriendAnim" and CommonUtils.GetSwitch("fn_arena_friend") then
			self._showPanel:getChildByFullName("friendCell.ShowAnim"):setVisible(true)
			self._showPanel:getChildByFullName("friendCell.ShowAnim"):gotoAndPlay(0)
		end

		if str == "CooperateBossAnim" and CommonUtils.GetSwitch(kFunctionData[4].switchKey) and self._cooperateBossSystem:cooperateBossShow() then
			self._showPanel:getChildByFullName("cooperateBossCell.ShowAnim"):setVisible(true)
			self._showPanel:getChildByFullName("cooperateBossCell.ShowAnim"):gotoAndPlay(0)
		end

		if str == "RTPKAnim" and CommonUtils.GetSwitch("fn_arena_rtpk") then
			self._showPanel:getChildByFullName("rtpkCell.ShowAnim"):setVisible(true)
			self._showPanel:getChildByFullName("rtpkCell.ShowAnim"):gotoAndPlay(0)
		end

		if str == "LeadStageAnim" and CommonUtils.GetSwitch("fn_arena_leadStage") and self._systemKeeper:canShow("StageArena") then
			self._showPanel:getChildByFullName("leadStageAreaCell.ShowAnim"):setVisible(true)
			self._showPanel:getChildByFullName("leadStageAreaCell.ShowAnim"):gotoAndPlay(0)
		end

		if str == "redShow" then
			self:refreshRed()
		end
	end

	action:setFrameEventCallFunc(onFrameEvent)
	self:refreshView()
end

function FunctionEntranceMediator:createArenaAnim()
	local arenaCell = self._arenaPanel:getChildByFullName("arenaCell"):clone()

	arenaCell:setVisible(true)

	local descLabel = arenaCell:getChildByFullName("text"):clone()

	descLabel:setVisible(true)

	local redPoint = arenaCell:getChildByFullName("redPoint"):clone()

	arenaCell:removeAllChildren()

	local anim = cc.MovieClip:create("arenaCell_jingjirukou")

	anim:addTo(arenaCell)
	anim:addCallbackAtFrame(21, function()
		anim:stop()
	end)
	anim:setPosition(cc.p(126, 120))
	anim:setName("ShowAnim")
	anim:setVisible(false)

	local descPanel = anim:getChildByFullName("descPanel")

	if descPanel then
		descPanel:removeAllChildren()
		descLabel:addTo(descPanel):posite(-70, 4)
		redPoint:addTo(descPanel):posite(80, 36)

		arenaCell.redPoint = redPoint
	end

	return arenaCell
end

function FunctionEntranceMediator:createPetRaceAnim()
	local petRaceCell = self._arenaPanel:getChildByFullName("petRaceCell"):clone()

	petRaceCell:setVisible(true)

	local descLabel = petRaceCell:getChildByFullName("text"):clone()

	descLabel:setVisible(true)

	local redPoint = petRaceCell:getChildByFullName("redPoint"):clone()

	petRaceCell:removeAllChildren()

	local anim = cc.MovieClip:create("petRaceCell_jingjirukou")

	anim:addTo(petRaceCell)
	anim:addCallbackAtFrame(21, function()
		anim:stop()
	end)
	anim:setPosition(cc.p(140, 130))
	anim:setName("ShowAnim")
	anim:setVisible(false)

	local descPanel = anim:getChildByFullName("descPanel")

	if descPanel then
		descPanel:removeAllChildren()
		descLabel:addTo(descPanel):posite(-70, 4)
		redPoint:addTo(descPanel):posite(90, -20)

		petRaceCell.redPoint = redPoint
	end

	return petRaceCell
end

function FunctionEntranceMediator:createFriendAnim()
	local petRaceCell = self._arenaPanel:getChildByFullName("friendCell"):clone()

	petRaceCell:setVisible(true)

	local descLabel = petRaceCell:getChildByFullName("text"):clone()

	descLabel:setVisible(true)

	local redPoint = petRaceCell:getChildByFullName("redPoint"):clone()

	petRaceCell:removeAllChildren()

	local anim = cc.MovieClip:create("friendCell_jingjirukou")

	anim:addTo(petRaceCell)
	anim:addCallbackAtFrame(26, function()
		anim:stop()
	end)
	anim:setPosition(cc.p(160, 120))
	anim:setName("ShowAnim")
	anim:setVisible(false)

	local descPanel = anim:getChildByFullName("descPanel")

	if descPanel then
		descPanel:removeAllChildren()
		descLabel:addTo(descPanel):posite(-70, 0)
		redPoint:addTo(descPanel):posite(80, -20)

		petRaceCell.redPoint = redPoint
	end

	return petRaceCell
end

function FunctionEntranceMediator:createCooperateBossAnim()
	local petRaceCell = self._arenaPanel:getChildByFullName("cooperateBossCell"):clone()

	petRaceCell:setVisible(true)

	local descLabel = petRaceCell:getChildByFullName("text"):clone()
	local text1 = petRaceCell:getChildByFullName("text1"):clone()
	local richText = ccui.RichText:createWithXML("", {})

	richText:setAnchorPoint(text1:getAnchorPoint())
	richText:setPosition(cc.p(text1:getPosition()))
	richText:renderContent(200, 0, true)

	self._cooperateBossStateLabel = richText

	local timeLabel = petRaceCell:getChildByFullName("text2"):clone()

	descLabel:setVisible(true)
	timeLabel:setVisible(true)
	self._cooperateBossStateLabel:setVisible(true)

	local redPoint = petRaceCell:getChildByFullName("redPoint"):clone()

	petRaceCell:removeAllChildren()

	local state = self._cooperateBossSystem:getcooperateBossState()
	local startTime = TimeUtil:localDate("%Y.%m.%d", self._cooperateBossSystem:getCooperateBoss():getHotTime())
	local endTime = TimeUtil:localDate("%Y.%m.%d", self._cooperateBossSystem:getCooperateBoss():getEndTime())

	if kCooperateBossState.kPreHot == state then
		self._cooperateBossStateLabel:setString(Strings:get("Boss_Times_UI01", {
			fontSize = 14,
			fontName = TTF_FONT_FZYH_R
		}))
		timeLabel:setString(Strings:get("CooperateBoss_Entry_UI02", {
			Start = startTime,
			End = endTime
		}))
	elseif kCooperateBossState.kStart == state then
		self._cooperateBossSystem:requestGetInviteInfo(function()
			if DisposableObject:isDisposed(self) or DisposableObject:isDisposed(self:getView()) then
				return
			end

			local curTimes = self._cooperateBossSystem:getCooperateBoss():getBossFightTimes()
			local resetData = DataReader:getDataByNameIdAndKey("Reset", "CooperateBoss", "ResetSystem")

			if curTimes then
				if curTimes.value <= 0 then
					self._cooperateBossStateLabel:setString(Strings:get("CooperateBoss_Times_Red", {
						fontSize = 14,
						fontName = TTF_FONT_FZYH_R,
						cur = curTimes.value,
						total = resetData.max
					}))
				else
					self._cooperateBossStateLabel:setString(Strings:get("CooperateBoss_Times_Orange", {
						fontSize = 14,
						fontName = TTF_FONT_FZYH_R,
						cur = curTimes.value,
						total = resetData.max
					}))
				end
			end
		end)
		timeLabel:setString(Strings:get("CooperateBoss_Entry_UI04", {
			EndTime = endTime
		}))
	elseif kCooperateBossState.kEnd == state then
		self._cooperateBossStateLabel:setString(Strings:get("Boss_Times_UI02", {
			fontSize = 18,
			fontName = TTF_FONT_FZYH_R
		}))
		timeLabel:setString(Strings:get("CooperateBoss_Entry_UI04", {
			EndTime = endTime
		}))
	end

	local anim = cc.MovieClip:create("cooperateBossCell_jingjirukou")

	anim:addTo(petRaceCell)
	anim:addCallbackAtFrame(26, function()
		anim:stop()
	end)
	anim:setPosition(cc.p(146, 120))
	anim:setName("ShowAnim")
	anim:setVisible(false)

	local descPanel = anim:getChildByFullName("descPanel")

	if descPanel then
		descPanel:removeAllChildren()
		descLabel:addTo(descPanel):posite(-70, 5)
		self._cooperateBossStateLabel:addTo(descPanel):posite(-13, 37)
		self._cooperateBossStateLabel:setName("stateLabel")
		timeLabel:addTo(descPanel):posite(0, -36)
		redPoint:addTo(descPanel):posite(80, -10)

		petRaceCell.redPoint = redPoint
	end

	return petRaceCell
end

function FunctionEntranceMediator:refreshCooperateBoss()
	local cooperateBossCell = self._showPanel:getChildByFullName("cooperateBossCell")

	if not cooperateBossCell then
		return
	end

	local coopNode = self._showPanel:getChildByFullName("cooperateBossCell.ShowAnim")

	if self._cooperateBossStateLabel and not DisposableObject:isDisposed(self._cooperateBossStateLabel) then
		local state = self._cooperateBossSystem:getcooperateBossState()

		if kCooperateBossState.kPreHot == state then
			self._cooperateBossStateLabel:setString(Strings:get("Boss_Times_UI01", {
				fontSize = 18,
				fontName = TTF_FONT_FZYH_R
			}))
		elseif kCooperateBossState.kStart == state then
			self._cooperateBossSystem:requestGetInviteInfo(function()
				self:dispatch(Event:new(EVENT_LOCAL_REFRESH_COOPERATE_STATE))
			end)
		elseif kCooperateBossState.kEnd == state then
			self._showPanel:getChildByFullName("cooperateBossCell.ShowAnim"):setVisible(false)
			self._showPanel:getChildByFullName("cooperateBossCell.ShowAnim"):stop()
		end
	end
end

function FunctionEntranceMediator:refreshCooperateBossStateLab()
	self._cooperateBossStateLabel:setVisible(true)

	local resetData = DataReader:getDataByNameIdAndKey("Reset", "CooperateBoss", "ResetSystem")
	local curTimes = self._cooperateBossSystem:getCooperateBoss():getBossFightTimes()

	if curTimes then
		if curTimes.value <= 0 then
			self._cooperateBossStateLabel:setString(Strings:get("CooperateBoss_Times_Red", {
				fontSize = 18,
				fontName = TTF_FONT_FZYH_R,
				cur = curTimes.value,
				total = resetData.max
			}))
		else
			self._cooperateBossStateLabel:setString(Strings:get("CooperateBoss_Times_Orange", {
				fontSize = 18,
				fontName = TTF_FONT_FZYH_R,
				cur = curTimes.value,
				total = resetData.max
			}))
		end
	end
end

function FunctionEntranceMediator:createRTPKAnim()
	local rtpkCell = self._arenaPanel:getChildByFullName("rtpkCell"):clone()

	rtpkCell:setVisible(true)

	local redPoint = rtpkCell:getChildByFullName("redPoint"):clone()

	redPoint:setVisible(false)

	local seasonLabel = rtpkCell:getChildByFullName("text1"):clone()
	local timeLabel = rtpkCell:getChildByFullName("text2"):clone()

	seasonLabel:setVisible(true)
	timeLabel:setVisible(true)
	rtpkCell:removeAllChildren()

	local anim = cc.MovieClip:create("rtpkCell_jingjirukou")

	anim:addTo(rtpkCell)
	anim:addCallbackAtFrame(21, function()
		anim:stop()
	end)
	anim:setPosition(cc.p(160, 120))
	anim:setName("ShowAnim")
	anim:setVisible(false)

	local descPanel = anim:getChildByFullName("descPanel")

	if descPanel then
		seasonLabel:addTo(descPanel):posite(0, 10)
		seasonLabel:setFontSize(16)
		timeLabel:addTo(descPanel):posite(0, -12)
		redPoint:addTo(descPanel, 5):posite(115, -20)

		rtpkCell.redPoint = redPoint
		rtpkCell.seasonLabel = seasonLabel
		rtpkCell.timeLabel = timeLabel

		local img = ccui.ImageView:create("RTPK_yq_rk.png", ccui.TextureResType.plistType)
		local text = ccui.Text:create(Strings:get("RTPK_DoubleScore"), TTF_FONT_FZYH_R, 18)

		text:getVirtualRenderer():setDimensions(77, 25)
		text:addTo(img):center(img:getContentSize()):offset(-1, 4)
		img:addTo(descPanel):posite(71, 20)

		rtpkCell.doubleImg = img

		rtpkCell.doubleImg:setVisible(false)
	end

	return rtpkCell
end

function FunctionEntranceMediator:refreshRTPKCell()
	local rtpkCell = self._showPanel:getChildByFullName("rtpkCell")

	if not rtpkCell or not rtpkCell:isVisible() then
		return
	end

	local seasonLabel = rtpkCell.seasonLabel
	local timeLabel = rtpkCell.timeLabel
	local systemKeeper = self:getInjector():getInstance("SystemKeeper")
	local unlock, tips, unLockLevel = systemKeeper:isUnlock("RTPK")

	if not unlock then
		local config = ConfigReader:getRecordById("UnlockSystem", "RTPK")

		seasonLabel:setVisible(false)
		timeLabel:setString(Strings:get("RTPK_EntryUnlockTipShow", {
			uLevel = unLockLevel,
			serverDay = config.Condition.SERVER
		}))
	else
		self:refreshRTPKTimer()
	end
end

function FunctionEntranceMediator:refreshRTPKTimer()
	local rtpkCell = self._showPanel:getChildByFullName("rtpkCell")
	local seasonLabel = rtpkCell.seasonLabel
	local timeLabel = rtpkCell.timeLabel
	local rtpk = self._rtpkSystem:getRtpk()

	if self._rtpkTimer then
		self._rtpkTimer:stop()

		self._rtpkTimer = nil
	end

	local function update()
		local status = rtpk:getCurStatus()
		local curTime = self._gameServerAgent:remoteTimestamp()

		if status ~= RTPKSeasonStatus.kRest then
			local seasonConfig = rtpk:getSeasonConfig()

			seasonLabel:setVisible(true)
			seasonLabel:setString(Strings:get("RTPK_Main_Season", {
				index = seasonConfig.SeasonOrder
			}) .. Strings:get("RTPK_Main_SeasonText"))

			local param = self._rtpkSystem:formatMatchTimeParam()

			timeLabel:setString(Strings:get("RTPK_OpenTime_Entry", param))

			local isDouble = self._rtpkSystem:isDoubleScore()

			if isDouble then
				rtpkCell.doubleImg:setVisible(true)
				rtpkCell.redPoint:setVisible(false)
				seasonLabel:setAnchorPoint(cc.p(0, 0.5))
				seasonLabel:setPositionX(-40)
			else
				rtpkCell.doubleImg:setVisible(false)
				seasonLabel:setAnchorPoint(cc.p(0.5, 0.5))
				seasonLabel:setPositionX(25)
			end

			local remainTime = math.max(rtpk:getCloseTime() - curTime, 0)

			if remainTime == 0 then
				self._rtpkSystem:requestRTPKInfo(function()
					if self._viewClose then
						return
					end

					self:refreshRed()
				end, false)
			end
		else
			seasonLabel:setVisible(false)

			if self._rtpkSystem:getSeasonNextCD() > 0 then
				local str = ""
				local remainTime = math.max(self._rtpkSystem:getSeasonNextCD() - curTime, 0)
				local fmtStr = "${d}:${HH}:${M}:${SS}"
				local timeStr = TimeUtil:formatTime(fmtStr, remainTime)
				local parts = string.split(timeStr, ":", nil, true)
				local timeTab = {}

				timeTab.day = tonumber(parts[1])
				timeTab.hour = tonumber(parts[2])
				timeTab.min = tonumber(parts[3])
				timeTab.sec = tonumber(parts[4])
				str = timeTab.day > 0 and timeTab.day .. Strings:get("TimeUtil_Day") .. timeTab.hour .. Strings:get("RTPK_TimeUtil_Hour") or timeTab.hour > 0 and timeTab.hour .. Strings:get("RTPK_TimeUtil_Hour") .. timeTab.min .. Strings:get("TimeUtil_Min") or timeTab.min > 0 and timeTab.min .. Strings:get("TimeUtil_Min") .. timeTab.sec .. Strings:get("TimeUtil_Sec") or timeTab.sec .. Strings:get("TimeUtil_Sec")

				timeLabel:setString(Strings:get("RTPK_NewSeason_Countdown", {
					time = str
				}))

				if remainTime == 0 then
					self._rtpkSystem:requestRTPKInfo(function()
						if self._viewClose then
							return
						end

						self:refreshRed()
					end, false)
				end
			else
				timeLabel:setString(Strings:get("Function_Not_Open"))
			end
		end
	end

	self._rtpkTimer = LuaScheduler:getInstance():schedule(update, 1, false)

	update()
end

function FunctionEntranceMediator:creatLeadStageAnim()
	local leadStageCell = self._arenaPanel:getChildByFullName("leadStageAreaCell"):clone()

	leadStageCell:setVisible(true)

	local redPoint = leadStageCell:getChildByFullName("redPoint"):clone()

	redPoint:setVisible(false)

	local seasonLabel = leadStageCell:getChildByFullName("text1"):clone()
	local timeLabel = leadStageCell:getChildByFullName("text2"):clone()

	seasonLabel:setVisible(true)
	timeLabel:setVisible(true)
	leadStageCell:removeAllChildren()

	local anim = cc.MovieClip:create("zhu_buyeyourukouanniu")

	anim:addTo(leadStageCell)
	anim:addCallbackAtFrame(21, function()
		anim:stop()
	end)
	anim:setPosition(cc.p(50, 30))
	anim:setName("ShowAnim")
	anim:setVisible(false)

	local descPanel = anim:getChildByFullName("descPanel")

	if descPanel then
		seasonLabel:addTo(descPanel):posite(-96, 16)
		timeLabel:addTo(descPanel):posite(-96, -14)
		redPoint:addTo(descPanel):posite(120, 35)

		leadStageCell.redPoint = redPoint
		leadStageCell.seasonLabel = seasonLabel
		leadStageCell.timeLabel = timeLabel
	end

	return leadStageCell
end

function FunctionEntranceMediator:refreshLeadStageAreanaCell()
	local stageArenaCell = self._showPanel:getChildByFullName("leadStageAreaCell")

	if not stageArenaCell or not stageArenaCell:isVisible() then
		return
	end

	local seasonLabel = stageArenaCell.seasonLabel
	local timeLabel = stageArenaCell.timeLabel
	local systemKeeper = self:getInjector():getInstance("SystemKeeper")
	local unlock, tips, unLockLevel = systemKeeper:isUnlock("StageArena")

	if not unlock then
		local config = ConfigReader:getRecordById("UnlockSystem", "StageArena")
		local condition = config.Condition

		seasonLabel:setVisible(false)
		timeLabel:setString(Strings:get("StageArena_Unlock_EntryText", {
			uLevel = condition.LEVEL,
			leaderNum = condition.LEADER
		}))
	else
		self:refreshStageArenaTimer()
	end
end

function FunctionEntranceMediator:refreshStageArenaTimer()
	local stageArenaCell = self._showPanel:getChildByFullName("leadStageAreaCell")
	local seasonLabel = stageArenaCell.seasonLabel
	local timeLabel = stageArenaCell.timeLabel
	local stageArena = self._leadStageArenaSystem:getLeadStageArena()

	if self._stageArenaTimer then
		self._stageArenaTimer:stop()

		self._stageArenaTimer = nil
	end

	local function update()
		local status = stageArena:getCurStatus()
		local curTime = self._gameServerAgent:remoteTimestamp()

		if status ~= LeadStageArenaState.KReset then
			local seasonConfig = stageArena:getConfig()

			seasonLabel:setVisible(true)
			seasonLabel:setString(Strings:get("StageArena_Entry_Desc"))

			local startTime = TimeUtil:localDate("%Y.%m.%d", stageArena:getStartTime())
			local endTime = TimeUtil:localDate("%Y.%m.%d", stageArena:getEndTime())

			timeLabel:setString(startTime .. "-" .. endTime)

			local remainTime = math.max(stageArena:getCloseTime() - curTime, 0)

			if remainTime == 0 then
				self._leadStageArenaSystem:requestGetSeasonInfo(function()
					if self._viewClose then
						return
					end

					self:refreshRed()
				end, false)
			end
		else
			seasonLabel:setVisible(false)

			if self._leadStageArenaSystem:getSeasonNextCD() > 0 then
				local str = ""
				local remainTime = math.max(self._leadStageArenaSystem:getSeasonNextCD() - curTime, 0)
				local fmtStr = "${d}:${HH}:${M}:${SS}"
				local timeStr = TimeUtil:formatTime(fmtStr, remainTime)
				local parts = string.split(timeStr, ":", nil, true)
				local timeTab = {}

				timeTab.day = tonumber(parts[1])
				timeTab.hour = tonumber(parts[2])
				timeTab.min = tonumber(parts[3])
				timeTab.sec = tonumber(parts[4])
				str = timeTab.day > 0 and timeTab.day .. Strings:get("TimeUtil_Day") .. timeTab.hour .. Strings:get("RTPK_TimeUtil_Hour") or timeTab.hour > 0 and timeTab.hour .. Strings:get("RTPK_TimeUtil_Hour") .. timeTab.min .. Strings:get("TimeUtil_Min") or timeTab.min > 0 and timeTab.min .. Strings:get("TimeUtil_Min") .. timeTab.sec .. Strings:get("TimeUtil_Sec") or timeTab.sec .. Strings:get("TimeUtil_Sec")

				timeLabel:setString(Strings:get("RTPK_NewSeason_Countdown", {
					time = str
				}))

				if remainTime == 0 then
					self._leadStageArenaSystem:requestGetSeasonInfo(function()
						if self._viewClose then
							return
						end

						self:refreshRed()
					end, false)
				end
			else
				timeLabel:setString(Strings:get("Function_Not_Open"))
			end
		end
	end

	self._stageArenaTimer = LuaScheduler:getInstance():schedule(update, 1, false)

	update()
end

function FunctionEntranceMediator:creatAreaNewCellAnim()
	local newArenaCell = self._arenaPanel:getChildByFullName("arenaNewCell"):clone()

	newArenaCell:setVisible(true)

	local redPoint = newArenaCell:getChildByFullName("redPoint"):clone()

	redPoint:setVisible(false)

	local seasonLabel = newArenaCell:getChildByFullName("text1"):clone()
	local timeLabel = newArenaCell:getChildByFullName("text2"):clone()

	seasonLabel:setVisible(true)
	timeLabel:setVisible(true)
	newArenaCell:removeAllChildren()

	local anim = cc.MovieClip:create("mengjingjichangNEW_jingjirukou")

	anim:addTo(newArenaCell)
	anim:addCallbackAtFrame(21, function()
		anim:stop()
	end)
	anim:setPosition(cc.p(140, 130))
	anim:setName("ShowAnim")
	anim:setVisible(false)

	local descPanel = anim:getChildByFullName("descPanel")

	if descPanel then
		seasonLabel:addTo(descPanel):posite(-58, 24)
		timeLabel:addTo(descPanel):posite(-58, -14)
		redPoint:addTo(descPanel):posite(80, 35)

		newArenaCell.redPoint = redPoint
		newArenaCell.seasonLabel = seasonLabel
		newArenaCell.timeLabel = timeLabel
	end

	return newArenaCell
end

function FunctionEntranceMediator:refreshAreaNewCell()
	local newArenaCell = self._showPanel:getChildByFullName("arenaNewCell")

	if not newArenaCell or not newArenaCell:isVisible() then
		return
	end

	self:refreshRed()

	local seasonLabel = newArenaCell.seasonLabel
	local timeLabel = newArenaCell.timeLabel
	local systemKeeper = self:getInjector():getInstance("SystemKeeper")
	local unlock, tips, unLockLevel = systemKeeper:isUnlock("ChessArena_System")

	if not unlock then
		seasonLabel:setVisible(false)
		timeLabel:setString(tips)
	else
		self:refreshAreaNewTimer()
	end
end

function FunctionEntranceMediator:refreshAreaNewTimer()
	local newArenaCell = self._showPanel:getChildByFullName("arenaNewCell")
	local seasonLabel = newArenaCell.seasonLabel
	local timeLabel = newArenaCell.timeLabel
	local newArena = self._arenaNewSystem:getArenaNew()

	if self._aenaNewTimer then
		self._aenaNewTimer:stop()

		self._aenaNewTimer = nil
	end

	local function update()
		local seasonData = self._arenaNewSystem:getSeasonData()

		if seasonData then
			seasonLabel:setVisible(true)
			timeLabel:setVisible(true)
			seasonLabel:setContentSize(cc.size(150, 30))
			seasonLabel:setString(Strings:get(self._arenaNewSystem:getCurSeasonData().SeasonTitle))

			local startTime = TimeUtil:localDate("%Y.%m.%d", self._arenaNewSystem:getStartTime())
			local endTime = TimeUtil:localDate("%Y.%m.%d", self._arenaNewSystem:getEndTime())

			timeLabel:setString(startTime .. "-" .. endTime)
		else
			local nextConfig = self._arenaNewSystem:getNextSeasonStartTime()

			if nextConfig then
				seasonLabel:setVisible(true)
				timeLabel:setVisible(false)
				seasonLabel:setContentSize(cc.size(150, 50))

				local curTime = self._gameServerAgent:remoteTimestamp()
				local year = TimeUtil:remoteDate("*t", curTime).year
				local str = ""
				local st = nextConfig.TimeFactor.start

				st = year .. "-" .. st

				local _, _, y, m, d, hour, min, sec = string.find(st, "(%d+)-(%d+)-(%d+)%s*(%d+):(%d+):(%d+)")
				local timestamp = TimeUtil:timeByRemoteDate({
					year = year,
					month = m,
					day = d,
					hour = hour,
					min = min,
					sec = sec
				})
				local remainTime = timestamp - curTime
				local fmtStr = "${d}:${HH}:${M}:${SS}"
				local timeStr = TimeUtil:formatTime(fmtStr, remainTime)
				local parts = string.split(timeStr, ":", nil, true)
				local timeTab = {}

				timeTab.day = tonumber(parts[1])
				timeTab.hour = tonumber(parts[2])
				timeTab.min = tonumber(parts[3])
				timeTab.sec = tonumber(parts[4])
				str = timeTab.day > 0 and timeTab.day .. Strings:get("TimeUtil_Day") .. timeTab.hour .. Strings:get("RTPK_TimeUtil_Hour") or timeTab.hour > 0 and timeTab.hour .. Strings:get("RTPK_TimeUtil_Hour") .. timeTab.min .. Strings:get("TimeUtil_Min") or timeTab.min > 0 and timeTab.min .. Strings:get("TimeUtil_Min") .. timeTab.sec .. Strings:get("TimeUtil_Sec") or timeTab.sec .. Strings:get("TimeUtil_Sec")

				seasonLabel:setString(Strings:get("RTPK_NewSeason_Countdown", {
					time = str
				}))

				if remainTime <= 0 and remainTime > -1 then
					self._arenaNewSystem:checkSeasonData(function()
						if self._viewClose then
							return
						end

						self:refreshRed()
					end)
				end
			else
				timeLabel:setVisible(true)
				seasonLabel:setVisible(false)
				timeLabel:setString(Strings:get("StageArena_EntryUI02"))
			end
		end
	end

	self._aenaNewTimer = LuaScheduler:getInstance():schedule(update, 1, false)

	update()
end

function FunctionEntranceMediator:createRulePanel(parent, str)
	local image = ccui.ImageView:create("asset/common/sl_bg_msd.png")

	image:setAnchorPoint(cc.p(1, 0.5))
	image:addTo(parent):posite(132, -13)

	local label = cc.Label:createWithTTF(str, TTF_FONT_FZYH_M, 19)

	GameStyle:setCommonOutlineEffect(label, 255)
	label:setAnchorPoint(cc.p(1, 0.5))
	label:addTo(image):posite(242, 32)
	image:setOpacity(0)
	performWithDelay(self:getView(), function()
		image:fadeIn({
			time = 0.2
		})
	end, 0.5)

	return image
end

function FunctionEntranceMediator:refreshView()
	for i = 1, #kFunctionData do
		local data = kFunctionData[i]
		local cellNode = data.cellNode
		local panel = self._showPanel:getChildByFullName(cellNode)

		if panel and CommonUtils.GetSwitch(data.switchKey) then
			panel:addClickEventListener(function()
				self:clickPanel(i)
			end)
		end
	end
end

function FunctionEntranceMediator:clickPanel(index)
	if index == 1 then
		self:enterArenaView()
	elseif index == 2 then
		self:enterPetRaceView()
	elseif index == 3 then
		self:enterFriendView()
	elseif index == 4 then
		if self._cooperateBossSystem:getcooperateBossState() == kCooperateBossState.kStart then
			self:enterCooperateBoss()
		elseif self._cooperateBossSystem:getcooperateBossState() == kCooperateBossState.kPreHot then
			local startTime = TimeUtil:localDate("%m" .. Strings:get("Setting_UI_Month") .. "%d" .. Strings:get("Setting_UI_Day"), self._cooperateBossSystem:getCooperateBoss():getHotTime())

			self:dispatch(ShowTipEvent({
				tip = Strings:get("CooperateBoss_Entry_UI07", {
					StartTime = startTime
				})
			}))
		end
	elseif index == 5 then
		self:enterRTPKView()
	elseif index == 6 then
		self:enterLeadStageArenaView()
	elseif index == 7 then
		self:enterAreanaView()
	end
end

function FunctionEntranceMediator:refreshRed()
	local redFunc = {
		function()
			return self._arenaSystem:checkAwardRed()
		end,
		function()
			return self._petRaceSystem:redPointShow()
		end,
		function()
			return false
		end,
		function()
			return self._cooperateBossSystem:redPointShow()
		end,
		function()
			return self._rtpkSystem:checkShowRed() and not self._rtpkSystem:isDoubleScore()
		end,
		function()
			return self._leadStageArenaSystem:checkShowRed()
		end,
		function()
			return self._arenaNewSystem:checkShowRed()
		end
	}

	for i = 1, #kFunctionData do
		local data = kFunctionData[i]
		local cellNode = data.cellNode
		local panel = self._showPanel:getChildByFullName(cellNode)

		if panel then
			local redPoint1 = panel:getChildByFullName("redPoint")
			local redPoint2 = panel.redPoint
			local resShow = redFunc[i]()

			if redPoint1 then
				redPoint1:setVisible(resShow)
			end

			if redPoint2 then
				redPoint2:setVisible(resShow)
			end
		end
	end
end

function FunctionEntranceMediator:enterArenaView()
	local unlock, tip = self._arenaSystem:checkEnabled()

	if not unlock then
		AudioEngine:getInstance():playEffect("Se_Alert_Error", false)
		self:dispatch(ShowTipEvent({
			tip = tip
		}))
	else
		AudioEngine:getInstance():playEffect("Se_Click_Open_1", false)
		self:getArenaSystem():tryEnter()
	end
end

function FunctionEntranceMediator:enterPetRaceView()
	local unlock, tip = self._petRaceSystem:checkEnabled()

	if not unlock then
		AudioEngine:getInstance():playEffect("Se_Alert_Error", false)
		self:dispatch(ShowTipEvent({
			tip = tip
		}))
	else
		AudioEngine:getInstance():playEffect("Se_Click_Open_1", false)
		self:getPetRaceSystem():tryEnter()
	end
end

function FunctionEntranceMediator:enterFriendView()
	local systemKeeper = self:getInjector():getInstance("SystemKeeper")
	local unlock, tips = systemKeeper:isUnlock("Friend_PK")

	if unlock then
		AudioEngine:getInstance():playEffect("Se_Click_Open_1", false)

		local friendPvpSystem = self:getInjector():getInstance(FriendPvpSystem)

		friendPvpSystem:tryEnter()
	else
		AudioEngine:getInstance():playEffect("Se_Alert_Error", false)
		self:dispatch(ShowTipEvent({
			tip = tips
		}))
	end
end

function FunctionEntranceMediator:enterRTPKView()
	self._rtpkSystem:tryEnter()
end

function FunctionEntranceMediator:enterCooperateBoss()
	self._cooperateBossSystem:enterCooperateBoss()
end

function FunctionEntranceMediator:enterLeadStageArenaView()
	self._leadStageArenaSystem:tryEnter()
end

function FunctionEntranceMediator:enterAreanaView()
	AudioEngine:getInstance():playEffect("Se_Click_Open_1", false)
	self._arenaNewSystem:tryEnter()
end

function FunctionEntranceMediator:onClickBack(sender, eventType)
	self._main:stopAllActions()
	self:dismissWithOptions({
		transition = ViewTransitionFactory:create(ViewTransitionType.kCommonAreaView)
	})
end

function FunctionEntranceMediator:setupClickEnvs()
	if GameConfigs.closeGuide then
		return
	end

	local sequence = cc.Sequence:create(cc.CallFunc:create(function()
		local storyDirector = self:getInjector():getInstance(story.StoryDirector)

		for i = 1, #kFunctionData do
			local data = kFunctionData[i]
			local cellNode = data.cellNode
			local panel = self._showPanel:getChildByFullName(cellNode)

			if panel and CommonUtils.GetSwitch(data.switchKey) then
				storyDirector:setClickEnv("functionEntrance.node_" .. i, panel, function(sender, eventType)
					self:clickPanel(i)
				end)
			end
		end

		storyDirector:notifyWaiting("enter_FunctionEntrance_view")
	end))

	self:getView():runAction(sequence)
end

function FunctionEntranceMediator:didFinishResumeTransition()
	local winSize = cc.Director:getInstance():getWinSize()
	local transitionView = cc.LayerColor:create(cc.c4b(0, 0, 0, 255), winSize.width, winSize.height)

	transitionView:addTo(self:getView())
	transitionView:center(cc.size(1136, 640))
	transitionView:runAction(cc.Sequence:create(cc.FadeTo:create(0.1, 0), cc.CallFunc:create(function()
		transitionView:removeFromParent(true)
	end)))
end
