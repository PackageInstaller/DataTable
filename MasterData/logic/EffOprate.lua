-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/funcopen/operate/EffOprate.lua

module("logic.extensions.funcopen.operate.EffOprate", package.seeall)

local EffOprate = class("EffOprate", OprateBase)

function EffOprate:ctor(operateDat)
	EffOprate.super.ctor(self, operateDat)
end

function EffOprate:doOprate()
	TaskController.instance:pause()

	function oprateFinish()
		self:doOprateCallBack()
	end

	UIStateManager.instance:open("funcOpen", self._operateDat.funcId, oprateFinish)
end

function EffOprate:onFlyViewCallBack()
	local trs = self.widget.transform
	local count = trs.childCount

	for i = count, 1, -1 do
		local child = trs:GetChild(i - 1)

		child.gameObject:SetActive(true)
	end

	TaskController.instance:resume()
	UIStateManager.instance:pop()
	GuideController.instance:onDoGuide(GuideConst.BRANCH_Qilin)
	GlobalDispatcher:dispatch(GlobalNotify.PlayNewFuncAnimEnd)
end

function EffOprate:doOprateCallBack()
	self.widget = self:getWidget()

	self.widget.gameObject:SetActive(true)

	local function _onFlyViewCallBack()
		self:onFlyViewCallBack()
	end

	UIStateManager.instance:open("funcOpenFly", self.widget, _onFlyViewCallBack, self._operateDat.funcId)
end

return EffOprate
