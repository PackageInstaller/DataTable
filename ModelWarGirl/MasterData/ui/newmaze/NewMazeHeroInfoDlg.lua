-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\NewMaze\\NewMazeHeroInfoDlg.lua

local RoleInfoHeroDlg = require("UI/RoleInfo/RoleInfoHeroDlg")
local ResNewMazeHero = require("ClientData/ResNewMazeHero")
local ResNewMazeFetters = require("ClientData/ResNewMazeFetters")
local ResNewMazeFeature = require("ClientData/ResNewMazeFeature")
local ATTR_PANEL_PROP_MAP = {
	{
		prop = "atk"
	},
	{
		prop = "mhp"
	},
	{
		prop = "p_def"
	},
	{
		prop = "cri_rate"
	},
	{
		prop = "cri_dmg"
	},
	{
		prop = "assist_enhance"
	},
	{
		prop = "effect_hit"
	}
}
local PropHelper = require("Common/FrameBattle/BattleObject/PropHelper")
local strClassName = "NewMazeHeroInfoDlg"
local NewMazeHeroInfoDlg = Class(strClassName, RoleInfoHeroDlg)

function NewMazeHeroInfoDlg:ctor()
	self.LosderPanelList = {}
	self.losderTitlePanel = UIControls.Panel(self, "HeroContentPanel/HeroContentBaseInfoPanel/InfoPanel/LosderTitlePanel")

	for i = 1, 3 do
		local losderPanel = UIControls.Panel(self, "HeroContentPanel/HeroContentBaseInfoPanel/InfoPanel/LosderTitlePanel/LosderPanel" .. i)
		local iconLosder = UIControls.Image(self, "HeroContentPanel/HeroContentBaseInfoPanel/InfoPanel/LosderTitlePanel/LosderPanel" .. i .. "/IconLosder")
		local textLosderName = UIControls.Label(self, "HeroContentPanel/HeroContentBaseInfoPanel/InfoPanel/LosderTitlePanel/LosderPanel" .. i .. "/TextLosderName")

		table.insert(self.LosderPanelList, {
			losderPanel = losderPanel,
			icon = iconLosder,
			name = textLosderName
		})
	end

	self.textCharacter = UIControls.Label(self, "HeroContentPanel/HeroContentBaseInfoPanel/InfoPanel/TextCharacter")
	self.panelDes = UIControls.Panel(self, "HeroContentPanel/ImgDes")
	self.txtDes = UIControls.Label(self, "HeroContentPanel/ImgDes/TxtDes")

	self.panelDes:setVisible(true)

	self.actActive = false
	self.actObj = CurAvatar:getNewMazeActivity()

	if self.actObj and self.actObj:inOpenState() then
		self.actActive = true
	end
end

function NewMazeHeroInfoDlg:setData(heros, idx, miscData)
	self.heros = heros
	self.miscData = miscData
	self.isFromNewMaze = true
	self.idx = idx or 1

	self:setSelectHero(idx)
	self:setVisible(true)
end

function NewMazeHeroInfoDlg:setSelectHero(idx)
	NewMazeHeroInfoDlg.super.setSelectHero(self, idx)
	self:setLosderData()
	self:setUpHeroData()
	self:setHeroDesc()
end

function NewMazeHeroInfoDlg:refreshUIForNewMaze(filterList)
	self:setData(filterList, self.idx, self.miscData)
end

function NewMazeHeroInfoDlg:clearRelicInfo()
	if self.gridRelic then
		self.gridRelic:setVisible(false)
	end

	self.btnRelicGrid:setEnable(true)

	local dataList = {}

	self.actObj = CurAvatar:getNewMazeActivity()

	if self.actObj then
		dataList = self.actObj.actData:getCanWearRelicsInNewMaze(self.selectedHero)
	end

	if #dataList > 0 then
		self.imgRelicNew:setVisible(self.actActive)
	else
		self.imgRelicNew:setVisible(false)
	end
end

function NewMazeHeroInfoDlg:onRelicGridClick(sender)
	if self.isFromNewMaze and Const.NEW_MAZE_ITERATION_OPEN then
		local dataList = {}

		self.actObj = CurAvatar:getNewMazeActivity()

		if self.actObj then
			dataList = self.actObj.actData:getCanWearRelicsInNewMaze(self.selectedHero)
		end

		if #dataList > 0 then
			local relicWearDlg = UIManager.getUI("relicWearDlg", true)

			relicWearDlg:setHero(self.selectedHero, dataList, nil, nil, nil, true)
			relicWearDlg.panelFund:setVisible(false)
		else
			MsgManager.clientNotice(281)
		end
	elseif self.selectedHero:getRelic() and self.gridRelic then
		UIManager.getUI("relicTips"):showObj(self, self.relic)
	end
end

function NewMazeHeroInfoDlg:setHeroDesc()
	local hero = self.selectedHero or self.heros[1]

	if utils.tableIsContainsElement(self.miscData.assist_hero, hero.id) then
		self.txtDes:setText(ClientUtils.getClientNotice(670))
	else
		self.txtDes:setText(ClientUtils.getClientNotice(669))
	end
end

function NewMazeHeroInfoDlg:setLosderData()
	local hero = self.selectedHero or self.heros[1]

	self.losderTitlePanel:setVisible(true)

	local solderList = hero:getMazeSolderState()

	for i = 1, 3 do
		if solderList[i] then
			self.LosderPanelList[i].losderPanel:setVisible(true)

			for _, data in pairs(ResNewMazeFetters) do
				if data.type == solderList[i].id and data.level == 1 then
					self.LosderPanelList[i].icon:setImage(data.icon_path, data.icon_name)
					self.LosderPanelList[i].name:setText(data.name)

					break
				end
			end
		else
			self.LosderPanelList[i].losderPanel:setVisible(false)
		end
	end
end

function NewMazeHeroInfoDlg:setUpHeroData()
	self.textCharacter:setVisible(false)
end

return NewMazeHeroInfoDlg
