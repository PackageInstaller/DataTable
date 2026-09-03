-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/cooperateBoss/view/CooperateBossInviteFriendMediator.lua

CooperateBossInviteFriendMediator = class("CooperateBossInviteFriendMediator", DmAreaViewMediator)

CooperateBossInviteFriendMediator:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")
CooperateBossInviteFriendMediator:has("_gameServerAgent", {
	is = "r"
}):injectWith("GameServerAgent")
CooperateBossInviteFriendMediator:has("_cooperateBossSystem", {
	is = "r"
}):injectWith("CooperateBossSystem")
CooperateBossInviteFriendMediator:has("_friendSystem", {
	is = "r"
}):injectWith("FriendSystem")
CooperateBossInviteFriendMediator:has("_clubSystem", {
	is = "r"
}):injectWith("ClubSystem")

local kBtnHandlers = {
	["main.infoBtn"] = {
		clickAudio = "Se_Click_Common_2",
		func = "onClickInfoBtn"
	},
	["main.fight"] = {
		clickAudio = "Se_Click_Common_2",
		func = "onFightClick"
	},
	["main.buyTimesBtn"] = {
		clickAudio = "Se_Click_Common_2",
		func = "onBuyTimesClick"
	},
	["main.friendPanel.addFriend"] = {
		clickAudio = "Se_Click_Common_2",
		func = "onAddFriendBtnClick"
	},
	["main.friendPanel.clubFriend"] = {
		clickAudio = "Se_Click_Common_2",
		func = "onClubFriendBtnClick"
	},
	["main.friendPanel.friend"] = {
		clickAudio = "Se_Click_Common_2",
		func = "onFriendBtnClick"
	},
	["main.friendPanel.backBtn"] = {
		clickAudio = "Se_Click_Common_2",
		func = "hideFriendView"
	}
}
local kFriendShowType = {
	kFriend = "kFriend",
	kClubFriend = "kClubFriend"
}

function CooperateBossInviteFriendMediator:initialize()
	super.initialize(self)
end

function CooperateBossInviteFriendMediator:dispose()
	self:getView():stopAllActions()

	if self._timer then
		self._timer:stop()

		self._timer = nil
	end

	if self._friendSchel then
		self._friendSchel:stop()

		self._friendSchel = nil
	end

	super.dispose(self)
end

function CooperateBossInviteFriendMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(kBtnHandlers)
	self:mapEventListeners()
end

function CooperateBossInviteFriendMediator:mapEventListeners()
	self.mapEventListener(self, self:getEventDispatcher(), EVT_COOPERATE_BOSS_BUYTIME, self, self.refreshBuyTimes)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_COOPERATE_BOSS_FRIEND_CHANGE, self, self.refreshFriendView)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_FRIEND_LOGIN, self, self.refreshFriendView)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_FRIEND_LOGOUT, self, self.refreshFriendView)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_COOPERATE_BOSS_AGREE, self, self.refreshView)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_COOPERATE_BOSS_REFUSE, self, self.refreshView)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_COOPERATE_BOSS_BATTLE_OVER, self, self.refreshView)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_COOPERATE_BOSS_BEGIN, self, self.refreshView)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_COOPERATE_BOSS_ESCAPED, self, self.backCooperateBossMain)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_COOPERATE_BOSS_DEAD, self, self.refreshView)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_COOPERATE_BOSS_ENTERROOM, self, self.refreshView)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_COOPERATE_BOSS_LEAVEROOM, self, self.refreshView)
end

function CooperateBossInviteFriendMediator:enterWithData(data)
	self:initView()
	self:setupTopInfoWidget()
	self:initAnim()
	self:initData(data)
	self:setupView()
	self:setupBossTime()
	self:hideFriendView()
	self:checkStory()
end

function CooperateBossInviteFriendMediator:resumeWithData()
	self:checkStory()
end

function CooperateBossInviteFriendMediator:checkStory()
	local tipStr

	if self._data.bossInfo.state == kCooperateBossEnemyState.kDead then
		local bossName = self._cooperateBossSystem:getBossName(self._data.bossInfo.confId)

		tipStr = Strings:get("CooperateBoss_PopUp_Died", {
			bossLevel = self._data.bossInfo.lv,
			bossName = bossName
		})
	elseif self._data.bossInfo.state == kCooperateBossEnemyState.kEscaped then
		local bossName = self._cooperateBossSystem:getBossName(self._data.bossInfo.confId)

		tipStr = Strings:get("CooperateBoss_PopUp_Escape", {
			bossLevel = self._data.bossInfo.lv,
			bossName = bossName
		})
	end

	if tipStr and not self._cooperateBossSystem:isSaved(self._data.bossInfo.bossId) then
		self._cooperateBossSystem:save(self._data.bossInfo.bossId)

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

function CooperateBossInviteFriendMediator:setupTopInfoWidget()
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
		btnHandler = {
			clickAudio = "Se_Click_Close_1",
			func = bind1(self.onClickBack, self)
		}
	}
	local injector = self:getInjector()

	self._topInfoWidget = self:autoManageObject(injector:injectInto(TopInfoWidget:new(topInfoNode)))

	self._topInfoWidget:updateView(config)
end

