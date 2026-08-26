-- chunkname: @modules/logic/versionactivity1_9/fairyland/view/comp/FairyLandTextFade.lua

module("modules.logic.versionactivity1_9.fairyland.view.comp.FairyLandTextFade", package.seeall)

local FairyLandTextFade = class("FairyLandTextFade", LuaCompBase)

function FairyLandTextFade:init(go)
	self.transform = go.transform
	self.gameObject = go
	self.parent = self.transform.parent
	self.text = go:GetComponent(gohelper.Type_TextMesh)
	self.canvasGroup = gohelper.onceAddComponent(self.text.gameObject, typeof(UnityEngine.CanvasGroup))
end

function FairyLandTextFade:setScrollContent(scrollContent)
	self.scrollContent = scrollContent
end

function FairyLandTextFade:setText(param)
	self:killTween()

	self.layoutCallback = param.layoutCallback
	self.callback = param.callback
	self.callbackObj = param.callbackObj
	self.content = param.content
	self.text.text = self.content

	local textHeight = self.text.preferredHeight

	if self.layoutCallback then
		self.layoutCallback(self.callbackObj, textHeight)
	end

	if param.tween then
		self.canvasGroup.alpha = 0

		TaskDispatcher.runDelay(self._delayShow, self, 0.05)
	else
		self:onTextFinished()
	end
end

function FairyLandTextFade:_delayShow()
	self:initText()

	self.canvasGroup.alpha = 1
	self.tweenId = ZProj.TweenHelper.DOTweenFloat(1, self.characterCount, self.delayTime, self.frameCallback, self.onTextFinished, self, nil, EaseType.Linear)

	self:moveContent()
end

function FairyLandTextFade:moveContent()
	if gohelper.isNil(self.scrollContent) then
		return
	end

	local contentTransform = self.scrollContent.transform
	local scrollHeight = recthelper.getHeight(contentTransform.parent)
	local contentHeight = recthelper.getHeight(contentTransform)
	local maxPos = math.max(contentHeight - scrollHeight, 0)
	local txtPos = recthelper.getAnchorY(self.transform.parent)
	local txtHeight = recthelper.getHeight(self.transform.parent)
	local txtPosY = txtPos + txtHeight
	local caleMovePosY = math.max(maxPos, txtPosY - scrollHeight)

	self.moveId = ZProj.TweenHelper.DOAnchorPosY(contentTransform, caleMovePosY, self.delayTime * 0.8, nil, nil, nil, EaseType.Linear)
end

function FairyLandTextFade:_doCallback()
	local callback = self.callback
	local callbackObj = self.callbackObj

	self.callback = nil
	self.callbackObj = nil

	if callback then
		self.callback(callbackObj)
	end
end

function FairyLandTextFade:frameCallback(value)
	local screenWidth = UnityEngine.Screen.width
	local uiCamera = CameraMgr.instance:getUICamera()

	for i, v in ipairs(self.lineInfoList) do
		local lineInfo = v[1]
		local startCount = v[2]
		local endCount = v[3]

		if startCount <= value and value <= endCount then
			local characterInfo = self.textInfo.characterInfo
			local firstChar = characterInfo[lineInfo.firstVisibleCharacterIndex]
			local lastChar = characterInfo[lineInfo.lastVisibleCharacterIndex]
			local firstBL = uiCamera:WorldToScreenPoint(self.transform:TransformPoint(firstChar.bottomLeft))
			local maxBL = firstBL
			local minbly = firstBL.y

			for j = lineInfo.firstVisibleCharacterIndex, lineInfo.lastVisibleCharacterIndex do
				local char = characterInfo[j]
				local tl = uiCamera:WorldToScreenPoint(self.transform:TransformPoint(char.bottomLeft))

				if minbly > tl.y then
					minbly = tl.y
				end
			end

			maxBL.y = minbly

			local firstTL = uiCamera:WorldToScreenPoint(self.transform:TransformPoint(firstChar.topLeft))
			local maxTL = firstTL
			local maxtly = firstTL.y

			for j = lineInfo.firstVisibleCharacterIndex, lineInfo.lastVisibleCharacterIndex do
				local char = characterInfo[j]
				local tl = uiCamera:WorldToScreenPoint(self.transform:TransformPoint(char.topLeft))

				if maxtly < tl.y then
					maxtly = tl.y
				end
			end

			maxTL.y = maxtly

			local lastBR = uiCamera:WorldToScreenPoint(self.transform:TransformPoint(lastChar.bottomRight))

			if i == 1 then
				self._conMat:SetFloat(self._LineMinYId, maxBL.y)
				self._conMat:SetFloat(self._LineMaxYId, maxTL.y + 10)

				for _, mesh in pairs(self._subMeshs) do
					if mesh.materialForRendering then
						mesh.materialForRendering:SetFloat(self._LineMinYId, maxBL.y)
						mesh.materialForRendering:SetFloat(self._LineMaxYId, maxTL.y + 10)
						mesh.materialForRendering:EnableKeyword("_GRADUAL_ON")
					end
				end
			else
				self._conMat:SetFloat(self._LineMinYId, maxBL.y)
				self._conMat:SetFloat(self._LineMaxYId, maxTL.y)

				for _, mesh in pairs(self._subMeshs) do
					if mesh.materialForRendering then
						mesh.materialForRendering:SetFloat(self._LineMinYId, maxBL.y)
						mesh.materialForRendering:SetFloat(self._LineMaxYId, maxTL.y)
						mesh.materialForRendering:EnableKeyword("_GRADUAL_ON")
					end
				end
			end

			local go = self.gameObject

			gohelper.setActive(go, false)
			gohelper.setActive(go, true)

			local rate = startCount == endCount and 1 or (value - startCount) / (endCount - startCount)
			local screenPosX = Mathf.Lerp(maxBL.x - 10, lastBR.x + 10, rate)
			local posZ = 1 - screenPosX / screenWidth

			transformhelper.setLocalPos(self.transform, self._contentX, self._contentY, posZ)
		end
	end
