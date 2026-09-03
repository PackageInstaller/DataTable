-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/cooperateBoss/view/CooperateBossMainMediator.lua

CooperateBossMainMediator = class("CooperateBossMainMediator", DmAreaViewMediator)

CooperateBossMainMediator:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")
CooperateBossMainMediator:has("_cooperateBossSystem", {
	is = "r"
}):injectWith("CooperateBossSystem")
CooperateBossMainMediator:has("_activitySystem", {
	is = "r"
}):injectWith("ActivitySystem")

local kBtnHandlers = {
	["main.infoBtn"] = {
		clickAudio = "Se_Click_Common_2",
		func = "onClickInfoBtn"
	},
	["main.fightBtn"] = {
		clickAudio = "Se_Click_Common_2",
		func = "onClickFightBtnBtn"
	},
	["main.buyTimesBtn"] = {
		clickAudio = "Se_Click_Common_2",
		func = "onBuyTimesClick"
	}
}
local SHOW_HERO_ANIM = true
local EVT_COOPERATE_BOSS_SELF_REFRESH = "EVT_COOPERATE_BOSS_SELF_REFRESH"

function CooperateBossMainMediator:initialize()
	super.initialize(self)
end

function CooperateBossMainMediator:dispose()
	self:getView():stopAllActions()

	if self._timer then
		self._timer:stop()

		self._timer = nil
	end

	super.dispose(self)
end

function CooperateBossMainMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(kBtnHandlers)
	self:mapEventListeners()
end

function CooperateBossMainMediator:mapEventListeners()
	self.mapEventListener(self, self:getEventDispatcher(), EVT_COOPERATE_BOSS_BUYTIME, self, self.refreshBuyTimes)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_COOPERATE_BOSS_ESCAPED, self, self.refreshView)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_COOPERATE_BOSS_NEWONE, self, self.refreshView)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_COOPERATE_BOSS_AGREE, self, self.refreshView)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_COOPERATE_BOSS_DEAD, self, self.refreshView)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_COOPERATE_BOSS_INVITE, self, self.refreshView)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_COOPERATE_REFRESH_INVITELIST, self, self.refreshView)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_COOPERATE_BOSS_SELF_REFRESH, self, self.setupView)
end

function CooperateBossMainMediator:enterWithData(data)
	self:initView()
	self:initAnim()
	self:setupRule()
	self:initData(data)
	self:setupView()
	self:checkStory()
end

function CooperateBossMainMediator:resumeWithData()
	return
end

function CooperateBossMainMediator:setupTopInfoWidget()
	local topInfoNode = self:getView():getChildByFullName("main.topinfo_node")
	local config = {
		style = 1,
		currencyInfo = {
			CurrencyIdKind.kDiamond,
			CurrencyIdKind.kPower,
			CurrencyIdKind.kCrystal,
			CurrencyIdKind.kGold
		},
		title = Strings:get("CooperateBoss_SystemName"),
		fontSize = (getCurrentLanguage() ~= GameLanguageType.CN or nil) and 30,
		btnHandler = {
			clickAudio = "Se_Click_Close_1",
			func = bind1(self.onClickBack, self)
		}
	}
	local injector = self:getInjector()

	self._topInfoWidget = self:autoManageObject(injector:injectInto(TopInfoWidget:new(topInfoNode)))

	self._topInfoWidget:updateView(config)
end

function CooperateBossMainMediator:initView()
	self:setupTopInfoWidget()

	self._main = self:getView():getChildByFullName("main")
	self._bossList = self._main:getChildByFullName("bossList")
	self._ruleList = self._main:getChildByFullName("battleInfo.ruleList")
	self._noRecordPanel = self._main:getChildByFullName("battleRecord.Bg.noRecord")
	self._recordList = self._main:getChildByFullName("battleRecord.list")
	self._inviteCellClone = self:getView():getChildByFullName("inviteCellClone")
	self._battleRecordCellClone = self:getView():getChildByFullName("battleRecordCellClone")
	self._bossRole = self._main:getChildByFullName("bg.role")
	self._timeText = self._main:getChildByFullName("timeTile.time")
	self._fightBtn = self._main:getChildByFullName("fightBtn")
	self._talk = self._main:getChildByFullName("tablk")
	self._leaveTimesPanel = self._main:getChildByFullName("leaveTimes")
	self._leaveTimesLab = self._main:getChildByFullName("leaveTimes.cur")
	self._totalTimesLab = self._main:getChildByFullName("leaveTimes.total")
	self._buyTimesBtn = self._main:getChildByFullName("buyTimesBtn")
