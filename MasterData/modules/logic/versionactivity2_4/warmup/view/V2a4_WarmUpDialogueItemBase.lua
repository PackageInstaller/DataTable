-- chunkname: @modules/logic/versionactivity2_4/warmup/view/V2a4_WarmUpDialogueItemBase.lua

module("modules.logic.versionactivity2_4.warmup.view.V2a4_WarmUpDialogueItemBase", package.seeall)

local V2a4_WarmUpDialogueItemBase = class("V2a4_WarmUpDialogueItemBase", RougeSimpleItemBase)
local kType_TMPMark = typeof(ZProj.TMPMark)

function V2a4_WarmUpDialogueItemBase:ctor(...)
	self:__onInit()
	V2a4_WarmUpDialogueItemBase.super.ctor(self, ...)

	self.__txtCmpList = self:getUserDataTb_()
	self.__txtmarktopList = self:getUserDataTb_()
	self.__txtmarktopGoList = self:getUserDataTb_()
	self.__txtConMarkList = self:getUserDataTb_()
	self.__txtmarktopIndex = 0
	self.__fTimerList = {}
	self.__lineSpacing = {}
	self.__originalLineSpacing = {}
	self.__markTopListList = {}
	self._isFlushed = false
	self._isReadyStepEnd = false
	self._isGrayscaled = false
end

function V2a4_WarmUpDialogueItemBase:setTopOffset(index, offsetX, offsetY)
	local txtConMark = self.__txtConMarkList[index]

	if not txtConMark then
		return
	end

	txtConMark:SetTopOffset(offsetX or 0, offsetY or 0)
end

function V2a4_WarmUpDialogueItemBase:createMarktopCmp(textCmp)
	local index = self.__txtmarktopIndex + 1

	self.__txtmarktopIndex = index

	local textGo = textCmp.gameObject
	local txtmarktopGo = IconMgr.instance:getCommonTextMarkTop(textGo)
	local txtmarktop = txtmarktopGo:GetComponent(gohelper.Type_TextMesh)
	local txtConMark = gohelper.onceAddComponent(textGo, kType_TMPMark)

	self.__txtCmpList[index] = textCmp
	self.__txtmarktopGoList[index] = txtmarktopGo
	self.__txtmarktopList[index] = txtmarktop
	self.__txtConMarkList[index] = txtConMark
	self.__originalLineSpacing[index] = textCmp.lineSpacing

	txtConMark:SetMarkTopGo(txtmarktopGo)

	return index
end

function V2a4_WarmUpDialogueItemBase:setTextWithMarktopByIndex(index, str)
	self.__markTopListList[index] = StoryTool.getMarkTopTextList(str)

	self:_setText(index, StoryTool.filterMarkTop(str))
	self:_unregftimer(index)

	local fTimer = FrameTimerController.instance:register(function()
		local txtmarktop = self.__txtmarktopList[index]
		local txtmarktopGo = self.__txtmarktopGoList[index]
		local txtConMark = self.__txtConMarkList[index]
		local markTopList = self.__markTopListList[index]

		if markTopList and txtmarktop and txtConMark and not gohelper.isNil(txtmarktopGo) then
			txtConMark:SetMarksTop(markTopList)
		end
	end, nil, 1)

	self.__fTimerList[index] = fTimer

	fTimer:Start()
end

function V2a4_WarmUpDialogueItemBase:_setText(index, str)
	local textCmp = self.__txtCmpList[index]

	if not textCmp then
		return
	end

	textCmp.lineSpacing = self:getLineSpacing(index)
	textCmp.text = str
end

function V2a4_WarmUpDialogueItemBase:setLineSpacing(index, lineSpacing)
	self.__lineSpacing[index] = lineSpacing or 0
end

function V2a4_WarmUpDialogueItemBase:getLineSpacing(index)
	local markTopList = self.__markTopListList[index]
	local lineSpacing = self.__lineSpacing[index]
	local original = self.__originalLineSpacing[index]

	return markTopList and #markTopList > 0 and lineSpacing or original or 0
end

function V2a4_WarmUpDialogueItemBase:_unregftimer(index)
	local fTimer = self.__fTimerList[index]

	if not fTimer then
		return
	end

	FrameTimerController.instance:unregister(fTimer)

	self.__fTimerList[index] = nil
end

function V2a4_WarmUpDialogueItemBase:onDestroyView()
	for index, _ in pairs(self.__fTimerList) do
		self:_unregftimer(index)
	end

	FrameTimerController.onDestroyViewMember(self, "__fTimerSetTxt")
	V2a4_WarmUpDialogueItemBase.super.onDestroyView(self)
	self:__onDispose()
