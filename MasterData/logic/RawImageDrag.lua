-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/bag/view/RawImageDrag.lua

module("logic.extensions.bag.view.RawImageDrag", package.seeall)

local RawImageDrag = class("RawImageDrag")
local threshold = 300

function RawImageDrag:ctor(dragContent, rawImg, isLoop)
	self._dragContent = Framework.UIDragTrigger.Get(dragContent)
	self._rawImg1 = rawImg:GetComponent("RawImage")
	self._rawImg2 = self._rawImg1
	self._curImg = self._rawImg1

	Framework.TransformUtil.SetLocalScale(self._rawImg2.transform, 1, 1, 1)
	self._dragContent:AddBeginDragListener(self._onBeginDrag, self)
	self._dragContent:AddEndDragListener(self._onEndDrag, self)
	self._dragContent:AddDragListener(self._onDragging, self)

	self._btn1 = Framework.ButtonAdapter.GetFrom(self._rawImg1.gameObject, "btn_click")
	self._btn2 = Framework.ButtonAdapter.GetFrom(self._rawImg2.gameObject, "btn_click")

	self._btn1:AddClickListener(self._onClickCell, self)
	self._btn2:AddClickListener(self._onClickCell, self)

	self.isDragEnabled = true
	self.isLoop = isLoop
end

function RawImageDrag:setDragEnabled(boo)
	self.isDragEnabled = boo
end

function RawImageDrag:setMaxNum(val)
	self._maxNum = checknumber(val)
end

function RawImageDrag:_onClickCell()
	if self._clickHandler then
		if self._clickHandlerTarget then
			self._clickHandler(self._clickHandlerTarget, index, cell)
		else
			self._clickHandler(index, cell)
		end
	end
end

function RawImageDrag:setUpdateCallback(handler, handlerTarget)
	self._handler = handler
	self._handlerTarget = handlerTarget
end

function RawImageDrag:setClickCallback(handler, handlerTarget)
	self._clickHandler = handler
	self._clickHandlerTarget = handlerTarget
end

function RawImageDrag:_onBeginDrag(eventData)
	if not self.isDragEnabled then
		return
	end
end

function RawImageDrag:centerOnIndex(index, isSpring, isLeft)
	if self._isTweening then
		self:_onTweenFinished()
	end

	self._curIndex = index

	self:_updateCell(index)

	local trans = self._curImg.transform
	local startX, y, z = Framework.TransformUtil.GetLocalPos(trans, 0, 0, 0)

	if not isSpring then
		self:_onTweenFinished()
	else
		local nextCell = self:_getNextCell()

		if isLeft then
			if not -threshold then
				local target = threshold

				self._isTweening = true
				self._tweenFadeIn = TweenUtil.ValueTo(0, 1, 0.2, function(val)
					local x, y, z = Framework.TransformUtil.GetLocalPos(trans, 0, 0, 0)
					local targetPosX = startX + (-target - startX) * val

					Framework.TransformUtil.SetLocalPos(trans, targetPosX, 0, 0)
					Game.ImageUtil.SetRawImageAlpha(self._curImg, (threshold - math.abs(targetPosX)) / threshold)
				end, nil, self)
				self._tweenFadeOut = TweenUtil.ValueTo(0, 1, 0.2, function(val)
					Framework.TransformUtil.SetLocalPos(nextCell.transform, target * (1 - val), 0, 0)
					Game.ImageUtil.SetRawImageAlpha(nextCell, val)
				end, self._onTweenFinished, self)
			end
		end
	end
end

function RawImageDrag:_onTweenFinished(force)
	self._isTweening = false

	if self._tweenFadeOut then
		self._tweenFadeOut:Kill(false)
	end

	if self._tweenFadeIn then
		self._tweenFadeIn:Kill(false)
	end

	self._tweenFadeIn = nil
	self._tweenFadeOut = nil

	local curCell = self._curImg

	self._curImg = self:_getNextCell()

	goutil.setActive(self._curImg.gameObject, true)
	Framework.TransformUtil.SetLocalPos(self._curImg.transform, 0, 0, 0)
	Game.ImageUtil.SetRawImageAlpha(curCell, 1)
end

function RawImageDrag:_onDragging(eventData)
	if not self.isDragEnabled then
		return
	end

	if self._isTweening then
		return
	end

	local trans = self._curImg.transform
	local x, y, z = Framework.TransformUtil.GetLocalPos(trans, 0, 0, 0)

	x = x + eventData.delta.x

	if x >= threshold then
		x = threshold
	elseif x <= -threshold then
		x = -threshold
	end

	Framework.TransformUtil.SetLocalPos(trans, x, y, z)
	Game.ImageUtil.SetRawImageAlpha(self._curImg, (threshold - math.abs(x)) / threshold)
end

function RawImageDrag:_onEndDrag(eventData)
	if not self.isDragEnabled then
		return
	end

	if self._isTweening then
		return
	end

	local trans = self._curImg.transform
	local startX, y, z = Framework.TransformUtil.GetLocalPos(trans, 0, 0, 0)
	local isLeft = startX > 0

	if isLeft then
		if not (self._curIndex - 1) then
			local newIdx = self._curIndex + 1

			if self.isLoop then
				newIdx = 1 + (newIdx - 1) % self._maxNum
			end

			if math.abs(startX) < 100 or newIdx < 1 or newIdx > self._maxNum then
				self._isTweening = true

				local x, y, z = Framework.TransformUtil.GetLocalPos(trans, 0, 0, 0)
				local sss = (threshold - math.abs(x)) / threshold
				local tween = TweenUtil.ValueTo(sss, 1, 0.2, function(val)
					Framework.TransformUtil.SetLocalPos(trans, startX * (1 - val), 0, 0)
					Game.ImageUtil.SetRawImageAlpha(self._curImg, val)
				end, function()
					self._isTweening = false
				end, self)
			else
				self:centerOnIndex(newIdx, true, isLeft)
			end
		end
	end
end

function RawImageDrag:_updateCell(index)
	local cell = self:_getNextCell()

	if self._handler then
		if self._handlerTarget then
			self._handler(self._handlerTarget, index, cell)
		else
			self._handler(index, cell)
		end
	end
end

function RawImageDrag:_getNextCell()
	if self._rawImg1 == self._curImg then
		return self._rawImg2
	else
		return self._rawImg1
	end
end

return RawImageDrag
