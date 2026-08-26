-- chunkname: @modules/logic/partygame/view/carddrop/vsview/CardDropVSView.lua

module("modules.logic.partygame.view.carddrop.vsview.CardDropVSView", package.seeall)

local CardDropVSView = class("CardDropVSView", BaseView)

CardDropVSView.OpenType = {
	ShowAll = 1,
	ShowAllResult = 4,
	ShowMyAndEnemy = 2,
	ShowMyAndEnemyResult = 3
}

function CardDropVSView.blockEsc()
	return
end

function CardDropVSView:onInitView()
	self.goLayout2 = gohelper.findChild(self.viewGO, "root/#layout2")
	self.goLayout4 = gohelper.findChild(self.viewGO, "root/#layout4")
	self.goVsLayout = gohelper.findChild(self.viewGO, "root/#vsLayout")
	self.goBattleItem = gohelper.findChild(self.viewGO, "root/#go_listitem")

	gohelper.setActive(self.goBattleItem, false)

	self.goLine2 = gohelper.findChild(self.viewGO, "root/#layout2/#go_line2role")
	self.goLine4 = gohelper.findChild(self.viewGO, "root/#layout4/#go_line4role")
	self.goVsLayoutPlayer1 = gohelper.findChild(self.viewGO, "root/#vsLayout/#player1")
	self.goVsLayoutPlayer2 = gohelper.findChild(self.viewGO, "root/#vsLayout/#player2")
	self.goNormalVs = gohelper.findChild(self.viewGO, "root/#vsLayout/#go_normalvs")
	self.goEndVs = gohelper.findChild(self.viewGO, "root/#vsLayout/#go_endvs")
	self.txtTitle = gohelper.findChildText(self.viewGO, "root/titlebg/#txt_title")
	self.goWaitTip = gohelper.findChild(self.viewGO, "root/txt_tips")

	gohelper.setActive(self.goWaitTip, false)

	local viewSetting = self.viewContainer:getSetting()
	local res = viewSetting.otherRes.common_playeritem

	self.playerItemPrefab = self.viewContainer:getRes(res)
	self.battleItemList = {}
	self.interface = PartyGameCSDefine.CardDropInterfaceCs

	NavigateMgr.instance:addEscape(self.viewName, self.blockEsc)
end

function CardDropVSView:onUpdateParam()
	self:refreshUI()
end

function CardDropVSView:onOpen()
	self:refreshUI()
	self:setTitleText()
end

function CardDropVSView:setTitleText()
	local playerList = PartyGameModel.instance:getCurGamePlayerList()
	local time = 1
	local len = #playerList

	time = len == 8 and 1 or len == 4 and 2 or 3
	self.txtTitle.text = CardDropGameController.instance:getTitleText()
end

function CardDropVSView:refreshUI()
	local openType = self.viewParam.openType

	if openType == CardDropVSView.OpenType.ShowAll then
		self:refreshAllInfo()
	elseif openType == CardDropVSView.OpenType.ShowMyAndEnemy then
		self:refreshMyAndEnemyInfo()
	elseif openType == CardDropVSView.OpenType.ShowMyAndEnemyResult then
		self:refreshShowMyAndEnemyResultInfo()
	elseif openType == CardDropVSView.OpenType.ShowAllResult then
		self:refreshShowAllResultInfo()
	end
end

function CardDropVSView:refreshPlayerItem(playerItem, playMo, win)
	playerItem:setNameTextByPlayerMo(playMo)

	local isMain = playMo:isMainPlayer()

	playerItem:setArrowActive(isMain)
	playerItem:setLightByWin(win, isMain)
	playerItem:playAnimByWin(win)
end

function CardDropVSView:refreshShowMyAndEnemyResultInfo()
	self:destroyBattleItemList()
	gohelper.setActive(self.goLayout2, false)
	gohelper.setActive(self.goLayout4, true)
	gohelper.setActive(self.goLine2, false)
	gohelper.setActive(self.goLine4, false)
	gohelper.setActive(self.goVsLayout, false)
	gohelper.setActive(self.goWaitTip, true)

	local myUid = self.interface.GetMyPlayerUid()
	local enemyUid = self.interface.GetEnemyPlayerUid()
	local myPlayerMo = PartyGameModel.instance:getPlayerMoByUid(myUid)
	local enemyPlayerMo = PartyGameModel.instance:getPlayerMoByUid(enemyUid)
	local battleItem = self:createBattleItem(self.goLayout4)

	gohelper.setActive(battleItem.go, true)

	battleItem.player1Mo = myPlayerMo
	battleItem.player2Mo = enemyPlayerMo

	if battleItem.player1Mo then
		battleItem.player1Comp = MonoHelper.addNoUpdateLuaComOnceToGo(battleItem.goPlayer1Parent, CommonPartyGamePlayerSpineComp)

		battleItem.player1Comp:initSpine(battleItem.player1Mo.uid)

		local win = self.interface.GetPlayerGameResult(battleItem.player1Mo.uid)

		self:refreshPlayerItem(battleItem.goPlayerItem1, battleItem.player1Mo, win)
		battleItem.player1Comp:setGray(not win)
	end

	if battleItem.player2Mo then
		battleItem.player2Comp = MonoHelper.addNoUpdateLuaComOnceToGo(battleItem.goPlayer2Parent, CommonPartyGamePlayerSpineComp)

		battleItem.player2Comp:initSpine(battleItem.player2Mo.uid)

		local win = self.interface.GetPlayerGameResult(battleItem.player2Mo.uid)

		self:refreshPlayerItem(battleItem.goPlayerItem2, battleItem.player2Mo, win)
		battleItem.player2Comp:setGray(not win)
	end
