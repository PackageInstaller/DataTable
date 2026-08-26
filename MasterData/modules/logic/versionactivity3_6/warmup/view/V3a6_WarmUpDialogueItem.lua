-- chunkname: @modules/logic/versionactivity3_6/warmup/view/V3a6_WarmUpDialogueItem.lua

module("modules.logic.versionactivity3_6.warmup.view.V3a6_WarmUpDialogueItem", package.seeall)

local V3a6_WarmUpDialogueItem = class("V3a6_WarmUpDialogueItem", RougeSimpleItemBase)
local ti = table.insert
local tm = table.remove
local sf = string.format
local string_sub = string.sub
local string_gsub = string.gsub
local string_find = string.find
local string_len = string.len
local kType_TMPMark = typeof(ZProj.TMPMark)
local csAnimatorPlayer = SLFramework.AnimatorPlayer
local csUGUIHelper = ZProj.UGUIHelper
local EState = {
	Flushed = 2,
	WaitingCutScene = 3,
	AllowFlush = 1,
	__End = 5,
	CutSceneDone = 4,
	None = 0
}

function V3a6_WarmUpDialogueItem:_setState(eUserState)
	self._eState = math.max(eUserState, self._eState or EState.None)
end

function V3a6_WarmUpDialogueItem:bAllowFlush()
	return self._eState >= EState.AllowFlush
end

function V3a6_WarmUpDialogueItem:bFlushed()
	return self._eState >= EState.Flushed
end

function V3a6_WarmUpDialogueItem:bWaitingCutScene()
	return self._eState >= EState.WaitingCutScene
end

function V3a6_WarmUpDialogueItem:bCutSceneDone()
	return self._eState >= EState.CutSceneDone
end

function V3a6_WarmUpDialogueItem:bCompleted()
	return self._eState >= EState.__End
end

function V3a6_WarmUpDialogueItem:ctor(...)
	self:__onInit()
	V3a6_WarmUpDialogueItem.super.ctor(self, ...)

	self._str = ""
	self._charList = {}
	self._charIndex = 1
	self._charCount = 0
	self._tagCount = 0
	self._tagStack = {}
	self._eState = EState.None
end

function V3a6_WarmUpDialogueItem:_editableInitView()
	V3a6_WarmUpDialogueItem.super._editableInitView(self)

	self._bgGo = gohelper.findChild(self.viewGO, "content_bg")
	self._txt = gohelper.findChildText(self._bgGo, "#txt_content")
	self._bgTrans = self._bgGo.transform
	self._txtGo = self._txt.gameObject
	self._txtTrans = self._txtGo.transform
	self._oriTxtWidth = recthelper.getWidth(self._txtTrans)
	self._oriTxtHeight = 39.76
	self._oriBgWidth = recthelper.getWidth(self._bgTrans)
	self._oriBgHeight = math.max(81.75, recthelper.getHeight(self:transform()))
	self._animPlayer = csAnimatorPlayer.Get(self.viewGO)
end

local function _getUCharArr(ucharStr)
	if string.nilorempty(ucharStr) then
		return {}
	end

	local list = {}
	local i = 1
	local len = #ucharStr

	local function _appendChar(char, advance)
		ti(list, char)

		i = i + (advance or 1)
	end

	while i <= len do
		local char = string_sub(ucharStr, i, i)

		if char == "<" then
			_appendChar(char)

			local tagEnd = string_find(ucharStr, ">", i)

			if tagEnd then
				_appendChar(string_sub(ucharStr, i, tagEnd))

				i = tagEnd + 1
			end
		else
			local charLen = LuaUtil.GetBytes(char)

			if charLen > 1 then
				char = string_sub(ucharStr, i, i + charLen - 1)
			end

			_appendChar(char, charLen)
		end
	end

	return list
end

function V3a6_WarmUpDialogueItem:setData(mo)
	V3a6_WarmUpDialogueItem.super.setData(self, mo)

	local dialogCO = mo
	local str = dialogCO.desc

	recthelper.setAnchorY(self:transform(), self:stY())

	if isDebugBuild then
		self:setName(tostring(dialogCO.id))
	end

	self._str = StoryTool.filterMarkTop(str) or ""

	if self:baseViewContainer():bFastForwarding() then
		self:_onFlushDone()
	else
		self:_doTyping()
	end
end

function V3a6_WarmUpDialogueItem:_doTyping()
	self._charList = _getUCharArr(self._str)
	self._charIndex = 1
	self._charCount = #self._charList
	self._tagCount = 0
	self._tagStack = {}

	self:_dummyItem():_calcTextInfo(self._str)
	self:_openAnim()
	self:_typing()
end

