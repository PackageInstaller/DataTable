-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\OpActivity\\ClanClear\\ClanClearSendDlg.lua

local ActivityPanelMixin = require("UI/OpActivity/ActivityPanelMixin")
local CommonHeroListPanel = require("UI/Battle/CommonHeroListPanel")
local FilterSelectPanel = require("UI/MainState/FilterSelectPanel")
local GridHeroStarUp = require("UI/Hero/StarUp/GridHeroStarUp")
local ResOpActClanBossAddon = require("ClientData/ResOpActClanBossAddon")
local ResOpActClanBossLimit = require("ClientData/ResOpActClanBossLimit")
local ResOpActClanBossMisc = require("ClientData/ResOpActClanBossMisc")
local InSendingHeroAddCell = Class("InSendingHeroAddCell", UIControls.Child)

function InSendingHeroAddCell:ctor(...)
	self:initUI()
end

function InSendingHeroAddCell:initUI(...)
	self.btnSensor = UIControls.Button(self, "")

	self.btnSensor:addEventClick(self.onBtnSensorClick)

	self.gridHero = GridHeroStarUp(self, "GridHeroStarUpPanel", "System/StarUp/GridHeroStarUp")
end

function InSendingHeroAddCell:setData(hero)
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

function InSendingHeroAddCell:onBtnSensorClick()
	if self.hero then
		self.mWindow:cancelSendingPos(self)
	end
end

local CleanHeroScrollCell = Class("CleanHeroScrollCell", UIControls.HeroCardLoop)

function CleanHeroScrollCell:ctor()
	self.panelInOtherSend = UIControls.Panel(self, "InfoPanel/ImgMention")
	self.showSelect = false
	self.panelScore = UIControls.Panel(self, "InfoPanel/ScorePanel")

	self.panelScore:setVisible(true)

	self.textScore = UIControls.Label(self, "InfoPanel/ScorePanel/Text2")
	self.textDesc = UIControls.Label(self, "InfoPanel/ScorePanel/Text1")
end

function CleanHeroScrollCell:setHero(hero)
	CleanHeroScrollCell.super.setHero(self, hero)

	if self.mWindow.otherSendHeros[hero.gid] then
		self.panelInOtherSend:setVisible(true)
	else
		self.panelInOtherSend:setVisible(false)
	end

	if self.mWindow:inSending(hero.gid) then
		self:showChooseState(true)
	else
		self:showChooseState(false)
	end

	local actId = self.mParent.mParent.actId

	self.textDesc:setText(ResOpActClanBossMisc[actId].desc_send_hero_bonus)
	self.textScore:setText(utils.getClanClearHeroScore(hero, self.mWindow.actId))
end

function CleanHeroScrollCell:showChooseState(isSelected)
	self.imgSelect:setVisible(isSelected)
end

function CleanHeroScrollCell:onBtnSelect()
	self.mWindow:onHeroCardClick(self)
end

local CleanConditionCell = Class("CleanConditionCell", UIControls.Child)

function CleanConditionCell:ctor()
	self.textDesc = UIControls.Label(self, "Text")
	self.textScoreTitle = UIControls.Label(self, "TextTitle")
	self.textScore = UIControls.Label(self, "TextAward")
end

function CleanConditionCell:setData(condId, addScore)
	if condId and ResOpActClanBossLimit[condId] then
		self.condData = ResOpActClanBossLimit[condId]

		self.textDesc:setText(self.condData.desc or "")
		self.textScore:setText("+" .. addScore)
		self:setVisible(true)
	else
		self:setVisible(false)
	end
end

function CleanConditionCell:setState(validNum, needNum)
	self.textDesc:setText((self.condData.desc or "") .. "(" .. validNum .. "/" .. needNum .. ")")

	if needNum <= validNum then
		self.textDesc:setFontColor(ResColor.ORANGEBTN)
		self.textScore:setFontColor(ResColor.ORANGEBTN)
		self.textScoreTitle:setFontColor(ResColor.ORANGEBTN)
	else
		self.textDesc:setFontColor(ResColor.GREYDIS)
		self.textScore:setFontColor(ResColor.GREYDIS)
		self.textScoreTitle:setFontColor(ResColor.GREYDIS)
	end
end

local strClassName = "ClanClearSendDlg"
local ClanClearSendDlg = Class(strClassName, UIControls.Window)

MixinClass(ClanClearSendDlg, ActivityPanelMixin)

local MAX_HERO_NUM = 5
local MAX_BOSS_NUM = 3

