-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\PetMaze\\PetMazeNmlInfoDlg.lua

local ResPetMazeNormalStage = require("ClientData/ResPetMazeNormalStage")
local ResPetMazeLayer = require("ClientData/ResPetMazeLayer")
local ResPetMazeQuality = require("ClientData/ResPetMazeQuality")
local ResPetMazeCondition = require("ClientData/ResPetMazeCondition")
local ResBattleStateShow = require("ClientData/ResBattleStateShow")
local ResColor = require("ClientData/ResColor")
local EventConst = require("EventConst")
local BtnHeroAdd = require("UI/PetMaze/BtnHeroAdd")
local CardHeroListPage = require("UI/PetMaze/CardHeroListPage")
local ConditionNode = Class("PetMazeNmlInfoDlg_ConditionNode", UIControls.Child)

function ConditionNode:ctor()
	self.txtCondition = UIControls.Label(self, "TextRequest")
	self.txtBuff = UIControls.Label(self, "TextBuff")
	self.effOnce = UIControls.Panel(self, "EfxOnce")
	self.effLoop = UIControls.Panel(self, "EfxLoop")
	self.imgDone = UIControls.Panel(self, "ImgDone")
	self.txtNum = UIControls.Label(self, "TextNum")

	self.effOnce:setVisible(false)
	self.effLoop:setVisible(false)
end

function ConditionNode:setData(conditionId, checkOk, okNum, checkChooseHero)
	self:clearTimer()

	self.conditionConfig = ResPetMazeCondition[conditionId]

	if self.conditionConfig then
		self.txtCondition:setText(self.conditionConfig.desc)

		self.buffId = self.conditionConfig.buff_id

		local buffConfig = ResBattleStateShow[self.buffId]

		if buffConfig then
			self.txtBuff:setText(buffConfig.desc)
		end

		if self.checkOk ~= checkOk then
			if checkOk then
				if checkChooseHero then
					self.effOnce:setVisible(true)
					self.effLoop:setVisible(false)

					self.slotTimerAction = self.slotTimerAction or Slot(self.timerAction, self)
					self.timer = Timer.New(self.slotTimerAction, 1, 1)

					self.timer:Start()
				else
					self.effOnce:setVisible(false)
					self.effLoop:setVisible(true)
				end
			else
				self.effOnce:setVisible(false)
				self.effLoop:setVisible(false)
			end

			self.checkOk = checkOk

			self.imgDone:setVisible(self.checkOk)

			local color = checkOk and ResColor.BUFFDONE or ResColor.BUFFUNDONE

			self.txtCondition:setFontColor(color)
			self.txtBuff:setFontColor(color)
			self.txtNum:setFontColor(color)
		end

		local needNum = self.conditionConfig.need_value

		okNum = checkOk and needNum or okNum

		self.txtNum:setText(string.format("(%d/%d)", okNum, needNum))
	end
end

function ConditionNode:timerAction()
	self.effOnce:setVisible(false)
	self.effLoop:setVisible(true)

	self.timer = nil
end

function ConditionNode:onDestroy()
	self:clearTimer()
end

function ConditionNode:clearTimer()
	if self.timer then
		self.timer:Stop()

		self.timer = nil
	end
end

local PetMazeNmlInfoDlg = Class("PetMazeNmlInfoDlg", UIControls.Window)

