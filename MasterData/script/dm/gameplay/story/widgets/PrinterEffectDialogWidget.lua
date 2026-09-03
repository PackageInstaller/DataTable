-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/story/widgets/PrinterEffectDialogWidget.lua

PrinterEffectDialogWidget = class("PrinterEffectDialogWidget", BaseWidget)

function PrinterEffectDialogWidget:initialize(view)
	super.initialize(self, view)
end

function PrinterEffectDialogWidget:dispose()
	super.dispose(self)
end

function PrinterEffectDialogWidget:setupView()
	local view = self:getView()
	local touchLayer = view:getChildByName("touch_layer")

	self._clickTouchTime = 0

	touchLayer:addClickEventListener(function()
		self:clickToEndPrient()
	end)

	local plist1 = view:getChildByFullName("main.Image_animbg.plist1")

	plist1:setSpeedVar(40)
	plist1:setSpeed(120)

	local plist2 = view:getChildByFullName("main.Image_animbg.plist2")

	plist2:setSpeedVar(40)
	plist2:setSpeed(120)

	local plist3 = view:getChildByFullName("main.Image_animbg.plist3")

	plist3:setSpeedVar(40)
	plist3:setSpeed(120)

	local node_anim = view:getChildByFullName("main.node_anim")
	local anim = cc.MovieClip:create("anim_zhangjiekaiqi")

	anim:gotoAndStop(180)
	anim:addTo(node_anim):center(node_anim:getContentSize()):offset(0, 0)
end

function PrinterEffectDialogWidget:updateView(data, onEnd, parentClass)
	self._onEnd = onEnd
	self._onEndDirect = onEnd
	self._parentClass = parentClass

	local view = self:getView()

	self._contentList = data.content or {}
	self._contentTextSpeeds = data.durations or {}
	self._contentWaitTimes = data.waitTimes or {}
	self._heightSpace = data.heightSpace or 26
	self._center = data.center or 0
	self._contentTextIndex = 0
	self._contentTextList = {}
	self._clickTouchTime = 0
	self._newTextShowSta = false
	self._printAudioOff = not not data.printAudioOff

	local bgShow = true

	if data.bgShow ~= nil then
		bgShow = data.bgShow
	end

	local bgRes = data.bgImage
	local animShow = true

	if data.animShow ~= nil then
		animShow = data.animShow
	end

	local panel = self:getView():getChildByFullName("main.Panel")

	panel:setOpacity((data.panelOpacity or nil) and data.panelOpacity)

	local node_anim = self:getView():getChildByFullName("main.node_anim")
	local blackPanel = self:getView():getChildByFullName("main.Image_animbg.blackPanel")

	node_anim:setVisible(bgShow)
	blackPanel:setVisible(not bgShow)

	if bgShow and bgRes then
		local image_animBg = self:getView():getChildByFullName("main.Image_animbg")

		image_animBg:loadTexture("asset/scene/" .. bgRes, ccui.TextureResType.localType)
		node_anim:setVisible(false)
	end

	local plist1 = view:getChildByFullName("main.Image_animbg.plist1")
	local plist2 = view:getChildByFullName("main.Image_animbg.plist2")
	local plist3 = view:getChildByFullName("main.Image_animbg.plist3")

	plist1:setVisible(animShow)
	plist2:setVisible(animShow)
	plist3:setVisible(animShow)

	if self._center > 0 then
		self:addContent()
		self:runNext()
	else
		self:addContentNew()
		self:runNew()
	end
end

local kTypeWaitActionTag = 65537

function PrinterEffectDialogWidget:runNext()
	self._contentTextIndex = self._contentTextIndex + 1

	if self._contentTextList and self._contentTextList[self._contentTextIndex] then
		local duration = self._contentTextSpeeds[self._contentTextIndex]

		if not self._contentTextList[self._contentTextIndex] then
			local contentText = ""

			if duration and (type(duration) == "number" and duration > 0 or type(duration) == "table") then
				contentText:playTypeWriter()
			else
				contentText:finishTypeWriter()

				if self._contentWaitTimes and self._contentWaitTimes[self._contentTextIndex] and self._contentWaitTimes[self._contentTextIndex] > 0 then
					local waitCallFun = cc.CallFunc:create(function()
						self:runNext()
					end)
					local waitAction = cc.Sequence:create(cc.DelayTime:create(self._contentWaitTimes[self._contentTextIndex]), waitCallFun)

					waitAction:setTag(kTypeWaitActionTag)
					contentText:runAction(waitAction)
					contentText:finishTypeWriter()
				else
					self:runNext()
				end
			end
		end
	else
		local onEnd = self._onEnd

		self._onEnd = nil

		if onEnd ~= nil then
			onEnd()
		end
	end
