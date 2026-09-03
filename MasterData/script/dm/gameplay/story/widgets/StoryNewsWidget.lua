-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/story/widgets/StoryNewsWidget.lua

StoryNewsWidget = class("StoryNewsWidget", BaseWidget)

function StoryNewsWidget:initialize(view)
	super.initialize(self, view)
end

function StoryNewsWidget:dispose()
	super.dispose(self)
end

function StoryNewsWidget:setupView()
	local view = self:getView()

	AdjustUtils.adjustLayoutUIByRootNode(view)

	local touchLayer = view:getChildByName("touch_layer")

	self._clickTouchTime = 0

	touchLayer:addClickEventListener(function()
		self:onTouchClick(true)
	end)

	local text_title = view:getChildByFullName("main.Text_title")

	text_title:setAdditionalKerning(3)
end

function StoryNewsWidget:updateView(data, onEnd, parentClass)
	self._onEnd = onEnd

	local view = self:getView()

	self._callback = onEnd
	self._parentClass = parentClass
	self._contents = data.content or {}
	self._durations = data.durations or {}
	self._cityStr = data.city or ""

	if self._cityStr ~= "" then
		self._cityStr = Strings:get(self._cityStr)
	end

	self._timeStr = data.time or ""
	self._titleStr = data.title or ""

	if self._titleStr ~= "" then
		self._titleStr = Strings:get(self._titleStr)
	end

	self._imgName = data.img

	local image_bg = view:getChildByFullName("main.Image_bg")
	local text_city = view:getChildByFullName("main.Text_city")
	local text_time = view:getChildByFullName("main.Text_time")
	local text_title = view:getChildByFullName("main.Text_title")

	if self._imgName and self._imgName ~= "" then
		local imagePath = CommonUtils.getPathByType("SCENE", self._imgName)

		image_bg:loadTexture(imagePath)
		image_bg:setVisible(true)
	else
		image_bg:setVisible(false)
	end

	text_city:setString(self._cityStr)
	text_time:setString(self._timeStr)
	text_title:setString(self._titleStr)

	self._isAutoPlay = self._mainNode:getAgent():isAutoPlayState()
	self._index = 0

	self:runNext()
end

local kTypeWirterActionTag = 65537

function StoryNewsWidget:runNext()
	if self._index >= #self._contents then
		return false
	end

	self._index = self._index + 1
	self._contentText = self:createContentText()

	if self._contentText == nil then
		return false
	end

	self._contentText:playTypeWriter()

	return true
end

function StoryNewsWidget:createContentText()
	local storyAgent = self._parentClass:getAgent()
	local view = self:getView()
	local node_des = view:getChildByFullName("main.Node_des")

	node_des:removeAllChildren()

	local content = self._contents[self._index]

	if content == nil then
		return nil
	end

	content = Strings:get(content)

	if storyAgent and storyAgent:getDirector() and string.find(content, "playername") then
		local direc = storyAgent:getDirector()
		local developSystem = direc:getInjector():getInstance(DevelopSystem)
		local playerName = developSystem:getNickName()
		local env = {
			playername = playerName
		}
		local tmpl = TextTemplate:new(content)

		content = tmpl:stringify(env)
	end

	if string.find(content, "fontName_FONT_1") or string.find(content, "fontName_FONT_2") or string.find(content, "fontName_FZYH_R") or string.find(content, "fontName_FZYH_M") then
		local env = {
			fontName_FONT_1 = CUSTOM_TTF_FONT_1,
			fontName_FONT_2 = CUSTOM_TTF_FONT_2,
			fontName_FZYH_R = TTF_FONT_FZYH_R,
			fontName_FZYH_M = TTF_FONT_FZYH_M
		}
		local tmpl = TextTemplate:new(content)

		content = tmpl:stringify(env)
	end

	if not self._durations[self._index] then
		local duration = kTypeOutInterval
		local contentText = ccui.RichText:createWithXML(content, {})

		contentText:setAnchorPoint(cc.p(0, 0.5))
		contentText:setWrapMode(1)
		contentText:ignoreContentAdaptWithSize(false)
		contentText:renderContent(0, 0, true)
		contentText:addTo(node_des)

		function contentText.playTypeWriter(contentText)
			if storyAgent and storyAgent.addDialogue then
				local dataAdd = {}

				dataAdd.content = content

				self._parentClass:getAgent():addDialogue(dataAdd, "P")
			end

			contentText:stopActionByTag(kTypeWirterActionTag)
			contentText:clipContent(0, 0)
			contentText:setVisible(true)

			local typerAction = NewTypeWriterAction:create(contentText, duration)
			local seq = cc.Sequence:create(typerAction, cc.CallFunc:create(function()
				if self._isAutoPlay then
					self:runAutoPlay()
				end
			end))

			seq:setTag(kTypeWirterActionTag)
			contentText:runAction(seq)
		end

		function contentText.finishTypeWriter(contentText)
			contentText:stopActionByTag(kTypeWirterActionTag)
			contentText:clipContent()
			contentText:renderContent(0, 0, true)
		end

		function contentText.isTypeWriting(contentText)
			local action = contentText:getActionByTag(kTypeWirterActionTag)

			return action ~= nil
		end

		return contentText
	end
end

function StoryNewsWidget:onTouchClick(_isTouch)
	if self._isAutoPlay and _isTouch then
		self._mainNode:getAgent():setAutoPlayState(false)

		return
	end

	if self._contentText == nil then
		return
	end

	if self._contentText.isTypeWriting and self._contentText:isTypeWriting() then
		self._contentText:finishTypeWriter()
	elseif not self:runNext() and self._callback then
		local callback = self._callback

		self._callback = nil

		callback()
	end
end

local DAZI_DELAY_TIME = 0.06

function StoryNewsWidget:runAutoPlay()
	if self._isAutoPlay then
		local contentLength = self._contentText:getContentLength()
		local delay = contentLength * DAZI_DELAY_TIME

		delay = delay > 0.5 and delay or 0.5
		self._funAutoPlay = performWithDelay(self:getView(), function()
			self._funAutoPlay = nil

			self:onTouchClick(false)
		end, delay)
	end
end

function StoryNewsWidget:startAutoPlay()
	self._isAutoPlay = true

	if self._contentText and self._contentText.isTypeWriting and not self._contentText:isTypeWriting() then
		self:runAutoPlay()
	end
end

function StoryNewsWidget:stopAutoPlay()
	if self._funAutoPlay then
		self:getView():stopAction(self._funAutoPlay)

		self._funAutoPlay = nil
	end

	self._isAutoPlay = false
end