function ClanClearSendDlg:initUI()
	self.cellPath = "System/Activity"

	if self.replaceableCellPath and self.replaceableCellPath[1] then
		self.cellPath = "System/Activity/" .. self.replaceableCellPath[1]
	end

	self.btnClose = UIControls.Button(self, "BtnClose")

	self.btnClose:addEventClick(self.onCloseClick)

	self.filterSelectPanel = FilterSelectPanel(self, "MainInfoPanel/HeroListPanel/ListSelectPanel")
	self.listHeros = CommonHeroListPanel(self, "MainInfoPanel/HeroListPanel")
	self.mustCondCells = {}
	self.bonusCondCells = {}
	self.chooseHeadCells = {}

	for index = 0, MAX_HERO_NUM - 1 do
		local newHead = InSendingHeroAddCell(self, "MainInfoPanel/TaskMainPanel/BgMember/Bg" .. index, self.cellPath .. "/BtnDispatchAct")

		newHead.pos = index + 1

		table.insert(self.chooseHeadCells, newHead)
	end

	self.btnSend = UIControls.Button(self, "MainInfoPanel/TaskMainPanel/BtnMention")

	self.btnSend:addEventClick(self.onSendClick)

	self.textScore = UIControls.Label(self, "MainInfoPanel/TaskMainPanel/BgScore/Text")
end

function ClanClearSendDlg:onShowBoss(bossId, actObj)
	self.bossId = bossId

	self:onShowActivity({
		actObj.clientTemplateData,
		actObj
	})
end

function ClanClearSendDlg:_setData()
	self.actId = self.actObj.actId

	local actData = self.actObj.actData

	self.otherSendHeros = {}

	for index = 1, MAX_BOSS_NUM do
		if index == self.bossId then
			self.curLayer = actData:getCurClanLayer(index)
			self.layerData = actData.clientData[index][self.curLayer]
		else
			local formation = actData:getCurClanLayerFormation(index)

			for _, hero in ipairs(formation or {}) do
				self.otherSendHeros[hero.gid] = true
			end
		end
	end

	for gid, hero in pairs(CurAvatar.heroDic) do
		if self.otherSendHeros[gid] then
			hero.clanClearState = 0
		else
			hero.clanClearState = 1
		end
	end

	self.nowSendHeros = {}

	self:refreshData()
	coroutine.start(self.setHeroHeadCount, self)
end

function ClanClearSendDlg:setHeroHeadCount()
	coroutine.wait(0.1)

	if self.id then
		self.listHeros:initHeroList(CleanHeroScrollCell, "System/Hero/GridHeroCardMayDay", UIConst.HERO_CLAN_CLEAR_SORT, UIConst.CLAN_CLEAR_FILTER_PANEL_MAP)
		self.listHeros:updateHeroFilter()
	end
end

function ClanClearSendDlg:onHeroCardClick(heroCard)
	local clickHero = heroCard.hero
	local gid = clickHero.gid

	if self.otherSendHeros[gid] then
		MsgManager.clientNotice(417)

		return
	end

	local emptyPos, nowSendingPos

	for pos = 1, MAX_HERO_NUM do
		local hGid = self.nowSendHeros[pos]

		if gid == hGid then
			nowSendingPos = pos

			break
		elseif hGid == nil and emptyPos == nil then
			emptyPos = pos
		end
	end

	if nowSendingPos then
		self.nowSendHeros[nowSendingPos] = nil

		heroCard:showChooseState(false)
		self:refreshDispatchGrid(nowSendingPos)
	elseif emptyPos then
		for pos = 1, MAX_HERO_NUM do
			local hGid = self.nowSendHeros[pos]

			if hGid then
				local hero = CurAvatar.heroDic[hGid]

				if hero and hero.id == clickHero.id then
					MsgManager.clientNotice(422)

					return
				end
			end
		end

		self.nowSendHeros[emptyPos] = gid

		heroCard:showChooseState(true)
		self:refreshDispatchGrid(emptyPos)
	else
		MsgManager.clientNotice(420)
	end
end

function ClanClearSendDlg:cancelSendingPos(head)
	if head.hero then
		local pos = head.pos

		self.nowSendHeros[pos] = nil

		for _, grid in pairs(self.listHeros.cells) do
			if grid.hero.gid == head.hero.gid then
				grid:showChooseState(false)

				break
			end
		end

		self:refreshDispatchGrid(pos)
	end
end

function ClanClearSendDlg:refreshDispatchGrid()
	for index, head in ipairs(self.chooseHeadCells) do
		local hero
		local heroGid = self.nowSendHeros[index]

		if heroGid then
			hero = CurAvatar.heroDic[heroGid]
		end

		head:setData(hero)
	end

	self:checkConditionState()
end

function ClanClearSendDlg:inSending(heroGid)
	for pos = 1, MAX_HERO_NUM do
		if heroGid == self.nowSendHeros[pos] then
			return true
		end
	end
end

