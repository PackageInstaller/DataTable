-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/common/instruction/view/SortPanelTipsView.lua

module("logic.extensions.common.instruction.view.SortPanelTipsView", package.seeall)

local SortPanelTipsView = class("SortPanelTipsView", ViewComponent)

function SortPanelTipsView:ctor()
	SortPanelTipsView.super.ctor(self)
end

function SortPanelTipsView:destroyUI()
	SortPanelTipsView.super.destroyUI(self)
end

function SortPanelTipsView:onExitFinished()
	SortPanelTipsView.super.onExitFinished(self)
end

function SortPanelTipsView:onEnterFinished()
	SortPanelTipsView.super.onEnterFinished(self)
end

function SortPanelTipsView:unbindEvents()
	SortPanelTipsView.super.unbindEvents(self)
	self._closeButton:RemoveClickListener()
	self._customInput:RemoveListener()
end

function SortPanelTipsView:bindEvents()
	SortPanelTipsView.super.bindEvents(self)
	self._closeButton:AddClickListener(self._onClickClose, self)
	self._customInput:AddListener(self._onCustomInputCallback, self)
end

function SortPanelTipsView:onExit()
	SortPanelTipsView.super.onExit(self)
end

function SortPanelTipsView:buildUI()
	SortPanelTipsView.super.buildUI(self)

	self._closeButton = self:getBtn("btnClose")
	self._content = self:getGo("gridlayout")
	self._adjustPosition = self._content:GetComponent("UIAdjustPosition")
	self._gridLayout = self._content:GetComponent("GridLayoutGroup")
	self._cells = ItemGroup.New(self._content)
end

function SortPanelTipsView:onEnter()
	SortPanelTipsView.super.onEnter(self)
	self:_adjustView()

	local param = self:getOpenParam()

	self._cells:updateWithMoArray(param, function(item, data)
		local go = item.mainGO
		local txtName = goutil.findChildTextComponent(go, "Name")
		local imgSortChange = goutil.findChildComponent(go, "ImgSort", "UIImageSpriteChange")
		local btn = Framework.ButtonAdapter.Get(go)

		btn:AddClickListener(function()
			self:_onClickSort(data)
		end)
	end)
end

function SortPanelTipsView:_onClickSort(data)
	return
end

function SortPanelTipsView:_adjustView()
	local pos = self._viewPresentor._openParam[1]
	local sizeDelta = self._viewPresentor._openParam[2]

	if pos then
		GameUtil.SetActive(self.mainGO, false)
		settimer(0.1, function()
			GameUtil.SetActive(self.mainGO, true)
			Framework.TransformUtil.SetLocalScale(self.mainGO.transform, 1, 1, 1)
			self._adjustPosition:AdjustScreenPosition(pos, sizeDelta[1], sizeDelta[2])
		end, nil, false)
	else
		Framework.TransformUtil.SetLocalPos(self._content.transform, 0, 0, 0)
	end
end

function SortPanelTipsView:_onClickClose()
	self:close()
end

return SortPanelTipsView
