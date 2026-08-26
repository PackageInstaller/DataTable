-- chunkname: @modules/logic/story/view/characterdialog/CharacterDialogComp.lua

module("modules.logic.story.view.characterdialog.CharacterDialogComp", package.seeall)

local CharacterDialogComp = class("CharacterDialogComp", BaseView)

function CharacterDialogComp:onInitView()
	self._goconversation = gohelper.findChild(self.viewGO, "#go_conversation")
	self._gohead = gohelper.findChild(self.viewGO, "#go_conversation/#go_head")
	self._goheadgrey = gohelper.findChild(self.viewGO, "#go_conversation/#go_head/#go_headgrey")
	self._simagehead = gohelper.findChildSingleImage(self.viewGO, "#go_conversation/#go_head/#simage_head")
	self._goname = gohelper.findChild(self.viewGO, "#go_conversation/#go_name")
	self._txtnamecn = gohelper.findChildText(self.viewGO, "#go_conversation/#go_name/namelayout/#txt_namecn")
	self._txtnameen = gohelper.findChildText(self.viewGO, "#go_conversation/#go_name/namelayout/#txt_nameen")
	self._gocontents = gohelper.findChild(self.viewGO, "#go_conversation/#go_contents")
	self._txtcontent = gohelper.findChildText(self.viewGO, "#go_conversation/#go_contents/go_normalcontent/Viewport/#txt_content")
	self._btncontent = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_content")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function CharacterDialogComp:addEvents()
	self._btncontent:AddClickListener(self._btncontentOnClick, self)
end

function CharacterDialogComp:removeEvents()
	self._btncontent:RemoveClickListener()
end

function CharacterDialogComp:_btncontentOnClick()
	if self._textShowFinished then
		self:_checkNextStep()
	else
		self:_onTextFinished()

		self._txtcontent.text = self._txt
	end
end

function CharacterDialogComp:_editableInitView()
	self:_showDialog(false)

	self._conMat = self._txtcontent.fontMaterial

	local _shader = UnityEngine.Shader

	self._LineMinYId = _shader.PropertyToID("_LineMinY")
	self._LineMaxYId = _shader.PropertyToID("_LineMaxY")

	self._txtcontent.fontSharedMaterial:DisableKeyword("UNDERLAY_ON")
	self._txtcontent.fontSharedMaterial:SetFloat("_BloomFactor", 0)
end

function CharacterDialogComp:onOpen()
	if self.viewContainer.initDialogFinish then
		self.viewContainer:initDialogFinish()
	end
end

function CharacterDialogComp:startDialog(groupId)
	V3a5PuzzleController.instance:dispatchEvent(V3a5PuzzleEvent.onStartDialog, groupId)
	self:_showDialog(true)

	self._groupId = groupId
	self._dialogGroupCos = V3a5PuzzleConfig.instance:getDialogGroupCos(groupId)

	if self._dialogGroupCos then
		self:_setDialog(1)
		self:_playGradualIn()
	end
end

function CharacterDialogComp:_setDialog(step)
	self._step = step
	self._dialogCo = self._dialogGroupCos[self._step]
	self._txt = self._dialogCo.text

	if self._playingId then
		AudioMgr.instance:stopPlayingID(self._playingId)
	end

	if self._dialogCo.voiceId ~= 0 then
		self._playingId = AudioMgr.instance:trigger(self._dialogCo.voiceId)
	end
end

