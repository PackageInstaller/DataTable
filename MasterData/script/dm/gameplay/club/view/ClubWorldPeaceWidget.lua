-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/club/view/ClubWorldPeaceWidget.lua

ClubWorldPeaceWidget = class("ClubWorldPeaceWidget", BaseWidget, _M)

ClubWorldPeaceWidget:has("_eventDispatcher", {
	is = "r"
}):injectWith("legs_sharedEventDispatcher")

local CampImage = {
	"CB_img_xin_f.png",
	"CB_img_xin_h.png",
	"CB_img_xin_l.png"
}
local CampImageColor = {
	cc.c3b(229, 75, 247),
	cc.c3b(241, 193, 32),
	cc.c3b(38, 164, 249)
}
local RoundText = {
	{
		"ClubNew_MapBOSS_9",
		"ClubNew_MapBOSS_10"
	},
	{
		"ClubNew_MapBOSS_11",
		"ClubNew_MapBOSS_12"
	},
	{
		"ClubNew_MapBOSS_13",
		"ClubNew_MapBOSS_14"
	}
}
local CampImage1 = {
	"CB_img_zhenying_hong2.png",
	"CB_img_zhenying_huang2.png",
	"CB_img_zhenying_lan2.png"
}
local CampGridRes = {
	"CB_sc9_dige_red.png",
	"CB_sc9_dige_yellow.png",
	"CB_sc9_dige_blue.png"
}

function ClubWorldPeaceWidget.class:createWidgetNode()
	local resFile = "asset/ui/ClubWorldPeace.csb"

	return cc.CSLoader:createNode(resFile)
end

function ClubWorldPeaceWidget:initialize(view, data)
	super.initialize(self, view)

	self._mediator = data.mediator
	self._worldPeaceSystem = DmGame:getInstance()._injector:getInstance("WorldPeaceSystem")
	self._worldPeace = self._worldPeaceSystem:getWorldPeace()
	self._gameServerAgent = DmGame:getInstance()._injector:getInstance("GameServerAgent")
	self._clubSystem = DmGame:getInstance()._injector:getInstance("ClubSystem")
	self._clubArr = {}

	self:initNodes(view)
end

local offsetConfig = {
	{
		-100,
		0
	},
	{
		0,
		100
	},
	{
		100,
		0
	},
	{
		0,
		-100
	}
}
local offsetConfig1 = {
	{
		-10,
		0
	},
	{
		0,
		10
	},
	{
		10,
		0
	},
	{
		0,
		-10
	}
}
local offsetConfig2 = {
	{
		10,
		0
	},
	{
		0,
		-10
	},
	{
		-10,
		0
	},
	{
		0,
		10
	}
}

function ClubWorldPeaceWidget:resetBgAnimPos()
	local actionTime = 1.5
	local animPanel = self._mapNode:getChildByFullName("animpanel")

	for i = 1, 4 do
		local node = animPanel:getChildByFullName("img" .. i)

		node.initPos = node.initPos or cc.p(node:getPosition())

		node:setPosition(node.initPos)
		node:setOpacity(255)
		node:stopAllActions()

		local action = cc.RepeatForever:create(cc.Sequence:create(cc.MoveBy:create(actionTime, cc.p(offsetConfig1[i][1], offsetConfig1[i][2])), cc.MoveBy:create(actionTime, cc.p(offsetConfig2[i][1], offsetConfig2[i][2]))))

		node:runAction(action)
	end
end

function ClubWorldPeaceWidget:runBgAnim(endFunc)
	local actionTime = 0.3
	local animPanel = self._mapNode:getChildByFullName("animpanel")

	for i = 1, 4 do
		local node = animPanel:getChildByFullName("img" .. i)
		local action = cc.Sequence:create(cc.Spawn:create(cc.MoveBy:create(actionTime, cc.p(offsetConfig[i][1], offsetConfig[i][2])), cc.FadeOut:create(actionTime)), cc.CallFunc:create(function()
			if i == 4 and endFunc then
				endFunc()
			end
		end))

		node:runAction(action)
	end
end

function ClubWorldPeaceWidget:dispose()
	if self._timer then
		self._timer:stop()

		self._timer = nil
	end

	self:getEventDispatcher():removeEventListener(EVT_WORLDPEACE_APPLY_SUCC, self, self.refreshView)
	self:getEventDispatcher():removeEventListener(EVT_WORLDPEACE_MATCH_END, self, self.refreshView)
	self:getEventDispatcher():removeEventListener(EVT_STAGE_SYNC, self, self.refreshView)
	self:getEventDispatcher():removeEventListener(EVT_SYSTEM_LEVELUP, self, self.refreshView)
	self:getEventDispatcher():removeEventListener(EVT_WORLDPESCE_MAIN_CLOSE, self, self.refreshView1)
	self:getEventDispatcher():removeEventListener(EVT_WORDPEACE_SWEAR_GROUPINFO_REFRESH, self, self.refreshView)
	super.dispose(self)
end

function ClubWorldPeaceWidget:initNodes()
	self._main = self:getView()
	self._helpBtn = self._main:getChildByName("helpbtn")

	self._helpBtn:setLocalZOrder(999999)
	self._helpBtn:addTouchEventListener(function(sender, eventType)
		if eventType == ccui.TouchEventType.began then
			self._worldPeaceSystem:tryEnterRankView()
		end
	end)

	self._guidebtn = self._main:getChildByName("guidebtn")

	self._guidebtn:setLocalZOrder(999999)
	self._guidebtn:addTouchEventListener(function(sender, eventType)
		if eventType == ccui.TouchEventType.began then
			local view = self:getInjector():getInstance("WordPeaceGuideView")

			self:getEventDispatcher():dispatchEvent(ViewEvent:new(EVT_SHOW_POPUP, view, {
				transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
			}, {}))
		end
	end)

	self._touchPanel = self._main:getChildByName("touchpanel")

	self._touchPanel:setSwallowTouches(false)
	self._touchPanel:setLocalZOrder(99999)

	self._checkBoxPanel = self._main:getChildByName("checkbox")

	self._checkBoxPanel:setLocalZOrder(9999)

	self._bgImg = self._main:getChildByName("Image_bg")
	self._statusText = self._main:getChildByName("Text_status")
	self._matchFailTips = self._main:getChildByName("Text_failTips")
	self._timePanel = self._main:getChildByName("Panel_time")

	self._timePanel:offset(0, 10)

	self._timeText = self._timePanel:getChildByName("Text_time")
	self._timeText2 = self._timePanel:getChildByName("Text_time2")
	self._timeDesc = self._timePanel:getChildByName("Text_desc")
	self._rewardPanel = self._main:getChildByName("reward")

	self._rewardPanel:offset(0, -2)
	self._rewardPanel:getChildByName("rewardTips"):offset(0, -2)

	self._clubClone = self._main:getChildByName("club")

	self._clubClone:setVisible(false)

	self._applyTips = self._main:getChildByName("Text_applyTips")
	self._statusDi = self._main:getChildByName("Image_4")
	self._chatBtn = bindWidget(self, "btn_chat", OneLevelViceButton, {
		handler = {
			clickAudio = "Se_Click_Common_1",
			func = bind1(self.onClickChat, self)
		}
	})
	self._applyBtn = bindWidget(self, "btn_apply", OneLevelMainButton, {
		handler = {
			clickAudio = "Se_Click_Common_1",
			func = bind1(self.onClickApply, self)
		}
	})
	self._mapNode = self._main:getChildByName("mapNode")

	self._mapNode:setVisible(false)
	self._mapNode:getChildByFullName("animpanel"):setTouchEnabled(false)

	self._bgAnim = self._mapNode:getChildByFullName("Image_14")
	self._scrollView = self._mapNode:getChildByName("map")
	self._infoPanel = self._mapNode:getChildByName("infoPanel")
	self._resultShow = self._main:getChildByName("resultShow")

	self._resultShow:setVisible(false)
	self._resultShow:setLocalZOrder(999999)
