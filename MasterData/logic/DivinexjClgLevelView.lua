-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinexingjiangclg/view/DivinexjClgLevelView.lua

module("logic.extensions.divinexingjiangclg.view.DivinexjClgLevelView", package.seeall)

local DivinexjClgLevelView = class("DivinexjClgLevelView", ViewComponent)

function DivinexjClgLevelView:ctor()
	DivinexjClgLevelView.super.ctor(self)
end

function DivinexjClgLevelView:buildUI()
	DivinexjClgLevelView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._btnGame = self:getBtn("btnGame")

	local cellContainers = self:getGo("cellContainers")

	self._cellList = {}

	for i = 1, 12 do
		local go = self:getGo("cellContainers/cell" .. i)
		local cell = {}

		cell.btn = goutil.findChild(go, "btn")
		cell.iconChange = goutil.findChild(go, "btn/icon"):GetComponent(ComponentType.UIImageSpriteChange)
		cell.passGo = goutil.findChild(go, "btn/pass")
		cell.txtName = goutil.findChildTextComponent(go, "txtName")
		cell.txtPass = goutil.findChildTextComponent(go, "btn/pass/txt")

		table.insert(self._cellList, cell)
	end
end

function DivinexjClgLevelView:bindEvents()
	DivinexjClgLevelView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnGame, self._onClickGame, self)

	for i, v in ipairs(self._cellList) do
		GameUtil.addClickHandler(v.btn, GameUtil.handler(self._onClickCell, self, i))
	end
end

function DivinexjClgLevelView:unbindEvents()
	DivinexjClgLevelView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnGame)

	for i, v in ipairs(self._cellList) do
		GameUtil.rmClickHandler(v.btn)
	end
end

function DivinexjClgLevelView:onEnter()
	DivinexjClgLevelView.super.onEnter(self)

	self._activityId = self:getFirstParam()

	self:_initList()
end

function DivinexjClgLevelView:onExit()
	DivinexjClgLevelView.super.onExit(self)
end

function DivinexjClgLevelView:_onClickGame()
	UIStateManager.instance:push(ViewName.DivinexjClgGameEnterView, self._activityId)
end

function DivinexjClgLevelView:_onClickCell(stageId)
	local isPass = DivineXingJiangClgModel.instance:isPassStage(self._activityId, stageId)

	if isPass then
		local cfgStage = DivineXingJiangClgConfig.instance:getStageCfg(self._activityId, stageId)

		if cfgStage then
			FloatWordMgr.instance:show(string.format("%s 已通关", cfgStage.name))
		end

		return
	end

	UIStateManager.instance:push(ViewName.DivinexjClgInfoView, self._activityId, stageId)
end

function DivinexjClgLevelView:_initList()
	for i, v in ipairs(self._cellList) do
		self:_updateCell(v, i)
	end
end

function DivinexjClgLevelView:_updateCell(cell, stageId)
	local cfgStage = DivineXingJiangClgConfig.instance:getStageCfg(self._activityId, stageId)

	if not cfgStage then
		return
	end

	cell.txtName.text = "星座星图-" .. cfgStage.name

	cell.iconChange:SetState(stageId - 1)

	local isPass = DivineXingJiangClgModel.instance:isPassStage(self._activityId, cfgStage.stageId)
	local isActiveSelfAllPos = DivineXingJiangClgModel.instance:isActiveSelfStageAllPos(self._activityId, cfgStage.stageId)

	GameUtil.SetActive(cell.passGo, isPass or isActiveSelfAllPos)

	cell.txtPass.text = isPass and "已激活" or "已通关"
end

return DivinexjClgLevelView
