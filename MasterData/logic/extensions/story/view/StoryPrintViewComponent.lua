-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/story/view/StoryPrintViewComponent.lua

module("logic.extensions.story.view.StoryPrintViewComponent", package.seeall)

local M = class("StoryPrintViewComponent", ViewComponent)

function M:buildUI()
	self._curDialogType = nil

	local tempDType = StoryConstDef.EStoryDialogUIStyleType

	self._goDialogRoot = self:getGo("story_main_view_-233468769")
	self._dialogMaskRoot = self:getGo("story_main_view_-1396634094")

	goutil.setActive(self._dialogMaskRoot, true)

	self._roleNamesText = {}
	self._roleNamesText[tempDType.Normal] = self:getText("story_main_view_492409072")
	self._roleNamesText[tempDType.Heart] = self:getText("story_main_view_787193464")
	self._roleNamesText[tempDType.Memory] = self:getText("story_main_view_-831151161")
	self._roleNamesText[tempDType.Narrator] = self:getText("story_main_view_391766560")
	self._roleNamesText[tempDType.Inspiration] = self:getText("story_main_view_-1467240246")
	self._roleNamesText[tempDType.HeadIcon] = self:getText("story_main_view_1801671486")
	self._roleNamesText[tempDType.Distance] = self:getText("story_main_view_-1841270014")
	self._dialogObjs = {}
	self._dialogObjs[tempDType.Normal] = self:getGo("story_main_view_-1168559709")
	self._dialogObjs[tempDType.Heart] = self:getGo("story_main_view_-1090068211")
	self._dialogObjs[tempDType.Memory] = self:getGo("story_main_view_1320265444")
	self._dialogObjs[tempDType.Narrator] = self:getGo("story_main_view_1432012496")
	self._dialogObjs[tempDType.Inspiration] = self:getGo("story_main_view_1783151135")
	self._dialogObjs[tempDType.HeadIcon] = self:getGo("story_main_view_-545542725")
	self._dialogObjs[tempDType.Distance] = self:getGo("story_main_view_1037532243")
	self._dialogObjs[tempDType.Subtitle3d] = self:getGo("story_main_view_202145661")
	self._dialogObjs[tempDType.Bubble] = self:getGo("story_main_view_156299194")
	self._dialogObjs[tempDType.Film] = self:getGo("story_main_view_-722628372")
	self._dialogMaskObjs = {}
	self._textTargets = {}
	self._textTargets[tempDType.Normal] = self:getUIComponent("story_main_view_2116305409", typeof(TMPro.TextMeshProUGUI))
	self._textTargets[tempDType.Heart] = self:getUIComponent("story_main_view_-887766021", typeof(TMPro.TextMeshProUGUI))
	self._textTargets[tempDType.Memory] = self:getUIComponent("story_main_view_-420866867", typeof(TMPro.TextMeshProUGUI))
	self._textTargets[tempDType.Narrator] = self:getUIComponent("story_main_view_-1994643372", typeof(TMPro.TextMeshProUGUI))
	self._textTargets[tempDType.Inspiration] = self:getUIComponent("story_main_view_-1182031903", typeof(TMPro.TextMeshProUGUI))
	self._textTargets[tempDType.HeadIcon] = self:getUIComponent("story_main_view_-838994433", typeof(TMPro.TextMeshProUGUI))
	self._textTargets[tempDType.Distance] = self:getUIComponent("story_main_view_-1329880534", typeof(TMPro.TextMeshProUGUI))
	self._textTargets[tempDType.Subtitle3d] = self:getUIComponent("story_main_view_1410250676", typeof(TMPro.TextMeshProUGUI))
	self._textTargets[tempDType.Bubble] = self:getUIComponent("story_main_view_-1086799070", typeof(TMPro.TextMeshProUGUI))
	self._textTargets[tempDType.Film] = self:getUIComponent("story_main_view_-1473525857", typeof(TMPro.TextMeshProUGUI))
	self._nextTips = {}
	self._nextTips[tempDType.Normal] = self:getGo("story_main_view_1672928380")
	self._nextTips[tempDType.Heart] = self:getGo("story_main_view_-1946321686")
	self._nextTips[tempDType.Memory] = self:getGo("story_main_view_-820613077")
	self._nextTips[tempDType.Narrator] = self:getGo("story_main_view_-1696641789")
	self._nextTips[tempDType.Inspiration] = self:getGo("story_main_view_-363697779")
	self._nextTips[tempDType.HeadIcon] = self:getGo("story_main_view_-1787683909")
	self._nextTips[tempDType.Distance] = self:getGo("story_main_view_-716215123")
	self._nextTips[tempDType.Subtitle3d] = self:getGo("story_main_view_1410250676")
	self._roleImgs = {}

	local _tempRtSt1 = {}

	_tempRtSt1.roleImg = self:getImage("story_main_view_-1137842428")
	self._roleImgs[tempDType.Distance] = _tempRtSt1
	self._distanceHeadIcom1 = self:getImage("story_main_view_-1137842428")
	self._distanceHeadIcom2 = self:getImage("story_main_view_-165013788")

	local _tempRtSt2 = {}

	_tempRtSt2.roleImg = self:getImage("story_main_view_-1597575425")
	self._roleImgs[tempDType.HeadIcon] = _tempRtSt2
	self._filmTopBg = goutil.findChild(self._dialogObjs[tempDType.Film], "dialogBg/top")
	self._filmBottomBg = goutil.findChild(self._dialogObjs[tempDType.Film], "dialogBg/bottom")
