-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\PetMaze\\PetMazeMainDlg.lua

local ResPetMazeNormalStage = require("ClientData/ResPetMazeNormalStage")
local ResPetMazeBossStage = require("ClientData/ResPetMazeBossStage")
local ResPetMazeLayer = require("ClientData/ResPetMazeLayer")
local ResPetMazeQuality = require("ClientData/ResPetMazeQuality")
local ResJumpGuide = require("ClientData/ResJumpGuide")
local BtnHeroAdd = require("UI/PetMaze/BtnHeroAdd")
local CardHeroListPage = require("UI/PetMaze/CardHeroListPage")
local ActivityPanelMixin = require("UI/OpActivity/ActivityPanelMixin")
local Hero = require("Common/Object/Hero")
local NormalAreaNode = Class("PetMazeMainDlg_NormalAreaNode", UIControls.Child)

function NormalAreaNode:ctor()
	self.btnBgPanel = UIControls.Button(self, "BgPanel")

	self.btnBgPanel:addEventClick(self.onClickBtnBgPanel)

	self.txtName = UIControls.Label(self, "BgPanel/TextAreaName")

	if UIControls.checkControlFunc(self, "BgPanel/GridSpecialHero/GridHeroIcon") then
		self.imgHeroIcon = UIControls.Image(self, "BgPanel/GridSpecialHero/GridHeroIcon")
	end

	self.imgSpecialMark = UIControls.Image(self, "BgPanel/GridSpecialHero/ImgSpecial")
	self.battlePanel = UIControls.Panel(self, "BgPanel/StatusBattlePanel")
	self.resultPanel = UIControls.Panel(self, "BgPanel/StatusResultPanel")
	self.needlessPanel = UIControls.Panel(self, "BgPanel/StatusNeedLessPanel")
	self.anim = UIControls.UIAni(self, "")
	self.starBgPanelList = {}
	self.starPanelList = {}

	for i = 1, 5 do
		if UIControls.checkControlFunc(self, "BgPanel/StatusResultPanel/BgStar" .. i) then
			local starBgPanel = UIControls.Panel(self, "BgPanel/StatusResultPanel/BgStar" .. i)

			table.insert(self.starBgPanelList, starBgPanel)

			local starPanel = UIControls.Panel(self, "BgPanel/StatusResultPanel/BgStar" .. i .. "/ImgStar")

			table.insert(self.starPanelList, starPanel)
		end
	end

	self.cleanPanel = UIControls.Panel(self, "BgPanel/StatusCleanPanel")
	self.imgQuality = UIControls.Image(self, "BgPanel/ImgBattleQuality")
	self.imgPoint = UIControls.Image(self, "ImgMapPoint")
	self.imgLine = UIControls.Image(self, "BgPanel/ImgBattleQuality/ImgLine")
	self.imgMonster = UIControls.Image(self, "BgPanel/ImgBattleQuality/ImgMonster")
	self.effPlayer = UIControls.LazyEffectPlayer(self, "ImgMapPoint/Efx")
end

function NormalAreaNode:init(posX)
	self.posX = posX
end

