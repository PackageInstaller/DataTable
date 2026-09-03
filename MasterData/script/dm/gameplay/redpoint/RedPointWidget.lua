-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/redpoint/RedPointWidget.lua

BaseRedPoint = class("BaseRedPoint", BaseWidget, _M)

function BaseRedPoint:initialize(view, parent, checkFunc, notAutoRefresh)
	super.initialize(self, view)
	assert(checkFunc ~= nil, "`checkFunc` must NOT be nil")

	self._parent = parent
	self._checkFunc = checkFunc

	if parent == nil then
		if view:getParent() == nil then
			assert(false, "parent and view:getParent is nil")
		end
	else
		view:addTo(parent, 999)
		ccext.positeWithRelPosition(view, parent:getContentSize(), {
			1,
			1
		})
	end

	view:atExit(function()
		self:dispose()
	end)
	self:refresh()

	if not notAutoRefresh then
		RedPointManager:getInstance():registerObject(self)
	end
end

function BaseRedPoint:dispose()
	super.dispose(self)
end

function BaseRedPoint:setScale(scale)
	self._view:setScale(scale)
end

function BaseRedPoint:offset(x, y)
	self._view:offset(x, y)

	return self
end

function BaseRedPoint:posite(x, y)
	self._view:posite(x, y)

	return self
end

function BaseRedPoint:refresh()
	assert(false, "override me!!")
end

RedPoint = class("RedPoint", BaseRedPoint, _M)

function RedPoint.class:createDefaultNode(image)
	if image then
		return cc.Sprite:createWithSpriteFrameName(image)
	end

	return cc.Sprite:createWithSpriteFrameName(IconFactory.redPointPath)
end

function RedPoint:initialize(view, parent, checkFunc, notAutoRefresh)
	super.initialize(self, view, parent, checkFunc, notAutoRefresh)
end

function RedPoint:refresh()
	local view = self._view
	local checkFunc = self._checkFunc
	local isVisible = checkFunc()

	view:setVisible(isVisible)
end

NumberRedPoint = class("NumberRedPoint", BaseRedPoint, _M)

function NumberRedPoint.class:createDefaultNode(isQuard)
	local imgName = isQuard and "btn_hongdian.png" or "btn_hongdian.png"
	local node = cc.Sprite:createWithSpriteFrameName(imgName)
	local numberText = ccui.Text:create("", TTF_FONT_FZYH_R, 16)

	numberText:addTo(node):center(node:getContentSize()):offset(-2, 0):setName("number_text"):enableOutline(cc.c4b(0, 0, 0, 125), 2)

	return node
end

function NumberRedPoint:initialize(view, parent, checkFunc, notAutoRefresh)
	super.initialize(self, view, parent, checkFunc, notAutoRefresh)
end

function NumberRedPoint:refresh()
	local view = self._view
	local checkFunc = self._checkFunc
	local isVisible, number, maxNum, minNum = checkFunc()

	view:setVisible(isVisible)

	local numberText = view:getChildByFullName("number_text")

	if number == "" then
		numberText:setFontSize(18)
		numberText:setString(number)
	elseif number == nil or number <= 0 then
		view:setVisible(false)
	elseif number <= 99 then
		numberText:setFontSize(18)
		numberText:setString(number)
	else
		numberText:setFontSize(15)
		numberText:setString("99+")
	end
end
