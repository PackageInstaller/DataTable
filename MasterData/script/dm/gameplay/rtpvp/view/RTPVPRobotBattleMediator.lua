-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/rtpvp/view/RTPVPRobotBattleMediator.lua

RTPVPRobotBattleMediator = class("RTPVPRobotBattleMediator", BattleMainMediator, _M)

function RTPVPRobotBattleMediator:initialize()
	super.initialize(self)
end

function RTPVPRobotBattleMediator:onRemove()
	cancelDelayCall(self._surrenderTimer)
	super.onRemove(self)
end

function RTPVPRobotBattleMediator:enterWithData(data)
	super.enterWithData(self, data)
	self:mapEventListeners()
	self:createSurrenderButton()
end

function RTPVPRobotBattleMediator:mapEventListeners()
	self._viewContext:addEventListener(EVT_BATTLE_POINT_READY, self, self._readyGoFinish)
end

function RTPVPRobotBattleMediator:resumeWithData(data)
	super.resumeWithData(self, data)
end

function RTPVPRobotBattleMediator:createSurrenderButton()
	local surrenderBtn = ccui.Button:create("zhandou_btn_zd.png", "zhandou_btn_zd.png", "zhandou_btn_zd.png", ccui.TextureResType.plistType)
	local text1 = ccui.Text:create(Strings:get("RTPK_Lose_UI02"), TTF_FONT_FZYH_M, 18)

	text1:addTo(surrenderBtn):posite(16.5, 36)
	text1:setTextColor(cc.c3b(21, 21, 13))
	text1:enableOutline(cc.c4b(255, 255, 255, 153), 1)

	local text2 = ccui.Text:create(Strings:get("RTPK_Lose_UI03"), TTF_FONT_FZYH_M, 18)

	text2:addTo(surrenderBtn):posite(33.5, 22)
	text2:setTextColor(cc.c3b(21, 21, 13))
	text2:enableOutline(cc.c4b(255, 255, 255, 153), 1)

	if getCurrentLanguage() ~= GameLanguageType.CN then
		text1:setVisible(false)
		text2:setVisible(false)

		local text3 = ccui.Text:create(Strings:get("RTPK_Lose_UI01"), TTF_FONT_FZYH_M, 18)

		text3:addTo(surrenderBtn):posite(27.5, 28)
		text3:setTextColor(cc.c3b(21, 21, 13))
		text3:getVirtualRenderer():setOverflow(cc.LabelOverflow.SHRINK)
		text3:getVirtualRenderer():setDimensions(55, 50)
		text3:enableOutline(cc.c4b(255, 255, 255, 153), 1)
	end

	local ctrlButtons = self.battleUIMediator:getCtrlButtons()
	local ctrlView = ctrlButtons:getView()

	surrenderBtn:addTo(ctrlView)
	surrenderBtn:setAnchorPoint(0.5, 0.5)
	surrenderBtn:setPosition(0, 30)
	surrenderBtn:addTouchEventListener(function(sender, eventType)
		if eventType == ccui.TouchEventType.ended then
			local outSelf, delegate = self, {}

			function delegate:willClose(popupMediator, data)
				if data.response == AlertResponse.kOK then
					outSelf:stopScheduler()
					outSelf._delegate:onBattleSurrender()
				end
			end

			local data = {
				title = Strings:get("RTPK_Lose_UI01"),
				title1 = Strings:get("UITitle_EN_Tishi"),
				content = Strings:get("RTPK_Lose_UI04"),
				sureBtn = {},
				cancelBtn = {}
			}
			local view = self:getInjector():getInstance("AlertView")

			self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
				transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
			}, data, delegate))
		end
	end)
	surrenderBtn:setVisible(false)

	self._surrenderBtn = surrenderBtn
end

function RTPVPRobotBattleMediator:_readyGoFinish()
	local time = ConfigReader:getDataByNameIdAndKey("ConfigValue", "RTPK_LostTine", "content")

	self._surrenderTimer = delayCallByTime((time + 1) * 1000, function()
		self._surrenderBtn:setVisible(true)
	end)
end