function V3a6_WarmUpDialogueItem:onFlush()
	if self:bFlushed() then
		return
	end

	self:_setState(EState.Flushed)

	if self:bAllowFlush() then
		self:_onFlushDone()
	end
end

function V3a6_WarmUpDialogueItem:_bTypedDone()
	return self._charIndex > self._charCount
end

local kTypingWidth = 30

function V3a6_WarmUpDialogueItem:_typing()
	FrameTimerController.onDestroyViewMember(self, "_fTimer")
	self:_setText(LuaUtil.emptyStr)
	self:_setActive_Txt(true)
	recthelper.setSize(self._bgTrans, kTypingWidth, self._oriBgHeight)
	self:addContentItem(self._oriBgHeight)

	self._fTimer = FrameTimerController.instance:register(self._showTypewriterText, self, 1, 199999)

	self._fTimer:Start()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_feichi_yure_caption_20200114)
end

function V3a6_WarmUpDialogueItem:_showTypewriterText()
	if self:_bTypedDone() then
		self:onFlush()

		return
	end

	if self:bAllowFlush() and self:bFlushed() then
		self:onFlush()

		return
	end

	local text = self:getTypewriterShowText()

	self:_setText(text)
	self:_onRefreshTextInfo()
	self:_onRefreshContentView()
end

function V3a6_WarmUpDialogueItem:hasCutScene()
	local dialogCO = self._mo

	return dialogCO.cutscene > 0
end

function V3a6_WarmUpDialogueItem:_onFlushDone()
	AudioMgr.instance:trigger(AudioEnum.UI.stop_ui_feichi_yure_caption_20200115)
	FrameTimerController.onDestroyViewMember(self, "_fTimer")

	if self:bCompleted() then
		return
	end

	if self:baseViewContainer():bFastForwarding() then
		self:_setState(EState.__End)
		self:_setText(self._str)
		self:_setActive_Txt(true)
		self:_onRefreshTextInfo()
		self:_onRefreshContentView()

		return
	end

	assert(self:bAllowFlush() == true, "undefinded behaviour")

	local dummyItem = self:_dummyItem()

	self._charIndex = self._charCount + 1
	self._curTxtWidth = dummyItem._curTxtWidth
	self._curTxtHeight = dummyItem._curTxtHeight
	self._curBgWidth = dummyItem._curBgWidth
	self._curBgHeight = dummyItem._curBgHeight

	self:_setText(self._str)
	self:_onRefreshContentView()

	if self:hasCutScene() then
		self:_waitingCutScene()
	else
		self:onStepEnd()
	end
end

function V3a6_WarmUpDialogueItem:_waitingCutScene()
	if self:bWaitingCutScene() then
		return
	end

	self:_setState(EState.WaitingCutScene)

	local p = self:parent()

	p:onWaitingCutScene(self)
end

function V3a6_WarmUpDialogueItem:doneCutSceen()
	if self:bCutSceneDone() then
		return
	end

	self:_setState(EState.CutSceneDone)

	local p = self:parent()

	p:onCloseCutScene(self)
end

function V3a6_WarmUpDialogueItem:onStepEnd()
	if self:bCompleted() then
		return
	end

	self:_setState(EState.__End)

	local p = self:parent()

	p:onStepEnd(self)
end

function V3a6_WarmUpDialogueItem:_onRefreshContentView()
	recthelper.setSize(self._txtTrans, self._curTxtWidth, self._curTxtHeight)
	recthelper.setSize(self._bgTrans, self._curBgWidth, self._curBgHeight)
	self:addContentItem(self._curBgHeight)
end

function V3a6_WarmUpDialogueItem:getTypewriterShowText()
	if self:_bTypedDone() then
		return self._str
	end

	local retText
	local index = self._charIndex
	local char = self._charList[index]
	local tagStackCount = #self._tagStack

	if string_sub(char, 1, 1) == "<" then
		if string_sub(char, 2, 2) ~= "/" then
			ti(self._tagStack, char)
		elseif tagStackCount > 0 then
			tm(self._tagStack)
		end
	else
		retText = self.curText

		if tagStackCount > 0 then
			if self._tagCount == tagStackCount then
				local ends = ""

				for j = tagStackCount, 1, -1 do
					local tag = self._tagStack[j]

					ends = ends .. string_gsub(tag, "<", "</")
				end

				local len = -string_len(ends) - 1

				retText = string_sub(retText, 1, len) .. char .. ends
			else
				for _, tag in ipairs(self._tagStack) do
					retText = retText .. tag
				end

				retText = retText .. char

				for j = tagStackCount, 1, -1 do
					local tag = self._tagStack[j]

					retText = retText .. string_gsub(tag, "<", "</")
				end
			end
		else
			retText = retText .. char
		end

		self._tagCount = tagStackCount
	end

	self._charIndex = self._charIndex + 1

	return retText
