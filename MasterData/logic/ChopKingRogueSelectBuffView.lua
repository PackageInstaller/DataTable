-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/chopking/view/ChopKingRogueSelectBuffView.lua

module("logic.extensions.chopking.view.ChopKingRogueSelectBuffView", package.seeall)

local ChopKingRogueSelectBuffView = class("ChopKingRogueSelectBuffView", ViewComponent)

function ChopKingRogueSelectBuffView:ctor()
	ChopKingRogueSelectBuffView.super.ctor(self)
end

function ChopKingRogueSelectBuffView:buildUI()
	ChopKingRogueSelectBuffView.super.buildUI(self)

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

function ChopKingRogueSelectBuffView:bindEvents()
	ChopKingRogueSelectBuffView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnGet, self._onClickGet, self)
	GameUtil.addClickHandler(self._btnChange, self._onClickChange, self)
end

function ChopKingRogueSelectBuffView:unbindEvents()
	ChopKingRogueSelectBuffView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnGet)
	GameUtil.addClickHandler(self._btnChange)
end

function ChopKingRogueSelectBuffView:onEnter()
	ChopKingRogueSelectBuffView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.PM_ChopKingRerandomDropBuffRes, self._onRerandomDropBuffRes, self)
	self.addGEvent(self, GlobalNotify.PM_ChopKingSelectDropBuffRes, self._onSelectDropBuffRes, self)

	local params = self:getOpenParam()

	self._activityId = params[1]
	self._isRefresh = params[2]

	local passNum = ChopKingModel.instance:getRoguePassNum(self._activityId)

	self._curStageId = passNum + 1
	self._curBuffCount = 1
	self._buffMaxCount = self._isRefresh and ChopKingController.instance:getTargetBuffCount(self._activityId, self._curStageId) or 1

	self:_updateView()
end

function ChopKingRogueSelectBuffView:onExit()
	ChopKingRogueSelectBuffView.super.onExit(self)
	self:_resetCells()
	self:_stopSelectEffect()
	self:_clearCoinIcon()
end

function ChopKingRogueSelectBuffView:_onClickChange()
	local reRandomCount = ChopKingModel.instance:getReRandomCount(self._activityId)
	local cfg = ChopKingConfig.instance:getFirstClgReRandomCfg(self._activityId, reRandomCount + 1)

	if not MaterialMgr.getMatEnough(cfg.cost) then
		local name = MaterialMgr.getMaterialsNameByCfg(cfg.cost)

		FloatWordMgr.instance:show(string.format("%s 资源不足", name))

		return
	end

	local matType, id, matNum = MaterialMgr.getMatParams(cfg.cost)
	local content = string.format("确定要花费%d%s换一批圣器么？", matNum, MaterialMgr.getMaterialsName(matType, id))

	TipsFacade.instance:openPopupCostMatViewNew(matType, id, matNum, content, function()
		ChopKingAgent.instance:sendPM_ChopKingRerandomDropBuffReq(self._activityId)
	end)
end

function ChopKingRogueSelectBuffView:_onClickGet()
	if ChopKingModel.instance:isNeedSelectBuff(self._activityId) then
		ChopKingAgent.instance:sendPM_ChopKingSelectDropBuffReq(self._activityId, self._selectBuffId)
	else
		FloatWordMgr.instance:show("已完成选择")
		self:close()
	end
end

function ChopKingRogueSelectBuffView:_onRerandomDropBuffRes()
	self:_updateView()
end

function ChopKingRogueSelectBuffView:_onSelectDropBuffRes()
	self._curBuffCount = self._curBuffCount + 1

	if ChopKingModel.instance:isNeedSelectBuff(self._activityId) then
		self:_updateView()
	else
		self:close()
	end
end

function ChopKingRogueSelectBuffView:_initCells(buffIds)
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

function ChopKingRogueSelectBuffView:_resetCells()
	for i, v in ipairs(self._cellList) do
		GameUtil.SetActive(v.go, false)
		GameUtil.rmClickHandler(v.btn)
	end
end

function ChopKingRogueSelectBuffView:_updateCellInfos(buffIds)
	for i = 1, #buffIds do
		local element = self._cellList[i]
		local buffId = buffIds[i]
		local cfgDropBuff = ChopKingConfig.instance:getDropBuff(self._activityId, buffId)

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

function ChopKingRogueSelectBuffView:_updateView()
	self:_stopSelectEffect()

	self._selectBuffIndex = 1

	local buffIds = ChopKingModel.instance:getSelectDropBuffs(self._activityId)

	self._selectBuffId = buffIds[self._selectBuffIndex]

	self:_initCells(buffIds)
	self:_updateCellInfos(buffIds)
	self:_updateCoinInfo()
	self:_updateBuffNums()
end

function ChopKingRogueSelectBuffView:_playSelectEffect(go)
	self:_stopSelectEffect()

	local eff = UIEffectManager.instance:playEffectBrief(self, "fx_ui_yuanzheng/fx_ui_yuanzheng_xuanka.prefab", go.transform, true)

	eff:setParent(go.transform)
	eff:setLocalPos(0, 0, 0)
	eff:setScale(1)
	eff:setSortingOrder(220)

	self._selectEff = eff
end

function ChopKingRogueSelectBuffView:_stopSelectEffect()
	if self._selectEff then
		UIEffectManager.instance:stopEffect(self._selectEff)

		self._selectEff = nil
	end
end

function ChopKingRogueSelectBuffView:_updateCoinInfo()
	local reRandomCount = ChopKingModel.instance:getReRandomCount(self._activityId, self._phaseId)
	local cfg = ChopKingConfig.instance:getFirstClgReRandomCfg(self._activityId, reRandomCount + 1)
	local matType, id, matNum = MaterialMgr.getMatParams(cfg.cost)

	MaterialMgr.setIcon(self._icon, matType, id)

	self._txtCost.text = matNum
end

function ChopKingRogueSelectBuffView:_clearCoinIcon()
	MaterialMgr.clearIcon(self._icon)
end

function ChopKingRogueSelectBuffView:_updateBuffNums()
	self._txtBuffNums.text = string.format("扫荡后圣器选择数量（%d/%d）", self._curBuffCount, self._buffMaxCount)
end

return ChopKingRogueSelectBuffView
