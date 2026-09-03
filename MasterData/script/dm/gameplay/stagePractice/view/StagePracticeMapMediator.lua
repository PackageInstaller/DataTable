-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/stagePractice/view/StagePracticeMapMediator.lua

StagePracticeMapMediator = class("StagePracticeMapMediator", DmAreaViewMediator, _M)

StagePracticeMapMediator:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")
StagePracticeMapMediator:has("_stagePracticeSystem", {
	is = "r"
}):injectWith("StagePracticeSystem")

local kBtnHandlers = {}
local kNodeWigth = 354

function StagePracticeMapMediator:initialize()
	super.initialize(self)

	self._newMessages = {}
end

function StagePracticeMapMediator:dispose()
	super.dispose(self)

	if self._topInfoWidget then
		self._topInfoWidget:dispose()

		self._topInfoWidget = nil
	end
end

function StagePracticeMapMediator:userInject()
	self._systemKeeper = self:getInjector():getInstance(SystemKeeper)
end

function StagePracticeMapMediator:onRegister()
	local view = self:getView()
	local background = cc.Sprite:create("asset/ui/stagePractice/bg_practice_school1.png")

	background:addTo(view, -1):setName("backgroundBG"):center(view:getContentSize())
	self:mapButtonHandlersClick(kBtnHandlers)
	super.onRegister(self)
end

function StagePracticeMapMediator:adjustLayout(targetFrame)
	super.adjustLayout(self, targetFrame)
	self:getView():getChildByName("backgroundBG"):coverWorldRegion(targetFrame)
end

function StagePracticeMapMediator:resumeWithData(data)
	self:runCellUnLockAnim()
end

function StagePracticeMapMediator:enterWithData(data)
	self._data = data

	self:setupTopInfoWidget()
	self:initData()
	self:initScrollView()
	self:scrollOffSet(data)

	local function func()
		return
	end

	if data and data.pointId then
		local view = self:getInjector():getInstance("StagePracticePointView")

		self:dispatch(ViewEvent:new(EVT_PUSH_VIEW, view, nil, {
			mapId = data.mapId,
			pointId = data.pointId
		}))
	else
		function func()
			self:runCellUnLockAnim()
		end
	end

	self:createAction(func)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_STAGEPRACTICE_GETREWARD_SUCC, self, self.refreshViewByGetReward)
	self:setupClickEnvs()
end

function StagePracticeMapMediator:scrollOffSet(data)
	self._selectIndex = 1

	if data and data.mapId then
		for i = 1, #self._mapIds do
			if self._mapIds[i] == data.mapId then
				self._selectIndex = i

				break
			end
		end
	end

	self._selectIndex = 5

	local maxOffsetX = self._scrollview:getInnerContainerSize().width - self._scrollview:getContentSize().width
	local offsetX = -(self._selectIndex - 1) * kNodeWigth

	offsetX = math.max(offsetX, -maxOffsetX)

	local position = self._scrollview:getInnerContainerPosition()

	self._scrollview:setInnerContainerPosition(cc.p(offsetX, position.y))
end

function StagePracticeMapMediator:setupClickEnvs()
	if GameConfigs.closeGuide then
		return
	end

	local sequence = cc.Sequence:create(cc.CallFunc:create(function()
		local storyDirector = self:getInjector():getInstance(story.StoryDirector)
		local targetNode = self._nodeList[1]

		storyDirector:setClickEnv("stagePractice.base_practice_btn", targetNode, function(sender, eventType)
			self:onClickMap(sender, eventType, 1)
		end)
		storyDirector:notifyWaiting("enter_stage_practice_map_view")
	end))

	self:getView():runAction(sequence)
end

function StagePracticeMapMediator:setupTopInfoWidget()
	local topInfoNode = self:getView():getChildByFullName("topinfo_node")

	topInfoNode:setLocalZOrder(60)

	local config = {
		hasAnim = true,
		currencyInfo = {
			CurrencyIdKind.kPower,
			CurrencyIdKind.kDiamond,
			CurrencyIdKind.kGold
		},
		btnHandler = bind1(self.onClickBack, self),
		title = Strings:get("StagePractice_Text7")
	}
	local injector = self:getInjector()

	self._topInfoWidget = self:autoManageObject(injector:injectInto(TopInfoWidget:new(topInfoNode)))

	self._topInfoWidget:updateView(config)
end

function StagePracticeMapMediator:initData()
	self._mapIds = self._stagePracticeSystem:getShowMapIds()
	self._stagePractice = self._stagePracticeSystem:getStagePractice()
end

