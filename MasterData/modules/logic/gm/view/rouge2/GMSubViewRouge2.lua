-- chunkname: @modules/logic/gm/view/rouge2/GMSubViewRouge2.lua

module("modules.logic.gm.view.rouge2.GMSubViewRouge2", package.seeall)

local GMSubViewRouge2 = class("GMSubViewRouge2", GMSubViewBase)

require("tolua.reflection")
tolua.loadassembly("UnityEngine.UI")

local type_linetype = tolua.findtype("UnityEngine.UI.InputField+LineType")
local MultiLineNewline = System.Enum.Parse(type_linetype, "MultiLineNewline")

function GMSubViewRouge2:ctor()
	self.tabName = "肉鸽2"
end

function GMSubViewRouge2:addLineIndex()
	self.lineIndex = self.lineIndex + 1
end

function GMSubViewRouge2:getLineGroup()
	return "L" .. self.lineIndex
end

function GMSubViewRouge2:initViewContent()
	if self._inited then
		return
	end

	GMSubViewBase.initViewContent(self)

	self.lineIndex = 1

	self:addTitleSplitLine("GM")
	self.addButton(self, self:getLineGroup(), "进入肉鸽", self.onClickEnterRouge, self)
	self:initFinishCurEventGM()
	self:initMoveMaxStageGM()
	self:initBossBattleGM()
	self:initChangeNextNodeEventGM()
	self:initAddCoinGM()
	self:initAddRevivalCoinGM()
	self:initFixCheckGM()
	self:initAddAttrGM()
	self:initPrintItemGM()
	self:initPrintAttrGM()
	self:initPrintAttrExprGM()
	self:initAcceptEntrustGM()
	self:initSetEndGM()
	self:initDeleteMapGM()
	self:addLineIndex()
	self:addTitleSplitLine("地图编辑")
	self.addButton(self, self:getLineGroup(), "肉鸽路线层地图编辑", self.onClickNormalMapEditor, self)
	self.addButton(self, self:getLineGroup(), "肉鸽地图编辑", self.onClickRougeMapEditor, self)
	self.addButton(self, self:getLineGroup(), "肉鸽地图路线位置编辑", self.onClickRougeSelectMapEditor, self)

	self.showClickAreaTrigger = self.addToggle(self, self:getLineGroup(), "显示节点点击区域", self.onToggleValueChanged, self)

	self:addLineIndex()

	self.allowAbortFightTrigger = self.addToggle(self, self:getLineGroup(), "允许主动退出战斗", self.onAllowAbortFightToggleValueChanged, self)
	self.allowAbortFightTrigger.isOn = Rouge2_EditorController.instance:isAllowAbortFight()
	self.startRecordGc = self.addButton(self, self:getLineGroup(), "开始记录内存", self.onClickStartRecordGc, self)
	self.endRecordGc = self.addButton(self, self:getLineGroup(), "结束记录内存", self.onClickEndRecordGc, self)

	self:addTitleSplitLine("配置检查")
	self:addLineIndex()
	self.addButton(self, self:getLineGroup(), "事件总表配置的id在事件分表是否存在", self.checkAllEventExistInSubEvent, self)
	self:addTitleSplitLine("检查id在指定表是否存在")
	self:addLineIndex()

	self.inputExcelName = self:addInputText(self:getLineGroup(), "", "表名", nil, nil, {
		w = 300
	})
	self.inputCheckExcelFields = self:addInputText(self:getLineGroup(), "", "检查表excel.字段名", nil, nil, {
		w = 500,
		h = 500
	})
	self.inputCheckExcelFields.inputField.lineType = MultiLineNewline
	self.mathList = {
		"默认",
		"1#(%d+).*"
	}
	self.matchDrop = self:addDropDown(self:getLineGroup(), "匹配格式", self.mathList)

	self.addButton(self, self:getLineGroup(), "开始检查", self.startCheckExcel, self)
	self:addTitleSplitLine("剧情")
	self:addLineIndex()
	self.addButton(self, self:getLineGroup(), "清空肉鸽剧情", self._onClickClearRougeStories, self)
	self.addButton(self, self:getLineGroup(), "完成肉鸽剧情", self._onClickFinishRougeStories, self)
	self:addLineIndex()

	self._inpClearStoryValue = self:addInputText(self:getLineGroup(), "", "剧情id", nil, nil, {
		w = 1000
	})

	self.addButton(self, self:getLineGroup(), "重置剧情", self._onClickClearStory, self)
	self:addLineIndex()

	self._inpFinishStoryValue = self:addInputText(self:getLineGroup(), "", "剧情id", nil, nil, {
		w = 1000
	})

	self.addButton(self, self:getLineGroup(), "完成剧情", self._onClickFinishStory, self)
	self:addTitleSplitLine("属性检定")
	self:addLineIndex()

	self._inpAttrDiceValue = self:addInputText(self:getLineGroup(), "", "骰子id#点数|骰子id#点数", nil, nil, {
		w = 400
	})

	self.addButton(self, self:getLineGroup(), "属性检定", self._onClickAttrCheck, self)
