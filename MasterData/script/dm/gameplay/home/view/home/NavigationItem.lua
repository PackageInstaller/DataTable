-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/home/view/home/NavigationItem.lua

NavigationItem = class("NavigationItem", objectlua.Object, _M)

NavigationItem:has("_node", {
	is = "rw"
})
NavigationItem:has("_pX", {
	is = "rw"
})
NavigationItem:has("_pY", {
	is = "rw"
})
NavigationItem:has("_aniRatio", {
	is = "rw"
})

function NavigationItem:initialize(node, data)
	super.initialize(self)

	self._node = node
	self._aniRatio = 0.020833333333333332
	self._pX, self._pY = node:getPosition()
	self._winSize = cc.Director:getInstance():getWinSize()
	self._data = data

	if self._data.flash then
		dump(self._data.flash, "self._data.flash")

		local mc = cc.MovieClip:create(self._data.flash)

		mc:setPosition(cc.p(5, -6))
		self._node:addChild(mc)
	end
end

function NavigationItem:rightOpen()
	if self._data.isSpecial then
		self._node:runAction(cc.MoveTo:create(self._aniRatio * 30, cc.p(self._pX, self._pY)))

		return
	else
		local actionSeq = {}

		actionSeq[#actionSeq + 1] = cc.MoveTo:create(self._aniRatio * 40, cc.p(self._pX, self._pY))
		actionSeq[#actionSeq + 1] = cc.DelayTime:create(0.15)
		actionSeq[#actionSeq + 1] = cc.MoveTo:create(self._aniRatio * 10, cc.p(self._pX - 10, self._pY))
		actionSeq[#actionSeq + 1] = cc.MoveTo:create(self._aniRatio * 10, cc.p(self._pX, self._pY))

		self._node:runAction(cc.Sequence:create(unpack(actionSeq)))
	end
end

function NavigationItem:rightClose()
	if self._data.isSpecial then
		self._node:runAction(cc.MoveTo:create(self._aniRatio * 30, cc.p(self._winSize.width, self._pY)))

		return
	else
		local actionSeq = {}

		actionSeq[#actionSeq + 1] = cc.MoveTo:create(self._aniRatio * 10, cc.p(self._pX - 10, self._pY))
		actionSeq[#actionSeq + 1] = cc.MoveTo:create(self._aniRatio * 10, cc.p(self._pX, self._pY))
		actionSeq[#actionSeq + 1] = cc.DelayTime:create(0.15)
		actionSeq[#actionSeq + 1] = cc.MoveTo:create(self._aniRatio * 40, cc.p(self._winSize.width, self._pY))

		self._node:runAction(cc.Sequence:create(unpack(actionSeq)))
	end
end

function NavigationItem:bottomOpen()
	local easeBackOutAni = cc.EaseBackOut:create(cc.MoveTo:create(self._aniRatio * 30, cc.p(self._pX, self._pY)))

	easeBackOutAni:update(1)

	local ani = cc.Sequence:create(cc.DelayTime:create(0), easeBackOutAni)

	self._node:runAction(ani)
end

function NavigationItem:bottomClose()
	local easeBackOutAni = cc.EaseBackIn:create(cc.MoveTo:create(self._aniRatio * 30, cc.p(self._pX, self._pY - 150)))

	easeBackOutAni:update(1)

	local ani = cc.Sequence:create(cc.DelayTime:create(0), easeBackOutAni)

	self._node:runAction(ani)
end

function NavigationItem:topClose()
	local cfg = self._data.close
	local easeBackOutAni = cc.EaseBackIn:create(cc.MoveTo:create(self._aniRatio * 30, cc.p(self._winSize.width, self._pY)))

	easeBackOutAni:update(1)

	local ani = cc.Sequence:create(cc.DelayTime:create(cfg.delayTime), easeBackOutAni)

	self._node:runAction(ani)
end

function NavigationItem:topOpen()
	local cfg = self._data.open
	local easeBackOutAni = cc.EaseBackOut:create(cc.MoveTo:create(self._aniRatio * 30, cc.p(self._pX, self._pY)))

	easeBackOutAni:update(1)

	local ani = cc.Sequence:create(cc.DelayTime:create(cfg.delayTime), easeBackOutAni)

	self._node:runAction(ani)
end

function NavigationItem:leftClose()
	self._node:runAction(cc.MoveTo:create(self._aniRatio * 30, cc.p(-80, self._pY)))
end

function NavigationItem:leftOpen()
	self._node:runAction(cc.MoveTo:create(self._aniRatio * 30, cc.p(self._pX, self._pY)))
end
