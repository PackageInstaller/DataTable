-- chunkname: @IQIGame\\UI\\Mail\\NewMouldCell.lua

local NewMouldCell = {}

function NewMouldCell.PackageOrReuseView(ui, newMouldPrefab)
	if ui == nil or newMouldPrefab == nil then
		return nil
	end

	if ui.__SUB_UI_MAP_NewMouldCell == nil then
		ui.__SUB_UI_MAP_NewMouldCell = {}
	end

	local subUIMap = ui.__SUB_UI_MAP_NewMouldCell
	local mailItemCell

	if subUIMap[newMouldPrefab:GetInstanceID()] == nil then
		mailItemCell = NewMouldCell:__New(newMouldPrefab)
		subUIMap[newMouldPrefab:GetInstanceID()] = mailItemCell
	else
		mailItemCell = subUIMap[newMouldPrefab:GetInstanceID()]
	end

	return mailItemCell
end

function NewMouldCell:__New(itemCellView)
	local itemCell = Clone(NewMouldCell)

	itemCell:Init(itemCellView)

	return itemCell
end

function NewMouldCell:Init(view)
	self.goView = view

	LuaCodeInterface.BindOutlet(self.goView, self)
	self:AddListener()
end

function NewMouldCell:AddListener()
	return
end

function NewMouldCell:RemoveListener()
	return
end

function NewMouldCell.DisposeIn(ui)
	if ui.__SUB_UI_MAP_NewMouldCell == nil then
		return
	end

	for i, itemCell in pairs(ui.__SUB_UI_MAP_NewMouldCell) do
		itemCell:Dispose()
	end

	ui.__SUB_UI_MAP_NewMouldCell = nil
end

function NewMouldCell:Dispose()
	self:RemoveListener()
	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.goView, self)

	self.goView = nil
end

function NewMouldCell:SetItem(newsData)
	self.newsData = newsData

	if newsData == nil then
		self:Clear()
	else
		self:Update()
	end
end

function NewMouldCell:Update()
	if self.newsData ~= nil then
		UGUIUtil.SetText(self.TextNewName, self.newsData.cfgInfo.Name)
		UGUIUtil.SetText(self.TextNewTime, MailUIApi:GetString("mailTime", 1, nil, false))

		if self.ImageNew and self.newsData.cfgInfo.PaperType ~= nil and self.newsData.cfgInfo.PaperType ~= "" then
			local typePath = LibraryNewsUIApi:GetString("NewsTypePath", self.newsData.cfgInfo.PaperType)

			AssetUtil.LoadImage(self, typePath, self.ImageNew:GetComponent("Image"))
		end

		self.ImageBg:SetActive(not self.newsData.isRead)
		self.ImageBgOpen:SetActive(self.newsData.isRead)

		local isRed = self.newsData:IsGetReward()

		self.ImgRed:SetActive(isRed)
	end
end

function NewMouldCell:Clear()
	self.goView:SetActive(false)
end

return NewMouldCell
