-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/activity/view/ActivityPuzzleGameMediator.lua

ActivityPuzzleGameMediator = class("ActivityPuzzleGameMediator", DmPopupViewMediator)

ActivityPuzzleGameMediator:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")
ActivityPuzzleGameMediator:has("_activitySystem", {
	is = "r"
}):injectWith("ActivitySystem")

local kBtnHandlers = {
	["main.ruleBtn"] = {
		ignoreClickAudio = false,
		func = "onClickRuleBtn"
	}
}

function ActivityPuzzleGameMediator:initialize()
	super.initialize(self)

	self._allPiece = {}
	self._doLightIndex = 0
end

function ActivityPuzzleGameMediator:dispose()
	if self._timer then
		self._timer:stop()

		self._timer = nil
	end

	super.dispose(self)
end

function ActivityPuzzleGameMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(kBtnHandlers)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_PUZZLEGAME_REFRESH, self, self.refreshView)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_PUZZLEGAME_TASK_REFRESH, self, self.refreshItemsCount)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_ACTIVITY_REFRESH, self, self.refreshView)
end

function ActivityPuzzleGameMediator:enterWithData(data)
	self._activity = data.activity
	self._activityUIType = data.activity:getConfig().UI
	self._parentMediator = data.parentMediator

	self:setupView()
end

function ActivityPuzzleGameMediator:setupView()
	self._main = self:getView():getChildByName("main")
	self._iconNumText = self._main:getChildByName("iconNumText")
	self._iconPanel = self._main:getChildByName("iconPanel")
	self._roleNode = self._main:getChildByName("roleNode")
	self._talkText = self._main:getChildByFullName("Panel_Hero.Text_talk")
	self._timeNode = self._main:getChildByName("timeNode")
	self._cloneCell = self:getView():getChildByName("cellPanel")

	self._cloneCell:setVisible(false)

	self._boxTipPanel = self._main:getChildByName("boxTipPanel")

	self._boxTipPanel:setVisible(false)

	self._puzzlePanel = self._main:getChildByFullName("gamePanel.puzzlePanel")
	self._taskBtn = bindWidget(self, "main.gainItemsBtn", OneLevelMainButton, {
		handler = {
			clickAudio = "Se_Click_Common_1",
			func = bind1(self.onTaskBtnClicked, self)
		}
	})

	self:createPuzzleBg()
	self:doRoleAndWorldLogic()
	self:updateRemainTime()
	self:doCostItemLogic()
	self:doAllPieceLogic()
	self:refreshRedPoint()

	local allIsReturn = false
	local allLightButton = self._main:getChildByName("allLightButton")

	allLightButton:addTouchEventListener(function(sender, eventType)
		if eventType == ccui.TouchEventType.began then
			allIsReturn = false

			local pos = sender:getTouchBeganPosition()

			self._beginPos = {
				x = pos.x,
				y = pos.y
			}

			local delayAct = cc.DelayTime:create(0.1)
			local judgeShowAct = cc.CallFunc:create(function()
				if self._activity:checkHasAllPieceRewardCanDoGian() == false then
					allIsReturn = true

					self:showBoxTipView(1)
				end
			end)
			local seqAct = cc.Sequence:create(delayAct, judgeShowAct)

			sender:runAction(seqAct)
		elseif eventType == ccui.TouchEventType.moved then
			local pos = sender:getTouchMovePosition()
			local changeX = math.abs(pos.x - self._beginPos.x)
			local changeY = math.abs(pos.y - self._beginPos.y)

			if changeX > 20 or changeY > 20 then
				self:removeBoxTipView()
			end
		elseif eventType == ccui.TouchEventType.ended then
			sender:stopAllActions()

			if not allIsReturn then
				if self._activity:checkHasAllPieceRewardCanDoGian() == true then
					self._activitySystem:requestGetPuzzleReward(self._activity:getId(), 2, nil)
				else
					self:dispatch(ShowTipEvent({
						tip = Strings:get("Puzzle_Error_2")
					}))
				end
			end

			AudioEngine:getInstance():playEffect("Se_Click_Common_1", false)
			self:removeBoxTipView()
		end
	end)

	local oneIsReturn = false
	local oneLightButton = self._main:getChildByName("oneLightButton")

	oneLightButton:addTouchEventListener(function(sender, eventType)
		if eventType == ccui.TouchEventType.began then
			oneIsReturn = false

			local pos = sender:getTouchBeganPosition()

			self._beginPos = {
				x = pos.x,
				y = pos.y
			}

			local delayAct = cc.DelayTime:create(0.1)
			local judgeShowAct = cc.CallFunc:create(function()
				oneIsReturn = true

				if self._activity:checkHasAllPieceRewardCanDoGian() == false then
					self:showBoxTipView(2)
				end
			end)
			local seqAct = cc.Sequence:create(delayAct, judgeShowAct)

			sender:runAction(seqAct)
		elseif eventType == ccui.TouchEventType.moved then
			local pos = sender:getTouchMovePosition()
			local changeX = math.abs(pos.x - self._beginPos.x)
			local changeY = math.abs(pos.y - self._beginPos.y)

			if changeX > 20 or changeY > 20 then
				self:removeBoxTipView()
			end
		elseif eventType == ccui.TouchEventType.ended then
			sender:stopAllActions()

			if not oneIsReturn then
				if self._activity:checkHasOnePieceRewardCanDoGian() == true then
					self._activitySystem:requestGetPuzzleReward(self._activity:getId(), 1, nil)
				else
					self:dispatch(ShowTipEvent({
						tip = Strings:get("Puzzle_Error_2")
					}))
				end
			end

			AudioEngine:getInstance():playEffect("Se_Click_Common_1", false)
			self:removeBoxTipView()
		end
	end)
