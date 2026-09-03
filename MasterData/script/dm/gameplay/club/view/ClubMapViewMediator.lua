-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/club/view/ClubMapViewMediator.lua

ClubMapViewMediator = class("ClubMapViewMediator", DmAreaViewMediator, _M)

ClubMapViewMediator:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")
ClubMapViewMediator:has("_clubSystem", {
	is = "r"
}):injectWith("ClubSystem")
ClubMapViewMediator:has("_systemKeeper", {
	is = "r"
}):injectWith("SystemKeeper")
ClubMapViewMediator:has("_gameServerAgent", {
	is = "r"
}):injectWith("GameServerAgent")
ClubMapViewMediator:has("_worldPeaceSystem", {
	is = "r"
}):injectWith("WorldPeaceSystem")

local kBtnHandlers = {}

function ClubMapViewMediator:initialize()
	super.initialize(self)
end

function ClubMapViewMediator:dispose()
	if self._clubResourcesBattleTimer then
		self._clubResourcesBattleTimer:stop()

		self._clubResourcesBattleTimer = nil
	end

	super.dispose(self)
end

function ClubMapViewMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(kBtnHandlers)
	self:mapEventListeners()

	local view = self:getView()
end

function ClubMapViewMediator:mapEventListeners()
	self.mapEventListener(self, self:getEventDispatcher(), EVT_CLUBMAPHOUSE_REFRESH, self, self.onClubPlayerHouseChange)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_CLUBOSSREDPOINT_REFRESH, self, self.refreshClubBossRedPoint)
end

function ClubMapViewMediator:enterWithData(data)
	self._data = data

	self:initData()
	self:setupView()
	self:setupMapPanel()
	self:setupHouseBtnWidget()
	self:checkClubResourcesBattleTimerLogic()
	self:checkBossLogic()
	self:checkEnterLogic()
	self:refreshRedPoint()
	self:requestAuditData()
	self:setupClickEnvs()
end

function ClubMapViewMediator:refreshClubBossRedPoint(data)
	self:refreshRedPoint()
end

function ClubMapViewMediator:initData()
	self._showHouseButtonPos = 0
	self._allHouseNode = {}
	self._housePositionList = self._clubSystem:getClub():getClubMapPositionList():getPlayerVillages()
	self._doMoveHouseLogic = false
	self._clubInfoOj = self._clubSystem:getClubInfoOj()
	self._curPosition = self._clubInfoOj:getPosition()
end

function ClubMapViewMediator:setupView()
	self._panel_base = self:getView():getChildByFullName("Panel_base")
	self._scrollView = self._panel_base:getChildByFullName("ScrollView")

	AdjustUtils.adjustLayoutByType(self._scrollView, AdjustUtils.kAdjustType.StretchWidth + AdjustUtils.kAdjustType.StretchHeight)
	self._scrollView:setScrollBarEnabled(true)
	self._scrollView:setSwallowTouches(true)
	self._scrollView:setTouchEnabled(true)
	self._scrollView:setInnerContainerSize(cc.size(2047, 1260))
	self._scrollView:setScrollBarEnabled(true)
	self._scrollView:setScrollBarAutoHideTime(9999)
	self._scrollView:setScrollBarColor(cc.c3b(255, 255, 255))
	self._scrollView:setScrollBarAutoHideEnabled(true)
	self._scrollView:setScrollBarWidth(5)
	self._scrollView:setScrollBarOpacity(125)
	self._scrollView:setScrollBarPositionFromCorner(cc.p(10, 15))

	self._mapPanel = self._scrollView:getChildByFullName("mapPanel")

	local touchPanel = self._mapPanel:getChildByFullName("touchPanel")

	touchPanel:setTouchEnabled(true)
	touchPanel:addTouchEventListener(function(sender, eventType)
		self:onClickTouchPanel(sender, eventType)
	end)

	self._clubResourceBattle = self._mapPanel:getChildByFullName("Panel_6.clubResourceBattle")
	self._clubResourcesBattleTimeText = self._mapPanel:getChildByFullName("Panel_6.clubResourceBattle.timeText")

	self._clubResourceBattle:setVisible(false)

	self._clubBaShenRedPoint = self._mapPanel:getChildByFullName("Panel_7.Image_17.redPoint")
	self._clubBossRedPoint = self._mapPanel:getChildByFullName("Panel_4.Image_17.redPoint")
	self._clubActivityBossRedPoint = self._mapPanel:getChildByFullName("Panel_5.Image_17.redPoint")
	self._clubHallRedPoint = self._mapPanel:getChildByFullName("Panel_3.Image_17.redPoint")
