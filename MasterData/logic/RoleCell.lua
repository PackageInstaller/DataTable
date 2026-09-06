-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/jumpfloor/view/game/RoleCell.lua

module("logic.extensions.jumpfloor.view.game.RoleCell", package.seeall)

local RoleCell = class("RoleCell")

function RoleCell:ctor(mainGo)
	self._mainGo = mainGo
	self._roleCellRect = self._mainGo:GetComponent(goutil.Type_RectTransform)
	self._shieldGo = goutil.findChild(self._mainGo, "shield")
	self._rawImage = goutil.findChildComponent(self._mainGo, "img", ComponentType.RawImage)

	goutil.setActive(self._shieldGo, false)
	goutil.setActive(self._mainGo, true)
end

function RoleCell:setAnchoredPosition(anchoredPosition)
	self._roleCellRect.anchoredPosition = anchoredPosition
end

function RoleCell:getAnchoredPosition()
	return self._roleCellRect.anchoredPosition
end

function RoleCell:getLocalPosition()
	return self._roleCellRect.localPosition
end

function RoleCell:doJumpAnchorPos(targetPos, duration, heightTopY)
	local jumpPower = 30

	self._roleCellTweenX = self._roleCellRect:DOAnchorPosX(targetPos.x, duration)

	local heightY = heightTopY + jumpPower
	local halfDuration = duration / 2
	local isMoveUp = self._roleCellRect.anchoredPosition.y <= targetPos.y

	if isMoveUp then
		if not DG.Tweening.Ease.OutQuart then
			local InEase = DG.Tweening.Ease.InQuart

			if isMoveUp then
				if not DG.Tweening.Ease.InQuart then
					local OutEase = DG.Tweening.Ease.OutQuart

					self._roleCellTweenY1 = self._roleCellRect:DOAnchorPosY(heightY, halfDuration):SetEase(InEase)
					self._roleCellTweenY2 = self._roleCellRect:DOAnchorPosY(targetPos.y, halfDuration):SetDelay(halfDuration):SetEase(OutEase)

					return self._roleCellTweenX, self._roleCellTweenY1, self._roleCellTweenY2
				end
			end
		end
	end
end

function RoleCell:onJumpAnchorComplete()
	if self._roleCellTweenX then
		self._roleCellTweenX:OnComplete(function()
			local distance = -1000
			local endPos = self._roleCellRect.anchoredPosition + Vector2.New(0, distance)

			self._roleCellRect:DOAnchorPos(endPos, BaseJumpFloorGame.DropTime)
		end)
	end
end

function RoleCell:setShieldActive(isShow)
	goutil.setActive(self._shieldGo, isShow)
end

function RoleCell:reset()
	if self._roleCellTweenX then
		self._roleCellTweenX:Kill()

		self._roleCellTweenX = nil
	end

	if self._roleCellTweenY1 then
		self._roleCellTweenY1:Kill()

		self._roleCellTweenY1 = nil
	end

	if self._roleCellTweenY2 then
		self._roleCellTweenY2:Kill()

		self._roleCellTweenY2 = nil
	end

	if self._tweenOnDead then
		self._tweenOnDead:Kill()

		self._tweenOnDead = nil
	end

	goutil.setActive(self._shieldGo, false)

	self._rawImage.color = Color.white
	self._roleCellRect.anchoredPosition = Vector2.New(-2000, -2000)
end

function RoleCell:doTweenOnDead(onComplete)
	local duration = 0.15
	local loopCount = 4
	local loopType = DG.Tweening.LoopType.Yoyo

	self._tweenOnDead = self._rawImage:DOColor(Color.red, duration):SetLoops(loopCount, loopType):OnComplete(onComplete)
end

return RoleCell
