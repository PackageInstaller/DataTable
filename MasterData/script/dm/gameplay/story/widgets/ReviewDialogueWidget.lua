-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/story/widgets/ReviewDialogueWidget.lua

ReviewDialogueWidget = class("ReviewDialogueWidget", BaseWidget)

function ReviewDialogueWidget:initialize(view)
	super.initialize(self, view)
end

function ReviewDialogueWidget:dispose()
	super.dispose(self)
end

function ReviewDialogueWidget:setupView()
	local touchLayer = self:getView():getChildByName("touch_layer")

	touchLayer:addClickEventListener(function()
		self:onClickTouchLayer()
	end)

	local descListView = self:getView():getChildByFullName("main.ListView")

	descListView:onScroll(function(event)
		self:refreshScrollBar()
	end)
end

function ReviewDialogueWidget:refreshScrollBar()
	local descListView = self:getView():getChildByFullName("main.ListView")

	descListView:setScrollBarEnabled(false)
	descListView:setSwallowTouches(true)
	descListView:setBounceEnabled(true)

	local posY = descListView:getInnerContainerPosition().y
	local bar_bg = self:getView():getChildByFullName("main.bar_bg")
	local bar = bar_bg:getChildByFullName("bar")
	local innerSizeY = descListView:getInnerContainerSize().height
	local sizeY = descListView:getContentSize().height
	local barBgHeight = bar_bg:getContentSize().height

	if innerSizeY <= sizeY then
		bar_bg:setVisible(false)

		return
	end

	bar_bg:setVisible(true)

	if posY <= sizeY - innerSizeY then
		bar:setPositionY(barBgHeight)
	elseif posY >= 0 then
		bar:setPositionY(0)
	else
		posY = 0 - posY

		local p = posY / (innerSizeY - sizeY)
		local y = p * barBgHeight

		bar:setPositionY(y)
	end
end

function ReviewDialogueWidget:getDescTextContent(desc)
	local szFullString = desc
	local szSeparator = "</font>"
	local nFindStartIndex = 1
	local nSplitIndex = 1
	local nSplitArray = {}
	local nSepLen = string.len(szSeparator)

	while true do
		local nFindLastIndex = string.find(szFullString, szSeparator, nFindStartIndex)

		if not nFindLastIndex then
			if nSplitIndex == 1 then
				nSplitArray[nSplitIndex] = szFullString
			end

			break
		end

		nFindLastIndex = nFindLastIndex + nSepLen - 1
		nSplitArray[nSplitIndex] = string.sub(szFullString, nFindStartIndex, nFindLastIndex)
		nFindStartIndex = nFindLastIndex + 1
		nSplitIndex = nSplitIndex + 1
	end
end

function ReviewDialogueWidget:updateView(dialogues)
	dialogues = dialogues or {}

	local descListView = self:getView():getChildByFullName("main.ListView")
	local dialoguePanel = self:getView():getChildByFullName("main.dialoguePanel")
	local choosePanel = self:getView():getChildByFullName("main.choosePanel")
	local line = self:getView():getChildByFullName("main.line")

	descListView:removeAllChildren(true)

	for i, value in pairs(dialogues) do
		local layout = ccui.Layout:create()
		local t = value.t
		local desc = value.content
		local content = self:getDescTextContent(desc)
		local preText

		if t == "C" then
			preText = "<font size='22' color='#FFFFFF'>"
		elseif t == "N" then
			preText = "<font size='22' color='#503214'>"
		elseif t == "P" then
			preText = "<font size='20' color='#8C4614'>"
		elseif t == "D" then
			preText = "<font size='20' color='#503214'>"
		end

		local newDesc = preText .. content .. "</font>"
		local label = ccui.RichText:createWithXML(newDesc, {
			fontName_FONT_1 = CUSTOM_TTF_FONT_1,
			fontName_FONT_2 = CUSTOM_TTF_FONT_2,
			fontName_FZYH_R = TTF_FONT_FZYH_R,
			fontName_FZYH_M = TTF_FONT_FZYH_M
		})

		label:ignoreContentAdaptWithSize(false)
		label:setWrapMode(1)

		if t == "C" then
			local panel = choosePanel:clone()

			panel:addTo(layout)
			label:setAnchorPoint(cc.p(0.5, 0))
			label:renderContent(label:getContentSize().width, 0, true)
			label:setPosition(cc.p(descListView:getContentSize().width / 2 - 50, 15))
			layout:setContentSize(cc.size(descListView:getContentSize().width - 100, label:getContentSize().height + 30))
			panel:setContentSize(cc.size(label:getContentSize().width + 40, label:getContentSize().height + 20))
			panel:setPosition(cc.p(descListView:getContentSize().width / 2 - 50, 5))
		elseif t == "N" or t == "P" then
			label:setFontFace(CUSTOM_TTF_FONT_1)
			label:setAnchorPoint(cc.p(0, 0))
			label:renderContent(descListView:getContentSize().width - 100, 0, true)
			label:setPosition(cc.p(40, 10))
			layout:setContentSize(cc.size(descListView:getContentSize().width, label:getContentSize().height + 20))
		elseif t == "D" then
			local panel = dialoguePanel:clone()

			panel:addTo(layout)
			label:setAnchorPoint(cc.p(0, 0))
			label:renderContent(panel:getContentSize().width - 50, 0, true)
			label:setPosition(cc.p(40, 20))
			layout:setContentSize(cc.size(descListView:getContentSize().width, label:getContentSize().height + 40))
			panel:setContentSize(cc.size(panel:getContentSize().width, label:getContentSize().height + 20))
			panel:setPosition(cc.p(35, 10))
		end

		label:addTo(layout)
		descListView:pushBackCustomItem(layout)

		if t == "P" then
			local dialogN = dialogues[i + 1]

			if dialogN then
				local tN = dialogN.t

				if tN ~= "P" then
					local lineN = line:clone()
					local layoutN = ccui.Layout:create()

					lineN:setPosition(cc.p(130, 10))
					lineN:addTo(layoutN)
					layoutN:setContentSize(cc.size(descListView:getContentSize().width, 20))
					descListView:pushBackCustomItem(layoutN)
				end
			end
		end
	end

	descListView:jumpToBottom()
	self:refreshScrollBar()
end

function ReviewDialogueWidget:onClickTouchLayer()
	self.mainNode:hide()
end
