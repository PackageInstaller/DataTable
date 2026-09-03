-- chunkname: @/tmp/or_script/lua_compile/dm/base/view/toasts/ToastViewFactory.lua

local tippointPath = "common_bg_tips_1.png"
local tipbgPath = "common_bg_tips_2.png"
local bgw = 353
local bgh = 41
local capInsetsx = 13
local capInsets = 13
local capInsetw = 13
local capInseth = 13

function tipView(text)
	local toastView = cc.Node:create()

	text = text or ""

	local data = string.split(text, "<font")

	if #data <= 1 then
		text = Strings:get("ToastTipRichText_Text", {
			text = text,
			fontName = TTF_FONT_FZYH_M
		})
	end

	local label = ccui.RichText:createWithXML(text, {})

	label:setScale(0.9)
	label:ignoreContentAdaptWithSize(true)
	label:rebuildElements()
	label:formatText()
	label:setAnchorPoint(cc.p(0.5, 0.5))
	label:renderContent()

	local labelSize = label:getContentSize()
	local w = labelSize.width + 20
	local h = labelSize.height + 10

	label:setIgnoreAnchorPointForPosition(false)
	toastView:addChild(label)
	label:setColor(cc.c3b(255, 255, 255))

	local bgWidth = w > bgw and w or bgw
	local bgHeight = h > bgh and h or bgh
	local bgColor = cc.c4b(0, 0, 0, 255)

	if style and style.bgColor ~= nil then
		bgColor = cc.c4b(style.bgColor.r, style.bgColor.g, style.bgColor.b, style.bgColor.a or 255)
	end

	local bgLayer = cc.LayerColor:create(bgColor, bgWidth, bgHeight)

	bgLayer:setPosition(0, 0)
	bgLayer:setAnchorPoint(cc.p(0.5, 0.5))
	bgLayer:setIgnoreAnchorPointForPosition(false)

	local pointImg = ccui.ImageView:create(tippointPath, ccui.TextureResType.plistType)

	pointImg:setAnchorPoint(cc.p(0.5, 0.5))
	pointImg:setPosition(-15, labelSize.height / 2)
	label:addChild(pointImg)

	local capInsets = cc.rect(capInsetsx, capInsets, capInsetw, capInseth)
	local tipSprite = ccui.Scale9Sprite:createWithSpriteFrameName(tipbgPath)

	tipSprite:setScale9Enabled(false)
	tipSprite:setCapInsets(capInsets)
	tipSprite:setAnchorPoint(cc.p(0.5, 0.5))
	tipSprite:setContentSize(cc.size(bgWidth, bgHeight))
	tipSprite:setScaleX(math.max(bgWidth / bgw, 1))
	toastView:addChild(tipSprite, -1)
	toastView:setContentSize(cc.size(bgWidth, bgHeight))

	local touchNode = ccui.Widget:create()

	touchNode:setAnchorPoint(0.5, 0.5)
	touchNode:setContentSize(cc.size(bgWidth, bgHeight))
	toastView:addChild(touchNode, -1)

	toastView.label = label
	toastView.touchNode = touchNode

	return toastView
end
