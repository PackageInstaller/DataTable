SchoolCinemalTalkLayer = class("SchoolCinemalTalkLayer", function()
	return cc.Layer:create()
end)

local photo_data = require("data.photo_data")
local photo_extension_data = require("data.photo_extension_data")
local explore_photo_data = require("data.explore_photo_data")

require("view.Layer.TalkLayer")

function SchoolCinemalTalkLayer.create(arg_2_0, arg_2_1, arg_2_2)
	local var_2_0 = SchoolCinemalTalkLayer.new()

	var_2_0:init(arg_2_1, arg_2_2)

	return var_2_0
end

function SchoolCinemalTalkLayer:init(arg_3_1, arg_3_2)
	self.count = 0
	self.bg = ccui.Layout:create()

	self.bg:setTouchEnabled(false)
	self.bg:setContentSize(cc.Director:getInstance():getVisibleSize())
	self.bg:setAnchorPoint(cc.p(0.5, 0.5))
	self.bg:setPosition(cc.p(cc.Director:getInstance():getVisibleSize().width / 2, cc.Director:getInstance():getVisibleSize().height / 2))
	self.bg:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	self.bg:setBackGroundColor(cc.c3b(0, 0, 0))
	self.bg:setBackGroundColorOpacity(255)
	self.bg:setOpacity(0)
	self:addChild(self.bg, 100)

	self.chapterLabel = cc.Label:createWithTTF("", FONT_BUTTON, 36)

	self.chapterLabel:setPositionX(320)
	self.chapterLabel:setPositionY(800)
	self.bg:addChild(self.chapterLabel)
	;({
		[TALK_TYPE_BRANCH] = function()
			local var_4_0 = {}

			while explore_photo_data[arg_3_1]["next_classification_" .. 1] do
				table.insert(var_4_0, explore_photo_data[arg_3_1]["next_classification_" .. 1])
			end

			local var_4_2 = explore_photo_data[arg_3_1].name or L_SCHOOL_CINEMA_DEFAULT_NAME
			local var_4_3

			local function var_4_4()
				return function()
					self.count = self.count + 1

					if self.count > #var_4_0 then
						LayerManager:removePopLayer()
					else
						self.bg:setOpacity(255)
						self.bg:setTouchEnabled(true)
						self.bg:runAction(cc.Sequence:create(cc.DelayTime:create(2), cc.CallFunc:create(function(...)
							self.bg:setTouchEnabled(false)
							var_4_3(var_4_0[self.count])
						end)))
						self.chapterLabel:setString(string.format(L_SCHOOL_CINEMA_STRING, self.count + 1))
					end
				end
			end

			function var_4_3(arg_8_0)
				self:addChild(TalkLayer:create(arg_8_0, nil, TALK_TYPE_BRANCH, var_4_2, var_4_4(), 1), 10000)
			end

			self.bg:addTouchEventListener(function(arg_9_0, arg_9_1)
				if arg_9_1 ~= ccui.TouchEventType.ended then
					return
				end

				self.bg:stopAllActions()
				self.bg:setTouchEnabled(false)
				var_4_3(var_4_0[self.count])
			end)
			var_4_3(explore_photo_data[arg_3_1].classification)
		end,
		[TALK_TYPE_NORMAL] = function()
			local var_10_0 = {}

			while photo_data[arg_3_1]["next_classification_" .. 1] do
				table.insert(var_10_0, photo_data[arg_3_1]["next_classification_" .. 1])
			end

			local var_10_2

			local function var_10_3()
				return function()
					self.count = self.count + 1

					if self.count > #var_10_0 then
						LayerManager:removePopLayer()
					else
						self.bg:setOpacity(255)
						self.bg:setTouchEnabled(true)
						self.bg:runAction(cc.Sequence:create(cc.DelayTime:create(2), cc.CallFunc:create(function(...)
							self.bg:setTouchEnabled(false)
							var_10_2(var_10_0[self.count])
						end)))
						self.chapterLabel:setString(string.format(L_SCHOOL_CINEMA_STRING, self.count + 1))
					end
				end
			end

			function var_10_2(arg_14_0)
				self:addChild(TalkLayer:create(arg_14_0, nil, TALK_TYPE_NORMAL, photo_data[arg_3_1].name, var_10_3(), 1), 10000)
			end

			self.bg:addTouchEventListener(function(arg_15_0, arg_15_1)
				if arg_15_1 ~= ccui.TouchEventType.ended then
					return
				end

				self.bg:stopAllActions()
				self.bg:setTouchEnabled(false)
				var_10_2(var_10_0[self.count])
			end)
			var_10_2(photo_data[arg_3_1].classification)
		end
	})[arg_3_2]()
end
