-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/miniGame/view/plane/PlaneWarStageWinMediator.lua

PlaneWarStageWinMediator = class("PlaneWarStageWinMediator", DmPopupViewMediator, _M)

PlaneWarStageWinMediator:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")
PlaneWarStageWinMediator:has("_gameServer", {
	is = "r"
}):injectWith("GameServerAgent")
PlaneWarStageWinMediator:has("_miniGameSystem", {
	is = "r"
}):injectWith("MiniGameSystem")

function PlaneWarStageWinMediator:initialize()
	super.initialize(self)
end

function PlaneWarStageWinMediator:dispose()
	super.dispose(self)
end

function PlaneWarStageWinMediator:userInject()
	return
end

function PlaneWarStageWinMediator:onRegister()
	super.onRegister(self)
end

function PlaneWarStageWinMediator:bindWidgets()
	return
end

function PlaneWarStageWinMediator:adjustLayout(targetFrame)
	super.adjustLayout(self, targetFrame)
end

function PlaneWarStageWinMediator:enterWithData(data)
	snkAudio.play("Mus_Tuweizhan_3")

	self._data = data
	self._planeWarActivity = self._miniGameSystem:getPlaneWarSystem():getPlaneWarActivity()
	self._canTouch = false
	self._mainPanel = self:getView():getChildByFullName("main")

	local mainAnim = cc.MovieClip:create("win2_twjiesuan")
	local config = self._data.pointConfig
	local stageType = config.Type
	local gameEvn

	if stageType == StageType.kElite then
		gameEvn = ResourceDoubleActivityEvn.kElite
	elseif stageType == StageType.kMain then
		gameEvn = ResourceDoubleActivityEvn.kNormal
	end

	if gameEvn then
		local activitySystem = self:getInjector():getInstance(ActivitySystem)
		local resourceDoubleSystem = activitySystem:getResourceDoubleActivitySystem()

		self._resourceDoubleData = resourceDoubleSystem:getDoubleResConfigByEvn({
			gameEvn
		})
	end

	mainAnim:setPosition(display.center)
	mainAnim:addEndCallback(function(cid, mc)
		self._canTouch = true

		mc:stop()
	end)
	mainAnim:addTo(self._mainPanel, 10):center(self._mainPanel:getContentSize()):offset(-10, 5)

	local winSize = cc.Director:getInstance():getWinSize()
	local oldtouchLayer = self:getView():getChildByTag(1234)

	if oldtouchLayer then
		oldtouchLayer:removeFromParent(true)
	end

	local touchLayer = ccui.Layout:create()

	touchLayer:setTag(1234)
	touchLayer:setTouchEnabled(true)
	touchLayer:setContentSize(cc.size(winSize.width, winSize.height))
	touchLayer:addTo(self:getView()):center(self:getView():getContentSize())
	touchLayer:setLocalZOrder(100)
	touchLayer:addTouchEventListener(function(sender, eventType)
		if eventType == ccui.TouchEventType.ended then
			self:onTouchMaskLayer()
		end
	end)

	self._rewardPanel = self._mainPanel:getChildByFullName("rewardimg")

	self._rewardPanel:setLocalZOrder(11)
	self._rewardPanel:setVisible(false)

	self._rewardNode = cc.Node:create()

	self._rewardNode:addTo(self._rewardPanel):center(self._rewardPanel:getContentSize())
	self:bindWidget("main.okbtn", TwoLevelMainButton, {
		handler = bind1(self.onOkClicked, self)
	})

	local starPanel = self._mainPanel:getChildByFullName("star_panel")

	starPanel:setLocalZOrder(11)

	local condLabels = {}

	condLabels[1] = starPanel:getChildByName("condition_text_1")
	condLabels[2] = starPanel:getChildByName("condition_text_2")
	condLabels[3] = starPanel:getChildByName("condition_text_3")

	for i = 1, 3 do
		if condLabels[i] then
			local condLabelBg = cc.Sprite:createWithSpriteFrameName("di_twjiesuanimage.png")

			condLabelBg:addTo(starPanel):setPosition(condLabels[i]:getPosition())
			condLabelBg:setLocalZOrder(condLabels[i]:getLocalZOrder() - 1)
		end
	end

	local starNodes = {}

	starNodes[1] = starPanel:getChildByName("star_1")
	starNodes[2] = starPanel:getChildByName("star_2")
	starNodes[3] = starPanel:getChildByName("star_3")

	starPanel:setVisible(true)

	for index, v in pairs(data.condText) do
		local desc = Strings:get(v.desc, {
			num = v.score,
			bossName = data.bossName
		})

		if data.pointConfig then
			local t = TextTemplate:new(desc)

			desc = t:stringify(data.pointConfig, {
				convertToS = function(value)
					return value * 0.001
				end
			})
		end

		condLabels[index]:setString(desc)
		starNodes[index]:loadTexture("jiesuan_img_star01.png", ccui.TextureResType.plistType)
	end

	for i, v in pairs(data.star) do
		starNodes[v]:loadTexture("asset/ui/common/jiesuan_img_star.png", 0)
	end

	local starNum = #data.condText

	if starNum and starNum == 1 then
		starNodes[2]:setVisible(false)
		starNodes[3]:setVisible(false)
		condLabels[2]:setVisible(false)
		condLabels[3]:setVisible(false)
		starNodes[1]:setPositionX(starNodes[2]:getPositionX())
		condLabels[1]:setPositionX(condLabels[2]:getPositionX())
	elseif starNum and starNum == 2 then
		starNodes[3]:setVisible(false)
		condLabels[3]:setVisible(false)
		starNodes[1]:setPositionX(starNodes[1]:getPositionX() + 50)
		condLabels[1]:setPositionX(condLabels[1]:getPositionX() + 50)
		starNodes[2]:setPositionX(starNodes[2]:getPositionX() + 50)
		condLabels[2]:setPositionX(condLabels[2]:getPositionX() + 50)
	end

	if data.rewards then
		self:refreshRewards(data.rewards)
	end
