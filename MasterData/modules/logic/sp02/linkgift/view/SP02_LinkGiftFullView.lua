-- chunkname: @modules/logic/sp02/linkgift/view/SP02_LinkGiftFullView.lua

module("modules.logic.sp02.linkgift.view.SP02_LinkGiftFullView", package.seeall)

local SP02_LinkGiftFullView = class("SP02_LinkGiftFullView", SP02_LinkGiftBaseView)

function SP02_LinkGiftFullView:checkParam()
	SP02_LinkGiftFullView.super.checkParam(self)

	if self.viewParam.parent then
		gohelper.setParent(self.viewGO, self.viewParam.parent)
	end
end

return SP02_LinkGiftFullView