end

function GMSubViewRouge2:onClickStartRecordGc()
	RougeProfileController.instance:startRecordMemory()
end

function GMSubViewRouge2:onClickEndRecordGc()
	RougeProfileController.instance:endRecord()
end

function GMSubViewRouge2:onClickNormalMapEditor()
	Rouge2_EditorController.instance:enterNormalLayerMapEditor()
	self:closeThis()
end

function GMSubViewRouge2:onClickRougeMapEditor()
	Rouge2_EditorController.instance:enterRougeMapEditor()
	self:closeThis()
end

function GMSubViewRouge2:onToggleValueChanged()
	if self.showClickAreaTrigger.isOn then
		Rouge2_EditorController.instance:showNodeClickArea()
	else
		Rouge2_EditorController.instance:hideNodeClickArea()
	end
end

function GMSubViewRouge2:onAllowAbortFightToggleValueChanged()
	Rouge2_EditorController.instance:allowAbortFight(self.allowAbortFightTrigger.isOn)
end

function GMSubViewRouge2:onClickRougeSelectMapEditor()
	Rouge2_EditorController.instance:enterPathSelectMapEditorView()
	self:closeThis()
end

function GMSubViewRouge2:checkAllEventExistInSubEvent()
	local allEvent = lua_rouge2_event.configList

	for _, eventCo in ipairs(allEvent) do
		local eventType = eventCo.type
		local eventId = eventCo.id
		local subEventCo

		if Rouge2_MapHelper.isFightEvent(eventType) then
			subEventCo = lua_rouge2_fight_event.configDict[eventId]

			if not lua_rouge2_fight_event.configDict[eventId] then
				logError("肉鸽战斗事件表不存在id : " .. tostring(eventId))
			end
		elseif Rouge2_MapHelper.isChoiceEvent(eventType) then
			if not Rouge2_MapConfig.instance:getChoiceListByEventId(eventId) then
				logError("肉鸽选项事件表不存在id : " .. tostring(eventId))
			end
		else
			logError(string.format("事件表id : %s, 配置了未知事件类型 : %s", eventId, eventType))
		end
	end

	GameFacade.showToastString("检查完毕")
end

