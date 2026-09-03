-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/activity/view/TrialRoadMainMediator.lua

local heroImg = {
	"ydn022.png",
	"ydn021.png",
	"ydn022.png",
	"ydn023.png"
}

TrialRoadMainMediator = class("TrialRoadMainMediator", DmAreaViewMediator, _M)

TrialRoadMainMediator:has("_activitySystem", {
	is = "r"
}):injectWith("ActivitySystem")
TrialRoadMainMediator:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")

function TrialRoadMainMediator:initialize()
	super.initialize(self)
end

function TrialRoadMainMediator:dispose()
	if self._timer then
		self._timer:stop()

		self._timer = nil
	end

	super.dispose(self)
end

function TrialRoadMainMediator:onRegister()
	super.onRegister(self)

	local view = self:getView()
	local background = cc.Sprite:create("asset/scene/trialroad_scene.jpg")

	background:addTo(view, -1):setName("backgroundBG")
end

function TrialRoadMainMediator:enterWithData(data)
	super.enterWithData(self, data)

	self._activityId = data.activityId
	self._activity = self._activitySystem:getActivityById(self._activityId)
	self._ElementData = ConfigReader:getDataTable("TrialRoadBlock")

	self:initView()
	self:initBgAnimation()
	self:mapEventListeners()
	self:bindWidgets()
	self:setupTopInfoWidget()
	self:initMap()
	self:refreshBottomBox()
	self:initDice()
	self:refreshConsume()
	self:playBackGroundMusic()
	self:startTimer()
end

function TrialRoadMainMediator:playBackGroundMusic()
	AudioEngine:getInstance():playBackgroundMusic(self._activity:getBgm())
	print(self._activity:getBackGroundMusic(), "self._activity:getBackGroundMusic()")
end

function TrialRoadMainMediator:initView()
	self._view = self:getView()
	self._main = self._view:getChildByName("main")
	self._panel_di = self._main:getChildByName("panel_di")
	self._Pright = self._main:getChildByName("panel_right")
	self._btnRule = self._main:getChildByName("btn_rule")
	self._btnReward = self._Pright:getChildByName("btn_reward")

	self._btnReward:setVisible(false)

	self._btnBuy = self._Pright:getChildByName("btn_buy")
	self._btnRun = self._Pright:getChildByName("btn_run")
	self._labLastTime = self._Pright:getChildByName("lab_lasttime")
	self._labTime = self._panel_di:getChildByName("lab_time")
	self._bottomPanel = self._main:getChildByFullName("scroll.panel_bottom")
	self._scrollView = self._main:getChildByFullName("scroll")
	self._role = self._panel_di:getChildByName("img_role")

	self._role:ignoreContentAdaptWithSize(true)

	self._touchLayer = self._main:getChildByName("touchLayer")

	self._touchLayer:setVisible(false)

	self._tips = self._main:getChildByName("tips")

	self._tips:setScale(0)

	self._quanshu = self._main:getChildByName("quanshu")
end

function TrialRoadMainMediator:initBgAnimation()
	local bg = self._panel_di:getChildByName("img_di_bg")
	local uiType = self._activity:getUIType()

	if uiType and uiType == "ATHENA_GO_LOVE" then
		bg:loadTexture("bg_yadianna_bg6.png", ccui.TextureResType.plistType)
		self._Pright:loadTexture("bg_yadianna_bg7.png", ccui.TextureResType.plistType)
	elseif uiType and uiType == "ATHENA_GO_SPRING" then
		bg:loadTexture("bg_yadianna_bg3.png", ccui.TextureResType.plistType)
		self._Pright:loadTexture("bg_yadianna_bg5.png", ccui.TextureResType.plistType)
	end

	local remainTime = self._activitySystem:getActivityRemainTime(self._activityId) * 0.001

	remainTime = math.max(0, remainTime)

	if remainTime > 2 then
		local scriptNames = "eventstory_TrialRoad"
		local storyDirector = self:getInjector():getInstance(story.StoryDirector)
		local storyAgent = storyDirector:getStoryAgent()

		storyAgent:setSkipCheckSave(false)

		local guideSaved = storyAgent:isSaved(scriptNames)

		if not guideSaved then
			storyAgent:trigger(scriptNames)
		end
	end
