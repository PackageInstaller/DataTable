-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roguelike/view/RoguelikeselectbuffView.lua

module("logic.extensions.roguelike.view.RoguelikeselectbuffView", package.seeall)

local RoguelikeselectbuffView = class("RoguelikeselectbuffView", ViewComponent)

function RoguelikeselectbuffView:ctor()
	RoguelikeselectbuffView.super.ctor(self)
end

function RoguelikeselectbuffView:buildUI()
	RoguelikeselectbuffView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._btnGet = self:getBtn("btnGet")
	self._btnChange = self:getBtn("btnChange")
	self._txtCost = self:getTxt("txtCost")
	self._icon = self:getGo("txtCost/icon")
	self._txtBuffNums = self:getTxt("buffNums")
	self._mapRoot = self:getGo("cellRoot")
	self._cell = self:getGo("cell")

	goutil.setActive(self._cell, false)

	self._cellList = {}

	GameUtil.SetActive(self._btnClose, false)
end

function RoguelikeselectbuffView:bindEvents()
	RoguelikeselectbuffView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnGet, self._onClickGet, self)
	GameUtil.addClickHandler(self._btnChange, self._onClickChange, self)
end

function RoguelikeselectbuffView:unbindEvents()
	RoguelikeselectbuffView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnGet)
	GameUtil.addClickHandler(self._btnChange)
end

function RoguelikeselectbuffView:onEnter()
	RoguelikeselectbuffView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.RoguelikeRerandomDropBuffRes, self._onRerandomDropBuffRes, self)
	self.addGEvent(self, GlobalNotify.RoguelikeSelectDropBuffRes, self._onSelectDropBuffRes, self)

	local params = self:getOpenParam()

	self._activityId = params[1]
	self._phaseId = params[2]
	self._isNormal = params[3]
	self._isRefresh = params[4]

	if self._isNormal then
		local var_5_0 = RoguelikeModel.instance:getNormalPassNum(self._activityId, self._phaseId)

		if not var_5_0 then
			var_5_0 = RoguelikeModel.instance:getExtraPassNum(self._activityId, self._phaseId)

			local passNum = var_5_0

			self._curStageId = passNum + 1
			self._cfgPhase = RoguelikeConfig.instance:getPhaseCfg(self._activityId, self._phaseId)

			if self._isNormal then
				self._reRandomPlanId = self._cfgPhase.normalRerandomPlanId or self._cfgPhase.extRerandomPlanId
			end

			self._curBuffCount = 1
			self._buffMaxCount = self._isRefresh and RoguelikeController.instance:getTargetBuffCount(self._activityId, self._phaseId, self._curStageId, true) or self._isNormal and 1 or RoguelikeController.instance:getTargetBuffCount(self._activityId, self._phaseId, self._curStageId, false)

			self:_updateView()
		end
	end
end

function RoguelikeselectbuffView:onExit()
	RoguelikeselectbuffView.super.onExit(self)
	self:_resetCells()
	self:_stopSelectEffect()
	self:_clearCoinIcon()
end

function RoguelikeselectbuffView:_onClickChange()
	local reRandomCount = RoguelikeModel.instance:getReRandomCount(self._activityId, self._phaseId)
	local cfg = RoguelikeConfig.instance:getReRandomCfg(self._activityId, self._reRandomPlanId, reRandomCount + 1)

	if not MaterialMgr.getMatEnough(cfg.cost) then
		local name = MaterialMgr.getMaterialsNameByCfg(cfg.cost)

		FloatWordMgr.instance:show(string.format("%s 资源不足", name))

		return
	end

	local matType, id, matNum = MaterialMgr.getMatParams(cfg.cost)
	local content = string.format("确定要花费%d%s换一批圣器么？", matNum, MaterialMgr.getMaterialsName(matType, id))

	TipsFacade.instance:openPopupCostMatViewNew(matType, id, matNum, content, function()
		RoguelikeAgent.instance:sendPM_RoguelikeRerandomDropBuffReq(self._activityId, self._phaseId)
	end)
end

function RoguelikeselectbuffView:_onClickGet()
	if RoguelikeModel.instance:isNeedSelectBuff(self._activityId, self._phaseId) then
		RoguelikeAgent.instance:sendPM_RoguelikeSelectDropBuffReq(self._activityId, self._phaseId, self._selectBuffId)
	else
		FloatWordMgr.instance:show("已完成选择")
	end
end

