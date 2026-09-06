-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/season/view/SeasonBossDetailView.lua

module("logic.extensions.season.view.SeasonBossDetailView", package.seeall)

local SeasonBossDetailView = class("SeasonBossDetailView", ViewComponent)

function SeasonBossDetailView:ctor()
	SeasonBossDetailView.super.ctor(self)
end

function SeasonBossDetailView:unbindEvents()
	SeasonBossDetailView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnSure)
end

function SeasonBossDetailView:bindEvents()
	SeasonBossDetailView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnSure, self._onClickSure, self)
end

function SeasonBossDetailView:buildUI()
	SeasonBossDetailView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._imgNum = self:getGo("power/imgNum"):GetComponent(ComponentType.UIImgNumeralText)
	self._teamViewsGo = self:getGo("enemy/tableview")
	self._teamGo = self:getGo("enemy/pet")
	self._txtCost = self:getTxt("txtCost")
	self._btnSure = self:getGo("btnChallenge")
	self._txtSure = self:getTxt("btnChallenge/Text")
	self._effect = self:getGo("effect")

	GameUtil.SetActive(self._teamGo, false)

	self._teamScrollList = ScrollerList.create(self._teamViewsGo, self._teamGo, GameUtil.handler(self._updateTeamCell, self), GameUtil.handler(self._clearTeamCell, self))
end

function SeasonBossDetailView:onExit()
	SeasonBossDetailView.super.onExit(self)
	self._teamScrollList:dispose()

	if self._pmEff then
		UIEffectManager.instance:stopEffect(self._pmEff)
	end
end

function SeasonBossDetailView:onEnter()
	SeasonBossDetailView.super.onEnter(self)

	local params = self:getFirstParam()
	local evtConfig = params.evtConfig
	local evtDetailConfig = params.evtDetailConfig
	local creepsMasterId = evtDetailConfig.creepsMasterId
	local creepsTeam = SeasonConfig.instance:getCreepTeam(creepsMasterId)
	local creeps = SeasonConfig.instance:getCreeps(creepsMasterId)

	self._teamScrollList:reloadData(creeps)
	self._imgNum:SetNum(creepsTeam.recommendZdl or 0)

	if self._txtSure then
		self._txtSure.text = params.strSure or lang("confirm")
	end

	self._sureCallback = params.sureCallback

	GameUtil.SetActive(self._btnSure, not params.bHideSure)

	self._cost = checknumber(evtConfig.cost)

	GameUtil.SetActive(self._txtCost, not params.bHideSure and self._cost > 0)

	self._txtCost.text = self._cost

	self:_showEffect()
end

function SeasonBossDetailView:_updateTeamCell(view, cell, data, tag)
	local itemStr = MaterialMgr.createSerName(MatType.Pet, data.raceId, data.lv)

	MaterialMgr.resetAll(cell.gameObject)

	local proxy = MaterialMgr.setCellByCfg(itemStr, cell.gameObject)

	if proxy then
		proxy.binder:setStars(data.awakenLv)

		if not string.nilorempty(data.faceId) then
			proxy.binder:setSkin(data.faceId)
		end

		proxy.binder:setAutoTips(false)
		proxy.binder:setCallBack(function()
			local petMo = {
				raceId = data.raceId,
				curFaceId = checknumber(data.faceId),
				level = data.lv,
				name = data.name,
				contractSkillId = data.contractSkillId,
				_curZdl = data.fightingPower,
				awakenLv = data.awakenLv
			}

			CommonTipsMgr.instance:showPetTips(petMo)
		end)
	end
end

function SeasonBossDetailView:_clearTeamCell(cell)
	MaterialMgr.resetAll(cell.gameObject)
end

function SeasonBossDetailView:_showEffect()
	local effectPath = "20221028/yingfenshen_dkns/fx_ui_yingfenshen_dkns.prefab"

	self._pmEff = UIEffectManager.instance:playEffect(self, effectPath, self._effect, 0, 0, true, nil, nil, nil, self)

	self._pmEff:setParent(self._effect.transform)
	self._pmEff:setLocalPos(0, 0, 0)
	self._pmEff:setScale(1)
end

function SeasonBossDetailView:_onClickSure()
	if self._cost > 0 then
		local teamModel = SeasonTeamsModel.instance
		local teamId = teamModel:getCurrTeamId()
		local teamMo = teamModel:getTeam(teamId)

		if not teamMo then
			FloatWordMgr.instance:show(lang("队伍不存在"))

			return
		end

		if teamMo.teamStrength < self._cost then
			FloatWordMgr.instance:show(lang("体力不足"))

			return
		end
	end

	self:close()
	GameUtil.callBack(self._sureCallback)
end

return SeasonBossDetailView
