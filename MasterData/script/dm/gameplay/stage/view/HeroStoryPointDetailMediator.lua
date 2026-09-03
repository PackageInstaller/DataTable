-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/stage/view/HeroStoryPointDetailMediator.lua

HeroStoryPointDetailMediator = class("HeroStoryPointDetailMediator", DmPopupViewMediator)

HeroStoryPointDetailMediator:has("_stageSystem", {
	is = "r"
}):injectWith("StageSystem")
HeroStoryPointDetailMediator:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")

local kBtnHandlers = {}

function HeroStoryPointDetailMediator:initialize()
	super.initialize(self)
end

function HeroStoryPointDetailMediator:dispose()
	super.dispose(self)
end

function HeroStoryPointDetailMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(kBtnHandlers)
	self:glueFieldAndUi()

	self._bagSystem = self._developSystem:getBagSystem()

	self.mapEventListener(self, self:getEventDispatcher(), EVT_HEROSTAGE_RESETTIMES, self, self.refreshChallengeTimes)
end

function HeroStoryPointDetailMediator:enterWithData(data)
	if data.isModel then
		self._point = data.point
		self._pointId = self._point:getPointId()
		self._pointConfig = self._point._config
	else
		self._pointId = data.point
		self._point = nil
		self._pointConfig = ConfigReader:getRecordById("HeroStoryPoint", self._pointId)
	end

	self._index = data.index
	self._mapId = ConfigReader:getDataByNameIdAndKey("HeroStoryPoint", self._pointId, "Map")
	self._enterBattle = false

	self:setupView()
	self:initAnim()
end

function HeroStoryPointDetailMediator:glueFieldAndUi()
	self._main = self:getView():getChildByFullName("main")

	local function callFunc()
		self:onClickBack()
	end

	local touchView = self._main:getChildByName("touchPanel")

	mapButtonHandlerClick(nil, touchView, {
		clickAudio = "Se_Click_Close_2",
		func = callFunc
	})

	self._rightPanel = self._main:getChildByFullName("rightPanel")

	self._rightPanel:setLocalZOrder(101)

	self._rolePanel = self._main:getChildByName("bg_renwu")
	self._descLabel = self._rightPanel:getChildByFullName("descTextPanel.desc_text")
	self._titleLabel = self._rightPanel:getChildByFullName("title_text")
	self._dropPanel = self._rightPanel:getChildByFullName("Panel_drop")
	self._challengeBtn = self._rightPanel:getChildByFullName("challenge_btn")
	self._teamPanel = self._rightPanel:getChildByName("Panel_team")

	local petScroll = self._teamPanel:getChildByName("petScorll")
	local dropListView = self._dropPanel:getChildByName("dropListView")

	dropListView:setScrollBarEnabled(false)
	petScroll:setScrollBarEnabled(false)
	petScroll:setBounceEnabled(true)

	local function challengeFunc()
		self:onChallenge()
	end

	mapButtonHandlerClick(nil, self._challengeBtn, {
		ignoreClickAudio = true,
		func = challengeFunc
	})
end

function HeroStoryPointDetailMediator:setupView()
	local point = self._point
	local pointConfig = self._pointConfig

	self._conditionPanel = self._rightPanel:getChildByFullName("3starTip")

	self._conditionPanel:setLocalZOrder(948)

	local descs = ConfigReader:getDataByNameIdAndKey("ConfigValue", "Block_StarConditionDesc", "content")
	local starCondition = pointConfig.StarCondition

	for i = 1, 3 do
		local tip = self._conditionPanel:getChildByName("tip" .. i)

		tip:setString(Strings:get(descs[starCondition[i].type], {
			value = starCondition[i].value
		}))

		local tipStar = self._conditionPanel:getChildByName("star" .. i)

		if ((self._point or nil) and point:getStarState())[i] then
			tipStar:loadTexture("asset/common/yinghun_xingxing.png", ccui.TextureResType.localType)
		else
			tipStar:loadTexture("asset/common/yinghun_xingxing2.png", ccui.TextureResType.localType)
			tipStar:setScale(0.3)
		end
	end

	self._rolePanel:removeAllChildren()

	local pointHead = pointConfig.PointHead
	local heroSprite = IconFactory:createRoleIconSpriteNew({
		useAnim = true,
		frameId = "bustframe9",
		id = pointHead
	})

	heroSprite:addTo(self._rolePanel):setTag(951)
	heroSprite:setScale(0.8)
	heroSprite:setPosition(cc.p(0, 30))
	self._descLabel:setString(Strings:get(pointConfig.BlockDesc))
	self._descLabel:enableShadow(cc.c4b(0, 0, 0, 137.70000000000002), cc.size(2, -2), 3)
	self._descLabel:getVirtualRenderer():setLineHeight(20)
	self._descLabel:setLineSpacing(0)

	local pointIndex = self._index

	self._titleLabel:setString(pointIndex .. "." .. Strings:get(pointConfig.Name))

	local costText = self._challengeBtn:getChildByFullName("cost_text")

	costText:setString(pointConfig.StaminaCost)

	self._curPower = self._bagSystem:getPower()

	if self._curPower < pointConfig.StaminaCost then
		costText:setTextColor(GameStyle:getColor(7))
	else
		costText:setTextColor(GameStyle:getColor(1))
	end

	self:refreshChallengeTimes()
	self:initTeamInfo()
