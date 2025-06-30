-- chunkname: @IQIGame\\UI\\RoleInfoDetails\\RoleInfoDetails_FavorAttributePanel.lua

local RoleInfoDetails_FavorAttributePanel = {}
local attItemClass = require("IQIGame/UI/RoleInfoDetails/FavorAttributePanel_AttItem")

function RoleInfoDetails_FavorAttributePanel.New(go, mainView)
	local o = Clone(RoleInfoDetails_FavorAttributePanel)

	o:Initialize(go, mainView)

	return o
end

function RoleInfoDetails_FavorAttributePanel:Initialize(go, mainView)
	LuaCodeInterface.BindOutlet(go, self)

	self.gameObject = go
	self.mainView = mainView
	self.attributeScrollDataArray = {}
	self.attScrollCellList = {}

	self:InitComponent()
	self:InitDelegate()
	self:AddListener()
end

function RoleInfoDetails_FavorAttributePanel:InitComponent()
	local attributeScroll = self.attributeItems:GetComponent("ScrollAreaList")

	function attributeScroll.onRenderCell(gridCell)
		self:OnAttributeScrollRenderGridCell(gridCell)
	end
end

function RoleInfoDetails_FavorAttributePanel:InitDelegate()
	function self.delegateOnClickCloseBtn()
		self:OnClickCloseBtn()
	end
end

function RoleInfoDetails_FavorAttributePanel:AddListener()
	self.closeBtn:GetComponent("Button").onClick:AddListener(self.delegateOnClickCloseBtn)
end

function RoleInfoDetails_FavorAttributePanel:RemoveListener()
	self.closeBtn:GetComponent("Button").onClick:RemoveListener(self.delegateOnClickCloseBtn)
end

function RoleInfoDetails_FavorAttributePanel:OnAttributeScrollRenderGridCell(gridCellData)
	local data = self.attributeScrollDataArray[gridCellData.index + 1]
	local insID = gridCellData.gameObject:GetInstanceID()
	local cell = self.attScrollCellList[insID]

	if not cell then
		cell = attItemClass.New(gridCellData.gameObject, self)
		self.attScrollCellList[insID] = cell
	end

	data.insID = insID

	cell:Refresh(data)

	gridCellData.gameObject.name = data.cid
end

function RoleInfoDetails_FavorAttributePanel:OnClickCloseBtn()
	self:Hide()
end

function RoleInfoDetails_FavorAttributePanel:Show()
	LuaUtility.SetGameObjectShow(self.gameObject, true)
end

function RoleInfoDetails_FavorAttributePanel:Hide()
	LuaUtility.SetGameObjectShow(self.gameObject, false)
end

function RoleInfoDetails_FavorAttributePanel:Refresh(heroCid)
	self.heroCid = heroCid

	local cfgFavorLv = CfgUtil.GetFavorLvCfgDataWithHeroCid(self.heroCid)

	self.attributeScrollDataArray = {}

	for i = 1, #cfgFavorLv.Attribute, 2 do
		local data = {}

		data.attId = cfgFavorLv.Attribute[i]
		data.attValue = cfgFavorLv.Attribute[i + 1]

		table.insert(self.attributeScrollDataArray, data)
	end

	self:RefreshAttScroll()
end

function RoleInfoDetails_FavorAttributePanel:RefreshAttScroll(isDynamic)
	local scroll = self.attributeItems:GetComponent("ScrollAreaList")

	if isDynamic then
		scroll:RenderCellsDynamic(#self.attributeScrollDataArray)
	else
		scroll:Refresh(#self.attributeScrollDataArray)
	end
end

function RoleInfoDetails_FavorAttributePanel:OnDestroy()
	return
end

return RoleInfoDetails_FavorAttributePanel
