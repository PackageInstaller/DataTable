-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\SneakBattle\\SneakBattleTeamSetDlg.lua

local FilterSelectPanel = require("UI/MainState/FilterSelectPanel")
local HeroGridSneakBattlePFCard = require("UI/SneakBattle/HeroGridSneakBattlePFCard")
local ResBattleFormationLimit = require("ClientData/ResBattleFormationLimit")
local ResNewPveShow = require("ClientData/ResNewPveShow")
local CommonHeroListPanel = require("UI/Battle/CommonHeroListPanel")
local Hero = require("Common/Object/Hero")
local SneakBattleTeamSetTeamCell = Class("SneakBattleTeamSetTeamCell", UIControls.ScrollViewLoopCell)

function SneakBattleTeamSetTeamCell:ctor(...)
	self:initUI()
end

function SneakBattleTeamSetTeamCell:initUI(...)
	self.imgNml = UIControls.Image(self, "ContentPanel/ImgNml")
	self.imgBlock = UIControls.Image(self, "ContentPanel/ImgBlock")
	self.imgSlc = UIControls.Image(self, "ContentPanel/ImgSlc")
	self.imgLocked = UIControls.Image(self, "ContentPanel/ImgLocked")
	self.txtStageTitle = UIControls.Label(self, "ContentPanel/TextTitle")
	self.imgLimitIcon = UIControls.Image(self, "ContentPanel/ImgIcon")
	self.btnContent = UIControls.Button(self, "ContentPanel")

	self.btnContent:addEventClick(self.onBtnContentClick)

	self.slotOnHeroCellClick = Slot(self.onHeroCellClick, self)
	self.slotOnPetCellClick = Slot(self.onPetCellClick, self)
	self.heroCells = {}
	self.imgReset = UIControls.Image(self, "ContentPanel/ImgReset")
	self.btnReset = UIControls.Button(self, "ContentPanel/BtnReset")

	self.btnReset:addEventClick(self.onBtnResetClick)

	self.btnResetDis = UIControls.Button(self, "ContentPanel/BtnResetDis")

	self.btnResetDis:addEventClick(self.onBtnResetDisClick)

	self.imgConflict = UIControls.Image(self, "ContentPanel/ImgConflict")
end

function SneakBattleTeamSetTeamCell:setData(data)
	self.data = data or self.data

	if self.data then
		if self.data.canChange then
			self.imgLocked:setVisible(false)
		else
			self.imgLocked:setVisible(true)
		end

		if self.data.limit and self.data.limit ~= 0 then
			self.imgLimitIcon:setVisible(true)

			local resData = self.mParent.actData:getLimitResDataById(self.data.limit)

			if resData then
				self.imgLimitIcon:setImage(resData.icon_path, resData.icon_name)
			end
		else
			self.imgLimitIcon:setVisible(false)
		end

		self.txtStageTitle:setText(self.data.stage_name)

		local formation = self.data.formation

		if formation and formation.hero then
			local heros = formation.hero
			local count = 0

			if heros then
				count = #heros

				for index, hero in ipairs(heros) do
					if not self.heroCells[index] then
						self.heroCells[index] = UIControls.HeroGridChild(self, "ContentPanel/HeroPanel/GridHero" .. index, "System/StarUp/GridHeroStarUp", 0, 0, true)
					end

					local heroGrid = Hero({
						resid = hero.resid
					})

					self.heroCells[index]:setVisible(true)

					self.heroCells[index].mEventClick = self.slotOnHeroCellClick

					self.heroCells[index]:setObj(heroGrid)

					self.heroCells[index].mEnableTips = false

					self.heroCells[index]:setSneakBattleShow()
				end

				if self.data and self.data.limit ~= 0 then
					local checkHeros = {}

					for index, hero in ipairs(heros) do
						table.insert(checkHeros, Hero({
							resid = hero.resid
						}))
					end

					self.imgConflict:setVisible(not utils.checkFormationConditionLimit(self.data.limit, checkHeros))
				else
					self.imgConflict:setVisible(false)
				end
			else
				self.imgConflict:setVisible(false)
			end

			for index = count + 1, #self.heroCells do
				self.heroCells[index]:setVisible(false)
			end
		else
			self.imgConflict:setVisible(false)

			if self.heroCells then
				for index, cell in ipairs(self.heroCells) do
					cell:setVisible(false)
				end
			end
		end

		if not self.gridPet then
			self.gridPet = UIControls.PetCardChild(self, "ContentPanel/HeroPanel/GridPet", "System/Pet/GridPetCardMini")

			self.gridPet:setSelectCallback(Slot(self.onPetCellClick, self))
		end

		if formation and formation.pet_id and formation.pet_id ~= 0 then
			self.gridPet:setVisible(true)

			local pet = CurAvatar.petDic[formation.pet_id]

			self.gridPet:setPet(pet)
		else
			self.gridPet:setVisible(false)
		end
	end

	self:refreshState()
