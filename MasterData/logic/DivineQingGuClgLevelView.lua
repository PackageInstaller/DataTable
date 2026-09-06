-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divineqingguclg/view/DivineQingGuClgLevelView.lua

module("logic.extensions.divineqingguclg.view.DivineQingGuClgLevelView", package.seeall)

local DivineQingGuClgLevelView = class("DivineQingGuClgLevelView", ViewComponent)

function DivineQingGuClgLevelView:ctor()
	DivineQingGuClgLevelView.super.ctor(self)
end

function DivineQingGuClgLevelView:buildUI()
	DivineQingGuClgLevelView.super.buildUI(self)

	self._btnClose = self:getBtn("leftTop/btnClose")
	self._txtDesc = self:getTxt("rules/tableview/viewport/content/txtDesc")
	self._txtCoin = self:getTxt("reward/txtCoin")
	self._icon = self:getGo("reward/icon")
	self._levelList = {}

	for i = 1, DivineQingGuClgModel.MaxLevelNum do
		local go = self:getGo("levels/level" .. i)
		local element = {}

		element.btn = goutil.findChild(go, "btn")
		element.txt = goutil.findChildTextComponent(go, "btn/txt")
		element.passGo = goutil.findChild(go, "btn/pass")

		table.insert(self._levelList, element)
	end
end

function DivineQingGuClgLevelView:bindEvents()
	DivineQingGuClgLevelView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)

	for i, v in ipairs(self._levelList) do
		GameUtil.addClickHandler(v.btn, function()
			self:_onClickLevel(i)
		end)
	end
end

function DivineQingGuClgLevelView:unbindEvents()
	DivineQingGuClgLevelView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)

	for i, v in ipairs(self._levelList) do
		GameUtil.rmClickHandler(v.btn)
	end
end

function DivineQingGuClgLevelView:onEnter()
	DivineQingGuClgLevelView.super.onEnter(self)

	self._activityId = self:getFirstParam()
	self._cfgActivity = DivineQingGuClgConfig.instance:getActivityCfg(self._activityId)

	self:_initText()
	self:_initLevels()
end

function DivineQingGuClgLevelView:onExit()
	DivineQingGuClgLevelView.super.onExit(self)
	self:_clearIcon()
end

function DivineQingGuClgLevelView:_onClickLevel(stageId)
	if DivineQingGuClgModel.instance:isPassStage(self._activityId, stageId) then
		FloatWordMgr.instance:show("已通关")
	else
		DivineQingGuClgController.instance:openMissionView(self._activityId, stageId)
	end
end

function DivineQingGuClgLevelView:_initText()
	self._txtDesc.text = DivineQingGuClgConfig.instance:getCommonValue("TEXT_DESC1")
	self._txtCoin.text = DivineQingGuClgConfig.instance:getCommonValue("TEXT_DESC2")

	local matType, cfgId = MaterialMgr.getMatParams(self._cfgActivity.coin)

	MaterialMgr.setIcon(self._icon, matType, cfgId)
end

function DivineQingGuClgLevelView:_clearIcon()
	MaterialMgr.clearIcon(self._icon)
end

function DivineQingGuClgLevelView:_initLevels()
	for stageId, cell in ipairs(self._levelList) do
		local cfg = DivineQingGuClgConfig.instance:getStage(self._activityId, stageId)

		if cfg then
			cell.txt.text = cfg.name

			goutil.setActive(cell.passGo, DivineQingGuClgModel.instance:isPassStage(self._activityId, stageId))
		end
	end
end

return DivineQingGuClgLevelView