function NormalAreaNode:setData(actData, data, checkNormalAreaAllFinish)
	self.actData = actData
	self.data = data

	local checkClean = actData.checkClean
	local checkFinish = not checkClean and data.is_pass
	local checkBattle = not checkClean and not checkFinish and not checkNormalAreaAllFinish
	local checkNeedless = not checkClean and not checkFinish and checkNormalAreaAllFinish
	local qualityConfig = ResPetMazeQuality[actData.layer][data.quality]

	self.resultPanel:setVisible(checkFinish)
	self.battlePanel:setVisible(checkBattle)
	self.needlessPanel:setVisible(checkNeedless)
	self.btnBgPanel:setEnable(not checkNeedless)
	self.cleanPanel:setVisible(checkClean)

	local qualityIconPath = (checkClean or checkNeedless) and "BgFightDis0" .. data.quality or "BgFightNml0" .. data.quality

	self.imgQuality:setImage("Atlas/MazzPetAtlas/MazzPetAtlas3", qualityIconPath)
	self.imgSpecialMark:setImage(self.actData.supportMarkPath, "TxtIconHired0" .. data.quality)

	if checkFinish then
		local starNum = data.star
		local maxStarNum = qualityConfig.star_award[2]

		for i = 1, #self.starPanelList do
			local checkBg = i <= maxStarNum

			self.starBgPanelList[i]:setVisible(checkBg)

			if checkBg then
				self.starPanelList[i]:setVisible(i <= starNum)
			end
		end
	end

	if self.imgHeroIcon then
		local heroId = data.specialHeroId
		local hero = BaseObject.GetObject(heroId)

		if hero then
			local iconPath = hero:getIconPath(true)

			if iconPath then
				self.imgHeroIcon:setImage(iconPath[1], iconPath[2])
			end
		end
	end

	self.imgPoint:setImage("Atlas/MazzPetAtlas/MazzPetAtlas3", "ImgTarget0" .. data.quality)
	self.imgLine:setImage("Atlas/MazzPetAtlas/MazzPetAtlas3", "ImgArrow0" .. data.quality)

	local stageConfig = ResPetMazeNormalStage[data.id]

	if stageConfig then
		self.txtName:setText(stageConfig.name)

		if stageConfig.icon_path and stageConfig.icon_name then
			self.imgMonster:setImage(stageConfig.icon_path, stageConfig.icon_name)
		end
	end

	if data.quality == 3 then
		self.effPlayer:playEffectByPath("Effects/UI/efx_ui_MazzPetMain_orange.prefab")
	elseif data.quality == 2 then
		self.effPlayer:playEffectByPath("Effects/UI/efx_ui_MazzPetMain_green.prefab")
	end
end

function NormalAreaNode:onClickBtnBgPanel()
	if self.actData.checkClean then
		MsgManager.clientNotice(713)
	else
		local ui = UIManager.getUI("petMazeNmlInfoDlg", true)

		ui:setData(self.actData, self.data.id)
	end
end

function NormalAreaNode:setDragVisible(value, checkOnOpen)
	if value ~= self.checkDragShow then
		self.checkDragShow = value

		if checkOnOpen then
			if value then
				self.anim:startAni("ShowBattleInfoD")
			else
				self.anim:startAni("HideBattleInfoD")
			end
		elseif value then
			self.anim:startAni("ShowBattleInfo")
		else
			self.anim:startAni("HideBattleInfo")
		end
	end
end

local BossAreaNode = Class("PetMazeMainDlg_BossAreaNode", UIControls.Child)

function BossAreaNode:ctor()
	self.btnBgPanel = UIControls.Button(self, "BgPanel")

	self.btnBgPanel:addEventClick(self.onClickBtn)

	self.txtName = UIControls.Label(self, "BgPanel/BattleInfoPanel/TextBossName")
	self.imgRole = UIControls.Role(self, "BgPanel/BossMask/ImgBoss/GridHeroPortrait", 0, 0)
	self.imgFinish = UIControls.Image(self, "BgPanel/BossMask/ImgBoss/ImgFinish")
	self.lockPanel = UIControls.Panel(self, "BgPanel/BattleInfoPanel/BattleLockPanel")
	self.txtLock = UIControls.Label(self, "BgPanel/BattleInfoPanel/BattleLockPanel/TextLock")
	self.readyPanel = UIControls.Panel(self, "BgPanel/BattleInfoPanel/BattleReadyPanel")
	self.scorePanel = UIControls.Panel(self, "BgPanel/BattleInfoPanel/BattleScorePanel")
	self.txtScoreNum = UIControls.Label(self, "BgPanel/BattleInfoPanel/BattleScorePanel/TextScore")
	self.killPanel = UIControls.Panel(self, "BgPanel/BattleInfoPanel/BattleKillPanel")
	self.txtKillScoreNum = UIControls.Label(self, "BgPanel/BattleInfoPanel/BattleKillPanel/TextScore")
	self.lockAreaPanel = UIControls.Panel(self, "BgPanel/UnlockPanel")
	self.redDot = UIControls.RedDot(self, "BgPanel/IconNew")

	self.redDot:addHint({
		UIConst.RD_HINT_PET_MAZE_BOSS
	})

	self.anim = UIControls.UIAni(self, "")
	self.cleanPanel = UIControls.Panel(self, "BgPanel/BattleInfoPanel/BattleCleanPanel")
	self.lockAreaPanelList = {}

	for i = 1, 5 do
		local panel = UIControls.Panel(self, "BgPanel/UnlockPanel/LockPanel" .. i)

		table.insert(self.lockAreaPanelList, panel)
	end
