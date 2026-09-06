-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/stargodplus/view/StargodplusfilterView.lua

module("logic.extensions.stargodplus.view.StargodplusfilterView", package.seeall)

local StargodplusfilterView = class("StargodplusfilterView", ViewComponent)

function StargodplusfilterView:ctor()
	StargodplusfilterView.super.ctor(self)
end

function StargodplusfilterView:buildUI()
	StargodplusfilterView.super.buildUI(self)

	self._cellGo = self:getGo("root/cell")
	self._rootGo = self:getGo("root")
	self._itemGroup = ItemGroup.New(self._rootGo, self._cellGo, nil, nil, true)
	self._customInput = UICustomInput.Get(self:getGo("root"))
end

function StargodplusfilterView:bindEvents()
	StargodplusfilterView.super.bindEvents(self)
	self._customInput:AddListener(self._onCustomInputCallback, self)
end

function StargodplusfilterView:unbindEvents()
	StargodplusfilterView.super.unbindEvents(self)
	self._customInput:RemoveListener()
end

function StargodplusfilterView:destroyUI()
	StargodplusfilterView.super.destroyUI(self)
end

function StargodplusfilterView:onEnter()
	StargodplusfilterView.super.onEnter(self)

	local list = StargodplusConfig.instance:getFillerCfgs()
	local hasType = {}

	for i, v in pairs(list) do
		if type(i) == "number" then
			hasType[v.type] = true
		end
	end

	self._currId = false
	self._resList = {}

	for k, v in pairs(hasType) do
		table.insert(self._resList, k)
	end

	table.sort(self._resList, function(a, b)
		return a < b
	end)
	self:_updateItem()
end

function StargodplusfilterView:onEnterFinished()
	StargodplusfilterView.super.onEnterFinished(self)
end

function StargodplusfilterView:onExit()
	StargodplusfilterView.super.onExit(self)
end

function StargodplusfilterView:onExitFinished()
	StargodplusfilterView.super.onExitFinished(self)
end

function StargodplusfilterView:_updateItem()
	self._itemGroup:updateWithMoArray(self._resList, function(item, data)
		local nameText = goutil.findChildTextComponent(item.mainGO, "text")
		local change = item.mainGO:GetComponent(ComponentType.UIImageSpriteChange)
		local btn = GameUtil.asBtn(item.mainGO)

		btn:AddClickListener(function()
			self._currId = data

			GlobalDispatcher:dispatch(StargodplusController.On_Select_FilterType, data)
			self:_updateItem()
		end)
		change:SetState(self._currId == data and 1 or 0)

		nameText.text = GameEnum.StarGodPlusEquipTypeName[data]
	end)
end

function StargodplusfilterView:_onCustomInputCallback(hover)
	if not hover then
		self:close()
	end
end

return StargodplusfilterView
