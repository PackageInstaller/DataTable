-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/gallery/view/GalleryPartnerPastMediator.lua

GalleryPartnerPastMediator = class("GalleryPartnerPastMediator", DmAreaViewMediator, _M)

GalleryPartnerPastMediator:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")
GalleryPartnerPastMediator:has("_gallerySystem", {
	is = "r"
}):injectWith("GallerySystem")
GalleryPartnerPastMediator:has("_customDataSystem", {
	is = "r"
}):injectWith("CustomDataSystem")

local kBtnHandlers = {
	["main.backBtn"] = {
		clickAudio = "Se_Click_Close_2",
		func = "onClickBack"
	},
	["main.left.button"] = {
		clickAudio = "Se_Click_Common_1",
		func = "onClickLeft"
	},
	["main.right.button"] = {
		clickAudio = "Se_Click_Common_1",
		func = "onClickRight"
	},
	["main.rewardNode.btn"] = {
		clickAudio = "Se_Click_Common_1",
		func = "onClickReward"
	}
}

function GalleryPartnerPastMediator:initialize()
	super.initialize(self)
end

function GalleryPartnerPastMediator:dispose()
	super.dispose(self)
end

function GalleryPartnerPastMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(kBtnHandlers)

	self._heroSystem = self._developSystem:getHeroSystem()
	self._bagSystem = self._developSystem:getBagSystem()

	self.mapEventListener(self, self:getEventDispatcher(), EVT_GALLERY_HEROREWARD_SUCC, self, self.refreshReward)
end

function GalleryPartnerPastMediator:enterWithData(data)
	self:initData(data)
	self:initWidgetInfo()
	self:initView()
	self:runStartAnim()
end

function GalleryPartnerPastMediator:refreshBySync()
	self:refreshData()
	self:refreshView()
end

function GalleryPartnerPastMediator:initData(data)
	self._heroId = data.id or ""
	self._bg = data.bg
	self._curIndex = 1
	self._storyArray = data.storyArray
	self._curStoryData = self._storyArray[self._curIndex]
	self._canChange = true
	self._maxIndex = 0

	local customKey = CustomDataKey.kHeroGalleryPast .. self._heroId
	local customValue = self._customDataSystem:getValue(PrefixType.kGlobal, customKey)

	if customValue then
		self._maxIndex = tonumber(customValue)
	end
end

function GalleryPartnerPastMediator:initWidgetInfo()
	self._main = self:getView():getChildByFullName("main")
	self._rewardNode = self._main:getChildByFullName("rewardNode")
	self._heroPanel = self._main:getChildByFullName("heroIcon.heroPanel")
	self._leftBtn = self._main:getChildByFullName("left.leftBtn")
	self._rightBtn = self._main:getChildByFullName("right.rightBtn")
	self._lockTip = self._main:getChildByFullName("lockTip")
	self._newTip = self._main:getChildByFullName("pastPanel.newTip")

	self._newTip:setVisible(false)

	self._title = self._main:getChildByFullName("pastPanel.title")
	self._page = self._main:getChildByFullName("pastPanel.page")
	self._desc = self._main:getChildByFullName("pastPanel.desc")

	self._desc:setLineSpacing(5)

	self._pastPanel = self._main:getChildByFullName("pastPanel")

	CommonUtils.runActionEffect(self._leftBtn, "Node_1.leftBtn", "LeftRightArrowEffect", "anim1", true)
	CommonUtils.runActionEffect(self._rightBtn, "Node_2.rightBtn", "LeftRightArrowEffect", "anim1", true)
	self._main:getChildByFullName("pastPanel.image.text1"):setLineSpacing(-9)
	self._main:getChildByFullName("pastPanel.image.text1"):setVisible(false)
end

function GalleryPartnerPastMediator:initView()
	self._main:getChildByFullName("heroIcon"):loadTexture(self._bg)
	self._heroPanel:removeAllChildren()

	local roleModel = IconFactory:getRoleModelByKey("HeroBase", self._heroId)
	local hero = self._heroSystem:getHeroById(self._heroId)
	local heroIcon = IconFactory:createRoleIconSpriteNew({
		useAnim = true,
		frameId = "bustframe4_8",
		id = (hero or nil) and hero:getModel()
	})

	heroIcon:addTo(self._heroPanel):center(self._heroPanel:getContentSize())

	local heroRewards = self._gallerySystem:getHeroRewards()
	local canGet = not heroRewards[self._heroId]

	self._rewardNode:setVisible(canGet)
	self:refreshView()
end

function GalleryPartnerPastMediator:refreshReward(event)
	local response = event:getData().data

	if response and response.reward then
		local view = self:getInjector():getInstance("getRewardView")
		local this = self

		local function callback()
			local storyDirector = this:getInjector():getInstance(story.StoryDirector)

			storyDirector:notifyWaiting("exit_GetRewardView_suc")
		end

		self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
			maskOpacity = 0
		}, {
			needClick = false,
			rewards = response.reward,
			callback = callback
		}))
	end

	local heroRewards = self._gallerySystem:getHeroRewards()
	local canGet = not heroRewards[self._heroId]

	self._rewardNode:setVisible(canGet)
end

function GalleryPartnerPastMediator:refreshData()
	self._curStoryData = self._storyArray[self._curIndex]