end

function BossAreaNode:init(posX)
	self.posX = posX
end

function BossAreaNode:setData(actData, data, needFinishNormalAreaCount, curFinishNormalAreaCount)
	self.actData = actData
	self.data = data

	local stageConfig = ResPetMazeBossStage[data.id]

	if stageConfig then
		self.txtName:setText(stageConfig.name)
		self.imgRole:showRole(stageConfig.draw_id)
	end

	self.status = self.actData:getBossStatus()

	self.lockPanel:setVisible(self.status == UIConst.PET_MAZE_BOSS_STATE_LOCK)
	self.lockAreaPanel:setVisible(self.status == UIConst.PET_MAZE_BOSS_STATE_LOCK or self.status == UIConst.PET_MAZE_BOSS_STATE_CLEAN)
	self.readyPanel:setVisible(self.status == UIConst.PET_MAZE_BOSS_STATE_READY)
	self.scorePanel:setVisible(self.status == UIConst.PET_MAZE_BOSS_STATE_BATTLEING)
	self.killPanel:setVisible(self.status == UIConst.PET_MAZE_BOSS_STATE_PASS)
	self.cleanPanel:setVisible(self.status == UIConst.PET_MAZE_BOSS_STATE_CLEAN)

	if self.status == UIConst.PET_MAZE_BOSS_STATE_LOCK then
		for i = 1, #self.lockAreaPanelList do
			local panel = self.lockAreaPanelList[i]
			local checkNeed = i <= needFinishNormalAreaCount
			local checkFinish = i <= curFinishNormalAreaCount

			panel:setVisible(checkNeed and not checkFinish)
		end

		self.txtLock:setText(string.format(Lang.get(78800), curFinishNormalAreaCount, needFinishNormalAreaCount))
	end

	local txtScore = self.status == UIConst.PET_MAZE_BOSS_STATE_BATTLEING and self.txtScoreNum or self.status == UIConst.PET_MAZE_BOSS_STATE_KILL and self.txtKillScoreNum

	if txtScore then
		txtScore:setText(data.score)
	end
end

function BossAreaNode:onClickBtn()
	if self.actData.checkClean then
		MsgManager.clientNotice(713)
	else
		local ui = UIManager.getUI("petMazeBossInfoDlg", true)

		ui:setData(self.actData, self.data)
	end
end

function BossAreaNode:setDragVisible(value, checkOnOpen)
	if value ~= self.checkDragShow then
		self.checkDragShow = value

		if checkOnOpen then
			if value then
				self.anim:startAni("ShowBattleInfoD")
			else
				self.anim:startAni("HideBattleInfoD")
			end
		elseif value then
			self.anim:startAni("ShowBattleInfo")
		else
			self.anim:startAni("HideBattleInfo")
		end
	end
end

local PetMazeMainDlg = Class("PetMazeMainDlg", UIControls.Window)

MixinClass(PetMazeMainDlg, ActivityPanelMixin)