end

function M:onEnter()
	RectTransformUtils.SetAnchoredPosition(self._filmTopBg.transform, 0, 80)
	RectTransformUtils.SetAnchoredPosition(self._filmBottomBg.transform, 0, -80)
	StoryDispatcher:addEventListener(StoryNotifyName.UIDialogEnter, self.OnShowDialog, self)
	StoryDispatcher:addEventListener(StoryNotifyName.UIDialogPrint, self.OnPrintText, self)
	StoryDispatcher:addEventListener(StoryNotifyName.UIDialogExit, self.OnDialogExit, self)
	StoryDispatcher:addEventListener(StoryNotifyName.UIDilaogShowAll, self.OnShowAll, self)
	StoryDispatcher:addEventListener(StoryNotifyName.UIMultiDialogShow, self.OnUIMultiDialogShow, self)
	StoryDispatcher:addEventListener(StoryNotifyName.UIDialogVisibleSwitch, self.OnDialogVisibleSwitch, self)
	self:registerLocalNotify(StoryNotifyName.HideUIByManual, self._OnHideUIByManual, self)
	StoryDispatcher:addEventListener(StoryNotifyName.UIBranchEnter, self._onBranchUI, self)
	StoryDispatcher:addEventListener(StoryNotifyName.UIBranchExit, self._onCloseRadio, self)
	StoryDispatcher:addEventListener(StoryNotifyName.DoStoryFadeTween, self._onStartBlackTween, self)
end

function M:onExit()
	StoryDispatcher:removeEventListener(StoryNotifyName.UIDialogEnter, self.OnShowDialog, self)
	StoryDispatcher:removeEventListener(StoryNotifyName.UIDialogPrint, self.OnPrintText, self)
	StoryDispatcher:removeEventListener(StoryNotifyName.UIDialogExit, self.OnDialogExit, self)
	StoryDispatcher:removeEventListener(StoryNotifyName.UIDilaogShowAll, self.OnShowAll, self)
	StoryDispatcher:removeEventListener(StoryNotifyName.UIMultiDialogShow, self.OnUIMultiDialogShow, self)
	StoryDispatcher:removeEventListener(StoryNotifyName.UIDialogVisibleSwitch, self.OnDialogVisibleSwitch, self)
	self:unregisterLocalNotify(StoryNotifyName.HideUIByManual, self._OnHideUIByManual, self)
	StoryDispatcher:removeEventListener(StoryNotifyName.UIBranchEnter, self._onBranchUI, self)
	StoryDispatcher:removeEventListener(StoryNotifyName.UIBranchExit, self._onCloseRadio, self)
	StoryDispatcher:removeEventListener(StoryNotifyName.DoStoryFadeTween, self._onStartBlackTween, self)