end

function FairyLandTextFade:onTextFinished()
	self:killTween()

	self.canvasGroup.alpha = 1

	if self.characterCount then
		self:frameCallback(self.characterCount)
	end

	local x, y, z = transformhelper.getLocalPos(self.transform)

	transformhelper.setLocalPos(self.transform, x, y, 0)

	if self._conMat then
		self._conMat:DisableKeyword("_GRADUAL_ON")
	end

	if self._subMeshs then
		for _, v in pairs(self._subMeshs) do
			if v.materialForRendering then
				v.materialForRendering:DisableKeyword("_GRADUAL_ON")
			end
		end
	end

	self:_doCallback()
end

function FairyLandTextFade:initText()
	self._subMeshs = {}
	self._conMat = self.text.fontMaterial

	self._conMat:EnableKeyword("_GRADUAL_ON")
	self._conMat:DisableKeyword("_DISSOLVE_ON")

	local _shader = UnityEngine.Shader

	self._LineMinYId = _shader.PropertyToID("_LineMinY")
	self._LineMaxYId = _shader.PropertyToID("_LineMaxY")
	self._contentX, self._contentY, _ = transformhelper.getLocalPos(self.transform)

	local subMeshs = self.gameObject:GetComponentsInChildren(typeof(TMPro.TMP_SubMeshUI), true)

	if subMeshs then
		local iter = subMeshs:GetEnumerator()

		while iter:MoveNext() do
			local subMesh = iter.Current.gameObject:GetComponent(typeof(TMPro.TMP_SubMeshUI))

			table.insert(self._subMeshs, subMesh)
		end
	end

	self.textInfo = self.text:GetTextInfo(self.content)
	self.lineInfoList = {}

	local totalVisibleCharacterCount = 0

	for i = 1, self.textInfo.lineCount do
		local lineInfo = self.textInfo.lineInfo[i - 1]
		local prevLineTotalCount = totalVisibleCharacterCount + 1

		totalVisibleCharacterCount = totalVisibleCharacterCount + lineInfo.visibleCharacterCount

		table.insert(self.lineInfoList, {
			lineInfo,
			prevLineTotalCount,
			totalVisibleCharacterCount
		})
	end

	self.characterCount = totalVisibleCharacterCount
	self.delayTime = self:getDelayTime(totalVisibleCharacterCount)
end

function FairyLandTextFade:getDelayTime(characterCount)
	local speed = 4
	local time = 0.08 * characterCount

	time = time / speed

	return time
end

function FairyLandTextFade:killTween()
	if self.tweenId then
		ZProj.TweenHelper.KillById(self.tweenId)

		self.tweenId = nil
	end

	if self.moveId then
		ZProj.TweenHelper.KillById(self.moveId)

		self.moveId = nil
	end

	TaskDispatcher.cancelTask(self._delayShow, self)
end

function FairyLandTextFade:onDestroy()
	self:killTween()
end

return FairyLandTextFade
