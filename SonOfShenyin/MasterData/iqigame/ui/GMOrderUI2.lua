-- chunkname: @IQIGame\\UI\\GMOrderUI2.lua

local GMOrderUI2 = {
	fatherNodeViewCellList = {},
	childNodeViewCellList = {},
	ContentItemViewList = {}
}

GMConditionType = {
	BranchLineStage = 8,
	TowerStage = 7,
	EquipDupStage = 5,
	ItemTable = 1,
	BossStage = 6,
	TASK = 10,
	GlobalBuff = 11,
	DailyDupStage = 4,
	SummerStage = 9,
	PlotDupStage = 3,
	Normal = 2
}
GMOrderUI2 = Base:Extend("GMOrderUI2", "IQIGame.Onigao.UI.GMOrderUI2", GMOrderUI2)

local GMTapItem = require("IQIGame.UI.GMOrder2.GMTapItem")
local GMContentItem = require("IQIGame.UI.GMOrder2.GMContentItem")
local GMSubmitPanel = require("IQIGame.UI.GMOrder2.GMSubmitPanel")

function GMOrderUI2:OnInit()
	LuaCodeInterface.BindOutlet(self.gameObject, self)
	self:InitComponent()
	self:InitDelegate()
end

function GMOrderUI2:InitComponent()
	self.tapScroll_Top = self.tapScroll_Top:GetComponent("ScrollAreaList")

	function self.tapScroll_Top.onRenderCell(gridCell)
		self:OnTapScroll_TopRenderGridCell(gridCell)
	end

	self.tapScroll_Left = self.tapScroll_Left:GetComponent("ScrollAreaList")

	function self.tapScroll_Left.onRenderCell(gridCell)
		self:OnTapScroll_LeftRenderGridCell(gridCell)
	end

	self.optimizedContentScroll = self.optimizedContentScroll:GetComponent("OptimizedScrollRect")

	self.optimizedContentScroll:NormalInit(function(OptimizedParams, OptimizedViewsHolder)
		self:UpdateContentScroll(OptimizedParams, OptimizedViewsHolder)
	end)

	self.GMSubmitPanel = GMSubmitPanel.New(self.SubmitPanel)

	self.GMSubmitPanel:Close()

	self.btnReturn = self.btnReturn:GetComponent("Button")
	self.btnExecute = self.btnExecute:GetComponent("Button")
	self.btnSearch = self.btnSearch:GetComponent("Button")
	self.btnReset = self.btnReset:GetComponent("Button")
	self.btnDoAll = self.btnDoAll:GetComponent("Button")
	self.inputIdSearch = self.inputIdSearch:GetComponent("IQIGame.Onigao.Game.UI.InputField")
	self.inputNameSearch = self.inputNameSearch:GetComponent("IQIGame.Onigao.Game.UI.InputField")
	self.inputDesSearch = self.inputDesSearch:GetComponent("IQIGame.Onigao.Game.UI.InputField")
end

function GMOrderUI2:InitDelegate()
	function self.CloseDelegate(_self, go)
		self:Close()
	end

	function self.ExecuteDelegate()
		self:OnClickBtnExecute()
	end

	function self.SearchBtnDelegate()
		self:OnClickBtnSearch()
	end

	function self.ResetBtnDelegate()
		self:OnClickBtnReset()
	end

	function self.tapClickDelegate(index, isFather)
		self:TapClick(index, isFather)
	end

	function self.contentClickDelegate(data)
		self:ContentClick(data)
	end

	function self.btnDoAllDelegate()
		self:OnBtnDoAllClick()
	end
end

function GMOrderUI2:OnAddListeners()
	self.btnReturn.onClick:AddListener(self.CloseDelegate)
	self.btnExecute.onClick:AddListener(self.ExecuteDelegate)
	self.btnSearch.onClick:AddListener(self.SearchBtnDelegate)
	self.btnReset.onClick:AddListener(self.ResetBtnDelegate)
	self.btnDoAll.onClick:AddListener(self.btnDoAllDelegate)
	EventDispatcher.AddEventListener(EventID.GMTapClick, self.tapClickDelegate)
	EventDispatcher.AddEventListener(EventID.GMContentClick, self.contentClickDelegate)
end

function GMOrderUI2:OnRemoveListeners()
	self.btnReturn.onClick:RemoveListener(self.CloseDelegate)
	self.btnExecute.onClick:RemoveListener(self.ExecuteDelegate)
	self.btnSearch.onClick:RemoveListener(self.SearchBtnDelegate)
	self.btnReset.onClick:RemoveListener(self.ResetBtnDelegate)
	self.btnDoAll.onClick:RemoveListener(self.btnDoAllDelegate)
	EventDispatcher.RemoveEventListener(EventID.GMTapClick, self.tapClickDelegate)
	EventDispatcher.RemoveEventListener(EventID.GMContentClick, self.contentClickDelegate)