end

function M:destroyUI()
	self:CloseAllHeadIcon()
	self:RemoveHead3DModelAndPtr(self.m_dialogData)

	self.m_dialogData = nil
	self._textTargets = nil
	self._nextTips = nil
	self._roleImgs = nil
	self._dialogObjs = nil
	self._roleNamesText = nil
	self._roleNamesBgObjs = nil
	self._lastDialogType = nil
	self._dialogMaskObjs = nil
end

function M:OnDialogVisibleSwitch(_, visible)
	if self._currentDialogState then
		if not visible and self.m_dialogData and self.m_dialogData.dialogType == StoryConstDef.EStoryDialogUIStyleType.Film and self._dialogObjs[StoryConstDef.EStoryDialogUIStyleType.Film].activeSelf then
			self:_playFilmAnima(false, self._onHideFileDialog, self, self.m_dialogData.dialogType)

			return
		end

		self:_switchDialogRootVisible(visible == true)
	end
end

function M:OnUIMultiDialogShow(_)
	self:RefreshDialogTypeVisible(StoryConstDef.EStoryDialogUIStyleType.MultiDialog)
end

function M:OnDialogExit(_)
	return
end

function M:OnShowAll(evt)
	self._isShowAll = true

	self:RefreshTextMaxVisibleCharacters(self.m_dialogData.dialogType, 1)
end

function M:OnPrintText(_, progress, maxPrintCount, dialogType)
	if not self.m_dialogData then
		return
	end

	if dialogType >= StoryConstDef.EStoryDialogUIStyleType.Extra and dialogType <= StoryConstDef.EStoryDialogUIStyleType.White then
		return
	end

	if self._isShowAll then
		return
	end

	self:RefreshTextMaxVisibleCharacters(dialogType, progress, maxPrintCount)
end

function M:OnShowDialog(_, data)
	self._isShowAll = false
	self.m_dialogData = data

	local _dialogType = data.dialogType

	if _dialogType >= StoryConstDef.EStoryDialogUIStyleType.Extra and _dialogType <= StoryConstDef.EStoryDialogUIStyleType.White then
		local isBlack = _dialogType == StoryConstDef.EStoryDialogUIStyleType.Black
		local isWhite = _dialogType == StoryConstDef.EStoryDialogUIStyleType.White

		if isBlack or isWhite then
			self:RefreshDialogMaskVisible(_dialogType)
		end

		return
	end

	self:RemoveHead3DModelAndPtr(self.m_dialogData)
	self:AddHead3DPtr(data)
	self:_switchDialogRootVisible(true)
	self:RefreshDialogTypeVisible(_dialogType)
	self:SetRoleName(data.dialogType, data.roleName)
	self:RefreshTextContent(_dialogType, data.content)
	self:RefreshTextMaxVisibleCharacters(_dialogType, 0)
	self:RefreshTNextTipsVisible(_dialogType, false)
	self:RefreshRoleHeadIcon()
	self:PlayViewAnimation(_dialogType)
	self:RefreshDialogMaskVisible(_dialogType)
	self:RefrshBubbleDialogInfo(data)
end

function M:PlayViewAnimation(etype)
	if etype == StoryConstDef.EStoryDialogUIStyleType.Film then
		self:_playFilmAnima(true)
	end
end

function M:_playFilmAnima(isOpen, callback, callbackHandler, dtype)
	self._filmTopBg.transform:DOKill(false)
	self._filmBottomBg.transform:DOKill(false)

	local animSpeed = 0.5

	if isOpen then
		self._filmTopBg.transform:DOAnchorPosY(0, animSpeed):SetAutoKill(true):OnComplete(function()
			if callback then
				callback(callbackHandler, dtype)
			end
		end, self)
		self._filmBottomBg.transform:DOAnchorPosY(0, animSpeed):SetAutoKill(true)
	else
		self._filmTopBg.transform:DOAnchorPosY(80, animSpeed):SetAutoKill(true):OnComplete(function()
			if callback then
				callback(callbackHandler, dtype)
			end
		end, self)
		self._filmBottomBg.transform:DOAnchorPosY(-80, animSpeed):SetAutoKill(true)
	end
