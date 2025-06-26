-- chunkname: @IQIGame\\UI\\Challenge\\ChallengeBuffInfoItemCell.lua

local ChallengeBuffInfoItemCell = {}

function ChallengeBuffInfoItemCell.PackageOrReuseView(ui, mouldPrefab)
	if ui == nil or mouldPrefab == nil then
		return nil
	end

	if ui.__SUB_UI_MAP_ChallengeBuffInfoItemCell == nil then
		ui.__SUB_UI_MAP_ChallengeBuffInfoItemCell = {}
	end

	local subUIMap = ui.__SUB_UI_MAP_ChallengeBuffInfoItemCell
	local buffInfoCell

	if subUIMap[mouldPrefab:GetInstanceID()] == nil then
		buffInfoCell = ChallengeBuffInfoItemCell.__New(mouldPrefab)
		subUIMap[mouldPrefab:GetInstanceID()] = buffInfoCell
	else
		buffInfoCell = subUIMap[mouldPrefab:GetInstanceID()]
	end

	return buffInfoCell
end

function ChallengeBuffInfoItemCell.__New(itemCellView)
	local itemCell = Clone(ChallengeBuffInfoItemCell)

	itemCell:Init(itemCellView)

	return itemCell
end

function ChallengeBuffInfoItemCell:Init(view)
	self.goView = view

	LuaCodeInterface.BindOutlet(self.goView, self)
	self:AddListener()
end

function ChallengeBuffInfoItemCell:AddListener()
	return
end

function ChallengeBuffInfoItemCell:RemoveListener()
	return
end

function ChallengeBuffInfoItemCell.DisposeIn(ui)
	if ui.__SUB_UI_MAP_ChallengeBuffInfoItemCell == nil then
		return
	end

	for i, itemCell in pairs(ui.__SUB_UI_MAP_ChallengeBuffInfoItemCell) do
		itemCell:Dispose()
	end

	ui.__SUB_UI_MAP_ChallengeBuffInfoItemCell = nil
end

function ChallengeBuffInfoItemCell:SetData(data)
	self.cfgBuffData = data

	if data == nil then
		self:Clear()
	else
		self:Update()
	end
end

function ChallengeBuffInfoItemCell:Update()
	if self.cfgBuffData ~= nil then
		self.NameText:GetComponent("Text").text = self.cfgBuffData.Name
		self.DescText:GetComponent("Text").text = self.cfgBuffData.Describe

		local path = UIGlobalApi.GetIconPath(self.cfgBuffData.Icon)

		AssetUtil.LoadImage(self, path, self.Icon:GetComponent("Image"))
	end
end

function ChallengeBuffInfoItemCell:Clear()
	self.goView:SetActive(false)
end

function ChallengeBuffInfoItemCell:Dispose()
	self:RemoveListener()
	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.goView, self)

	self.goView = nil
end

return ChallengeBuffInfoItemCell