end

function CardDropVSView:refreshShowAllResultInfo()
	self:destroyBattleItemList()
	gohelper.setActive(self.goVsLayout, false)
	gohelper.setActive(self.goLine2, true)
	gohelper.setActive(self.goLine4, true)
	gohelper.setActive(self.goWaitTip, false)

	local playerList = PartyGameModel.instance:getCurGamePlayerList()
	local teamCount = #playerList / 2

	if teamCount < 2 then
		gohelper.setActive(self.goLayout2, false)
		gohelper.setActive(self.goLayout4, false)

		return
	end

	AudioMgr.instance:trigger(340135)
	gohelper.setActive(self.goLayout2, teamCount == 2)
	gohelper.setActive(self.goLayout4, teamCount == 4)

	if teamCount == 4 then
		if not self.goLayout4 then
			local parentRoot = self.goLayout2
			local resultData = self.viewParam.data
			local scoreList = resultData.ScoreList
			local battleDict = self:getBattleDict(playerList)

			for _, playMoList in pairs(battleDict) do
				local my, enemy = playMoList[1], playMoList[2]
				local battleItem = self:createBattleItem(parentRoot)

				gohelper.setActive(battleItem.go, true)

				battleItem.player1Mo = my
				battleItem.player2Mo = enemy

				if battleItem.player1Mo then
					battleItem.player1Comp = MonoHelper.addNoUpdateLuaComOnceToGo(battleItem.goPlayer1Parent, CommonPartyGamePlayerSpineComp)

					battleItem.player1Comp:initSpine(battleItem.player1Mo.uid)

					local win = self:getWinOrDefeatByScoreList(battleItem.player1Mo.index, scoreList)

					self:refreshPlayerItem(battleItem.goPlayerItem1, battleItem.player1Mo, win)
					battleItem.player1Comp:setGray(not win)
				end

				if battleItem.player2Mo then
					battleItem.player2Comp = MonoHelper.addNoUpdateLuaComOnceToGo(battleItem.goPlayer2Parent, CommonPartyGamePlayerSpineComp)

					battleItem.player2Comp:initSpine(battleItem.player2Mo.uid)

					local win = self:getWinOrDefeatByScoreList(battleItem.player2Mo.index, scoreList)

					self:refreshPlayerItem(battleItem.goPlayerItem2, battleItem.player2Mo, win)
					battleItem.player2Comp:setGray(not win)
				end
			end
		end
	end
end

function CardDropVSView:getWinOrDefeatByScoreList(index, scoreList)
	for i = 0, scoreList.Count - 1 do
		local scoreMo = scoreList[i]
		local scoreIndex = self.interface.GetScoreMoValue(scoreMo, "index")

		if tonumber(scoreIndex) == index then
			local rank = self.interface.GetScoreMoValue(scoreMo, "rank")

			return tonumber(rank) == 1
		end
	end
end

function CardDropVSView:refreshAllInfo()
	self:destroyBattleItemList()
	gohelper.setActive(self.goVsLayout, false)
	gohelper.setActive(self.goLine2, true)
	gohelper.setActive(self.goLine4, true)
	gohelper.setActive(self.goWaitTip, false)

	local playerList = PartyGameModel.instance:getCurGamePlayerList()
	local teamCount = #playerList / 2

	if teamCount < 2 then
		gohelper.setActive(self.goLayout2, false)
		gohelper.setActive(self.goLayout4, false)

		return
	end

	AudioMgr.instance:trigger(340126)
	gohelper.setActive(self.goLayout2, teamCount == 2)
	gohelper.setActive(self.goLayout4, teamCount == 4)

	if teamCount == 4 then
		if not self.goLayout4 then
			local parentRoot = self.goLayout2
			local battleDict = self:getBattleDict(playerList)

			for _, playMoList in pairs(battleDict) do
				local my, enemy = playMoList[1], playMoList[2]
				local battleItem = self:createBattleItem(parentRoot)

				gohelper.setActive(battleItem.go, true)

				battleItem.player1Mo = my
				battleItem.player2Mo = enemy

				if battleItem.player1Mo then
					battleItem.player1Comp = MonoHelper.addNoUpdateLuaComOnceToGo(battleItem.goPlayer1Parent, CommonPartyGamePlayerSpineComp)

					battleItem.player1Comp:initSpine(battleItem.player1Mo.uid)
					battleItem.goPlayerItem1:setNameTextByPlayerMo(battleItem.player1Mo)
					battleItem.goPlayerItem1:setNameActive(true)

					local isMain = PartyGameModel.instance:IsMainUid(battleItem.player1Mo.uid)

					battleItem.goPlayerItem1:setArrowActive(isMain)
				end

				if battleItem.player2Mo then
					battleItem.player2Comp = MonoHelper.addNoUpdateLuaComOnceToGo(battleItem.goPlayer2Parent, CommonPartyGamePlayerSpineComp)

					battleItem.player2Comp:initSpine(battleItem.player2Mo.uid)
					battleItem.goPlayerItem2:setNameTextByPlayerMo(battleItem.player2Mo)
					battleItem.goPlayerItem2:setNameActive(true)

					local isMain = PartyGameModel.instance:IsMainUid(battleItem.player2Mo.uid)

					battleItem.goPlayerItem2:setArrowActive(isMain)
				end
			end
		end
	end
