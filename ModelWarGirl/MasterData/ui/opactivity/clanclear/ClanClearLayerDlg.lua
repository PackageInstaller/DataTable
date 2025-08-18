-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\OpActivity\\ClanClear\\ClanClearLayerDlg.lua

local ActivityPanelMixin = require("UI/OpActivity/ActivityPanelMixin")
local CommonHeroListPanel = require("UI/Battle/CommonHeroListPanel")
local FilterSelectPanel = require("UI/MainState/FilterSelectPanel")
local GridHeroStarUp = require("UI/Hero/StarUp/GridHeroStarUp")
local ClanClearPlayerCell = Class("ClanClearPlayerCell", UIControls.ScrollViewLoopCell)

function ClanClearPlayerCell:ctor(...)
	self:initUI()
end

function ClanClearPlayerCell:initUI(...)
	self.panelHead = UIControls.PlayerHeadGridChild(self, "GridPlayer", "System/Common/Grid/GridPlayerCommon", 0, 0, true)
	self.textName = UIControls.Label(self, "TxtName")
	self.textScore = UIControls.Label(self, "TxtNum")
end

function ClanClearPlayerCell:setData(memberInfo)
	self.member = memberInfo[1]
	self.score = memberInfo[2]

	self.panelHead:setCommInfo(self.member.base, false, self)

	local name = utils.GetPlayerName(self.member.base.name)

	self.textName:setText(name)
	self.textScore:setText(self.score)
end

local DispatchHeroAddCell = Class("DispatchHeroAddCell", UIControls.Child)

function DispatchHeroAddCell:ctor(...)
	self:initUI()
end

function DispatchHeroAddCell:initUI(...)
	self.btnSensor = UIControls.Button(self, "")

	self.btnSensor:addEventClick(self.onBtnSensorClick)

	self.gridHero = GridHeroStarUp(self, "GridHeroStarUpPanel", "System/StarUp/GridHeroStarUp")
end

function DispatchHeroAddCell:setData(hero)
	self.hero = hero

	if hero then
		self.gridHero:setHero(self.hero)
		self.gridHero:setDispatchState()
		self.gridHero:setVisible(true)
		self:setVisible(true)
	else
		self.gridHero:setVisible(false)
		self:setVisible(false)
	end
end

function DispatchHeroAddCell:onBtnSensorClick()
	return
end

local DispatchProgressAwardButton = Class("DispatchProgressAwardButton", UIControls.Button)

function DispatchProgressAwardButton:ctor()
	self:initUI()
end

function DispatchProgressAwardButton:initUI()
	self.imgButton = UIControls.Image(self, self.mPath .. "/Icon")
	self.textScore = UIControls.Label(self, self.mPath .. "/TxtNum")
end

local strClassName = "ClanClearLayerDlg"
local ClanClearLayerDlg = Class(strClassName, UIControls.Window)

MixinClass(ClanClearLayerDlg, ActivityPanelMixin)

local MAX_BONUS_NUM = 4
local MAX_HERO_NUM = 5
local MAX_BOSS_NUM = 3