end

function ActivityPuzzleGameMediator:refreshData()
	self._activity = self._activitySystem:getActivityByType(ActivityType.KPuzzleGame)
end

function ActivityPuzzleGameMediator:refreshView()
	self:refreshData()
	self:refreshItemsCount()
	self:setTalkView()
	self:doAllPieceLogic()
	self:refreshRedPoint()
end

function ActivityPuzzleGameMediator:createPuzzleBg()
	local iconName = self._activity:getActivityConfig().SceneImg
	local blurBg = cc.Sprite:create("asset/scene/" .. iconName)

	blurBg:addTo(self._puzzlePanel):center(self._puzzlePanel:getContentSize())

	local puzzlBgSize = blurBg:getContentSize()
	local scale_w = self._puzzlePanel:getContentSize().width / puzzlBgSize.width
	local scale_h = self._puzzlePanel:getContentSize().height / puzzlBgSize.height
	local scale = math.max(scale_w, scale_h)

	blurBg:setScale(scale)

	local oldScale = scale
	local oldPos = cc.p(blurBg:getPosition())
	local oldAnchor = blurBg:getAnchorPoint()

	blurBg:setAnchorPoint(cc.p(0, 0))
	blurBg:setPosition(0, 0)
	cc.Director:getInstance():setNextDeltaTimeZero(true)

	local formate = blurBg:getTexture():getPixelFormat()

	CustomShaderUtils.setBlurToNode(blurBg, 10, 10)

	local rtx = cc.RenderTexture:create(puzzlBgSize.width * scale, puzzlBgSize.height * scale, formate or cc.TEXTURE2_D_PIXEL_FORMAT_RGB_A8888)

	rtx:beginWithClear(0, 0, 0, 0)
	blurBg:visit()
	rtx:endToLua()
	app.render()

	local texture = rtx:getSprite():getTexture()

	blurBg:removeFromParent(true)

	self._blurTexture = texture

	local puzzleBg = cc.Sprite:create("asset/scene/" .. iconName)

	puzzleBg:addTo(self._puzzlePanel):center(self._puzzlePanel:getContentSize())

	local puzzlBgSize = puzzleBg:getContentSize()
	local scale_w = self._puzzlePanel:getContentSize().width / puzzlBgSize.width
	local scale_h = self._puzzlePanel:getContentSize().height / puzzlBgSize.height
	local scale = math.max(scale_w, scale_h)

	puzzleBg:setScale(scale)
	puzzleBg:setAnchorPoint(oldAnchor)
	puzzleBg:setPosition(oldPos)
	puzzleBg:setScale(oldScale)

	local titleImg = self._activity:getActivityConfig().PuzzleTopUI
	local title = self._main:getChildByFullName("Image_1")

	if titleImg then
		title:ignoreContentAdaptWithSize(true)
		title:loadTexture(titleImg .. ".png", ccui.TextureResType.plistType)
	end
end

function ActivityPuzzleGameMediator:refreshRedPoint()
	local oneLightRedPoint = self._main:getChildByFullName("oneLightButton.redPoint")
	local allLightRedPoint = self._main:getChildByFullName("allLightButton.redPoint")

	oneLightRedPoint:setVisible(self._activity:checkHasOnePieceRewardCanDoGian())
	allLightRedPoint:setVisible(self._activity:checkHasAllPieceRewardCanDoGian())
end

function ActivityPuzzleGameMediator:refreshItemsCount()
	local hasNum = CurrencySystem:getCurrencyCount(self, self._activity:getResourceItem())

	self._iconNumText:setString(hasNum)
end

