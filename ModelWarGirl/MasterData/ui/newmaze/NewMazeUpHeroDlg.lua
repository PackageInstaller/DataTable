-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\NewMaze\\NewMazeUpHeroDlg.lua

local ResNewMazeHero = require("ClientData/ResNewMazeHero")
local ResNewMazeFetters = require("ClientData/ResNewMazeFetters")
local ResNewMazeDisplay = require("ClientData/ResNewMazeDisplay")
local ResNewMazeTalent = require("ClientData/ResNewMazeTalent")
local NewMazeLosderTipsInfoPanel = require("UI/NewMaze/NewMazeLosderTipsInfoPanel")
local HeroCharacterGrid = require("UI/NewMaze/HeroCharacterGrid")
local CharacterTipsPanel = require("UI/NewMaze/CharacterTipsPanel")
local NewMazeTalentGrid = require("UI/NewMaze/NewMazeTalentGrid")
local strClassName = "TalentTipsPanel"
local TalentTipsPanel = Class(strClassName, UIControls.Child)

function TalentTipsPanel:ctor(...)
	self.textTitle = UIControls.Label(self, "TextTitle")
	self.textDes = UIControls.Label(self, "TextDes")
	self.iconTalent = UIControls.Image(self, "IconSkill")
end

function TalentTipsPanel:setData(groupId)
	self.groupId = groupId
	self.groupData = ResNewMazeTalent[groupId]

	local showData = self.groupData[1]

	if showData.iconPath then
		self.iconTalent:setImage(showData.iconPath, showData.icon)
	end

	self.textTitle:setText(showData.name)
	self.textDes:setText(showData.desc)
end

local strClassName = "NewMazeUpHeroPanel"
local NewMazeUpHeroPanel = Class(strClassName, UIControls.Child)

function NewMazeUpHeroPanel:ctor(...)
	self:initUI()
end

function NewMazeUpHeroPanel:initUI()
	self.anim = UIControls.UIAni(self, "")
	self.textRule = UIControls.Label(self, "BgPanel/BgRule/TextRule")
	self.textName = UIControls.Label(self, "BgPanel/TextName")
	self.textName2 = UIControls.Label(self, "BgPanel/TextNamePanel/TextName")
	self.LosderPanelList = {}

	for i = 1, 3 do
		local losderPanel = UIControls.Panel(self, "BgPanel/BgLosder/LosderList/LosderPanel" .. i)
		local iconLosder = UIControls.Image(self, "BgPanel/BgLosder/LosderList/LosderPanel" .. i .. "/IconLosder")
		local textLosderName = UIControls.Label(self, "BgPanel/BgLosder/LosderList/LosderPanel" .. i .. "/TextLosderName")
		local btn = UIControls.Button(self, "BgPanel/BgLosder/LosderList/LosderPanel" .. i)

		btn:addEventClick(Functor(self.gridLosderClick, self, i))

		local iconLimitUp

		if UIControls.checkControlFunc(self, "BgPanel/BgLosder/LosderList/LosderPanel" .. i .. "/IconLimitUp") then
			iconLimitUp = UIControls.Panel(self, "BgPanel/BgLosder/LosderList/LosderPanel" .. i .. "/IconLimitUp")
		end

		table.insert(self.LosderPanelList, {
			losderPanel = losderPanel,
			icon = iconLosder,
			name = textLosderName,
			btn = btn,
			iconLimitUp = iconLimitUp
		})
	end

	self.losderTipsPanel = UIControls.Panel(self, "BgPanel/BgLosder/LosderTipsPanel")
	self.losderTipsInfoPanel = NewMazeLosderTipsInfoPanel(self, "BgPanel/BgLosder/LosderTipsPanel", "System/Rogue/LosderTipsInfoPanel")
	self.characterCellList = {}
	self.panelCharacterTips = UIControls.Panel(self, "BgPanel/BgCharacter/CharacterTipsPanel")
	self.TalentTipsPanel = TalentTipsPanel(self, "BgPanel/BgCharacter/CharacterTipsPanel", "System/Rogue/CharacterSkillPanel")
	self.uIClickThrough1 = UIControls.Button(self, "BgPanel/BgCharacter/CharacterTipsPanel/UIClickThrough")

	self.uIClickThrough1:addEventClick(self.onUIClickThroughClick)

	self.uIClickThrough2 = UIControls.Button(self, "BgPanel/BgLosder/LosderTipsPanel/UIClickThrough")

	self.uIClickThrough2:addEventClick(self.onUIClickThroughClick)

	self.rolePortraitShadow = UIControls.Role(self, "BgPanel/Bg/Mask/HeropanelShadow", 0, 0)
	self.rolePortrait = UIControls.Role(self, "BgPanel/Bg/Mask/Heropanel", 0, 0)
	self.talentCellList = {}
end

