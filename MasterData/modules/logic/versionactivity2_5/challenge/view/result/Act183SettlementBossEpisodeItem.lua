-- chunkname: @modules/logic/versionactivity2_5/challenge/view/result/Act183SettlementBossEpisodeItem.lua

module("modules.logic.versionactivity2_5.challenge.view.result.Act183SettlementBossEpisodeItem", package.seeall)

local Act183SettlementBossEpisodeItem = class("Act183SettlementBossEpisodeItem", LuaCompBase)
local RoundStageToBgNameMap = {
	"v2a5_challenge_result_roundbg4",
	"v2a5_challenge_result_roundbg3",
	"v2a5_challenge_result_roundbg2",
	"v2a5_challenge_result_roundbg1"
}

function Act183SettlementBossEpisodeItem:init(go)
	self.go = go
	self._txtbossbadge = gohelper.findChildText(go, "root/right/#txt_bossbadge")
	self._simageboss = gohelper.findChildSingleImage(go, "root/right/#simage_boss")
	self._gobossheros = gohelper.findChild(go, "root/right/#go_bossheros")
	self._gostars = gohelper.findChild(go, "root/right/BossStars/#go_Stars")
	self._gostaritem = gohelper.findChild(go, "root/right/BossStars/#go_Stars/#go_Staritem")
	self._txtround = gohelper.findChildText(go, "root/right/totalround/#txt_totalround")
	self._imageroundbg = gohelper.findChildImage(go, "root/right/totalround/#image_roundbg")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Act183SettlementBossEpisodeItem:addEvents()
	return
end

function Act183SettlementBossEpisodeItem:removeEvents()
	return
end

function Act183SettlementBossEpisodeItem:_editableInitView()
	self._herogroupComp = MonoHelper.addNoUpdateLuaComOnceToGo(self._gobossheros, Act183SettlementBossEpisodeHeroComp)
end

function Act183SettlementBossEpisodeItem:setHeroTemplate(templateGo)
	if self._herogroupComp then
		self._herogroupComp:setHeroTemplate(templateGo)
	end
end

function Act183SettlementBossEpisodeItem:onUpdateMO(groupRecordMo, episodeRecordMo)
	if not episodeRecordMo then
		return
	end

	self._bossEpisodeId = episodeRecordMo:getEpisodeId()

	Act183Helper.setBossEpisodeResultIcon(self._bossEpisodeId, self._simageboss)
	self:refreshRound(episodeRecordMo)
	self:refreshUseBadge(episodeRecordMo)
	self:refreshHeroGroup(episodeRecordMo)
	self:refreshEpisodeStars(episodeRecordMo)
end

function Act183SettlementBossEpisodeItem:refreshUseBadge(episodeRecordMo)
	local useBadgeNum = episodeRecordMo:getUseBadgeNum()

	gohelper.setActive(self._txtbossbadge.gameObject, useBadgeNum > 0)

	self._txtbossbadge.text = useBadgeNum
end

function Act183SettlementBossEpisodeItem:refreshEpisodeStars(episodeRecordMo)
	local totalStarCount = episodeRecordMo:getTotalStarCount()
	local finishStarCount = episodeRecordMo:getFinishStarCount()

	for i = 1, totalStarCount do
		local gostar = gohelper.cloneInPlace(self._gostaritem, "star_" .. i)
		local imagestar = gohelper.onceAddComponent(gostar, gohelper.Type_Image)
		local color = i <= finishStarCount and "#F77040" or "#87898C"

		UISpriteSetMgr.instance:setCommonSprite(imagestar, "zhuxianditu_pt_xingxing_001", true)
		SLFramework.UGUI.GuiHelper.SetColor(imagestar, color)
		gohelper.setActive(gostar, true)
	end
end

function Act183SettlementBossEpisodeItem:refreshHeroGroup(episodeRecordMo)
	if self._herogroupComp then
		self._herogroupComp:onUpdateMO(episodeRecordMo)
	end
end

function Act183SettlementBossEpisodeItem:refreshRound(episodeRecordMo)
	local roundNum = episodeRecordMo:getRound()

	self._txtround.text = roundNum

	local stage = Act183Helper.getRoundStage(roundNum)
	local roundBgName = RoundStageToBgNameMap[stage]

	if roundBgName then
		UISpriteSetMgr.instance:setChallengeSprite(self._imageroundbg, roundBgName)
	else
		logError(string.format("缺少回合数挡位 --> 回合数背景图配置 roundNum = %s, stage = %s", roundNum, stage))
	end
end

function Act183SettlementBossEpisodeItem:onDestroy()
	return
end

return Act183SettlementBossEpisodeItem
