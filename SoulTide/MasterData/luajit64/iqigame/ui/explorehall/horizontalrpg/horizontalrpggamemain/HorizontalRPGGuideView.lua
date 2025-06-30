-- chunkname: @IQIGame\\UI\\ExploreHall\\HorizontalRPG\\HorizontalRPGGameMain\\HorizontalRPGGuideView.lua

local m = {
	IsShow = true,
	QuestCellPool = {},
	Quests = {}
}
local HorizontalRPGQuestCell = require("IQIGame.UI.ExploreHall.HorizontalRPG.HorizontalRPGGameMain.HorizontalRPGQuestCell")

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	self.QuestScroll:GetComponent("ScrollAreaList").onRenderCell = function(cell)
		self:OnRenderQuestCell(cell)
	end

	function self.DelegateRPGChangeGuideEvent()
		self:OnRPGChangeGuideEvent()
	end

	function self.DelegateOnBtnHide()
		self:OnBtnHide()
	end

	function self.DelegateOnBtnShow()
		self:OnBtnShow()
	end

	self:AddListener()
end

function m:AddListener()
	self.BtnHide:GetComponent("Button").onClick:AddListener(self.DelegateOnBtnHide)
	self.BtnShow:GetComponent("Button").onClick:AddListener(self.DelegateOnBtnShow)
	EventDispatcher.AddEventListener(EventID.HorizontalRPGChangeGuideEvent, self.DelegateRPGChangeGuideEvent)
end

function m:RemoveListener()
	self.BtnHide:GetComponent("Button").onClick:RemoveListener(self.DelegateOnBtnHide)
	self.BtnShow:GetComponent("Button").onClick:RemoveListener(self.DelegateOnBtnShow)
	EventDispatcher.RemoveEventListener(EventID.HorizontalRPGChangeGuideEvent, self.DelegateRPGChangeGuideEvent)
end

function m:OnRPGChangeGuideEvent()
	self:UpdateView()
end

function m:UpdateView()
	self:RefreshState()

	self.Quests = HorizontalRPGModule.dailyDupPOD.horizontalRPGPOD.task or {}

	self.QuestScroll:GetComponent("ScrollAreaList"):Refresh(#self.Quests)
end

function m:OnRenderQuestCell(cell)
	local cid = self.Quests[cell.index + 1]
	local insID = cell.gameObject:GetInstanceID()
	local questCell = self.QuestCellPool[insID]

	if questCell == nil then
		questCell = HorizontalRPGQuestCell.New(cell.gameObject)
		self.QuestCellPool[insID] = questCell
	end

	questCell:SetData(cid)
end

function m:OnBtnHide()
	self.IsShow = false

	self:RefreshState()
end

function m:OnBtnShow()
	self.IsShow = true

	self:RefreshState()
end

function m:RefreshState()
	self.ShowView:SetActive(self.IsShow)
	self.BtnShow:SetActive(not self.IsShow)
end

function m:Dispose()
	self:RemoveListener()

	for i, v in pairs(self.QuestCellPool) do
		v:Dispose()
	end

	LuaCodeInterface.ClearOutlet(self.View, self)
	UnityEngine.Object.Destroy(self.View)

	self.View = nil
end

return m