function GMSubViewRouge2:startCheckExcel()
	local excelName = self.inputExcelName:GetText()
	local configDict = self:getExcelDataDict(excelName)

	if not configDict then
		return
	end

	local checkExcelStr = self.inputCheckExcelFields:GetText()
	local fields = string.split(checkExcelStr, "\n")
	local fieldList = {}

	for _, field in ipairs(fields) do
		if not string.nilorempty(field) then
			local excel, fieldName
			local splitArr = string.split(field, ".")

			table.insert(fieldList, {
				excel = splitArr[1],
				fieldName = string.trim(splitArr[2])
			})
		end
	end

	local mathIndex = self.matchDrop:GetValue()

	if mathIndex ~= 0 then
		if not self.mathList[mathIndex + 1] then
			local mathStr

			for _, field in ipairs(fieldList) do
				logWarn(string.format("开始检查 excel ： %s, 字段 : %s", field.excel, field.fieldName))

				local configList = self:getExcelDataList(field.excel)

				if configList then
					for _, co in ipairs(configList) do
						local value = co[field.fieldName]

						if value then
							value = tostring(value)

							if mathStr then
								value = string.match(value, mathStr)
							end

							if not string.nilorempty(value) then
								local valueList = string.splitToNumber(value, "|")

								for _, valueId in ipairs(valueList) do
									if not configDict[valueId] then
										logError(string.format("excel : %s, id : %s, 字段 : %s, 配置的id : '%s' 在 excel : '%s' 中不存在", field.excel, co.id, field.fieldName, valueId, excelName))
									end

									logNormal("check id : " .. tostring(valueId))
								end
							end
						else
							logError(string.format("excel : %s, 不存在 字段 : %s, id : %s", field.excel, field.fieldName, (co or nil) and (co.id or "nil")))
						end
					end
				end
			end
		end
	end
end

function GMSubViewRouge2:getExcelDataDict(excelName)
	local cls = _G["lua_" .. tostring(excelName)]

	if not cls then
		logError("配置表不存在 ：" .. tostring(excelName))

		return
	end

	local configDict = cls.configDict

	if not configDict then
		logError("配置表 configDict 不存在 ：" .. tostring(excelName))

		return
	end

	return configDict
end

function GMSubViewRouge2:getExcelDataList(excelName)
	local cls = _G["lua_" .. tostring(excelName)]

	if not cls then
		logError("配置表不存在 ：" .. tostring(excelName))

		return
	end

	local configList = cls.configList

	if not configList then
		logError("配置表 configDict 不存在 ：" .. tostring(excelName))

		return
	end

	return configList
end

function GMSubViewRouge2:_onClickClearRougeStories()
	for i, v in ipairs(lua_rouge2_story_list.configList) do
		local storyList = string.splitToNumber(v.storyIdList, "#")

		for _, id in ipairs(storyList) do
			GMRpc.instance:sendGMRequest(string.format("delete story %s", id))
		end
	end

	StoryRpc.instance:sendGetStoryRequest()
end

function GMSubViewRouge2:_onClickFinishRougeStories()
	for i, v in ipairs(lua_rouge2_story_list.configList) do
		local storyList = string.splitToNumber(v.storyIdList, "#")

		for _, id in ipairs(storyList) do
			StoryRpc.instance:sendUpdateStoryRequest(id, -1, 0)
		end
	end

	StoryRpc.instance:sendGetStoryRequest()
end

function GMSubViewRouge2:_onClickClearStory()
	local storyList = string.splitToNumber(self._inpClearStoryValue:GetText(), "#")

	for _, id in ipairs(storyList) do
		GMRpc.instance:sendGMRequest(string.format("delete story %s", id))
	end

	StoryRpc.instance:sendGetStoryRequest()
end

function GMSubViewRouge2:_onClickFinishStory()
	local storyList = string.splitToNumber(self._inpFinishStoryValue:GetText(), "#")

	for _, id in ipairs(storyList) do
		StoryRpc.instance:sendUpdateStoryRequest(id, -1, 0)
	end

	StoryRpc.instance:sendGetStoryRequest()
end

function GMSubViewRouge2:_onClickAttrCheck()
	local checkDiceRes = self._inpAttrDiceValue:GetText()
	local checkCo = lua_rouge2_dice_check.configList[1]
	local checkId = checkCo and checkCo.id
	local checkRes = Rouge2_MapEnum.AttrCheckResult.Succeed
	local checkResInfo = {
		checkCo = checkCo,
		checkResInfo = {
			checkId = checkId,
			checkRes = checkRes,
			checkDiceRes = checkDiceRes
		}
	}

	ViewMgr.instance:openView(ViewName.Rouge2_MapDiceView, checkResInfo)
end

