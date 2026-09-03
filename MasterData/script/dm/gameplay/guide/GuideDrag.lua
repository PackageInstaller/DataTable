-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/guide/GuideDrag.lua

local length_original = 300

GuideDrag = class("GuideDrag", BaseWidget, _M)

function GuideDrag:initialize(data)
	local resFile = "asset/ui/GuideDrag.csb"

	self._view = cc.CSLoader:createNode(resFile)

	self:setupView(data)
	super.initialize(self, self._view)
end

function GuideDrag:dispose()
	super.dispose(self)
end

function GuideDrag:setupView(data)
	if not data.beginPos or not data.endPos then
		return
	end

	local node_body = self._view:getChildByName("Node_body")
	local node_head = self._view:getChildByName("Node_head")
	local node_hand = self._view:getChildByName("Node_hand")
	local image_body = node_body:getChildByName("Image_body")
	local beginPos = data.beginPos
	local endPos = data.endPos
	local length = cc.pGetDistance(beginPos, endPos)
	local scale = (length - 30) / length_original

	node_head:setPositionY(length_original * scale)
	image_body:setScaleX(scale)

	local call = cc.CallFunc:create(function()
		node_hand:setPositionY(0)
	end)

	node_hand:stopAllActions()

	local action = cc.Sequence:create(cc.MoveBy:create(scale, cc.p(0, scale * length_original - 30)), call)

	node_hand:runAction(cc.RepeatForever:create(action))
end
