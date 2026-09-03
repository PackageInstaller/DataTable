-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/story/widgets/PortraitOptionWidget.lua

PortraitOptionWidget = class("PortraitOptionWidget", BaseWidget)

function PortraitOptionWidget:initialize(view)
	super.initialize(self, view)
end

function PortraitOptionWidget:dispose()
	self:releseSchedule()
	super.dispose(self)
end

function PortraitOptionWidget:setupView()
	local view = self:getView()

	self._title = view:getChildByFullName("main.title_bg.title")

	local button1 = view:getChildByFullName("main.button_1")
	local button2 = view:getChildByFullName("main.button_2")
	local button3 = view:getChildByFullName("main.button_3")

	self._button1Text = view:getChildByFullName("main.button_1.text")
	self._button2Text = view:getChildByFullName("main.button_2.text")
	self._button3Text = view:getChildByFullName("main.button_3.text")

	button1:setTag(1)
	button2:setTag(2)
	button3:setTag(3)

	local outlineColor = cc.c4b(159, 52, 0, 165)
	local outlineWidth = 2
	local lineGradiantVec2 = {
		{
			ratio = 0.3,
			color = cc.c4b(255, 255, 255, 255)
		},
		{
			ratio = 0.7,
			color = cc.c4b(255, 244, 120, 255)
		}
	}
	local lineGradiantDir = {
		x = 0,
		y = -1
	}

	self._button1Text:enableOutline(outlineColor, outlineWidth)
	self._button1Text:enablePattern(cc.LinearGradientPattern:create(lineGradiantVec2, lineGradiantDir))
	self._button2Text:enableOutline(outlineColor, outlineWidth)
	self._button2Text:enablePattern(cc.LinearGradientPattern:create(lineGradiantVec2, lineGradiantDir))
	self._button3Text:enableOutline(outlineColor, outlineWidth)
	self._button3Text:enablePattern(cc.LinearGradientPattern:create(lineGradiantVec2, lineGradiantDir))
	mapButtonHandlerClick(self, button1, function(sender, eventType)
		self:onClickButton(sender, eventType)
	end)
	mapButtonHandlerClick(self, button2, function(sender, eventType)
		self:onClickButton(sender, eventType)
	end)
	mapButtonHandlerClick(self, button3, function(sender, eventType)
		self:onClickButton(sender, eventType)
	end)
end

function PortraitOptionWidget:updateView(data, onEnd)
	self._title:setString(data.title)
	self._button1Text:setString(data.button1Text)
	self._button2Text:setString(data.button2Text)
	self._button3Text:setString(data.button3Text)

	self._onEnd = onEnd

	if data.duration then
		local timeNum = data.duration

		local function onTick()
			timeNum = timeNum - 1

			if timeNum < 0 then
				self:selectOption("option1")

				return
			end

			time:setString(timeNum)
		end

		self._timeScheduler = LuaScheduler:getInstance():schedule(onTick, 1)
	end
end

function PortraitOptionWidget:releseSchedule()
	if self._timeScheduler then
		LuaScheduler:getInstance():unschedule(self._timeScheduler)

		self._timeScheduler = nil
	end
end

function PortraitOptionWidget:onClickButton(sender, eventType)
	if eventType == ccui.TouchEventType.ended then
		local tag = sender:getTag()
		local optionId = "option" .. tag

		self:selectOption(optionId)
	end
end

function PortraitOptionWidget:selectOption(optionId)
	self:releseSchedule()

	if self._onEnd then
		self._onEnd(optionId)
	end

	self:getView():setVisible(false)
end
