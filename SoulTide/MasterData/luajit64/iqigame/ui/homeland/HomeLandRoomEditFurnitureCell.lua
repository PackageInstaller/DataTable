-- chunkname: @IQIGame\\UI\\HomeLand\\HomeLandRoomEditFurnitureCell.lua

local HomeLandRoomEditFurnitureCell = {}

function HomeLandRoomEditFurnitureCell.PackageOrReuseView(ui, mouldPrefab)
	if ui == nil or mouldPrefab == nil then
		return nil
	end

	if ui.__SUB_UI_MAP_HomeLandRoomEditFurnitureCell == nil then
		ui.__SUB_UI_MAP_HomeLandRoomEditFurnitureCell = {}
	end

	local subUIMap = ui.__SUB_UI_MAP_HomeLandRoomEditFurnitureCell
	local eventCell

	if subUIMap[mouldPrefab:GetInstanceID()] == nil then
		eventCell = HomeLandRoomEditFurnitureCell.__New(mouldPrefab)
		subUIMap[mouldPrefab:GetInstanceID()] = eventCell
	else
		eventCell = subUIMap[mouldPrefab:GetInstanceID()]
	end

	return eventCell
end

function HomeLandRoomEditFurnitureCell.__New(itemCellView)
	local itemCell = Clone(HomeLandRoomEditFurnitureCell)

	itemCell:Init(itemCellView)

	return itemCell
end

function HomeLandRoomEditFurnitureCell:Init(view)
	self.goView = view

	LuaCodeInterface.BindOutlet(self.goView, self)

	self.btnLook = self.BtnLook:GetComponent("Button")

	function self.delegateBtnLook()
		self:OnBtnLook()
	end

	self:AddListener()
end

function HomeLandRoomEditFurnitureCell:AddListener()
	self.btnLook.onClick:AddListener(self.delegateBtnLook)
end

function HomeLandRoomEditFurnitureCell:RemoveListener()
	self.btnLook.onClick:RemoveListener(self.delegateBtnLook)
end

function HomeLandRoomEditFurnitureCell.DisposeIn(ui)
	if ui.__SUB_UI_MAP_HomeLandRoomEditFurnitureCell == nil then
		return
	end

	for i, itemCell in pairs(ui.__SUB_UI_MAP_HomeLandRoomEditFurnitureCell) do
		itemCell:Dispose()
	end

	ui.__SUB_UI_MAP_HomeLandRoomEditFurnitureCell = nil
end

function HomeLandRoomEditFurnitureCell:SetData(data, str)
	self.decorateThemeId = data
	self.title = str

	self:Update()
end

function HomeLandRoomEditFurnitureCell:Update()
	UGUIUtil.SetText(self.TextDown, self.title)
	UGUIUtil.SetText(self.TextUp, self.title)
	self.BtnLook:SetActive(self.decorateThemeId > 0)
	self.RedPoint:SetActive(false)
end

function HomeLandRoomEditFurnitureCell:Select(top)
	if top then
		self.Down:SetActive(false)
		self.Up:SetActive(true)
	else
		self.Down:SetActive(true)
		self.Up:SetActive(false)
	end
end

function HomeLandRoomEditFurnitureCell:SetRedPoint(top)
	self.RedPoint:SetActive(top)
end

function HomeLandRoomEditFurnitureCell:OnBtnLook()
	local cfgTheme = CfgHomeLandDecorateThemeTable[self.decorateThemeId]
	local path = UIGlobalApi.GetImagePath(cfgTheme.Preview)

	UIModule.Open(Constant.UIControllerName.HomeLandCgShowUI, Constant.UILayer.UI, {
		path,
		Vector3.New(0, 0, 0)
	})
end

function HomeLandRoomEditFurnitureCell:Dispose()
	self:RemoveListener()
	LuaCodeInterface.ClearOutlet(self.goView, self)

	self.goView = nil
end

return HomeLandRoomEditFurnitureCell