function CharacterDialogComp:_playGradualIn()
	local height = UnityEngine.Screen.height

	self._conMat:EnableKeyword("_GRADUAL_ON")
	self._conMat:DisableKeyword("_DISSOLVE_ON")
	self._conMat:SetFloat(self._LineMinYId, height)
	self._conMat:SetFloat(self._LineMaxYId, height)

	self._subMeshs = {}

	local subMeshs = self._txtcontent.gameObject:GetComponentsInChildren(typeof(TMPro.TMP_SubMeshUI), true)

	if subMeshs then
		local iter = subMeshs:GetEnumerator()

		while iter:MoveNext() do
			local subMesh = iter.Current.gameObject:GetComponent(typeof(TMPro.TMP_SubMeshUI))

			table.insert(self._subMeshs, subMesh)
		end
	end

	for _, v in pairs(self._subMeshs) do
		if v.materialForRendering then
			v.materialForRendering:EnableKeyword("_GRADUAL_ON")
			v.materialForRendering:DisableKeyword("_DISSOLVE_ON")
			v.materialForRendering:SetFloat(self._LineMinYId, height)
			v.materialForRendering:SetFloat(self._LineMaxYId, height)
		end
	end

	local characterId = self._dialogCo.characterId
	local characterCo = V3a5PuzzleConfig.instance:getCharacterCo(characterId)

	if characterCo then
		local path = string.format("singlebg/headicon_small/%s.png", characterCo.profileId)

		self._simagehead:LoadImage(path)

		self._txtnamecn.text = characterCo.name
		self._txtnameen.text = characterCo.enName

		gohelper.setActive(self._simagehead.gameObject, true)
	else
		gohelper.setActive(self._simagehead.gameObject, false)

		self._txtnamecn.text = ""
		self._txtnameen.text = ""
	end

	self._textShowFinished = false

	local x, y, z = transformhelper.getLocalPos(self._txtcontent.transform)

	transformhelper.setLocalPos(self._txtcontent.transform, x, y, 1)

	if self._conTweenId then
		ZProj.TweenHelper.KillById(self._conTweenId)

		self._conTweenId = nil
	end

	TaskDispatcher.cancelTask(self._delayShow, self)
	TaskDispatcher.runDelay(self._delayShow, self, 0.05)
end

function CharacterDialogComp:_delayShow()
	self._textInfo = self._txtcontent:GetTextInfo(self._txt)
	self._lineInfoList = {}

	local totalVisibleCharacterCount = 0

	for i = 1, self._textInfo.lineCount do
		local lineInfo = self._textInfo.lineInfo[i - 1]
		local prevLineTotalCount = totalVisibleCharacterCount + 1

		totalVisibleCharacterCount = totalVisibleCharacterCount + lineInfo.visibleCharacterCount

		table.insert(self._lineInfoList, {
			lineInfo,
			prevLineTotalCount,
			totalVisibleCharacterCount
		})
	end

	self._contentX, self._contentY, _ = transformhelper.getLocalPos(self._txtcontent.transform)
	self._curLine = nil

	local delay = self:_getDelayTime(totalVisibleCharacterCount)

	if self._conTweenId then
		ZProj.TweenHelper.KillById(self._conTweenId)

		self._conTweenId = nil
	end

	self._conTweenId = ZProj.TweenHelper.DOTweenFloat(1, totalVisibleCharacterCount, delay, self._conUpdate, self._onTextFinished, self, nil, EaseType.Linear)
end

