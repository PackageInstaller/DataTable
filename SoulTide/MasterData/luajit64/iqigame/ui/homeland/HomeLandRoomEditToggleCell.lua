-- chunkname: @IQIGame\\UI\\HomeLand\\HomeLandRoomEditToggleCell.lua

local HomeLandRoomEditToggleCell = {}

function HomeLandRoomEditToggleCell.PackageOrReuseView(ui, mouldPrefab)
	if ui == nil or mouldPrefab == nil then
		return nil
	end

	if ui.__SUB_UI_MAP_HomeLandRoomEditToggleCell == nil then
		ui.__SUB_UI_MAP_HomeLandRoomEditToggleCell = {}
	end

	local subUIMap = ui.__SUB_UI_MAP_HomeLandRoomEditToggleCell
	local eventCell

	if subUIMap[mouldPrefab:GetInstanceID()] == nil then
		eventCell = HomeLandRoomEditToggleCell.__New(mouldPrefab)
		subUIMap[mouldPrefab:GetInstanceID()] = eventCell
	else
		eventCell = subUIMap[mouldPrefab:GetInstanceID()]
	end

	return eventCell
end

function HomeLandRoomEditToggleCell.__New(itemCellView)
	local itemCell = Clone(HomeLandRoomEditToggleCell)

	itemCell:Init(itemCellView)

	return itemCell
end

function HomeLandRoomEditToggleCell:Init(view)
	self.goView = view

	LuaCodeInterface.BindOutlet(self.goView, self)

	self.btnLook = self.BtnLook:GetComponent("Button")

	function self.delegateBtnLook()
		self:OnBtnLook()
	end

	self:AddListener()
end

function HomeLandRoomEditToggleCell:AddListener()
	self.btnLook.onClick:AddListener(self.delegateBtnLook)
end

function HomeLandRoomEditToggleCell:RemoveListener()
	self.btnLook.onClick:RemoveListener(self.delegateBtnLook)
end

function HomeLandRoomEditToggleCell.DisposeIn(ui)
	if ui.__SUB_UI_MAP_HomeLandRoomEditToggleCell == nil then
		return
	end

	for i, itemCell in pairs(ui.__SUB_UI_MAP_HomeLandRoomEditToggleCell) do
		itemCell:Dispose()
	end

	ui.__SUB_UI_MAP_HomeLandRoomEditToggleCell = nil
end

function HomeLandRoomEditToggleCell:SetData(data, str)
	self.decorateThemeId = data
	self.title = str

	self:Update()
end

function HomeLandRoomEditToggleCell:Update()
	UGUIUtil.SetText(self.TextDown, self.title)
	UGUIUtil.SetText(self.TextUp, self.title)
	self.BtnLook:SetActive(self.decorateThemeId > 0)
	self.RedPoint:SetActive(false)
end

function HomeLandRoomEditToggleCell:Select(top)
	if top then
		self.Down:SetActive(false)
		self.Up:SetActive(true)
	else
		self.Down:SetActive(true)
		self.Up:SetActive(false)
	end
end

function HomeLandRoomEditToggleCell:SetRedPoint(top)
	self.RedPoint:SetActive(top)
end

function HomeLandRoomEditToggleCell:OnBtnLook()
	local cfgTheme = CfgHomeLandDecorateThemeTable[self.decorateThemeId]
	local path = UIGlobalApi.GetImagePath(cfgTheme.Preview)

	UIModule.Open(Constant.UIControllerName.HomeLandCgShowUI, Constant.UILayer.UI, {
		path,
		Vector3.New(0, 0, 0)
	})
end

function HomeLandRoomEditToggleCell:Dispose()
	self:RemoveListener()
	LuaCodeInterface.ClearOutlet(self.goView, self)

	self.goView = nil
end

return HomeLandRoomEditToggleCell
