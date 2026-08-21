-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\NewMaze\\NewMazeEventDetailDlg.lua

local ResNewMazeBattle = require("ClientData/ResNewMazeBattle")
local ResBattleTarget = require("ClientData/ResBattleTarget")
local ResBattleConfig = require("ClientData/ResBattleConfig")
local ResRandClient = require("ClientData/ResRandClient")
local ResNewMazeTreasure = require("ClientData/ResNewMazeTreasure")
local ResNewMazeRandEvent = require("ClientData/ResNewMazeRandEvent")
local DebuffGrid = require("UI/NewMaze/DebuffGrid")
local DebuffTipsInfoPanel = require("UI/NewMaze/DebuffTipsInfoPanel")
local BattleConst = require("Common/FrameBattle/BattleConst")
local Monster = require("Common/Object/Monster")
local GridHookContainerChild = require("UI/Common/Grid/GridHookContainerChild")
local ResNewMazeDisplay = require("ClientData/ResNewMazeDisplay")
local strClassName = "EventChooseCell"
local EventChooseCell = Class(strClassName, UIControls.Child)

function EventChooseCell:ctor(...)
	self.textTitle = UIControls.Label(self, "TextTitle")
	self.textDes = UIControls.Label(self, "TextDes")
	self.imgSel = UIControls.Image(self, "ImgSel")
	self.btnSelf = UIControls.Button(self, "")

	self.btnSelf:addEventClick(self.onSelectClick)
end

function EventChooseCell:setData(randomId, index)
	self.randomId = randomId
	self.index = index
	self.randSubjectType = self.mParent.newMazeData.randSubjectType or 1
	self.randomData = self.mParent.newMazeData.randEventTableData[self.randSubjectType][self.randomId]

	self.textTitle:setText(self.randomData.name)
	self.textDes:setText(self.randomData.description)
	self.imgSel:setVisible(self.mParent.curChooseRandomIndex == self.index)
end

function EventChooseCell:setSelectFunc(selectCallback)
	self.selectCallback = selectCallback
end

function EventChooseCell:onSelectClick()
	if self.selectCallback then
		self.selectCallback(self)
	end
end

function EventChooseCell:refreshUI()
	self.imgSel:setVisible(self.mParent.curChooseRandomIndex == self.index)
end

local strClassName = "NewMazeEventDetailDlg"
local NewMazeEventDetailDlg = Class(strClassName, UIControls.Window)

function NewMazeEventDetailDlg:ctor(...)
	self:initUI()
end

function NewMazeEventDetailDlg:initUI()
	self.eventBattleDetailPanel = UIControls.Panel(self, "BgPanel/EventBattleDetailPanel")
	self.iconEvent = UIControls.RawImage(self, "BgPanel/EventCardPanel/IconEvent")
	self.textBattleRule = UIControls.Label(self, "BgPanel/EventBattleDetailPanel/TextSpecialPanel/TextRule")
	self.text = UIControls.Label(self, "BgPanel/BtnFunc/Text")
	self.textRule = UIControls.Label(self, "BgPanel/EventDetailPanel/TextRulelPanel/TextRule")
	self.textSpecialPanel = UIControls.Panel(self, "BgPanel/EventBattleDetailPanel/TextSpecialPanel")
	self.textDes = UIControls.Label(self, "BgPanel/EventBattleDetailPanel/TextDes")
	self.bgEvent = UIControls.Image(self, "BgPanel/EventCardPanel/BgEvent")
	self.textEvent = UIControls.Image(self, "BgPanel/EventCardPanel/BgTextEvent/TextEvent")
	self.eventDetailPanel = UIControls.Panel(self, "BgPanel/EventDetailPanel")
	self.eventRandomPanel = UIControls.Panel(self, "BgPanel/EventRandomPanel")
	self.textRandomRule = UIControls.Label(self, "BgPanel/EventRandomPanel/TextRulelPanel/TextRule")
	self.btnFunc = UIControls.Button(self, "BgPanel/BtnFunc", "Text")

	self.btnFunc:addEventClick(self.onBtnFuncClick)

	self.btnMoreMonster = UIControls.Button(self, "BgPanel/EventBattleDetailPanel/MonsterPanel/MonsterList/BtnMoreMonster")

	self.btnMoreMonster:addEventClick(self.onBtnMoreMonsterClick)

	self.awardDeBuffPanel = UIControls.Panel(self, "BgPanel/EventCardPanel/AwardDeBuffPanel")
	self.deBuffTipsPanel = UIControls.Panel(self, "BgPanel/EventCardPanel/AwardDeBuffPanel/DeBuffTipsPanel")
	self.uIClickThrough = UIControls.Button(self, "BgPanel/EventCardPanel/AwardDeBuffPanel/DeBuffTipsPanel/UIClickThrough")

	self.uIClickThrough:addEventClick(self.onUIClickThroughClick)

	self.panelCareerNotice = UIControls.Label(self, "BgPanel/EventBattleDetailPanel/TextDes")
	self.panelLastPointBoss = UIControls.Panel(self, "BgPanel/EventBattleDetailPanel/PointsPanel")
	self.textBattleDetail = UIControls.Label(self, "BgPanel/EventBattleDetailPanel/PointsPanel/Text")
	self.monsterCells = {}
	self.moreMonsterCells = {}
	self.buffCells = {}
	self.randomEventcells = {}