function CooperateBossInviteFriendMediator:initView()
	self._main = self:getView():getChildByFullName("main")
	self._fightBtn = self._main:getChildByFullName("fight")
	self._rewardPanel = self._main:getChildByFullName("rewardRec.partenerList")
	self._attrAddPanel = self._main:getChildByFullName("partenerRec.partenerList")
	self._playerList = self._main:getChildByFullName("list")
	self._bossInfoPanel = self._main:getChildByFullName("roleInfo")
	self._bossTime = self._main:getChildByFullName("info.time")
	self._bossStateText = self._main:getChildByFullName("info.text")
	self._bossRole = self._main:getChildByFullName("role")
	self._leaveTimesLab = self._main:getChildByFullName("curLeaveTimes")
	self._totalTimesLab = self._main:getChildByFullName("totalLeaveTimes")
	self._titleTimesLab = self._main:getChildByFullName("leaveTimesTitle")
	self._buyTimesBtn = self._main:getChildByFullName("buyTimesBtn")
	self.roleInfo = self._main:getChildByFullName("roleInfo")
	self._friendPanel = self._main:getChildByFullName("friendPanel")
	self._friendPanelList = self._main:getChildByFullName("friendPanel.list")
	self._recommendHero1Clone = self:getView():getChildByFullName("recommendHero1")
	self._recommendHero2Clone = self:getView():getChildByFullName("recommendHero2")
	self._recommendHero3Clone = self:getView():getChildByFullName("recommendHero3")
	self._friendCell = self:getView():getChildByFullName("friendCellClone")
	self._cloneCell = self:getView():getChildByFullName("partenerCellClone")
	self._friendBtn = self._main:getChildByFullName("friendPanel.friend")
	self._clubFriendBtn = self._main:getChildByFullName("friendPanel.clubFriend")
	self._noFriend = self._main:getChildByFullName("friendPanel.noFriend")
	self._rewardBtn = self:bindWidget("main.rewardBtn", OneLevelMainButton, {
		handler = {
			clickAudio = "Se_Click_Cancle",
			func = bind1(self.onClickBack, self)
		},
		btnSize = {
			width = 222,
			height = 108
		}
	})

	self._rewardBtn:setButtonName(Strings:get("CooperateBoss_Invite_UI33"), "")
	self._rewardBtn:setVisible(false)
end

function CooperateBossInviteFriendMediator:setupFriendState()
	self._bossFightTimes = {}

	self._cooperateBossSystem:requestFriendTimes(function(respon)
		if respon.resCode == 0 then
			if DisposableObject:isDisposed(self) or DisposableObject:isDisposed(self:getView()) then
				return
			end

			self._bossFightTimes = respon.data

			table.sort(self._friendList, function(a, b)
				local sortA = (a:getOnline() == false or a:getOnline() == 0) and 0 or 1
				local sortB = (b:getOnline() == false or b:getOnline() == 0) and 0 or 1

				if sortA == sortB then
					local isInTeamA = 0
					local isInTeamB = 0

					for i = 1, #self._data.bossInfo.battleRecordLst do
						local member = self._data.bossInfo.battleRecordLst[i]

						if member.pid == a:getRid() then
							isInTeamA = 1
						end

						if member.pid == b:getRid() then
							isInTeamB = 1
						end
					end

					if isInTeamA == isInTeamB then
						local leaveTimesA = 0
						local leaveTimesB = 0

						if self._bossFightTimes.frientLst then
							if not self._bossFightTimes.frientLst then
								local frientLst = {}

								for i = 1, #frientLst do
									local data = frientLst[i]

									if data.pid == a:getRid() then
										leaveTimesA = data.bossFightTime and data.bossFightTime or 0
									end

									if data.pid == b:getRid() then
										leaveTimesB = data.bossFightTime and data.bossFightTime or 0
									end
								end

								if leaveTimesA == leaveTimesB then
									return a:getCombat() > b:getCombat()
								else
									return leaveTimesB < leaveTimesA
								end
							end
						end
					else
						return isInTeamB < isInTeamA
					end
				else
					return sortB < sortA
				end
			end)
			table.sort(self._memberList, function(a, b)
				local sortA = (a:getIsOnline() == false or a:getIsOnline() == 0) and 0 or 1
				local sortB = (b:getIsOnline() == false or b:getIsOnline() == 0) and 0 or 1

				if sortA == sortB then
					local isInTeamA = 0
					local isInTeamB = 0

					for i = 1, #self._data.bossInfo.battleRecordLst do
						local member = self._data.bossInfo.battleRecordLst[i]

						if member.pid == a:getRid() then
							isInTeamA = 1
						end

						if member.pid == b:getRid() then
							isInTeamB = 1
						end
					end

					if isInTeamA == isInTeamB then
						local leaveTimesA = 0
						local leaveTimesB = 0

						if self._bossFightTimes.clubmateLst then
							if not self._bossFightTimes.clubmateLst then
								local frientLst = {}

								for i = 1, #frientLst do
									local data = frientLst[i]

									if data.pid == a:getRid() then
										leaveTimesA = data.bossFightTime and data.bossFightTime or 0
									end

									if data.pid == b:getRid() then
										leaveTimesB = data.bossFightTime and data.bossFightTime or 0
									end
								end

								if leaveTimesA == leaveTimesB then
									return a:getCombat() > b:getCombat()
								else
									return leaveTimesB < leaveTimesA
								end
							end
						end
					else
						return isInTeamB < isInTeamA
					end
				else
					return sortB < sortA
				end
			end)
			self:createFriendTableView()
		end
	end)
end

function CooperateBossInviteFriendMediator:setupView()
	self:createTableView()
	self:setupFriendState()
	self:setupBossState()
end

function CooperateBossInviteFriendMediator:initData(data)
	self._data = data
	self._cooperateBossData = self._cooperateBossSystem:getCooperateBoss()
	self._bossConfig = ConfigReader:getRecordById("CooperateBossMain", self._data.bossInfo.confId)
	self._friendViewIsShow = false
	self._friendList = {}

	self._friendSystem:requestFriendsMainInfo(function()
		self._friendModel = self._friendSystem:getFriendModel()
		self._friendList = self._friendModel:getOnlineFriendList(kFriendType.kGame)
	end)

	self._memberRecordListOj = self._clubSystem:getMemberRecordListOj()

	local clubMembers = self._memberRecordListOj:getList()

	self._memberList = {}

	for i = 1, #clubMembers do
		local member = clubMembers[i]

		if member:getIsOnline() == false or member:getIsOnline() == 0 then
			-- block empty
		else
			table.insert(self._memberList, member)
		end
	end

	self._rid = self._developSystem:getPlayer():getRid()

	local selfIndex = 0

	for i = 1, #self._memberList do
		local friendData = self._memberList[i]

		if friendData:getRid() == self._rid then
			selfIndex = i
		end
	end

	if selfIndex ~= 0 then
		table.remove(self._memberList, selfIndex)
	end

	self._currenfFriendShowType = kFriendShowType.kFriend
