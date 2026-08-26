-- chunkname: @modules/logic/seasonver/act166/view/Season166BaseSpotView.lua

module("modules.logic.seasonver.act166.view.Season166BaseSpotView", package.seeall)

local Season166BaseSpotView = class("Season166BaseSpotView", BaseView)

function Season166BaseSpotView:onInitView()
	self._simagebg = gohelper.findChildSingleImage(self.viewGO, "#simage_bg")
	self._goscoreInfo = gohelper.findChild(self.viewGO, "left/#go_scoreInfo")
	self._txtscore = gohelper.findChildText(self.viewGO, "left/#go_scoreInfo/#txt_score")
	self._txttitle = gohelper.findChildText(self.viewGO, "right/episodeInfo/#txt_title")
	self._btndetail = gohelper.findChildButtonWithAudio(self.viewGO, "right/episodeInfo/#btn_detail")
	self._txtenemyinfo = gohelper.findChildText(self.viewGO, "right/episodeInfo/enemyInfo/enemyinfo/#txt_enemyinfo")
	self._txtepisodeInfo = gohelper.findChildText(self.viewGO, "right/episodeInfo/#txt_episodeInfo")
	self._gorewardContent = gohelper.findChild(self.viewGO, "right/reward/#go_rewardContent")
	self._gorewardItem = gohelper.findChild(self.viewGO, "right/reward/#go_rewardContent/#go_rewardItem")
	self._btnfight = gohelper.findChildButtonWithAudio(self.viewGO, "right/#btn_fight")
	self._gotopleft = gohelper.findChild(self.viewGO, "#go_topleft")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Season166BaseSpotView:addEvents()
	self._btndetail:AddClickListener(self._btndetailOnClick, self)
	self._btnfight:AddClickListener(self._btnfightOnClick, self)
end

function Season166BaseSpotView:removeEvents()
	self._btndetail:RemoveClickListener()
	self._btnfight:RemoveClickListener()
end

function Season166BaseSpotView:_btndetailOnClick()
	EnemyInfoController.instance:openEnemyInfoViewByBattleId(self.battleId)
end

function Season166BaseSpotView:_btnfightOnClick()
	local param = {}

	param.actId = self.actId
	param.baseId = self.baseId

	Season166BaseSpotController.instance:enterBaseSpotFightScene(param)
end

function Season166BaseSpotView:_editableInitView()
	self.starTab = self:getUserDataTb_()

	for i = 1, 3 do
		local starItem = {}

		starItem.go = gohelper.findChild(self.viewGO, "left/#go_scoreInfo/stars/go_star" .. i)
		starItem.imageStar = gohelper.findChildImage(starItem.go, "#go_Star" .. i)

		table.insert(self.starTab, starItem)
	end
end

function Season166BaseSpotView:onUpdateParam()
	return
end

function Season166BaseSpotView:onOpen()
	self.actId = self.viewParam.actId
	self.config = self.viewParam.config
	self.baseId = self.viewParam.baseId
	self.episodeConfig = DungeonConfig.instance:getEpisodeCO(self.config.episodeId)
	self.battleId = self.episodeConfig.battleId

	local Season166MO = Season166Model.instance:getActInfo(self.actId)
	local baseSpotMO = Season166MO.baseSpotInfoMap[self.baseId]

	if baseSpotMO and not baseSpotMO.isEnter then
		Activity166Rpc.instance:sendAct166EnterBaseRequest(self.actId, self.baseId)
	end

	local scoreConfigList = Season166Config.instance:getSeasonScoreCos(self.actId)

	self.finalLevelScore = scoreConfigList[#scoreConfigList].needScore

	Season166Controller.instance:dispatchEvent(Season166Event.OpenBaseSpotView, {
		isEnter = true,
		baseSpotId = self.baseId
	})
	Season166BaseSpotModel.instance:initBaseSpotData(self.actId, self.baseId)
	self:refreshUI()
end

function Season166BaseSpotView:refreshUI()
	self:refreshReward()
	self:refreshInfo()
	self:refreshScoreInfo()
end

function Season166BaseSpotView:refreshReward()
	local allLevelCoList = Season166Config.instance:getSeasonBaseLevelCos(self.actId, self.baseId)

	gohelper.CreateObjList(self, self.rewardItemShow, allLevelCoList, self._gorewardContent, self._gorewardItem)
end

function Season166BaseSpotView:rewardItemShow(obj, data, index)
	local txtStarCount = gohelper.findChildText(obj, "star/txt_starCount")
	local goItemPos = gohelper.findChild(obj, "go_itempos")
	local goGet = gohelper.findChild(obj, "go_get")
	local scoreConfig = Season166Config.instance:getSeasonScoreCo(self.actId, data.level)
	local starCount = scoreConfig.star

	txtStarCount.text = starCount

	local item = IconMgr.instance:getCommonPropItemIcon(goItemPos)
	local itemCo = string.splitToNumber(data.firstBonus, "#")

	item:setMOValue(itemCo[1], itemCo[2], itemCo[3])
	item:setHideLvAndBreakFlag(true)
	item:hideEquipLvAndBreak(true)
	item:setCountFontSize(51)

	local curGetStarCount = Season166BaseSpotModel.instance:getStarCount(self.actId, self.baseId)

	gohelper.setActive(goGet, starCount <= curGetStarCount)
end

function Season166BaseSpotView:refreshInfo()
	self._txttitle.text = GameUtil.setFirstStrSize(self.config.name, 102)
	self._txtepisodeInfo.text = self.config.desc

	local enemyLevel = self.config.level

	self._txtenemyinfo.text = HeroConfig.instance:getLevelDisplayVariant(enemyLevel)
end

function Season166BaseSpotView:refreshScoreInfo()
	local curMaxScore = Season166BaseSpotModel.instance:getBaseSpotMaxScore(self.actId, self.baseId)

	self._txtscore.text = curMaxScore

	local curGetStarCount = Season166BaseSpotModel.instance:getStarCount(self.actId, self.baseId)
	local allLevelCoList = Season166Config.instance:getSeasonBaseLevelCos(self.actId, self.baseId)

	for index, starItem in ipairs(self.starTab) do
		gohelper.setActive(starItem.go, index <= #allLevelCoList)
		gohelper.setActive(starItem.imageStar.gameObject, index <= curGetStarCount)

		local lightStarUrl = curMaxScore >= self.finalLevelScore and "season166_result_inclinedbulb3" or "season166_result_inclinedbulb2"

		UISpriteSetMgr.instance:setSeason166Sprite(starItem.imageStar, lightStarUrl)
	end
end

function Season166BaseSpotView:onClose()
	Season166Controller.instance:dispatchEvent(Season166Event.CloseBaseSpotView, {
		isEnter = false,
		baseSpotId = self.baseId
	})
end

function Season166BaseSpotView:onDestroyView()
	return
end

return Season166BaseSpotView
