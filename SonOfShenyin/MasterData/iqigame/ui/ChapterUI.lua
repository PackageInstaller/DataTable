-- chunkname: @IQIGame\\UI\\ChapterUI.lua

local ResourceChapterView = require("IQIGame.UI.Chapter.ResourceChapter.ResourceChapterView")
local EquipChapterView = require("IQIGame.UI.Chapter.EquipChapter.EquipChapterView")
local BossChapterView = require("IQIGame.UI.Chapter.BossChapter.BossChapterView")
local TowerChapterView = require("IQIGame.UI.Chapter.TowerChapter.TowerChapterView")
local ChapterUI = {
	TopTabListenerList = {},
	viewList = {}
}

ChapterUI = Base:Extend("ChapterUI", "IQIGame.Onigao.UI.ChapterUI", ChapterUI)

function ChapterUI:InitDelegation()
	return
end

function ChapterUI:OnInit()
	LuaCodeInterface.BindOutlet(self.View, self)
	self:InitDelegation()
	self:Initialize()
end

function ChapterUI:Initialize()
	self.TopTabList = {
		[Constant.ChapterPassType.TYPE_RESOURCES] = self.Toggle2,
		[Constant.ChapterPassType.TYPE_EQUIP] = self.Toggle3,
		[Constant.ChapterPassType.TYPE_BOSS] = self.Toggle4,
		[Constant.ChapterPassType.TYPE_CLIMB_TOWER] = self.ToggleTower
	}
	self.ResourceChapterView = ResourceChapterView.New(self.ResourceChapter, self)
	self.EquipChapterView = EquipChapterView.New(self.EquipChapter, self)
	self.BossChapterView = BossChapterView.New(self.BossChapter, self)
	self.TowerChapterView = TowerChapterView.New(self.TowerChapter, self)

	table.insert(self.viewList, self.ResourceChapterView)
	table.insert(self.viewList, self.EquipChapterView)
	table.insert(self.viewList, self.BossChapterView)
	table.insert(self.viewList, self.TowerChapterView)

	self.commonReturnBtn = CommonReturnBtn.New(self.Com_ReturnBtn, self)

	self.commonReturnBtn:RegisterReturnEvent(function()
		self:OnCloseBtn()
	end)
end

function ChapterUI:ShowTab(index)
	logDebug(string.format("ChapterUI:ShowTab=%d", index))

	for k, v in pairs(self.viewList) do
		v:Hide()
	end

	if index == Constant.ChapterPassType.TYPE_RESOURCES then
		self.ResourceChapterView:Show()
		self.ResourceChapterView:SetData()
	elseif index == Constant.ChapterPassType.TYPE_EQUIP then
		self.EquipChapterView:Show()
		self.EquipChapterView:SetData()
	elseif index == Constant.ChapterPassType.TYPE_BOSS then
		self.BossChapterView:Show()
		self.BossChapterView:SetData()
	elseif index == Constant.ChapterPassType.TYPE_CLIMB_TOWER then
		self.TowerChapterView:Show()
	end
end

function ChapterUI:OnCloseBtn()
	GameChapterModule.CurSelectChapterType = nil
	GameChapterModule.CurSelectChapterUserData = nil

	UIModule.CloseSelf(self)
end

function ChapterUI:OnDestroy()
	self.ResourceChapterView:Dispose()
	self.EquipChapterView:Dispose()
	self.TowerChapterView:OnDestroy()
	self.commonReturnBtn:Dispose()
end

function ChapterUI:OnOpen(userData)
	self.TopTabList[Constant.ChapterPassType.TYPE_RESOURCES]:GetComponent("Toggle").isOn = true

	self:ShowTab(Constant.ChapterPassType.TYPE_RESOURCES)
	self.Toggle2:SetActive(ResourceChapterModule.FristCondition())
	self.Toggle3:SetActive(EquipChapterModule.FristCondition())
	self.Toggle4:SetActive(BossChapterModule.FristCondition())
	self.ToggleTower:SetActive(TowerChapterModule.FirstCondition())
end

function ChapterUI:OnClose(userData)
	return
end

function ChapterUI:OnAddListeners()
	self.TopTabListenerList = {}

	for index, v in pairs(self.TopTabList) do
		self.TopTabListenerList[index] = function(isOn)
			if isOn then
				self:ShowTab(index)
			end
		end

		v:GetComponent("Toggle").onValueChanged:AddListener(self.TopTabListenerList[index])
	end
end

function ChapterUI:OnRemoveListeners()
	for index, v in pairs(self.TopTabList) do
		v:GetComponent("Toggle").onValueChanged:RemoveListener(self.TopTabListenerList[index])
	end
end

function ChapterUI:GetPreloadAssetPaths()
	return nil
end

function ChapterUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function ChapterUI:IsManualShowOnOpen(userData)
	return false
end

function ChapterUI:GetBGM(userData)
	return nil
end

function ChapterUI:OnPause()
	return
end

function ChapterUI:OnResume()
	return
end

function ChapterUI:OnCover()
	return
end

function ChapterUI:OnReveal()
	return
end

function ChapterUI:OnRefocus(userData)
	return
end

function ChapterUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function ChapterUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function ChapterUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function ChapterUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

return ChapterUI
