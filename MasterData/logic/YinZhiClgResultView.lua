-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/yinzhiclg/view/YinZhiClgResultView.lua

module("logic.extensions.yinzhiclg.view.YinZhiClgResultView", package.seeall)

local YinZhiClgResultView = class("YinZhiClgResultView", ViewComponent)

function YinZhiClgResultView:ctor()
	YinZhiClgResultView.super.ctor(self)
end

function YinZhiClgResultView:unbindEvents()
	YinZhiClgResultView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnCancel)
	GameUtil.rmClickHandler(self._btnSure)
end

function YinZhiClgResultView:bindEvents()
	YinZhiClgResultView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnSure, GameUtil.handler(self._onClickClose, self, true))
	GameUtil.addClickHandler(self._btnCancel, GameUtil.handler(self._onClickClose, self, false))
end

function YinZhiClgResultView:buildUI()
	YinZhiClgResultView.super.buildUI(self)

	self._btnCancel = self:getGo("btnCancel")
	self._btnSure = self:getGo("btnSure")
	self._curShowItemsCellList = {}

	for i = 1, 7 do
		local cell = {}

		cell.go = self:getGo("history/showItems/showItem_" .. i)
		cell.attr = goutil.findChildComponent(cell.go, "attr", "UIImageSpriteChange")
		cell.txt = goutil.findChildTextComponent(cell.go, "txt")
		self._curShowItemsCellList[i] = cell
	end

	self._curTxtNum = self:getTxt("history/txtNum")
	self._newShowItemsCellList = {}

	for i = 1, 7 do
		local cell = {}

		cell.go = self:getGo("new/showItems/showItem_" .. i)
		cell.attr = goutil.findChildComponent(cell.go, "attr", "UIImageSpriteChange")
		cell.txt = goutil.findChildTextComponent(cell.go, "txt")
		self._newShowItemsCellList[i] = cell
	end

	self._newTxtNum = self:getTxt("new/txtNum")
end

function YinZhiClgResultView:onExit()
	YinZhiClgResultView.super.onExit(self)
end

function YinZhiClgResultView:onEnter()
	YinZhiClgResultView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.YinZhiClgConfirmResult, self._handleConfirmResult, self)

	self._lastResult = self:getFirstParam()

	if self._lastResult then
		self._activityId = checknumber(self._lastResult.activityId)

		if self._activityId <= 0 then
			self._activityId = 486001
		end

		local lastStageId = self._lastResult.stageId
		local lastPhaseId = self._lastResult.phaseId
		local phaseCfg = YinZhiClgConfig.instance:getPhaseCfgByPhaseId(self._activityId, lastPhaseId)
		local curBaseInfo = YinZhiClgModel.instance:getBaseInfo(self._activityId)

		if not curBaseInfo.stages then
			if not self._lastResult.attributes then
				local lastAttributes = {}
				local curMinNum, newMinNum
				local temNum = 0
				local curShowItemInfoMap, newShowItemInfoMap = {}, {}

				for _, stageInfo in ipairs(curBaseInfo.stages) do
					if stageInfo.stageId == lastStageId then
						for k, attributeInfo in ipairs(stageInfo.attributes) do
							temNum = curShowItemInfoMap[attributeInfo.attributeId] or 0
							temNum = temNum + attributeInfo.num
							curShowItemInfoMap[attributeInfo.attributeId] = temNum
						end
					else
						for k, attributeInfo in ipairs(stageInfo.attributes) do
							temNum = curShowItemInfoMap[attributeInfo.attributeId] or 0
							temNum = temNum + attributeInfo.num
							curShowItemInfoMap[attributeInfo.attributeId] = temNum
							temNum = newShowItemInfoMap[attributeInfo.attributeId] or 0
							temNum = temNum + attributeInfo.num
							newShowItemInfoMap[attributeInfo.attributeId] = temNum
						end
					end
				end

				for k, attributeInfo in ipairs(lastAttributes) do
					temNum = newShowItemInfoMap[attributeInfo.attributeId] or 0
					temNum = temNum + attributeInfo.num
					newShowItemInfoMap[attributeInfo.attributeId] = temNum
				end

				for i = 1, #self._curShowItemsCellList do
					if not curShowItemInfoMap[i] then
						local num = 0

						curMinNum = curMinNum and Mathf.Min(curMinNum, num) or num
					end
				end

				for i = 1, #self._newShowItemsCellList do
					if not newShowItemInfoMap[i] then
						local num = 0

						newMinNum = newMinNum and Mathf.Min(newMinNum, num) or num
					end
				end

				if phaseCfg then
					if not phaseCfg.targetValue then
						local targetValue = 0
						local colorGreen = "#73fca6ff"
						local colorRed = "#eb4642ff"
						local strColor = ""

						strColor = curMinNum < targetValue and colorRed or colorGreen
						self._curTxtNum.text = string.format("%s(<color=%s>%s</color>/%s)", targetValue, strColor, curMinNum, targetValue)
						strColor = newMinNum < targetValue and colorRed or colorGreen
						self._newTxtNum.text = string.format("%s(<color=%s>%s</color>/%s)", targetValue, strColor, newMinNum, targetValue)

						for i, cell in ipairs(self._curShowItemsCellList) do
							cell.attr:SetState(i - 1)

							if not curShowItemInfoMap[i] then
								local num = 0

								cell.txt.text = string.format("X %s", num)
							end
						end

						for i, cell in ipairs(self._newShowItemsCellList) do
							cell.attr:SetState(i - 1)

							if not newShowItemInfoMap[i] then
								local num = 0

								cell.txt.text = string.format("X %s", num)
							end
						end
					end
				end
			end
		end
	else
		self:_handleConfirmResult()
	end
end

function YinZhiClgResultView:_onClickClose(isSaveData)
	YinZhiClgController.instance:confirmResult(self._activityId, isSaveData)
end

function YinZhiClgResultView:_handleConfirmResult()
	self:close()
	BattleController.instance:endBattle()
end

return YinZhiClgResultView