end

function ClubMapViewMediator:refreshRedPoint()
	local clubBashenSystem = self:getInjector():getInstance("ClubBashenSystem")
	local redPointState = self._clubSystem:hasHomeRedPoint()
	local unlock, tips = self._systemKeeper:isUnlock("ClubBashen")

	self._clubBaShenRedPoint:setVisible(clubBashenSystem:isTodayNotPlayed() and unlock)

	local redPointState = self._clubSystem:hasHomeRedPoint()

	self._clubBossRedPoint:setVisible(redPointState)

	local redPointState_Activity = self._clubSystem:hasHomeActivityRedPoint()

	self._clubActivityBossRedPoint:setVisible(redPointState_Activity)

	if self._curPosition == ClubPosition.kProprieter or self._curPosition == ClubPosition.kDeputyProprieter or self._curPosition == ClubPosition.kElite then
		local redPointState = self._clubSystem:hasAuditRecord()

		self._clubHallRedPoint:setVisible(redPointState)
	else
		self._clubHallRedPoint:setVisible(false)
	end
end

function ClubMapViewMediator:setupMapPanel()
	local idlist = {
		1,
		2,
		3,
		4,
		5,
		6,
		7,
		8
	}

	for i = 1, #idlist do
		local index = idlist[i]
		local buildingNode = self._mapPanel:getChildByFullName("Panel_" .. index)
		local touchPanel = buildingNode:getChildByFullName("touchPanel")
		local animNode = buildingNode:getChildByFullName("Node_anim")
		local nameNode = buildingNode:getChildByFullName("Image_17")

		if index == 1 then
			local vertices = {
				cc.p(0, 0),
				cc.p(0, 60),
				cc.p(20, 80),
				cc.p(45, 160),
				cc.p(65, 160),
				cc.p(90, 80),
				cc.p(110, 60),
				cc.p(110, 0)
			}
			local shape = ccui.HittingPolygon:create(vertices)

			touchPanel:setHittingShape(shape)
		elseif index == 2 then
			local vertices = {
				cc.p(60, 0),
				cc.p(70, 40),
				cc.p(-30, 40),
				cc.p(-50, 120),
				cc.p(10, 190),
				cc.p(80, 220),
				cc.p(200, 150),
				cc.p(210, 110),
				cc.p(190, 40),
				cc.p(90, 40),
				cc.p(110, 0)
			}
			local shape = ccui.HittingPolygon:create(vertices)

			touchPanel:setHittingShape(shape)

			local anim = cc.MovieClip:create("zhaohuan_zhujiemianchangjing")

			anim:addTo(animNode, 1)
			anim:setPosition(cc.p(105, 115))
			anim:gotoAndPlay(1)
		elseif index == 3 then
			local vertices = {
				cc.p(15, 15),
				cc.p(-5, 45),
				cc.p(-5, 80),
				cc.p(85, 140),
				cc.p(115, 95),
				cc.p(155, 60),
				cc.p(150, 0)
			}
			local shape = ccui.HittingPolygon:create(vertices)

			touchPanel:setHittingShape(shape)
		elseif index == 4 then
			local vertices = {
				cc.p(40, 0),
				cc.p(0, 30),
				cc.p(0, 60),
				cc.p(40, 80),
				cc.p(80, 160),
				cc.p(100, 170),
				cc.p(110, 70),
				cc.p(150, 40),
				cc.p(150, 0)
			}
			local shape = ccui.HittingPolygon:create(vertices)

			touchPanel:setHittingShape(shape)

			local anim = cc.MovieClip:create("shentuanBoss_zhujiemianchangjing")

			anim:addTo(animNode, 1)
			anim:setPosition(cc.p(75, 75))
			anim:gotoAndPlay(1)
		elseif index == 5 then
			local vertices = {
				cc.p(60, -10),
				cc.p(-30, 70),
				cc.p(150, 70),
				cc.p(160, 40),
				cc.p(130, 0)
			}
			local shape = ccui.HittingPolygon:create(vertices)

			touchPanel:setHittingShape(shape)

			local anim = cc.MovieClip:create("huodongBoss_zhujiemianchangjing")

			anim:addTo(animNode, 1)
			anim:setPosition(cc.p(105, 30))
			anim:gotoAndPlay(1)

			if not CommonUtils.GetSwitch("fn_clubBossPass") then
				nameNode:setVisible(false)
				touchPanel:setTouchEnabled(false)
			end
		elseif index == 6 then
			local vertices = {
				cc.p(75, 0),
				cc.p(0, 0),
				cc.p(-5, 50),
				cc.p(5, 110),
				cc.p(25, 105),
				cc.p(120, 80),
				cc.p(150, 40),
				cc.p(100, 0)
			}
			local shape = ccui.HittingPolygon:create(vertices)

			touchPanel:setHittingShape(shape)

			local anim = cc.MovieClip:create("dabang_zhujiemianchangjing")

			anim:addTo(animNode, 1)
			anim:setPosition(cc.p(62, 83))
			anim:gotoAndPlay(1)
		elseif index == 7 then
			local vertices = {
				cc.p(40, 0),
				cc.p(0, 30),
				cc.p(0, 90),
				cc.p(40, 120),
				cc.p(120, 160),
				cc.p(120, 170),
				cc.p(150, 70),
				cc.p(150, 40),
				cc.p(150, 0)
			}
			local shape = ccui.HittingPolygon:create(vertices)

			touchPanel:setHittingShape(shape)
			buildingNode:setVisible(not GameConfigs.closeClubBashen)
		elseif index == 8 then
			local anim = cc.MovieClip:create("jiaoyisuo_zhujiemianchangjing")

			anim:addTo(animNode, 1)
			anim:setPosition(cc.p(90, 55))
			anim:gotoAndPlay(1)
			nameNode:setVisible(false)
		end

		touchPanel:addTouchEventListener(function(sender, eventType)
			self:onClickBuilding(sender, eventType)
		end)
	end

	for i = 9, 23 do
		local buildingNode = self._mapPanel:getChildByFullName("Panel_" .. i)
		local touchPanel = buildingNode:getChildByFullName("touchPanel")

		touchPanel:addTouchEventListener(function(sender, eventType)
			self:onClickHouse(sender, eventType)
		end)

		local groundImage = buildingNode:getChildByFullName("groundImage")
		local houseImageNode = buildingNode:getChildByFullName("houseImageNode")
		local nameNode = buildingNode:getChildByFullName("nameNode")
		local nameBG = nameNode:getChildByFullName("Image_34")
		local nameText = nameNode:getChildByFullName("nameText")

		nameText:setPositionY(27.5)
		nameText:getVirtualRenderer():setDimensions(80, 0)
		nameNode:setVisible(false)

		local oneHouse = {}

		oneHouse.groundImage = groundImage
		oneHouse.houseImageNode = houseImageNode
		oneHouse.nameNode = nameNode
		oneHouse.nameBG = nameBG
		oneHouse.nameText = nameText
		self._allHouseNode[i - 8] = oneHouse
	end

	self:refreshAllHouse()
	self._scrollView:setInnerContainerPosition(cc.p(-500, -370))