function NewMazeUpHeroPanel:playPanelAnimation()
	self.anim:startAni("ShowRogueHeroCanvas", true)
end

function NewMazeUpHeroPanel:setData()
	self.newMazeData = self.mParent.newMazeData

	local heroData = ResNewMazeHero[self.newMazeData.heroId]

	self.rolePortraitShadow:showRole(heroData.id, UIConst.ROLEIMAGE_SHOWTYPE_NEW_MAZE_UPHERO)
	self.rolePortrait:showRole(heroData.id, UIConst.ROLEIMAGE_SHOWTYPE_NEW_MAZE_UPHERO)
	self.textName:setText(heroData.name)
	self.textName2:setText(heroData.name)
	self.textRule:setText(ResNewMazeDisplay[13060001].desc)

	local labelList = {}

	if self.newMazeData.heroInitSolder and self.newMazeData.heroInitSolder.fetter1_id and self.newMazeData.heroInitSolder.fetter1_id > 0 then
		if self.newMazeData.heroInitSolder.fetter1_id > 0 then
			table.insert(labelList, self.newMazeData.heroInitSolder.fetter1_id)
		end

		if self.newMazeData.heroInitSolder.fetter2_id > 0 then
			table.insert(labelList, self.newMazeData.heroInitSolder.fetter2_id)
		end

		if self.newMazeData.heroInitSolder.fetter3_id > 0 then
			table.insert(labelList, self.newMazeData.heroInitSolder.fetter3_id)
		end

		self.addUpLabel = false
	else
		if heroData.team_label then
			table.insert(labelList, heroData.team_label)
		end

		if heroData.feature_label1 then
			table.insert(labelList, heroData.feature_label1)
		end

		if heroData.feature_label2 then
			table.insert(labelList, heroData.feature_label2)
		end

		if heroData.extra_label_flag and heroData.extra_label_flag == 1 then
			self.addUpLabel = true
		end
	end

	self.fettersTableData = {}

	for i = 1, 3 do
		if labelList[i] then
			self.LosderPanelList[i].losderPanel:setVisible(true)

			for _, data in pairs(ResNewMazeFetters) do
				if data.type == labelList[i] and data.level == 1 then
					self.LosderPanelList[i].icon:setImage(data.icon_path, data.icon_name)
					self.LosderPanelList[i].name:setText(data.name)

					self.fettersTableData[i] = data

					break
				end
			end

			if self.LosderPanelList[i].iconLimitUp and self.addUpLabel then
				self.LosderPanelList[i].iconLimitUp:setVisible(true)
			end
		else
			self.LosderPanelList[i].losderPanel:setVisible(false)
		end
	end

	for i, groupId in ipairs(self.newMazeData.miscData.up_hero_talent_group or {}) do
		local cell = self.talentCellList[i]

		if cell == nil then
			cell = NewMazeTalentGrid(self, "BgPanel/BgCharacter/CharacterList", "System/Rogue/GridRogueCharacterSkill", 0, 0, true)
		end

		cell:setData(groupId)

		cell.mEventCellClick = Slot(self.onOpenTalentTipsClick, self)
		self.talentCellList[i] = cell
	end
end

function NewMazeUpHeroPanel:gridLosderClick(index)
	self.losderTipsInfoPanel:setData(nil, self.fettersTableData[index], true)
	self.losderTipsPanel:setVisible(true)
	self.losderTipsInfoPanel:setVisible(true)
end

function NewMazeUpHeroPanel:onOpenTalentTipsClick(grid)
	self.TalentTipsPanel:setData(grid.groupId)
	self.TalentTipsPanel:setVisible(true)
	self.panelCharacterTips:setVisible(true)
end

function NewMazeUpHeroPanel:onUIClickThroughClick()
	self.TalentTipsPanel:setVisible(false)
	self.panelCharacterTips:setVisible(false)
	self.losderTipsPanel:setVisible(false)
	self.losderTipsInfoPanel:setVisible(false)
end

local strClassName = "NewMazeUpHeroDlg"
local NewMazeUpHeroDlg = Class(strClassName, UIControls.Window)

function NewMazeUpHeroDlg:ctor(...)
	self:initUI()
end

function NewMazeUpHeroDlg:initUI()
	return
end

function NewMazeUpHeroDlg:setData()
	self.actObj = CurAvatar:getNewMazeActivity()

	if self.actObj then
		self.newMazeData = self.actObj.actData
	else
		MsgManager.notice(Lang.get(32785))

		return
	end

	local prefabStr = "System/Rogue/HeroFeatures/RogueHeroPanel"

	if not self.upHeroPanel then
		self.upHeroPanel = NewMazeUpHeroPanel(self, "BgPanel", prefabStr, 0, 0, true)
	end

	self.upHeroPanel:setData()
	self.upHeroPanel:playPanelAnimation()
end

return NewMazeUpHeroDlg