end

function HeroStoryPointDetailMediator:initAnim()
	local mc = cc.MovieClip:create("guankaxiangqing_zhuxianguanka_UIjiaohudongxiao")

	mc:addCallbackAtFrame(21, function()
		local btnAnim = cc.MovieClip:create("xiangqingxunhuan_zhuxianguanka_UIjiaohudongxiao")

		btnAnim:setScale(0.8)
		btnAnim:addTo(mc)
		btnAnim:setPosition(cc.p(443.5, 0))
		btnAnim:setOpacity(0)
		btnAnim:runAction(cc.FadeIn:create(0.5))
	end)
	mc:addCallbackAtFrame(30, function()
		mc:stop()
	end)
	mc:setPlaySpeed(1.6)
	mc:stop()
	mc:addTo(self._main)
	mc:setPosition(cc.p(568, 290))
	mc:setLocalZOrder(100)

	for i = 1, 3 do
		local starMc = mc:getChildByName("star" .. i)
		local star = self._conditionPanel:getChildByName("star" .. i)

		star:changeParent(starMc):center(starMc:getContentSize())

		local tipsMc = mc:getChildByName("tips" .. i)
		local tips = self._conditionPanel:getChildByName("tip" .. i)

		tips:changeParent(tipsMc)
		tips:setPosition(-83, 0)
	end

	local descMc = mc:getChildByFullName("desc")
	local descTextPanel = self._rightPanel:getChildByFullName("descTextPanel")

	descTextPanel:changeParent(descMc)
	descTextPanel:setPosition(cc.p(-213, -53))

	local rewardMc = mc:getChildByFullName("rewardPanel")

	self._teamPanel:changeParent(rewardMc)
	self._teamPanel:setPosition(cc.p(-217, -52))

	local titleMc = mc:getChildByFullName("title")

	self._titleLabel:changeParent(titleMc)
	self._titleLabel:setPosition(cc.p(-90, 4))

	local heroRole = mc:getChildByFullName("hero")

	self._rolePanel:changeParent(heroRole)
	self._challengeBtn:setOpacity(0)

	local act = cc.Sequence:create(cc.DelayTime:create(0.4375), cc.FadeIn:create(0.3125))

	self._challengeBtn:runAction(act:clone())
	mc:gotoAndPlay(1)
end

function HeroStoryPointDetailMediator:refreshChallengeTimes()
	local ResetChallenge = self._rightPanel:getChildByFullName("ResetChallenge")
	local remainTimes = ResetChallenge:getChildByName("remainTimes")
	local changeTimes

	remainTimes:setString(self._point and self._point:getChallengeTimes() or self._pointConfig.LimitAmount)
end

function HeroStoryPointDetailMediator:showCondition(sender, eventType)
	if eventType == ccui.TouchEventType.began then
		self._conditionPanel:setVisible(true)
	elseif eventType == ccui.TouchEventType.ended then
		self._conditionPanel:setVisible(false)
	elseif eventType == ccui.TouchEventType.canceled then
		self._conditionPanel:setVisible(false)
	end
end

function HeroStoryPointDetailMediator:bindGuildPopView()
	local descs = self._pointConfig.SpecialRuleShow

	if not descs or #descs == 0 then
		return
	end

	local icon = ccui.ImageView:create("asset/common/zd_txt_tgjq.png", ccui.TextureResType.localType)

	icon:addTo(self._rightPanel)
	icon:setPosition(616, 403)
	icon:setTouchEnabled(true)

	local function callFunc()
		local view = self:getInjector():getInstance("StagePracticeSpecialRuleView")
		local event = ViewEvent:new(EVT_SHOW_POPUP, view, {
			remainLastView = true,
			transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
		}, {
			ruleList = descs
		})

		self:dispatch(event)
	end

	mapButtonHandlerClick(nil, icon, {
		ignoreClickAudio = true,
		func = callFunc
	})

	if not self._point and not self._pointConfig.isFirstEnter and not self._enterBattle then
		self._pointConfig.isFirstEnter = true

		callFunc()
	end
end

