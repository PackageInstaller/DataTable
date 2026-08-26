-- chunkname: @modules/logic/versionactivity2_1/activity165/view/Activity165StepItem.lua

module("modules.logic.versionactivity2_1.activity165.view.Activity165StepItem", package.seeall)

local Activity165StepItem = class("Activity165StepItem", LuaCompBase)

function Activity165StepItem:onInitView()
	self._goleft = gohelper.findChild(self.viewGO, "#go_left")
	self._txtstory = gohelper.findChildText(self.viewGO, "#go_left/scroll_story/Viewport/#txt_story")
	self._goright = gohelper.findChild(self.viewGO, "#go_right")
	self._goselect = gohelper.findChild(self.viewGO, "#go_right/icon/bg/#go_select")
	self._goadd = gohelper.findChild(self.viewGO, "#go_right/icon/#go_add")
	self._gocorrect = gohelper.findChild(self.viewGO, "#go_right/icon/#go_correct")
	self._imageicon = gohelper.findChildImage(self.viewGO, "#go_right/icon/#image_icon")
	self._gopoint = gohelper.findChild(self.viewGO, "#go_right/icon/#go_point")
	self._btnclick = gohelper.findChildButtonWithAudio(self.viewGO, "#go_right/icon/#btn_click")
	self._txtindex = gohelper.findChildText(self.viewGO, "#go_right/indexbg/#txt_index")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Activity165StepItem:addEvents()
	self._btnclick:AddClickListener(self._btnclickOnClick, self)
end

function Activity165StepItem:removeEvents()
	self._btnclick:RemoveClickListener()
end

function Activity165StepItem:addEventListeners()
	self:addEvents()
end

function Activity165StepItem:removeEventListeners()
	self:removeEvents()
end

function Activity165StepItem:_btnclickOnClick()
	if self.isFixed then
		return
	end

	if self._storyMo then
		local stage = self._storyMo:getState()

		if stage == Activity165Enum.StoryStage.Ending then
			return
		end

		Activity165Controller.instance:dispatchEvent(Activity165Event.onClickStepBtn, self._index)
	end
end

function Activity165StepItem:_editableInitView()
	self._goindex = gohelper.findChild(self.viewGO, "#go_right/indexbg")
	self._goDecorate = gohelper.findChild(self.viewGO, "#go_left/img_tex")
	self._goTxt = gohelper.findChild(self.viewGO, "#go_left/scroll_story")
	self._scrollStory = gohelper.findChildScrollRect(self.viewGO, "#go_left/scroll_story")
	self._gobg = gohelper.findChild(self.viewGO, "#go_right/icon/bg")
	self._tex1 = gohelper.findChild(self.viewGO, "#go_left/img_tex/img_en1")
	self._tex2 = gohelper.findChild(self.viewGO, "#go_left/img_tex/img_en2")
	self._goeglocked = gohelper.findChild(self.viewGO, "#go_eglocked")
	self._goline = gohelper.findChild(self.viewGO, "line")
	self._anieglocked = SLFramework.AnimatorPlayer.Get(self._goeglocked.gameObject)
	self._aniTex = SLFramework.AnimatorPlayer.Get(self._goDecorate.gameObject)
	self._aniView = SLFramework.AnimatorPlayer.Get(self.viewGO.gameObject)
	self._keywordPointList = self:getUserDataTb_()
	self._typeMarkItemList = self:getUserDataTb_()
	self._markItemList = self:getUserDataTb_()

	local goMark = gohelper.findChild(self.viewGO, "#go_left/scroll_story/Viewport/#txt_story/go_mark")

	self._goMarkPrefabs = self:getUserDataTb_()

	for i = 1, 4 do
		self._goMarkPrefabs[i] = gohelper.findChild(goMark, "mark_" .. i)

		gohelper.setActive(self._goMarkPrefabs[i], false)

		self._typeMarkItemList[i] = self:getUserDataTb_()
	end

	for i = 1, self._gopoint.transform.childCount do
		local _go = gohelper.findChild(self._gopoint, i)

		for j = 1, i do
			local icon = gohelper.findChildImage(_go, j)

			if not self._keywordPointList[i] then
				self._keywordPointList[i] = self:getUserDataTb_()
				self._keywordPointList[i].go = _go
				self._keywordPointList[i].ponit = self:getUserDataTb_()
			end

			local item = self:getUserDataTb_()

			item.go = icon.gameObject
			item.icon = icon
			item.canvasgroup = icon.gameObject:GetComponent(typeof(UnityEngine.CanvasGroup))

			table.insert(self._keywordPointList[i].ponit, item)
		end
	end

	self._txtstory.text = ""
	self._keywordMaxCount = tabletool.len(self._keywordPointList)
	self._keywordItem = self:getUserDataTb_()
	self._keywordIdList = {}
	self._bogusId = nil