end

function NewMazeEventDetailDlg:setData(nodeData, levelType, curSelectNodeIndex)
	self.actObj = CurAvatar:getNewMazeActivity()

	if self.actObj and self.actObj:isValid() then
		self.newMazeData = self.actObj.actData
	else
		return
	end

	self.eventType = nodeData.node_type
	self.nodeId = nodeData.node_id
	self.eventId = nodeData.spec_id
	self.curSelectNodeIndex = curSelectNodeIndex
	self.levelAwardData = self.newMazeData.layerAwardData[self.newMazeData.ratingLevel]

	if nodeData.tag_id and nodeData.tag_id > 0 then
		self.panelCareerNotice:setVisible(true)
		self.panelCareerNotice:setText(Lang.get(102264))
	else
		self.panelCareerNotice:setVisible(false)
	end

	if #self.levelAwardData >= self.newMazeData.layer then
		self.layerAward = self.levelAwardData[self.newMazeData.layer]
	else
		local layer = math.fmod(self.newMazeData.layer, #self.levelAwardData)

		self.layerAward = self.levelAwardData[layer]
	end

	local typeNum = Const.NEW_MAZE_NODE_EVENT_NAME[self.eventType][2]

	self.textEvent:setImage("Atlas/RogueAtlas/RougeMainAtlas01", "TxtEvent0" .. typeNum)

	if levelType == 2 and utils.tableIsContainsElement(Const.NEW_MAZE_BATTLE_EVENT, self.eventType) then
		self.iconEvent:setImage("NoAlpha/Rogue/BgPoltCard0" .. typeNum)
	elseif self.eventType == Const.NEW_MAZE_NODE_EVENT_TYPE.Award then
		local quality = ResNewMazeTreasure[self.eventId].quality
		local num = quality - 1 + typeNum

		self.iconEvent:setImage("NoAlpha/Rogue/BgPoltCard" .. num)
	else
		self.iconEvent:setImage("NoAlpha/Rogue/BgPoltCard" .. typeNum)
	end

	if utils.tableIsContainsElement(Const.NEW_MAZE_BATTLE_EVENT, self.eventType) then
		self.eventBattleDetailPanel:setVisible(true)
		self.eventDetailPanel:setVisible(false)
		self.eventRandomPanel:setVisible(false)
		self.btnFunc:setText(Lang.get(699))

		self.battleId = ResNewMazeBattle[self.eventId].battle_id
		self.battleConfig = ResBattleConfig[self.battleId]

		if self.eventType == Const.NEW_MAZE_NODE_EVENT_TYPE.SpecialFight then
			self.textSpecialPanel:setVisible(true)
			self.textDes:setVisible(true)
			self.textDes:setText(ResNewMazeDisplay[13060050].desc)

			local targetId = self.battleConfig.target_id or 0

			if ResBattleTarget[targetId] then
				local targetDesc = ResBattleTarget[targetId].targets[1].desc

				self.textBattleRule:setText(targetDesc)
			end
		else
			self.textSpecialPanel:setVisible(false)
		end

		self.monsterObjs = {}

		local monsters = self.battleConfig.monsters

		for pos, monsterId in ipairs(monsters) do
			if monsterId and monsterId ~= 0 then
				local newMonster = Monster(monsterId, 220)

				table.insert(self.monsterObjs, newMonster)
			end
		end

		local needCount = 0

		if #self.monsterObjs <= 5 then
			needCount = #self.monsterObjs

			self.btnMoreMonster:setVisible(false)
		else
			self.btnMoreMonster:setVisible(true)

			needCount = 5
		end

		self.panelLastPointBoss:setVisible(ResNewMazeBattle[self.eventId].need_settle == 1)
		self.textBattleDetail:setText(ResNewMazeDisplay[13060076].desc or "")
		self:_initMonsters(needCount, self.monsterCells, "BgPanel/EventBattleDetailPanel/MonsterPanel/MonsterList")

		local randId, coinNum, expNum, extraCoinNum

		if self.eventType == Const.NEW_MAZE_NODE_EVENT_TYPE.NormalFight then
			randId = self.layerAward.normal_pass_award
			coinNum = self.layerAward.normal_coin_award
			expNum = ResNewMazeBattle[self.eventId].shop_exp or 0
		elseif self.eventType == Const.NEW_MAZE_NODE_EVENT_TYPE.EliteFight then
			randId = self.layerAward.elite_pass_award
			coinNum = self.layerAward.elite_coin_award
			expNum = ResNewMazeBattle[self.eventId].shop_exp or 0
		elseif self.eventType == Const.NEW_MAZE_NODE_EVENT_TYPE.BossFight then
			randId = self.layerAward.boss_pass_award
			coinNum = self.layerAward.boss_coin_award
			expNum = ResNewMazeBattle[self.eventId].shop_exp or 0
		elseif self.eventType == Const.NEW_MAZE_NODE_EVENT_TYPE.SpecialFight then
			randId = self.layerAward.special_pass_award
			coinNum = self.layerAward.special_coin_award
			expNum = ResNewMazeBattle[self.eventId].shop_exp or 0
			extraCoinNum = ResNewMazeBattle[self.eventId].target_award or 0
		end

		self:initAward(randId, coinNum, expNum, extraCoinNum)
		self:initDebuff()
	else
		self.eventBattleDetailPanel:setVisible(false)
		self.eventDetailPanel:setVisible(true)
		self.eventRandomPanel:setVisible(false)

		if self.eventType == Const.NEW_MAZE_NODE_EVENT_TYPE.Shop then
			self.btnFunc:setText(Lang.get(73))

			local shopLevel = self.newMazeData.curShopLv
			local shopData

			for i, v in pairs(self.newMazeData.shopTableData) do
				if v.shop_level == shopLevel then
					shopData = v
				end
			end

			self.textRule:setText(shopData.shop_description)
		elseif self.eventType == Const.NEW_MAZE_NODE_EVENT_TYPE.Award then
			self.btnFunc:setText(Lang.get(61824))
			self.textRule:setText(ResNewMazeTreasure[self.eventId].description)
		elseif self.eventType == Const.NEW_MAZE_NODE_EVENT_TYPE.RandEvent then
			self.eventDetailPanel:setVisible(false)
			self.eventRandomPanel:setVisible(true)
			self.btnFunc:setText(Lang.get(61825))
			self.textRandomRule:setText(ResNewMazeDisplay[13060047].desc)

			self.randomEventList = {
				self.eventId
			}

			if (self.newMazeData.miscData.new_hero_feature1 == 101 or self.newMazeData.miscData.new_hero_feature2 == 101) and nodeData.spec_id_other and nodeData.spec_id_other ~= 0 then
				self.randomEventOtherId = nodeData.spec_id_other

				table.insert(self.randomEventList, self.randomEventOtherId)
			end

			self.curChooseRandomIndex = 1

			if self.newMazeData.lastEventData.node_type == self.eventType and self.newMazeData.lastEventData.spec_data.rand_event.select_index ~= 0 then
				self.alreadyChooseRand = true
				self.curChooseRandomIndex = self.newMazeData.lastEventData.spec_data.rand_event.select_index
			end

			for i, eventId in ipairs(self.randomEventList) do
				local eventChooseCell = self.randomEventcells[i]

				if eventChooseCell == nil then
					eventChooseCell = EventChooseCell(self, "BgPanel/EventRandomPanel/EventChooseTwoPanel", "System/Rogue/EventChooseCell", 0, 0, true)
				end

				eventChooseCell:setData(eventId, i)
				eventChooseCell:setSelectFunc(Slot(self.chooseRandomCellClick, self))

				self.randomEventcells[i] = eventChooseCell
			end
		end
	end
end

function NewMazeEventDetailDlg:chooseRandomCellClick(sender)
	if self.curChooseRandomIndex ~= sender.index and self.alreadyChooseRand then
		MsgManager.notice(ResNewMazeDisplay[13060061].desc)

		return
	end

	self.curChooseRandomIndex = sender.index

	for i, eventChooseCell in ipairs(self.randomEventcells) do
		eventChooseCell:refreshUI()
	end
end

function NewMazeEventDetailDlg:_initMonsters(needCount, pool, path)
	local preCount = 1

	for idx, cell in ipairs(pool) do
		preCount = preCount + 1

		if idx <= needCount then
			cell:setVisible(true)
			cell.setObj(self.monsterObjs[idx])
		else
			cell:setVisible(false)
		end
	end

	for i = preCount, needCount do
		local newCell = UIControls.MonsterCardChild(self, path, "System/Common/Grid/GridMonster")

		table.insert(pool, newCell)
		newCell:setVisible(true)
		newCell:setObj(self.monsterObjs[i])
	end
end

function NewMazeEventDetailDlg:initAward(randId, coinNum, expNum, extraCoinNum)
	local path = "BgPanel/EventBattleDetailPanel/AwardPanel/AwardList"
	local itemCoinId = self.newMazeData.miscData.coin_item_id

	if coinNum then
		coinNum = coinNum + self.newMazeData.battleGoldAdd

		local newGrid = UIControls.getGridContainer(self, path)
		local coinItem = BaseObject.GetObject(itemCoinId, coinNum)

		newGrid:setObj(coinItem)

		newGrid.grid.mDisableWays = true

		newGrid:setVisible(true)
	end

	local expGrid = UIControls.getGridContainer(self, path)
	local itemExpId = self.newMazeData.miscData.shop_exp_item_id

	if self.newMazeData.ratingLevel == 1 and self.newMazeData.layer == 1 then
		expNum = expNum + 2
	end

	expNum = expNum + self.newMazeData.battleExpAdd

	local expItem = BaseObject.GetObject(itemExpId, expNum)

	expGrid:setObj(expItem)

	expGrid.grid.mDisableWays = true

	expGrid:setVisible(true)

	if extraCoinNum then
		local coinItem = BaseObject.GetObject(itemCoinId, extraCoinNum)
		local extraGrid = UIControls.getGridAwardContainer(self, path)

		extraGrid:setObj(coinItem)

		extraGrid.mDisableWays = true

		extraGrid:setSpe(true, 3, self.newMazeData.miscData.grid_special_config)
		extraGrid.imgSpe:setScaleXYZ(1.4, 1.4, 1)
		extraGrid:setVisible(true)
	end
end

function NewMazeEventDetailDlg:initDebuff()
	if self.newMazeData.nextFightBuff then
		if self.buffGrid == nil then
			self.buffGrid = DebuffGrid(self, "BgPanel/EventCardPanel/AwardDeBuffPanel/DeBuffPanel", "System/Common/Grid/GridDeBuff", 0, 0, true)
		end

		self.buffGrid:setData(self.newMazeData.nextFightBuff)
		self.buffGrid:setClickCallBack(Slot(self.onClickDebuff, self))

		self.debuffTipInfoPanel = DebuffTipsInfoPanel(self, "BgPanel/EventCardPanel/AwardDeBuffPanel/DeBuffTipsPanel", "System/Common/Tips/DeBuffTipsInfoPanel")

		self.awardDeBuffPanel:setVisible(true)
	end
end

function NewMazeEventDetailDlg:onClickDebuff(grid)
	self.debuffTipInfoPanel:setData(grid.buffId)
	self.debuffTipInfoPanel:setVisible(true)
	self.deBuffTipsPanel:setVisible(true)
end

function NewMazeEventDetailDlg:onUIClickThroughClick()
	self.deBuffTipsPanel:setVisible(false)
	self.debuffTipInfoPanel:setVisible(false)
end

function NewMazeEventDetailDlg:onBtnMoreMonsterClick()
	UIManager.getUI("onceTowerMonsterDlg", true):onShow(self.monsterObjs or {})
end

function NewMazeEventDetailDlg:onBtnFuncClick()
	if self.actObj:inFreeze() then
		MsgManager.notice(Lang.get(32793))

		return
	end

	if utils.tableIsContainsElement(Const.NEW_MAZE_BATTLE_EVENT, self.eventType) then
		if self.newMazeData.lastRandMultiAward and #self.newMazeData.lastRandMultiAward ~= 0 then
			local chooseThreeDlg = UIManager.getUI("newMazeChooseThreeDlg", true)

			chooseThreeDlg:setData(self.newMazeData.lastRandMultiAward)
		elseif CurAvatar.newMazeBattleMultiAward then
			local chooseThreeDlg = UIManager.getUI("newMazeChooseThreeDlg", true)

			chooseThreeDlg:setData(CurAvatar.newMazeBattleMultiAward)

			CurAvatar.newMazeBattleMultiAward = nil
		else
			self:_battleEventFunc()
		end
	elseif self.eventType == Const.NEW_MAZE_NODE_EVENT_TYPE.Shop then
		if self.newMazeData.shopItems then
			local storeDlg = UIManager.getUI("newMazeStoreDlg", true)

			storeDlg:setData(self.newMazeData.shopItems)
		else
			RPC.newMazeNodeSelect(self.actObj.opId, self.newMazeData.layer, self.curSelectNodeIndex)
		end
	elseif self.eventType == Const.NEW_MAZE_NODE_EVENT_TYPE.Award then
		if self.newMazeData.lastRandMultiAward and #self.newMazeData.lastRandMultiAward ~= 0 then
			local chooseThreeDlg = UIManager.getUI("newMazeChooseThreeDlg", true)

			chooseThreeDlg:setData(self.newMazeData.lastRandMultiAward)
		else
			RPC.newMazeNodeSelect(self.actObj.opId, self.newMazeData.layer, self.curSelectNodeIndex)
		end
	elseif self.eventType == Const.NEW_MAZE_NODE_EVENT_TYPE.RandEvent then
		if self.alreadyChooseRand then
			if self.newMazeData.lastRandMultiAward and #self.newMazeData.lastRandMultiAward ~= 0 then
				if self.newMazeData.randEventRemainTimes and self.newMazeData.randEventRemainTimes >= 1 then
					local randomDetailDlg = UIManager.getUI("newMazeRandomDetailDlg", true)

					randomDetailDlg:setData(self.randomEventList[self.curChooseRandomIndex], self.nodeId)
				end

				local chooseThreeDlg = UIManager.getUI("newMazeChooseThreeDlg", true)

				chooseThreeDlg:setData(self.newMazeData.lastRandMultiAward)
			else
				local randomDetailDlg = UIManager.getUI("newMazeRandomDetailDlg", true)

				randomDetailDlg:setData(self.randomEventList[self.curChooseRandomIndex], self.nodeId)
			end
		else
			RPC.newMazeNodeSelect(self.actObj.opId, self.newMazeData.layer, self.curSelectNodeIndex)
			RPC.newMazeRandomEventSelect(self.actObj.opId, self.curChooseRandomIndex)

			local randomDetailDlg = UIManager.getUI("newMazeRandomDetailDlg", true)

			randomDetailDlg:setData(self.randomEventList[self.curChooseRandomIndex], self.nodeId)
		end
	end

	self:setVisible(false)
end

function NewMazeEventDetailDlg:_battleEventFunc()
	local hp = self.newMazeData.redheart

	if hp <= 0 then
		MsgManager.notice(Lang.get(64288))

		return
	end

	local pveId = self.battleId
	local battleData = {}

	battleData.newMazeData = {}
	battleData.newMazeData.eventType = self.eventType
	battleData.newMazeData.eventId = self.eventId
	battleData.newMazeData.nodeId = self.nodeId
	battleData.newMazeData.curSelectNodeIndex = self.curSelectNodeIndex
	battleData.newMazeData.isRetry = 0
	battleData.newMazeData.actId = self.actObj.actId
	battleData.newMazeData.opId = self.actObj.opId

	CurAvatar:enterFormation(pveId, BattleConst.BATTLE_TYPE_NEW_MAZE, battleData)
end

return NewMazeEventDetailDlg
