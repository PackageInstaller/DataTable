-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/nightfeastbosschallenge/view/NightFeastBossLevelView.lua

module("logic.extensions.nightfeastbosschallenge.view.NightFeastBossLevelView", package.seeall)

local NightFeastBossLevelView = class("NightFeastBossLevelView", ViewComponent)

function NightFeastBossLevelView:ctor()
	NightFeastBossLevelView.super.ctor(self)

	self._powerPetMo = FightingPowerPetMo.New()
end

function NightFeastBossLevelView:buildUI()
	NightFeastBossLevelView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._btnTip = self:getBtn("btnTip")
	self._btnBuff = self:getBtn("btnBuff")
	self._txtDesc = self:getTxt("txtDesc")
	self.scrollerGo = self:getGo("tableview")
	self.cellGo = self:getGo("tablecell")
	self._scrollList = ScrollerList.create(self.scrollerGo, self.cellGo, GameUtil.handler(self._updateCell, self), GameUtil.handler(self.clearCell, self))
end

function NightFeastBossLevelView:bindEvents()
	NightFeastBossLevelView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickTip, self)
	GameUtil.addClickHandler(self._btnBuff, self._onClickBuff, self)
end

function NightFeastBossLevelView:unbindEvents()
	NightFeastBossLevelView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnBuff)
end

function NightFeastBossLevelView:onEnter()
	NightFeastBossLevelView.super.onEnter(self)

	self._activityId = self:getFirstParam()
	self._actCfg = NightFeastBossConfig.instance:getActivityCfg(self._activityId)
	self._txtDesc.text = string.format("每次挑战成功，均可获得%s\n每日05:00刷新关卡", self._actCfg.buffPointName)

	self:_initLevels()
end

function NightFeastBossLevelView:onExit()
	NightFeastBossLevelView.super.onExit(self)
	self._scrollList:dispose()
end

function NightFeastBossLevelView:_onClickTip()
	local key = self._actCfg.ruleKey

	TipsFacade.instance:openRulesView(key)
end

function NightFeastBossLevelView:_onClickBuff()
	UIStateManager.instance:push(ViewName.NightFeastBossBuffView, self._activityId)
end

function NightFeastBossLevelView:_updateCell(view, cell, data, tag)
	local pass = goutil.findChild(cell, "pass")
	local txtPass = goutil.findChildTextComponent(cell, "pass")
	local txtDesc = goutil.findChildTextComponent(cell, "txtDesc")
	local btnChallenge = Framework.ButtonAdapter.GetFrom(cell.gameObject, "btnChallenge")
	local fmtList = {}

	for i = 1, 9 do
		local item = {}

		item.go = goutil.findChild(cell.gameObject, string.format("fmt/cell_%d", i))
		item.con = goutil.findChild(cell.gameObject, string.format("fmt/cell_%d/con", i))

		MaterialMgr.resetAll(item.con)
		table.insert(fmtList, item)
	end

	local stageId = data
	local isPass = NightFeastBossModel.instance:isDailyPassedStageId(self._activityId, stageId)

	GameUtil.addClickHandler(btnChallenge, function()
		if not isPass then
			NightFeastBossController.instance:openCommonMissionView(self._activityId, stageId)
		else
			FloatWordMgr.instance:show("已通过")
		end
	end)

	local cfg = NightFeastBossConfig.instance:getDailyStageCfg(self._activityId, stageId)

	txtDesc.text = cfg.stageDesc

	GameUtil.SetActive(pass, isPass)
	GameUtil.SetActive(btnChallenge, not isPass)

	local cfgCreeps = NightFeastBossConfig.instance:getCreeps(cfg.creepsMasterId)

	for i, cfgEnemy in ipairs(cfgCreeps) do
		local item = fmtList[cfgEnemy.posId]

		if item and item.go then
			goutil.setActive(item.go, true)
			GameUtil.setLocalScale(item.con, 0.8, 0.8, 0.8)
			self._powerPetMo:fromChallengeCreepCo(cfgEnemy)

			local bagPetMo = self._powerPetMo:toBaseBagPetMo()
			local proxy = MaterialMgr.setCellByMo(bagPetMo, item.con)

			proxy.binder:setAutoTips(false)
			proxy:setCallBack(function()
				CommonTipsMgr.instance:showPetTips(bagPetMo)
			end)
		end
	end

	txtPass.text = string.format("已获得%s", self._actCfg.buffPointName)
end

function NightFeastBossLevelView:clearCell(cell)
	local btnChallenge = Framework.ButtonAdapter.GetFrom(cell.gameObject, "btnChallenge")

	GameUtil.rmClickHandler(btnChallenge)

	for i = 1, 9 do
		local go = goutil.findChild(cell.gameObject, string.format("fmt/cell_%d", i))
		local con = goutil.findChild(cell.gameObject, string.format("fmt/cell_%d/con", i))

		MaterialMgr.resetAll(con)
		GameUtil.SetActive(go, false)
	end
end

function NightFeastBossLevelView:_initLevels()
	local stageIds = NightFeastBossModel.instance:getDailyStageIds(self._activityId)

	for i, v in ipairs(stageIds) do
		printInfo("test NightFeastBossLevelView:_initLevels", i, v)
	end

	self._scrollList:reloadData(stageIds)
end

return NightFeastBossLevelView
