-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/guide/view/ImageGuideView.lua

module("logic.extensions.guide.view.ImageGuideView", package.seeall)

local ImageGuideView = class("ImageGuideView", ViewComponent)
local type = {
	text = 1,
	video = 6,
	img = 2,
	interact = 3,
	ppt = 4,
	singleStep = 5
}

function ImageGuideView:buildUI()
	self._btnClose = self:getBtn("imageguideview_copy_678884780")
	self._btnTextClose = self:getBtn("3&universal_second_tips_common_bg_1201003252")
	self._videoClose = Astral.UIClickTrigger.Get(self:getGo("imageguideview_copy_1683318416"))
	self._btnExit = self:getBtn("3&universal_second_tips_common_bg_-1467035629")
	self.go_detailItem = self:getGo("imageguideview_copy_81345777")
	self.tr_parent = self:getRectTransform("imageguideview_copy_828264324")
	self._btns = self:getGo("imageguideview_copy_-1609025357")
	self._interactPanel = self:getGo("imageguideview_copy_-42414370")
	self._pptPanel = self:getGo("imageguideview_copy_-1885463606")
	self._imgScrollRect = self:getUIComponent("imageguideview_copy_477459672", UIComponentType.ScrollRect)
	self._loopListHelper = LoopListHelper.New(self._imgScrollRect)

	self._loopListHelper:AddEndDragListener(self._endDrag, self)
	self._loopListHelper:AddSnapNearestChangedListener(self._snapNearestChanged, self)
	self._loopListHelper:InitListView(0, self._updateImageGuide, self)
	self._loopListHelper:SetSnapVecThreshold(99999)

	self._typeGo = {
		self:getGo("imageguideview_copy_-1570229296"),
		self:getGo("imageguideview_copy_-1124094933"),
		self:getGo("imageguideview_copy_-1174429780"),
		self:getGo("imageguideview_copy_-1354326982"),
		self:getGo("imageguideview_copy_742162551")
	}
	self._btnLeft = self:getBtn("imageguideview_copy_-1154705026")
	self._btnRight = self:getBtn("imageguideview_copy_443214607")
	self._dotParentGO = self:getGo("imageguideview_copy_-1924247883")
	self._dotGOList = {
		self:getGo("imageguideview_copy_1412230810"),
		self:getGo("imageguideview_copy_-1576767470"),
		self:getGo("imageguideview_copy_1584357995"),
		self:getGo("imageguideview_copy_142750872"),
		self:getGo("imageguideview_copy_-968305576"),
		self:getGo("imageguideview_copy_-1213559816"),
		self:getGo("imageguideview_copy_1450779628"),
		self:getGo("imageguideview_copy_-1179082603"),
		self:getGo("imageguideview_copy_1250638811"),
		self:getGo("imageguideview_copy_366964539")
	}
end

function ImageGuideView:bindEvents()
	self._btnClose:AddClickListener(self._onClickClose, self)
	self._btnLeft:AddClickListener(self._clickTurnLeft, self)
	self._btnRight:AddClickListener(self._clickTurnRight, self)
	self._btnTextClose:AddClickListener(self._onClickClose, self)
	self._btnExit:AddClickListener(self._onClickClose, self)
	self._videoClose:AddClickListener(self._onClickClose, self)
	GlobalDispatcher:addEventListener(EventType.GET_GUIDE_TEXT, self._getText, self)
end

function ImageGuideView:unbindEvents()
	GlobalDispatcher:removeEventListener(EventType.GET_GUIDE_TEXT, self._getText, self)
	self._btnClose:RemoveClickListener()
	self._btnLeft:RemoveClickListener()
	self._btnRight:RemoveClickListener()
	self._btnTextClose:RemoveClickListener()
	self._btnExit:RemoveClickListener()
	self._videoClose:RemoveClickListener()

	if self._mask then
		self._mask:RemoveClickListener()
	end

	if self._activates then
		for i, v in ipairs(self._activates) do
			self._activates[i]:RemoveClickListener()
			self._nonactivates[i]:RemoveClickListener()
		end
	end
