-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dragonxiuer/view/DragonXiuerBossView.lua

module("logic.extensions.dragonxiuer.view.DragonXiuerBossView", package.seeall)

local DragonXiuerBossView = class("DragonXiuerBossView", ViewComponent)

function DragonXiuerBossView:ctor()
	DragonXiuerBossView.super.ctor(self)
end

function DragonXiuerBossView:unbindEvents()
	DragonXiuerBossView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnChallenge)
end

function DragonXiuerBossView:bindEvents()
	DragonXiuerBossView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnChallenge, self._onClickChallenge, self)
end

function DragonXiuerBossView:buildUI()
	DragonXiuerBossView.super.buildUI(self)

	self._btnClose = self:getGo("static/btnClose")
	self._btnChallenge = self:getGo("btnChallenge")
	self._petASilder = self:getSlider("petInfoA/blockSlider")
	self._txtProgressA = self:getTxt("petInfoA/txt/txtProgress")
	self._petBSilder = self:getSlider("petInfoB/blockSlider")
	self._txtProgressB = self:getTxt("petInfoB/txt/txtProgress")
	self._txtTime = self:getTxt("txtTimeBg/txtTime")
	self._txtDesc = self:getTxt("txtbg/txtDesc")
end

function DragonXiuerBossView:onExit()
	DragonXiuerBossView.super.onExit(self)
end

function DragonXiuerBossView:onEnter()
	DragonXiuerBossView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.handlePM_DragonXiuerGetInfoRes, self._refreshView, self)

	self._actId = self:getFirstParam()

	DragonXiuerAgent.instance:sendPM_DragonXiuerGetInfoReq(self._actId)

	if DragonXiuerController.instance:isNeedNotifyReset() == true then
		UIStateManager.instance:push(ViewName.DragonXiuerBossFailView)
	end

	local ruleCfg = RulesConfig.instance:getRuleCo("dragonxiuerboss_rule")

	self._txtDesc.text = ruleCfg.rules
end

function DragonXiuerBossView:_refreshView()
	local bossCfgInfo = {}
	local challengeCfg = DragonXiuerConfig.instance:getBossCfg(self._actId)
	local creepCfg = DragonXiuerConfig.instance:getCreepsCfg(challengeCfg.bossTeamId)
	local petACfg = creepCfg[1]
	local petBCfg = creepCfg[2]
	local petAAttr = FightingPowerFormula.instance:parseAttrValues(petACfg.extproperties)
	local petATotalHp = petAAttr[GameEnum.AttrType.Hp]
	local petAInfo = DragonXiuerModel.instance:getBossInfo(self._actId, 1)
	local petACurHp = petATotalHp

	if petAInfo then
		petACurHp = petAInfo.bossHp
	elseif DragonXiuerModel.instance:getIsPassBoss(self._actId) == true then
		petACurHp = 0
	end

	self._txtProgressA.text = petACurHp

	self._petASilder:SetValue(petACurHp / petATotalHp)

	local modelCo = CharacterConfig.instance:getModelCo(checknumber(petACfg.raceId))

	if not modelCo then
		printError("t_model id not exist:" .. raceId)

		return
	end

	bossCfgInfo[1] = {}
	bossCfgInfo[1].totalHp = petATotalHp
	bossCfgInfo[1].name = petACfg.creepsName

	local petBAttr = FightingPowerFormula.instance:parseAttrValues(petBCfg.extproperties)
	local petBTotalHp = petAAttr[GameEnum.AttrType.Hp]
	local petBInfo = DragonXiuerModel.instance:getBossInfo(self._actId, 2)
	local petBCurHp = petBTotalHp

	if petBInfo then
		petBCurHp = petBInfo.bossHp
	elseif DragonXiuerModel.instance:getIsPassBoss(self._actId) == true then
		petBCurHp = 0
	end

	self._txtProgressB.text = petBCurHp

	self._petBSilder:SetValue(petBCurHp / petBTotalHp)

	local modelCo = CharacterConfig.instance:getModelCo(checknumber(petBCfg.raceId))

	if not modelCo then
		printError("t_model id not exist:" .. raceId)

		return
	end

	bossCfgInfo[2] = {}
	bossCfgInfo[2].totalHp = petBTotalHp
	bossCfgInfo[2].name = petBCfg.creepsName
	self._txtTime.text = langPara("次数：%d/%d", challengeCfg.challengeTimes - DragonXiuerModel.instance:getBossTime(self._actId), challengeCfg.challengeTimes)

	DragonXiuerModel.instance:saveBossCfgInfo(bossCfgInfo)

	if petACurHp == 0 and petBCurHp == 0 then
		TipsFacade.instance:openTipWindow("提示", "恭喜你挑战成功", function()
			self:close()
		end)
	end
end

function DragonXiuerBossView:_onClickChallenge()
	if DragonXiuerModel.instance:getIsPassBoss(self._actId) == true then
		FloatWordMgr.instance:show(lang("已通关"))
	else
		local fmtMo = DragonXiuerModel.instance:getBossFmtMo()

		fmtMo:initParams(self._actId)
		CustomFmtController.instance:showMissionView(fmtMo)
	end
end

return DragonXiuerBossView
