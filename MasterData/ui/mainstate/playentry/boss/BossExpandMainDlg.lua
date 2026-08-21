-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\MainState\\PlayEntry\\Boss\\BossExpandMainDlg.lua

local DragTwoPages = require("UI/Control/DragTwoPages")
local UserData = require("Helper/UserData")
local ResColor = require("ClientData/ResColor")
local ResBossTowerExpandLevel = require("ClientData/ResBossTowerExpandLevel")
local ResBossTowerExpandCamp = require("ClientData/ResBossTowerExpandCamp")
local ResBossTowerExpandMisc = require("ClientData/ResBossTowerExpandMisc")
local ResBossTower = require("ClientData/ResBossTower")
local BossLevelCell = Class("BossLevelCelll", UIControls.Child)
local SLIDER_VALUE = 0.246

function BossLevelCell:ctor(...)
	self:initUI()
end

function BossLevelCell:initUI(...)
	self.btnLv = UIControls.Button(self, "BtnLv")

	self.btnLv:addEventClick(self.onBtnLvClick)

	self.btnLvDis = UIControls.Button(self, "BtnLvDis")

	self.btnLvDis:addEventClick(self.onBtnLvDisClick)

	self.txtNum = UIControls.Label(self, "BtnLv/TextNum")
	self.txtNumDis = UIControls.Label(self, "BtnLvDis/TextNum")
	self.imgDiff = UIControls.Image(self, "BtnLv/IconDifficult")
	self.imgClean = UIControls.Image(self, "BtnLv/LabelPanel/Icon")
	self.aniSelf = UIControls.UIAni(self, "")

	self.aniSelf:addEventFinish(self.onAniFinish)
end

function BossLevelCell:setData(layer)
	self.layer = layer

	self.txtNum:setText(layer)
	self.txtNumDis:setText(layer)

	local diffInfo, isMax, canFight = self.mParent:getDiffInfoByLayer(self.layer)

	if diffInfo then
		if isMax and not canFight then
			self.imgDiff:setImage("Atlas/OtherBattleAtlas/ChallengeBossAtlas4", "IconDifficultySmallFinish")
		else
			self.imgDiff:setImage("Atlas/OtherBattleAtlas/ChallengeBossAtlas4", "IconDifficultySmall0" .. diffInfo.diff)
		end
	end

	if canFight or isMax then
		self.btnLvDis:setVisible(false)
		self.btnLv:setVisible(true)
	else
		self.btnLvDis:setVisible(true)
		self.btnLv:setVisible(false)
	end

	local items = ClientUtils.getObjectByRandId(diffInfo.clean_award)

	if #items > 0 then
		local path = items[1]:getIconPath()

		if path then
			self.imgClean:setImage(path[1], path[2])
		end
	end
end

function BossLevelCell:refreshData()
	self:setData(self.layer)
end

function BossLevelCell:showBtnDis(v)
	self.btnLvDis:setVisible(v)
end

function BossLevelCell:playNewLayerAni(v)
	if v then
		self._playingAni = true

		self.aniSelf:startAni("ShowLevelUp")
	elseif self._playingAni then
		self.aniSelf:stopAni("ShowLevelUp")
		self.aniSelf:startAni("ResetLevelUp")
	end
end

function BossLevelCell:setEnable(v)
	self.btnLv:setEnable(v)
	self.btnLvDis:setEnable(v)
end

function BossLevelCell:onAniFinish(...)
	self._playingAni = nil

	self.mWindow:checkAni()
end

function BossLevelCell:onBtnLvDisClick(...)
	self.mParent:onLevelBtnClick(self.layer)
end

function BossLevelCell:onBtnLvClick(...)
	self.mParent:onLevelBtnClick(self.layer)
	self.mWindow:stopAllAni()
end

local BossExpandInfoPage = Class("BossExpandInfoPage", UIControls.Child)

function BossExpandInfoPage:ctor(...)
	self:initUI()
end