end

function PlaneWarStageWinMediator:refreshRewards(rewards)
	self._rewardPanel:setVisible(true)

	local width = 0
	local index = 0

	for i = 1, #rewards do
		local icon = IconFactory:createRewardIcon(rewards[i], {
			isWidget = true
		})

		icon:setScale(0.8)
		icon:addTo(self._rewardNode):posite(-50 + (index - 1) * 121, -74)
		IconFactory:bindTouchHander(icon, IconTouchHander:new(self), rewards[i], {
			needDelay = true
		})

		if self._resourceDoubleData then
			icon:setResourceDouble(self._resourceDoubleData.rate)
		end

		index = index + 1
		width = width + icon:getContentSize().width * 0.8
	end

	if #rewards == 3 then
		self._rewardNode:posite(230 - width / 2 - 15)
	elseif #rewards == 4 then
		self._rewardNode:posite(230 - width / 2 - 25)
	else
		self._rewardNode:posite(230 - width / 2)
	end
end

function PlaneWarStageWinMediator:onTouchMaskLayer()
	if not self._canTouch then
		return
	end

	self:onOkClicked(nil, ccui.TouchEventType.ended)
end

function PlaneWarStageWinMediator:onOkClicked(sender, eventType)
	if eventType == ccui.TouchEventType.ended then
		local storyDirector = self:getInjector():getInstance(story.StoryDirector)

		storyDirector:notifyWaiting("exit_minigame_win_view")
		self:dispatch(Event:new(EVT_PLANEWAR_STAGE_CLOSE, {}))

		local currentScene = self:getCurrentSceneMediator()
		local sceneName = currentScene:getViewName()

		if sceneName == "battleScene" then
			local config = self._data.pointConfig
			local stageType = config.Type
			local data = {
				viewName = "stageView",
				stageType = stageType,
				mapId = config.Map,
				showPass = stageType == StageType.kMain
			}

			self:dispatch(SceneEvent:new(EVT_SWITCH_SCENE, "mainScene", nil, data))
		end

		self:close()
	end
end
