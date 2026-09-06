-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/fanruichallenge/view/FanRuiChallengeDestinyView.lua

module("logic.extensions.fanruichallenge.view.FanRuiChallengeDestinyView", package.seeall)

local FanRuiChallengeDestinyView = class("FanRuiChallengeDestinyView", ViewComponent)

function FanRuiChallengeDestinyView:buildUI()
	FanRuiChallengeDestinyView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._btnForecast = self:getBtn("stageInfo/btnForecast")
	self._btnChallenge = self:getBtn("stageInfo/btnChallenge")
	self._itemList = {}

	for i = 1, 3 do
		local cell = {}
		local path = "stage" .. i

		cell.pass = self:getGo(path .. "/pass")
		cell.select = self:getGo(path .. "/select")
		cell.headIcon = self:getGo(path .. "/headIcon")

		table.insert(self._itemList, cell)
	end

	local stageInfo = self:getGo("stageInfo")

	self._txtTitle = goutil.findChildTextComponent(stageInfo, "txtTitle")
	self._txtDesc1 = goutil.findChildTextComponent(stageInfo, "txtDesc1")
	self.cellGo = goutil.findChild(stageInfo, "tablecell")
	self.scrollerGo1 = goutil.findChild(stageInfo, "tableview1")
	self._scrollList1 = ScrollerList.create(self.scrollerGo1, self.cellGo, GameUtil.handler(self._updateCell1, self), GameUtil.handler(self._clearCell1, self))
	self.scrollerGo2 = goutil.findChild(stageInfo, "tableview2")
	self._scrollList2 = ScrollerList.create(self.scrollerGo2, self.cellGo, GameUtil.handler(self._updateCell2, self), GameUtil.handler(self._clearCell2, self))
	self._txtRule = self:getTxt("txtRule")
end

function FanRuiChallengeDestinyView:bindEvents()
	FanRuiChallengeDestinyView.super.bindEvents(self)
	self._btnClose:AddClickListener(self.close, self)
	self._btnForecast:AddClickListener(self._onClickForecast, self)
	self._btnChallenge:AddClickListener(self._onClickChallenge, self)
end

function FanRuiChallengeDestinyView:unbindEvents()
	FanRuiChallengeDestinyView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
	self._btnForecast:RemoveClickListener()
	self._btnChallenge:RemoveClickListener()
end

function FanRuiChallengeDestinyView:onEnter()
	FanRuiChallengeDestinyView.super.onEnter(self)
	GlobalDispatcher:addListener(GlobalNotify.FanRuiClgChoiceFinish, self._onChoiceFinish, self)

	self._activityId = self:getFirstParam()
	self._cfgStages = FanRuiChallengeConfig.instance:getDestinyClgStageCfgList(self._activityId)
	self._passNum = FanRuiChallengeModel.instance:getDestinyPassProgress(self._activityId)
	self._maxNum = #self._cfgStages
	self._curStageIndex = Mathf.Clamp(self._passNum + 1, 1, self._maxNum)
	self._cfgStage = FanRuiChallengeConfig.instance:getDestinyClgStageCfg(self._activityId, self._curStageIndex)
	self._isPassAll = self._passNum >= self._maxNum
	self._planId = self._cfgStage.planId
	self._isForecast = false
	self._choiceId1 = 0
	self._choiceId2 = 0
	self._choiceId3 = 0
	self._choiceId1, self._choiceId2, self._choiceId3 = FanRuiChallengeController.instance:getForecastChoices(self._activityId)

	self:_initRule()
	self:_updateBtnsInfo()
	self:_updateCurStageInfo()
end

function FanRuiChallengeDestinyView:onExit()
	FanRuiChallengeDestinyView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.FanRuiClgChoiceFinish, self._onChoiceFinish, self)
	self:_clearImages()
end

function FanRuiChallengeDestinyView:_onClickForecast()
	UIStateManager.instance:push(ViewName.FanRuiChallengeBuffView, self._planId, self._choiceId1, self._choiceId2, self._choiceId3)
end

function FanRuiChallengeDestinyView:_onClickChallenge()
	if self._isPassAll then
		FloatWordMgr.instance:show("已通关所有关卡")
	elseif self._choiceId1 > 0 and self._choiceId2 > 0 and self._choiceId3 > 0 then
		local choiceIds = {}

		table.insert(choiceIds, self._choiceId1)
		table.insert(choiceIds, self._choiceId2)
		table.insert(choiceIds, self._choiceId3)
		FanRuiChallengeController.instance:openDestinyMissionView(self._activityId, self._curStageIndex, choiceIds, self._viewPresentor.viewName)
	else
		FloatWordMgr.instance:show("请先完成三项通关条件的预测")
	end