end

function Activity165StepItem:init(go)
	self.viewGO = go

	self:onInitView()
end

function Activity165StepItem:onInitItem(storyMo, index)
	self._index = index
	self._storyMo = storyMo
	self._actId = storyMo._actId

	if self._index == 3 then
		transformhelper.setLocalPosXY(self._goeglocked.transform, 763, 850)
	end

	self:activeStep(false)
end

function Activity165StepItem:onRefreshMo(stepId)
	self._stepMo = stepId and self._storyMo:getStepMo(stepId)

	local kwIds = self._storyMo:getKwIdsByStepIndex(self._index)

	self._keywordIdList = kwIds or {}

	local isCanFill = self._storyMo:getState() == Activity165Enum.StoryStage.Filling
	local unlockStepCount = self._storyMo:getUnlockStepIdRemoveEndingCount()
	local unlockIndex = self._index - unlockStepCount

	self._isUnlock = unlockIndex <= 0
	self._isCurStep = isCanFill and unlockIndex == 1 or false
	self.isFixed = self._isUnlock and not LuaUtil.tableNotEmpty(self._keywordIdList)

	if self._stepMo and self._isUnlock and self.isFixed then
		local pic = self._stepMo.stepCo.pic

		if not string.nilorempty(pic) then
			UISpriteSetMgr.instance:setV2a1Act165Sprite(self._imageicon, pic, true)
		end
	end
end

function Activity165StepItem:onUpdateMO(stepId)
	self:killTween()

	self._stepId = stepId

	self:onRefreshMo(stepId)
	self:refreshIndex(self._index)
	gohelper.setActive(self._gocorrect.gameObject, self._isUnlock)

	if self._isCurStep then
		self:showEgLock()
	else
		self:_hideEglocked()
	end

	if not self._isUnlock and not self._isCurStep then
		self:activeStep(false)

		return
	end

	self:activeStep(true)

	if self._isUnlock then
		self:showStoryTxt()
	end

	self:refreshState()
	gohelper.setActive(self._goTxt.gameObject, self._isUnlock)
	self:showDecorateTexture()
	self:setKeywordItem()
end

function Activity165StepItem:showEgLock(callback)
	gohelper.setActive(self._goeglocked.gameObject, true)
	self._anieglocked:Play(Activity165Enum.EditViewAnim.Idle, callback, self)
end

function Activity165StepItem:unlockEgLock()
	if not self.isFixed and LuaUtil.tableNotEmpty(self._keywordIdList) then
		gohelper.setActive(self._goeglocked.gameObject, true)
		self._anieglocked:Play(Activity165Enum.EditViewAnim.Unlock, self._hideEglocked, self)
	else
		self:_hideEglocked()
	end
end

function Activity165StepItem:_hideEglocked()
	gohelper.setActive(self._goeglocked.gameObject, false)
end

function Activity165StepItem:showDecorateTexture(callback)
	local isShow = not self._isUnlock and self:getFillKwCount() >= 1

	gohelper.setActive(self._goDecorate.gameObject, isShow)

	if isShow then
		self._aniTex:Play(Activity165Enum.EditViewAnim.Idle, callback, self)
	end
end

function Activity165StepItem:unlockDecorateTexture(callback)
	gohelper.setActive(self._goDecorate.gameObject, true)
	self._aniTex:Play(Activity165Enum.EditViewAnim.Unlock, callback, self)
end