function PetMazeMainDlg:ctor()
	self.uiAni = UIControls.UIAni(self, "MainInfoPanel")
	self.btnClose = UIControls.Button(self, "BtnClose")

	self.btnClose:addEventClick(self.onClickBtnClose)

	self.btnAchi = UIControls.Button(self, "MainInfoPanel/BattleInfoPanel/FuncPanel/BtnAchi")

	self.btnAchi:addEventClick(self.onClickBtnAchi)

	self.redDotAchi = UIControls.RedDot(self, "MainInfoPanel/BattleInfoPanel/FuncPanel/BtnAchi/Content/IconNew")

	self.redDotAchi:addHint({
		UIConst.RD_HINT_PET_MAZE_ACHI
	})

	self.btnAward = UIControls.Button(self, "MainInfoPanel/BattleInfoPanel/FuncPanel/BtnAward")

	self.btnAward:addEventClick(self.onClickBtnAward)

	self.btnRank = UIControls.Button(self, "MainInfoPanel/BattleInfoPanel/FuncPanel/BtnRank")

	self.btnRank:addEventClick(self.onClickBtnRank)

	self.btnTip = UIControls.Button(self, "BtnTips")

	self.btnTip:addEventClick(self.onClickBtnTip)

	self.btnStore = UIControls.Button(self, "MainInfoPanel/BattleInfoPanel/BattleAreaList/Content/BtnStore")

	self.btnStore:addEventClick(self.onClickBtnStore)

	self.txtTime = UIControls.Label(self, "MainInfoPanel/BattleInfoPanel/BattleAreaList/Content/BattleInfoPanel/TextTime")
	self.txtLayer = UIControls.Label(self, "MainInfoPanel/BattleInfoPanel/BattleAreaList/Content/BattleInfoPanel/TextTitle/TextDiff")
	self.leftArrowPanel = UIControls.Panel(self, "MainInfoPanel/BattleInfoPanel/ImgLeftTips")
	self.rightArrowPanel = UIControls.Panel(self, "MainInfoPanel/BattleInfoPanel/ImgRightTips")
	self.scrollView = UIControls.ScrollView(self, "MainInfoPanel/BattleInfoPanel/BattleAreaList")

	self.scrollView:addEventValueChanged(Slot(self.onDrag, self))

	local halfViewWidth = self.scrollView:getSize().width * 0.5

	self.leftViewX = -halfViewWidth
	self.rightViewX = halfViewWidth

	local leftLimitPanel = UIControls.Panel(self, "MainInfoPanel/BattleInfoPanel/BattleAreaList/LimitL")

	self.leftLimitPosX = leftLimitPanel:getPosition().x

	local rightLimitPanel = UIControls.Panel(self, "MainInfoPanel/BattleInfoPanel/BattleAreaList/LimitR")

	self.rightLimitPosX = rightLimitPanel:getPosition().x
	self.dragPanel = UIControls.Panel(self, "MainInfoPanel/BattleInfoPanel/BattleAreaList/Content")
	self.halfDragWidth = self.dragPanel:getRectSize().width * 0.5
	self.normalAreaNodeList = {}

	for i = 1, 9 do
		local node = NormalAreaNode(self, "MainInfoPanel/BattleInfoPanel/BattleAreaList/Content/AreaList/AreaCell" .. i, "System/MazzPet/BattleAreaInfoCell")
		local panel = UIControls.Panel(self, "MainInfoPanel/BattleInfoPanel/BattleAreaList/Content/AreaList/AreaCell" .. i)
		local posX = panel:getPosition().x

		node:init(posX)
		table.insert(self.normalAreaNodeList, node)
	end

	self.bossNode = BossAreaNode(self, "MainInfoPanel/BattleInfoPanel/BattleAreaList/Content/AreaList/BossCell", "System/MazzPet/BattleBossInfoCell")

	local bossPanel = UIControls.Panel(self, "MainInfoPanel/BattleInfoPanel/BattleAreaList/Content/AreaList/BossCell")
	local posX = bossPanel:getPosition().x

	self.bossNode:init(posX)
	self.bossNode:setVisible(true)

	self.aniHero = UIControls.UIAni(self, "MainInfoPanel/BattleInfoPanel/BattleTeamPanel")
	self.btnHeroTip = UIControls.Button(self, "MainInfoPanel/BattleInfoPanel/BattleTeamPanel/BtnTips")

	self.btnHeroTip:addEventClick(self.onClickBtnHeroTip)

	self.btnReset = UIControls.Button(self, "MainInfoPanel/BattleInfoPanel/BattleTeamPanel/BtnReset")

	self.btnReset:addEventClick(self.onClickBtnReset)

	self.btnHeroNml = UIControls.Button(self, "MainInfoPanel/BattleInfoPanel/BattleTeamPanel/BtnModeToNml")

	self.btnHeroNml:addEventClick(self.onClickBtnHeroNml)

	self.btnHeroEdit = UIControls.Button(self, "MainInfoPanel/BattleInfoPanel/BattleTeamPanel/BtnModeToEdit")

	self.btnHeroEdit:addEventClick(self.onClickBtnHeroEdit)

	self.normalHeroNodeList = {}

	local slotOnClickHeroNode = Slot(self.onClickHeroNode, self)

	for i = 1, 4 do
		local node = BtnHeroAdd(self, "MainInfoPanel/BattleInfoPanel/BattleTeamPanel/HeroListPanel", "System/MazzPet/BtnBattleAdd")

		node:init(slotOnClickHeroNode)
		node:setVisible(true)
		table.insert(self.normalHeroNodeList, node)
	end

	self.specialHeroNode = BtnHeroAdd(self, "MainInfoPanel/BattleInfoPanel/BattleTeamPanel/GridSpecialHero/BtnHeroAdd", "System/MazzPet/BtnBattleAdd")

	self.specialHeroNode:init(slotOnClickHeroNode)
	self.specialHeroNode:setVisible(true)

	self.imgSpecialHero = UIControls.Image(self, "MainInfoPanel/BattleInfoPanel/BattleTeamPanel/GridSpecialHero/ImgSpecialHero")
	self.cardHeroListPage = CardHeroListPage(self, "MainInfoPanel/HeroListPanel")

	self.cardHeroListPage:setTip(Lang.get(77966), Lang.get(77967))

	self.slotCancelAndCloseEditHeroPanel = Slot(self.cancelAndCloseEditHeroPanel, self)
	self.slotConfirmAndCloseEditHeroPanel = Slot(self.confirmAndCloseEditHeroPanel, self)
	self.slotShowCellAction = Slot(self.showCellAction, self)
	self.slotRefreshHero = Slot(self.refreshHeros, self)
	self.slotSortHeroAction = Slot(self.sortHeroAction, self)
	self.normalAwardGridList = {}
	self.txtLeftAwardTimes = UIControls.Label(self, "MainInfoPanel/BattleInfoPanel/AwardPreviewPanel/BgDes/TextRemain")
	self.btnClean = UIControls.Button(self, "MainInfoPanel/BattleInfoPanel/BtnClean")

	self.btnClean:addEventClick(self.onClickBtnClean)