end

function V2a4_WarmUpDialogueItemBase:isFlushed()
	return self._isFlushed
end

function V2a4_WarmUpDialogueItemBase:isReadyStepEnd()
	return self._isReadyStepEnd
end

function V2a4_WarmUpDialogueItemBase:waveMO()
	return self._mo.waveMO
end

function V2a4_WarmUpDialogueItemBase:roundMO()
	return self._mo.roundMO
end

function V2a4_WarmUpDialogueItemBase:dialogCO()
	return self._mo.dialogCO
end

function V2a4_WarmUpDialogueItemBase:addContentItem(curBgHeight)
	local p = self:parent()

	p:onAddContentItem(self, curBgHeight)
end

function V2a4_WarmUpDialogueItemBase:uiInfo()
	local p = self:parent()

	return p:uiInfo()
end

function V2a4_WarmUpDialogueItemBase:stY()
	return self:uiInfo().stY or 0
end

function V2a4_WarmUpDialogueItemBase:getTemplateGo()
	assert(false, "please override this function")
end

function V2a4_WarmUpDialogueItemBase:onRefreshLineInfo()
	self:stepEnd()
end

function V2a4_WarmUpDialogueItemBase:onFlush()
	if self._isFlushed then
		return
	end

	self._isFlushed = true

	self:setActive_Txt(true)
end

function V2a4_WarmUpDialogueItemBase:stepEnd()
	local p = self:parent()

	p:onStepEnd(self:waveMO(), self:roundMO())
end

function V2a4_WarmUpDialogueItemBase:lineCount()
	local t = self._txtcontent:GetTextInfo(self._txtcontent.text)

	return t.lineCount
end

function V2a4_WarmUpDialogueItemBase:preferredWidthTxt()
	return self._txtcontent.preferredWidth
end

function V2a4_WarmUpDialogueItemBase:preferredHeightTxt()
	return self._txtcontent.preferredHeight
end

function V2a4_WarmUpDialogueItemBase:setActive_Txt(isActive)
	GameUtil.setActive01(self._txtTrans, isActive)
end

function V2a4_WarmUpDialogueItemBase:setActive_loading(isActive)
	gohelper.setActive(self._goloading, isActive)
end

function V2a4_WarmUpDialogueItemBase:setFontColor(hexColor)
	self._txtcontent.color = GameUtil.parseColor(hexColor)
end

function V2a4_WarmUpDialogueItemBase:grayscale(isGray, go1, go2, go3, go4)
	if self._isGrayscaled == isGray then
		return
	end

	self._isGrayscaled = true

	if go1 then
		self:setGrayscale(go1, isGray)
	end

	if go2 then
		self:setGrayscale(go2, isGray)
	end

	if go3 then
		self:setGrayscale(go3, isGray)
	end

	if go4 then
		self:setGrayscale(go4, isGray)
	end
end

function V2a4_WarmUpDialogueItemBase:refreshLineInfo()
	local textInfo = self._txtcontent:GetTextInfo(self._txtcontent.text)
	local lineCount = textInfo.lineCount

	self._lineCount = lineCount

	if lineCount > 0 then
		local lineInfo = textInfo.lineInfo[0]

		self._lineHeight = lineInfo.lineHeight
		self._lineWidth = lineInfo.width
	else
		self._lineHeight = recthelper.getHeight(self._txtTrans)
		self._lineWidth = self._txtcontent.preferredWidth
	end

	self._isReadyStepEnd = true

	self:onRefreshLineInfo()
end

function V2a4_WarmUpDialogueItemBase:setData(mo)
	V2a4_WarmUpDialogueItemBase.super.setData(self, mo)
	recthelper.setAnchorY(self:transform(), self:stY())
end

function V2a4_WarmUpDialogueItemBase:setText(str, isFlush)
	self._txtcontent.text = str
	self._isFlushed = isFlush

	self:setActive_Txt(false)
	FrameTimerController.onDestroyViewMember(self, "__fTimerSetTxt")

	self.__fTimerSetTxt = FrameTimerController.instance:register(function()
		if not gohelper.isNil(self._txtGo) then
			self:refreshLineInfo()

			if self._isFlushed then
				self:setActive_Txt(true)
			end
		end
	end, nil, 1)

	self.__fTimerSetTxt:Start()
end

return V2a4_WarmUpDialogueItemBase