end

function CooperateBossMainMediator:initData(data)
	self._data = data
	self._cooperateBossData = self._cooperateBossSystem:getCooperateBoss()
end

function CooperateBossMainMediator:setupView()
	self:setupBossMapList()
	self:setupRewardBtnState()
	self:setupBossModeShow(self._data.mineBoss)
	self:setupBattleRecord()
	self:setupTimeShow()
end

function CooperateBossMainMediator:setupRule()
	self._ruleList:removeAllChildren()
	self._ruleList:setScrollBarEnabled(false)

	local ruleKeys = ConfigReader:getDataByNameIdAndKey("ConfigValue", "CooperateBoss_RuleTitle", "content")

	for i = 1, #ruleKeys do
		local ruleStr = Strings:get(ruleKeys[i], {
			fontName = TTF_FONT_FZYH_R
		})

		if ruleStr and ruleStr ~= "" then
			local label = ccui.RichText:createWithXML(ruleStr, {})

			label:renderContent(518, 0)
			label:setAnchorPoint(cc.p(0, 0))
			label:setVerticalSpace(10)
			self._ruleList:pushBackCustomItem(label)
		end
	end
end

function CooperateBossMainMediator:setupBossMapList()
	local maps = self._data.invitedBossIdMap

	self._bossList:removeAllChildren()
	self._bossList:setScrollBarEnabled(false)

	if maps and #maps == 0 then
		local boss = self._inviteCellClone:clone()

		self._bossList:pushBackCustomItem(boss)

		local name = boss:getChildByFullName("invitePanel.nameDi.name")
		local invite = boss:getChildByFullName("invitePanel.inviteDi.invite")
		local level = boss:getChildByFullName("invitePanel.level")

		name:setVisible(false)
		invite:setVisible(false)
		level:setVisible(false)

		local invitePanel = boss:getChildByFullName("invitePanel")

		invitePanel:addTouchEventListener(function(sender, eventType)
			if eventType == ccui.TouchEventType.ended then
				self:dispatch(ShowTipEvent({
					duration = 0.2,
					tip = Strings:get("CooperateBoss_Entry_UI09")
				}))
			end
		end)
	else
		for i = 1, #maps do
			local info = maps[i]
			local boss = self._inviteCellClone:clone()

			self._bossList:pushBackCustomItem(boss)

			local invitePanel = boss:getChildByFullName("invitePanel")
			local bossIcon = boss:getChildByFullName("invitePanel.role")
			local bossNameText = boss:getChildByFullName("invitePanel.nameDi.name")
			local bossLvText = boss:getChildByFullName("invitePanel.level.text")
			local playerNameText = boss:getChildByFullName("invitePanel.inviteDi.invite")
			local bg = boss:getChildByFullName("Bg")

			playerNameText:setString(info.name)
			bossNameText:setString(self._cooperateBossSystem:getBossName(info.confId))

			local pic, animName = self._cooperateBossSystem:getInviteBossTabImage(info.lv)

			bg:loadTexture(pic, ccui.TextureResType.localType)

			if animName and animName ~= "" then
				local animNode = boss:getChildByFullName("invitePanel")

				animNode:removeChildByName("FrameFX")

				local anim = cc.MovieClip:create(animName)

				anim:addTo(animNode):center(animNode:getContentSize()):offset(0, -2)
				anim:setName("FrameFX")
			end

			bossLvText:setString("Lv." .. info.lv)
			boss:getChildByFullName("invitePanel.info"):setVisible(false)

			local heroSprite = IconFactory:createRoleIconSpriteNew({
				frameId = "bustframe13_2",
				id = self._cooperateBossData:getRoleModelId(info.confId)
			})

			heroSprite:addTo(bossIcon):center(bossIcon:getContentSize())
			invitePanel:addTouchEventListener(function(sender, eventType)
				if eventType == ccui.TouchEventType.ended then
					local data = {
						confId = info.confId,
						bossCreateTime = info.bossCreateTime,
						bossLevel = info.lv,
						name = info.name,
						bossId = info.bossId
					}

					self._cooperateBossSystem:enterCooperateBossInvite(data)
				end
			end)
		end
	end
