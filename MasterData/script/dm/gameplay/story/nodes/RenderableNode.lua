-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/story/nodes/RenderableNode.lua

module("story", package.seeall)

HideAnimTimeInterval = 0.3

local function _changeMaskNodeAction(maskNode, colorInfo, duration, onEnd)
	if colorInfo == nil or maskNode == nil then
		return
	end

	maskNode:stopAllActions()

	if colorInfo.color ~= nil then
		maskNode:setColor(colorInfo.color)
	end

	if not colorInfo.opacity then
		local opacity = 255

		opacity = math.max(0, math.min(opacity, 255))

		if duration == nil or duration <= 0 then
			maskNode:setVisible(opacity > 0)
			maskNode:setOpacity(opacity)

			if onEnd ~= nil then
				onEnd()
			end
		else
			local fadeTo = cc.FadeTo:create(duration, opacity)
			local call = cc.CallFunc:create(function()
				maskNode:setVisible(opacity > 0)

				if onEnd ~= nil then
					onEnd()
				end
			end)

			maskNode:setVisible(true)
			maskNode:runAction(cc.Sequence:create(fadeTo, call))
		end
	end
end

local function _runFlashScreen(self, data, endCallback)
	local arr = data.arr
	local actions = {}
	local index = 0
	local maskNode = self._renderNode

	maskNode:setVisible(true)
	maskNode:onNodeEvent("cleanup", function()
		if self and self._flashTask ~= nil then
			cancelDelayCall(self._flashTask)

			self._flashTask = nil
		end
	end)

	local runNextAction, runOneAction

	function runOneAction(func, duration)
		if func ~= nil then
			func()
		end

		if self._flashTask ~= nil then
			cancelDelayCall(self._flashTask)

			self._flashTask = nil
		end

		if duration <= 0 then
			runNextAction()
		else
			self._flashTask = delayCallByTime(duration * 1000, runNextAction)
		end
	end

	function runNextAction()
		index = index + 1

		if index <= #actions then
			local action = actions[index]

			runOneAction(action.func, action.duration or 0)
		else
			if not data.isSave then
				_changeMaskNodeAction(maskNode, {
					opacity = 0
				}, 0)
			end

			if endCallback ~= nil then
				endCallback()
			end
		end
	end

	for _, task in ipairs(arr) do
		local color = GameStyle:stringToColor(task.color)
		local opacity = (task.alpha or 1) * 255

		if task.fadein ~= nil and task.fadein > 0 then
			if not task.fadein then
				local duration = 0

				actions[#actions + 1] = {
					duration = duration,
					func = function()
						_changeMaskNodeAction(maskNode, {
							color = color,
							opacity = opacity
						}, duration)
					end
				}
			end
		end

		if not task.duration then
			local duration = 1

			if duration > 0 then
				actions[#actions + 1] = {
					duration = duration,
					func = function()
						_changeMaskNodeAction(maskNode, {
							color = color,
							opacity = opacity
						}, 0)
					end
				}
			end

			if task.fadeout ~= nil and task.fadeout > 0 then
				if not task.fadeout then
					local duration = 0

					actions[#actions + 1] = {
						duration = task.fadeout,
						func = function()
							_changeMaskNodeAction(maskNode, {
								opacity = 0,
								color = color
							}, duration)
						end
					}
				end
			end
		end
	end

	runNextAction()
end

ImageNode = class("ImageNode", StageNode)

register_stage_node("Image", ImageNode)

local acitons = {
	changeTexture = ChangeTexture
}

ImageNode:extendActionsForClass(acitons)

function ImageNode:initialize(config)
	super.initialize(self, config)
end

function ImageNode:createRenderNode(config)
	local imagePath = CommonUtils.getPathByType(config.pathType, config.image)
	local renderNode = ccui.ImageView:create(imagePath, (not config.resType or nil) and ccui.TextureResType.localType)

	renderNode:setBrightness(config.brightness or 0)

	return renderNode
end

function ImageNode:hide()
	local renderNode = self:getRenderNode()

	renderNode:setVisible(false)
end

MovieClipNode = class("MovieClipNode", StageNode)

register_stage_node("MovieClip", MovieClipNode)

local acitons = {
	hide = hideMovieClipNode,
	play = playMovieClipNode
}

MovieClipNode:extendActionsForClass(acitons)

function MovieClipNode:initialize(config)
	super.initialize(self, config)
end

function MovieClipNode:createRenderNode(config)
	local renderNode = cc.Node:create()
	local animNode = cc.MovieClip:create(config.actionName)

	if not animNode then
		print("MovieClipNode animNode is nil", config.actionName)
	end

	animNode:addTo(renderNode):setName("animNode")
	animNode:stop()

	return renderNode
end

function MovieClipNode:hide()
	local renderNode = self:getRenderNode()
	local animNode = renderNode:getChildByName("animNode")

	if animNode then
		animNode:stop()
	end

	renderNode:setVisible(false)
end

function MovieClipNode:play(args)
	args = args or {}

	local renderNode = self:getRenderNode()
	local animNode = renderNode:getChildByName("animNode")

	animNode:gotoAndPlay(1)

	local time = 1

	if not args.time then
		local playTime = 1

		animNode:addEndCallback(function(cid, mc)
			mc:stop()

			if playTime == -1 or time < playTime then
				mc:gotoAndPlay(1)

				time = time + 1
			end
		end)
		renderNode:setVisible(true)
	end
end

VideoSpriteNode = class("VideoSpriteNode", StageNode)

register_stage_node("VideoSprite", VideoSpriteNode)

local acitons = {
	hide = hideVideoSpriteNode,
	play = playVideoSpriteNode,
	stop = stopVideoSpriteNode,
	pause = pauseVideoSpriteNode,
	resume = resumeVideoSpriteNode,
	playEnd = playEndVideoSpriteNode
}

VideoSpriteNode:extendActionsForClass(acitons)

function VideoSpriteNode:initialize(config)
	super.initialize(self, config)
end

function VideoSpriteNode:createRenderNode(config)
	self._videoName = "video/story/" .. config.videoName .. ".usm"

	return (cc.Node:create())
end

function VideoSpriteNode:hide()
	local renderNode = self:getRenderNode()

	renderNode:removeAllChildren()
	renderNode:setVisible(false)
end

function VideoSpriteNode:play(args)
	args = args or {}

	local renderNode = self:getRenderNode()

	renderNode:setVisible(true)
	renderNode:removeAllChildren()

	local videoSp = VideoSprite.create(self._videoName)

	videoSp:addTo(renderNode)
	videoSp:setAnchorPoint(renderNode:getAnchorPoint().x, renderNode:getAnchorPoint().y)
	videoSp:setName("videoSp")

	if not args.time then
		local playTime = 1

		videoSp:setListener(function(sprite, eventType, eventTag)
			if playTime ~= -1 then
				self:hide()
			end
		end)

		if args.additive and args.additive > 0 then
			videoSp:setAdditive(true)
		else
			videoSp:setAdditive(false)
		end

		if playTime == -1 then
			videoSp:getPlayer():loop(true)
		else
			videoSp:getPlayer():loop(false)
		end
	end
end

function VideoSpriteNode:playEnd(args, endfun)
	args = args or {}

	local renderNode = self:getRenderNode()

	renderNode:setVisible(true)
	renderNode:removeAllChildren()

	local videoSp = VideoSprite.create(self._videoName)

	videoSp:addTo(renderNode)
	videoSp:setAnchorPoint(renderNode:getAnchorPoint().x, renderNode:getAnchorPoint().y)
	videoSp:setName("videoSp")
	videoSp:setListener(function(sprite, eventType, eventTag)
		self:hide()

		if endfun then
			endfun()
		end
	end)

	if args.additive and args.additive > 0 then
		videoSp:setAdditive(true)
	else
		videoSp:setAdditive(false)
	end

	videoSp:getPlayer():loop(false)
end

function VideoSpriteNode:stop()
	local renderNode = self:getRenderNode()
	local videoSp = renderNode:getChildByName("videoSp")

	if videoSp then
		videoSp:getPlayer():stop()
	end
end

function VideoSpriteNode:pause()
	local renderNode = self:getRenderNode()
	local videoSp = renderNode:getChildByName("videoSp")

	if videoSp then
		videoSp:getPlayer():pause(true)
	end
end

function VideoSpriteNode:resume()
	local renderNode = self:getRenderNode()
	local videoSp = renderNode:getChildByName("videoSp")

	if videoSp then
		videoSp:getPlayer():pause(false)
	end
end

kPortraitScale = 1
PortraitNode = class("PortraitNode", StageNode)

PortraitNode:has("_modeId", {
	is = "r"
})
PortraitNode:has("_portraitScale", {
	is = "r"
})
PortraitNode:has("_brightness", {
	is = "r"
})
register_stage_node("Portrait", PortraitNode)

local acitons = {
	scaleTo = PortraitNodeScaleTo,
	portraitNodeBrightnessTo = PortraitNodeBrightnessTo,
	blendFlashScreen = PortraitNodeBlendFlashScreen
}

PortraitNode:extendActionsForClass(acitons)

function PortraitNode:initialize(config)
	self._modeId = config.modelId
	self._portraitScale = config.scale or 1
	self._brightness = config.brightness or 0

	super.initialize(self, config)
end

function PortraitNode:createRenderNode(config)
	local node = cc.Node:create()

	node:setAnchorPoint(cc.p(0.5, 0.5))
	node:setCascadeOpacityEnabled(true)

	local protraitNode = self:createRoleIconSprite({
		iconType = 2,
		id = self._modeId
	})

	protraitNode:setAnchorPoint(cc.p(0.5, 0))
	protraitNode:setScale(kPortraitScale)
	protraitNode:setBrightness(self._brightness)
	protraitNode:setName("protraitNode")
	protraitNode:addTo(node)

	return node
end

function PortraitNode:createRoleIconSprite(info)
	local id = info.id

	if not info.iconType then
		local type = 1

		if not IconFactory.kIconType[type] then
			local needType = type
			local rolePicId = ConfigReader:getDataByNameIdAndKey("RoleModel", id, needType)

			assert(rolePicId ~= nil, "表RoleModel中没有id为" .. id .. "字段为" .. needType .. "的值")

			local modelID = ConfigReader:getDataByNameIdAndKey("RoleModel", id, "Model")
			local commonResource = ConfigReader:getDataByNameIdAndKey("RoleModel", id, "CommonResource")

			if not commonResource or commonResource == "" then
				commonResource = modelID
			end

			local picInfo = ConfigReader:getRecordById("SpecialPicture", rolePicId)
			local path = string.format("%s%s/%s.png", IconFactory.kIconPathCfg[tonumber(picInfo.Path)], commonResource, picInfo.Filename)
			local sprite = cc.Sprite:create(path)

			sprite = sprite or cc.Sprite:create()

			local spriteSize = sprite:getContentSize()

			if not picInfo.Coordinates then
				if not picInfo.Coordinates[1] then
					local x = 0

					if not picInfo.Coordinates[2] then
						local y = 0
						local clipSzie

						if x ~= 0 or y ~= 0 then
							clipSzie = cc.size(spriteSize.width - x, spriteSize.height - y)
						end

						if clipSzie then
							local offsetX = math.max(0, x)
							local offsetY = math.max(0, spriteSize.height - y - clipSzie.height)

							if x < 0 then
								if not (clipSzie.width + x) then
									local width = clipSzie.width

									if spriteSize.height - y - clipSzie.height < 0 then
										if not (clipSzie.height + (spriteSize.height - y - clipSzie.height)) then
											local height = clipSzie.height

											sprite:setTextureRect(cc.rect(offsetX, offsetY, math.min(width, spriteSize.width - offsetX), height))
										end
									end
								end
							end
						end

						if (picInfo.Deviation or picInfo.zoom) and picInfo.zoom and not info.stencil then
							sprite:setScale(picInfo.zoom)
						end

						return sprite
					end
				end
			end
		end
	end
end

function PortraitNode:setVolatileProps(config)
	super.setVolatileProps(self, config)

	if config.forward then
		self:setForward(config.forward)
	end
end

function PortraitNode:setForward(forward)
	local renderNode = self:getRenderNode()
	local protraitNode = renderNode:getChildByName("protraitNode")

	if protraitNode then
		protraitNode:setScaleX(forward)
	end
end

function PortraitNode:getForward()
	local protraitNode = self:getRenderNode()

	return protraitNode:getScaleX()
