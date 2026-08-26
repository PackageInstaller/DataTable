-- chunkname: @modules/logic/rouge/map/view/map/RougeMapEliteFightView.lua

module("modules.logic.rouge.map.view.map.RougeMapEliteFightView", package.seeall)

local RougeMapEliteFightView = class("RougeMapEliteFightView", BaseView)

function RougeMapEliteFightView:onInitView()
	self._goboss = gohelper.findChild(self.viewGO, "#go_boss")
	self._txtbossdesc = gohelper.findChildText(self.viewGO, "#go_boss/#txt_bossdec")
	self._imageBossHead = gohelper.findChildImage(self.viewGO, "#go_boss/#image_bosshead")
	self._imagecareer = gohelper.findChildImage(self.viewGO, "#go_boss/career")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function RougeMapEliteFightView:addEvents()
	return
end

function RougeMapEliteFightView:removeEvents()
	return
end

function RougeMapEliteFightView:_editableInitView()
	self.addEventCb(self, RougeMapController.instance, RougeMapEvent.onChangeMapInfo, self.refreshBoss, self)
	self.addEventCb(self, RougeMapController.instance, RougeMapEvent.onUpdateMapInfo, self.refreshBoss, self)
end

function RougeMapEliteFightView:onOpen()
	self:refreshBoss()
end

function RougeMapEliteFightView:refreshBoss()
	if not RougeMapModel.instance:isNormalLayer() then
		gohelper.setActive(self._goboss, false)

		self.eventId = nil

		return
	end

	if not RougeMapEffectHelper.checkHadEffect(RougeMapEnum.EffectType.UnlockShowPassFightMask, RougeMapEnum.EventType.EliteFight) then
		gohelper.setActive(self._goboss, false)

		self.eventId = nil

		return
	end

	local eventId = self:getShowBossEventId()

	if not eventId then
		gohelper.setActive(self._goboss, false)

		self.eventId = nil

		return
	end

	if not RougeOutsideModel.instance:passedEventId(eventId) then
		gohelper.setActive(self._goboss, false)

		self.eventId = nil

		return
	end

	if eventId == self.eventId then
		return
	end

	gohelper.setActive(self._goboss, true)

	self.eventId = eventId

	self:refreshUI()
end

function RougeMapEliteFightView:checkUnlockTalent()
	local talentId = RougeMapConfig.instance:getShowFightMonsterMaskTalentId(RougeMapEnum.EventType.EliteFight)

	return talentId and RougeTalentModel.instance:checkNodeLight(talentId)
end

function RougeMapEliteFightView:getShowBossEventId()
	local nodeMoDict = RougeMapModel.instance:getNodeDict()

	for _, nodeMo in pairs(nodeMoDict) do
		local eventCo = nodeMo:getEventCo()

		if eventCo and eventCo.type == RougeMapEnum.EventType.EliteFight then
			return eventCo.id
		end
	end
end

function RougeMapEliteFightView:refreshUI()
	local fightEventCo = RougeMapConfig.instance:getFightEvent(self.eventId)

	if not fightEventCo then
		return
	end

	local career = self:getBossCareer(fightEventCo)

	UISpriteSetMgr.instance:setRougeSprite(self._imagecareer, "rouge_map_career_" .. career)

	self._txtbossdesc.text = fightEventCo.bossDesc

	local bossMask = fightEventCo.bossMask

	if string.nilorempty(bossMask) then
		logError(string.format("战斗事件表id ： %s， 没有配置Boss剪影", self.eventId))

		return
	end

	UISpriteSetMgr.instance:setRouge3Sprite(self._imageBossHead, bossMask)
end

function RougeMapEliteFightView:getBossCareer(fightEventCo)
	local episodeCo = DungeonConfig.instance:getEpisodeCO(fightEventCo.episodeId)
	local battleCo = lua_battle.configDict[episodeCo.battleId]

	if not battleCo then
		logError("not found battle co, battle id : " .. tostring(episodeCo.battleId))

		return 1
	end

	local monsterGroupIdList = string.splitToNumber(battleCo.monsterGroupIds, "#")

	for _, groupId in ipairs(monsterGroupIdList) do
		local groupCo = lua_monster_group.configDict[groupId]
		local bossId = groupCo.bossId

		if not string.nilorempty(bossId) then
			bossId = string.splitToNumber(bossId, "#")[1]

			local monsterCo = lua_monster.configDict[bossId]

			return monsterCo.career
		end
	end

	logError("not found boss career, battle id .. " .. battleCo.id)

	return 1
end

function RougeMapEliteFightView:onDestroyView()
	return
end

return RougeMapEliteFightView