end

function CooperateBossMainMediator:setupBattleRecord()
	local records = self._data.battleRecordLst

	self._recordList:removeAllChildren()
	self._recordList:setScrollBarEnabled(false)

	if records == nil or #records == 0 then
		self._noRecordPanel:setVisible(true)
	else
		table.sort(records, function(a, b)
			if a.finishBattleTime then
				if not a.finishBattleTime then
					local tiemA = a.bossCreateTime

					if b.finishBattleTime then
						if not b.finishBattleTime then
							local tiemB = b.bossCreateTime

							return tiemB < tiemA
						end
					end
				end
			end
		end)
		self._noRecordPanel:setVisible(false)

		for i = 1, #records do
			local record = self._battleRecordCellClone:clone()
			local bossNameLab = record:getChildByFullName("name")
			local stateImg = record:getChildByFullName("state")
			local detailBtn = record:getChildByFullName("detail")
			local rewardPanel = record:getChildByFullName("reward")
			local rewardList = record:getChildByFullName("rewardList")
			local di = record:getChildByFullName("di")
			local config = ConfigReader:getRecordById("CooperateBossMain", records[i].confId)

			assert(config ~= nil, "Error configId : " .. records[i].confId)
			di:setVisible(i % 2 == 1)

			local nameKey = ConfigReader:getDataByNameIdAndKey("CooperateBossBattle", config.BossBattle, "Name")

			bossNameLab:setString(Strings:get("CooperateBoss_Main_BossLevel", {
				bossName = Strings:get(nameKey),
				bossLevel = records[i].lv
			}))

			if records[i].state == kCooperateBossEnemyState.kEscaped then
				stateImg:loadTexture("gongdou_txt_taopao.png", ccui.TextureResType.plistType)
			elseif records[i].state == kCooperateBossEnemyState.kDead then
				stateImg:loadTexture("gongdou_txt_jikui.png", ccui.TextureResType.plistType)
			else
				stateImg:loadTexture("gongdou_txt_jinxingzhong.png", ccui.TextureResType.plistType)
			end

			local rewards = {}

			if records[i].battleRecord and records[i].battleRecord.lastKillRewards and #records[i].battleRecord.lastKillRewards > 0 then
				for j = 1, #records[i].battleRecord.lastKillRewards do
					local reward = records[i].battleRecord.lastKillRewards[j]

					reward.tagImg = "lastKillRewards"

					table.insert(rewards, reward)
				end
			end

			if records[i].battleRecord and records[i].battleRecord.roomOwnerRewards and #records[i].battleRecord.roomOwnerRewards > 0 then
				for j = 1, #records[i].battleRecord.roomOwnerRewards do
					local reward = records[i].battleRecord.roomOwnerRewards[j]

					reward.tagImg = "roomOwnerRewards"

					table.insert(rewards, reward)
				end
			end

			if records[i].battleRecord and records[i].battleRecord.assistRewards and #records[i].battleRecord.assistRewards > 0 then
				for j = 1, #records[i].battleRecord.assistRewards do
					local reward = records[i].battleRecord.assistRewards[j]

					reward.tagImg = "assistRewards"

					table.insert(rewards, reward)
				end
			end

			rewardPanel:removeAllChildren()
			rewardList:removeAllChildren()

			if #rewards <= 0 then
				if records[i].state ~= kCooperateBossEnemyState.kEscaped then
					local icon = cc.Sprite:createWithSpriteFrameName("gongdou_img_xx_wh.png")

					icon:setPosition(cc.p(-5, 0))
					rewardPanel:addChild(icon)
					rewardPanel:setContentSize(cc.size(icon:getContentSize().width + 20, icon:getContentSize().height))
					icon:setAnchorPoint(0, 0)
					rewardPanel:setPositionX(300)
				else
					rewardList:setVisible(false)
					rewardPanel:setVisible(false)
				end
			else
				local dataList = self._cooperateBossData:getTokenRewardBossLst()
				local isDraw = false

				for k, v in pairs(dataList) do
					if v == records[i].bossId then
						isDraw = true
					end
				end

				if #rewards > 3 then
					rewardList:setVisible(true)
					rewardPanel:setVisible(false)

					local panel = ccui.Layout:create()

					panel:setAnchorPoint(0, 0)
					rewardList:pushBackCustomItem(panel)

					for j = 1, #rewards do
						local reward = rewards[j]
						local icon = IconFactory:createRewardIcon(reward, {
							showAmount = true,
							isWidget = true,
							notShowQulity = false
						})

						panel:addChild(icon)
						icon:setPosition(cc.p((j - 1) * 50, 2))
						panel:setContentSize(cc.size(50 * j, 50))
						icon:setScaleNotCascade(0.4)
						icon:setAnchorPoint(0, 0)
						rewardList:setScrollBarEnabled(false)
						IconFactory:bindTouchHander(icon, IconTouchHandler:new(self), reward, {
							needDelay = true
						})

						local tagImgSrc = ""

						if reward.tagImg == "lastKillRewards" then
							tagImgSrc = "gongdou_img_xx_zs.png"
						elseif reward.tagImg == "roomOwnerRewards" then
							tagImgSrc = "gongdou_img_xx_fz.png"
						end

						if tagImgSrc ~= "" then
							local tagImg = cc.Sprite:createWithSpriteFrameName(tagImgSrc)

							icon:addChild(tagImg)
							tagImg:setScale(1.9)
							tagImg:setPositionY(icon:getContentSize().height - 21)
							tagImg:setPositionX(26)
						end

						if isDraw then
							local ylqImg = cc.Sprite:createWithSpriteFrameName("gongdou_img_lingquzhezhao.png")

							ylqImg:setScale(2.5)
							ylqImg:addTo(icon):center(icon:getContentSize())
							ylqImg:setLocalZOrder(1000)
						end
					end
				else
					rewardList:setVisible(false)
					rewardPanel:setVisible(true)

					local starPosx = 310 - #rewards * 20 - 8

					for j = 1, #rewards do
						local reward = rewards[j]
						local icon = IconFactory:createRewardIcon(reward, {
							showAmount = true,
							isWidget = true,
							notShowQulity = false
						})

						icon:setScaleNotCascade(0.4)

						local detalX = starPosx - rewardPanel:getPositionX() + 8

						icon:setPosition(cc.p((j - 1) * (icon:getContentSize().width * 0.4 + 10) + detalX, 5))
						rewardPanel:addChild(icon)
						icon:setAnchorPoint(0, 0)
						IconFactory:bindTouchHander(icon, IconTouchHandler:new(self), reward, {
							needDelay = true
						})

						local tagImgSrc = ""

						if reward.tagImg == "lastKillRewards" then
							tagImgSrc = "gongdou_img_xx_zs.png"
						elseif reward.tagImg == "roomOwnerRewards" then
							tagImgSrc = "gongdou_img_xx_fz.png"
						end

						if tagImgSrc ~= "" then
							local tagImg = cc.Sprite:createWithSpriteFrameName(tagImgSrc)

							icon:addChild(tagImg)
							tagImg:setScale(1.9)
							tagImg:setPositionY(icon:getContentSize().height - 21)
							tagImg:setPositionX(26)
						end

						if isDraw then
							local ylqImg = cc.Sprite:createWithSpriteFrameName("gongdou_img_lingquzhezhao.png")

							ylqImg:setScale(2.5)
							ylqImg:addTo(icon):center(icon:getContentSize())
							ylqImg:setLocalZOrder(1000)
						end
					end
				end
			end

			detailBtn:setVisible(true)
			detailBtn:addTouchEventListener(function(sender, eventType)
				if eventType == ccui.TouchEventType.ended then
					self._cooperateBossSystem:enterCooperateBossInviteFriendView(records[i].bossId)
				end
			end)
			self._recordList:pushBackCustomItem(record)
		end
	end