function GMSubViewRouge2:initChangeNextNodeEventGM()
	self:addLineIndex()

	self._eventNameList = {}
	self._index2EventCoMap = {}

	local index = 0

	for _, eventCo in ipairs(lua_rouge2_event.configList) do
		index = index + 1

		local eventId = eventCo.id
		local eventName = eventCo.name

		table.insert(self._eventNameList, index, string.format("%s_%s", eventId, eventName))

		self._index2EventCoMap[index] = eventCo
	end

	self._eventDrop = self:addDropDown(self:getLineGroup(), "事件列表", self._eventNameList, nil, nil, {
		temp_w = 700,
		total_w = 900,
		drop_w = 700
	})

	self.addButton(self, self:getLineGroup(), "变化下个节点相邻事件", self._onClickChangeNextNodeEvent, self)
end

function GMSubViewRouge2:_onClickChangeNextNodeEvent()
	local mathIndex = self._eventDrop:GetValue()
	local eventCo = self._index2EventCoMap[mathIndex + 1]
	local eventId = eventCo and eventCo.id

	GMRpc.instance:sendGMRequest("rouge2ChangeNextNodeEvent " .. eventId)
end

function GMSubViewRouge2:initFinishCurEventGM()
	self.addButton(self, self:getLineGroup(), "完成当前普通层事件", self._onClickFinishCurEvent, self)
end

function GMSubViewRouge2:_onClickFinishCurEvent()
	GMRpc.instance:sendGMRequest("rouge2FinishCurEvent")
end

function GMSubViewRouge2:initMoveMaxStageGM()
	self.addButton(self, self:getLineGroup(), "移动到当前地图最后一个节点", self._onClickMoveMaxStage, self)
end

function GMSubViewRouge2:_onClickMoveMaxStage()
	GMRpc.instance:sendGMRequest("rouge2MoveMaxStage")
end

function GMSubViewRouge2:initAddCoinGM()
	self:addLineIndex()

	self._inputCoinValue = self:addInputText(self:getLineGroup(), 1, "金币变更数量", nil, nil, {
		w = 300
	})

	self.addButton(self, self:getLineGroup(), "变更金币数量", self._onClickAddCoin, self)
end

function GMSubViewRouge2:_onClickAddCoin()
	local coinNum = tonumber(self._inputCoinValue:GetText()) or 0

	GMRpc.instance:sendGMRequest("addRouge2Coin " .. coinNum)
end

function GMSubViewRouge2:initAddRevivalCoinGM()
	self:addLineIndex()

	self._inputRevivalCoinValue = self:addInputText(self:getLineGroup(), 1, "复活币变更数量", nil, nil, {
		w = 300
	})

	self.addButton(self, self:getLineGroup(), "变更复活币数量", self._onClickAddRevivalCoin, self)
end

function GMSubViewRouge2:_onClickAddRevivalCoin()
	local coinNum = tonumber(self._inputRevivalCoinValue:GetText()) or 0

	GMRpc.instance:sendGMRequest("addRouge2RevivalCoin " .. coinNum)
end

function GMSubViewRouge2:initFixCheckGM()
	self:addLineIndex()
	self:addLabel(self:getLineGroup(), "设置检定结果")
	self.addButton(self, self:getLineGroup(), "关闭检定", self._onClickFixCheck_None, self)
	self.addButton(self, self:getLineGroup(), "检定成功", self._onClickFixCheck_Succ, self)
	self.addButton(self, self:getLineGroup(), "检定失败", self._onClickFixCheck_Fail, self)
	self.addButton(self, self:getLineGroup(), "检定大成功", self._onClickFixCheck_BigSucc, self)
end

function GMSubViewRouge2:_onClickFixCheck_None()
	GMRpc.instance:sendGMRequest("rouge2FixCheck -1")
end

function GMSubViewRouge2:_onClickFixCheck_Succ()
	GMRpc.instance:sendGMRequest("rouge2FixCheck 0")
end

function GMSubViewRouge2:_onClickFixCheck_Fail()
	GMRpc.instance:sendGMRequest("rouge2FixCheck 1")
end

function GMSubViewRouge2:_onClickFixCheck_BigSucc()
	GMRpc.instance:sendGMRequest("rouge2FixCheck 2")
end

