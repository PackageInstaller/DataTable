GuideNode = class("GuideNode", function()
	return cc.Node:create()
end)

local guide_data = require("data.guide_data")
local var_0_1 = "Guide/guide_frame.png"

function GuideNode.create(arg_2_0, arg_2_1, arg_2_2)
	local var_2_0 = GuideNode.new()

	var_2_0:init(arg_2_1, arg_2_2)

	return var_2_0
end

function GuideNode:init(arg_3_1, arg_3_2)
	self._guide = arg_3_1
	self._index = nil
	self._closetouch = false
	self._posconf = GuideListener.center
	self._rectconf = GuideListener.fullrect
	self._obj = arg_3_2.obj
	self._nodevisible = true
	self._globalvisible = true

	self:initTouchListener()
	self:initGuideAction()
end

function GuideNode:initTouchListener()
	local var_4_0 = cc.EventListenerTouchOneByOne:create()

	var_4_0:setSwallowTouches(false)
	var_4_0:registerScriptHandler(function(arg_5_0, arg_5_1)
		if cc.rectContainsPoint(self._rectconf, (self:convertTouchToNodeSpace(arg_5_0))) then
			return true
		else
			return false
		end
	end, cc.Handler.EVENT_TOUCH_BEGAN)
	var_4_0:registerScriptHandler(function(arg_6_0, arg_6_1)
		if self._closetouch then
			return
		end

		if not cc.rectContainsPoint(self._rectconf, (self:convertTouchToNodeSpace(arg_6_0))) then
			return
		end

		self._closetouch = true

		LayerManager:getGuideObj():removeGuideElement(self._index)
		self:runAction(cc.RemoveSelf:create())
		GuideListener.finishGuide(self._guide)
	end, cc.Handler.EVENT_TOUCH_ENDED)
	self:getEventDispatcher():addEventListenerWithSceneGraphPriority(var_4_0, self)
end

function GuideNode:initGuideAction()
	local var_7_0 = guide_data[self._guide]

	if guide_data[self._guide].guideaction == GUIDEACTION_FINGER then
		local function var_7_1()
			self:updateGuideNodeConf()
			self:addChild(GuideFinger:create(self._posconf, self._rectconf, var_7_0.showfingercircle), 10)
			self:addGuideFrame()

			self._closetouch = false
		end

		self._closetouch = true

		if guide_data[self._guide].delay then
			self:runAction(cc.Sequence:create(cc.DelayTime:create(guide_data[self._guide].delay), cc.CallFunc:create(var_7_1)))
		else
			var_7_1()
		end
	elseif guide_data[self._guide].guideaction == GUIDEACTION_TIPS then
		local function var_7_2()
			self:updateGuideNodeConf()
			self:addChild(GuideTips:create(var_7_0.text, self._posconf, self._rectconf, var_7_0.tipsflip))
			self:addGuideFrame()

			self._closetouch = false
		end

		self._closetouch = true

		if guide_data[self._guide].delay then
			self:runAction(cc.Sequence:create(cc.DelayTime:create(guide_data[self._guide].delay), cc.CallFunc:create(var_7_2)))
		else
			var_7_2()
		end
	elseif guide_data[self._guide].guideaction == GUIDEACTION_EXPLAIN then
		local function var_7_3()
			self:updateGuideNodeConf()
			self:addChild(GuideExplain:create(var_7_0.text, var_7_0.explainmodel, var_7_0.explainmodeloffset, self._posconf, self._rectconf, var_7_0.explainpos, var_7_0.sound))
			self:addChild(GuideFinger:create(self._posconf, self._rectconf, var_7_0.showfingercircle), 10)
			self:addGuideFrame()

			self._closetouch = false
		end

		self._closetouch = true

		if guide_data[self._guide].delay then
			self:runAction(cc.Sequence:create(cc.DelayTime:create(guide_data[self._guide].delay), cc.CallFunc:create(var_7_3)))
		else
			var_7_3()
		end
	elseif guide_data[self._guide].guideaction == GUIDEACTION_TALK then
		local function var_7_4()
			self:updateGuideNodeConf()
			self:addChild(TalkLayer:create(var_7_0.talkid, nil, TALK_TYPE_NORMAL, "", function()
				LayerManager:getGuideObj():removeGuideElement(self._index)
				self:runAction(cc.RemoveSelf:create())
				GuideListener.finishGuide(self._guide)
			end), 999)
			self:addChild(GuideFinger:create(self._posconf, self._rectconf, var_7_0.showfingercircle), 10)
			self:addGuideFrame()

			self._closetouch = false
		end

		self._closetouch = true

		if guide_data[self._guide].delay then
			self:runAction(cc.Sequence:create(cc.DelayTime:create(guide_data[self._guide].delay), cc.CallFunc:create(var_7_4)))
		else
			var_7_4()
		end
	elseif guide_data[self._guide].guideaction == GUIDEACTION_ALERT then
		local function var_7_5()
			self:updateGuideNodeConf()

			local var_13_0

			if config._DEBUG then
				var_13_0 = cc.Sprite:create(var_7_0.alerticon) or cc.Sprite:createWithSpriteFrameName(var_7_0.alerticon)
			end

			var_13_0:setPosition(cc.p(self._posconf.x + (var_7_0.alertoffsetX or 0), self._posconf.y + (var_7_0.alertoffsetY or 0)))
			self:addChild(var_13_0, 100)

			self._closetouch = false
		end

		self._closetouch = true

		if guide_data[self._guide].delay then
			self:runAction(cc.Sequence:create(cc.DelayTime:create(guide_data[self._guide].delay), cc.CallFunc:create(var_7_5)))
		else
			var_7_5()
		end
	end
