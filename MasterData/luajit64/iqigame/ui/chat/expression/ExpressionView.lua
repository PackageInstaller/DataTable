-- chunkname: @IQIGame\\UI\\Chat\\Expression\\ExpressionView.lua

local ExpressionView = {
	expCellPool = {},
	groupCellPool = {}
}
local ExpGroupCell = require("IQIGame.UI.Chat.Expression.ExpGroupCell")
local ExpCell = require("IQIGame.UI.Chat.Expression.ExpCell")

function ExpressionView.New(view)
	local obj = Clone(ExpressionView)

	obj:Init(view)

	return obj
end

function ExpressionView:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	self.tfGroupName = self.goGroupName:GetComponent("Text")
	self.btnClose = self.goBtnClose:GetComponent("Button")
	self.btnGroupSort = self.goBtnGroupSort:GetComponent("Button")

	function self.onClickBtnCloseDelegate()
		self:OnClickBtnClose()
	end

	function self.onClickBtnGroupSortDelegate()
		self:OnClickBtnGroupSort()
	end

	function self.onCloseUIDelegate(sender, args)
		self:OnUIClosed(sender, args)
	end

	self.groupList = self.goGroupList:GetComponent("ScrollAreaList")

	function self.groupList.onRenderCell(cell)
		self:OnRenderGroupCell(cell)
	end

	function self.groupList.onSelectedCell(cell)
		self:OnSelectGroupCell(cell)
	end

	self.expList = self.goExpList:GetComponent("ScrollAreaList")

	function self.expList.onRenderCell(cell)
		self:OnRenderExpCell(cell)
	end

	function self.expList.onSelectedCell(cell)
		self:OnSelectExpCell(cell)
	end

	UGUIUtil.SetTextInChildren(self.ExpListEmptyView, ChatUIApi:GetString("ExpListEmptyViewText"))
end

function ExpressionView:Open()
	if self.isOpening then
		return
	end

	self.isOpening = true

	self.View:SetActive(true)
	self:OnAddListener()

	self.groupList.defaultSelectedToggle = 0

	self:RefreshGroupList()
end

function ExpressionView:Close()
	self:OnHide()
	self.View:SetActive(false)
end

function ExpressionView:OnHide()
	self.isOpening = false

	self:OnRemoveListener()

	for i, v in pairs(self.groupCellPool) do
		v:OnHide()
	end

	for i, v in pairs(self.expCellPool) do
		v:OnHide()
	end
end

function ExpressionView:OnDestroy()
	for i, v in pairs(self.groupCellPool) do
		v:OnDestroy()
	end

	for i, v in pairs(self.expCellPool) do
		v:OnDestroy()
	end

	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

function ExpressionView:OnAddListener()
	self.btnGroupSort.onClick:AddListener(self.onClickBtnGroupSortDelegate)
	self.btnClose.onClick:AddListener(self.onClickBtnCloseDelegate)
	GameEntry.LuaEvent:Subscribe(CloseUIFormCompleteEventArgs.EventId, self.onCloseUIDelegate)
end

function ExpressionView:OnRemoveListener()
	self.btnGroupSort.onClick:RemoveListener(self.onClickBtnGroupSortDelegate)
	self.btnClose.onClick:RemoveListener(self.onClickBtnCloseDelegate)
	GameEntry.LuaEvent:Unsubscribe(CloseUIFormCompleteEventArgs.EventId, self.onCloseUIDelegate)
end

function ExpressionView:OnClickBtnClose()
	self:Close()
end

function ExpressionView:OnClickBtnGroupSort()
	UIModule.Open(Constant.UIControllerName.ChatEmojiSortUI, Constant.UILayer.UI)
end

function ExpressionView:OnUIClosed(sender, args)
	if args.UIFormAssetName == AssetPath.Get(GlobalKey.UIPrefabPath, Constant.UIControllerName.ChatEmojiSortUI) then
		self.groupListDatum = ChatModule.GetEmoGroupSortDatum()

		table.insert(self.groupListDatum, 1, CfgChatEmoticonGroupTable[1])
		self.groupList:RenderCells()
	end
end

function ExpressionView:OnRenderGroupCell(cell)
	local luaIndex = cell.index + 1
	local insID = cell.gameObject:GetInstanceID()
	local cfgGroupData = self.groupListDatum[luaIndex]
	local groupCell = self.groupCellPool[insID]

	if groupCell == nil then
		groupCell = ExpGroupCell.New(cell.gameObject)
		self.groupCellPool[insID] = groupCell
	end

	groupCell:Refresh(cfgGroupData)
end

function ExpressionView:OnSelectGroupCell(cell)
	local luaIndex = cell.index + 1
	local cfgGroupData = self.groupListDatum[luaIndex]

	self.curCfgGroupData = cfgGroupData
	self.tfGroupName.text = ChatUIApi:GetString("expViewGroupName", cfgGroupData.Name)

	self:RefreshEmoList()
end

function ExpressionView:OnRenderExpCell(cell)
	local luaIndex = cell.index + 1
	local insID = cell.gameObject:GetInstanceID()
	local cfgEmoData = self.expListDatum[luaIndex]
	local expCell = self.expCellPool[insID]

	if expCell == nil then
		expCell = ExpCell.New(cell.gameObject)
		self.expCellPool[insID] = expCell
	end

	expCell:Refresh(cfgEmoData)
end

function ExpressionView:OnSelectExpCell(cell)
	local luaIndex = cell.index + 1
	local cfgEmoData = self.expListDatum[luaIndex]

	EventDispatcher.Dispatch(EventID.SelectExpression, cfgEmoData.Id)

	local normalCfgEmoDatum = ChatModule.GetNormalEmoDatum()
	local toRemovePos

	for i, v in ipairs(normalCfgEmoDatum) do
		if v.Id == cfgEmoData.Id then
			toRemovePos = i

			break
		end
	end

	if toRemovePos ~= nil then
		table.remove(normalCfgEmoDatum, toRemovePos)
	end

	normalCfgEmoDatum[#normalCfgEmoDatum + 1] = cfgEmoData

	ChatModule.SaveNormalEmoDatum(normalCfgEmoDatum)
	self:Close()
end

function ExpressionView:RefreshGroupList()
	self.groupListDatum = ChatModule.GetEmoGroupSortDatum()

	table.insert(self.groupListDatum, 1, CfgChatEmoticonGroupTable[1])
	self.groupList:Refresh(#self.groupListDatum)
end

function ExpressionView:RefreshEmoList()
	self.expListDatum = {}

	if self.curCfgGroupData.Id == 1 then
		self.expListDatum = ChatModule.GetNormalEmoDatum()
	else
		for i, v in pairsCfg(CfgChatEmoticonTable) do
			if v.Group == self.curCfgGroupData.Id and ChatModule.CheckEmoIsUnlock(v.Id) then
				self.expListDatum[#self.expListDatum + 1] = v
			end
		end

		table.sort(self.expListDatum, function(a, b)
			return a.Id < b.Id
		end)
	end

	self.expList:Refresh(#self.expListDatum)
	self.ExpListEmptyView:SetActive(#self.expListDatum == 0)
end

return ExpressionView
