-- chunkname: @IQIGame\\UI\\Guild\\GuildIntroduce\\GuildApplyView.lua

local m = {
	applyRenderCellPool = {},
	guildList = {}
}
local GuildApplyRenderCell = require("IQIGame.UI.Guild.GuildIntroduce.GuildApplyRenderCell")

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	self.ScrollArea:GetComponent("ScrollAreaList").onRenderCell = function(cell)
		self:OnRenderGridCell(cell)
	end

	function self.DelegateApplyListEvent()
		self:OnUpdateApplyList()
	end
end

function m:AddListener()
	EventDispatcher.AddEventListener(EventID.GuildApplyListEvent, self.DelegateApplyListEvent)
end

function m:RemoveListener()
	EventDispatcher.RemoveEventListener(EventID.GuildApplyListEvent, self.DelegateApplyListEvent)
end

function m:OnRenderGridCell(cell)
	local guildData = self.guildList[cell.index + 1]

	if guildData == nil then
		cell.gameObject:SetActive(false)

		return
	end

	cell.gameObject:SetActive(true)

	local insID = cell.gameObject:GetInstanceID()
	local applyRenderCell = self.applyRenderCellPool[insID]

	if applyRenderCell == nil then
		applyRenderCell = GuildApplyRenderCell.New(cell.gameObject)
		self.applyRenderCellPool[insID] = applyRenderCell
	end

	applyRenderCell:SetData(guildData)
end

function m:OnUpdateApplyList()
	self.guildList = GuildModule.myApplyList

	if self.guildList == nil then
		self.guildList = {}
	end

	self:UpdateView()
end

function m:UpdateView()
	local haveData = #self.guildList > 0

	self.ScrollArea:SetActive(haveData)
	self.NoneNode:SetActive(not haveData)

	if haveData then
		self.ScrollArea:GetComponent("ScrollAreaList"):Refresh(#self.guildList)
	end

	local maxNum = CfgDiscreteDataTable[6520091].Data[2]

	UGUIUtil.SetText(self.TextApplyNumber, GuildIntroduceUIApi:GetString("ApplyNumber", #self.guildList, maxNum))
end

function m:Open()
	self.guildList = {}

	self.View:SetActive(true)
	self:AddListener()
	GuildModule.GetMyApplyList()
	self:UpdateView()
end

function m:Close()
	self.View:SetActive(false)
	self:RemoveListener()
end

function m:Dispose()
	self:Close()

	for i, v in pairs(self.applyRenderCellPool) do
		v:Dispose()
	end

	LuaCodeInterface.ClearOutlet(self.View, self)
	UnityEngine.Object.Destroy(self.View)

	self.View = nil
end

return m
