-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\MainState\\OtherBattle\\EquipTowerChooseSuitDlg.lua

local ResEquipTowerCustomEquipDrop = require("ClientData/ResEquipTowerCustomEquipDrop")
local ResEquipTowerCustomEquipEffect = require("ClientData/ResEquipTowerCustomEquipEffect")
local Hero = require("Common/Object/Hero")
local ResEquipSuit = require("ClientData/ResEquipSuit")
local ResHero = require("ClientData/ResHero")
local ResEquipTower = require("ClientData/ResEquipTower")
local HeroEquipSpeCell = Class("HeroEquipSpeCell", UIControls.ScrollViewLoopCell)

function HeroEquipSpeCell:ctor(...)
	self:initUI()
end

function HeroEquipSpeCell:initUI(...)
	self.gridHero = UIControls.HeroCardChild(self, "GridHero", "System/Hero/GridHeroCard", 1, 1, true)

	self.gridHero:setSelectCallback(Slot(self.onBtnSensorClick, self))

	self.gridHero.showSelect = true
	self.panelSuit = UIControls.Panel(self, "EquipSpeInfoPanel")
	self.imgSuit = UIControls.Image(self, "EquipSpeInfoPanel/IconSuit")
	self.txtName = UIControls.Label(self, "EquipSpeInfoPanel/TextName")
end

function HeroEquipSpeCell:setData(data)
	self.data = data

	self.gridHero:setHero(data.hero)
	self.gridHero:setHaveState(data.isOwn)
	self.gridHero:setSelected(data.isSelect)

	if self.mParent.layerType == Const.EQUIP_TOWER_LAYER_TYPE_STONE then
		self.panelSuit:setVisible(false)
	else
		local suitInfo = ResEquipSuit[data.dropInfo.suit_id]

		if suitInfo then
			self.imgSuit:setImage("Atlas/CommonAtlas/" .. suitInfo.iconPath, suitInfo.icon)
			self.txtName:setText(suitInfo.name)
		end
	end
end

function HeroEquipSpeCell:onBtnSensorClick(...)
	self.mWindow:onClickHero(self.data)
end

local strClassName = "EquipTowerChooseSuitDlg"
local EquipTowerChooseSuitDlg = Class(strClassName, UIControls.Window)

function EquipTowerChooseSuitDlg:ctor(...)
	self:initUI()
end

function EquipTowerChooseSuitDlg:initUI(...)
	self.scrollView = UIControls.ScrollViewLoopV(self, "HeroListPanel/CardPanel", 0, self.onCellChanged)
	self.gridHero = UIControls.HeroCardChild(self, "BgSelect/GridHeroCard", "System/Hero/GridHeroCard")

	self.gridHero:setSelectCallback(Slot(self.onSelectingHeroClick, self))

	self.panelBgEquipInfo = UIControls.Panel(self, "BgSelect/BgEquipInfo")
	self.panelAttr = UIControls.Panel(self, "BgSelect/AttrPanel")
	self.panelBgSuit = UIControls.Panel(self, "BgSelect/GridHeroCard/Bg")
	self.panelBgStone = UIControls.Panel(self, "BgSelect/GridHeroCard/BgStone")
	self.imgSuit = UIControls.Image(self, "BgSelect/BgEquipInfo/IconSuit")
	self.bgTitle = UIControls.Image(self, "BgSelect/BgEquipInfo/BgTitle")
	self.txtsuitName = UIControls.Label(self, "BgSelect/BgEquipInfo/TextName")
	self.txtTips = UIControls.Label(self, "BgSelect/AttrPanel/TextTips")
	self.btnCheck = UIControls.Button(self, "BgSelect/BgEquipInfo/BtnCheck", "Text")

	self.btnCheck:addEventClick(self.onBtnCheckClick)

	self.btnSave = UIControls.Button(self, "HeroListPanel/FuncPanel/BtnSave")

	self.btnSave:addEventClick(self.onBtnSaveClick)

	self.btnCancel = UIControls.Button(self, "HeroListPanel/FuncPanel/BtnCancel")

	self.btnCancel:addEventClick(self.onBtnCancelClick)

	self.attrUIs = {}

	for i = 1, 3 do
		local path = "BgSelect/AttrPanel/Attr" .. i
		local panel = UIControls.Panel(self, path)
		local txtTitle = UIControls.Label(self, path .. "/TextTitle")
		local txtAttr = UIControls.Label(self, path .. "/TextAttr")

		self.attrUIs[i] = {
			panel,
			txtTitle,
			txtAttr
		}
	end
end

function EquipTowerChooseSuitDlg:show(towerType, level)
	self.towerType = towerType
	self.level = level

	if CurAvatar.equipTowerData then
		self.towerData = CurAvatar.equipTowerData[towerType]
	else
		self.towerData = {}
	end

	self.layerType = ResEquipTower[towerType][level].layer_type

	if self.layerType and self.layerType == Const.EQUIP_TOWER_LAYER_TYPE_STONE then
		self.panelBgSuit:setVisible(false)
		self.panelBgStone:setVisible(true)
	else
		self.panelBgSuit:setVisible(true)
		self.panelBgStone:setVisible(false)
	end

	self:initData()
end

