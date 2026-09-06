-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/heartofjieshen/view/HeartofjieshenyiresultView.lua

module("logic.extensions.heartofjieshen.view.HeartofjieshenyiresultView", package.seeall)

local HeartofjieshenyiresultView = class("HeartofjieshenyiresultView", ViewComponent)

function HeartofjieshenyiresultView:ctor()
	HeartofjieshenyiresultView.super.ctor(self)
end

function HeartofjieshenyiresultView:unbindEvents()
	HeartofjieshenyiresultView.super.unbindEvents(self)
	self._btnSure:RemoveClickListener()
	self._btnCancel:RemoveClickListener()
end

function HeartofjieshenyiresultView:bindEvents()
	HeartofjieshenyiresultView.super.bindEvents(self)
	self._btnSure:AddClickListener(self._onClickbtnSure, self)
	self._btnCancel:AddClickListener(self._onClickbtnCancel, self)
end

function HeartofjieshenyiresultView:buildUI()
	HeartofjieshenyiresultView.super.buildUI(self)

	self._btnSure = self:getBtn("btnSure")
	self._btnCancel = self:getBtn("btnCancel")
	self._tableviewGo = self:getGo("tableview")
	self._tablecellGo = self:getGo("tablecell")
	self._txtDamagePer = self:getTxt("txtDamagePer")
	self._txtDamage = self:getTxt("txtDamage")
	self._scrollerList = ScrollerList.create(self._tableviewGo, self._tablecellGo, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
end

function HeartofjieshenyiresultView:onExit()
	HeartofjieshenyiresultView.super.onExit(self)
	self._scrollerList:dispose()
end

function HeartofjieshenyiresultView:onEnter()
	HeartofjieshenyiresultView.super.onEnter(self)

	self._msg = HeartofjieshenModel.instance:getFightYiResMsg()

	self:_updateUI()
end

function HeartofjieshenyiresultView:_onClickbtnSure()
	HeartofjieshenModel.instance:setClgFinish(GameEnum.HeartofjieshenclgFmtType.Yi)

	local mo = HeartofjieshenModel.instance:getFmtMo()
	local actCfg = HeartofjieshenConfig.instance:getActCfg(self._msg.activityId)

	mo:initParams(self._msg.activityId, actCfg.chiCreepsMasterId, GameEnum.HeartofjieshenclgFmtType.Chi)
	BattleFacade.instance:endBattle()
end

function HeartofjieshenyiresultView:_onClickbtnCancel()
	BattleFacade.instance:endBattle()
end

function HeartofjieshenyiresultView:_updateCell(view, cell, raceId, tag)
	MaterialMgr.resetAll(cell.gameObject)
	MaterialMgr.setCell(MatType.Pet, raceId, cell.gameObject)
end

function HeartofjieshenyiresultView:_clearCell(cell)
	MaterialMgr.resetAll(cell.gameObject)
end

function HeartofjieshenyiresultView:_updateUI()
	self._txtDamage.text = self._msg.curFightDamage

	self:_updateDamagePercent()
	self:_updatePets()
end

function HeartofjieshenyiresultView:_updateDamagePercent()
	local myTeamId = BattleModel.instance:getLeftTeamId()

	self._playTotalDamage = BattleStatisticsDataModel.instance:getTotalDamage(myTeamId)
	self._playerDatas = BattleStatisticsDataModel.instance:getStatistics(myTeamId)

	self:_prepareStatics(myTeamId)

	self._txtDamagePer.text = self:_data2text(self._playTotalDamage)
end

function HeartofjieshenyiresultView:_updatePets()
	self._scrollerList:reloadData(self._msg.raceMustOnChiForm)
end

function HeartofjieshenyiresultView:_prepareStatics(teamId)
	local totalDamage = BattleStatisticsDataModel.instance:getTotalDamage(teamId)
	local totalDefDamage = BattleStatisticsDataModel.instance:getTotalDefDamage(teamId)
	local totalTreatment = BattleStatisticsDataModel.instance:getTotalTreatment(teamId)
	local staticsDatas = BattleStatisticsDataModel.instance:getStatistics(teamId)
	local currDamagePercent = 0

	for i = 1, #staticsDatas do
		staticsDatas[i].damagePercent = staticsDatas[i].damage / totalDamage
		currDamagePercent = currDamagePercent + staticsDatas[i].damagePercent
	end

	local deltaDamagePercent = 1 - currDamagePercent

	if deltaDamagePercent ~= 0 then
		for i = 1, #staticsDatas do
			if deltaDamagePercent > 0 then
				if i == #staticsDatas then
					staticsDatas[i].damagePercent = staticsDatas[i].damagePercent + deltaDamagePercent
				elseif staticsDatas[i].damage > 0 then
					staticsDatas[i].damagePercent = staticsDatas[i].damagePercent + 0.01
					deltaDamagePercent = deltaDamagePercent - 0.01
				end
			end
		end
	end
end

function HeartofjieshenyiresultView:_data2text(totalDamage)
	local list = {}

	for i, data in ipairs(self._playerDatas) do
		local raceId = 0

		if data.faceId and data.faceId ~= 0 then
			raceId = data.faceId
		end

		local var_15_0

		do
			do
				local scene = SceneMgr.instance:getCurScene()
				local unit = scene.unitFactory:getUnit(data.teamId, data.charactorId)

				raceId = unit.attrs:getOriginSkinId()
			end

			var_15_0 = checknumber(self._msg.curFightDamage) > 0 and string.format("%.2f", data.damagePercent * 100) or 0
		end

		table.insert(list, string.format("%s <color=#e32c2c>%s%%</color>伤害", PetSkinConfig.instance:getPetSkinName(raceId), var_15_0))
	end

	return table.concat(list, "  ")
end

return HeartofjieshenyiresultView
