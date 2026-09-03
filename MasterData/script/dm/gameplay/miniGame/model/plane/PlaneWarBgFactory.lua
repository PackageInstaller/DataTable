-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/miniGame/model/plane/PlaneWarBgFactory.lua

require("dm.gameplay.miniGame.model.plane.PlaneWarBg")
require("dm.gameplay.miniGame.model.plane.PlaneWarCloud")

PlaneWarBgFactory = class("PlaneWarBgFactory", objectlua.Object, _M)

function PlaneWarBgFactory:initialize(mainNode, gameController)
	do return end

	self._gameController = gameController

	super.initialize(self)

	self._mainNode = mainNode

	local winSize = cc.Director:getInstance():getWinSize()

	self._anim1 = cc.MovieClip:create("shuye_feijichangjing")

	self._anim1:addTo(mainNode, 10):posite(600, 140)

	self._anim2 = cc.MovieClip:create("shuyebb_feijichangjing")

	self._anim2:addTo(mainNode, 10):posite(600, 140)
	self:stopAnim()

	self._bgList = {}
	self._planeWarBg1 = PlaneWarBg:new(mainNode, {
		imgPath2 = "asset/ui/miniplane/miniplanebg2.png",
		changeWidth = 5,
		imgPath1 = "asset/ui/miniplane/miniplanebg2.png",
		posY = -80
	}, self._gameController)
	self._bgList[#self._bgList + 1] = self._planeWarBg1
	self._planeWarBg2 = PlaneWarBg:new(mainNode, {
		imgPath2 = "asset/ui/miniplane/miniplanebg4.png",
		changeWidth = 10,
		imgPath1 = "asset/ui/miniplane/miniplanebg4.png",
		posY = -50
	}, self._gameController)
	self._bgList[#self._bgList + 1] = self._planeWarBg2
	self._planeWarBg3 = PlaneWarBg:new(mainNode, {
		imgPath2 = "asset/ui/miniplane/miniplanebg1.png",
		changeWidth = 60,
		imgPath1 = "asset/ui/miniplane/miniplanebg1.png",
		posY = -120
	}, self._gameController)
	self._bgList[#self._bgList + 1] = self._planeWarBg3
	self._planeWarBg4 = PlaneWarBg:new(mainNode, {
		imgPath2 = "asset/ui/miniplane/miniplanebg3.png",
		changeWidth = 15,
		imgPath1 = "asset/ui/miniplane/miniplanebg3.png",
		posY = 250
	}, self._gameController)
	self._bgList[#self._bgList + 1] = self._planeWarBg4
end

function PlaneWarBgFactory:stopAnim()
	do return end

	self._anim1:stop()
	self._anim2:stop()
end

function PlaneWarBgFactory:playAnim()
	do return end

	self._anim1:play()
	self._anim2:play()
end

function PlaneWarBgFactory:build()
	do return end

	for i = 1, #self._bgList do
		self._bgList[i]:build()
	end

	self:playAnim()
end

function PlaneWarBgFactory:remove()
	do return end

	for i = 1, #self._bgList do
		self._bgList[i]:remove()
	end
end

function PlaneWarBgFactory:pause()
	do return end

	self._stop = true

	for i = 1, #self._bgList do
		self._bgList[i]:pause()
	end

	self:stopAnim()
end

function PlaneWarBgFactory:resume()
	do return end

	self._stop = false

	for i = 1, #self._bgList do
		self._bgList[i]:resume()
	end

	self:playAnim()
end
