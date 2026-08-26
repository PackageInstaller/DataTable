-- chunkname: @modules/logic/autochess/main/view/AutoChessBattleRecordItem.lua

module("modules.logic.autochess.main.view.AutoChessBattleRecordItem", package.seeall)

local AutoChessBattleRecordItem = class("AutoChessBattleRecordItem", ListScrollCellExtend)

function AutoChessBattleRecordItem:onInitView()
	self._goSelfWinFlag = gohelper.findChild(self.viewGO, "#go_playerwin")
	self._goEnemyWinFlag = gohelper.findChild(self.viewGO, "#go_enemywin")
	self._txtSelfName = gohelper.findChildText(self.viewGO, "PlayerGroup/#txt_Name")
	self._txtEnemyName = gohelper.findChildText(self.viewGO, "EnemyGroup/#txt_Name")
	self._txtSelfRank = gohelper.findChildText(self.viewGO, "PlayerGroup/Badge/#txt_badge")
	self._txtEnemyRank = gohelper.findChildText(self.viewGO, "EnemyGroup/Badge/#txt_badge")
	self._goSelfIconRoot = gohelper.findChild(self.viewGO, "PlayerGroup/HeroHeadIcon")
	self._goEnemyIconRoot = gohelper.findChild(self.viewGO, "EnemyGroup/HeroHeadIcon")
	self._selfHeadicon = gohelper.findChildSingleImage(self.viewGO, "PlayerGroup/HeroHeadIcon/#simage_headicon")
	self._enemyHeadicon = gohelper.findChildSingleImage(self.viewGO, "EnemyGroup/HeroHeadIcon/#simage_headicon")
	self._txtSelfAddScore = gohelper.findChildText(self.viewGO, "PlayerGroup/Score/#txt_Add")
	self._txtEnemyAddScore = gohelper.findChildText(self.viewGO, "EnemyGroup/Score/#txt_Add")
	self._txtSelfReduceScore = gohelper.findChildText(self.viewGO, "PlayerGroup/Score/#txt_Reduce")
	self._txtEnemyReduceScore = gohelper.findChildText(self.viewGO, "EnemyGroup/Score/#txt_Reduce")
	self._btnReplay = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_Replay")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function AutoChessBattleRecordItem:addEvents()
	self._btnReplay:AddClickListener(self._onClickBtnReplay, self)
end

function AutoChessBattleRecordItem:removeEvents()
	self._btnReplay:RemoveClickListener()
end

function AutoChessBattleRecordItem:_onClickBtnReplay()
	Activity182Rpc.instance:sendAct182GetFriendFightMessageRequest(self._actId, self.recordData.friendPlayerInfo.userId, self.recordData.uid)
end

function AutoChessBattleRecordItem:_editableInitView()
	self._actId = Activity182Model.instance:getCurActId()
end

function AutoChessBattleRecordItem:onUpdateData(recordData)
	self.recordData = recordData

	local playerInfo = recordData.playerInfo
	local enemyInfo = recordData.friendPlayerInfo
	local playerRank = playerInfo.rank
	local enemyRank = enemyInfo.rank
	local playerScore = tonumber(playerInfo.hurt)
	local enemyScore = tonumber(enemyInfo.hurt)
	local playerIsWin = playerInfo.isWin
	local enemyIsWin = enemyInfo.isWin
	local playerName = playerInfo.name
	local enemyName = enemyInfo.name
	local playerRankCfg = lua_auto_chess_rank.configDict[self._actId][playerRank]
	local enemyRankCfg = lua_auto_chess_rank.configDict[self._actId][enemyRank]

	if playerRankCfg then
		if not playerRankCfg.name then
			local playerRankName = luaLang("autochess_badgeitem_noget")

			if enemyRankCfg then
				if not enemyRankCfg.name then
					local playerIconId = playerInfo.portrait
					local enemyIconId = enemyInfo.portrait

					self._txtSelfRank.text = playerRankName
					self._txtEnemyRank.text = luaLang("autochess_badgeitem_noget")
					self._txtSelfName.text = playerName
					self._txtEnemyName.text = enemyName

					gohelper.setActive(self._goSelfWinFlag, playerIsWin)
					gohelper.setActive(self._goEnemyWinFlag, enemyIsWin)

					self._txtSelfReduceScore.text = "-" .. enemyScore
					self._txtEnemyReduceScore.text = "-" .. playerScore

					gohelper.setActive(self._txtSelfReduceScore.gameObject, true)
					gohelper.setActive(self._txtEnemyReduceScore.gameObject, true)
					gohelper.setActive(self._txtSelfAddScore.gameObject, false)
					gohelper.setActive(self._txtEnemyAddScore.gameObject, false)

					self._selfLiveHeadIcon = self._selfLiveHeadIcon or IconMgr.instance:getCommonLiveHeadIcon(self._selfHeadicon)

					self._selfLiveHeadIcon:setLiveHead(playerIconId)

					self._enemyLiveHeadIcon = self._enemyLiveHeadIcon or IconMgr.instance:getCommonLiveHeadIcon(self._enemyHeadicon)

					self._enemyLiveHeadIcon:setLiveHead(enemyIconId)
				end
			end
		end
	end
end

function AutoChessBattleRecordItem:onDestroyView()
	return
end

return AutoChessBattleRecordItem
