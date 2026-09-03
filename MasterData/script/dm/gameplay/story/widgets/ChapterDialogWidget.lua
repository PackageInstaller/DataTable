-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/story/widgets/ChapterDialogWidget.lua

ChapterDialogWidget = class("ChapterDialogWidget", BaseWidget)

function ChapterDialogWidget:initialize(view)
	super.initialize(self, view)
end

function ChapterDialogWidget:dispose()
	super.dispose(self)
end

function ChapterDialogWidget:setupView()
	local view = self:getView()
	local touchLayer = view:getChildByName("touch_layer")

	touchLayer:addTouchEventListener(function(sender, eventType)
		if self._anim then
			self._anim:setPlaySpeed(2)
		end
	end)

	local node_anim = view:getChildByFullName("main.Node_anim")

	node_anim:removeAllChildren()

	local plist1 = view:getChildByFullName("main.plist1")

	plist1:setSpeedVar(40)
	plist1:setSpeed(120)

	local plist2 = view:getChildByFullName("main.plist2")

	plist2:setSpeedVar(40)
	plist2:setSpeed(120)

	local plist3 = view:getChildByFullName("main.plist3")

	plist3:setSpeedVar(40)
	plist3:setSpeed(120)

	local anim = cc.MovieClip:create("anim_zhangjiekaiqi")
	local node_title_anim = anim:getChildByFullName("titleNode")

	self._node_title = view:getChildByFullName("main.Node_title")

	self._node_title:changeParent(node_title_anim)
	self._node_title:setPosition(cc.p(0, 0))

	self._node_des = anim:getChildByFullName("desNode")
	self._anim = anim

	anim:stop()
	anim:addTo(node_anim):center(node_anim:getContentSize()):offset(0, 0)
end

function ChapterDialogWidget:updateView(data, onEnd, parentClass)
	self._onEnd = onEnd
	self._parentClass = parentClass

	local view = self:getView()
	local titleSta = data.content[1]

	if titleSta and titleSta ~= "" then
		titleSta = Strings:get(titleSta, {
			fontName_FONT_1 = CUSTOM_TTF_FONT_1,
			fontName_FONT_2 = CUSTOM_TTF_FONT_2,
			fontName_FZYH_R = TTF_FONT_FZYH_R,
			fontName_FZYH_M = TTF_FONT_FZYH_M
		})
	end

	local desStr = data.content[2]

	if desStr then
		if type(desStr) == "string" then
			desStr = Strings:get(desStr, {
				fontName_FONT_1 = CUSTOM_TTF_FONT_1,
				fontName_FONT_2 = CUSTOM_TTF_FONT_2,
				fontName_FZYH_R = TTF_FONT_FZYH_R,
				fontName_FZYH_M = TTF_FONT_FZYH_M
			})
		elseif type(desStr) == "table" then
			for i = 1, #desStr do
				desStr[i] = Strings:get(desStr[i], {
					fontName_FONT_1 = CUSTOM_TTF_FONT_1,
					fontName_FONT_2 = CUSTOM_TTF_FONT_2,
					fontName_FZYH_R = TTF_FONT_FZYH_R,
					fontName_FZYH_M = TTF_FONT_FZYH_M
				})
			end
		end
	end

	data.content[1] = titleSta
	data.content[2] = desStr
	self._titleStr = titleSta
	self._desStr = desStr

	self:addContent()
	self:playChapterAction()

	if self._parentClass and self._parentClass:getAgent() and self._parentClass:getAgent().addDialogue then
		self._parentClass:getAgent():addDialogue(data, "P")
	end
end

function ChapterDialogWidget:addContent()
	local view = self:getView()
	local contentNode_title = self._node_title:getChildByFullName("Node_des")
	local contentNode_des = self._node_des

	contentNode_title:removeAllChildren(true)
	contentNode_des:removeAllChildren(true)

	local contentTitle = self:createRichText(self._titleStr)
	local width = contentTitle:getContentSize().width

	contentTitle:addTo(contentNode_title)
	self._node_title:setPositionX(0 - width / 2 - 13)

	if type(self._desStr) == "string" then
		local contentDes = self:createRichText(self._desStr)

		contentDes:addTo(contentNode_des)

		local width = contentDes:getContentSize().width

		contentDes:setPosition(cc.p(0 - width / 2, 0))
	elseif type(self._desStr) == "table" then
		local node = cc.Node:create()
		local widthAll = 0

		for i = 1, #self._desStr do
			local des = self._desStr[i]
			local contentDes = self:createRichText(des)

			contentDes:addTo(node)

			local width = contentDes:getContentSize().width

			contentDes:setPosition(cc.p(widthAll, 0))

			widthAll = widthAll + width

			if i ~= #self._desStr then
				widthAll = widthAll + 7
			end
		end

		node:addTo(contentNode_des)
		node:setPosition(cc.p(0 - widthAll / 2, 0))
	end
end

function ChapterDialogWidget:playChapterAction()
	self._anim:gotoAndPlay(1)
	self._anim:addCallbackAtFrame(180, function(cid, mc)
		mc:stop()

		if self._onEnd then
			-- block empty
		end
	end)
end

function ChapterDialogWidget:createRichText(desStr)
	local contentDes = ccui.RichText:createWithXML(desStr, {})

	contentDes:setWrapMode(1)
	contentDes:ignoreContentAdaptWithSize(false)
	contentDes:setAnchorPoint(cc.p(0, 0.5))
	contentDes:renderContent(0, 0, true)

	return contentDes
end
