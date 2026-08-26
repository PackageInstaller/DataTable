-- chunkname: @modules/logic/gm/view/rouge/GMSubViewRouge.lua

module("modules.logic.gm.view.rouge.GMSubViewRouge", package.seeall)

local GMSubViewRouge = class("GMSubViewRouge", GMSubViewBase)

require("tolua.reflection")
tolua.loadassembly("UnityEngine.UI")

local type_linetype = tolua.findtype("UnityEngine.UI.InputField+LineType")
local MultiLineNewline = System.Enum.Parse(type_linetype, "MultiLineNewline")

function GMSubViewRouge:ctor()
	self.tabName = "肉鸽"
end

function GMSubViewRouge:addLineIndex()
	self.lineIndex = self.lineIndex + 1
end

function GMSubViewRouge:getLineGroup()
	return "L" .. self.lineIndex
end

function GMSubViewRouge:initViewContent()
	if self._inited then
		return
	end

	GMSubViewBase.initViewContent(self)

	self.lineIndex = 1

	self:addTitleSplitLine("地图编辑")
	self.addButton(self, self:getLineGroup(), "肉鸽地图编辑", self.onClickRougeMapEditor, self)
	self.addButton(self, self:getLineGroup(), "肉鸽地图路线位置编辑", self.onClickRougeSelectMapEditor, self)

	self.showClickAreaTrigger = self.addToggle(self, self:getLineGroup(), "显示节点点击区域", self.onToggleValueChanged, self)

	self:addLineIndex()

	self.allowAbortFightTrigger = self.addToggle(self, self:getLineGroup(), "允许主动退出战斗", self.onAllowAbortFightToggleValueChanged, self)
	self.allowAbortFightTrigger.isOn = RougeEditorController.instance:isAllowAbortFight()
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
end

function GMSubViewRouge:onClickStartRecordGc()
	RougeProfileController.instance:startRecordMemory()
end

function GMSubViewRouge:onClickEndRecordGc()
	RougeProfileController.instance:endRecord()
end

function GMSubViewRouge:onClickRougeMapEditor()
	RougeEditorController.instance:enterRougeMapEditor()
	self:closeThis()
end

function GMSubViewRouge:onToggleValueChanged()
	if self.showClickAreaTrigger.isOn then
		RougeEditorController.instance:showNodeClickArea()
	else
		RougeEditorController.instance:hideNodeClickArea()
	end
end

function GMSubViewRouge:onAllowAbortFightToggleValueChanged()
	RougeEditorController.instance:allowAbortFight(self.allowAbortFightTrigger.isOn)
end

function GMSubViewRouge:onClickRougeSelectMapEditor()
	RougeEditorController.instance:enterPathSelectMapEditorView()
	self:closeThis()
end

function GMSubViewRouge:checkAllEventExistInSubEvent()
	local allEvent = lua_rouge_event.configList

	for _, eventCo in ipairs(allEvent) do
		local eventType = eventCo.type
		local eventId = eventCo.id
		local subEventCo

		if RougeMapHelper.isFightEvent(eventType) then
			subEventCo = lua_rouge_fight_event.configDict[eventId]

			if not lua_rouge_fight_event.configDict[eventId] then
				logError("肉鸽战斗事件表不存在id : " .. tostring(eventId))
			end
		elseif RougeMapHelper.isChoiceEvent(eventType) then
			subEventCo = lua_rouge_choice_event.configDict[eventId]

			if not lua_rouge_choice_event.configDict[eventId] then
				logError("肉鸽选项事件表不存在id : " .. tostring(eventId))
			end
		elseif RougeMapHelper.isStoreEvent(eventType) then
			if not lua_rouge_shop_event.configDict[eventId] then
				logError("肉鸽商店事件表不存在id : " .. tostring(eventId))
			end
		else
			logError(string.format("事件表id : %s, 配置了未知事件类型 : %s", eventId, eventType))
		end
	end

	GameFacade.showToastString("检查完毕")
end

function GMSubViewRouge:startCheckExcel()
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

function GMSubViewRouge:getExcelDataDict(excelName)
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

function GMSubViewRouge:getExcelDataList(excelName)
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

function GMSubViewRouge:_onClickClearRougeStories()
	for i, v in ipairs(lua_rouge_story_list.configList) do
		local storyList = string.splitToNumber(v.storyIdList, "#")

		for _, id in ipairs(storyList) do
			GMRpc.instance:sendGMRequest(string.format("delete story %s", id))
		end
	end

	StoryRpc.instance:sendGetStoryRequest()
end

function GMSubViewRouge:_onClickFinishRougeStories()
	for i, v in ipairs(lua_rouge_story_list.configList) do
		local storyList = string.splitToNumber(v.storyIdList, "#")

		for _, id in ipairs(storyList) do
			StoryRpc.instance:sendUpdateStoryRequest(id, -1, 0)
		end
	end

	StoryRpc.instance:sendGetStoryRequest()
end

function GMSubViewRouge:_onClickClearStory()
	local storyList = string.splitToNumber(self._inpClearStoryValue:GetText(), "#")

	for _, id in ipairs(storyList) do
		GMRpc.instance:sendGMRequest(string.format("delete story %s", id))
	end

	StoryRpc.instance:sendGetStoryRequest()
end

function GMSubViewRouge:_onClickFinishStory()
	local storyList = string.splitToNumber(self._inpFinishStoryValue:GetText(), "#")

	for _, id in ipairs(storyList) do
		StoryRpc.instance:sendUpdateStoryRequest(id, -1, 0)
	end

	StoryRpc.instance:sendGetStoryRequest()
end

return GMSubViewRouge
