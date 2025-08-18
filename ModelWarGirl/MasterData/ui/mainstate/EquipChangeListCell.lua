-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\MainState\\EquipChangeListCell.lua

local strClassName = "EquipChangeListCell"
local EquipChangeListCell = Class(strClassName, UIControls.ScrollViewLoopCell)

function EquipChangeListCell:ctor()
	self:initUI()
end

function EquipChangeListCell:initUI()
	self.imgNone = UIControls.Image(self, "ImgNone")
	self.imgCostItem = UIControls.Image(self, "ExpendPanel/Icon")
	self.txtCostNum = UIControls.Label(self, "ExpendPanel/TxtNum")
end

function EquipChangeListCell:setEquipChangeInfo(equipChangeInfo)
	self.equipChangeInfo = equipChangeInfo

	if not self.gridEquip then
		self.gridEquip = UIControls.EquipGridChild(self, "EquipGrid", "System/Common/Grid/GridEquipItem", 0, 0, true)
	end

	self.gridEquip:setObj(self.equipChangeInfo.equip)

	if not self.gridOriHero then
		self.gridOriHero = UIControls.GridHeroInfoChild(self, "HeroInfo1", "System/Common/Grid/GridHeroInfo")
	end

	self.gridOriHero.btnHeroHead:setEnable(false)
	self.gridOriHero:setHero(self.equipChangeInfo.oriHero)

	if self.equipChangeInfo.tarHero then
		if not self.gridTarHero then
			self.gridTarHero = UIControls.GridHeroInfoChild(self, "HeroInfo2", "System/Common/Grid/GridHeroInfo")
		end

		self.gridTarHero.btnHeroHead:setEnable(false)
		self.gridTarHero:setHero(self.equipChangeInfo.tarHero)
		self.imgNone:setVisible(false)
	else
		if self.gridTarHero then
			self.gridTarHero:destroy()

			self.gridTarHero = nil
		end

		self.imgNone:setVisible(true)
	end

	local offNeedInfo = self.equipChangeInfo.equip:getOffMaterialNeed()
	local costId = offNeedInfo[1]
	local costNum = offNeedInfo[2]
	local itemIcon = BaseObject.getItemIconPath(costId)

	if itemIcon then
		self.imgCostItem:setImage(itemIcon[1], itemIcon[2])
	end

	self.txtCostNum:setText(ClientUtils.getNumShortStr(costNum))
end

return EquipChangeListCell