end

function CooperateBossMainMediator:setupRewardBtnState()
	self._rewardBtn = self:bindWidget("main.rewardBtn", OneLevelMainButton, {
		handler = {
			clickAudio = "Se_Click_Cancle",
			func = bind1(self.onRewardBtnClick, self)
		}
	})

	local records = self._data.battleRecordLst

	self._rewardBtn:setGray(false)

	if records and #records == 0 then
		self._rewardBtn:setGray(true)
	else
		self:refreshRewardState()
	end

	self._rewardBtn:setButtonName(Strings:get("CooperateBoss_Receive"), "")

	self._activeBtn = self:bindWidget("main.activeBtn", OneLevelMainButton, {
		handler = {
			clickAudio = "Se_Click_Cancle",
			func = bind1(self.onActiveBtnClick, self)
		}
	})

	local activityId = self._cooperateBossData:getConfig().ActivityConfig.ExchangeID
	local isActivityOpen = false

	if activityId then
		local activity = self._activitySystem:getActivityById(activityId)

		if activity and self._activitySystem:isActivityOpen(activityId) then
			isActivityOpen = true
		end
	else
		local oldActivity = self._activitySystem:getActivityByComplexUI("Exchange")

		if oldActivity and self._activitySystem:isActivityOpen(oldActivity:getId()) then
			isActivityOpen = true
		end
	end

	self._activeBtn:setGray(not isActivityOpen)
	self._activeBtn:setButtonName(Strings:get("CooperateBoss_Btn_Exchange"), "")