end

function GMOrderUI2:OnOpen(userData)
	self:RefreshScroll()
	self.GMSubmitPanel:Close()
end

function GMOrderUI2:OnClose(userData)
	self.ChildData = nil
end

function GMOrderUI2:GetPreloadAssetPaths()
	return nil
end

function GMOrderUI2:GetOpenPreloadAssetPaths(userData)
	return nil
end

function GMOrderUI2:IsManualShowOnOpen(userData)
	return false
end

function GMOrderUI2:GetBGM(userData)
	return nil
end

function GMOrderUI2:OnPause()
	return
end

function GMOrderUI2:OnResume()
	return
end

function GMOrderUI2:OnCover()
	return
end

function GMOrderUI2:OnReveal()
	return
end

function GMOrderUI2:OnRefocus(userData)
	return
end

function GMOrderUI2:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function GMOrderUI2:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function GMOrderUI2:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function GMOrderUI2:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function GMOrderUI2:OnDestroy()
	for i, v in pairs(self.fatherNodeViewCellList) do
		v:OnDestroy()
	end

	for i, v in pairs(self.childNodeViewCellList) do
		v:OnDestroy()
	end

	for i, v in pairs(self.ContentItemViewList) do
		v:OnDestroy()
	end

	self.GMSubmitPanel:OnDestroy()
end

function GMOrderUI2:Close()
	UIModule.Close(Constant.UIControllerName.GMOrderUI2)
end

function GMOrderUI2:OnClickBtnExecute()
	if self.ChildData then
		if self.ChildData.InputName and #self.ChildData.InputName > 0 then
			self.GMSubmitPanel:Show(self.ChildData)
		elseif self.ChildData.Cmd then
			GMOrder2Module.SendCMD(self.ChildData.Cmd)
		end
	end
end

function GMOrderUI2:OnClickBtnSearch()
	local IDOption = self.inputIdSearch.text
	local NameOption = self.inputNameSearch.text
	local DesOption = self.inputDesSearch.text
	local filterList = {}

	if IDOption ~= "" then
		for i, v in pairs(self.ContentItemList) do
			if string.match(tostring(v.Id), IDOption) then
				table.insert(filterList, v)
			end
		end

		if NameOption ~= "" then
			for i, v in pairs(filterList) do
				if not string.match(tostring(v.Name), NameOption) then
					table.removeElement(filterList, v)
				end
			end
		end

		if DesOption ~= "" then
			for i, v in pairs(filterList) do
				if not string.match(tostring(v.ItemTips), DesOption) then
					table.removeElement(filterList, v)
				end
			end
		end

		self.ContentItemList = filterList

		self:RefreshOptimizedContentScroll()

		return
	end

	if NameOption ~= "" then
		for i, v in pairs(self.ContentItemList) do
			if string.match(tostring(v.Name), NameOption) then
				table.insert(filterList, v)
			end
		end

		if DesOption ~= "" then
			for i, v in pairs(filterList) do
				if not string.match(tostring(v.ItemTips), DesOption) then
					table.removeElement(filterList, v)
				end
			end
		end

		self.ContentItemList = filterList

		self:RefreshOptimizedContentScroll()

		return
	end

	if DesOption ~= "" then
		for i, v in pairs(self.ContentItemList) do
			if string.match(tostring(v.ItemTips), DesOption) then
				table.insert(filterList, v)
			end
		end

		self.ContentItemList = filterList

		self:RefreshOptimizedContentScroll()
	end
end

function GMOrderUI2:OnClickBtnReset()
	self.inputIdSearch.text = ""
	self.inputNameSearch.text = ""
	self.inputDesSearch.text = ""

	self:RefreshContentScroll(self.ChildData)
end