function GMSubViewRouge2:initAddAttrGM()
	self._attrNameList = {}
	self._index2AttrMap = {}

	local index = 0

	for _, attrCo in ipairs(lua_rouge2_attribute.configList) do
		index = index + 1

		local attrName = attrCo.name
		local attrId = attrCo.id

		table.insert(self._attrNameList, index, string.format("%s_%s", attrId, attrName))

		self._index2AttrMap[index] = attrCo
	end

	self:addLineIndex()

	self._attrDrop = self:addDropDown(self:getLineGroup(), "属性列表", self._attrNameList, nil, nil, {
		tempH = 500,
		total_w = 800,
		drop_w = 600
	})
	self._inputAddAttrValue = self:addInputText(self:getLineGroup(), 1, "添加属性值", nil, nil, {
		w = 300
	})

	self.addButton(self, self:getLineGroup(), "添加属性", self._onClickAddAttr, self)
end

function GMSubViewRouge2:_onClickAddAttr()
	local mathIndex = tonumber(self._attrDrop:GetValue()) or 0
	local attrCo = self._index2AttrMap[mathIndex + 1]
	local attrId = attrCo and attrCo.id
	local addAttrValue = tonumber(self._inputAddAttrValue:GetText()) or 0

	GMRpc.instance:sendGMRequest(string.format("addRouge2Attr %s %s", attrId, addAttrValue))
end

function GMSubViewRouge2:initPrintItemGM()
	self._bagTypeNameList = {}
	self._index2BagTypeMap = {}

	local index = 0

	for bagKey, bagType in pairs(Rouge2_Enum.BagType) do
		index = index + 1
		self._index2BagTypeMap[index] = bagType

		table.insert(self._bagTypeNameList, index, bagKey)
	end

	self:addLineIndex()

	self._bagTypeDrop = self:addDropDown(self:getLineGroup(), "背包类型", self._bagTypeNameList, nil, nil, {
		tempH = 500,
		total_w = 800,
		drop_w = 600
	})

	self.addButton(self, self:getLineGroup(), "打印背包", self._onClickBagType, self)
end

function GMSubViewRouge2:_onClickBagType()
	local mathIndex = tonumber(self._bagTypeDrop:GetValue()) or 0
	local bagType = self._index2BagTypeMap[mathIndex + 1]

	if not bagType then
		return
	end

	GMRpc.instance:sendGMRequest(string.format("printRouge2Item %s", bagType))
end

function GMSubViewRouge2:initPrintAttrGM()
	self:addLineIndex()
	self.addButton(self, self:getLineGroup(), "打印队长属性", self._onClickPrintAttr, self)
end

function GMSubViewRouge2:_onClickPrintAttr()
	GMRpc.instance:sendGMRequest("printRouge2Attr")
end

function GMSubViewRouge2:initPrintAttrExprGM()
	self._attrExprNameList = {}
	self._index2AttrExprMap = {}

	local index = 0
	local attrExprList = Rouge2_AttributeConfig.instance:getAttrConfigListByType(Rouge2_MapEnum.AttrType.EquationAttr)

	for _, attrCo in ipairs(attrExprList) do
		index = index + 1

		local attrName = attrCo.name
		local attrId = attrCo.id

		table.insert(self._attrExprNameList, index, string.format("%s_%s", attrId, attrName))

		self._index2AttrExprMap[index] = attrCo
	end

	self:addLineIndex()

	self._attrExprDrop = self:addDropDown(self:getLineGroup(), "公式属性(类型:2)列表", self._attrExprNameList, nil, nil, {
		tempH = 500,
		total_w = 1000,
		drop_w = 600
	})

	self.addButton(self, self:getLineGroup(), "打印公式属性", self._onClickPrintAttrExpr, self)
end

function GMSubViewRouge2:_onClickPrintAttrExpr()
	local mathIndex = tonumber(self._attrExprDrop:GetValue()) or 0
	local attrCo = self._index2AttrExprMap[mathIndex + 1]
	local attrId = attrCo and attrCo.id

	GMRpc.instance:sendGMRequest(string.format("printRouge2AttrExpr %s", attrId))