end

function GalleryPartnerPastMediator:refreshView()
	self:refreshArrowState()
	self._page:setString(self._curIndex .. "/" .. #self._storyArray)

	if not self._curStoryData then
		return
	end

	self._newTip:setVisible(self._curIndex > self._maxIndex)
	self._title:setString(self._curStoryData.title)
	self._desc:setString(self._curStoryData.desc)

	self._maxIndex = math.max(self._maxIndex, self._curIndex)

	local customKey = CustomDataKey.kHeroGalleryPast .. self._heroId

	self._maxIndex = math.max(self._maxIndex, self._curIndex)

	local customValue = self._customDataSystem:getValue(PrefixType.kGlobal, customKey)

	if not customValue or tonumber(customValue) ~= self._maxIndex then
		self._customDataSystem:setValue(PrefixType.kGlobal, customKey, self._maxIndex)
	end
end

function GalleryPartnerPastMediator:refreshArrowState()
	self._leftBtn:setVisible(self._curIndex ~= 1 and #self._storyArray > 0)
	self._rightBtn:setVisible(self._curIndex ~= #self._storyArray and #self._storyArray > 0)
end

function GalleryPartnerPastMediator:onClickBack(sender, eventType)
	self:dismiss()
end

function GalleryPartnerPastMediator:onClickLeft(sender, eventType)
	if not self._canChange then
		return
	end

	self._canChange = false

	performWithDelay(self:getView(), function()
		self._canChange = true
	end, 0.3)

	self._curIndex = self._curIndex - 1

	if self._curIndex <= 1 then
		self._curIndex = 1
	end

	self:refreshData()
	self:refreshView()
end

function GalleryPartnerPastMediator:onClickRight(sender, eventType)
	if not self._canChange then
		return
	end

	self._canChange = false

	performWithDelay(self:getView(), function()
		self._canChange = true
	end, 0.3)

	self._curIndex = self._curIndex + 1

	if self._curIndex >= #self._storyArray then
		self._curIndex = #self._storyArray
	end

	local storyData = self._storyArray[self._curIndex]

	if storyData and not storyData.unlock then
		local targetLevel, targetExp = storyData.targetLevel, storyData.targetExp
		local tip = Strings:get("GALLERY_UnlockTips", {
			num = targetLevel
		})

		self:dispatch(ShowTipEvent({
			tip = (targetExp ~= 0 or nil) and Strings:get("GALLERY_UnlockTips2", {
				num = targetLevel,
				exp = targetExp
			})
		}))

		self._curIndex = self._curIndex - 1

		return
	end

	self:refreshData()
	self:refreshView()
end

function GalleryPartnerPastMediator:onClickReward()
	local heroRewards = self._gallerySystem:getHeroRewards()
	local canGet = not heroRewards[self._heroId]

	if not canGet then
		return
	end

	local params = {
		heroId = self._heroId
	}

	self._gallerySystem:requestGalleryHeroReward(params)
end

function GalleryPartnerPastMediator:runStartAnim()
	self._pastPanel:setVisible(false)

	local panel = self._pastPanel:clone()

	panel:getChildByFullName("image.text1"):setVisible(false)
	panel:getChildByFullName("desc"):setLineSpacing(5)
	panel:setVisible(true)
	panel:addTo(self._main)
	panel:setLocalZOrder(-1)
	panel:setPosition(cc.p(585, 348))
	panel:setRotation(4)

	local rotate = cc.RotateTo:create(0.3, 0)
	local moveto1 = cc.MoveTo:create(0.3, cc.p(391, 301))
	local spawn = cc.Spawn:create(rotate, moveto1)

	panel:runAction(spawn)

	local heroIcon = self._main:getChildByFullName("heroIcon")

	heroIcon:setPosition(cc.p(569, 356))
	heroIcon:setRotation(4)

	rotate = cc.RotateTo:create(0.3, 11.6)
	moveto1 = cc.MoveTo:create(0.3, cc.p(766, 330))
	spawn = cc.Spawn:create(rotate, moveto1)

	local callfunc = cc.CallFunc:create(function()
		self._pastPanel:setVisible(true)
		panel:setVisible(false)
		self:setupClickEnvs()
	end)
	local seq = cc.Sequence:create(spawn, callfunc)

	heroIcon:runAction(seq)

	local backBtn = self._main:getChildByFullName("backBtn")

	backBtn:setOpacity(0)
	backBtn:fadeIn({
		time = 0.3
	})
	self._rewardNode:setOpacity(0)
	self._rewardNode:fadeIn({
		time = 0.3
	})
end

function GalleryPartnerPastMediator:setupClickEnvs()
	if GameConfigs.closeGuide then
		return
	end

	local storyDirector = self:getInjector():getInstance(story.StoryDirector)
	local rewardNode = self._main:getChildByFullName("rewardNode.btn")

	storyDirector:setClickEnv("GalleryPartnerPastMediator.rewardNode", rewardNode, function(sender, eventType)
		AudioEngine:getInstance():playEffect("Se_Click_Common_1", false)
		self:onClickReward(sender, eventType)
	end)
	storyDirector:notifyWaiting("enter_GalleryPartnerPastMediator")
end