end

function ClubMapViewMediator:setScrollViewTouchEnable(enabled)
	self._scrollView:setTouchEnabled(enabled)
end

function ClubMapViewMediator:onClubPlayerHouseChange()
	self._housePositionList = self._clubSystem:getClub():getClubMapPositionList():getPlayerVillages()
	self._doMoveHouseLogic = false

	if self._clubInfoWidget:getIsButtonShow() then
		self._clubInfoWidget:buttonHide()

		self._showHouseButtonPos = 0
	end

	self:refreshAllHouse()
end

function ClubMapViewMediator:refreshAllHouse()
	for i = 1, 15 do
		local oneHouse = self._allHouseNode[i]
		local oneHousePosition = self._housePositionList[i]

		oneHouse.houseImageNode:removeAllChildren()

		if oneHousePosition then
			oneHouse.groundImage:setVisible(false)

			local houseImage = ccui.ImageView:create(oneHousePosition:getJobPositinImage(), ccui.TextureResType.plistType)

			houseImage:setAnchorPoint(cc.p(0.5, 0.5))
			houseImage:setPosition(0, 0)
			oneHouse.houseImageNode:addChild(houseImage)
			oneHouse.nameNode:setVisible(true)
			oneHouse.nameText:setString(oneHousePosition:getName())
			oneHouse.nameBG:setContentSize(cc.size(92, oneHouse.nameText:getContentSize().height))

			if self._developSystem:getRid() == oneHousePosition:getRId() then
				oneHouse.nameText:setColor(cc.c3b(42, 255, 0))
			else
				oneHouse.nameText:setColor(cc.c3b(255, 255, 255))
			end
		else
			oneHouse.groundImage:setVisible(false)
			oneHouse.nameNode:setVisible(false)
		end
	end
