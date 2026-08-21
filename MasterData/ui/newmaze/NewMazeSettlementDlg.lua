-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\NewMaze\\NewMazeSettlementDlg.lua

local ResNewMazeDisplay = require("ClientData/ResNewMazeDisplay")
local NewMazeHallowGrid = require("UI/NewMaze/NewMazeHallowGrid")
local DebuffTipsInfoPanel = require("UI/NewMaze/DebuffTipsInfoPanel")
local strClassName = "NewMazeSettlementDlg"
local NewMazeSettlementDlg = Class(strClassName, UIControls.Window)

function NewMazeSettlementDlg:ctor(...)
	self:initUI()
end

function NewMazeSettlementDlg:initUI()
	self.hero = UIControls.Image(self, "BgPanel/Mask/Hero")
	self.textPass = UIControls.Label(self, "BgPanel/BgTextLayer/TextLayer/TextPass")
	self.textLayer = UIControls.Label(self, "BgPanel/BgTextLayer/TextLayer")
	self.textRedHeartNum = UIControls.Label(self, "BgPanel/BgTextLayer/TextLayer/Icon/TextNum")
	self.imgRecord = UIControls.Image(self, "BgPanel/ImgRecord")
	self.btnConfirm = UIControls.Button(self, "BgPanel/BtnPanel/BtnConfirm", "Text")

	self.btnConfirm:addEventClick(self.onBtnConfirmClick)

	self.btnDeny = UIControls.Button(self, "BgPanel/BtnPanel/BtnDeny")

	self.btnDeny:addEventClick(self.onBtnDenyClick)

	self.hallowTipsPanel = UIControls.Panel(self, "BgPanel/HallowTipsPanel")
	self.uIClickThrough = UIControls.Button(self, "BgPanel/HallowTipsPanel/UIClickThrough")

	self.uIClickThrough:addEventClick(self.onUIClickThroughClick)

	self.relicsCells = {}
	self.heroCells = {}
end

function NewMazeSettlementDlg:setData(type, hideDenyBtn, fromRatingDlg)
	self.type = type
	self.actObj = CurAvatar:getNewMazeActivity()

	if self.actObj then
		self.newMazeData = CurAvatar:getNewMazeActData()
	else
		return
	end

	self.relics = self.newMazeData.bagRelics
	self.heros = self.newMazeData.bagHeros
	self.bossLayer = 30

	for i, data in pairs(self.newMazeData.nodeTableData[self.newMazeData.ratingLevel]) do
		if data.node_type == Const.NEW_MAZE_BOSS_NODE_TYPE then
			self.bossLayer = data.layer

			break
		end
	end

	self.btnDeny:setVisible(true)

	if hideDenyBtn or fromRatingDlg or self.type == Const.NEW_MAZE_SETTLEMENT_TYPE.Over then
		self.btnDeny:setVisible(false)
	end

	if self.type == Const.NEW_MAZE_SETTLEMENT_TYPE.Next then
		self.btnConfirm:setText(ResNewMazeDisplay[13060040].desc)

		if fromRatingDlg then
			self.btnConfirm:setText(ResNewMazeDisplay[13060039].desc)
		end
	elseif self.type == Const.NEW_MAZE_SETTLEMENT_TYPE.Over then
		if self.newMazeData.layer > self.bossLayer and self.newMazeData.ratingLevel < #self.newMazeData.levelMiscData then
			self.btnConfirm:setText(ResNewMazeDisplay[13060040].desc)
		else
			self.btnConfirm:setText(ResNewMazeDisplay[13060039].desc)
		end
	elseif self.type == Const.NEW_MAZE_SETTLEMENT_TYPE.Reset then
		self.btnConfirm:setText(ResNewMazeDisplay[13060041].desc)
	end

	if Const.OPEN_NEW_MAZE_TALENT and self.newMazeData.curScore > 0 then
		local score = self.newMazeData.curScore
		local redheartNum = self.newMazeData.redheart

		if redheartNum > 0 then
			self.textRedHeartNum:setText(redheartNum)

			score = score - redheartNum * self.newMazeData.miscData.redheart_convert_score * 1000000

			self:playAni("ChangePoint", Slot(self.onChangePointOver, self))
			self.btnDeny:setVisible(false)
		end

		local str = string.format(ResNewMazeDisplay[13060009].desc, self.newMazeData.layer)

		self.textLayer:setText(string.format(Lang.get(102594), str, score))
	else
		self.textLayer:setText(string.format(ResNewMazeDisplay[13060009].desc, self.newMazeData.layer - 1))
	end

	if self.newMazeData.oldSeasonBestGradeLevel and self.newMazeData.oldSeasonBestGradeLayer then
		if self.newMazeData.ratingLevel > self.newMazeData.oldSeasonBestGradeLevel or self.newMazeData.ratingLevel == self.newMazeData.oldSeasonBestGradeLevel and self.newMazeData.layer - 1 > self.newMazeData.oldSeasonBestGradeLayer then
			self.imgRecord:setVisible(true)
		else
			self.imgRecord:setVisible(false)
		end
	end

	self.textPass:setVisible(self.newMazeData.layer > self.bossLayer)

	for i, relic in ipairs(self.relics or {}) do
		local relicCell = self.relicsCells[i]

		if relicCell == nil then
			relicCell = NewMazeHallowGrid(self, "BgPanel/HallowList/Content", "System/Common/Grid/GridHallow", 0, 0, true)
		end

		relicCell:setData(relic.id)

		relicCell.clickSelfFunc = Slot(self._onSelectHallow, self)
		self.relicsCells[i] = relicCell
	end

	for i, hero in ipairs(self.heros or {}) do
		local heroCell = self.heroCells[i]

		if heroCell == nil then
			heroCell = UIControls.GridSimpleHeroChild(self, "BgPanel/HeroList/Content", "System/Common/Grid/GridHeroTeam", 0, 0, true)
		end

		local hero = self.newMazeData:getPerfectHero(hero.id)

		heroCell:setObj(hero)

		heroCell.clickSelfFunc = Slot(self._onSelectHero, self)
		self.heroCells[i] = heroCell
	end