end

function CooperateBossInviteFriendMediator:backCooperateBossMain()
	local scene = self:getInjector():getInstance("BaseSceneMediator", "activeScene")
	local topViewName = scene:getTopViewName()

	if topViewName == "CooperateBossInviteFriendView" then
		self:dismissWithOptions({
			transition = ViewTransitionFactory:create(ViewTransitionType.kCommonAreaView)
		})
	end
end

function CooperateBossInviteFriendMediator:onClickBack(sender, eventType)
	local function requestLeaveTeam()
		local bossId = self._data.bossInfo.bossId

		self._cooperateBossSystem:requestLeaveTeam(bossId, function(response)
			if DisposableObject:isDisposed(self) or DisposableObject:isDisposed(self:getView()) then
				return
			end

			if response.resCode == 12806 then
				self:dispatch(Event:new(EVT_POP_TO_TARGETVIEW, "homeView"))

				return
			end

			self._cooperateBossSystem:enterCooperateBoss(true)
		end)
	end

	if self._data.bossInfo and self._data.bossInfo.isOwner then
		requestLeaveTeam()

		return
	end

	local bossData

	for i = 1, #self._data.bossInfo.battleRecordLst do
		bossData = self._data.bossInfo.battleRecordLst[i]
	end

	if bossData and bossData.state == kCooperateRoomState.kOnFinish then
		requestLeaveTeam()

		return
	end

	local outSelf, delegate = self, {}

	function delegate:willClose(popupMediator, data)
		if data.response == "ok" then
			-- block empty
		elseif data.response == "cancel" then
			requestLeaveTeam()
		elseif data.response == "close" then
			-- block empty
		end
	end

	local data = {
		title = Strings:get("Tip_Remind"),
		content = Strings:get("CooperateBoss_LeftEntry_UI08"),
		sureBtn = {
			text = Strings:get("CooperateBoss_LeftEntry_UI10")
		},
		cancelBtn = {
			text = Strings:get("CooperateBoss_LeftEntry_UI09")
		}
	}
	local view = self:getInjector():getInstance("AlertView")

	self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
		transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
	}, data, delegate))
end

function CooperateBossInviteFriendMediator:onClickInfoBtn()
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

function CooperateBossInviteFriendMediator:initAnim()
	local mc = cc.MovieClip:create("xiangqingxunhuan_zhuxianguanka_UIjiaohudongxiao")

	mc:addCallbackAtFrame(30, function()
		mc:stop()
	end)
	mc:stop()
	mc:addTo(self._fightBtn):center(self._fightBtn:getContentSize())
	mc:setScale(0.8)
	mc:setLocalZOrder(100)

	local tuijian = cc.MovieClip:create("tuijian_mengjingyuanzheng")
	local recommend = self._main:getChildByFullName("partenerRec")

	tuijian:addTo(recommend):center(recommend:getContentSize())
	tuijian:addCallbackAtFrame(12, function()
		tuijian:stop()
		self:setupHeroAttrAdds()
	end)

	local tuijian2 = cc.MovieClip:create("tuijian_mengjingyuanzheng")
	local recommend2 = self._main:getChildByFullName("rewardRec")

	recommend2:setVisible(true)
	tuijian2:addTo(recommend2):center(recommend2:getContentSize())
	tuijian2:addCallbackAtFrame(12, function()
		tuijian2:stop()
		self:setupRewards()
	end)
end

function CooperateBossInviteFriendMediator:setupRewards()
	self._rewardPanel:removeAllChildren()
	self._rewardPanel:setScrollBarEnabled(false)

	local rewardId = self._bossConfig.RewardShow
	local rewards = ConfigReader:getDataByNameIdAndKey("Reward", rewardId, "Content")

	for i = 1, #rewards do
		local icon = IconFactory:createRewardIcon(rewards[i], {
			showAmount = false,
			isWidget = true,
			notShowQulity = false
		})

		self._rewardPanel:pushBackCustomItem(icon)
		icon:setScale(0.6)
		IconFactory:bindTouchHander(icon, IconTouchHandler:new(self), rewards[i], {
			needDelay = true
		})
	end
end

function CooperateBossInviteFriendMediator:setupHeroAttrAdds()
	self._attrAddPanel:removeAllChildren()
	self._attrAddPanel:setScrollBarEnabled(false)

	local recomandHeros = self._bossConfig.ExcellentHero

	for i = 1, #recomandHeros do
		local heros = recomandHeros[i].Hero
		local effect = recomandHeros[i].Effect

		for i = 1, #heros do
			local heroCell = self._recommendHero1Clone:clone()
			local icon = heroCell:getChildByFullName("icon")
			local config = ConfigReader:getRecordById("HeroBase", heros[i])
			local heroImg = IconFactory:createRoleIconSpriteNew({
				id = config.RoleModel
			})

			heroImg:addTo(icon):center(icon:getContentSize())
			heroImg:setName("iconHero")

			local leftNumber = ccui.ImageView:create()

			leftNumber:setAnchorPoint(cc.p(0, 0.5))
			leftNumber:setPosition(cc.p(-15, 50))
			icon:addChild(leftNumber)
			leftNumber:setScale(0.4)
			leftNumber:setRotation(0)
			leftNumber:loadTexture(GameStyle:getHeroRarityImage(config.Rareity), 1)
			heroImg:setScale(0.25)

			local buffInfo = ConfigReader:getRecordById("SkillAttrEffect", effect)
			local desc = ConfigReader:getEffectDesc("SkillAttrEffect", buffInfo.EffectDesc, effect)
			local attackText = heroCell:getChildByFullName("attackText")

			attackText:setString(desc)
			self._attrAddPanel:pushBackCustomItem(heroCell)
		end
	end

	local fullStarCell = self._recommendHero2Clone:clone()
	local fullStarEffect = self._bossConfig.StarsAttrEffect
	local fullStarBuffInfo = ConfigReader:getRecordById("SkillAttrEffect", fullStarEffect)
	local fullStarDesc = ConfigReader:getEffectDesc("SkillAttrEffect", fullStarBuffInfo.EffectDesc, fullStarEffect)
	local attackText1 = fullStarCell:getChildByFullName("attackText")

	attackText1:setString(fullStarDesc)
	self._attrAddPanel:pushBackCustomItem(fullStarCell)

	local awakenCell = self._recommendHero3Clone:clone()
	local awakenEffect = self._bossConfig.AwakenAttrEffect
	local awakenBuffInfo = ConfigReader:getRecordById("SkillAttrEffect", awakenEffect)
	local awakenDesc = ConfigReader:getEffectDesc("SkillAttrEffect", awakenBuffInfo.EffectDesc, awakenEffect)
	local attackText2 = awakenCell:getChildByFullName("attackText")

	attackText2:setString(awakenDesc)
	self._attrAddPanel:pushBackCustomItem(awakenCell)