end

function SneakBattleTeamSetTeamCell:refreshState(...)
	if self.data then
		self.imgSlc:setVisible(self.data.stage == self.mParent.nowSelectStage)
		self.imgNml:setVisible(self.data.stage ~= self.mParent.nowSelectStage)
		self.imgBlock:setVisible(self.data.stage ~= self.mParent.nowSelectStage)

		if self.data.stage <= self.mParent.curPassStage then
			if not self.mParent.lockedStage or self.mParent.lockedStage == 0 then
				self.btnReset:setVisible(true)
				self.btnResetDis:setVisible(false)
				self.imgReset:setVisible(false)
			else
				self.imgReset:setVisible(self.data.stage == self.mParent.lockedStage)
				self.btnReset:setVisible(false)
				self.btnResetDis:setVisible(self.data.stage ~= self.mParent.lockedStage)
			end
		else
			self.btnReset:setVisible(false)
			self.btnResetDis:setVisible(false)
			self.imgReset:setVisible(false)
		end
	end
end

function SneakBattleTeamSetTeamCell:onHeroCellClick(sender)
	if self.data and sender and self.data.canChange then
		local resId = sender.object.id
		local formation = self.data.formation

		if formation and formation.hero then
			local heros = formation.hero

			for index, hero in ipairs(heros) do
				if hero.resid == resId then
					table.remove(heros, index)
				end
			end
		end

		self:setData()
		self.mParent:onRemoveHeroInTeam(resId)
	end
end

function SneakBattleTeamSetTeamCell:onBtnContentClick()
	if self.data and self.data.canChange then
		self.mParent:onTeamCellClick(self)
	end
end

function SneakBattleTeamSetTeamCell:onPetCellClick(sender)
	if self.data then
		self.data.formation.pet_id = 0

		self:setData()

		self.mParent.anyChange = true

		self.mParent:refreshSaveBtn()
		self.mParent:refreshPets()
	end
end

function SneakBattleTeamSetTeamCell:onBtnResetClick()
	local function funY(...)
		if self.mParent.actData then
			local actData = self.mParent.actData

			RPC.newPveResetStage(actData.actObject.opId, actData.nowSelectLevel, self.data.stage)
		end
	end

	UIManager.showConfirmWithId(1125, Slot(funY, self), nil)
end

function SneakBattleTeamSetTeamCell:onBtnResetDisClick()
	if ResNewPveShow[13090017] then
		MsgManager.notice(ResNewPveShow[13090017].desc)
	end
end

local SneakBattleTeamSetDlg = Class("SneakBattleTeamSetDlg", UIControls.Window)

function SneakBattleTeamSetDlg:ctor(...)
	self:initUI()
end