end

function M:_playDialogTrack(guiAnimation, aniName, model, wrapModel)
	model = model or Astral.GUITimeLineMode.TimeToStart
	wrapModel = wrapModel or UnityEngine.Playables.DirectorWrapMode.None

	guiAnimation:PlayAniByName(aniName, model, wrapModel)
end

function M:RefreshRoleHeadIcon()
	self:CloseAllHeadIcon()

	local dtype = self.m_dialogData.dialogType
	local _headType = self.m_dialogData.headType

	if _headType == StoryConstDef.EStoryDialogHeadStyleType.Normal then
		local _headId = self.m_dialogData.headResId
		local _isEmptyHeadId = GameUtils.isEmptyString(_headId)

		if _isEmptyHeadId then
			print("剧情头像url为空=======", dtype, _headType, _headId)
		else
			self:_set2DHeadIcon(dtype, _headId)
		end
	end
end

function M:RemoveHead3DModelAndPtr(dialogData)
	return
end

function M:AddHead3DPtr(dialogData)
	return
end

function M:CloseAllHeadIcon()
	for _, v in pairs(self._roleImgs) do
		IconLoader.clearSprite(v.roleImg)
	end

	IconLoader.clearSprite(self._distanceHeadIcom1)
	IconLoader.clearSprite(self._distanceHeadIcom2)
end

function M:RefreshTNextTipsVisible(etype, hasNext)
	local tempGo = self._nextTips[etype]

	if tempGo then
		goutil.setActive(tempGo, hasNext)
	end
end

function M:RefreshTextMaxVisibleCharacters(etype, progress, tempMaxCount)
	local _targetText = self._textTargets[etype]

	if _targetText then
		goutil.setActive(_targetText.gameObject, false)

		local maxPrintCount = _targetText.textInfo.characterCount

		if progress >= 1 then
			self:RefreshTNextTipsVisible(self.m_dialogData.dialogType, self.m_dialogData.hasNextTips)
			goutil.setActive(_targetText.gameObject, true)
			_targetText:ForceMeshUpdate()

			maxPrintCount = _targetText.textInfo.characterCount

			local maxCount = tempMaxCount and tempMaxCount or 0

			_targetText.maxVisibleCharacters = maxPrintCount ~= 0 and maxPrintCount or maxCount
		else
			local tempCount = math.ceil(progress * maxPrintCount)

			_targetText.maxVisibleCharacters = tempCount
		end

		goutil.setActive(_targetText.gameObject, true)

		_targetText.text = StringUtil.replaceTMPBlackBlock(_targetText.text)
	end
end

function M:RefreshTextContent(etype, content)
	local _targetText = self._textTargets[etype]

	if _targetText then
		_targetText.text = content
	end
end

function M:SetRoleName(etype, name)
	local _targetText = self._roleNamesText[etype]

	if _targetText ~= nil then
		local _hasName = GameUtils.isEmptyString(name) == false

		if self._roleNamesBgObjs then
			local _roleNameBgObj = self._roleNamesBgObjs[self._curDialogType]

			if _roleNameBgObj ~= nil then
				goutil.setActive(_roleNameBgObj, _hasName)
			end
		end

		_targetText.text = name
	end
end

function M:RefreshDialogTypeVisible(dtype)
	if dtype == StoryConstDef.EStoryDialogUIStyleType.Subtitle3d then
		StoryFacde.instance:hideAll(StoryConst.DefaultStateKey)
	else
		StoryFacde.instance:showAll(StoryConst.DefaultStateKey)
	end

	for key, value in pairs(self._dialogObjs) do
		goutil.setActive(value, dtype == key)
	end
