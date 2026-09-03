-- chunkname: @/tmp/or_script/lua_compile/dm/base/functions.lua

local TMXLayer = cc.TMXLayer
local FastTMXLayer = ccexp.TMXLayer

function TMXLayer:getTileCoordinateFor45Degree(pos)
	if not self.mapDegree then
		local tiledSize = self:getMapTileSize()
		local mapSize = self:getContentSize()

		self.mapDegree = math.atan(tiledSize.height / tiledSize.width)
		self.mapCos = math.cos(self.mapDegree)
		self.mapTan = math.tan(self.mapDegree)
		self.mapSin = math.sin(self.mapDegree)
		self.edgeC = tiledSize.width * 0.5 / self.mapCos
		self.mapOriginPos = cc.p(mapSize.width * 0.5, mapSize.height)
	end

	local size = self:getLayerSize()
	local newPos = cc.p(self.mapOriginPos.x - pos.x, self.mapOriginPos.y - pos.y)
	local newX = (newPos.y - newPos.x * self.mapTan) / (2 * self.mapSin)
	local newY = newPos.x / self.mapCos + newX

	if newY < 0 or newX < 0 or newY > size.height * self.edgeC or newX > size.width * self.edgeC then
		return cc.p(-1, -1)
	end

	return cc.p(math.min(math.floor(newX / self.edgeC), size.width - 1), math.min(math.floor(newY / self.edgeC), size.height - 1))
end

function FastTMXLayer:getTileCoordinateFor45Degree(pos)
	return TMXLayer.getTileCoordinateFor45Degree(self, pos)
end

function TMXLayer:getTileCoordinate()
	assert(false, "性能太低被废弃")
end

function TMXLayer:checkTiledMapEdge()
	assert(false, "性能太低被废弃")
end

local nodes = {
	[cc.Node] = {
		"new",
		"create"
	},
	[cc.Layer] = {
		"new",
		"create"
	},
	[cc.LayerColor] = {
		"new",
		"create"
	},
	[cc.Sprite] = {
		"new",
		"create",
		"createWithSpriteFrameName",
		"createWithTexture"
	},
	[cc.Label] = {
		"new",
		"create"
	},
	[cc.LabelTTF] = {
		"new",
		"create"
	},
	[ccui.Widget] = {
		"new",
		"create"
	},
	[ccui.Layout] = {
		"new",
		"create"
	},
	[ccui.RichText] = {
		"new",
		"create",
		"createWithXML"
	},
	[ccui.Scale9Sprite] = {
		"new",
		"create"
	},
	[ccui.ImageView] = {
		"new",
		"create"
	},
	[ccui.Button] = {
		"new",
		"create"
	},
	[ccui.Text] = {
		"new",
		"create"
	},
	[sp.SkeletonAnimation] = {
		"new",
		"create"
	},
	[cc.GroupedNode] = {
		"new",
		"create"
	},
	[cc.TableView] = {
		"new",
		"create"
	},
	[cc.ClippingNode] = {
		"new",
		"create"
	},
	[cc.TableViewCell] = {
		"new",
		"create"
	},
	[cc.MovieClip] = {
		"new",
		"create"
	},
	[cc.ProgressTimer] = {
		"new",
		"create"
	},
	[ccui.EditBox] = {
		"new",
		"create"
	},
	[cc.ParticleSystemQuad] = {
		"create"
	}
}

for node, funcs in pairs(nodes) do
	for i = 1, #funcs do
		local func = funcs[i]
		local oldFunc = node[func]

		if oldFunc then
			node[func] = function(...)
				local obj = oldFunc(...)

				if not obj then
					return
				end

				obj:setCascadeOpacityEnabled(true)
				obj:setCascadeColorEnabled(true)
				obj:setCascadeOpacityEnabledRecursively(true)
				obj:setCascadeColorEnabledRecursively(true)

				if obj.getContainer then
					obj:getContainer():setCascadeOpacityEnabled(true)
					obj:getContainer():setCascadeColorEnabled(true)
					obj:getContainer():setCascadeOpacityEnabledRecursively(true)
					obj:getContainer():setCascadeColorEnabledRecursively(true)
				end

				return obj
			end
		end
	end
end

function checkDependInstance(ins)
	return not ins or not DisposableObject:isDisposed(ins)
