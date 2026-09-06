-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinetianshanclg/view/DivineTianShancClgNormalView.lua

module("logic.extensions.divinetianshanclg.view.DivineTianShancClgNormalView", package.seeall)

local DivineTianShancClgNormalView = class("DivineTianShancClgNormalView", ViewComponent)

function DivineTianShancClgNormalView:ctor()
	DivineTianShancClgNormalView.super.ctor(self)
end

function DivineTianShancClgNormalView:unbindEvents()
	DivineTianShancClgNormalView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnBuff)
	GameUtil.rmClickHandler(self._btnFight)
	GameUtil.rmClickHandler(self._btnPreview)

	for i, cell in ipairs(self._zoneList) do
		GameUtil.rmClickHandler(cell.go)
	end
end

function DivineTianShancClgNormalView:bindEvents()
	DivineTianShancClgNormalView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnBuff, self._onClickBuff, self)
	GameUtil.addClickHandler(self._btnFight, self._onClickFight, self)
	GameUtil.addClickHandler(self._btnPreview, self._onClickPreview, self)

	for i, cell in ipairs(self._zoneList) do
		GameUtil.addClickHandler(cell.go, GameUtil.handler(self._switchZoneById, self, i))
	end
end

function DivineTianShancClgNormalView:buildUI()
	DivineTianShancClgNormalView.super.buildUI(self)

	self._btnBuff = self:getGo("btnBuff")
	self._btnFight = self:getGo("btnFight")
	self._btnClose = self:getGo("leftTop/btnClose")
	self._btnPreview = self:getGo("btnPreview")
	self._roleCon = self:getGo("role")
	self._txtNumTimes = self:getTxt("times/txtNum")
	self._zoneList = {}

	for i = 1, 4 do
		local cell = {}

		cell.go = self:getGo("zones/zone_" .. i)
		cell.txt = goutil.findChildTextComponent(cell.go, "txt")
		cell.pass = goutil.findChild(cell.go, "pass")
		cell.leftHp = goutil.findChild(cell.go, "leftHp")
		cell.select = goutil.findChild(cell.go, "select")
		cell.txtLeftHp = goutil.findChildTextComponent(cell.leftHp, "txt")
		self._zoneList[i] = cell
	end

	local cellProgress = self:getGo("prize/cell")
	local tabProgress = self:getGo("prize/tableview")

	self._tableviewProgress = ScrollerList.create(tabProgress, cellProgress, GameUtil.handler(self._updateProgressCell, self), GameUtil.handler(self._clearProgressCell, self))
	self._progressBar = self:getSlider("prize/tableview/viewport/content/progressBar")
	self._txtDamageNum = self:getTxt("prize/damageNum/txtNum")
	self._txtInfo = self:getTxt("infoCol/sv/Viewport/txt")
	self._txtInfoTitle = self:getTxt("infoCol/title/txt")
end

function DivineTianShancClgNormalView:onExit()
	DivineTianShancClgNormalView.super.onExit(self)

	if self._role then
		self._role = RoleObjectPool.instance:removeRole(self._role)
		self._role = nil
	end

	self._curZoneId = nil
end

function DivineTianShancClgNormalView:onEnter()
	DivineTianShancClgNormalView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.DivineTianShanClgGainNormalPrize, self._handleGainPrize, self)

	self._activityId = checknumber(self:getFirstParam())

	self:_updateUIByCfg()
	self:_updateUIByInfo()

	for i, cell in ipairs(self._zoneList) do
		local stageInfo = self._stageInfoMap[i]
		local isPass = stageInfo and checknumber(stageInfo.leftHp) <= 0

		if not isPass then
			self:_switchZoneById(i)

			break
		end
	end

	if not self._curZoneId then
		self:_switchZoneById(1)
	end
end

function DivineTianShancClgNormalView:_onClickBuff()
	UIStateManager.instance:push(ViewName.DivineTianShanClgrBuffView, self._activityId, self._curZoneId)
end

function DivineTianShancClgNormalView:_onClickFight()
	if self._leftTimes <= 0 then
		TipsFacade.instance:openCommonTips("今日次数已用完")

		return
	end

	local stageInfo = self._stageInfoMap[self._curZoneId]
	local isPass = stageInfo and checknumber(stageInfo.leftHp) <= 0

	if isPass then
		TipsFacade.instance:openCommonTips("当前关卡已通关")

		return
	end

	DivineTianShanClgController.instance:openNormalMissionView(self._activityId, self._curZoneId, false)
end

function DivineTianShancClgNormalView:_onClickPreview()
	DivineTianShanClgController.instance:openNormalMissionView(self._activityId, self._curZoneId, true)
end

function DivineTianShancClgNormalView:_switchZoneById(id)
	self._curZoneId = id

	local stageCfg = self._stageCfgs[self._curZoneId]

	self._txtInfo.text = stageCfg.stageDesc
	self._txtInfoTitle.text = stageCfg.stageName

	GameUtil.setAnchoredPos(self._txtInfo.gameObject, 0, 0)

	if self._role then
		self._role = RoleObjectPool.instance:removeRole(self._role)
		self._role = nil
	end

	if not stageCfg.display then
		local display = {}

		self._role = RoleObjectPool.instance:addRoleToParent(self._role, stageCfg.lihuiId, self._roleCon, display[3], nil, true, display[1], display[2])

		for i, cell in ipairs(self._zoneList) do
			goutil.setActive(cell.select, i == self._curZoneId)
		end
	end