function RoguelikeselectbuffView:_onRerandomDropBuffRes()
	self:_updateView()
end

function RoguelikeselectbuffView:_onSelectDropBuffRes()
	self._curBuffCount = self._curBuffCount + 1

	if RoguelikeModel.instance:isNeedSelectBuff(self._activityId, self._phaseId) then
		self:_updateView()
	else
		self:close()
	end
end

function RoguelikeselectbuffView:_initCells(buffIds)
	local buffCount = #buffIds

	self:_resetCells()

	for i = 1, buffCount do
		if not self._cellList[i] then
			local go = goutil.cloneAndSetParent(self._cell, self._mapRoot.transform, "cell" .. i)

			GameUtil.SetActive(go, true)

			local element = {}

			element.go = go
			element.level = goutil.findChild(go, "level")
			element.btn = goutil.findChild(go, "btn")
			element.txtName = goutil.findChildTextComponent(go, "txtName")
			element.icon = goutil.findChild(go, "icon")
			element.buffIcon = goutil.findChild(go, "buffIcon")
			element.txtDesc = goutil.findChildTextComponent(go, "View/Viewport/Content/txtDesc")

			table.insert(self._cellList, element)
		else
			GameUtil.SetActive(self._cellList[i].go, true)
		end
	end
end

function RoguelikeselectbuffView:_resetCells()
	for i, v in ipairs(self._cellList) do
		GameUtil.SetActive(v.go, false)
		GameUtil.rmClickHandler(v.btn)
	end
end

function RoguelikeselectbuffView:_updateCellInfos(buffIds)
	for i = 1, #buffIds do
		local element = self._cellList[i]
		local buffId = buffIds[i]
		local cfgDropBuff = RoguelikeConfig.instance:getDropBuff(self._activityId, buffId)

		element.txtName.text = cfgDropBuff.buffName
		element.txtDesc.text = cfgDropBuff.buffDesc

		if self._selectBuffIndex == i then
			self:_playSelectEffect(element.go)
		end

		uGuiUtil.setSpriteToImage(element.buffIcon, uGuiUtil.SpriteType.BigBg, GameUrl.getExpEventUrl(cfgDropBuff.iconPath))
		GameUtil.addClickHandler(element.btn, function()
			printInfo("test 当前选择buffId = ", buffId)

			self._selectBuffIndex = i
			self._selectBuffId = buffId

			self:_playSelectEffect(element.go)
		end)
	end
end

function RoguelikeselectbuffView:_updateView()
	self:_stopSelectEffect()

	self._selectBuffIndex = 1

	local buffIds = RoguelikeModel.instance:getSelectDropBuffs(self._activityId, self._phaseId)

	self._selectBuffId = buffIds[self._selectBuffIndex]

	self:_initCells(buffIds)
	self:_updateCellInfos(buffIds)
	self:_updateCoinInfo()
	self:_updateBuffNums()
end

function RoguelikeselectbuffView:_playSelectEffect(go)
	self:_stopSelectEffect()

	local eff = UIEffectManager.instance:playEffectBrief(self, "fx_ui_yuanzheng/fx_ui_yuanzheng_xuanka.prefab", go.transform, true)

	eff:setParent(go.transform)
	eff:setLocalPos(0, 0, 0)
	eff:setScale(1)
	eff:setSortingOrder(220)

	self._selectEff = eff
end

function RoguelikeselectbuffView:_stopSelectEffect()
	if self._selectEff then
		UIEffectManager.instance:stopEffect(self._selectEff)

		self._selectEff = nil
	end
end

function RoguelikeselectbuffView:_updateCoinInfo()
	local reRandomCount = RoguelikeModel.instance:getReRandomCount(self._activityId, self._phaseId)
	local cfg = RoguelikeConfig.instance:getReRandomCfg(self._activityId, self._reRandomPlanId, reRandomCount + 1)
	local matType, id, matNum = MaterialMgr.getMatParams(cfg.cost)

	MaterialMgr.setIcon(self._icon, matType, id)

	self._txtCost.text = matNum
end

function RoguelikeselectbuffView:_clearCoinIcon()
	MaterialMgr.clearIcon(self._icon)
end

function RoguelikeselectbuffView:_updateBuffNums()
	self._txtBuffNums.text = string.format("扫荡后圣器选择数量（%d/%d）", self._curBuffCount, self._buffMaxCount)
end

return RoguelikeselectbuffView