end

function PetMazeMainDlg:_onShow()
	self:refreshView()
end

function PetMazeMainDlg:onDestroy()
	ClientTimerManager.RemoveSecondTickUI(self.txtTime)
	PetMazeMainDlg.super.onDestroy(self)
end

function PetMazeMainDlg:updateActivityData()
	self:refreshView()
end

function PetMazeMainDlg:refreshView()
	self.actObj = CurAvatar:getActivityObjByType(Const.ACT_TYPE_PET_MAZE)

	if not self.actObj then
		return
	end

	self.actData = self.actObj.actData

	self.actData:setClientSeason()

	self.needFinishNormalAreaCount = self.actData.needFinishNormalAreaCount
	self.specialHeroId = self.actData.specialHeroId
	self.battleHeroNum = self.actData.battleHeroNum
	self.curFinishNormalAreaCount = self.actData:getCurFinishNormalAreaCount()

	self.btnRank:setVisible(Const.PET_MAZE_RANK_OPEN == true and self.actData.checkRankOpen)
	self.txtLayer:setText(string.format("%02d", self.actData.layer))
	ClientTimerManager.RemoveSecondTickUI(self.txtTime)
	ClientTimerManager.AddSecondFormatTickUI(self.txtTime, self.actObj.actData:getSeasonLeftTime(), false, Lang.get(30590), Slot(self.timerOver, self))
	self.cardHeroListPage:init(self.battleHeroNum, true, self.specialHeroId, self.slotCancelAndCloseEditHeroPanel, self.slotConfirmAndCloseEditHeroPanel, self.slotShowCellAction, self.slotRefreshHero, self.slotSortHeroAction)

	self.layerConfig = ResPetMazeLayer[self.actData.layer]

	ClientUtils.CreateBonusGrid(self, self.normalAwardGridList, "MainInfoPanel/BattleInfoPanel/AwardPreviewPanel/AwardList/Content", self.layerConfig.normal_award, false, 3, true)
	self.txtLeftAwardTimes:setText(string.format("%s/%s", self.actData.leftAwardTimes, self.actData.totalAwardTimes))
	self:refreshAreas()
	self:refreshHeros(self.actData.selectHeroList)
	self:refreshBtnReset()
	self:calculateDrag(true)
	self:refreshMysteryShow()
	self:refreshClean()
