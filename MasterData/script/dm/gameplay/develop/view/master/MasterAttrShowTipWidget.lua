-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/develop/view/master/MasterAttrShowTipWidget.lua

MasterAttrShowTipWidget = class("MasterAttrShowTipWidget", BaseWidget, _M)

local allHeight1 = 294
local allHeight = 223
local cellHeight = 32

function MasterAttrShowTipWidget.class:createWidgetNode()
	local resFile = "asset/ui/MasterAttrShowTip.csb"

	return cc.CSLoader:createNode(resFile)
end

function MasterAttrShowTipWidget:initialize(view)
	super.initialize(self, view)
	self:initSubviews(view)
end

function MasterAttrShowTipWidget:dispose()
	self._closeView = true

	super.dispose(self)
end

function MasterAttrShowTipWidget:initSubviews(view)
	self._view = view

	self._view:setVisible(false)

	self._touchPanel = view:getChildByFullName("touchPanel")

	self._touchPanel:setSwallowTouches(false)

	self._backImg = view:getChildByFullName("backimg")
	self._titleImg = view:getChildByFullName("image")
	self._attrNode = cc.Node:create()

	self._attrNode:addTo(self._view)

	self._titleLabel = self._titleImg:getChildByFullName("text1")
	self._innerWidth = self._backImg:getContentSize().width
	self._attrNodeY = 0
	self._backImgY = self._backImg:getPositionY()
	self._titleImgY = self._titleImg:getPositionY()

	self._touchPanel:addClickEventListener(function()
		if self._view:isVisible() then
			self._view:setVisible(false)
		end
	end)
end

function MasterAttrShowTipWidget:showAttribute(role, titleStr)
	local valueName = getAttName()
	local value, icons = getAttNumber(role)
	local data = {}

	for i = 1, #valueName do
		data[#data + 1] = {
			attrType = Strings:get(valueName[i]),
			attrNum = value[i],
			attrIcon = icons[i]
		}
	end

	titleStr = titleStr or ""

	self._titleLabel:setString(titleStr)
	self._attrNode:removeAllChildren()

	for i = 1, #data do
		local panel = self:createAttrPanel(data[i].attrType, data[i].attrNum, data[i].attrIcon)

		panel:addTo(self._attrNode)
		panel:setPosition(i % 2 == 0 and 222 or 1, allHeight - (i % 2 == 0 and i / 2 - 1 or math.ceil(i / 2) - 1) * cellHeight)
	end

	self._backImg:setContentSize(cc.size(self._innerWidth, math.ceil(#data / 2) * cellHeight + 68))
end

function MasterAttrShowTipWidget:createAttrPanel(attrType, attrNum, attrIcon)
	local layout = ccui.Layout:create()
	local label1 = cc.Label:createWithTTF(attrType, TTF_FONT_FZYH_M, 18)

	label1:setColor(cc.c3b(255, 255, 255))
	label1:setAnchorPoint(0, 0.5)
	GameStyle:setCommonOutlineEffect(label1, 255)

	local label2 = cc.Label:createWithTTF(attrNum, TTF_FONT_FZYH_M, 18)

	label2:setColor(cc.c3b(169, 239, 20))
	label2:setAnchorPoint(0, 0.5)
	GameStyle:setCommonOutlineEffect(label2, 255)
	layout:setContentSize(cc.size(232, cellHeight))
	layout:setAnchorPoint(cc.p(0, 0.5))
	label1:addTo(layout):posite(32, 16)
	label2:addTo(layout):posite(label1:getPositionX() + label1:getContentSize().width + 4, 16)

	if attrIcon ~= "" then
		local icon = ccui.ImageView:create(attrIcon, 1)

		icon:setAnchorPoint(0, 0.5)
		icon:addTo(layout):posite(0, 18)
	end

	return layout
end

function MasterAttrShowTipWidget:adjustPositionY()
	local offsetY = allHeight1 - self._backImg:getContentSize().height

	self._attrNode:setPositionY(self._attrNodeY - offsetY)
	self._backImg:setPositionY(self._backImgY - offsetY)
	self._titleImg:setPositionY(self._titleImgY - offsetY)
end