end

function table.reverse(array)
	local arrLength = #array

	if arrLength <= 1 then
		return array
	end

	local length = math.floor(arrLength / 2)

	for i = 1, length do
		array[i] = array[arrLength - i + 1]
		array[arrLength - i + 1] = array[i]
	end

	return array
end

function replaceTextFieldToEditLayer(textWidget, ignoreForbiddenWord, maskType)
	if not textWidget then
		return nil
	end

	local widgetType = textWidget:getDescription()

	if widgetType ~= "TextField" then
		return textWidget
	end

	local textFieldSize = textWidget:getContentSize()
	local pNewLayer = cc.Layer:create()
	local editBox = ccui.EditBox:create(textFieldSize, " ")
	local parent = textWidget:getParent()

	if not parent then
		dump("error: EditBox parent is nil")

		return textWidget
	end

	parent:addChild(pNewLayer)
	pNewLayer:setTouchEnabled(true)

	local function onTouchBegin(touch, event)
		local node = pNewLayer

		while node do
			if not node:isVisible() then
				return false
			end

			node = node:getParent()
		end

		local p = pNewLayer._editBox:convertToNodeSpace(touch:getLocation())

		if p.x > 0 and p.y > 0 and p.x < pNewLayer._editBox:getContentSize().width and p.y < pNewLayer._editBox:getContentSize().height then
			return (editBox:isVisible())
		end

		return false
	end

	local isOpen = false

	local function openKeyboard()
		if isOpen then
			return
		end

		isOpen = true

		local visibleOrigin = cc.Director:getInstance():getVisibleOrigin()
		local visibleSize = cc.Director:getInstance():getVisibleSize()
		local editLayer = cc.LayerColor:create(cc.c4b(0, 0, 0, 155))

		editLayer:setCascadeOpacityEnabled(false)
		editLayer:setCascadeColorEnabled(false)
		editLayer:setCascadeOpacityEnabledRecursively(false)
		editLayer:setCascadeColorEnabledRecursively(false)
		editLayer:addTo(cc.Director:getInstance():getRunningScene(), 9999)
		editLayer:setTouchEnabled(true)

		local function onTouchBegin(touch, event)
			return true
		end

		local listener = cc.EventListenerTouchOneByOne:create()

		listener:setSwallowTouches(true)
		listener:registerScriptHandler(onTouchBegin, cc.Handler.EVENT_TOUCH_BEGAN)
		editLayer:getEventDispatcher():addEventListenerWithSceneGraphPriority(listener, editLayer)

		local function editBoxTextEventHandle(strEventName, pSender)
			local editBox = pNewLayer._editBox
			local edit = pSender
			local strFmt

			if strEventName == "began" then
				local contentLabel = editBox:getContentLabel()

				if contentLabel:getString() ~= editBox:getText() then
					editBox:setText(contentLabel:getString())
					edit:setText(contentLabel:getString())
				end

				if contentLabel then
					contentLabel:setVisible(false)
				end

				local placeHolderContent = editBox:getPlaceholderLabel()

				if placeHolderContent then
					placeHolderContent:setVisible(false)
				end

				editBox._keyboardState = true
			elseif strEventName == "ended" then
				editLayer:removeFromParent(true)

				isOpen = false

				editBox:setText(edit:getText())

				local result, finalString = false, editBox:getText()

				if not ignoreForbiddenWord then
					result, finalString = StringChecker.hasForbiddenWords(finalString, maskType)
				end

				if result then
					editBox:setText(finalString)

					if editBox._callback then
						editBox._callback("ForbiddenWord", editBox)
					end
				end

				if editBox._maxLengthEnabled and utf8.len(editBox:getText()) > editBox._maxLength then
					editBox:setText(utf8.sub(editBox:getText(), 1, editBox._maxLength))

					if editBox._callback then
						editBox._callback("Exceed", editBox)
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
			elseif strEventName == "return" then
				-- block empty
			elseif strEventName == "changed" then
				editBox:setText(edit:getText())

				if editBox and editBox._maxLengthEnabled and editBox._keyboardState then
					if utf8.len(editBox:getText()) > editBox._maxLength then
						local text = utf8.sub(editBox:getText(), 1, editBox._maxLength)

						if text ~= editBox:getText() then
							editBox:setText(utf8.sub(editBox:getText(), 1, editBox._maxLength))

							if editBox._callback then
								editBox._callback("Exceed", editBox)
							end
						end
					end

					local contentLabel = editBox:getContentLabel()

					if contentLabel then
						contentLabel:setVisible(not edit._keyboardState)
					end
				end
			end

			if editBox._callback then
				editBox._callback(strEventName, editBox)
			end
		end

		local backImg = ccui.Scale9Sprite:create("asset/common/common_bg_shurukuang.png")

		backImg:addTo(editLayer):move(visibleSize.width / 2, visibleSize.height * 0.9)
		backImg:setContentSize(cc.rect(0, 0, visibleSize.width * 0.81, 80))

		local editBox = pNewLayer._editBox
		local editName = ccui.EditBox:create(cc.size(visibleSize.width * 0.8, 60), "asset/common/common_bg_srk.png")

		editName:setInputMode(pNewLayer._inputMode)
		editName:setReturnType(pNewLayer._returnType)
		editName:addTo(editLayer):move(visibleSize.width / 2, visibleSize.height * 0.9)
		editName:registerScriptEditBoxHandler(editBoxTextEventHandle)
		editName:setText(editBox:getText())
		editName.touchDownAction(editName, editName, ccui.TouchEventType.ended)
		editName:setFontSize(28)
		editName:setFontName(pNewLayer._fontName)
		editName:setFontColor(pNewLayer._fontColor)

		return true
	end

	local function onTouchEnd(touch, event)
		openKeyboard()
	end

	local listener = cc.EventListenerTouchOneByOne:create()

	listener:setSwallowTouches(false)
	listener:registerScriptHandler(onTouchBegin, cc.Handler.EVENT_TOUCH_BEGAN)
	listener:registerScriptHandler(onTouchEnd, cc.Handler.EVENT_TOUCH_ENDED)
	pNewLayer:getEventDispatcher():addEventListenerWithSceneGraphPriority(listener, pNewLayer)
	pNewLayer:addChild(editBox)

	pNewLayer._editBox = editBox

	editBox:setText(textWidget:getString())

	local anchorPt = textWidget:getAnchorPoint()

	editBox:setAnchorPoint(anchorPt)

	local x, y = textWidget:getPosition()

	editBox:setPosition(cc.p(x, y))
	editBox:setLocalZOrder(textWidget:getLocalZOrder())
	editBox:setVisible(textWidget:isVisible())
	editBox:setFontSize(textWidget:getFontSize())
	editBox:setFontName(textWidget:getFontName())

	pNewLayer._fontName = textWidget:getFontName()

	editBox:setFontColor(textWidget:getColor())

	pNewLayer._fontColor = textWidget:getColor()

	editBox:setPlaceHolder(textWidget:getPlaceHolder())
	editBox:setPlaceholderFont(textWidget:getFontName(), textWidget:getFontSize())
	editBox:setPlaceholderFontColor(textWidget:getPlaceHolderColor())
	editBox:setScaleX(textWidget:getScaleX())
	editBox:setScaleY(textWidget:getScaleY())
	editBox:setTag(textWidget:getTag())
	editBox:setName(textWidget:getName())
	editBox:setInputMode(cc.EDITBOX_INPUT_MODE_SINGLELINE)
	editBox:setReturnType(cc.KEYBOARD_RETURNTYPE_DONE)

	pNewLayer._inputMode = cc.EDITBOX_INPUT_MODE_SINGLELINE
	pNewLayer._returnType = cc.KEYBOARD_RETURNTYPE_DONE

	local setInputMode = editBox.setInputMode
	local setReturnType = editBox.setReturnType

	function editBox:setInputMode(mode)
		setInputMode(editBox, mode)

		pNewLayer._inputMode = mode
	end

	function editBox:setReturnType(type)
		setReturnType(editBox, type)

		pNewLayer._returnType = type
	end

	function editBox:openKeyboard()
		openKeyboard()
	end

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

	adjustEditBox(editBox)
	editBox:unregisterScriptEditBoxHandler()
	editBox:registerScriptEditBoxHandler(function(eventName, sender)
		if eventName == "began" then
			-- block empty
		elseif eventName == "ended" then
			-- block empty
		elseif eventName == "return" then
			-- block empty
		elseif eventName == "changed" then
			-- block empty
		end
	end)

	editBox._keyboardState = false

	editBox:setTouchEnabled(false)

	function editBox:setTouchEnabled(type)
		pNewLayer:setTouchEnabled(type)
	end

	parent:removeChild(textWidget)

	return editBox
