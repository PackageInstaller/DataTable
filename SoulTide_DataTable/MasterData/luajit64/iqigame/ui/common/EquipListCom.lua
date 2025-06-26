-- chunkname: @IQIGame\\UI\\Common\\EquipListCom.lua

local EquipListCom = {
	cells = {}
}

function EquipListCom.New(go, UIController, onRenderCellDelegate, onSelectedCellDelegate)
	local o = Clone(EquipListCom)

	o:Initialize(go, UIController, onRenderCellDelegate, onSelectedCellDelegate)

	return o
end

function EquipListCom:Initialize(go, UIController, onRenderCellDelegate, onSelectedCellDelegate)
	self.View = go

	LuaCodeInterface.BindOutlet(self.View, self)

	function self.DelegateOnClickBtnSetting()
		self:OnClickBtnSetting()
	end

	self.UIController = UIController
	self.onRenderCellDelegate = onRenderCellDelegate
	self.onSelectedCellDelegate = onSelectedCellDelegate
	self.belongIsWoreSort = true
	self.tfNum = self.goNum:GetComponent("Text")
	self.btnFilter = self.goBtnFilter:GetComponent("Button")
	self.btnFilterReset = self.goBtnFilterReset:GetComponent("Button")
	self.btnSort = self.goBtnSort:GetComponent("Button")

	function self.onClickBtnFilterResetDelegate()
		self:OnClickBtnFilterReset()
	end

	function self.onClickBtnFilterDelegate()
		self:OnClickBtnFilter()
	end

	function self.onClickBtnSortDelegate()
		self:OnClickBtnSort()
	end

	self.scrollList = self.goScrollArea:GetComponent("ScrollAreaList")

	function self.scrollList.onRenderCell(cell)
		self:OnRenderGridCell(cell)
	end

	function self.scrollList.onSelectedCell(cell)
		self:OnSelectedGridCell(cell)
	end

	self.goBtnSort.transform:Find("Text"):GetComponent("Text").text = EquipListUIApi:GetString("goSortTxt")
	self.goBtnFilter.transform:Find("State_1/Text"):GetComponent("Text").text = EquipListUIApi:GetString("goBtnFilterTxt")
	self.goBtnFilter.transform:Find("State_2/Text"):GetComponent("Text").text = EquipListUIApi:GetString("goBtnFilterTxt")
	self.SignEmptyDesc:GetComponent("Text").text = EquipListUIApi:GetString("SignEmptyDesc")
end

function EquipListCom:Refresh()
	self.sortQuality = 0

	self:AddListener()
end

function EquipListCom:AddListener()
	self.btnFilter.onClick:AddListener(self.onClickBtnFilterDelegate)
	self.btnSort.onClick:AddListener(self.onClickBtnSortDelegate)
	self.btnFilterReset.onClick:AddListener(self.onClickBtnFilterResetDelegate)
	self.goBtnSetting:GetComponent(typeof(UnityEngine.UI.Button)).onClick:AddListener(self.DelegateOnClickBtnSetting)
end

function EquipListCom:RemoveListener()
	self.btnFilter.onClick:RemoveListener(self.onClickBtnFilterDelegate)
	self.btnSort.onClick:RemoveListener(self.onClickBtnSortDelegate)
	self.btnFilterReset.onClick:RemoveListener(self.onClickBtnFilterResetDelegate)
	self.goBtnSetting:GetComponent(typeof(UnityEngine.UI.Button)).onClick:RemoveListener(self.DelegateOnClickBtnSetting)
end

function EquipListCom:OnHide()
	EquipModule.ResetEquipListUISort()
	EquipModule.ResetEquipListUIScreen()
	self:RemoveListener()
end

function EquipListCom:OnDestroy()
	for i, v in pairs(self.cells) do
		v:OnDestroy()
	end

	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

function EquipListCom:OnClickBtnFilterReset()
	EquipModule.ResetEquipListUIScreen()
	EventDispatcher.Dispatch(EventID.EquipSortRefresh)
end

function EquipListCom:OnClickBtnSort()
	UIModule.Open(Constant.UIControllerName.EquipListSortUI, Constant.UILayer.UI)
end

function EquipListCom:OnClickBtnFilter()
	UIModule.Open(Constant.UIControllerName.EquipListScreenUI, Constant.UILayer.UI)
end

function EquipListCom:OnRenderGridCell(grid)
	local luaIndex = grid.index + 1
	local itemData = self.curDatum[luaIndex]
	local insID = grid.gameObject:GetInstanceID()
	local cell = self.cells[insID]

	if cell == nil then
		cell = EquipCell.New(grid.gameObject)
		cell.useSmallIcon = true
		cell.enableClick = false
		self.cells[insID] = cell
	end

	grid.gameObject.name = luaIndex

	cell:Refresh(itemData)

	if itemData.id == 0 then
		cell:SetGray(true)
	else
		cell:SetGray(false)
	end

	if self.onRenderCellDelegate ~= nil then
		self.onRenderCellDelegate(itemData, cell)
	end
