-- chunkname: @modules/ugui/textmeshpro/TMPFadeIn.lua

module("modules.ugui.textmeshpro.TMPFadeIn", package.seeall)

local TMPFadeIn = class("TMPFadeIn", LuaCompBase)
local EachCharacterDelay = 0.03

function TMPFadeIn:init(go)
	self._contentGO = go
	self._norDiaGO = gohelper.findChild(go, "go_normalcontent")
	self._txtcontentcn = gohelper.findChildText(self._norDiaGO, "txt_contentcn")
	self._conMat = self._txtcontentcn.fontMaterial

	local _shader = UnityEngine.Shader

	self._LineMinYId = _shader.PropertyToID("_LineMinY")
	self._LineMaxYId = _shader.PropertyToID("_LineMaxY")
end

function TMPFadeIn:hideDialog()
	if self._conTweenId then
		ZProj.TweenHelper.KillById(self._conTweenId)

		self._conTweenId = nil
	end

	gohelper.setActive(self._norDiaGO, false)

	local x, y, z = transformhelper.getLocalPos(self._txtcontentcn.transform)

	transformhelper.setLocalPos(self._txtcontentcn.transform, x, y, 1)
end

function TMPFadeIn:playNormalText(txt, callback, callbackobj)
	self._conMat:EnableKeyword("_GRADUAL_ON")

	local height = UnityEngine.Screen.height

	self._conMat:SetFloat(self._LineMinYId, height)
	self._conMat:SetFloat(self._LineMaxYId, height)
	gohelper.setActive(self._norDiaGO, true)

	self._txt = txt
	self._finishCallback = callback
	self._finishCallbackObj = callbackobj

	local x, y, z = transformhelper.getLocalPos(self._txtcontentcn.transform)

	transformhelper.setLocalPos(self._txtcontentcn.transform, x, y, 1)

	self._txtcontentcn.text = self._txt

	TaskDispatcher.runDelay(self._delayShow, self, 0)
end

function TMPFadeIn:_delayShow()
	local uiCamera = CameraMgr.instance:getUICamera()
	local textInfo = self._txtcontentcn:GetTextInfo(self._txt)

	self._textInfo = textInfo
	self._lineInfoList = {}

	local totalVisibleCharacterCount = 0
	local contentTransform = self._txtcontentcn.transform

	for i = 1, textInfo.lineCount do
		local lineInfo = textInfo.lineInfo[i - 1]
		local prevLineTotalCount = totalVisibleCharacterCount + 1

		totalVisibleCharacterCount = totalVisibleCharacterCount + lineInfo.visibleCharacterCount

		local characterInfo = self._textInfo.characterInfo
		local firstChar = characterInfo[lineInfo.firstVisibleCharacterIndex]
		local lastChar = characterInfo[lineInfo.lastVisibleCharacterIndex]
		local firstBL = uiCamera:WorldToScreenPoint(contentTransform:TransformPoint(firstChar.bottomLeft))
		local firstTL = uiCamera:WorldToScreenPoint(contentTransform:TransformPoint(firstChar.topLeft))
		local minbly = firstBL.y
		local maxtly = firstTL.y

		for index = lineInfo.firstVisibleCharacterIndex, lineInfo.lastVisibleCharacterIndex do
			local char = characterInfo[index]
			local bl = uiCamera:WorldToScreenPoint(contentTransform:TransformPoint(char.bottomLeft))

			if minbly > bl.y then
				minbly = bl.y
			end

			local tl = uiCamera:WorldToScreenPoint(contentTransform:TransformPoint(char.topLeft))

			if maxtly < tl.y then
				maxtly = tl.y
			end
		end

		firstBL.y = minbly
		firstTL.y = maxtly

		local lastBR = uiCamera:WorldToScreenPoint(contentTransform:TransformPoint(lastChar.bottomRight))

		table.insert(self._lineInfoList, {
			lineInfo,
			prevLineTotalCount,
			totalVisibleCharacterCount,
			firstBL,
			firstTL,
			lastBR
		})
	end

	self._contentX, self._contentY, _ = transformhelper.getLocalPos(self._txtcontentcn.transform)
	self._curLine = nil

	local delay = EachCharacterDelay * totalVisibleCharacterCount

	if self._conTweenId then
		ZProj.TweenHelper.KillById(self._conTweenId)

		self._conTweenId = nil
	end

	self._conTweenId = ZProj.TweenHelper.DOTweenFloat(1, totalVisibleCharacterCount, delay, self._conUpdate, self.conFinished, self)
end

function TMPFadeIn:_conUpdate(value)
	local screenWidth = UnityEngine.Screen.width

	for i, v in ipairs(self._lineInfoList) do
		local startCount = v[2]
		local endCount = v[3]

		if startCount <= value and value <= endCount and startCount ~= endCount then
			local firstBL = v[4]
			local firstTL = v[5]
			local lastBR = v[6]

			if self._curLine ~= i then
				self._curLine = i

				self._conMat:SetFloat(self._LineMinYId, firstBL.y)
				self._conMat:SetFloat(self._LineMaxYId, firstTL.y)

				local go = self._txtcontentcn.gameObject

				gohelper.setActive(go, false)
				gohelper.setActive(go, true)
			end

			local rate = (value - startCount) / (endCount - startCount)
			local screenPosX = Mathf.Lerp(firstBL.x, lastBR.x, rate)

			transformhelper.setLocalPos(self._txtcontentcn.transform, self._contentX, self._contentY, 1 - screenPosX / screenWidth)
		end
	end
end

function TMPFadeIn:isPlaying()
	return not not self._conTweenId
end

function TMPFadeIn:conFinished()
	if self._conTweenId then
		ZProj.TweenHelper.KillById(self._conTweenId)

		self._conTweenId = nil
	end

	self:_disable_GRADUAL_ON()

	local x, y, z = transformhelper.getLocalPos(self._txtcontentcn.transform)

	transformhelper.setLocalPos(self._txtcontentcn.transform, x, y, 0)

	if self._finishCallback then
		self._finishCallback(self._finishCallbackObj)
	end
end

function TMPFadeIn:_disable_GRADUAL_ON()
	local csArray = self._txtcontentcn.gameObject:GetComponentsInChildren(gohelper.Type_TMP_SubMeshUI, true)

	if csArray then
		local n = csArray.Length

		for i = 0, n - 1 do
			local tmpSubMeshUICmp = csArray[i]
			local material = tmpSubMeshUICmp.sharedMaterial

			if not gohelper.isNil(material) then
				material:DisableKeyword("_GRADUAL_ON")
				material:SetFloat(self._LineMinYId, 0)
				material:SetFloat(self._LineMaxYId, 0)
			end
		end
	end

	self._conMat:DisableKeyword("_GRADUAL_ON")
	self._conMat:SetFloat(self._LineMinYId, 0)
	self._conMat:SetFloat(self._LineMaxYId, 0)
end

function TMPFadeIn:onDestroy()
	self:onDestroyView()
end

function TMPFadeIn:onDestroyView()
	TaskDispatcher.cancelTask(self._delayShow, self)
	GameUtil.onDestroyViewMember_TweenId(self, "_conTweenId")
end

return TMPFadeIn
