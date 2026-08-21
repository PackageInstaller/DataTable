-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\SneakBattle\\SneakBattleStageInfoDlg.lua

local ResBattleConfig = require("ClientData/ResBattleConfig")
local ResBattleTarget = require("ClientData/ResBattleTarget")
local ResNewPveShow = require("ClientData/ResNewPveShow")
local Hero = require("Common/Object/Hero")
local SneakBattleStageInfoDlg = Class("SneakBattleStageInfoDlg", UIControls.Window)

function SneakBattleStageInfoDlg:ctor(...)
	self:initUI()
end

function SneakBattleStageInfoDlg:initUI(...)
	self.txtTitle = UIControls.Label(self, "BgPanel/TextTitle")
	self.txtName = UIControls.Label(self, "BgPanel/TextTitle/TextName")
	self.btnBuff = UIControls.Button(self, "BgPanel/BtnBuff")

	self.btnBuff:addEventClick(self.onBtnBuffClick)

	self.imgFinish = UIControls.Image(self, "BgPanel/ImgFinish")
	self.imgPerfect = UIControls.Image(self, "BgPanel/ImgPerfect")
	self.txtDescFinish = UIControls.Label(self, "BgPanel/InfoPanel/TextDescFinish")
	self.txtDescPerfect = UIControls.Label(self, "BgPanel/InfoPanel/TextDescPerfect")
	self.limitPanel = UIControls.Panel(self, "BgPanel/InfoPanel/LimitPanel")
	self.imgLimitIcon = UIControls.Image(self, "BgPanel/InfoPanel/LimitPanel/ImgIcon")
	self.txtLImitTitle = UIControls.Label(self, "BgPanel/InfoPanel/LimitPanel/TextTitle")
	self.txtLimitDesc = UIControls.Label(self, "BgPanel/InfoPanel/LimitPanel/TextDesc")
	self.imgEmptyLimit = UIControls.Image(self, "BgPanel/InfoPanel/ImgEmptyLimit")
	self.moreMonsterPanel = UIControls.Image(self, "BgPanel/MoreMonsterPanel")
	self.buffPanel = UIControls.Image(self, "BgPanel/BuffPanel")
	self.iconBuff = UIControls.Image(self, "BgPanel/BuffPanel/Icon")
	self.txtBuffTitle = UIControls.Label(self, "BgPanel/BuffPanel/TextTitle")
	self.txtBuffDesc = UIControls.Label(self, "BgPanel/BuffPanel/TextDesc")
	self.uIClick = UIControls.Button(self, "BgPanel/UIClick")

	self.uIClick:addEventClick(self.onUIClickClick)

	self.btnAwardTips = UIControls.Button(self, "BgPanel/InfoPanel/BtnAwardTips")

	self.btnAwardTips:addEventClick(self.onBtnAwardTipsClick)

	self.imgAwardReceived = UIControls.Image(self, "BgPanel/InfoPanel/ImgAwardReceived")
	self.awardPanel = UIControls.Panel(self, "BgPanel/InfoPanel/AwardList")
	self.imgElite = UIControls.Image(self, "BgPanel/ImgElite")
	self.moreMonsterPanel = UIControls.Image(self, "BgPanel/MoreMonsterPanel")
	self.btnMonsterMore = UIControls.Button(self, "BgPanel/MonsterPanel/BtnMore")

	self.btnMonsterMore:addEventClick(self.onBtnMonsterMoreClick)

	self.moreMonsterCells = {}
	self.awardCells = {}
	self.heroCells = {}
	self.btnStart = UIControls.Button(self, "BgPanel/TeamPanel/BtnStart")

	self.btnStart:addEventClick(self.onBtnStartFightClick)

	self.lockedPanel = UIControls.Button(self, "BgPanel/TeamPanel/LockedPanel")

	self.lockedPanel:addEventClick(self.onLockedPanelClick)

	self.heroPanel = UIControls.Panel(self, "BgPanel/TeamPanel/HeroPanel")
	self.imgEmpty = UIControls.Image(self, "BgPanel/TeamPanel/ImgEmpty")
end