function ClanClearLayerDlg:initUI()
	self.imgBg = UIControls.RawImage(self, "Bg")
	self.btnClose = UIControls.Button(self, "BtnClose")

	self.btnClose:addEventClick(self.onCloseClick)

	self.btnsBoss = {}
	self.btnsBossNew = {}

	for index = 1, MAX_BOSS_NUM do
		local newBtn = UIControls.Button(self, "MainInfoPanel/AreaPanel/BtnArea" .. index, "Text")

		newBtn:addEventClick(self.onBossBtnClick)

		newBtn.index = index

		table.insert(self.btnsBoss, newBtn)

		local iconNew = UIControls.Panel(self, "MainInfoPanel/AreaPanel/BtnArea" .. index .. "/IconNew")

		table.insert(self.btnsBossNew, iconNew)
	end

	self.sliderPreDay = UIControls.Slider(self, "MainInfoPanel/DispatchInfoPanel/DispatchProgress")
	self.sliderAward = UIControls.Slider(self, "MainInfoPanel/DispatchInfoPanel/Advanceprogress")
	self.lastAwardBtn = DispatchProgressAwardButton(self, "MainInfoPanel/DispatchInfoPanel/DispatchProgress/BtnAward")
	self.lastAwardBtn.index = MAX_BONUS_NUM + 1

	self.lastAwardBtn:addEventClick(self.onAwardClick)

	self.awardBtns = {}

	for index = 1, MAX_BONUS_NUM do
		local newBtn = DispatchProgressAwardButton(self, "MainInfoPanel/DispatchInfoPanel/DispatchProgress/BtnProgressAward" .. index)

		newBtn.index = index

		newBtn:addEventClick(self.onAwardClick)
		table.insert(self.awardBtns, newBtn)
	end

	self.panelComputionExtra = UIControls.Panel(self, "MainInfoPanel/DispatchInfoPanel/DispatchPanel/ImgAccount")
	self.panelInTime = UIControls.Panel(self, "MainInfoPanel/DispatchInfoPanel/DispatchPanel")
	self.panelNoSending = UIControls.Panel(self, "MainInfoPanel/DispatchInfoPanel/DispatchPanel/ImgNone")
	self.panelSending = UIControls.Panel(self, "MainInfoPanel/DispatchInfoPanel/DispatchPanel/TeamPanel")
	self.imgStateSending = UIControls.Panel(self, "MainInfoPanel/DispatchInfoPanel/DispatchPanel/TeamPanel/ImgDispatch")
	self.chooseHeadCells = {}

	for index = 0, MAX_HERO_NUM - 1 do
		local newHead = DispatchHeroAddCell(self, "MainInfoPanel/DispatchInfoPanel/DispatchPanel/TeamPanel/Bg" .. index, "System/Activity/BtnDispatchAct")

		table.insert(self.chooseHeadCells, newHead)
	end

	self.textScore = UIControls.Label(self, "MainInfoPanel/DispatchInfoPanel/DispatchPanel/TxtTeamScore")
	self.btnGoSend = UIControls.Button(self, "MainInfoPanel/DispatchInfoPanel/DispatchPanel/BtnDispatch")

	self.btnGoSend:addEventClick(self.onGoSendClick)

	self.panelNotInTime = UIControls.Panel(self, "MainInfoPanel/DispatchInfoPanel/DispatchNonePanel")
	self.bgNotInTime = UIControls.Panel(self, "MainInfoPanel/DispatchInfoPanel/DispatchNonePanel/DesPanel")
	self.textNotInTime = UIControls.Label(self, "MainInfoPanel/DispatchInfoPanel/DispatchNonePanel/DesPanel/TxtTime")
	self.clanMemCells = {}
	self.clanMemView = UIControls.ScrollViewLoopV(self, "MainInfoPanel/DispatchInfoPanel/PlayerInfoPanel", 0, self.onCellChanged)
	self.btnEvent = UIControls.Button(self, "MainInfoPanel/EventPanel")

	self.btnEvent:addEventClick(self.onEventClick)

	self.panelScore = UIControls.Panel(self, "MainInfoPanel/DispatchInfoPanel/ScorePanel")
	self.textAllScore = UIControls.Label(self, "MainInfoPanel/DispatchInfoPanel/ScorePanel/AllPanel/TxtNum")
	self.textYesterdayScore = UIControls.Label(self, "MainInfoPanel/DispatchInfoPanel/ScorePanel/YesterdayPanel/TxtNum")
	self.textTodayScore = UIControls.Label(self, "MainInfoPanel/DispatchInfoPanel/ScorePanel/NewPanel/TxtNum")
	self.panelNone = UIControls.Panel(self, "MainInfoPanel/DispatchInfoPanel/ImgNone")
end

function ClanClearLayerDlg:_setData()
	self.cellPath = "System/Activity/GirdActPlayerInfo"

	if self.replaceableCellPath and self.replaceableCellPath[1] then
		self.cellPath = "System/Activity/" .. self.replaceableCellPath[1] .. "/GridActPlayerInfo"
	end

	self.gotAtlasPath = "Atlas/CommonAtlas/IconAtlas/ItemBagAtlas/21"
	self.nmlAtlasPath = "Atlas/CommonAtlas/IconAtlas/ItemBagAtlas/20"

	if self.replaceableCellPath and self.replaceableCellPath[2] then
		self.gotAtlasPath = "Atlas/ActivityAtlas/" .. self.replaceableCellPath[2]
		self.nmlAtlasPath = self.gotAtlasPath
	end

	self.miscData = self.actObj.actData.miscData or {}

	self:refreshData()