function CharacterDialogComp:_conUpdate(value)
	local screenWidth = UnityEngine.Screen.width
	local contentTransform = self._txtcontent.transform
	local uiCamera = CameraMgr.instance:getUICamera()

	self._subMeshs = {}

	local subMeshs = self._txtcontent.gameObject:GetComponentsInChildren(typeof(TMPro.TMP_SubMeshUI), true)

	if subMeshs then
		local iter = subMeshs:GetEnumerator()

		while iter:MoveNext() do
			local subMesh = iter.Current.gameObject:GetComponent(typeof(TMPro.TMP_SubMeshUI))

			table.insert(self._subMeshs, subMesh)
		end
	end

	for i, v in ipairs(self._lineInfoList) do
		local lineInfo = v[1]
		local startCount = v[2]
		local endCount = v[3]

		if startCount <= value and value <= endCount then
			local characterInfo = self._textInfo.characterInfo
			local firstChar = characterInfo[lineInfo.firstVisibleCharacterIndex]
			local lastChar = characterInfo[lineInfo.lastVisibleCharacterIndex]
			local firstBL = uiCamera:WorldToScreenPoint(contentTransform:TransformPoint(firstChar.bottomLeft))
			local maxBL = firstBL
			local minbly = firstBL.y

			for j = lineInfo.firstVisibleCharacterIndex, lineInfo.lastVisibleCharacterIndex do
				local char = characterInfo[j]
				local tl = uiCamera:WorldToScreenPoint(contentTransform:TransformPoint(char.bottomLeft))

				if minbly > tl.y then
					minbly = tl.y
				end
			end

			maxBL.y = minbly

			local firstTL = uiCamera:WorldToScreenPoint(contentTransform:TransformPoint(firstChar.topLeft))
			local maxTL = firstTL
			local maxtly = firstTL.y

			for j = lineInfo.firstVisibleCharacterIndex, lineInfo.lastVisibleCharacterIndex do
				local char = characterInfo[j]
				local tl = uiCamera:WorldToScreenPoint(contentTransform:TransformPoint(char.topLeft))

				if maxtly < tl.y then
					maxtly = tl.y
				end
			end

			maxTL.y = maxtly

			local lastBR = uiCamera:WorldToScreenPoint(contentTransform:TransformPoint(lastChar.bottomRight))

			if i == 1 then
				self._conMat:SetFloat(self._LineMinYId, maxBL.y)
				self._conMat:SetFloat(self._LineMaxYId, maxTL.y + 10)

				for _, mesh in pairs(self._subMeshs) do
					if mesh.materialForRendering then
						mesh.materialForRendering:SetFloat(self._LineMinYId, maxBL.y)
						mesh.materialForRendering:SetFloat(self._LineMaxYId, maxTL.y + 10)
					end
				end
			else
				self._conMat:SetFloat(self._LineMinYId, maxBL.y)
				self._conMat:SetFloat(self._LineMaxYId, maxTL.y)

				for _, mesh in pairs(self._subMeshs) do
					if mesh.materialForRendering then
						mesh.materialForRendering:SetFloat(self._LineMinYId, maxBL.y)
						mesh.materialForRendering:SetFloat(self._LineMaxYId, maxTL.y)
					end
				end
			end

			local go = self._txtcontent.gameObject

			gohelper.setActive(go, false)
			gohelper.setActive(go, true)

			local rate = startCount == endCount and 1 or (value - startCount) / (endCount - startCount)
			local screenPosX = Mathf.Lerp(maxBL.x - 10, lastBR.x + 10, rate)
			local posZ = 1 - screenPosX / screenWidth

			transformhelper.setLocalPos(self._txtcontent.transform, self._contentX, self._contentY, posZ)
		end
	end
end

function CharacterDialogComp:_onTextFinished()
	self:_clear()

	for _, v in pairs(self._subMeshs) do
		if v.materialForRendering then
			v.materialForRendering:DisableKeyword("_GRADUAL_ON")
		end
	end

	self._textShowFinished = true
end

function CharacterDialogComp:_showDialog(isShow)
	gohelper.setActive(self.viewGO, isShow)
end

function CharacterDialogComp:_checkNextStep()
	if self._dialogGroupCos[self._step + 1] then
		self:_setDialog(self._step + 1)
		self:_playGradualIn()
	else
		self:_showDialog(false)
		self.viewContainer:finishDialog(self._groupId)
		V3a5PuzzleController.instance:dispatchEvent(V3a5PuzzleEvent.onFinishDialog, self._groupId)
	end
end

function CharacterDialogComp:_getDelayTime(characterCount)
	local speed = 1

	if self._txt and string.find(self._txt, "<speed=%d[%d.]*>") then
		local speedTxt = string.sub(self._txt, string.find(self._txt, "<speed=%d[%d.]*>"))

		speed = speedTxt and tonumber(string.match(speedTxt, "%d[%d.]*")) or 1
	end

	local time = 0.08 * characterCount
	local curStoryIndex = GameLanguageMgr.instance:getLanguageTypeStoryIndex()

	if curStoryIndex == LanguageEnum.LanguageStoryType.EN then
		time = time * 0.67
	end

	time = time / speed

	return time
end

function CharacterDialogComp:_clear()
	if self._conTweenId then
		ZProj.TweenHelper.KillById(self._conTweenId)

		self._conTweenId = nil
	end

	self._conMat:DisableKeyword("_GRADUAL_ON")
end

function CharacterDialogComp:onClose()
	self:_clear()
	TaskDispatcher.cancelTask(self._delayShow, self)
end

function CharacterDialogComp:onDestroy()
	self:_clear()
	self._simagehead:UnLoadImage()
end

return CharacterDialogComp
