-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\MainState\\OtherBattle\\EquipTowerEquipHaveDlg.lua

local ResEquipSuit = require("ClientData/ResEquipSuit")
local EquipPanel = Class("EquipPanel", UIControls.Panel)

function EquipPanel:ctor(...)
	self:initUI()
end

function EquipPanel:initUI(...)
	self.imgHave = UIControls.Image(self, self.mPath .. "/ImgHave")
	self.imgPart = UIControls.Image(self, self.mPath .. "/IconPart")
	self.scrollView = UIControls.ScrollViewLoopH(self, self.mPath .. "/EquipList", 0, self.onCellChanged)
end

function EquipPanel:setData(equips, isHave)
	self.datas = equips

	if equips then
		isHave = #equips > 0

		self.imgHave:setVisible(isHave)
		self.scrollView:setTotalCount(#self.datas)

		if #self.datas <= 6 then
			self.scrollView:cancelScroll()
		end
	else
		isHave = false

		self.imgHave:setVisible(false)
	end

	if isHave then
		self.imgPart:setImage("Atlas/OtherBattleAtlas/EquipTowerAtlas3", "BgEquip0" .. self.index)
	else
		self.imgPart:setImage("Atlas/OtherBattleAtlas/EquipTowerAtlas3", "BgEquip0" .. self.index .. "Dis")
	end
end

function EquipPanel:onCellChanged(sender, targetCell, newIdx)
	if targetCell == nil then
		targetCell = UIControls.EquipGridLoop(sender, "System/Common/Grid/GridEquipItem", newIdx)
	end

	targetCell.index = newIdx

	targetCell:setObj(self.datas[newIdx])
end

local strClassName = "EquipTowerEquipHaveDlg"
local EquipTowerEquipHaveDlg = Class(strClassName, UIControls.Window)

function EquipTowerEquipHaveDlg:ctor(...)
	self:initUI()
end

function EquipTowerEquipHaveDlg:initUI(...)
	self.txtTitle = UIControls.Label(self, "Bg/TextTips")
	self.equipUIs = {}

	for i = 1, 6 do
		local panel = EquipPanel(self, "Bg/InfoPanel/Equip" .. i)

		panel.index = i
		self.equipUIs[i] = panel
	end
end

function EquipTowerEquipHaveDlg:show(suitId, effectId)
	self.effectId = effectId
	self.suitId = suitId

	local data = CurAvatar:getAllDefineEquipList(effectId, suitId)
	local ownCount = 0

	for i, ui in ipairs(self.equipUIs) do
		local equips = data[i]

		ui:setData(equips)
	end

	local name = ResEquipSuit[self.suitId].name

	self.txtTitle:setText(ClientUtils.getClientNotice(496))
end

return EquipTowerEquipHaveDlg
