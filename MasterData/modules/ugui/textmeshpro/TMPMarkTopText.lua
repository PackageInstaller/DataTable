-- chunkname: @modules/ugui/textmeshpro/TMPMarkTopText.lua

module("modules.ugui.textmeshpro.TMPMarkTopText", package.seeall)

local TMPMarkTopText = class("TMPMarkTopText", ListScrollCellExtend)

function TMPMarkTopText:init(go)
	local tmp = go:GetComponent(gohelper.Type_TextMesh)

	self:reInitByCmp(tmp)
end

function TMPMarkTopText:initByCmp(tmp)
	self:reInitByCmp(tmp)
end

function TMPMarkTopText:reInitByCmp(tmp)
	if self._txtcontentcn == tmp then
		return
	end

	self:onDestroyView()

	local go = tmp.gameObject

	self._markTopList = {}
	self._lineSpacing = 0
	self._txtcontentcn = tmp
	self._txtmarktopGo = IconMgr.instance:getCommonTextMarkTop(go)
	self._txtmarktop = self._txtmarktopGo:GetComponent(gohelper.Type_TextMesh)
	self._conMark = gohelper.onceAddComponent(go, typeof(ZProj.TMPMark))

	self._conMark:SetMarkTopGo(self._txtmarktopGo)

	self._originalLineSpacing = self._txtcontentcn.lineSpacing
	self._lineSpacing = self._originalLineSpacing

	TMPMarkTopText.super.init(self, go)
end

function TMPMarkTopText:setData(str)
	self._markTopList = StoryTool.getMarkTopTextList(str)

	self:_setLineSpacing(self:getLineSpacing())

	self._txtcontentcn.text = StoryTool.filterMarkTop(str)

	FrameTimerController.onDestroyViewMember(self, "_frameTimer")

	self._frameTimer = FrameTimerController.instance:register(self._onSetMarksTop, self)

	self._frameTimer:Start()
end

function TMPMarkTopText:_onSetMarksTop()
	self._conMark:SetMarksTop(self._markTopList)
	self:rebuildLayout()
end

function TMPMarkTopText:getLineSpacing()
	return (self:isContainsMarkTop() or nil) and (self._lineSpacing or self._originalLineSpacing)
end

function TMPMarkTopText:_setLineSpacing(lineSpacing)
	self._txtcontentcn.lineSpacing = lineSpacing or 0
end

function TMPMarkTopText:onDestroyView()
	FrameTimerController.onDestroyViewMember(self, "_frameTimer")
end

function TMPMarkTopText:onDestroy()
	self:onDestroyView()
end

function TMPMarkTopText:onUpdateMO(str)
	self:setData(str)
end

function TMPMarkTopText:isContainsMarkTop()
	return #self._markTopList > 0
end

function TMPMarkTopText:rebuildLayout()
	if not self._rbTrans then
		return
	end

	ZProj.UGUIHelper.RebuildLayout(self._rbTrans)
end

function TMPMarkTopText:setTopOffset(offsetX, offsetY)
	self._conMark:SetTopOffset(offsetX or 0, offsetY or 0)
end

function TMPMarkTopText:setLineSpacing(lineSpacing)
	self._lineSpacing = lineSpacing or 0
end

function TMPMarkTopText:setActive(isActive)
	gohelper.setActive(self.viewGO, isActive)
end

function TMPMarkTopText:registerRebuildLayout(trans)
	self._rbTrans = trans
end

return TMPMarkTopText
