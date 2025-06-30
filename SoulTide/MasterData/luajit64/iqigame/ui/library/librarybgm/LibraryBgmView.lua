-- chunkname: @IQIGame\\UI\\Library\\LibraryBgm\\LibraryBgmView.lua

local m = {
	libraryBgmCellPool = {},
	cfgBgmData = {},
	bgmFavorID = {}
}
local LibraryBgmCell = require("IQIGame.UI.Library.LibraryBgm.LibraryBgmCell")

function m.New(view, root)
	local obj = Clone(m)

	obj:Init(view, root)

	return obj
end

function m:Init(view, root)
	self.View = view
	self.Root = root

	LuaCodeInterface.BindOutlet(self.View, self)

	function self.DelegateBtnClose()
		self:OnBtnClose()
	end

	self.ScrollArea:GetComponent("ScrollAreaList").onSelectedCell = function(cell)
		self:OnClickCell(cell)
	end
	self.ScrollArea:GetComponent("ScrollAreaList").onRenderCell = function(cell)
		self:OnRenderCell(cell)
	end
	self.cfgBgmData = {}

	for i, v in pairsCfg(CfgLibraryBgmListTable) do
		if not v.IsHide then
			table.insert(self.cfgBgmData, v)
		end
	end

	table.sort(self.cfgBgmData, function(a, b)
		return a.Sort < b.Sort
	end)

	self.bgmID = SaveDataModule.GetInt(PlayerModule.PlayerInfo.baseInfo.pid, Constant.SaveServerDataKey.LibraryBgm)

	if self.bgmID == nil or self.bgmID == 0 then
		self.bgmID = self.cfgBgmData[1].Id
	end
end

function m:AddListener()
	self.BtnClose:GetComponent("Button").onClick:AddListener(self.DelegateBtnClose)
end

function m:RemoveListener()
	self.BtnClose:GetComponent("Button").onClick:RemoveListener(self.DelegateBtnClose)
end

function m:RefreshList(refreshPosition)
	local playData
	local favorData = {}
	local noFavorData = {}

	for i, v in pairs(self.cfgBgmData) do
		local isPlay = self.bgmID == v.Id

		if isPlay then
			playData = v
		else
			local favor = self.bgmFavorID[tostring(v.Id)]

			favor = favor or 0

			if favor > 0 then
				table.insert(favorData, v)
			else
				table.insert(noFavorData, v)
			end
		end
	end

	table.sort(favorData, function(a, b)
		return a.Sort < b.Sort
	end)
	table.sort(noFavorData, function(a, b)
		return a.Sort < b.Sort
	end)

	local tempList = {}

	table.insert(tempList, playData)

	for i = 1, #favorData do
		table.insert(tempList, favorData[i])
	end

	for i = 1, #noFavorData do
		table.insert(tempList, noFavorData[i])
	end

	self.cfgBgmData = tempList

	if refreshPosition then
		self.ScrollArea:GetComponent("ScrollAreaList"):Refresh(#self.cfgBgmData)
	else
		self.ScrollArea:GetComponent("ScrollAreaList"):RenderCellsDynamic(#self.cfgBgmData)
	end
end

function m:OnRenderCell(cell)
	local cfgData = self.cfgBgmData[cell.index + 1]
	local goObj = cell.gameObject
	local instanceID = goObj:GetInstanceID()
	local bgmCell = self.libraryBgmCellPool[instanceID]

	if bgmCell == nil then
		bgmCell = LibraryBgmCell.New(goObj)

		function bgmCell.favorCallBack(bgmId, isOn)
			self:RefreshFavorList(bgmId, isOn)
		end

		self.libraryBgmCellPool[instanceID] = bgmCell
	end

	local id = self.bgmFavorID[tostring(cfgData.Id)]

	id = id or 0

	local isFavor = id > 0 and true or false

	bgmCell:SetData(cfgData, isFavor)
	bgmCell:RefreshSelect(self.bgmID == cfgData.Id)
end

function m:OnClickCell(cell)
	local selectID = self.cfgBgmData[cell.index + 1].Id

	if selectID == self.bgmID then
		return
	end

	self.bgmID = selectID

	for i, v in pairs(self.libraryBgmCellPool) do
		v:RefreshSelect(self.bgmID == v.cfgData.Id)
	end

	SaveDataModule.SaveInt(PlayerModule.PlayerInfo.baseInfo.pid, Constant.SaveServerDataKey.LibraryBgm, self.bgmID)

	local uiControl = self.View:GetComponentInParent(typeof(UIController))

	uiControl:ChangeBGM(CfgLibraryBgmListTable[self.bgmID].SoundID)
	self.Root:RefreshBgm()
end

function m:RefreshFavorList(bgmId, isOn)
	if isOn then
		if self.bgmFavorID[tostring(bgmId)] == nil then
			NoticeModule.ShowNotice(21043015)
		end

		self.bgmFavorID[tostring(bgmId)] = bgmId
	else
		if self.bgmFavorID[tostring(bgmId)] ~= nil then
			NoticeModule.ShowNotice(21043016)
		end

		self.bgmFavorID[tostring(bgmId)] = nil
	end

	PlayerPrefsUtil.SetLuaTable("", Constant.SaveServerDataKey.LibraryFavorBgm, self.bgmFavorID)
end

function m:OnBtnClose()
	self:Close()
end

function m:Open()
	self.bgmFavorID = PlayerPrefsUtil.GetLuaTable("", Constant.SaveServerDataKey.LibraryFavorBgm)
	self.bgmFavorID = self.bgmFavorID or {}

	self:AddListener()
	self.View:SetActive(true)
	self:RefreshList(true)
end

function m:Close()
	self:RemoveListener()
	self.View:SetActive(false)
end

function m:Dispose()
	AssetUtil.UnloadAsset(self)
	self:RemoveListener()
	LuaCodeInterface.ClearOutlet(self.View, self)
	UnityEngine.Object.Destroy(self.View)

	self.View = nil
end

return m
