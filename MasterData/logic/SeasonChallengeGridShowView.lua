-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/season/view/SeasonChallengeGridShowView.lua

module("logic.extensions.season.view.SeasonChallengeGridShowView", package.seeall)

local SeasonChallengeGridShowView = class("SeasonChallengeGridShowView", SeasonBaseGridShowView)

function SeasonChallengeGridShowView:ctor()
	SeasonChallengeGridShowView.super.ctor(self)
end

function SeasonChallengeGridShowView:unbindEvents()
	SeasonChallengeGridShowView.super.unbindEvents(self)
end

function SeasonChallengeGridShowView:bindEvents()
	SeasonChallengeGridShowView.super.bindEvents(self)
end

function SeasonChallengeGridShowView:buildUI()
	SeasonChallengeGridShowView.super.buildUI(self)

	self._txtPower = self:getTxt("txtPower")
	self._teamViewsGo = self:getGo("enemy/tableview")
	self._teamGo = self:getGo("enemy/item")
	self._rewardViewsGo = self:getGo("reward/tableview")
	self._rewardGo = self:getGo("reward/item")

	GameUtil.SetActive(self._teamGo, false)
	GameUtil.SetActive(self._rewardGo, false)

	self._teamScrollList = ScrollerList.create(self._teamViewsGo, self._teamGo, GameUtil.handler(self._updateTeamCell, self), GameUtil.handler(self._clearTeamCell, self))
	self._rewardScrollList = ScrollerList.create(self._rewardViewsGo, self._rewardGo, GameUtil.handler(self._updateRewardCell, self), GameUtil.handler(self._clearRewardCell, self))
	self._hightLowFightBuff = self:getGo("buffList/hightLowBuff")
	self._hightLowFightBuffIcon = self:getGo("buffList/hightLowBuff/icon")
	self._hightLowFightBuffDesc = self:getTxt("buffList/hightLowBuff/txtDesc")
	self._mapBuff = self:getGo("buffList/mapBuff")
	self._mapBuffIcon = self:getGo("buffList/mapBuff/icon")
	self._mapBuffDesc = self:getTxt("buffList/mapBuff/txtDesc")
end

function SeasonChallengeGridShowView:onExit()
	SeasonChallengeGridShowView.super.onExit(self)

	if self._mapBuffIcon then
		uGuiUtil.clearImage(self._mapBuffIcon)
	end

	self._teamScrollList:dispose()
end

function SeasonChallengeGridShowView:onEnter()
	SeasonChallengeGridShowView.super.onEnter(self)

	local params = self:getFirstParam()

	self._evtConfig = params.evtConfig
	self._evtDetailConfig = params.evtDetailConfig
	self._hightLowFightBuffId = params.hightLowFightBuffId

	self:_showEnemy()
	self:_showReword()

	self._txtTitle.text = not string.nilorempty(params.strTitle) and params.strTitle or langPara("%s(Lv.%s)", self._evtDetailConfig.isElite and lang("精英敌人") or lang("普通敌人"), self._evtConfig.showLevel)

	local seasonId = SeasonModel.instance:getSeasonId()
	local cfg = SeasonConfig.instance:getSeasonConfigBySeasonId(seasonId)

	if checknumber(self._hightLowFightBuffId) > 0 and cfg.isUseHightLow == true then
		GameUtil.SetActive(self._hightLowFightBuff, true)

		local cfg = BattleConfig.instance:getBuffCo(self._hightLowFightBuffId)

		if cfg then
			uGuiUtil.setSpriteToImage(self._hightLowFightBuffIcon, nil, GameUrl.getExpEventUrl(cfg.icon))

			self._hightLowFightBuffDesc.text = lang(cfg.desc)
		end
	else
		GameUtil.SetActive(self._hightLowFightBuff, false)
	end

	if not string.nilorempty(self._evtDetailConfig.mapBuffIdAndTimes) and self._mapBuff then
		GameUtil.SetActive(self._mapBuff, true)

		local params = string.split(self._evtDetailConfig.mapBuffIdAndTimes, "_")
		local buffId = checknumber(params[1])
		local count = checknumber(params[2])
		local cfg = SeasonConfig.instance:getMapBuffCfg(SeasonModel.instance:getSeasonId(), buffId)

		if cfg then
			uGuiUtil.setSpriteToImage(self._mapBuffIcon, nil, GameUrl.getExpEventUrl(cfg.icon))

			self._mapBuffDesc.text = count > 0 and langPara(cfg.desc, count) or lang(cfg.desc)
		end
	else
		GameUtil.SetActive(self._mapBuff, false)
	end
end

function SeasonChallengeGridShowView:_showEnemy()
	local creepsMasterId = self._evtDetailConfig.creepsMasterId
	local creeps = SeasonConfig.instance:getCreeps(creepsMasterId)
	local list = {}

	for k, v in pairs(creeps) do
		local mo = FightingPowerPetMo.New()

		mo:fromChallengeCreepCo(v, creeps)
		table.insert(list, mo)
	end

	self._teamScrollList:reloadData(list)

	local creepsTeam = SeasonConfig.instance:getCreepTeam(creepsMasterId)

	self._txtPower.text = langPara("推荐战力：%s", creepsTeam.recommendZdl or 0)
end

function SeasonChallengeGridShowView:_showReword()
	local strPrize = self._evtDetailConfig.prize
	local rewardList = string.split(strPrize, "#")
	local seasonId = SeasonModel.instance:getSeasonId()
	local fragmentId = self._evtDetailConfig.fragmentId
	local medalId = self._evtDetailConfig.medalId

	if checknumber(medalId) > 0 then
		local medalConf = SeasonMainCampConfig.instance:getBadgeConfig(seasonId, medalId)

		table.insert(rewardList, medalConf.fakeItem)
	end

	if checknumber(fragmentId) > 0 then
		local cfg = SeasonConfig.instance:getSeasonFragmentConfig(seasonId, fragmentId)

		table.insert(rewardList, cfg.fakeItem)
	end

	self._rewardScrollList:reloadData(rewardList)
end

function SeasonChallengeGridShowView:_updateTeamCell(view, cell, data, tag)
	local proxy = MaterialMgr.setCellByMo(data, cell)

	if proxy then
		proxy.binder:setCallBack(function()
			CommonTipsMgr.instance:showPetTips(data)
		end)
	end
end

function SeasonChallengeGridShowView:_clearTeamCell(cell)
	MaterialMgr.resetAll(cell.gameObject)
end

function SeasonChallengeGridShowView:_updateRewardCell(view, cell, data, tag)
	MaterialMgr.resetAll(cell.gameObject)
	MaterialMgr.setCellByCfg(data, cell.gameObject)
end

function SeasonChallengeGridShowView:_clearRewardCell(cell)
	MaterialMgr.resetAll(cell.gameObject)
end

return SeasonChallengeGridShowView