end

function CardDropVSView:getBattleDict(playerList)
	local battleDict = {}

	for _, playerInfo in ipairs(playerList) do
		local teamType = playerInfo.tempType
		local playerMoList = battleDict[teamType]

		if not playerMoList then
			playerMoList = {}
			battleDict[teamType] = playerMoList
		end

		table.insert(playerMoList, playerInfo)
	end

	return battleDict
end

function CardDropVSView:createBattleItem(parent)
	local battleItem = self:getUserDataTb_()

	battleItem.go = gohelper.clone(self.goBattleItem, parent)
	battleItem.goPlayer1 = gohelper.findChild(battleItem.go, "#player1")
	battleItem.goPlayerItem1 = self:createPlayerItem(battleItem.goPlayer1)
	battleItem.goPlayer1Parent = battleItem.goPlayerItem1.goImagePaint
	battleItem.goPlayer2 = gohelper.findChild(battleItem.go, "#player2")
	battleItem.goPlayerItem2 = self:createPlayerItem(battleItem.goPlayer2)
	battleItem.goPlayer2Parent = battleItem.goPlayerItem2.goImagePaint

	table.insert(self.battleItemList, battleItem)

	return battleItem
end

function CardDropVSView:createPlayerItem(go)
	local instanceGo = gohelper.clone(self.playerItemPrefab, go)
	local playerItem = CardDropCommonPlayerItem.Create(instanceGo)

	playerItem:setImagePaintActive(true)

	return playerItem
end

function CardDropVSView:refreshMyAndEnemyInfo()
	gohelper.setActive(self.goLayout2, false)
	gohelper.setActive(self.goLayout4, false)
	gohelper.setActive(self.goVsLayout, true)
	gohelper.setActive(self.goWaitTip, false)
	AudioMgr.instance:trigger(340127)

	local mainPlayerMo = PartyGameModel.instance:getMainPlayerMo()
	local allPlayerMoList = PartyGameModel.instance:getCurGamePlayerList()
	local isLast = #allPlayerMoList == 2

	gohelper.setActive(self.goNormalVs, not isLast)
	gohelper.setActive(self.goEndVs, isLast)

	local team = mainPlayerMo.tempType
	local uid = tostring(mainPlayerMo.uid)
	local enemyMo

	for _, playerMo in ipairs(allPlayerMoList) do
		if playerMo.tempType == team and tostring(playerMo.uid) ~= uid then
			enemyMo = playerMo

			break
		end
	end

	local playerItemComp = self:createPlayerItem(self.goVsLayoutPlayer2)

	playerItemComp:setNameActive(true)
	playerItemComp:setNameTextByPlayerMo(mainPlayerMo)
	playerItemComp:setArrowActive(true)
	playerItemComp:setImageSelfLightActive(false)
	playerItemComp:setImageLightActive(false)

	local myPlayerComp = MonoHelper.addNoUpdateLuaComOnceToGo(playerItemComp.goImagePaint, CommonPartyGamePlayerSpineComp)

	myPlayerComp:initSpine(mainPlayerMo.uid)

	playerItemComp = self:createPlayerItem(self.goVsLayoutPlayer1)

	playerItemComp:setNameActive(true)
	playerItemComp:setNameTextByPlayerMo(enemyMo)
	playerItemComp:setArrowActive(false)
	playerItemComp:setImageSelfLightActive(false)
	playerItemComp:setImageLightActive(false)

	local enemyPlayerComp = MonoHelper.addNoUpdateLuaComOnceToGo(playerItemComp.goImagePaint, CommonPartyGamePlayerSpineComp)

	enemyPlayerComp:initSpine(enemyMo.uid)

	local tr = playerItemComp.goImagePaint.transform
	local scaleX, scaleY, scaleZ = transformhelper.getLocalScale(tr)

	transformhelper.setLocalScale(tr, -scaleX, scaleY, scaleZ)
end

function CardDropVSView:destroyBattleItemList()
	if not self.battleItemList then
		return
	end

	for _, battleItem in ipairs(self.battleItemList) do
		gohelper.destroy(battleItem.go)
	end

	tabletool.clear(self.battleItemList)
end

return CardDropVSView
