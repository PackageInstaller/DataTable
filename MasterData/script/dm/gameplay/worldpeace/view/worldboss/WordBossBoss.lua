-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/worldpeace/view/worldboss/WordBossBoss.lua

WordBossBoss = class("WordBossBoss", WorldPeaceBoss)

function WordBossBoss:updateInfo(data)
	if data:getHpr() then
		self:updateHp()
	end
end

function WordBossBoss:initVars()
	self._config = ConfigReader:getRecordById("WorldBoss", self._id)
	self._atk = self._data:getAtk()
end

function WordBossBoss:initialize(id, memberType, data, factory)
	super.initialize(self, id, memberType, data, factory)
	self:setUpExtraView()

	local miwuAnim = cc.MovieClip:create("miwu_shijiebosszhd")

	miwuAnim:addTo(self._content):offset(-5, -5)
	miwuAnim:setLocalZOrder(3)

	self._fix_shijieboss1 = cc.MovieClip:create("jinbi_shijieboss")

	self._fix_shijieboss1:addTo(self._content)
	self._fix_shijieboss1:gotoAndStop(0)
	self._fix_shijieboss1:setVisible(false)
	self._fix_shijieboss1:setScale(1.2)
	self._fix_shijieboss1:setLocalZOrder(5)

	self._fix_shijieboss2 = cc.MovieClip:create("jingyan_shijieboss")

	self._fix_shijieboss2:addTo(self._content)
	self._fix_shijieboss2:gotoAndStop(0)
	self._fix_shijieboss2:setVisible(false)
	self._fix_shijieboss2:setScale(1.2)
	self._fix_shijieboss2:setLocalZOrder(5)

	self._fix_shijieboss3 = cc.MovieClip:create("shuijing_shijieboss")

	self._fix_shijieboss3:addTo(self._content)
	self._fix_shijieboss3:gotoAndStop(0)
	self._fix_shijieboss3:setVisible(false)
	self._fix_shijieboss3:setScale(1.2)
	self._fix_shijieboss3:setLocalZOrder(5)

	self._fix_shijieboss4 = cc.MovieClip:create("zuanshi_shijieboss")

	self._fix_shijieboss4:addTo(self._content)
	self._fix_shijieboss4:gotoAndStop(0)
	self._fix_shijieboss4:setVisible(false)
	self._fix_shijieboss4:setScale(1.2)
	self._fix_shijieboss4:setLocalZOrder(5)

	self._animtionMap = {
		Worldboss_img_jinbidui = self._fix_shijieboss1,
		Worldboss_img_jinyandui = self._fix_shijieboss2,
		Worldboss_img_jingshidui = self._fix_shijieboss3,
		Worldboss_img_zuanshidui = self._fix_shijieboss4
	}

	self._hpbar:setVisible(false)
	self._progressbg2:setVisible(false)

	self._rewardHitAnim = false

	self._content:getChildByName("reward"):ignoreContentAdaptWithSize(true)
	self._content:getChildByName("reward"):loadTexture(self._config.HeroIcon .. ".png", 1)
	self._content:getChildByName("reward"):setLocalZOrder(11111)
	self._content:getChildByName("bianhao"):setVisible(false)
end

function WordBossBoss:changeNextBoss()
	local heroId = self._config.Hero

	if type(self._config.Hero) == "table" then
		local index = (self._data:getIndex() + 1) % #self._config.Hero

		if index == 0 then
			index = #self._config.Hero
		end

		heroId = self._config.Hero[index]
	end

	local modelId = IconFactory:getRoleModelByKey("HeroBase", heroId)
	local refreshAnim = cc.MovieClip:create("shuaxin_shijiebosszhd")

	refreshAnim:addTo(self:getDisplayNode())
	refreshAnim:addCallbackAtFrame(20, function()
		self._content:removeChildByName("playerIcon")

		local bossIcon = self._content:getChildByName("icon")

		bossIcon:setVisible(false)

		local sprite = IconFactory:createAsyncRoleIconSpriteNew({
			useAnim = false,
			frameId = "bustframe29",
			id = modelId
		})

		sprite:setPosition(cc.p(0, 0))
		sprite:addTo(self._content)
		sprite:setName("playerIcon")
		sprite:offset(-10, -5)
		sprite:setScale(0.93)
		sprite:setOpacity(0)
		sprite:fadeTo({
			time = 0.5,
			opacity = 255
		})
	end)
	refreshAnim:addEndCallback(function()
		refreshAnim:stop()
		refreshAnim:removeFromParent()
	end)
end

function WordBossBoss:setUpExtraView()
	self._content:getChildByName("type1"):setVisible(false)
	self._content:getChildByName("type2"):setVisible(false)
	self._content:getChildByName("type3"):setVisible(false)
	self._content:getChildByName("name"):setVisible(false)
	self._content:getChildByName("reward"):setLocalZOrder(10)
	self._content:getChildByName("heart"):setVisible(false)
	self._content:getChildByName("frame"):setVisible(false)
	self._content:getChildByName("bg"):setVisible(false)
end

function WordBossBoss:onHit(detail)
	super.onHit(self, detail)

	local isMyth = detail.actor._isMyth

	if self._animtionMap[self._config.HeroIcon] and not self._rewardHitAnim and isMyth then
		self._animtionMap[self._config.HeroIcon]:setVisible(true)
		self._animtionMap[self._config.HeroIcon]:gotoAndPlay(1)
		self._animtionMap[self._config.HeroIcon]:addEndCallback(function()
			self._rewardHitAnim = false

			self._animtionMap[self._config.HeroIcon]:stop()
		end)

		self._rewardHitAnim = true
	end

	local atk = detail.actor:getAtk()

	if isMyth then
		local hp = self._data:getHpr()
		local newHp = math.max(0, math.floor(hp - atk))

		self._data:setHpr(newHp)
	end

	self._content:getChildByName("reward"):ignoreContentAdaptWithSize(true)
	self._content:getChildByName("reward"):loadTexture(self._config.HeroIcon .. ".png", 1)

	local system = DmGame:getInstance()._injector:getInstance("DevelopSystem")

	system:dispatch(Event:new(EVT_WORLDBOSSHP_REFRESH, {
		isMyth = isMyth,
		actor = detail.actor
	}))
end