end

local kTypePrinterActionTag = 65536

function PrinterEffectDialogWidget:addContent()
	local view = self:getView()
	local contentNode = view:getChildByFullName("main.contentNode")
	local contentNode_center = view:getChildByFullName("main.contentNode_center")
	local contentPanel = view:getChildByFullName("contentPanel")
	local widthPanel = contentPanel:getContentSize().width
	local centerType = self._center

	contentNode:removeAllChildren(true)
	contentNode_center:removeAllChildren(true)

	local baseNode = cc.Node:create()

	baseNode:addTo((centerType > 0 or nil) and contentNode_center)

	local heightAll = 0

	for k, v in pairs(self._contentList) do
		local content = Strings:get(v)

		if self._parentClass and self._parentClass:getAgent() then
			if self._parentClass:getAgent():getDirector() and string.find(content, "playername") then
				local direc = self._parentClass:getAgent():getDirector()
				local developSystem = direc:getInjector():getInstance(DevelopSystem)
				local playerName = developSystem:getNickName()
				local env = {
					playername = playerName
				}
				local tmpl = TextTemplate:new(content)

				content = tmpl:stringify(env)
			end
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

		local contentText = ccui.RichText:createWithXML(content, {
			KEY_VERTICAL_SPACE = self._heightSpace
		})

		contentText:setWrapMode(1)
		contentText:ignoreContentAdaptWithSize(false)
		contentText:setAnchorPoint(cc.p(0.5, 1))
		contentText:addTo(baseNode)
		contentText:setPosition(cc.p(0, 0 - heightAll))
		contentText:setVisible(false)

		if centerType and centerType == 1 then
			contentText:renderContent(0, 0, true)

			local width = contentText:getContentSize().width

			contentText:renderContent(width, 0, true)
		else
			contentText:renderContent(widthPanel, 0, true)
		end

		heightAll = heightAll + contentText:getContentSize().height + self._heightSpace

		if not self._contentTextSpeeds[k] then
			local duration = kTypeOutInterval
			local waitTime = self._contentWaitTimes[k]
			local text_index = 0

			function contentText.playTypeWriter(contentText)
				contentText:setVisible(true)

				local contentLen = contentText:getContentLength()

				contentText:clipContent(0, 0)

				local function callFunc()
					if waitTime and waitTime > 0 then
						local waitCallFun = cc.CallFunc:create(function()
							self:runNext()
						end)
						local waitAction = cc.Sequence:create(cc.DelayTime:create(waitTime), waitCallFun)

						waitAction:setTag(kTypeWaitActionTag)
						contentText:runAction(waitAction)
					else
						self:runNext()
					end
				end

				local function soundCallfun()
					if not self._printAudioOff then
						AudioEngine:getInstance():playEffect("Se_Story_Type", false)
					end
				end

				local typerAction = NewTypeWriterAction:create(contentText, duration, soundCallfun)
				local seq = cc.Sequence:create(typerAction, cc.CallFunc:create(callFunc))

				seq:setTag(kTypePrinterActionTag)
				contentText:runAction(seq)

				if text_index == 0 then
					text_index = text_index + 1

					if self._parentClass and self._parentClass:getAgent() and self._parentClass:getAgent().addDialogue then
						local dataAdd = {}

						dataAdd.content = content

						self._parentClass:getAgent():addDialogue(dataAdd, "P")
					end
				end
			end

			function contentText.finishTypeWriter(contentText)
				contentText:setVisible(true)
				contentText:stopActionByTag(kTypePrinterActionTag)
				contentText:clipContent()
				contentText:renderContent(contentText:getContentSize().width, 0, false)

				if text_index == 0 then
					text_index = text_index + 1

					if self._parentClass and self._parentClass:getAgent() and self._parentClass:getAgent().addDialogue then
						local dataAdd = {}

						dataAdd.content = content

						self._parentClass:getAgent():addDialogue(dataAdd, "P")
					end
				end
			end

			self._contentTextList[k] = contentText
		end
	end

	if centerType > 0 then
		baseNode:setPositionY(heightAll / 2 + 20)
	end