function GMOrderUI2:RefreshScroll()
	self.fatherNodeList = GMOrder2Module.GetFatherNode()

	self.tapScroll_Top:Refresh(#self.fatherNodeList)
	self:RefreshChildTap(self.fatherNodeList[1].Id)
end

function GMOrderUI2:RefreshChildTap(parentID)
	self.childNodeList = GMOrder2Module.GetChildNodeWithID(parentID)

	self.tapScroll_Left:Refresh(#self.childNodeList)
end

function GMOrderUI2:RefreshContentScroll(data)
	self.ContentItemList = {}

	if data.ConditionType > 0 then
		self:SetContentScrollShow(true)

		if data.ConditionType == GMConditionType.ItemTable then
			self.ContentItemList = GMOrder2Module.GetItemWithType(data.Condition)
		elseif data.ConditionType == GMConditionType.Normal then
			local tempList = GMOrder2Module.GetChildNodeWithID(data.Id)

			for i, v in pairs(tempList) do
				if v.Cmd then
					v.ItemTips = v.Cmd
				end
			end

			self.ContentItemList = tempList
		elseif data.ConditionType == GMConditionType.PlotDupStage then
			local tempList = GMOrder2Module.GetStage(GMConditionType.PlotDupStage)

			for i, v in pairs(tempList) do
				if v.ItemType == Constant.MapStageType.MainLine and v.Desc then
					v.ItemTips = v.Desc
				end
			end

			self.ContentItemList = tempList
		elseif data.ConditionType == GMConditionType.DailyDupStage then
			local tempList = GMOrder2Module.GetStage(GMConditionType.DailyDupStage)

			for i, v in pairs(tempList) do
				if v.Desc then
					v.ItemTips = v.Desc
				end
			end

			self.ContentItemList = tempList
		elseif data.ConditionType == GMConditionType.EquipDupStage then
			local tempList = GMOrder2Module.GetStage(GMConditionType.EquipDupStage)

			for i, v in pairs(tempList) do
				if v.Desc then
					v.ItemTips = v.Desc
				end
			end

			self.ContentItemList = tempList
		elseif data.ConditionType == GMConditionType.BossStage then
			local tempList = GMOrder2Module.GetStage(GMConditionType.BossStage)

			for i, v in pairs(tempList) do
				if v.Desc then
					v.ItemTips = v.Desc
				end
			end

			self.ContentItemList = tempList
		elseif data.ConditionType == GMConditionType.TowerStage then
			local tempList = GMOrder2Module.GetStage(GMConditionType.TowerStage)

			for i, v in pairs(tempList) do
				if v.Desc then
					v.ItemTips = v.Desc .. "-" .. v.Level
				end
			end

			self.ContentItemList = tempList
		elseif data.ConditionType == GMConditionType.BranchLineStage then
			local tempList = GMOrder2Module.GetStage(GMConditionType.BranchLineStage)

			for i, v in pairs(tempList) do
				if v.Desc then
					v.ItemTips = v.Desc
				end
			end

			self.ContentItemList = tempList
		elseif data.ConditionType == GMConditionType.SummerStage then
			local tempList = GMOrder2Module.GetStage(GMConditionType.SummerStage)

			for i, v in pairs(tempList) do
				if v.Desc then
					v.ItemTips = v.Desc
				end
			end

			self.ContentItemList = tempList
		elseif data.ConditionType == GMConditionType.TASK then
			local types = {}

			for _, v in pairs(data.Condition) do
				table.insert(types, tonumber(v))
			end

			local tempList = GMOrder2Module.GetTask(types)

			for i, v in pairs(tempList) do
				if v.Desc then
					v.ItemTips = v.Desc
				end
			end

			self.ContentItemList = tempList
		elseif data.ConditionType == GMConditionType.GlobalBuff then
			local types = {}

			for _, v in pairs(data.Condition) do
				table.insert(types, tonumber(v))
			end

			local tempList = GMOrder2Module.GetGlobalBuff(types)

			for i, v in pairs(tempList) do
				if v.Describe then
					v.ItemTips = v.Describe
				end
			end

			self.ContentItemList = tempList
		end

		self.ContentType = data.ConditionType
		self.ChildData = data

		self:RefreshOptimizedContentScroll()
	end
end

function GMOrderUI2:RefreshOptimizedContentScroll()
	self.optimizedContentScroll:RefreshByItemCount(#self.ContentItemList)

	if #self.ContentItemList > 0 then
		self.optimizedContentScroll:ScrollTo(0)
	end
end

function GMOrderUI2:SetContentScrollShow(show)
	LuaUtility.SetGameObjectShow(self.optimizedContentScroll.gameObject, show)
	LuaUtility.SetGameObjectShow(self.SearchPanel, show)
end

function GMOrderUI2:OnTapScroll_TopRenderGridCell(gridCell)
	local index = gridCell.index + 1
	local data = self.fatherNodeList[index]

	if self.fatherNodeViewCellList[index] == nil then
		local Tap = GMTapItem.New(index, gridCell.gameObject, true)

		Tap:Refresh(data)

		self.fatherNodeViewCellList[index] = Tap
	end

	self.fatherNodeViewCellList[index]:Refresh(data)

	gridCell.transform.parent.gameObject.name = index

	if gridCell.index == 0 then
		self.fatherNodeViewCellList[index]:_OnClick()
	end
end

function GMOrderUI2:OnTapScroll_LeftRenderGridCell(gridCell)
	if not self.childNodeList then
		return
	end

	local index = gridCell.index + 1
	local data = self.childNodeList[index]
	local insID = gridCell.gameObject:GetInstanceID()

	if self.childNodeViewCellList[insID] == nil then
		local Tap = GMTapItem.New(insID, gridCell.gameObject, false)

		self.childNodeViewCellList[insID] = Tap
	end

	self.childNodeViewCellList[insID]:Refresh(data)

	gridCell.transform.parent.gameObject.name = index

	if gridCell.index == 0 then
		self.childNodeViewCellList[insID]:_OnClick()
	end
end

function GMOrderUI2:OnContentScrollRenderGridCell(gridCell)
	local index = gridCell.index + 1
	local data = self.ContentItemList[index]
	local insID = gridCell.gameObject:GetInstanceID()

	if self.ContentItemViewList[insID] == nil then
		local Item = GMContentItem.New(gridCell.gameObject)

		self.ContentItemViewList[insID] = Item
	end

	self.ContentItemViewList[insID]:Refresh(data, self.ContentType)
end

function GMOrderUI2:UpdateContentScroll(OptimizedParams, OptimizedViewsHolder)
	local viewGameObject = OptimizedViewsHolder.root.gameObject
	local instanceID = OptimizedViewsHolder.instanceID
	local index = OptimizedViewsHolder.ItemIndex
	local data = self.ContentItemList[index + 1]

	if not self.ContentItemViewList[instanceID] then
		self.ContentItemViewList[instanceID] = GMContentItem.New(viewGameObject)
	end

	self.ContentItemViewList[instanceID]:Refresh(data, self.ContentType)
end

function GMOrderUI2:ExecuteCMD(cmd)
	if cmd then
		GMOrder2Module.SendCMD(cmd)
	end
end

function GMOrderUI2:TapClick(isFather, tap)
	if isFather then
		if tap == self.curSelectTopTap then
			return
		end

		if self.curSelectTopTap then
			self.curSelectTopTap:SetSelect(false)
		end

		self.curSelectTopTap = tap

		self:RefreshChildTap(tap.data.Id)
	else
		if tap == self.curSelectLeftTap then
			self:RefreshContentScroll(tap.data)

			return
		end

		if self.curSelectLeftTap then
			self.curSelectLeftTap:SetSelect(false)
		end

		self.curSelectLeftTap = tap

		self:RefreshContentScroll(tap.data)
	end
end

function GMOrderUI2:ContentClick(data)
	if self.ChildData.ConditionType == GMConditionType.ItemTable or self.ChildData.ConditionType == GMConditionType.GlobalBuff then
		self:ExecuteCMD(string.format("%s %s %s", self.ChildData.Cmd, data.cfg.Id, data.num))
	elseif self.ChildData.ConditionType == GMConditionType.Normal then
		local isExecute = GMOrder2Module.ExecuteMethod(data.cfg.NodeType)

		if isExecute == true then
			return
		end

		if data.cfg.InputName and #data.cfg.InputName > 0 then
			self.GMSubmitPanel:Show(data.cfg)
		else
			self:ExecuteCMD(data.cfg.Cmd)
		end
	elseif self.ChildData.ConditionType == GMConditionType.PlotDupStage or self.ChildData.ConditionType == GMConditionType.BossStage or self.ChildData.ConditionType == GMConditionType.TowerStage or self.ChildData.ConditionType == GMConditionType.DailyDupStage or self.ChildData.ConditionType == GMConditionType.EquipDupStage or self.ChildData.ConditionType == GMConditionType.BranchLineStage or self.ChildData.ConditionType == GMConditionType.SummerStage or self.ChildData.ConditionType == GMConditionType.TASK then
		local cmd = self.ChildData.Cmd .. " " .. data.cfg.Id

		self:ExecuteCMD(cmd)
	end
end

function GMOrderUI2:OnBtnDoAllClick()
	if self.ChildData.ConditionType == GMConditionType.ItemTable then
		coroutine.start(function()
			for i, v in pairs(self.ContentItemList) do
				coroutine.wait(0.1)

				if self.ChildData.inputDefault[1] then
					self:ExecuteCMD(self.ChildData.Cmd .. " " .. v.Id .. " " .. self.ChildData.inputDefault[1])
				else
					self:ExecuteCMD(self.ChildData.Cmd .. " " .. v.Id .. " " .. "1")
				end
			end
		end)
	elseif self.ChildData.ConditionType == GMConditionType.Normal then
		-- block empty
	elseif self.ChildData.ConditionType == GMConditionType.PlotDupStage or self.ChildData.ConditionType == GMConditionType.BossStage or self.ChildData.ConditionType == GMConditionType.TowerStage or self.ChildData.ConditionType == GMConditionType.DailyDupStage or self.ChildData.ConditionType == GMConditionType.EquipDupStage or self.ChildData.ConditionType == GMConditionType.BranchLineStage then
		coroutine.start(function()
			for i, v in pairs(self.ContentItemList) do
				coroutine.wait(0.1)
				self:ExecuteCMD(self.ChildData.Cmd .. " " .. v.Id)
			end
		end)
	end
end

return GMOrderUI2