end

function CooperateBossMainMediator:setupBossModeShow(mineBoss)
	self._bossRole:removeAllChildren()

	local bossId

	if SHOW_HERO_ANIM then
		self._bossRole:stopAllActions()

		local heroAnim = self._bossRole:getChildByName("HeroAnim")

		if not heroAnim then
			heroAnim = cc.MovieClip:create("renwu_yingling")

			heroAnim:addTo(self._bossRole)
			heroAnim:setName("HeroAnim")
			heroAnim:addCallbackAtFrame(25, function()
				heroAnim:stop()
			end)
			heroAnim:gotoAndPlay(0)
			heroAnim:setPlaySpeed(0.7)
		end

		local iconNode = heroAnim:getChildByName("heroIcon")

		iconNode:removeAllChildren()

		local roleModel

		if mineBoss and self._cooperateBossSystem:checkMineDefaultBossShow(mineBoss) then
			bossId = mineBoss.confId

			local bossConfig = ConfigReader:getRecordById("CooperateBossMain", mineBoss.confId)

			roleModel = bossConfig.RoleModel

			self._fightBtn:setVisible(true)
			self._talk:setVisible(false)
			self._leaveTimesPanel:setVisible(true)
			self._buyTimesBtn:setVisible(true)

			if self._cooperateBossSystem:redPointShow() then
				self._buyTimesBtn:setGray(false)
			else
				self._buyTimesBtn:setGray(true)
			end

			local curTimes = self._cooperateBossData:getBossFightTimes()
			local resetData = DataReader:getDataByNameIdAndKey("Reset", "CooperateBoss", "ResetSystem")

			self._leaveTimesLab:setString(tostring(curTimes.value))

			if curTimes.value <= 0 then
				self._leaveTimesLab:setTextColor(cc.c3b(255, 117, 117))
				self._totalTimesLab:setTextColor(cc.c3b(255, 117, 117))
			else
				self._leaveTimesLab:setTextColor(cc.c3b(255, 255, 255))
				self._totalTimesLab:setTextColor(cc.c3b(255, 255, 255))
			end

			self._totalTimesLab:setString("/" .. tostring(resetData.max))
		else
			bossId = ConfigReader:getDataByNameIdAndKey("ConfigValue", "CooperateBoss_MainBossShow", "content")
			roleModel = IconFactory:getRoleModelByKey("HeroBase", bossId)
			self._heroSystem = self._developSystem:getHeroSystem()

			local hero = self._heroSystem:getHeroById(bossId)

			if hero then
				roleModel = hero:getModel()
			end

			self._fightBtn:setVisible(false)
			self._talk:setVisible(true)
			self._talk:stopAllActions()

			local talkText = self._talk:getChildByName("Text_80")
			local talkConfig = ConfigReader:getDataByNameIdAndKey("ConfigValue", "CooperateBoss_Main_Bubble", "content")
			local talkStayTime = ConfigReader:getDataByNameIdAndKey("ConfigValue", "CooperateBoss_Main_Bubble_Stay", "content")
			local oldIdx = math.random(1, #talkConfig)

			talkText:setString(Strings:get(talkConfig[oldIdx]))
			schedule(self._talk, function()
				local curIdx

				for i = 1, 10 do
					curIdx = math.random(1, #talkConfig)

					if curIdx ~= oldIdx then
						break
					end
				end

				oldIdx = curIdx

				talkText:setString(Strings:get(talkConfig[curIdx]))
			end, talkStayTime)
			self._buyTimesBtn:setVisible(false)
			self._leaveTimesPanel:setVisible(false)
		end

		local img, path, spineani, picInfo = IconFactory:createRoleIconSpriteNew({
			useAnim = true,
			frameId = "bustframe9",
			id = roleModel
		})

		img:addTo(iconNode)
		img:setPosition(cc.p(60, -63))
	elseif mineBoss and self._cooperateBossSystem:checkMineDefaultBossShow(mineBoss) then
		bossId = mineBoss.confId

		local bossConfig = ConfigReader:getRecordById("CooperateBossMain", mineBoss.confId)
		local roleModel = bossConfig.RoleModel
		local heroSprite, _, spineani, picInfo = IconFactory:createRoleIconSpriteNew({
			useAnim = true,
			frameId = "bustframe9",
			id = roleModel
		})

		heroSprite:addTo(self._bossRole)
		heroSprite:setPosition(cc.p(70, -70))
		heroSprite:setTouchEnabled(false)
		self._fightBtn:setVisible(true)
		self._talk:setVisible(false)
		self._leaveTimesPanel:setVisible(true)
		self._buyTimesBtn:setVisible(true)

		if self._cooperateBossSystem:redPointShow() then
			self._buyTimesBtn:setGray(false)
		else
			self._buyTimesBtn:setGray(true)
		end

		local curTimes = self._cooperateBossData:getBossFightTimes()
		local resetData = DataReader:getDataByNameIdAndKey("Reset", "CooperateBoss", "ResetSystem")

		self._leaveTimesLab:setString(tostring(curTimes.value))

		if curTimes.value <= 0 then
			self._leaveTimesLab:setTextColor(cc.c3b(255, 117, 117))
			self._totalTimesLab:setTextColor(cc.c3b(255, 117, 117))
		else
			self._leaveTimesLab:setTextColor(cc.c3b(255, 255, 255))
			self._totalTimesLab:setTextColor(cc.c3b(255, 255, 255))
		end

		self._totalTimesLab:setString("/" .. tostring(resetData.max))
	else
		bossId = ConfigReader:getDataByNameIdAndKey("ConfigValue", "CooperateBoss_MainBossShow", "content")

		local roleModel = IconFactory:getRoleModelByKey("HeroBase", bossId)

		self._heroSystem = self._developSystem:getHeroSystem()

		local hero = self._heroSystem:getHeroById(bossId)
		local heroSprite, _, spineani, picInfo = IconFactory:createRoleIconSpriteNew({
			useAnim = true,
			frameId = "bustframe9",
			id = (hero or nil) and hero:getModel()
		})

		heroSprite:addTo(self._bossRole)
		heroSprite:setPosition(cc.p(160, -70))
		heroSprite:setTouchEnabled(false)
		self._fightBtn:setVisible(false)
		self._talk:setVisible(true)
		self._buyTimesBtn:setVisible(false)
		self._leaveTimesPanel:setVisible(false)
	end
end

function CooperateBossMainMediator:setupTimeShow()
	if self._timer then
		self._timer:stop()

		self._timer = nil
	end

	local endTime = self._cooperateBossData:getEndTime()

	local function checkTimeFunc()
		if DisposableObject:isDisposed(self) or DisposableObject:isDisposed(self:getView()) then
			if self._timer then
				self._timer:stop()

				self._timer = nil
			end

			return
		end

		local curServerTime = TimeUtil:timeByRemoteDate()

		if endTime - curServerTime <= 0 then
			if self._timer then
				self._timer:stop()

				self._timer = nil
			end

			self._timeText:setString(Strings:get("CooperateBoss_Invite_UI23"))

			return
		end

		local remainTimeStr = TimeUtil:formatTime("${HH}:${MM}:${SS}", endTime - curServerTime)
		local str = ""
		local fmtStr = "${d}:${H}:${M}:${S}"
		local timeStr = TimeUtil:formatTime(fmtStr, endTime - curServerTime)
		local parts = string.split(timeStr, ":", nil, true)
		local timeTab = {}

		timeTab.day = tonumber(parts[1])
		timeTab.hour = tonumber(parts[2])
		timeTab.min = tonumber(parts[3])
		timeTab.sec = tonumber(parts[4])
		str = timeTab.day > 0 and timeTab.day .. Strings:get("TimeUtil_Day") .. timeTab.hour .. Strings:get("TimeUtil_Hour") or timeTab.hour > 0 and timeTab.hour .. Strings:get("TimeUtil_Hour") .. timeTab.min .. Strings:get("TimeUtil_Min") or timeTab.min .. Strings:get("TimeUtil_Min") .. timeTab.sec .. Strings:get("TimeUtil_Sec")

		self._timeText:setString(Strings:get("CooperateBoss_Countdown", {
			time = str
		}))
	end

	self._timer = LuaScheduler:getInstance():schedule(checkTimeFunc, 1, false)

	checkTimeFunc()
end

function CooperateBossMainMediator:checkStory()
	local ownerRecords = {}

	for i = 1, #self._data.battleRecordLst do
		local tmp = self._data.battleRecordLst[i]

		if tmp.isOwner and (tmp.state == kCooperateBossEnemyState.kDead or tmp.state == kCooperateBossEnemyState.kEscaped) then
			table.insert(ownerRecords, tmp)
		end
	end

	if #ownerRecords > 0 then
		local tipStr

		if ownerRecords[1].state == kCooperateBossEnemyState.kDead then
			local bossName = self._cooperateBossSystem:getBossName(ownerRecords[1].confId)

			tipStr = Strings:get("CooperateBoss_PopUp_Died", {
				bossLevel = ownerRecords[1].lv,
				bossName = bossName
			})
		elseif ownerRecords[1].state == kCooperateBossEnemyState.kEscaped then
			local bossName = self._cooperateBossSystem:getBossName(ownerRecords[1].confId)

			tipStr = Strings:get("CooperateBoss_PopUp_Escape", {
				bossLevel = ownerRecords[1].lv,
				bossName = bossName
			})
		end

		if not self._cooperateBossSystem:isSaved(ownerRecords[1].bossId) then
			self._cooperateBossSystem:save(ownerRecords[1].bossId)

			local outSelf, delegate = self, {}

			function delegate:willClose(popupMediator, data)
				if data.response == "ok" then
					-- block empty
				elseif data.response == "cancel" then
					-- block empty
				elseif data.response == "close" then
					-- block empty
				end
			end

			local data = {
				title1 = "Tips",
				title = Strings:get("Tip_Remind"),
				content = tipStr,
				sureBtn = {}
			}
			local view = self:getInjector():getInstance("AlertView")

			self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
				transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
			}, data, delegate))
		end
	end