function SneakBattleTeamSetDlg:initUI(...)
	self.PET_LIST_PATH = "MainInfoPanel/HeroListPanel/PetNode"
	self.HERO_LIST_PATH = "MainInfoPanel/HeroListPanel/HeroNode"
	self.filterSelectPanel = FilterSelectPanel(self, self.HERO_LIST_PATH .. "/ListSelectPanel")
	self.listHeros = CommonHeroListPanel(self, self.HERO_LIST_PATH)
	self.panelList = UIControls.Panel(self, "HeroListPanel")
	self.panelHeroList = UIControls.Panel(self, self.HERO_LIST_PATH)
	self.panelBlock = UIControls.Panel(self, self.HERO_LIST_PATH .. "/Panel")
	self.panelPetList = UIControls.Panel(self, self.PET_LIST_PATH)
	self.scrollPetList = UIControls.ScrollViewLoopV(self, self.PET_LIST_PATH .. "/PetList")

	self.scrollPetList:addEventCellChanged(self.onPetListChanged)

	self.skillList = UIControls.Panel(self, "MainInfoPanel/HeroListPanel/PetNode/SkillList")

	self.skillList:setVisible(false)

	self.btnChange = UIControls.Button(self, "MainInfoPanel/HeroListPanel/BtnChange")

	self.btnChange:addEventClick(self.onBtnChangeClick)
	self.btnChange:setVisible(true)

	self.panelNonePet = UIControls.Panel(self, self.PET_LIST_PATH .. "/BgNothing")
	self.limitPanel = UIControls.Panel(self, "MainInfoPanel/HeroListPanel/SneakBattleLimitPanel")
	self.imgLimitIcon = UIControls.Image(self, "MainInfoPanel/HeroListPanel/SneakBattleLimitPanel/ImgIcon")
	self.txtLimitDesc = UIControls.Label(self, "MainInfoPanel/HeroListPanel/SneakBattleLimitPanel/TextDesc")
	self.txtLimitTitle = UIControls.Label(self, "MainInfoPanel/HeroListPanel/SneakBattleLimitPanel/TextTitle")
	self.scrollTeamList = UIControls.ScrollViewLoopV(self, "MainInfoPanel/TeamListPanel/TeamList")

	self.scrollTeamList:addEventCellChanged(self.onTeamListChanged)

	self.teamCells = {}
	self.petCells = {}
	self.btnClear = UIControls.Button(self, "MainInfoPanel/TeamListPanel/BtnClear")

	self.btnClear:addEventClick(self.onBtnClearClick)

	self.btnReset = UIControls.Button(self, "MainInfoPanel/TeamListPanel/BtnReset")

	self.btnReset:addEventClick(self.onBtnResetClick)

	self.btnFastFormation = UIControls.Button(self, "MainInfoPanel/TeamListPanel/BtnFastFormation")

	self.btnFastFormation:addEventClick(self.onBtnFastFormationClick)

	self.btnClose = UIControls.Button(self, "BtnClose")

	self.btnClose:addEventClick(self.onBtnCloseClick)

	self.btnTips = UIControls.Button(self, "BtnTips")

	self.btnTips:addEventClick(self.onBtnTipsClick)

	self.slotOnHeroCellClick = Slot(self.onHeroCellClick, self)
	self.txtProgressNum = UIControls.Label(self, "MainInfoPanel/TeamListPanel/TextTitle/TextNum")
	self.btnSave = UIControls.Button(self, "MainInfoPanel/TeamListPanel/BtnSave")

	self.btnSave:addEventClick(self.onBtnSaveClick)

	self.btnBuff = UIControls.Button(self, "MainInfoPanel/TeamListPanel/BtnBuff")

	self.btnBuff:addEventClick(self.onBtnBuffClick)

	self.buffPanel = UIControls.Image(self, "BuffPanel")
	self.iconBuff = UIControls.Image(self, "BuffPanel/Icon")
	self.txtBuffTitle = UIControls.Label(self, "BuffPanel/TextTitle")
	self.txtBuffDesc = UIControls.Label(self, "BuffPanel/TextDesc")
	self.uIClick = UIControls.Button(self, "UIClick")

	self.uIClick:addEventClick(self.onUIClickClick)
