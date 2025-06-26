-- chunkname: @IQIGame\\UI\\Guild\\GuildIntroduce\\GuildSearchView.lua

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
	UGUIUtil.SetText(self.SearchTitle, GuildIntroduceUIApi:GetString("SearchTitle"))
	UGUIUtil.SetText(self.SearchNoneText, GuildIntroduceUIApi:GetString("SearchNoneText"))

	self.ScrollArea:GetComponent("ScrollAreaList").onRenderCell = function(cell)
		self:OnRenderGridCell(cell)
	end

	function self.delegateOnValueChanged(text)
		self:OnValueChanged(text)
	end

	function self.delegateBtnSearch()
		self:OnBtnSearch()
	end

	function self.delegateBtnBack()
		self:OnBtnBack()
	end

	function self.DelegateApplyListEvent()
		self:OnUpdateApplyList()
	end

	self.maxCharNum = CfgDiscreteDataTable[6520052].Data[1]
	self.InputContent:GetComponent("IQIGame.Onigao.Game.UI.InputField").characterLimit = self.maxCharNum
end

function m:AddListener()
	self.BtnBack:GetComponent("Button").onClick:AddListener(self.delegateBtnBack)
	self.BtnSearch:GetComponent("Button").onClick:AddListener(self.delegateBtnSearch)
	self.InputContent:GetComponent("IQIGame.Onigao.Game.UI.InputField").onValueChanged:AddListener(self.delegateOnValueChanged)
	EventDispatcher.AddEventListener(EventID.GuildApplyListEvent, self.DelegateApplyListEvent)
end

function m:RemoveListener()
	self.BtnBack:GetComponent("Button").onClick:RemoveListener(self.delegateBtnBack)
	self.BtnSearch:GetComponent("Button").onClick:RemoveListener(self.delegateBtnSearch)
	self.InputContent:GetComponent("IQIGame.Onigao.Game.UI.InputField").onValueChanged:RemoveListener(self.delegateOnValueChanged)
	EventDispatcher.RemoveEventListener(EventID.GuildApplyListEvent, self.DelegateApplyListEvent)
end

function m:OnValueChanged(text)
	self.InputContent:GetComponent("IQIGame.Onigao.Game.UI.InputField").text = string.subUTF8Length(text, 27)
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

function m:OnBtnBack()
	self:ShowDefault(true)
end

function m:OnBtnSearch()
	local name = self.InputContent:GetComponent("IQIGame.Onigao.Game.UI.InputField").text

	if name == "" or name == nil then
		return
	end

	if string.len(name) < 4 then
		NoticeModule.ShowNotice(21066303)

		return
	end

	if WarnStrFunc:isWarningInPutStr(name) then
		NoticeModule.ShowNoticeNoCallback(Constant.Notice.BlankFloatNoticeID, SettingPlayerInfoViewApi:GetString("ErrorMsg6"))

		return
	end

	GuildModule.SearchGuild(name, function(guildBaseList)
		self:ShowSearchData(guildBaseList)
	end)
end

function m:ShowSearchData(guildBaseList)
	if guildBaseList then
		self.guildList = guildBaseList
	else
		self.guildList = {}
	end

	self:ShowDefault(false)

	local haveData = #self.guildList > 0

	self.ScrollArea:SetActive(haveData)
	self.NoneNode:SetActive(not haveData)

	if haveData then
		self.ScrollArea:GetComponent("ScrollAreaList"):Refresh(#self.guildList)
	end
end

function m:ShowDefault(top)
	self.SearchNode:SetActive(top)
	self.ScrollArea:SetActive(not top)
	self.NoneNode:SetActive(not top)
	self.BtnBack:SetActive(not top)
end

function m:UpdateView()
	local maxNum = CfgDiscreteDataTable[6520091].Data[2]

	UGUIUtil.SetText(self.TextApplyNumber, GuildIntroduceUIApi:GetString("ApplyNumber", #GuildModule.myApplyList, maxNum))

	if #self.guildList > 0 then
		self:ShowSearchData(GuildModule.guildBaseList)
	end
end

function m:OnUpdateApplyList()
	self:UpdateView()
end

function m:Open()
	self.View:SetActive(true)
	self:AddListener()
	self:ShowDefault(true)
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