function PetMazeNmlInfoDlg:ctor()
	self.btnClose = UIControls.Button(self, "BgPanel/BtnClose")

	self.btnClose:addEventClick(self.onClickBtnClose)

	self.btnBattle = UIControls.Button(self, "BgPanel/BtnBattle")

	self.btnBattle:addEventClick(self.onClickBtnBattle)

	self.btnMore = UIControls.Button(self, "BgPanel/MonsterPreviewPanel/MonsterPanel/MonsterList/BtnMoreMonster")

	self.btnMore:addEventClick(self.onClickBtnMoreMonster)

	self.btnTip = UIControls.Button(self, "BgPanel/DispatchPanel/TextTitle/BtnTips")

	self.btnTip:addEventClick(self.onClickBtnTip)

	self.uiAni = UIControls.UIAni(self, "")
	self.txtName = UIControls.Label(self, "BgPanel/TextTitle")
	self.imgMonster = UIControls.Image(self, "BgPanel/ImgBg1/MonsterMask/ImgMonster")
	self.imgRole = UIControls.Role(self, "BgPanel/ImgBg1/MonsterMask/GridHeroPortrait", 0, 0)
	self.finishPanel = UIControls.Panel(self, "BgPanel/ImgBg1/MonsterMask/ImgFinish")
	self.specialAwardEffect = UIControls.Panel(self, "BgPanel/AwardPanel/AwardList/GridSpecialAward/Efx")
	self.normalHeroNodeList = {}

	local slotOnClickHeroNode = Slot(self.onClickHeroNode, self)

	for i = 1, 4 do
		local node = BtnHeroAdd(self, "BgPanel/DispatchPanel/HeroList", "System/MazzPet/BtnSupportAdd")

		node:init(slotOnClickHeroNode)
		node:setVisible(true)
		table.insert(self.normalHeroNodeList, node)
	end

	self.specialHeroNode = BtnHeroAdd(self, "BgPanel/DispatchPanel/HeroList/GridSpecialHero/BtnHeroAdd", "System/MazzPet/BtnSupportAdd")

	self.specialHeroNode:init(slotOnClickHeroNode)
	self.specialHeroNode:setVisible(true)

	self.imgSpecialHero = UIControls.Image(self, "BgPanel/DispatchPanel/HeroList/GridSpecialHero/ImgSpecialHero")
	self.specialHeroMark = UIControls.Image(self, "BgPanel/DispatchPanel/HeroList/GridSpecialHero/ImgIcon")
	self.cardHeroListPage = CardHeroListPage(self, "HeroListPanel")
	self.starBgPanelList = {}
	self.starPanelList = {}

	for i = 1, 5 do
		if UIControls.checkControlFunc(self, "BgPanel/StarPreviewPanel/TextTitle/BgStar" .. i) then
			local starBgPanel = UIControls.Panel(self, "BgPanel/StarPreviewPanel/TextTitle/BgStar" .. i)

			table.insert(self.starBgPanelList, starBgPanel)

			local starPanel = UIControls.Panel(self, "BgPanel/StarPreviewPanel/TextTitle/BgStar" .. i .. "/ImgStar")

			table.insert(self.starPanelList, starPanel)
		end
	end

	self.slotCancelAndCloseEditHeroPanel = Slot(self.cancelAndCloseEditHeroPanel, self)
	self.slotConfirmAndCloseEditHeroPanel = Slot(self.confirmAndCloseEditHeroPanel, self)
	self.slotOnActivityDataChange = Slot(self.onActivityDataChange, self)
	self.slotShowCellAction = Slot(self.showCellAction, self)
	self.slotRefreshHeroGidList = Slot(self.refreshGidList, self)
	self.slotSortHeroAction = Slot(self.sortHeroAction, self)
	self.conditionNodeList = {}
	self.monsterObjList = {}
	self.monsterNodeList = {}
	self.specialAwardCellList = {}
	self.qualityAwardCellList = {}
end

function PetMazeNmlInfoDlg:onOpen()
	PetMazeNmlInfoDlg.super.onOpen(self)
	EventCenter.addEventListener(EventConst.ACTIVITY_DATA_CHANGE, self.slotOnActivityDataChange)
end

function PetMazeNmlInfoDlg:onClose()
	EventCenter.removeEventListener(EventConst.ACTIVITY_DATA_CHANGE, self.slotOnActivityDataChange)
	PetMazeNmlInfoDlg.super.onClose(self)
end

