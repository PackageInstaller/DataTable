GuideClippingNode = class("GuideClippingNode", function()
	return cc.Node:create()
end)

local var_0_0 = config._DEBUG and 0 or 1
local guide_data = require("data.guide_data")

function GuideClippingNode.create(arg_2_0, arg_2_1, arg_2_2)
	local var_2_0 = GuideClippingNode.new()

	var_2_0:init(arg_2_1, arg_2_2)

	return var_2_0
end

function GuideClippingNode:init(arg_3_1, arg_3_2)
	self._guide = arg_3_1
	self._index = nil
	self._closetouch = true
	self._posconf = GuideListener.center
	self._rectconf = GuideListener.fullrect
	self._obj = arg_3_2.obj

	if guide_data[arg_3_1].shelter == 1 then
		self._shelterconf = arg_3_2.shelterconf or {}
	end

	self._nodevisible = true
	self._globalvisible = true

	self:initSwallowButton()
	self:initClipping()
	self:initGuideAction()
end

function GuideClippingNode:initSwallowButton()
	local var_4_0 = ccui.Button:create("public/panelbg/text_bg.png", "public/panelbg/text_bg.png", "public/panelbg/text_bg.png", var_0_0)

	var_4_0:setScale9Enabled(true)
	var_4_0:setContentSize(cc.size(GameDisplay.width, GameDisplay.height))
	var_4_0:setAnchorPoint(cc.p(0, 0))
	var_4_0:setPosition(cc.p(-GameDisplay.fix_x, -GameDisplay.fix_y))
	var_4_0:setOpacity(0)
	var_4_0:setSwallowTouches(true)
	var_4_0:addTouchEventListener(function(arg_5_0, arg_5_1)
		if arg_5_1 ~= ccui.TouchEventType.ended then
			return
		end

		if self._closetouch then
			return
		end

		if not cc.rectContainsPoint(self._rectconf, self:convertToNodeSpace(arg_5_0:getTouchEndPosition())) then
			return
		end

		self._closetouch = true

		self:getParent():removeGuideElement(self._index, true)
		self:runAction(cc.RemoveSelf:create())
		GuideListener.finishGuide(self._guide)
		KeyCodeManager:setKeyCodeEventlock(false)
	end)

	self._touchBtn = var_4_0

	self:addChild(var_4_0)
end

local function var_0_2(arg_6_0)
	local var_6_0, var_6_1 = arg_6_0:match("(.+),(.+)")

	return cc.p(tonumber(var_6_0), tonumber(var_6_1))
end

local function var_0_3(arg_7_0)
	if not arg_7_0 then
		return nil
	end

	local var_7_0, var_7_1 = arg_7_0:match("(%d+),(%d+)")

	return cc.size(tonumber(var_7_0), tonumber(var_7_1))
end

local function var_0_4(arg_8_0)
	if not arg_8_0 then
		return {
			pos = GuideListener.center,
			boundingbox = GuideListener.fullrect
		}
	end

	if tolua.isnull(arg_8_0) then
		return {
			pos = GuideListener.center,
			boundingbox = GuideListener.fullrect
		}
	end

	local var_8_0 = GuideListener.convertToGuideSpace(arg_8_0:getParent(), cc.p(arg_8_0:getPosition()))
	local var_8_1 = arg_8_0:getBoundingBox()
	local var_8_2 = arg_8_0:getAnchorPoint()

	return {
		pos = cc.p(var_8_0.x - (var_8_2.x - 0.5) * var_8_1.width, var_8_0.y - (var_8_2.y - 0.5) * var_8_1.height),
		boundingbox = var_8_1
	}
end

