-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\MainState\\OtherBattle\\EquipSuitSpeInquireDlg.lua

local CommonHeroListPanel = require("UI/Battle/CommonHeroListPanel")
local FilterSelectPanel = require("UI/MainState/FilterSelectPanel")
local ResEquipTowerCustomEquipDrop = require("ClientData/ResEquipTowerCustomEquipDrop")
local ResEquipTowerCustomEquipEffect = require("ClientData/ResEquipTowerCustomEquipEffect")
local ResEquipSuit = require("ClientData/ResEquipSuit")
local ResEquipTower = require("ClientData/ResEquipTower")
local SpeSuitHeroScrollCell = Class("SpeSuitHeroScrollCell", UIControls.HeroCardLoop)

function SpeSuitHeroScrollCell:setSelected(isSelected)
	self.beSelected = isSelected

	self.btnSelf:setEnable(not self.beSelected)
end

local EquipSuitSpeInquireCell = Class("EquipSuitSpeInquireCell", UIControls.Child)

function EquipSuitSpeInquireCell:ctor()
	self.bg = UIControls.Image(self, "Bg")
	self.iconGroup = UIControls.Image(self, "IconGroup")
	self.towerName = UIControls.Label(self, "BgTower/TextName")
	self.iconSuit = UIControls.Image(self, "BgEquipInfo/IconSuit")
	self.suitName = UIControls.Label(self, "BgEquipInfo/TextName")
	self.btnGofor = UIControls.Button(self, "BtnGofor")

	self.btnGofor:addEventClick(self.onBtnGoforClick)
end

function EquipSuitSpeInquireCell:setData(towerInfo)
	self.towerInfo = towerInfo

	self.bg:setImage("Atlas/OtherBattleAtlas/EquipTowerInquireAtlas", "BgGroupL0" .. towerInfo.tower_type)
	self.iconGroup:setImage("Atlas/OtherBattleAtlas/EquipTowerAtlas", "IconGroupL0" .. towerInfo.tower_type)

	self.towerResData = ResEquipTower[towerInfo.tower_type]

	self.towerName:setText(self.towerResData[1].name or {})

	local suitId = towerInfo.suit_id

	if ResEquipSuit[suitId] and ResEquipSuit[suitId].iconPath then
		self.iconSuit:setImage(UIConst.COMMON_ICON_PATH .. ResEquipSuit[suitId].iconPath, ResEquipSuit[suitId].icon)
		self.suitName:setText(ResEquipSuit[suitId].name)
	end
end

function EquipSuitSpeInquireCell:onBtnGoforClick()
	local towerData = CurAvatar.equipTowerData[self.towerInfo.tower_type] or {}
	local passedLevel = towerData.layer or 0
	local layerType, curLevel

	if self.towerResData[passedLevel] and self.towerResData[passedLevel].layer_type then
		layerType = self.towerResData[passedLevel].layer_type
		curLevel = passedLevel
	elseif self.towerResData[passedLevel + 1] and self.towerResData[passedLevel + 1].layer_type then
		layerType = self.towerResData[passedLevel + 1].layer_type
		curLevel = passedLevel + 1
	end

	if layerType and layerType >= Const.EQUIP_TOWER_LAYER_TYPE_CUSTOM then
		RPC.equipTowerChooseHero(self.towerInfo.tower_type, curLevel, self.mParent.selectHero.id, self.mParent.selectHero.gid)
		UIManager.getUI("equipTowerLevelDlg", true):refreshData(self.towerInfo.tower_type)
		self.mParent:setVisible(false)
	else
		MsgManager.clientNotice(767)
	end
end

local strClassName = "EquipSuitSpeInquireDlg"
local EquipSuitSpeInquireDlg = Class(strClassName, UIControls.Window)

function EquipSuitSpeInquireDlg:ctor(...)
	self:initUI()
end

