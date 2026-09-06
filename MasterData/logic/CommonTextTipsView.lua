-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/common/instruction/view/CommonTextTipsView.lua

module("logic.extensions.common.instruction.view.CommonTextTipsView", package.seeall)

local CommonTextTipsView = class("CommonTextTipsView", TipsViewBase)

function CommonTextTipsView:ctor()
	CommonTextTipsView.super.ctor(self)
end

function CommonTextTipsView:buildUI()
	CommonTextTipsView.super.buildUI(self)

	self._Nego_Content = goutil.findChild(self.mainGO, "Nego_Content")
	self._adjustPosition = self._Nego_Content:GetComponent("UIAdjustPosition")
	self._customInput = UICustomInput.Get(self._Nego_Content)

	local _Nego_Bottom = goutil.findChild(self._Nego_Content, "Nego_Bottom")

	self._TxtC_Desc_1 = MaterialMgr.findGraphicText(_Nego_Bottom, "TxtC_Desc")
end

function CommonTextTipsView:destroyUI()
	CommonTextTipsView.super.destroyUI(self)
end

function CommonTextTipsView:bindEvents()
	self._customInput:AddListener(self._onCustomInputCallback, self)
end

function CommonTextTipsView:unbindEvents()
	self._customInput:RemoveListener()
end

function CommonTextTipsView:_onCustomInputCallback(hover)
	CommonTipsMgr.instance:doWillClose(self, hover)
end

function CommonTextTipsView:onEnter()
	CommonTextTipsView.super.onEnter(self)

	local data = self._viewPresentor._openParam[1]
	local pos = self._viewPresentor._openParam[2]

	if not self._viewPresentor._openParam[3] then
		local sizeDelta = {
			0,
			0
		}

		self:_SetDesc1(data)

		if pos then
			GameUtil.SetActive(self.mainGO, false)
			settimer(0.1, function()
				GameUtil.SetActive(self.mainGO, true)
				Framework.TransformUtil.SetLocalScale(self.mainGO.transform, 1, 1, 1)
				self._adjustPosition:AdjustScreenPosition(pos, sizeDelta[1], sizeDelta[2])
			end, nil, false)
		else
			Framework.TransformUtil.SetLocalPos(self._Nego_Content.transform, 0, 0, 0)
		end
	end
end

function CommonTextTipsView:onExit()
	CommonTextTipsView.super.onExit(self)
end

function CommonTextTipsView:onExitFinished()
	CommonTextTipsView.super.onExitFinished(self)
end

function CommonTextTipsView:_SetDesc1(desc)
	self._TxtC_Desc_1.text = desc
end

function CommonTextTipsView:_OnClickSelf()
	CommonTipsMgr.instance:closeAllTips()
end

return CommonTextTipsView
