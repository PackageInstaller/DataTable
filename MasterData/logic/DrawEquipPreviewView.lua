-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/drawequipments/view/DrawEquipPreviewView.lua

module("logic.extensions.equiplottery.view.DrawEquipPreviewView", package.seeall)

local DrawEquipPreviewView = class("DrawEquipPreviewView", ViewComponent)
local cellTitleTag = 100
local cellEquipTag = 101

function DrawEquipPreviewView:buildUI()
	DrawEquipPreviewView.super.buildUI(self)

	self._viewBgGo = self:getGo("viewBgGo")
	self._closeBtn = Framework.ButtonAdapter.GetFrom(self._viewBgGo, "closeBtn")
	self._descTxt = goutil.findChildTextComponent(self._viewBgGo, "leftDesGo/descTxt")
	self._tabView = self:getGo("viewBgGo/tabView"):GetComponent(ComponentType.UITableview)
	self._tabItem = self:getGo("viewBgGo/tabItem")
	self._equipsView = self:getGo("viewBgGo/equipListSR"):GetComponent(ComponentType.UITableview)
	self._equipItem = self:getGo("viewBgGo/equipItem")
	self._itemTitleCell = self:getGo("viewBgGo/itemTitleCell")

	self._equipItem:SetActive(false)
	self._itemTitleCell:SetActive(false)
	self._tabItem:SetActive(false)

	local titleRuleTxt = goutil.findChildTextComponent(self._viewBgGo, "leftDesGo/titleTxt")

	titleRuleTxt.text = lang("text_rules_title")
end

function DrawEquipPreviewView:bindEvents()
	self._closeBtn:AddClickListener(self.close, self)
	self._tabView:RegisterCallback(self._numTabsInView, self._tabSizeForIndex, self._tabCellAtIndex, self)
	self._equipsView:RegisterCallback(self._numEquipsInView, self._equipSizeForIndex, self._equipCellAtIndex, self)
end

function DrawEquipPreviewView:unbindEvents()
	self._closeBtn:RemoveClickListener()
	self._tabView:UnRegisterAllCallbacks()
	self._equipsView:UnRegisterAllCallbacks()
end

function DrawEquipPreviewView:onEnter()
	self._curPoolId = self:getFirstParam()

	self:_refreshTabView()
	self:_selectRare(self._rareConfigs[1].rare)

	local pool = DrawEquipmentsModel.instance:getPoolById(self._curPoolId)

	self._descTxt.text = pool:getPoolDesc()
end

function DrawEquipPreviewView:onExit()
	self._selectRareId = nil
	self._rareConfigs = nil
	self._equipsConfig = nil

	self._tabView:Travel(self._clearTabCell, self)
	self._equipsView:Travel(self._clearEquipCell, self)
end

function DrawEquipPreviewView:_refreshTabView()
	local rareConfig = DrawEquipmentsConfig.instance:getAllRaresConfig(self._curPoolId)

	self._rareConfigs = {}

	for k, v in pairs(rareConfig or {}) do
		table.insert(self._rareConfigs, v)
	end

	table.sort(self._rareConfigs, function(x, y)
		return x.rare < y.rare
	end)
	self._tabView:SetOffsetWithoutRefresh(0)
	self._tabView:ReloadData()
end

function DrawEquipPreviewView:_clearTabCell(cell)
	local btn = Framework.ButtonAdapter.GetFrom(cell.gameObject, "tabItemBtn")

	btn:RemoveClickListener()
end

function DrawEquipPreviewView:_numTabsInView()
	if not self._rareConfigs then
		return 0
	end

	return #self._rareConfigs
end

function DrawEquipPreviewView:_tabSizeForIndex()
	return 98, 30
end

function DrawEquipPreviewView:_tabCellAtIndex(view, idx)
	local cell = view:DequeueCell()

	cell = cell or view:AddChild(self._tabItem)

	local cfg = self._rareConfigs[idx + 1]
	local btn = Framework.ButtonAdapter.GetFrom(cell.gameObject, "tabItemBtn")
	local btnText = goutil.findChildTextComponent(btn.gameObject, "tabItemTxt")
	local spriteGroup = btn:GetComponent(ComponentType.UIChangeGroup)

	btnText.text = cfg.rareName

	if self._selectRareId == cfg.rare then
		spriteGroup:SetState(1)
	else
		spriteGroup:SetState(0)
	end

	btn:RemoveClickListener()
	btn:AddClickListener(function()
		self:_selectRare(cfg.rare)
	end)

	return cell
end

function DrawEquipPreviewView:_selectRare(rare)
	self._selectRareId = rare

	self._tabView:Refresh()
	self:_refreshEquipsView(rare)
end

