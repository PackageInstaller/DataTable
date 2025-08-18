-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Battle\\BattleBonusDlg.lua

local ResRoleAttr = require("ClientData/ResRoleAttr")
local ResPetMazeQuality = require("ClientData/ResPetMazeQuality")
local ResPetMazeLayer = require("ClientData/ResPetMazeLayer")
local BattleAwardMixin = require("UI/Battle/BattleAwardMixin")
local strClassName = "BattleBonusDlg"
local BattleBonusDlg = Class(strClassName, UIControls.Window)
local ClientUtils = ClientUtils

MixinClass(BattleBonusDlg, BattleAwardMixin, true)

function BattleBonusDlg:ctor()
	self:ctorMixin()
	self:initUI()
end

function BattleBonusDlg:initUI()
	self.expPanel = UIControls.Panel(self, "BgPanel/ExpPanel")
	self.sliderExp = UIControls.Slider(self, "BgPanel/ExpPanel/Slider")
	self.textLevel = UIControls.Label(self, "BgPanel/ExpPanel/TextLv")
	self.bonusGrids = {}
	self.btnConfirm = UIControls.Button(self, "BgPanel/BtnConfirm")

	self.btnConfirm:addEventClick(self.onClickConfirm)

	self.imgRole = UIControls.Role(self, "BgPanel/GridHeroPortrait", 0, 0)
	self.txtName = UIControls.Label(self, "BgPanel/ExpPanel/TextPlayerName")
	self.effectSlider = UIControls.Panel(self, "BgPanel/ExpPanel/EfxSlider")
	self.btnHead = UIControls.PlayerHeadGridChild(self, "BgPanel/ExpPanel/GridPlayer", "System/Common/Grid/GridPlayerCommon")

	self.btnHead:hideLevel()
	self.btnHead:setEnable(false)
	self.btnHead:setCommInfo(CurAvatar:getMyCommInfo(), false, self)

	self.petMazePanel = UIControls.Panel(self, "BgPanel/MazzPetStarPanel")
	self.starBgPanelList = {}
	self.starPanelList = {}

	for i = 1, 5 do
		if UIControls.checkControlFunc(self, "BgPanel/MazzPetStarPanel/TextTitleStar/BgStar" .. i) then
			local starBgPanel = UIControls.Panel(self, "BgPanel/MazzPetStarPanel/TextTitleStar/BgStar" .. i)

			table.insert(self.starBgPanelList, starBgPanel)

			local starPanel = UIControls.Panel(self, "BgPanel/MazzPetStarPanel/TextTitleStar/BgStar" .. i .. "/ImgStar")

			table.insert(self.starPanelList, starPanel)
		end
	end

	self.petMazeNextSeasonPanel = UIControls.Panel(self, "BgPanel/TextNextDiff")
	self.petMazeNextScorePanel = UIControls.Panel(self, "BgPanel/TextNextScore")
end

function BattleBonusDlg:onOpenOver()
	BattleBonusDlg.super.onOpenOver(self)

	if self.commonBonus then
		self:_onStartAnim()
	end
end

function BattleBonusDlg:bgmOn()
	local battleState = GameFsm.getCurState()

	if battleState and battleState.relicHero then
		local battleBGM = battleState.relicHero:getRelicBgmIdByType(Const.RELIC_BGM_TYPE_VICTORY)

		if battleBGM then
			CueManager.playUIBGM(battleBGM)
		end
	else
		BattleBonusDlg.super.bgmOn(self)
	end
end

