-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/xinshoutehui/view/XinShouTeHuiTabFrameView.lua

module("logic.extensions.xinshoutehui.view.XinShouTeHuiTabFrameView", package.seeall)

local XinShouTeHuiTabFrameView = class("XinShouTeHuiTabFrameView", TabFrameWorkMainView)

function XinShouTeHuiTabFrameView:buildUI()
	XinShouTeHuiTabFrameView.super.buildUI(self)

	self._openTime = goutil.findChild(self.mainGO, "openTime")
	self._txtOpenTime = goutil.findChildTextComponent(self.mainGO, "openTime/txt")
end

function XinShouTeHuiTabFrameView:bindEvents()
	XinShouTeHuiTabFrameView.super.bindEvents(self)
end

function XinShouTeHuiTabFrameView:unbindEvents()
	XinShouTeHuiTabFrameView.super.unbindEvents(self)
end

function XinShouTeHuiTabFrameView:onEnter()
	XinShouTeHuiTabFrameView.super.onEnter(self)
end

function XinShouTeHuiTabFrameView:_getFrameId()
	return 11
end

function XinShouTeHuiTabFrameView:_onSetUI()
	XinShouTeHuiTabFrameView.super._onSetUI(self)
end

function XinShouTeHuiTabFrameView:_updateHeadTabCell(mainGo, headTabIndex)
	XinShouTeHuiTabFrameView.super._updateHeadTabCell(self, mainGo, headTabIndex)

	local headInfo = self:_getHeadTabViewInfo(headTabIndex)
	local rec = goutil.findChild(mainGo, "rec")
	local txtRec = goutil.findChildTextComponent(mainGo, "rec/txt")
	local params = headInfo.data.exJsonTabParams

	if params then
		if not params.tabName then
			local tabName = ""

			if string.nilorempty(tabName) then
				GameUtil.SetActive(rec, false)
			else
				txtRec.text = params.tabName

				GameUtil.SetActive(rec, true)
				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(rec:GetComponent(goutil.Type_RectTransform))
			end
		end
	end
end

return XinShouTeHuiTabFrameView
