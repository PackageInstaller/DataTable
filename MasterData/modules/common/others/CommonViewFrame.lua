-- chunkname: @modules/common/others/CommonViewFrame.lua

module("modules.common.others.CommonViewFrame", package.seeall)

local CommonViewFrame = class("CommonViewFrame", BaseView)
local Type_ViewFrame = typeof(ZProj.ViewFrame)

function CommonViewFrame:onInitView()
	self._viewFrame = self.viewGO:GetComponent(Type_ViewFrame) or self.viewGO:GetComponentInChildren(Type_ViewFrame, true)

	if self._viewFrame then
		self._viewFrame:SetLoadCallback(self._onFrameLoaded, self)
	else
		logError(self.viewName .. " 没有挂通用弹框底板脚本 ViewFrame.cs")
	end
end

function CommonViewFrame:_onFrameLoaded(viewFrame)
	local viewFrameGO = self._viewFrame.frameGO

	self._txtTitle = gohelper.findChildText(viewFrameGO, "txt/titlecn")

	if self._txtTitle and not string.nilorempty(self._viewFrame.cnTitle) then
		self._txtTitle.text = luaLang(self._viewFrame.cnTitle)
	end

	self._txtTitleEn = gohelper.findChildText(viewFrameGO, "txt/titlecn/titleen")

	if self._txtTitleEn then
		self._txtTitleEn.text = self._viewFrame.enTitle
	end

	self._btnclose = gohelper.findChildButtonWithAudio(viewFrameGO, "#btn_close")

	if self._btnclose then
		self._btnclose:AddClickListener(self._btncloseOnClick, self)
	end

	local clickMaskGO = gohelper.findChild(viewFrameGO, "Mask")

	if clickMaskGO then
		self._clickMask = SLFramework.UGUI.UIClickListener.Get(clickMaskGO)

		self._clickMask:AddClickListener(self._btncloseOnClick, self)
	end
end

function CommonViewFrame:_btncloseOnClick()
	self:closeThis()
end

function CommonViewFrame:onDestroyView()
	if self._btnclose then
		self._btnclose:RemoveClickListener()

		self._btnclose = nil
	end

	if self._clickMask then
		self._clickMask:RemoveClickListener()
	end
end

function CommonViewFrame:onClickModalMask()
	self:closeThis()
end

return CommonViewFrame