end

function ClubMapViewMediator:showAllHouseEmptyGround()
	if self._doMoveHouseLogic then
		return
	end

	self._doMoveHouseLogic = true

	local hasEmpty = false

	for i = 1, 15 do
		local oneHouse = self._allHouseNode[i]
		local oneHousePosition = self._housePositionList[i]

		if oneHousePosition == nil then
			oneHouse.groundImage:setVisible(true)
			oneHouse.nameNode:setVisible(false)

			hasEmpty = true
		end
	end

	if hasEmpty == false then
		self._doMoveHouseLogic = false

		self:dispatch(ShowTipEvent({
			duration = 0.35,
			tip = Strings:get("ClubNew_UI_44")
		}))
	end
end

function ClubMapViewMediator:hideAllHouseEmptyGround()
	self._doMoveHouseLogic = false

	for i = 1, 15 do
		local oneHouse = self._allHouseNode[i]
		local oneHousePosition = self._housePositionList[i]

		if oneHousePosition == nil then
			oneHouse.groundImage:setVisible(false)
			oneHouse.nameNode:setVisible(false)
		end
	end
end

function ClubMapViewMediator:checkClubResourcesBattleTimerLogic()
	if CommonUtils.GetSwitch("fn_club_resource_battle") == false then
		return
	end

	if self._clubResourcesBattleTimer == nil then
		local function refreshTimer()
			local hasJoinClub = self._clubSystem:getHasJoinClub()

			if hasJoinClub == false then
				return
			end

			if self._clubSystem:isClubResourcesBattleOpen() == false then
				self._clubResourceBattle:setVisible(false)

				return
			end

			self._clubResourceBattle:setVisible(true)

			local ClubResourcesBattleData = self._clubSystem:getClub():getClubResourcesBattleInfo()
			local remoteTimestamp = self._gameServerAgent:remoteTimestamp()
			local refreshTiem = ClubResourcesBattleData:getNextMillis() / 1000
			local remainTime = refreshTiem - remoteTimestamp

			if remainTime <= 0 and ClubResourcesBattleData:getNextMillis() == -1 and ClubResourcesBattleData:getStatus() == "END" then
				self._clubResourcesBattleTimer:stop()

				self._clubResourcesBattleTimer = nil

				self._clubResourceBattle:setVisible(false)
			end

			self:refreshRemainTime(remainTime)
		end

		self._clubResourcesBattleTimer = LuaScheduler:getInstance():schedule(refreshTimer, 1, false)

		refreshTimer()
	end
end

function ClubMapViewMediator:refreshRemainTime(remainTime)
	local str = self._clubSystem:getRemainTime(remainTime)
	local ClubResourcesBattleData = self._clubSystem:getClub():getClubResourcesBattleInfo()

	if ClubResourcesBattleData:getStatus() == "NOTOPEN" or ClubResourcesBattleData:getStatus() == "MATCHING" then
		local timeStr = Strings:get("Club_ResourceBattle_8")

		self._clubResourcesBattleTimeText:setString(timeStr)
	end

	if ClubResourcesBattleData:getStatus() == "OPEN" then
		self._clubResourcesBattleTimeText:setString((remainTime < 0 or nil) and Strings:get("Club_ResourceBattle_14"))
	end

	if ClubResourcesBattleData:getStatus() == "END" then
		local timeStr = Strings:get("Club_ResourceBattle_14")

		self._clubResourcesBattleTimeText:setString(timeStr)
	end
