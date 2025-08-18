-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\NewMaze\\NewMazeChangeHeroDlg.lua

local NewMazeShopHeroCard = require("UI/NewMaze/NewMazeShopHeroCard")
local ResNewMazeHero = require("ClientData/ResNewMazeHero")
local ResNewMazeRandDevote = require("ClientData/ResNewMazeRandDevote")
local NewMazeLosderMixin = require("UI/NewMaze/NewMazeLosderMixin")
local ResNewMazeDisplay = require("ClientData/ResNewMazeDisplay")
local strClassName = "ChooseHeroCard"
local ChooseHeroCard = Class(strClassName, NewMazeShopHeroCard)

function ChooseHeroCard:ctor()
	self.btnSelf = UIControls.Button(self, "")

	self.btnSelf:addEventClick(self.onBtnSelfClick)

	self.bgSel = UIControls.Panel(self, "BgSel")
	self.emptyRaycast = UIControls.Panel(self, "EmptyRaycast")
end

function ChooseHeroCard:refreshUI()
	self.imgSel:setVisible(utils.tableIsContainsElement(self.mParent.curSelectHeroList, self.heroId))
end

function ChooseHeroCard:showBgSel()
	self.bgSel:setVisible(true)
	self.emptyRaycast:setVisible(true)
end

function ChooseHeroCard:setSelectCallBack(selectFunc)
	self.selectFunc = selectFunc
end

function ChooseHeroCard:onBtnSelfClick()
	if self.selectFunc then
		self.selectFunc(self)
	end
end

local strClassName = "NewMazeChangeHeroDlg"
local NewMazeChangeHeroDlg = Class(strClassName, UIControls.Window)

MixinClass(NewMazeChangeHeroDlg, NewMazeLosderMixin)

function NewMazeChangeHeroDlg:ctor(...)
	self:ctorMixin()
	self:initUI()
end

function NewMazeChangeHeroDlg:initUI()
	self.textTitle = UIControls.Label(self, "MainInfoPanel/BgTextTitle/TextTitle")
	self.btnAbandon = UIControls.Button(self, "MainInfoPanel/StoreInfoPanel/BtnAbandon")

	self.btnAbandon:addEventClick(self.onBtnAbandonClick)

	self.moreToOnePanel = UIControls.Panel(self, "MainInfoPanel/StoreInfoPanel/MoreToOnePanel")
	self.textLabelOdds1 = UIControls.Label(self, "MainInfoPanel/StoreInfoPanel/MoreToOnePanel/TextLabelOdds1")
	self.textLabelOdds2 = UIControls.Label(self, "MainInfoPanel/StoreInfoPanel/MoreToOnePanel/TextLabelOdds2")
	self.textLabelOdds3 = UIControls.Label(self, "MainInfoPanel/StoreInfoPanel/MoreToOnePanel/TextLabelOdds3")
	self.heroCellList = {}
	self.curSelectHeroList = {}
end

function NewMazeChangeHeroDlg:setData(type, index)
	self.type = type
	self.index = index
	self.actObj = CurAvatar:getNewMazeActivity()

	if self.actObj and self.actObj:isValid() then
		self.newMazeData = self.actObj.actData
	else
		return
	end

	if self.type == Const.NEW_MAZE_CHANGE_TYPE_MORE_TO_ONE then
		self.textTitle:setText(ResNewMazeDisplay[13060032].desc)

		self.heros = self.actObj.actData:getSaleHeroListExceptUp()

		for i, heroData in pairs(self.heros or {}) do
			local heroCell = self.heroCellList[i]

			if heroCell == nil then
				heroCell = ChooseHeroCard(self, "MainInfoPanel/ChooseCardPanel/Content", "System/Common/Grid/GridRogueHeroCard", 0, 0, true)
			end

			heroCell:setData(heroData.id, Const.NEW_MAZE_LOSDER_TYPE_REDUCE)
			heroCell:showBgSel()
			heroCell:setSelectCallBack(Slot(self.onSelectMoreClick, self))

			self.heroCellList[i] = heroCell
		end
	elseif self.type == Const.NEW_MAZE_CHANGE_TYPE_ONE_TO_ONE then
		self.textTitle:setText(ResNewMazeDisplay[13060033].desc)

		self.heros = self.actObj.actData:getThreeLabelHeroList()

		for i, heroData in pairs(self.heros or {}) do
			local heroCell = self.heroCellList[i]

			if heroCell == nil then
				heroCell = ChooseHeroCard(self, "MainInfoPanel/ChooseCardPanel/Content", "System/Common/Grid/GridRogueHeroCard", 0, 0, true)
			end

			heroCell:setData(heroData.id, Const.NEW_MAZE_LOSDER_TYPE_REDUCE)
			heroCell:showBgSel()
			heroCell:setSelectCallBack(Slot(self.onSelectOneClick, self))

			self.heroCellList[i] = heroCell
		end
	end

	self:refreshOddsUI()
	self:refreshFettersUI()