function Activity165StepItem:playDecorateTexture(callback)
	gohelper.setActive(self._goDecorate.gameObject, true)
	self._aniTex:Play(Activity165Enum.EditViewAnim.Unlock, callback, self)
end

function Activity165StepItem:hideyDecorateTexture()
	gohelper.setActive(self._goDecorate.gameObject, false)
end

function Activity165StepItem:onFinishStep(stepId)
	self._isUnlock = true

	self:beginShowTxt(stepId)
	self:unlockEgLock()
	gohelper.setActive(self._gocorrect.gameObject, true)
end

function Activity165StepItem:activeStep(isActive)
	local isPreActive = self._goleft.gameObject.activeSelf

	gohelper.setActive(self._goleft.gameObject, isActive)
	gohelper.setActive(self._goright.gameObject, isActive)
	gohelper.setActive(self._goline.gameObject, isActive)

	if not isPreActive and isActive then
		self._aniView:Play(Activity165Enum.EditViewAnim.EgOpen, nil, self)
	end
end

function Activity165StepItem:refreshIndex(index)
	self._txtindex.text = index > 10 and index or "0" .. index

	local offset = Activity165Enum.StepOffsetObj[index % 2 + 1]
	local txtWidth = self.isFixed and 480 or 530
	local offsetTxt = index % 2 == 0 and -15 or 15

	if self.isFixed then
		if not (offset.gotxt.PosX + offsetTxt) then
			local txtPosx = offset.gotxt.PosX

			recthelper.setWidth(self._goTxt.transform, txtWidth)

			self._scrollTxtHeight = self._goTxt.transform.rect.height

			transformhelper.setLocalPosXY(self._goleft.transform, offset.goleft.PosX, offset.goleft.PosY)
			transformhelper.setLocalPosXY(self._goright.transform, offset.goright.PosX, offset.goright.PosY)
			transformhelper.setLocalPosXY(self._goindex.transform, offset.goindex.PosX, offset.goindex.PosY)
			transformhelper.setLocalPosXY(self._goTxt.transform, txtPosx, offset.gotxt.PosY)
			gohelper.setActive(self._tex1, index % 2 == 0)
			gohelper.setActive(self._tex2, index % 2 == 1)
		end
	end
end

function Activity165StepItem:onDestroy()
	self:killTween()
end

function Activity165StepItem:refreshState()
	if not self.isFixed then
		local isNull = self:isNullKeyword()

		gohelper.setActive(self._goadd.gameObject, not self._isUnlock and isNull and not self._bogusId)
		self:refreshFillStepState()
	end

	gohelper.setActive(self._gobg, not self.isFixed)
	gohelper.setActive(self._imageicon.gameObject, self.isFixed)
end

function Activity165StepItem:setBogusKeyword(id)
	if self._bogusId or not self:tryFillKeyword() then
		return
	end

	self._bogusId = id

	self:setKeywordItem()
end

function Activity165StepItem:cancelBogusKeyword()
	self._bogusId = nil
end

function Activity165StepItem:refreshBogusKeyword()
	if self._bogusId then
		self._bogusId = nil

		self:setKeywordItem()
	end
end

function Activity165StepItem:refreshFillStepState()
	if self._storyMo then
		local index = self._storyMo:getSelectStepIndex()
		local isShow = index and index == self._index or false

		gohelper.setActive(self._goselect.gameObject, isShow)
	end
end

function Activity165StepItem:tryFillKeyword(id)
	if self:isFullKeyword() then
		return false
	end

	if LuaUtil.tableContains(self._keywordIdList, id) then
		return false
	end

	return true
end

function Activity165StepItem:getFillKwCount()
	return tabletool.len(self._keywordIdList)
end

function Activity165StepItem:fillKeyword(id)
	self:addKeywordItem(id)

	if self:getFillKwCount() == 1 then
		self:unlockDecorateTexture()
	end
end

function Activity165StepItem:failFillKeyword(id)
	self:removeKeywordItem(id)
end

function Activity165StepItem:addKeywordItem(id)
	if not LuaUtil.tableContains(self._keywordIdList, id) then
		table.insert(self._keywordIdList, id)
	end

	self:setKeywordItem()
end