end

function ClubMapViewMediator:setupHouseBtnWidget()
	self._buttonNode = self._mapPanel:getChildByFullName("buttonNode")
	self._clubInfoWidget = self:getInjector():injectInto(ClubMapButtonWidget:new(self._buttonNode))

	local delegate, outSelf = {}, self

	function delegate:willCancel()
		if outSelf._doMoveHouseLogic then
			outSelf:hideAllHouseEmptyGround()
		end
	end

	self._clubInfoWidget:initSubviews(delegate)
	self._buttonNode:getChildByFullName("main.Node_5.moveHomeButton"):addTouchEventListener(function(sender, eventType)
		self:onClickMoveHome(sender, eventType)
	end)
end

function ClubMapViewMediator:checkBossLogic()
	if self._data and self._data.goToBoss == true then
		self:tryEnterClubBoss()
	end

	if self._data and self._data.goToActivityBoss == true then
		self:tryEnterActivityBoss()
	end

	if self._data and self._data.goToActivityBossFormSunmmer == true then
		self:tryEnterActivityBoss()
	end
end

function ClubMapViewMediator:checkEnterLogic()
	if self._data then
		local tab = self._data.tab

		if tab and ClubHallType[tab] then
			local unlock = self._clubSystem:checkEnabled({
				tab = ClubHallType[tab]
			})

			if unlock then
				if ClubHallType[tab] == ClubHallType.kBasicInfo or ClubHallType[tab] == ClubHallType.kBasicInfo or ClubHallType[tab] == ClubHallType.kLog then
					local view = self:getInjector():getInstance("ClubNewHallView")
					local event = ViewEvent:new(EVT_PUSH_VIEW, view, nil, {})

					self:dispatch(event)
				elseif ClubHallType[tab] == ClubHallType.kTechnology then
					local view = self:getInjector():getInstance("ClubNewTechnologyView")
					local event = ViewEvent:new(EVT_PUSH_VIEW, view, nil, {})

					self:dispatch(event)
				elseif ClubHallType[tab] == ClubHallType.kBoss then
					self:tryEnterClubBoss()
				elseif ClubHallType[tab] == ClubHallType.kActivityBoss then
					self:tryEnterActivityBoss()
				end
			end
		end
	end
end

function ClubMapViewMediator:requestAuditData()
	if self._curPosition == ClubPosition.kProprieter or self._curPosition == ClubPosition.kDeputyProprieter or self._curPosition == ClubPosition.kElite then
		local clubSystem = self:getInjector():getInstance("ClubSystem")

		clubSystem:getAuditRecordListOj():cleanUp()
		clubSystem:requestAuditList(1, 20, true, function()
			if DisposableObject:isDisposed(self) then
				return
			end

			self:refreshClubBossRedPoint(nil)
		end)
	end
end

function ClubMapViewMediator:onClickBack(sender, eventType)
	self:dispatch(Event:new(EVT_HOMEVIEW_REDPOINT_REF, {
		showRedPoint = -1,
		type = 4
	}))
	self:dismissWithOptions({
		transition = ViewTransitionFactory:create(ViewTransitionType.kCommonAreaView)
	})
	cc.Director:getInstance():getOpenGLView():setIMEKeyboardState(false)
end

function ClubMapViewMediator:enterWorldPeaceView()
	self._worldPeaceSystem:tryEnter()
end