function StagePracticeMapMediator:initScrollView()
	self._scrollview = self:getView():getChildByName("scrollview")

	self._scrollview:setScrollBarEnabled(false)

	local templateNode = self:getView():getChildByName("clonepanel")

	templateNode:setVisible(false)

	local director = cc.Director:getInstance()
	local winSize = director:getWinSize()
	local safeAreaInset = director:getOpenGLView():getSafeAreaInset()
	local winSizeWidth = winSize.width - safeAreaInset.left - safeAreaInset.right

	self._scrollview:setContentSize(cc.size(winSizeWidth, 640))

	local functionNum = #self._mapIds
	local totalWigth = functionNum * kNodeWigth
	local function1XPos = totalWigth <= winSizeWidth and winSizeWidth / 2 - functionNum * (kNodeWigth / 2) or 5

	self._nodeList = {}

	for i = 1, functionNum do
		local functionNode = templateNode:clone()

		functionNode:setVisible(true)
		self._scrollview:addChild(functionNode)
		functionNode:setTag(i)
		functionNode:setPosition(cc.p(function1XPos + (i - 1) * kNodeWigth, templateNode:getPositionY() + 0))
		self:refreshNodeInfo(functionNode, i)

		self._nodeList[i] = functionNode
	end

	self._scrollview:setInnerContainerSize(cc.size(totalWigth, 640))
	self._scrollview:setTouchEnabled(winSizeWidth < totalWigth)
end

local boxAnimStatePath = {
	"dha_baoxiangkaiqi",
	"dhb_baoxiangkaiqi",
	"dhc_baoxiangkaiqi"
}

function StagePracticeMapMediator:moveAction(delayTime, targetPos, func)
	return cc.Sequence:create(cc.DelayTime:create(delayTime), cc.EaseOut:create(cc.MoveTo:create(0.4, targetPos), 0.7), cc.CallFunc:create(func))
end

function StagePracticeMapMediator:createAction(func)
	local index = 1
	local count = #self._nodeList

	for i = count, 1, -1 do
		local node = self._nodeList[i]
		local posX, posY = node:getPositionX(), node:getPositionY()

		node:setPositionX(-320 - 300 * i)
		node:runAction(self:moveAction(0.1, cc.p(posX, posY), function()
			if i == 1 and func then
				func()
			end
		end))

		index = index + 1
	end
end

local lockAnim = {
	GREEN = "lan_zhangjiejiesuo",
	BLUE = "lv_zhangjiejiesuo",
	RED = "hong_zhangjiejiesuo"
}
local normalAnim = {
	GREEN = "lan_zhangjiechuxian",
	BLUE = "lv_zhangjiechuxian",
	RED = "hong_zhangjiechuxian"
}

function StagePracticeMapMediator:refreshNodeInfo(panel, index)
	local mapId = self._mapIds[index]
	local mapData = self._stagePractice:getMapById(mapId)

	panel:setTouchEnabled(true)

	local touchPanel = panel:getChildByFullName("touchpanel")

	touchPanel:addTouchEventListener(function(sender, eventType)
		self:onClickMap(sender, eventType, index)
	end)

	local reawardPanel = panel:getChildByFullName("reawardpanel")

	reawardPanel:setVisible(not mapData:isLock())

	local loadingNode = reawardPanel:getChildByFullName("loading")

	loadingNode:setPercent(mapData:getStar() / mapData:getAllStar() * 100)

	local numLabel = reawardPanel:getChildByFullName("numlabel")

	numLabel:setString(mapData:getStar() .. "/" .. mapData:getAllStar())

	local state = mapData:getFullStarReward()
	local animParent = reawardPanel:getChildByFullName("boximg")

	animParent:removeAllChildren()

	local anim = cc.MovieClip:create("tongxiang" .. boxAnimStatePath[state + 1])

	anim:addTo(animParent):center(animParent:getContentSize()):offset(-17, 8)
	anim:setScale(-0.28, 0.28)

	local touchPanel = reawardPanel:getChildByFullName("touchpanel")

	touchPanel:addTouchEventListener(function(sender, eventType)
		self:onClickTouch(sender, eventType, index)
	end)

	if not panel.redPoint then
		panel.redPoint = RedPoint:createDefaultNode()

		panel.redPoint:addTo(panel):posite(333, 422)
		panel.redPoint:setLocalZOrder(999)
	end

	panel.redPoint:setVisible(mapData:hasPointRedPoint())
	self:refreshCellAnim(panel, index)
end

local animTag = 133

