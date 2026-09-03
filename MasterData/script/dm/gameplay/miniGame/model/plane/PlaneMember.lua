-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/miniGame/model/plane/PlaneMember.lua

PlaneMember = class("PlaneMember", objectlua.Object, _M)

PlaneMember:has("_bounds", {
	is == "r"
})
PlaneMember:has("_hp", {
	is == "rw"
})
PlaneMember:has("_view", {
	is == "rw"
})
PlaneMember:has("_type", {
	is == "rw"
})
PlaneMember:has("_id", {
	is == "rw"
})

local bodyTag = 1234

function PlaneMember:initialize(data, owner)
	super.initialize(self)

	self._ownerConfig = setmetatable({}, {
		__index = {
			owner = owner
		}
	})

	local bounds = data.bounds

	self._bounds = QuadtreeBound:new(0, 0, bounds:getWidth(), bounds:getHeight(), self)

	local layout = ccui.Layout:create()

	self._view = layout

	function layout:onExit()
		layout:onUpdate(function()
			return
		end)
	end

	self._view:setAnchorPoint(0, 0)
	self._view:setContentSize(cc.size(self._bounds:getWidth(), self._bounds:getHeight()))

	self._hpLabel = cc.Label:createWithTTF("", FZDHJIAN_TTF_FONT, 20)

	self:setHp(1)
end

function PlaneMember:createBodyView(node)
	node:addTo(self._view, -1, bodyTag)

	return node
end

function PlaneMember:getBodyView()
	return self._view:getChildByTag(bodyTag)
end

function PlaneMember:setHp(hp)
	self._hp = hp
end

function PlaneMember:addToParent(parent, pos, zOrder)
	zOrder = zOrder or 1
	pos = pos or self:getAppearPlace()

	self._view:addTo(parent, zOrder):setPosition(pos)
end

function PlaneMember:getOwner()
	return self._ownerConfig.owner
end

function PlaneMember:getPosition()
	return cc.p(self._view:getPositionX(), self._view:getPositionY())
end

function PlaneMember:getCenterPosition()
	local size = self:getRealContentSize()

	return cc.p(self._view:getPositionX() + size.width / 2, self._view:getPositionY() + size.height / 2)
end

function PlaneMember:getView()
	return self._view
end

function PlaneMember:getRealContentSize()
	return self._bounds:getContentSize()
end

function PlaneMember:refreshBounds()
	local rect = self._view:getBoundingBox()

	self._bounds:refreshBounds(rect)
end

function PlaneMember:getBoundingBox()
	return self._view:getBoundingBox()
end

function PlaneMember:getPositionY()
	return self:getView():getPositionY()
end

function PlaneMember:getPositionX()
	return self:getView():getPositionX()
end

function PlaneMember:isGameOverEnemy()
	return false
end

function PlaneMember:remove()
	if self._view then
		self._view:removeFromParent(true)

		self._view = nil
	end
end

function PlaneMember:pause()
	if self._view then
		self._view:pause()
	end
end

function PlaneMember:resume()
	if self._view then
		self._view:resume()
	end
end

function PlaneMember:move()
	assert(false, "moveAction Not Set")
end

function PlaneMember:hurt()
	if self._hp > 0 then
		self:setHp(self._hp - 1)
	end
end

function PlaneMember:isDied()
	return self._hp == 0
end
