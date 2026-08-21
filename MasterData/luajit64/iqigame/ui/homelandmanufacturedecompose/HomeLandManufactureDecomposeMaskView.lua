-- chunkname: @IQIGame\\UI\\HomeLandManufactureDecompose\\HomeLandManufactureDecomposeMaskView.lua

local m = {}
local HomeLandDecomposeMaskStyleBtnCell = require("IQIGame.UI.HomeLandManufactureDecompose.HomeLandDecomposeMaskStyleBtnCell")

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

	self:AddListener()
end

function m:AddListener()
	self.BtnClose:GetComponent("Button").onClick:AddListener(self.delegateBtnClose)
end

function m:RemoveListener()
	self.BtnClose:GetComponent("Button").onClick:RemoveListener(self.delegateBtnClose)
end

function m:SetData(data)
	return
end

function m:CreateButtons(tab)
	self.tabs = tab
	self.styleButtons = {}

	self.SortMould:SetActive(false)

	for i = 1, #self.tabs do
		local tabData = self.tabs[i]
		local obj = UnityEngine.Object.Instantiate(self.SortMould)

		obj:SetActive(true)
		obj.transform:SetParent(self.Sort.transform, false)

		local btnStyle = HomeLandDecomposeMaskStyleBtnCell.New(obj)

		btnStyle:SetData(tabData[1], tabData[2])

		function btnStyle.clickSelfCallBack(decorateThemeId)
			self:OnSelectStyle(decorateThemeId)
		end

		self.styleButtons[tabData[1]] = btnStyle
	end

	self.selectIndex = 1
end

function m:OnSelectStyle(decorateThemeId)
	for i = 1, #self.tabs do
		local tabData = self.tabs[i]

		if tabData[1] == decorateThemeId then
			self.selectIndex = i

			break
		end
	end

	self:Close()
end

function m:OnBtnClose()
	self:Close()
end

function m:Open()
	self.View:SetActive(true)
end

function m:Close()
	self.View:SetActive(false)

	if self.selectChangeFun then
		self.selectChangeFun(self.selectIndex)
	end
end

function m:Dispose()
	self.selectChangeFun = nil

	self:RemoveListener()

	for i, v in pairs(self.styleButtons) do
		v:Dispose()
	end

	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