end

function ImageGuideView:_getText(evt, text, id)
	if id == GameEnum.DescriptionEnum.GuideFullScreen then
		self._guideText = text

		self:_textProcess(text)
	elseif id == GameEnum.DescriptionEnum.GuideFullScreenStep then
		self._stepDesc[self._stepDescPos] = text
		self._stepDescPos = self._stepDescPos + 1

		self:_refreshText()
	end
end

function ImageGuideView:destroyUI()
	self._btnClose = nil

	self._loopListHelper:Dispose()

	self._loopListHelper = nil
	self._btnLeft = nil
	self._btnRight = nil

	table.clear(self._dotGOList)

	if self._resLoader then
		self._resLoader:clear()
	end
end

function ImageGuideView:onExitFinished()
	if self._imgDi then
		self._imgDi:ClearImage()
	end
end

function ImageGuideView:_getStepDesc(code)
	self._stepDesc = {}
	self._stepDescPos = 1

	for _, list in pairs(self._guideStepList) do
		local t = string.match(list.id, code, 1)

		if t then
			TextDetectAgent.instance:sendCheckDescriptionRequest(GameEnum.DescriptionEnum.GuideFullScreenStep, tostring(list.id))
		end
	end
end

function ImageGuideView:getParams(id)
	local res = {}

	if self._stepDescPos then
		self._stepDescPos = 1
	end

	for _, list in pairs(self._guideList) do
		if tonumber(id) == list.id then
			if list.type == type.text then
				return list.param, list.type
			else
				res = string.split(list.param, ",")

				return res, list.type
			end
		end
	end
end

function ImageGuideView:_initDots()
	local maxDots = #self._dotGOList
	local maxImg = table.nums(self._stepConfig)

	if maxDots < maxImg then
		local offset = maxImg - maxDots

		for i = 1, offset do
			local obj = Astral.GameObjectUtil.CloneAndSetParent(self._dotGOList[1], self._dotParentGO.transform, nil)

			table.insert(self._dotGOList, obj)
		end
	end

	self._dotElemList = {}

	for i = 1, maxDots do
		goutil.setActive(self._dotGOList[i], i <= maxImg)

		local active = goutil.findChild(self._dotGOList[i], "active")
		local deactive = goutil.findChild(self._dotGOList[i], "deactive")
		local dotElem = {
			go = self._dotGOList[i],
			active = active,
			deactive = deactive
		}

		table.insert(self._dotElemList, dotElem)
	end

	self:_UpdateDots()
end

function ImageGuideView:onEnter()
	self._blackMask = ModalMask.addBlackMask(self.mainGO)
	self._guideList = GuideConfig.instance:getGuideFullScreenList()
	self._guideStepList = GuideConfig.instance:getGuideFullScreenStepList()

	goutil.setActive(self._dotParentGO, false)
	goutil.setActive(self._btnLeft.gameObject, false)
	goutil.setActive(self._btnRight.gameObject, false)

	local openParamArr = self:getOpenParam()

	self._resLoader = SingleResLoader.New()

	if openParamArr then
		local openparam = openParamArr[1]
		local id = openparam[1]
		local res, paramType = false, false

		if id ~= 0 then
			res, paramType = self:getParams(id)
		else
			paramType = openparam[2]
			res = openparam[3]
		end

		self._type = paramType

		if paramType == type.img then
			self._imgNames = res

			self:_imgProcess()
		elseif paramType == type.text then
			if id > 0 then
				TextDetectAgent.instance:sendCheckDescriptionRequest(GameEnum.DescriptionEnum.GuideFullScreen, tostring(id))
			end

			self:_textProcess(res)
		elseif paramType == type.interact then
			self._imgUrl = res[1]

			local prefabName = res[2]

			self._tipsText = {}

			self:_getStepDesc(id)
			self._resLoader:load(GameUrl.getGuideType3Path(prefabName), self._onResType3Loaded, self)
			self:_interactProcess()
		elseif paramType == type.ppt then
			self._imgUrl = res[1]

			local prefabName = res[2]

			self._stepText = false

			self:_getStepDesc(id)
			self:_pptProcess()
			self._resLoader:load(GameUrl.getGuideType4Path(prefabName), function()
				return self:_onResType4Loaded(false)
			end, self)
		elseif paramType == type.singleStep then
			local prefabName = res[1]
			local configName = res[2]

			self._stepText = false

			self:_getStepDesc(id)
			self:_pptProcess()
			self._resLoader:load(GameUrl.getGuideType5Path(prefabName), function()
				return self:_onResType5Loaded(configName)
			end, self)
		elseif paramType == type.video then
			local videoName = res[1]
			local isLoop = res[2] == "1"
			local tips = res[3] or ""

			self:_videoProcess(videoName, isLoop, tips)
		end
	end

	goutil.setActive(self._btnClose.gameObject, true)