end

function V3a6_WarmUpDialogueItem:onDestroyView()
	FrameTimerController.onDestroyViewMember(self, "__fTimerSetTxt")
	FrameTimerController.onDestroyViewMember(self, "_fTimer")
	V3a6_WarmUpDialogueItem.super.onDestroyView(self)
	self:__onDispose()
end

function V3a6_WarmUpDialogueItem:addContentItem(curBgHeight)
	local p = self:parent()

	p:onAddContentItem(self, curBgHeight)
end

function V3a6_WarmUpDialogueItem:uiInfo()
	local p = self:parent()

	return p:uiInfo()
end

function V3a6_WarmUpDialogueItem:stY()
	return self:uiInfo().stY or 0
end

function V3a6_WarmUpDialogueItem:_dummyItem()
	local p = self:parent()

	return p._dummyItem
end

function V3a6_WarmUpDialogueItem:_setText(str)
	self.curText = str
	self._txt.text = str
end

function V3a6_WarmUpDialogueItem:_getTextCmp()
	return self._txt
end

function V3a6_WarmUpDialogueItem:_getTextTrans()
	return self._txtTrans
end

function V3a6_WarmUpDialogueItem:_onDummyItemCb()
	self:_setState(EState.AllowFlush)

	if self:bFlushed() then
		self:_onFlushDone()
	end
end

function V3a6_WarmUpDialogueItem:_preferredValue()
	csUGUIHelper.RebuildLayout(self._txtTrans)

	local v2 = self._txt:GetPreferredValues()

	return v2.x, v2.y
end

function V3a6_WarmUpDialogueItem:_calcTextInfo(str, optSenderItem)
	self:_setText(str or "")
	self:_setActive_Txt(false)
	FrameTimerController.onDestroyViewMember(self, "__fTimerSetTxt")

	self.__fTimerSetTxt = FrameTimerController.instance:register(function()
		if not gohelper.isNil(self._txtGo) then
			self:_onCalcTextInfo(str, optSenderItem)
		end
	end, self, 1)

	self.__fTimerSetTxt:Start()
end

function V3a6_WarmUpDialogueItem:_onCalcTextInfo(str, optSenderItem)
	local textInfo = self._txt:GetTextInfo(str)
	local lineCount = textInfo.lineCount

	self._lineCount = lineCount

	if lineCount > 0 then
		local lineInfo = textInfo.lineInfo[0]

		self._lineHeight = lineInfo.lineHeight
		self._lineWidth = lineInfo.width
	else
		local lineWidth = self:_preferredValue()

		self._lineHeight = recthelper.getHeight(self._txtTrans)
		self._lineWidth = lineWidth
	end

	self:_onRefreshTextInfo()

	if optSenderItem then
		optSenderItem:_onDummyItemCb()
	end
end

function V3a6_WarmUpDialogueItem:_onRefreshTextInfo()
	local curTxtWidth, curTxtHeight = self:_preferredValue()
	local curBgWidth = self._oriBgWidth
	local curBgHeight = self._oriBgHeight

	if curTxtWidth <= self._oriTxtWidth then
		curBgWidth = curBgWidth + (curTxtWidth - self._oriTxtWidth)
	else
		curTxtWidth = self._oriTxtWidth
		curBgHeight = curBgHeight + math.max(0, curTxtHeight - self._oriTxtHeight)
	end

	self._curTxtWidth = curTxtWidth
	self._curTxtHeight = curTxtHeight
	self._curBgWidth = curBgWidth
	self._curBgHeight = curBgHeight
end

function V3a6_WarmUpDialogueItem:_setActive_Txt(isActive)
	GameUtil.setActive01(self._txtTrans, isActive)
end

function V3a6_WarmUpDialogueItem:_openAnim(cb, cbObj)
	self._animPlayer:Play(UIAnimationName.Open, cb, cbObj)
end

function V3a6_WarmUpDialogueItem.s_state(eState)
	for k, v in pairs(EState) do
		if k == v then
			return k
		end
	end

	return "[V3a6_WarmUpDialogueItem - s_state] error !"
end

function V3a6_WarmUpDialogueItem:dump(refStrBuf, depth)
	depth = depth or 0

	local tab = string.rep("\t", depth)

	ti(refStrBuf, tab .. sf("name = %s", self:name()))
	ti(refStrBuf, tab .. sf("(%s/%s)%s", self._charIndex, self._charCount, self._str))
	ti(refStrBuf, tab .. sf("estate = %s", V3a6_WarmUpDialogueItem.s_state(self._eState)))
end

return V3a6_WarmUpDialogueItem
