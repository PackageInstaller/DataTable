-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/story/widgets/NormalDialogueWidget.lua

NormalDialogueWidget = class("NormalDialogueWidget", BaseWidget)

local kDialogState = {
	kLeft = 1,
	kRight = 2
}

function NormalDialogueWidget:initialize(view)
	super.initialize(self, view)

	local winSize = cc.Director:getInstance():getVisibleSize()

	view:setContentSize(winSize)
end

function NormalDialogueWidget:dispose()
	super.dispose(self)
end

function NormalDialogueWidget:setupView(data)
	local view = self:getView()
	local topBg = view:getChildByFullName("bg.bg_top")
	local bottomBg = view:getChildByFullName("bg.bg_bottom")
	local dialogLeft = view:getChildByFullName("bg.dialog_left")
	local dialogRight = view:getChildByFullName("bg.dialog_right")

	topBg:loadTexture("asset/story/pic_top_bg.png")
	bottomBg:loadTexture("asset/story/pic_top_bg.png")
	dialogLeft:loadTexture("asset/story/pic_dialog_bg2.png")
	dialogRight:loadTexture("asset/story/pic_dialog_bg.png")

	local touchLayer = view:getChildByFullName("touch_layer")

	touchLayer:setTouchEnabled(true)
	touchLayer:addTouchEventListener(function(sender, eventType)
		self:onClickNext(sender, eventType)
	end)
end

function NormalDialogueWidget:updateView(data, onEnd)
	local view = self:getView()

	self._onEnd = onEnd
	self._data = data

	local role1Info = data.role1
	local role2Info = data.role2

	self._leftDialog = view:getChildByFullName("bg.dialog_left")
	self._leftContentRect = self._leftDialog:getChildByName("content_rect")

	if role1Info then
		if role1Info.name then
			local name = self._leftDialog:getChildByName("name")

			name:setString(role1Info.name)
		end

		if role1Info.modelId then
			local role1 = view:getChildByFullName("bg.role_1")

			self._leftRoleAnim = RoleFactory:createRolePortraitAnim(role1Info.modelId, nil, {
				mask = true
			})

			self._leftRoleAnim:setAnchorPoint(cc.p(0.5, 0))
			self._leftRoleAnim:addTo(role1)
		end

		self._indexLeft = 0
		self._contentLeft = {}

		if type(role2Info.content) == "string" then
			self._contentLeft[1] = role2Info.content
		else
			self._contentLeft = role2Info.content
		end
	end

	self._rightDialog = view:getChildByFullName("bg.dialog_right")
	self._rightContentRect = self._rightDialog:getChildByName("content_rect")

	if role2Info then
		if role2Info.name then
			local name = self._rightDialog:getChildByName("name")

			name:setString(role2Info.name)
		end

		if role2Info.modelId then
			local role2 = view:getChildByFullName("bg.role_2")

			self._rightRoleAnim = RoleFactory:createRolePortraitAnim(role2Info.modelId, nil, {
				mask = true
			})

			self._rightRoleAnim:setAnchorPoint(cc.p(0.5, 0))
			self._rightRoleAnim:addTo(role2)
		end

		self._indexRight = 0
		self._contentRight = {}

		if type(role2Info.content) == "string" then
			self._contentRight[1] = role2Info.content
		else
			self._contentRight = role2Info.content
		end
	end

	self._dialoagState = kDialogState.kLeft

	self._leftDialog:setVisible(true)
	self._rightDialog:setVisible(false)
	self._rightRoleAnim:setVisible(false)
	self:setAnimMaskVisible(self._leftRoleAnim, false)

	self._contentRect = self._leftContentRect
	self._contents = self._contentLeft

	self:next()
end

local kTypeOutInterval = 0.03
local kTypeWirterActionTag = 65536

