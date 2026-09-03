-- chunkname: @/tmp/or_script/lua_compile/foundation/ccext/CCUIExtends.lua

if not _G.ccui then
	local ccui = {}

	ccui.ClippingType = {
		SCISSOR = 1,
		STENCIL = 0
	}
	FontStyleColor = {
		kWhite = cc.c3b(255, 255, 255),
		kRed = cc.c3b(254, 251, 228),
		kYellow = cc.c3b(253, 202, 91),
		kBlack = cc.c3b(0, 0, 0)
	}

	local MULTIP_LANGUAGE_PRE = "lang_"

	local function setTextAdditionalKerning(textWidget, value)
		local language = getCurrentLanguage()

		if language ~= GameLanguageType.CN then
			return
		end

		if textWidget.getVirtualRenderer ~= nil then
			local label = textWidget:getVirtualRenderer()

			if label and label.setAdditionalKerning ~= nil then
				label:setAdditionalKerning(value)
			end
		end
	end

	local function setTextLineSpace(textWidget, value)
		if textWidget.getVirtualRenderer ~= nil then
			local label = textWidget:getVirtualRenderer()

			if label and label.setLineSpacing ~= nil then
				label:setLineSpacing(value)
			end
		end
	end

	function replaceTextFieldToEditBox(textWidget, notAdjustEditBox)
		if not textWidget then
			return nil
		end

		local widgetType = textWidget:getDescription()

		if widgetType ~= "TextField" then
			return textWidget
		end

		local textFieldSize = textWidget:getContentSize()
		local editBox = ccui.EditBox:create(textFieldSize, " ")
		local parent = textWidget:getParent()

		if not parent then
			dump("error: EditBox parent is nil")

			return textWidget
		end

		parent:addChild(editBox)
		editBox:setText(textWidget:getString())

		local anchorPt = textWidget:getAnchorPoint()

		editBox:setAnchorPoint(anchorPt)

		local x, y = textWidget:getPosition()

		editBox:setPosition(cc.p(x, y))
		editBox:setLocalZOrder(textWidget:getLocalZOrder())
		editBox:setVisible(textWidget:isVisible())
		editBox:setFontSize(textWidget:getFontSize())
		editBox:setFontName(textWidget:getFontName())
		editBox:setFontColor(textWidget:getColor())
		editBox:setPlaceHolder(textWidget:getPlaceHolder())
		editBox:setPlaceholderFont(textWidget:getFontName(), textWidget:getFontSize())
		editBox:setPlaceholderFontColor(textWidget:getPlaceHolderColor())
		editBox:setScaleX(textWidget:getScaleX())
		editBox:setScaleY(textWidget:getScaleY())
		editBox:setTag(textWidget:getTag())
		editBox:setName(textWidget:getName())

		if textWidget:isMaxLengthEnabled() then
			editBox._maxLengthEnabled = textWidget:isMaxLengthEnabled()
			editBox._maxLength = textWidget:getMaxLength()
		end

		local function adjustEditBox(editBox)
			local size = editBox:getContentSize()
			local editContent = editBox:getContentLabel()

			editContent:setAnchorPoint(cc.p(0.5, 0.5))

			local placeHolderContent = editBox:getPlaceholderLabel()

			placeHolderContent:setAnchorPoint(cc.p(0.5, 0.5))

			if textWidget:isIgnoreContentAdaptWithSize() == false then
				editContent:setDimensions(size.width, size.height)
				placeHolderContent:setDimensions(size.width, size.height)
				editContent:setPosition(cc.p(size.width / 2, size.height / 2))
				placeHolderContent:setPosition(cc.p(size.width / 2, size.height / 2))
			end
		end

		function editBox:getMaxLength()
			return self._maxLength
		end

		function editBox:onEvent(callback)
			self._callback = callback
		end

		function editBox:getkeyboardState()
			return self._keyboardState
		end

		if not notAdjustEditBox then
			adjustEditBox(editBox)
		end

		editBox:unregisterScriptEditBoxHandler()
		editBox:registerScriptEditBoxHandler(function(eventName, sender)
			if eventName == "began" then
				local contentLabel = editBox:getContentLabel()

				if contentLabel:getString() ~= editBox:getText() then
					editBox:setText(contentLabel:getString())
				end

				if contentLabel then
					contentLabel:setVisible(false)
				end

				local placeHolderContent = editBox:getPlaceholderLabel()

				if placeHolderContent then
					placeHolderContent:setVisible(false)
				end

				editBox._keyboardState = true
			elseif eventName == "ended" then
				local content = editBox:getText()
				local toContent = string.gsub(content, "\n", " ")

				toContent = string.gsub(toContent, "\r\n", " ")

				if toContent ~= content then
					editBox:setText(toContent)
				end

				local result, finalString = StringChecker.hasForbiddenWords(editBox:getText())

				if result then
					editBox:setText(finalString)

					if editBox._callback then
						editBox._callback("ForbiddenWord", sender)
					end
				end

				if editBox._maxLengthEnabled and utf8.len(editBox:getText()) > editBox._maxLength then
					editBox:setText(utf8.sub(editBox:getText(), 1, editBox._maxLength))

					if editBox._callback then
						editBox._callback("Exceed", sender)
					end
				end

				local contentLabel = editBox:getContentLabel()

				if contentLabel then
					contentLabel:setVisible(true)
				end

				local placeHolderContent = editBox:getPlaceholderLabel()

				if placeHolderContent and placeHolderContent:getString() == "" then
					placeHolderContent:setVisible(true)
				end

				editBox._keyboardState = false
			elseif eventName == "return" then
				-- block empty
			elseif eventName == "changed" and editBox and editBox._maxLengthEnabled and editBox._keyboardState then
				if utf8.len(editBox:getText()) > editBox._maxLength then
					local text = utf8.sub(editBox:getText(), 1, editBox._maxLength)

					if text ~= editBox:getText() then
						editBox:setText(utf8.sub(editBox:getText(), 1, editBox._maxLength))

						if editBox._callback then
							editBox._callback("Exceed", sender)
						end
					end
				end

				local contentLabel = editBox:getContentLabel()

				if contentLabel then
					contentLabel:setVisible(not editBox._keyboardState)
				end
			end

			if editBox._callback then
				editBox._callback(eventName, sender)
			end
		end)

		editBox._keyboardState = false

		parent:removeChild(textWidget)

		return editBox
	end

	ccui.Text.setAdditionalKerning = setTextAdditionalKerning
	ccui.Text.setLineSpacing = setTextLineSpace
	ccui.TextField.setAdditionalKerning = setTextAdditionalKerning
	ccui.TextField.setLineSpacing = setTextLineSpace

	function ccui.TextField.enableUserCursor(textWidget, cursorFilePath)
		if not cursorFilePath then
			return
		end

		if textWidget then
			local cursor = cc.Sprite:create(cursorFilePath)

			if cursor then
				local render = tolua.cast(textWidget:getVirtualRenderer(), "cc.Label")

				if render then
					local contentSize = cursor:getContentSize()

					if contentSize.height ~= 0 then
						local scaleFactor = render:getLineHeight() / contentSize.height

						cursor:setScaleY(scaleFactor)
					end
				end

				textWidget:removeUserCursor()
				cursor:setAnchorPoint(cc.p(0, 0))
				textWidget:setUserCursor(cursor)
				cursor:runAction(cc.RepeatForever:create(FadeInOutAction:create(0.5)))
			end
		end
	end

	function ccui.TextField.disableUserCursor(textWidget)
		textWidget:removeUserCursor()
	end

	function ccui.RichText:renderContent(width, height, forceRebuild)
		if width ~= nil or height ~= nil then
			if width == nil then
				width = self:getContentSize().width
			end

			if height == nil then
				height = self:getContentSize().height
			end

			if width <= 0 and height <= 0 then
				self:ignoreContentAdaptWithSize(true)
			else
				self:ignoreContentAdaptWithSize(false)
				self:setContentSize(cc.size(width, height))
			end
		end

		self:rebuildElements(forceRebuild)
		self:formatText()
	end

	local function modifyRichTextFont(text)
		local fontTab = {
			CUSTOM_TTF_FONT_1,
			CUSTOM_TTF_FONT_2,
			TTF_FONT_FZYH_R,
			TTF_FONT_FZYH_M,
			TTF_FONT_STORY
		}
		local localLanguage = getCurrentLanguage()
		local ontName = text

		if ontName and localLanguage ~= GameLanguageType.CN then
			local font = localLanguage ~= GameLanguageType.TH and TTF_FONT_GENERAL or TTF_FONT_TH

			for k, v in pairs(fontTab) do
				if string.find(ontName, v) then
					ontName = string.gsub(ontName, v, font)
				end
			end
		end

		return ontName
	end

	local ccuiRichTextcreateWithXMLFunc = ccui.RichText.createWithXML

	function ccui.RichText:createWithXML(text, param, ...)
		local ontName = modifyRichTextFont(text)

		return ccuiRichTextcreateWithXMLFunc(self, ontName, param, ...)
	end

	local ccuiRichTextSetFontFaceFunc = ccui.RichText.setFontFace

	function ccui.RichText:setFontFace(ontName)
		local localLanguage = getCurrentLanguage()

		if ontName and localLanguage ~= GameLanguageType.CN then
			local font

			ontName = localLanguage ~= GameLanguageType.TH and TTF_FONT_GENERAL or TTF_FONT_TH
		end

		return ccuiRichTextSetFontFaceFunc(self, ontName)
	end

	local ccuiRichTextSetStringFunc = ccui.RichText.setString

	function ccui.RichText:setString(text)
		local ontName = modifyRichTextFont(text)

		ccuiRichTextSetStringFunc(self, ontName)
	end

	function ajustRichTextCustomWidth(richText, maxWidth, forceRebuild)
		if forceRebuild == nil then
			forceRebuild = false
		end

		richText:rebuildElements(forceRebuild)
		richText:formatText()

		local _richW = richText:getContentSize().width

		if maxWidth < _richW and _richW ~= 0 then
			richText:setScale(maxWidth / _richW)
		end
	end

	function setTextShadowOpacity(text, opacity)
		opacity = opacity or 1

		if text:isShadowEnabled() then
			local shadowColor = text:getShadowColor()

			shadowColor.a = shadowColor.a * opacity

			text:enableShadow(shadowColor, text:getShadowOffset(), text:getShadowBlurRadius())
		end
	end

	function setTextOutlineOpacity(text, opacity)
		opacity = opacity or 1

		local outlineSize = text:getOutlineSize()

		if outlineSize > 0 then
			local effectColor = text:getEffectColor()

			effectColor.a = effectColor.a * opacity

			text:enableOutline(effectColor, text:getOutlineSize())
		end
	end

	function ccui.Text:getAutoRenderWidth()
		local _autoRenderSize = self:getAutoRenderSize()
		local _contentSize = self:getContentSize()

		if _autoRenderSize.width > _contentSize.width then
			return _contentSize.width
		end

		return _autoRenderSize.width
	end

	ccui.Text.setShadowOpacity = setTextShadowOpacity
	cc.Label.setShadowOpacity = setTextShadowOpacity
	ccui.Text.setOutlineOpacity = setTextOutlineOpacity
	cc.Label.setOutlineOpacity = setTextOutlineOpacity

	local function adjustTextCustomSize(text)
		if text:isIgnoreContentAdaptWithSize() or text:getString() == "" then
			return
		end

		local virtualRenderer = text:getVirtualRenderer()

		virtualRenderer:setOverflow(cc.LabelOverflow.NONE)
		virtualRenderer:setOverflow(cc.LabelOverflow.SHRINK)

		local language = getCurrentLanguage()

		if language ~= GameLanguageType.CN then
			virtualRenderer:setLineSpacing(-3)
		end
	end

	local ccuiTextCreateFunc = ccui.Text.create

	function ccui.Text:create(text, fontName, fontSize, ...)
		local localLanguage = getCurrentLanguage()

		if fontName and localLanguage ~= GameLanguageType.CN then
			local font

			fontName = localLanguage ~= GameLanguageType.TH and TTF_FONT_GENERAL or TTF_FONT_TH
		end

		return ccuiTextCreateFunc(self, text, fontName, fontSize, ...)
	end

	local ccuiTextSetStringFunc = ccui.Text.setString

	function ccui.Text:setString(...)
		ccuiTextSetStringFunc(self, ...)
		adjustTextCustomSize(self)
	end

	local ccLabelCreateWithTTFFunc = cc.Label.createWithTTF

	function cc.Label:createWithTTF(text, fontName, fontSize, ...)
		local localLanguage = getCurrentLanguage()

		return ccLabelCreateWithTTFFunc(self, text, (fontName ~= nil and fontName ~= "" or nil) and ORGetFont(localLanguage, fontName), fontSize, ...)
	end

	local function modifyAssetLanguagePath(imgPath)
		local isModify = false
		local modify_path = imgPath
		local sIdx, eIdx = string.find(imgPath, "asset/")

		if sIdx ~= nil and eIdx ~= nil then
			if not cc.FileUtils:getInstance():isFileExist(imgPath) then
				local dir = string.split(imgPath, "/")

				modify_path = string.gsub(modify_path, dir[2], MULTIP_LANGUAGE_PRE .. dir[2], 1)
				isModify = true
			end
		end

		return modify_path, isModify
	end

	function identifyLanguageFile(...)
		local args = {
			...
		}
		local filename = args[1]

		if not filename then
			return unpack(args)
		end

		local localLanguage = getCurrentLanguageForRes()

		if filename ~= nil then
			local var_26_0, var_26_1 = modifyAssetLanguagePath(filename)

			filename = var_26_0

			if var_26_1 then
				args[1] = filename
			end
		end

		local st, ed = string.find(filename, MULTIP_LANGUAGE_PRE)

		if st and localLanguage ~= "" then
			local eidx = string.find(filename, "/", ed)

			eidx = eidx or 0

			local dirName = string.sub(filename, st, eidx - 1)

			filename = string.gsub(filename, dirName, dirName .. "_" .. localLanguage)
			args[1] = filename
		end

		return unpack(args)
	end

	local ccSpriteCreateFunc = cc.Sprite.create

	function cc.Sprite:create(...)
		return ccSpriteCreateFunc(self, identifyLanguageFile(...))
	end

	local ccuiImageViewCreateFunc = ccui.ImageView.create

	function ccui.ImageView:create(...)
		return ccuiImageViewCreateFunc(self, identifyLanguageFile(...))
	end

	local ccuiImageViewLoadTexture = ccui.ImageView.loadTexture

	function ccui.ImageView:loadTexture(...)
		ccuiImageViewLoadTexture(self, identifyLanguageFile(...))
	end

	local function _checkCustomProperty(ui, styleData)
		if tolua.type(ui) == "ccui.Text" or tolua.type(ui) == "ccui.TextField" then
			local localLanguage = getCurrentLanguage()
			local fontName = ui:getFontName()

			if fontName ~= nil and fontName ~= "" then
				local map2Font = ORGetFont(localLanguage, fontName)

				ui:setFontName(map2Font)
			end

			if tolua.type(ui) == "ccui.Text" then
				adjustTextCustomSize(ui)
			end
		end
	end

	local function getCustomPropertyByRootNode(root)
		local childs = root:getChildren()

		for i = 1, #childs do
			local subNode = childs[i]
			local component = subNode:getComponent("ComExtensionData")
			local styleData = component:getCustomProperty()

			_checkCustomProperty(subNode, styleData)
			getCustomPropertyByRootNode(subNode)
		end

		return root
	end

	local ccCSLoaderCreateNode = cc.CSLoader.createNode

	function cc.CSLoader:createNode(...)
		local root = ccCSLoaderCreateNode(self, ...)

		return getCustomPropertyByRootNode(root)
	end

	function addImageAsync(imagePath, func)
		local fileUtils = cc.FileUtils:getInstance()
		local alphaPath = imagePath .. "@alpha"
		local isFilePathExist_Alpha = fileUtils.isFilePathExist and fileUtils:isFilePathExist(alphaPath) or false
		local etc1AlphaPath = imagePath .. "@etc1-alpha"
		local isFilePathExist_etc1Alpha = fileUtils.isFilePathExist and fileUtils:isFilePathExist(etc1AlphaPath) or false

		if not fileUtils:isFileExist(imagePath) then
			if func then
				func()
			end
		elseif isFilePathExist_Alpha and not fileUtils:isFileExist(alphaPath) then
			if func then
				func()
			end
		elseif isFilePathExist_etc1Alpha and not fileUtils:isFileExist(etc1AlphaPath) then
			if func then
				func()
			end
		else
			local textureCache = cc.Director:getInstance():getTextureCache()

			textureCache:addImageAsync(imagePath, function(texture)
				if func then
					func(texture)
				end
			end)
		end
	end

	function _setFontCustomPropertyByConfig(text, config)
		if not config then
			return
		end

		text:disableEffect(1)

		if config.fontName then
			local oldFontName = text:getFontName()

			if config.fontName then
				text:setFontName(config.fontName)
			end
		end

		if config.color then
			text:setTextColor(config.color)
		end

		if config.gradientColor then
			local lineGradiantVec = {
				config.gradientColor.color1,
				config.gradientColor.color2
			}

			text:enablePattern(cc.LinearGradientPattern:create(lineGradiantVec, config.gradientColor.factor))
		end

		if config.shadowColor then
			text:enableShadow(config.shadowColor.color, config.shadowColor.offset, config.shadowColor.factor)
		end

		if config.outline then
			text:enableOutline(config.outline.outline, config.outline.size)
		end

		if config.skewX then
			text:setSkewX(config.skewX)
		end

		if config.opacity then
			text:setOpacity(config.opacity)
		end

		if config.glowColor then
			text:enableGlow(config.glowColor.color)
		end
	end

	function setTextWithFontStyle(text, styleData)
		dump(styleData, "styleData_____styleData")

		FontStyleType = {
			FontZWMBText = {
				color = cc.c3b(255, 255, 255),
				outline = {
					size = 1,
					outline = cc.c4b(0, 0, 0, 255)
				}
			},
			FontTipsText = {
				color = FontStyleColor.kWhite
			},
			FontTipsTextHei = {
				color = FontStyleColor.kBlack
			},
			FontSZHText = {
				color = cc.c3b(35, 1, 0)
			},
			FontLSTCHText = {
				color = cc.c3b(60, 255, 0)
			}
		}

		if string.find(styleData, "Font", 1, 4) ~= nil then
			_setFontCustomPropertyByConfig(text, FontStyleType[styleData])
		elseif tolua.type(text) == "ccui.TextField" then
			_setTextFieldCustomPropertyByConfig(text, FontStyleType[styleData])
		end
	end

	function _setTextFieldCustomPropertyByConfig(textField, config)
		if not config then
			return
		end

		if config.color then
			textField:setFontColor(config.color)
		end
	end

	function clipRichTextWithLimitWidth(clipRt, limitWidth, ellipsisStyle)
		local length = clipRt:getContentLength()
		local size = clipRt:getContentSize()
		local overSize = false

		if limitWidth < size.width then
			overSize = true
			limitWidth = limitWidth - 30
		end

		for i = 1, length do
			clipRt:clipContent(0, i)
			clipRt:renderContent()

			local size = clipRt:getContentSize()

			if limitWidth < size.width and (i >= length or true) then
				break
			end
		end

		ellipsisStyle = ellipsisStyle or {}

		if not ellipsisStyle.hideEllipsis and overSize then
			local size = clipRt:getContentSize()
			local ellipsisText = ccui.Text:create("...", ellipsisStyle.fontName or TTF_FONT_FZYH_M, ellipsisStyle.fontSize or 16)

			ellipsisText:setAnchorPoint(cc.p(0, clipRt:getAnchorPoint().y))
			ellipsisText:addTo(clipRt:getParent())

			local ellipsisSize = ellipsisText:getContentSize()

			clipRt:offset(-clipRt:getAnchorPoint().x * ellipsisSize.width, 0)
			ellipsisText:posite(clipRt:getPositionX() + size.width * (1 - clipRt:getAnchorPoint().x), clipRt:getPositionY())
			setTextWithFontStyle(ellipsisText, ellipsisStyle.fontStyle or "FontTipsText")
		end
	end

	function ccui.Widget:setClickEffectUnVisible(isVisible)
		self.__clickEffectVisible = isVisible
	end

	function ccui.Widget:setClickStyle(clickStyle)
		self.__clickStyle = clickStyle
	end

	function ccui.Widget:setEffectNode(effectNodes)
		self.effectNodes = effectNodes
	end

	function ccui.Widget:setScaleValue(scaleValue)
		self.scaleValue = scaleValue
	end

	function ccui.Widget:getClickStyle()
		return self.__clickStyle
	end
end