function PetMazeNmlInfoDlg:onDestroy()
	for i = 1, #self.conditionNodeList do
		self.conditionNodeList[i]:onDestroy()
	end

	PetMazeNmlInfoDlg.super.onDestroy(self)
end

function PetMazeNmlInfoDlg:onActivityDataChange(param)
	if param ~= self.opId then
		return
	end

	self:refreshData(true)
end

function PetMazeNmlInfoDlg:setData(actData, stageId)
	self.actData = actData
	self.actObject = self.actData.actObject
	self.opId = self.actObject.opId
	self.layer = self.actData.layer
	self.maxHeroNum = self.actData.assistHeroNum
	self.stageId = stageId
	self.stageConfig = ResPetMazeNormalStage[self.stageId]
	self.pveId = self.stageConfig.battle_id

	self.cardHeroListPage:init(self.maxHeroNum, true, nil, self.slotCancelAndCloseEditHeroPanel, self.slotConfirmAndCloseEditHeroPanel, self.slotShowCellAction, self.slotRefreshHeroGidList, self.slotSortHeroAction)
	self:refreshData()
end

function PetMazeNmlInfoDlg:refreshData(checkChooseHero)
	self.areaData = self.actData:getNormalAreaData(self.stageId)
	self.checkPass = self.areaData.is_pass
	self.quality = self.areaData.quality
	self.specialHeroId = self.areaData.specialHeroId
	self.layerConfig = ResPetMazeLayer[self.layer]
	self.qualityConfig = ResPetMazeQuality[self.layer][self.quality]
	self.selectHeroList = {}
	self.selectHeroGidList = {}
	self.excludeHeroIdDic = self.actData:getSupportExcludeHeroIdDic(self.stageId)

	for i = 1, #self.areaData.selectHeroList do
		local hero = self.areaData.selectHeroList[i]

		if hero then
			local gid = hero.gid

			if self.areaData.is_pass or not self.excludeHeroIdDic[hero.id] and CurAvatar.heroDic[gid] then
				table.insert(self.selectHeroList, hero)
				table.insert(self.selectHeroGidList, gid)
			end
		end
	end

	self.specialHeroMark:setImage(self.actData.supportMarkPath, "TxtIconHired0" .. self.quality)
	self:refreshView(checkChooseHero)
end

function PetMazeNmlInfoDlg:refreshView(checkChooseHero)
	self.txtName:setText(self.stageConfig.name)
	self.imgRole:showRole(self.stageConfig.draw_id)
	ClientUtils.createMonsterGrids(self, self.pveId, self.monsterObjList, self.monsterNodeList, "BgPanel/MonsterPreviewPanel/MonsterPanel/MonsterList", 3, self.btnMore)
	self.finishPanel:setVisible(self.checkPass)
	self.btnBattle:setVisible(not self.checkPass)
	self.specialHeroNode:setEnable(not self.checkPass)

	for i = 1, #self.normalHeroNodeList do
		local node = self.normalHeroNodeList[i]

		node:setEnable(not self.checkPass)
	end

	self:refreshHero(self.selectHeroList, checkChooseHero)
end

function PetMazeNmlInfoDlg:refreshGidList(heroGidList)
	local heroList = {}

	for i = 1, #heroGidList do
		local hero = CurAvatar.heroDic[heroGidList[i]]

		if hero then
			table.insert(heroList, hero)
		end
	end

	self:refreshHero(heroList, true)
end

