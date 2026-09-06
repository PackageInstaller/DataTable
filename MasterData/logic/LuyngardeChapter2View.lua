-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/luyngarde/view/LuyngardeChapter2View.lua

module("logic.extensions.luyngarde.view.LuyngardeChapter2View", package.seeall)

local LuyngardeChapter2View = class("LuyngardeChapter2View", ViewComponent)

function LuyngardeChapter2View:ctor()
	LuyngardeChapter2View.super.ctor(self)
end

function LuyngardeChapter2View:unbindEvents()
	LuyngardeChapter2View.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnPreview)
	GameUtil.rmClickHandler(self._btnRank)
	GameUtil.rmClickHandler(self._btnFight)
	GameUtil.rmClickHandler(self._btnPrize)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnShowBuff)
end

function LuyngardeChapter2View:bindEvents()
	LuyngardeChapter2View.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickbtnTip, self)
	GameUtil.addClickHandler(self._btnPreview, self._onClickBtnPreview, self)
	GameUtil.addClickHandler(self._btnRank, self._onClickBtnRank, self)
	GameUtil.addClickHandler(self._btnFight, self._onClickBtnFight, self)
	GameUtil.addClickHandler(self._btnPrize, self._onClickBtnPrize, self)
	GameUtil.addClickHandler(self._btnShowBuff, self._onClickShowBuff, self)
end

function LuyngardeChapter2View:buildUI()
	LuyngardeChapter2View.super.buildUI(self)

	self._btnClose = self:getGo("leftTop/btnClose")
	self._btnTip = self:getGo("leftTop/btnTip")
	self._btnShowBuff = self:getGo("btnShowBuff")
	self._txtDesc1 = self:getTxt("infoCol/txtDesc1")
	self._txtDesc2 = self:getTxt("infoCol/txtDesc2")
	self._btnPreview = self:getGo("btnPreview")
	self._btnRank = self:getGo("btnRank")
	self._btnFight = self:getGo("btnFight")
	self._txtDamageNum = self:getTxt("prize/damageNum/txtNum")

	local cellProgress = self:getGo("prize/cell")
	local tabProgress = self:getGo("prize/tableview")

	self._tableviewProgress = ScrollerList.create(tabProgress, cellProgress, GameUtil.handler(self._updateProgressCell, self), GameUtil.handler(self._clearProgressCell, self))
	self._progressBar = self:getSlider("prize/tableview/viewport/content/progressBar")
	self._txtNumTimes = self:getTxt("times/txtNum")
	self._sliderHp = self:getSlider("Hp/slider")
	self._txtHp = self:getTxt("Hp/txtLeftHp/txt")
	self._rankCellList = {}

	for i = 1, 3 do
		local rankCell = {}

		rankCell.go = self:getGo("rankInfo/info" .. i)
		rankCell.headIcon = goutil.findChild(rankCell.go, "headIcon")
		rankCell.empty = goutil.findChild(rankCell.go, "empty")
		rankCell.txtName = goutil.findChildTextComponent(rankCell.go, "txtName")
		self._rankCellList[i] = rankCell
	end

	self._btnPrize = self:getGo("btnPrize")
	self._roleCon = self:getGo("role")
	self._rd = self:getGo("btnPrize/rd")
end

function LuyngardeChapter2View:onExit()
	LuyngardeChapter2View.super.onExit(self)

	if self._role then
		self._role = RoleObjectPool.instance:removeRole(self._role)
		self._role = nil
	end

	for _, rankCell in ipairs(self._rankCellList) do
		HeadItemController.instance:resetHeadCell(rankCell.headIcon)
	end

	RedPointController.instance:unregRedPoint(self._rd)
	self._tableviewProgress:dispose()
end

function LuyngardeChapter2View:onEnter()
	LuyngardeChapter2View.super.onEnter(self)

	self._activityId = checknumber(self:getFirstParam())

	self.addGEvent(self, GlobalNotify.LuyngardeGetChapter2Info, self._handleGetInfo, self)
	self.addGEvent(self, GlobalNotify.LuyngardeGetChapter2SimpleRankInfo, self._handleGetRankInfo, self)
	self.addGEvent(self, GlobalNotify.LuyngardeGainChapter2Prize, self._handleGainPrize, self)
	self:_updateUIByCfg()
	LuyngardeController.instance:getChapter2Info(self._activityId)
	LuyngardeController.instance:getChapter2SimpleRankInfo(self._activityId)
	RedPointController.instance:regRedPoint(self._rd, RedPointModel.ID_Luyngarde_AreaKill_Prize)