end

function PrinterEffectDialogWidget:clickToEndPrient()
	local socket = require("socket")

	self._clickTouchTime = socket.gettime()

	if self._contentTextList then
		local len = table.getn(self._contentTextList)

		for index = self._contentTextIndex, len + 1 do
			self._contentTextIndex = index

			local contentText = self._contentTextList[index]

			if self._center > 0 then
				if contentText and contentText.finishTypeWriter then
					contentText:finishTypeWriter()
				end
			elseif contentText then
				contentText:stopAllActions()
				contentText:setOpacity(255)
			end
		end

		if len < self._contentTextIndex then
			local onEnd = self._onEnd

			self._onEnd = nil

			local view = self:getView()

			if onEnd ~= nil then
				performWithDelay(view, function()
					onEnd()
				end, 2.4)
			else
				view:stopAllActions()
				self._onEndDirect()
			end
		end
	end
end

function PrinterEffectDialogWidget:addContentNew()
	local view = self:getView()
	local contentNode = view:getChildByFullName("main.contentNode")
	local contentNode_center = view:getChildByFullName("main.contentNode_center")
	local contentPanel = view:getChildByFullName("contentPanel")
	local widthPanel = contentPanel:getContentSize().width

	contentNode:removeAllChildren(true)
	contentNode_center:removeAllChildren(true)

	local baseNode = cc.Node:create()

	baseNode:addTo(contentNode)

	local heightAll = 0

	for k, v in pairs(self._contentList) do
		local content = Strings:get(v)

		if self._parentClass and self._parentClass:getAgent() then
			if self._parentClass:getAgent():getDirector() and string.find(content, "playername") then
				local direc = self._parentClass:getAgent():getDirector()
				local developSystem = direc:getInjector():getInstance(DevelopSystem)
				local playerName = developSystem:getNickName()
				local env = {
					playername = playerName
				}
				local tmpl = TextTemplate:new(content)

				content = tmpl:stringify(env)
			end
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

		local contentText = ccui.RichText:createWithXML(content, {
			KEY_VERTICAL_SPACE = self._heightSpace
		})

		contentText:setWrapMode(1)
		contentText:ignoreContentAdaptWithSize(false)
		contentText:setAnchorPoint(cc.p(0, 1))
		contentText:addTo(baseNode)
		contentText:setPosition(cc.p(0, 0 - heightAll))
		contentText:renderContent(widthPanel, 0, true)

		heightAll = heightAll + contentText:getContentSize().height + self._heightSpace
		self._contentTextList[k] = contentText

		contentText:setOpacity(0)
	end
end

function PrinterEffectDialogWidget:runNew()
	local function playEnd()
		local onEnd = self._onEnd

		self._onEnd = nil

		if onEnd ~= nil then
			onEnd()
		end
	end

	local time = 0

	self._newTextShowSta = true

	for i = 1, #self._contentTextList - 1 do
		local text = self._contentTextList[i]
		local delayTime = cc.DelayTime:create(time)

		text:runAction(cc.Sequence:create(delayTime, cc.FadeIn:create(0.4)))

		time = time + 0.2
	end

	local contentText = self._contentTextList[#self._contentTextList]

	if contentText then
		if not self._contentWaitTimes[1] then
			local func = cc.CallFunc:create(function()
				playEnd()
			end)
			local func_1 = cc.CallFunc:create(function()
				self._newTextShowSta = false
			end)

			contentText:runAction(cc.Sequence:create(cc.DelayTime:create(time), cc.FadeIn:create(0.4), func_1, cc.DelayTime:create(self._contentWaitTimes[1]), func))
		end
	else
		self._newTextShowSta = false

		playEnd()
	end
end

function PrinterEffectDialogWidget:skipToEndNew()
	if self._newTextShowSta then
		return
	end

	local contentText = self._contentTextList[#self._contentTextList]

	if contentText then
		contentText:stopAllActions()

		local onEnd = self._onEnd

		self._onEnd = nil

		if onEnd ~= nil then
			onEnd()
		end
	end
end