end

function CooperateBossMainMediator:onRewardBtnClick(sender, eventType)
	local records = self._data.battleRecordLst

	if records and #records == 0 then
		self:dispatch(ShowTipEvent({
			duration = 0.2,
			tip = Strings:get("CooperateBoss_PopUp_UI05")
		}))
	else
		self._cooperateBossSystem:drawBattleRewards(function(respons)
			if respons.resCode == 0 then
				local rewards = respons.data.rewards

				if #rewards == 0 then
					self:dispatch(ShowTipEvent({
						duration = 0.2,
						tip = Strings:get("CooperateBoss_PopUp_UI05")
					}))
				else
					self:refreshRewardState()

					local view = self:getInjector():getInstance("getRewardView")

					self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
						maskOpacity = 0
					}, {
						rewards = rewards
					}))
				end
			end
		end)
	end
end

function CooperateBossMainMediator:onActiveBtnClick(sender, eventType)
	local activityId = self._cooperateBossData:getConfig().ActivityConfig.ExchangeID
	local curTimeStamp = TimeUtil:timeByRemoteDate()
	local activity

	if activityId then
		activity = self._activitySystem:getActivityById(activityId)
	else
		activity = self._activitySystem:getActivityByComplexUI("Exchange")
		activityId = activity:getId()
	end

	if activity then
		if curTimeStamp * 1000 < activity:getStartTime() then
			self:dispatch(ShowTipEvent({
				duration = 0.2,
				tip = Strings:get("CooperateBoss_ExchangeActivityTip01")
			}))

			return
		end

		if curTimeStamp * 1000 > activity:getEndTime() then
			self:dispatch(ShowTipEvent({
				duration = 0.2,
				tip = Strings:get("CooperateBoss_ExchangeActivityTip02")
			}))

			return
		end

		local uiType = activity:getUI()

		if uiType == "NewExchange" then
			self._activitySystem:tryEnterCoopExchangeView({
				activityId = activityId
			})
		elseif uiType == "Exchange" then
			self._activitySystem:tryEnter({
				id = activityId
			})
		end
	end
