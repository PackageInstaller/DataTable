-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/bag/panel/PetSortPaneView.lua

module("logic.extensions.bag.panel.PetSortPaneView", package.seeall)

local PetSortPaneView = class("PetSortPaneView", ViewComponent)

function PetSortPaneView:ctor()
	PetSortPaneView.super.ctor(self)
end

function PetSortPaneView:destroyUI()
	PetSortPaneView.super.destroyUI(self)
end

function PetSortPaneView:onExitFinished()
	PetSortPaneView.super.onExitFinished(self)
end

function PetSortPaneView:onEnterFinished()
	PetSortPaneView.super.onEnterFinished(self)
end

function PetSortPaneView:unbindEvents()
	PetSortPaneView.super.unbindEvents(self)
	self._customInput:RemoveListener()

	local _sortSize = #self._sortGoList

	for i = 1, _sortSize do
		local go = self._sortGoList[i]

		GameUtil.rmClickHandler(go)
	end
end

function PetSortPaneView:bindEvents()
	PetSortPaneView.super.bindEvents(self)
	self._customInput:AddListener(self._onCustomInputCallback, self)
end

function PetSortPaneView:onExit()
	PetSortPaneView.super.onExit(self)

	self._callback = nil

	removetimer(self.showMainGo, self)
end

function PetSortPaneView:buildUI()
	PetSortPaneView.super.buildUI(self)

	self._content = goutil.findChild(self.mainGO, "content")
	self._adjustPosition = self._content:GetComponent("UIAdjustPosition")
	self._customInput = UICustomInput.Get(self._content)
end

function PetSortPaneView:reset(arr)
	self._sortGoList = {}

	for k, v in pairs(arr) do
		local go = goutil.findChild(self._content, "Cell" .. k)

		if go then
			self._sortGoList[k] = go

			local ImgSort = goutil.findChild(go, "ImgSort"):GetComponent("UIImageSpriteChange")

			ImgSort:SetState(v)
			GameUtil.rmClickHandler(go)
			GameUtil.addClickHandler(go, GameUtil.handler(self._onClickFilterBtn, self, k))
		end
	end
end

function PetSortPaneView:_onClickFilterBtn(idx)
	GameUtil.callBack(self._callback, idx, GameUtil.handler(self.reset, self))
end

function PetSortPaneView:_onCustomInputCallback(hover)
	if not hover then
		self:close()
	end
end

function PetSortPaneView:onEnter()
	PetSortPaneView.super.onEnter(self)
	self:_adjustView()

	self.parentPresentor = self._viewPresentor._openParam[3]

	local arr = self._viewPresentor._openParam[4]

	self._callback = self._viewPresentor._openParam[5]

	self:reset(arr)
end

function PetSortPaneView:_adjustView()
	local pos = self._viewPresentor._openParam[1]

	self.pos = pos
	self.sizeDelta = self._viewPresentor._openParam[2]

	if pos then
		GameUtil.SetActive(self.mainGO, false)
		settimer(0.1, self.showMainGo, self, false)
	else
		Framework.TransformUtil.SetLocalPos(self._content.transform, 0, 0, 0)
	end
end

function PetSortPaneView:showMainGo()
	GameUtil.SetActive(self.mainGO, true)
	Framework.TransformUtil.SetLocalScale(self.mainGO.transform, 1, 1, 1)
	self._adjustPosition:AdjustScreenPosition(self.pos, self.sizeDelta[1], self.sizeDelta[2])
	self:checkPresentor()
end

function PetSortPaneView:checkPresentor(callback)
	if not self.parentPresentor or not self.parentPresentor:isOpen() then
		self:close()

		return
	end

	GameUtil.callBack(callback)
end

return PetSortPaneView