function SneakBattleStageInfoDlg:setData(actData, stage)
	self.actData = actData or self.actData

	if self.actData then
		self.stage = stage or 1

		local txtStage = self.stage

		if txtStage < 10 then
			txtStage = "0" .. txtStage
		end

		self.txtTitle:setText(txtStage)

		local stageData = self.actData:getNowLevelStageData()

		if stageData and stageData[self.stage] then
			self.stageData = stageData[self.stage]
		end

		if self.stageData then
			if self.stageData.chinese_name then
				self.txtName:setText(self.stageData.chinese_name)
			end

			self.imgElite:setVisible(self.stageData.need_limit and self.stageData.need_limit == 1)

			if self.stageData.canEnter then
				self.btnStart:setVisible(true)
				self.lockedPanel:setVisible(false)
			else
				self.btnStart:setVisible(false)
				self.lockedPanel:setVisible(true)
			end

			if self.stageData.limit and self.stageData.limit ~= 0 then
				local limitData = self.actData:getLimitResDataById(self.stageData.limit)

				if limitData then
					self.limitPanel:setVisible(true)
					self.imgEmptyLimit:setVisible(false)
					self.imgLimitIcon:setImage(limitData.icon_path, limitData.icon_name)
					self.txtLImitTitle:setText(limitData.name)
					self.txtLimitDesc:setText(limitData.desc)
				else
					self.limitPanel:setVisible(false)
					self.imgEmptyLimit:setVisible(true)
				end
			else
				self.limitPanel:setVisible(false)
				self.imgEmptyLimit:setVisible(true)
			end

			if self.stageData.strongPass then
				self.imgPerfect:setVisible(true)
				self.imgFinish:setVisible(false)
			else
				self.imgPerfect:setVisible(false)

				if self.stageData.weakPass then
					self.imgFinish:setVisible(true)
				else
					self.imgFinish:setVisible(false)
				end
			end

			if self.stageData.pve_id then
				local target = self.actData:getTargetsByPveId(self.stageData.pve_id)

				if target then
					if target[1] then
						self.txtDescPerfect:setText(utils.format(Lang.get(96442), target[1].desc))
					end

					if target[2] then
						self.txtDescFinish:setText(utils.format(Lang.get(96443), target[2].desc))
					end
				end
			end

			self:refreshMonster()
			self:refreshAward()
			self:refreshFormation()
		end
	end
end

function SneakBattleStageInfoDlg:refreshAward(...)
	if self.actData then
		local showIds, showNums = self.actData:getLevelWeekAwardShow(self.actData.nowSelectLevel, self.stage)

		if showIds and #showIds ~= 0 then
			self.imgAwardReceived:setVisible(false)
			self.awardPanel:setVisible(true)

			for index, id in ipairs(showIds) do
				if not self.awardCells[index] then
					self.awardCells[index] = UIControls.getGridAwardContainer(self, "BgPanel/InfoPanel/AwardList/Content")

					self.awardCells[index]:setVisible(true)
				end

				local fakeItem = BaseObject.GetObject(showIds[index], showNums[index])

				self.awardCells[index]:setObj(fakeItem)

				if self.awardCells[index].grid then
					self.awardCells[index].grid.mDisableWays = true
				end
			end
		else
			self.imgAwardReceived:setVisible(true)
			self.awardPanel:setVisible(false)
		end
	end
end