end

function CooperateBossMainMediator:initAnim()
	self._fightBtn:removeAllChildren()

	local mc = cc.MovieClip:create("xiangqingxunhuan_zhuxianguanka_UIjiaohudongxiao")

	mc:addCallbackAtFrame(30, function()
		mc:stop()
	end)
	mc:stop()
	mc:addTo(self._fightBtn):center(self._fightBtn:getContentSize())
	mc:setScale(0.8)
	mc:setLocalZOrder(100)

	local animNode = self:getView():getChildByFullName("main.bg.anim")

	animNode:removeAllChildren()

	local anim = cc.MovieClip:create("lizidonghua_gongdouquanping")

	anim:addTo(animNode):setScale(1)
end

function CooperateBossMainMediator:onClickBack(sender, eventType)
	self:dismissWithOptions({
		transition = ViewTransitionFactory:create(ViewTransitionType.kCommonAreaView)
	})
end

function CooperateBossMainMediator:onClickInfoBtn()
	local Rule = ConfigReader:getDataByNameIdAndKey("ConfigValue", "CooperateBoss_MainRule", "content")
	local view = self:getInjector():getInstance("ArenaRuleView")

	self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
		transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
	}, {
		rule = Rule,
		ruleReplaceInfo = {
			time = TimeUtil:getSystemResetDate()
		}
	}))
