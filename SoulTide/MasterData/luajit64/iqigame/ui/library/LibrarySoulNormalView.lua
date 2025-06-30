-- chunkname: @IQIGame\\UI\\Library\\LibrarySoulNormalView.lua

local LibrarySoulNormalView = {
	showState = 1,
	currentSelect = 1
}
local LibrarySoulInfoView = require("IQIGame.UI.Library.LibrarySoulInfoView")
local LibrarySoulCGView = require("IQIGame.UI.Library.LibrarySoulCGView")
local LibrarySoulCVView = require("IQIGame.UI.Library.LibrarySoulCVView")
local LibrarySoulMovieView = require("IQIGame.UI.Library.LibrarySoulMovieView")
local LibrarySoulSpineCVView = require("IQIGame.UI.Library.LibrarySoulSpineCVView")

function LibrarySoulNormalView.New(view, root)
	local obj = Clone(LibrarySoulNormalView)

	obj:Init(view, root)

	return obj
end

function LibrarySoulNormalView:Init(view, root)
	self.View = view
	self.rootUI = root

	LuaCodeInterface.BindOutlet(self.View, self)

	self.toggles = {}

	for i = 1, 5 do
		self["Toggle" .. i]:GetComponent("ToggleHelperComponent").text = LibrarySoulApi:GetString("ToggleStr", i)

		local toggle = self["Toggle" .. i]:GetComponent("Toggle")

		toggle.group = self.ToggleGroup:GetComponent("ToggleGroup")
		toggle.isOn = false
		self.toggles[i] = toggle
	end

	self.childViews = {}
	self.childViews[1] = LibrarySoulInfoView.New(self.InfoView)
	self.childViews[2] = LibrarySoulCGView.New(self.CGView)
	self.childViews[3] = LibrarySoulCVView.New(self.CVView)
	self.childViews[4] = LibrarySoulSpineCVView.New(self.SpineCVView, self.rootUI)
	self.childViews[5] = LibrarySoulMovieView.New(self.MovieView, self.rootUI)

	function self.delegateOnToggleChange(isOn)
		self:OnToggleChange(isOn)
	end

	self:AddListener()
end

function LibrarySoulNormalView:AddListener()
	for i, v in pairs(self.toggles) do
		v.onValueChanged:AddListener(self.delegateOnToggleChange)
	end
end

function LibrarySoulNormalView:RemoveListener()
	for i, v in pairs(self.toggles) do
		v.onValueChanged:RemoveListener(self.delegateOnToggleChange)
	end
end

function LibrarySoulNormalView:Update(data)
	self.librarySoulData = data

	self:ShowTab()
end

function LibrarySoulNormalView:ShowTab()
	for i = 1, #self.childViews do
		local childView = self.childViews[i]

		if self.currentSelect == i then
			childView:Open()
			childView:Update(self.librarySoulData)
		else
			childView:Close()
		end
	end
end

function LibrarySoulNormalView:OnToggleChange(isOn)
	if isOn then
		local index

		for i = 1, #self.toggles do
			local toggle = self.toggles[i]

			if toggle.isOn == true then
				index = i

				break
			end
		end

		if self.currentSelect ~= index then
			self.currentSelect = index

			self:ShowTab()
		end
	end
end

function LibrarySoulNormalView:SetCVToggleVisible(state)
	self.showState = state

	self.Toggle3:SetActive(self.showState == 1)
	self.Toggle4:SetActive(self.showState == 3)

	if self.showState ~= 1 then
		if self.toggles[3].isOn then
			self.toggles[3].isOn = false
			self.currentSelect = 1
			self.toggles[self.currentSelect].isOn = true

			self:ShowTab()
		end
	elseif self.showState ~= 3 and self.toggles[4].isOn then
		self.toggles[4].isOn = false
		self.currentSelect = 1
		self.toggles[self.currentSelect].isOn = true

		self:ShowTab()
	end
end

function LibrarySoulNormalView:Open()
	self.View:SetActive(true)

	self.currentSelect = 1
	self.toggles[self.currentSelect].isOn = true
end

function LibrarySoulNormalView:Close()
	self.View:SetActive(false)

	for i, v in pairs(self.childViews) do
		v:Close()
	end
end

function LibrarySoulNormalView:Dispose()
	self:RemoveListener()

	for i, v in pairs(self.childViews) do
		v:Dispose()
	end

	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return LibrarySoulNormalView