end

function CooperateBossInviteFriendMediator:createTableView()
	table.sort(self._data.bossInfo.battleRecordLst, function(a, b)
		assert(a.enterTime ~= nil, "find server to check enterTime")
		assert(b.enterTime ~= nil, "find server to check enterTime")

		return a.enterTime < b.enterTime
	end)

	if self._helperTableView then
		self._helperTableView:reloadData()
	else
		local playerSize = self._cloneCell:getContentSize()
		local kCellHeight = playerSize.height
		local kColumnNum = 3
		local viewSize = self._playerList:getContentSize()
		local kFirstCellPos = cc.p(viewSize.width / kColumnNum - 5, kCellHeight / 2 - 8)
		local tableView = cc.TableView:create(viewSize)

		local function numberOfCells(view)
			return math.ceil((#self._data.bossInfo.battleRecordLst + 1) / kColumnNum)
		end

		local function cellTouched(table, cell)
			return
		end

		local function cellSize(table, idx)
			return viewSize.width, kCellHeight
		end

		local function cellAtIndex(table, idx)
			local bar = table:dequeueCell()

			if bar == nil then
				bar = cc.TableViewCell:new()
			else
				bar:removeAllChildren()
			end

			for i = 1, kColumnNum do
				local pos = idx * kColumnNum + i

				if pos > #self._data.bossInfo.battleRecordLst + 1 then
					break
				end

				local itemCell = self._cloneCell:clone()

				itemCell:setTouchEnabled(true)
				itemCell:setSwallowTouches(false)
				itemCell:setSwallowTouches(false)

				local posX = kFirstCellPos.x * (i - 1)

				itemCell:setPosition(cc.p(posX, 0))
				bar:addChild(itemCell, 0, i)
				self:setPlayerCellState(itemCell, self._data.bossInfo.battleRecordLst[pos])
			end

			return bar
		end

		tableView:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
		tableView:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
		tableView:setDelegate()
		self._playerList:addChild(tableView)
		tableView:registerScriptHandler(numberOfCells, cc.NUMBER_OF_CELLS_IN_TABLEVIEW)
		tableView:registerScriptHandler(cellTouched, cc.TABLECELL_TOUCHED)
		tableView:registerScriptHandler(cellSize, cc.TABLECELL_SIZE_FOR_INDEX)
		tableView:registerScriptHandler(cellAtIndex, cc.TABLECELL_SIZE_AT_INDEX)
		tableView:setMaxBounceOffset(10)

		self._helperTableView = tableView

		tableView:reloadData()
	end
end

function CooperateBossInviteFriendMediator:setPlayerCellState(cell, info)
	local kill = cell:getChildByFullName("kill")
	local state = cell:getChildByFullName("state")
	local stateText = cell:getChildByFullName("state.text")
	local name = cell:getChildByFullName("name")
	local stateIcon = cell:getChildByFullName("stateIcon")
	local add = cell:getChildByFullName("add")
	local role = cell:getChildByFullName("role")
	local di = cell:getChildByFullName("di")

	if info then
		add:setVisible(false)
		name:setVisible(true)
		role:removeAllChildren()
		name:setString(info.name .. "  " .. Strings:get("CooperateBoss_Invite_UI32", {
			level = info.lv
		}))

		local roleModel = ConfigReader:getDataByNameIdAndKey("HeroBase", info.boardShowId, "RoleModel")
		local hero = RoleFactory:createHeroAnimation(roleModel, "stand")

		hero:setAnchorPoint(cc.p(0.5, 0))
		hero:setScale(0.6)
		hero:addTo(role):center(role:getContentSize()):offset(0, -50)

		if self._data.bossInfo and self._data.bossInfo.state == kCooperateBossEnemyState.kDead then
			assert(self._data.bossInfo.lastKillPid ~= nil, "not have lastKillPid,but boss dead")
			kill:setVisible(false)

			if self._data.bossInfo.lastKillPid == info.pid then
				kill:setVisible(true)
			end
		else
			kill:setVisible(false)
		end

		if info.isOwner then
			di:loadTexture("gongdou_img_yq_wzd1.png", ccui.TextureResType.plistType)
		else
			di:loadTexture("gongdou_img_yq_wzd2.png", ccui.TextureResType.plistType)
		end

		if info.state == kCooperateRoomState.kOnReady then
			stateText:setString(Strings:get("CooperateBoss_Room_UI02"))
			stateIcon:loadTexture("gongdou_img_yq_wzzb.png", ccui.TextureResType.plistType)
		elseif info.state == kCooperateRoomState.kOnFight then
			stateText:setString(Strings:get("CooperateBoss_Room_UI03"))
			stateIcon:loadTexture("gongdou_img_yq_wzdz.png", ccui.TextureResType.plistType)
		else
			stateText:setString(Strings:get("CooperateBoss_Invite_UI02", {
				dps = info.atk
			}))
			stateIcon:loadTexture("gongdou_img_yq_wzwc.png", ccui.TextureResType.plistType)
		end
	else
		kill:setVisible(false)
		state:setVisible(false)
		name:setVisible(false)
		stateIcon:setVisible(false)
		role:setVisible(false)
		add:setVisible(true)
		di:loadTexture("gongdou_img_yq_wzd3.png", ccui.TextureResType.plistType)

		if self._data.bossInfo.state == kCooperateBossEnemyState.kDead or self._data.bossInfo.state == kCooperateBossEnemyState.kEscaped or self._data.bossInfo.isOwner == false then
			cell:setVisible(false)
		elseif self._data.bossInfo.state == kCooperateBossEnemyState.kInit then
			cell:setGray(true)
			cell:addTouchEventListener(function(sender, eventType)
				if eventType == ccui.TouchEventType.ended then
					self:dispatch(ShowTipEvent({
						duration = 0.35,
						tip = Strings:get("CooperateBoss_Room_UI01")
					}))
				end
			end)
		else
			cell:setGray(false)
			cell:addTouchEventListener(function(sender, eventType)
				if eventType == ccui.TouchEventType.ended then
					if self._friendViewIsShow then
						self:hideFriendView()
					else
						self:showFriendView()
					end
				end
			end)
		end
	end
end

function CooperateBossInviteFriendMediator:showFriendView()
	self._friendViewIsShow = true

	self._friendPanel:setVisible(true)
	self._bossRole:setVisible(false)
	self._leaveTimesLab:setVisible(false)
	self._titleTimesLab:setVisible(false)
	self._totalTimesLab:setVisible(false)
	self._buyTimesBtn:setVisible(false)
	self.roleInfo:setVisible(false)
	self._fightBtn:setVisible(false)
	self:onFriendBtnClick()
end

function CooperateBossInviteFriendMediator:hideFriendView()
	self._friendViewIsShow = false

	self._friendPanel:setVisible(false)
	self._bossRole:setVisible(true)
	self._leaveTimesLab:setVisible(true)
	self._titleTimesLab:setVisible(true)
	self._totalTimesLab:setVisible(true)
	self._buyTimesBtn:setVisible(true)
	self.roleInfo:setVisible(true)
	self._fightBtn:setVisible(true)

	if self._data.bossInfo and self._data.bossInfo.state == kCooperateBossEnemyState.kDead then
		self._fightBtn:setVisible(false)
		self._leaveTimesLab:setVisible(false)
		self._totalTimesLab:setVisible(false)
		self._titleTimesLab:setVisible(false)
		self._buyTimesBtn:setVisible(false)
	end

	if self._data.bossInfo and self._data.bossInfo.state == kCooperateBossEnemyState.kEscaped then
		self._fightBtn:setVisible(false)
		self._leaveTimesLab:setVisible(false)
		self._totalTimesLab:setVisible(false)
		self._titleTimesLab:setVisible(false)
		self._buyTimesBtn:setVisible(false)
	end
end

function CooperateBossInviteFriendMediator:setupBossState()
	local bossName = self._bossInfoPanel:getChildByFullName("name")
	local bossLevel = self._bossInfoPanel:getChildByFullName("level")
	local bossHpBar = self._bossInfoPanel:getChildByFullName("loadingBar")
	local processText = self._bossInfoPanel:getChildByFullName("processText")
	local bossDead = self._bossInfoPanel:getChildByFullName("bossDead")
	local bossDeadText = self._bossInfoPanel:getChildByFullName("bossDeadText")
	local bossBattle = ConfigReader:getDataByNameIdAndKey("CooperateBossMain", self._data.bossInfo.confId, "BossBattle")
	local nameKey = ConfigReader:getDataByNameIdAndKey("CooperateBossBattle", bossBattle, "Name")

	bossLevel:setString(Strings:get("CooperateBoss_Invite_UI32", {
		level = self._data.bossInfo.lv
	}))
	bossHpBar:setPercent(self._data.bossInfo.bossHpRate * 100)
	bossName:setString(Strings:get(nameKey))
	processText:setString(tostring(self._data.bossInfo.lastBossHp) .. "/" .. tostring(self._data.bossInfo.bossHp))

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
	self._bossRole:removeAllChildren()

	local roleModel = ConfigReader:getDataByNameIdAndKey("CooperateBossMain", self._data.bossInfo.confId, "RoleModel")
	local heroSprite, _, spineani, picInfo = IconFactory:createRoleIconSpriteNew({
		useAnim = true,
		frameId = "bustframe9",
		id = roleModel
	})

	heroSprite:setPosition(cc.p(70, -70))
	heroSprite:setTouchEnabled(false)

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
	heroSprite:addTo(iconNode)
	heroSprite:setPosition(cc.p(60, -63))
	bossDead:setVisible(false)
	bossDeadText:setVisible(false)

	local bossStateText = "CooperateBoss_Room_UI01"

	if self._data.bossInfo.state == kCooperateBossEnemyState.kDead or self._data.bossInfo.state == kCooperateBossEnemyState.kEscaped then
		bossStateText = "CooperateBoss_Invite_UI05"

		bossDead:setVisible(true)
		bossDeadText:setVisible(true)
		heroSprite:setGray(true)

		if self._data.bossInfo.state == kCooperateBossEnemyState.kDead then
			bossDeadText:setString(Strings:get("CooperateBoss_Invite_UI06"))
			self._rewardBtn:setVisible(true)
		else
			bossDeadText:setString(Strings:get("CooperateBoss_BattleRecord_Status02"))
		end

		self:hideFriendView()
	elseif self._data.bossInfo.state == kCooperateBossEnemyState.kInit then
		bossStateText = "CooperateBoss_Room_UI01"
	elseif self._data.bossInfo.state == kCooperateBossEnemyState.kLiving then
		bossStateText = "CooperateBoss_Invite_UI01"
	end

	self._bossStateText:setString(Strings:get(bossStateText))
end

function CooperateBossInviteFriendMediator:setupBossTime()
	local function formatTime(time)
		local str = ""
		local fmtStr = "${d}:${H}:${M}:${S}"
		local timeStr = TimeUtil:formatTime(fmtStr, time)
		local parts = string.split(timeStr, ":", nil, true)
		local timeTab = {}

		timeTab.day = tonumber(parts[1])
		timeTab.hour = tonumber(parts[2])
		timeTab.min = tonumber(parts[3])
		timeTab.s = tonumber(parts[4])

		if timeTab.day > 0 then
			str = timeTab.day .. Strings:get("TimeUtil_Day") .. timeTab.hour .. Strings:get("TimeUtil_Hour") .. timeTab.min .. Strings:get("TimeUtil_Min") .. timeTab.s .. Strings:get("TimeUtil_Sec")
		elseif timeTab.hour > 0 then
			str = timeTab.hour .. Strings:get("TimeUtil_Hour") .. timeTab.min .. Strings:get("TimeUtil_Min") .. timeTab.s .. Strings:get("TimeUtil_Sec")
		else
			timeTab.min = math.max(0, timeTab.min)
			str = timeTab.min .. Strings:get("TimeUtil_Min") .. timeTab.s .. Strings:get("TimeUtil_Sec")
		end

		return str
	end

	if self._timer then
		self._timer:stop()

		self._timer = nil
	end

	if self._data.bossInfo.state == kCooperateBossEnemyState.kDead then
		self._bossTime:setString(Strings:get("CooperateBoss_Room_UI04", {
			time = formatTime((self._data.bossInfo and self._data.bossInfo.bossDeadTime or nil) and self._data.bossInfo.bossDeadTime - self._data.bossInfo.bossCreateTime)
		}))

		return
	elseif self._data.bossInfo.state == kCooperateBossEnemyState.kEscaped then
		self._bossTime:setString(Strings:get("CooperateBoss_Invite_UI23"))

		return
	end

	local remoteTimestamp = self._gameServerAgent:remoteTimestamp()
	local endTime = self._data.bossInfo.bossCreateTime + ConfigReader:getDataByNameIdAndKey("CooperateBossMain", self._data.bossInfo.confId, "Time")

	local function checkTimeFunc()
		remoteTimestamp = self._gameServerAgent:remoteTimestamp()

		local remainTime = endTime - remoteTimestamp

		if remainTime <= 0 then
			self._timer:stop()

			self._timer = nil

			self._bossTime:setString(Strings:get("CooperateBoss_Invite_UI23"))

			return
		end

		self._bossTime:setString(Strings:get("CooperateBoss_Trigger_UI02", {
			countdown = formatTime(remainTime)
		}))
	end

	self._timer = LuaScheduler:getInstance():schedule(checkTimeFunc, 1, false)

	checkTimeFunc()
end

function CooperateBossInviteFriendMediator:onFightClick()
	local curTimes = self._cooperateBossData:getBossFightTimes()

	if curTimes.value <= 0 then
		self:onBuyTimesClick()

		return
	end

	self._cooperateBossSystem:enterEditTeamView(self._data.bossInfo)
end

function CooperateBossInviteFriendMediator:onBuyTimesClick()
	local view = self:getInjector():getInstance("CooperateBossBuyTimeView")

	self:getEventDispatcher():dispatchEvent(ViewEvent:new(EVT_SHOW_POPUP, view, {
		transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
	}, nil))
end

function CooperateBossInviteFriendMediator:createFriendTableView()
	if self._tableView then
		self._tableView:reloadData()
	else
		local function scrollViewDidScroll(table)
			return
		end

		local function tableCellTouch(table, cell)
			return
		end

		local function cellSizeForTable(table, idx)
			return self._friendCell:getContentSize().width, self._friendCell:getContentSize().height
		end

		local function tableCellAtIndex(table, idx)
			local cell = table:dequeueCell()

			if cell == nil then
				cell = cc.TableViewCell:new()

				local sprite = self._friendCell:clone()

				sprite:setPosition(0, 0)
				cell:addChild(sprite)
				sprite:setVisible(true)
				sprite:setTag(10000)

				local cell_Old = cell:getChildByTag(10000)

				self:refreshFriendCell(cell_Old, idx + 1)
				cell:setTag(idx + 1)
			else
				local cell_Old = cell:getChildByTag(10000)

				self:refreshFriendCell(cell_Old, idx + 1)
				cell:setTag(idx + 1)
			end

			return cell
		end

		local function numberOfCellsInTableView(table)
			if self._currenfFriendShowType == kFriendShowType.kFriend then
				return #self._friendList
			elseif self._currenfFriendShowType == kFriendShowType.kClubFriend then
				return #self._memberList
			end
		end

		local tableView = cc.TableView:create(self._friendPanelList:getContentSize())

		tableView:setTag(1234)

		self._tableView = tableView

		tableView:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
		tableView:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
		tableView:setPosition(cc.p(7, 57))
		tableView:setAnchorPoint(self._friendPanelList:getAnchorPoint())
		tableView:setDelegate()
		tableView:addTo(self._friendPanel)
		tableView:registerScriptHandler(numberOfCellsInTableView, cc.NUMBER_OF_CELLS_IN_TABLEVIEW)
		tableView:registerScriptHandler(scrollViewDidScroll, cc.SCROLLVIEW_SCRIPT_SCROLL)
		tableView:registerScriptHandler(cellSizeForTable, cc.TABLECELL_SIZE_FOR_INDEX)
		tableView:registerScriptHandler(tableCellAtIndex, cc.TABLECELL_SIZE_AT_INDEX)
		tableView:registerScriptHandler(tableCellTouch, cc.TABLECELL_TOUCHED)
		tableView:reloadData()
	end

	if self._friendSchel == nil then
		local function friend_update()
			local friendCds = self._cooperateBossSystem:getMemberHelpTimeCDArr()

			for _, v in pairs(friendCds) do
				if self._tableView then
					self._tableView:updateCellAtIndex(v.idx)
				end
			end
		end

		self._friendSchel = self._friendSchel or LuaScheduler:getInstance():schedule(friend_update, 1, true)
	end
end

function CooperateBossInviteFriendMediator:refreshFriendCell(cell, index)
	local friendData

	if self._currenfFriendShowType == kFriendShowType.kFriend then
		friendData = self._friendList[index]
	elseif self._currenfFriendShowType == kFriendShowType.kClubFriend then
		friendData = self._memberList[index]
	end

	local headBg = cell:getChildByName("headimg")

	headBg:removeAllChildren()

	local headicon, oldIcon = IconFactory:createPlayerIcon({
		frameStyle = 2,
		clipType = 4,
		headFrameScale = 0.4,
		id = friendData:getHeadId(),
		size = cc.size(84, 84),
		headFrameId = friendData:getHeadFrame()
	})

	oldIcon:setScale(0.4)
	headicon:addTo(headBg):center(headBg:getContentSize())
	headicon:setScale(0.8)
	headBg:setTouchEnabled(true)
	mapButtonHandlerClick(nil, headBg, {
		func = function(sender, eventType)
			self:onClickHead(friendData, sender)
		end
	})

	local nameText = cell:getChildByName("Text_name")

	if self._currenfFriendShowType == kFriendShowType.kFriend then
		nameText:setString(friendData:getNickName())
	elseif self._currenfFriendShowType == kFriendShowType.kClubFriend then
		nameText:setString(friendData:getName())
	end

	local levelText = cell:getChildByName("Text_level")

	levelText:setString("Lv." .. friendData:getLevel())
	levelText:enableOutline(cc.c4b(0, 0, 0, 219.29999999999998), 1)
	levelText:setLocalZOrder(10)

	local combatText = cell:getChildByName("Text_combat")

	combatText:setString(Strings:get("CooperateBoss_Invite_UI29", {
		num = friendData:getCombat()
	}))

	local onlineText = cell:getChildByName("outLine")
	local helped = cell:getChildByName("helped")
	local inviteBtn = cell:getChildByName("invite")
	local inviting = cell:getChildByName("inviting")
	local isInTeam = false

	for i = 1, #self._data.bossInfo.battleRecordLst do
		local member = self._data.bossInfo.battleRecordLst[i]

		if member.pid == friendData:getRid() then
			isInTeam = true
		end
	end

	onlineText:setVisible(false)
	helped:setVisible(false)
	inviteBtn:setVisible(false)
	inviting:setVisible(false)

	if isInTeam then
		helped:setVisible(true)
	elseif self._currenfFriendShowType == kFriendShowType.kFriend then
		if friendData:getOnline() == false or friendData:getOnline() == 0 then
			onlineText:setVisible(true)
		else
			inviteBtn:setVisible(true)

			local rid = friendData:getRid()
			local memberHelpTimeCDArr = self._cooperateBossSystem:getMemberHelpTimeCDArr()

			if memberHelpTimeCDArr[rid] == nil or memberHelpTimeCDArr[rid].cd <= 0 then
				inviteBtn:setVisible(true)
				inviting:setVisible(false)
			else
				inviteBtn:setVisible(false)
				inviting:setVisible(true)

				local timerLab = cell:getChildByFullName("inviting.text")

				timerLab:setString(Strings:get("CooperateBoss_Invite_UI14", {
					cd = memberHelpTimeCDArr[rid].cd
				}))
			end
		end
	elseif self._currenfFriendShowType == kFriendShowType.kClubFriend then
		if friendData:getIsOnline() == false or friendData:getIsOnline() == 0 then
			onlineText:setVisible(true)
		else
			local rid = friendData:getRid()
			local memberHelpTimeCDArr = self._cooperateBossSystem:getMemberHelpTimeCDArr()

			if memberHelpTimeCDArr[rid] == nil or memberHelpTimeCDArr[rid].cd <= 0 then
				inviteBtn:setVisible(true)
				inviting:setVisible(false)
			else
				inviteBtn:setVisible(false)
				inviting:setVisible(true)

				local timerLab = cell:getChildByFullName("inviting.text")

				timerLab:setString(Strings:get("CooperateBoss_Invite_UI14", {
					cd = memberHelpTimeCDArr[rid].cd
				}))
			end
		end
	end

	local timeText = cell:getChildByName("Text_time")
	local helpText = cell:getChildByName("Text_help")
	local leaveTimes = 0
	local joinTimes = 0
	local isActivityClose = false
	local frientLst = {}

	if self._currenfFriendShowType == kFriendShowType.kFriend then
		frientLst = self._bossFightTimes.frientLst and self._bossFightTimes.frientLst or {}
	elseif self._currenfFriendShowType == kFriendShowType.kClubFriend then
		frientLst = self._bossFightTimes.clubmateLst and self._bossFightTimes.clubmateLst or {}
	end

	for i = 1, #frientLst do
		local data = frientLst[i]

		if data.pid == friendData:getRid() then
			leaveTimes = data.bossFightTime and data.bossFightTime or 0
			joinTimes = data.assistBattleTimes and data.assistBattleTimes or 0

			if data.bossFightTime == nil then
				isActivityClose = true
			end
		end
	end

	if isActivityClose then
		onlineText:setVisible(false)
		helped:setVisible(false)
		inviteBtn:setVisible(false)
		inviting:setVisible(false)
		cell:setGray(true)
		timeText:setPositionY(53)
		timeText:setString(Strings:get("CooperateBoss_Invite_UI31"))
		helpText:setString(Strings:get("CooperateBoss_Invite_UI30", {
			times = joinTimes
		}))
	else
		cell:setGray(false)
		timeText:setPositionY(83)
		timeText:setString(Strings:get("CooperateBoss_Invite_UI12", {
			times = leaveTimes
		}))
		helpText:setString(Strings:get("CooperateBoss_Invite_UI30", {
			times = joinTimes
		}))
	end

	local inviteBtn = cell:getChildByName("invite")

	local function receiveCallFunc(sender, eventType)
		self:onClickInvite(friendData, cell, index - 1)
	end

	mapButtonHandlerClick(nil, inviteBtn, {
		func = receiveCallFunc
	})
	self._cooperateBossSystem:setMemberIdx(friendData:getRid(), index - 1)
end

function CooperateBossInviteFriendMediator:onClickHead(data, sender)
	if not data then
		return
	end

	local friendSystem = self:getFriendSystem()

	local function gotoView(response)
		local record = BaseRankRecord:new()
		local var_60_0 = {
			headImage = data:getHeadId(),
			headFrame = data:getHeadFrame(),
			rid = data:getRid(),
			level = data:getLevel()
		}

		if self._currenfFriendShowType == kFriendShowType.kFriend then
			var_60_0.nickname = data:getNickName() or data:getName()
		end

		if self._currenfFriendShowType == kFriendShowType.kFriend then
			var_60_0.vipLevel = data:getVipLevel() or data:getVip()
		end

		var_60_0.combat = data:getCombat()
		var_60_0.slogan = data:getSlogan()
		var_60_0.master = data:getMaster()
		var_60_0.heroes = data:getHeroes()

		if self._currenfFriendShowType == kFriendShowType.kFriend then
			var_60_0.clubName = data:getUnionName() or self._clubSystem:getName()
		end

		var_60_0.online = self._currenfFriendShowType == kFriendShowType.kFriend and data:getOnline() == ClubMemberOnLineState.kOnline or data:getIsOnline() == ClubMemberOnLineState.kOnline

		if self._currenfFriendShowType == kFriendShowType.kFriend then
			var_60_0.lastOfflineTime = data:getLastOfflineTime() or data:getLastOnlineTime()
		end

		var_60_0.isFriend = response.isFriend
		var_60_0.close = response.close
		var_60_0.gender = data:getGender()
		var_60_0.city = data:getCity()
		var_60_0.birthday = data:getBirthday()
		var_60_0.tags = data:getTags()
		var_60_0.block = response.block
		var_60_0.leadStageId = data:getLeadStageId()
		var_60_0.leadStageLevel = data:getLeadStageLevel()

		record:synchronize(var_60_0)
		self._friendSystem:showFriendPlayerInfoView(record:getRid(), record)
	end

	friendSystem:requestSimpleFriendInfo(data:getRid(), function(response)
		if DisposableObject:isDisposed(self) or DisposableObject:isDisposed(self:getView()) then
			return
		end

		gotoView(response)
	end)
end

function CooperateBossInviteFriendMediator:onAddFriendBtnClick()
	local view = self:getInjector():getInstance("FriendMainView")

	self:getEventDispatcher():dispatchEvent(ViewEvent:new(EVT_SHOW_POPUP, view, {
		transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
	}, {
		tabType = 3
	}))
end

function CooperateBossInviteFriendMediator:onClubFriendBtnClick()
	self._friendBtn:setGray(true)
	self._clubFriendBtn:setGray(false)

	self._currenfFriendShowType = kFriendShowType.kClubFriend

	if self._tableView then
		self._tableView:reloadData()
	end

	self._noFriend:setVisible(false)

	if #self._memberList == 0 then
		self._noFriend:setVisible(true)
	end
end

function CooperateBossInviteFriendMediator:onFriendBtnClick()
	self._friendBtn:setGray(false)
	self._clubFriendBtn:setGray(true)

	self._currenfFriendShowType = kFriendShowType.kFriend

	if self._tableView then
		self._tableView:reloadData()
	end

	self._noFriend:setVisible(false)

	if #self._friendList == 0 then
		self._noFriend:setVisible(true)
	end
end

function CooperateBossInviteFriendMediator:onClickInvite(data, cell, idx)
	if not data then
		return
	end

	local rid = data:getRid()
	local bossId = self._data.bossInfo.bossId

	self._cooperateBossSystem:requestInviteFriend(bossId, rid, function(response)
		if response.resCode == 0 then
			if DisposableObject:isDisposed(self) or DisposableObject:isDisposed(self:getView()) then
				return
			end

			local memberHelpTimeCDArr = self._cooperateBossSystem:getMemberHelpTimeCDArr()

			if memberHelpTimeCDArr and (memberHelpTimeCDArr[rid] == nil or memberHelpTimeCDArr[rid].cd <= 0) then
				self._cooperateBossSystem:initMemberTimer(rid, 60, idx)
				cell:getChildByFullName("invite"):setVisible(false)
				cell:getChildByFullName("inviting"):setVisible(true)

				local timerLab = cell:getChildByFullName("inviting.text")

				timerLab:setString(Strings:get("CooperateBoss_Invite_UI14", {
					cd = 60
				}))
			end
		end
	end)
end

function CooperateBossInviteFriendMediator:refreshBuyTimes()
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

function CooperateBossInviteFriendMediator:refreshFriendView()
	self._friendList = {}

	self._friendSystem:requestFriendsMainInfo(function()
		if DisposableObject:isDisposed(self) or DisposableObject:isDisposed(self:getView()) then
			return
		end

		self._friendModel = self._friendSystem:getFriendModel()
		self._friendList = self._friendModel:getOnlineFriendList(kFriendType.kGame)

		self._noFriend:setVisible(false)

		if self._tableView and self._tableView:isVisible() and self._currenfFriendShowType == kFriendShowType.kFriend then
			self:setupFriendState()

			if #self._friendList == 0 then
				self._noFriend:setVisible(true)
			end
		end
	end)
end

function CooperateBossInviteFriendMediator:refreshClubMemberView()
	self._memberRecordListOj = self._clubSystem:getMemberRecordListOj()

	local clubMembers = self._memberRecordListOj:getList()

	self._memberList = {}

	for i = 1, #clubMembers do
		local member = clubMembers[i]

		if member:getIsOnline() == false or member:getIsOnline() == 0 then
			-- block empty
		else
			table.insert(self._memberList, member)
		end
	end

	self._currenfFriendShowType = kFriendShowType.kFriend

	self._noFriend:setVisible(false)

	if self._tableView and self._tableView:isVisible() and self._currenfFriendShowType == kFriendShowType.kClubFriend then
		self._tableView:reloadData()

		if #self._memberList == 0 then
			self._noFriend:setVisible(true)
		end
	end
end

function CooperateBossInviteFriendMediator:refreshView()
	local function callback(data)
		if DisposableObject:isDisposed(self) or DisposableObject:isDisposed(self:getView()) then
			return
		end

		self:initData(data)
		self:setupView()
		self:setupBossTime()
	end

	local bossId = self._data.bossInfo.bossId

	self._cooperateBossSystem:requestCooperateBossFriendInvite(bossId, callback)
end