function BattleBonusDlg:onShow(commonBonus, itemBonus, battleType, finish)
	self.commonBonus = commonBonus
	self.itemBonus = itemBonus

	if itemBonus then
		local specBonus = itemBonus.activityBonus

		itemBonus.activityBonus = nil

		local clientItems = {}

		for _, item in pairs(itemBonus) do
			table.insert(clientItems, item)
		end

		for index, item in ipairs(clientItems) do
			local newGrid = UIControls.getGridChild(item, self, "BgPanel/GridPanel")

			newGrid:setVisible(true)
			newGrid:setObj(item)

			newGrid.mDisableWays = true

			table.insert(self.bonusGrids, newGrid)
		end

		local actObj = CurAvatar:getStageAchieveActivity()

		for index, item in ipairs(specBonus or {}) do
			local newGrid = UIControls.getGridAwardContainer(self, "BgPanel/GridPanel")

			newGrid:setVisible(true)
			newGrid:setObj(item)

			newGrid.mDisableWays = true

			if actObj then
				newGrid:setActivitySpecialImage(actObj.actId)
			end

			table.insert(self.bonusGrids, newGrid)
		end
	end

	local battleState = GameFsm.getState(Const.STATE_BATTLE)
	local mvp = battleState:getMVPActor()

	if mvp then
		local portId = mvp.hero:getShowPortId()

		self.imgRole:showRole(portId)
	end

	if battleType and battleType == BattleConst.BATTLE_TYPE_MAZE_PET then
		self:showShareBtn(false)
		self.expPanel:setVisible(false)

		local data = finish.spec and finish.spec.pet_maze

		if data then
			if data.stage_id and data.stage_id > 0 then
				self.petMazePanel:setVisible(true)

				local qualityConfig = ResPetMazeQuality[data.level][data.quality]
				local starNum = data.star
				local maxStarNum = qualityConfig.star_award[2]

				for i = 1, #self.starPanelList do
					local checkBg = i <= maxStarNum

					self.starBgPanelList[i]:setVisible(checkBg)

					if checkBg then
						self.starPanelList[i]:setVisible(i <= starNum)
					end
				end

				self.awardCellList = self.awardCellList or {}

				local awardList = {}
				local checkHaveSpecialHero = false
				local actObj = CurAvatar:getActivityObjByType(Const.ACT_TYPE_PET_MAZE)

				if actObj and actObj.actData then
					local areaData = actObj.actData:getNormalAreaData(data.stage_id)

					if areaData then
						local heroList = areaData.selectHeroList

						if #heroList > 0 then
							checkHaveSpecialHero = heroList[1].id == areaData.specialHeroId
						end
					end
				end

				if checkHaveSpecialHero then
					local layerConfig = ResPetMazeLayer[data.level]

					table.insert(awardList, layerConfig.spec_award)
					table.insert(awardList, qualityConfig.quality_award)
				else
					table.insert(awardList, qualityConfig.quality_award)
				end

				ClientUtils.CreatePreviewBonusSumGrid(self, self.awardCellList, "BgPanel/MazzPetStarPanel/MazzPetGridPanel", awardList, nil, nil, true)
			elseif data.boss_id and data.boss_id > 0 then
				if data.is_pass and data.is_pass > 0 then
					self.petMazeNextSeasonPanel:setVisible(true)
				else
					self.petMazeNextScorePanel:setVisible(true)
				end
			end
		end
	else
		self.txtName:setText(CurAvatar:getPlayerName())

		if ResRoleAttr[self.commonBonus.pre_level] and ResRoleAttr[self.commonBonus.after_level] then
			local valueData = {}

			valueData.preLevel = self.commonBonus.pre_level
			valueData.prePercent = self.commonBonus.pre_xp / ResRoleAttr[self.commonBonus.pre_level].levelxp
			valueData.curLevel = self.commonBonus.after_level
			valueData.curPercent = self.commonBonus.after_xp / ResRoleAttr[self.commonBonus.after_level].levelxp
			self.valueData = valueData

			self.sliderExp:setValue(valueData.prePercent)
		end

		battleType = battleState.battleType
	end

	self:playCustomBgm(battleType, "result_award")
end

function BattleBonusDlg:_onStartAnim()
	if ResRoleAttr[self.commonBonus.pre_level] and ResRoleAttr[self.commonBonus.after_level] then
		local function func()
			self.effectSlider:setVisible(true)
			self.effectSlider:playEffect()

			return 1
		end

		local function f()
			return
		end

		local uiData = {
			slider = self.sliderExp,
			levelLabel = self.textLevel
		}

		self.coFunc = ClientUtils.sliderAni(uiData, self.valueData, 0, nil, func, f)
	else
		self.sliderExp:setValue(0)
	end
end

function BattleBonusDlg:onClickConfirm()
	coroutine.stop(self.coFunc)

	self.enterMain = true

	self:setVisible(false)
end

function BattleBonusDlg:destroy()
	BattleBonusDlg.super.destroy(self)

	if not GameFsm.isInState(Const.STATE_BATTLE) then
		return
	end

	if self.enterMain then
		GameFsm.getCurState():exitBattle(true)
	end
end

return BattleBonusDlg
