-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/activity/view/ActivityBentoMediator.lua

ActivityBentoMediator = class("ActivityBentoMediator", DmAreaViewMediator, _M)

ActivityBentoMediator:has("_activitySystem", {
	is = "r"
}):injectWith("ActivitySystem")
ActivityBentoMediator:has("_gameServerAgent", {
	is = "r"
}):injectWith("GameServerAgent")
ActivityBentoMediator:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")

local kBtnHandlers = {
	["main.btn_task"] = {
		clickAudio = "Se_Click_Common_2",
		func = "onClickTask"
	},
	["main.btn_bag"] = {
		clickAudio = "Se_Click_Common_2",
		func = "onClickBag"
	},
	["main.btn_cook"] = {
		clickAudio = "Se_Click_Common_2",
		func = "onClickCook"
	},
	["main.btn_rule"] = {
		clickAudio = "Se_Click_Common_2",
		func = "onClickRule"
	},
	Panel_guide = {
		ignoreClickAudio = true,
		func = "onClickGuide"
	}
}

function ActivityBentoMediator:initialize()
	super.initialize(self)
end

function ActivityBentoMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(kBtnHandlers)

	self._main = self:getView():getChildByName("main")
	self._foodPanel = self._main:getChildByName("Panel_food")
	self._materialPanel = self._main:getChildByName("Panel_Material")
	self._materialCell = self._materialPanel:getChildByName("material")

	self._materialCell:setVisible(false)

	self._cookTips = self._main:getChildByName("cooktips")

	self._cookTips:setVisible(false)

	local bg = self._main:getChildByName("Imagebg")

	CustomShaderUtils.setBlurToNode(bg, 10, 10)

	self._guidePanel = self:getView():getChildByName("Panel_guide")

	self._guidePanel:setLocalZOrder(10000)

	self._cookBtn = self._main:getChildByName("btn_cook")
end

function ActivityBentoMediator:setupTopInfoWidget()
	local topInfoNode = self:getView():getChildByFullName("topinfo_node")

	topInfoNode:setLocalZOrder(1001)

	local config = {
		style = 1,
		title = Strings:get(self._activity:getTitle()),
		btnHandler = {
			clickAudio = "Se_Click_Close_1",
			func = bind1(self.dismiss, self)
		}
	}
	local injector = self:getInjector()

	self._topInfoWidget = self:autoManageObject(injector:injectInto(TopInfoWidget:new(topInfoNode)))

	self._topInfoWidget:updateView(config)
end

function ActivityBentoMediator:enterWithData(data)
	self._activityId = data.activityId
	self._activity = self._activitySystem:getActivityById(self._activityId)
	self._bagSystem = self._developSystem:getBagSystem()

	if not self._activity then
		return
	end

	self._selectFoodId = nil
	self._materialCells = {}
	self._finishFoodCount = 0

	self:setupTopInfoWidget()
	self:initFoodScene()
	self:refreshFoodAndMaterialPanel()
	self:refreshRedPoint()
	self:mapEventListeners()
	self:initGuidePanel()
	self:initAnim()

	local text = self._main:getChildByName("Text_time")

	text:setString(Strings:get("ActivityBlock_UI_17", {
		time = self._activity:getTimeStr1()
	}))
	text:enableOutline(cc.c4b(0, 0, 0, 61), 1)
end

function ActivityBentoMediator:mapEventListeners()
	self.mapEventListener(self, self:getEventDispatcher(), EVT_ACTIVITY_REDPOINT_REFRESH, self, self.refreshRedPoint)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_PLAYER_SYNCHRONIZED, self, self.refreshViewByResChange)
end

function ActivityBentoMediator:refreshViewByResChange()
	if self._cooking then
		return
	end

	self:refreshFoodScene()
	self:refreshFoodAndMaterialPanel()
end

function ActivityBentoMediator:refreshRedPoint()
	local redPoint = self._main:getChildByFullName("btn_task.redPoint")

	redPoint:setVisible(self._activity:hasRewardToGet())
end

function ActivityBentoMediator:isMaterialEnough(foodId)
	local map = self._activity:getFoodMaterial()

	if map[foodId] then
		local enough = true

		for k, v in pairs(map[foodId]) do
			local count = self._bagSystem:getItemCount(k)

			if count < v then
				enough = false
			end
		end

		return enough
	end
end