function SneakBattleStageInfoDlg:refreshFormation(...)
	if self.stageData then
		local formation = self.stageData.formation

		if formation and formation.hero and #formation.hero ~= 0 then
			self.heroPanel:setVisible(true)
			self.imgEmpty:setVisible(false)

			local heros = formation.hero
			local count = 0

			if heros then
				count = #heros

				for index, hero in ipairs(heros) do
					if not self.heroCells[index] then
						self.heroCells[index] = UIControls.HeroGridChild(self, "BgPanel/TeamPanel/HeroPanel/GridHero" .. index, "System/StarUp/GridHeroStarUp", 0, 0, true)

						self.heroCells[index]:setVisible(true)
					end

					local heroGrid = Hero({
						resid = hero.resid
					})

					self.heroCells[index]:setObj(heroGrid)

					self.heroCells[index].mEnableTips = false

					self.heroCells[index]:setSneakBattleShow()
				end
			end

			for index = count + 1, #self.heroCells do
				self.heroCells[index]:setVisible(false)
			end

			if formation.pet_id and formation.pet_id ~= 0 then
				if not self.gridPet then
					self.gridPet = UIControls.PetCardChild(self, "BgPanel/TeamPanel/HeroPanel/GridPet", "System/Pet/GridPetCardMini")
				end

				self.gridPet:setVisible(true)

				local pet = CurAvatar.petDic[formation.pet_id]

				self.gridPet:setPet(pet)
			end
		else
			self.heroPanel:setVisible(false)
			self.imgEmpty:setVisible(true)
		end
	end
end

function SneakBattleStageInfoDlg:refreshMonster(...)
	self.monsterObjList = {}
	self.monsterNodeList = self.monsterNodeList or {}

	ClientUtils.createMonsterGrids(self, self.stageData.pve_id, self.monsterObjList, self.monsterNodeList, "BgPanel/MonsterPanel/ListMonster", 3, self.btnMonsterMore)
end

function SneakBattleStageInfoDlg:refreshUI()
	return
end

function SneakBattleStageInfoDlg:onBtnBuffClick()
	if self.actData then
		local buffData = self.actData:getBuffResData()

		if buffData then
			self.txtBuffTitle:setText(buffData.name)
			self.txtBuffDesc:setText(buffData.desc)
			self.iconBuff:setImage(buffData.icon_path, buffData.icon_name)
			self.buffPanel:setVisible(true)
			self.uIClick:setVisible(true)
		end
	end
end

function SneakBattleStageInfoDlg:onBtnMonsterMoreClick()
	for index = #self.moreMonsterCells, #self.monsterObjList - 1 do
		local newCell = UIControls.MonsterCardChild(self, "BgPanel/MoreMonsterPanel/MonsterList", "System/Common/Grid/GridMonster")

		table.insert(self.moreMonsterCells, newCell)
	end

	for index, cell in ipairs(self.moreMonsterCells) do
		if self.monsterObjList[index] then
			cell:setVisible(true)
			cell:setObj(self.monsterObjList[index])
		else
			cell:setVisible(false)
		end
	end

	self.moreMonsterPanel:setVisible(true)
	self.uIClick:setVisible(true)
end

function SneakBattleStageInfoDlg:onBtnAwardTipsClick()
	UIManager.getUI("infoNotice", true):showSystemInfo(485)
end

function SneakBattleStageInfoDlg:onUIClickClick()
	self.uIClick:setVisible(false)
	self.moreMonsterPanel:setVisible(false)
	self.buffPanel:setVisible(false)
end

function SneakBattleStageInfoDlg:onBtnStartFightClick()
	if self.actData then
		if self.actData:isInFrozenTime() == true then
			if ResNewPveShow and ResNewPveShow[13090008] then
				MsgManager.notice(ResNewPveShow[13090008].desc)
			end
		else
			local check = self.actData:checkCanEnterStage()

			if check then
				if not self.actData:checkHaveLockedStage() then
					local battleData = self.stageData

					CurAvatar:enterFormation(self.stageData.pve_id, BattleConst.BATTLE_TYPE_SNEAK_BATTLE, battleData)
				elseif self.actData.lockedStage == self.stage then
					local battleData = self.stageData

					CurAvatar:enterFormation(self.stageData.pve_id, BattleConst.BATTLE_TYPE_SNEAK_BATTLE, battleData)
				elseif ResNewPveShow[13090014] then
					MsgManager.notice(ResNewPveShow[13090014].desc)
				end
			elseif ResNewPveShow[13090003] then
				MsgManager.notice(ResNewPveShow[13090003].desc)
			end
		end
	end
end

function SneakBattleStageInfoDlg:onLockedPanelClick()
	if ResNewPveShow[13090006] then
		MsgManager.notice(ResNewPveShow[13090006].desc)
	end
end

return SneakBattleStageInfoDlg