end

function DivineTianShancClgNormalView:_updateUIByCfg()
	self._actCfg = DivineTianShanClgConfig.instance:getActCfgById(self._activityId)
	self._normalCfg = DivineTianShanClgConfig.instance:getNormalClgPlanCfg(self._actCfg.normalClgPlanId)
	self._stageCfgs = DivineTianShanClgConfig.instance:getNormalStagePlanCfgs(self._normalCfg.stagePlanId)
	self._prizeCfgs = DivineTianShanClgConfig.instance:getNormalPrizeCfgs(self._normalCfg.prizePlanId)

	for i, cell in ipairs(self._zoneList) do
		local cfg = self._stageCfgs[i]

		if cfg then
			cell.txt.text = cfg.stageName
		end
	end
end

function DivineTianShancClgNormalView:_updateUIByInfo()
	local baseInfo = DivineTianShanClgModel.instance:getBaseInfo(self._activityId)

	self._info = baseInfo and baseInfo.normalClgInfo

	if not self._info then
		return
	end

	self._stageInfoMap = DivineTianShanClgModel.instance:getNormalStageMap(self._activityId)
	self._totalHp = 0
	self._leftHp = 0

	for i, stageInfo in pairs(self._stageInfoMap) do
		self._totalHp = self._totalHp + checknumber(stageInfo.totalDamage)
		self._leftHp = self._leftHp + checknumber(stageInfo.leftHp)

		local cell = self._zoneList[i]

		if cell then
			local leftHp = checknumber(stageInfo.leftHp)

			if leftHp <= 0 then
				cell.pass:SetActive(true)

				cell.txtLeftHp.text = lang("剩余血量:0")
			else
				cell.pass:SetActive(false)

				cell.txtLeftHp.text = leftHp >= 10000 and string.format("剩余血量:%s万(%s%%)", Mathf.Ceil(leftHp / 10000), Mathf.Ceil(leftHp / checknumber(stageInfo.totalDamage) * 100)) or string.format("剩余血量:%s(%s%%)", leftHp, Mathf.Ceil(leftHp / checknumber(stageInfo.totalDamage) * 100))
			end
		end
	end

	self._totalDamage = self._totalHp - self._leftHp
	self._txtDamageNum.text = self._totalDamage >= 10000 and string.format("%s万", Mathf.Floor((checknumber(self._totalDamage / 10000)))) or self._totalDamage
	self._gainPrizeIds = self._info.gainPrizeIds or {}

	self._tableviewProgress:reloadData(self._prizeCfgs)

	local scoreList = {}

	for i, v in ipairs(self._prizeCfgs) do
		table.insert(scoreList, checknumber(v.damage))
	end

	self._tableviewProgress:updateUnderSlider(self._progressBar, self._totalDamage, scoreList)

	self._leftTimes = self._normalCfg.dailyFightTimesLimit - self._info.todayFightTimes
	self._txtNumTimes.text = string.format("今日剩余次数：%s/%s", self._leftTimes, self._normalCfg.dailyFightTimesLimit)
end

function DivineTianShancClgNormalView:_handleGainPrize()
	self:_updateUIByInfo()
end

function DivineTianShancClgNormalView:_updateProgressCell(view, cellGo, data)
	local goEffect = goutil.findChild(cellGo, "effect")

	self:_clearCellEffect(goEffect)

	local goItem = goutil.findChild(cellGo, "item")

	MaterialMgr.resetAll(goItem)
	MaterialMgr.setCellByCfg(data.prize, goItem)

	local txtNum = goutil.findChildTextComponent(cellGo, "txtNum")
	local damage = checknumber(data.damage)

	txtNum.text = damage >= 10000 and string.format("%s万", checknumber(damage / 10000)) or data.damage

	local isGain = table.keyof(self._gainPrizeIds, data.prizeId)
	local isMatchGain = not isGain and self._totalDamage >= checknumber(data.damage)
	local btnGet = goutil.findChild(cellGo, "btnGet")

	goutil.setActive(btnGet, isMatchGain)

	if isMatchGain then
		self:_playCellEffect(goEffect)
		GameUtil.addClickHandler(btnGet, GameUtil.handler(self._onClickGainPrize, self, data))
	end

	local goGeted = goutil.findChild(cellGo, "geted")

	goutil.setActive(goGeted, isGain)
end

function DivineTianShancClgNormalView:_clearProgressCell(view, cellGo)
	local goEffect = goutil.findChild(cellGo, "effect")

	self:_clearCellEffect(goEffect)

	local goItem = goutil.findChild(cellGo, "item")

	MaterialMgr.resetAll(goItem)

	local btnGet = goutil.findChild(cellGo, "btnGet")

	GameUtil.rmClickHandler(btnGet)
end

function DivineTianShancClgNormalView:_playCellEffect(effGo)
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

function DivineTianShancClgNormalView:_clearCellEffect(effGo)
	if self._cellEffects and self._cellEffects[effGo] then
		UIEffectManager.instance:stopEffect(self._cellEffects[effGo])

		self._cellEffects[effGo] = nil
	end
end

function DivineTianShancClgNormalView:_onClickGainPrize(data)
	DivineTianShanClgController.instance:gainNormalPrize(self._activityId, data.prizeId)
end

return DivineTianShancClgNormalView
