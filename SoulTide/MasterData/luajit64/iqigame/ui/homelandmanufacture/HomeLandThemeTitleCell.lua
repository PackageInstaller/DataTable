-- chunkname: @IQIGame\\UI\\HomeLandManufacture\\HomeLandThemeTitleCell.lua

HomeLandThemeTitleCell = {}

function HomeLandThemeTitleCell:New(itemCellView)
	local itemCell = Clone(HomeLandThemeTitleCell)

	itemCell:Init(itemCellView)

	return itemCell
end

function HomeLandThemeTitleCell:Init(view)
	self.goView = view

	LuaCodeInterface.BindOutlet(self.goView, self)
	self:AddListener()
end

function HomeLandThemeTitleCell:AddListener()
	return
end

function HomeLandThemeTitleCell:RemoveListener()
	return
end

function HomeLandThemeTitleCell:SetDate(data)
	self.cfgDecorateTheme = data

	if self.cfgDecorateTheme then
		local path = UIGlobalApi.GetImagePath("/Home" .. self.cfgDecorateTheme.Icon)

		AssetUtil.LoadImage(self, path, self.ImgDown:GetComponent("Image"))
		AssetUtil.LoadImage(self, path, self.ImgUp:GetComponent("Image"))

		local num, totalNum = HomeLandManufactureMould.GetCompleteThemeNumber(self.cfgDecorateTheme.Id)

		UGUIUtil.SetText(self.TextDown1, HomeLandManufactureListUIApi:GetString("TextDown", num, totalNum))
		UGUIUtil.SetText(self.TextUp1, HomeLandManufactureListUIApi:GetString("TextUp", num, totalNum))
		UGUIUtil.SetText(self.TextDown2, self.cfgDecorateTheme.Name)
		UGUIUtil.SetText(self.TextUp2, self.cfgDecorateTheme.Name)
	end
end

function HomeLandThemeTitleCell:SetSelect(select)
	self.ToggleDown:SetActive(not select)
	self.ToggleUp:SetActive(select)
end

function HomeLandThemeTitleCell:Dispose()
	AssetUtil.UnloadAsset(self)
	self:RemoveListener()
	LuaCodeInterface.ClearOutlet(self.goView, self)
	UnityEngine.GameObject.Destroy(self.goView)

	self.goView = nil
end

return HomeLandThemeTitleCell
