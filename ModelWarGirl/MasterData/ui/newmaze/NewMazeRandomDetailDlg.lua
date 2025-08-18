-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\NewMaze\\NewMazeRandomDetailDlg.lua

local ResNewMazeBattle = require("ClientData/ResNewMazeBattle")
local ResNewMazeDisplay = require("ClientData/ResNewMazeDisplay")
local BattleConst = require("Common/FrameBattle/BattleConst")
local strClassName = "OptionChooseCell"
local OptionChooseCell = Class(strClassName, UIControls.Child)

function OptionChooseCell:ctor(...)
	self.textDes = UIControls.Label(self, "TextDes")
	self.btnSelf = UIControls.Button(self, "")

	self.btnSelf:addEventClick(self.onSelectClick)
end

function OptionChooseCell:setData(choiceData, index)
	self.choiceData = choiceData
	self.index = index
	self.type = self.choiceData.param_type

	if self.mParent.isSuccess == nil then
		self.textDes:setText(self.choiceData.description)
	elseif self.mParent.isSuccess == true then
		self.textDes:setText(self.choiceData.wim_desc)
	else
		self.textDes:setText(self.choiceData.lose_desc)
	end

	self.btnSelf:setEnable(true)
end

function OptionChooseCell:setSelectCloseFunc(selectCallback)
	self.selectCallback = selectCallback
end

function OptionChooseCell:onSelectClick()
	if self.selectCallback then
		self.selectCallback(self)
	end
end

local strClassName = "NewMazeRandomDetailDlg"
local NewMazeRandomDetailDlg = Class(strClassName, UIControls.Window)

function NewMazeRandomDetailDlg:ctor(...)
	self:initUI()
end

function NewMazeRandomDetailDlg:initUI()
	self.textBloodNum = UIControls.Label(self, "BgPanel/BtnBlood/TextNum")
	self.textGoldNum = UIControls.Label(self, "BgPanel/BtnGold/TextNum")
	self.textTitle = UIControls.Label(self, "BgPanel/RandomDetailPanel/BgTitle/TextTitle")
	self.textDes = UIControls.Label(self, "BgPanel/RandomDetailPanel/TextDes")
	self.textRemainNum = UIControls.Label(self, "BgPanel/RandomDetailPanel/TextRemain/TextNum")
	self.btnBlood = UIControls.Button(self, "BgPanel/BtnBlood")

	self.btnBlood:addEventClick(self.onBtnBloodClick)

	self.btnGold = UIControls.Button(self, "BgPanel/BtnGold")

	self.btnGold:addEventClick(self.onBtnGoldClick)

	self.optionChooseCells = {}
end

function NewMazeRandomDetailDlg:refreshUI(isSuccess)
	self.isSuccess = isSuccess
	self.actObj = CurAvatar:getNewMazeActivity()

	if self.actObj and self.actObj:isValid() then
		self.newMazeData = self.actObj.actData
	else
		return
	end

	self.textBloodNum:setText(self.newMazeData.redheart)
	self.textGoldNum:setText(self.newMazeData.coin)

	self.randSubjectType = self.newMazeData.randSubjectType or 1
	self.randEventData = self.newMazeData.randEventTableData[self.randSubjectType][self.eventId]

	self.textTitle:setText(self.randEventData.name)
	self.textDes:setText(self.randEventData.description)

	self.remainTimes = self.newMazeData.randEventRemainTimes or self.randEventData.times

	self.textRemainNum:setText(self.remainTimes)

	for i, choiceData in ipairs(self.randEventData.event_choices) do
		local optionChooseCell = self.optionChooseCells[i]

		if optionChooseCell == nil then
			optionChooseCell = OptionChooseCell(self, "BgPanel/RandomOptionPanel/OptionChooseoPanel", "System/Rogue/OptionChooseCell", 0, 0, true)
		end

		optionChooseCell:setData(choiceData, i)
		optionChooseCell:setSelectCloseFunc(Slot(self.chooseCloseClick, self))

		self.optionChooseCells[i] = optionChooseCell
	end
end

function NewMazeRandomDetailDlg:playShowAni()
	self:playAni("ShowRogueRandomDetailCanvas")
end

function NewMazeRandomDetailDlg:setData(eventId, nodeId)
	self.eventId = eventId
	self.nodeId = nodeId

	self:playAni("OpenRogueRandomDetailCanvas")
	self:refreshUI()
end

