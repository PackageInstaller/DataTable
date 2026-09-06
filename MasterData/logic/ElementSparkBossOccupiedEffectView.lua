-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/elementspark/view/ElementSparkBossOccupiedEffectView.lua

module("logic.extensions.elementspark.view.ElementSparkBossOccupiedEffectView", package.seeall)

local ElementSparkBossOccupiedEffectView = class("ElementSparkBossOccupiedEffectView", ViewComponent)

function ElementSparkBossOccupiedEffectView:ctor()
	ElementSparkBossOccupiedEffectView.super.ctor(self)
end

function ElementSparkBossOccupiedEffectView:unbindEvents()
	ElementSparkBossOccupiedEffectView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function ElementSparkBossOccupiedEffectView:bindEvents()
	ElementSparkBossOccupiedEffectView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
end

function ElementSparkBossOccupiedEffectView:buildUI()
	ElementSparkBossOccupiedEffectView.super.buildUI(self)

	self._txtCampScore = self:getTxt("effect/txtCampScore")
	self._txtPersonScore = self:getTxt("effect/txtPersonScore")
	self._txtLevel = self:getTxt("guardEffect/txtTitle")
	self._txtBuffDesc = self:getTxt("guardEffect/txtBuffDesc")
	self._txtGuardCount = self:getTxt("guardEffect/txtGuardCount")
	self._txtBossRate = self:getTxt("guardEffect/txtBossRate")
	self._btnClose = self:getBtn("btnClose")
end

function ElementSparkBossOccupiedEffectView:onExit()
	ElementSparkBossOccupiedEffectView.super.onExit(self)
end

function ElementSparkBossOccupiedEffectView:onEnter()
	ElementSparkBossOccupiedEffectView.super.onEnter(self)

	local params = self:getOpenParam()
	local chunkId = checknumber(params[1])
	local level = params[2]
	local planId = ElementSparkController.instance:getMapPlanId()
	local chunkCfg = ElementSparkConfig.instance:getMapChunkCfgById(planId, chunkId)
	local occupyProductId = chunkCfg.occupyProduct[1]
	local guardProductId = chunkCfg.guardProductId
	local campScoreRate = ElementSparkConfig.instance:getProductCfg(occupyProductId).rate
	local personScoreRate = ElementSparkConfig.instance:getProductCfg(guardProductId).rate
	local info = ElementSparkModel.instance:getInfo()
	local campInfo = ElementSparkModel.instance:getCampInfo()

	self._txtCampScore.text = campScoreRate .. "/分钟"
	self._txtPersonScore.text = personScoreRate .. "/分钟"

	local starLv = chunkCfg.star
	local mapLvCfg = ElementSparkConfig.instance:getMapLvCfg(planId, starLv)
	local buffId = mapLvCfg[level].defenseBuffId
	local buffCfg = ElementSparkConfig.instance:getBuffCfg(buffId)

	self._txtLevel.text = string.format("%d级驻军效果", level)
	self._txtBuffDesc.text = buffCfg.describ
	self._txtGuardCount.text = mapLvCfg[level].guardNum
	self._txtBossRate.text = mapLvCfg[level].sysRecoverWanPercent / 100 .. "%/分钟"
end

return ElementSparkBossOccupiedEffectView
