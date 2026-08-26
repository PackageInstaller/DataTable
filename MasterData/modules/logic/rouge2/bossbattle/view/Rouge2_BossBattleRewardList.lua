-- chunkname: @modules/logic/rouge2/bossbattle/view/Rouge2_BossBattleRewardList.lua

module("modules.logic.rouge2.bossbattle.view.Rouge2_BossBattleRewardList", package.seeall)

local Rouge2_BossBattleRewardList = class("Rouge2_BossBattleRewardList", LuaCompBase)

function Rouge2_BossBattleRewardList.Get(go)
	return MonoHelper.addNoUpdateLuaComOnceToGo(go, Rouge2_BossBattleRewardList)
end

Rouge2_BossBattleRewardList.firtRewardProgress = 0.143
Rouge2_BossBattleRewardList.lastRewardProgress = 0.325
Rouge2_BossBattleRewardList.middleRewardProgress = 1 - Rouge2_BossBattleRewardList.firtRewardProgress - Rouge2_BossBattleRewardList.lastRewardProgress

function Rouge2_BossBattleRewardList:init(go)
	self.go = go
	self._txtCurScore = gohelper.findChildText(self.go, "#txt_CurScore")
	self._goRewardList = gohelper.findChild(self.go, "#go_RewardList")
	self._imageAllProgress = gohelper.findChildImage(self.go, "#go_RewardList/#image_AllProgress")
	self._imageCurProgress = gohelper.findChildImage(self.go, "#go_RewardList/#image_AllProgress/#image_CurProgress")
	self._goStageContainer = gohelper.findChild(self.go, "#go_RewardList/#image_AllProgress/#go_StageContainer")
	self._goStageItem = gohelper.findChild(self.go, "#go_RewardList/#image_AllProgress/#go_StageContainer/#go_StageItem")
	self._btnClaim = gohelper.findChildButtonWithAudio(self.go, "#go_RewardList/#btn_Claim")
	self._allProgressWidth = recthelper.getWidth(self._imageAllProgress.transform)
	self._middleProgressWidth = self._allProgressWidth * Rouge2_BossBattleRewardList.middleRewardProgress
	self._firstProgressWidth = self._allProgressWidth * Rouge2_BossBattleRewardList.firtRewardProgress
end

function Rouge2_BossBattleRewardList:addEventListeners()
	self._btnClaim:AddClickListener(self._btnClaimOnClick, self)
end

function Rouge2_BossBattleRewardList:removeEventListeners()
	self._btnClaim:RemoveClickListener()
end

function Rouge2_BossBattleRewardList:_btnClaimOnClick()
	if not self._bossId or self._bossId == 0 then
		return
	end

	Rouge2OutsideRpc.instance:sendRouge2BossRewardRequest(self._bossId)
end

function Rouge2_BossBattleRewardList:onUpdateMO(battleInfo, bossCo)
	self._bossCo = bossCo
	self._bossId = bossCo and bossCo.id
	self._battleInfo = battleInfo
	self._bossInfo = self._battleInfo and self._battleInfo:getBossInfoById(self._bossId)
	self._curScore = self._bossInfo and self._bossInfo:getMaxScore() or 0
	self._minScore, self._maxScore = Rouge2_BossBattleConfig.instance:getBossRewardScoreRange(self._bossId)
	self._scoreRange = self._maxScore - self._minScore
	self._rewardList = Rouge2_BossBattleConfig.instance:getRewardListByBossId(self._bossId)

	if self._rewardList then
		self._rewardNum = #self._rewardList or 0
	end

	self._middlePartWidth = self._middleProgressWidth / (self._rewardNum - 2)
	self._middlePartProgress = Rouge2_BossBattleRewardList.middleRewardProgress / (self._rewardNum - 2)
	self._totalProgress = 0

	self:refreshUI()
end

function Rouge2_BossBattleRewardList:refreshUI()
	if self._bossInfo then
		local hasAnyRewardCanGet = self._bossInfo:hasAnyRewardCanGet()

		gohelper.setActive(self._btnClaim.gameObject, self._bossInfo)
		gohelper.CreateObjList(self, self._refreshStageItem, self._rewardList, self._goStageContainer, self._goStageItem, Rouge2_BossBattleRewardStageItem)

		self._txtCurScore.text = self._curScore
		self._imageCurProgress.fillAmount = self._totalProgress or 0
	end
end

function Rouge2_BossBattleRewardList:_refreshStageItem(rewardItem, stageCo, index)
	local posX = self:_calcStagePos(index)
	local progress = self:_calcStageProgress(stageCo, index)

	self._totalProgress = self._totalProgress + progress

	rewardItem:onUpdateMO(self._battleInfo, self._bossInfo, stageCo, posX, index)
end

function Rouge2_BossBattleRewardList:_calcStagePos(index)
	if index == 1 then
		return self._firstProgressWidth
	elseif index == self._rewardNum then
		return self._allProgressWidth
	else
		return self._firstProgressWidth + (index - 1) * self._middlePartWidth
	end
end

function Rouge2_BossBattleRewardList:_calcStageProgress(stageCo, index)
	local lastSageCo = self._rewardList[index - 1]

	if lastSageCo then
		if not lastSageCo.score then
			local lastScore = 0
			local scoreRange = stageCo.score - lastScore
			local scoreOffset = self._curScore - lastScore

			scoreOffset = scoreOffset > 0 and scoreOffset or 0
			scoreOffset = scoreRange < scoreOffset and scoreRange or scoreOffset

			return scoreOffset / scoreRange * (index == 1 and Rouge2_BossBattleRewardList.firtRewardProgress or index == self._rewardNum and Rouge2_BossBattleRewardList.lastRewardProgress or self._middlePartProgress)
		end
	end
end

function Rouge2_BossBattleRewardList:onDestroy()
	return
end

return Rouge2_BossBattleRewardList
