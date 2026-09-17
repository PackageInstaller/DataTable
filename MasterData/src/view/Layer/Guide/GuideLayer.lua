GuideLayer = class("GuideLayer", function()
	return cc.Layer:create()
end)

require("view.Layer.Guide.GuideNode")
require("view.Layer.Guide.GuideClipping")
require("view.Layer.Guide.GuideClippingNode")
require("view.Layer.Guide.GuideTips")
require("view.Layer.Guide.GuideExplain")
require("view.Layer.Guide.GuideFinger")
require("view.Layer.Guide.GuideFullScreenNode")

local guide_data = require("data.guide_data")
local var_0_1 = 1
local var_0_2 = 2
local var_0_3 = 3

function GuideLayer.create(arg_2_0)
	local var_2_0 = GuideLayer.new()

	var_2_0:init()

	return var_2_0
end

local var_0_4 = {
	insert = function(self, ...)
		local var_3_0 = {
			...
		}

		if #var_3_0 == 1 then
			table.insert(self, var_3_0[1])
			self[#self]:updateIndex(#self)
		elseif #var_3_0 == 2 then
			table.insert(self, var_3_0[1], var_3_0[2])

			for iter_3_0 = var_3_0[1], #self do
				self[iter_3_0]:updateIndex(iter_3_0)
			end
		end
	end,
	remove = function(self, arg_4_1)
		for iter_4_0 = arg_4_1, #self do
			self[iter_4_0]:updateIndex(iter_4_0)
		end

		return (table.remove(self, arg_4_1))
	end,
	clean = function(arg_5_0)
		for iter_5_0, iter_5_1 in pairs(arg_5_0) do
			arg_5_0[iter_5_0] = nil
		end
	end
}

function GuideLayer:init()
	self.swallow = false

	self:initSwallowToucheEvent()

	self._fullscreenqueue = {}
	self._fullscreenguide = nil
	self._elementguide = setmetatable({}, {
		__index = var_0_4
	})
	self._showelements = true
	self._hiderect = nil
	self._showallguides = true
	self._existclipping = false
end

function GuideLayer:initSwallowToucheEvent()
	local var_7_0 = cc.EventListenerTouchOneByOne:create()

	var_7_0:setSwallowTouches(true)
	var_7_0:registerScriptHandler(function(arg_8_0, arg_8_1)
		return self.swallow
	end, cc.Handler.EVENT_TOUCH_BEGAN)
	var_7_0:registerScriptHandler(function(arg_9_0, arg_9_1)
		return
	end, cc.Handler.EVENT_TOUCH_ENDED)
	self:getEventDispatcher():addEventListenerWithSceneGraphPriority(var_7_0, self)
end

function GuideLayer.swallowEvent(arg_10_0, arg_10_1)
	arg_10_0.swallow = arg_10_1
end

function GuideLayer:addGuide(arg_11_1, arg_11_2)
	AnalyticManager.begin_guide({
		guideID = arg_11_1
	})

	if guide_data[arg_11_1].guideaction == GUIDEACTION_SNAP then
		self:pushFullScreenGuide(arg_11_1)
	elseif guide_data[arg_11_1].guideaction == GUIDEACTION_ANI then
		self:pushFullScreenGuide(arg_11_1)
	elseif guide_data[arg_11_1].guideaction == GUIDEACTION_EXPLAIN and guide_data[arg_11_1].explainfullscreen then
		self:pushFullScreenGuide({
			guideID = arg_11_1,
			conf = arg_11_2
		})
	elseif guide_data[arg_11_1].guideaction == GUIDEACTION_TALK and guide_data[arg_11_1].explainfullscreen then
		self:pushFullScreenGuide({
			guideID = arg_11_1,
			conf = arg_11_2
		})
	elseif arg_11_2 ~= nil then
		self:addElementGuide(arg_11_1, arg_11_2)
	else
		print("Error: guide " .. arg_11_1 .. " need triggerlayer and uiname")
	end
end

function GuideLayer:pushFullScreenGuide(arg_12_1)
	table.insert(self._fullscreenqueue, arg_12_1)

	if not self._fullscreenguide then
		self._fullscreenguide = GuideFullScreenNode:create()

		self:addChild(self._fullscreenguide, var_0_3)

		if not self._showallguides then
			self._fullscreenguide:setVisible(false)
		end
	end
end

function GuideLayer:popNextFullScreenGuide()
	return table.remove(self._fullscreenqueue, 1)
end

function GuideLayer:onFullScreenEvent(arg_14_1)
	if arg_14_1 == "enter" then
		self:showAllGuides(false)
		KeyCodeManager:setKeyCodeEventlock(true)
	elseif arg_14_1 == "exit" then
		self:showAllGuides(true)

		self._fullscreenguide = nil

		KeyCodeManager:setKeyCodeEventlock(false)
	end
end

function GuideLayer:addElementGuide(arg_15_1, arg_15_2)
	local var_15_0 = guide_data[arg_15_1]

	if guide_data[arg_15_1].swallowtouch then
		if self._existclipping then
			print("there is only one clipping guide node allowed in a layer")

			return
		end

		assert(var_15_0.guideaction ~= GUIDEACTION_ALERT, "Are you fuck kidding me???")

		local var_15_1 = GuideClippingNode:create(arg_15_1, arg_15_2)

		self:showGuideElement(var_15_1)
		self:addChild(var_15_1, var_0_2)
		self._elementguide:insert(var_15_1)

		self._existclipping = true

		KeyCodeManager:setKeyCodeEventlock(true)
	elseif var_15_0.guideaction == GUIDEACTION_ALERT then
		local var_15_2 = GuideNode:create(arg_15_1, arg_15_2)

		self:showGuideElement(var_15_2)
		var_15_2:setPosition(arg_15_2.obj:convertToNodeSpace(cc.p(0, 0)))
		arg_15_2.obj:addChild(var_15_2, 100)
		self._elementguide:insert(var_15_2)
	else
		local var_15_3 = GuideNode:create(arg_15_1, arg_15_2)

		self:showGuideElement(var_15_3)
		self:addChild(var_15_3, var_0_1)
		self._elementguide:insert(var_15_3)
	end
end

function GuideLayer:removeGuideElement(arg_16_1, arg_16_2)
	self._elementguide:remove(arg_16_1)

	if arg_16_2 then
		self._existclipping = false
	end
end

function GuideLayer:cleanCurGuides()
	for iter_17_0, iter_17_1 in pairs(self._elementguide) do
		iter_17_1:runAction(cc.RemoveSelf:create())
	end

	self._elementguide:clean()

	if self._fullscreenguide then
		self._fullscreenguide:exit()

		self._fullscreenguide = nil
	end

	self._fullscreenqueue = {}
	self._existclipping = false
end

function GuideLayer:showAllGuides(arg_18_1)
	self._showelements = arg_18_1

	for iter_18_0, iter_18_1 in pairs(self._elementguide) do
		self:showGuideElement(iter_18_1)
	end
end

function GuideLayer:showGuidesInRect(arg_19_1, arg_19_2)
	self._hiderect = not arg_19_1 and arg_19_2 or nil

	for iter_19_0, iter_19_1 in pairs(self._elementguide) do
		self:showGuideElement(iter_19_1)
	end
end

function GuideLayer:showGuideElement(arg_20_1)
	if not self._showallguides then
		arg_20_1:setGlobalVisible(false)

		return
	end

	if not self._showelements then
		arg_20_1:setGlobalVisible(false)

		return
	end

	if self._hiderect and cc.rectContainsPoint(self._hiderect, arg_20_1._posconf) then
		arg_20_1:setGlobalVisible(false)

		return
	end

	arg_20_1:setGlobalVisible(true)
end

function GuideLayer:showAllGuidesWithFullScreen(arg_21_1)
	self._showallguides = arg_21_1

	for iter_21_0, iter_21_1 in pairs(self._elementguide) do
		self:showGuideElement(iter_21_1)
	end

	if self._fullscreenguide then
		self._fullscreenguide:setVisible(arg_21_1)
	end
end
