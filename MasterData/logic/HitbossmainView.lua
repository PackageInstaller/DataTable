-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/hitboss/view/HitbossmainView.lua

module("logic.extensions.hitboss.view.HitbossmainView", package.seeall)

local HitbossmainView = class("HitbossmainView", ViewComponent)

function HitbossmainView:ctor()
	HitbossmainView.super.ctor(self)

	self._effectHandlers = {}
end

function HitbossmainView:unbindEvents()
	HitbossmainView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self.btnClose)
	GameUtil.rmClickHandler(self.btnRule)
	GameUtil.rmClickHandler(self.btnChallenge)
	self._btnTxtRank:RemoveClickListener()
	GameUtil.rmClickHandler(self._btnBuff)
end

function HitbossmainView:bindEvents()
	HitbossmainView.super.bindEvents(self)
	GameUtil.addClickHandler(self.btnClose, self.close, self)
	GameUtil.addClickHandler(self.btnRule, self._onClickRule, self)
	GameUtil.addClickHandler(self.btnChallenge, self.onClickStart, self)
	self._btnTxtRank:AddClickListener(self._onClickbtnTxtRank, self)
	GameUtil.addClickHandler(self._btnBuff, self._onClickBtnBuff, self)
end

function HitbossmainView:buildUI()
	HitbossmainView.super.buildUI(self)

	self._challengeId = 20
	self._type = MoyanModel.TYPE_3
	self.btnRule = self:getGo("btnTip")
	self.btnClose = self:getGo("btnClose")
	self.btnChallenge = self:getGo("btnChallenge")
	self.txt = self:getTxt("remain/txt")
	self.txtDesc = self:getTxt("rule/txtDesc")
	self.txtLeftTime = self:getGo("txtLeftTime")

	GameUtil.SetActive(self.txtLeftTime, false)

	self._con = self:getGo("con")
	self.txtNum = self:getTxt("progress/txtNum")
	self.Slider = self:getSlider("progress/tableview/Viewport/Content/Slider")
	self._tableviewGo = self:getGo("progress/tableview")
	self._rewardCellGo = self:getGo("progress/rewardCell")
	self._scrollerList = ScrollerList.create(self._tableviewGo, self._rewardCellGo, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._txtDamage = self:getTxt("damagetip/txtDamage")
	self._btnTxtRank = self:getBtn("damagetip/btnTxtRank")
	self._txtBuff = self:getTxt("bubble/txtBuff")
	self._scrollRect = self:getGo("progress/tableview"):GetComponent(ComponentType.ScrollRect)
	self._btnBuff = goutil.findChild(self.mainGO, "btnBuff")
end

function HitbossmainView:onExit()
	HitbossmainView.super.onExit(self)
	UIEffectManager.instance:stopEffect(self._pmEff)
	UIEffectManager.instance:stopEffect(self._pmEff2)
	self._scrollerList:dispose()
end

function HitbossmainView:onEnter()
	HitbossmainView.super.onEnter(self)
	self.addGEvent(self, HitBossAgent.HitBossGetInfoRes, self._onHitBossGetInfoRes, self)
	self.addGEvent(self, HitBossAgent.HitBossGainPrizeRes, self.onRefreshUI, self)

	self._activityId = checknumber(self:getFirstParam())

	if self._activityId <= 0 then
		self._activityId = HitbossController.instance:getActivityId()
	end

	if self._activityId <= 0 then
		FloatWordMgr.instance:show("功能未开启")
		self:close()

		return
	end

	self._bossId = HitbossConfig.instance:getBossId(self._activityId)

	self:onRefreshUI()
	self:_setRole()
	self:_playEffect()
	HitBossAgent.instance:sendPM_HitBossGetInfoReq(self._activityId)
end

function HitbossmainView:_playEffect()
	local effPath = "fx_ui_moyantiaozhan/fx_ui_zhumianban_common.prefab"

	self._pmEff = UIEffectManager.instance:playEffect(self, effPath, self.mainGO, 0, 0, true, nil, nil, nil, self)

	self._pmEff:setParent(self.mainGO.transform)
	self._pmEff:setScale(1)

	local effPath = "fx_ui_moyantiaozhan/fx_ui_zhumianban_anniu.prefab"

	self._pmEff2 = UIEffectManager.instance:playEffect(self, effPath, self.mainGO, 488.4, -279, true, nil, nil, nil, self)

	self._pmEff2:setParent(self.mainGO.transform)
	self._pmEff2:setScale(1)
end

function HitbossmainView:_setRole()
	local skinId = HitbossController.instance:getSkinId(self._activityId)

	self._role = RoleObjectPool.instance:removeRole(self._role)

	if skinId > 0 then
		self._role = RoleObjectPool.instance:addRoleToParent(self._role, skinId, self._con, 1, nil, true, 0, 0)
	end
end

function HitbossmainView:onRefreshUI()
	self._info = HitbossModel.instance:getInfo(self._activityId)

	if not self._info then
		return
	end

	local baseCfg = HitbossConfig.instance:getActivityCfg(self._activityId)
	local dailyClgTimes = baseCfg.dailyClgTimes
	local useTime = self._info.usedDailyClgTimes
	local maxDamage = checknumber(self._info.maxDamage)
	local left = dailyClgTimes - useTime

	self.txt.text = langPara("剩余挑战次数：%s/%s", left, dailyClgTimes)
	self.txtDesc.text = baseCfg.desc

	self:_showMaxDamage(maxDamage)
	self:_showReward()
	self:_showBuff()
end

function HitbossmainView:_onClickRule()
	return
end

function HitbossmainView:onClickStart()
	if self:checkHasTime() then
		HitbossController.instance:enterMission(self._activityId, self._bossId)
	else
		FloatWordMgr.instance:show("明日再来")
	end
end

function HitbossmainView:checkHasTime()
	local baseCfg = HitbossConfig.instance:getActivityCfg(self._activityId)
	local dailyClgTimes = baseCfg.dailyClgTimes

	if self._info then
		if not self._info.usedDailyClgTimes then
			local useTime = 0
			local left = dailyClgTimes - useTime

			return left > 0
		end
	end
end

function HitbossmainView:_onHitBossGetInfoRes()
	self:onRefreshUI()
end

function HitbossmainView:_showReward()
	local prizeCfgs = HitbossConfig.instance:getPrizeCfgs(self._activityId)
	local scoreList = HitbossConfig.instance:getPrizeProgressList(self._activityId)
	local bossDamage = HitbossModel.instance:getTotalDamage(self._activityId)

	self._scrollerList:reloadData(prizeCfgs)
	self._scrollerList:updateUnderSlider(self.Slider, bossDamage, scoreList)
end

function HitbossmainView:_updateCell(view, cell, prizeCfg, tag)
	local item = goutil.findChild(cell, "item")
	local received = goutil.findChild(cell, "received")
	local txtNum = goutil.findChildTextComponent(cell, "txtNum")
	local effectGo = goutil.findChild(cell, "effect")
	local isGain = HitbossController.instance:isGainPrize(self._activityId, prizeCfg.prizeId)
	local isCanGain = HitbossController.instance:isCanGainPrize(self._activityId, prizeCfg.prizeId)

	txtNum.text = HitbossController.instance:getDamageStr(prizeCfg.progress)

	GameUtil.SetActive(received, isGain)

	local proxy = MaterialMgr.setCellByCfg(prizeCfg.prize, item)

	proxy.binder:setAutoTips(not isCanGain)

	if isCanGain then
		proxy.binder:setCallBack(function()
			HitbossController.instance:sendPM_HitBossGainPrizeReq(self._activityId, prizeCfg.prizeId)
		end)
	else
		proxy.binder:setCallBack(nil)
	end

	goutil.setActive(effectGo, isCanGain)

	if isCanGain then
		local handler = self._effectHandlers[effectGo]

		if not handler then
			handler = UIEffectManager.instance:playEffect(self, "fx_ui_juqingfuben/fx_ui_juqingfuben02.prefab", nil, nil, nil, true, nil, nil, function()
				handler:setScrollRectClipping(self._scrollRect)
			end)
			self._effectHandlers[effectGo] = handler
		end

		handler:setParent(effectGo.transform)
		handler:setScale(0.7)
		handler:setLocalPos(0, 0, 0)
	end
end

function HitbossmainView:_clearCell(cell)
	local item = goutil.findChild(cell, "item")
	local effectGo = goutil.findChild(cell, "effect")
	local handler = self._effectHandlers[effectGo]

	if handler then
		UIEffectManager.instance:stopEffect(handler)

		self._effectHandlers[effectGo] = nil
	end

	MaterialMgr.resetAll(item)
end

function HitbossmainView:_onClickbtnTxtRank()
	UIStateManager.instance:push(ViewName.HitbossrankView, self._activityId)
end

function HitbossmainView:_showBuff()
	local day = HitbossController.instance:getTotalDay(self._activityId)
	local cfg = HitbossConfig.instance:getDailyBuffCfg(self._activityId, day)

	self._txtBuff.text = cfg and cfg.des or "暂无"
end

function HitbossmainView:_showMaxDamage(maxDamage)
	self._txtDamage.text = HitbossController.instance:getDamageStr(maxDamage)
end

function HitbossmainView:_onClickBtnBuff()
	UIStateManager.instance:push(ViewName.HitBossBuffView, self._activityId)
end

return HitbossmainView