end

function PortraitNode:setPortraitScale(scale)
	self._portraitScale = scale
end

function PortraitNode:setBrightness(brightness)
	self._brightness = brightness
end

function PortraitNode:runBlendFlashScreen(args, callback)
	local renderNode = self:getRenderNode()
	local protraitNode = renderNode:getChildByName("protraitNode")
	local protraitNodeNew = self:createRoleIconSprite({
		iconType = 2,
		id = self._modeId
	})

	protraitNodeNew:setAnchorPoint(cc.p(0.5, 0))

	local zorder = 9999999
	local pos = cc.p(protraitNode:getPositionX(), protraitNode:getPositionY())

	renderNode:addChild(protraitNodeNew)
	protraitNodeNew:setLocalZOrder(zorder)
	protraitNodeNew:setPosition(pos)
	protraitNodeNew:setScale(protraitNode:getScale())

	local function endCallback()
		protraitNodeNew:removeFromParent()

		if callback then
			callback()
		end
	end

	protraitNodeNew:setBlendFunc(cc.blendFunc(gl.SRC_ALPHA, gl.ONE))

	local infoSelf = {}

	infoSelf._renderNode = protraitNodeNew

	_runFlashScreen(infoSelf, args, endCallback)
end

DialogueNode = class("DialogueNode", StageNode)

register_stage_node("Dialogue", DialogueNode)

local acitons = {
	addPortrait = DialogueAddPortrait,
	removePortrait = DialogueRemovePortrait,
	speak = DialogueSpeak,
	hide = DialogueHide,
	show = DialogueShow,
	reset = DialogueReset,
	clearProtrait = DialogueRemoveAllPortrait
}

DialogueNode:extendActionsForClass(acitons)

function DialogueNode:initialize(config)
	super.initialize(self, config)

	self._contents = {}
	self._index = 0
	self._contentFontCount = 0
end

function DialogueNode:activeSpeakings(speakings, portraits)
	if speakings == nil then
		return
	end

	local speakingNodeIds = {}

	if #speakings > 0 then
		for k, v in pairs(speakings) do
			speakingNodeIds[v] = true
		end
	end

	local kActionTag = 65537
	local children = portraits

	for i, child in pairs(children) do
		local protraitNode = child:getRenderNode()
		local scale = child:getPortraitScale()
		local bright = child:getBrightness()
		local action

		if speakingNodeIds[child:getId()] then
			action = BrightnessTo:create(0.03, bright)
		else
			local brightness = bright ~= 0 and bright or -50

			action = BrightnessTo:create(0.03, brightness)
		end

		if protraitNode then
			protraitNode:stopActionByTag(kActionTag)
			action:setTag(kActionTag)
			protraitNode:runAction(action)
		end
	end
end

function DialogueNode:createRenderNode(config)
	local dialogueUINode = cc.CSLoader:createNode("asset/ui/PlotDialogue.csb")
	local main = dialogueUINode:getChildByName("main")

	main:setVisible(false)

	local next_node = dialogueUINode:getChildByFullName("main.next_node")
	local action = cc.MovieClip:create("nextAnim_juqingfanye")

	action:addTo(next_node):center(next_node:getContentSize()):offset(0, 0)

	local renderNode = dialogueUINode

	renderNode:setVisible(false)

	local touchLayer = renderNode:getChildByName("touch_layer")

	touchLayer:addClickEventListener(function()
		self:onTouchClick(true)
	end)

	return renderNode
end

local kTypeWirterActionTag = 65536

function DialogueNode:speak(args, callback)
	local view = self:getRenderNode()

	view:setVisible(true)

	local main = view:getChildByName("main")

	main:setVisible(true)

	self._callback = callback

	local dialogueUI = view

	if self._contentTextNode then
		self._contentTextNode:removeFromParent(true)

		self._contentTextNode = nil
	end

	self.rockActions = args.rockActions or {}

	if not self.dialoguePosX or not self.dialoguePosY then
		self.dialoguePosX = view:getPositionX()
		self.dialoguePosY = view:getPositionY()
	end

	if not args.nameSpace then
		local dialog = dialogueUI:getChildByFullName("main.dialog")
		local nameLeft = dialogueUI:getChildByFullName("main.name_left")
		local nameRight = dialogueUI:getChildByFullName("main.name_right")
		local nameBg_l = dialogueUI:getChildByFullName("main.Image_name_bg_l")
		local nameBg_r = dialogueUI:getChildByFullName("main.Image_name_bg_r")

		nameLeft:setVisible(false)
		nameRight:setVisible(false)
		nameBg_l:setVisible(false)
		nameBg_r:setVisible(false)

		local location = args.location

		if args.location == nil then
			location = "left"
		end

		local imagePath = CommonUtils.getPathByType(args.pathType, (args.dialogImage ~= nil or nil) and args.dialogImage)

		dialog:loadTexture(imagePath, ccui.TextureResType.localType)
		dialog:setScale9Enabled(true)

		if args.capInsets and #args.capInsets == 4 then
			dialog:setCapInsets(cc.rect(args.capInsets[1], args.capInsets[2], args.capInsets[3], args.capInsets[4]))
		else
			dialog:setCapInsets(cc.rect(240, 114, 250, 119))
		end

		local winSize = cc.Director:getInstance():getWinSize()

		dialog:setContentSize(cc.size(winSize.width - 2 * AdjustUtils.getFixOffsetX(), dialog:getContentSize().height))

		local name, nameBg

		if location == "left" then
			dialog:setFlippedX(false)

			name = nameLeft
			nameBg = nameBg_l
		elseif location == "right" then
			dialog:setFlippedX(true)

			name = nameRight
			nameBg = nameBg_r
		end

		name:setFontSize((args.nameFontSize or nil) and args.nameFontSize)

		if args.name then
			name:setString(Strings:get(args.name))
			name:setVisible(true)
			nameBg:setVisible(true)
		end

		self:activeSpeakings(args.speakings, args.portraits)
		self:createContentText(args)

		self._isAutoPlay = self:getAgent():isAutoPlayState()
		self._contents = args.contents
		self._index = 0

		self:next()
	end
end

function DialogueNode:createContentText(args)
	if not args.contents then
		if not args.durations then
			local durations = {}
			local nameStr = Strings:get(args.name)

			self._contentTextNodes = {}
			self._contentTextNode = cc.Node:create()

			local dialogueUI = self._renderNode
			local contentRect = dialogueUI:getChildByFullName("main.content_label")
			local next_node = dialogueUI:getChildByFullName("main.next_node")
			local contentTextParent = contentRect:getParent()

			self._contentTextNode:addTo(contentTextParent)
			self._contentTextNode:posite(contentRect:getPosition())
			next_node:setVisible(false)

			local storyAgent = self:getAgent()

			self._contentFontCount = 0

			local height = 0

			for k, v in pairs(args.contents) do
				local content = Strings:get(v)

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
						fontName_FONT_1 = TTF_FONT_STORY,
						fontName_FONT_2 = TTF_FONT_STORY,
						fontName_FZYH_R = TTF_FONT_STORY,
						fontName_FZYH_M = TTF_FONT_STORY
					}
					local tmpl = TextTemplate:new(content)

					content = tmpl:stringify(env)
				end

				if not durations[k] then
					local duration = kTypeOutInterval
					local contentText = ccui.RichText:createWithXML(content, {})

					contentText:ignoreContentAdaptWithSize(false)
					contentText:setContentSize(cc.size(contentRect:getContentSize().width, 0))
					contentText:addTo(self._contentTextNode)

					local rockAction = self.rockActions[k]

					function contentText.playTypeWriter(contentText)
						local dataAdd = {}

						if storyAgent and storyAgent.addDialogue then
							dataAdd.name = nameStr
							dataAdd.content = content

							storyAgent:addDialogue(dataAdd, "D")
						end

						contentText:stopActionByTag(kTypeWirterActionTag)
						contentText:clipContent(0, 0)
						contentText:setVisible(true)
						next_node:setVisible(false)

						local typerAction = NewTypeWriterAction:create(contentText, duration)
						local seq = cc.Sequence:create(typerAction, cc.CallFunc:create(function()
							if self._isAutoPlay then
								self:runAutoPlay()
							else
								next_node:setVisible(true)
							end
						end))

						seq:setTag(kTypeWirterActionTag)
						contentText:runAction(seq)
						self:stopDialogueRockAction()

						if rockAction and rockAction.freq and rockAction.strength then
							self:runDialogueRockAction(rockAction.freq, rockAction.strength)
						end
					end

					function contentText.finishTypeWriter(contentText)
						next_node:setVisible(true)
						contentText:stopActionByTag(kTypeWirterActionTag)
						contentText:clipContent()
						contentText:renderContent(contentText:getContentSize().width, 0, false)
						self:stopDialogueRockAction()
					end

					function contentText.isTypeWriting(contentText)
						local action = contentText:getActionByTag(kTypeWirterActionTag)

						return action ~= nil
					end

					contentText:renderContent(contentRect:getContentSize().width, 0, true)
					contentText:setAnchorPoint(cc.p(0.5, 1))
					contentText:posite(0, 0 - height)

					height = height + contentText:getContentSize().height

					contentText:setVisible(false)

					self._contentTextNodes[k] = contentText
				end
			end

			self._contentTextNode:posite(self._contentTextNode:getPositionX(), 134)
		end
	end
end

function DialogueNode:next()
	if self._index >= #self._contents then
		return false
	end

	self._index = self._index + 1

	local contentText = self._contentTextNodes[self._index]

	self._contentText = contentText

	if contentText == nil then
		return false
	end

	contentText:playTypeWriter()

	return true
end

function DialogueNode:reset(children)
	self:hide()

	local children = children

	if children ~= nil then
		for i, subnode in ipairs(children) do
			self:removeChild(subnode)
			subnode:dispose()
		end

		self._children = nil
	end
end

function DialogueNode:hide()
	local view = self:getRenderNode()

	view:setVisible(false)
end

function DialogueNode:show()
	local view = self:getRenderNode()

	view:setVisible(true)
end

local kTypeDialogueRockActionTag = 65538

function DialogueNode:runDialogueRockAction(freq, strength)
	local view = self:getRenderNode()
	local rockAction = RockAction:create(freq, strength)

	rockAction:setTag(kTypeDialogueRockActionTag)
	view:runAction(rockAction)
end

function DialogueNode:stopDialogueRockAction()
	local view = self:getRenderNode()

	if view:getActionByTag(kTypeDialogueRockActionTag) then
		view:stopActionByTag(kTypeDialogueRockActionTag)
		view:setPositionX(self.dialoguePosX)
		view:setPositionY(self.dialoguePosY)
	end
end

function DialogueNode:onTouchClick(_isTouch)
	if self._isAutoPlay and _isTouch then
		self:getAgent():setAutoPlayState(false)

		return
	end

	if self._contentText == nil then
		return
	end

	local next_node = self._renderNode:getChildByFullName("main.next_node")

	next_node:setVisible(false)
	AudioEngine:getInstance():playEffect("Se_Click_Story_2", false)

	if self._contentText.isTypeWriting and self._contentText:isTypeWriting() then
		self._contentText:finishTypeWriter()
	elseif not self:next() then
		self._contents = {}
		self._index = 0

		local function callback()
			if self._callback then
				local callback = self._callback

				self._callback = nil

				callback()
			end
		end

		local delay = cc.DelayTime:create(0.01)
		local sequence = cc.Sequence:create(delay, cc.CallFunc:create(callback))

		self._renderNode:runAction(sequence)
	end
end

function DialogueNode:startAutoPlay()
	self._isAutoPlay = true

	if self._contentText and self._contentText.isTypeWriting and not self._contentText:isTypeWriting() then
		self:runAutoPlay()
	end

	local next_node = self._renderNode:getChildByFullName("main.next_node")

	next_node:setVisible(false)
end

function DialogueNode:stopAutoPlay()
	if self._funAutoPlay then
		self._renderNode:stopAction(self._funAutoPlay)

		self._funAutoPlay = nil
	end

	self._isAutoPlay = false
end

local DAZI_DELAY_TIME = 0.06

function DialogueNode:runAutoPlay()
	if self._isAutoPlay then
		local contentLength = self._contentText:getContentLength()
		local delay = contentLength * DAZI_DELAY_TIME

		delay = delay > 0.5 and delay or 0.5
		self._funAutoPlay = performWithDelay(self._renderNode, function()
			self._funAutoPlay = nil

			self:onTouchClick(false)
		end, delay)
	end