function BossExpandInfoPage:initUI(...)
	self.imgBgGroup = UIControls.Image(self, "LvInfoPanel/BgGroup")
	self.imgGroup = UIControls.Image(self, "LvInfoPanel/BgTitle/IconGroup")
	self.imgDiffGroup = UIControls.Image(self, "LvInfoPanel/DifficultPanel/DifficultProgress/Fill/IconDifficult")
	self.imgDescGroup = UIControls.Image(self, "LvInfoPanel/BgInfo/ImgLine")
	self.imgDiffPass = UIControls.Image(self, "LvInfoPanel/DifficultPanel/ImgPass")
	self.rImgBgTittle = UIControls.RawImage(self, "LvInfoPanel/BgTitle")
	self.txtBoss = UIControls.Label(self, "LvInfoPanel/BgTitle/TextBoss")
	self.txtDes = UIControls.Label(self, "LvInfoPanel/DifficultPanel/BgDes/TxtDes")
	self.txtDiffLv = UIControls.Label(self, "LvInfoPanel/DifficultPanel/TextDifficult")
	self.txtDiffDes = UIControls.Label(self, "LvInfoPanel/DifficultPanel/BgDes/TxtDes")
	self.txtCleanDes = UIControls.Label(self, "LvInfoPanel/AwardPanel/CleanAwardPanel/TextTitle")
	self.txtCleanTimes = UIControls.Label(self, "TimePanel/TxtTime")
	self.textDesc = UIControls.Label(self, "LvInfoPanel/BgInfo/TextDes")
	self.textDescGroup = UIControls.Label(self, "LvInfoPanel/BgInfo/TextEngName")
	self.textEngGroup = UIControls.Label(self, "LvInfoPanel/BgInfo/TextEng")
	self.txtDiffDesc = UIControls.Label(self, "LvInfoPanel/DifficultPanel/TextLv")
	self.sliderDiff = UIControls.Slider(self, "LvInfoPanel/DifficultPanel/DifficultProgress")
	self.btnBlock = UIControls.Button(self, "LvInfoPanel/BgInfo/Block")

	self.btnBlock:addEventClick(self.onBtnBlockClick)

	self.btnDes = UIControls.Button(self, "LvInfoPanel/BgTitle/BtnDes")

	self.btnDes:addEventClick(self.onBtnDesClick)

	self.btnDiffDes = UIControls.Button(self, "LvInfoPanel/DifficultPanel/BtnDes")

	self.btnDiffDes:addEventClick(self.onBtnDiffDesClick)

	self.btnClean = UIControls.Button(self, "LvInfoPanel/AwardPanel/CleanAwardPanel/BtnClean")

	self.btnClean:addEventClick(self.onBtnCleanClick)

	self.btnFight = UIControls.Button(self, "LvInfoPanel/AwardPanel/FirstAwardPanel/BtnPanel/BtnBattle")

	self.btnFight:addEventClick(self.onBtnFightClick)

	self.btnMore = UIControls.Button(self, "LvInfoPanel/AwardPanel/FirstAwardPanel/BtnMore")

	self.btnMore:addEventClick(self.onBtnMoreClick)

	self.btnCleanMore = UIControls.Button(self, "LvInfoPanel/AwardPanel/CleanAwardPanel/BtnMore")

	self.btnCleanMore:addEventClick(self.onBtnMoreClick)

	self.btnCleanDis = UIControls.Button(self, "LvInfoPanel/AwardPanel/CleanAwardPanel/BtnCleanDis", "Text")

	self.btnCleanDis:addEventClick(self.onBtnCleanDisClick)

	self.btnFightDis = UIControls.Button(self, "LvInfoPanel/AwardPanel/FirstAwardPanel/BtnPanel/BtnBattleDis")

	self.btnFightDis:addEventClick(self.onBtnFightDisClick)

	self.btnReplay = UIControls.Button(self, "LvInfoPanel/FuncPanel/BtnReplay")

	self.btnReplay:addEventClick(self.onBtnReplayClick)

	self.btnRank = UIControls.Button(self, "LvInfoPanel/FuncPanel/BtnRank")

	self.btnRank:addEventClick(self.onBtnRankClick)

	self.btnShowRoom = UIControls.Button(self, "LvInfoPanel/FuncPanel/BtnShowRoom")

	self.btnShowRoom:addEventClick(self.onBtnShowRoomClick)

	self.btnAutoFight = UIControls.Button(self, "LvInfoPanel/AwardPanel/FirstAwardPanel/BtnPanel/BtnAutoChallenge")

	self.btnAutoFight:addEventClick(self.onBtnAutoFightClick)

	self.imgRoleBoss = UIControls.Role(self, "LvInfoPanel/GridHeroPortrait")
	self.panelBgDes = UIControls.Panel(self, "LvInfoPanel/BgDes")
	self.panelDiffBgDes = UIControls.Label(self, "LvInfoPanel/DifficultPanel/BgDes")
	self.panelFirstAward = UIControls.Panel(self, "LvInfoPanel/AwardPanel/FirstAwardPanel")
	self.panelFormation = UIControls.Panel(self, "LvInfoPanel/BgInfo")
	self.aniWindow = UIControls.UIAni(self, "")

	self.aniWindow:addEventFinish(self.onAniWindowEnd)

	self.aniLvInfo = UIControls.UIAni(self, "LvInfoPanel")

	self.aniLvInfo:addEventFinish(self.onDiffAniFinish)

	self.efxClean = UIControls.LazyEffectPlayer(self, "LvInfoPanel/AwardPanel/CleanAwardPanel/Efx")
	self.efxFirstAward = UIControls.LazyEffectPlayer(self, "LvInfoPanel/AwardPanel/FirstAwardPanel/Efx")
	self.efxBoss = UIControls.LazyEffectPlayer(self, "LvInfoPanel/BgTitle/Efx")
	self.efxDiffUp = UIControls.LazyEffectPlayer(self, "LvInfoPanel/DifficultPanel/DifficultProgress/Fill/IconDifficult/EfxUpdate")
	self.scrollView = UIControls.ScrollView(self, "LvChooseList")
	self.groupTabs = {}

	for i = 1, 3 do
		local tab = UIControls.Button(self, "GroupChoosePanel/BtnGroup" .. i)

		tab.type = i

		tab:addEventClick(self.onCampTabClick)

		self.groupTabs[i] = tab
	end

	self.layerCells = {}
	self.curCampTab = nil
	self.curLayer = nil

	self.btnRank:setVisible(true)

	self.boss2ExtraSweepPanel = UIControls.Panel(self, "TimePanel/UpPanel")

	local extraSweepNum = CurAvatar:getActPrivilege(Const.ACT_PRIVILEGE_TYPE_NEW_BOSS_SWEEP, 0)

	self.boss2ExtraSweepPanel:setVisible(extraSweepNum > 0)

	self.boss2ExtraSweepLabel = UIControls.Label(self, "TimePanel/TxtTime")

	self.boss2ExtraSweepLabel:setText(extraSweepNum)
