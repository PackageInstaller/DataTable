local talkeditor_manager = class("talkeditor_manager")

require("file_manager")

local conversation_talkeditor_data = require("data.conversation_talkeditor_data")
local model_data = require("data.model_data")
local var_0_6 = TALKEDITOR.PropertyTypeList
local Utility = require("common.Utility")

function talkeditor_manager:properties(arg_1_1)
	for iter_1_0, iter_1_1 in pairs(arg_1_1) do
		self[iter_1_0] = iter_1_1
	end
end

function talkeditor_manager:ctor()
	self:properties({
		talkDataList = {},
		consoleDataList = {}
	})
end

function talkeditor_manager:init()
	FileM:init()
	FileM:initTalkFilePath()
	self:initInfo()
end

function talkeditor_manager:initInfo()
	self.talkDataList = {}
	self.consoleDataList = {}
	self.selectPropertyInfoByFilter = {}
	self.totalFolderName = "conversation_talkeditor_data"
	self.curFolderName = cc.UserDefault:getInstance():getStringForKey("operateFolderName", "conversation_default_data")
	self.curExcelName = cc.UserDefault:getInstance():getStringForKey("operateExcelName", "【剧情】导表_剧情表_默认")

	self:initConsoleDataList()
	self:initSelectPropertyInfo()
end

function talkeditor_manager:getCurFolderName()
	return self.curFolderName
end

function talkeditor_manager:getCurExcelName()
	return self.curExcelName
end

function talkeditor_manager:getTalkDataList(arg_7_1)
	if arg_7_1 == nil then
		return self.talkDataList
	else
		return self.talkDataList[arg_7_1]
	end
end