function ClubMapViewMediator:onClickBuilding(sender, eventType)
	local tag = sender:getTag()

	if eventType == ccui.TouchEventType.began and self._clubInfoWidget:getIsButtonShow() then
		self._clubInfoWidget:buttonHide()

		self._showHouseButtonPos = 0
	end

	if self._doMoveHouseLogic then
		self:hideAllHouseEmptyGround()
	end

	if eventType == ccui.TouchEventType.ended then
		if tag == 1 then
			local view = self:getInjector():getInstance("ClubNewTechnologyView")
			local event = ViewEvent:new(EVT_PUSH_VIEW, view, nil, {})

			self:dispatch(event)
		end

		if tag == 2 then
			local recruitSystem = self:getInjector():getInstance(RecruitSystem)
			local data = {
				isFromClub = true,
				recruitType = RecruitPoolType.kClub
			}

			recruitSystem:tryEnter(data)
		end

		if tag == 3 then
			self._clubSystem:requestClubInfo(function()
				local view = self:getInjector():getInstance("ClubNewHallView")
				local event = ViewEvent:new(EVT_PUSH_VIEW, view, nil, {})

				self:dispatch(event)
			end)
		end

		if tag == 4 then
			self:tryEnterClubBoss()
		end

		if tag == 5 then
			self:enterWorldPeaceView()
		end

		if tag == 6 then
			if self._clubSystem:isClubResourcesBattleOpen() == true then
				self._clubResourceBattle:setVisible(true)
			end

			AudioEngine:getInstance():playEffect("Se_Click_Open_1", false)
			self._clubSystem:tryEnterClubResourcesBattle()
		end

		if tag == 7 then
			local unlock, tips = self._systemKeeper:isUnlock("ClubBashen")

			if unlock then
				local club = self._clubSystem:getClub()
				local clubInfo = club:getInfo()
				local lastOutTime = clubInfo:getLastQuitTime()
				local gameServerAgent = self:getInjector():getInstance(GameServerAgent)
				local curTime = gameServerAgent:remoteTimestamp()

				if TimeUtil:isSameDay(lastOutTime, curTime, {
					sec = 0,
					min = 0,
					hour = 5
				}) then
					self:dispatch(ShowTipEvent({
						tip = Strings:get("Club_Cant_Goto_Train_Boost_Tip")
					}))
				else
					local clubBashenSystem = self:getInjector():getInstance("ClubBashenSystem")

					clubBashenSystem:tryEnter()
				end
			else
				self:dispatch(ShowTipEvent({
					duration = 0.35,
					tip = tips
				}))
			end
		end

		if tag == 8 then
			-- block empty
		end
	end
end

function ClubMapViewMediator:tryEnterClubBoss()
	if self._systemKeeper:canShow("ClubStage") == false or CommonUtils.GetSwitch("fn_clubBoss") == false then
		self:dispatch(ShowTipEvent({
			duration = 0.35,
			tip = Strings:get("ClubNew_UI_39")
		}))

		return
	end

	local function func(response)
		if self._clubSystem:getClubBoss():getIsRestState() then
			self:dispatch(ShowTipEvent({
				duration = 0.35,
				tip = Strings:get("Error_11466")
			}))

			return
		end

		local view = self:getInjector():getInstance("ClubBossView")
		local data = {
			viewType = ClubHallType.kBoss
		}

		if self._data and self._data.goToBoss == true then
			data.goToBoss = true
			self._data = nil
		end

		local event = ViewEvent:new(EVT_PUSH_VIEW, view, nil, data)

		self:dispatch(event)
	end

	local result, tip = self._systemKeeper:isUnlock("ClubStage")

	if result == true then
		local clubSystem = self:getInjector():getInstance("ClubSystem")

		if self._clubSystem:getClubBossKilled(ClubHallType.kBoss) and self._data and self._data.goToBoss == true then
			if func then
				func()
			end
		else
			clubSystem:requestClubBossInfo(func, true, ClubHallType.kBoss)
		end
	else
		self:dispatch(ShowTipEvent({
			duration = 0.35,
			tip = tip
		}))
	end
end

function ClubMapViewMediator:tryEnterActivityBoss()
	if self._clubSystem:checkHaveActivityBoss() == false then
		self:dispatch(ShowTipEvent({
			duration = 0.35,
			tip = Strings:get("ClubNew_UI_40")
		}))

		return
	end

	local function func()
		local view = self:getInjector():getInstance("ClubBossView")
		local data = {
			viewType = ClubHallType.kActivityBoss
		}

		if self._data and self._data.goToActivityBoss == true then
			data.goToActivityBoss = true
			self._data = nil
		end

		local event = ViewEvent:new(EVT_PUSH_VIEW, view, nil, data)

		self:dispatch(event)
	end

	local result, tip = self._systemKeeper:isUnlock("Activity_ClubStage")

	if result == true then
		local clubSystem = self:getInjector():getInstance("ClubSystem")

		if self._clubSystem:getClubBossKilled(ClubHallType.kActivityBoss) and self._data and self._data.goToActivityBoss == true then
			if func then
				func()
			end
		else
			clubSystem:requestClubBossInfo(func, true, ClubHallType.kActivityBoss)
		end
	else
		self:dispatch(ShowTipEvent({
			duration = 0.35,
			tip = tip
		}))
	end
