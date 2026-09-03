-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/miniGame/model/plane/PlaneEnemy.lua

require("dm.gameplay.miniGame.model.plane.PlaneMember")

BasicsPlaneEnemy = class("BasicsPlaneEnemy", PlaneMember, _M)

BasicsPlaneEnemy:has("_enemyType", {
	is == "rw"
})
BasicsPlaneEnemy:has("_config", {
	is == "r"
})
BasicsPlaneEnemy:has("_id", {
	is == "r"
})
BasicsPlaneEnemy:has("_bulletFactorys", {
	is == "r"
})

function BasicsPlaneEnemy:initialize(data, id, owner)
	super.initialize(self, data, owner)
	self:setType(PlaneMemberType.kEnemyPlane)

	self._id = id
	self._config = ConfigReader:getRecordById("MiniPlaneEnemy", id)

	self:setHp(self._config.hp)

	self._bulletFactorys = {}
end

function BasicsPlaneEnemy:getBoomReward()
	return self._config.boomReward
end

function BasicsPlaneEnemy:getScore()
	return self._config.score
end

function BasicsPlaneEnemy:isGameOverEnemy()
	return self._config.IsCount == 1
end

function BasicsPlaneEnemy:bindBulletFactory(bulletFactory)
	self._bulletFactorys[#self._bulletFactorys + 1] = bulletFactory
end

function BasicsPlaneEnemy:removeAllBulletFactory()
	for i = 1, #self._bulletFactorys do
		local bulletFactory = self._bulletFactorys[i]

		bulletFactory:remove()
	end

	self._bulletFactorys = {}
end

function BasicsPlaneEnemy:buildBullet(bulletFactory, parent, data)
	data = data or {}

	if self._config.BulletMoveType[1] and data.imgPath then
		bulletFactory:buildBullet(parent, data, function()
			return self:getPosition()
		end)
	end
end

function BasicsPlaneEnemy:pause()
	super.pause(self)

	for i = 1, #self._bulletFactorys do
		local bulletFactory = self._bulletFactorys[i]

		bulletFactory:pause()
	end
end

function BasicsPlaneEnemy:resume()
	super.resume(self)

	for i = 1, #self._bulletFactorys do
		local bulletFactory = self._bulletFactorys[i]

		bulletFactory:resume()
	end
end

function BasicsPlaneEnemy:stopBulletCreate()
	for i = 1, #self._bulletFactorys do
		if self._bulletFactorys[i] then
			self._bulletFactorys[i]:closeAllScheduler()
		end
	end
end

function BasicsPlaneEnemy:remove()
	self:stopBulletCreate()
	self:removeBody()

	self._hasBeEffect = false
end

function BasicsPlaneEnemy:removeBody()
	super.remove(self)
end

function BasicsPlaneEnemy:createBodyFadeOut(func)
	local bodyView = self:getBodyView()

	bodyView:runAction(cc.FadeOut:create(0.1))
end

function BasicsPlaneEnemy:clearEnemy()
	self:removeAllBulletFactory()
	self:removeBody()
end

function BasicsPlaneEnemy:hurt(diedFunc, diedFinishFunc)
	super.hurt(self)

	if self:isDied() then
		self:createDiedAnim(function()
			self:removeBody()

			if diedFinishFunc then
				diedFinishFunc()
			end

			if self._enemyType == PlaneEnemyType.kPlane6 then
				AudioEngine:getInstance():playEffect("Se_Effect_Monster_Die")
			end
		end)
		self:getOwner():removeEnemy(self)
		self:stopBulletCreate()

		if not self._hasBeEffect then
			if diedFunc then
				diedFunc(self:getScore())
			end

			self:getOwner():getGameControl():addExtraRewards(self._config.RewardId)

			self._hasBeEffect = true
		end
	elseif not self._stopCreateHurtAnim then
		self:createHurtAnim()
	end
end

local brightnessList = {
	140,
	120,
	100,
	80,
	60,
	50,
	40,
	30,
	20,
	0
}

function BasicsPlaneEnemy:playerHurtSound()
	if self._isPlayingSound then
		return
	end

	self._isPlayingSound = true

	local delay = cc.DelayTime:create(0.5)
	local sequence = cc.Sequence:create(delay, cc.CallFunc:create(function()
		self._isPlayingSound = nil
	end))

	if self._hitEffectId then
		AudioEngine:getInstance():stopEffect(self._hitEffectId)
	end

	self._hitEffectId = AudioEngine:getInstance():playEffect("Se_Effect_Monster_Hit")

	self:getView():runAction(sequence)
end

function BasicsPlaneEnemy:createHurtAnim(func)
	if not self._hurtAnim then
		self._hurtAnim = cc.MovieClip:create("yumaobaodian_dafeijitexiao")

		self._hurtAnim:addTo(self:getView(), PlaneWarConfig.boomZorder):center(self:getView():getContentSize())

		if self._enemyType == PlaneEnemyType.kPlane1 then
			self._hurtAnim:setScale(1.5)
		elseif self._enemyType == PlaneEnemyType.kPlane2 then
			self._hurtAnim:setScale(1.2)
		elseif self._enemyType == PlaneEnemyType.kPlane3 then
			self._hurtAnim:setScale(3)
			self._hurtAnim:offset(-10, 0)
		elseif self._enemyType == PlaneEnemyType.kPlane4 then
			self._hurtAnim:setScale(1.2)
		elseif self._enemyType == PlaneEnemyType.kPlane6 then
			self._hurtAnim:setScale(3)
			self._hurtAnim:offset(0, 20)
		end
	end

	self._hurtAnim:setVisible(true)
	self._hurtAnim:gotoAndPlay(0)

	if self._enemyType == PlaneEnemyType.kPlane6 then
		self._hurtAnim:addEndCallback(function(fid, mc, frameIndex)
			self._hurtAnim:stop()
			self._hurtAnim:setVisible(false)
			self._hurtAnim:removeCallback(fid)

			if func then
				func(self._hurtAnim)
			end
		end)
		self._hurtAnim:addCallbackAtFrame(30, function()
			self._stopCreateHurtAnim = false
		end)
	else
		self._hurtAnim:addEndCallback(function(fid, mc, frameIndex)
			self._stopCreateHurtAnim = false

			self._hurtAnim:stop()
			self._hurtAnim:setVisible(false)
			self._hurtAnim:removeCallback(fid)

			if func then
				func(self._hurtAnim)
			end
		end)
	end

	self:playerHurtSound()

	local frame = {
		1
	}

	for i = 1, #frame do
		self._hurtAnim:addCallbackAtFrame(frame[i], function(fid, mc, frameIndex)
			return
		end)
	end

	self:createBreakOutAnim(self._hurtAnim)
end

function BasicsPlaneEnemy:createBreakOutAnim(anim)
	local bodyAnim = self:getBodyView()

	bodyAnim:setBrightness(0)

	if bodyAnim then
		for i = 1, 10 do
			anim:addCallbackAtFrame(i, function(fid, mc, frameIndex)
				anim:removeCallback(fid)
				bodyAnim:setBrightness(brightnessList[i])
			end)
		end
	end
end

local offsetMap = {
	{
		-70,
		70
	},
	{
		70,
		70
	},
	{
		-70,
		-70
	},
	{
		70,
		-70
	}
}

function BasicsPlaneEnemy:createDiedAnim(func)
	if not self._diedAnim then
		self._diedAnim = cc.MovieClip:create("yumaobaodian_dafeijitexiao")

		self._diedAnim:setPlaySpeed(1.2)
		self._diedAnim:addTo(self:getView(), PlaneWarConfig.boomZorder):center(self:getView():getContentSize())

		if self._enemyType == PlaneEnemyType.kPlane1 then
			self._diedAnim:setScale(1.2)
			self._diedAnim:offset(5, 5)
		elseif self._enemyType == PlaneEnemyType.kPlane2 then
			self._diedAnim:setScale(1)
			self._diedAnim:offset(5, 5)
		elseif self._enemyType == PlaneEnemyType.kPlane3 then
			self._diedAnim:offset(-30, -10)
		elseif self._enemyType == PlaneEnemyType.kPlane4 then
			self._diedAnim:setScale(1.2)
			self._diedAnim:offset(5, 5)
		end
	end

	self._diedAnim:setVisible(true)
	self._diedAnim:gotoAndPlay(1)
	self._diedAnim:setPlaySpeed(1)
	self:createBreakOutAnim(self._diedAnim)

	if self._enemyType == PlaneEnemyType.kPlane3 then
		self._diedAnim:setPlaySpeed(2.5)

		local playTimes = 0
		local startPos = cc.p(self._diedAnim:getPosition())

		self._diedAnim:addEndCallback(function(fid, mc, frameIndex)
			if playTimes == 4 then
				self._diedAnim:stop()
				self._diedAnim:setVisible(false)
				self._diedAnim:removeCallback(fid)

				if func then
					func()
				end
			end

			playTimes = playTimes + 1

			if playTimes > 0 and playTimes <= 4 then
				self._diedAnim:gotoAndPlay(0)

				local offset = offsetMap[playTimes]

				self._diedAnim:setPosition(startPos)
				self._diedAnim:offset(offset[1], offset[2])
				self:createBreakOutAnim(self._diedAnim)
			end

			if playTimes == 4 then
				self:createBodyFadeOut()
			end
		end)
	else
		self._diedAnim:addEndCallback(function(fid, mc, frameIndex)
			self._diedAnim:stop()
			self._diedAnim:setVisible(false)
			self._diedAnim:removeCallback(fid)

			if func then
				func()
			end
		end)
		self:createBodyFadeOut()
	end
end

function BasicsPlaneEnemy:getAppearPlace()
	if self._appearPos then
		return self._appearPos
	end

	local winSize = cc.Director:getInstance():getWinSize()
	local data = self._config.appearPlace
	local y = winSize.height * ((data[1] ~= data[2] or nil) and math.random(data[1], data[2])) / 100

	if y < self:getView():getContentSize().height then
		y = self:getView():getContentSize().height
	end

	local var_30_0

	if y > winSize.height then
		y = winSize.height - self:getView():getContentSize().height
		var_30_0 = winSize.width + self:getView():getContentSize().width
	end

	self._appearPos = cc.p(var_30_0, y)

	return self._appearPos
end

function BasicsPlaneEnemy:move(func)
	local action = PlaneAction:getCompositePlaneAction(self._config.PlaneMoveType, {
		owner = self:getView(),
		type = self:getType()
	}, func)

	if action then
		self:getView():runAction(action)
	end
end

function BasicsPlaneEnemy:getTempRes()
	return "asset/anim/aen.skel"
end

PlaneEnemyKind1 = class("PlaneEnemyKind1", BasicsPlaneEnemy, _M)

function PlaneEnemyKind1:initialize(id, owner)
	super.initialize(self, {
		bounds = QuadtreeBound:new(0, 0, 130, 100, self)
	}, id, owner)

	local bodyImg = sp.SkeletonAnimation:create("asset/anim/huahuoshouhuzhe_mini.skel")

	bodyImg:setScaleX(-1)
	bodyImg:playAnimation(0, "stand", true)
	self:createBodyView(bodyImg):offset(50, -40)
	self:setEnemyType(PlaneEnemyType.kPlane1)
end

function PlaneEnemyKind1:buildBullet(bulletFactory, parent)
	local data = {
		bounds = QuadtreeBound:new(0, 0, 20, 20, self),
		offset = cc.p(10, 10),
		zorder = PlaneWarConfig.BigBulletZorder
	}

	if self._config.BulletMoveType[1] then
		bulletFactory:buildBullet(parent, data, function()
			return cc.p(self:getPositionX() - 30, self:getPositionY() + 10)
		end)
	end
end

PlaneEnemyKind2 = class("PlaneEnemyKind2", BasicsPlaneEnemy, _M)

function PlaneEnemyKind2:initialize(id, owner)
	super.initialize(self, {
		bounds = QuadtreeBound:new(0, 0, 120, 90, self)
	}, id, owner)

	local bodyImg = sp.SkeletonAnimation:create("asset/anim/huahuoshouhuzhe_normal.skel")

	bodyImg:setScaleX(-1)
	bodyImg:playAnimation(0, "stand", true)
	self:createBodyView(bodyImg):offset(63, -31)
	self:setEnemyType(PlaneEnemyType.kPlane2)
end

function PlaneEnemyKind2:buildBullet(bulletFactory, parent)
	local data = {
		bounds = QuadtreeBound:new(0, 0, 20, 20, self),
		offset = cc.p(10, 10)
	}

	if self._config.BulletMoveType[1] then
		bulletFactory:buildBullet(parent, data, function()
			return cc.p(self:getPositionX() - 30, self:getPositionY() + 26)
		end)
	end
end

PlaneEnemyKind3 = class("PlaneEnemyKind3", BasicsPlaneEnemy, _M)

function PlaneEnemyKind3:initialize(id, owner)
	super.initialize(self, {
		bounds = QuadtreeBound:new(0, 0, 340, 200, self)
	}, id, owner)

	local bodyImg = sp.SkeletonAnimation:create("asset/anim/huahuoshouhuzhe_big.skel")

	bodyImg:setScaleX(-1)
	bodyImg:playAnimation(0, "stand", true)
	self:createBodyView(bodyImg):offset(130, -40)
	self:setEnemyType(PlaneEnemyType.kPlane3)
end

function PlaneEnemyKind3:buildBullet(bulletFactory, parent)
	local data = {
		bounds = QuadtreeBound:new(0, 0, 20, 20, self),
		offset = cc.p(10, 10),
		zorder = PlaneWarConfig.BigBulletZorder
	}

	if self._config.BulletMoveType[1] then
		bulletFactory:buildBullet(parent, data, function()
			return cc.p(self:getPositionX() - 60, self:getPositionY() + 168)
		end)
	end
end

PlaneEnemyKind4 = class("PlaneEnemyKind4", BasicsPlaneEnemy, _M)

function PlaneEnemyKind4:initialize(id, owner)
	super.initialize(self, {
		bounds = QuadtreeBound:new(0, 0, 190, 110, self)
	}, id, owner)

	local bodyImg = sp.SkeletonAnimation:create("asset/anim/huahuoshouhuzhe_bag1.skel")

	bodyImg:setScale(-1, 1)
	bodyImg:playAnimation(0, "stand", true)
	self:createBodyView(bodyImg):offset(90, -20)
	self:setEnemyType(PlaneEnemyType.kPlane4)
end

function PlaneEnemyKind4:buildBullet(bulletFactory, parent)
	local data = {
		bounds = QuadtreeBound:new(0, 0, 20, 20, self),
		offset = cc.p(10, 10),
		zorder = PlaneWarConfig.BigBulletZorder
	}

	if self._config.BulletMoveType[1] then
		bulletFactory:buildBullet(parent, data, function()
			return cc.p(self:getPositionX() - 25, self:getPositionY() + 80)
		end)
	end
end

PlaneEnemyKind5 = class("PlaneEnemyKind5", BasicsPlaneEnemy, _M)

function PlaneEnemyKind5:initialize(id, owner)
	super.initialize(self, {
		bounds = QuadtreeBound:new(0, 0, 190, 110, self)
	}, id, owner)

	local bodyImg = sp.SkeletonAnimation:create("asset/anim/huahuoshouhuzhe_bag2.skel")

	bodyImg:setScale(-1, 1)
	bodyImg:playAnimation(0, "stand", true)
	self:createBodyView(bodyImg):offset(90, -20)
	self:setEnemyType(PlaneEnemyType.kPlane5)
end

function PlaneEnemyKind5:buildBullet(bulletFactory, parent)
	local data = {
		bounds = QuadtreeBound:new(0, 0, 20, 20, self),
		offset = cc.p(10, 10),
		zorder = PlaneWarConfig.BigBulletZorder
	}

	if self._config.BulletMoveType[1] then
		bulletFactory:buildBullet(parent, data, function()
			return cc.p(self:getPositionX() - 25, self:getPositionY() + 80)
		end)
	end
end

PlaneEnemyKind6 = class("PlaneEnemyKind6", BasicsPlaneEnemy, _M)

function PlaneEnemyKind6:initialize(id, owner)
	super.initialize(self, {
		bounds = QuadtreeBound:new(0, 0, 190, 110, self)
	}, id, owner)

	local bodyImg = sp.SkeletonAnimation:create("asset/anim/huahuoshouhuzhe_boss.skel")

	bodyImg:setScale(-1, 1)
	bodyImg:playAnimation(0, "stand", true)
	self:createBodyView(bodyImg):offset(90, -20)
	self:setEnemyType(PlaneEnemyType.kPlane6)
end

function PlaneEnemyKind6:buildBullet(bulletFactory, parent)
	local data = {
		bounds = QuadtreeBound:new(0, 0, 20, 20, self),
		offset = cc.p(10, 10),
		zorder = PlaneWarConfig.BigBulletZorder
	}

	if self._config.BulletMoveType[1] then
		bulletFactory:buildBullet(parent, data, function()
			return cc.p(self:getPositionX() - 25, self:getPositionY() + 80)
		end)
	end
end

PlaneEnemyKind7 = class("PlaneEnemyKind7", BasicsPlaneEnemy, _M)

function PlaneEnemyKind7:initialize(id, owner)
	super.initialize(self, {
		bounds = QuadtreeBound:new(0, 0, 50, 50, self)
	}, id, owner)

	local bodyImg = cc.Sprite:createWithSpriteFrameName("img_miniplane_jiangliguai.png")

	self:createBodyView(bodyImg):offset(27, 24)
	self:setEnemyType(PlaneEnemyType.kPlane7)
end

function PlaneEnemyKind7:buildBullet(bulletFactory, parent)
	local data = {
		bounds = QuadtreeBound:new(0, 0, 20, 20, self),
		offset = cc.p(10, 10),
		zorder = PlaneWarConfig.BigBulletZorder
	}

	if self._config.BulletMoveType[1] then
		bulletFactory:buildBullet(parent, data, function()
			return cc.p(self:getPositionX() - 25, self:getPositionY() + 80)
		end)
	end
end

BombPlaneEnemy = class("BombPlaneEnemy", BasicsPlaneEnemy, _M)

function BombPlaneEnemy:initialize(id, owner)
	super.initialize(self, {
		bounds = QuadtreeBound:new(0, 0, 37, 37, self)
	}, id, owner)

	local bodyImg = cc.Sprite:createWithSpriteFrameName("img_miniplane_zhadan.png")

	self:createBodyView(bodyImg):offset(20, 20)
	self:setEnemyType(PlaneEnemyType.kBomb)
end

GoldPlaneEnemy = class("GoldPlaneEnemy", BasicsPlaneEnemy, _M)

function GoldPlaneEnemy:initialize(id, owner)
	super.initialize(self, {
		bounds = QuadtreeBound:new(0, 0, 37, 37, self)
	}, id, owner)

	local bodyImg = cc.Sprite:createWithSpriteFrameName("img_miniplane_jinbi.png")

	self:createBodyView(bodyImg):offset(20, 20)
	self:setEnemyType(PlaneEnemyType.kGold)
end

DiamondPlaneEnemy = class("DiamondPlaneEnemy", BasicsPlaneEnemy, _M)

function DiamondPlaneEnemy:initialize(id, owner)
	super.initialize(self, {
		bounds = QuadtreeBound:new(0, 0, 37, 37, self)
	}, id, owner)

	local bodyImg = cc.Sprite:createWithSpriteFrameName("img_miniplane_baoshi.png")

	self:createBodyView(bodyImg):offset(20, 20)
	self:setEnemyType(PlaneEnemyType.kDiamond)
end

PiecePlaneEnemy = class("PiecePlaneEnemy", BasicsPlaneEnemy, _M)

function PiecePlaneEnemy:initialize(id, owner)
	super.initialize(self, {
		bounds = QuadtreeBound:new(0, 0, 37, 37, self)
	}, id, owner)

	local bodyImg = cc.Sprite:createWithSpriteFrameName("img_miniplane_suipian.png")

	self:createBodyView(bodyImg):offset(20, 20)
	self:setEnemyType(PlaneEnemyType.kPiece)
end