function Activity165StepItem:removeKeywordItem(id)
	if LuaUtil.tableContains(self._keywordIdList, id) then
		tabletool.removeValue(self._keywordIdList, id)
		self:showDecorateTexture()
	end

	self:setKeywordItem()
end

function Activity165StepItem:clearStep()
	self._keywordIdList = {}

	for i, list in pairs(self._keywordPointList) do
		gohelper.setActive(list.go, false)
	end

	self.isFixed = false

	self:_hideAllMark()
	self:onUpdateMO()
	gohelper.setActive(self._goTxt.gameObject, false)
	self:showDecorateTexture()
end

function Activity165StepItem:setKeywordItem()
	local idCount = self:getFillKwCount()

	if self._bogusId then
		idCount = idCount + 1
	end

	if idCount > 0 and idCount <= self._keywordMaxCount then
		local index = 1

		if LuaUtil.tableNotEmpty(self._keywordIdList) then
			for _, id in pairs(self._keywordIdList) do
				local point = self._keywordPointList[idCount].ponit[index]
				local co = Activity165Config.instance:getKeywordCo(self._actId, id)
				local icon = co.pic

				if not string.nilorempty(icon) then
					UISpriteSetMgr.instance:setV2a1Act165Sprite(point.icon, icon)
				end

				if point.canvasgroup then
					point.canvasgroup.alpha = 1
				end

				index = index + 1
			end
		end

		if self._bogusId then
			local point = self._keywordPointList[idCount].ponit[index]
			local co = Activity165Config.instance:getKeywordCo(self._actId, self._bogusId)
			local icon = co.pic

			if not string.nilorempty(icon) then
				UISpriteSetMgr.instance:setV2a1Act165Sprite(point.icon, icon)
			end

			if point.canvasgroup then
				point.canvasgroup.alpha = 0.5
			end
		end
	end

	for i, list in pairs(self._keywordPointList) do
		gohelper.setActive(list.go, idCount == i)
	end

	self:refreshState()
end

function Activity165StepItem:getKeywordItem(index)
	local item = self._keywordItem[index]

	if not item then
		local go = gohelper.cloneInPlace(self._gokeyword, "kw_" .. index)

		item = {
			go = go,
			icon = gohelper.findChildImage(go, "#image_keyword"),
			anim = SLFramework.AnimatorPlayer.Get(go.gameObject)
		}
		self._keywordItem[index] = item
	end

	return item
end

function Activity165StepItem:getKeywordList()
	return self._keywordIdList
end

function Activity165StepItem:isKeyword(kwId)
	return LuaUtil.tableContains(self._keywordIdList, kwId)
end

function Activity165StepItem:isNullKeyword()
	return not LuaUtil.tableNotEmpty(self._keywordIdList)
end

function Activity165StepItem:isFullKeyword()
	local isFull = self._keywordMaxCount <= self:getFillKwCount()

	if isFull then
		GameFacade.showToast(ToastEnum.Act165StepMaxCount, self._keywordMaxCount)
		AudioMgr.instance:trigger(AudioEnum.Activity156.play_ui_wangshi_fill_fail)
	end

	return isFull
end

function Activity165StepItem:beginShowTxt(stepId)
	if not LuaUtil.tableNotEmpty(self._stepMo) then
		self._stepMo = self._storyMo:getStepMo(stepId)
	end

	self:_setStepText()

	self._markItemPos = {}

	self:_setMarkItemPos()

	self._txtstory.text = ""
	self._finsihShowTxt = nil
	self._scrollHeight = recthelper.getHeight(self._scrollStory.transform)
	self._tweenTime = 0
	self._separateChars = Activity165Model.instance:setSeparateChars(self._reallyTxt)

	gohelper.setActive(self._goTxt.gameObject, false)
	self:playDecorateTexture(self.beginShowTxtCallback)
end

function Activity165StepItem:beginShowTxtCallback()
	local txtLen = #self._separateChars
	local time = txtLen * 0.033

	self._tweenId = ZProj.TweenHelper.DOTweenFloat(1, txtLen, time, self._onTweenFrameCallback, self._onTweenFinishCallback, self, nil, EaseType.Linear)

	gohelper.setActive(self._goTxt.gameObject, true)
	self:hideyDecorateTexture()