function HeroStoryPointDetailMediator:initTeamInfo()
	local petScorll = self._teamPanel:getChildByName("petScorll")
	local _modelIds = {}
	local cfgMaster = self._pointConfig.PlayerMaster

	_modelIds[#_modelIds + 1] = ConfigReader:getDataByNameIdAndKey("EnemyMaster", cfgMaster, "RoleModel")

	local mainRoleTag = 1

	if self._pointConfig.PlayerMasterMode == 1 then
		_modelIds[#_modelIds + 1] = self._pointConfig.PointHead
		mainRoleTag = 2
	end

	local cfgHeros = self._pointConfig.PlayerEnemyHero

	for _, v in ipairs(cfgHeros) do
		_modelIds[#_modelIds + 1] = ConfigReader:getDataByNameIdAndKey("EnemyHero", v, "RoleModel")
	end

	local size = self:getView():getChildByName("cloneCell"):getContentSize()

	if #_modelIds > 5 then
		local innerContainer = petScorll:getInnerContainer()
		local cSize = innerContainer:getContentSize()

		innerContainer:setContentSize(cc.size(#_modelIds * 74, cSize.height))
	end

	for k, v in ipairs(_modelIds) do
		local cell = self:getView():getChildByName("cloneCell"):clone()
		local bg = ccui.ImageView:create()

		bg:addTo(cell)
		bg:setPosition(cc.p(size.width / 2, size.height / 2))
		bg:loadTexture("asset/heroRect/heroIconRect/kazu_bg_ka_bai_new.png")

		local sprite = IconFactory:createRoleIconSpriteNew({
			id = _modelIds[k]
		})

		sprite:setScale(0.5)

		sprite = IconFactory:addStencilForIcon(sprite, 4, cc.size(100, 120), {
			0,
			3
		})

		sprite:addTo(cell)
		sprite:setPosition(cc.p(size.width / 2, size.height / 2 + 2))
		cell:addTo(petScorll)
		cell:setScale(0.6)
		cell:setPosition(cc.p((k - 0.5) * 74, 39.5))

		if k == mainRoleTag then
			local iamge = ccui.ImageView:create("hb_icon_zj.png", ccui.TextureResType.plistType)

			iamge:addTo(cell)
			iamge:setScale(1.4)
			iamge:setPosition(cc.p(80, 10))
		else
			local iamge = ccui.ImageView:create("hb_icon_robot.png", ccui.TextureResType.plistType)

			iamge:addTo(cell)
			iamge:setScale(1.4)
			iamge:setPosition(cc.p(80, 10))
		end
	end
end

function HeroStoryPointDetailMediator:onChallenge()
	if self._point then
		local changeTimes = self._point:getChallengeTimes()

		if changeTimes < 1 then
			self:dispatch(ShowTipEvent({
				tip = Strings:get("HeroStory_Today_Finish")
			}))

			return
		end
	end

	if self._bagSystem:getPower() < self._pointConfig.StaminaCost then
		self:dispatch(ShowTipEvent({
			duration = 0.2,
			tip = Strings:find("CUSTOM_ENERGY_NOT_ENOUGH")
		}))
		CurrencySystem:buyCurrencyByType(self, CurrencyType.kActionPoint)

		return
	end

	local bagSystem = self._developSystem:getBagSystem()
	local times = bagSystem:getTimeRecordById(TimeRecordType.kHeroStoryTotalNum)._time

	if times < 1 then
		self:dispatch(ShowTipEvent({
			tip = Strings:get("StoryBlock_Today_Finish")
		}))

		return
	end

	if self._point and self._point:getStarCount() >= 3 then
		self:onEnterSweepBox()
	else
		self:onEnterTeam()
	end
end

function HeroStoryPointDetailMediator:onEnterTeam()
	local view = self:getInjector():getInstance("StoryStageTeamView")
	local data = {}

	data.pointId = self._pointId
	data.heroId = ConfigReader:getDataByNameIdAndKey("HeroStoryMap", self._mapId, "Hero")

	self:dispatch(ViewEvent:new(EVT_PUSH_VIEW, view, {}, data))

	self._enterBattle = true

	self:close()
end

function HeroStoryPointDetailMediator:onClickWipeOnce()
	AudioEngine:getInstance():playEffect("Se_Click_Common_1", false)
	self._stageSystem:requestHeroStageSweep(self._pointId, 1, nil, function(data)
		data.param = {
			wipeTimes = 1,
			pointId = self._pointId
		}
		data.itemId = self._pointConfig.MainShowItem

		self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, self:getInjector():getInstance("StageSweepView"), {
			transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
		}, data))
	end)
end

function HeroStoryPointDetailMediator:onEnterSweepBox()
	local outSelf, delegate = self, {}

	function delegate:willClose(popupMediator, data)
		if not data then
			return
		end

		if data.returnValue == 1 then
			outSelf:onEnterTeam()
		elseif data.returnValue == 3 then
			outSelf:onClickWipeOnce()
		end
	end

	local data = {}

	data.stageType = kHeroStroy
	data.challengeTimes = 1

	AudioEngine:getInstance():playEffect("Se_Click_Common_1", false)
	self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, self:getInjector():getInstance("SweepBoxPopView"), {
		transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
	}, data, delegate))
end

function HeroStoryPointDetailMediator:onClickBack(sender, eventType)
	self:close()
end