end

function ClubMapViewMediator:onClickHouse(sender, eventType)
	if eventType == ccui.TouchEventType.ended then
		local tag = sender:getTag()
		local oneHousePosition = self._housePositionList[tag - 8]

		if oneHousePosition then
			print("onClickHouse_1")

			if self._doMoveHouseLogic then
				return
			end

			local buildingNode = self._mapPanel:getChildByFullName("Panel_" .. tag)

			self._buttonNode:setPosition(buildingNode:getPosition()):offset(-20, 35)
			self._clubInfoWidget:setSelfUser(false)

			if self._developSystem:getRid() == oneHousePosition:getRId() then
				self._clubInfoWidget:setSelfUser(true)
			end

			self._clubInfoWidget:buttonShow(oneHousePosition)
		else
			print("onClickHouse_2")

			if self._clubInfoWidget:getIsButtonShow() then
				self._clubInfoWidget:buttonHide()

				self._showHouseButtonPos = 0
			end

			if self._doMoveHouseLogic then
				self:hideAllHouseEmptyGround()
				self:onShowMoveHouseAlert(tag - 8)
				self._clubInfoWidget:buttonHide()
			end
		end
	end
end

function ClubMapViewMediator:onShowMoveHouseAlert(newPos)
	local outSelf, delegate = self, {}

	function delegate:willClose(popupMediator, data)
		if data.response == "ok" then
			outSelf._clubSystem:requestClubVillageChangeData(newPos, nil, true)
		else
			outSelf:hideAllHouseEmptyGround()
		end
	end

	local heroId = ConfigReader:getDataByNameIdAndKey("RoleModel", self._curModleId, "Model")
	local nameStr = ConfigReader:getDataByNameIdAndKey("HeroBase", heroId, "Name")
	local data = {
		title = Strings:get("ClubNew_UI_36"),
		content = Strings:get("ClubNew_UI_21"),
		sureBtn = {},
		cancelBtn = {}
	}
	local view = self:getInjector():getInstance("AlertView")

	self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
		transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
	}, data, delegate))
end

function ClubMapViewMediator:onClickMoveHome(sender, eventType)
	if eventType == ccui.TouchEventType.ended then
		AudioEngine:getInstance():playEffect("Se_Click_Open_1", false)

		local clubVillageChangeCount = self._clubSystem:getClub():getClubMapPositionList():getClubVillageChangeCount()

		if clubVillageChangeCount <= 0 then
			self:dispatch(ShowTipEvent({
				duration = 0.35,
				tip = Strings:get("ClubNew_UI_38")
			}))

			return
		end

		self:showAllHouseEmptyGround()
	end
end

function ClubMapViewMediator:onClickTouchPanel(sender, eventType)
	if eventType == ccui.TouchEventType.ended then
		AudioEngine:getInstance():playEffect("Se_Click_Open_1", false)

		if self._clubInfoWidget:getIsButtonShow() then
			self._clubInfoWidget:buttonHide()

			self._showHouseButtonPos = 0
		end

		if self._doMoveHouseLogic then
			self:hideAllHouseEmptyGround()
		end

		print("onClickTouchPanel")
	end
end

function ClubMapViewMediator:setupClickEnvs()
	local scriptNames = "guide_ClubPicGuide"
	local storyDirector = self:getInjector():getInstance(story.StoryDirector)
	local guideAgent = storyDirector:getGuideAgent()
	local guideSaved = guideAgent:isSaved(scriptNames)

	if not guideSaved then
		RuleFactory:showRules(self, nil, "Group_GuidePic")
		guideAgent:save(scriptNames)
	end
end