end

function EquipListCom:OnSelectedGridCell(grid)
	local luaIndex = grid.index + 1
	local itemData = self.curDatum[luaIndex]
	local insID = grid.gameObject:GetInstanceID()
	local cell = self.cells[insID]

	if self.onSelectedCellDelegate ~= nil then
		self.onSelectedCellDelegate(itemData, cell)
	end
end

function EquipListCom:SortCells(allItemData, dynamicRefresh)
	self.allItemData = allItemData
	self.curDatum = {}

	local selfWoreData

	for i, v in pairs(self.allItemData) do
		local cfgItemData = v:GetCfg()

		if self.sortQuality == 0 or cfgItemData.Quality == self.sortQuality then
			if self.toPutOffEquipId ~= nil then
				if self.toPutOffEquipId ~= v.id then
					self.curDatum[#self.curDatum + 1] = v
				else
					selfWoreData = v
				end
			else
				self.curDatum[#self.curDatum + 1] = v
			end
		end
	end

	if EquipModule.equipListUISort.selectedIndex == 1 then
		table.sort(self.curDatum, function(itemData1, itemData2)
			local cfgItemData1 = itemData1:GetCfg()
			local cfgItemData2 = itemData2:GetCfg()

			if itemData1.id == itemData2.id or itemData1.id ~= 0 and itemData2.id ~= 0 then
				if self.belongIsWoreSort then
					if itemData1.equipData.isWore == itemData2.equipData.isWore then
						if cfgItemData1.Quality == cfgItemData2.Quality then
							if itemData1.equipData.star == itemData2.equipData.star then
								if itemData1.equipData.lv == itemData2.equipData.lv then
									return self:SortCompare(cfgItemData1.Id, cfgItemData2.Id, true)
								end

								return self:SortCompare(itemData1.equipData.lv, itemData2.equipData.lv, EquipModule.equipListUISort.sortState[3])
							end

							return self:SortCompare(itemData1.equipData.star, itemData2.equipData.star, EquipModule.equipListUISort.sortState[2])
						end

						return self:SortCompare(cfgItemData1.Quality, cfgItemData2.Quality, EquipModule.equipListUISort.sortState[1])
					else
						return itemData1.equipData.isWore
					end
				else
					if cfgItemData1.Quality == cfgItemData2.Quality then
						if itemData1.equipData.star == itemData2.equipData.star then
							if itemData1.equipData.lv == itemData2.equipData.lv then
								return self:SortCompare(cfgItemData1.Id, cfgItemData2.Id, true)
							end

							return self:SortCompare(itemData1.equipData.lv, itemData2.equipData.lv, EquipModule.equipListUISort.sortState[3])
						end

						return self:SortCompare(itemData1.equipData.star, itemData2.equipData.star, EquipModule.equipListUISort.sortState[2])
					end

					return self:SortCompare(cfgItemData1.Quality, cfgItemData2.Quality, EquipModule.equipListUISort.sortState[1])
				end
			elseif itemData1.id == 0 and itemData2.id ~= 0 then
				return true
			elseif itemData1.id ~= 0 and itemData2.id == 0 then
				return false
			end
		end)
	elseif EquipModule.equipListUISort.selectedIndex == 2 then
		table.sort(self.curDatum, function(itemData1, itemData2)
			local cfgItemData1 = itemData1:GetCfg()
			local cfgItemData2 = itemData2:GetCfg()

			if itemData1.id == itemData2.id or itemData1.id ~= 0 and itemData2.id ~= 0 then
				if self.belongIsWoreSort then
					if itemData1.equipData.isWore == itemData2.equipData.isWore then
						if itemData1.equipData.star == itemData2.equipData.star then
							if cfgItemData1.Quality == cfgItemData2.Quality then
								if itemData1.equipData.lv == itemData2.equipData.lv then
									return self:SortCompare(cfgItemData1.Id, cfgItemData2.Id, true)
								end

								return self:SortCompare(itemData1.equipData.lv, itemData2.equipData.lv, EquipModule.equipListUISort.sortState[3])
							end

							return self:SortCompare(cfgItemData1.Quality, cfgItemData2.Quality, EquipModule.equipListUISort.sortState[1])
						end

						return self:SortCompare(itemData1.equipData.star, itemData2.equipData.star, EquipModule.equipListUISort.sortState[2])
					else
						return itemData1.equipData.isWore
					end
				else
					if itemData1.equipData.star == itemData2.equipData.star then
						if cfgItemData1.Quality == cfgItemData2.Quality then
							if itemData1.equipData.lv == itemData2.equipData.lv then
								return self:SortCompare(cfgItemData1.Id, cfgItemData2.Id, true)
							end

							return self:SortCompare(itemData1.equipData.lv, itemData2.equipData.lv, EquipModule.equipListUISort.sortState[3])
						end

						return self:SortCompare(cfgItemData1.Quality, cfgItemData2.Quality, EquipModule.equipListUISort.sortState[1])
					end

					return self:SortCompare(itemData1.equipData.star, itemData2.equipData.star, EquipModule.equipListUISort.sortState[2])
				end
			elseif itemData1.id == 0 and itemData2.id ~= 0 then
				return true
			elseif itemData1.id ~= 0 and itemData2.id == 0 then
				return false
			end
		end)
	elseif EquipModule.equipListUISort.selectedIndex == 3 then
		table.sort(self.curDatum, function(itemData1, itemData2)
			local cfgItemData1 = itemData1:GetCfg()
			local cfgItemData2 = itemData2:GetCfg()

			if itemData1.id == itemData2.id or itemData1.id ~= 0 and itemData2.id ~= 0 then
				if self.belongIsWoreSort then
					if itemData1.equipData.isWore == itemData2.equipData.isWore then
						if itemData1.equipData.lv == itemData2.equipData.lv then
							if cfgItemData1.Quality == cfgItemData2.Quality then
								if itemData1.equipData.star == itemData2.equipData.star then
									return self:SortCompare(cfgItemData1.Id, cfgItemData2.Id, true)
								end

								return self:SortCompare(itemData1.equipData.star, itemData2.equipData.star, EquipModule.equipListUISort.sortState[2])
							end

							return self:SortCompare(cfgItemData1.Quality, cfgItemData2.Quality, EquipModule.equipListUISort.sortState[1])
						end

						return self:SortCompare(itemData1.equipData.lv, itemData2.equipData.lv, EquipModule.equipListUISort.sortState[3])
					else
						return itemData1.equipData.isWore
					end
				else
					if itemData1.equipData.lv == itemData2.equipData.lv then
						if cfgItemData1.Quality == cfgItemData2.Quality then
							if itemData1.equipData.star == itemData2.equipData.star then
								return self:SortCompare(cfgItemData1.Id, cfgItemData2.Id, true)
							end

							return self:SortCompare(itemData1.equipData.star, itemData2.equipData.star, EquipModule.equipListUISort.sortState[2])
						end

						return self:SortCompare(cfgItemData1.Quality, cfgItemData2.Quality, EquipModule.equipListUISort.sortState[1])
					end

					return self:SortCompare(itemData1.equipData.lv, itemData2.equipData.lv, EquipModule.equipListUISort.sortState[3])
				end
			elseif itemData1.id == 0 and itemData2.id ~= 0 then
				return true
			elseif itemData1.id ~= 0 and itemData2.id == 0 then
				return false
			end
		end)
	elseif EquipModule.equipListUISort.selectedIndex == 4 then
		table.sort(self.curDatum, function(itemData1, itemData2)
			local cfgItemData1 = itemData1:GetCfg()
			local cfgItemData2 = itemData2:GetCfg()

			if itemData1.id == itemData2.id or itemData1.id ~= 0 and itemData2.id ~= 0 then
				if self.belongIsWoreSort then
					if itemData1.equipData.isWore == itemData2.equipData.isWore then
						if cfgItemData1.Id == cfgItemData2.Id then
							if cfgItemData1.Quality == cfgItemData2.Quality then
								if itemData1.equipData.star == itemData2.equipData.star then
									if itemData1.equipData.lv == itemData2.equipData.lv then
										return self:SortCompare(cfgItemData1.Id, cfgItemData2.Id, true)
									end

									return self:SortCompare(itemData1.equipData.lv, itemData2.equipData.lv, EquipModule.equipListUISort.sortState[3])
								end

								return self:SortCompare(itemData1.equipData.star, itemData2.equipData.star, EquipModule.equipListUISort.sortState[2])
							end

							return self:SortCompare(cfgItemData1.Quality, cfgItemData2.Quality, EquipModule.equipListUISort.sortState[1])
						end

						return self:SortCompare(cfgItemData1.Id, cfgItemData2.Id, EquipModule.equipListUISort.sortState[4])
					else
						return itemData1.equipData.isWore
					end
				else
					if cfgItemData1.Id == cfgItemData2.Id then
						if cfgItemData1.Quality == cfgItemData2.Quality then
							if itemData1.equipData.star == itemData2.equipData.star then
								if itemData1.equipData.lv == itemData2.equipData.lv then
									return self:SortCompare(cfgItemData1.Id, cfgItemData2.Id, true)
								end

								return self:SortCompare(itemData1.equipData.lv, itemData2.equipData.lv, EquipModule.equipListUISort.sortState[3])
							end

							return self:SortCompare(itemData1.equipData.star, itemData2.equipData.star, EquipModule.equipListUISort.sortState[2])
						end

						return self:SortCompare(cfgItemData1.Quality, cfgItemData2.Quality, EquipModule.equipListUISort.sortState[1])
					end

					return self:SortCompare(cfgItemData1.Id, cfgItemData2.Id, EquipModule.equipListUISort.sortState[4])
				end
			elseif itemData1.id == 0 and itemData2.id ~= 0 then
				return true
			elseif itemData1.id ~= 0 and itemData2.id == 0 then
				return false
			end
		end)
	elseif EquipModule.equipListUISort.selectedIndex == 5 then
		local itemCidNumMap = WarehouseModule.GetItemCIDNumMap()

		table.sort(self.curDatum, function(itemData1, itemData2)
			local cfgItemData1 = itemData1:GetCfg()
			local cfgItemData2 = itemData2:GetCfg()
			local count1 = itemCidNumMap[cfgItemData1.Id]
			local count2 = itemCidNumMap[cfgItemData2.Id]

			if itemData1.id == itemData2.id or itemData1.id ~= 0 and itemData2.id ~= 0 then
				if self.belongIsWoreSort then
					if itemData1.equipData.isWore == itemData2.equipData.isWore then
						if count1 == count2 then
							if cfgItemData1.Quality == cfgItemData2.Quality then
								if cfgItemData1.Id == cfgItemData2.Id then
									if itemData1.equipData.star == itemData2.equipData.star then
										return self:SortCompare(itemData1.equipData.lv, itemData2.equipData.lv, true)
									end

									return self:SortCompare(itemData1.equipData.star, itemData2.equipData.star, EquipModule.equipListUISort.sortState[2])
								end

								return self:SortCompare(cfgItemData1.Id, cfgItemData2.Id, EquipModule.equipListUISort.sortState[4])
							end

							return self:SortCompare(cfgItemData1.Quality, cfgItemData2.Quality, EquipModule.equipListUISort.sortState[1])
						end

						return self:SortCompare(count1, count2, EquipModule.equipListUISort.sortState[5])
					else
						return itemData1.equipData.isWore
					end
				else
					if count1 == count2 then
						if cfgItemData1.Quality == cfgItemData2.Quality then
							if cfgItemData1.Id == cfgItemData2.Id then
								if itemData1.equipData.star == itemData2.equipData.star then
									return self:SortCompare(itemData1.equipData.lv, itemData2.equipData.lv, true)
								end

								return self:SortCompare(itemData1.equipData.star, itemData2.equipData.star, EquipModule.equipListUISort.sortState[2])
							end

							return self:SortCompare(cfgItemData1.Id, cfgItemData2.Id, EquipModule.equipListUISort.sortState[4])
						end

						return self:SortCompare(cfgItemData1.Quality, cfgItemData2.Quality, EquipModule.equipListUISort.sortState[1])
					end

					return self:SortCompare(count1, count2, EquipModule.equipListUISort.sortState[5])
				end
			elseif itemData1.id == 0 and itemData2.id ~= 0 then
				return true
			elseif itemData1.id ~= 0 and itemData2.id == 0 then
				return false
			end
		end)
	end

	local filterPattern = EquipModule.OldDataToFilterPattern()
	local doneFilter = not EquipListUtil.IsFilterEmpty(filterPattern)

	if doneFilter then
		self.curDatum = EquipListUtil.Filter(self.curDatum, filterPattern)
	end

	self.tfNum.text = EquipListUIApi:GetString("goNum", #self.curDatum, #self.allItemData)

	self.goBtnFilter.transform:Find("State_1").gameObject:SetActive(not doneFilter)
	self.goBtnFilter.transform:Find("State_2").gameObject:SetActive(doneFilter)
	self.goBtnFilterReset:SetActive(doneFilter)

	if selfWoreData ~= nil then
		table.insert(self.curDatum, 1, selfWoreData)
	end

	if dynamicRefresh then
		self.scrollList:RenderCellsDynamic(#self.curDatum)
	else
		self.scrollList.startIndex = 0

		self.scrollList:Refresh(#self.curDatum)
	end

	self.SignEmpty:SetActive(#self.curDatum == 0)
end

function EquipListCom:SortCompare(data1, data2, desc)
	if desc then
		return data2 < data1
	end

	return data1 < data2
end

function EquipListCom:RefreshCells()
	self.scrollList:RenderCells()
end

function EquipListCom:OnClickBtnSetting()
	UIModule.Open(Constant.UIControllerName.SettingUI, Constant.UILayer.UI, true)
end

return EquipListCom
