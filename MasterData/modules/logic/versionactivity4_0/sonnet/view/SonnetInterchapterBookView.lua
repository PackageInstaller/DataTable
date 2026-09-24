-- chunkname: @modules/logic/versionactivity4_0/sonnet/view/SonnetInterchapterBookView.lua

module("modules.logic.versionactivity4_0.sonnet.view.SonnetInterchapterBookView", package.seeall)

local SonnetInterchapterBookView = class("SonnetInterchapterBookView", BaseView)

function SonnetInterchapterBookView:onInitView()
	self._gobookopen = gohelper.findChild(self.viewGO, "open/#go_book_open")
	self._gounopen = gohelper.findChild(self.viewGO, "open/#go_unopen")
	self._btnclick = gohelper.findChildButtonWithAudio(self.viewGO, "open/#go_unopen/#btn_click")
	self._gohas = gohelper.findChild(self.viewGO, "open/#go_has")
	self._scrollDescLeft = gohelper.findChildScrollRect(self.viewGO, "open/#go_has/#scroll_DescLeft")
	self._godescitem = gohelper.findChild(self.viewGO, "open/#go_has/#scroll_DescLeft/Viewport/Content/#go_descitem")
	self._scrollDescRight = gohelper.findChildScrollRect(self.viewGO, "open/#go_has/#scroll_DescRight")
	self._godescitem2 = gohelper.findChild(self.viewGO, "open/#go_has/#scroll_DescRight/Viewport/Content/#go_descitem2")
	self._goempty = gohelper.findChild(self.viewGO, "open/#go_empty")
	self._goUIEffLine = gohelper.findChild(self.viewGO, "open/#go_UIEff_Line")
	self._goworditem = gohelper.findChild(self.viewGO, "open/mindContent/#go_worditem")
	self._godialogcontainer = gohelper.findChild(self.viewGO, "open/#go_dialogcontainer")
	self._godialog = gohelper.findChild(self.viewGO, "open/#go_dialogcontainer/#go_dialog")
	self._simageheadicon = gohelper.findChildSingleImage(self.viewGO, "open/#go_dialogcontainer/#go_dialog/container/headframe/#simage_headicon")
	self._txtcontentcn = gohelper.findChildText(self.viewGO, "open/#go_dialogcontainer/#go_dialog/container/go_normalcontent/#txt_contentcn")
	self._btnclickdialog = gohelper.findChildButtonWithAudio(self.viewGO, "open/#go_dialogcontainer/#btn_clickdialog")
	self._btnink = gohelper.findChildButtonWithAudio(self.viewGO, "open/#btn_ink")
	self._imageink = gohelper.findChildImage(self.viewGO, "open/#btn_ink/#image_ink")
	self._txtprogress = gohelper.findChildText(self.viewGO, "open/#btn_ink/#txt_progress")
	self._goUIEffink = gohelper.findChild(self.viewGO, "open/#btn_ink/#go_UIEff_ink")
	self._golefttop = gohelper.findChild(self.viewGO, "#go_lefttop")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function SonnetInterchapterBookView:addEvents()
	self._btnclick:AddClickListener(self._btnclickOnClick, self)
	self._btnclickdialog:AddClickListener(self._btnclickdialogOnClick, self)
	self._btnink:AddClickListener(self._btninkOnClick, self)
end

function SonnetInterchapterBookView:removeEvents()
	self._btnclick:RemoveClickListener()
	self._btnclickdialog:RemoveClickListener()
	self._btnink:RemoveClickListener()
end

function SonnetInterchapterBookView:_btnclickdialogOnClick()
	return
end

function SonnetInterchapterBookView:_btnclickOnClick()
	return
end

function SonnetInterchapterBookView:_btninkOnClick()
	return
end

function SonnetInterchapterBookView:_editableInitView()
	gohelper.setActive(self._goworditem, false)
	gohelper.setActive(self._gobookopen, true)
	gohelper.setActive(self._goUIEffLine, false)
	gohelper.setActive(self._godescitem, false)
	gohelper.setActive(self._godescitem2, false)

	self._poemList = self:getUserDataTb_()
end

function SonnetInterchapterBookView:onUpdateParam()
	return
end

function SonnetInterchapterBookView:onOpen()
	self:_showWordsView()
	self:_updateProgress()
	AudioMgr.instance:trigger(SonnetInterchapterEnum.Audio.play_ui_wulu_paiqian_open)
end

function SonnetInterchapterBookView:_addLoadWords(id)
	self._loadWordId = id

	gohelper.setActive(self._goUIEffink, false)
	gohelper.setActive(self._goUIEffink, true)
end

function SonnetInterchapterBookView:_onUseWordResponse()
	if self._loadWordId then
		if self._loadWordId then
			gohelper.setActive(self._loadWordId.go, false)
		end

		self:_updateProgress()
	end
end

function SonnetInterchapterBookView:_updateProgress()
	local num = #SonnetInterchapterModel.instance:getAllUsedWords()
	local value = math.min(num * 50, 100)

	self._curProgress = value
	self._txtprogress.text = string.format(luaLang("sonnet_book_progress"), value)

	if self._curProgress >= 100 then
		SonnetInterchapterRpc.instance:sendSonnetConsumeWordRequest(self._onConsumeWordResponse, self)
	end

	self:_showConsumedWords()