function talkeditor_manager:deleteTalkEditorListInfo(arg_8_1)
	if #self.talkDataList < arg_8_1 or #self.talkDataList <= 1 then
		return
	end

	table.remove(self.talkDataList, arg_8_1)
	self:initTalkDataInfo()

	for iter_8_0 = 1, math.max(#self.talkDataList, #self.talkDataList) do
		self:opearteFile(iter_8_0)
	end

	conversation_talkeditor_data = require("devtools.debug_console").updateMergeData("data.conversation_talkeditor_data")
end

function talkeditor_manager:initTalkDataInfo()
	for iter_9_0 = 1, #self.talkDataList do
		local var_9_0 = self.talkDataList[iter_9_0]

		var_9_0.index = iter_9_0
		var_9_0.id = iter_9_0 >= 10 and var_9_0.classId .. var_9_0.index or var_9_0.classId .. "0" .. var_9_0.index
	end
end

function talkeditor_manager:pasteTalkEditorListInfo(arg_10_1, arg_10_2)
	if arg_10_1 > #self.talkDataList then
		return
	end

	arg_10_2 = arg_10_2 or arg_10_1
	arg_10_2 = arg_10_2 + 1

	table.insert(self.talkDataList, arg_10_2, cloneconf(self.talkDataList[arg_10_1]))
	self:initTalkDataInfo()

	for iter_10_0 = 1, math.max(#self.talkDataList, #self.talkDataList) do
		self:opearteFile(iter_10_0)
	end

	conversation_talkeditor_data = require("devtools.debug_console").updateMergeData("data.conversation_talkeditor_data")
end

function talkeditor_manager:setTalkEditorListInfo(arg_11_1, arg_11_2)
	for iter_11_0, iter_11_1 in pairs(arg_11_2) do
		self.talkDataList[arg_11_1][iter_11_0] = iter_11_1
	end

	for iter_11_2, iter_11_3 in pairs({
		"specialEffect"
	}) do
		self.talkDataList[arg_11_1][iter_11_3] = arg_11_2[iter_11_3]
	end

	self.talkDataList[arg_11_1].content = string.format("【%s】%s", self.talkDataList[arg_11_1].playerName, self.talkDataList[arg_11_1].playerLines)
	self.talkDataList[arg_11_1].dialogType = tonumber(self.talkDataList[arg_11_1].dialogType)
end

function talkeditor_manager:saveInfoToFile(arg_12_1)
	self:opearteFile(arg_12_1)

	conversation_talkeditor_data = require("devtools.debug_console").updateMergeData("data.conversation_talkeditor_data")
end

function talkeditor_manager:setSelectPropertyInfoByFilter(arg_13_1, arg_13_2)
	self.selectPropertyInfoByFilter[arg_13_1] = arg_13_2
end

function talkeditor_manager:getSelectPropertyInfoByFilter(arg_14_1)
	if arg_14_1 ~= nil then
		return self.selectPropertyInfoByFilter[arg_14_1]
	else
		return self.selectPropertyInfoByFilter
	end
end

function talkeditor_manager:selectListIndex(arg_15_1)
	self.lastSelectIndex = arg_15_1
end

function talkeditor_manager:getLastSelectIndex()
	return self.lastSelectIndex
end

function talkeditor_manager:quickAddListItem(arg_17_1)
	self.classId = arg_17_1

	local var_17_0 = cloneconf(self.talkDataList[1]) or {
		playerPosType = 0,
		playerName = "霓昂",
		dialogType = 2,
		content = "【霓昂】这是我要说的台词知道吗看看啥时候才会换行",
		isStay = 0,
		index = #self.talkDataList + 1,
		classId = arg_17_1
	}

	var_17_0.index = #self.talkDataList + 1

	table.insert(self.talkDataList, #self.talkDataList + 1, var_17_0)
	self:initTalkDataInfo()
end

function talkeditor_manager:createNewConversation(arg_18_1, arg_18_2)
	arg_18_2 = arg_18_2 or 1

	self:quickAddListItem(arg_18_1)
	self:selectListIndex(arg_18_2)
	self:opearteFile(arg_18_2)

	conversation_talkeditor_data = require("devtools.debug_console").updateMergeData("data.conversation_talkeditor_data")
end

function talkeditor_manager:loadOldConversation(arg_19_1, arg_19_2)
	if arg_19_1 == nil then
		return
	end

	self:setSettingInfo((require("devtools.debug_console").getCurDataInFolderInfo("classId", arg_19_1, "data." .. self.totalFolderName)))

	local var_19_0 = {}

	for iter_19_0, iter_19_1 in pairs(conversation_talkeditor_data) do
		if iter_19_1.classId == arg_19_1 then
			iter_19_1.content = string.format("【%s】%s", iter_19_1.playerName, iter_19_1.playerLines)

			if iter_19_1.index == nil then
				iter_19_1.index = #var_19_0 + 1 or iter_19_1.index
			end

			iter_19_1.dialogType = iter_19_1.dialogType == nil and 2 or iter_19_1.dialogType
			iter_19_1.isStay = iter_19_1.isStay == nil or iter_19_1.isStay

			table.insert(var_19_0, iter_19_1)
		end
	end

	if #var_19_0 ~= 0 then
		table.sort(var_19_0, function(arg_20_0, arg_20_1)
			return arg_20_0.index < arg_20_1.index
		end)
	else
		global_ShowBlockWords("加载的对话为空~请新建对话")
	end

	self.talkDataList = var_19_0
	self.classId = arg_19_1

	self:selectListIndex(arg_19_2 or 1)
end

function talkeditor_manager:setSettingInfo(arg_21_1)
	local var_21_0 = arg_21_1 and arg_21_1.excelName

	self.curFolderName = arg_21_1 and arg_21_1.folderName
	self.curExcelName = var_21_0

	cc.UserDefault:getInstance():setStringForKey("operateFolderName", arg_21_1 and arg_21_1.folderName)
	cc.UserDefault:getInstance():setStringForKey("operateExcelName", var_21_0)
end

function talkeditor_manager:initExcelAndScriptFile()
	if Utility:haveFileExist("./src/data/" .. self.curFolderName .. ".lua") == false or Utility:haveFileExist("./导表excel/剧情/" .. self.curExcelName .. ".xlsx") == false then
		FileM:writeData({
			path = string.format("剧情\\" .. self.curExcelName),
			to = string.format(self.curFolderName),
			parents = {
				self.totalFolderName
			},
			line_1 = {
				"isload",
				"id",
				"classId",
				"index",
				"dialogType",
				"isStay",
				"playerPosType",
				"playerExpression",
				"background",
				"specialEffect",
				"playerLines",
				"zoomPlayer",
				"playerId",
				"playerName",
				"bgm",
				"movePlayer",
				"Player_Position",
				"playerBubble"
			},
			value_list = {}
		})
		FileM:saveExplore()
		FileM:writeMergeTable()
	end
end

function talkeditor_manager:opearteFile(arg_23_1)
	arg_23_1 = arg_23_1 or self.lastSelectIndex

	local var_23_0 = readFile("./src/data/" .. self.curFolderName .. ".lua")
	local var_23_1 = io.open("./src/data/" .. self.curFolderName .. ".lua", "w+b")

	if var_23_0 == "" or var_23_0 == nil then
		var_23_1:write("local value_list = {} \n\n\nreturn value_list\n")
	end

	local function var_23_2(arg_25_0)
		local var_25_1 = string.find(var_23_0, arg_25_0.index >= 10 and "%[\"" .. arg_25_0.classId .. arg_25_0.index .. "\"" or "%[\"" .. arg_25_0.classId .. "0" .. arg_25_0.index .. "\"")

		if var_25_1 == nil then
			var_25_1 = string.find(var_23_0, "return value_list")

			return string.sub(var_23_0, 1, var_25_1 - 1), "return value_list"
		else
			local var_25_6 = string.sub(var_23_0, var_25_1 - 11)

			return string.sub(var_23_0, 1, var_25_1 - 11) .. string.sub(string.sub(var_25_6, string.find(var_25_6, "\n", 2) + 1), 1, -18), "return value_list"
		end
	end

	local var_23_3 = self.talkDataList[arg_23_1]
	local var_23_4 = ""

	if self.talkDataList[arg_23_1] ~= nil then
		var_23_4 = (function(arg_24_0)
			local var_24_1 = cloneconf(arg_24_0)

			if var_24_1.content then
				var_24_1.content = nil
			end

			if var_24_1.operateInfo then
				var_24_1.operateInfo = nil
			end

			if var_24_1.dialogType ~= 1 then
				var_24_1.Lines1 = nil
				var_24_1.Lines2 = nil
				var_24_1.nextClassId1 = nil
				var_24_1.nextClassId2 = nil
			end

			local var_24_2 = "value_list[\"" .. (var_24_1.index >= 10 and var_24_1.classId .. var_24_1.index or var_24_1.classId .. "0" .. var_24_1.index) .. "\"]={ "

			for iter_24_0, iter_24_1 in pairs({
				"classId",
				"index",
				"curNotes",
				"dialogType",
				"isStay",
				"playerPosType",
				"nextClassId1",
				"nextClassId2"
			}) do
				if var_24_1[iter_24_1] then
					if var_24_1[iter_24_1] == nil or var_24_1[iter_24_1] == "" then
						-- block empty
					else
						var_24_2 = var_24_2 .. iter_24_1 .. "=" .. ((type(var_24_1[iter_24_1]) == "string" or nil) and "\"" .. var_24_1[iter_24_1] .. "\"") .. ","
						var_24_1[iter_24_1] = nil
					end
				end
			end

			for iter_24_2, iter_24_3 in pairs(var_24_1) do
				if type(iter_24_3) == "string" and iter_24_3 ~= "" then
					var_24_2 = var_24_2 .. iter_24_2 .. "=" .. ("\"" .. iter_24_3 .. "\"") .. ","
				end
			end

			return var_24_2 .. "}\n"
		end)(var_23_3)
	else
		var_23_3 = {
			index = arg_23_1,
			classId = self.classId
		}
	end

	local var_23_5, var_23_6 = var_23_2(var_23_3)

	var_23_1:seek("set")
	var_23_1:write(var_23_5)
	var_23_1:write(var_23_4)
	var_23_1:write(var_23_6)
	var_23_1:flush()
	var_23_1:close()
end

function talkeditor_manager:getConsoleDataList()
	return self.consoleDataList
end

function talkeditor_manager:setConsoleListInfo(arg_27_1, arg_27_2, arg_27_3)
	if arg_27_3 == nil or self.consoleDataList == nil or self.consoleDataList[arg_27_1] == nil or self.consoleDataList[arg_27_1].list[arg_27_2] == nil then
		return
	end

	self.consoleDataList[arg_27_1].list[arg_27_2].value = arg_27_3
	self.consoleDataList[arg_27_1].list[arg_27_2].status = 1
end

function talkeditor_manager:initConsoleDataList()
	for iter_28_0 = 1, #TALKEDITOR.CONSOLE_LIST do
		TALKEDITOR.CONSOLE_LIST[iter_28_0].list = {}

		for iter_28_1, iter_28_2 in pairs((cloneconf(TALKEDITOR.CONSOLE_LIST[iter_28_0].list))) do
			table.insert(TALKEDITOR.CONSOLE_LIST[iter_28_0].list, {
				status = 0,
				title = iter_28_2
			})
		end

		table.insert(self.consoleDataList, TALKEDITOR.CONSOLE_LIST[iter_28_0])
	end
end

function talkeditor_manager:updateConsoleListInfo(arg_29_1)
	for iter_29_0 = 1, #TALKEDITOR.CONSOLE_LIST do
		if iter_29_0 == 3 then
			local var_29_1
			local var_29_2

			if arg_29_1.specialEffect ~= nil and type(arg_29_1.specialEffect) == "string" then
				local var_29_3 = string_split(arg_29_1.specialEffect, "=")

				var_29_1 = tonumber(var_29_3[1])
				var_29_2 = tonumber(var_29_3[2])
			end

			for iter_29_1 = 1, #self.consoleDataList[iter_29_0].list do
				if var_29_1 == iter_29_1 then
					self.consoleDataList[iter_29_0].list[iter_29_1].value = var_29_2
				else
					self.consoleDataList[iter_29_0].list[iter_29_1].value = nil
					self.consoleDataList[iter_29_0].list[iter_29_1].status = 0
				end
			end
		else
			for iter_29_2, iter_29_3 in pairs(self.consoleDataList[iter_29_0].list) do
				if arg_29_1[self.consoleDataList[iter_29_0].keyList[iter_29_2]] ~= nil then
					iter_29_3.value = arg_29_1[self.consoleDataList[iter_29_0].keyList[iter_29_2]]
				else
					iter_29_3.value = nil
					iter_29_3.status = 0
				end
			end
		end
	end
end

function talkeditor_manager:saveToExcelFile()
	local var_30_0 = {
		path = string.format("剧情\\" .. self.curExcelName),
		to = string.format(self.curFolderName),
		parents = {
			self.totalFolderName
		},
		line_1 = {
			"isload",
			"id",
			"classId",
			"index",
			"dialogType",
			"isStay",
			"playerPosType",
			"playerExpression",
			"background",
			"specialEffect",
			"playerLines",
			"zoomPlayer",
			"playerId",
			"playerName",
			"bgm",
			"movePlayer",
			"Player_Position",
			"playerBubble"
		},
		value_list = {}
	}

	for iter_30_0, iter_30_1 in pairs(self.talkDataList) do
		iter_30_1.isload = 1
		iter_30_1.id = iter_30_1.index >= 10 and iter_30_1.classId .. iter_30_1.index or iter_30_1.classId .. "0" .. iter_30_1.index

		table.insert(var_30_0.value_list, iter_30_1)
	end

	FileM:writeData(var_30_0)
	FileM:saveExplore()
	FileM:writeMergeTable()
end

function talkeditor_manager:initSelectPropertyInfo()
	self.selectPropertyInfo = {}

	local var_31_0 = {}
	local var_31_1 = {
		"感叹号",
		"爱心",
		"星星",
		"音符",
		"三点",
		"汗滴",
		"生气",
		"问号"
	}

	for iter_31_0 = 1, #var_31_1 do
		table.insert(var_31_0, {
			id = iter_31_0,
			name = var_31_1[iter_31_0],
			value = tostring(iter_31_0)
		})
	end

	self.selectPropertyInfo[var_0_6.Bubble] = var_31_0

	local var_31_2 = {}
	local var_31_3 = {
		"我",
		"学员",
		"旁白",
		"提示"
	}

	for iter_31_1 = 1, #var_31_3 do
		table.insert(var_31_2, {
			id = iter_31_1,
			name = var_31_3[iter_31_1],
			value = iter_31_1
		})
	end

	self.selectPropertyInfo[var_0_6.TalkType] = var_31_2

	local var_31_4 = {}
	local var_31_5 = {
		"正常",
		"发怒",
		"开心",
		"害羞",
		"哀愁",
		"惊讶",
		"备选1",
		"备选2",
		"备选3"
	}
	local var_31_6 = {
		"expression",
		"fanu",
		"kaixin",
		"haixiu",
		"aichou",
		"jingya",
		"beixuan1",
		"beixuan2",
		"beixuan3"
	}

	for iter_31_2 = 1, #var_31_5 do
		table.insert(var_31_4, {
			id = iter_31_2,
			name = var_31_5[iter_31_2],
			value = var_31_6[iter_31_2]
		})
	end

	self.selectPropertyInfo[var_0_6.Expression] = var_31_4
	self.selectPropertyInfo[var_0_6.Player] = self:getAllFiles("res/roleimage/role", var_0_6.Player)
	self.selectPropertyInfo[var_0_6.Background] = self:getAllFiles("res/mainScenebg", var_0_6.Background)
	self.selectPropertyInfo[var_0_6.BGM] = self:getAllFiles("res/sound/jvqingpeiyin", var_0_6.BGM, "jvqingpeiyin/")
end

function talkeditor_manager:getAllFiles(arg_32_1, arg_32_2, arg_32_3)
	local var_32_0 = {}

	arg_32_3 = arg_32_3 or ""

	if arg_32_2 == var_0_6.Player then
		-- block empty
	end

	for iter_32_0 in lfs.dir(arg_32_1) do
		if iter_32_0 ~= "." and iter_32_0 ~= ".." then
			local var_32_3 = lfs.attributes(arg_32_1 .. "/" .. iter_32_0)

			if var_32_3.mode == "directory" then
				-- block empty
			elseif var_32_3.mode == "file" then
				local var_32_4 = iter_32_0:sub(1, -5)

				table.insert(var_32_0, {
					id = 1,
					name = var_32_4,
					value = arg_32_3 .. var_32_4
				})
			end
		end
	end

	return var_32_0
end

function talkeditor_manager:getSelectPropertyInfo(arg_33_1)
	if arg_33_1 == nil then
		return self.selectPropertyInfo
	else
		return self.selectPropertyInfo[arg_33_1]
	end
end

function talkeditor_manager:getShowPropertyInfo(arg_34_1, arg_34_2)
	if self.selectPropertyInfo[arg_34_1] == nil or arg_34_2 == nil then
		return
	end

	local var_34_0

	for iter_34_0, iter_34_1 in pairs(self.selectPropertyInfo[arg_34_1]) do
		if iter_34_1.value == arg_34_2 then
			var_34_0 = iter_34_1.name

			break
		end
	end

	return var_34_0
end

return talkeditor_manager