end

function LuyngardeChapter2View:_updateUIByCfg()
	self._actCfg = LuyngardeConfig.instance:getActCfg(self._activityId)
	self._bossCfgs = LuyngardeConfig.instance:getChapter2BossCfgs(self._activityId)
	self._prizeCfgs = LuyngardeConfig.instance:getChapter2PersonDamageCfgs(self._activityId)
	self._txtDesc1.text = self._bossCfgs[1].showDesc
	self._txtDesc2.text = self._bossCfgs[2].showDesc
	self._totalHp = checknumber(self._actCfg.c2BossHp)
	self._totalTimes = checknumber(self._actCfg.c2DailyTimes)
end

function LuyngardeChapter2View:_handleGetInfo()
	local info = LuyngardeModel.instance:getChapter2InfoByActId(self._activityId)

	self._dailyTimes = checknumber(info.dailyTimes)
	self._totalDamage = checknumber(info.totalDamage)
	self._personalDamage = checknumber(info.personalDamage)
	self._maxDamage = checknumber(info.maxDamage)
	self._txtDamageNum.text = self._personalDamage
	self._curStepId = 1

	for i, cfg in ipairs(self._bossCfgs) do
		if self._totalDamage >= checknumber(cfg.triggerDamage) then
			self._curStepId = i
		end
	end

	self._role = RoleObjectPool.instance:addRoleToParent(self._role, self._bossCfgs[self._curStepId].showRole, self._roleCon, (self._curStepId == 2 or nil) and 0.7, nil, true, nil, nil)
	self._buffCfg = LuyngardeConfig.instance:getChapter2BossBuffCfg(self._activityId, self._curStepId)
	self._txtNumTimes.text = self._totalTimes - self._dailyTimes

	local curProgress = checknumber(checknumber(self._totalHp - self._totalDamage) / checknumber(self._totalHp))

	self._sliderHp:SetValue(curProgress)

	if curProgress < 1 and curProgress > 0.9999 then
		curProgress = 0.9999
	elseif curProgress < 0.0001 and curProgress > 0 then
		curProgress = 0.0001
	elseif curProgress < 0 then
		curProgress = 0
	end

	self._curProgress = curProgress
	self._txtHp.text = string.format("%.2f%%", checknumber(curProgress * 100))

	self:_updateProgress()
end

function LuyngardeChapter2View:_handleGetRankInfo(msg)
	local info = LuyngardeModel.instance:getChapter2SimpleRankInfoByActId(self._activityId)

	self:_updateRankInfo(self._rankCellList[1], info.maxDamageTop and info.maxDamageTop.headInfo)
	self:_updateRankInfo(self._rankCellList[2], info.accDamageTop and info.accDamageTop.headInfo)
	self:_updateRankInfo(self._rankCellList[3], info.killInfo)
end

function LuyngardeChapter2View:_updateRankInfo(cell, info)
	if cell then
		if info then
			goutil.setActive(cell.empty, false)
			goutil.setActive(cell.headIcon, true)
			goutil.setActive(cell.txtName.gameObject, true)
			HeadItemController.instance:setHeadCellByInfo(cell.headIcon, info, true)

			cell.txtName.text = info.userName
		else
			goutil.setActive(cell.empty, true)
			goutil.setActive(cell.headIcon, false)
			goutil.setActive(cell.txtName.gameObject, false)
		end
	end
end

function LuyngardeChapter2View:_handleGainPrize()
	self:_updateProgress()
end

function LuyngardeChapter2View:_updateProgress()
	local info = LuyngardeModel.instance:getChapter2InfoByActId(self._activityId)

	self._gainedPrizeIds = info.gainedPrizeIds or {}

	self._tableviewProgress:reloadData(self._prizeCfgs)

	local scoreList = {}

	for i, v in ipairs(self._prizeCfgs) do
		table.insert(scoreList, checknumber(v.damage))
	end

	self._tableviewProgress:updateUnderSlider(self._progressBar, self._personalDamage, scoreList)