function GuideClippingNode:initClipping()
	local function var_9_0()
		self:updateGuideNodeConf()

		local var_10_0 = {
			pos = self._posconf,
			rect = self._rectconf
		}
		local var_10_1
		local var_10_2

		if self._shelterconf then
			var_10_1 = {}

			local var_10_3 = guide_data[self._guide]

			if self._shelterconf.pos then
				local var_10_4 = cc.p(var_10_0.pos.x + self._shelterconf.pos.x, var_10_0.pos.y + self._shelterconf.pos.y)
				local var_10_5

				if var_10_3.sheltersize then
					local var_10_6 = var_0_3(var_10_3.sheltersize)

					var_10_5 = cc.rect(var_10_4.x - var_10_6.width / 2, var_10_4.y - var_10_6.height / 2, var_10_6.width, var_10_6.height)
				else
					var_10_5 = var_10_0.rect
				end

				var_10_1.pos = var_10_4
				var_10_1.rect = var_10_5
			elseif self._shelterconf.obj then
				local var_10_7 = var_0_4(self._shelterconf.obj)

				if self._shelterconf.offset then
					var_10_7.pos.x = var_10_7.pos.x + self._shelterconf.offset.x
					var_10_7.pos.y = var_10_7.pos.y + self._shelterconf.offset.y
				end

				local var_10_8 = var_0_3(var_10_3.sheltersize) or var_10_7.boundingbox

				var_10_1.rect, var_10_1.pos = cc.rect(var_10_7.pos.x - var_10_8.width / 2, var_10_7.pos.y - var_10_8.height / 2, var_10_8.width, var_10_8.height), var_10_7.pos
			else
				local var_10_9 = var_10_0.pos
				local var_10_10

				if var_10_3.sheltersize then
					local var_10_11 = var_0_3(var_10_3.sheltersize)

					var_10_10 = cc.rect(var_10_9.x - var_10_11.width / 2, var_10_9.y - var_10_11.height / 2, var_10_11.width, var_10_11.height)
				else
					var_10_10 = var_10_0.rect
				end

				var_10_1.pos = var_10_9
				var_10_1.rect = var_10_10
			end

			var_10_1.resource = var_10_3.resource
			var_10_1.alphathreshold = var_10_3.alpha
			var_10_1.shelterdelay = var_10_3.shelterdelay
		end

		if guide_data[self._guide].useframe then
			var_10_2 = {}

			if var_10_1 then
				var_10_2.pos = var_10_1.pos
				var_10_2.rect = var_10_1.rect
			else
				var_10_2.pos = cc.p(var_10_0.pos.x, var_10_0.pos.y)

				if guide_data[self._guide].shelterpos then
					local var_10_12 = var_0_2(guide_data[self._guide].shelterpos)

					var_10_2.pos.x = var_10_2.pos.x + var_10_12.x
					var_10_2.pos.y = var_10_2.pos.y + var_10_12.y
				end

				if guide_data[self._guide].sheltersize then
					local var_10_13 = var_0_3(guide_data[self._guide].sheltersize)

					var_10_2.rect = cc.rect(var_10_2.pos.x - var_10_13.width / 2, var_10_2.pos.y - var_10_13.height / 2, var_10_13.width, var_10_13.height)
				else
					var_10_2.rect = var_10_0.rect
				end
			end
		end

		self:addChild(GuideClipping:create(var_10_0, var_10_1, var_10_2), 1)
	end

	if guide_data[self._guide].delay then
		self:runAction(cc.Sequence:create(cc.DelayTime:create(guide_data[self._guide].delay), cc.CallFunc:create(var_9_0)))
	else
		var_9_0()
	end
end