end

function Activity165StepItem:_onTweenFrameCallback(value)
	if self._finsihShowTxt or value - self._tweenTime < 1 then
		return
	end

	if value <= #self._separateChars then
		local index = math.floor(value)

		self._txtstory.text = self._separateChars[index]

		if self._scrollStory.verticalNormalizedPosition ~= 0 then
			self._scrollStory.verticalNormalizedPosition = 0
		end
	else
		self._txtstory.text = self._reallyTxt
	end

	self._tweenTime = value
end

function Activity165StepItem:_onTweenFinishCallback()
	if self._tweenId then
		ZProj.TweenHelper.KillById(self._tweenId)

		self._tweenId = nil
	end

	local preferredValues = self._txtstory:GetPreferredValues()

	recthelper.setHeight(self._txtstory.transform, preferredValues.y)
	self:_showStoryTxt()
	self:_markNote()
	self:_playMarkItemAnim()
end

function Activity165StepItem:isPlayingTxt()
	return self._tweenId ~= nil
end

function Activity165StepItem:_setStepText()
	if not self._stepMo then
		return
	end

	local content = self._stepMo.stepCo.text
	local findPattern = "<%d-:.->"
	local pattern = "<%d-:(.-)>"

	self:_setReallyStepText(content, findPattern, pattern)
end

function Activity165StepItem:_setReallyStepText(content, findPattern, pattern)
	local content, startIndex = self:_matchData(content, findPattern, pattern)

	if not startIndex then
		self._reallyTxt = content

		return
	end

	self:_getReallyStepText(content, findPattern, pattern)
end

function Activity165StepItem:_showStoryTxt()
	if string.nilorempty(self._reallyTxt) then
		self:_setStepText()
	end

	self._txtstory.text = self._reallyTxt

	local preferredValues = self._txtstory:GetPreferredValues()

	recthelper.setHeight(self._txtstory.transform, preferredValues.y)
end

function Activity165StepItem:finishStoryAnim()
	self:showStoryTxt()
	self:_hideEglocked()
	Activity165Controller.instance:dispatchEvent(Activity165Event.finishStepAnim, self._index)
end

function Activity165StepItem:showStoryTxt()
	self:killTween()
	self:_showStoryTxt()
	self:_markNote()

	self._finsihShowTxt = true

	for _, item in pairs(self._markItemList) do
		gohelper.setActive(item.go, true)
	end
end

function Activity165StepItem:_markNote()
	if not self._stepMo then
		return
	end

	local content = self._stepMo.stepCo.text
	local findPattern = "<%d-:.->"
	local pattern = "<%d-:(.-)>"

	self._markItemPos = {}

	self:_matchData(content, findPattern, pattern, nil, self._markData)
	self:_setMarkItemPos()

	self._curShowMarkIndex = 1
end

function Activity165StepItem:_matchData(content, findPattern, pattern, clueId, callback)
	local startIndex, endIndex = string.find(content, findPattern)

	if not startIndex then
		return content, startIndex, clueId
	end

	local clueId = string.match(content, "<(%d-):.->")

	clueId = tonumber(clueId)

	if not clueId then
		return
	end

	local fillContent = ""

	content = string.gsub(content, pattern, function(str)
		fillContent = str

		return str
	end, 1)

	if callback then
		callback(self, content, startIndex, clueId, fillContent)
	end

	return self:_matchData(content, findPattern, pattern, clueId, callback)
end

