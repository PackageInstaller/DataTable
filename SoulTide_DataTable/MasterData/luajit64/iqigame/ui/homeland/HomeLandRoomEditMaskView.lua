-- chunkname: @IQIGame\\UI\\HomeLand\\HomeLandRoomEditMaskView.lua

local m = {}
local HomeLandRoomEditMaskStyleBtnCell = require("IQIGame.UI.HomeLand.HomeLandRoomEditMaskStyleBtnCell")

function m:New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	self.btnClose = self.BtnClose:GetComponent("Button")

	function self.delegateBtnClose()
		self:OnBtnClose()
	end

	self:AddListener()
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

		local btnStyle = HomeLandRoomEditMaskStyleBtnCell:New(obj)

		btnStyle:SetData(tabData[1], tabData[2])

		function btnStyle.clickSelfCallBack(decorateThemeId)
			self:OnSelectStyle(decorateThemeId)
		end

		self.styleButtons[tabData[1]] = btnStyle
	end

	self.selectIndex = 1
end

function m:AddListener()
	self.btnClose.onClick:AddListener(self.delegateBtnClose)
end

function m:RemoveListener()
	self.btnClose.onClick:RemoveListener(self.delegateBtnClose)
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
