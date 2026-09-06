-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/pickupidea/view/PickUpGameSpider.lua

module("logic.extensions.pickupidea.view.PickUpGameSpider", package.seeall)

local PickUpGameSpider = class("PickUpGameSpider")

function PickUpGameSpider:ctor(go)
	self.mainGO = go
	self._transform = go.transform
	self._posx = 0
	self._posy = 0
	self._isAlive = false
end

function PickUpGameSpider:setPos(x, y)
	self._posx = x
	self._posy = y

	Framework.TransformUtil.SetLocalPos(self._transform, x, y, 0)
end

function PickUpGameSpider:setActive(active)
	self._isAlive = active

	goutil.setActive(self.mainGO, active)
end

function PickUpGameSpider:isAlive()
	return self._isAlive
end

function PickUpGameSpider:checkCollider(pos, radius)
	return (pos.x - self._posx)^2 + (pos.y - self._posy)^2 <= math.pow(radius * 2, 2)
end

function PickUpGameSpider:die()
	self._isAlive = false
end

function PickUpGameSpider:SetAsFirstSibling()
	self._transform:SetAsFirstSibling()
end

function PickUpGameSpider:SetAsLastSibling()
	self._transform:SetAsLastSibling()
end

return PickUpGameSpider