end

function ImageGuideView:_onResType5Loaded(configName)
	local path = "logic.config.guide_config." .. configName

	self._stepConfig = require(path)
	self._pptIndex = 0
	self._goInst = self._resLoader:getResInstance()

	goutil.addChildToParent(self._goInst, self._pptPanel)

	self._stepText = goutil.findChildComponent(self._goInst, "txtTips", UIComponentType.TextMeshProUGUI)
	self._imgDi = UIComponentType.ImageBigBG(goutil.findChild(self._goInst, "step/imgDi").gameObject)
	self._pptMask = Astral.UIClickTrigger.Get(goutil.findChild(self._goInst, "fullscreenmask"))

	self._pptMask:AddClickListener(function()
		self:_initRefresh(1)
	end, self)

	self._step = goutil.findChild(self._goInst, "step")
	self._stepContent = goutil.findChild(self._goInst, "step/guide_type5_mask")
	self._ui = goutil.findChild(self._goInst, "step/guide_type5_mask/ui")
	self._imgKuang = goutil.findChild(self._goInst, "step/guide_type5_mask/imgKuang")
	self._stepMask = goutil.findChild(self._goInst, "step/guide_type5_mask/mask")
	self._rightHint = goutil.findChild(self._goInst, "step/right_hint")
	self._leftHint = goutil.findChild(self._goInst, "step/left_hint")
	self._tempGo = {}

	self:_initDots()
	self:_initRefresh(1)
end

function ImageGuideView:_initRefresh(index)
	self._pptIndex = self._pptIndex + index

	if self._pptIndex > table.nums(self._stepConfig) then
		self:_onClickClose()

		return
	end

	if self._pptIndex == table.nums(self._stepConfig) then
		-- block empty
	end

	for i, v in pairs(self._tempGo) do
		goutil.destroy(v)
	end

	goutil.setActive(self._imgKuang, false)
	goutil.setActive(self._ui, false)
	self:_UpdateDots()
	settimer(0, self._refreshStep, self, false)
end