end

function NewMazeSettlementDlg:onChangePointOver()
	local str = string.format(ResNewMazeDisplay[13060009].desc, self.newMazeData.layer)

	self.textLayer:setText(string.format(Lang.get(102594), str, self.newMazeData.curScore))
end

function NewMazeSettlementDlg:_onSelectHero(sender)
	local heroTips = UIManager.getUI("heroTips")

	heroTips:showObj(self, sender.hero)
	heroTips:setLoasderData(sender.hero.id)
end

function NewMazeSettlementDlg:_onSelectHallow(sender)
	if self.hallowTipsInfoPanel == nil then
		self.hallowTipsInfoPanel = DebuffTipsInfoPanel(self, "BgPanel/HallowTipsPanel", "System/Common/Tips/DeBuffTipsInfoPanel")
	end

	self.hallowTipsInfoPanel:setData(sender.relicId, Const.NEW_MAZE_SHOP_ITEM_TYPE.Relic)
	self.hallowTipsInfoPanel:setVisible(true)
	self.hallowTipsPanel:setVisible(true)
end

function NewMazeSettlementDlg:onUIClickThroughClick()
	self.hallowTipsInfoPanel:setVisible(false)
	self.hallowTipsPanel:setVisible(false)
end

function NewMazeSettlementDlg:onBtnConfirmClick()
	if Const.NEW_MAZE_ITERATION_OPEN then
		if self.type == Const.NEW_MAZE_SETTLEMENT_TYPE.Next and self.newMazeData.ratingLevel == 1 then
			RPC.opActivityData("kOpActivitySyncMgrData", 0, self.actObj.opId)
			RPC.newMazeOpen(self.actObj.opId)
		else
			RPC.newMazeLevelExit(self.actObj.opId, self.type)
		end
	else
		self:oldSettlementFunc()
	end

	self:setVisible(false)
end

function NewMazeSettlementDlg:oldSettlementFunc()
	if self.type == Const.NEW_MAZE_SETTLEMENT_TYPE.Next then
		if self.newMazeData.ratingLevel == 1 then
			RPC.opActivityData("kOpActivitySyncMgrData", 0, self.actObj.opId)
			RPC.newMazeOpen(self.actObj.opId)
		else
			if self.newMazeData.tickets < 1 then
				MsgManager.notice(ResNewMazeDisplay[13060005].desc)

				return
			end

			RPC.newMazeLevelEnter(self.actObj.opId, Const.NEW_MAZE_LEVEL_ENTER_TYPE.Next)
		end
	elseif self.type == Const.NEW_MAZE_SETTLEMENT_TYPE.Over then
		if self.newMazeData.ratingLevel < #self.newMazeData.levelMiscData and self.newMazeData.layer > self.bossLayer then
			RPC.newMazeLevelEnter(self.actObj.opId, Const.NEW_MAZE_LEVEL_ENTER_TYPE.Next)
		else
			local mainDlg = UIManager.tryGetUI("newMazeMainDlg")

			if mainDlg then
				mainDlg:setVisible(false)
			end

			local chooseDlg = UIManager.tryGetUI("newMazeChooseDlg")

			if chooseDlg then
				chooseDlg:_setData()
			else
				chooseDlg = UIManager.getUI("newMazeChooseDlg", true)

				chooseDlg:_setData()
			end
		end
	elseif self.type == Const.NEW_MAZE_SETTLEMENT_TYPE.Reset then
		RPC.newMazeLevelEnter(self.actObj.opId, Const.NEW_MAZE_LEVEL_ENTER_TYPE.Reset)
	end
end

function NewMazeSettlementDlg:onBtnDenyClick()
	self:setVisible(false)
end

return NewMazeSettlementDlg