function ActivityPuzzleGameMediator:doAllPieceLogic()
	if #self._allPiece == 0 then
		self:createPuzzlePiece()
	end

	local x = 6
	local y = 3
	local puzzle_Light = self._activity:getPuzzle()

	for i = 1, x * y do
		local onePiece = self._allPiece[i]
		local status = puzzle_Light[tostring(i - 1)]

		if status and status > 0 then
			if self._doLightIndex == i then
				self:doLightPieceAnim(onePiece)
			else
				onePiece:setVisible(false)
			end
		end
	end
end

function ActivityPuzzleGameMediator:doLightPieceAnim(onePiece)
	local fadeOut = cc.FadeOut:create(0.2)
	local anim = cc.MovieClip:create("lizi_shenmidangan")

	anim:addTo(onePiece):center(onePiece:getContentSize())
	anim:setTag(12345)
	anim:gotoAndPlay(1)

	local callback = cc.CallFunc:create(function()
		onePiece:setVisible(false)

		self._doLightIndex = 0
	end)

	onePiece:runAction(cc.Sequence:create(fadeOut, callback))
end

function ActivityPuzzleGameMediator:createPuzzlePiece()
	local x = 6
	local y = 3

	self._allPiece = {}

	local width = 620 / x
	local height = 330 / y

	for m = 1, y do
		for n = 1, x do
			local oneCell = self._cloneCell:clone()

			oneCell:setVisible(true)
			oneCell:setContentSize(cc.size(width, height))

			local bgImage = oneCell:getChildByName("bgImage")

			bgImage:setContentSize(cc.size(width, height))
			bgImage:setPosition(cc.p(width / 2, height / 2))
			oneCell:addTo(self._puzzlePanel):posite((n - 1) * width, (y - m) * height)
			oneCell:addTouchEventListener(function(sender, eventType)
				self:onCellClicked(sender, eventType, (m - 1) * x + n)
			end)
			self:createBlurSprite(oneCell, m, n)

			local iconName = ConfigReader:getDataByNameIdAndKey("ItemConfig", self._activity:getResourceItem(), "Icon") .. ".png"
			local icon = ccui.ImageView:create("asset/items/" .. iconName, ccui.TextureResType.localType)

			icon:addTo(oneCell):center(oneCell:getContentSize()):offset(-15, 0)
			icon:setScale(0.15)

			local costNum = self._activity:getResourceUnlockNumByPieceIndex((m - 1) * x + n)
			local costNumLabel = cc.Label:createWithTTF("", TTF_FONT_FZYH_M, 18)

			costNumLabel:setAnchorPoint(cc.p(0, 0.5))
			costNumLabel:enableOutline(cc.c4b(0, 0, 0, 255), 1)
			costNumLabel:addTo(oneCell):center(oneCell:getContentSize()):offset(10, 0)
			costNumLabel:setString(costNum)
			oneCell:setTag(costNum)

			self._allPiece[#self._allPiece + 1] = oneCell
		end
	end
end

function ActivityPuzzleGameMediator:createBlurSprite(cell, m, n)
	local x = 6
	local y = 3
	local width = 620 / x
	local height = 330 / y
	local sprite = cc.Sprite:createWithTexture(self._blurTexture)

	sprite:setFlippedY(true)
	sprite:setAnchorPoint(cc.p(0, 0))

	local spriteSize = sprite:getContentSize()
	local surplus_x = (spriteSize.width - 620) / 2
	local surplus_y = (spriteSize.height - 330) / 2

	sprite:setPosition(cc.p(-(n - 1) * width - surplus_x, -(y - m) * height - surplus_y))
	sprite:addTo(cell:getChildByName("BlurPanel"))
end

function ActivityPuzzleGameMediator:doRoleAndWorldLogic()
	local roleModel = "Model_" .. self._activity:getRoleModel()
	local heroSprite, _, spineani, picInfo = IconFactory:createRoleIconSpriteNew({
		useAnim = true,
		frameId = "bustframe9",
		id = roleModel
	})

	heroSprite:addTo(self._roleNode)
	heroSprite:setScale(0.7)
	heroSprite:setPosition(cc.p(40, 0))
	self:setTalkView()
end

function ActivityPuzzleGameMediator:doCostItemLogic()
	self._iconPanel:removeAllChildren()

	local iconName = ConfigReader:getDataByNameIdAndKey("ItemConfig", self._activity:getResourceItem(), "Icon") .. ".png"
	local icon = ccui.ImageView:create("asset/items/" .. iconName, ccui.TextureResType.localType)

	icon:addTo(self._iconPanel):center(self._iconPanel:getContentSize())
	icon:setScale(0.2)
	self:refreshItemsCount()
end

function ActivityPuzzleGameMediator:onCellClicked(sender, eventType, index)
	if eventType == ccui.TouchEventType.ended and sender:isVisible() then
		local costNum = sender:getTag()
		local hasNum = CurrencySystem:getCurrencyCount(self, self._activity:getResourceItem())

		if costNum <= hasNum then
			self._activitySystem:requestLightPuzzleOnePiece(self._activity:getId(), index - 1, nil)

			self._doLightIndex = index
		else
			self:dispatch(ShowTipEvent({
				tip = Strings:get("Puzzle_Error_1")
			}))
		end
	end
end

function ActivityPuzzleGameMediator:setTalkView()
	if self._activity:getBigReward() then
		self._talkText:setString(Strings:get("Puzzle_Main_UI08"))
	else
		self._talkText:setString(Strings:get("Puzzle_Main_UI07"))
	end
end

function ActivityPuzzleGameMediator:updateRemainTime()
	if self._activity == nil then
		self._timeNode:setVisible(false)

		return
	end

	if not self._timer then
		local remoteTimestamp = self._activitySystem:getCurrentTime()
		local refreshTiem = self._activity:getEndTime() / 1000

		local function checkTimeFunc()
			remoteTimestamp = self._activitySystem:getCurrentTime()

			local remainTime = refreshTiem - remoteTimestamp

			if remainTime <= 0 then
				self._timer:stop()

				self._timer = nil

				return
			end

			self:refreshRemainTime(remainTime)
		end

		self._timer = LuaScheduler:getInstance():schedule(checkTimeFunc, 1, false)

		checkTimeFunc()
	end
end

function ActivityPuzzleGameMediator:refreshRemainTime(remainTime)
	local str = ""
	local fmtStr = "${d}:${H}:${M}:${S}"
	local timeStr = TimeUtil:formatTime(fmtStr, remainTime)
	local parts = string.split(timeStr, ":", nil, true)
	local timeTab = {}

	timeTab.day = tonumber(parts[1])
	timeTab.hour = tonumber(parts[2])
	timeTab.min = tonumber(parts[3])
	timeTab.sec = tonumber(parts[4])
	str = timeTab.day > 0 and timeTab.day .. Strings:get("TimeUtil_Day") .. timeTab.hour .. Strings:get("TimeUtil_Hour") or timeTab.hour > 0 and timeTab.hour .. Strings:get("TimeUtil_Hour") .. timeTab.min .. Strings:get("TimeUtil_Min") or timeTab.min .. Strings:get("TimeUtil_Min") .. timeTab.sec .. Strings:get("TimeUtil_Sec")

	local str1 = Strings:get("Puzzle_Main_UI02", {
		time = str,
		fontName = TTF_FONT_FZYH_M
	})
	local node = self._timeNode:getChildByFullName("time")

	node:removeAllChildren()

	local contentText = ccui.RichText:createWithXML(str1, {})

	contentText:setAnchorPoint(cc.p(0, 0.5))
	contentText:addTo(node)
end

function ActivityPuzzleGameMediator:onClickRuleBtn(sender, eventType)
	if eventType == ccui.TouchEventType.ended then
		local RuleDesc = self._activity:getRules()

		if RuleDesc ~= nil then
			local view = self:getInjector():getInstance("ExplorePointRule")
			local event = ViewEvent:new(EVT_SHOW_POPUP, view, {
				transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
			}, {
				rule = RuleDesc,
				ruleReplaceInfo = {
					time = TimeUtil:getSystemResetDate()
				}
			}, nil)

			self:dispatch(event)
		end
	end
end

function ActivityPuzzleGameMediator:onTaskBtnClicked()
	local view = self:getInjector():getInstance("ActivityPuzzleGameTaskView")

	self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, nil, nil))
