-- chunkname: @modules/logic/guide/view/GuideViewMgr.lua

module("modules.logic.guide.view.GuideViewMgr", package.seeall)

local GuideViewMgr = class("GuideViewMgr")

function GuideViewMgr:open(guideId, stepId)
	self.guideId = guideId
	self.stepId = stepId
	self.viewParam = GuideViewParam.New()

	self.viewParam:setStep(self.guideId, self.stepId)

	if string.find(self.viewParam.goPath, "/MESSAGE") then
		ViewMgr.instance:openView(ViewName.GuideView2, self.viewParam, true)
	else
		ViewMgr.instance:openView(ViewName.GuideView, self.viewParam, true)
	end
end

function GuideViewMgr:close()
	self.viewParam = nil

	ViewMgr.instance:closeView(ViewName.GuideView, true)
	ViewMgr.instance:closeView(ViewName.GuideView2, true)
end

function GuideViewMgr:enableHoleClick()
	if self.viewParam then
		self.viewParam.enableHoleClick = true

		GuideController.instance:dispatchEvent(GuideEvent.UpdateMaskView)
	end
end

function GuideViewMgr:disableHoleClick()
	if self.viewParam then
		self.viewParam.enableHoleClick = false

		GuideController.instance:dispatchEvent(GuideEvent.UpdateMaskView)
	end
end

function GuideViewMgr:setHoleClickCallback(callback, callbackTarget)
	self._clickCallback = callback
	self._clickCallbackTarget = callbackTarget
end

function GuideViewMgr:enableClick(enable)
	if self.viewParam then
		self.viewParam.enableClick = enable

		GuideController.instance:dispatchEvent(GuideEvent.UpdateMaskView)
	end
end

function GuideViewMgr:enablePress(enable)
	if self.viewParam then
		self.viewParam.enablePress = enable

		GuideController.instance:dispatchEvent(GuideEvent.UpdateMaskView)
	end
end

function GuideViewMgr:enableDrag(enable)
	if self.viewParam then
		self.viewParam.enableDrag = enable

		GuideController.instance:dispatchEvent(GuideEvent.UpdateMaskView)
	end
end

function GuideViewMgr:setMaskAlpha(alpha)
	if self.viewParam then
		self.viewParam.maskAlpha = alpha

		GuideController.instance:dispatchEvent(GuideEvent.UpdateMaskView)
	end
end

function GuideViewMgr:enableSpaceBtn(enable)
	if self.viewParam then
		self.viewParam.enableSpaceBtn = enable
	end
end

function GuideViewMgr:onClickCallback(isInside)
	if self._clickCallback then
		if GuideController.EnableLog then
			local id = (self.guideId or "nil") .. "_" .. (self.stepId or "nil")

			logNormal("guidelog: " .. id .. " GuideViewMgr.onClickCallback inside " .. (isInside and "true" or "false") .. debug.traceback("", 2))
		end

		if self._clickCallbackTarget then
			self._clickCallback(self._clickCallbackTarget, isInside)
		else
			self._clickCallback(isInside)
		end
	elseif GuideController.EnableLog then
		local id = (self.guideId or "nil") .. "_" .. (self.stepId or "nil")

		logNormal("guidelog: " .. id .. "GuideViewMgr.onClickCallback callback not exist inside " .. (isInside and "true" or "false") .. debug.traceback("", 2))
	end
end

function GuideViewMgr:isGuidingGO(go)
	if ViewMgr.instance:isOpen(ViewName.GuideView) then
		local viewParam = GuideViewMgr.instance.viewParam
		local guideGOPath = viewParam and viewParam.goPath
		local guideGO = gohelper.find(guideGOPath)

		return guideGO == go
	end
end

GuideViewMgr.instance = GuideViewMgr.New()

return GuideViewMgr