end

function CooperateBossMainMediator:onClickFightBtnBtn()
	local mineBoss = self._data.mineBoss

	self._cooperateBossSystem:enterCooperateBossInviteFriendView(mineBoss.bossId)
end

function CooperateBossMainMediator:onBuyTimesClick()
	local view = self:getInjector():getInstance("CooperateBossBuyTimeView")

	self:getEventDispatcher():dispatchEvent(ViewEvent:new(EVT_SHOW_POPUP, view, {
		transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
	}, nil))
end

function CooperateBossMainMediator:refreshBuyTimes()
	local curTimes = self._cooperateBossData:getBossFightTimes()
	local resetData = DataReader:getDataByNameIdAndKey("Reset", "CooperateBoss", "ResetSystem")

	self._leaveTimesLab:setString(tostring(curTimes.value))

	if curTimes.value <= 0 then
		self._leaveTimesLab:setTextColor(cc.c3b(255, 117, 117))
		self._totalTimesLab:setTextColor(cc.c3b(255, 117, 117))
	else
		self._leaveTimesLab:setTextColor(cc.c3b(255, 255, 255))
		self._totalTimesLab:setTextColor(cc.c3b(255, 255, 255))
	end

	self._totalTimesLab:setString("/" .. tostring(resetData.max))
end

function CooperateBossMainMediator:refreshView(data)
	local function callback(data)
		self:initData(data)
		self:dispatch(Event:new(EVT_COOPERATE_BOSS_SELF_REFRESH))
	end

	self._cooperateBossSystem:requestCooperateBossMain(callback)
end

function CooperateBossMainMediator:refreshRewardState()
	self:setupBattleRecord()
	self._rewardBtn:setGray(not self._cooperateBossData:getRewardState())
end