end

function LuyngardeChapter2View:_updateProgressCell(view, cellGo, data)
	local cell = self:_clearProgressCell(cellGo)

	cell.txtNum.text = data.damage

	local damage = checknumber(data.damage)

	cell.txtNum.text = damage >= 10000 and string.format("%sW", checknumber(damage / 10000)) or data.damage

	MaterialMgr.setCellByCfg(data.prize, cell.item)

	local isGain = table.keyof(self._gainedPrizeIds, data.prizeId)
	local isMatchGain = not isGain and self._personalDamage >= checknumber(data.damage)

	goutil.setActive(cell.btnGet, isMatchGain)

	if isMatchGain then
		self:_playCellEffect(cell.effect)
		GameUtil.addClickHandler(cell.btnGet, self._onClickGainPrize, self)
	end

	goutil.setActive(cell.geted, isGain)
end

function LuyngardeChapter2View:_clearProgressCell(cellGo)
	local cell = {}

	cell.go = cellGo
	cell.item = goutil.findChild(cell.go, "item")

	MaterialMgr.resetAll(cell.item)

	cell.txtNum = goutil.findChildTextComponent(cell.go, "txtNum")
	cell.btnGet = goutil.findChild(cell.go, "btnGet")
	cell.effect = goutil.findChild(cell.go, "effect")
	cell.geted = goutil.findChild(cell.go, "geted")

	GameUtil.rmClickHandler(cell.btnGet)
	self:_clearCellEffect(cell.effect)

	return cell
end

function LuyngardeChapter2View:_playCellEffect(effGo)
	self:_clearCellEffect(effGo)

	local effPath = "fx_ui_juqingfuben/fx_ui_juqingfuben02.prefab"
	local uiEffect = UIEffectManager.instance:playEffect(self, effPath, effGo.transform, 0, 0, true, false, nil, function(target, eff)
		eff:setClipping(self:getGo("prize/tableview/viewport").transform)
	end)

	uiEffect:setParent(effGo.transform)
	uiEffect:setLocalPos(0, 0, 0)
	uiEffect:setScaleXYZ(0.96, 1, 0.87)

	self._cellEffects = self._cellEffects or {}
	self._cellEffects[effGo] = uiEffect
end

function LuyngardeChapter2View:_clearCellEffect(effGo)
	if self._cellEffects and self._cellEffects[effGo] then
		UIEffectManager.instance:stopEffect(self._cellEffects[effGo])

		self._cellEffects[effGo] = nil
	end
end

function LuyngardeChapter2View:_onClickGainPrize()
	LuyngardeController.instance:gainChapter2Prize(self._activityId)
end

function LuyngardeChapter2View:_onClickBtnFight()
	if self._curProgress <= 0 then
		FloatWordMgr.instance:show("Boss已被击败")

		return
	end

	local leftTimes = self._totalTimes - self._dailyTimes

	if leftTimes <= 0 then
		FloatWordMgr.instance:show("今日已无挑战次数")
	else
		LuyngardeController.instance:openChapter2MissionView(self._activityId, self._bossCfgs[self._curStepId].creepsMasterId, false)
	end
end

function LuyngardeChapter2View:_onClickBtnPreview()
	if self._curProgress <= 0 then
		FloatWordMgr.instance:show("Boss已被击败")

		return
	end

	LuyngardeController.instance:openChapter2MissionView(self._activityId, self._bossCfgs[self._curStepId].creepsMasterId, true)
end

function LuyngardeChapter2View:_onClickBtnRank()
	UIStateManager.instance:push(ViewName.LuyngardeRankMainView, self._activityId, 1, 1)
end

function LuyngardeChapter2View:_onClickBtnPrize()
	UIStateManager.instance:push(ViewName.LuyngardePrizeMainView, self._activityId, 1, 3)
end

function LuyngardeChapter2View:_onClickbtnTip()
	local key = self._actCfg.ruleKey

	TipsFacade.instance:openRulesView(key)
end

function LuyngardeChapter2View:_onClickShowBuff()
	if self._buffCfg then
		UIStateManager.instance:push(ViewName.LuyngardeBuffView, self._buffCfg)
	end
end

return LuyngardeChapter2View