end

function ActivityPuzzleGameMediator:showBoxTipView(type)
	local activityConfig = self._activity:getActivityConfig()
	local allNode = self._boxTipPanel:getChildByName("allNode")
	local oneNode = self._boxTipPanel:getChildByName("oneNode")
	local Text_name = self._boxTipPanel:getChildByName("Text_name")
	local Text_desc = self._boxTipPanel:getChildByName("Text_desc")

	if type == 1 then
		self._boxTipPanel:setPosition(cc.p(350, 121))
		oneNode:setVisible(false)
		allNode:setVisible(true)

		if activityConfig.AllName then
			Text_name:setString(Strings:get(activityConfig.AllName))
		end

		if activityConfig.AllDesc then
			Text_desc:setString(Strings:get(activityConfig.AllDesc))
		end
	elseif type == 2 then
		self._boxTipPanel:setPosition(cc.p(450, 121))
		oneNode:setVisible(true)
		allNode:setVisible(false)

		if activityConfig.SingleName then
			Text_name:setString(Strings:get(activityConfig.SingleName))
		end

		if activityConfig.SingleDesc then
			Text_desc:setString(Strings:get(activityConfig.SingleDesc))
		end
	end

	self._boxTipPanel:setVisible(true)
end

function ActivityPuzzleGameMediator:removeBoxTipView()
	self._boxTipPanel:setVisible(false)
end