end

function GMSubViewRouge2:initAcceptEntrustGM()
	self._entrustNameList = {}
	self._index2EntrustMap = {}

	local index = 0

	for _, entrustCo in ipairs(lua_rouge2_entrust.configList) do
		index = index + 1

		local entrustId = entrustCo.id

		table.insert(self._entrustNameList, index, tostring(entrustId))

		self._index2EntrustMap[index] = entrustCo
	end

	self:addLineIndex()

	self._entrustDrop = self:addDropDown(self:getLineGroup(), "委托列表", self._entrustNameList, nil, nil, {
		tempH = 500,
		total_w = 1000,
		drop_w = 600
	})

	self.addButton(self, self:getLineGroup(), "接取委托", self._onClickAcceptEntrust, self)
end

function GMSubViewRouge2:_onClickAcceptEntrust()
	local mathIndex = tonumber(self._entrustDrop:GetValue()) or 0
	local entrustCo = self._index2EntrustMap[mathIndex + 1]
	local entrustId = entrustCo and entrustCo.id

	GMRpc.instance:sendGMRequest(string.format("rouge2AcceptEntrust %s", entrustId))
end

function GMSubViewRouge2:initSetEndGM()
	self._endNameList = {}
	self._index2EndMap = {}

	local index = 0

	for _, endingCo in ipairs(lua_rouge2_ending.configList) do
		index = index + 1

		local endingId = endingCo.id
		local endingName = endingCo.desc

		table.insert(self._endNameList, index, string.format("%s_%s", endingId, endingName))

		self._index2EndMap[index] = endingCo
	end

	self:addLineIndex()

	self._endingDrop = self:addDropDown(self:getLineGroup(), "结局列表", self._endNameList, nil, nil, {
		tempH = 500,
		total_w = 1000,
		drop_w = 600
	})

	self.addButton(self, self:getLineGroup(), "设置结局", self._onClickSetEnd, self)
end

function GMSubViewRouge2:_onClickSetEnd()
	local mathIndex = tonumber(self._endingDrop:GetValue()) or 0
	local endingCo = self._index2EndMap[mathIndex + 1]
	local endingId = endingCo and endingCo.id

	GMRpc.instance:sendGMRequest(string.format("rouge2SetEnd %s", endingId))
end

function GMSubViewRouge2:initDeleteMapGM()
	self:addLineIndex()
	self.addButton(self, self:getLineGroup(), "删除肉鸽数据", self._onClickDeleteMap, self)
end

function GMSubViewRouge2:_onClickDeleteMap()
	GMRpc.instance:sendGMRequest("rouge2MapDelete")
end

function GMSubViewRouge2:onClickEnterRouge()
	Rouge2_ViewHelper.openEnterView()
end

function GMSubViewRouge2:initBossBattleGM()
	self:addLineIndex()

	self._bossNameList = {}
	self._index2BossCoMap = {}

	local index = 0

	for _, bossCo in ipairs(lua_rouge2_boss_rush.configList) do
		index = index + 1

		local bossId = bossCo.id
		local episodeCo = Rouge2_BossBattleController.instance:getEpisodeCoByBossId(bossId)
		local episodeName = episodeCo and episodeCo.name

		table.insert(self._bossNameList, index, string.format("%s_%s", bossId, episodeName))

		self._index2BossCoMap[index] = bossCo
	end

	self._bossDrop = self:addDropDown(self:getLineGroup(), "首领列表", self._bossNameList, nil, nil, {
		temp_w = 700,
		total_w = 900,
		drop_w = 700
	})

	self.addButton(self, self:getLineGroup(), "进入首领战斗", self._onClickEnterBossBattle, self)
end

function GMSubViewRouge2:_onClickEnterBossBattle()
	local mathIndex = self._bossDrop:GetValue()
	local bossCo = self._index2BossCoMap[mathIndex + 1]
	local bossId = bossCo and bossCo.id

	Rouge2_BossBattleController.instance:enterFight(bossId)
end

return GMSubViewRouge2