end

function GuideNode.updateIndex(arg_14_0, arg_14_1)
	arg_14_0._index = arg_14_1
end

function GuideNode:setNodeVisible(arg_15_1)
	self._nodevisible = arg_15_1

	self:setVisible(self._nodevisible and self._globalvisible)
end

function GuideNode:setGlobalVisible(arg_16_1)
	self._globalvisible = arg_16_1

	self:setVisible(self._nodevisible and self._globalvisible)
end

local function var_0_2(arg_17_0)
	if not arg_17_0 then
		return {
			pos = GuideListener.center,
			boundingbox = GuideListener.fullrect
		}
	end

	if tolua.isnull(arg_17_0) then
		return {
			pos = GuideListener.center,
			boundingbox = GuideListener.fullrect
		}
	end

	local var_17_0 = GuideListener.convertToGuideSpace(arg_17_0:getParent(), cc.p(arg_17_0:getPosition()))
	local var_17_1 = arg_17_0:getBoundingBox()
	local var_17_2 = arg_17_0:getAnchorPoint()

	return {
		pos = cc.p(var_17_0.x - (var_17_2.x - 0.5) * var_17_1.width, var_17_0.y - (var_17_2.y - 0.5) * var_17_1.height),
		boundingbox = var_17_1
	}
end

function GuideNode:updateGuideNodeConf()
	local var_18_0 = var_0_2(self._obj)

	self._posconf = var_18_0.pos
	self._rectconf = cc.rect(var_18_0.pos.x - var_18_0.boundingbox.width / 2, var_18_0.pos.y - var_18_0.boundingbox.height / 2, var_18_0.boundingbox.width, var_18_0.boundingbox.height)
end

function GuideNode:addGuideFrame()
	if not guide_data[self._guide].useframe then
		return
	end

	local var_19_0 = self._posconf
	local var_19_1 = self._rectconf
	local var_19_2

	if config._DEBUG then
		var_19_2 = cc.Scale9Sprite:create(var_0_1) or cc.Scale9Sprite:createWithSpriteFrameName(var_0_1)
	end

	var_19_2:setAnchorPoint(cc.p(0.5, 0.5))
	var_19_2:setPosition(var_19_0)
	var_19_2:setCapInsets(cc.rect(50, 25, 50, 20))
	var_19_2:setPreferredSize(cc.size(var_19_1.width + 38, var_19_1.height + 38))
	self:addChild(var_19_2, 1)
end