end

function ClanClearLayerDlg:onShowBoss(bossId, actObj)
	self.bossId = bossId

	self:onShowActivity({
		actObj.clientTemplateData,
		actObj
	})
end

local MIN_X = -410
local LEN_X = 410 - MIN_X
local COORD_Y = 5

function ClanClearLayerDlg:refreshData()
	if not self.bossId then
		return
	end

	local actData = self.actObj.actData

	for index = 1, MAX_BOSS_NUM do
		local btn = self.btnsBoss[index]
		local curLayer, curScore = actData:getCurClanLayer(index)
		local layerData = actData.clientData[index][curLayer]

		btn:setText(layerData.name or "")
		btn:setEnable(index ~= self.bossId)

		if self.bossId == index then
			self.curLayer = curLayer
			self.curScore = curScore
			self.layerData = layerData
		end

		local iconNew = self.btnsBossNew[index]

		if actData:_bossIdHasNew(index, true) then
			iconNew:setVisible(true)
		else
			iconNew:setVisible(false)
		end
	end

	if self.layerData then
		self.todayScore = 0

		if CurAvatar.myCircle then
			self.todayScore = CurAvatar.myCircle:getClanClearTodayScore(self.actObj.opId, self.bossId)
		end

		local bonusGot = actData.nowBonusData[self.bossId] or {}

		self.bonusGot = bonusGot[self.curLayer] or {}
		self.bonus = self.layerData.score_award

		local maxBonus = #self.bonus

		self.maxScore = self.bonus[maxBonus].score

		self.textAllScore:setText(self.todayScore + self.curScore)
		self.textYesterdayScore:setText(self.curScore)
		self.textTodayScore:setText(self.todayScore)
		self.sliderPreDay:setValue(self.curScore / self.maxScore)
		self.sliderAward:setValue((self.curScore + self.todayScore) / self.maxScore)

		for index, btn in ipairs(self.awardBtns) do
			if index < maxBonus then
				btn:setVisible(true)

				local score = self.bonus[index].score
				local coordX = MIN_X + LEN_X * score / self.maxScore

				btn:setPosition(coordX, COORD_Y)
				btn.textScore:setText(score)

				if self.bonusGot[index] then
					btn.imgButton:setImage(self.gotAtlasPath, "321")
					btn:setObjGray(false)
				else
					btn.imgButton:setImage(self.nmlAtlasPath, "319")

					if score > self.curScore + self.todayScore then
						btn:setObjGray(true)
					else
						btn:setObjGray(false)
					end
				end
			else
				btn:setVisible(false)
			end
		end

		self.lastAwardBtn.textScore:setText(self.maxScore)

		if self.bonusGot[maxBonus] then
			self.lastAwardBtn.imgButton:setImage(self.gotAtlasPath, "322")
			self.lastAwardBtn:setObjGray(false)
		else
			self.lastAwardBtn.imgButton:setImage(self.nmlAtlasPath, "320")

			if self.maxScore > self.curScore + self.todayScore then
				self.lastAwardBtn:setObjGray(true)
			else
				self.lastAwardBtn:setObjGray(false)
			end
		end

		if self.layerData.icon_path then
			self.imgBg:setImage("NoAlpha/" .. self.layerData.icon_path)
		end

		local formations = actData:getCurClanLayerFormation(self.bossId)
		local timeState, countDown = actData:getNowTimeState()

		if timeState == 0 then
			self.panelScore:setVisible(true)
			self.imgStateSending:setVisible(true)
			self.panelComputionExtra:setVisible(false)
			self.panelInTime:setVisible(true)
			self.panelNotInTime:setVisible(false)
			self.panelNoSending:setVisible(false)

			if formations and #formations > 0 then
				self.btnGoSend:setVisible(false)
				self.panelSending:setVisible(true)

				for index, head in ipairs(self.chooseHeadCells) do
					head:setData(formations[index])
				end

				local score = 0

				if CurAvatar.myCircle then
					score = CurAvatar.myCircle:getClanClearMemberScore(nil, self.actObj.opId, self.bossId, true)
				end

				self.textScore:setText(score)
			else
				self.btnGoSend:setVisible(true)
				self.panelSending:setVisible(false)
				self.textScore:setText("")
			end
		elseif timeState == 1 then
			self.panelScore:setVisible(true)
			self.imgStateSending:setVisible(false)
			self.panelComputionExtra:setVisible(true)

			if formations and #formations > 0 then
				self.panelSending:setVisible(true)
				self.panelNoSending:setVisible(false)
			else
				self.panelSending:setVisible(false)
				self.panelNoSending:setVisible(true)
			end

			self.panelInTime:setVisible(true)
			self.panelNotInTime:setVisible(false)
			self.btnGoSend:setVisible(false)
			self.textScore:setText("")
		else
			self.panelScore:setVisible(false)
			self.imgStateSending:setVisible(false)
			self.panelComputionExtra:setVisible(false)
			self.panelInTime:setVisible(false)
			self.panelNotInTime:setVisible(true)

			if self.curScore == 0 then
				self.bgNotInTime:setVisible(true)
				ClientTimerManager.AddSecondFormatTickUI(self.textNotInTime, countDown, nil, self.miscData.area_wait_notice, nil, nil)
			else
				ClientTimerManager.RemoveSecondTickUI(self.textNotInTime)
				self.bgNotInTime:setVisible(false)
				self.textNotInTime:setText("")
			end
		end
	end

	self.mems = {}

	local myCircle = CurAvatar.myCircle
	local opId = self.actObj.opId
	local bossId = self.bossId

	if myCircle then
		local memDic = myCircle:getCircleMembersList()

		for _, mem in ipairs(memDic) do
			local score = myCircle:getClanClearMemberScore(mem, opId, bossId, true)

			if score > 0 then
				table.insert(self.mems, {
					mem,
					score
				})
			end
		end
	end

	table.sort(self.mems, utils.getSortingFunc(2))
	self.panelNone:setVisible(#self.mems == 0)
	self.clanMemView:setTotalCount(#self.mems, 1)
end

function ClanClearLayerDlg:onCellChanged(sender, targetCell, newIdx)
	if targetCell == nil then
		targetCell = ClanClearPlayerCell(sender, self.cellPath, newIdx)
	else
		self.clanMemCells[targetCell.mIndex] = nil
		targetCell.mIndex = newIdx
	end

	self.clanMemCells[newIdx] = targetCell

	targetCell:setData(self.mems[newIdx])
end

function ClanClearLayerDlg:updateActivityData()
	self:refreshData()
end

function ClanClearLayerDlg:onOpen()
	ClanClearLayerDlg.super.onOpen(self)
end

function ClanClearLayerDlg:onBossBtnClick(sender)
	self:onShowBoss(sender.index, self.actObj)
end

function ClanClearLayerDlg:onCloseClick()
	self:setVisible(false)
end

function ClanClearLayerDlg:onEventClick()
	local events = self.actObj.actData:getClanYesterdayEvents(self.bossId)

	UIManager.getUI("clanClearEventsDlg", true):onShow(events, self.actObj)
end

function ClanClearLayerDlg:onAwardClick(sender)
	local index = sender.index

	if index == MAX_BONUS_NUM + 1 then
		ClientUtils.ShowBonusPreviewDlg(self.bonus[#self.bonus].award, self.actObj.actData:bonusHasGot(self.bossId, self.layerData.layer, #self.bonus))
	elseif self.bonus[index] then
		ClientUtils.ShowBonusPreviewDlg(self.bonus[index].award, self.actObj.actData:bonusHasGot(self.bossId, self.layerData.layer, index))
	end
end

function ClanClearLayerDlg:onGoSendClick()
	if self.actObj:inFreeze() then
		MsgManager.notice(Lang.get(32793))
	else
		local timeState = self.actObj.actData:getNowTimeState()

		if timeState == 0 then
			UIManager.getUI("clanClearSendDlg", true):onShowBoss(self.bossId, self.actObj)
		else
			MsgManager.clientNotice(421)
		end
	end
end

return ClanClearLayerDlg