end

function PetMazeMainDlg:timerOver()
	self.txtTime:setText("")
end

function PetMazeMainDlg:refreshAreas()
	local checkNormalAreaAllFinish = self.curFinishNormalAreaCount >= self.needFinishNormalAreaCount
	local dataNum = #self.actData.normalAreaDataList

	for i = 1, #self.normalAreaNodeList do
		local node = self.normalAreaNodeList[i]
		local checkShow = i <= dataNum

		node:setVisible(checkShow)

		if checkShow then
			node:setData(self.actData, self.actData.normalAreaDataList[i], checkNormalAreaAllFinish)
		end
	end

	self.bossNode:setData(self.actData, self.actData.bossAreaData, self.needFinishNormalAreaCount, self.curFinishNormalAreaCount)
end

function PetMazeMainDlg:focusArea(stageId)
	if not stageId or stageId == 0 then
		return
	end

	for i = 1, #self.normalAreaNodeList do
		local node = self.normalAreaNodeList[i]

		if node.data and node.data.id == stageId then
			self.dragPanel:setPosition(-node.posX)
			self:calculateDrag(true)

			break
		end
	end
end

function PetMazeMainDlg:onDrag()
	self:calculateDrag()
end

function PetMazeMainDlg:calculateDrag(checkOnOpen)
	local x = self.dragPanel:getPosition().x
	local checkShowLeftTip = x - self.halfDragWidth + 0.5 < self.leftViewX

	self.leftArrowPanel:setVisible(checkShowLeftTip)

	local checkShowRightTip = x + self.halfDragWidth - 0.5 > self.rightViewX

	self.rightArrowPanel:setVisible(checkShowRightTip)

	for i = 1, #self.normalAreaNodeList do
		local node = self.normalAreaNodeList[i]
		local posX = node.posX + x
		local checkShow = posX > self.leftLimitPosX and posX < self.rightLimitPosX

		node:setDragVisible(checkShow, checkOnOpen)
	end

	local posX = self.bossNode.posX + x
	local checkShow = posX > self.leftLimitPosX and posX < self.rightLimitPosX

	self.bossNode:setDragVisible(checkShow, checkOnOpen)
end

function PetMazeMainDlg:refreshHeros(selectHeroGidList)
	self.selectHeroGidList = {}

	local normalHeroList = {}
	local specialHero

	if selectHeroGidList then
		for i = 1, #selectHeroGidList do
			local gid = selectHeroGidList[i]
			local hero = CurAvatar.heroDic[gid]

			if hero then
				table.insert(self.selectHeroGidList, gid)

				if hero.id == self.specialHeroId then
					specialHero = hero

					local minStar = self.layerConfig.guarantee_star

					if minStar > specialHero.star then
						local newHero = utils.getDeepCopyHero(specialHero)

						newHero.star = minStar
						specialHero = newHero
					end
				else
					table.insert(normalHeroList, hero)
				end
			end
		end
	end

	self.specialHeroNode:setData(specialHero)
	self.imgSpecialHero:setVisible(specialHero == nil)

	if not specialHero then
		self.fakeSpecialHero = self.fakeSpecialHero or BaseObject.GetObject(self.specialHeroId)

		if self.fakeSpecialHero then
			local iconPath = self.fakeSpecialHero:getIconPath(true)

			if iconPath then
				self.imgSpecialHero:setImage(iconPath[1], iconPath[2])
			end
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
end