end

function BossExpandInfoPage:setData(bossType)
	self.noAni = true

	local bossData = ResBossTower[bossType]

	self.txtBoss:setText(bossData[1].name)
	self:refreshCleanTimes()

	self.bossData = CurAvatar.bossExpandData.boss_data[bossType]
	self._bossType = bossType

	local camp = self.mWindow:getCurCamp()

	self:onCampTabClick(self.groupTabs[camp])
	self.panelFormation:setVisible(false)
end

function BossExpandInfoPage:initAward(...)
	local cleanAwardId

	self.cleanDiff = nil

	if self.diffInfo.diff == 1 then
		self.cleanDiff = nil

		self.txtCleanDes:setText(Lang.get(50543))

		cleanAwardId = self.diffInfo.clean_award
	elseif self.canFight then
		self.txtCleanDes:setText(Lang.get(50282))

		self.cleanDiff = self.diffInfo.diff - 1

		local diffInfo = self:getDiffInfoByDiff(self.diffInfo.diff - 1)

		cleanAwardId = diffInfo.clean_award
	else
		self.cleanDiff = self.diffInfo.diff

		self.txtCleanDes:setText(Lang.get(86))

		cleanAwardId = self.diffInfo.clean_award
	end

	if not self.cleanAwards then
		self.cleanAwards = {}
		self.battleAwards = {}

		ClientUtils.CreateBonusGrid(self, self.cleanAwards, "LvInfoPanel/AwardPanel/CleanAwardPanel/GridPanel", cleanAwardId, true, nil, true)
		ClientUtils.CreateBonusGrid(self, self.battleAwards, "LvInfoPanel/AwardPanel/FirstAwardPanel/GridPanel", self.diffInfo.first_award, true, nil, true)

		while #self.battleAwards > 2 do
			local cell = self.battleAwards[#self.battleAwards]

			table.remove(self.battleAwards, #self.battleAwards)
			cell:destroy()
		end

		if self.diffInfo.diff ~= 1 then
			local item = BaseObject.GetObject(ResBossTowerExpandMisc[1].show_id)
			local grid = UIControls.getGridContainer(self, "LvInfoPanel/AwardPanel/FirstAwardPanel/GridPanel")

			grid:setVisible(true)
			grid:setObj(item)
			table.insert(self.battleAwards, grid)
		end
	else
		local cleanItems = ClientUtils.getObjectByRandId(cleanAwardId)

		for i, item in ipairs(cleanItems) do
			local grid = self.cleanAwards[i]

			if not grid then
				grid = UIControls.getGridAwardContainer(self, "LvInfoPanel/AwardPanel/CleanAwardPanel/GridPanel")

				table.insert(self.cleanAwards, grid)
			end

			grid:setObj(item)
			grid:setVisible(true)
		end

		local battleItems = ClientUtils.getObjectByRandId(self.diffInfo.first_award)

		while #battleItems > 2 do
			table.remove(battleItems, #battleItems)
		end

		if self.diffInfo.diff ~= 1 then
			table.insert(battleItems, BaseObject.GetObject(ResBossTowerExpandMisc[1].show_id))
		end

		for i, item in ipairs(battleItems) do
			local grid = self.battleAwards[i]

			if not grid then
				grid = UIControls.getGridAwardContainer(self, "LvInfoPanel/AwardPanel/FirstAwardPanel/GridPanel")

				table.insert(self.battleAwards, grid)
			end

			grid:setVisible(true)
			grid:setObj(item)
		end

		for i = #cleanItems + 1, #self.cleanAwards do
			self.cleanAwards[i]:setVisible(false)
		end

		for i = #battleItems + 1, #self.battleAwards do
			self.battleAwards[i]:setVisible(false)
		end
	end
end

function BossExpandInfoPage:playHigherDiffAni(v)
	if v then
		if not self.isMaxDiff then
			self:_refreshLevelUI(true)
			self.sliderDiff:setValue((self.diffInfo.diff - 1) * SLIDER_VALUE, 0.7)

			if self.coDiff then
				coroutine.stop(self.coDiff)

				self.coDiff = nil
			end

			self.coDiff = coroutine.start(function(...)
				coroutine.wait(0.7)
				self:onDiffAniFinish()
			end)
		end
	elseif self.coDiff then
		coroutine.stop(self.coDiff)

		self.coDiff = nil
	end
end

function BossExpandInfoPage:playNewLayerAni(v)
	local layer = self:getsuitableLayer()

	if layer then
		local cell = self.layerCells[layer]

		if cell then
			cell:playNewLayerAni(v)
		end
	end
end

function BossExpandInfoPage:showNewLayerDis(...)
	local layer = self:getsuitableLayer()

	if layer then
		self.layerCells[layer]:showBtnDis(true)
	end
end

function BossExpandInfoPage:refreshUI(...)
	return
end

function BossExpandInfoPage:refreshCleanTimes(...)
	local total, left = self.mWindow:getCleanTimes()

	self.txtCleanTimes:setText(string.format("%s/%s", left, total))
end

function BossExpandInfoPage:_refreshCampUI(...)
	local camp = self.mWindow:getCurCamp()

	self.rImgBgTittle:setImage("NoAlpha/ChallengeBoss/BgBossMain" .. camp)

	local towerId = 1

	for i, info in ipairs(ResBossTowerExpandCamp) do
		if info.boss_id == self._bossType and info.camp == camp then
			towerId = i

			break
		end
	end

	local campConfig = ResBossTowerExpandCamp[towerId]

	self.imgRoleBoss:showRole(campConfig.role_id)

	local levelData = ResBossTowerExpandLevel[towerId]

	self.layerDataConfig = levelData
	self.maxLayerNum = CurAvatar:getBossExpandMaxLayerNum(towerId)

	for i, cell in ipairs(self.layerCells) do
		cell:destroy()
	end

	self.towerData = self.bossData.type_data[camp]
	self.layerCells = {}

	for i = 1, self.maxLayerNum do
		local cell = BossLevelCell(self, "LvChooseList/Content", "System/ChallengeBoss/NewChallengeBossLvCell0" .. camp, 0, 0, true)

		self.layerCells[i] = cell

		cell:setData(i)
	end

	local layer = self.mWindow:getJumpLayer()

	layer = layer or self:getsuitableLayer()

	self.scrollView:gotoIndexVertical(layer + 2, 98)
	self:chooseLayer(layer)
	self.panelFormation:setVisible(false)
	self.efxBoss:playEffectByPath("Effects/UI/efx_ui_NewChallengeBossLvInfoPanel_01_0" .. camp .. ".prefab")
end

function BossExpandInfoPage:_refreshLevelUI(isPre)
	local diffInfo, isMax, result = self:getDiffInfoByLayer(self.curLayer)

	self.diffInfo = diffInfo
	self.curLayerData = self.towerData.layer_data[self.curLayer]

	local diff = self.diffInfo.diff

	if isPre then
		diff = math.max(1, diff - 1)
	end

	local diffConfig = UIConst.BOSS_EXPAND_DIFF_CONFIG[diff]

	self.sliderDiff:setValue((diff - 1) * SLIDER_VALUE)
	self.txtDiffLv:setText(diffConfig.des)

	if not isPre and self.curLayerData.pass_level > 0 and not result then
		self.isMaxDiff = true

		self.txtDiffDesc:setText(Lang.get(50616))
		self.txtDiffLv:setText(Lang.get(50617))
		self.txtDiffDes:setText(Lang.get(50545))
		self.panelFirstAward:setVisible(false)
		self.txtDiffLv:setFontColor(ResColor.COLORRANK10)
		self.imgDiffGroup:setImage("Atlas/OtherBattleAtlas/ChallengeBossAtlas4", "IconDifficultySmallFinish")
		self.imgDiffPass:setVisible(true)
		self.sliderDiff:setVisible(false)
	else
		self.isMaxDiff = false

		self.imgDiffPass:setVisible(false)
		self.sliderDiff:setVisible(true)
		self.txtDiffDesc:setText(Lang.get(49617))
		self.txtDiffLv:setFontColor(ResColor[diffConfig.color])
		self.imgDiffGroup:setImage("Atlas/OtherBattleAtlas/ChallengeBossAtlas4", "IconDifficultySmall0" .. diff)

		if isMax then
			self.txtDiffDes:setText(Lang.get(50618))
		else
			self.txtDiffDes:setText(Lang.get(48122))
		end

		self.panelFirstAward:setVisible(true)
	end

	if result and diff > 1 then
		self.btnAutoFight:setVisible(true)
	else
		self.btnAutoFight:setVisible(false)
	end

	self.canFight = result

	self:initAward()

	local total, left = self.mWindow:getCleanTimes()

	if self.cleanDiff then
		if left > 0 then
			self.btnClean:setVisible(true)
			self.btnCleanDis:setVisible(false)
		else
			self.btnClean:setVisible(false)
			self.btnCleanDis:setVisible(true)
			self.btnCleanDis:setText(Lang.get(82))
		end
	else
		self.btnClean:setVisible(false)
		self.btnCleanDis:setVisible(true)
		self.btnCleanDis:setText(Lang.get(85))
	end

	if self.canFight then
		self.btnFight:setVisible(true)
		self.btnFightDis:setVisible(false)
	else
		self.btnFight:setVisible(false)
		self.btnFightDis:setVisible(true)
	end

	self.efxClean:playEffect()
	self.efxFirstAward:playEffect()
end

function BossExpandInfoPage:isNewLayerOpen(layer)
	if self.needNewLayerAni then
		local info = self.towerData.layer_data[layer]
		local maxLayer = self:getsuitableLayer()

		return layer ~= 1 and info.pass_level == 0 and layer == maxLayer
	end
end

function BossExpandInfoPage:getCurShowLayer(...)
	return self.curLayer
end

function BossExpandInfoPage:getsuitableLayer(...)
	local layer = 1
	local camp = self.mWindow:getCurCamp()
	local count = #self.towerData.layer_data

	for i = count, 1, -1 do
		local info = self.towerData.layer_data[i]

		if info.pass_level > 0 then
			layer = math.min(self.maxLayerNum, i + 1)

			break
		end
	end

	return layer
end

function BossExpandInfoPage:getDiffInfoByLayer(layer)
	local data = self.towerData.layer_data[layer]

	if data then
		local curConfigData = self.layerDataConfig[layer]

		if data.pass_level < #curConfigData then
			local canFight = false
			local preConfigData = self.layerDataConfig[layer - 1]
			local preServerData = self.towerData.layer_data[layer - 1]

			if data.pass_level == 0 then
				if not preConfigData or not preServerData then
					canFight = true
				else
					local preServerLayerData = self.towerData.layer_data[layer - 1]

					for i, info in ipairs(preConfigData) do
						if i > preServerData.pass_level then
							break
						elseif info.unlock_ids then
							for j, id in ipairs(info.unlock_ids) do
								if id == curConfigData[1].level_id then
									canFight = true

									break
								end
							end
						end
					end
				end
			else
				canFight = true
			end

			return curConfigData[data.pass_level + 1], #curConfigData == data.pass_level + 1, canFight
		else
			return curConfigData[data.pass_level], #curConfigData == data.pass_level, false
		end
	end
end

function BossExpandInfoPage:getDiffInfoByDiff(diff)
	return self.layerDataConfig[self.curLayer][diff]
end

function BossExpandInfoPage:getTowerId(...)
	local camp = self.mWindow:getCurCamp()

	for i, info in ipairs(ResBossTowerExpandCamp) do
		if info.camp == camp and info.boss_id == self._bossType then
			return i
		end
	end
end

function BossExpandInfoPage:initFormationData(...)
	local camp = self.mWindow:getCurCamp()

	if camp then
		local fontColor = ResColor["GROUP0" .. camp]

		self.textDescGroup:setText(Const.CAMP_CONFIG[camp].en_name)

		local towerId = self:getTowerId()
		local data = ResBossTowerExpandCamp[towerId]

		self.textDesc:setText(data.formation_des or "")
		self.textDescGroup:setFontColor(fontColor)
		self.textEngGroup:setFontColor(fontColor)
		self.imgDescGroup:setObjColor(fontColor)
	end
end

function BossExpandInfoPage:chooseCamp(camp)
	self:onCampTabClick(self.groupTabs[camp])
end

function BossExpandInfoPage:chooseLayer(layer)
	for i, cell in ipairs(self.layerCells) do
		if cell.layer == layer then
			cell:onBtnLvClick()

			break
		end
	end
end

function BossExpandInfoPage:onDiffAniFinish(...)
	self.efxDiffUp:playEffect()
	self:_refreshLevelUI()

	self._playingAni = nil

	self.mWindow:checkAni()
end

function BossExpandInfoPage:onAniWindowEnd(...)
	if self.nextAni then
		self:_refreshCampUI()

		self.nextAni = nil

		self.aniWindow:startAni("ShowNewChallengeBossInfo")
	end
end

function BossExpandInfoPage:onBtnBlockClick(...)
	self.panelFormation:setVisible(false)
end

function BossExpandInfoPage:onCampTabClick(sender)
	if self.curCampTab then
		self.curCampTab:setEnable(true)
	end

	self.curCampTab = sender

	self.curCampTab:setEnable(false)

	local camp = sender.type

	self.mWindow:onChooseCamp(camp)

	if self.noAni then
		self:_refreshCampUI()

		self.noAni = nil
	else
		self.nextAni = true

		self.aniWindow:startAni("HideNewChallengeBossInfo")
	end

	self.mWindow:stopAllAni()
end

function BossExpandInfoPage:onLevelBtnClick(layer)
	if self.curLayer and self.layerCells[self.curLayer] then
		self.layerCells[self.curLayer]:setEnable(true)
	end

	self.curLayer = layer

	self.layerCells[layer]:setEnable(false)
	self:_refreshLevelUI()
end

function BossExpandInfoPage:onBtnShowRoomClick(...)
	local heroShowRoomMainDlg = UIManager.getUI("heroShowRoomMainDlg", true)
end

function BossExpandInfoPage:onBtnRankClick(...)
	local rankMainDlg = UIManager.getUI("rankMainDlg", true)
	local towerId = self:getTowerId()

	rankMainDlg:initByRankType(Const["RANK_TYPE_BOSS_EXPAND_" .. towerId])
end

function BossExpandInfoPage:onBtnReplayClick(...)
	local tower = self:getTowerId()
	local layer = self.curLayer
	local level = self.diffInfo.diff

	RPC.campTowerReplayRecord(tower, layer, level)
end

function BossExpandInfoPage:onBtnFightDisClick(...)
	MsgManager.clientNotice(632)
end

function BossExpandInfoPage:onBtnCleanDisClick(...)
	if not self.cleanDiff then
		MsgManager.clientNotice(631)
	else
		MsgManager.clientNotice(630)
	end
end

function BossExpandInfoPage:onBtnMoreClick(...)
	local towerId = self:getTowerId()

	UIManager.getUI("bossAwardInfoDlg", true):show(towerId, self.curLayer, self.towerData)
end

function BossExpandInfoPage:onBtnAutoFightClick(...)
	local towerId = self:getTowerId()
	local layer = self.curLayer

	UIManager.getUI("battleAutoChallengeDlg", true):setData(BattleConst.BATTLE_TYPE_BOSSTOWER_EXPAND, {
		towerId = towerId,
		layer = layer
	})
end

function BossExpandInfoPage:onBtnFightClick(...)
	local levelInfo = self.layerDataConfig[self.curLayer]
	local camp = self.mWindow:getCurCamp()
	local diffInfo, isMax, result = self:getDiffInfoByLayer(self.curLayer)
	local battleData = {}

	battleData.bossTowerExpandData = {}
	battleData.bossTowerExpandData.type = self._bossType
	battleData.bossTowerExpandData.camp = camp
	battleData.bossTowerExpandData.towerId = self:getTowerId()
	battleData.bossTowerExpandData.layer = self.curLayer
	battleData.bossTowerExpandData.level = self.diffInfo.diff
	battleData.bossTowerExpandData.pveId = self.diffInfo.pve_id

	CurAvatar:enterFormation(diffInfo.pve_id, BattleConst.BATTLE_TYPE_BOSSTOWER_EXPAND, battleData)
end

function BossExpandInfoPage:onBtnCleanClick(...)
	local diffInfo = self:getDiffInfoByDiff(self.cleanDiff)
	local total, left = self.mWindow:getCleanTimes()

	utils.openSweepDlg(Const.GAME_PLAY_NOTICE_BOSS_EXPAND, Slot(self._clean, self), Const.MONEY_ID_POWER, diffInfo.power_cost, left, total)
end

function BossExpandInfoPage:_clean(times)
	local data = {}

	data.tower = self:getTowerId()
	data.layer = self.curLayer
	data.level = self.cleanDiff
	data.times = times

	RPC.campTowerSweep({
		data
	})
end

function BossExpandInfoPage:onBtnDiffDesClick(...)
	local towerId = self:getTowerId()

	UIManager.getUI("bossAwardInfoDlg", true):show(towerId, self.curLayer, self.towerData)
end

function BossExpandInfoPage:onBtnDesClick(...)
	self.panelFormation:setVisible(true)
	self:initFormationData()
end

function BossExpandInfoPage:checkDestroy(...)
	if self.coDiff then
		coroutine.stop(self.coDiff)

		self.coDiff = nil
	end
end

function BossExpandInfoPage:refreshBtnData()
	for i, cell in ipairs(self.layerCells) do
		cell:refreshData()
	end
end

local strClassName = "BossExpandMainDlg"
local BossExpandMainDlg = Class(strClassName, UIControls.Window)

function BossExpandMainDlg:ctor(...)
	self:initUI()
end

function BossExpandMainDlg:initUI(...)
	self.btnClose = UIControls.Button(self, "BtnClose", "Text")

	self.btnClose:addEventClick(self.onBtnCloseClick)

	self.btnTips = UIControls.Button(self, "BtnTips")

	self.btnTips:addEventClick(self.onBtnTipsClick)

	self.dragPages = DragTwoPages(self, "MainInfoPanel/Mask/ContentPanel1", "MainInfoPanel/Mask/ContentPanel2", "MainInfoPanel/BtnPre", "MainInfoPanel/BtnNext")
	self.dragPages.dragEvent = Slot(self.onDragEvent, self)
	self.pages = {}

	local pagePrefabPath = "System/ChallengeBoss/NewChallengeBossLvInfoPanel"

	for i = 1, 2 do
		self.pages[i] = BossExpandInfoPage(self, "MainInfoPanel/Mask/ContentPanel" .. i, pagePrefabPath, 0, 0, true)
	end

	self.curBossType = nil
	self.curPage = nil
	self.imgPriVilege = UIControls.Image(self, "ImgPrivilege")
end

function BossExpandMainDlg:show(bossType, bossTypes, camp, layer)
	self.curBossType = bossType
	self._bTypes = bossTypes
	self._jumpCamp = camp
	self._jumpLayer = layer

	self:initPreCampChoose()
	self.dragPages:initPage(#bossTypes, bossType)
	self:checkAni()
	self.imgPriVilege:setVisible(CurAvatar:checkPrivielgeMonthCardEffect())
end

function BossExpandMainDlg:checkAni(...)
	if CurAvatar.bossExpandLevelTip then
		UIManager.getUI("bossShowNewDiffDlg", true):show()
	elseif self.needPlayDiffAni then
		self:playNewDiffAni(true)
	elseif self.needPlayLayerAni then
		self:playNewLayerAni(true)
	end
end

function BossExpandMainDlg:hideLayerBtnForAni(...)
	if self.curPage then
		self.curPage:showNewLayerDis()
	end
end

function BossExpandMainDlg:stopAllAni(...)
	self.needPlayLayerAni = nil
	self.needPlayDiffAni = nil

	if self.curPage then
		self:playNewLayerAni(false)
		self:playNewDiffAni(false)
	end
end

function BossExpandMainDlg:playShowAni(isNewLayer, isNewDiff)
	self.needPlayLayerAni = isNewLayer
	self.needPlayDiffAni = isNewDiff

	self:checkAni()
end

function BossExpandMainDlg:playNewLayerAni(v)
	self.needPlayLayerAni = nil

	if self.curPage then
		self.curPage:playNewLayerAni(v)
	end
end

function BossExpandMainDlg:playNewDiffAni(v)
	self.needPlayDiffAni = nil

	if self.curPage then
		self.curPage:playHigherDiffAni(v)
	end
end

function BossExpandMainDlg:refreshUI(...)
	if self.curPage then
		self.curPage:refreshCleanTimes()
	end
end

function BossExpandMainDlg:refreshLevelUI()
	if self.curPage then
		self.curPage:_refreshLevelUI()
		self.curPage:refreshBtnData()
	end
end

function BossExpandMainDlg:getCleanTimes(...)
	local total = CurAvatar:getBossExpandSweepMaxNum()
	local cleanedTimes = CurAvatar.bossExpandData.boss_data[self.curBossType].sweep_cnt or 0
	local leftTimes = math.max(total - cleanedTimes, 0)

	return total, leftTimes
end

function BossExpandMainDlg:onChooseCamp(camp)
	self.curCamp[self.curBossType] = camp
end

function BossExpandMainDlg:getCurCamp(...)
	if self._jumpCamp then
		local camp = self._jumpCamp

		self._jumpCamp = nil

		return camp
	end

	return self.curCamp[self.curBossType]
end

function BossExpandMainDlg:getJumpLayer(...)
	if self._jumpLayer then
		local layer = self._jumpLayer

		self._jumpLayer = nil

		return layer
	end
end

function BossExpandMainDlg:initPreCampChoose(...)
	self.curCamp = {
		1,
		1,
		1
	}

	local saveInfo = UserData.loadCommonData(CurAvatar.uid .. "keyBossExpandCamp")

	if saveInfo == nil then
		return
	end

	saveInfo = utils.unserialize(saveInfo)

	if saveInfo and #saveInfo > 0 then
		self.curCamp = saveInfo
	end
end

function BossExpandMainDlg:jumpToTowerAndLayer(tower, layer)
	local info = ResBossTowerExpandCamp[tower]
	local bossTypes = {
		1,
		2,
		3
	}

	self:show(info.boss_id, bossTypes, info.camp, layer)
end

function BossExpandMainDlg:chooseCampAndLayer(camp, layer)
	if self.curPage then
		if layer then
			self._jumpLayer = layer
		end

		if camp then
			self.curPage:chooseCamp(camp)
		end
	end
end

function BossExpandMainDlg:onPenaltyZoneReplayRecordResp(tower, layer, level, data)
	local info = self:getPreReplayInfo()

	CurAvatar.cachedBossExpandRecord = {}
	CurAvatar.cachedBossExpandRecord.levelId = ResBossTowerExpandLevel[tower][layer][level].level_id

	local extra = {
		battleType = BattleConst.BATTLE_TYPE_BOSSTOWER_EXPAND,
		checkCanEnter = self.curPage.canFight,
		onBattleClick = Slot(self.curPage.onBtnFightClick, self.curPage),
		towerId = self.curPage:getTowerId()
	}

	UIManager.getUI("onceTowerRecordDlg", true):setData(Const.BATTLE_REPLAY_BOSS_EXPAND, data, info, extra)
end

function BossExpandMainDlg:getPreReplayInfo(...)
	local info = {}

	info.bossType = self.curBossType
	info.camp = self:getCurCamp()
	info.layer = self.curPage:getCurShowLayer()

	return info
end

function BossExpandMainDlg:onDragEvent(sender, currentPageIndex, panelIndex)
	local bossType = self._bTypes[currentPageIndex]

	self.curBossType = bossType

	local page = self.pages[panelIndex]

	page:setData(bossType)

	self.curPage = page

	self:refreshUI()
end

function BossExpandMainDlg:onBtnCloseClick(sender)
	self:setVisible(false)
end

function BossExpandMainDlg:onBtnTipsClick(sender)
	UIManager.getUI("infoNotice", true):showSystemInfo(218)
end

function BossExpandMainDlg:destroy(...)
	BossExpandMainDlg.super.destroy(self)

	if self.curPage then
		self.curPage:checkDestroy()
	end

	UserData.saveCommonData(CurAvatar.uid .. "keyBossExpandCamp", utils.serialize(self.curCamp))

	if self.coAni then
		coroutine.stop(self.coAni)

		self.coAni = nil
	end

	CurAvatar.bossExpandLevelTip = nil
end

return BossExpandMainDlg