function NormalDialogueWidget:next()
	local index

	if self._dialoagState == kDialogState.kLeft then
		self._indexLeft = self._indexLeft + 1
		index = self._indexLeft
	elseif self._dialoagState == kDialogState.kRight then
		self._indexRight = self._indexRight + 1
		index = self._indexRight
	end

	local content = self._contents[index]
	local contentRect = self._contentRect
	local contentText

	contentRect:removeAllChildren(true)

	if contentText == nil then
		local contentTextParent = contentRect:getParent()

		contentText = ccui.RichText:createWithXML(content, {
			fontName_FONT_1 = TTF_FONT_STORY,
			fontName_FONT_2 = TTF_FONT_STORY,
			fontName_FZYH_R = TTF_FONT_STORY,
			fontName_FZYH_M = TTF_FONT_STORY
		})

		contentText:setWrapMode(1)
		contentText:ignoreContentAdaptWithSize(false)
		contentText:setAnchorPoint(contentRect:getAnchorPoint())
		contentText:addTo(contentTextParent):posite(contentRect:getPosition()):setName("content_text")

		function contentText.playTypeWriter(contentText)
			contentText:stopActionByTag(kTypeWirterActionTag)
			contentText:clipContent(0, 0)

			local contentLen = contentText:getContentLength()
			local action = TypeWriterAction:new(kTypeOutInterval, contentLen)

			action:setTag(kTypeWirterActionTag)
			contentText:runAction(action)
		end

		function contentText.finishTypeWriter(contentText)
			contentText:stopActionByTag(kTypeWirterActionTag)
			contentText:clipContent()
			contentText:renderContent()
		end

		function contentText.isTypeWriting(contentText)
			local action = contentText:getActionByTag(kTypeWirterActionTag)

			return action ~= nil
		end

		self._contentText = contentText
	end

	local contentLineNum = contentText:getLineCount()

	contentText:renderContent(contentRect:getContentSize().width, 0, true)

	local contentLineNum = contentText:getLineCount()

	if contentLineNum == 1 then
		contentText:setAnchorPoint(cc.p(0, 0))
	else
		contentText:setAnchorPoint(cc.p(0, 0.5))
	end

	contentText:posite(contentRect:getPosition())
	contentText:playTypeWriter()
end

function NormalDialogueWidget:setAnimMaskVisible(anim, isVisible)
	if anim then
		anim:setVisible(true)

		local mask = anim:getChildByFullName("anim.mask_node")

		mask:setVisible(isVisible)
	end
end

function NormalDialogueWidget:refreshDialogState()
	local index

	if self._dialoagState == kDialogState.kLeft then
		self._dialoagState = kDialogState.kRight

		self._leftDialog:setVisible(false)
		self._rightDialog:setVisible(true)

		self._contentRect = self._rightContentRect
		self._contents = self._contentRight
		index = self._indexRight

		self:setAnimMaskVisible(self._leftRoleAnim, true)
		self:setAnimMaskVisible(self._rightRoleAnim, false)
	elseif self._dialoagState == kDialogState.kRight then
		self._dialoagState = kDialogState.kLeft

		self._leftDialog:setVisible(true)
		self._rightDialog:setVisible(false)

		self._contentRect = self._leftContentRect
		self._contents = self._contentLeft
		index = self._indexLeft

		self:setAnimMaskVisible(self._leftRoleAnim, false)
		self:setAnimMaskVisible(self._rightRoleAnim, true)
	end

	if index >= #self._contents then
		return false
	end

	return true
end

function NormalDialogueWidget:onClickNext(sender, eventType)
	if self._contentText == nil then
		return
	end

	if eventType == ccui.TouchEventType.ended then
		if self._contentText:isTypeWriting() then
			self._contentText:finishTypeWriter()
		else
			local isNotFinished = self:refreshDialogState()

			if isNotFinished then
				self:next()
			elseif self._onEnd then
				local onEnd = self._onEnd

				self._onEnd = nil

				onEnd()
			end
		end
	end
end
