-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/judgmentdragonclg/view/JudgmentDragonClgStageResultView.lua

module("logic.extensions.judgmentdragonclg.view.JudgmentDragonClgStageResultView", package.seeall)

local JudgmentDragonClgStageResultView = class("JudgmentDragonClgStageResultView", ViewComponent)

function JudgmentDragonClgStageResultView:buildUI()
	JudgmentDragonClgStageResultView.super.buildUI(self)

	local descScrView = goutil.findChild(self.mainGO, "descScrView")
	local descScrCell = goutil.findChild(self.mainGO, "descScrCell")

	self._descScrollerList = ScrollerList.create(descScrView, descScrCell, GameUtil.handler(self._updateDescCell, self), GameUtil.handler(self._clearDescCell, self))
	self._customInput = UICustomInput.Get(self.mainGO)
end

function JudgmentDragonClgStageResultView:bindEvents()
	JudgmentDragonClgStageResultView.super.bindEvents(self)
	self._customInput:AddListener(function(self, hover)
		if not hover then
			self:close()
		end
	end, self)
end

function JudgmentDragonClgStageResultView:unbindEvents()
	JudgmentDragonClgStageResultView.super.unbindEvents(self)
	self._customInput:RemoveListener()
end

function JudgmentDragonClgStageResultView:onEnter()
	JudgmentDragonClgStageResultView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])
	self._phaseId = checknumber(params[2])
	self._activityType = JudgmentDragonClgController.instance:getActivityType()

	local isInTime = JudgmentDragonClgController.instance:isInActivityTime(self._activityId)

	if not isInTime then
		self:close()

		return
	end

	self:_onUpdateUI()
end

function JudgmentDragonClgStageResultView:onExit()
	JudgmentDragonClgStageResultView.super.onExit(self)
	self._descScrollerList:dispose()
end

function JudgmentDragonClgStageResultView:_onUpdateUI()
	local cfg = JudgmentDragonClgConfig.instance:getTerrainCfg(self._activityId, self._phaseId) or {}

	self._descScrollerList:reloadData(cfg)
end

function JudgmentDragonClgStageResultView:_updateDescCell(view, cell, data, tag)
	local index = cell.data
	local terrainId = data.terrainId
	local lastData = JudgmentDragonClgConfig.instance:getTerrainData(self._activityId, self._phaseId, terrainId - 1)
	local mainGo = cell.gameObject
	local bg = goutil.findChild(mainGo, "bg")
	local txtName = goutil.findChildTextComponent(mainGo, "txtName")
	local txtCount = goutil.findChildTextComponent(mainGo, "txtCount")
	local txtDesc = goutil.findChildTextComponent(mainGo, "txtDesc")

	txtName.text = data.name
	txtDesc.text = data.desc

	GameUtil.SetActive(bg, index % 2 == 0)

	local startCount = ((lastData and lastData.name == data.name or nil) and lastData.count) + 1
	local endCount = data.count

	txtCount.text = startCount == endCount and endCount or string.format("%s~%s", startCount, endCount)
end

function JudgmentDragonClgStageResultView:_clearDescCell(cell)
	return
end

return JudgmentDragonClgStageResultView