end

function M:_onHideFileDialog(dtype)
	self:_switchDialogRootVisible(false)
end

function M:RefreshDialogMaskVisible(dtype)
	for key, value in pairs(self._dialogMaskObjs) do
		goutil.setActive(value, dtype == key)
	end
end

function M:_switchDialogRootVisible(visible)
	self._currentDialogState = visible

	goutil.setActive(self._goDialogRoot, visible)
end

function M:_set2DHeadIcon(dtype, _headId)
	local headName = string.gsub(_headId, ".png", "")

	if dtype == StoryConstDef.EStoryDialogUIStyleType.Distance then
		local isBackImage = string.match(_headId, "_black")

		goutil.setActive(self._distanceHeadIcom1.gameObject, not isBackImage)
		goutil.setActive(self._distanceHeadIcom2.gameObject, isBackImage)
		IconLoader.setSprite(isBackImage and self._distanceHeadIcom2 or self._distanceHeadIcom1, IconType.RoleCard, headName)
	elseif dtype == StoryConstDef.EStoryDialogUIStyleType.HeadIcon then
		local _iconDt = self._roleImgs[dtype]

		if _iconDt then
			goutil.setActive(_iconDt.roleImg.gameObject, true)
			IconLoader.setSprite(_iconDt.roleImg, IconType.RoleCard, headName)
		end
	end
end

function M:_setModelRTHeadIcon(iconDt, head3DGo)
	if goutil.isNil(head3DGo) then
		return
	end

	goutil.setActive(iconDt.normalRTImgRootGo, true)
	goutil.setActive(iconDt.normalRTPhotoGo, true)
	iconDt.normalRTPhoto:turnOn()
	iconDt.normalRTPhoto:addGameobjectDirectlyPart(head3DGo)

	head3DGo.transform.localPosition = Vector3.New(0, -1.6, 1)
	head3DGo.transform.localRotation = Quaternion.Euler(Vector3.New(0, 180, 0))
end

function M:_setCommuRTHeadIcon(iconDt, head3DGo)
	if goutil.isNil(head3DGo) then
		return
	end

	goutil.setActive(iconDt.commuRTImgRootGo, true)
	goutil.setActive(iconDt.commuRTPhotoGo, true)
	iconDt.commuRTPhoto:turnOn()
	iconDt.commuRTPhoto:addGameobjectDirectlySmall(head3DGo)

	head3DGo.transform.localPosition = Vector3.New(0, -1.6, 1)
	head3DGo.transform.localRotation = Quaternion.Euler(Vector3.New(0, 180, 0))
end

function M:_refreshNextTipImgVisible(_hasNext)
	for _, value in pairs(self._nextTips) do
		goutil.setActive(value, _hasNext)
	end
end

function M:_OnHideUIByManual(evt, isHide)
	if isHide then
		for key, value in pairs(self._dialogObjs) do
			goutil.setActive(value, false)
		end
	else
		if not self.m_dialogData then
			return
		end

		local dialogType = self.m_dialogData.dialogType

		for key, value in pairs(self._dialogObjs) do
			goutil.setActive(value, dialogType == key)
		end
	end
end

function M:RefrshBubbleDialogInfo(data)
	if data.dialogType == StoryConstDef.EStoryDialogUIStyleType.Bubble then
		StoryDispatcher:dispatchEvent(StoryNotifyName.RogueDialog, data.roleUid)
	end
end

function M:_onBranchUI()
	if self.m_dialogData then
		self:RefreshTNextTipsVisible(self.m_dialogData.dialogType, false)
	end
end

function M:_onCloseRadio()
	if self.m_dialogData then
		self:RefreshTNextTipsVisible(self.m_dialogData.dialogType, self.m_dialogData.hasNextTips)
	end
end

function M:_onStartBlackTween(evt, params)
	local fadeType = params.fadeType

	if fadeType == StoryConstDef.EFadeType.EndStory then
		self:RefreshDialogMaskVisible(false)
	end
end

return M