end

function SonnetInterchapterBookView:_showConsumedWords()
	local list = SonnetInterchapterModel.instance:getAllConsumedWords()
	local len = #list

	gohelper.setActive(self._goempty, len == 0)
	gohelper.setActive(self._gohas, len > 0)

	local index = 1
	local progress = 0

	for i = 1, len do
		progress = progress + 50

		if progress >= 100 then
			progress = 0

			self:_showPoem(index)

			index = index + 1
		end
	end
end

function SonnetInterchapterBookView:_showPoem(index)
	if self._poemList[index] then
		return
	end

	local config = lua_sonnet_poem.configDict[300 + index]

	if not config then
		logError("no config for poem: " .. tostring(index))

		return
	end

	local go = gohelper.cloneInPlace(self._godescitem)

	gohelper.setActive(go, true)

	local txt = gohelper.findChildText(go, "txt_name")

	txt.text = config.poem
	self._poemList[index] = true
end

function SonnetInterchapterBookView:_onConsumeWordResponse()
	self:_updateProgress()
end

function SonnetInterchapterBookView:_showWordsView()
	self._wordItems = self:getUserDataTb_()

	local words = SonnetInterchapterModel.instance:getAllUnlockWords()

	for i, v in ipairs(words) do
		local wordConfig = SonnetInterchapterConfig.instance:getWordConfig(v.id)

		if wordConfig then
			local go = gohelper.cloneInPlace(self._goworditem)

			gohelper.setActive(go, true)

			local pos = string.splitToNumber(wordConfig.noteCoordinates, "#")

			if not pos[1] then
				local x = math.random(1920) - 1000

				if not pos[2] then
					local y = math.random(1080) - 600

					recthelper.setAnchor(go.transform, x, y)

					local txt = gohelper.findChildText(go, "unselect/txt")

					txt.text = wordConfig.words

					local newGo = gohelper.findChild(go, "new")

					gohelper.setActive(newGo, not SonnetInterchapterController.hasOnceActionKey(SonnetInterchapterEnum.PrefsKey.NewWord, v.id))

					local btn = gohelper.findChildButtonWithAudio(go, "btn_click")
					local data = {
						go = go,
						transform = go.transform,
						btn = btn,
						id = v.id,
						x = x,
						y = y,
						newGo = newGo
					}

					btn:AddClickListener(self._onBtnClick, self, data)

					self._wordItems[v.id] = data
				end
			end
		end
	end
end

function SonnetInterchapterBookView:_beginDrag(data, pointerEventData)
	gohelper.setActive(self._goUIEffLine, true)
	self:_refreshDragLine(data)
end

function SonnetInterchapterBookView:_onDrag(data, pointerEventData)
	self:_refreshDragLine(data)
end

function SonnetInterchapterBookView:_refreshDragLine(data)
	local lineTransform = self._goUIEffLine.transform
	local lineParent = lineTransform.parent
	local fromPos = lineParent:InverseTransformPoint(self._btnink.transform.position)
	local toPos = lineParent:InverseTransformPoint(data.transform.position)
	local fromX = fromPos.x
	local fromY = fromPos.y
	local toX = toPos.x
	local toY = toPos.y
	local deltaX = toX - fromX
	local deltaY = toY - fromY

	transformhelper.setLocalPosXY(lineTransform, fromX, fromY)
	recthelper.setWidth(lineTransform, math.sqrt(deltaX * deltaX + deltaY * deltaY))
	transformhelper.setLocalRotation(lineTransform, 0, 0, math.atan2(deltaY, deltaX) * 180 / math.pi)
end

function SonnetInterchapterBookView:_endDrag(data, pointerEventData)
	gohelper.setActive(self._goUIEffLine, false)

	if ZProj.UGUIHelper.Overlaps(data.transform, self._btnink.transform, CameraMgr.instance:getUICamera()) then
		self:_addLoadWords(data.id)

		return
	end

	recthelper.setAnchor(data.transform, data.x, data.y)
end

function SonnetInterchapterBookView:_onBtnClick(data)
	local id = data.id
	local wordConfig = SonnetInterchapterConfig.instance:getWordConfig(id)

	if not wordConfig then
		logError("wordConfig is nil", id)

		return
	end

	TipDialogController.instance:openTipDialogView(wordConfig.dialogId)

	if not SonnetInterchapterController.hasOnceActionKey(SonnetInterchapterEnum.PrefsKey.NewWord, id) then
		gohelper.setActive(data.newGo, false)
		SonnetInterchapterController.setOnceActionKey(SonnetInterchapterEnum.PrefsKey.NewWord, id)
		SonnetInterchapterController.instance:dispatchEvent(SonnetInterchapterEvent.ClickNewWord)
	end
end

function SonnetInterchapterBookView:onClose()
	for i, v in ipairs(self._wordItems) do
		v.btn:RemoveClickListener()
		CommonDragHelper.instance:unregisterDragObj(v.go)
	end

	AudioMgr.instance:trigger(SonnetInterchapterEnum.Audio.play_ui_role_pieces_open)
end

function SonnetInterchapterBookView:onDestroyView()
	return
end

return SonnetInterchapterBookView