function PetMazeMainDlg:onClickHeroNode(hero)
	if self.checkOpenEditHeroPanel then
		if hero then
			self.cardHeroListPage:cancelSelectCell(hero.gid)
		end
	elseif self.actData.checkClean then
		MsgManager.clientNotice(713)
	else
		self:openEditHeroPanel()
	end
end

function PetMazeMainDlg:openEditHeroPanel()
	self.checkOpenEditHeroPanel = true

	self.uiAni:startAni("ShowHeroList")

	local excludeHeroIdDic = self.actData:getBattleExcludeHeroIdDic()

	self.cardHeroListPage:onOpen(self.selectHeroGidList, excludeHeroIdDic)
end

function PetMazeMainDlg:cancelAndCloseEditHeroPanel()
	self.checkOpenEditHeroPanel = false

	self.uiAni:startAni("HideHeroList")
	self:refreshHeros(self.actData.selectHeroList)
end

function PetMazeMainDlg:confirmAndCloseEditHeroPanel(selectHeroGidList)
	local checkSpecialHeroOk = false
	local checkHeroOk = #selectHeroGidList >= self.battleHeroNum

	if selectHeroGidList then
		for i = 1, #selectHeroGidList do
			local gid = selectHeroGidList[i]
			local hero = CurAvatar.heroDic[gid]

			if hero and hero.id == self.specialHeroId then
				checkSpecialHeroOk = true

				break
			end
		end
	end

	if not checkSpecialHeroOk then
		UIManager.showConfirmWithId(1083, nil, Slot(self.jumpToDraw, self), Functor(self.saveAndCloseEditHeroPanel, self, selectHeroGidList))
	elseif not checkHeroOk then
		local content = Lang.get(77968)

		UIManager.showConfirm(UIConst.CONFIRM_TWOBTN, "", content, Functor(self.saveAndCloseEditHeroPanel, self, selectHeroGidList))
	else
		self:saveAndCloseEditHeroPanel(selectHeroGidList)
	end
end

function PetMazeMainDlg:jumpToDraw()
	local jumpId = self.actData.heroJumpIdDic[self.actData.specialHeroId]

	if jumpId then
		local guideInfo = ResJumpGuide[jumpId]

		if guideInfo then
			local checkCondition = guideInfo.condition

			if (not checkCondition or not ConditionLimitManager.inLimitState(checkCondition)) and guideInfo.param_1 then
				JumpGuideManager.jump(jumpId)

				return
			end
		end
	end

	JumpGuideManager.jump(28)
end

function PetMazeMainDlg:saveAndCloseEditHeroPanel(selectHeroGidList)
	self.checkOpenEditHeroPanel = false

	self.uiAni:startAni("HideHeroList")
	RPC.petMazeSaveFormation(self.actObj.opId, self.actData.layer, selectHeroGidList)
end

function PetMazeMainDlg:showCellAction(sender)
	sender:setBattleSpecial(sender.hero.id == self.actData.specialHeroId)

	local quality = self.actData.supportHero_QualityDic[sender.hero.id]

	if quality then
		sender:setDispatchSpecial(true, self.actData.supportMarkPath, "TxtIconHired0" .. quality)
	else
		sender:setDispatchSpecial(false)
	end
end

function PetMazeMainDlg:sortHeroAction(showHeroList)
	if not showHeroList then
		return
	end

	local list = {}

	for i = #showHeroList, 1, -1 do
		local hero = showHeroList[i]

		if hero.id == self.actData.specialHeroId then
			table.remove(showHeroList, i)
			table.insert(list, hero)
		end
	end

	for i = 1, #list do
		table.insert(showHeroList, 1, list[i])
	end
end

function PetMazeMainDlg:setHeroNodeEnable(value)
	for i = 1, #self.normalHeroNodeList do
		local node = self.normalHeroNodeList[i]

		node:setEnable(value)
	end

	self.specialHeroNode:setEnable(value)
end