function NewMazeRandomDetailDlg:chooseCloseClick(sender)
	if sender.type == 2 then
		if self.newMazeData.subEventData and self.newMazeData.subEventData.spec_id ~= 0 then
			MsgManager.notice(ResNewMazeDisplay[13060043].desc)

			return
		end

		if self.randEventData.event_choices[1].param_type == 4 and sender.choiceData.param and sender.choiceData.param[1] and self.newMazeData.coin < sender.choiceData.param[1] then
			MsgManager.notice(ResNewMazeDisplay[13060014].desc)

			return
		end

		RPC.newMazeRandomEventOptionSelect(self.actObj.opId, sender.index)
		RPC.newMazeLayerNextReq(self.actObj.opId)
		self:setVisible(false)
	else
		if sender.type == 3 then
			local changeDlg = UIManager.getUI("newMazeChangeHeroDlg", true)

			changeDlg:setData(Const.NEW_MAZE_CHANGE_TYPE_MORE_TO_ONE, sender.index)
		elseif sender.type == 4 then
			if CurAvatar.newMazeBattleMultiAward then
				local chooseThreeDlg = UIManager.getUI("newMazeChooseThreeDlg", true)

				chooseThreeDlg:setData(CurAvatar.newMazeBattleMultiAward)

				CurAvatar.newMazeBattleMultiAward = nil
			else
				self:_battleEventFunc(sender.index)
			end
		elseif sender.type == 5 then
			local heroList = self.newMazeData:getThreeLabelHeroList()

			if #heroList == 0 then
				MsgManager.notice(ResNewMazeDisplay[13060044].desc)

				return
			end

			local changeDlg = UIManager.getUI("newMazeChangeHeroDlg", true)

			changeDlg:setData(Const.NEW_MAZE_CHANGE_TYPE_ONE_TO_ONE, sender.index)
		elseif sender.type == 8 then
			if not self.newMazeData.lastEventDataStatus[7] then
				RPC.newMazeRandomEventOptionSelect(self.actObj.opId, sender.index)
			end

			RPC.mysteryShopEnter(Const.MYSTERY_SHOP_SUB_TYPE_NEW_MAZE)
		elseif sender.type == 9 then
			local poolId = sender.choiceData.param[1]

			CurAvatar:onNewMazeCheckPool(self.actObj.opId, sender.index, poolId)

			return
		else
			if sender.type == 1 then
				local cost = sender.choiceData.param[2] or 0

				if cost > self.newMazeData.coin then
					MsgManager.notice(ResNewMazeDisplay[13060014].desc)

					return
				end
			elseif sender.type == 6 and self.newMazeData.redheart <= 1 then
				MsgManager.notice(ResNewMazeDisplay[13060038].desc)

				return
			end

			RPC.newMazeRandomEventOptionSelect(self.actObj.opId, sender.index)
		end

		if self.remainTimes <= 1 then
			self:setVisible(false)
		end
	end

	sender.btnSelf:setEnable(false)
end

function NewMazeRandomDetailDlg:_battleEventFunc(index)
	local hp = self.newMazeData.redheart

	if hp <= 0 then
		MsgManager.notice(ResNewMazeDisplay[13060038].desc)

		return
	end

	if self.newMazeData.subEventData and self.newMazeData.subEventData.spec_id ~= 0 then
		local eventId = self.newMazeData.subEventData.spec_id
		local eventType = self.newMazeData.subEventData.type
		local battleId = ResNewMazeBattle[eventId].battle_id
		local pveId = battleId
		local battleData = {}

		battleData.newMazeData = {}
		battleData.newMazeData.eventType = eventType
		battleData.newMazeData.eventId = eventId
		battleData.newMazeData.fromRandom = 1
		battleData.newMazeData.isRetry = 0
		battleData.newMazeData.actId = self.actObj.actId
		battleData.newMazeData.opId = self.actObj.opId

		CurAvatar:enterFormation(pveId, BattleConst.BATTLE_TYPE_NEW_MAZE, battleData)
	else
		RPC.newMazeRandomEventOptionSelect(self.actObj.opId, index)
	end
end

function NewMazeRandomDetailDlg:onBtnGoldClick()
	local itemId = self.newMazeData.miscData.coin_item_id
	local fakeItem = BaseObject.GetObject(itemId)

	UIManager.getUI("itemTips"):showObj(self, fakeItem)
end

function NewMazeRandomDetailDlg:onBtnBloodClick()
	local itemId = self.newMazeData.miscData.redheart_item_id
	local fakeItem = BaseObject.GetObject(itemId)

	UIManager.getUI("itemTips"):showObj(self, fakeItem)
end

return NewMazeRandomDetailDlg
