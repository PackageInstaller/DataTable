-- chunkname: @modules/logic/partygame/view/collatingsort/CollatingSortGameView.lua

module("modules.logic.partygame.view.collatingsort.CollatingSortGameView", package.seeall)

local CollatingSortGameView = class("CollatingSortGameView", PartyGameCommonView)

function CollatingSortGameView:onInitView()
	CollatingSortGameView.super.onInitView(self)

	self._goJoystick = gohelper.findChild(self.viewGO, "#go_Joystick")
	self._golefttop = gohelper.findChild(self.viewGO, "#go_lefttop")
	self._gorighttop = gohelper.findChild(self.viewGO, "#go_righttop")
	self._golevellist = gohelper.findChild(self.viewGO, "#go_levellist")
	self._goright = gohelper.findChild(self.viewGO, "#go_right")
	self._goleft = gohelper.findChild(self.viewGO, "#go_left")

	if self._editableInitView then
		self:_editableInitView()
	end
end

CollatingSortGameView.MaxPlayer = 4
CollatingSortGameView.MinPlayer = 2

local CollatingSortGameInterface = PartyGame.Runtime.Games.CollatingSort.CollatingSortGameInterface

function CollatingSortGameView:_rightClickDown()
	PartyGameEnum.CommandUtil.CreateButtonCommand(PartyGameEnum.VirtualButtonId.button8, 1)
end

function CollatingSortGameView:_rightClickUp()
	PartyGameEnum.CommandUtil.CreateButtonCommand(PartyGameEnum.VirtualButtonId.button8, 2)
end

function CollatingSortGameView:_leftClickDown()
	PartyGameEnum.CommandUtil.CreateButtonCommand(PartyGameEnum.VirtualButtonId.button7, 1)
end

function CollatingSortGameView:_leftClickUp()
	PartyGameEnum.CommandUtil.CreateButtonCommand(PartyGameEnum.VirtualButtonId.button7, 2)
end

function CollatingSortGameView:_editableInitView()
	CollatingSortGameInterface.AddNewBallCallback(self.onNewBall, self)
	CollatingSortGameInterface.AddCollectBallCallback(self.onCollectBall, self)

	self._rightClick = SLFramework.UGUI.UIClickListener.Get(self._goright)

	self._rightClick:AddClickDownListener(self._rightClickDown, self)
	self._rightClick:AddClickUpListener(self._rightClickUp, self)

	self._rightClick.canMultTouch = true
	self._leftClick = SLFramework.UGUI.UIClickListener.Get(self._goleft)

	self._leftClick:AddClickDownListener(self._leftClickDown, self)
	self._leftClick:AddClickUpListener(self._leftClickUp, self)

	self._leftClick.canMultTouch = true
	self._animator = self.viewGO:GetComponent("Animator")
end

function CollatingSortGameView:_frameHandler()
	if self._isLeftDown and not self._isRightDown then
		CollatingSortGameInterface.ChangeBoardRotation(1)
	end

	if not self._isLeftDown and self._isRightDown then
		CollatingSortGameInterface.ChangeBoardRotation(2)
	end
end

function CollatingSortGameView:onNewBall(levelIndex, index, go, dropType, initPosX, initPosY)
	local uid = self._uidList[levelIndex + 1]
	local item = self._uidToItem[uid]

	if item then
		item:onNewBall(index, go, dropType, initPosX, initPosY)
	end
end

function CollatingSortGameView:onCollectBall(levelIndex, ballIndex, posIndex, score)
	local uid = self._uidList[levelIndex + 1]
	local item = self._uidToItem[uid]

	if item then
		item:onCollectBall(ballIndex, posIndex, score)
	else
		logError(string.format("onCollectBall levelIndex:%d, ballIndex:%d, posIndex:%d,score:%s item is nil", levelIndex, ballIndex, posIndex, score))
	end
end