function ActivityBentoMediator:initFoodScene()
	local sceneImg = self._main:getChildByName("Image_scene")
	local path = self._activity:getBmg()

	sceneImg:loadTexture("asset/scene/" .. path .. ".jpg")

	local size = sceneImg:getContentSize()
	local foodPos = self._activity:getFoodPos()

	self._foods = {}

	local foodList = {}

	for k, v in pairs(foodPos) do
		local iconImg = ccui.ImageView:create(v.icon .. ".png", 1)

		iconImg:setAnchorPoint(cc.p(0, 0))
		iconImg:addTo(sceneImg):posite(v.pos[1], size.height - v.pos[2])
		iconImg:setTouchEnabled(true)

		local function callFunc()
			self:onFoodClicked(k)
		end

		mapButtonHandlerClick(nil, iconImg, {
			func = callFunc
		})

		local lineImg = ccui.ImageView:create(v.line .. ".png", 1)

		lineImg:setAnchorPoint(cc.p(0, 0))
		lineImg:addTo(sceneImg):posite(v.pos[1], size.height - v.pos[2])

		if v.diImg then
			local diImg = ccui.ImageView:create(v.diImg .. ".png", 1)

			diImg:setAnchorPoint(cc.p(0, 0))
			diImg:addTo(sceneImg):posite(v.pos[1] - 98, size.height - v.pos[2] - 38)
			diImg:setLocalZOrder(v.zorder)
		end

		iconImg:setLocalZOrder(v.zorder)
		lineImg:setLocalZOrder(v.zorder)

		local data = {
			iconImg = iconImg,
			lineImg = lineImg,
			pos = cc.p(iconImg:getPosition()),
			id = k
		}

		self._foods[k] = data
		foodList[#foodList + 1] = data
	end

	self:refreshFoodScene()
	table.sort(foodList, function(a, b)
		return a.id < b.id
	end)

	for i, v in pairs(foodList) do
		self:setFoodHittingShape(v.iconImg, i)
	end
end

function ActivityBentoMediator:setFoodHittingShape(icon, index)
	local verticesMap = {
		{
			cc.p(0, 17),
			cc.p(46, 0),
			cc.p(88, 17),
			cc.p(60, 45)
		},
		{
			cc.p(7, 19),
			cc.p(25, 6),
			cc.p(103, 20),
			cc.p(84, 40)
		},
		{
			cc.p(7, 32),
			cc.p(89, 6),
			cc.p(124, 24),
			cc.p(28, 56)
		},
		{
			cc.p(0, 0),
			cc.p(155, 0),
			cc.p(155, 60),
			cc.p(0, 60)
		},
		{
			cc.p(0, 0),
			cc.p(239, 0),
			cc.p(239, 87),
			cc.p(0, 87)
		},
		{
			cc.p(7, 16),
			cc.p(72, 6),
			cc.p(104, 22),
			cc.p(104, 45),
			cc.p(48, 56),
			cc.p(7, 40)
		},
		{
			cc.p(7, 26),
			cc.p(56, 6),
			cc.p(124, 19),
			cc.p(124, 46),
			cc.p(56, 66),
			cc.p(7, 52)
		}
	}
	local shape = ccui.HittingPolygon:create(verticesMap[index])

	icon:setHittingShape(shape)
end

function ActivityBentoMediator:refreshFoodScene()
	self._finishFoodCount = 0

	for k, v in pairs(self._foods) do
		local count = self._bagSystem:getItemCount(k)

		if count == 0 then
			v.iconImg:setColor(cc.c3b(0, 0, 0))
		else
			v.iconImg:setColor(cc.c3b(255, 255, 255))

			self._finishFoodCount = self._finishFoodCount + 1
		end

		v.lineImg:setVisible(self:isMaterialEnough(k))
	end
end

function ActivityBentoMediator:resumeWithData(data)
	return
end

function ActivityBentoMediator:refreshFoodAndMaterialPanel()
	local foodNameDi = self._foodPanel:getChildByName("Image_name")
	local foodNameText = self._foodPanel:getChildByName("Text_name")
	local bubblePanel = self._foodPanel:getChildByName("Image_bubble")
	local iconDi = self._foodPanel:getChildByName("Image_di")

	iconDi:removeAllChildren()

	local tipsText = self._materialPanel:getChildByName("Text_tips")

	for i, v in pairs(self._materialCells) do
		v:setVisible(false)
	end

	if self._selectFoodId then
		bubblePanel:setVisible(false)
		foodNameDi:setVisible(true)
		foodNameText:setVisible(true)
		tipsText:setVisible(false)

		local config = ConfigReader:getRecordById("ItemConfig", self._selectFoodId)

		foodNameText:setString(Strings:get(config.Name))

		local icon = IconFactory:createItemPic({
			id = self._selectFoodId
		})

		icon:addTo(iconDi):center(iconDi:getContentSize()):setName("iconImg")
		icon:setScale(1.3)
		icon:setColor(cc.c3b(0, 0, 0))

		local materials = self._activity:getFoodMaterial()

		if materials[self._selectFoodId] then
			local index = 0
			local count = table.nums(materials[self._selectFoodId])
			local initPos = 110 - (count - 1) * 40

			for materialId, needCount in pairs(materials[self._selectFoodId]) do
				index = index + 1

				local itemCell = self._materialCells[index]

				if not itemCell then
					itemCell = self._materialCell:clone()

					itemCell:addTo(self._materialPanel)

					self._materialCells[#self._materialCells + 1] = itemCell
				end

				itemCell:setVisible(true)
				itemCell:posite(initPos + (index - 1) * 80, 4)

				local config = ConfigReader:getRecordById("ItemConfig", materialId)
				local nameText = itemCell:getChildByName("Text_name")

				nameText:setString(Strings:get(config.Name) .. "x" .. needCount)

				local iconDi = itemCell:getChildByName("Image_225")

				iconDi:removeAllChildren()

				local icon = IconFactory:createItemPic({
					id = materialId
				})

				icon:addTo(iconDi):center(iconDi:getContentSize())
				icon:setScale(0.6)

				local bagCount = self._bagSystem:getItemCount(materialId)
				local tipsText = itemCell:getChildByName("Panel_tips")

				tipsText:setVisible(bagCount < needCount)

				local enoughImg = itemCell:getChildByName("Image_enough")

				enoughImg:setVisible(needCount <= bagCount)
			end
		end
	else
		bubblePanel:setVisible(true)
		foodNameDi:setVisible(false)
		foodNameText:setVisible(false)
		tipsText:setVisible(true)

		local img = cc.Sprite:create("asset/story/guidequanmask.png")

		img:setAnchorPoint(0.5, 0.5)
		img:setScale(0.91)

		local clippingNode = cc.ClippingNode:create(img)

		clippingNode:setAlphaThreshold(0.1)
		img:setPosition(0, 0)
		clippingNode:addTo(iconDi, 4):center(iconDi:getContentSize())

		local heroId = self._activity:getShowHero()
		local roleModel = IconFactory:getRoleModelByKey("HeroBase", heroId)
		local heroImg = IconFactory:createRoleIconSpriteNew({
			id = roleModel
		})

		heroImg:setScale(0.65)
		heroImg:addTo(clippingNode, 4):center(clippingNode:getContentSize())
	end
end

function ActivityBentoMediator:showCookTips(str)
	self._cookTips:setVisible(true)
	self._cookTips:getChildByName("Text_str"):setString(str)
	self._cookTips:setOpacity(0)

	local action = cc.FadeIn:create(0.3)
	local action2 = cc.DelayTime:create(1)
	local action3 = cc.FadeOut:create(0.3)

	self._cookTips:runAction(cc.Sequence:create(action, action2, action3))
end

function ActivityBentoMediator:initGuidePanel()
	local customDataSystem = self:getInjector():getInstance("CustomDataSystem")
	local customKey = "Guide" .. self._activity:getId()
	local customValue = customDataSystem:getValue(PrefixType.kGlobal, customKey)

	if customValue then
		self._guidePanel:setVisible(false)

		return
	end

	self._guidePanel:setVisible(true)
	customDataSystem:setValue(PrefixType.kGlobal, customKey, true)

	local heroId = self._activity:getShowHero()
	local roleModel = IconFactory:getRoleModelByKey("HeroBase", heroId)
	local info = {
		useAnim = true,
		frameId = "bustframe9",
		id = roleModel
	}
	local heroNode = self._guidePanel:getChildByName("Node_hero")
	local heroImg = IconFactory:createRoleIconSpriteNew(info)

	heroImg:addTo(heroNode):posite(100, 50)
	heroImg:setScale(0.5)

	self._guideStrList = self._activity:getGuideText()
	self._guideText = self._guidePanel:getChildByName("Text_str")

	self._guideText:setString(Strings:get(self._guideStrList[1]))

	self._guideIndex = 1
end

function ActivityBentoMediator:initAnim()
	self._cookAnim = cc.MovieClip:create("guo_biandangwushi")

	self._cookAnim:addTo(self._cookBtn):center(self._cookBtn:getContentSize()):offset(-2, -4)
	self._cookAnim:gotoAndStop(1)
end

function ActivityBentoMediator:onClickTask()
	local view = self:getInjector():getInstance("ActivityBentoPopupView")

	self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {}, {
		tabType = 1,
		activityId = self._activityId
	}))