function DrawEquipPreviewView:_refreshEquipsView(rare)
	local equips = DrawEquipmentsConfig.instance:getEquipments(self._curPoolId, rare)

	self._equipsConfig = {}

	if equips then
		if equips.upEquips and #equips.upEquips > 0 then
			local cfg = {
				isUp = true,
				rare = rare,
				cellType = cellTitleTag,
				weight = equips.upEquips[1].upPool / 100
			}
			local equips = {
				rare = rare,
				cellType = cellEquipTag,
				equips = equips.upEquips
			}

			table.insert(self._equipsConfig, cfg)
			table.insert(self._equipsConfig, equips)
		end

		if equips.equipments and #equips.equipments > 0 then
			local cfg = {
				rare = rare,
				cellType = cellTitleTag,
				weight = DrawEquipmentsConfig.instance:getRareWeight(self._curPoolId, rare) / 10000
			}
			local equips = {
				rare = rare,
				cellType = cellEquipTag,
				equips = equips.equipments
			}

			table.insert(self._equipsConfig, cfg)
			table.insert(self._equipsConfig, equips)
		end
	end

	self._equipsView:SetOffsetWithoutRefresh(0)
	self._equipsView:ReloadData()
end

function DrawEquipPreviewView:_clearEquipCell(cell)
	local equipPos = goutil.findChild(cell.gameObject, "equipPos")

	if equipPos then
		local transform = equipPos.transform

		for i = 0, transform.childCount - 1 do
			local go = transform:GetChild(i).gameObject

			MaterialMgr.resetAll(go)
		end
	end
end

function DrawEquipPreviewView:_numEquipsInView()
	if not self._equipsConfig then
		return 0
	end

	return #self._equipsConfig
end

function DrawEquipPreviewView:_equipSizeForIndex(view, idx)
	local cfg = self._equipsConfig[idx + 1]

	if cfg.cellType == cellTitleTag then
		return 765, 34
	end

	local cnt = #cfg.equips
	local line = math.ceil(cnt / 7)

	return 765, 110 * line
end

function DrawEquipPreviewView:_equipCellAtIndex(view, idx)
	local cfg = self._equipsConfig[idx + 1]
	local cell = view:DequeueCellByTag(cfg.cellType)

	cell = cell or cfg.cellType == cellTitleTag and view:AddChild(self._itemTitleCell, cfg.cellType) or view:AddChild(self._equipItem, cfg.cellType)

	if cfg.cellType == cellTitleTag then
		self:_fillEquipTitle(cell, cfg)
	else
		self:_fillEquipsInfo(cell, cfg)
	end

	return cell
end

function DrawEquipPreviewView:_fillEquipTitle(cell, cfg)
	local attrTxt = goutil.findChildTextComponent(cell.gameObject, "rateBgGo/attrTxt")
	local upTxt = goutil.findChildTextComponent(cell.gameObject, "rateBgGo/upTxt")
	local rateTxt = goutil.findChildTextComponent(cell.gameObject, "rateBgGo/rateTxt")
	local rareName = DrawEquipmentsConfig.instance:getRareName(self._curPoolId, cfg.rare)

	attrTxt.text = rareName

	local ax, ay, az = Framework.TransformUtil.GetLocalPos(attrTxt.transform, nil, nil, nil)
	local rx, ry, rz = Framework.TransformUtil.GetLocalPos(rateTxt.transform, nil, nil, nil)

	if cfg.isUp then
		upTxt.gameObject:SetActive(true)

		local poolMo = DrawEquipmentsModel.instance:getPoolById(self._curPoolId)

		upTxt.text = poolMo:getPoolAttrName() .. "UP"

		local ux, uy, uz = Framework.TransformUtil.GetLocalPos(upTxt.transform, nil, nil, nil)

		rateTxt.text = string.format(lang("drawequipments_draw_uprate"), rareName, tostring(cfg.weight))

		Framework.TransformUtil.SetLocalPos(upTxt.transform, ax + attrTxt.preferredWidth + 15, uy, uz)
		Framework.TransformUtil.SetLocalPos(rateTxt.transform, ax + attrTxt.preferredWidth + upTxt.preferredWidth + 30, ry, rz)
	else
		upTxt.gameObject:SetActive(false)

		rateTxt.text = string.format(lang("drawequipments_draw_rate"), tostring(cfg.weight))

		Framework.TransformUtil.SetLocalPos(rateTxt.transform, ax + attrTxt.preferredWidth + 15, ry, rz)
	end
end

function DrawEquipPreviewView:_fillEquipsInfo(cell, cfg)
	local equipNum = #cfg.equips
	local layoutGo = goutil.findChildComponent(cell.gameObject, "equipPos", ComponentType.UILayoutSingleLine)
	local transform = layoutGo.transform
	local childCount = transform.childCount

	while childCount < equipNum do
		UGUIToolHelper.AddChild(transform.gameObject, transform:GetChild(0).gameObject)

		childCount = childCount + 1
	end

	for i = 1, equipNum do
		local go = transform:GetChild(i - 1).gameObject

		go:SetActive(true)

		local data = cfg.equips[i]

		MaterialMgr.setCellByCfg(data.item, go)
	end

	for i = equipNum + 1, childCount do
		local go = transform:GetChild(i - 1).gameObject

		go:SetActive(false)
	end

	layoutGo:Layout()
end

return DrawEquipPreviewView