function CollatingSortGameView:_initPlayerList()
	local list = PartyGameModel.instance:getCurGamePlayerList()
	local playerList = {}

	tabletool.addValues(playerList, list)

	local num = #playerList

	if num ~= CollatingSortGameView.MaxPlayer and num ~= CollatingSortGameView.MinPlayer then
		logError("CollatingSortGameView---1 playerList count is not right num:", num)
	end

	local mainPlayer

	for i, v in ipairs(playerList) do
		if PartyGameModel.instance:IsMainUid(v.uid) then
			mainPlayer = v

			table.remove(playerList, i)

			break
		end
	end

	if not mainPlayer then
		logError("CollatingSortGameView mainPlayer is nil")
	end

	if #playerList > CollatingSortGameView.MaxPlayer then
		for i = #playerList, CollatingSortGameView.MaxPlayer + 1, -1 do
			table.remove(playerList, i)
		end
	end

	if #playerList == CollatingSortGameView.MinPlayer then
		self._mainPlayerIndex = 1

		table.insert(playerList, self._mainPlayerIndex, mainPlayer)
		self._animator:Play("open2", 0, 0)
	else
		self._mainPlayerIndex = 2

		table.insert(playerList, self._mainPlayerIndex, mainPlayer)
		self._animator:Play("open1", 0, 0)
	end

	self._playerList = playerList
	self._playerNum = #self._playerList
	num = #playerList

	if #playerList ~= CollatingSortGameView.MaxPlayer and num ~= CollatingSortGameView.MinPlayer then
		logError("CollatingSortGameView---2 playerList count is not right num:", num)
	end
end

function CollatingSortGameView:onOpen()
	self:_initPlayerList()
	self:_initLevelList()
	CollatingSortGameView.super.onOpen(self)
end

function CollatingSortGameView:onCreateCompParam()
	self.partyGameCountDownData = {
		getCountDownFunc = self._getCountDownFunc,
		context = self
	}
end

function CollatingSortGameView:_getCountDownFunc()
	return CollatingSortGameInterface.GetGameCountDownTime()
end

function CollatingSortGameView:_initLevelList()
	local dropType1, dropType2 = CollatingSortGameInterface.GetDropTypes(nil, nil)

	self._levelList = self:getUserDataTb_()
	self._uidToItem = self:getUserDataTb_()

	for i = 1, self._playerNum do
		local itemRes = self.viewContainer:getSetting().otherRes.collatingsort_gamelevelitem
		local go = self.viewContainer:getResInst(itemRes, self._golevellist)

		transformhelper.setLocalPos(go.transform, 0, 0, 0)

		local item = MonoHelper.addNoUpdateLuaComOnceToGo(go, CollatingSortGameLevelItem)

		item.viewContainer = self.viewContainer
		self._levelList[i] = item

		local player = self._playerList[i]

		item:onUpdateMO(player, i, dropType1, dropType2)

		self._uidToItem[player.uid] = item

		if i == self._mainPlayerIndex then
			self._mainPlayerLevelItem = item

			item:showFrame(self._playerNum)
		elseif self._playerNum == CollatingSortGameView.MinPlayer then
			recthelper.setWidth(go.transform, 960)
		end
	end

	ZProj.UGUIHelper.RebuildLayout(self._golevellist.transform)

	self._uidList = {}

	local list = PartyGameModel.instance:getCurGamePlayerList()

	for i, v in ipairs(list) do
		self._uidList[i] = v.uid
	end

	TaskDispatcher.runDelay(self._initOffsetPos, self, 1.3)
end

function CollatingSortGameView:_initOffsetPos()
	for i, item in ipairs(self._levelList) do
		CollatingSortGameInterface.SetEntryGO(item:getEntryGo(), item:getUid())
		CollatingSortGameInterface.SetBoard(item:getBoardGo(), item:getUid())
		CollatingSortGameInterface.SetBox(item:getBoxGo(), item:getUid())
	end

	local entryPosX, entryPosY, entryPosZ = CollatingSortGameInterface.GetFirstEntryPos(nil, nil, nil)

	for i, item in ipairs(self._levelList) do
		local currentEntryGo = item:getEntryGo()
		local currentPosX, currentPosY, currentPosZ = transformhelper.getPos(currentEntryGo.transform)

		item:setOffsetPos(currentPosX - entryPosX, currentPosY - entryPosY, currentPosZ - entryPosZ)
	end
end

function CollatingSortGameView:onViewUpdate()
	if not self._levelList then
		return
	end

	for i, item in ipairs(self._levelList) do
		item:viewDataUpdate()
	end
end

function CollatingSortGameView:onClose()
	CollatingSortGameView.super.onClose(self)
	CollatingSortGameInterface.ClearNewBallCallback()
	CollatingSortGameInterface.ClearCollectBallCallback()
	self._rightClick:RemoveClickDownListener()
	self._rightClick:RemoveClickUpListener()
	self._leftClick:RemoveClickDownListener()
	self._leftClick:RemoveClickUpListener()
	TaskDispatcher.cancelTask(self._initOffsetPos, self)
end

function CollatingSortGameView:onDestroyView()
	CollatingSortGameView.super.onDestroyView(self)
end

return CollatingSortGameView