function ImageGuideView:_refreshStep()
	goutil.setActive(self._step, true)

	local pos = "step" .. self._pptIndex

	self._stepText.text = self._stepConfig[pos].tips
	self._stepText.text = self:_replaceText(self._stepText.text)

	local imgUrl = self._stepConfig[pos].img

	self._imgDi:SetImage(GameUrl.getGuideImgPath(imgUrl), nil, self)

	local kuang = self._stepConfig[pos].imgKuang

	if kuang and #kuang > 0 then
		goutil.setActive(self._imgKuang, true)
		goutil.setActive(self._ui, true)

		for i = 2, #kuang do
			local tempk = goutil.cloneAndSetParent(self._imgKuang, self._stepContent.transform)

			tempk.transform:SetAsLastSibling()

			local tempui = goutil.cloneAndSetParent(self._ui, self._stepContent.transform)

			tempui.transform:SetAsFirstSibling()
			table.insert(self._tempGo, tempk)
			table.insert(self._tempGo, tempui)
		end

		for i = 1, #kuang do
			local tempui = self._stepContent.transform:GetChild(i - 1)
			local tempk = self._stepContent.transform:GetChild(i + #kuang)
			local kuangpos = kuang[i]

			Astral.TransformUtil.SetLocalPos(tempk, kuangpos[1], kuangpos[2], kuangpos[3])
			RectTransformUtils.SetSize(tempk, kuangpos[4], kuangpos[5])
			Astral.TransformUtil.SetLocalPos(tempui, kuangpos[1], kuangpos[2], kuangpos[3])
			RectTransformUtils.SetSize(tempui, kuangpos[4] - 15, kuangpos[5] - 17)
		end
	end

	goutil.setActive(self._stepMask, self._stepConfig[pos].mask)

	local left = self._stepConfig[pos].leftHint
	local right = self._stepConfig[pos].rightHint
	local tempr = self._step.transform:GetChild(2)
	local templ = self._step.transform:GetChild(3)

	self:_refreshHint(templ, left)
	self:_refreshHint(tempr, right)

	for i = 2, #left do
		local temph = goutil.cloneAndSetParent(self._leftHint, self._step.transform)
		local temppos = self._stepConfig[pos].leftHint[i]

		Astral.TransformUtil.SetLocalPos(temph.transform, temppos[1], temppos[2], temppos[3])

		local tempTxtHint = goutil.findChildTextComponent(temph, "txtHint")

		tempTxtHint.text = temppos[4]
		tempTxtHint.text = self:_replaceText(tempTxtHint.text)

		table.insert(self._tempGo, temph)
	end

	for i = 2, #right do
		local temph = goutil.cloneAndSetParent(self._rightHint, self._step.transform)
		local temppos = self._stepConfig[pos].rightHint[i]

		Astral.TransformUtil.SetLocalPos(temph.transform, temppos[1], temppos[2], temppos[3])

		local tempTxtHint = goutil.findChildTextComponent(temph, "txtHint")

		tempTxtHint.text = temppos[4]
		tempTxtHint.text = self:_replaceText(tempTxtHint.text)

		table.insert(self._tempGo, temph)
	end
end

function ImageGuideView:_refreshHint(hint, hintConf)
	if #hintConf > 0 then
		local temppos = hintConf[1]

		Astral.TransformUtil.SetLocalPos(hint, temppos[1], temppos[2], temppos[3])

		local tempTxtHint = goutil.findChildTextComponent(hint, "txtHint")

		tempTxtHint.text = temppos[4]

		goutil.setActive(hint.gameObject, true)
	else
		goutil.setActive(hint.gameObject, false)
	end
end

function ImageGuideView:_onResType4Loaded(isSingle)
	self._goInst = self._resLoader:getResInstance()

	goutil.addChildToParent(self._goInst, self._pptPanel)

	local imgDi = UIComponentType.ImageBigBG(goutil.findChild(self._goInst, "imgDi").gameObject)

	imgDi:SetImage(GameUrl.getGuideImgPath(self._imgUrl), nil, self)

	self._pptMask = Astral.UIClickTrigger.Get(goutil.findChild(self._goInst, "fullscreenmask"))

	self._pptMask:AddClickListener(function()
		self:_onClickPPTMask(isSingle)
	end)

	self._steps = {}

	for i = 1, math.huge do
		local step = goutil.findChild(self._goInst, "step" .. i)

		if not step then
			break
		end

		self._stepText = goutil.findChildTextComponent(self._goInst, "txtTips")
		self._stepText.text = self._stepDesc[1]

		table.insert(self._steps, step)
	end

	goutil.setActive(self._steps[1].gameObject, true)
end

function ImageGuideView:_onResType3Loaded()
	self._goInst = self._resLoader:getResInstance()

	goutil.addChildToParent(self._goInst, self._interactPanel)

	local imgDi = UIComponentType.ImageBigBG(goutil.findChild(self._goInst, "imgDi").gameObject)

	imgDi:SetImage(GameUrl.getGuideImgPath(self._imgUrl), nil, self)

	self._mask = Astral.UIClickTrigger.Get(goutil.findChild(self._goInst, "fullscreenmask"))

	self._mask:AddClickListener(self._onClickInteractMask, self)

	self._tips = {}
	self._activates = {}
	self._nonactivates = {}

	for i = 1, math.huge do
		local tip = goutil.findChild(self._goInst, "descTips_" .. i)

		if not tip then
			return
		end

		local tipText = goutil.findChildTextComponent(tip, "txtDesc")

		tipText.text = self._stepDesc[i]

		local activate = Astral.UIClickTrigger.Get(goutil.findChild(self._goInst, "activate_" .. i))
		local nonactivate = Astral.UIClickTrigger.Get(goutil.findChild(self._goInst, "nonactivate_" .. i))

		activate:AddClickListener(function()
			return self:_onClickInteract(i)
		end, self)
		nonactivate:AddClickListener(function()
			return self:_onClickInteract(i)
		end, self)
		table.insert(self._tips, tip)
		table.insert(self._tipsText, tipText)
		table.insert(self._activates, activate)
		table.insert(self._nonactivates, nonactivate)
	end
end

function ImageGuideView:_onClickInteractMask()
	goutil.setActive(self._tips[self._interactIndex], false)
	goutil.setActive(self._mask.gameObject, false)
end

function ImageGuideView:_onClickInteract(index)
	goutil.setActive(self._activates[index].gameObject, false)
	goutil.setActive(self._nonactivates[index].gameObject, true)
	goutil.setActive(self._tips[index], true)
	goutil.setActive(self._mask.gameObject, true)

	self._interactIndex = index
end

function ImageGuideView:_imgProcess()
	for i = 1, #self._typeGo do
		goutil.setActive(self._typeGo[i], i == 2)
	end

	goutil.setActive(self._btns, true)

	local maxCount = self._imgNames and #self._imgNames or 0

	self._mPageCount = maxCount

	self._loopListHelper:SetListItemCount(maxCount, true)
	self:_setBtnState(0)

	if self._loopListHelper:GetListItemCount() == 1 then
		self._imgScrollRect.horizontal = false
	else
		self._imgScrollRect.horizontal = true
	end
end

function ImageGuideView:_videoProcess(videoName, isLoop, tips)
	for i = 1, #self._typeGo do
		goutil.setActive(self._typeGo[i], i == 5)
	end

	goutil.setActive(self._btns, false)

	if not self._videoMgr then
		local videoGo = self:getGo("imageguideview_copy_-69611282")

		self._videoMgr = CriWareVideoMgr.Get(videoGo)
		self._txtVideo = self:getUIComponent("imageguideview_copy_-404114003", UIComponentType.TextMeshProUGUI)
	end

	local fullVideoPath = GameUrl.getVideoUrl(videoName)

	self:_setBtnCloseVisible(true)
	self._videoMgr:PlayMovie(fullVideoPath, true, isLoop)
	removetimer(self._setVideoLoop, self)

	if isLoop then
		settimer(0.1, self._setVideoLoop, self, false)
	end

	self._videoMgr:SetVolume(0, true)

	self._txtVideo.text = self:_replaceText(tips)
end

function ImageGuideView:_setVideoLoop()
	if self._videoMgr then
		self._videoMgr:SetLoop(true)
	end
end

function ImageGuideView:_textProcess(input)
	for i = 1, #self._typeGo do
		goutil.setActive(self._typeGo[i], i == 1)
	end

	goutil.setActive(self._btns, false)

	if self._guideText then
		input = self._guideText
	end

	self:_updatePanel(input)
end

function ImageGuideView:_updatePanel(input)
	local titleList, contentList = StringUtil.splitTitleAndContent(input)

	if not titleList or not contentList then
		return
	end

	local itemCount = math.max(#titleList, #contentList)
	local roleChildCount = self.tr_parent.childCount

	if roleChildCount < itemCount then
		for i = roleChildCount + 1, itemCount do
			goutil.cloneAndSetParent(self.go_detailItem, self.tr_parent)
		end
	end

	for i = 1, self.tr_parent.childCount do
		local child = self.tr_parent:GetChild(i - 1)

		if i <= itemCount then
			goutil.setActive(child.gameObject, true)
			self:_updateTextItem(child.gameObject, titleList[i], contentList[i])
		else
			goutil.setActive(child.gameObject, false)
		end
	end
end

function ImageGuideView:_updateTextItem(itemGo, title, content)
	local txt_title = goutil.findChildTextComponent(itemGo, "imgTitle/txtTitle")
	local txt_content = goutil.findChildComponent(itemGo, "txtContent", UIComponentType.TextMeshProUGUI)
	local titleGo = goutil.findChild(itemGo, "imgTitle")

	if not title then
		goutil.setActive(titleGo, false)
	elseif txt_title then
		goutil.setActive(titleGo, true)

		txt_title.text = self:_replaceText(title)
	end

	if txt_content then
		txt_content.text = self:_replaceText(content)
	end
end

function ImageGuideView:_interactProcess()
	for i = 1, #self._typeGo do
		goutil.setActive(self._typeGo[i], i == 3)
	end

	self._interactIndex = 1

	self:_setBtnCloseVisible(true)
end

function ImageGuideView:_pptProcess()
	for i = 1, #self._typeGo do
		goutil.setActive(self._typeGo[i], i == 4)
	end

	self._pptIndex = 1

	if self._type == type.singleStep then
		goutil.setActive(self._btns, true)
		goutil.setActive(self._dotParentGO, true)
	else
		self:_setBtnCloseVisible(false)
	end
end

function ImageGuideView:_refreshText()
	if self._typeGo[3].activeSelf then
		if self._tipsText[self._interactIndex] then
			for i, v in pairs(self._tipsText) do
				self._tipsText[i].text = self._stepDesc[i]
			end
		end
	elseif self._typeGo[4].activeSelf and self._stepText then
		self._stepText.text = self._stepDesc[self._pptIndex]
	end
end

function ImageGuideView:_onClickPPTMask(isSingle)
	self._pptIndex = self._pptIndex + 1

	if self._pptIndex > #self._stepDesc then
		self:_onClickClose()

		return
	end

	goutil.setActive(self._steps[self._pptIndex], true)
	goutil.setActive(self._steps[self._pptIndex - 1], not isSingle)

	self._stepText.text = self._stepDesc[self._pptIndex]

	if self._pptIndex == #self._stepDesc then
		-- block empty
	end
end

function ImageGuideView:_clickTurnLeft()
	self:_turnPage(false)
end

function ImageGuideView:_clickTurnRight()
	self:_turnPage(true)
end

function ImageGuideView:_turnPage(isRight)
	if self._type == type.img then
		local curNearestItemIndex = self._loopListHelper:getCurSnapNearestItemIndex()

		if curNearestItemIndex < 0 or curNearestItemIndex >= self._mPageCount then
			return
		end

		local index = curNearestItemIndex

		if isRight then
			index = curNearestItemIndex + 1
		else
			index = curNearestItemIndex - 1
		end

		self._loopListHelper:SetSnapTargetItemIndex(index)
		self:_setBtnState(index)
	elseif self._type == type.singleStep then
		local index = isRight and 1 or -1

		self:_UpdateDots()
		self:_initRefresh(index)
	end
end

function ImageGuideView:_setBtnState()
	local index = self._loopListHelper:getCurSnapNearestItemIndex()

	goutil.setActive(self._btnLeft.gameObject, true)
	goutil.setActive(self._btnRight.gameObject, true)

	if index == 0 then
		goutil.setActive(self._btnLeft.gameObject, false)
	end

	if index == self._mPageCount - 1 then
		goutil.setActive(self._btnRight.gameObject, false)
	end
end

function ImageGuideView:_UpdateDots()
	local maxNum = table.nums(self._stepConfig)

	goutil.setActive(self._btnLeft.gameObject, true)
	goutil.setActive(self._btnRight.gameObject, true)

	if self._pptIndex == 1 then
		goutil.setActive(self._btnLeft.gameObject, false)
	end

	if self._pptIndex == maxNum then
		goutil.setActive(self._btnRight.gameObject, false)
	end

	local count = self._dotElemList and #self._dotElemList or 0

	for i = 1, count do
		local elem = self._dotElemList[i]

		if i ~= self._pptIndex then
			goutil.setActive(elem.active, false)
			goutil.setActive(elem.deactive, true)
		else
			goutil.setActive(elem.active, true)
			goutil.setActive(elem.deactive, false)
		end
	end
end

function ImageGuideView:_setBtnCloseVisible(visible)
	goutil.setActive(self._btns, true)
	goutil.setActive(self._btnLeft.gameObject, false)
	goutil.setActive(self._btnRight.gameObject, false)
end

function ImageGuideView:onExit()
	removetimer(self._setVideoLoop, self)
	self._loopListHelper:ClearCells()

	if self._pptMask then
		self._pptMask:RemoveClickListener()

		self._pptMask = nil
	end

	goutil.clearChildren(self._pptPanel)
	goutil.clearChildren(self._interactPanel)
	ModalMask.releaseMask(self._blackMask)

	if self._videoMgr then
		self._videoMgr:StopMovie()
	end
end

function ImageGuideView:_updateImageGuide(curIndex)
	if curIndex < 0 then
		return
	end

	curIndex = curIndex + 1

	local item = self._loopListHelper:NewListViewItem("imageguidecell")
	local imageList = self._imgNames
	local imageName = imageList[curIndex]
	local shower = Astral.LuaComponentContainer.Add(item.gameObject, ImageGuideItem)

	shower:setCellData(imageName)

	return item
end

function ImageGuideView:_endDrag()
	local vec = self._loopListHelper:getScrollRect().velocity.x
	local curNearestItemIndex = self._loopListHelper:getCurSnapNearestItemIndex()

	if Mathf.Abs(vec) < 20 then
		self:_setBtnState(curNearestItemIndex)
		self._loopListHelper:SetSnapTargetItemIndex(curNearestItemIndex)

		return
	end

	if vec > 0 then
		self:_turnPage(false)
	else
		self:_turnPage(true)
	end
end

function ImageGuideView:_snapNearestChanged(listive, item)
	local curNearestItemIndex = self._loopListHelper:getCurSnapNearestItemIndex()

	if curNearestItemIndex < 0 or curNearestItemIndex >= self._mPageCount then
		return
	end

	self:_setBtnState(curNearestItemIndex)
end

function ImageGuideView:_onClickClose()
	self:close()
	GlobalDispatcher:dispatchEvent(EventType.CLOSE_IMAGE_GUIDE_VIEW)
end

function ImageGuideView:_replaceText(text)
	if not text then
		return ""
	end

	text = StringUtil.replaceAllRed(text)
	text = string.gsub(text, "*(.-)*", "<color=#d4692d><size=20>%1</size></color>")
	text = string.gsub(text, "%%%%", "&@&")
	text = string.gsub(text, "%%(.-)%%", "<color=#9f9f9f>%1</color>")
	text = string.gsub(text, "&@&", "%%")

	return text
end

return ImageGuideView