end

function DialogueNode:isAutoPlay()
	return self._isAutoPlay
end

function DialogueNode:updateAutoPlayState(isAutoPlay)
	if isAutoPlay then
		self:startAutoPlay()
	else
		self:stopAutoPlay()
	end
end

function DialogueNode:startHidePlay(notAnim)
	local renderNode = self._renderNode:getChildByName("main")

	if not notAnim then
		local moveTo = cc.MoveBy:create(HideAnimTimeInterval, cc.p(0, -100))
		local fadeOut = cc.FadeOut:create(HideAnimTimeInterval)
		local sequence = cc.Spawn:create(moveTo, fadeOut)

		renderNode:runAction(sequence)
	end
end

function DialogueNode:stopHidePlay(notAnim)
	local renderNode = self._renderNode:getChildByName("main")

	if not notAnim then
		local moveTo = cc.MoveBy:create(HideAnimTimeInterval, cc.p(0, 100))
		local fadeIn = cc.FadeIn:create(HideAnimTimeInterval)
		local sequence = cc.Spawn:create(moveTo, fadeIn)

		renderNode:runAction(sequence)
	end
end

function DialogueNode:updateHideUIState(isAutoPlay, notAnim)
	if isAutoPlay then
		self:startHidePlay(notAnim)
	else
		self:stopHidePlay(notAnim)
	end
end

NormalDialogueNode = class("NormalDialogueNode", StageNode)

register_stage_node("NormalDialogue", NormalDialogueNode)

local actions = {
	speak = NormalDialogueSpeak,
	hide = NormalDialogueHide
}

NormalDialogueNode:extendActionsForClass(actions)

function NormalDialogueNode:initialize(config)
	super.initialize(self, config)
end

function NormalDialogueNode:createRenderNode(config)
	local renderNode = cc.CSLoader:createNode("asset/ui/NormalDialog.csb")
	local dialogueWidget = NormalDialogueWidget:new(renderNode)

	dialogueWidget:setupView()

	self._dialogueWidget = dialogueWidget

	renderNode:setVisible(false)

	return renderNode
end

function NormalDialogueNode:speak(args, onEnd)
	self._dialogueWidget:setVisible(true)
	self._dialogueWidget:updateView(args, onEnd)
end

function NormalDialogueNode:hide()
	self._dialogueWidget:setVisible(false)
end

OptionNode = class("OptionNode", StageNode)

register_stage_node("Option", OptionNode)

local actions = {
	speak = OptionSpeak,
	hide = OptionHide
}

OptionNode:extendActionsForClass(actions)

function OptionNode:initialize(config)
	super.initialize(self, config)

	self._contents = {}
	self._index = 0
end

function OptionNode:createRenderNode(config)
	local renderNode, widget

	if config.style then
		renderNode = cc.CSLoader:createNode("asset/ui/Option2Dialogue.csb")
		widget = PortraitOptionWidget:new(renderNode)
	else
		renderNode = cc.CSLoader:createNode("asset/ui/OptionDialogue.csb")
		widget = OptionWidget:new(renderNode)
	end

	widget:setupView()

	self._widget = widget

	renderNode:setVisible(false)

	return renderNode
end

function OptionNode:speak(args, onEnd)
	self._widget:setVisible(true)
	self._widget:updateView(args, onEnd)
end

function OptionNode:hide()
	self._widget:setVisible(false)
end

function OptionNode:removeSchedule()
	self._widget:releseSchedule()
end

CurtainNode = class("CurtainNode", StageNode)

register_stage_node("Curtain", CurtainNode)

function CurtainNode:initialize(config)
	super.initialize(self, config)
end

local acitons = {
	updateColor = CurtainUpdateColor
}

CurtainNode:extendActionsForClass(acitons)

function CurtainNode:createRenderNode(config)
	local winSize = cc.Director:getInstance():getVisibleSize()

	return cc.LayerColor:create(cc.c4b(0, 0, 0, 255), winSize.width, winSize.height)
end

function CurtainNode:updateColor(args)
	local renderNode = self:getRenderNode()
	local r, g, b, a = 0, 0, 0, 255

	if args and args.color then
		r = args.color[1] or 0
		g = args.color[2] or 0
		b = args.color[3] or 0
		a = args.color[4] or 255
	end

	renderNode:setColor(cc.c4b(r, g, b, a))
end

MaskNode = class("MaskNode", StageNode)

register_stage_node("Mask", MaskNode)

local acitons = {
	flashScreen = FlashScreen,
	hide = MaskNodeHide
}

MaskNode:extendActionsForClass(acitons)

function MaskNode:initialize(config)
	super.initialize(self, config)
end

function MaskNode:dispose()
	if self._flashTask ~= nil then
		cancelDelayCall(self._flashTask)

		self._flashTask = nil
	end

	super.dispose(self)
end

function MaskNode:createMaskSprite(config)
	local msSprite

	if config then
		if not config.resType then
			do
				local resType = ccui.TextureResType.localType

				msSprite = config.resType == ccui.TextureResType.localType and cc.MaskSprite:create(config.image) or cc.MaskSprite:createWithSpriteFrameName(config.image)
			end

			if msSprite == nil then
				msSprite = cc.MaskSprite:create("asset/story/guidequanmask.png")
			end
		end
	end

	return msSprite
end

function MaskNode:createRenderNode(config)
	local winSize = cc.Director:getInstance():getVisibleSize()
	local renderNode = cc.Node:create()

	renderNode:setContentSize(winSize)

	local maskLayer = cc.LayerColor:create(cc.c4b(0, 0, 0, 0), winSize.width, winSize.height)

	maskLayer:addTo(renderNode, 2)

	local msSprite = self:createMaskSprite()

	msSprite:setScale(0.8)

	local maskBeginNode = cc.MaskBeginNode:create(msSprite)

	maskBeginNode:setInverted(true)
	maskBeginNode:setIsEnabled(false)
	maskBeginNode:setVisible(false)
	maskBeginNode:addTo(renderNode, 1)
	maskBeginNode:getEndNode():addTo(renderNode, 3)

	self._maskBeginNode = maskBeginNode

	self._maskBeginNode:setPosition(cc.p(-200, -200))

	self._maskLayer = maskLayer
	self._style = config.style
	self._circleAnim = cc.MovieClip:create("bigqq_zhandouyindao")

	self._circleAnim:addTo(renderNode, 3)
	self._circleAnim:setVisible(false)

	return renderNode
end

function MaskNode:mask(touchMask, opacity, guideConfig)
	if guideConfig then
		self._hasAction = guideConfig.hasAction or false
	end

	if guideConfig then
		self._showGuideBtn = guideConfig.showGuideBtn or false
	end

	self._callback = guideConfig and guideConfig.callback

	self._renderNode:setVisible(true)
	self:setTouchEnabled(touchMask)

	opacity = opacity or 0
	self._opacity = opacity

	self._maskLayer:setOpacity(255 * opacity)

	local style = guideConfig and guideConfig.style

	if style ~= self._style then
		local config
		local scale = 1

		if style == "big" then
			config = {
				image = "asset/story/guideBigMask.png",
				resType = ccui.TextureResType.localType
			}
		elseif style == "special" then
			config = guideConfig and guideConfig.maskData
		else
			config = {
				image = "asset/story/guidequanmask.png",
				resType = ccui.TextureResType.localType
			}
			scale = 0.8
		end

		self._style = style

		local mySprite = self:createMaskSprite(config)

		mySprite:setScale(scale)
		self._maskBeginNode:setMaskContent(mySprite)
	end

	if guideConfig and guideConfig.holePos ~= nil then
		self._maskBeginNode:setIsEnabled(true)
		self._maskBeginNode:setVisible(true)
		self._maskBeginNode:setPosition(cc.p(0, 0))

		local msSprite = self._maskBeginNode:getMaskContent()

		msSprite:setPosition(guideConfig.holePos)

		local offset = guideConfig and guideConfig.offset

		if offset then
			msSprite:offset(offset.x, offset.y)
		end
	end
end

function MaskNode:runStageAction()
	if self._maskLayer:getOpacity() == self._opacity then
		self._maskLayer:setOpacity(self._opacity)
		self._maskLayer:runAction(cc.FadeTo:create(0.5, 127.5))
	end

	local sprite = self._maskBeginNode:getMaskContent()
	local posX, posY = sprite:getPosition()

	self._circleAnim:setPosition(cc.p(posX, posY))
	self._circleAnim:setVisible(true)
	self._circleAnim:gotoAndPlay(1)
	self._circleAnim:addEndCallback(function(cid, mc)
		mc:stop()
	end)
end

function MaskNode:onTouchEnded(touch, event)
	super.onTouchEnded(self, touch, event)

	if self._callback then
		self._callback()

		self._callback = nil

		return
	end

	if self._hasAction then
		self:runStageAction()
		self:showFlowTip()
	end

	if self._showGuideBtn then
		self:showGuideSkipBtn()
	end
end

function MaskNode:showGuideSkipBtn()
	local agent = self:getAgent()

	if agent == nil then
		return
	end

	local scriptName = agent:getCurrentScriptName()

	if scriptName == "guide_chapterOne1_4" or scriptName == "guide_Village_Building" then
		return
	end

	local scene = self:getScene()

	if scene then
		local guideSkipBtn = scene:getChildById("guideSkipButton")

		if guideSkipBtn then
			local renderNode = guideSkipBtn:getRenderNode()

			if renderNode and renderNode:isVisible() == false then
				renderNode:setVisible(true)
				renderNode:setOpacity(0)
				renderNode:runAction(cc.FadeTo:create(0.5, 255))
			end
		end
	end
end

function MaskNode:changeMaskLayer(colorInfo, duration, onEnd)
	if colorInfo == nil then
		return
	end

	local maskLayer = self._maskLayer

	maskLayer:stopAllActions()

	if colorInfo.color ~= nil then
		maskLayer:setColor(colorInfo.color)
	end

	if not colorInfo.opacity then
		local opacity = 255

		opacity = math.max(0, math.min(opacity, 255))

		if duration == nil or duration <= 0 then
			maskLayer:setVisible(opacity > 0)
			maskLayer:setOpacity(opacity)

			if onEnd ~= nil then
				onEnd()
			end
		else
			local fadeTo = cc.FadeTo:create(duration, opacity)
			local call = cc.CallFunc:create(function()
				maskLayer:setVisible(opacity > 0)

				if onEnd ~= nil then
					onEnd()
				end
			end)

			maskLayer:setVisible(true)
			maskLayer:runAction(cc.Sequence:create(fadeTo, call))
		end
	end
end

function MaskNode:updatePosition()
	local maskLayer = self._maskLayer
	local parentNode = maskLayer:getParent()

	if parentNode then
		local worldPt = cc.p(0, 0)
		local nodePosition = parentNode:convertToNodeSpace(worldPt)

		maskLayer:setPosition(nodePosition)
	end
end

function MaskNode:hide()
	self._renderNode:setVisible(false)
	self._maskBeginNode:setIsEnabled(false)
	self._maskBeginNode:setVisible(false)
end

function MaskNode:flashScreen(data, endCallback)
	local arr = data.arr
	local actions = {}
	local index = 0

	self._renderNode:setVisible(true)
	self._maskBeginNode:setIsEnabled(true)
	self._maskBeginNode:setVisible(true)

	local runNextAction, runOneAction

	function runOneAction(func, duration)
		if func ~= nil then
			func()
		end

		if self._flashTask ~= nil then
			cancelDelayCall(self._flashTask)

			self._flashTask = nil
		end

		if duration <= 0 then
			runNextAction()
		else
			self._flashTask = delayCallByTime(duration * 1000, runNextAction)
		end
	end

	function runNextAction()
		index = index + 1

		if index <= #actions then
			local action = actions[index]

			runOneAction(action.func, action.duration or 0)
		else
			if not data.isSave then
				self:changeMaskLayer({
					opacity = 0
				}, 0)
			end

			if endCallback ~= nil then
				endCallback()
			end
		end
	end

	for _, task in ipairs(arr) do
		local color = GameStyle:stringToColor(task.color)
		local opacity = (task.alpha or 1) * 255

		if task.fadein ~= nil and task.fadein > 0 then
			if not task.fadein then
				local duration = 0

				actions[#actions + 1] = {
					duration = duration,
					func = function()
						self:changeMaskLayer({
							color = color,
							opacity = opacity
						}, duration)
					end
				}
			end
		end

		if not task.duration then
			local duration = 1

			if duration > 0 then
				actions[#actions + 1] = {
					duration = duration,
					func = function()
						self:changeMaskLayer({
							color = color,
							opacity = opacity
						}, 0)
					end
				}
			end

			if task.fadeout ~= nil and task.fadeout > 0 then
				if not task.fadeout then
					local duration = 0

					actions[#actions + 1] = {
						duration = task.fadeout,
						func = function()
							self:changeMaskLayer({
								opacity = 0,
								color = color
							}, duration)
						end
					}
				end
			end
		end
	end

	self:updatePosition()
	runNextAction()
