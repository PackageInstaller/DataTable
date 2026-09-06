-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/view/lightking/LightKingBaseView.lua

module("logic.extensions.timelimitedchallenge.view.lightking.LightKingBaseView", package.seeall)

local LightKingBaseView = class("LightKingBaseView", TableViewComponent)

function LightKingBaseView:_getPath()
	return {
		cellPath = "tablecell",
		viewPath = "tableview"
	}
end

function LightKingBaseView:unbindEvents()
	LightKingBaseView.super.unbindEvents(self)
end

function LightKingBaseView:bindEvents()
	LightKingBaseView.super.bindEvents(self)
end

function LightKingBaseView:onExit()
	LightKingBaseView.super.onExit(self)

	self._needCenterOn = false
end

function LightKingBaseView:buildUI()
	LightKingBaseView.super.buildUI(self)

	self._txtDesc = self:getTxt("bottom/txtBuffDesc")
end

function LightKingBaseView:onEnter()
	LightKingBaseView.super.onEnter(self)

	self._challengeType = checknumber(self:getFirstParam())
	self._curViewDatas = LightKingConfig.instance:getStageCfgsByType(self._challengeType)
	self._needCenterOn = true

	self:reloadData()
	LightKingController.instance:showChangeSetId()

	local baseCfg = LightKingConfig.instance:getBaseDefineCfg(self._challengeType)

	self._txtDesc.text = baseCfg.desc
end

function LightKingBaseView:_updateCell(view, cell, data)
	local btn = goutil.findChild(cell.gameObject, "btn")

	GameUtil.addClickHandler(btn, function()
		self:_onClickCell(data)
	end)

	local txtLevel = goutil.findChildTextComponent(btn, "txtLevel")
	local finished = goutil.findChild(btn, "finished")
	local txtIconNum = goutil.findChildTextComponent(btn, "txtIconNum")
	local imgIcon = goutil.findChild(btn, "imgIcon")

	txtLevel.text = string.format("第%d关", data.stage)

	local curStage = LightKingModel.instance:getCurStage(self._challengeType)

	uGuiUtil.setGoGrayState(btn, data.stage > curStage + 1)
	finished:SetActive(curStage >= data.stage)

	txtIconNum.text = "x" .. data.score

	local matType, matId = LightKingModel.instance:getItemTypeAndId()

	MaterialMgr.setIcon(imgIcon, matType, matId)
end

function LightKingBaseView:_onClickCell(cfg)
	local curStage = LightKingModel.instance:getCurStage(self._challengeType)
	local leftTimes = LightKingController.instance:getLeftTimes(self._challengeType)

	if cfg.stage < curStage + 1 then
		FloatWordMgr.instance:show("已通关！")
	elseif cfg.stage > curStage + 1 then
		FloatWordMgr.instance:show("请先通过前面关卡！")
	elseif not self._dontCheckLeftTimes and leftTimes < 1 then
		LightKingController.instance:addTimes(self._challengeType, function()
			UIStateManager.instance:push(ViewName.LightKingMissionView)
		end)
	else
		UIStateManager.instance:push(ViewName.LightKingMissionView)
	end
end

function LightKingBaseView:_onReloadFinish()
	if self._needCenterOn then
		self._needCenterOn = false

		local curStage = LightKingModel.instance:getCurStage(self._challengeType)

		for k, v in ipairs(self._curViewDatas) do
			if v.stage == curStage + 1 then
				self._tableview:MoveCellToCebter(k - 1)
			end
		end
	end
end

return LightKingBaseView
