-- chunkname: @modules/logic/versionactivity3_0/karong/flow/KaRongPopViewStep.lua

module("modules.logic.versionactivity3_0.karong.flow.KaRongPopViewStep", package.seeall)

local KaRongPopViewStep = class("KaRongPopViewStep", BaseWork)

function KaRongPopViewStep:ctor(data)
	if not string.nilorempty(data.param) then
		local params = string.splitToNumber(data.param, "#")

		self.viewParam = params[1]
	end
end

function KaRongPopViewStep:onStart(context)
	ViewMgr.instance:registerCallback(ViewEvent.OnCloseViewFinish, self.onCloseViewFinish, self)

	if not self.viewParam then
		logError("请检查弹窗效果配置,参数格式错误")
		self:onDone(true)

		return
	end

	ViewMgr.instance:openView(ViewName.KaRongRoleTagView, self.viewParam)
end

function KaRongPopViewStep:onCloseViewFinish(viewName)
	if viewName == ViewName.KaRongRoleTagView then
		self:onDone(true)
	end
end

function KaRongPopViewStep:clearWork()
	self.viewParam = nil

	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseViewFinish, self.onCloseViewFinish, self)
end

return KaRongPopViewStep