end

function ClubWorldPeaceWidget:closeEntrance(data)
	if not CommonUtils.GetSwitch("fn_worldpeace_enter") then
		local childs = self._main:getChildren()

		for i = 1, #childs do
			if childs[i] == self._bgImg then
				childs[i]:setVisible(true)
			else
				childs[i]:setVisible(false)
			end
		end

		return true
	end

	return false
end

function ClubWorldPeaceWidget:setupView(data)
	if self:closeEntrance() then
		return
	end

	self._enterView = data and data.enterView

	local unlock, tips = self._worldPeaceSystem:checkEnabled()

	if not self._clubSystem:getHasJoinClub() or not unlock then
		self:refreshView()
	else
		self:refreshViewByRequest()
	end

	self:getView():runAction(DelayAction:create(function()
		self:startTimer()
	end, 0.01))
	self:mapEventListeners()
end

function ClubWorldPeaceWidget:mapEventListeners()
	self:getEventDispatcher():addEventListener(EVT_WORLDPEACE_APPLY_SUCC, self, self.refreshView)
	self:getEventDispatcher():addEventListener(EVT_WORLDPEACE_MATCH_END, self, self.refreshView)
	self:getEventDispatcher():addEventListener(EVT_STAGE_SYNC, self, self.refreshView)
	self:getEventDispatcher():addEventListener(EVT_SYSTEM_LEVELUP, self, self.refreshView)
	self:getEventDispatcher():addEventListener(EVT_WORLDPESCE_MAIN_CLOSE, self, self.refreshView1)
	self:getEventDispatcher():addEventListener(EVT_WORDPEACE_SWEAR_GROUPINFO_REFRESH, self, self.refreshView)
end

function ClubWorldPeaceWidget:refreshViewByRequest()
	if self._enterView == "homeView" and (not self._clubSystem._clubView or not self._clubSystem._clubView:isVisible()) then
		return
	end

	if not self._clubSystem:getHasJoinClub() then
		return
	end

	local unlock, tips = self._worldPeaceSystem:checkEnabled()

	if unlock then
		local timeList = self._worldPeaceSystem:getTimeList()
		local status = self._worldPeaceSystem:getStatus()
		local curTime = self._gameServerAgent:remoteTimestamp()

		if status == WPStatus.kResultShow or status == WPStatus.kApply or status == WPStatus.kPrepare and curTime < timeList.chatTime1PRE then
			self._worldPeaceSystem:requestUpdateData(function(response)
				if DisposableObject:isDisposed(self) then
					return
				end

				self:refreshView()
			end, false)
		else
			self._worldPeaceSystem:requestSimpleBattleInfo(function(response)
				if DisposableObject:isDisposed(self) then
					return
				end

				self:refreshView()
			end, false)
		end
	end
end

function ClubWorldPeaceWidget:showChat(show)
	if self._chatView then
		self._chatView:setVisible(show)
	end

	if show and not self._chatView then
		self:getView():runAction(DelayAction:create(function()
			self._chatView = self:getInjector():getInstance("SmallChat")

			self._chatView:addTo(self._main):posite(-670, 4)

			local mediator = self._mediator:getMediatorMap():retrieveMediator(self._chatView)

			if mediator then
				mediator:setMessageBoxType(ChatTabType.kWordPeace)
				mediator:enterWithData({
					filterList = {
						ChatTabType.kWordPeace
					}
				})
				mediator:setChatItemContent(cc.size(-50, 0))
				self._chatView:getChildByName("Image_11"):setVisible(false)
			end
		end, 0.01))
	end
end

function ClubWorldPeaceWidget:isRichText(string)
	local str = "<font"
	local count = string:find(str)

	if count ~= nil then
		return true
	else
		return false
	end
end

function ClubWorldPeaceWidget:createRichText(string)
	if not self._centerTips then
		self._centerTips = ccui.RichText:createWithXML(string, {})

		local label = ccui.Text:create("", TTF_FONT_FZYH_M, 24)

		self._centerTips = label

		self._centerTips:addTo(self._main)
		label:setAnchorPoint(0.5, 1)
		label:setTextHorizontalAlignment(cc.TEXT_ALIGNMENT_CENTER)
		label:getVirtualRenderer():setOverflow(cc.LabelOverflow.SHRINK)
		label:getVirtualRenderer():setDimensions(520, 75)
		label:setLineSpacing(-4)
		setTextWithFontStyle(label, "FontZWMBText")

		local language = LanguageSetter:getLanguage()

		self._centerTips:posite(312, 180)
	end

	self._centerTips:setVisible(true)
	self._centerTips:setString(string)
end

function ClubWorldPeaceWidget:refreshConditionView()
	self._checkBoxPanel:setVisible(true)

	local checkBox1 = self._checkBoxPanel:getChildByFullName("checkboxpanel1.checkBox")
	local condiReachLevel = true
	local needLevel = ConfigReader:getDataByNameIdAndKey("ConfigValue", "ClubMapApplyCondition2", "content")

	if needLevel > self._worldPeace:getClubLevel() then
		condiReachLevel = false
		self._needApplyLevel = needLevel
	end

	self._condiReachLevel = condiReachLevel
	self._needApplyLevel = needLevel

	checkBox1:setSelected(condiReachLevel)
	checkBox1:setTouchEnabled(false)

	local descLabel1 = self._checkBoxPanel:getChildByFullName("checkboxpanel1.desclabel")

	descLabel1:setString(Strings:get("ClubMapBoss_ClubLevel", {
		needLevel = needLevel
	}))

	local checkBox2 = self._checkBoxPanel:getChildByFullName("checkboxpanel2.checkBox")
	local condiReachClub = true
	local needCon = ConfigReader:getDataByNameIdAndKey("ConfigValue", "ClubMapApplyCondition3", "content")

	if needCon > self._worldPeace:getClubCon() then
		condiReachClub = false
		self._needCondLevel = needCon
	end

	self._condiReachClub = condiReachClub

	checkBox2:setSelected(condiReachClub)
	checkBox2:setTouchEnabled(false)

	local descLabel2 = self._checkBoxPanel:getChildByFullName("checkboxpanel2.desclabel")

	descLabel2:setString(Strings:get("ClubMapBoss_ClubContribution", {
		needLevel = needCon
	}))
