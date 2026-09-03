-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/story/widgets/DialogueChooseShowWidget.lua

DialogueChooseShowWidget = class("DialogueChooseShowWidget", BaseWidget)

function DialogueChooseShowWidget:initialize(view)
	super.initialize(self, view)
end

function DialogueChooseShowWidget:dispose()
	super.dispose(self)
end

function DialogueChooseShowWidget:setupView()
	local node1 = self:getView():getChildByFullName("main.Node_1")
	local button_1 = self:getView():getChildByFullName("main.Node_1.Button_1")
	local img_bg_1 = self:getView():getChildByFullName("main.Node_1.img_bg1")

	self._buttonSize = button_1:getContentSize()
	self._img_bgSize = img_bg_1:getContentSize()

	button_1:addTouchEventListener(function(sender, eventType)
		if eventType == ccui.TouchEventType.began then
			node1:setScale(0.9)
		elseif eventType == ccui.TouchEventType.ended then
			self:onClickDialogue(1)
			node1:setScale(1)
		elseif eventType == ccui.TouchEventType.canceled then
			node1:setScale(1)
		end
	end)

	local node2 = self:getView():getChildByFullName("main.Node_2")
	local button_2 = self:getView():getChildByFullName("main.Node_2.Button_2")

	button_2:addTouchEventListener(function(sender, eventType)
		if eventType == ccui.TouchEventType.began then
			node2:setScale(0.9)
		elseif eventType == ccui.TouchEventType.ended then
			self:onClickDialogue(2)
			node2:setScale(1)
		elseif eventType == ccui.TouchEventType.canceled then
			node2:setScale(1)
		end
	end)

	local node3 = self:getView():getChildByFullName("main.Node_3")
	local button_3 = self:getView():getChildByFullName("main.Node_3.Button_3")

	button_3:addTouchEventListener(function(sender, eventType)
		if eventType == ccui.TouchEventType.began then
			node3:setScale(0.9)
		elseif eventType == ccui.TouchEventType.ended then
			self:onClickDialogue(3)
			node3:setScale(1)
		elseif eventType == ccui.TouchEventType.canceled then
			node3:setScale(1)
		end
	end)

	self.node_1 = self:getView():getChildByFullName("main.Node_1")
	self.node_2 = self:getView():getChildByFullName("main.Node_2")
	self.node_3 = self:getView():getChildByFullName("main.Node_3")
	self.nodePos_1 = self.node_1:getPositionY()
	self.nodePos_2 = self.node_2:getPositionY()
	self.nodePos_3 = self.node_3:getPositionY()

	local touchLayer = self:getView():getChildByFullName("touch_layer")

	touchLayer:addTouchEventListener(function(sender, eventType)
		if button_1:isEnabled() and self._contentA and #self._contentA == 1 then
			if eventType == ccui.TouchEventType.began then
				node1:setScale(0.9)
			elseif eventType == ccui.TouchEventType.ended then
				self:onClickDialogue(1)
				node1:setScale(1)
			elseif eventType == ccui.TouchEventType.canceled then
				node1:setScale(1)
			end
		end
	end)
end