function GuideClippingNode:initGuideAction()
	local var_11_0 = guide_data[self._guide]

	self._closetouch = true

	self._touchBtn:setSwallowTouches(true)

	if guide_data[self._guide].guideaction == GUIDEACTION_FINGER then
		local function var_11_1()
			self:updateGuideNodeConf()
			self:addChild(GuideFinger:create(self._posconf, self._rectconf, var_11_0.showfingercircle), 10)

			self._closetouch = false

			self._touchBtn:setSwallowTouches(false)
		end

		if guide_data[self._guide].delay then
			self:runAction(cc.Sequence:create(cc.DelayTime:create(guide_data[self._guide].delay), cc.CallFunc:create(var_11_1)))
		else
			var_11_1()
		end
	elseif guide_data[self._guide].guideaction == GUIDEACTION_TIPS then
		local function var_11_2()
			self:updateGuideNodeConf()
			self:addChild(GuideTips:create(var_11_0.text, self._posconf, self._rectconf), 10)

			self._closetouch = false

			self._touchBtn:setSwallowTouches(false)
		end

		if guide_data[self._guide].delay then
			self:runAction(cc.Sequence:create(cc.DelayTime:create(guide_data[self._guide].delay), cc.CallFunc:create(var_11_2)))
		else
			var_11_2()
		end
	elseif guide_data[self._guide].guideaction == GUIDEACTION_EXPLAIN then
		local function var_11_3()
			self:updateGuideNodeConf()
			self:runAction(cc.Sequence:create(cc.DelayTime:create(0.4 + (var_11_0.shelterdelay or 0)), cc.CallFunc:create(function()
				self:addChild(GuideExplain:create(var_11_0.text, var_11_0.explainmodel, var_11_0.explainmodeloffset, self._posconf, self._rectconf, var_11_0.explainpos, var_11_0.sound), 10)
			end), cc.DelayTime:create(0.2), cc.CallFunc:create(function()
				self:addChild(GuideFinger:create(self._posconf, self._rectconf, var_11_0.showfingercircle), 11)

				self._closetouch = false

				self._touchBtn:setSwallowTouches(false)
			end)))
		end

		if guide_data[self._guide].delay then
			self:runAction(cc.Sequence:create(cc.DelayTime:create(guide_data[self._guide].delay), cc.CallFunc:create(var_11_3)))
		else
			var_11_3()
		end
	elseif guide_data[self._guide].guideaction == GUIDEACTION_TALK then
		local function var_11_4()
			self:updateGuideNodeConf()
			self:runAction(cc.Sequence:create(cc.DelayTime:create(0.4 + (var_11_0.shelterdelay or 0)), cc.CallFunc:create(function()
				self:addChild(TalkLayer:create(var_11_0.talkid, nil, TALK_TYPE_NORMAL, "", function()
					self:getParent():removeGuideElement(self._index, true)
					self:runAction(cc.RemoveSelf:create())
					GuideListener.finishGuide(self._guide)
					KeyCodeManager:setKeyCodeEventlock(false)
				end), 999)
			end), cc.DelayTime:create(0.2), cc.CallFunc:create(function()
				self:addChild(GuideFinger:create(self._posconf, self._rectconf, var_11_0.showfingercircle), 11)

				self._closetouch = false

				self._touchBtn:setSwallowTouches(false)
			end)))
		end

		if guide_data[self._guide].delay then
			self:runAction(cc.Sequence:create(cc.DelayTime:create(guide_data[self._guide].delay), cc.CallFunc:create(var_11_4)))
		else
			var_11_4()
		end
	end
end

function GuideClippingNode.updateIndex(arg_21_0, arg_21_1)
	arg_21_0._index = arg_21_1
end

function GuideClippingNode:setNodeVisible(arg_22_1)
	self._nodevisible = arg_22_1

	self:setVisible(self._nodevisible and self._globalvisible)
end

function GuideClippingNode:setGlobalVisible(arg_23_1)
	self._globalvisible = arg_23_1

	self:setVisible(self._nodevisible and self._globalvisible)
end

function GuideClippingNode:updateGuideNodeConf()
	local var_24_0 = var_0_4(self._obj)

	self._posconf = var_24_0.pos
	self._rectconf = cc.rect(var_24_0.pos.x - var_24_0.boundingbox.width / 2, var_24_0.pos.y - var_24_0.boundingbox.height / 2, var_24_0.boundingbox.width, var_24_0.boundingbox.height)
end
