-- chunkname: @/tmp/or_script/lua_compile/dm/gameupdate/view/UpdateToast.lua

local tipbgPath = "tips.png"
local bgw = 160
local bgh = 50
local capInsetsx = 13
local capInsets = 13
local capInsetw = 13
local capInseth = 13
local kMaxLabelWidth = 500
local tmpX = 3
local tmpY = 0

local function tipView(text)
	local toastView = cc.Node:create()

	text = text or ""

	local label = ccui.RichText:createWithXML(text, {})

	label:ignoreContentAdaptWithSize(true)
	label:rebuildElements()
	label:formatText()
	label:setAnchorPoint(cc.p(0.5, 0.5))
	label:renderContent()
	label:offset(0, tmpY)

	local labelSize = label:getContentSize()

	if labelSize.width > kMaxLabelWidth then
		label:ignoreContentAdaptWithSize(false)
		label:setContentSize(cc.size(kMaxLabelWidth, 0))
		label:renderContent()
		label:offset(1, 0)

		labelSize = label:getContentSize()
	end

	local w = labelSize.width + 20
	local h = labelSize.height + 10

	label:setIgnoreAnchorPointForPosition(false)
	toastView:addChild(label)
	label:setColor(cc.c3b(255, 255, 255))

	local bgWidth = w > bgw and w or bgw

	tmpX = w > bgw and 0 or 3

	local bgHeight = h > bgh and h or bgh
	local bgColor = cc.c4b(0, 0, 0, 255)

	if style and style.bgColor ~= nil then
		bgColor = cc.c4b(style.bgColor.r, style.bgColor.g, style.bgColor.b, style.bgColor.a or 255)
	end

	local bgLayer = cc.LayerColor:create(bgColor, bgWidth, bgHeight)

	bgLayer:setPosition(0, 0)
	bgLayer:setAnchorPoint(cc.p(0.5, 0.5))
	bgLayer:setIgnoreAnchorPointForPosition(false)

	local capInsets = cc.rect(capInsetsx, capInsets, capInsetw, capInseth)
	local tipSprite = ccui.Scale9Sprite:createWithSpriteFrameName(tipbgPath)

	tipSprite:setScale9Enabled(true)
	tipSprite:setCapInsets(capInsets)
	tipSprite:setAnchorPoint(cc.p(0.5, 0.5))
	tipSprite:setContentSize(cc.size(bgWidth, bgHeight))
	tipSprite:setPosition(tmpX, tmpY)
	toastView:addChild(tipSprite, -1)
	toastView:setContentSize(cc.size(bgWidth, bgHeight))

	local touchNode = ccui.Widget:create()

	touchNode:setAnchorPoint(0.5, 0.5)
	touchNode:setContentSize(cc.size(bgWidth, bgHeight))
	touchNode:setPosition(tmpX, tmpY)
	toastView:addChild(touchNode, -1)

	toastView.label = label
	toastView.touchNode = touchNode

	return toastView
end

if not UpdateToast then
	local UpdateToast = {}

	function UpdateToast:new(text)
		local result = setmetatable({}, {
			__index = UpdateToast
		})

		result:initialize(text)

		return result
	end

	function UpdateToast:initialize(text)
		self._view = tipView(text)
	end

	function UpdateToast:getView()
		return self._view
	end

	function UpdateToast:dispose(...)
		return
	end

	function UpdateToast:setup(parentLayer, options)
		self._duration = options.duration or 0.2
		self._delay = options.delay or 1
		self._options = options

		local view = self:getView()

		view:setCascadeOpacityEnabled(true)
		parentLayer:addChild(self:getView(), 1001)
		view:setPosition(0, 0)

		return true
	end

	function UpdateToast:startAnimation(endCallback)
		local view = self:getView()

		view:setOpacity(0)
		view:setPosition(0, 0)

		local inDuration = self._duration
		local moveUpAct = cc.MoveBy:create(inDuration, cc.p(0, 80))
		local fade_in = cc.FadeIn:create(inDuration)
		local moveFadeAct = cc.Spawn:create(moveUpAct, fade_in)
		local delayAction = cc.DelayTime:create(self._delay)
		local fade_out = cc.FadeOut:create(0.5)
		local callbackFunc = cc.CallFunc:create(function()
			view:removeFromParent()
			endCallback(self)
		end)
		local action = cc.Speed:create(cc.Sequence:create(moveFadeAct, delayAction, fade_out, callbackFunc), 1)

		view:runAction(action)
	end

	return UpdateToast
end