end

function SneakBattleTeamSetDlg:onUIClickClick()
	self.buffPanel:setVisible(false)
	self.uIClick:setVisible(false)
end

function SneakBattleTeamSetDlg:onBtnBuffClick()
	local showState = self.buffPanel:getVisible()

	self.buffPanel:setVisible(not showState)
	self.uIClick:setVisible(not showState)
end

function SneakBattleTeamSetDlg:setData(actData)
	self.actData = actData or self.actData

	if self.actData then
		local buffData = self.actData:getBuffResData()

		if buffData then
			self.iconBuff:setImage(buffData.icon_path, buffData.icon_name)
			self.txtBuffTitle:setText(buffData.name)
			self.txtBuffDesc:setText(buffData.desc)
		end

		self:refreshSaveBtn()

		self.pets = {}

		for _, pet in pairs(CurAvatar.petDic) do
			table.insert(self.pets, pet)
		end

		self.listHeros.isDragTip = false
		self.allheros = self.actData:getCircleBattleHeroList()

		if not self.listHeros.cellClass then
			self.listHeros:initHeroList(HeroGridSneakBattlePFCard, "System/Hero/GridHeroCardSneakBattle", UIConst.HERO_SNEAK_BATTLE_PRE_FORMATION_SORT_MAP, UIConst.CLAN_CLEAR_FILTER_PANEL_MAP, self.allheros)
		else
			self.listHeros:updateHeroBag(self.allheros)
		end

		self.listHeros._slot4CellSelect = self.slotOnHeroCellClick
		self.stageData = utils.deepcopy(self.actData:getNowLevelStageData())

		self.scrollTeamList:setTotalCount(#self.stageData)

		self.lockedStage = self.actData.lockedStage
		self.curPassStage = self.actData.curPassStage

		local level = self.actData.nowSelectLevel
		local stage = self.curPassStage

		if stage and stage ~= 0 then
			local levelName = self.actData:getLevelName(level)
			local stageName = self.actData:getStageName(level, stage)

			self.txtProgressNum:setText(utils.format("%1s-%2s", levelName, stageName))
		else
			self.txtProgressNum:setText(Lang.get(96065))
		end

		if self.lockedStage ~= 0 then
			self:setSelectedStage(self.lockedStage)
		elseif self.stageData and self.curPassStage < #self.stageData then
			self:setSelectedStage(self.curPassStage + 1)
		end
	end
end

function SneakBattleTeamSetDlg:refreshHeros(...)
	self.listHeros:updateHeroBag(self.allheros)
	self.listHeros:refreshSort()
end

function SneakBattleTeamSetDlg:refreshPets(...)
	if #self.pets == 0 then
		self.panelNonePet:setVisible(true)
	else
		self.scrollPetList:setTotalCount(#self.pets)
		self.panelNonePet:setVisible(false)

		if self.nowSelectStage and self.stageData and self.stageData[self.nowSelectStage] then
			local petId = self.stageData[self.nowSelectStage].formation.pet_id

			for _, petCell in pairs(self.petCells) do
				petCell:setSelected(petCell.pet.id == petId)
			end
		else
			for _, petCell in pairs(self.petCells) do
				petCell:setSelected(false)
			end
		end
	end
end

function SneakBattleTeamSetDlg:setSelectedStage(stage)
	self.nowSelectStage = stage or self.nowSelectStage

	if self.nowSelectStage and self.stageData and self.stageData[self.nowSelectStage] then
		local nowStageData = self.stageData[self.nowSelectStage]

		if nowStageData.limit and nowStageData.limit ~= 0 then
			self.limitPanel:setVisible(true)

			local resData = self.actData:getLimitResDataById(nowStageData.limit)

			if resData then
				self.imgLimitIcon:setImage(resData.icon_path, resData.icon_name)
				self.txtLimitTitle:setText(resData.name)
				self.txtLimitDesc:setText(resData.desc)
			end
		else
			self.limitPanel:setVisible(false)
		end

		self:refreshHeros()
		self:refreshPets()

		for index, cell in pairs(self.teamCells) do
			cell:refreshState()
		end
	end
end

function SneakBattleTeamSetDlg:refreshSaveBtn(...)
	if self.nowSelectStage and self.nowSelectStage ~= 0 then
		self.btnSave:setEnable(self.anyChange)
	else
		self.btnSave:setEnable(false)
	end
end

function SneakBattleTeamSetDlg:onRemoveHeroInTeam(resid)
	self.anyChange = true

	self:refreshSaveBtn()

	for index, hero in ipairs(self.allheros) do
		if hero.id == resid then
			hero.sneakStage = 0
		end
	end

	self:refreshHeros()
end

function SneakBattleTeamSetDlg:onHeroCellClick(sender)
	if sender and sender.hero then
		if sender.hero.canUse and sender.hero.canUse == 1 then
			local preStage = -sender.hero.sneakStage

			if preStage ~= 0 then
				if preStage == self.nowSelectStage then
					sender.hero.sneakStage = 0

					sender:refreState()

					local preStageData = self.stageData[preStage]
					local heros = preStageData.formation.hero

					if heros then
						for index, hero in pairs(heros) do
							if hero.resid == sender.hero.id then
								table.remove(heros, index)

								break
							end
						end
					end

					self.anyChange = true

					self:refreshSaveBtn()

					if self.teamCells[preStage] then
						self.teamCells[preStage]:setData(preStageData)
					end
				end

				return
			end

			if self.nowSelectStage and self.stageData and self.stageData[self.nowSelectStage] then
				local nowStageData = self.stageData[self.nowSelectStage]

				if nowStageData.formation.hero == nil then
					nowStageData.formation.hero = {}
				end

				local heros = nowStageData.formation.hero

				if preStage ~= self.nowSelectStage then
					if heros and #heros >= 6 then
						if ResNewPveShow[13090018] then
							MsgManager.notice(ResNewPveShow[13090018].desc)
						end

						return
					end

					table.insert(heros, {
						resid = sender.hero.id
					})

					sender.hero.sneakStage = -self.nowSelectStage

					if self.teamCells[self.nowSelectStage] then
						self.teamCells[self.nowSelectStage]:setData(nowStageData)
					end
				else
					sender.hero.sneakStage = 0
				end
			end

			self.anyChange = true

			self:refreshSaveBtn()
			sender:refreState()
		elseif ResNewPveShow[13090015] then
			MsgManager.notice(ResNewPveShow[13090015].desc)
		end
	end
end

function SneakBattleTeamSetDlg:onPetCellClick(sender)
	if sender and sender.pet and self.nowSelectStage and self.stageData and self.stageData[self.nowSelectStage] then
		local nowStageData = self.stageData[self.nowSelectStage]
		local prePetId = nowStageData.formation.pet_id

		if prePetId == sender.pet.id then
			nowStageData.formation.pet_id = nil
		else
			nowStageData.formation.pet_id = sender.pet.id
		end

		if self.teamCells[self.nowSelectStage] then
			self.teamCells[self.nowSelectStage]:setData(nowStageData)
		end

		self.anyChange = true

		self:refreshSaveBtn()
		self:refreshPets()
	end
end

function SneakBattleTeamSetDlg:onTeamCellClick(sender)
	if sender and sender.data then
		self:setSelectedStage(sender.data.stage)
	end
end

function SneakBattleTeamSetDlg:onPetListChanged(sender, targetCell, newIdx)
	if not targetCell then
		targetCell = UIControls.PetCardLoop(sender, "System/Pet/GridPetCard", newIdx)

		targetCell:setSelectCallback(Slot(self.onPetCellClick, self))
	else
		self.petCells[targetCell.mIndex] = nil
		targetCell.mIndex = newIdx
	end

	self.petCells[newIdx] = targetCell

	local pet = self.pets[newIdx]

	targetCell:setPet(pet)
end

function SneakBattleTeamSetDlg:onTeamListChanged(sender, targetCell, newIdx)
	if not targetCell then
		targetCell = SneakBattleTeamSetTeamCell(sender, "System/SneakBattle/SneakBattleTeamCell", newIdx)
	else
		self.teamCells[targetCell.mIndex] = nil
		targetCell.mIndex = newIdx
	end

	self.teamCells[newIdx] = targetCell

	if self.stageData and self.stageData[newIdx] then
		targetCell:setData(self.stageData[newIdx])
	end
end

function SneakBattleTeamSetDlg:onBtnChangeClick()
	local showState = not self.panelHeroList:getVisible()

	self.panelHeroList:setVisible(showState)
	self.panelPetList:setVisible(not showState)
end

function SneakBattleTeamSetDlg:getRemainderLimit(stageDatas, index)
	local nowIndex = index or 0

	if not stageDatas or #stageDatas == 0 then
		return
	end

	local limits = {}

	for index, stageData in ipairs(stageDatas) do
		if stageData.limit and stageData.limit ~= 0 then
			table.insert(limits, stageData.limit)
		end
	end
end

function SneakBattleTeamSetDlg:onBtnFastFormationClick()
	if self.stageData then
		self.anyChange = true

		self:refreshSaveBtn()

		local needSetStages = {}
		local visHeroMap = {}

		for index, stageData in ipairs(self.stageData) do
			if stageData.canChange then
				local heros = stageData.formation.hero

				if not heros or #heros == 0 then
					table.insert(needSetStages, stageData)
				else
					local checkHeros = {}

					for index, hero in ipairs(heros) do
						table.insert(checkHeros, Hero({
							resid = hero.resid
						}))
					end

					if not stageData.limit or stageData.limit == 0 or utils.checkFormationConditionLimit(stageData.limit, checkHeros) then
						for _, hero in ipairs(stageData.formation.hero) do
							visHeroMap[hero.resid] = true
						end
					else
						for _, hero in ipairs(stageData.formation.hero) do
							if self.allheros then
								for index, shero in ipairs(self.allheros) do
									if shero.id == hero.resid then
										shero.sneakStage = 0
									end
								end
							end
						end

						stageData.formation.hero = nil

						table.insert(needSetStages, stageData)
					end
				end
			elseif stageData.formation and stageData.formation.hero then
				for _, hero in ipairs(stageData.formation.hero) do
					visHeroMap[hero.resid] = true
				end
			end
		end

		if #needSetStages == 0 then
			return
		end

		local ResNewPveAutoFormation = require("ClientData/ResNewPveAutoFormation")
		local careerData = {}

		for career_id, data in pairs(ResNewPveAutoFormation) do
			careerData[data.priority] = {}
			careerData[data.priority].career = career_id
			careerData[data.priority].num = data.need_num
		end

		for index, stageData in ipairs(needSetStages) do
			local canSetHeros = {}

			if self.allheros then
				for index, hero in ipairs(self.allheros) do
					if not visHeroMap[hero.id] then
						table.insert(canSetHeros, hero)
					end
				end
			end

			local limit

			if stageData.limit and ResBattleFormationLimit[stageData.limit] then
				limit = ResBattleFormationLimit[stageData.limit]
			end

			local remainderLimitIds = self:getRemainderLimit(needSetStages, index)
			local remainderLimits = {}

			for index, id in pairs(remainderLimitIds or {}) do
				if ResBattleFormationLimit[id] then
					table.insert(remainderLimits, ResBattleFormationLimit[id])
				end
			end

			local state, formation = ClientUtils.getSneakBattleFormation(canSetHeros, stageData.need_power, stageData.least_hero_num, careerData, limit, remainderLimits)

			if state then
				for index, hero in ipairs(formation) do
					visHeroMap[hero.id] = true

					if not stageData.formation.hero then
						stageData.formation.hero = {}
					end

					local data = {}

					data.resid = hero.id

					table.insert(stageData.formation.hero, data)

					hero.sneakStage = -stageData.stage
				end

				if self.teamCells and self.teamCells[stageData.stage] then
					self.teamCells[stageData.stage]:setData(stageData)
				end
			else
				break
			end
		end

		self:refreshHeros()
	end
end

function SneakBattleTeamSetDlg:saveFormationToServer(...)
	if self.stageData and self.actData then
		local data = {}

		data.formation = {}
		data.level = self.actData.nowSelectLevel

		for index, stageData in ipairs(self.stageData) do
			local sendData = {}

			sendData.stage = index
			sendData.formation = stageData.formation

			table.insert(data.formation, sendData)
		end

		RPC.newPveSaveFormation(self.actData.actObject.opId, data)
	end
end

function SneakBattleTeamSetDlg:onBtnClearClick()
	if self.actData and self.stageData then
		if self.actData.lockedStage and self.actData.lockedStage ~= 0 and self.stageData and self.stageData[self.actData.lockedStage] then
			self.stageData[self.actData.lockedStage].formation.hero = nil
			self.stageData[self.actData.lockedStage].formation.pet_id = 0

			for _, hero in pairs(self.allheros) do
				local stage = -hero.sneakStage

				if stage == self.actData.lockedStage then
					hero.sneakStage = 0
				end
			end

			self.anyChange = true

			self:refreshSaveBtn()
		end

		local nowStage = self.actData.curPassStage

		if nowStage < #self.stageData then
			for i = nowStage + 1, #self.stageData do
				self.stageData[i].formation.hero = nil
				self.stageData[i].formation.pet_id = 0
			end

			self.anyChange = true

			self:refreshSaveBtn()
		end

		for _, hero in pairs(self.allheros) do
			local stage = -hero.sneakStage

			if nowStage < stage then
				hero.sneakStage = 0
			end
		end

		self:refreshPets()
		self:refreshHeros()

		for index, cell in pairs(self.teamCells) do
			cell:setData(self.stageData[index])
		end
	end
end

function SneakBattleTeamSetDlg:onBtnResetClick()
	if self.actData and self.actData.curPassStage and self.actData.curPassStage ~= 0 then
		local function funY(...)
			if self.actData then
				RPC.newPveResetProgress(self.actData.actObject.opId, self.actData.nowSelectLevel)
			end
		end

		UIManager.showConfirmWithId(1122, Slot(funY, self), nil)
	elseif ResNewPveShow[13090019] then
		MsgManager.notice(ResNewPveShow[13090019].desc)
	end
end

function SneakBattleTeamSetDlg:onBtnCloseClick()
	if self.anyChange and self.nowSelectStage and self.nowSelectStage ~= 0 then
		local function funY(...)
			self:saveFormationToServer()
			self:setVisible(false)
		end

		local function funN(...)
			self:setVisible(false)
		end

		UIManager.showConfirmWithId(1121, Slot(funY, self), Slot(funN, self))
	else
		self:setVisible(false)
	end
end

function SneakBattleTeamSetDlg:SetOnRelinkShow(...)
	return
end

function SneakBattleTeamSetDlg:checkOnRelink(...)
	local actObject = CurAvatar:getSneakBattleActivity()

	if not actObject or not actObject:isOpen() then
		self:setVisible(false)
	end
end

function SneakBattleTeamSetDlg:onBtnSaveClick()
	if ResNewPveShow[13090016] then
		MsgManager.notice(ResNewPveShow[13090016].desc)
	end

	self:saveFormationToServer()

	self.anyChange = false

	self:refreshSaveBtn()
end

function SneakBattleTeamSetDlg:onBtnTipsClick()
	UIManager.getUI("infoNotice", true):showSystemInfo(500)
end

function SneakBattleTeamSetDlg:destroy(...)
	SneakBattleTeamSetDlg.super.destroy(self)
end

return SneakBattleTeamSetDlg