end

function MaskNode:showFlowTip()
	local dispatcher = DmGame:getInstance()

	dispatcher:dispatch(ShowTipEvent({
		once = true,
		tip = Strings:get("NewPlayerGuide_Tips")
	}))
end

ContainerNode = class("ContainerNode", StageNode)

register_stage_node("Container", ContainerNode)

function ContainerNode:initialize(config)
	super.initialize(self, config)
end

function ContainerNode:createRenderNode(config)
	return cc.Node:create()
end

CameraNode = class("CameraNode", StageNode)

register_stage_node("Camera", CameraNode)

local acitons = {
	movingshot = CameraMovingshot,
	moveTo = CameraMoveTo,
	moveBy = CameraMoveBy,
	scaleTo = CameraScaleTo
}

CameraNode:extendActionsForClass(acitons)

CameraMoveType = {
	kVertical = 2,
	kHorizontal = 1,
	kBoth = 3
}

function CameraNode:initialize(config)
	super.initialize(self, config)
end

function CameraNode:dispose()
	if self._movingshotTask then
		self._movingshotTask:stop()

		self._movingshotTask = nil
	end

	local actorRenderNode = self:getActorRenderNode()

	if actorRenderNode then
		if self._moveAction then
			actorRenderNode:stopAction(self._moveAction)

			self._moveAction = nil
		end

		if self._scaleAction then
			actorRenderNode:stopAction(self._scaleAction)

			self._scaleAction = nil
		end
	end

	super.dispose(self)
end

function CameraNode:movingshot(args)
	local focus = args.focus
	local oneshot = args.oneshot

	local function onEnd()
		if args.onEnd then
			args.onEnd()
		end
	end

	if self._movingshotTask then
		self._movingshotTask:stop()

		self._movingshotTask = nil
	end

	local focusRenderNode = focus and focus:getRenderNode()
	local focusParentNode = focusRenderNode and focusRenderNode:getParent()

	if focus == nil or focusRenderNode == nil or focusParentNode == nil then
		onEnd()

		return
	end

	local focusNodePt = cc.p(focusRenderNode:getPosition())

	args.position = focusParentNode:convertToWorldSpace(focusNodePt)

	self:moveTo(args)

	if not oneshot then
		self._lastPosition = focusNodePt

		local moveArgs = {}

		moveArgs.moveType = args.moveType
		moveArgs.range = args.range

		local function update()
			local focusNodePt = cc.p(focusRenderNode:getPosition())

			if self._lastPosition.x ~= focusNodePt.x or self._lastPosition.y ~= focusNodePt.y then
				moveArgs.position = focusParentNode:convertToWorldSpace(focusNodePt)

				self:moveTo(moveArgs)

				self._lastPosition = focusNodePt
			end
		end

		self._movingshotTask = LuaScheduler:getInstance():schedule(update, 0, false)
	end
end

function CameraNode:moveTo(args)
	local duration = args.duration
	local worldPt = args.position

	worldPt.x = worldPt.x or 0
	worldPt.y = worldPt.y or 0

	if not args.moveType then
		local moveType = CameraMoveType.kHorizontal
		local range = args.range

		local function onEnd()
			if args.onEnd then
				args.onEnd()
			end
		end

		local actorRenderNode = self:getActorRenderNode()

		if actorRenderNode == nil then
			onEnd()

			return
		end

		local winSize = cc.Director:getInstance():getVisibleSize()
		local targetWorldPt = cc.p(winSize.width * 0.5, winSize.height * 0.5)
		local offsetPt = cc.pSub(targetWorldPt, worldPt)

		if moveType == CameraMoveType.kHorizontal then
			offsetPt.y = 0
		elseif moveType == CameraMoveType.kVertical then
			offsetPt.x = 0
		end

		local position = cc.p(actorRenderNode:getPosition())

		position = cc.pAdd(position, offsetPt)

		if range then
			local actorNodeSize = actorRenderNode:getContentSize()
			local xmin, xmax = 0, winSize.width - range.width
			local ymin, ymax = 0, winSize.height - range.height

			position.x = cc.clampf(position.x, xmin, xmax)
			position.y = cc.clampf(position.y, ymin, ymax)
		end

		if duration == nil or duration == 0 then
			actorRenderNode:setPosition(position)
			onEnd()
		else
			if self._moveAction then
				actorRenderNode:stopAction(self._moveAction)

				self._moveAction = nil
			end

			local moveAction = cc.MoveTo:create(duration, position)

			self._moveAction = cc.Sequence:create(moveAction, cc.CallFunc:create(function()
				self._moveAction = nil

				onEnd()
			end))

			actorRenderNode:runAction(self._moveAction)
		end
	end
end

function CameraNode:moveBy(args)
	local duration = args.duration
	local deltaPosition = args.deltaPosition

	deltaPosition.x = -deltaPosition.x or 0
	deltaPosition.y = -deltaPosition.y or 0

	if not args.moveType then
		local moveType = CameraMoveType.kHorizontal

		local function onEnd()
			if args.onEnd then
				args.onEnd()
			end
		end

		local actorRenderNode = self:getActorRenderNode()

		if actorRenderNode == nil then
			onEnd()

			return
		end

		if moveType == CameraMoveType.kHorizontal then
			deltaPosition.y = 0
		elseif moveType == CameraMoveType.kVertical then
			deltaPosition.x = 0
		end

		if duration == nil or duration == 0 then
			actorRenderNode:offset(deltaPosition)
			onEnd()
		else
			if self._moveAction then
				actorRenderNode:stopAction(self._moveAction)

				self._moveAction = nil
			end

			local moveAction = cc.MoveBy:create(duration, deltaPosition)

			self._moveAction = cc.Sequence:create(moveAction, cc.CallFunc:create(function()
				self._moveAction = nil

				onEnd()
			end))

			actorRenderNode:runAction(self._moveAction)
		end
	end
end

function CameraNode:getActorRenderNode()
	local scene = self:getScene()

	return scene and scene:getStageRenderNode()
end

function CameraNode:scaleTo(args)
	local scale = args.scale
	local duration = args.duration

	local function onEnd()
		if args.onEnd then
			args.onEnd()
		end
	end

	local actorRenderNode = self:getActorRenderNode()

	if actorRenderNode == nil then
		onEnd()

		return
	end

	local winSize = cc.Director:getInstance():getVisibleSize()
	local worldPt = cc.p(winSize.width * 0.5, winSize.height * 0.5)
	local ptInActor = actorRenderNode:convertToNodeSpace(worldPt)
	local actorNodeSize = actorRenderNode:getContentSize()
	local anchorPoint = cc.p(ptInActor.x / actorNodeSize.width, ptInActor.y / actorNodeSize.height)

	actorRenderNode:setIgnoreAnchorPointForPosition(true)
	actorRenderNode:setAnchorPoint(anchorPoint)

	if duration == nil or duration == 0 then
		actorRenderNode:setScale(scale)
		onEnd()
	else
		if self._scaleAction then
			actorRenderNode:stopAction(self._scaleAction)

			self._scaleAction = nil
		end

		local scaleAction = cc.ScaleTo:create(duration, scale)

		self._scaleAction = cc.Sequence:create(scaleAction, cc.CallFunc:create(function()
			self._scaleAction = nil

			onEnd()
		end))

		actorRenderNode:runAction(self._scaleAction)
	end
end

ColorBackGroundNode = class("ColorBackGroundNode", StageNode)

register_stage_node("ColorBackGround", ColorBackGroundNode)

local acitons = {
	hide = ColorBackGroundHide,
	show = ColorBackGroundShow
}

ColorBackGroundNode:extendActionsForClass(acitons)

function ColorBackGroundNode:initialize(config)
	super.initialize(self, config)
end

function ColorBackGroundNode:createRenderNode(config)
	local renderNode = cc.LayerColor:create(GameStyle:stringToColor("#000000"), 1386, 852)

	renderNode:setAnchorPoint(cc.p(0.5, 0.5))
	renderNode:setVisible(false)

	return renderNode
end

function ColorBackGroundNode:show(config)
	if config and config.bgColor then
		self._renderNode:initWithColor(GameStyle:stringToColor(config.bgColor))
	end

	self._renderNode:setVisible(true)
end

function ColorBackGroundNode:hide()
	self._renderNode:setVisible(false)
end

SkipButtonNode = class("SkipButtonNode", StageNode)

register_stage_node("SkipButton", SkipButtonNode)

local acitons = {
	hide = SkipButtonHide,
	show = SkipButtonShow
}

SkipButtonNode:extendActionsForClass(acitons)

function SkipButtonNode:initialize(config)
	super.initialize(self, config)
end

function SkipButtonNode:createRenderNode(config)
	local renderNode = ccui.Button:create("asset/common/ck_skip_btn.png", "asset/common/ck_skip_btn.png")

	mapButtonHandlerClick(self, renderNode, function(sender, eventType)
		self:onClickSkip(sender, eventType)
	end, renderNode)

	local title1 = cc.Label:createWithTTF(Strings:get("Story_Skip"), TTF_FONT_FZYH_R, 24)

	title1:enableOutline(cc.c4b(0, 0, 0, 204), 2)
	title1:addTo(renderNode):offset(renderNode:getContentSize().width * 0.5, renderNode:getContentSize().height * 0.6)

	local lineGradiantVec1 = {
		{
			ratio = 0.5,
			color = cc.c4b(255, 255, 255, 255)
		},
		{
			ratio = 1,
			color = cc.c4b(225, 231, 252, 255)
		}
	}

	title1:enablePattern(cc.LinearGradientPattern:create(lineGradiantVec1, {
		x = 0,
		y = -1
	}))

	if getCurrentLanguage() == GameLanguageType.DE then
		title1:setScale(0.5)
	end

	renderNode:setVisible(false)

	return renderNode
end

function SkipButtonNode:onClickSkip()
	local agent = self:getAgent()

	if agent == nil then
		return
	end

	if self._date then
		self:showLovesTips()

		return
	end

	self:skip()
end

function SkipButtonNode:skip()
	local agent = self:getAgent()

	if agent == nil then
		return
	end

	agent:setAutoPlayState(false, true)
	AudioEngine:getInstance():stopEffectsByType()
	AudioEngine:getInstance():playEffect("Se_Click_Story_2", false)

	if AudioEngine:getInstance():getElide() then
		AudioEngine:getInstance():setElide(false)
	end

	if agent._guideStatisticSta then
		local scriptName = agent:getCurrentScriptName()
		local content = {
			type = "loginpoint",
			point = scriptName .. "_skip"
		}

		StatisticSystem:send(content)
	end

	agent:skip(true)
end

function SkipButtonNode:showLovesTips()
	local agent = self:getAgent()

	agent:setAutoPlayState(false, true)

	if agent.showSkipChoose then
		local ctx = agent:getCurrentScriptCtx()

		if ctx ~= nil then
			local scene = ctx:getScene()
			local actor = scene:getChildById("skipChoose")

			if actor == nil then
				actor = StageNodeFactory:createSkipChooseDialog(scene)
			end

			if actor then
				actor:show()

				local director = agent:getDirector()
				local gallerySystem = director:getInjector():getInstance(GallerySystem)
				local opts, loves = gallerySystem:getDateOptionsValue()
				local text = Strings:get("UI_DateSpik", {
					fontName = TTF_FONT_FZYH_M,
					Num = loves
				})

				actor:setView({
					type = "date",
					text = text
				})
			end
		end
	end
end

function SkipButtonNode:hide()
	self._renderNode:setVisible(false)
end

function SkipButtonNode:show(args)
	if args.date then
		self._date = args.date

		local agent = self:getAgent()
		local director = agent:getDirector()
		local gallerySystem = director:getInjector():getInstance(GallerySystem)

		self._renderNode:setVisible(gallerySystem:isShowSkip())

		return
	end

	self._renderNode:setVisible(true)
