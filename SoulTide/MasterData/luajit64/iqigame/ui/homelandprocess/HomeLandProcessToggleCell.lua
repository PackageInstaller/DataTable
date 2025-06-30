-- chunkname: @IQIGame\\UI\\HomeLandProcess\\HomeLandProcessToggleCell.lua

local HomeLandProcessToggleCell = {}

function HomeLandProcessToggleCell.PackageOrReuseView(ui, mouldPrefab)
	if ui == nil or mouldPrefab == nil then
		return nil
	end

	if ui.SUB_UI_MAP_ProcessToggleElement == nil then
		ui.SUB_UI_MAP_ProcessToggleElement = {}
	end

	local subUIMap = ui.SUB_UI_MAP_ProcessToggleElement
	local eventCell

	if subUIMap[mouldPrefab:GetInstanceID()] == nil then
		eventCell = HomeLandProcessToggleCell.__New(mouldPrefab)
		subUIMap[mouldPrefab:GetInstanceID()] = eventCell
	else
		eventCell = subUIMap[mouldPrefab:GetInstanceID()]
	end

	return eventCell
end

function HomeLandProcessToggleCell.__New(itemCellView)
	local itemCell = Clone(HomeLandProcessToggleCell)

	itemCell:Init(itemCellView)

	return itemCell
end

function HomeLandProcessToggleCell:Init(view)
	self.goView = view

	LuaCodeInterface.BindOutlet(self.goView, self)
	self:AddListener()
end

function HomeLandProcessToggleCell:AddListener()
	return
end

function HomeLandProcessToggleCell:RemoveListener()
	return
end

function HomeLandProcessToggleCell.DisposeIn(ui)
	if ui.SUB_UI_MAP_ProcessToggleElement == nil then
		return
	end

	for i, itemCell in pairs(ui.SUB_UI_MAP_ProcessToggleElement) do
		itemCell:Dispose()
	end

	ui.SUB_UI_MAP_ProcessToggleElement = nil
end

function HomeLandProcessToggleCell:SetData(data)
	self.showData = data

	self:Update()
end

function HomeLandProcessToggleCell:Update()
	if self.showData then
		UGUIUtil.SetText(self.TextDown1, self.showData[2])
		UGUIUtil.SetText(self.TextUp1, self.showData[2])

		local imgDown = HomeLandMakeItemListUIApi:GetString("ImgDown", self.showData[1])
		local imgUp = HomeLandMakeItemListUIApi:GetString("ImgUp", self.showData[1])

		AssetUtil.LoadImage(self, imgDown, self.ImgDown:GetComponent("Image"))
		AssetUtil.LoadImage(self, imgUp, self.ImgUp:GetComponent("Image"))
	end
end

function HomeLandProcessToggleCell:Select(top)
	self.ToggleDown:SetActive(not top)
	self.ToggleUp:SetActive(top)
end

function HomeLandProcessToggleCell:Clear()
	self.goView:SetActive(false)
end

function HomeLandProcessToggleCell:Dispose()
	AssetUtil.UnloadAsset(self)
	self:RemoveListener()
	LuaCodeInterface.ClearOutlet(self.goView, self)
	UnityEngine.GameObject.Destroy(self.goView)

	self.goView = nil
end

return HomeLandProcessToggleCell