end

function FanRuiChallengeDestinyView:_onChoiceFinish(id1, id2, id3)
	self:_updateChoiceIds(id1, id2, id3)
	self:_updateForecastDesc()
end

function FanRuiChallengeDestinyView:_updateCell1(view, cell, data, tag)
	local node = goutil.findChild(cell, "node")
	local proxy = MaterialMgr.setCell(MatType.Pet, data.raceId, node)

	if proxy then
		proxy.binder:setAutoTips(false)
	end
end

function FanRuiChallengeDestinyView:_clearCell1(cell)
	local node = goutil.findChild(cell, "node")

	MaterialMgr.resetAll(node)
end

function FanRuiChallengeDestinyView:_updateCell2(view, cell, data, tag)
	local node = goutil.findChild(cell, "node")

	MaterialMgr.setCellByCfg(data, node)
end

function FanRuiChallengeDestinyView:_clearCell2(cell)
	local node = goutil.findChild(cell, "node")

	MaterialMgr.resetAll(node)
end

function FanRuiChallengeDestinyView:_updateBtnsInfo()
	for i = 1, 3 do
		local item = self._itemList[i]

		if item then
			goutil.setActive(item.select, self._curStageIndex == i)
			goutil.setActive(item.pass, i <= self._passNum)

			local cfg = FanRuiChallengeConfig.instance:getDestinyClgStageCfg(self._activityId, i)

			if cfg then
				local cfgCreeps = FanRuiChallengeConfig.instance:getCreepsCfgs(cfg.creepsMasterId)

				if cfgCreeps[1] then
					MaterialMgr.setIcon(item.headIcon, MatType.Pet, cfgCreeps[1].raceId)
				end
			end
		end
	end
end

function FanRuiChallengeDestinyView:_clearImages()
	for i, v in ipairs(self._itemList) do
		MaterialMgr.clearIcon(v.headIcon)
	end
end

function FanRuiChallengeDestinyView:_updateCurStageInfo()
	self._txtTitle.text = string.format("洞悉命运•第%d关", self._curStageIndex)

	if self._cfgStage then
		-- block empty
	end

	self:_updateForecastDesc()

	if self._cfgStage then
		if not string.nilorempty(self._cfgStage.title) then
			self._txtTitle.text = self._cfgStage.title
		end

		local cfgCreeps = FanRuiChallengeConfig.instance:getCreepsCfgs(self._cfgStage.creepsMasterId)

		self._scrollList1:reloadData(cfgCreeps)

		local arr = MaterialMgr.changeItemStrArr(self._cfgStage.passStagePrize)

		self._scrollList2:reloadData(arr)
	end
end

function FanRuiChallengeDestinyView:_updateForecastDesc()
	local text1 = FanRuiChallengeConfig.instance:getCommonValue("FANRUI_DESC1")
	local text2 = FanRuiChallengeConfig.instance:getCommonValue("FANRUI_DESC2")
	local text3 = FanRuiChallengeConfig.instance:getCommonValue("FANRUI_DESC3")
	local str = "1、%s：%s\n2、%s：%s\n3、%s：%s"
	local str1, str2, str3 = self:_getChoiceStrs()

	str = string.format(str, text1, str1, text2, str2, text3, str3)
	self._txtDesc1.text = str
end

function FanRuiChallengeDestinyView:_updateChoiceIds(id1, id2, id3)
	self._isForecast = true
	self._choiceId1 = id1
	self._choiceId2 = id2
	self._choiceId3 = id3

	FanRuiChallengeController.instance:saveForecastChoices(self._activityId, id1, id2, id3)
end

function FanRuiChallengeDestinyView:_getChoiceStrs()
	local cfg1 = FanRuiChallengeConfig.instance:getProjectedPlanCfg(self._planId, 1, self._choiceId1)
	local cfg2 = FanRuiChallengeConfig.instance:getProjectedPlanCfg(self._planId, 2, self._choiceId2)
	local cfg3 = FanRuiChallengeConfig.instance:getProjectedPlanCfg(self._planId, 3, self._choiceId3)
	local str1 = cfg1 and FanRuiChallengeController.instance:getRangeStr(cfg1.valueRange) or "未预测"
	local str2 = cfg2 and FanRuiChallengeController.instance:getRangeStr(cfg2.valueRange) or "未预测"
	local str3 = cfg3 and FanRuiChallengeController.instance:getRangeStr(cfg3.valueRange) or "未预测"

	return str1, str2, str3
end

function FanRuiChallengeDestinyView:_initRule()
	self._txtRule.text = FanRuiChallengeConfig.instance:getCommonValue("FANRUI_DESC4")
end

return FanRuiChallengeDestinyView