end

function SkipButtonNode:startHidePlay(notAnim)
	local renderNode = self._renderNode

	if not notAnim then
		local moveTo = cc.MoveBy:create(HideAnimTimeInterval, cc.p(0, 100))
		local fadeOut = cc.FadeOut:create(HideAnimTimeInterval)
		local sequence = cc.Spawn:create(moveTo, fadeOut)

		renderNode:runAction(sequence)
	end
end

function SkipButtonNode:stopHidePlay(notAnim)
	local renderNode = self._renderNode

	if not notAnim then
		local moveTo = cc.MoveBy:create(HideAnimTimeInterval, cc.p(0, -100))
		local fadeIn = cc.FadeIn:create(HideAnimTimeInterval)
		local sequence = cc.Spawn:create(moveTo, fadeIn)

		renderNode:runAction(sequence)
	end
end

function SkipButtonNode:updateHideUIState(isAutoPlay, notAnim)
	if isAutoPlay then
		self:startHidePlay(notAnim)
	else
		self:stopHidePlay(notAnim)
	end
end

GuideSkipButtonNode = class("GuideSkipButtonNode", StageNode)

register_stage_node("GuideSkipButton", GuideSkipButtonNode)

function GuideSkipButtonNode:initialize(config)
	super.initialize(self, config)
end

function GuideSkipButtonNode:createRenderNode(config)
	local renderNode = ccui.Layout:create()

	renderNode:setAnchorPoint(cc.p(0.5, 0.5))
	renderNode:setContentSize(cc.size(100, 100))
	renderNode:setScale(1.2)

	local image = cc.Sprite:create("asset/common/ck_skip_btn.png")

	image:addTo(renderNode):center(renderNode:getContentSize())
	renderNode:setTouchEnabled(true)
	renderNode:addTouchEventListener(function(sender, eventType)
		if eventType == ccui.TouchEventType.ended then
			AudioEngine:getInstance():playEffect("Se_Click_Story_2", false)
			self:onClickSkip(sender, eventType)
		end
	end)

	local title1 = cc.Label:createWithTTF(Strings:get("NewPlayerGuide_Jump"), TTF_FONT_FZYH_R, 24)

	title1:enableOutline(cc.c4b(0, 0, 0, 204), 2)
	title1:addTo(image):offset(image:getContentSize().width * 0.5, image:getContentSize().height * 0.6)

	local lineGradiantVec1 = {
		{
			ratio = 0.5,
			color = cc.c4b(255, 255, 255, 255)
		},
		{
			ratio = 1,
			color = cc.c4b(225, 231, 252, 255)
		}
	}

	title1:enablePattern(cc.LinearGradientPattern:create(lineGradiantVec1, {
		x = 0,
		y = -1
	}))
	renderNode:setVisible(false)

	return renderNode
end

function GuideSkipButtonNode:onClickSkip(sender, eventType)
	local agent = self:getAgent()

	if agent == nil then
		return
	end

	if agent._isStatisticSta then
		local scriptName = agent:getCurrentScriptName()
		local content = {
			type = "loginpoint",
			point = scriptName .. "_skip"
		}

		StatisticSystem:send(content)
	end

	agent:skip(true)
end

function GuideSkipButtonNode:hide()
	self._renderNode:setVisible(false)
end

function GuideSkipButtonNode:show(waitType)
	self._renderNode:setVisible(true)
end

GuideSkipAllButtonNode = class("GuideSkipAllButtonNode", StageNode)

register_stage_node("GuideSkipAllButton", GuideSkipAllButtonNode)

local acitons = {
	hide = GuideSkipAllButtonHide,
	show = GuideSkipAllButtonShow
}

GuideSkipAllButtonNode:extendActionsForClass(acitons)

function GuideSkipAllButtonNode:initialize(config)
	super.initialize(self, config)
end

function GuideSkipAllButtonNode:createRenderNode(config)
	local renderNode = ccui.Button:create("asset/common/ck_skip_btn.png", "asset/common/ck_skip_btn.png")

	mapButtonHandlerClick(self, renderNode, function(sender, eventType)
		self:onClickSkip(sender, eventType)
	end, renderNode)

	local title1 = cc.Label:createWithTTF(Strings:get("Story_Skip"), TTF_FONT_FZYH_R, 24)

	title1:enableOutline(cc.c4b(0, 0, 0, 204), 2)
	title1:addTo(renderNode):offset(0, 0)

	local lineGradiantVec1 = {
		{
			ratio = 0.5,
			color = cc.c4b(255, 255, 255, 255)
		},
		{
			ratio = 1,
			color = cc.c4b(225, 231, 252, 255)
		}
	}

	title1:enablePattern(cc.LinearGradientPattern:create(lineGradiantVec1, {
		x = 0,
		y = -1
	}))

	if getCurrentLanguage() == GameLanguageType.DE then
		title1:setScale(0.5)
	end

	renderNode:setVisible(false)

	return renderNode
end

function GuideSkipAllButtonNode:onClickSkip()
	local agent = self:getAgent()

	if agent == nil then
		return
	end

	agent:save("GUIDE_SKIP_ALL")
	agent:skip(true)
end

function GuideSkipAllButtonNode:hide()
	self._renderNode:setVisible(false)
end

function GuideSkipAllButtonNode:show()
	self._renderNode:setVisible(true)
end

ReviewButtonNode = class("ReviewButtonNode", StageNode)

register_stage_node("ReviewButton", ReviewButtonNode)

local acitons = {
	hide = ReviewButtonNodeHide,
	show = ReviewButtonNodeShow
}

ReviewButtonNode:extendActionsForClass(acitons)

function ReviewButtonNode:initialize(config)
	super.initialize(self, config)
end

function ReviewButtonNode:createRenderNode(config)
	local renderNode = ccui.Button:create("asset/common/ck_auto_btn1.png", "asset/common/ck_auto_btn2.png")

	mapButtonHandlerClick(self, renderNode, {
		clickAudio = "Se_Click_Story_2",
		func = function(sender, eventType)
			self:onClickReview()
		end
	}, renderNode)

	local title1 = cc.Label:createWithTTF(Strings:get("Story_Review"), TTF_FONT_FZYH_R, 18)

	title1:enableOutline(cc.c4b(0, 0, 0, 204), 2)
	title1:addTo(renderNode):offset(renderNode:getContentSize().width * 0.5, renderNode:getContentSize().height * 0.65)

	local lineGradiantVec1 = {
		{
			ratio = 0.5,
			color = cc.c4b(255, 255, 255, 255)
		},
		{
			ratio = 1,
			color = cc.c4b(225, 231, 252, 255)
		}
	}

	title1:enablePattern(cc.LinearGradientPattern:create(lineGradiantVec1, {
		x = 0,
		y = -1
	}))

	if getCurrentLanguage() == GameLanguageType.DE then
		title1:setScale(0.7)
	end

	renderNode:setVisible(false)

	return renderNode
end

function ReviewButtonNode:onClickReview()
	local agent = self:getAgent()

	if agent ~= nil then
		local ctx = agent:getCurrentScriptCtx()

		if ctx ~= nil then
			local scene = ctx:getScene()
			local actor = scene:getChildById("review")

			if actor == nil then
				actor = StageNodeFactory:createReviewDialog(scene)
			end

			if actor then
				actor:show()
			end
		end
	end
end

function ReviewButtonNode:hide()
	self._renderNode:setVisible(false)
end

function ReviewButtonNode:show()
	self._renderNode:setVisible(true)
end

function ReviewButtonNode:startHidePlay(notAnim)
	local renderNode = self._renderNode

	if not notAnim then
		local moveTo = cc.MoveBy:create(HideAnimTimeInterval, cc.p(0, 100))
		local fadeOut = cc.FadeOut:create(HideAnimTimeInterval)
		local sequence = cc.Spawn:create(moveTo, fadeOut)

		renderNode:runAction(sequence)
	end
end

function ReviewButtonNode:stopHidePlay(notAnim)
	local renderNode = self._renderNode

	if not notAnim then
		local moveTo = cc.MoveBy:create(HideAnimTimeInterval, cc.p(0, -100))
		local fadeIn = cc.FadeIn:create(HideAnimTimeInterval)
		local sequence = cc.Spawn:create(moveTo, fadeIn)

		renderNode:runAction(sequence)
	end
end

function ReviewButtonNode:updateHideUIState(isAutoPlay, notAnim)
	if isAutoPlay then
		self:startHidePlay(notAnim)
	else
		self:stopHidePlay(notAnim)
	end
end

DialogueChooseNode = class("DialogueChooseNode", StageNode)

register_stage_node("DialogueChoose", DialogueChooseNode)

local actions = {
	show = DialogueChooseShow
}

DialogueChooseNode:extendActionsForClass(actions)

function DialogueChooseNode:initialize(config)
	super.initialize(self, config)

	self._contents = {}
	self._index = 0
end

function DialogueChooseNode:createRenderNode(config)
	local renderNode = cc.CSLoader:createNode("asset/ui/DialogueChooseDialog.csb")
	local widget = DialogueChooseShowWidget:new(renderNode)

	widget:setupView()

	self._widget = widget

	self._widget:getView():setVisible(false)

	return renderNode
end

function DialogueChooseNode:show(args, onEnd)
	self._widget:getView():setVisible(true)

	args.agent = self:getAgent()

	self._widget:updateView(args, onEnd, self)
end

function DialogueChooseNode:hide()
	self._widget:getView():setVisible(false)
end

PrinterEffectNode = class("PrinterEffectNode", StageNode)

register_stage_node("PrinterEffect", PrinterEffectNode)

local actions = {
	show = PrinterEffectShow,
	hide = PrinterEffectHide
}

PrinterEffectNode:extendActionsForClass(actions)

function PrinterEffectNode:initialize(config)
	super.initialize(self, config)

	self._contents = {}
	self._index = 0
end

function PrinterEffectNode:createRenderNode(config)
	local renderNode = cc.CSLoader:createNode("asset/ui/PrinterEffectDialog.csb")
	local widget = PrinterEffectDialogWidget:new(renderNode)

	widget:setupView()

	self._widget = widget

	self._widget:getView():setVisible(false)

	return renderNode
end

function PrinterEffectNode:show(args, onEnd)
	self._widget:getView():setVisible(true)
	self._widget:updateView(args, onEnd, self)
end

function PrinterEffectNode:hide(args, onEnd)
	self._widget:getView():setVisible(false)

	if onEnd then
		onEnd()
	end
end

ReviewNode = class("ReviewNode", StageNode)

register_stage_node("Review", ReviewNode)

function ReviewNode:initialize(config)
	super.initialize(self, config)
end

function ReviewNode:createRenderNode(config)
	local renderNode = cc.CSLoader:createNode("asset/ui/ReviewDialog.csb")
	local widget = ReviewDialogueWidget:new(renderNode)

	widget:setupView()

	self._widget = widget
	widget.mainNode = self

	self._widget:getView():setVisible(false)

	return renderNode
end

function ReviewNode:show()
	local dialogues = {}
	local agent = self:getAgent()

	if agent ~= nil and agent._dialogues then
		dialogues = agent._dialogues
	end

	self._widget:getView():setVisible(true)
	self._widget:updateView(dialogues)
	self:getAgent():setAutoPlayState(false, true)
end

function ReviewNode:hide()
	self._widget:getView():setVisible(false)
	self:getAgent():setAutoPlayState(true, true)
end

SkipChooseNode = class("SkipChooseNode", StageNode)

register_stage_node("SkipChoose", SkipChooseNode)

function SkipChooseNode:initialize(config)
	super.initialize(self, config)
end

function SkipChooseNode:createRenderNode(config)
	local renderNode = cc.CSLoader:createNode("asset/ui/SkipChooseDialog.csb")
	local btnOk = renderNode:getChildByFullName("main.btnOk")
	local btnCanel = renderNode:getChildByFullName("main.btnCanel")

	btnOk:getChildByName("name"):setString(Strings:get("story_des_4"))
	btnOk:getChildByName("name1"):setString(Strings:get("UITitle_EN_Queding"))
	btnCanel:getChildByName("name"):setString(Strings:get("story_des_3"))
	btnCanel:getChildByName("name1"):setString(Strings:get("UITitle_EN_Quxiao"))

	local touchLayer = renderNode:getChildByName("touch_layer")

	touchLayer:addClickEventListener(function()
		return
	end)
	mapButtonHandlerClick(self, btnOk:getChildByName("button"), function(sender, eventType)
		self:onClickBtnOk()
	end, renderNode)
	mapButtonHandlerClick(self, btnCanel:getChildByName("button"), function(sender, eventType)
		self:onClickBtnCanel()
	end, renderNode)
	renderNode:setVisible(false)

	self._desLab = renderNode:getChildByFullName("main.desLab")

	return renderNode