end

function convertTextFieldToEditBox(textWidget, ignoreForbiddenWord, maskType)
	if not textWidget then
		return nil
	end

	if device.platform == "android" then
		return replaceTextFieldToEditLayer(textWidget, ignoreForbiddenWord, maskType)
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

	if textWidget:getFontName() == "" then
		if not TTF_FONT_FZYH_R then
			local fontName = textWidget:getFontName()

			editBox:setText(textWidget:getString())

			local anchorPt = textWidget:getAnchorPoint()

			editBox:setAnchorPoint(anchorPt)

			local x, y = textWidget:getPosition()

			editBox:setPosition(cc.p(x, y))
			editBox:setLocalZOrder(textWidget:getLocalZOrder())
			editBox:setVisible(textWidget:isVisible())
			editBox:setFontSize(textWidget:getFontSize())
			editBox:setFontName(fontName)
			editBox:setFontColor(textWidget:getColor())
			editBox:setPlaceHolder(textWidget:getPlaceHolder())
			editBox:setPlaceholderFont(fontName, textWidget:getFontSize())
			editBox:setPlaceholderFontColor(textWidget:getPlaceHolderColor())
			editBox:setScaleX(textWidget:getScaleX())
			editBox:setScaleY(textWidget:getScaleY())
			editBox:setTag(textWidget:getTag())
			editBox:setName(textWidget:getName())
			editBox:setInputMode(cc.EDITBOX_INPUT_MODE_SINGLELINE)
			editBox:setReturnType(cc.KEYBOARD_RETURNTYPE_DONE)

			if textWidget:isMaxLengthEnabled() then
				editBox:setMaxLength(textWidget:getMaxLength())
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

			function editBox:onEvent(callback)
				self._callback = callback
			end

			function editBox:getkeyboardState()
				return self._keyboardState
			end

			adjustEditBox(editBox)
			editBox:unregisterScriptEditBoxHandler()
			editBox:registerScriptEditBoxHandler(function(eventName, sender)
				if eventName == "began" then
					local contentLabel = editBox:getContentLabel()

					if contentLabel then
						contentLabel:setVisible(false)
					end

					local placeHolderContent = editBox:getPlaceholderLabel()

					if placeHolderContent then
						placeHolderContent:setVisible(false)
					end

					editBox._keyboardState = true
				elseif eventName == "ended" then
					local result, finalString = false, editBox:getText()

					if not ignoreForbiddenWord then
						result, finalString = StringChecker.hasForbiddenWords(finalString, maskType)
					end

					if result then
						editBox:setText(finalString)

						if editBox._callback then
							editBox._callback("ForbiddenWord", sender)
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
				elseif eventName == "changed" then
					-- block empty
				end

				if editBox._callback then
					editBox._callback(eventName, sender)
				end
			end)

			editBox._keyboardState = false

			parent:removeChild(textWidget)

			return editBox
		end
	end
end

function assertCObj(obj, message)
	assert(not tolua.isnull(obj), "此对象已经被移除:" .. (message or ""))
end

function easyHttpRequest(url, data, type, callback, noBlockUI)
	type = type or "POST"

	if not noBlockUI then
		WaitingView:getInstance():show(WaitingStyle.kLoading, {
			delay = 200
		})
	end

	local xhr = cc.XMLHttpRequest:new()

	xhr.responseType = cc.XMLHTTPREQUEST_RESPONSE_STRING

	xhr:open(type, url)

	local function httpResponse()
		if not noBlockUI then
			WaitingView:getInstance():hide()
		end

		if GAME_SHOW_NETDATA then
			dump(xhr.response, "easyHttp response:")
			dump(xhr.status, "easyHttp status:")
		end

		if callback then
			callback(xhr.status, xhr.response)
		end
	end

	xhr:registerScriptHandler(httpResponse)
	xhr:send(data)

	if GAME_SHOW_NETDATA then
		dump(data, "easyHttp request:" .. url)
	end
end