function StagePracticeMapMediator:refreshCellAnim(panel, index)
	panel:removeChildByTag(animTag, true)

	local mapId = self._mapIds[index]
	local mapData = self._stagePractice:getMapById(mapId)
	local isLock = false

	isLock = not mapData:isLock() and (self._stagePracticeSystem:getFlagIdState(mapData:getId()) or true) or true

	local imgType = mapData:getBackImgType()

	if isLock then
		if not lockAnim[imgType] then
			local animPath = normalAnim[imgType]
			local anim = cc.MovieClip:create(animPath)

			anim:addTo(panel, -1, animTag):posite(174, 218)
			anim:addEndCallback(function()
				anim:stop()
			end)

			panel.anim = anim

			local titleAnim = anim:getChildByName("title")
			local label = cc.Label:createWithTTF(mapData:getName(), TTF_FONT_FZYH_M, 34)

			label:setAnchorPoint(cc.p(0, 0.5))
			label:addTo(titleAnim):center(titleAnim:getContentSize())

			local lineGradiantVec2 = {
				{
					ratio = 0.3,
					color = cc.c4b(255, 255, 255, 255)
				},
				{
					ratio = 0.7,
					color = cc.c4b(185, 185, 185, 255)
				}
			}

			label:enablePattern(cc.LinearGradientPattern:create(lineGradiantVec2, {
				x = 0,
				y = -1
			}))

			local heroAnim = anim:getChildByName("hero")
			local layout = ccui.Layout:create()

			layout:setContentSize(cc.size(500, 500))
			layout:setClippingEnabled(true)
			layout:addTo(heroAnim):center(heroAnim:getContentSize()):offset(0, 99)

			local rolePic = RoleFactory:createRolePortraitPic(mapData:getBackImgRole())

			rolePic:setScale(0.65)
			rolePic:addTo(layout):center(layout:getContentSize()):offset(0, -110)
			anim:stop()

			if isLock then
				anim:getChildByName("guang"):stop()
				anim:getChildByName("lock"):stop()
			end
		end
	end
end

function StagePracticeMapMediator:runCellUnLockAnim()
	for i = 1, #self._nodeList do
		local node = self._nodeList[i]
		local anim = node.anim
		local mapId = self._mapIds[i]
		local mapData = self._stagePractice:getMapById(mapId)

		if not self._stagePracticeSystem:getFlagIdState(mapData:getId()) and not mapData:isLock() then
			self._stagePracticeSystem:setFlagIdState(mapData:getId(), true)
			anim:gotoAndPlay(1)
			anim:getChildByName("guang"):gotoAndPlay(1)
			anim:getChildByName("lock"):gotoAndPlay(1)
			anim:addCallbackAtFrame(57, function()
				self:refreshCellAnim(node, i)
			end)
		elseif not mapData:isLock() then
			anim:gotoAndPlay(0)
		end
	end
end

function StagePracticeMapMediator:onClickBack(sender, eventType)
	if eventType == ccui.TouchEventType.ended then
		self:dismiss()

		if self._data and self._data.isBackEntrance then
			local view = self:getInjector():getInstance("PracticeEntranceView")

			self:dispatch(ViewEvent:new(EVT_PUSH_VIEW, view, nil))
		end
	end
end

function StagePracticeMapMediator:onClickMap(sender, eventType, index)
	if eventType == ccui.TouchEventType.ended then
		local mapId = self._mapIds[index]
		local mapData = self._stagePractice:getMapById(mapId)

		if mapData:isLock() then
			self:dispatch(ShowTipEvent({
				tip = self._stagePracticeSystem:getMapLockTip(mapId)
			}))

			return
		end

		local view = self:getInjector():getInstance("StagePracticePointView")

		self:dispatch(ViewEvent:new(EVT_PUSH_VIEW, view, nil, {
			mapId = mapId
		}))
	end
end

function StagePracticeMapMediator:onClickTouch(sender, eventType, index)
	if eventType == ccui.TouchEventType.ended then
		local mapId = self._mapIds[index]
		local mapData = self._stagePractice:getMapById(mapId)
		local state = mapData:getFullStarReward()

		if state ~= SPracticeRewardState.kCanGet then
			local info = {
				rewardId = mapData:getStarReward(),
				star = mapData:getAllStar(),
				starEngouh = mapData:getStar() >= mapData:getAllStar(),
				state = state,
				conditionValue = config.ConditionValue
			}
			local view = self:getInjector():getInstance("StagePracticeBoxTipView")

			self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
				transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
			}, info))

			return
		end

		local mapId = self._mapIds[index]

		self._stagePracticeSystem:requestGetMapFullStarReward(mapId, function(response)
			local view = self:getInjector():getInstance("getRewardView")

			self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
				maskOpacity = 0
			}, {
				rewards = response.data.reward
			}))
			self:refreshNodeInfo(self._nodeList[index], index)
		end)
	end
end

function StagePracticeMapMediator:refreshViewByGetReward(event)
	for index = 1, #self._nodeList do
		self:refreshNodeInfo(self._nodeList[index], index)
	end
end