end

function TrialRoadMainMediator:sortmapData()
	local map = self._activity:getMap()
	local mapVec = {}

	for i = 1, 22 do
		local value

		for k, v in pairs(map) do
			if i == tonumber(k) then
				value = v
			end
		end

		value = value or 0

		if i == 1 then
			value = 0
		end

		mapVec[i] = value
	end

	self._mapData = mapVec

	return mapVec
end

function TrialRoadMainMediator:initMap()
	self:sortmapData()

	self._mapVec = {}
	self._transportMap = {}

	local mapData = self:sortmapData()
	local scaleInfos = {
		TR_Dice = 0.35,
		TR_Girl = 0.8,
		TR_FuDai = 0.35,
		TR_HaiSeWei = 0.8
	}
	local offsets = {
		TR_Dice = cc.p(0, 3),
		TR_BaoXiang = cc.p(6, 8)
	}
	local animMaps = {
		TR_Transfer_2 = "chuansong_qianjinyadianna",
		TR_Transfer_1 = "chuansong_qianjinyadianna"
	}
	local tansportInfo = {}

	for i = 1, 22 do
		local eventPanel = self._panel_di:getChildByName("img_di_" .. i)
		local data = mapData[i]
		local rewardImg = ccui.ImageView:create("img_ath_shaizi.png", ccui.TextureResType.plistType)

		rewardImg:addTo(eventPanel):center(eventPanel:getContentSize())
		rewardImg:setName("rewardImg")
		rewardImg:setVisible(false)

		if tonumber(data) ~= 0 then
			local imgName = self._ElementData[data].Icon

			rewardImg:loadTexture(imgName .. ".png", ccui.TextureResType.plistType)
			rewardImg:setVisible(true)
			rewardImg:setScale(scaleInfos[data] or 0.7)

			local var_9_0

			if offsets[data] then
				var_9_0 = offsets[data].x or 0

				local var_9_1

				if offsets[data] then
					var_9_1 = offsets[data].y or 0
				end
			end

			rewardImg:offset(var_9_0, var_9_1)

			rewardImg.isChuanSong = false

			if animMaps[data] then
				local chuansong = cc.MovieClip:create(animMaps[data])

				chuansong:addTo(eventPanel):offset(40, 50)
				chuansong:setName("chuansongAnim")
				rewardImg:setVisible(false)

				rewardImg.isChuanSong = true
				tansportInfo[#tansportInfo + 1] = i
			end
		end

		self._mapVec[i] = eventPanel
	end

	if #tansportInfo > 0 then
		self._transportMap[tostring(tansportInfo[1])] = tansportInfo[2]
		self._transportMap[tostring(tansportInfo[2])] = tansportInfo[1]
	end

	self:initAthenaPos()

	local rewardsInfos = {
		{
			amount = 0,
			code = "IR_Gold",
			type = 2
		},
		{
			amount = 0,
			code = "IR_Diamond",
			type = 2
		},
		{
			amount = 0,
			code = "IM_TR_Bag",
			type = 2
		},
		{
			amount = 0,
			code = "IM_TR_BaoXiang",
			type = 2
		}
	}
	local targetPos = cc.p(50, 180)

	self._rewardsLabel = {}

	for k, reward in pairs(rewardsInfos) do
		local icon = IconFactory:createRewardIcon(reward, {
			isWidget = true,
			showAmount = false
		})

		icon:setScale(0.35)
		self._Pright:getChildByName("bg"):addChild(icon)

		targetPos.y = 180 - (k - 1) * 48

		icon:setPosition(targetPos)

		local label = cc.Label:createWithTTF("x" .. reward.amount, TTF_FONT_FZYH_R, 18)

		self._Pright:getChildByName("bg"):addChild(label)
		label:setAnchorPoint(cc.p(0, 0.5))

		targetPos.y = 180 - (k - 1) * 48

		label:setPosition(cc.p(90, targetPos.y))

		self._rewardsLabel[reward.code] = label
	end

	local rewards = self._activity:getRewardInfo()

	for k, reward in pairs(rewards) do
		if self._rewardsLabel[reward.code] then
			self._rewardsLabel[reward.code]:setString("x" .. reward.amount)
		end
	end
end

function TrialRoadMainMediator:initAthenaPos()
	self._AthenaPos = self._activity:getCurlPos()

	self:changeRoleImg(self._AthenaPos)

	local paneCell = self._mapVec[self._AthenaPos]

	self._role:setPosition(paneCell:getPosition()):offset(0, 40)
	paneCell:getChildByName("rewardImg"):setVisible(false)
end

function TrialRoadMainMediator:changeRoleImg(pos)
	local index = 1

	if pos >= 1 and pos <= 7 then
		index = 1
	elseif pos >= 8 and pos <= 11 then
		index = 2
	elseif pos >= 12 and pos <= 18 then
		index = 3
	elseif pos >= 19 and pos <= 22 then
		index = 4
	end

	local path = heroImg[index]

	self._role:loadTexture(path, ccui.TextureResType.plistType)

	if index == 1 then
		self._role:setScaleX(0.75)
	else
		self._role:setScaleX(-0.75)
	end
end

function TrialRoadMainMediator:initDice()
	self._diceAni = cc.MovieClip:create("shaizi_qianjinyadianna")

	self._diceAni:gotoAndStop(0)
	self._diceAni:addTo(self._Pright)
	self._diceAni:setPosition(cc.p(-280, 272))
end

function TrialRoadMainMediator:refreshDiceNum(reward)
	local diceNum = self._activity:getPoint()

	self._touchLayer:setVisible(true)
	self._diceAni:gotoAndPlay(1)
	AudioEngine:getInstance():playEffect("Se_Effect_Trial_Dice", false)
	self._diceAni:addEndCallback(function()
		self._diceAni:stop()

		local diceImg = self._diceAni:getChildByName("diceimg")

		if diceImg then
			diceImg:loadTexture("img_dice_" .. diceNum .. ".png", ccui.TextureResType.plistType)
			diceImg:setVisible(true)
		else
			local sp = ccui.ImageView:create("img_dice_" .. diceNum .. ".png", ccui.TextureResType.plistType)

			sp:addTo(self._diceAni):offset(-120, -10):setName("diceimg")
		end
	end)
	self._diceAni:runAction(cc.Sequence:create(cc.DelayTime:create(2), cc.CallFunc:create(function()
		self:refreshAthenaPos(diceNum, reward)
	end)))
end

function TrialRoadMainMediator:refreshAthenaMap()
	local mapData = self:sortmapData()
	local shengliAni = cc.MovieClip:create("shengli_qianjinyadianna")

	shengliAni:addTo(self._panel_di):offset(450, 360)
	shengliAni:addEndCallback(function()
		shengliAni:stop()
		shengliAni:removeFromParent()
	end)
	AudioEngine:getInstance():playEffect("Se_Effect_Trial_Celebrate", false)

	local scaleInfos = {
		TR_Dice = 0.35,
		TR_Girl = 0.8,
		TR_FuDai = 0.35,
		TR_HaiSeWei = 0.8
	}
	local offsets = {
		TR_Dice = cc.p(0, 3),
		TR_BaoXiang = cc.p(6, 8)
	}
	local animMaps = {
		TR_Transfer_2 = "chuansong_qianjinyadianna",
		TR_Transfer_1 = "chuansong_qianjinyadianna"
	}
	local tansportInfo = {}
	local tigger = self._activity:getTrigger()

	for i = 1, 22 do
		local eventPanel = self._mapVec[i]

		if i ~= 1 then
			local img = eventPanel:getChildByName("rewardImg")
			local chuansongAnim = eventPanel:getChildByName("chuansongAnim")

			if chuansongAnim then
				chuansongAnim:removeFromParent()
			end

			if img then
				local scale = cc.ScaleTo:create(img:getScale(), 0.01)
				local index = i

				local function call()
					local data = mapData[index]

					if tonumber(data) ~= 0 then
						local imgName = self._ElementData[data].Icon

						img:loadTexture(imgName .. ".png", ccui.TextureResType.plistType)
						img:setScale(scaleInfos[data] or 0.7)
						img:setVisible(true)

						img.isChuanSong = false

						if animMaps[data] then
							local chuansong = cc.MovieClip:create(animMaps[data])

							chuansong:addTo(eventPanel):offset(40, 50)
							chuansong:setName("chuansongAnim")
							img:setVisible(false)

							img.isChuanSong = true
							tansportInfo[#tansportInfo + 1] = i
						end
					elseif tigger then
						if tigger[tostring(index)] then
							local data = tigger[tostring(index)]
							local imgName = self._ElementData[data].Icon

							img:loadTexture(imgName .. ".png", ccui.TextureResType.plistType)
							img:setScale(scaleInfos[data] or 0.7)
							img:setVisible(true)

							img.isChuanSong = false

							if animMaps[data] then
								local chuansong = cc.MovieClip:create(animMaps[data])

								chuansong:addTo(eventPanel):offset(40, 50)
								chuansong:setName("chuansongAnim")
								img:setVisible(false)

								img.isChuanSong = true
								tansportInfo[#tansportInfo + 1] = i
							end
						end
					elseif tonumber(data) == 0 then
						img:setVisible(false)
					end
				end

				call()
			end
		end
	end

	self._transportMap = {}

	if #tansportInfo > 0 then
		self._transportMap[tostring(tansportInfo[1])] = tansportInfo[2]
		self._transportMap[tostring(tansportInfo[2])] = tansportInfo[1]
	end

	self:refreshBottomBox()
end

function TrialRoadMainMediator:refreshAthenaPos(diceNum, rewardData)
	local actionList = {}
	local that = self
	local time = 0.5

	for i = 1, diceNum do
		local pos = self._AthenaPos + i

		if pos > 22 then
			pos = pos - 22
		end

		local nextPos = self._mapVec[pos]
		local posx = nextPos:getPositionX()
		local posy = nextPos:getPositionY() + 40
		local prejump = cc.CallFunc:create(function()
			AudioEngine:getInstance():playEffect("Se_Effect_Trial_Jump", false)
		end)
		local dump = cc.JumpTo:create(time, cc.p(posx, posy), 50, 1)
		local call = cc.CallFunc:create(function()
			that:changeRoleImg(pos)

			local luoguo = cc.MovieClip:create("luoguo_qianjinyadianna")

			luoguo:addTo(nextPos):offset(40, 40)
			luoguo:addEndCallback(function()
				luoguo:removeFromParent()
			end)
			AudioEngine:getInstance():playEffect("Se_Effect_Trial_Land", false)
		end)

		if pos == 1 then
			local dump1 = cc.JumpTo:create(time, cc.p(posx, posy), 50, 1)
			local dump2 = cc.JumpTo:create(time, cc.p(posx, posy), 50, 1)
			local dump3 = cc.JumpTo:create(time, cc.p(posx, posy), 50, 1)
			local spawn = cc.Spawn:create(cc.Sequence:create(prejump, dump1, prejump, dump2, prejump, dump3), cc.CallFunc:create(function()
				that:refreshAthenaMap()
			end))

			actionList[i] = cc.Sequence:create(prejump, dump, call, spawn)
		else
			actionList[i] = cc.Sequence:create(prejump, dump, call)
		end
	end

	self._AthenaPos = self._AthenaPos + diceNum <= 22 and self._AthenaPos + diceNum or self._AthenaPos + diceNum - 22
	actionList[diceNum + 1] = cc.CallFunc:create(function()
		self._mapVec[self._AthenaPos]:getChildByName("rewardImg"):setVisible(false)
		self._touchLayer:setVisible(false)

		local rewardData = rewardData.reward

		if #rewardData > 0 then
			local isDice = false

			for i = 1, #rewardData do
				local reward = rewardData[i]

				if reward.code == "AG_DICE" then
					isDice = true
				end
			end

			if isDice then
				self:dispatch(ShowTipEvent({
					tip = Strings:get("AthenaGO_Tips_9")
				}))
			else
				local view = self:getInjector():getInstance("getRewardView")

				self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, nil, {
					rewards = rewardData
				}))
			end
		end

		local diceImg = self._diceAni:getChildByName("diceimg")

		diceImg:setVisible(false)
		self._diceAni:gotoAndStop(1)

		local rewards = self._activity:getRewardInfo()

		for k, reward in pairs(rewards) do
			if self._rewardsLabel[reward.code] then
				self._rewardsLabel[reward.code]:setString("x" .. reward.amount)
			end
		end
	end)
	actionList[#actionList + 1] = cc.CallFunc:create(function()
		local targetPos = self._transportMap[tostring(self._AthenaPos)]

		if not targetPos then
			return
		end

		local nextPos = self._mapVec[targetPos]
		local posx = nextPos:getPositionX()
		local posy = nextPos:getPositionY() + 40

		that:changeRoleImg(targetPos)
		self._role:setPosition(posx, posy)

		local orgRender = self._mapVec[self._AthenaPos]:getChildByName("chuansongAnim")

		if orgRender then
			orgRender:removeFromParent()
		end

		local targetRender = self._mapVec[targetPos]:getChildByName("chuansongAnim")

		if targetRender then
			targetRender:removeFromParent()
		end

		self._AthenaPos = targetPos
		self._transportMap = {}
	end)

	local trialRoad_Bubble = ConfigReader:requireDataByNameIdAndKey("ConfigValue", "TrialRoad_Bubble", "content")
	local tipsStr = trialRoad_Bubble[self._mapData[self._AthenaPos]]

	if tipsStr then
		actionList[#actionList + 1] = cc.CallFunc:create(function()
			self._tips:setScale(0)

			local actions = cc.Sequence:create(cc.ScaleTo:create(0.2, 1), cc.DelayTime:create(2), cc.ScaleTo:create(0.2, 0))

			self._tips:runAction(actions)
			self._tips:getChildByName("tips"):setString(Strings:get(tipsStr))

			local nextPos = self._mapVec[self._AthenaPos]
			local posx = nextPos:getPositionX()
			local posy = nextPos:getPositionY()

			self._tips:setPosition(posx + 20, posy)
		end)
	end

	local seq = cc.Sequence:create(actionList)

	self._role:runAction(seq)
end

function TrialRoadMainMediator:srotBoxState()
	local boxState = self._activity:getTreasureBox()
	local totalCycle = self._activity:getTotalCycleNum()
	local stateVec = {}

	for i = 1, #totalCycle do
		local state = 0

		for k, v in pairs(boxState) do
			if tonumber(k) == tonumber(totalCycle[i]) then
				state = v
			end
		end

		stateVec[totalCycle[i]] = state
	end

	return stateVec
end

function TrialRoadMainMediator:reckonCycle()
	local curlCycle = self._activity:getCycleNum()
	local count = 0
	local totalCycle = self._activity:getTotalCycleNum()

	for i = 1, #totalCycle do
		local cycle = totalCycle[i]

		if cycle <= curlCycle then
			count = count + 1
		end
	end

	return count / #totalCycle * 100
end

function TrialRoadMainMediator:refreshBottomBox()
	local rewardData = self._activity:getBoxRewardData()
	local percent = self:reckonCycle()
	local loadingBar = self._bottomPanel:getChildByName("progress_bar")
	local loadingbg = self._bottomPanel:getChildByName("progress_bg")

	loadingBar:setPercent(percent)

	local boxState = self:srotBoxState()

	loadingBar:removeAllChildren()

	local totalCycle = self._activity:getTotalCycleNum()

	for i = 1, 6 do
		self._bottomPanel:getChildByName("box_" .. i):setVisible(false)
	end

	self._BoxInfo = self._BoxInfo or {}

	for i = 1, #totalCycle do
		local index = totalCycle[i]
		local state = boxState[index]
		local panel = ccui.Layout:create()

		panel:setContentSize(cc.size(80, 80))
		panel:addTo(loadingBar)
		panel:setPosition(i / 6 * loadingbg:getContentSize().width - 40, 0)
		panel:setTouchEnabled(true)
		panel:setSwallowTouches(false)

		if not self._BoxInfo[index] then
			local cloneBox = self._bottomPanel:getChildByName("box_1"):clone()

			self._BoxInfo[index] = cloneBox

			cloneBox:addTouchEventListener(function(sender, eventType)
				if eventType == ccui.TouchEventType.ended then
					self:showBoxReward(self._BoxInfo[index].state, index, rewardData)
				end
			end)
			cloneBox:setTouchEnabled(true)
			cloneBox:setVisible(true)
			cloneBox:addTo(self._bottomPanel)
			cloneBox:setPosition(cc.p(35 + 184 * (i - 1), 31))

			local descLabel = cc.Label:createWithTTF(Strings:get("TrialRoad_Desc2", {
				num = totalCycle[i]
			}), TTF_FONT_FZYH_M, 22)

			descLabel:addTo(cloneBox, 10):center(cloneBox:getContentSize()):offset(-5, -22)
			descLabel:enableOutline(cc.c4b(0, 0, 0, 255), 2)
			descLabel:setScale(0.5)

			local redPoint = ccui.ImageView:create(IconFactory.redPointPath1, 1)

			redPoint:addTo(cloneBox):posite(30, 25):setScale(0.7)

			cloneBox.redPoint = redPoint

			redPoint:setVisible(false)
		end

		local normal = self._BoxInfo[index]:getChildByName("normal")
		local canReceive = self._BoxInfo[index]:getChildByName("canReceive")
		local hasReceive = self._BoxInfo[index]:getChildByName("hasReceive")

		normal:setVisible(state == 0)
		canReceive:setVisible(state == 1)
		hasReceive:setVisible(state == 2)

		self._BoxInfo[index].state = state

		self._BoxInfo[index].redPoint:setVisible(state == 1)
	end

	self._bottomPanel:getChildByName("progress_bg"):setContentSize(cc.size(184 * (#totalCycle - 1) - 40, 7))
	self._bottomPanel:getChildByName("progress_bar"):setContentSize(cc.size(184 * (#totalCycle - 1) - 40, 7))
	self._scrollView:setInnerContainerSize(cc.size(184 * #totalCycle - 80, 83))
	self._scrollView:setScrollBarEnabled(false)

	local currentActiveBox = 0

	for i = 1, #totalCycle do
		local index = totalCycle[i]
		local state = boxState[index]

		if state == 1 then
			currentActiveBox = i

			break
		end
	end

	if currentActiveBox > 6 then
		self._scrollView:scrollToPercentHorizontal((currentActiveBox - 6 + 2) / #totalCycle * 100, 0.2, true)
	end
end

local BoxState = {
	kCannotReceive = 0,
	kHasReceived = 2,
	kCanReceive = 1
}

function TrialRoadMainMediator:showBoxReward(state, index, rewardData)
	if state == BoxState.kCanReceive then
		local params = {
			doActivityType = 103,
			boxIndex = index
		}

		self._activitySystem:requestDoActivity3(self._activity:getId(), params, function(response)
			self:onDoActivityCallBack({
				param = params,
				response = response
			})
		end)
	else
		local info = {
			rewardId = rewardData.showReward,
			tips = Strings:get("TrialRoad_Tips_Desc"),
			hasGet = (state == 2 or nil) and true
		}
		local view = self:getInjector():getInstance("ActivityBoxView")

		self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
			transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
		}, info))
	end
end

function TrialRoadMainMediator:bindWidgets()
	self._btnRule:addTouchEventListener(function(sender, eventType)
		self:onClickRule(sender, eventType)
	end)
	self._btnReward:addTouchEventListener(function(sender, eventType)
		self:onClickReward(sender, eventType)
	end)
	self._btnBuy:addTouchEventListener(function(sender, eventType)
		self:onClickBuyTime(sender, eventType)
	end)
	self._btnRun:addTouchEventListener(function(sender, eventType)
		self:onClickDoActivity(sender, eventType)
	end)
end

function TrialRoadMainMediator:refreshConsume()
	self._labLastTime:setString(Strings:get("TrialRoad_Desc1", {
		num = self._activity:getLastTime()
	}))
	self._quanshu:setString(Strings:get("TrialRoad_Title3", {
		num = self._activity:getCycleNum()
	}))
end

function TrialRoadMainMediator:mapEventListeners()
	self.mapEventListener(self, self:getEventDispatcher(), "DEBUG_ROADWAY_FIXDICENUM", self, self.debugBox)
end

function TrialRoadMainMediator:doReset()
	self._activity = self._activitySystem:getActivityById(self._activityId)

	if not self._activity then
		self:dispatch(Event:new(EVT_POP_TO_TARGETVIEW, "homeView"))
	end
end

function TrialRoadMainMediator:adjustLayout(targetFrame)
	super.adjustLayout(self, targetFrame)

	local pos = self:getView():convertToNodeSpace(cc.p(targetFrame.x + targetFrame.width * 0.5, targetFrame.y + targetFrame.height * 0.5))

	self:getView():getChildByName("backgroundBG"):setPosition(pos)
end

function TrialRoadMainMediator:setupTopInfoWidget()
	local topInfoNode = self:getView():getChildByFullName("topinfo_node")
	local config = {
		style = 1,
		hasAnim = true,
		currencyInfo = self._activity:getResourcesBanner(),
		btnHandler = {
			clickAudio = "Se_Click_Close_1",
			func = bind1(self.onClickBack, self)
		},
		title = Strings:get("Activity_TrialRoad_Name")
	}
	local injector = self:getInjector()

	self._topInfoWidget = self:autoManageObject(injector:injectInto(TopInfoWidget:new(topInfoNode)))

	self._topInfoWidget:updateView(config)
end

function TrialRoadMainMediator:startTimer()
	if self._timer == nil then
		local timeText = self._labTime

		local function update()
			local remainTime = self._activitySystem:getActivityRemainTime(self._activityId) * 0.001

			remainTime = math.max(0, remainTime)

			timeText:setString(Strings:get("TrialRoad_Title1") .. TimeUtil:formatTime(Strings:get("TrialRoad_UI01"), remainTime))

			if remainTime == 0 then
				self._timer:stop()

				self._timer = nil

				delayCallByTime(0, function()
					self:dispatch(Event:new(EVT_POP_TO_TARGETVIEW, "homeView"))
				end)
			end
		end

		self._timer = LuaScheduler:getInstance():schedule(update, 1, true)

		update()
	end
end

function TrialRoadMainMediator:debugBox(event)
	local data = event:getData()
	local params = {
		doActivityType = 101
	}

	dump(data, "cdscdscdscds", 8)
	self._activitySystem:getActivityList():syncAloneActivity(self._activity:getId(), data.response.data, params.param)
	self:onDoActivityCallBack(data)
end

function TrialRoadMainMediator:onDoActivityCallBack(data)
	local response = data.response
	local param = data.param

	if param.doActivityType == 101 then
		self:refreshConsume()
		self:refreshDiceNum(response.data)
	elseif param.doActivityType == 102 then
		self:dispatch(ShowTipEvent({
			tip = Strings:get("AthenaGO_Tips_10")
		}))
		self:refreshConsume()
	elseif param.doActivityType == 103 then
		local rewardData = response.data
		local view = self:getInjector():getInstance("getRewardView")

		self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, nil, {
			rewards = rewardData.reward
		}))
		self:refreshBottomBox()
	elseif param.doActivityType == 104 then
		local data = response.data.getRewardInfo
		local view = self:getInjector():getInstance("AthenaGoRuleView")

		self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
			transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
		}, {
			isRule = false,
			rule = data
		}, nil))
	end
end

function TrialRoadMainMediator:onActivityResetCallBack()
	self:refreshConsume()
end

function TrialRoadMainMediator:onClickBack(sender, eventType)
	if eventType == ccui.TouchEventType.ended then
		self:dismiss("TrialRoadMainMediator dismiss")
	end
end

function TrialRoadMainMediator:onClickDoActivity(sender, eventType)
	if eventType == ccui.TouchEventType.ended then
		AudioEngine:getInstance():playEffect("Se_Click_Common_1", false)

		if self._activity:getLastTime() <= 0 then
			self:dispatch(ShowTipEvent({
				duration = 0.35,
				tip = Strings:get("TrialRoad_Error_82102")
			}))

			return
		end

		local params = {
			doActivityType = 101
		}

		self._activitySystem:requestDoActivity3(self._activity:getId(), params, function(response)
			self:onDoActivityCallBack({
				param = params,
				response = response
			})
		end)
	end
end

function TrialRoadMainMediator:checkCost()
	local bagSystem = self._developSystem:getBagSystem()
	local cost = self._activity:getCost()

	if not cost.count then
		self:dispatch(ShowTipEvent({
			tip = Strings:get("AthenaGO_Tips_2")
		}))

		return
	end

	if bagSystem:checkCostEnough(cost.type, cost.count, {
		type = "alert"
	}) then
		local params = {
			doActivityType = 102
		}
		local outSelf, delegate = self, {}

		function delegate:willClose(popupMediator, data)
			if data.response == "ok" then
				-- block empty
			end
		end

		local count, lastTime = self._activity:getCountLastTime()
		local data = {
			desStr = "Arena_Challenge_Left_Time",
			title = Strings:get("OpenMusic_Text_2"),
			content = Strings:get("Ninja_Buy", {
				count = 1,
				num = cost.count,
				fontName = DEFAULT_TTF_FONT
			}),
			sureBtn = {},
			cancelBtn = {},
			cocalCount = count,
			lastTime = lastTime
		}

		self:showAlertView(data, function()
			self._activitySystem:requestDoActivity(self._activity:getId(), params)
		end)
	end
end

function TrialRoadMainMediator:showAlertView(data, okCallback)
	local outSelf, delegate = self, {}

	function delegate:willClose(popupMediator, data)
		if data.response == AlertResponse.kOK and okCallback then
			okCallback()
		end
	end

	local view = self:getInjector():getInstance("alertView")

	self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
		transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
	}, data, delegate))
end

function TrialRoadMainMediator:onClickRule(sender, eventType)
	if eventType == ccui.TouchEventType.ended then
		local rules = self._activity:getActivityConfig().RuleDesc

		self._activitySystem:showActivityRules(rules)
	end
end

function TrialRoadMainMediator:onClickBuyTime(sender, eventType)
	if eventType == ccui.TouchEventType.ended then
		AudioEngine:getInstance():playEffect("Se_Click_Common_1", false)
		self:checkCost()
	end
end

function TrialRoadMainMediator:onClickReward(sender, eventType)
	if eventType == ccui.TouchEventType.ended then
		AudioEngine:getInstance():playEffect("Se_Click_Common_1", false)

		local params = {
			doActivityType = 104
		}

		self._activitySystem:requestDoActivity(self._activity:getId(), params)
	end
end
