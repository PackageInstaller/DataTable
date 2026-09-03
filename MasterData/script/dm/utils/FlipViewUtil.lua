-- chunkname: @/tmp/or_script/lua_compile/dm/utils/FlipViewUtil.lua

FlipViewUtil = class("FlipViewUtil", objectlua.Object)

FlipViewUtil:has("_flipTime", {
	is = "rw"
})

local function helpCreateLayout()
	local layout = ccui.Layout:create()

	layout:setAnchorPoint(cc.p(0.5, 0.5))
	layout:setPosition(cc.p(0, 0))
	layout:setContentSize(cc.size(100, 100))

	return layout
end

function FlipViewUtil:initialize(data)
	super.initialize(self)

	self._pageCount = 0
	self._curPageTag = -1
	self._flipTime = 0.2
	self._view = cc.Node:create()
	self._backView = nil
	self._faceView = nil
	self._touchView = nil
	self._delegate = data.delegate

	self:initBaseLayout(data.size)
end

function FlipViewUtil:getView()
	return self._view
end

function FlipViewUtil:initBaseLayout(size)
	self._backView = helpCreateLayout()
	self._faceView = helpCreateLayout()

	self._backView:addTo(self._view)
	self._faceView:addTo(self._view)

	local _size = size or cc.size(200, 200)
	local layout = ccui.Layout:create()

	layout:setAnchorPoint(cc.p(0.5, 0.5))
	layout:setPosition(cc.p(0, 0))
	layout:setContentSize(_size)
	layout:addTo(self._view)
	layout:setSwallowTouches(false)

	self._touchView = layout

	local function callFunc(sender, eventType)
		if self._isDragging then
			return
		end

		if eventType == ccui.TouchEventType.canceled then
			self:dealTouchView(1)
		elseif eventType == ccui.TouchEventType.ended then
			local beganPos = sender:getTouchBeganPosition()
			local endPos = sender:getTouchEndPosition()

			if math.abs(endPos.x - beganPos.x) > 20 then
				self:dealTouchView(endPos.x - beganPos.x)
			elseif self._delegate.viewTouchEvent then
				self._delegate:viewTouchEvent(self._curPageTag)
			end
		end
	end

	mapButtonHandlerClick(nil, layout, {
		ignoreClickAudio = true,
		eventType = 4,
		func = callFunc
	})
end

function FlipViewUtil:reloadData()
	self._pageCount = self._delegate:getPageCount()

	if self._pageCount > 1 then
		self._touchView:setTouchEnabled(true)
	elseif self._pageCount == 1 then
		self._touchView:setTouchEnabled(true)
	else
		self._touchView:setTouchEnabled(false)

		return
	end

	self._curPageTag = 1

	self:_resetView()
	self:loadFaceView()

	if self._delegate.flipEndCallBack then
		self._delegate:flipEndCallBack(self._faceView:getChildByTag(1024), self._curPageTag)
	end
end

function FlipViewUtil:_resetView()
	self._backView:setLocalZOrder(1)
	self._faceView:setLocalZOrder(2)
	self._backView:setScaleX(-1)
	self._faceView:setScaleX(1)
	self._backView:setVisible(false)
	self._faceView:setVisible(true)
end

function FlipViewUtil:_adjustIndex(tag)
	if tag > self._pageCount then
		return 1
	end

	if tag < 1 then
		return self._pageCount + tag
	end

	return tag
end

function FlipViewUtil:loadFaceView()
	self._faceView:removeAllChildren()

	local _faceView = self._delegate:getPageByIndex(self._curPageTag)

	_faceView:addTo(self._faceView):center(cc.size(100, 100)):setTag(1024)
end

function FlipViewUtil:loadBackView(backViewIndex)
	local backView = self._faceView:isVisible() and self._backView or self._faceView

	backView:removeAllChildren()

	local _backView = self._delegate:getPageByIndex(backViewIndex)

	_backView:addTo(backView, 1, 1024):center(cc.size(100, 100))
end

function FlipViewUtil:dealTouchView(value)
	self._isDragging = true

	local backViewIndex = value < 0 and self:_adjustIndex(self._curPageTag - 1) or self:_adjustIndex(self._curPageTag + 1)

	self:loadBackView(backViewIndex)
	self:runFlipAction(value, backViewIndex)
end

function FlipViewUtil:runFlipAction(value, backViewIndex)
	local cardBack, cardFace

	if self._faceView:isVisible() then
		cardFace = self._faceView
		cardBack = self._backView
	else
		cardFace = self._backView
		cardBack = self._faceView
	end

	local act1 = cc.Sequence:create(cc.DelayTime:create(0.2), cc.Show:create(), cc.DelayTime:create(0.2), cc.Show:create())
	local act2 = cc.ScaleBy:create(0.5, -1, 1)
	local backAct = cc.Spawn:create(act1, act2)

	cardBack:runAction(backAct)

	local act3 = cc.Sequence:create(cc.DelayTime:create(0.2), cc.Hide:create(), cc.DelayTime:create(0.2), cc.Hide:create())
	local act4 = cc.ScaleBy:create(0.5, -1, 1)
	local faceAct = cc.Sequence:create(cc.Spawn:create(act3, act4), cc.CallFunc:create(function()
		self._curPageTag = backViewIndex

		if self._delegate.flipEndCallBack then
			self._delegate:flipEndCallBack(cardBack:getChildByTag(1024), self._curPageTag)
		end

		cardFace:setLocalZOrder(1)
		cardBack:setLocalZOrder(2)

		self._isDragging = false
	end))

	cardFace:runAction(faceAct)
end

function FlipViewUtil:autoFlipView()
	if self._isDragging then
		return false
	end

	self:dealTouchView(1)

	return true
end