end

function NewMazeChangeHeroDlg:refreshOddsUI()
	if self.type == Const.NEW_MAZE_CHANGE_TYPE_MORE_TO_ONE then
		local selectLabelData = {}

		for i, heroId in pairs(self.curSelectHeroList) do
			local heroData = self.actObj.actData:getBagHeroData(heroId)
			local heroLabelNum = 0

			if heroData then
				if heroData.fetter1_id > 0 then
					heroLabelNum = heroLabelNum + 1
				end

				if heroData.fetter2_id > 0 then
					heroLabelNum = heroLabelNum + 1
				end

				if heroData.fetter3_id > 0 then
					heroLabelNum = heroLabelNum + 1
				end
			end

			table.insert(selectLabelData, heroLabelNum)
		end

		table.sort(selectLabelData, function(a, b)
			return a < b
		end)

		local devoteData

		for _, devote in pairs(ResNewMazeRandDevote) do
			if #selectLabelData == #devote.devote_quality then
				table.sort(devote.devote_quality, function(a, b)
					return a < b
				end)

				local isEqual = true

				for i, v in ipairs(selectLabelData) do
					if v ~= devote.devote_quality[i] then
						isEqual = false
					end
				end

				if isEqual then
					devoteData = devote

					break
				end
			end
		end

		if devoteData then
			self.textLabelOdds1:setText(devoteData.label_rate1 .. "%")
			self.textLabelOdds2:setText(devoteData.label_rate2 .. "%")
			self.textLabelOdds3:setText(devoteData.label_rate3 .. "%")
		else
			self.textLabelOdds1:setText("0%")
			self.textLabelOdds2:setText("0%")
			self.textLabelOdds3:setText("0%")
		end
	else
		self.textLabelOdds1:setText("0%")
		self.textLabelOdds2:setText("0%")
		self.textLabelOdds3:setText("100%")
	end
end

function NewMazeChangeHeroDlg:refreshFettersUIByChoose()
	local allFetters = self.newMazeData:getAllFetters()

	for i, heroId in pairs(self.curSelectHeroList) do
		for j, fetterData in pairs(allFetters) do
			local index

			for k, hero in pairs(fetterData.heros) do
				if hero == heroId then
					index = k
				end
			end

			if index then
				table.remove(fetterData.heros, index)

				fetterData.num = fetterData.num - 1
			end

			local indexFormation

			for k, hero in pairs(fetterData.formationHeros) do
				if hero == heroId then
					indexFormation = k
				end
			end

			if indexFormation then
				table.remove(fetterData.formationHeros, indexFormation)

				fetterData.formationNum = fetterData.formationNum - 1
			end
		end
	end

	self:refreshFettersUI(allFetters)
end

function NewMazeChangeHeroDlg:onSelectMoreClick(grid)
	local index

	for i, heroId in pairs(self.curSelectHeroList) do
		if heroId == grid.heroId then
			index = i
		end
	end

	if index then
		table.remove(self.curSelectHeroList, index)
	elseif #self.curSelectHeroList >= 2 then
		MsgManager.notice(ResNewMazeDisplay[13060034].desc)
	else
		table.insert(self.curSelectHeroList, grid.heroId)
	end

	for i, cell in pairs(self.heroCellList) do
		cell:refreshUI()
	end

	self:refreshOddsUI()
end

function NewMazeChangeHeroDlg:onSelectOneClick(grid)
	if self.curSelectHeroList[1] and self.curSelectHeroList[1] == grid.heroId then
		self.curSelectHeroList = {}
	else
		self.curSelectHeroList = {
			grid.heroId
		}
	end

	for i, cell in pairs(self.heroCellList) do
		cell:refreshUI()
	end
end

function NewMazeChangeHeroDlg:onBtnAbandonClick()
	local noticeInfo = ResNewMazeDisplay[13060035].desc

	if #self.curSelectHeroList == 0 then
		MsgManager.notice(noticeInfo)
	else
		local function yesFunc()
			self.actObj.actData.curSelectHeroList = self.curSelectHeroList

			RPC.newMazeRandomEventOptionSelect(self.actObj.opId, self.index, self.curSelectHeroList)
			self:setVisible(false)
		end

		local msgContent = string.format(ResNewMazeDisplay[13060036].desc)

		UIManager.showConfirm(UIConst.CONFIRM_TWOBTN, Lang.get(5), msgContent, yesFunc, nil, -1)
	end
end

return NewMazeChangeHeroDlg
