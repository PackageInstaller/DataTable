-- chunkname: @IQIGame\\UI\\Guild\\GuildIntroduce\\GuildRecommendView.lua

local m = {
	recommendRenderCellPool = {},
	guildList = {}
}
local GuildRecommendRenderCell = require("IQIGame.UI.Guild.GuildIntroduce.GuildRecommendRenderCell")

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)
	UGUIUtil.SetTextInChildren(self.BtnRefresh, GuildIntroduceUIApi:GetString("BtnRefreshLabel"))
	UGUIUtil.SetText(self.TextNoneRecommend, GuildIntroduceUIApi:GetString("TextNoneRecommend"))

	self.ScrollArea:GetComponent("ScrollAreaList").onRenderCell = function(cell)
		self:OnRenderGridCell(cell)
	end

	function self.DelegateBtnRefresh()
		self:OnBtnRefresh()
	end

	function self.DelegateRecommendGuildList()
		self:OnRecommendGuildList()
	end

	function self.DelegateApplyListEvent()
		self:OnUpdateApplyList()
	end
end

function m:AddListener()
	self.BtnRefresh:GetComponent("Button").onClick:AddListener(self.DelegateBtnRefresh)
	EventDispatcher.AddEventListener(EventID.GuildUpdateRecommendGuildListEvent, self.DelegateRecommendGuildList)
	EventDispatcher.AddEventListener(EventID.GuildApplyListEvent, self.DelegateApplyListEvent)
end

function m:RemoveListener()
	self.BtnRefresh:GetComponent("Button").onClick:RemoveListener(self.DelegateBtnRefresh)
	EventDispatcher.RemoveEventListener(EventID.GuildUpdateRecommendGuildListEvent, self.DelegateRecommendGuildList)
	EventDispatcher.RemoveEventListener(EventID.GuildApplyListEvent, self.DelegateApplyListEvent)
end

function m:UpdateView()
	local haveData = #self.guildList > 0

	self.ScrollArea:SetActive(haveData)
	self.NoneNode:SetActive(not haveData)

	if haveData then
		self.ScrollArea:GetComponent("ScrollAreaList"):Refresh(#self.guildList)
	end

	local maxNum = CfgDiscreteDataTable[6520091].Data[2]

	UGUIUtil.SetText(self.TextNum, GuildIntroduceUIApi:GetString("TextNum", #GuildModule.myApplyList, maxNum))
end

function m:OnRenderGridCell(cell)
	local guildData = self.guildList[cell.index + 1]

	if guildData == nil then
		cell.gameObject:SetActive(false)

		return
	end

	cell.gameObject:SetActive(true)

	local insID = cell.gameObject:GetInstanceID()
	local recommendRenderCell = self.recommendRenderCellPool[insID]

	if recommendRenderCell == nil then
		recommendRenderCell = GuildRecommendRenderCell.New(cell.gameObject)
		self.recommendRenderCellPool[insID] = recommendRenderCell
	end

	recommendRenderCell:SetData(guildData)
end

function m:OnBtnRefresh()
	GuildModule.GetRecommendGuildList()
end

function m:OnRecommendGuildList()
	self.guildList = GuildModule.recommendGuildList

	if self.guildList == nil then
		self.guildList = {}
	end

	self:UpdateView()
end

function m:OnUpdateApplyList()
	self:UpdateView()
end

function m:Open()
	self.View:SetActive(true)
	self:AddListener()
	GuildModule.GetRecommendGuildList()
	self:UpdateView()
end

function m:Close()
	self.View:SetActive(false)
	self:RemoveListener()
end

function m:Dispose()
	self:Close()

	for i, v in pairs(self.recommendRenderCellPool) do
		v:Dispose()
	end

	LuaCodeInterface.ClearOutlet(self.View, self)
	UnityEngine.Object.Destroy(self.View)

	self.View = nil
end

return m