function PetMazeNmlInfoDlg:refreshHero(heroList, checkChooseHero)
	local normalHeroList = {}
	local specialHero

	self.checkHaveSpecialHero = false

	for i = 1, #heroList do
		local hero = heroList[i]

		if hero then
			if hero.id == self.specialHeroId then
				specialHero = hero
				self.checkHaveSpecialHero = true
			else
				table.insert(normalHeroList, hero)
			end
		end
	end

	if not specialHero and #normalHeroList >= self.maxHeroNum then
		specialHero = normalHeroList[1]

		table.remove(normalHeroList, 1)
	end

	self.specialHeroNode:setData(specialHero)
	self.imgSpecialHero:setVisible(specialHero == nil)
	self.specialHeroMark:setVisible(self.checkHaveSpecialHero or specialHero == nil)

	if not specialHero then
		self.fakeSpecialHero = self.fakeSpecialHero or BaseObject.GetObject(self.specialHeroId)

		local iconPath = self.fakeSpecialHero:getIconPath(true)

		if iconPath then
			self.imgSpecialHero:setImage(iconPath[1], iconPath[2])
		end
	end

	local heroNum = normalHeroList and #normalHeroList or 0

	for i = 1, #self.normalHeroNodeList do
		local node = self.normalHeroNodeList[i]

		if i <= heroNum then
			node:setData(normalHeroList[i])
		else
			node:setData(nil)
		end
	end

	self:refreshBuff(heroList, checkChooseHero)
	self:refreshAward()
end

function PetMazeNmlInfoDlg:onClickHeroNode(hero)
	if self.checkOpenEditHeroPanel then
		if hero then
			self.cardHeroListPage:cancelSelectCell(hero.gid)
		end
	else
		self:openEditHeroPanel()
	end
end

function PetMazeNmlInfoDlg:openEditHeroPanel()
	if not self.actData:checkHaveBattleFormation(true) then
		return
	end

	self.checkOpenEditHeroPanel = true

	self.uiAni:startAni("ShowHeroListSupport")
	self.cardHeroListPage:onOpen(self.selectHeroGidList, self.excludeHeroIdDic)
end

function PetMazeNmlInfoDlg:cancelAndCloseEditHeroPanel()
	self.checkOpenEditHeroPanel = false

	self.uiAni:startAni("HideHeroListSupport")
	self:refreshHero(self.selectHeroList, true)
end

function PetMazeNmlInfoDlg:confirmAndCloseEditHeroPanel(heroGidList)
	self:saveAndCloseEditHeroPanel(heroGidList)
end

function PetMazeNmlInfoDlg:saveAndCloseEditHeroPanel(heroGidList)
	self.checkOpenEditHeroPanel = false

	self.uiAni:startAni("HideHeroListSupport")
	RPC.petMazeSaveSupportFormation(self.actObject.opId, self.level, self.stageId, heroGidList)
end

function PetMazeNmlInfoDlg:showCellAction(sender)
	local quality = self.actData.supportHero_QualityDic[sender.hero.id]

	if quality then
		sender:setDispatchSpecial(true, self.actData.supportMarkPath, "TxtIconHired0" .. quality)
	else
		sender:setDispatchSpecial(false)
	end
end

function PetMazeNmlInfoDlg:sortHeroAction(showHeroList)
	if not showHeroList then
		return
	end

	local list = {}

	for i = #showHeroList, 1, -1 do
		local hero = showHeroList[i]

		if hero.id == self.areaData.specialHeroId then
			table.remove(showHeroList, i)
			table.insert(list, hero)
		end
	end

	for i = 1, #list do
		table.insert(showHeroList, 1, list[i])
	end
end

function PetMazeNmlInfoDlg:setHeroNodeEnable(value)
	for i = 1, #self.normalHeroNodeList do
		local node = self.normalHeroNodeList[i]

		node:setEnable(value)
	end

	self.specialHeroNode:setEnable(value)
end

function PetMazeNmlInfoDlg:refreshBuff(heroList, checkChooseHero)
	self.conditionOkList = {}

	local dataNum = self.areaData.condition and #self.areaData.condition or 0
	local nodeNum = #self.conditionNodeList

	for i = 1, dataNum do
		local node

		if i <= nodeNum then
			node = self.conditionNodeList[i]
		else
			node = ConditionNode(self, "BgPanel/BuffPanel/BuffList", "System/MazzPet/BuffRequestCell")

			table.insert(self.conditionNodeList, node)
		end

		node:setVisible(true)

		local conditionId = self.areaData.condition[i] and self.areaData.condition[i].id or 0
		local checkOk, okNum = self.actData:checkConditionOK(conditionId, heroList)

		node:setData(conditionId, checkOk, okNum, checkChooseHero)
		table.insert(self.conditionOkList, {
			conditionId,
			checkOk
		})
	end

	if dataNum < nodeNum then
		for i = dataNum + 1, nodeNum do
			self.conditionNodeList[i]:setVisible(false)
		end
	end
