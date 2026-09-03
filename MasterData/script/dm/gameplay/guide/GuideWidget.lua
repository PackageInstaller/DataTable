-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/guide/GuideWidget.lua

GuideWidget = class("GuideWidget", BaseWidget, _M)

local kArrowRotation = {
	90,
	-90,
	0,
	-40,
	45,
	-90,
	180
}
local kArrowOffset = {
	cc.p(-20, -20),
	cc.p(0, 0),
	cc.p(10, -10),
	cc.p(20, 0),
	cc.p(0, 0),
	cc.p(0, 0),
	(cc.p(-20, 20))
}

function GuideWidget:initialize(data)
	local resFile = "asset/ui/PianoGuideWidget.csb"

	self._view = cc.CSLoader:createNode(resFile)

	self:setupView(data)
	super.initialize(self, self._view)
end

function GuideWidget:dispose()
	super.dispose(self)
end

function GuideWidget:setupView(data)
	local view = self._view

	if not data.style then
		local circle = view:getChildByName("circle")

		self._textBg = view:getChildByName("text_bg")

		local text = self._textBg:getChildByName("text")

		if not data.circleScale then
			local circleScale = 1.2

			text:setTextAreaSize(cc.size(150, 0))

			if data.style == "click" then
				self._circleAnim = cc.MovieClip:create("guangquana_xinshouyindao")
				self._arrowAnim = cc.MovieClip:create("xiaoshou_xinshouyindao")

				local handNode = self._arrowAnim:getChildByName("handNode")

				if handNode then
					local image = ccui.ImageView:create("xsyd_shou.png", ccui.TextureResType.plistType)

					image:addTo(handNode)
				end

				self._arrowAnim:addTo(circle, 1)

				self._orignalPosX, self._orignalPosY = self._arrowAnim:getPosition()

				self._circleAnim:addTo(circle):posite(-5, 5)
			elseif data.style == "drag" then
				self._circleAnim = cc.MovieClip:create("jiantou_xinshouyindao")

				self._circleAnim:addTo(circle):posite(0, 30)
			elseif data.style == "drag2" then
				self._circleAnim = cc.MovieClip:create("jiantoub_xinshouyindao")

				self._circleAnim:addTo(circle):posite(0, 30)
			end

			self._circleAnim:setScale(circleScale)

			self._blockImage = view:getChildByName("block")

			self._textBg:setVisible(false)
		end
	end
end

function GuideWidget:updateView(style, arrowPos, offset, text, hasHand)
	if offset then
		self._arrowAnim:posite(0, 0)
		self._arrowAnim:offset(offset.x, offset.y)

		if self._circleAnim then
			self._circleAnim:posite(-5, 5)
			self._circleAnim:offset(offset.x, offset.y)
		end
	end

	self:updateArrow(arrowPos)

	if style == "big" then
		self._blockImage:setVisible(true)
		self._circleAnim:setVisible(false)
		self._arrowAnim:setVisible(true)
	elseif style == "embattle" then
		self._circleAnim:setVisible(false)
		self._arrowAnim:setVisible(false)
	else
		self._blockImage:setVisible(false)
		self._circleAnim:setVisible(true)
		self._arrowAnim:setVisible(hasHand)
	end
end

function GuideWidget:updateArrow(arrowPos)
	local arrowPos = arrowPos or 3

	if self._arrowAnim then
		self._arrowAnim:setRotation(kArrowRotation[arrowPos])

		local offPos = kArrowOffset[arrowPos]

		self._arrowAnim:offset(offPos.x, offPos.y)
	end
end
