-- chunkname: @modules/logic/fight/view/FightSeasonSubHeroList.lua

module("modules.logic.fight.view.FightSeasonSubHeroList", package.seeall)

local FightSeasonSubHeroList = class("FightSeasonSubHeroList", FightBaseView)

function FightSeasonSubHeroList:onInitView()
	self._scoreText = gohelper.findChildText(self.viewGO, "Score/#txt_num")
	self._scoreText1 = gohelper.findChildText(self.viewGO, "Score/#txt_num1")
	self._ani = SLFramework.AnimatorPlayer.Get(gohelper.findChild(self.viewGO, "Score"))
	self._goScore = gohelper.findChild(self.viewGO, "Score")
	self._scoreImg = gohelper.findChildImage(self.viewGO, "Score/#image_ScoreBG")
	self._itemRoot = gohelper.findChild(self.viewGO, "List")
	self._goItem = gohelper.findChild(self.viewGO, "List/#go_Item")
	self._itemClassList = {}
end

function FightSeasonSubHeroList:addEvents()
	self:com_registFightEvent(FightEvent.ChangeWaveEnd, self._onChangeWaveEnd)
	self:com_registFightEvent(FightEvent.OnIndicatorChange, self._onIndicatorChange)
	self:com_registFightEvent(FightEvent.StageChanged, self._onStageChanged)
	self:com_registEvent(ViewMgr.instance, ViewEvent.OnOpenView, self.onOpenView)
	self:com_registEvent(ViewMgr.instance, ViewEvent.OnCloseView, self.onCloseView)
end

function FightSeasonSubHeroList:removeEvents()
	return
end

function FightSeasonSubHeroList:_onStageChanged(curStage, lastStage)
	gohelper.setActive(self._itemRoot, curStage ~= FightStageMgr.StageType.Play)
end

function FightSeasonSubHeroList:_enterOperate()
	self.PARENT_VIEW:_enterOperate()
end

function FightSeasonSubHeroList:_exitOperate(changed)
	if self._selectItem then
		self._selectItem:playAni("select_out", true)

		self._selectItem = nil
	end

	if not changed then
		self:_refreshSubSpine()
	end
end

function FightSeasonSubHeroList.sortScoreConfig(item1, item2)
	return item1.level < item2.level
end

function FightSeasonSubHeroList:onOpen()
	local activeId = Season166Model.instance:getCurSeasonId()
	local configs = lua_activity166_score.configDict[activeId]

	self._scoreConfigList = {}

	for i, v in ipairs(configs) do
		table.insert(self._scoreConfigList, v)
	end

	table.sort(self._scoreConfigList, FightSeasonSubHeroList.sortScoreConfig)

	self._index2ImageName = {
		"season_scorebg_01",
		"season_scorebg_02",
		"season_scorebg_03",
		"season_scorebg_04"
	}

	self:_refreshHeroList()

	self._score = FightDataHelper.fieldMgr:getIndicatorNum(FightEnum.IndicatorId.NewSeasonScore)

	self:_refreshScore()
end

function FightSeasonSubHeroList:_refreshHeroList()
	local subList = FightDataHelper.entityMgr:getMySubList()

	table.sort(subList, FightEntityDataHelper.sortSubEntityList)
	gohelper.CreateObjList(self, self._onItemShow, subList, self._itemRoot, self._goItem)
end

function FightSeasonSubHeroList:_onItemShow(obj, data, index)
	local itemclass = self._itemClassList[index]

	if not itemclass then
		itemclass = self:com_openSubView(FightSeasonSubHeroItem, obj)
		self._itemClassList[index] = itemclass
	end

	itemclass:refreshData(data.id)
	itemclass:playAni("normal_in", true)
end

function FightSeasonSubHeroList:selectItem(item)
	for i, v in ipairs(self._itemClassList) do
		if v.viewGO.activeInHierarchy and self:selecting(v) then
			v:playAni("select_out", true)
		end
	end

	item:playAni("select_in", true)

	self._selectItem = item

	self.PARENT_VIEW:selectItem(item)
	self:_refreshSubSpine(item._entityId)
end

function FightSeasonSubHeroList:_refreshSubSpine(selectId)
	local showId = selectId

	if not showId then
		local subList = FightDataHelper.entityMgr:getMySubList()

		table.sort(subList, FightEntityDataHelper.sortSubEntityList)

		local nextSubEntityMO = subList[1]

		showId = nextSubEntityMO and nextSubEntityMO.id
	end

	if showId then
		local entityMO = FightDataHelper.entityMgr:getById(showId)

		if entityMO then
			local subEntity = FightHelper.getSubEntity(FightEnum.EntitySide.MySide)

			if subEntity then
				if subEntity.id ~= showId then
					FightGameMgr.entityMgr:delEntity(subEntity.id)
					FightGameMgr.entityMgr:newEntity(entityMO)
				end
			else
				FightGameMgr.entityMgr:newEntity(entityMO)
			end
		end
	end
end

function FightSeasonSubHeroList:selecting(item)
	return self._selectItem == item
end

function FightSeasonSubHeroList:_onIndicatorChange(id)
	if id == FightEnum.IndicatorId.NewSeasonScoreOffset then
		self._score = self._score + FightDataHelper.fieldMgr:getIndicatorNum(FightEnum.IndicatorId.NewSeasonScoreOffset)

		self:_refreshScore()
		self._ani:Play("up", nil, nil)
	end
end

function FightSeasonSubHeroList:_refreshScore()
	gohelper.setActive(self._goScore, Season166Model.instance:checkIsBaseSpotEpisode())

	self._scoreText.text = self._score
	self._scoreText1.text = self._score

	local index = 1

	for i = #self._scoreConfigList, 1, -1 do
		if self._score >= self._scoreConfigList[i].needScore then
			index = i

			break
		end
	end

	if index == self._lastIndex then
		return
	end

	self._lastIndex = index

	UISpriteSetMgr.instance:setFightSprite(self._scoreImg, self._index2ImageName[index])
end

function FightSeasonSubHeroList:onOpenView(viewName)
	if viewName == ViewName.FightEnemyActionView then
		gohelper.setActive(self._goScore, false)
	end
end

function FightSeasonSubHeroList:onCloseView(viewName)
	if viewName == ViewName.FightEnemyActionView then
		gohelper.setActive(self._goScore, Season166Model.instance:checkIsBaseSpotEpisode())
	end
end

function FightSeasonSubHeroList:_onChangeWaveEnd()
	self:onOpen()
end

function FightSeasonSubHeroList:onClose()
	return
end

function FightSeasonSubHeroList:onDestroyView()
	return
end

return FightSeasonSubHeroList