function PetMazeMainDlg:refreshMysteryShow()
	if self.actData.checkMysteryShopTrigger then
		if self.actData.mysteryData then
			self:refreshBtnStore()
		else
			self.btnStore:setVisible(false)
			RPC.mysteryShopEnter(Const.MYSTERY_SHOP_SUB_TYPE_NEW_MAZE)
		end
	end
end

function PetMazeMainDlg:refreshBtnStore()
	local checkShowBtnStore = self.actData.checkMysteryShopTrigger and not self.actData:checkMysterySoldOut()

	self.btnStore:setVisible(checkShowBtnStore)

	local mysteryStoreDlg = UIManager.tryGetUI("newMazeMysteryStoreDlg")

	if mysteryStoreDlg then
		mysteryStoreDlg:setData(Const.MYSTERY_SHOP_SUB_TYPE_PET_MAZE, self.actData.mysteryData)
	elseif checkShowBtnStore and not self.actData:getMysteryAutoOpen() then
		self.actData:setMysteryAutoOpen()

		mysteryStoreDlg = UIManager.getUI("newMazeMysteryStoreDlg", true)

		mysteryStoreDlg:setData(Const.MYSTERY_SHOP_SUB_TYPE_PET_MAZE, self.actData.mysteryData)
	end
end

function PetMazeMainDlg:refreshBtnReset()
	local checkCanReset = self.curFinishNormalAreaCount > 0

	self.btnReset:setVisible(checkCanReset)
	self:setHeroNodeEnable(not checkCanReset)
end

function PetMazeMainDlg:refreshClean()
	local checkCanClean = Const.PET_MAZE_CLEAN_OPEN and CurAvatar.petMazeData.max_level and CurAvatar.petMazeData.max_level > 0 and not self.actData.checkClean and self.actData.leftAwardTimes == self.actData.totalAwardTimes

	self.btnClean:setVisible(checkCanClean)
end

function PetMazeMainDlg:onClickBtnClean()
	self.slotSendCleanRpc = self.slotSendCleanRpc or Slot(self.sendCleanRpc, self)

	UIManager.showConfirmWithId(1089, self.slotSendCleanRpc, nil)
end

function PetMazeMainDlg:sendCleanRpc()
	local layer = CurAvatar.petMazeData.max_level

	RPC.petMazeSweep(self.actObj.opId, layer)
end

function PetMazeMainDlg:onClickBtnAchi()
	UIManager.getUI("petMazeAchiDlg", true):onShowActivity({
		self.actObj.clientTemplateData,
		self.actObj
	})
end

function PetMazeMainDlg:onClickBtnAward()
	local ui = UIManager.getUI("petMazeResetDlg", true)

	ui:setData(self.actData)
end

function PetMazeMainDlg:onClickBtnRank()
	local rankMainDlg = UIManager.getUI("rankMainDlg", true)

	rankMainDlg:initByRankType(Const.RANK_TYPE_PET_MAZE)
end

function PetMazeMainDlg:onClickBtnTip()
	UIManager.getUI("infoNotice", true):showSystemInfo(372)
end

function PetMazeMainDlg:onClickBtnHeroTip()
	UIManager.getUI("infoNotice", true):showSystemInfo(373)
end

function PetMazeMainDlg:onClickBtnReset()
	local ui = UIManager.getUI("petMazeResetConfirmDlg", true)

	ui:setData(self.actData)
end

function PetMazeMainDlg:onClickBtnHeroNml()
	self.aniHero:startAni("ChangeModeToNml")
end

function PetMazeMainDlg:onClickBtnHeroEdit()
	self.aniHero:startAni("ChangeModeToEdit")
end

function PetMazeMainDlg:onClickBtnStore()
	local mysteryStoreDlg = UIManager.getUI("newMazeMysteryStoreDlg", true)

	mysteryStoreDlg:setData(Const.MYSTERY_SHOP_SUB_TYPE_PET_MAZE, self.actData.mysteryData)
end

function PetMazeMainDlg:onClickBtnClose()
	self:setVisible(false)
end

return PetMazeMainDlg
