-- chunkname: @IQIGame\\UI\\Girl\\GirlOnDuty\\GirlOnDutySelectModeView.lua

local m = {
	renderCells = {}
}
local GirlOnDutySelectModeRenderCell = require("IQIGame.UI.Girl.GirlOnDuty.GirlOnDutySelectModeRenderCell")
local UIObjectPool = require("IQIGame.UI.Common.UIObjectPool")

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	function self.delegateBtnClose()
		self:OnBtnClose()
	end

	self.SortMould:SetActive(false)

	self.renderCellPool = UIObjectPool.New(5, function()
		local renderObj = UnityEngine.Object.Instantiate(self.SortMould)

		return GirlOnDutySelectModeRenderCell.New(renderObj)
	end, function(currentCell)
		currentCell:Dispose()
	end)

	self.Sort:SetActive(false)
	self.BtnClose:SetActive(false)
	self.BgImg:SetActive(false)
	self:AddListener()
end

function m:AddListener()
	self.BtnClose:GetComponent("Button").onClick:AddListener(self.delegateBtnClose)
end

function m:RemoveListener()
	self.BtnClose:GetComponent("Button").onClick:RemoveListener(self.delegateBtnClose)
end

function m:CreateRenders(renderTypes, renderLabs)
	for i, v in pairs(self.renderCells) do
		v.View:SetActive(false)
		v.View.transform:SetParent(self.View:GetComponentInParent(typeof(UIController)).transform, false)
		self.renderCellPool:Release(v)
	end

	self.renderCells = {}

	for i = 1, #renderTypes do
		local renderTypes = renderTypes[i]
		local labStr = renderLabs[i]
		local cell = self.renderCellPool:Obtain()

		cell.View.transform:SetParent(self.Sort.transform, false)
		cell.View:SetActive(true)
		cell:SetData(renderTypes, labStr)

		function cell.clickSelfCallBack(type)
			self:SelectRender(type)
		end

		table.insert(self.renderCells, cell)
	end
end

function m:SelectRender(type)
	self:OnBtnClose(type)
end

function m:OnBtnClose(type)
	if self.closeCallBack then
		self.closeCallBack(type)
	end
end

function m:OpenList()
	self.Sort:SetActive(true)
	self.BtnClose:SetActive(true)
	self.BgImg:SetActive(true)
end

function m:CloseList()
	self.Sort:SetActive(false)
	self.BtnClose:SetActive(false)
	self.BgImg:SetActive(false)
end

function m:Dispose()
	self:RemoveListener()

	self.closeCallBack = nil

	for i, v in pairs(self.renderCells) do
		self.renderCellPool:Release(v)
	end

	self.renderCells = nil

	self.renderCellPool:Dispose()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
