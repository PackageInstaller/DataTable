-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/pickupidea/view/PickUpGameBgCell.lua

module("logic.extensions.pickupidea.view.PickUpGameBgCell", package.seeall)

local PickUpGameBgCell = class("PickUpGameBgCell")

function PickUpGameBgCell:ctor(go, row, col)
	self._mainGO = go
	self._transform = go.transform
	self._posx = 0
	self._posy = 0
	self._sizeX = 100
	self._sizeY = 100
	self._isCanCollider = false
	self._row = row
	self._col = col
	self._isDanger = false
	self._initBgIdx = math.random(1, 2) - 1
	self._change = go:GetComponent(ComponentType.UIImageSpriteChange)

	self._change:SetState(self._initBgIdx)

	self._dangerImgIndex = 2
end

function PickUpGameBgCell:setPos(x, y)
	self._posx = x
	self._posy = y

	Framework.TransformUtil.SetLocalPos(self._transform, x, y, 0)
end

function PickUpGameBgCell:getPos()
	return self._posx, self._posy
end

function PickUpGameBgCell:resetNormal()
	self._isDanger = false

	self._change:SetState(self._initBgIdx)
end

function PickUpGameBgCell:playWarning()
	self._isCanCollider = false

	local startVal = 0
	local endVal = 1
	local duration = 2
	local luaTarget = self
	local easeType = DG.Tweening.Ease.Linear
	local stepVal = 0
	local count = 0
	local modNum = 10
	local halfModNum = modNum / 2

	local function updateHander(val)
		count = count + 1
		stepVal = count % modNum

		if stepVal <= halfModNum then
			self._change:SetState(self._dangerImgIndex)
		else
			self._change:SetState(self._initBgIdx)
		end
	end

	local function endHander()
		self._change:SetState(self._dangerImgIndex)
		self:_activeBlock()
	end

	self._tweenOfShow = TweenUtil.ValueTo(startVal, endVal, duration, updateHander, endHander, luaTarget, easeType)
end

function PickUpGameBgCell:_activeBlock()
	self._isCanCollider = true
	self._isDanger = true

	GlobalDispatcher:dispatch(GlobalNotify.PickUpIdeaBlockActive, self._row, self._col)
end

function PickUpGameBgCell:checkCollider(triggerPosV2, radius)
	if not self._isCanCollider then
		return false
	end

	local v_x = math.abs(triggerPosV2.x - self._posx)
	local v_y = math.abs(triggerPosV2.y - self._posy)
	local h_x = PickupideagameView.BgCellSpaceX / 2
	local h_y = PickupideagameView.BgCellSpaceY / 2
	local u_x = v_x - h_x < 0 and 0 or v_x - h_x
	local u_y = v_y - h_y < 0 and 0 or v_y - h_y

	return u_x * u_x + u_y * u_y <= radius * radius
end

function PickUpGameBgCell:isDanger()
	return self._isDanger
end

function PickUpGameBgCell:getRolCol()
	return self._row, self._col
end

return PickUpGameBgCell