end

function SkipChooseNode:onClickBtnOk()
	self:hide()

	local agent = self:getAgent()

	if agent == nil then
		return
	end

	local ctx = agent:getCurrentScriptCtx()

	if ctx ~= nil then
		local scene = ctx:getScene()
		local actor = scene:getChildById("skipButton")

		actor:skip()
	end
end

function SkipChooseNode:onClickBtnCanel()
	self:hide()
end

function SkipChooseNode:onClickBtnBack()
	return
end

function SkipChooseNode:setView(data)
	if data and data.type == "date" then
		self._desLab:setString("")

		local desc = self._desLab:getChildByName("desLabRichText")

		if not desc then
			local richText = ccui.RichText:createWithXML("", {})

			richText:addTo(self._desLab)
			richText:setName("desLabRichText")

			desc = richText
		end

		desc:setString(data.text)
	end
end

function SkipChooseNode:show()
	local view = self:getRenderNode()

	if self._bindWidget == nil then
		self._bindWidget = true

		local storyAgent = self:getAgent()
		local direc = storyAgent:getDirector()
		local bgNode = view:getChildByFullName("main.tipnode")

		bindWidget(direc, bgNode, PopupNormalWidget, {
			btnHandler = {
				clickAudio = "Se_Click_Close_2",
				func = bind1(self.onClickBtnCanel, self)
			},
			title = Strings:get("story_des_1"),
			title1 = Strings:get("UITitle_EN_Tishi"),
			bgSize = {
				width = 740,
				height = 410
			}
		})
	end

	view:setVisible(true)
	self:getAgent():setAutoPlayState(false, true)
end

function SkipChooseNode:hide()
	local view = self:getRenderNode()

	view:setVisible(false)
	self:getAgent():setAutoPlayState(true, true)
end

ChapterDialogNode = class("ChapterDialogNode", StageNode)

register_stage_node("ChapterDialog", ChapterDialogNode)

local actions = {
	show = ChapterDialogShow,
	hide = ChapterDialogHide
}

ChapterDialogNode:extendActionsForClass(actions)

function ChapterDialogNode:initialize(config)
	super.initialize(self, config)

	self._contents = {}
	self._index = 0
end

function ChapterDialogNode:createRenderNode(config)
	local renderNode = cc.CSLoader:createNode("asset/ui/ChapterDialog.csb")
	local widget = ChapterDialogWidget:new(renderNode)

	widget:setupView()

	self._widget = widget

	self._widget:getView():setVisible(false)

	return renderNode
end

function ChapterDialogNode:show(args, onEnd)
	self._widget:getView():setVisible(true)
	self._widget:updateView(args, onEnd, self)
end

function ChapterDialogNode:hide(args, onEnd)
	self._widget:getView():setVisible(false)

	if onEnd then
		onEnd()
	end
end

WorldScrollTextNode = class("WorldScrollTextNode", StageNode)

register_stage_node("WorldScrollText", WorldScrollTextNode)

local actions = {
	show = WorldScrollTextNodeShow,
	hide = WorldScrollTextNodeHide
}

WorldScrollTextNode:extendActionsForClass(actions)

function WorldScrollTextNode:initialize(config)
	super.initialize(self, config)

	self._contents = {}
	self._index = 0
	self._playSpeed = 0
	self._doubleClickAct = nil
	self._speedUp = 1
end

function WorldScrollTextNode:createRenderNode(config)
	local winSize = cc.size(1136, 640)
	local renderNode = cc.Node:create()

	renderNode:setContentSize(winSize)

	local touchLayer = ccui.Layout:create()

	touchLayer:setAnchorPoint(cc.p(0.5, 0.5))
	touchLayer:addTo(renderNode, 2):center(renderNode:getContentSize())
	touchLayer:setContentSize(cc.size(winSize.width, winSize.height))
	touchLayer:setTouchEnabled(false)
	touchLayer:addTouchEventListener(function(sender, eventType)
		self:onTouchLayer(sender, eventType)
	end)

	self._touchLayer = touchLayer

	local textRootNode = cc.Node:create()

	textRootNode:setAnchorPoint(cc.p(0.5, 0.5))
	textRootNode:setContentSize(cc.size(winSize.width, winSize.height))
	textRootNode:addTo(renderNode, 3):center(renderNode:getContentSize())

	self._textRootNode = textRootNode

	renderNode:setVisible(false)

	return renderNode
end

function WorldScrollTextNode:show(args, onEnd)
	local renderNode = self._renderNode

	renderNode:setVisible(true)
	self:clearContentList()

	if not args.content then
		self._playSpeed = args.speed or 1

		if not args.heightSpace then
			local heightSpace = 10
			local textRootNode = self._textRootNode
			local offx = textRootNode:getContentSize().width * 0.5
			local offy = textRootNode:getContentSize().height
			local allHight = 0
			local textList = {}
			local textEnv = {
				fontName_FONT_1 = CUSTOM_TTF_FONT_1,
				fontName_FONT_2 = CUSTOM_TTF_FONT_2,
				fontName_FZYH_R = TTF_FONT_FZYH_R,
				fontName_FZYH_M = TTF_FONT_FZYH_M,
				fontName_STORY = TTF_FONT_STORY
			}

			for i, v in ipairs(args.content) do
				local tmpl = TextTemplate:new(Strings:get(v, {}))
				local text = tmpl:stringify(textEnv, nil)
				local contentText = ccui.RichText:createWithXML(text, {})

				contentText:ignoreContentAdaptWithSize(false)
				contentText:setAnchorPoint(cc.p(0.5, 1))
				contentText:setWrapMode(1)
				contentText:addTo(textRootNode, i)

				local width = contentText:getContentSize().width

				contentText:setPosition(cc.p(offx, offy - allHight))
				contentText:renderContent(width, 0, true)

				allHight = allHight + contentText:getContentSize().height + heightSpace
				textList[i] = contentText
			end

			self._allHight = allHight
			self._contentTextList = textList

			self._touchLayer:setTouchEnabled(true)
			self:playScrollAction(onEnd)
		end
	end
end

function WorldScrollTextNode:hide(args, onEnd)
	if self._doubleClickAct then
		self._touchLayer:stopAction(self._doubleClickAct)

		self._doubleClickAct = nil
	end

	self._speedUp = 1

	self:stopScrollAction()
	self:clearContentList()
	self._touchLayer:setTouchEnabled(false)

	local renderNode = self._renderNode

	renderNode:setVisible(false)
end

function WorldScrollTextNode:clearContentList()
	if not self._contentTextList then
		return
	end

	for i, v in ipairs(self._contentTextList) do
		v:removeFromParent()
	end

	self._contentTextList = nil
end

function WorldScrollTextNode:playScrollAction(onEnd)
	self:stopScrollAction()

	local textRootNode = self._textRootNode
	local size = self._renderNode:getContentSize()

	textRootNode:setPositionY(-size.height * 0.5 - 20)

	local srcY = textRootNode:getPositionY()
	local maxY = self._allHight + size.height + 10
	local movY = 0

	schedule(textRootNode, function()
		movY = movY + self._playSpeed * self._speedUp

		textRootNode:setPositionY(srcY + movY)

		if movY >= maxY then
			self:hide()

			if onEnd then
				onEnd()
			end
		end
	end, 0.03333333333333333)
end

function WorldScrollTextNode:stopScrollAction()
	self._textRootNode:stopAllActions()
end

function WorldScrollTextNode:onTouchLayer(sender, eventType)
	if eventType == ccui.TouchEventType.ended or eventType == ccui.TouchEventType.canceled then
		self._speedUp = 2

		if self._doubleClickAct then
			self._touchLayer:stopAction(self._doubleClickAct)

			self._doubleClickAct = nil
		end
	elseif eventType == ccui.TouchEventType.began and not self._doubleClickAct then
		self._doubleClickAct = performWithDelay(self._touchLayer, function()
			self._doubleClickAct = nil
			self._speedUp = 4
		end, 0.3)
	end
end

RenameDialogNode = class("RenameDialogNode", StageNode)

register_stage_node("RenameDialog", RenameDialogNode)

function RenameDialogNode:initialize(config)
	super.initialize(self, config)

	self._contents = {}
	self._index = 0
end

function RenameDialogNode:createRenderNode(config)
	local renderNode = cc.CSLoader:createNode("asset/ui/RenameDialog.csb")

	self._widget = RenameDialogWidget:new(renderNode)

	return renderNode
end

function RenameDialogNode:show(args, onEnd)
	self._widget:getView():setVisible(true)

	if self._widget._renameSetUpView == nil then
		self._widget._renameSetUpView = true

		self._widget:setupView()
	end

	self._widget:updateView(args, onEnd, self:getAgent())
end

function RenameDialogNode:hide(args, onEnd)
	self._widget:getView():setVisible(false)

	if onEnd then
		onEnd()
	end
end

StoryLoveNode = class("StoryLoveNode", StageNode)

register_stage_node("StoryLove", StoryLoveNode)

function StoryLoveNode:initialize(config)
	super.initialize(self, config)
end

function StoryLoveNode:createRenderNode(config)
	self.addLoveList = {}
	self.showIndex = 0
	self.showSta = false

	return (cc.CSLoader:createNode("asset/ui/StoryLove.csb"))
end

function StoryLoveNode:hide()
	self._renderNode:setVisible(false)

	self.addLoveList = {}
	self.showIndex = 0
end

