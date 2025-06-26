-- chunkname: @IQIGame\\UI\\ElementIntroduceUI.lua

local ElementIntroduceUI = Base:Extend("ElementIntroduceUI", "IQIGame.Onigao.UI.ElementIntroduceUI", {
	COLUMN = 2,
	DefaultCellWidth = 0
})
local ElementIntroduceCell = require("IQIGame.UI.ElementIntroduce.ElementIntroduceCell")

function ElementIntroduceUI:OnInit()
	function self.DelegateOnClickCloseBtn()
		self:OnClickCloseBtn()
	end

	self.ElementCells = {}

	for i = 1, 4 do
		local cell = ElementIntroduceCell.New(UnityEngine.Object.Instantiate(self.ElementCellPrefab))

		cell.View.transform:SetParent(self.ElementCellGrid.transform, false)
		table.insert(self.ElementCells, cell)
	end

	UGUIUtil.SetText(self.TitleText, ElementIntroduceUIApi:GetString("TitleText"))

	self.DefaultCellWidth = self.ElementCellPrefab.transform.sizeDelta.x
end

function ElementIntroduceUI:GetPreloadAssetPaths()
	return nil
end

function ElementIntroduceUI:GetOpenPreloadAssetPaths(userData)
	local paths = {}
	local cfgElementInfoData = CfgElementInfoTable[userData.cid]

	for i = 1, #cfgElementInfoData.Image do
		table.insert(paths, UIGlobalApi.GetImagePath(cfgElementInfoData.Image[i]))
	end

	return paths
end

function ElementIntroduceUI:OnOpen(userData)
	self:UpdateView(userData.cid)
end

function ElementIntroduceUI:OnClose(userData)
	return
end

function ElementIntroduceUI:OnAddListeners()
	self.CloseBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickCloseBtn)
	self.CloseBtn1:GetComponent("Button").onClick:AddListener(self.DelegateOnClickCloseBtn)
end

function ElementIntroduceUI:OnRemoveListeners()
	self.CloseBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickCloseBtn)
	self.CloseBtn1:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickCloseBtn)
end

function ElementIntroduceUI:OnPause()
	return
end

function ElementIntroduceUI:OnResume()
	return
end

function ElementIntroduceUI:OnCover()
	return
end

function ElementIntroduceUI:OnReveal()
	return
end

function ElementIntroduceUI:OnRefocus(userData)
	return
end

function ElementIntroduceUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function ElementIntroduceUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function ElementIntroduceUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function ElementIntroduceUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function ElementIntroduceUI:OnDestroy()
	for i = 1, #self.ElementCells do
		local cell = self.ElementCells[i]

		cell:Dispose()
	end
end

function ElementIntroduceUI:UpdateView(cid)
	local cfgElementInfoData = CfgElementInfoTable[cid]

	for i = 1, #self.ElementCells do
		local cell = self.ElementCells[i]
		local imgPath = cfgElementInfoData.Image[i]

		if imgPath ~= nil then
			cell:SetData(LuaCodeInterface.ToSprite(self.UIController:GetPreloadedAsset(UIGlobalApi.GetImagePath(imgPath))))
		else
			cell:SetData(nil)
		end
	end

	local cellNumInFirstRow = #cfgElementInfoData.Image % ElementIntroduceUI.COLUMN

	for i = 1, #self.ElementCells do
		local cell = self.ElementCells[i]
		local imgPath = cfgElementInfoData.Image[i]

		if imgPath ~= nil then
			if cellNumInFirstRow ~= 0 and i <= cellNumInFirstRow then
				cell:SetWidth(self.DefaultCellWidth * ElementIntroduceUI.COLUMN / cellNumInFirstRow)
			else
				cell:SetWidth(self.DefaultCellWidth)
			end
		end
	end

	UGUIUtil.SetText(self.ElementTitleText, ElementIntroduceUIApi:GetString("ElementTitleText", cfgElementInfoData.Title))
	UGUIUtil.SetText(self.DescText, ElementIntroduceUIApi:GetString("DescText", cfgElementInfoData.Describe))
end

function ElementIntroduceUI:OnClickCloseBtn()
	self:Close()
end

function ElementIntroduceUI:Close()
	UIModule.Close(Constant.UIControllerName.ElementIntroduceUI)
	MazeLogicAdapter.Instance:AddMazeOrderFromLua(MazeLogicAdapter.ORDER_ELEMENT_INTRODUCTION_CLOSED)
end

return ElementIntroduceUI
