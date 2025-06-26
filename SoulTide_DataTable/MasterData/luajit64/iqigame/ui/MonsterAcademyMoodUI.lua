-- chunkname: @IQIGame\\UI\\MonsterAcademyMoodUI.lua

local MonsterAcademyMoodUI = {
	currentPage = 1,
	pageCount = 4,
	girlList = {},
	girlCells = {}
}

MonsterAcademyMoodUI = Base:Extend("MonsterAcademyMoodUI", "IQIGame.Onigao.UI.MonsterAcademyMoodUI", MonsterAcademyMoodUI)

require("IQIGame.UIExternalApi.MonsterAcademyMoodUIApi")

local UIObjectPool = require("IQIGame.UI.Common.UIObjectPool")
local MonsterAcademyGirlCell = require("IQIGame.UI.ExploreHall.MonsterAcademy.MonsterAcademyGirlCell")

function MonsterAcademyMoodUI:OnInit()
	UGUIUtil.SetText(self.TitleText, MonsterAcademyMoodUIApi:GetString("TitleText"))

	self.scrollList = self.ScrollArea:GetComponent("ScrollAreaListPage")

	function self.scrollList.onRenderCell(cell)
		self:OnRenderCell(cell)
	end

	function self.scrollList.onPageReachedMainPos(page)
		self:OnPageReachedMain(page)
	end

	function self.DelegateOnClickNextBtn()
		self:OnClickNextBtn()
	end

	function self.DelegateOnClickPrevBtn()
		self:OnClickPrevBtn()
	end

	function self.DelegateOnClickCloseBtn()
		self:OnClickCloseBtn()
	end

	function self.DelegateUpdateMessageEvent()
		self:OnUpdateMessageEvent()
	end

	self.SoulCellPrefab:SetActive(false)

	self.girlCellPool = UIObjectPool.New(4, function()
		return MonsterAcademyGirlCell.New(UnityEngine.Object.Instantiate(self.SoulCellPrefab))
	end, function(cell)
		cell:Dispose()
	end)
end

function MonsterAcademyMoodUI:GetPreloadAssetPaths()
	return nil
end

function MonsterAcademyMoodUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function MonsterAcademyMoodUI:IsManualShowOnOpen(userData)
	return false
end

function MonsterAcademyMoodUI:GetBGM(userData)
	return nil
end

function MonsterAcademyMoodUI:OnOpen(userData)
	self.currentPage = 1

	self:UpdateView()
end

function MonsterAcademyMoodUI:OnClose(userData)
	return
end

function MonsterAcademyMoodUI:OnAddListeners()
	self.NextBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickNextBtn)
	self.PrevBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickPrevBtn)
	self.CloseBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickCloseBtn)
	EventDispatcher.AddEventListener(EventID.MonsterAcademyUpdateMessageEvent, self.DelegateUpdateMessageEvent)
end

function MonsterAcademyMoodUI:OnRemoveListeners()
	self.NextBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickNextBtn)
	self.PrevBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickPrevBtn)
	self.CloseBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickCloseBtn)
	EventDispatcher.RemoveEventListener(EventID.MonsterAcademyUpdateMessageEvent, self.DelegateUpdateMessageEvent)
end

function MonsterAcademyMoodUI:OnPause()
	return
end

function MonsterAcademyMoodUI:OnResume()
	return
end

function MonsterAcademyMoodUI:OnCover()
	return
end

function MonsterAcademyMoodUI:OnReveal()
	return
end

function MonsterAcademyMoodUI:OnRefocus(userData)
	return
end

function MonsterAcademyMoodUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function MonsterAcademyMoodUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function MonsterAcademyMoodUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function MonsterAcademyMoodUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function MonsterAcademyMoodUI:OnDestroy()
	for i, v in pairs(self.girlCells) do
		self.girlCellPool:Release(v)
	end

	self.girlCells = {}

	self.girlCellPool:Dispose()
end

function MonsterAcademyMoodUI:OnUpdateMessageEvent()
	self:UpdateView()
end

function MonsterAcademyMoodUI:UpdateView()
	self.girlList = {}

	for i, v in pairs(MonsterAcademyModule.girlDic) do
		if v.girlDataPOD.favorAbility >= 0 then
			table.insert(self.girlList, v)
		end
	end

	table.sort(self.girlList, function(a, b)
		local unlockPhone1 = a.unLockPhone and 1 or 0
		local unlockPhone2 = b.unLockPhone and 1 or 0

		if a.favor == b.favor then
			if unlockPhone1 == unlockPhone2 then
				return a.cfgID < b.cfgID
			end

			return unlockPhone2 < unlockPhone1
		end

		return a.favor > b.favor
	end)

	self.totalPage = math.ceil(#self.girlList / self.pageCount)

	for i, v in pairs(self.girlCells) do
		v.View:SetActive(false)
		v.View.transform:SetParent(self.UIController.transform, false)
		self.girlCellPool:Release(v)
	end

	self.girlCells = {}
	self.scrollList.startIndex = self.currentPage - 1

	self.scrollList:Refresh(self.totalPage)
end

function MonsterAcademyMoodUI:OnRenderCell(pageCell)
	local goObj = pageCell.gameObject

	goObj:SetActive(true)

	local index = pageCell.index + 1
	local pageGirl = self:GetCurrentPageDate(index)

	for i = 1, #pageGirl do
		local girlData = pageGirl[i]
		local cell = self.girlCellPool:Obtain()

		cell.View.transform:SetParent(goObj.transform, false)
		cell.View:SetActive(true)
		cell:SetData(girlData)
		table.insert(self.girlCells, cell)
	end
end

function MonsterAcademyMoodUI:GetCurrentPageDate(showPage)
	local tab = {}

	for i = 1, #self.girlList do
		local page = math.ceil(i / self.pageCount)

		if page == showPage then
			table.insert(tab, self.girlList[i])
		end
	end

	return tab
end

function MonsterAcademyMoodUI:OnPageReachedMain(page)
	self.currentPage = page.index + 1

	self:ShowCurrentPage()
end

function MonsterAcademyMoodUI:ShowCurrentPage()
	self.PrevBtn:SetActive(self.currentPage ~= 1)
	self.NextBtn:SetActive(self.currentPage ~= self.totalPage)
end

function MonsterAcademyMoodUI:OnClickNextBtn()
	self.scrollList:TurnToForward()
end

function MonsterAcademyMoodUI:OnClickPrevBtn()
	self.scrollList:TurnToBackward()
end

function MonsterAcademyMoodUI:OnClickCloseBtn()
	UIModule.Close(Constant.UIControllerName.MonsterAcademyMoodUI)
end

return MonsterAcademyMoodUI
