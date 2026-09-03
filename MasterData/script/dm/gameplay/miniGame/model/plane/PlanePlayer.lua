-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/miniGame/model/plane/PlanePlayer.lua

require("dm.gameplay.miniGame.model.plane.PlaneMember")

PlanePlayer = class("PlanePlayer", PlaneMember, _M)

local kSpeicalName = "kSpeicalName_Plane"

function PlanePlayer:getTempRes()
	return "asset/anim/swmxue_feixing.skel"
end

function PlanePlayer:initialize(owner, bulletActionConfig, gameController)
	self._gameController = gameController

	super.initialize(self, {
		bounds = QuadtreeBound:new(0, 0, 30, 30)
	}, owner)
	self:setType(PlaneMemberType.kPlayer)

	local bodyImg = sp.SkeletonAnimation:create(self:getTempRes())

	bodyImg:playAnimation(0, "stand", true)
	bodyImg:setScale(0.7)
	self:createBodyView(bodyImg):center(cc.size(30, 30)):offset(0, -70)

	self._bulletFactory = PlayerBulletFactory:new(bulletActionConfig, PlaneMemberType.kPlayerButtle, gameController)

	bodyImg:setName(kSpeicalName)
end

function PlanePlayer:move(location)
	local director = cc.Director:getInstance()
	local winSize = director:getWinSize()

	if not director:isPaused() then
		local mainPanel = self:getView()
		local playerPosX = self:getPositionX()
		local playerPosY = self:getPositionY()
		local realSize = self:getRealContentSize()
		local canMove = location.x >= realSize.width / 2

		if location.x > winSize.width - realSize.width / 2 then
			canMove = false
		end

		if location.y < realSize.height / 2 then
			canMove = false
		end

		if (location.y > winSize.height - realSize.height / 2 or nil) and false then
			mainPanel:setPosition(location)
		end
	end
end

function PlanePlayer:build(parent)
	local winSize = cc.Director:getInstance():getWinSize()
	local realSize = self:getRealContentSize()

	self:addToParent(parent, cc.p(realSize.width + 66, winSize.height / 2 - 10), PlaneWarConfig.playerZorder)
	self:addBullet(parent)
end

local posX = {
	0,
	40,
	0
}

function PlanePlayer:addBullet(parent)
	self._bulletFactory:buildBullet(parent, function(index)
		index = index or 1

		return cc.p(self:getPositionX() + posX[index], self:getPositionY() - 10 - (index - 1) * 20 + 25)
	end)
end

function PlanePlayer:addPlayerDoubleBullet(parent, time)
	self._bulletFactory:addPlayerDoubleBullet(parent, {
		imgPath = "img_miniplane_zidan04.png",
		bounds = QuadtreeBound:new(0, 0, 40, 10, self),
		offset = cc.p(15, 5)
	}, function()
		return cc.p(self:getPositionX() - 50, self:getPositionY() + 150 + 25)
	end, time)
end

function PlanePlayer:getBullets()
	return self._bulletFactory:getBulletList()
end

function PlanePlayer:hurt(func)
	super.hurt(self)

	if self:isDied() then
		self:createDiedAnim(func)
		self:remove()
	end
end

function PlanePlayer:createDiedAnim(func)
	if not self._diedAnim then
		self._diedAnim = cc.MovieClip:create("zidanxiaobaodian_dafeijitexiao")

		self._diedAnim:setPlaySpeed(1.2)
		self._diedAnim:addTo(self:getView():getParent()):setPosition(self:getView():getPosition())
	end

	self._diedAnim:setVisible(true)
	self._diedAnim:gotoAndPlay(1)
	self._diedAnim:addEndCallback(function(fid, mc, frameIndex)
		self._diedAnim:stop()
		self._diedAnim:setVisible(false)
		self._diedAnim:removeCallback(fid)

		if func then
			func()
		end
	end)
end

function PlanePlayer:remove()
	self._bulletFactory:remove()
	super.remove(self)
end

function PlanePlayer:pause()
	self._bulletFactory:pause()
	super.pause(self)
end

function PlanePlayer:resume()
	if self._gameController:getIsGameOver() then
		return
	end

	self._bulletFactory:resume()
	super.resume(self)
end
