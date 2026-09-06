-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/elementspark/view/ElementSparkLevelupView.lua

module("logic.extensions.elementspark.view.ElementSparkLevelupView", package.seeall)

local ElementSparkLevelupView = class("ElementSparkLevelupView", ViewComponent)

function ElementSparkLevelupView:ctor()
	ElementSparkLevelupView.super.ctor(self)
end

function ElementSparkLevelupView:unbindEvents()
	ElementSparkLevelupView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnLevelUp)
end

function ElementSparkLevelupView:bindEvents()
	ElementSparkLevelupView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnLevelUp, self._onClickLevelUp, self)
end

function ElementSparkLevelupView:buildUI()
	ElementSparkLevelupView.super.buildUI(self)

	self._bg = self:getGo("bg")
	self._btnClose = self:getBtn("btnClose")
	self._btnLevelUp = self:getBtn("levelup/btnLevelUp")
	self._costIcon = self:getGo("levelup/txtCost/icon")
	self._txtOld = self:getTxt("levelup/level/txtOld")
	self._txtNew = self:getTxt("levelup/level/txtNew")
	self._txtBuffDesc_1 = self:getTxt("levelup/buff/txtDesc_1")
	self._txtBuffDesc_2 = self:getTxt("levelup/buff/txtDesc_2")
	self._txtCount_1 = self:getTxt("levelup/guardCount/txtCount_1")
	self._txtCount_2 = self:getTxt("levelup/guardCount/txtCount_2")
	self._txtBossRate_1 = self:getTxt("levelup/bossRate/txtBossRate_1")
	self._txtBossRate_2 = self:getTxt("levelup/bossRate/txtBossRate_2")
	self._txtCost = self:getTxt("levelup/txtCost")
	self._txtBuff = self:getTxt("max/txtBuff")
	self._txtGuardCount = self:getTxt("max/txtGuardCount")
	self._txtBossRate = self:getTxt("max/txtBossRate")
	self._maxGo = self:getGo("max")
	self._levelGo = self:getGo("levelup")
end

function ElementSparkLevelupView:onExit()
	ElementSparkLevelupView.super.onExit(self)
end

function ElementSparkLevelupView:onEnter()
	ElementSparkLevelupView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.EleSparkUpgradeGuardRes, self._refreshLevel, self)

	self._activityId = ElementSparkController.instance:getActivityId()

	local params = self:getOpenParam()

	self._chunkId = checknumber(params[1])
	self._level = params[2]
	self._planId = ElementSparkController.instance:getMapPlanId()
	self._chunkCfg = ElementSparkConfig.instance:getMapChunkCfgById(self._planId, self._chunkId)
	self._starLv = self._chunkCfg.star
	self._mapLvCfg = ElementSparkConfig.instance:getMapLvCfg(self._planId, self._starLv)

	self:_refresh()
end

function ElementSparkLevelupView:_refreshLevel(lv)
	self._level = checknumber(lv)

	self:_refresh()
end

function ElementSparkLevelupView:_refresh()
	self._isMaxLv = #self._mapLvCfg <= self._level

	GameUtil.SetActive(self._maxGo, self._isMaxLv)
	GameUtil.SetActive(self._levelGo, not self._isMaxLv)

	if self._isMaxLv then
		GameUtil.setHeight(self._bg, 470)

		local buffId = self._mapLvCfg[self._level].defenseBuffId
		local buffCfg = ElementSparkConfig.instance:getBuffCfg(buffId)

		self._txtBuff.text = buffCfg.describ
		self._txtGuardCount.text = "守军驻扎上限：" .. self._mapLvCfg[self._level].guardNum
		self._txtBossRate.text = "BOSS回血速度：" .. self._mapLvCfg[self._level].sysRecoverWanPercent / 100 .. "%/分钟"
	else
		GameUtil.setHeight(self._bg, 566)

		local curBuffId = self._mapLvCfg[self._level].defenseBuffId
		local nextBuffId = self._mapLvCfg[self._level + 1].defenseBuffId
		local curBuffCfg = ElementSparkConfig.instance:getBuffCfg(curBuffId)
		local nextBuffCfg = ElementSparkConfig.instance:getBuffCfg(nextBuffId)

		self._txtBuffDesc_1.text = curBuffCfg.describ
		self._txtBuffDesc_2.text = nextBuffCfg.describ
		self._txtOld.text = self._level .. "级"
		self._txtNew.text = self._level + 1 .. "级"
		self._txtCount_1.text = "守军驻扎上限：" .. self._mapLvCfg[self._level].guardNum
		self._txtCount_2.text = "守军驻扎上限：" .. self._mapLvCfg[self._level + 1].guardNum
		self._txtBossRate_1.text = "BOSS回血速度：" .. self._mapLvCfg[self._level].sysRecoverWanPercent / 100 .. "%/分钟"
		self._txtBossRate_2.text = "BOSS回血速度：" .. self._mapLvCfg[self._level + 1].sysRecoverWanPercent / 100 .. "%/分钟"
		self._txtCost.text = "消耗阵营积分：" .. self._mapLvCfg[self._level + 1].price
	end
end

function ElementSparkLevelupView:_onClickLevelUp()
	local isCommander = ElementSparkController.instance:isCommander()

	if not isCommander then
		FloatWordMgr.instance:show("仅指挥官可升级地块哦")

		return
	end

	local info = ElementSparkModel.instance:getInfo()
	local campScore = checknumber(info.campScore)
	local costScore = self._mapLvCfg[self._level + 1].price
	local desc = costScore .. "阵营积分"
	local tips = langPara("elementspark_8", desc, self._level + 1, campScore)

	local function sureChange()
		if campScore < costScore then
			FloatWordMgr.instance:show("阵营积分不足，无法升级地块哦~")

			return
		end

		ElementSparkController.instance:sendPM_EleSparkUpgradeGuardReq(self._activityId, self._chunkId, self._level + 1)
	end

	TipsFacade.instance:openTipWindow(lang("text_tong_tips"), tips, sureChange, "确定", UnityEngine.TextAnchor.MiddleCenter)
end

return ElementSparkLevelupView
