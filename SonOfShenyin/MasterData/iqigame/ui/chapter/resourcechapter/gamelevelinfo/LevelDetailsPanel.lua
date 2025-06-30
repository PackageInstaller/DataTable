-- chunkname: @IQIGame\\UI\\Chapter\\ResourceChapter\\GameLevelInfo\\LevelDetailsPanel.lua

local m = {
	tabs = {},
	subPanel = {}
}
local enemyDetailView = require("IQIGame.UI.Chapter.ResourceChapter.GameLevelInfo.EnemyDetailView")
local terrainDetailView = require("IQIGame.UI.Chapter.ResourceChapter.GameLevelInfo.TerrainDetailView")

function m.New(view, callback, uiController)
	local obj = Clone(m)

	obj:Init(view, callback, uiController)

	return obj
end

function m:Init(view, callback, uiController)
	self.View = view
	self.callback = callback
	self.UIController = uiController

	LuaCodeInterface.BindOutlet(self.View, self)

	self.EnemyDetailPanel = enemyDetailView.New(self.EnemyDetailParent)
	self.TerrainDetailView = terrainDetailView.New(self.TerrainDetailParent)
	self.subPanel[1] = self.EnemyDetailPanel
	self.subPanel[2] = self.TerrainDetailView
	self.SubTween = self.View:GetComponent("TweenPosition")

	function self.DelegateOnClickTab(isOn)
		self:OnClickTab(isOn)
	end

	function self.DelegateCloseBtn()
		self:Hide()
	end

	local strs = ChapterUIApi:GetPassInfoPanelToggleStr()
	local toggleLen = self.TittleToggleGroups.transform.childCount

	for i = 1, toggleLen do
		self.tabs[i] = self.TittleToggleGroups.transform:GetChild(i - 1)
		self.tabs[i]:GetComponent("ToggleHelperComponent").text = strs[i]
	end

	UGUIUtil.SetTextInChildren(self.ReturnBtn, ChapterUIApi:GetPassInfoPanelReturnStr())
	self:AddListeners()
end

function m:AddListeners()
	self.CloseBtn:GetComponent("Button").onClick:AddListener(self.DelegateCloseBtn)
	self.ReturnBtn:GetComponent("Button").onClick:AddListener(self.DelegateCloseBtn)

	local toggle

	for i = 1, #self.tabs do
		toggle = self.tabs[i]:GetComponent("Toggle")

		toggle.onValueChanged:AddListener(self.DelegateOnClickTab)
	end
end

function m:RemoveListeners()
	self.CloseBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateCloseBtn)
	self.ReturnBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateCloseBtn)

	local toggle

	for i = 1, #self.tabs do
		toggle = self.tabs[i]:GetComponent("Toggle")

		toggle.onValueChanged:RemoveListener(self.DelegateOnClickTab)
	end
end

function m:SetData(levelData)
	self.LevelData = levelData
end

function m:Show()
	self.View:SetActive(true)
	self:ToggleTo(1)

	self.tabs[1]:GetComponent("Toggle").isOn = true
end

function m:Hide()
	if self.callback ~= nil then
		self.callback()
	end

	self.View:SetActive(false)
end

function m:OnClickTab(isOn)
	if isOn then
		local currentTarget = self.UIController:GetCurrentTarget()

		for i = 1, #self.tabs do
			if self.tabs[i].gameObject == currentTarget then
				self:ToggleTo(i)

				return
			end
		end
	end
end

function m:ToggleTo(panelIndex)
	for i = 1, #self.subPanel do
		if panelIndex == i then
			self.subPanel[i]:Show()
			self.subPanel[i]:SetData(self.LevelData)
		else
			self.subPanel[i]:Hide()
		end
	end
end

function m:Dispose()
	self:RemoveListeners()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