end

function PetMazeNmlInfoDlg:refreshAward()
	self.specialAwardEffect:setVisible(self.checkHaveSpecialHero)
	ClientUtils.CreateBonusGrid(self, self.specialAwardCellList, "BgPanel/AwardPanel/AwardList/GridSpecialAward", self.layerConfig.spec_award, false, nil, true)

	for _, cell in ipairs(self.specialAwardCellList) do
		if cell.grid and cell.grid.setIconGray then
			cell.grid:setIconGray(not self.checkHaveSpecialHero)
		end
	end

	ClientUtils.CreateBonusGrid(self, self.qualityAwardCellList, "BgPanel/AwardPanel/AwardList/GridDiffAward", self.qualityConfig.quality_award, false, nil, true)

	local starNum = 0
	local maxStarNum = 0

	if self.qualityConfig.star_award then
		maxStarNum = self.qualityConfig.star_award[2]
		starNum = self.checkHaveSpecialHero and self.qualityConfig.star_award[2] or self.qualityConfig.star_award[1]
	end

	for i = 1, #self.starPanelList do
		local checkBg = i <= maxStarNum

		self.starBgPanelList[i]:setVisible(checkBg)

		if checkBg then
			self.starPanelList[i]:setVisible(i <= starNum)
		end
	end
end

function PetMazeNmlInfoDlg:onClickBtnBattle()
	if not self.actData:checkHaveBattleFormation(true) then
		return
	end

	local checkSpecialHeroOk = false
	local checkStarOk = true
	local heroList = {}

	for i = 1, #self.selectHeroGidList do
		local gid = self.selectHeroGidList[i]
		local hero = CurAvatar.heroDic[gid]

		if hero then
			table.insert(heroList, hero)

			if hero.id == self.specialHeroId then
				checkSpecialHeroOk = true
			end
		end
	end

	local conditionDataList = self.areaData.condition
	local dataNum = conditionDataList and #conditionDataList or 0

	for i = 1, dataNum do
		local conditionId = conditionDataList[i] and conditionDataList[i].id or 0
		local checkOk = self.actData:checkConditionOK(conditionId, heroList)

		if not checkOk then
			checkStarOk = false

			break
		end
	end

	self.slotStartBattle = self.slotStartBattle or Slot(self.startBattle, self)

	if not checkSpecialHeroOk then
		local content = Lang.get(77969)

		UIManager.showConfirm(UIConst.CONFIRM_TWOBTN, "", content, self.slotStartBattle)
	elseif not checkStarOk then
		local content = Lang.get(77970)

		UIManager.showConfirm(UIConst.CONFIRM_TWOBTN, "", content, self.slotStartBattle)
	else
		self:startBattle()
	end
end

function PetMazeNmlInfoDlg:startBattle()
	RPC.petMazeSaveSupportFormation(self.actObject.opId, self.level, self.stageId, self.selectHeroGidList)
	self.actData:startBattle(nil, self.stageId, self.pveId, self.conditionOkList)
end

function PetMazeNmlInfoDlg:onClickBtnMoreMonster()
	UIManager.getUI("onceTowerMonsterDlg", true):onShow(self.monsterObjList)
end

function PetMazeNmlInfoDlg:onClickBtnTip()
	UIManager.getUI("infoNotice", true):showSystemInfo(374)
end

function PetMazeNmlInfoDlg:onClickBtnClose()
	self:setVisible(false)
end

return PetMazeNmlInfoDlg