function StoryLoveNode:show(id)
	local data = ConfigReader:getDataByNameIdAndKey("StoryPointLove", id, "LoveAdd") or {}

	for id, num in pairs(data) do
		local info = {}

		info.id = id
		info.num = num
		self.addLoveList[#self.addLoveList + 1] = info
	end

	if self.showSta then
		return
	end

	self.showSta = true

	self:showLove()
end

function StoryLoveNode:showLove()
	local renderNode = self._renderNode

	self.showIndex = self.showIndex + 1

	if self.addLoveList[self.showIndex] then
		renderNode:setVisible(true)

		local data = self.addLoveList[self.showIndex]
		local heroId = data.id
		local animName = self:getAnimName(data.num)
		local animBaseNode = renderNode:getChildByName("Node_anim")
		local animNode = animBaseNode:getChildByName(animName)

		if animNode == nil then
			animNode = cc.MovieClip:create(animName .. "_juqinghaogandutisheng")

			animNode:setPlaySpeed(1.5)
			animBaseNode:addChild(animNode)
			animNode:setName(animName)
			animNode:addCallbackAtFrame(80, function(cid, mc)
				mc:gotoAndStop(1)
				mc:setVisible(false)
				self:showLove()
			end)
		end

		animNode:setVisible(true)
		animNode:gotoAndPlay(1)

		local headNode = renderNode:getChildByName("Node_head")

		headNode:removeAllChildren()

		local imgHead = self:createHeadImg(heroId)

		headNode:addChild(imgHead)

		local numLabel = animNode:getChildByFullName("labelNode.numNode")

		if numLabel then
			numLabel:removeAllChildren()

			if data.num > 0 then
				local numNode = self:createNumLabel(data.num)

				numLabel:addChild(numNode)
			end
		end

		local nameLabel = renderNode:getChildByName("Text_name")
		local heroName = Strings:get(ConfigReader:getDataByNameIdAndKey("HeroBase", heroId, "Name"))

		nameLabel:setString(heroName)
	else
		self.addLoveList = {}
		self.showIndex = 0
		self.showSta = false

		renderNode:setVisible(false)
	end
end

function StoryLoveNode:getAnimName(num)
	local data = ConfigReader:getDataByNameIdAndKey("ConfigValue", "StoryLoveType", "content")
	local hate = data.hate
	local normal = data.normal
	local animName

	if num >= hate[1] and num <= hate[2] then
		animName = "animNone"

		AudioEngine:getInstance():playEffect("Se_Alert_Favor_Down", false)
	elseif num >= normal[1] and num <= normal[2] then
		animName = "animOne"

		AudioEngine:getInstance():playEffect("Se_Alert_Favor_Up", false)
	else
		animName = "animThree"

		AudioEngine:getInstance():playEffect("Se_Alert_Favor_Up", false)
	end

	return animName
end

function StoryLoveNode:createNumLabel(value)
	local node = cc.Node:create()
	local width = 0

	for i = 1, utf8.len(value) do
		local num = string.sub(tostring(value), i, i)
		local child = ccui.ImageView:create("jq_word_" .. num .. ".png", 1)

		child:setAnchorPoint(cc.p(0.5, 0.5))
		child:setPosition(width, 0)
		node:addChild(child)

		width = width + child:getContentSize().width - 20
	end

	return node
end

function StoryLoveNode:createHeadImg(heroId)
	local headImgName = "guideText_" .. heroId .. ".png"
	local img = ccui.ImageView:create(headImgName, 1)

	img:setScale(0.8)

	headImgName = IconFactory:addStencilForIcon(img, 2, cc.size(100, 100), {
		0,
		-20
	})

	return headImgName
end

MessageNode = class("MessageNode", StageNode)

register_stage_node("MessageNode", MessageNode)

local actions = {
	show = MessageNodeShow,
	hide = MessageNodeHide
}

MessageNode:extendActionsForClass(actions)

function MessageNode:initialize(config)
	super.initialize(self, config)

	self._index = 0
end

function MessageNode:createRenderNode(config)
	return (cc.Node:create())
end

function MessageNode:show(args, onEnd)
	local renderNode = self._renderNode

	renderNode:setVisible(true)
	renderNode:removeAllChildren()

	if args.position then
		local parentNode = renderNode:getParent()
		local parentSize = parentNode and parentNode:getContentSize()
		local position = calcPosition(args.position, parentSize)

		renderNode:setPosition(position)
	end

	local bgImg = ccui.Scale9Sprite:createWithSpriteFrameName("jq_bg_txd_1.png")

	bgImg:setAnchorPoint(0.5, 0.5)
	bgImg:setCapInsets(cc.rect(60, 60, 5, 5))
	bgImg:setContentSize(cc.size(403, 557))
	bgImg:addTo(renderNode, 1)

	if args.modelId and args.modelId ~= "" then
		local roleImg = self:createRoleImg(args)

		roleImg:addTo(renderNode, 2)
	end

	if onEnd then
		onEnd()
	end
end

function MessageNode:hide(args, onEnd)
	local renderNode = self._renderNode

	renderNode:setVisible(false)

	if onEnd then
		onEnd()
	end
end

function MessageNode:createRoleImg(args)
	local modelId = args.modelId

	if not args.modelScale then
		if not args.modelOffset then
			local modelOffset = cc.p(0, 0)
			local img = IconFactory:createRoleIconSpriteNew({
				iconType = 2,
				id = modelId
			})
			local anim = cc.MovieClip:create("tongxun_juqingtexiao")

			anim:addTo(img):center(img:getContentSize()):offset(0 - modelOffset.x, img:getContentSize().height / 4 - modelOffset.y)
			anim:setScale(0.9 / args.modelScale)
			img:setScale(args.modelScale)
			img:setAnchorPoint(cc.p(0.5, 1))

			img = IconFactory:addStencilForIcon(img, 10, nil, {
				0 + modelOffset.x,
				250 + modelOffset.y
			})

			return img
		end
	end
end

StoryNewsNode = class("StoryNewsNode", StageNode)

register_stage_node("StoryNewsNode", StoryNewsNode)

local actions = {
	show = StoryNewsNodeShow,
	hide = StoryNewsNodeHide
}

StoryNewsNode:extendActionsForClass(actions)

function StoryNewsNode:initialize(config)
	super.initialize(self, config)

	self._contents = {}
	self._index = 0
end

function StoryNewsNode:createRenderNode(config)
	local renderNode = cc.CSLoader:createNode("asset/ui/NewsDialog.csb")
	local widget = StoryNewsWidget:new(renderNode)

	widget:setupView()

	widget._mainNode = self
	self._widget = widget

	self._widget:getView():setVisible(false)

	return renderNode
end

function StoryNewsNode:show(args, onEnd)
	self._widget:getView():setVisible(true)
	self._widget:updateView(args, onEnd, self)
end

function StoryNewsNode:hide(args, onEnd)
	self._widget:getView():setVisible(false)

	if onEnd then
		onEnd()
	end
end

function StoryNewsNode:updateAutoPlayState(isAutoPlay)
	if self._widget then
		if isAutoPlay then
			self._widget:startAutoPlay()
		else
			self._widget:stopAutoPlay()
		end
	end
end

AutoPlayButtonNode = class("AutoPlayButtonNode", StageNode)

register_stage_node("AutoPlayButton", AutoPlayButtonNode)

local acitons = {
	hide = AutoPlayButtonNodeHide,
	show = AutoPlayButtonNodeShow
}

AutoPlayButtonNode:extendActionsForClass(acitons)

function AutoPlayButtonNode:initialize(config)
	super.initialize(self, config)
end

function AutoPlayButtonNode:createRenderNode(config)
	local image1 = cc.Sprite:create("asset/common/ck_auto_btn1.png")
	local image2 = cc.Node:create()
	local anim = cc.MovieClip:create("zidongxunhuan_xitonganniu")

	anim:addTo(image2):offset(0, 14)
	anim:setScale(1.1)

	local renderNode = ccui.Layout:create()

	renderNode:setAnchorPoint(cc.p(0.5, 0.5))
	renderNode:setContentSize(image1:getContentSize())
	renderNode:setTouchEnabled(true)
	renderNode:addTouchEventListener(function(sender, eventType)
		if eventType == ccui.TouchEventType.ended then
			self:onClickPlay(sender, eventType)
		end
	end)
	image1:addTo(renderNode):center(renderNode:getContentSize())
	image2:addTo(renderNode):center(renderNode:getContentSize())

	local title1 = cc.Label:createWithTTF(Strings:get("Story_Auto"), TTF_FONT_FZYH_R, 18)

	title1:enableOutline(cc.c4b(0, 0, 0, 204), 2)
	title1:addTo(image1):offset(image1:getContentSize().width * 0.5, image1:getContentSize().height * 0.65)

	local lineGradiantVec1 = {
		{
			ratio = 0.5,
			color = cc.c4b(255, 255, 255, 255)
		},
		{
			ratio = 1,
			color = cc.c4b(225, 231, 252, 255)
		}
	}

	title1:enablePattern(cc.LinearGradientPattern:create(lineGradiantVec1, {
		x = 0,
		y = -1
	}))

	local title2 = cc.Label:createWithTTF(Strings:get("Story_Auto"), TTF_FONT_FZYH_R, 18)

	title2:enableOutline(cc.c4b(0, 0, 0, 204), 2)
	title2:addTo(image2):offset(image2:getContentSize().width * 0.5, image2:getContentSize().height * 0.65 + 13.5)

	local lineGradiantVec1 = {
		{
			ratio = 0.5,
			color = cc.c4b(255, 255, 255, 255)
		},
		{
			ratio = 1,
			color = cc.c4b(225, 231, 252, 255)
		}
	}

	title2:enablePattern(cc.LinearGradientPattern:create(lineGradiantVec1, {
		x = 0,
		y = -1
	}))

	renderNode._image1 = image1
	renderNode._image2 = image2

	image2:setVisible(false)
	renderNode:setVisible(false)

	return renderNode
end

function AutoPlayButtonNode:startAutoPlay()
	local renderNode = self._renderNode

	renderNode._image2:setVisible(true)
end

function AutoPlayButtonNode:stopAutoPlay()
	local renderNode = self._renderNode

	renderNode._image2:setVisible(false)
end

function AutoPlayButtonNode:onClickPlay()
	local agent = self:getAgent()

	AudioEngine:getInstance():playEffect("Se_Click_Story_2", false)
	agent:setAutoPlayState(not agent:isAutoPlayState())
end

function AutoPlayButtonNode:hide()
	self._renderNode:setVisible(false)
end

function AutoPlayButtonNode:show()
	self._renderNode:setVisible(true)

	local agent = self:getAgent()

	self:updateAutoPlayState(agent:isAutoPlayState())
end

function AutoPlayButtonNode:updateAutoPlayState(isAutoPlay)
	if isAutoPlay then
		self:startAutoPlay()
	else
		self:stopAutoPlay()
	end
end

function AutoPlayButtonNode:startHidePlay(notAnim)
	local renderNode = self._renderNode

	if not notAnim then
		local moveTo = cc.MoveBy:create(HideAnimTimeInterval, cc.p(0, 100))
		local fadeOut = cc.FadeOut:create(HideAnimTimeInterval)
		local sequence = cc.Spawn:create(moveTo, fadeOut)

		renderNode:runAction(sequence)
	end
end

function AutoPlayButtonNode:stopHidePlay(notAnim)
	local renderNode = self._renderNode

	if not notAnim then
		local moveTo = cc.MoveBy:create(HideAnimTimeInterval, cc.p(0, -100))
		local fadeIn = cc.FadeIn:create(HideAnimTimeInterval)
		local sequence = cc.Spawn:create(moveTo, fadeIn)

		renderNode:runAction(sequence)
	end
end

function AutoPlayButtonNode:updateHideUIState(isAutoPlay, notAnim)
	if isAutoPlay then
		self:startHidePlay(notAnim)
	else
		self:stopHidePlay(notAnim)
	end
end

HideButtonNode = class("HideButtonNode", StageNode)

register_stage_node("HideButton", HideButtonNode)

local acitons = {
	hide = HideButtonNodeHide,
	show = HideButtonNodeShow
}

HideButtonNode:extendActionsForClass(acitons)

function HideButtonNode:initialize(config)
	super.initialize(self, config)
end

function HideButtonNode:createRenderNode(config)
	local image1 = cc.Sprite:create("asset/common/ck_auto_btn1.png")
	local renderNode = ccui.Layout:create()

	renderNode:setAnchorPoint(cc.p(0.5, 0.5))
	renderNode:setContentSize(image1:getContentSize())
	renderNode:setTouchEnabled(true)
	renderNode:addTouchEventListener(function(sender, eventType)
		if eventType == ccui.TouchEventType.ended then
			self:onClickHide(sender, eventType)
		end
	end)
	image1:addTo(renderNode):center(renderNode:getContentSize())

	local title1 = cc.Label:createWithTTF(Strings:get("Story_Hide"), TTF_FONT_FZYH_R, 18)

	title1:enableOutline(cc.c4b(0, 0, 0, 204), 2)
	title1:addTo(image1):offset(image1:getContentSize().width * 0.5, image1:getContentSize().height * 0.65)

	local lineGradiantVec1 = {
		{
			ratio = 0.5,
			color = cc.c4b(255, 255, 255, 255)
		},
		{
			ratio = 1,
			color = cc.c4b(225, 231, 252, 255)
		}
	}

	title1:enablePattern(cc.LinearGradientPattern:create(lineGradiantVec1, {
		x = 0,
		y = -1
	}))

	local title2 = cc.Label:createWithTTF(Strings:get("Story_Hide"), TTF_FONT_FZYH_R, 18)

	title2:enableOutline(cc.c4b(0, 0, 0, 204), 2)

	local lineGradiantVec1 = {
		{
			ratio = 0.5,
			color = cc.c4b(255, 255, 255, 255)
		},
		{
			ratio = 1,
			color = cc.c4b(225, 231, 252, 255)
		}
	}

	title2:enablePattern(cc.LinearGradientPattern:create(lineGradiantVec1, {
		x = 0,
		y = -1
	}))

	renderNode._image1 = image1

	renderNode:setVisible(false)

	return renderNode
end

function HideButtonNode:startHidePlay(notAnim)
	local renderNode = self._renderNode
	local parent = renderNode:getParent()
	local hideStoryMask = parent:getChildByName("HideStoryMask")

	if not hideStoryMask then
		local renderNode = cc.CSLoader:createNode("asset/ui/HideStoryUIMask.csb")

		renderNode:addTo(parent)
		renderNode:setLocalZOrder(99999)
		renderNode:setName("HideStoryMask")
		renderNode:getChildByName("touch_layer"):addClickEventListener(function()
			self:onClickHide()
		end)
	else
		hideStoryMask:setVisible(true)
	end

	if not notAnim then
		local moveTo = cc.MoveBy:create(HideAnimTimeInterval, cc.p(0, 100))
		local fadeOut = cc.FadeOut:create(HideAnimTimeInterval)
		local sequence = cc.Spawn:create(moveTo, fadeOut)

		renderNode:runAction(sequence)
	end
end

function HideButtonNode:stopHidePlay(notAnim)
	local renderNode = self._renderNode
	local parent = renderNode:getParent()
	local hideStoryMask = parent:getChildByName("HideStoryMask")

	if hideStoryMask then
		hideStoryMask:setVisible(false)
	end

	if not notAnim then
		local moveTo = cc.MoveBy:create(HideAnimTimeInterval, cc.p(0, -100))
		local fadeIn = cc.FadeIn:create(HideAnimTimeInterval)
		local sequence = cc.Spawn:create(moveTo, fadeIn)

		renderNode:runAction(sequence)
	end
end

function HideButtonNode:onClickHide()
	local agent = self:getAgent()

	AudioEngine:getInstance():playEffect("Se_Click_Story_2", false)
	agent:setHideUIState(not agent:isHideUIState())

	if agent:isHideUIState() then
		DmGame:getInstance():dispatch(ShowTipEvent({
			tip = Strings:get("Story_Touch_Show")
		}))
	end
end

function HideButtonNode:hide()
	self._renderNode:setVisible(false)
end

function HideButtonNode:show()
	self._renderNode:setVisible(true)

	local agent = self:getAgent()

	self:updateHideUIState(agent:isHideUIState(), true)
	self:updateAutoPlayState(agent:isAutoPlayState())
end

function HideButtonNode:updateHideUIState(isAutoPlay, notAnim)
	if isAutoPlay then
		self:startHidePlay(notAnim)
	else
		self:stopHidePlay(notAnim)
	end
end

function HideButtonNode:updateAutoPlayState(isAutoPlay)
	self._renderNode:setVisible(not isAutoPlay)
end

ParticleNode = class("ParticleNode", StageNode)

register_stage_node("Particle", ParticleNode)

local acitons = {
	hide = hideParticleNode,
	play = playParticleNode
}

ParticleNode:extendActionsForClass(acitons)

function ParticleNode:initialize(config)
	super.initialize(self, config)
end

function ParticleNode:createRenderNode(config)
	local renderNode = cc.Node:create()
	local particle = cc.ParticleSystemQuad:create(string.format("asset/particle/%s.plist", config.actionName))

	particle:addTo(renderNode):setName("particleNode")
	particle:stopSystem()

	return renderNode
end

function ParticleNode:hide()
	local renderNode = self:getRenderNode()
	local particle = renderNode:getChildByName("particleNode")

	if particle then
		particle:stopSystem()
	end

	renderNode:setVisible(false)
end

function ParticleNode:play(args)
	args = args or {}

	local renderNode = self:getRenderNode()

	local function runfun()
		local particle = renderNode:getChildByName("particleNode")

		if not args.time then
			particle:setDuration(args.time)
			particle:resetSystem()
			renderNode:setVisible(true)
		end
	end

	if not args.delay then
		if args.delay > 0 then
			renderNode:runAction(cc.Sequence:create(cc.DelayTime:create(args.delay), cc.CallFunc:create(runfun)))
		else
			runfun()
		end
	end
end

MazeClueNode = class("MazeClueNode", StageNode)

register_stage_node("MazeClue", MazeClueNode)

function MazeClueNode:initialize(config)
	super.initialize(self, config)

	self.suspectIdList = {}
end

function MazeClueNode:createRenderNode(config)
	return (cc.Node:create())
end

function MazeClueNode:hide()
	self._renderNode:setVisible(false)
end

function MazeClueNode:show(id)
	local renderNode = self._renderNode
	local agent = self:getAgent()
	local director = agent:getDirector()
	local mazeSystem = director:getInjector():getInstance(MazeSystem)
	local infoList = mazeSystem:getClueHeroInfoList(id)

	if #infoList > 0 then
		for i, info in ipairs(infoList) do
			local suspectId = info.suspectId
			local tmpx = 0
			local tmpy = 0
			local clueHead = IconFactory:createStoryMazeClueHead(info)

			clueHead:addTo(renderNode)
			clueHead:setTag(666)
			clueHead:setPosition(cc.p(tmpx, tmpy))
			clueHead:setOpacity(0)
			clueHead:setScale(1.2)
			clueHead:runAction(cc.Sequence:create(cc.DelayTime:create(2 * (i - 1)), cc.Spawn:create(cc.FadeIn:create(0.3), cc.ScaleTo:create(0.3, 0.9)), cc.ScaleTo:create(0.2, 1), cc.DelayTime:create(1.2), cc.Spawn:create(cc.FadeOut:create(0.3), cc.MoveBy:create(0.3, cc.p(0, -20)))))

			if mazeSystem:isNewUnlockClueHero(suspectId) and not self.suspectIdList[suspectId] then
				self:showNewUnlockClueHero(info)

				self.suspectIdList[suspectId] = true
			end
		end
	end

	renderNode:setVisible(true)
end

function MazeClueNode:showNewUnlockClueHero(info)
	local scene = self:getScene()
	local view = scene:getChildById("mazeNewClueTip")

	if view == nil then
		view = StageNodeFactory:createMazeNewClueTip(scene)
	end

	if view then
		view:show(info)
	end
end

MazeNewClueTipNode = class("MazeNewClueTipNode", StageNode)

register_stage_node("MazeNewClueTip", MazeNewClueTipNode)

function MazeNewClueTipNode:initialize(config)
	super.initialize(self, config)
end

function MazeNewClueTipNode:createRenderNode(config)
	local renderNode = cc.CSLoader:createNode("asset/ui/MazeNewClue.csb")
	local touchLayer = renderNode:getChildByName("touch_layer")

	touchLayer:addClickEventListener(function()
		self:hide()
	end)
	renderNode:setVisible(false)

	return renderNode
end

function MazeNewClueTipNode:hide()
	local renderNode = self._renderNode

	renderNode:setVisible(false)
end

function MazeNewClueTipNode:show(info)
	local renderNode = self._renderNode
	local main = renderNode:getChildByName("main")
	local animNode = main:getChildByName("animNode")
	local descNode = main:getChildByName("descNode")

	descNode:setOpacity(0)
	descNode:setScale(1.5)
	animNode:removeAllChildren()

	local anim = cc.MovieClip:create("huodetishi_huodetishi")

	anim:setPlaySpeed(1.5)
	anim:addTo(animNode, 1)
	anim:addCallbackAtFrame(39, function()
		anim:stop()
	end)

	local cnText = anim:getChildByFullName("cnText")
	local enText = anim:getChildByFullName("enText")
	local title1 = cc.Label:createWithTTF(Strings:get("新嫌疑人解锁"), CUSTOM_TTF_FONT_1, 50)

	title1:enableOutline(cc.c4b(0, 0, 0, 255), 1)
	title1:addTo(cnText):offset(0, -3)

	local title2 = cc.Label:createWithTTF(Strings:get("New suspect unlocked"), TTF_FONT_FZYH_M, 18)

	title2:setColor(cc.c3b(150, 160, 255))
	title2:addTo(enText)
	anim:addCallbackAtFrame(10, function()
		local scaleAct = cc.ScaleTo:create(0.2, 1)
		local fadeInAct = cc.FadeIn:create(0.2)
		local action = cc.Spawn:create(scaleAct, fadeInAct)

		descNode:runAction(action)
	end)

	local headNode = descNode:getChildByName("headNode")

	headNode:removeAllChildren()

	local headImgName = IconFactory:createRoleIconSprite({
		clipType = 3,
		id = info.heroId
	})
	local imgHead = IconFactory:addStencilForIcon(headImgName, 2, cc.size(100, 100))

	imgHead:addTo(headNode):center(headNode:getContentSize()):offset(0, 0)

	local nameLabel = descNode:getChildByName("Text_name")
	local heroName = Strings:get(ConfigReader:getDataByNameIdAndKey("PansLabSuspects", info.suspectId, "Name"))

	nameLabel:setString(heroName)
	renderNode:setVisible(true)
end

local function hexToRGB(hex)
	if string.sub(hex, 1, 1) == "#" then
		hex = string.sub(hex, 2)
	end

	local r = tonumber(string.sub(hex, 1, 2), 16)
	local g = tonumber(string.sub(hex, 3, 4), 16)
	local b = tonumber(string.sub(hex, 5, 6), 16)

	return {
		r = r,
		g = g,
		b = b,
		a = a
	}
end

FlashMaskNode = class("FlashMaskNode", StageNode)

register_stage_node("FlashMask", FlashMaskNode)

local acitons = {
	hide = hideFlashMaskNode,
	show = showFlashMaskNode,
	flashScreen = FlashScreen
}

FlashMaskNode:extendActionsForClass(acitons)

function FlashMaskNode:initialize(config)
	super.initialize(self, config)
end

function FlashMaskNode:createRenderNode(config)
	local winSize = cc.Director:getInstance():getVisibleSize()
	local renderNode = cc.Sprite:create("asset/common/bai_rect.png")
	local size = renderNode:getContentSize()

	renderNode:setScale(winSize.width / size.width, winSize.height / size.height)
	renderNode:setPosition(cc.p(winSize.width * 0.5, winSize.height * 0.5))
	renderNode:setVisible(false)
	renderNode:setBlendFunc(cc.blendFunc(gl.SRC_ALPHA, gl.ONE))

	return renderNode
end

function FlashMaskNode:hide()
	self._renderNode:setVisible(false)
end

function FlashMaskNode:show(args)
	local renderNode = self._renderNode

	args = args or {}

	if args.color then
		local color = hexToRGB(args.color)

		if not color.r then
			if not color.g then
				local g = 255

				if not color.b then
					local b = 255

					renderNode:setColor(cc.c3b(color.r, g, b))
				end
			end
		end
	end

	if args.alpha then
		if not args.alpha then
			local a = 255

			renderNode:setOpacity(a)
		end
	end

	renderNode:setVisible(true)
end

function FlashMaskNode:flashScreen(data, endCallback)
	self:show()
	_runFlashScreen(self, data, endCallback)
end

ImageFlashNode = class("ImageFlashNode", StageNode)

register_stage_node("ImageFlash", ImageFlashNode)

local acitons = {
	show = showImageFlashNode,
	hide = hideImageFlashNode,
	flashScreen = FlashScreen
}

ImageFlashNode:extendActionsForClass(acitons)

function ImageFlashNode:initialize(config)
	super.initialize(self, config)
end

function ImageFlashNode:createRenderNode(config)
	local renderNode = cc.Sprite:create("asset/common/bai_rect.png")

	if config.color then
		local color = hexToRGB(config.color)

		if not color.r then
			if not color.g then
				local g = 255

				if not color.b then
					local b = 255

					renderNode:setColor(cc.c3b(color.r, g, b))
				end
			end
		end
	end

	if config.alpha then
		if not config.alpha then
			local a = 255

			renderNode:setOpacity(a)
		end
	end

	renderNode:setBlendFunc(cc.blendFunc(gl.SRC_ALPHA, gl.ONE))

	return renderNode
end

function ImageFlashNode:show()
	local renderNode = self:getRenderNode()

	renderNode:setVisible(true)
end

function ImageFlashNode:hide()
	local renderNode = self:getRenderNode()

	renderNode:setVisible(false)
end

function ImageFlashNode:flashScreen(data, endCallback)
	_runFlashScreen(self, data, endCallback)
end

StoryChooseNode = class("StoryChooseNode", StageNode)

register_stage_node("StoryChoose", StoryChooseNode)

function StoryChooseNode:initialize(config)
	super.initialize(self, config)

	self._contents = {}
	self._index = 0
end

function StoryChooseNode:createRenderNode(config)
	local renderNode = cc.CSLoader:createNode("asset/ui/DiffChooseDialog.csb")

	self._widget = StoryChooseDialogWidget:new(renderNode)

	return renderNode
end

function StoryChooseNode:show(args, onEnd)
	self._widget:getView():setVisible(true)

	if self._widget._renameSetUpView == nil then
		self._widget._renameSetUpView = true

		self._widget:setupView()
	end

	self._widget:updateView(args, onEnd, self:getAgent())
end

function StoryChooseNode:hide(args, onEnd)
	self._widget:getView():setVisible(false)

	if onEnd then
		onEnd()
	end
end