function EquipSuitSpeInquireDlg:initUI(...)
	self.btnClose = UIControls.Button(self, "BgPanel/InquirePanel/BtnClose")

	self.btnClose:addEventClick(self.onBtnCloseClick)

	self.heroListPanel = UIControls.Panel(self, "BgPanel/HeroListPanel")
	self.filterSelectPanel = FilterSelectPanel(self, "BgPanel/HeroListPanel/ListSelectPanel")

	self.filterSelectPanel:setVisible(false)

	self.listHeros = CommonHeroListPanel(self, "BgPanel/HeroListPanel")
	self.listHeros._slot4CellSelect = Slot(self.onHeroCellClick, self)
	self.listHeros.isDragTip = false
	self.attrPanel = UIControls.Panel(self, "BgPanel/InquirePanel/SelectPanel/AttrPanel")
	self.textAttrs = {}

	for i = 1, 3 do
		local textAttr = UIControls.Label(self, "BgPanel/InquirePanel/SelectPanel/AttrPanel/Attr" .. i .. "/TextAttr")

		table.insert(self.textAttrs, textAttr)
	end

	self.towerCell = {}
end

function EquipSuitSpeInquireDlg:setData(hideHeroList, selectHero)
	if hideHeroList then
		self.heroListPanel:setVisible(false)

		self.selectHero = selectHero
	else
		self.heroListPanel:setVisible(true)
		coroutine.start(function(...)
			coroutine.step()

			self.allHeros = CurAvatar:getSpeSuitHeroList()

			self.listHeros:initHeroList(SpeSuitHeroScrollCell, "System/Hero/GridHeroCard", UIConst.HERO_DEFAULT_SORT_MAP, UIConst.HERO_DEFAULT_FILTER_PANEL_MAP, self.allHeros)

			if not self.selectHero then
				self:onHeroCellClick(self.listHeros.cells[1])
			end
		end)
	end

	self:refreshInquireInfo()
end

function EquipSuitSpeInquireDlg:refreshInquireInfo()
	if self.selectHero then
		self.attrPanel:setVisible(true)

		if self.gridHero == nil then
			self.gridHero = UIControls.HeroCardChild(self, "BgPanel/InquirePanel/SelectPanel/GridHeroCard", "System/Hero/GridHeroCard")
		end

		self.gridHero:setHero(self.selectHero)
		self.gridHero:setVisible(true)

		for eId, info in pairs(ResEquipTowerCustomEquipEffect) do
			if info and #info > 0 and info[1].hero_id == self.selectHero.id then
				for i, v in ipairs(info) do
					self.textAttrs[i]:setText(v.effect_desc)
				end

				break
			end
		end

		local towerTypes = self:getEquipTowerTypeByHeroId(self.selectHero.id)

		for i, data in ipairs(towerTypes) do
			if self.towerCell[i] == nil then
				self.towerCell[i] = EquipSuitSpeInquireCell(self, "BgPanel/InquirePanel/GoforPanel", "System/EquipTower/EquipSuitSpeInquireCell")
			end

			self.towerCell[i]:setData(data)
			self.towerCell[i]:setVisible(true)
		end
	else
		self.attrPanel:setVisible(false)
	end
end

function EquipSuitSpeInquireDlg:getEquipTowerTypeByHeroId(heroId)
	local towerTypes = {}

	for i, infos in ipairs(ResEquipTowerCustomEquipDrop) do
		for id, info in pairs(infos or {}) do
			if info.hero_id == heroId then
				table.insert(towerTypes, info)
			end
		end
	end

	return towerTypes
end

function EquipSuitSpeInquireDlg:onHeroCellClick(sender)
	self.listHeros:onHeroCellSelect(sender)

	self.selectHero = sender.hero

	self:refreshInquireInfo()
end

function EquipSuitSpeInquireDlg:onBtnCloseClick()
	self:setVisible(false)
end

return EquipSuitSpeInquireDlg