function Activity165StepItem:_markData(content, startIndex, clueId, fillContent)
	local preStr = string.sub(content, 1, startIndex - 1)
	local textInfo = self._txtstory:GetTextInfo(content)
	local preLen = GameUtil.utf8len(preStr)
	local endLen = GameUtil.utf8len(fillContent) + preLen - 1
	local characterInfo = textInfo.characterInfo[preLen]
	local endCharacterInfo = textInfo.characterInfo[endLen]
	local startBL = characterInfo.bottomLeft
	local endBL = endCharacterInfo.bottomRight
	local fontSize = self._txtstory.fontSize
	local txtWidth = self._txtstory.transform.rect.width
	local types = self:parseMark(clueId, 4)
	local lineCount = math.floor(math.abs(endBL.y - startBL.y) / fontSize)

	if lineCount > 0 then
		for i = 1, lineCount + 1 do
			if i == 1 then
				local mo = {}

				mo.types = types
				mo.posX = startBL.x
				mo.posY = startBL.y
				mo.width = txtWidth - startBL.x
				mo.fillContent = fillContent

				table.insert(self._markItemPos, mo)
			elseif i == lineCount + 1 then
				local mo = {}

				mo.types = types
				mo.posX = 0
				mo.posY = endBL.y
				mo.width = endBL.x
				mo.fillContent = fillContent

				table.insert(self._markItemPos, mo)
			else
				local mo = {}

				mo.types = types
				mo.posX = 0
				mo.posY = startBL.y - fontSize * i
				mo.width = txtWidth
				mo.fillContent = fillContent

				table.insert(self._markItemPos, mo)
			end
		end
	else
		local mo = {}

		mo.types = types
		mo.posX = startBL.x
		mo.posY = startBL.y
		mo.width = endBL.x - startBL.x
		mo.fillContent = fillContent

		table.insert(self._markItemPos, mo)
	end
end

function Activity165StepItem:getMarkItemByType(type, index)
	local item = self._typeMarkItemList[type][index]

	if not item then
		local go = gohelper.cloneInPlace(self._goMarkPrefabs[type])

		item = self:getUserDataTb_()
		item.go = go
		item.icon = gohelper.findChildImage(go, "mark")
		item.anim = SLFramework.AnimatorPlayer.Get(go.gameObject)
		self._typeMarkItemList[type][index] = item

		gohelper.setActive(item.go, false)
	end

	return item
end

function Activity165StepItem:_setMarkItemPos()
	self._markItemList = {}

	local preferredValues = self._txtstory:GetPreferredValues()
	local height = preferredValues.y

	for i, data in pairs(self._markItemPos) do
		for j, type in pairs(data.types) do
			local item = self:getMarkItemByType(type, i)

			item.go.name = data.fillContent .. "_" .. type .. "_" .. j .. "_" .. i

			table.insert(self._markItemList, item)

			local posY = data.posY

			if height < self._scrollTxtHeight then
				local offset = (self._scrollTxtHeight - height) * 0.5

				posY = data.posY - offset
			end

			recthelper.setAnchor(item.go.transform, data.posX, posY)

			if self._goMarkPrefabs[type] then
				if not self._goMarkPrefabs[type].transform.rect.width then
					local defaultWidth = 100
					local width = math.max(data.width, defaultWidth)

					recthelper.setWidth(item.icon.transform, width)
				end
			end
		end
	end
end

function Activity165StepItem:_playMarkItemAnim()
	if self._curShowMarkIndex > #self._markItemList then
		return self:finishStoryAnim()
	end

	local item = self._markItemList[self._curShowMarkIndex]

	if not item or not item.go then
		return self:finishStoryAnim()
	end

	gohelper.setActive(item.go, true)

	self._curShowMarkIndex = self._curShowMarkIndex + 1

	item.anim:Play(Activity165Enum.EditViewAnim.Open, self._playMarkItemAnim, self)
end

function Activity165StepItem:parseMark(num, max)
	local list = {}
	local temp = num

	for i = max, 1, -1 do
		local power = 2^i

		if power <= temp then
			table.insert(list, i)

			temp = temp - power

			if temp == 0 then
				break
			end
		end
	end

	return list
end

function Activity165StepItem:_hideAllMark()
	for _, item in pairs(self._markItemList) do
		gohelper.setActive(item.go, false)
	end

	self._markItemList = {}
end

function Activity165StepItem:killTween()
	if self._tweenId then
		ZProj.TweenHelper.KillById(self._tweenId)

		self._tweenId = nil
	end

	if self._markTweenId then
		ZProj.TweenHelper.KillById(self._markTweenId)

		self._markTweenId = nil
	end

	TaskDispatcher.cancelTask(self._playMarkItemAnim, self)
end

return Activity165StepItem