local function sortHeroData(a, b)
	if a.isOwn ~= b.isOwn then
		return a.isOwn
	elseif a.hero.star ~= b.hero.star then
		return a.hero.star > b.hero.star
	elseif a.hero.level ~= b.hero.level then
		return a.hero.level > b.hero.level
	elseif a.hero.step ~= b.hero.step then
		return a.hero.step > b.hero.step
	else
		return a.hero.id > b.hero.id
	end
end

function EquipTowerChooseSuitDlg:initData(...)
	self.datas = {}

	local sortHeroDic = CurAvatar:getIdGrowthestHeroDic()
	local infos = ResEquipTowerCustomEquipDrop[self.towerType]

	if infos then
		for id, info in pairs(infos) do
			local config = ResEquipTowerCustomEquipEffect[info.effect_id]

			if config and next(config) then
				local key = next(config)
				local heroId = config[key].hero_id

				if ResHero[heroId] and ClientUtils.isTimeConfigPassed(ResHero[heroId].valid_time_id) then
					local data = {
						dropInfo = info,
						effectInfo = config
					}
					local hero = sortHeroDic[heroId]

					if hero then
						data.isOwn = true
					else
						hero = Hero({
							resid = heroId
						})
						data.isOwn = false
					end

					local isSelect = false

					if self.towerData then
						if CurAvatar.heroDic[self.towerData.gid] then
							if hero.gid == self.towerData.gid then
								isSelect = true
							end
						elseif self.towerData.resId == hero.id then
							isSelect = true
						end

						if isSelect then
							self.curSelectData = data
						end
					end

					data.hero = hero
					data.isSelect = isSelect

					table.insert(self.datas, data)
				end
			end
		end
	end

	table.sort(self.datas, sortHeroData)
	self.scrollView:setTotalCount(#self.datas)
	self:refreshSelectHero()
end

function EquipTowerChooseSuitDlg:refreshSelectHero(...)
	if self.curSelectData then
		if self.curSelectData.isSelect then
			self.panelBgEquipInfo:setVisible(true)
			self.gridHero:setHero(self.curSelectData.hero)
			self.gridHero:setVisible(true)
			self.panelAttr:setVisible(true)
			self.imgSuit:setVisible(true)
			self.bgTitle:setVisible(true)
			self.txtsuitName:setVisible(true)

			local suitInfo = ResEquipSuit[self.curSelectData.dropInfo.suit_id]

			if suitInfo then
				self.imgSuit:setImage("Atlas/CommonAtlas/" .. suitInfo.iconPath, suitInfo.icon)
				self.txtsuitName:setText(suitInfo.name)
			end

			local count = self:getOwnCount()

			self.btnCheck:setText(utils.format(Lang.get(51404), count))

			for i, info in ipairs(self.curSelectData.effectInfo) do
				local ui = self.attrUIs[i]

				if ui then
					ui[1]:setVisible(true)
					ui[2]:setText(utils.format(Lang.get(51405), info.num))
					ui[3]:setText(info.effect_desc)
				end
			end

			self.txtTips:setText(ClientUtils.getClientNotice(492))
		else
			self.panelAttr:setVisible(false)
			self.gridHero:setVisible(false)
			self.panelBgEquipInfo:setVisible(false)
		end
	else
		self.panelAttr:setVisible(false)
		self.gridHero:setVisible(false)
		self.panelBgEquipInfo:setVisible(false)
	end
end

function EquipTowerChooseSuitDlg:getOwnCount(...)
	local dropInfo = self.curSelectData.dropInfo
	local data = CurAvatar:getAllDefineEquipList(dropInfo.effect_id, dropInfo.suit_id)
	local ownCount = 0

	for i = 1, 6 do
		local equips = data[i]

		if equips and #equips > 0 then
			ownCount = ownCount + 1
		end
	end

	return ownCount
end

function EquipTowerChooseSuitDlg:onSelectingHeroClick(...)
	if self.curSelectData then
		self:onClickHero(self.curSelectData)
	end
end

function EquipTowerChooseSuitDlg:onClickHero(data)
	data.isSelect = not data.isSelect

	if self.curSelectData then
		if self.curSelectData == data then
			self.curSelectData = nil
		else
			self.curSelectData.isSelect = false
			self.curSelectData = data
		end
	else
		self.curSelectData = data
	end

	self.scrollView:refreshCells()
	self:refreshSelectHero()
end

function EquipTowerChooseSuitDlg:onBtnCancelClick(...)
	self:setVisible(false)
end

function EquipTowerChooseSuitDlg:onBtnSaveClick(...)
	if self.curSelectData then
		local gid

		if self.curSelectData.isOwn then
			gid = self.curSelectData.hero.gid
		end

		RPC.equipTowerChooseHero(self.towerType, self.level, self.curSelectData.hero.id, gid)
	else
		MsgManager.clientNotice(493)
	end
end

function EquipTowerChooseSuitDlg:onBtnCheckClick(...)
	if self.curSelectData then
		local dropInfo = self.curSelectData.dropInfo

		UIManager.getUI("equipTowerEquipHaveDlg", true):show(dropInfo.suit_id, dropInfo.effect_id)
	end
end

function EquipTowerChooseSuitDlg:onCellChanged(sender, targetCell, newIdx)
	if targetCell == nil then
		targetCell = HeroEquipSpeCell(sender, "System/Hero/GridHeroEquipSpe", newIdx, 0, 0)
	end

	targetCell.index = newIdx

	targetCell:setData(self.datas[newIdx])
end

return EquipTowerChooseSuitDlg
