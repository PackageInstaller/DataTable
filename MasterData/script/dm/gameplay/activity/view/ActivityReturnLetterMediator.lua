-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/activity/view/ActivityReturnLetterMediator.lua

ActivityReturnLetterMediator = class("ActivityReturnLetterMediator", PopupViewMediator, _M)

ActivityReturnLetterMediator:has("_activitySystem", {
	is = "r"
}):injectWith("ActivitySystem")
ActivityReturnLetterMediator:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")

local kBtnHandlers = {
	["main.letterContent.rewardBox"] = {
		clickAudio = "Se_Click_Common_2",
		func = "onClickReward"
	}
}

function ActivityReturnLetterMediator:initialize()
	super.initialize(self)
end

function ActivityReturnLetterMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(kBtnHandlers)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_RETURN_ACTIVITY_REFRESH, self, self.onActivityRefresh)
	self:initUI()
end

function ActivityReturnLetterMediator:enterWithData(data)
	self._activityId = data.activityId
	self._activity = self._activitySystem:getActivityById(self._activityId)
	self._letterActivity = self._activity:getSubActivityByType(ActivityType.KLetter)

	self:setupLetterContent()
	self:initAnim()
end

function ActivityReturnLetterMediator:initUI()
	self._main = self:getView():getChildByName("main")
	self._letter = self._main:getChildByFullName("letter")
	self._content = self._main:getChildByFullName("letterContent")
	self._letterTitle = self._main:getChildByFullName("letterContent.titleLab")
	self._letterContent = self._main:getChildByFullName("letterContent.contentLab")
	self._letterName = self._main:getChildByFullName("letterContent.nameLab")
	self._roleView = self._main:getChildByFullName("role")
	self._animNode = self._main:getChildByFullName("anim")
	self._rewardBox = self._main:getChildByFullName("letterContent.rewardBox")
end

function ActivityReturnLetterMediator:initAnim()
	self._animNode:removeAllChildren()

	self._anim = cc.MovieClip:create("eff_zong_huiliu")

	self._anim:addTo(self._animNode, 1)
	self._anim:setPosition(cc.p(568, 320))

	self._letterShakeEff = AudioEngine:getInstance():playEffect("Se_Effect_Letter_Shake", true)

	self._anim:addCallbackAtFrame(60, function(cid, mc)
		self._anim:gotoAndPlay(1)
	end)
	self._anim:addCallbackAtFrame(70, function(cid, mc)
		self._roleView:runAction(cc.Spawn:create(cc.MoveBy:create(0.2, cc.p(40, 0)), cc.FadeIn:create(0.5)))
	end)
	self._anim:addCallbackAtFrame(80, function(cid, mc)
		self._letterContent:runAction(cc.FadeIn:create(0.8))
		self._letterTitle:runAction(cc.FadeIn:create(0.8))
		self._letterName:runAction(cc.FadeIn:create(0.8))
	end)
	self._anim:addCallbackAtFrame(83, function(cid, mc)
		self._rewardBox:runAction(cc.FadeIn:create(0.8))
	end)
	self._anim:addCallbackAtFrame(95, function(cid, mc)
		mc:stop()
	end)
end

function ActivityReturnLetterMediator:setupLetterContent()
	local mainActivity = self._activity
	local letterActivity = self._letterActivity
	local customDataSystem = self:getInjector():getInstance(CustomDataSystem)
	local showHeroId = customDataSystem:getValue(PrefixType.kGlobal, "BoardHeroId", -1)

	if showHeroId == -1 then
		showHeroId = ConfigReader:getDataByNameIdAndKey("ConfigValue", "Default_Model_Board", "content")

		customDataSystem:setValue(PrefixType.kGlobal, "BoardHeroId", showHeroId)
	end

	local config = letterActivity:getActivityConfig()
	local player = self._developSystem:getPlayer()

	self._letterTitle:setString(Strings:get(config.Letter[1], {
		Name = player:getNickName()
	}))

	local timeTs = TimeUtil:localDate("*t", mainActivity:getLastLogoutTime())
	local leaveTs = TimeUtil:timeByRemoteDate() - mainActivity:getLastLogoutTime()
	local dayNum = math.ceil(leaveTs / 86400)
	local signName = Strings:get(ConfigReader:getDataByNameIdAndKey("HeroBase", showHeroId, "Name"))

	self._letterContent:setString(Strings:get(config.Letter[2], {
		Year = timeTs.year,
		Month = timeTs.month,
		Day = timeTs.day,
		Num = dayNum,
		Sign = signName
	}))
	self._letterName:setString(Strings:get(config.Letter[3], {
		Sign = signName
	}))

	local roleModel = IconFactory:getRoleModelByKey("HeroBase", showHeroId)
	local hero = self._developSystem:getHeroSystem():getHeroById(showHeroId)
	local surfaceId

	if hero then
		roleModel = hero:getModel()
		surfaceId = hero:getSurfaceId()
	end

	local heroSprite, _, spineani, picInfo = IconFactory:createRoleIconSpriteNew({
		useAnim = true,
		frameId = "bustframe9",
		id = roleModel
	})

	if spineani then
		spineani:registerSpineEventHandler(handler(self, self.spineAnimEvent), sp.EventType.ANIMATION_COMPLETE)

		self._sharedSpine = spineani
	else
		self._sharedSpine = nil
	end

	self._roleView:removeAllChildren()
	heroSprite:addTo(self._roleView)
	heroSprite:setPosition(cc.p(330, -20))
	heroSprite:setTouchEnabled(false)
	self._letter:setVisible(true)
	self._content:setVisible(false)
	performWithDelay(self._letter, function()
		AudioEngine:getInstance():stopEffectsByType(AudioType.CVEffect)
	end, 1)
	self._letter:addTouchEventListener(function(sender, eventType)
		if eventType == ccui.TouchEventType.ended then
			if self._letterShakeEff then
				AudioEngine:getInstance():stopEffect(self._letterShakeEff)
			end

			AudioEngine:getInstance():playEffect("Se_Effect_Letter_Unfold", false)
			self._letter:setVisible(false)
			self._content:setVisible(true)
			AudioEngine:getInstance():stopEffectsByType(AudioType.CVEffect)

			local soundId = "Voice_" .. showHeroId .. "_38"

			AudioEngine:getInstance():playRoleEffect(soundId, false)
			self._anim:stop()
			self._anim:gotoAndPlay(61)
		end
	end)
end

function ActivityReturnLetterMediator:spineAnimEvent(event)
	if event.type == "complete" and event.animation ~= "animation" and self._sharedSpine then
		self._sharedSpine:playAnimation(0, "animation", true)
	end
end

function ActivityReturnLetterMediator:onClickReward()
	local view = self:getInjector():getInstance("ActivityReturnLetterRewardView")
	local outSelf = self
	local rewardId = self._letterActivity:getActivityConfig().Reward

	self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, nil, {
		rewardId = rewardId,
		callback = function()
			outSelf._activitySystem:drawLetterReward()
			outSelf:close()
		end
	}))
end

function ActivityReturnLetterMediator:onActivityRefresh()
	if not self._activitySystem:isReturnActivityShow() then
		self:close()
	end
end