function ClanClearSendDlg:refreshData()
	if not self.layerData then
		return
	end

	self.limits = self.layerData.limit_list or {}

	for index = #self.mustCondCells, #self.limits - 1 do
		local newCond = CleanConditionCell(self, "MainInfoPanel/TaskMainPanel/ConditionTitle1/ConditionPanel", self.cellPath .. "/MayDayCleanConditionCell")

		table.insert(self.mustCondCells, newCond)
	end

	for index, cell in ipairs(self.mustCondCells) do
		if ResOpActClanBossAddon[self.limits[index]] then
			cell:setData(ResOpActClanBossAddon[self.limits[index]].limit_id, ResOpActClanBossAddon[self.limits[index]].score or 0)
		else
			cell:setData()
		end
	end

	self.extraLimits = self.layerData.score_add or {}

	for index = #self.bonusCondCells, #self.extraLimits - 1 do
		local newCond = CleanConditionCell(self, "MainInfoPanel/TaskMainPanel/ConditionTitle2/ConditionPanel", self.cellPath .. "/MayDayCleanConditionCell")

		table.insert(self.bonusCondCells, newCond)
	end

	for index, cell in ipairs(self.bonusCondCells) do
		if ResOpActClanBossAddon[self.extraLimits[index]] then
			cell:setData(ResOpActClanBossAddon[self.extraLimits[index]].limit_id, ResOpActClanBossAddon[self.extraLimits[index]].score or 0)
		else
			cell:setData()
		end
	end

	self:refreshDispatchGrid()
end

function ClanClearSendDlg:checkConditionState()
	local heros = {}
	local score = 0

	self.conditionOk = true
	self.softConditionOk = true

	for index, heroGid in pairs(self.nowSendHeros) do
		local hero = CurAvatar.heroDic[heroGid]

		if hero then
			table.insert(heros, hero)

			score = score + utils.getClanClearHeroScore(hero, self.actId)
		end
	end

	for index, addId in ipairs(self.limits) do
		local cell = self.mustCondCells[index]
		local addData = ResOpActClanBossAddon[addId]

		if cell and addData then
			local validNum, needNum = self:_checkConditionOK(addData.limit_id, heros)

			if validNum < needNum then
				self.conditionOk = false
			else
				score = score + (addData.score or 0)
			end

			cell:setState(validNum, needNum)
		end
	end

	for index, addId in ipairs(self.extraLimits) do
		local cell = self.bonusCondCells[index]
		local addData = ResOpActClanBossAddon[addId]

		if cell and addData then
			local validNum, needNum = self:_checkConditionOK(addData.limit_id, heros)

			cell:setState(validNum, needNum)

			if needNum <= validNum then
				score = score + (addData.score or 0)
			else
				self.softConditionOk = false
			end
		end
	end

	self.textScore:setText(score)

	if self.conditionOk and #heros >= 5 then
		self.btnSend:setObjGray(false)
	else
		self.btnSend:setObjGray(true)
	end
end

function ClanClearSendDlg:_checkConditionOK(condId, heros)
	local condData = ResOpActClanBossLimit[condId]

	if not condData then
		return 0, 0
	end

	local OKNum = 0

	for _, hero in ipairs(heros or {}) do
		if condData.check_type == 1 then
			for _, camp in ipairs(condData.param or {}) do
				if hero.camp == camp then
					OKNum = OKNum + 1

					break
				end
			end
		elseif condData.check_type == 2 then
			for _, career in ipairs(condData.param or {}) do
				if hero.career == career then
					OKNum = OKNum + 1

					break
				end
			end
		elseif condData.check_type == 3 then
			for _, team in ipairs(condData.param or {}) do
				if hero.team == team then
					OKNum = OKNum + 1

					break
				end
			end
		elseif condData.check_type == 4 then
			local needStar = condData.param[1]

			if needStar <= hero.star then
				OKNum = OKNum + 1
			end
		elseif condData.check_type == 5 then
			OKNum = OKNum + hero.step
		end
	end

	return OKNum, condData.need_value
end

function ClanClearSendDlg:updateActivityData()
	self:refreshData()
end

function ClanClearSendDlg:onOpen()
	ClanClearSendDlg.super.onOpen(self)
end

function ClanClearSendDlg:onCloseClick()
	self:setVisible(false)
end

function ClanClearSendDlg:_realStartSend(bossId, curLayer, gids)
	if self.id then
		self.actObj.actData:rpcSendStart(bossId, curLayer, gids)
		self:setVisible(false)
	end
end

function ClanClearSendDlg:onSendClick()
	if self.conditionOk then
		local gids = {}

		for index = 1, MAX_HERO_NUM do
			local heroGid = self.nowSendHeros[index]

			if heroGid then
				local hero = CurAvatar.heroDic[heroGid]

				if hero then
					table.insert(gids, heroGid)
				end
			end
		end

		if #gids < 5 then
			MsgManager.clientNotice(419)
		elseif self.softConditionOk then
			self.actObj.actData:rpcSendStart(self.bossId, self.curLayer, gids)
			self:setVisible(false)
		else
			UIManager.showConfirmWithId(1053, Functor(self._realStartSend, self, self.bossId, self.curLayer, gids))
		end
	else
		MsgManager.clientNotice(418)
	end
end

return ClanClearSendDlg
