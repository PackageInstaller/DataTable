-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/chat/view/PlayerVipWidget.lua

PlayerVipWidget = class("PlayerVipWidget", BaseWidget, _M)

function PlayerVipWidget.class:createWidgetNode()
	local resFile = "asset/ui/vip.csb"

	return cc.CSLoader:createNode(resFile)
end

function PlayerVipWidget:initialize(view)
	super.initialize(self, view)
	self:initSubviews(view)
end

function PlayerVipWidget:dispose()
	super.dispose(self)
end

function PlayerVipWidget:initSubviews(view)
	self._view = view

	self._view:setVisible(false)

	self._vipLevel = view:getChildByFullName("viplabel")
end

function PlayerVipWidget:getView()
	return self._view
end

function PlayerVipWidget:updateView(level)
	if level > 0 then
		self._view:setVisible(true)
		self._vipLevel:setString(level)
	else
		self._view:setVisible(false)
	end
end

PlayerVipWidgetExtend = class("PlayerVipWidgetExtend", BaseWidget, _M)

function PlayerVipWidgetExtend.class:createWidgetNode()
	local resFile = "asset/ui/vipex.csb"

	return cc.CSLoader:createNode(resFile)
end

function PlayerVipWidgetExtend:initialize(view)
	super.initialize(self, view)
	self:initSubviews(view)
end

function PlayerVipWidgetExtend:dispose()
	super.dispose(self)
end

function PlayerVipWidgetExtend:initSubviews(view)
	self._view = view

	self._view:setVisible(false)

	self._vipLevel = view:getChildByFullName("viplabel")

	self._vipLevel:enableOutline(cc.c4b(116, 69, 2, 255), 1)
	self._vipLevel:enableShadow(cc.c4b(0, 0, 0, 0), cc.size(-2, -1), 1)
end

function PlayerVipWidgetExtend:getView()
	return self._view
end

function PlayerVipWidgetExtend:updateView(level)
	if level > 0 then
		self._view:setVisible(true)
		self._vipLevel:setString(level)
	else
		self._view:setVisible(false)
	end
end