end

function ClubWorldPeaceWidget:getSwearChatGroupData()
	local groupData = self._worldPeaceSystem:getWorldSwearChat():getGroupData()

	groupData = groupData or self._worldPeaceSystem:getWorldPeace():getMatchGroup()

	local data = {}

	for k, v in pairs(groupData) do
		data[#data + 1] = v
	end

	self._worldPeaceSystem:setCampIndex(data)
	table.sort(data, function(a, b)
		return a.totalCombat > b.totalCombat
	end)

	return data
end

function ClubWorldPeaceWidget:refreshView()
	if self:closeEntrance() then
		return
	end

	self:resetBgAnimPos()

	local timeList = self._worldPeaceSystem:getTimeList()
	local curTime = self._gameServerAgent:remoteTimestamp()

	self._statusDi:setVisible(false)
	self._mapNode:setVisible(false)
	self._touchPanel:addTouchEventListener(function(sender, eventType)
		if eventType == ccui.TouchEventType.ended then
			local unlock, tips, params = self._worldPeaceSystem:checkEnabled()
			local status = self._worldPeaceSystem:getStatus()

			if not unlock then
				self:getEventDispatcher():dispatchEvent(ShowTipEvent({
					tip = tips
				}))

				return
			end

			if status == WPStatus.kApply then
				if not self._condiReachLevel then
					self:getEventDispatcher():dispatchEvent(ShowTipEvent({
						tip = Strings:get("ClubMapBoss_EntryTips1", {
							needLevel = self._needApplyLevel
						})
					}))

					return
				end

				if not self._condiReachClub then
					self:getEventDispatcher():dispatchEvent(ShowTipEvent({
						tip = Strings:get("ClubMapBoss_EntryTips2", {
							needLevel = self._needCondLevel
						})
					}))

					return
				end
			end

			if status == WPStatus.kPrepare and self._matchSucc then
				local isMatch = self._worldPeaceSystem:getWorldPeace():getMatchGroup()

				if #isMatch > 0 then
					local isChatTime = curTime < timeList.battleStartTime and curTime > timeList.chatTime1PRE

					if isChatTime then
						local beganPos = sender:getTouchBeganPosition()
						local endPos = sender:getTouchEndPosition()

						if math.abs(beganPos.x - endPos.x) < 150 then
							self._worldPeaceSystem:tryEnterSwearMain()

							return
						end
					end
				end
			end
		end
	end)

	if not self._main.tipText then
		self._main.tipText = cc.Label:createWithTTF("", TTF_FONT_FZYH_M, 18)

		self._main.tipText:addTo(self._main, 9999)
		setTextWithFontStyle(self._main.tipText, "FontLSTCHText")
	end

	if not self._main.condition then
		self._main.condition = cc.Node:create()

		self._main.condition:addTo(self._main, 9999)
	end

	self._needApplyLevel = nil
	self._needCondLevel = nil
	self._matchFail = false

	self._main.tipText:setString("")
	self._main.condition:setVisible(false)
	self._checkBoxPanel:setVisible(false)
	self._resultShow:setVisible(false)

	local unlock, tips, params = self._worldPeaceSystem:checkEnabled()

	self._statusText:setVisible(true)

	local status = self._worldPeaceSystem:getStatus()

	if not unlock then
		self._bgImg:loadTexture("img-gonghui_02.png", 1)
		self._statusText:setVisible(false)
		self._statusDi:setVisible(false)
		self:showReward()
		self._timePanel:setVisible(false)
		self._chatBtn:setVisible(false)
		self._applyBtn:setVisible(false)
		self:showChat(false)
		self._matchFailTips:setVisible(false)
		self._applyTips:setVisible(false)
		self:createRichText(Strings:get("ClubMapBoss_State_Open2", {
			fontName = TTF_FONT_FZYH_M
		}))
		self._applyBtn:setButtonName(Strings:get("GALLERY_UI59"))
		self._rewardPanel:setVisible(true)

		if params.type == 3 then
			self._main.tipText:setAnchorPoint(cc.p(1, 0.5))
			self._main.tipText:setPosition(570, 50)
			self._main.tipText:setString(tips)
		end

		return
	end

	if status == WPStatus.kApply or status == WPStatus.kResultShow then
		local resultData = self._worldPeace:getResultShowData()

		if resultData and next(resultData) then
			self._bgImg:loadTexture("img-gonghui_01.png", 1)
			self:showResultView(resultData)

			if self._centerTips then
				self._centerTips:setVisible(false)
			end
		else
			self._bgImg:loadTexture("img-gonghui_02.png", 1)
			self:createRichText(Strings:get("ClubMapBoss_Starcraft", {
				fontName = TTF_FONT_FZYH_M
			}))
		end

		self._statusText:setVisible(false)
		self._statusDi:setVisible(false)
		self:showReward()
		self._applyBtn:setVisible(false)
		self._timePanel:setVisible(true)
		self._chatBtn:setVisible(false)
		self._matchFailTips:setVisible(false)
		self._applyTips:setVisible(false)
		self._rewardPanel:setVisible(true)
		self:refreshConditionView()

		return
	else
		if status == WPStatus.kPrepare then
			local matchGroup = self._worldPeace:getMatchGroup()

			if #matchGroup > 0 then
				self._matchSucc = true

				self._worldPeaceSystem:setCampIndex(matchGroup)
			end

			if self._matchSucc then
				self._matchFail = false

				self._statusText:setVisible(false)
				self._matchFailTips:setVisible(false)
				self._timePanel:setVisible(true)
				self._matchFailTips:setVisible(false)
				self._bgImg:loadTexture("img-gonghui_01.png", 1)
				self._rewardPanel:setVisible(false)
				self._applyTips:setVisible(false)
				self._applyBtn:setVisible(false)
				self._timeDesc:setString("")

				if self._centerTips then
					self._centerTips:setVisible(false)
				end

				if #matchGroup > 0 then
					local isChatTime = curTime < timeList.battleStartTime and curTime > timeList.chatTime1PRE

					if isChatTime then
						self:clearClubPanel()

						local groupData = self:getSwearChatGroupData()

						self:showBattleGroupInfo(groupData)
						self._applyBtn:setVisible(true)
						self._applyBtn:setButtonName(Strings:get("ClubMapBoss_EntryPrepare"))

						return
					end
				end

				for i = 1, #matchGroup do
					local data = matchGroup[i]
					local panel = self._clubArr[i]

					if data then
						panel = panel or self:createClubPanel(data, i)

						local campDi = panel:getChildByName("Image_1")

						campDi:setVisible(false)

						local campImg = panel:getChildByName("Image_camp")

						campImg:setVisible(false)

						local numText = panel:getChildByName("Text_num")

						numText:setString("")

						local combatDi = panel:getChildByName("Image_zl")

						combatDi:setVisible(true)

						local combatText = panel:getChildByName("Text_combat")

						combatText:setString(self._worldPeaceSystem:formatShowNum(data.totalCombat or 0))
					end
				end
			else
				self:clearClubPanel()

				local curTime = self._gameServerAgent:remoteTimestamp()

				if curTime > timeList.matchtTime + 60 then
					self._matchFail = true
				else
					local resultData = self._worldPeace:getResultShowData()

					if resultData and next(resultData) then
						self._bgImg:loadTexture("img-gonghui_01.png", 1)
						self:showResultView(resultData)

						if self._centerTips then
							self._centerTips:setVisible(false)
						end
					else
						self._bgImg:loadTexture("img-gonghui_02.png", 1)
						self:createRichText(Strings:get("ClubMapBoss_Starcraft", {
							fontName = TTF_FONT_FZYH_M
						}))
					end

					self._statusText:setVisible(false)
					self._statusDi:setVisible(false)
					self:showReward()
					self._applyBtn:setVisible(false)
					self._timePanel:setVisible(false)
					self._chatBtn:setVisible(false)
					self._matchFailTips:setVisible(false)
					self._applyTips:setVisible(false)
					self._rewardPanel:setVisible(true)
					self:refreshConditionView()

					local lastTime = timeList.applyTime - curTime

					self._main.tipText:setAnchorPoint(cc.p(0, 0.5))
					self._main.tipText:setPosition(268, 50)
					self._main.tipText:setString(Strings:get("ClubMapBoss_NowMatching", {
						time = lastTime
					}))

					return
				end
			end
		elseif status == WPStatus.kBattle then
			local battleGroup = self._worldPeace:getBattleGroup()

			if battleGroup and #battleGroup > 0 then
				self._matchFail = false

				self._timePanel:setVisible(true)
				self._rewardPanel:setVisible(false)
				self._applyTips:setVisible(false)
				self._matchFailTips:setVisible(false)
				self._bgImg:loadTexture("img-gonghui_01.png", 1)
				self._chatBtn:setVisible(false)
				self._applyBtn:setVisible(true)
				self._applyBtn:setButtonName(Strings:get("ClubNew_MapBOSS_4"))
				self._timeDesc:setString("")

				local index = self._worldPeaceSystem:getTodaySeasonDayIndex()

				self._statusText:setString(Strings:get(RoundText[index][1]))
				self._statusDi:setVisible(true)
				self:clearClubPanel()
				self:showBattleMap()

				if self._centerTips then
					self._centerTips:setVisible(false)
				end
			else
				local curTime = self._gameServerAgent:remoteTimestamp()

				if curTime > timeList.battleStartTime + 60 then
					self._matchFail = true
				end
			end
		else
			local battleGroup = self._worldPeace:getBattleGroup()

			if not battleGroup or #battleGroup == 0 then
				local curTime = self._gameServerAgent:remoteTimestamp()

				if curTime > timeList.enterTime + 60 then
					self._matchFail = true
				end
			else
				self._matchFail = false

				self._timePanel:setVisible(true)
				self._rewardPanel:setVisible(false)
				self._bgImg:loadTexture("img-gonghui_01.png", 1)
				self._applyTips:setVisible(false)
				self._matchFailTips:setVisible(false)
				self._chatBtn:setVisible(true)
				self._applyBtn:setVisible(false)
				self._applyBtn:setButtonName(Strings:get("ClubNew_MapBOSS_4"))
				self:showBattleGroupInfo()

				local index = self._worldPeaceSystem:getTodaySeasonDayIndex()

				self._statusText:setString(Strings:get(RoundText[index][2]))
				self._statusDi:setVisible(true)

				if status == WPStatus.kBattleRest then
					self._timeDesc:setString("")
				else
					self._timeDesc:setString("")
				end
			end
		end

		if self._matchFail then
			self._timePanel:setVisible(true)
			self._rewardPanel:setVisible(false)
			self._chatBtn:setVisible(false)
			self._applyTips:setVisible(false)
			self._applyBtn:setVisible(false)
			self._bgImg:loadTexture("img-gonghui_02.png", 1)
			self:createRichText(Strings:get("ClubMapBoss_NoEntry", {
				fontName = TTF_FONT_FZYH_M
			}))
		end
	end
end

function ClubWorldPeaceWidget:showResultView(resultData)
	self._resultShow:setVisible(true)

	local topClub = self._resultShow:getChildByName("topClub")
	local topPlayer = self._resultShow:getChildByName("topPlayer")
	local clubrank = self._resultShow:getChildByName("clubrank")

	clubrank:setVisible(false)

	local changeBtn = self._resultShow:getChildByName("btn_change")

	changeBtn:addTouchEventListener(function(sender, eventType)
		if eventType == ccui.TouchEventType.ended then
			topClub:setVisible(not topClub:isVisible())
			topPlayer:setVisible(not topPlayer:isVisible())
			clubrank:setVisible(not clubrank:isVisible())
		end
	end)

	local topData = resultData.firstGroup

	if topData then
		local clubIcon = topClub:getChildByName("ClubIcon")

		if not clubIcon then
			local var_26_0 = {}

			var_26_0.id = topData.groupHeadImg or topData.headImg

			local icon = IconFactory:createClubIcon(var_26_0, {
				isNoBG = true
			})

			icon:addTo(topClub, -1):center(topClub:getContentSize()):offset(0, 20):setName("ClubIcon")
			icon:setScale(1.5)
		end

		local clubNameText = topClub:getChildByName("Text_name")

		clubNameText:setString(topData.groupName)
		topClub:addTouchEventListener(function(sender, eventType)
			if eventType == ccui.TouchEventType.ended then
				self._worldPeaceSystem:getOtherClubDetail({
					clubId = topData.gId
				}, true, function(data)
					local view = self:getInjector():getInstance("WordPeaceAssociationMainView")

					self:getEventDispatcher():dispatchEvent(ViewEvent:new(EVT_PUSH_VIEW, view, nil, data))
				end)
			end
		end)
	end

	local topPlayerData = resultData.firstPlayer

	if topPlayerData then
		local playerIcon = topPlayer:getChildByName("PlayerIcon")

		if not playerIcon and topPlayerData.headImage then
			local headicon, oldIcon = IconFactory:createPlayerIcon({
				clipType = 4,
				id = topPlayerData.headImage,
				headFrameId = topPlayerData.headFrame
			})

			headicon:setScale(1)
			oldIcon:setScale(0.45)
			headicon:addTo(topPlayer):center(topPlayer:getContentSize()):offset(0, 20):setName("PlayerIcon")
		end

		local nickNameText = topPlayer:getChildByName("Text_name")

		nickNameText:setString(topPlayerData.nickName)
		topPlayer:addTouchEventListener(function(sender, eventType)
			if eventType == ccui.TouchEventType.ended then
				local friendSystem = self:getInjector():getInstance(FriendSystem)

				friendSystem:showFriendInfoNewView(topPlayerData.rid)
			end
		end)
	end

	if not resultData.groupRank then
		local battleGroup = {}
		local allNum = 0

		for i, v in pairs(battleGroup) do
			allNum = allNum + v.point
		end

		local progressRes = {
			"CB_sc9_jindu2_red.png",
			"CB_sc9_jindu2_yellow.png",
			"CB_sc9_jindu2_blue.png"
		}

		for i = 1, 3 do
			local data = battleGroup[i]

			if data then
				local cell = clubrank:getChildByName("club" .. i)
				local nameText = cell:getChildByName("Text_name1")

				nameText:setString(i .. "." .. data.groupName)

				local barImg = cell:getChildByName("percent")

				barImg:loadTexture(progressRes[i], 1)

				local per = data.point / allNum

				barImg:setContentSize(cc.size(180 * per, 24))

				local value = cell:getChildByName("value")

				value:setString(data.point)
			end
		end
	end
end

function ClubWorldPeaceWidget:clearClubPanel()
	for i, v in pairs(self._clubArr) do
		v:removeFromParent()
	end

	self._clubArr = {}
end

function ClubWorldPeaceWidget:showBattleGroupInfo(groupData)
	if not groupData then
		::label_32_0::

		local battleGroup = self._worldPeace:getBattleGroup()

		if battleGroup and #battleGroup > 0 then
			self._worldPeaceSystem:setCampIndex(battleGroup)

			for i = 1, #battleGroup do
				local data = battleGroup[i]
				local panel = self._clubArr[i]

				if data then
					panel = panel or self:createClubPanel(data, i)

					local campDi = panel:getChildByName("Image_8")

					campDi:setVisible(true)

					local campImg = panel:getChildByName("Image_camp")

					campImg:setVisible(true)
					campImg:loadTexture(CampImage[data.camp], 1)

					local name = panel:getChildByName("Text_name")

					name:setColor(CampImageColor[data.camp])

					local numText = panel:getChildByName("Text_num")

					if data.bridesNum then
						numText:setString("X" .. data.bridesNum)
					end

					if data.point then
						numText:setString(data.point)
					end

					local combatDi = panel:getChildByName("Image_zl")

					combatDi:setVisible(false)

					local combatText = panel:getChildByName("Text_combat")

					combatText:setString("")

					local icon = panel:getChildByName("ClubIcon")

					icon:setScale(1.35)

					if data.bridesNum and self:isMaxBridesNum(data.gId) then
						icon:setScale(1.7)
					end
				end
			end
		end
	end
end

function ClubWorldPeaceWidget:isMaxBridesNum(gId)
	local battleGroup = self._worldPeace:getBattleGroup()
	local list = {}

	table.deepcopy(battleGroup, list)
	table.sort(list, function(a, b)
		return a.bridesNum > b.bridesNum
	end)

	if list[1].bridesNum > list[2].bridesNum and list[1].gId == gId then
		return true
	end

	return false
end

local posX = {
	227,
	70,
	390
}

function ClubWorldPeaceWidget:createClubPanel(data, index)
	local panel = self._clubClone:clone()

	panel:setVisible(true)
	panel:addTo(self._main):posite(posX[index], 92)

	local bgImg = panel:getChildByName("Image_8")

	bgImg:setVisible(false)

	local nameText = panel:getChildByName("Text_name")

	nameText:setString(data.name or data.gName or data.groupName)
	nameText:setColor(CampImageColor[data.camp])

	local var_35_1 = {}

	var_35_1.id = data.groupHeadImg or data.headImg

	local icon = IconFactory:createClubIcon(var_35_1, {
		isNoBG = true
	})

	icon:addTo(panel, -1):center(panel:getContentSize()):offset(0, 20):setName("ClubIcon")
	icon:setScale(1.76)

	panel.id = data.gId
	self._clubArr[index] = panel

	panel:setTouchEnabled(true)
	panel:setSwallowTouches(false)
	panel:addTouchEventListener(function(sender, eventType)
		if eventType == ccui.TouchEventType.ended then
			self._worldPeaceSystem:getOtherClubDetail({
				clubId = data.gId
			}, true, function(data)
				local view = self:getInjector():getInstance("WordPeaceAssociationMainView")

				self:getEventDispatcher():dispatchEvent(ViewEvent:new(EVT_PUSH_VIEW, view, nil, data))
			end)
		end
	end)

	return panel
end

function ClubWorldPeaceWidget:showReward()
	local rewards = ConfigReader:getDataByNameIdAndKey("Reward", "ClubMapReward_ShowR", "Content")

	if not self._rewardPanel.hasInit then
		for i, reward in pairs(rewards) do
			self._rewardPanel:runAction(DelayAction:create(function()
				local icon = IconFactory:createRewardIcon(reward, {
					showAmount = false,
					isWidget = true
				})

				icon:setScale(0.41)
				icon:addTo(self._rewardPanel):posite(25 + (i - 1) * 55, 28)
				IconFactory:bindTouchHander(icon, IconTouchHandler:new(self._mediator), reward, {
					needDelay = true
				})
			end, 0.1 * i))
		end

		self._rewardPanel.hasInit = true
	end
end

function ClubWorldPeaceWidget:startTimer()
	if self._timer then
		self._timer:stop()

		self._timer = nil
	end

	local timeList = self._worldPeaceSystem:getTimeList()

	self._oldStatus = self._worldPeaceSystem:getStatus()

	local curTime = self._gameServerAgent:remoteTimestamp()
	local oldChatTimeStatus = curTime < timeList.battleStartTime and curTime > timeList.chatTime1PRE

	local function update()
		if self._enterView == "homeView" and (not self._clubSystem._clubView or not self._clubSystem._clubView:isVisible()) then
			self:resetBattleMap()

			self._oldStatus = nil

			return
		end

		local curTime = self._gameServerAgent:remoteTimestamp()
		local isChatTime = curTime < timeList.battleStartTime and curTime > timeList.chatTime1PRE
		local status = self._worldPeaceSystem:getStatus()

		if self._oldStatus ~= status or isChatTime ~= oldChatTimeStatus then
			timeList = self._worldPeaceSystem:getTimeList()
			oldChatTimeStatus = isChatTime

			if status == WPStatus.kBattle then
				if curTime > timeList.battleStartTime + 5 then
					self:refreshViewByRequest()

					self._oldStatus = status
				end
			else
				self:refreshViewByRequest()

				self._oldStatus = status
			end
		end

		self._timeText:setAnchorPoint(0.5, 0.5)
		self._timeText:setPosition(83, 30)
		self._timeText:setString("")
		self._timeText2:setPosition(83, 4)
		self._timeText2:setAnchorPoint(0.5, 0.5)
		self._timeText2:setString("")
		self._timeText:setFontSize(20)
		self._timeText:getVirtualRenderer():setOverflow(cc.LabelOverflow.SHRINK)

		local unlock, tips, params = self._worldPeaceSystem:checkEnabled()

		if self._clubSystem:getHasJoinClub() and not unlock and params.type == 2 then
			self._timeText:setString(tips)
		elseif status == WPStatus.kApply or status == WPStatus.kResultShow then
			self._timeText:setAnchorPoint(0, 0.5)
			self._timeText:posite(40, 0)
			self._timeText:setFontSize(18)
			self._timeText:setTextHorizontalAlignment(cc.TEXT_ALIGNMENT_LEFT)
			self._timeText:getVirtualRenderer():setDimensions(310, 25)

			local remainTime = math.max(timeList.applyTime - curTime, 0)
			local strId = "ClubMapBoss_TimeMatch"

			if status == WPStatus.kResultShow then
				strId = "ClubMapBoss_NewBattle"
				remainTime = math.max(timeList.closeTime2 - curTime, 0)
			end

			if remainTime >= 86400 then
				local timeStr = TimeUtil:formatTimeStr(remainTime, 1)

				self._timeText:setString(Strings:get(strId, {
					time = timeStr
				}))
			else
				local format = Strings:get("Common_Time_07")

				self._timeText:setString(Strings:get(strId, {
					time = TimeUtil:formatTime(format, remainTime)
				}))
			end
		elseif status == WPStatus.kPrepare then
			if self._matchSucc then
				local isMatch = self._worldPeaceSystem:getWorldPeace():getMatchGroup()

				if #isMatch > 0 then
					if isChatTime then
						self._timeText:setAnchorPoint(0, 0.5)
						self._timeText:setPosition(-183, 10)
						self._timeText:setTextHorizontalAlignment(cc.TEXT_ALIGNMENT_LEFT)
						self._timeText:getVirtualRenderer():setDimensions(400, 25)

						local strId = "ClubMapBoss_TimeScramble"
						local remainTime = math.max(timeList.battleStartTime - curTime, 0)

						if curTime < timeList.chatTime2PRE then
							remainTime = math.max(timeList.chatTime2PRE - curTime, 0)
							strId = "ClubMapBoss_TimePrepare2"
						end

						if remainTime >= 86400 then
							local timeStr = TimeUtil:formatTimeStr(remainTime, 1)

							self._timeText:setString(Strings:get(strId, {
								time = timeStr
							}))
						else
							local format = Strings:get("Common_Time_07")
							local timeStr = TimeUtil:formatTime(format, remainTime)

							self._timeText:setString(Strings:get(strId, {
								time = timeStr
							}))
						end

						return
					else
						self._timeText:setTextHorizontalAlignment(cc.TEXT_ALIGNMENT_CENTER)
						self._timeText:getVirtualRenderer():setDimensions(500, 25)

						local remainTime = math.max(timeList.chatTime1PRE - curTime, 0)

						if remainTime >= 86400 then
							local timeStr = TimeUtil:formatTimeStr(remainTime, 1)

							self._timeText:setString(Strings:get("ClubMapBoss_TimePrepare", {
								time = timeStr
							}))
						else
							local format = Strings:get("Common_Time_07")
							local timeStr = TimeUtil:formatTime(format, remainTime)

							self._timeText:setString(Strings:get("ClubMapBoss_TimePrepare", {
								time = timeStr
							}))
						end

						local remainTime = math.max(timeList.battleStartTime - curTime, 0)

						if remainTime >= 86400 then
							local timeStr = TimeUtil:formatTimeStr(remainTime, 1)

							self._timeText2:setString(Strings:get("ClubMapBoss_TimeScramble", {
								time = timeStr
							}))
						else
							local format = Strings:get("Common_Time_07")
							local timeStr = TimeUtil:formatTime(format, remainTime)

							self._timeText2:setString(Strings:get("ClubMapBoss_TimeScramble", {
								time = timeStr
							}))
						end
					end
				end
			elseif self._matchFail then
				local remainTime = math.max(timeList.closeTime - curTime, 0)

				if remainTime >= 86400 then
					local timeStr = TimeUtil:formatTimeStr(remainTime, 1)

					self._timeText:setString(Strings:get("ClubMapBoss_NewBattle", {
						time = timeStr
					}))
				else
					local format = Strings:get("Common_Time_07")
					local timeStr = TimeUtil:formatTime(format, remainTime)

					self._timeText:setString(Strings:get("ClubMapBoss_NewBattle", {
						time = timeStr
					}))
				end

				self._timeText:setPosition(83, -0)
				self._timeText:setTextHorizontalAlignment(cc.TEXT_ALIGNMENT_CENTER)
				self._timeText:getVirtualRenderer():setDimensions(500, 25)
			elseif curTime >= timeList.matchtTime + 60 then
				self:refreshViewByRequest()
			end
		elseif self._matchFail then
			local remainTime = math.max(timeList.closeTime2 - curTime, 0)

			if remainTime >= 86400 then
				local timeStr = TimeUtil:formatTimeStr(remainTime, 1)

				self._timeText:setString(Strings:get("ClubMapBoss_NewBattle", {
					time = timeStr
				}))
			else
				local format = Strings:get("Common_Time_07")
				local timeStr = TimeUtil:formatTime(format, remainTime)

				self._timeText:setString(Strings:get("ClubMapBoss_NewBattle", {
					time = timeStr
				}))
			end

			self._timeText:setPosition(83, -0)
		end
	end

	self._timer = LuaScheduler:getInstance():schedule(update, 1, true)

	update()
end

function ClubWorldPeaceWidget:checkCondition()
	local condiReach = true
	local needLevel = ConfigReader:getDataByNameIdAndKey("ConfigValue", "ClubMapApplyCondition2", "content")

	if needLevel > self._worldPeace:getClubLevel() then
		self._condiReach = false
	end

	local needCon = ConfigReader:getDataByNameIdAndKey("ConfigValue", "ClubMapApplyCondition3", "content")

	if needCon > self._worldPeace:getClubCon() then
		self._condiReach = false
	end

	return condiReach
end

function ClubWorldPeaceWidget:onClickChat()
	local curTime = self._gameServerAgent:remoteTimestamp()
	local timeList = self._worldPeaceSystem:getTimeList()
	local isMatch = self._worldPeaceSystem:getWorldPeace():getMatchGroup()

	if #isMatch > 0 then
		local isChatTime = curTime < timeList.battleStartTime and curTime > timeList.chatTime1PRE

		if isChatTime then
			self._worldPeaceSystem:tryEnterSwearMain()

			return
		end
	end

	local view = self:getInjector():getInstance("chatMainView")
	local data = {
		tabType = ChatTabType.kWordPeace
	}

	self:getEventDispatcher():dispatchEvent(ViewEvent:new(EVT_SHOW_POPUP, view, {
		transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
	}, data))
end

function ClubWorldPeaceWidget:onClickApply()
	do return end

	local unlock, tips = self._worldPeaceSystem:checkEnabled()

	if not unlock then
		self:getEventDispatcher():dispatchEvent(ShowTipEvent({
			tip = tips
		}))

		return
	end

	if not CommonUtils.GetSwitch("fn_worldpeace_apply") then
		self:getEventDispatcher():dispatchEvent(ShowTipEvent({
			tip = Strings:get("ClubMapBoss_Result_Pause3_Tips")
		}))

		return
	end

	local status = self._worldPeaceSystem:getStatus()

	if status == WPStatus.kBattle then
		self._worldPeaceSystem:tryEnterMap()
	end
end

function ClubWorldPeaceWidget:showBattleMap()
	local bossList = self._worldPeace:getBossList()
	local battleGroup = self._worldPeace:getBattleGroup()

	if table.nums(bossList) < 1 or table.nums(battleGroup) < 1 then
		self._mapNode:setVisible(false)
		self:resetBattleMap()

		return
	end

	self:resetBattleMap()
	self._mapNode:setVisible(true)
	self._scrollView:setVisible(true)
	self._worldPeaceSystem:setCampIndex(battleGroup)

	self._campIndex = {}

	for i, v in ipairs(battleGroup) do
		self._campIndex[v.gId] = v.camp
	end

	for i, v in ipairs(battleGroup) do
		if not v.atkNum then
			local atkNum = 0

			if not v.defNum then
				local defNum = 0

				self._infoPanel:getChildByName("img" .. v.camp):ignoreContentAdaptWithSize(true)
				self._infoPanel:getChildByName("img" .. v.camp):loadTexture(atkNum == 0 and "CB_img_dunpai.png" or "CB_img_jian.png", 1)
				self._infoPanel:getChildByFullName("c" .. v.camp):setString(defNum + atkNum)
			end
		end
	end

	if not self._targetBoss then
		self._targetBoss = {}
		self._innnerContainer = self._scrollView:getInnerContainer()

		self._scrollView:setTouchEnabled(false)

		self._container = self._scrollView:getInnerContainer()

		self._scrollView:setScrollBarEnabled(false)
		self._container:setContentSize(cc.size(3900, 2544))

		self._containerSize = self._container:getContentSize()
		self._viewSize = self._scrollView:getContentSize()
		self._enterScale = 0.4

		local node = cc.Node:create()

		node:setName("BgLayer")
		node:addTo(self._innnerContainer)

		local bg = ccui.ImageView:create("asset/scene/cb_bg.jpg")

		bg:setAnchorPoint(cc.p(0, 0))
		bg:setPosition(0, 0)
		bg:addTo(node)

		local node = cc.Node:create()

		node:setName("BossLayer")
		node:addTo(self._innnerContainer)

		self._bossLayer = node

		local node = cc.Node:create()

		node:setName("BollLayer")
		node:addTo(self._innnerContainer)

		self._bollLayer = node
		self._bolls = {}
	end

	self._allPointOccupation1 = {}

	local list = {}
	local centerBossId = "ClubMapBoss01"

	for k, v in pairs(bossList) do
		list[#list + 1] = v
	end

	table.sort(list, function(a, b)
		return a:getConfig().HeroPosition[2] > b:getConfig().HeroPosition[2]
	end)

	local function create(v)
		local id = v:getId()

		if not self._targetBoss[id] then
			local boss = self:createBoss(v)

			self._bossLayer:addChild(boss)

			self._targetBoss[id] = boss

			self:runOvalAction(boss)
		end

		self._targetBoss[id].data = v

		self:updateBoss(self._targetBoss[id])
	end

	local p = bossList[centerBossId]:getConfig().HeroPosition
	local cp = cc.p(p[1], p[2])
	local size = self._scrollView:getContentSize()
	local offset = 50

	for i, v in ipairs(list) do
		local p = v:getConfig().HeroPosition
		local pos = cc.p(p[1], p[2])
		local w = (size.width / 2 + offset) * (1 / self._enterScale)
		local h = (size.height / 2 + offset) * (1 / self._enterScale)

		if pos.x < cp.x + w and pos.x > cp.x - w and pos.y < cp.y + h and pos.y > cp.y - h then
			create(v)
		end
	end

	if not self._initPos then
		self._initPos = true

		self:setZoomScale(self._enterScale)

		local pos = self:getMemberInnerContainerPosition(cc.p(p[1], p[2]))

		self._scrollView:setInnerContainerPosition(pos)
	end
end

function ClubWorldPeaceWidget:setZoomScale(scale, center)
	local container = self._innnerContainer

	center = center or self:getView():convertToWorldSpace(cc.p(568, 320))

	if scale == container:getScale() then
		return
	end

	local curSize = cc.size(self._containerSize.width * self._enterScale, self._containerSize.height * self._enterScale)

	if curSize.height < self._viewSize.height or curSize.width < self._viewSize.height then
		return
	end

	local oldCenter = container:convertToNodeSpace(center)

	container:setScale(self._enterScale)
	self._scrollView:setInnerContainerSize(curSize)

	local newCenter = container:convertToWorldSpace(oldCenter)
	local offset = cc.pSub(center, newCenter)
	local targetPos = cc.pAdd(self._scrollView:getInnerContainerPosition(), offset)

	self:setScrollViewPosition(targetPos)
end

function ClubWorldPeaceWidget:setScrollViewPosition(pos, open)
	local border = {
		500,
		500,
		500,
		400
	}
	local targetPos = cc.p(pos.x, pos.y)
	local viewSize = self._scrollView:getContentSize()
	local curSize = self._scrollView:getInnerContainerSize()
	local minX = viewSize.width - curSize.width
	local minY = viewSize.height - curSize.height
	local maxX = 0
	local maxY = 0

	if not open then
		local scale = self._innnerContainer:getScale()

		minX = minX + border[2] * scale
		minY = minY + border[3] * scale
		maxX = -border[1] * scale
		maxY = -border[4] * scale
	end

	targetPos.x = minX > targetPos.x and minX or targetPos.x
	targetPos.y = minY > targetPos.y and minY or targetPos.y
	targetPos.x = maxX < targetPos.x and maxX or targetPos.x
	targetPos.y = maxY < targetPos.y and maxY or targetPos.y

	self._scrollView:setInnerContainerPosition(targetPos)
end

function ClubWorldPeaceWidget:getMemberInnerContainerPosition(targetPos)
	local scale = self._container:getScale()

	return (cc.p(-(targetPos.x * scale - self._viewSize.width / 2), -(targetPos.y * scale - self._viewSize.height / 2)))
end

function ClubWorldPeaceWidget:createBoss(data)
	local config = data:getConfig()
	local node = ccui.Widget:create()
	local csbRes = "asset/ui/Boss_word_simple.csb"
	local content = cc.CSLoader:createNode(csbRes)

	content:addTo(node):setName("content"):setScale(1)
	content:getChildByName("name"):setString(data:getId())

	local pos = cc.p(config.HeroPosition[1], config.HeroPosition[2])

	node:setPosition(pos)

	local scale = K_CAMP_BOSS_SCALE[config.HeroFrame]

	node:setScale(scale)

	local grid = content:getChildByName("grid")

	grid:setScale(1 / scale)

	grid.id = data:getId()

	grid:setTouchEnabled(true)
	grid:addClickEventListener(function(sender)
		local status = self._worldPeaceSystem:getStatus()

		if status == WPStatus.kBattle then
			self._worldPeaceSystem.runBgAnim = false

			dump("runBgAnim___runBgAnim")
			self:runBgAnim(function()
				self._worldPeaceSystem:tryEnterMap(nil, function()
					self:resetBattleMap()
					dump("df______4124")
				end)
			end)
		end
	end)

	local modelId = IconFactory:getRoleModelByKey("HeroBase", config.Hero)
	local bossIcon = IconFactory:createAsyncRoleIconSpriteNew({
		id = modelId
	})
	local stencil = ccui.ImageView:create("asset/stencil/zc_Clubbride_boss.png", 0)

	bossIcon:setScale(2)
	bossIcon:setPosition(0, 0)
	bossIcon:removeFromParent()

	sprite = ClippingNodeUtils.getClippingNodeByData({
		stencil = stencil,
		content = bossIcon
	})

	sprite:setPosition(cc.p(0, 0))
	sprite:addTo(content)
	sprite:setName("playerIcon")
	sprite:setScale(0.41)
	sprite:offset(-75, 40)
	sprite:setOpacity(0)
	sprite:fadeTo({
		time = 0.5,
		opacity = 255
	})

	return node
end

function ClubWorldPeaceWidget:updateBoss(bossNode)
	local data = bossNode.data
	local config = data:getConfig()
	local content = bossNode:getChildByName("content")
	local name = content:getChildByName("name")
	local lv = data:getLv() and "(Lv." .. data:getLv() .. ")" or ""

	name:setString(Strings:get(ConfigReader:getRecordById("HeroBase", config.Hero).Name) .. lv)

	local camp = data:getCamp()

	if camp and camp ~= "" then
		content:getChildByName("grid"):loadTexture(CampGridRes[self._campIndex[camp]], 1)
	else
		content:getChildByName("grid"):loadTexture("CB_sc9_dige_bai.png", 1)
	end

	local myClubId = self._clubSystem:getClubId()
	local aTeamNum = data:getATeamNum()
	local dTeamNum = data:getDTeamNum()

	self._bolls[data:getId()] = {}

	for gid, n in pairs(aTeamNum) do
		for i = 1, n do
			local function func()
				local key = "atk_" .. data:getId() .. gid .. i
				local pos = self:randomAroudBossPos1(bossNode, key)
				local boll = ccui.ImageView:create(CampImage1[self._campIndex[gid]], 1)

				boll:addTo(self._bollLayer):posite(pos.pos.x, pos.pos.y)

				boll.key = key

				boll:setLocalZOrder(gid == myClubId and 999 or -9999)

				boll.bossNode = bossNode

				boll:runAction(self:attAction(boll))
				table.insert(self._bolls[data:getId()], boll)
			end

			func()
		end
	end

	local order = 0

	for gid, n in pairs(dTeamNum) do
		for i = 1, n do
			local function func()
				local key = "def_" .. data:getId() .. gid .. i
				local boll = ccui.ImageView:create(CampImage1[self._campIndex[gid]], 1)

				boll:addTo(self._bollLayer)

				order = order - 1

				boll:setLocalZOrder(order)

				boll.order = order
				boll.key = key
				boll.boss = bossNode

				self:ovalTo(bossNode, boll)
				table.insert(self._bolls[data:getId()], boll)

				if order == -1 then
					boll:setScale(1.2)
				end
			end

			self._bollLayer:runAction(DelayAction:create(function()
				func()
			end, 0.1 * i))
		end
	end
end

function ClubWorldPeaceWidget:randomAroudBossPos1(bossNode, teamkey)
	local randomCfg = {
		{
			0,
			25
		},
		{
			75,
			100
		},
		{
			25,
			50
		},
		{
			50,
			75
		}
	}
	local id = bossNode.data:getId()

	self._allPointOccupation1[id] = self._allPointOccupation1[id] or {}

	local num = table.nums(self._allPointOccupation1[id])
	local cfg = randomCfg[num % #randomCfg + 1]
	local dt = math.random(cfg[1], cfg[2]) / 100
	local pos = self:getOvalPos(cc.p(bossNode:getPosition()), dt)

	self._allPointOccupation1[id][teamkey] = {
		pos = pos,
		radio = 360 * dt,
		teamkey = teamkey
	}

	return self._allPointOccupation1[id][teamkey]
end

function ClubWorldPeaceWidget:getOvalPos(pos, dt, a, b)
	local a = a or K_Oval_V1[1]
	local b = b or K_Oval_V1[2]
	local x = a * math.cos(4 * K_MATH_PIOVER2 * dt)
	local y = b * math.sin(4 * K_MATH_PIOVER2 * dt)

	return cc.pAdd(pos, cc.p(x, y))
end

function ClubWorldPeaceWidget:ovalTo(targetBoss, displayNode)
	local x, y = targetBoss:getPosition()
	local var_61_0 = {
		moveClockDir = true,
		key = self._id,
		a = K_Oval_V[1],
		b = K_Oval_V[2],
		centerPos = cc.p(x, y),
		step = function(dt)
			return
		end
	}

	var_61_0.dt = displayNode.order * K_Oval_Dt * -1.5 + (targetBoss.ovalDt or 0)

	local config = var_61_0
	local ovalTo = OvalTo:create(K_Oval_Times, config)
	local action = cc.RepeatForever:create(ovalTo)

	displayNode:runAction(action)
end

function ClubWorldPeaceWidget:runOvalAction(node)
	local random = math.random(1, 10) / 10
	local ovalNode = cc.Node:create()

	ovalNode:addTo(node)

	local config = {
		key = "OvalNode",
		moveClockDir = true,
		dt = 0,
		a = K_Oval_V[1],
		b = K_Oval_V[2],
		centerPos = cc.p(0, 0),
		step = function(dt)
			node.ovalDt = dt + random
		end
	}
	local ovalTo = OvalTo:create(K_Oval_Times, config)
	local action = cc.RepeatForever:create(ovalTo)

	ovalNode:runAction(action)
end

function ClubWorldPeaceWidget:attAction(boll)
	local bossNode = boll.bossNode
	local bossPosX, bossPosY = bossNode:getPosition()
	local bollPosX, bollPosY = boll:getPosition()
	local delay1 = cc.DelayTime:create(math.random(1, 50) / 10)
	local moveTo1 = cc.MoveTo:create(0.2, cc.p(bossPosX, bossPosY))
	local moveTo2 = cc.MoveTo:create(0.08, cc.p(bollPosX, bollPosY))
	local delay2 = cc.DelayTime:create(1)
	local action = cc.Sequence:create(delay1, moveTo1, moveTo2, delay2)

	return (cc.RepeatForever:create(action))
end

function ClubWorldPeaceWidget:resetBattleMap()
	if self._targetBoss then
		self._bollLayer:stopAllActions()

		for k, v in pairs(self._targetBoss) do
			if self._bolls[v.data:getId()] then
				for k, v in pairs(self._bolls[v.data:getId()]) do
					v:removeFromParent()
				end
			end

			self._bolls[v.data:getId()] = nil
		end
	end
end

function ClubWorldPeaceWidget:refreshView1()
	if self._enterView == "homeView" and (not self._clubSystem._clubView or not self._clubSystem._clubView:isVisible()) then
		return
	end

	self:resetBgAnimPos()

	self._oldStatus = nil
end
