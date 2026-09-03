-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/spStage/view/SpStageSweepMediator.lua

SpStageSweepMediator = class("SpStageSweepMediator", DmPopupViewMediator, _M)

SpStageSweepMediator:has("_spStageSystem", {
	is = "r"
}):injectWith("SpStageSystem")

local kMaxshowIconCount = 5
local kIconWigth = 133
local kBtnHandlers = {}

function SpStageSweepMediator:initialize()
	super.initialize(self)
end

function SpStageSweepMediator:dispose()
	super.dispose(self)
end

function SpStageSweepMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(kBtnHandlers)
	self:initWigetInfo()

	self._stageId = {}

	local spStageIndex = self._spStageSystem:getSpStageSort()

	for index, v in pairs(spStageIndex) do
		self._stageId[v] = index
	end
end

function SpStageSweepMediator:initWigetInfo()
	self._main = self:getView():getChildByName("main")
	self._goldPanel = self._main:getChildByName("goldPanel")

	self._goldPanel:setOpacity(0)

	self._iconPanel = self._main:getChildByName("iconpanel")

	self._iconPanel:setLocalZOrder(10)

	self.canTouchNext = false

	local touchLayer = self:getView():getChildByName("touch_layer")

	touchLayer:addClickEventListener(function()
		if self.canTouchNext then
			self:onClickOk()
		end
	end)
end

function SpStageSweepMediator:enterWithData(data)
	self._spStageModel = self._spStageSystem:getModel()
	self._stageList = self._spStageModel:getStageList()
	self._data = data
	self._goldNum = 0
	self._rewards = {}

	for i = 1, 3 do
		local k = self._stageId[i]
		local v = self._data[k]

		if v then
			self._rewards = v.rewards["1"]
		end
	end

	self._callback = data.callback or nil

	if table.nums(self._rewards) == 0 then
		self.canTouchNext = true

		return
	end

	local rewardsNow = {}
	local filter = ConfigReader:getDataByNameIdAndKey("ConfigValue", "Activity_Point_Hide", "content")

	for i = 1, table.nums(self._rewards) do
		if self._rewards[i] and self._rewards[i].code then
			local code = self._rewards[i].code

			for kf, vf in pairs(filter) do
				if code ~= vf then
					rewardsNow[#rewardsNow + 1] = self._rewards[i]
				end
			end
		end
	end

	self._rewards = rewardsNow

	if table.nums(self._rewards) == 0 then
		self.canTouchNext = true

		return
	end

	self._rewardIndex = 1
	self._maxGroupCount = math.ceil(#self._rewards / kMaxshowIconCount)
	self._curGroupIndex = 1

	self:setupView()
end

function SpStageSweepMediator:setupView()
	AudioEngine:getInstance():playEffect("Se_Alert_Reward", false)
	self:showGetRewardAnim()
end

function SpStageSweepMediator:getCurShowRewardCount()
	if self._curGroupIndex < self._maxGroupCount then
		return kMaxshowIconCount
	elseif #self._rewards % kMaxshowIconCount == 0 then
		return kMaxshowIconCount
	else
		return #self._rewards % kMaxshowIconCount
	end
end

function SpStageSweepMediator:showGetRewardAnim()
	local animNode = self:getView():getChildByFullName("main.animNode")
	local anim = cc.MovieClip:create("zonghe_gongxihuode")

	anim:setPlaySpeed(1.5)
	anim:addTo(animNode, 1)
	anim:addCallbackAtFrame(60, function()
		anim:stop()
		anim:gotoAndPlay(45)
	end)
	anim:addCallbackAtFrame(10, function()
		local title = anim:getChildByName("title")
		local titleNode = title:getChildByName("node")
		local image = ccui.ImageView:create("zyfb_sdcg.png", 1)

		image:addTo(titleNode)
		title:addCallbackAtFrame(12, function()
			title:stop()
		end)

		if self._goldNum > 0 then
			local gold = self._goldPanel:getChildByFullName("gold")
			local text = self._goldPanel:getChildByFullName("text")

			text:setString(self._goldNum)
			gold:setPositionX(text:getPositionX() - text:getContentSize().width / 2 + 5)
			self._goldPanel:fadeIn({
				time = 0.5
			})
		end
	end)
	anim:addCallbackAtFrame(21, function()
		self:showOneIcon(1)
	end)
end

function SpStageSweepMediator:showOneIcon(index)
	self._rewardIndex = index + (self._curGroupIndex - 1) * kMaxshowIconCount

	local baseNode = cc.Node:create()

	self._iconPanel:addChild(baseNode)

	local rewardData = self._rewards[self._rewardIndex]
	local anim = cc.MovieClip:create("icon_group_gongxihuode")

	anim:setPlaySpeed(1.5)
	anim:setPosition(cc.p(-8, 27))
	baseNode:addChild(anim, 2)
	anim:addCallbackAtFrame(5, function()
		local iconNode = cc.Node:create()

		baseNode:addChild(iconNode)

		local icon = IconFactory:createRewardIcon(rewardData, {
			isWidget = true
		})

		icon:addTo(iconNode, 1):center(iconNode:getContentSize()):offset(0, 30)
		IconFactory:bindTouchHander(icon, IconTouchHandler:new(self), rewardData, {
			needDelay = true
		})

		local nameText = cc.Label:createWithTTF(RewardSystem:getName(rewardData), TTF_FONT_FZYH_M, 18)

		nameText:setAnchorPoint(cc.p(0.5, 1))
		nameText:enableOutline(cc.c4b(0, 0, 0, 127), 2)
		nameText:addTo(iconNode):center(iconNode:getContentSize()):offset(0, -35)
		GameStyle:setQualityText(nameText, RewardSystem:getQuality(rewardData))
		nameText:setMaxLineWidth(135)
		AudioEngine:getInstance():playEffect("Se_Alert_Common_Gain")
	end)
	anim:addEndCallback(function()
		anim:stop()
		anim:setVisible(false)

		if index >= self:getCurShowRewardCount() then
			self.canTouchNext = true
		end
	end)

	local initX = self._iconPanel:getContentSize().width / 2 - (self:getCurShowRewardCount() - 1) * 0.5 * kIconWigth

	baseNode:setPosition(cc.p(initX + (index - 1) * kIconWigth, 35))

	local frame = {
		2,
		2,
		3,
		2,
		2
	}

	anim:addCallbackAtFrame(frame[index], function()
		if rewardData.type == 3 then
			self:showNewHeroView(rewardData.code, function()
				if index < self:getCurShowRewardCount() then
					index = index + 1

					self:showOneIcon(index)
				end
			end)
		elseif index < self:getCurShowRewardCount() then
			index = index + 1

			self:showOneIcon(index)
		end
	end)
end

function SpStageSweepMediator:showNewHeroView(heroId, callback)
	local view = self:getInjector():getInstance("newHeroView")

	self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, nil, {
		heroId = heroId,
		callback = callback
	}))
end

function SpStageSweepMediator:onClickOk()
	if self._curGroupIndex and self._maxGroupCount and self._curGroupIndex < self._maxGroupCount then
		self._iconPanel:removeAllChildren(true)

		self._curGroupIndex = self._curGroupIndex + 1

		self:showOneIcon(1)

		self.canTouchNext = false
	else
		local function func()
			self:close()
		end

		if self._callback then
			self._callback(func)
		else
			func()
		end
	end
end