end

function ActivityBentoMediator:onClickBag()
	local view = self:getInjector():getInstance("ActivityBentoPopupView")

	self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {}, {
		tabType = 2,
		activityId = self._activityId
	}))
end

function ActivityBentoMediator:onClickCook()
	if self._cooking then
		return
	end

	if not self._selectFoodId then
		self:showCookTips(Strings:get("Bento_Main_Tips4"))

		return
	end

	if not self:isMaterialEnough(self._selectFoodId) then
		self:showCookTips(Strings:get("Bento_Main_Tips7"))

		return
	end

	local params = {
		doActivityType = 102,
		cate = self._selectFoodId
	}

	self._cooking = true

	self._activitySystem:requestDoActivity(self._activityId, params, function(response)
		if not checkDependInstance(self) then
			return
		end

		AudioEngine:getInstance():playEffect("Se_Effect_Bento_Cooking", false)

		local cookImg = self._cookBtn:getChildByName("Image_cook")

		cookImg:setVisible(false)
		self._cookAnim:setVisible(true)
		self._cookAnim:gotoAndPlay(1)
		self._cookAnim:addEndCallback(function()
			self._cookAnim:stop()
			self._cookAnim:clearCallbacks()
			self._cookAnim:setVisible(false)
			cookImg:setVisible(true)
		end)

		local iconDi = self._foodPanel:getChildByName("Image_di")
		local icon = iconDi:getChildByName("iconImg")

		icon:setLocalZOrder(10)

		local iconDi = self._foodPanel:getChildByName("Image_di")
		local foodAnim = cc.MovieClip:create("finish_biandangwushi")

		foodAnim:addTo(iconDi):center(iconDi:getContentSize())
		foodAnim:addEndCallback(function()
			foodAnim:stop()
			foodAnim:removeFromParent()
		end)

		local delayAction = cc.DelayTime:create(0.5)
		local action1 = cc.TintTo:create(0.3, cc.c4b(255, 255, 255, 255))
		local foodData = self._foods[self._selectFoodId]
		local wordPos = foodData.iconImg:getParent():convertToWorldSpace(foodData.pos)
		local size = foodData.iconImg:getContentSize()
		local realPos = iconDi:convertToNodeSpace(wordPos)
		local delayAction2 = cc.DelayTime:create(1.2)
		local action2 = cc.MoveTo:create(1, cc.p(realPos.x + size.width * 0.5, realPos.y + size.height * 0.5))
		local action3 = cc.CallFunc:create(function()
			self._cooking = false
			self._selectFoodId = nil

			self:refreshFoodScene()
			self:refreshFoodAndMaterialPanel()
			self:showCookTips(Strings:get("Bento_Main_Tips5"))
		end)

		icon:runAction(cc.Sequence:create(delayAction, action1, delayAction2, action2, action3))
	end)
end

function ActivityBentoMediator:onFoodClicked(foodId)
	if self._cooking then
		return
	end

	self._selectFoodId = foodId

	self:refreshFoodAndMaterialPanel()
end

function ActivityBentoMediator:onClickRule()
	local rules = self._activity:getRuleDesc()

	self._activitySystem:showActivityRules(rules, nil, {})
end

function ActivityBentoMediator:onClickGuide()
	if not self._guideIndex then
		self._guidePanel:setVisible(false)

		return
	end

	self._guideIndex = self._guideIndex + 1

	if self._guideStrList[self._guideIndex] then
		self._guideText:setString(Strings:get(self._guideStrList[self._guideIndex]))
	else
		self._guidePanel:setVisible(false)
	end
end