function DialogueChooseShowWidget:updateView(data, onEnd, parentClass)
	self._onEnd = onEnd

	local view = self:getView()

	if not data.content then
		local contentA = {}

		self._contentA = contentA
		self.actionName = data.actionName
		self.storyAgent = data.agent
		self.date = data.date
		self.storyLove = data.storyLove or {}
		self.mazeClue = data.mazeClue or {}
		self._parentClass = parentClass

		self.node_1:setPositionY(self.nodePos_1)
		self.node_2:setPositionY(self.nodePos_2)
		self.node_3:setPositionY(self.nodePos_3)

		local numAll = 0
		local maxWidth = 0

		for i = 1, 3 do
			local nameStr = "main.Node_" .. tostring(i)
			local button = view:getChildByFullName(nameStr .. ".Button_" .. tostring(i))
			local content_rect = view:getChildByFullName(nameStr .. ".content_rect" .. tostring(i))
			local bg = view:getChildByFullName(nameStr .. ".img_bg" .. tostring(i))
			local node_i = view:getChildByFullName(nameStr)
			local text = contentA[i]

			bg:stopAllActions()
			content_rect:stopAllActions()
			button:setEnabled(true)
			content_rect:setScale(1)
			content_rect:setOpacity(255)
			bg:setScale(1)
			bg:setOpacity(255)
			node_i:setScale(1)
			node_i:setOpacity(255)
			content_rect:removeAllChildren(true)

			if text then
				local playerName = ""

				if self._parentClass and self._parentClass:getAgent() then
					if self._parentClass:getAgent():getDirector() then
						local direc = self._parentClass:getAgent():getDirector()
						local developSystem = direc:getInjector():getInstance(DevelopSystem)

						playerName = developSystem:getNickName()
					end
				end

				local content = Strings:get(text, {
					fontName_FONT_1 = CUSTOM_TTF_FONT_1,
					fontName_FONT_2 = CUSTOM_TTF_FONT_2,
					fontName_FZYH_R = TTF_FONT_FZYH_R,
					fontName_FZYH_M = TTF_FONT_FZYH_M,
					playername = playerName
				})

				button:setVisible(true)
				content_rect:setVisible(true)
				bg:setVisible(true)

				self._contentA[i] = content

				local contentText = ccui.RichText:createWithXML(content, {})

				contentText:setWrapMode(1)
				contentText:ignoreContentAdaptWithSize(false)
				contentText:setAnchorPoint(cc.p(0.5, 0.5))
				contentText:addTo(content_rect)
				contentText:setPosition(cc.p(0, 0))
				contentText:renderContent(0, 0, true)

				local width = contentText:getContentSize().width

				width = width > display.width - 170 and display.width - 170 or width

				contentText:renderContent(width, 0, true)

				if maxWidth < width then
					maxWidth = width
				end

				numAll = numAll + 1
			else
				button:setVisible(false)
				content_rect:setVisible(false)
				bg:setVisible(false)
			end
		end

		self._numAll = numAll

		if numAll == 1 then
			self.node_1:setPositionY(self.nodePos_2)
		elseif numAll == 2 then
			local y = self.nodePos_1 - self.nodePos_2

			self.node_1:setPositionY(self.nodePos_1 - y / 2)
			self.node_2:setPositionY(self.nodePos_2 - y / 2)
		end

		local buttonSize = cc.size(self._buttonSize.width, self._buttonSize.height)
		local img_bgSize = cc.size(self._img_bgSize.width, self._img_bgSize.height)
		local addSize = maxWidth - self._buttonSize.width + 100

		if addSize > 0 then
			buttonSize.width = buttonSize.width + addSize
			img_bgSize.width = img_bgSize.width + addSize
		end

		for i = 1, 3 do
			local baseNode = view:getChildByFullName("main.Node_" .. i)
			local button = baseNode:getChildByFullName("Button_" .. i)
			local img_bg = baseNode:getChildByFullName("img_bg" .. i)

			button:setContentSize(buttonSize)
			img_bg:setContentSize(img_bgSize)
			img_bg:removeChildByTag(666)

			local clueId = self.mazeClue[i]

			if clueId and clueId ~= "" then
				local mazeSystem = self.storyAgent:getInjector():getInstance(MazeSystem)
				local isHave = mazeSystem:haveClue(clueId)

				if isHave then
					local infoList = mazeSystem:getClueHeroInfoList(clueId)

					if #infoList > 0 then
						local tmpx = img_bgSize.width + 30
						local tmpy = img_bgSize.height * 0.6

						for i, info in ipairs(infoList) do
							local clueHead = IconFactory:createMazeClueHead(info)

							clueHead:addTo(img_bg)
							clueHead:setTag(666)
							clueHead:setPosition(cc.p(tmpx + (i - 1) * 110, tmpy))
						end

						local tmpw = 120 + (#infoList - 1) * 120

						button:setContentSize(cc.size(buttonSize.width + tmpw, buttonSize.height))
						img_bg:setContentSize(cc.size(img_bgSize.width + tmpw, img_bgSize.height))
					end
				end
			end
		end

		if GameConfigs.autoStory then
			self:onClickDialogue(1)
		end
	end
end

function DialogueChooseShowWidget:onClickDialogue(_idx)
	local idx = _idx or 1

	AudioEngine:getInstance():playEffect("Se_Click_Story_1", false)

	local view = self:getView()
	local button_1 = view:getChildByFullName("main.Node_1.Button_1")
	local button_2 = view:getChildByFullName("main.Node_2.Button_2")
	local button_3 = view:getChildByFullName("main.Node_3.Button_3")
	local node = view:getChildByFullName("main.Node_" .. idx)
	local content_rect = node:getChildByName("content_rect" .. idx)
	local bg = node:getChildByName("img_bg" .. idx)

	button_1:setEnabled(false)
	button_2:setEnabled(false)
	button_3:setEnabled(false)

	local sequence = cc.Sequence:create(cc.FadeOut:create(0.4), cc.CallFunc:create(function()
		self:clickToSelect(idx)
	end))

	content_rect:runAction(sequence)
	bg:runAction(cc.FadeOut:create(0.4))
end

function DialogueChooseShowWidget:clickToSelect(index)
	if self.storyAgent ~= nil and self.actionName ~= nil and self.actionName[index] ~= nil then
		local storyName = self.actionName[index]
		local storyAgent = self.storyAgent

		storyAgent:addEnterFollowAction(storyName)
	end

	if self.date then
		local gallerySystem = self.storyAgent:getInjector():getInstance("GallerySystem")
		local dateOptions = gallerySystem:getDateOptions()

		dateOptions[#dateOptions + 1] = index

		gallerySystem:setDateOptions(dateOptions)
	end

	if self.storyAgent then
		if self.storyLove and self.storyLove[index] then
			self.storyAgent:sendAddStoryLove(self.storyLove[index])
		end

		if self.mazeClue and self.mazeClue[index] then
			self.storyAgent:pushMazeClue(self.mazeClue[index])
		end
	end

	self.storyAgent:addStoryStatisticStep(110 + index)
	self:getView():setVisible(false)

	if self._onEnd then
		-- block empty
	end
end
