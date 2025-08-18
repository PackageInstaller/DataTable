-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/Debug\\Modules\\DebugStoryScript.lua

local UserData = require("Helper/UserData")
local ResVideoTalk = require("ClientData/ResVideoTalk")
local DebugConst = require("Debug/DebugConst")
local ResPlotRewindDetail = require("ClientData/ResPlotRewindDetail")
local DebugModule = {}

DebugModule.ENTRY_NAME = "剧情"

function DebugModule.stepA(sender, menu, value)
	local section = tonumber(value) or 1

	UIManager.playAVG(section)
end

function DebugModule.stepB(sender, menu, value)
	return
end

function DebugModule.stepC(sender, menu, value)
	return
end

function DebugModule.stepD(sender, menu, value)
	return
end

function DebugModule.newbieAVG(sender, menu, value)
	local section = tonumber(value) or 1

	UIManager.playAVG(section, nil, nil, true)
end

function DebugModule.stepList(sender, menu, value)
	local valueList = utils.splitString(value, ",")

	if #valueList < 1 then
		return
	end

	local firstSection = tonumber(valueList[1])

	table.remove(valueList, 1)

	local endCallbackList = {}

	for i = #valueList, 1, -1 do
		local sectionId = tonumber(valueList[i])

		if i == #valueList then
			local function cb(...)
				UIManager.playAVG(sectionId)
			end

			endCallbackList[i] = cb
		else
			local function cb(...)
				UIManager.playAVG(sectionId, nil, endCallbackList[i + 1])
			end

			endCallbackList[i] = cb
		end
	end

	UIManager.playAVG(firstSection, nil, endCallbackList[1])
end

local forcePlayAvg = UserData.loadCommonData("ForcePlayAvg")

if forcePlayAvg == "1" then
	GameFsm.getState(Const.STATE_BATTLE).FORCE_PLAY_BATTLE_AVG = true
end

function DebugModule.setForcePlayAvg(sender, menu, value)
	if forcePlayAvg == "1" then
		forcePlayAvg = "0"

		MsgManager.notice("不可重复观看AVG")
		UserData.saveCommonData("ForcePlayAvg", "0")

		GameFsm.getState(Const.STATE_BATTLE).FORCE_PLAY_BATTLE_AVG = false
	else
		forcePlayAvg = "1"

		MsgManager.notice("可重复观看AVG")
		UserData.saveCommonData("ForcePlayAvg", "1")

		GameFsm.getState(Const.STATE_BATTLE).FORCE_PLAY_BATTLE_AVG = true
	end
end

function DebugModule.checkRepeatedAVG()
	local AVGInfo = require("UI/AVG/AVGInfo")
	local editorTalk, excelTalk = AVGInfo:getRawAVGData("ResTalk")
	local editorBg, excelBg = AVGInfo:getRawAVGData("ResTalkBg")
	local editorScenery, excelScenery = AVGInfo:getRawAVGData("ResTalkScenery")

	for key, value in pairs(excelTalk) do
		if editorTalk[key] then
			-- block empty
		end
	end

	for key, value in pairs(excelBg) do
		if editorBg[key] then
			-- block empty
		end
	end

	for key, value in pairs(excelScenery) do
		if editorScenery[key] then
			-- block empty
		end
	end

	local editorDataPrefix = "ClientData/AVGData/EditorData/"
	local AVGManifest = require("ClientData/AVGData/EditorData/AVGManifest")

	for _, value in ipairs(AVGManifest) do
		local resTalkPath = editorDataPrefix .. value.resPath .. "/ResTalk"
		local resTalk = require(resTalkPath)
		local resTalkBgPath = editorDataPrefix .. value.resPath .. "/ResTalkBg"
		local resTalkBg = require(resTalkBgPath)
		local resTalkSceneryPath = editorDataPrefix .. value.resPath .. "/ResTalkScenery"
		local resTalkSceney = require(resTalkSceneryPath)

		DebugModule.idRangeCheck(value.resPath .. "脚本", resTalk, value.sectionStartId, value.sectionEndId, true)
		DebugModule.idRangeCheck(value.resPath .. "背景", resTalkBg, value.bgStartId, value.bgEndId)
		DebugModule.idRangeCheck(value.resPath .. "布景", resTalkSceney, value.sceneryStartId, value.sceneryEndId)
	end

	for key, value in pairs(excelTalk) do
		for _, manifest in ipairs(AVGManifest) do
			local id = Mathf.Floor(key / 1000)

			if id >= manifest.sectionStartId and id <= manifest.sectionEndId then
				-- block empty
			end
		end
	end

	for key, value in pairs(excelBg) do
		for _, manifest in ipairs(AVGManifest) do
			if key >= manifest.bgStartId and key <= manifest.bgEndId then
				-- block empty
			end
		end
	end

	for key, value in pairs(excelScenery) do
		for _, manifest in ipairs(AVGManifest) do
			if key >= manifest.sceneryStartId and key <= manifest.sceneryEndId then
				-- block empty
			end
		end
	end
end

function DebugModule.idRangeCheck(fileName, dataList, min, max, isResTalk)
	for key, data in pairs(dataList) do
		local id = key

		if isResTalk then
			id = Mathf.Floor(key / 1000)
		end

		if min <= id and id <= max then
			-- block empty
		end
	end
end

function DebugModule.checkErrorTranslate(sender, menu, value)
	if Lang.inited then
		local ResTalkNpc = require("ClientData/ResTalkNpc")
		local valueList = utils.splitString(value, ",")

		if #valueList < 1 then
			return
		end

		local checkSectionDic = {}

		for _, section in ipairs(valueList) do
			local sectionId = tonumber(section)

			checkSectionDic[sectionId] = true
		end

		local AVGInfo = require("UI/AVG/AVGInfo")
		local editorData, excelData = AVGInfo:getRawAVGData("ResTalk")
		local errorList = {}

		for _, talkInfo in pairs(editorData) do
			if talkInfo.talk and talkInfo.section and checkSectionDic[talkInfo.section] and string.find(talkInfo.talk, "ERR:") then
				local errorMsg = {}

				errorMsg.errorId = utils.replaceString(talkInfo.talk, "ERR:", "")
				errorMsg.section = talkInfo.section
				errorMsg.id = talkInfo.id

				table.insert(errorList, errorMsg)
			end

			if talkInfo.section and checkSectionDic[talkInfo.section] then
				local npcId = talkInfo.npc_id

				if npcId and ResTalkNpc[npcId] then
					local npcInfo = ResTalkNpc[npcId]

					if npcInfo.name and string.find(npcInfo.name, "ERR:") then
						local errorMsg = {}

						errorMsg.errorId = utils.replaceString(npcInfo.name, "ERR:", "")
						errorMsg.section = 0
						errorMsg.id = npcId

						table.insert(errorList, errorMsg)
					end
				end
			end

			if talkInfo.branch_info and checkSectionDic[talkInfo.section] then
				for _, info in ipairs(talkInfo.branch_info) do
					if info.branch_content and string.find(info.branch_content, "ERR:") then
						local errorMsg = {}

						errorMsg.errorId = utils.replaceString(info.branch_content, "ERR:", "")
						errorMsg.section = talkInfo.section or 0
						errorMsg.id = talkInfo.id

						table.insert(errorList, errorMsg)
					end
				end
			end
		end

		for _, talkInfo in pairs(excelData) do
			if talkInfo.talk and talkInfo.section and checkSectionDic[talkInfo.section] and string.find(talkInfo.talk, "ERR:") then
				local errorMsg = {}

				errorMsg.errorId = utils.replaceString(talkInfo.talk, "ERR:", "")
				errorMsg.section = talkInfo.section
				errorMsg.id = talkInfo.id

				table.insert(errorList, errorMsg)
			end

			if talkInfo.section and checkSectionDic[talkInfo.section] then
				local npcId = talkInfo.npc_id

				if npcId and ResTalkNpc[npcId] then
					local npcInfo = ResTalkNpc[npcId]

					if npcInfo.name and string.find(npcInfo.name, "ERR:") then
						local errorMsg = {}

						errorMsg.errorId = utils.replaceString(npcInfo.name, "ERR:", "")
						errorMsg.section = 0
						errorMsg.id = npcId

						table.insert(errorList, errorMsg)
					end
				end
			end

			if talkInfo.branch_info and checkSectionDic[talkInfo.section] then
				for _, info in ipairs(talkInfo.branch_info) do
					if info.branch_content and string.find(info.branch_content, "ERR:") then
						local errorMsg = {}

						errorMsg.errorId = utils.replaceString(info.branch_content, "ERR:", "")
						errorMsg.section = talkInfo.section or 0
						errorMsg.id = talkInfo.id

						table.insert(errorList, errorMsg)
					end
				end
			end
		end

		local function _sortError(errorMsgA, errorMsgB)
			if errorMsgA.section ~= errorMsgB.section then
				return errorMsgA.section < errorMsgB.section
			elseif errorMsgA.id ~= errorMsgB.id then
				return errorMsgA.id < errorMsgB.id
			else
				return errorMsgA.errorId < errorMsgB.errorId
			end
		end

		table.sort(errorList, _sortError)

		local file = io.open("TalkError" .. os.date("%m-%d-%H_%M_%S", ClientUtils.getServerTime()) .. "Section" .. valueList[1] .. ".csv", "w+")
		local output = "ErrorId,SectionId,TalkId\n"

		for i, v in ipairs(errorList) do
			local lineStr = utils.format("%1s,%2s,%3s\n", v.errorId, v.section, v.id)

			output = output .. lineStr
		end

		file:write(output)
		file:flush()
		file:close()
	end
end

function DebugModule.checkErrorMainStage(sender, menu, value)
	if Lang.inited then
		local ResStage = require("ClientData/ResStage")
		local valueList = utils.splitString(value, ",")

		if #valueList < 1 then
			return
		end

		local checkChapterDic = {}

		for _, chapter in ipairs(valueList) do
			local chapter = tonumber(chapter)

			checkChapterDic[chapter] = true
		end

		local errorList = {}

		for chapter, _ in pairs(checkChapterDic) do
			for level, stageInfo in pairs(ResStage[1][chapter]) do
				if stageInfo.name and stageInfo.desc then
					local isErrorName = string.find(stageInfo.name, "ERR:")
					local isErrorDesc = string.find(stageInfo.desc, "ERR:")

					if isErrorName or isErrorDesc then
						local errorMsg = {}

						errorMsg.chapter = chapter
						errorMsg.level = stageInfo.level

						if isErrorName and isErrorDesc then
							errorMsg.errorType = "1;2"

							local nameErrorId = utils.replaceString(stageInfo.name, "ERR:", "")
							local descErrorId = utils.replaceString(stageInfo.desc, "ERR:", "")

							errorMsg.errorId = nameErrorId .. ";" .. descErrorId
						elseif isErrorName then
							errorMsg.errorType = "1"

							local nameErrorId = utils.replaceString(stageInfo.name, "ERR:", "")

							errorMsg.errorId = nameErrorId
						else
							errorMsg.errorType = "2"

							local descErrorId = utils.replaceString(stageInfo.desc, "ERR:", "")

							errorMsg.errorId = descErrorId
						end

						table.insert(errorList, errorMsg)
					end
				end
			end
		end

		local function _sortError(errorMsgA, errorMsgB)
			if errorMsgA.chapter ~= errorMsgB.chapter then
				return errorMsgA.chapter < errorMsgB.chapter
			elseif errorMsgA.level ~= errorMsgB.level then
				return errorMsgA.level < errorMsgB.level
			end
		end

		table.sort(errorList, _sortError)

		local file = io.open("MainStageError" .. os.date("%m-%d-%H_%M_%S", ClientUtils.getServerTime()) .. "Chapter" .. valueList[1] .. ".csv", "w+")
		local output = "ErrorId,Chapter,Level,ErrorType\n"

		for i, v in ipairs(errorList) do
			local lineStr = utils.format("%1s,%2s,%3s,%4s\n", v.errorId, v.chapter, v.level, v.errorType)

			output = output .. lineStr
		end

		file:write(output)
		file:flush()
		file:close()
	end
end

function DebugModule.checkDuplicateAvg(sender, menu, value)
	if Lang.inited then
		local AVGInfo = require("UI/AVG/AVGInfo")
		local editorData, excelData = AVGInfo:getRawAVGData("ResTalk")
		local ResTalkNpc = require("ClientData/ResTalkNpc")
		local errorList = {}
		local contentDic = {}
		local branchTextDict = {}

		for _, talkInfo in pairs(editorData) do
			if talkInfo.branch_info then
				for i, branch in ipairs(talkInfo.branch_info) do
					local branchContent = branch.branch_content

					if branchContent then
						if not errorList[branchContent] then
							errorList[branchContent] = {}
							errorList[branchContent].count = 0
							errorList[branchContent].idList = {}
						end

						errorList[branchContent].content = branchContent
						errorList[branchContent].count = errorList[branchContent].count + 1

						table.insert(errorList[branchContent].idList, talkInfo.id .. "_isbranch" .. i)
					end
				end
			end

			if talkInfo.talk then
				local originalTalk = talkInfo.talk

				if not errorList[originalTalk] then
					errorList[originalTalk] = {}
					errorList[originalTalk].count = 0
				end

				local content = utils.replaceString(originalTalk, ",", "，")

				content = utils.replaceString(content, "\n", "\\n")
				errorList[originalTalk].content = content
				errorList[originalTalk].count = errorList[originalTalk].count + 1

				if not errorList[originalTalk].idList then
					errorList[originalTalk].idList = {}
				end

				table.insert(errorList[originalTalk].idList, talkInfo.id)

				local npcId = talkInfo.npc_id

				if talkInfo.section and npcId and ResTalkNpc[npcId] and ResTalkNpc[npcId].name and errorList[originalTalk] then
					local newNPCName = utils.format("段落%1s的%2s;", talkInfo.section, ResTalkNpc[npcId].name)

					if not errorList[originalTalk].npc then
						errorList[originalTalk].npc = ""
					end

					errorList[originalTalk].npc = errorList[originalTalk].npc .. newNPCName
				elseif errorList[originalTalk] then
					errorList[originalTalk].npc = utils.format("段落%1s的%2s;", talkInfo.section or "000000", "旁白")
				end
			end
		end

		for _, talkInfo in pairs(excelData) do
			if talkInfo.branch_info then
				for i, branch in ipairs(talkInfo.branch_info) do
					local branchContent = branch.branch_content

					if branchContent then
						if not errorList[branchContent] then
							errorList[branchContent] = {}
							errorList[branchContent].count = 0
							errorList[branchContent].idList = {}
						end

						errorList[branchContent].content = branchContent
						errorList[branchContent].count = errorList[branchContent].count + 1

						table.insert(errorList[branchContent].idList, talkInfo.id .. "_isbranch" .. i)
					end
				end
			end

			if talkInfo.talk then
				local originalTalk = talkInfo.talk

				if not errorList[originalTalk] then
					errorList[originalTalk] = {}
					errorList[originalTalk].count = 0
				end

				local content = utils.replaceString(originalTalk, ",", "，")

				content = utils.replaceString(content, "\n", "\\n")
				errorList[originalTalk].content = content
				errorList[originalTalk].count = errorList[originalTalk].count + 1

				if not errorList[originalTalk].idList then
					errorList[originalTalk].idList = {}
				end

				table.insert(errorList[originalTalk].idList, talkInfo.id)

				local npcId = talkInfo.npc_id

				if talkInfo.section and npcId and ResTalkNpc[npcId] and ResTalkNpc[npcId].name and errorList[originalTalk] then
					local newNPCName = utils.format("段落%1s的%2s;", talkInfo.section, ResTalkNpc[npcId].name)

					if not errorList[originalTalk].npc then
						errorList[originalTalk].npc = ""
					end

					errorList[originalTalk].npc = errorList[originalTalk].npc .. newNPCName
				elseif errorList[originalTalk] then
					errorList[originalTalk].npc = utils.format("段落%1s的%2s;", talkInfo.section or "000000", "旁白")
				end
			end
		end

		local file = io.open("TalkDuplicate" .. ".csv", "w")
		local output = "Content,Count,talkId,newContent, 是否是分支选项\n"

		for content, info in pairs(errorList) do
			if info.count >= 2 and DebugModule.hasChinese(info.content) then
				for index, talkID in pairs(info.idList) do
					local isBranch = string.find(talkID, "isbranch")

					if isBranch then
						local indexID = string.sub(talkID, -1)
						local prefix = "_" .. talkID .. indexID .. "_"
						local newContent = prefix .. info.content
						local lineStr = utils.format("%1s,%2s,%3s,%4s,%5s\n", info.content, info.count, talkID, newContent, "1")

						output = output .. lineStr
					else
						local prefix = "_" .. talkID .. "_"
						local newContent = prefix .. info.content
						local lineStr = utils.format("%1s,%2s,%3s,%4s,\n", info.content, info.count, talkID, newContent, "0")

						output = output .. lineStr
					end
				end
			end
		end

		file:write(output)
		file:flush()
		file:close()
	end
end

function DebugModule.hasChinese(content)
	local clearContent = content
	local ChineseSymbol = {
		"！",
		"。",
		"……",
		"，",
		"；",
		"~",
		"——",
		"？"
	}

	for index, symbol in ipairs(ChineseSymbol) do
		clearContent = string.gsub(clearContent, "(" .. symbol .. ")", "")
	end

	if clearContent == "♪ ♩ ♫ ♬ ♭¶ ♪♪ ♩ ♫ ♬ ♭¶ ♪♪ ♩ ♫ ♬ ♭¶ ♪♪ ♩ ♫ ♬ ♭¶ ♪" then
		return false
	end

	for i = 1, string.len(clearContent) do
		local byte = string.byte(clearContent, i)

		if byte > 127 then
			return true
		end
	end

	return false
end

function DebugModule._removeDuplicatePrefix(content)
	local _content = string.gsub(content, "_(.*)_", "")

	return _content
end

function DebugModule.checkOverflow(sender, menu, value)
	local AvgConfig = require("DesignerScript/AvgConfig")

	if Lang.inited then
		local valueList = utils.splitString(value, ",")

		if #valueList < 1 then
			return
		end

		local langRes = Lang.getRes()
		local strToId = {}

		if langRes then
			for key, value in pairs(langRes) do
				strToId[value] = key
			end
		end

		local checkSectionDic = {}

		for _, section in ipairs(valueList) do
			local sectionId = tonumber(section)

			checkSectionDic[sectionId] = true
		end

		local AVGInfo = require("UI/AVG/AVGInfo")
		local editorData, excelData = AVGInfo:getRawAVGData("ResTalk")
		local errorList = {}
		local talkBox = UIManager.getUI("talkBox", true)
		local talkTxt = UIControls.Label(talkBox, "AboveEfx/Content/Text")
		local text = talkTxt:getComObj()
		local standardHeight = 187

		for _, talkInfo in pairs(editorData) do
			if talkInfo.talk and talkInfo.section and checkSectionDic[talkInfo.section] then
				local talkStr = talkInfo.talk
				local talkStrs = utils.splitString(talkStr, "|")

				talkStr = talkStrs[1]
				talkStr = DebugModule._removeDuplicatePrefix(talkStr)

				talkTxt:setFontSize(talkInfo.font_size or AvgConfig.DEFAULT_FONT_SIZE)
				talkTxt:setText(talkStr)

				local height = text.preferredHeight

				if standardHeight < height then
					local errorMsg = {}

					errorMsg.section = talkInfo.section
					errorMsg.id = talkInfo.id
					errorMsg.content = talkInfo.talk
					errorMsg.baseId = strToId[talkInfo.talk]

					if not errorMsg.baseId then
						errorMsg.baseId = ""
					end

					table.insert(errorList, errorMsg)
				end
			end
		end

		for _, talkInfo in pairs(excelData) do
			if talkInfo.talk and talkInfo.section and checkSectionDic[talkInfo.section] then
				local talkStr = talkInfo.talk
				local talkStrs = utils.splitString(talkStr, "|")

				talkStr = talkStrs[1]
				talkStr = DebugModule._removeDuplicatePrefix(talkStr)

				talkTxt:setFontSize(talkInfo.font_size or AvgConfig.DEFAULT_FONT_SIZE)
				talkTxt:setText(talkStr)

				local height = text.preferredHeight

				if standardHeight < height then
					local errorMsg = {}

					errorMsg.section = talkInfo.section
					errorMsg.id = talkInfo.id
					errorMsg.content = talkInfo.talk
					errorMsg.baseId = strToId[talkInfo.talk]

					if not errorMsg.baseId then
						errorMsg.baseId = ""
					end

					table.insert(errorList, errorMsg)
				end
			end
		end

		talkBox:setVisible(false)

		local file = io.open("TalkOverFlowError" .. os.date("%m-%d-%H_%M_%S", ClientUtils.getServerTime()) .. ".csv", "w+")
		local output = "BaseID,SectionId,TalkId\n"

		for i, v in ipairs(errorList) do
			local lineStr = utils.format("%1s,%2s,%3s\n", v.baseId, v.section, v.id)

			output = output .. lineStr
		end

		file:write(output)
		file:flush()
		file:close()
	end
end

function DebugModule.getTalkContentByNpc(sender, menu, value)
	if Lang.inited then
		local ResTalkNpc = require("ClientData/ResTalkNpc")
		local valueList = utils.splitString(value, ",")

		if #valueList < 1 then
			return
		end

		local checkNpcIdDic = {}

		for _, npcInfo in pairs(ResTalkNpc) do
			for _, name in ipairs(valueList) do
				if npcInfo.name and string.find(npcInfo.name, name) then
					checkNpcIdDic[npcInfo.id] = true
				end
			end
		end

		local AVGInfo = require("UI/AVG/AVGInfo")
		local editorData, excelData = AVGInfo:getRawAVGData("ResTalk")
		local errorList = {}

		for _, talkInfo in pairs(editorData) do
			local npcId = talkInfo.npc_id

			if talkInfo.talk and npcId and checkNpcIdDic[npcId] then
				local errorMsg = {}
				local content = utils.replaceString(talkInfo.talk, ",", "，")

				content = utils.replaceString(content, "\n", "\\n")
				errorMsg.content = content
				errorMsg.id = talkInfo.id

				local npcInfo = ResTalkNpc[npcId]

				errorMsg.npcName = npcInfo.name
				errorMsg.npcId = npcId

				table.insert(errorList, errorMsg)
			end
		end

		for _, talkInfo in pairs(excelData) do
			local npcId = talkInfo.npc_id

			if talkInfo.talk and npcId and checkNpcIdDic[npcId] then
				local errorMsg = {}
				local content = utils.replaceString(talkInfo.talk, ",", "，")

				content = utils.replaceString(content, "\n", "\\n")
				errorMsg.content = content
				errorMsg.id = talkInfo.id

				local npcInfo = ResTalkNpc[npcId]

				errorMsg.npcName = npcInfo.name
				errorMsg.npcId = npcId

				table.insert(errorList, errorMsg)
			end
		end

		local function _sortError(errorMsgA, errorMsgB)
			if errorMsgA.npcName ~= errorMsgB.npcName then
				return errorMsgA.npcName < errorMsgB.npcName
			elseif errorMsgA.content ~= errorMsgB.content then
				return errorMsgA.content < errorMsgB.content
			else
				return errorMsgA.id < errorMsgB.id
			end
		end

		table.sort(errorList, _sortError)

		local file = io.open("TalkNPCContent" .. os.date("%m-%d-%H_%M_%S", ClientUtils.getServerTime()) .. ".csv", "w+")
		local output = "NpcName,Content,TalkId\n"

		for i, v in ipairs(errorList) do
			local lineStr = utils.format("%1s,%2s,%3s\n", v.npcName, v.content, v.id)

			output = output .. lineStr
		end

		file:write(output)
		file:flush()
		file:close()
	end
end

function DebugModule.getPlotRewindDetailContent(sender, menu, value)
	local AVGInfo = require("UI/AVG/AVGInfo")
	local ResTalkNpc = require("ClientData/ResTalkNpc")
	local editorData, excelData = AVGInfo:getRawAVGData("ResTalk")
	local sectionContentList = {}

	for _, talkInfo in pairs(editorData) do
		if talkInfo.section and (talkInfo.talk or talkInfo.branch_info) then
			if not sectionContentList[talkInfo.section] then
				sectionContentList[talkInfo.section] = {}
			end

			table.insert(sectionContentList[talkInfo.section], talkInfo)
		end
	end

	for _, talkInfo in pairs(excelData) do
		if talkInfo.section and (talkInfo.talk or talkInfo.branch_info) then
			if not sectionContentList[talkInfo.section] then
				sectionContentList[talkInfo.section] = {}
			end

			table.insert(sectionContentList[talkInfo.section], talkInfo)
		end
	end

	local outPutList = {}

	for idx1, resDataList in ipairs(ResPlotRewindDetail) do
		for idx2, resData in ipairs(resDataList) do
			for idx3, sectionInfo in ipairs(resData.section) do
				local sectionId = sectionInfo.id
				local contentList = sectionContentList[sectionId]

				if not contentList and ResVideoTalk[sectionId] and ResVideoTalk[sectionId].talk_id then
					contentList = sectionContentList[ResVideoTalk[sectionId].talk_id]
				end

				if contentList then
					for idx, talkInfo in ipairs(contentList) do
						if talkInfo.talk then
							local output = {}

							output.talkId = talkInfo.id

							local content = utils.replaceString(talkInfo.talk, ",", "，")

							content = utils.replaceString(content, "\n", "\\n")
							output.content = content
							output.npcName = "旁白"

							if talkInfo.npc_id and ResTalkNpc[talkInfo.npc_id] and ResTalkNpc[talkInfo.npc_id].name then
								local npc = utils.replaceString(ResTalkNpc[talkInfo.npc_id].name, ",", "，")

								npc = utils.replaceString(npc, "\n", "\\n")
								output.npcName = npc
							end

							output.section = talkInfo.section
							output.idx = idx1 * 100000 + idx2 * 1000 + idx3 * 1

							table.insert(outPutList, output)
						elseif talkInfo.branch_info then
							for _, branchInfo in ipairs(talkInfo.branch_info) do
								if branchInfo.branch_content and branchInfo.branch_content ~= "" then
									local output = {}

									output.talkId = talkInfo.id

									local content = utils.replaceString(branchInfo.branch_content, ",", "，")

									content = utils.replaceString(content, "\n", "\\n")
									output.content = content
									output.npcName = "旁白"

									if talkInfo.npc_id and ResTalkNpc[talkInfo.npc_id] and ResTalkNpc[talkInfo.npc_id].name then
										local npc = utils.replaceString(ResTalkNpc[talkInfo.npc_id].name, ",", "，")

										npc = utils.replaceString(npc, "\n", "\\n")
										output.npcName = npc
									end

									output.section = talkInfo.section
									output.idx = idx1 * 100000 + idx2 * 1000 + idx3 * 1

									table.insert(outPutList, output)
								end
							end
						end
					end
				end
			end
		end
	end

	local function _sortOutPut(outPutMsgA, outPutMsgB)
		if outPutMsgA.idx ~= outPutMsgB.idx then
			return outPutMsgA.idx < outPutMsgB.idx
		else
			return outPutMsgA.talkId < outPutMsgB.talkId
		end
	end

	table.sort(outPutList, _sortOutPut)

	local file = io.open("TalkRewindContent" .. os.date("%m-%d-%H_%M_%S", ClientUtils.getServerTime()) .. ".csv", "w+")
	local output = "Section,Content,NpcName,TalkId\n"

	for i, v in ipairs(outPutList) do
		local lineStr = utils.format("%1s,%2s,%3s,%4s\n", v.section, v.content, v.npcName, v.talkId)

		output = output .. lineStr
	end

	file:write(output)
	file:flush()
	file:close()
end

function DebugModule.getAVGContent(sender, menu, value)
	local AVGInfo = require("UI/AVG/AVGInfo")
	local editorData, excelData = AVGInfo:getRawAVGData("ResTalk")
	local ResTalkNpc = require("ClientData/ResTalkNpc")
	local valueList = utils.splitString(value, ",")

	if #valueList < 1 then
		return
	end

	local checkSectionList = {}

	for _, section in ipairs(valueList) do
		local sectionId = tonumber(section)

		table.insert(checkSectionList, sectionId)
	end

	local TALK_TYPE_DIC = {
		[0] = "左",
		"右",
		"内心",
		"旁白",
		"分支",
		"爆炸",
		"特殊交互",
		"出场介绍",
		"章节结束",
		"旁白黑",
		"标题动画",
		"视频",
		"入册表现",
		"终端对话",
		"终端爆炸",
		"直播",
		"宣传图"
	}
	local sectionContentList = {}

	for _, talkInfo in pairs(editorData) do
		if talkInfo.section and (talkInfo.talk or talkInfo.branch_info) then
			if not sectionContentList[talkInfo.section] then
				sectionContentList[talkInfo.section] = {}
			end

			table.insert(sectionContentList[talkInfo.section], talkInfo)
		end
	end

	for _, talkInfo in pairs(excelData) do
		if talkInfo.section and (talkInfo.talk or talkInfo.branch_info) then
			if not sectionContentList[talkInfo.section] then
				sectionContentList[talkInfo.section] = {}
			end

			table.insert(sectionContentList[talkInfo.section], talkInfo)
		end
	end

	local outPutList = {}

	for idx1, sectionId in ipairs(checkSectionList) do
		local contentList = sectionContentList[sectionId]

		if not contentList and ResVideoTalk[sectionId] and ResVideoTalk[sectionId].talk_id then
			contentList = sectionContentList[ResVideoTalk[sectionId].talk_id]
		end

		if contentList then
			for idx, talkInfo in ipairs(contentList) do
				if talkInfo.talk then
					local output = {}

					output.talkId = talkInfo.id

					local content = utils.replaceString(talkInfo.talk, ",", "，")

					content = utils.replaceString(content, "\n", "\\n")
					output.content = content
					output.npcName = "旁白"

					if talkInfo.npc_id and ResTalkNpc[talkInfo.npc_id] and ResTalkNpc[talkInfo.npc_id].name then
						local npc = utils.replaceString(ResTalkNpc[talkInfo.npc_id].name, ",", "，")

						npc = utils.replaceString(npc, "\n", "\\n")
						output.npcName = npc
					end

					output.section = talkInfo.section
					output.talkType = talkInfo.talk_type and TALK_TYPE_DIC[talkInfo.talk_type] or ""
					output.idx = idx1

					table.insert(outPutList, output)
				elseif talkInfo.branch_info then
					for _, branchInfo in ipairs(talkInfo.branch_info) do
						if branchInfo.branch_content and branchInfo.branch_content ~= "" then
							local output = {}

							output.talkId = talkInfo.id

							local content = utils.replaceString(branchInfo.branch_content, ",", "，")

							content = utils.replaceString(content, "\n", "\\n")
							output.content = content
							output.npcName = "旁白"

							if talkInfo.npc_id and ResTalkNpc[talkInfo.npc_id] and ResTalkNpc[talkInfo.npc_id].name then
								local npc = utils.replaceString(ResTalkNpc[talkInfo.npc_id].name, ",", "，")

								npc = utils.replaceString(npc, "\n", "\\n")
								output.npcName = npc
							end

							output.section = talkInfo.section
							output.idx = idx1
							output.talkType = talkInfo.talk_type and TALK_TYPE_DIC[talkInfo.talk_type] or ""

							table.insert(outPutList, output)
						end
					end
				end
			end
		end
	end

	local function _sortOutPut(outPutMsgA, outPutMsgB)
		if outPutMsgA.idx ~= outPutMsgB.idx then
			return outPutMsgA.idx < outPutMsgB.idx
		else
			return outPutMsgA.talkId < outPutMsgB.talkId
		end
	end

	table.sort(outPutList, _sortOutPut)

	local file = io.open("TalkAVGContent" .. os.date("%m-%d-%H_%M_%S", ClientUtils.getServerTime()) .. ".csv", "w+")
	local output = "Section,Content,NpcName,TalkId,TalkType\n"

	for i, v in ipairs(outPutList) do
		local lineStr = string.format("%s,%s,%s,%s,%s\n", v.section, v.content, v.npcName, v.talkId, v.talkType)

		output = output .. lineStr
	end

	file:write(output)
	file:flush()
	file:close()
end

function DebugModule.forBandiRebuild(sender, menu, groupName)
	local returnBg = require("ClientData/AVGData/EditorData/" .. groupName .. "/ResTalkBg")
	local resBg = returnBg
	local bgIndexMap = require("ClientData/AVGData/EditorData/bgIndexMap")
	local returnTalk = require("ClientData/AVGData/EditorData/banai/ResTalk")
	local resTalk = returnTalk
	local talkIndexMap = require("ClientData/AVGData/EditorData/restaskIndexMap")
	local indexMapResTalkAction = require("ClientData/AVGData/EditorData/resTalkActionIndexMap")
	local returnScenery = require("ClientData/AVGData/EditorData/" .. groupName .. "/ResTalkScenery")
	local resScenery = returnScenery
	local sceneryIndexMap = require("ClientData/AVGData/EditorData/sceneryIndexMap")
	local json = require("Debug/AVGEditor/dkjson")
	local rawBg = DebugModule.rebuildFromIndexmap(resBg, bgIndexMap)
	local rawTalk = DebugModule.rebuildTalkFromIndexmap(resTalk, talkIndexMap, indexMapResTalkAction)
	local rawScenery = DebugModule.rebuildFromIndexmap(resScenery, sceneryIndexMap)
	local str = json.encode(rawBg, {
		indent = true
	})
	local filePath = "Assets/" .. groupName .. "/ResTalkBg.json"
	local file = io.open(filePath, "w")

	io.output(file)
	io.write(str)
	io.close()

	str = json.encode(rawScenery, {
		indent = true
	})
	filePath = "Assets/" .. groupName .. "/ResTalkScenery.json"
	file = io.open(filePath, "w")

	io.output(file)
	io.write(str)
	io.close()

	str = json.encode(rawTalk, {
		indent = true
	})
	filePath = "Assets/" .. groupName .. "/ResTalk.json"
	file = io.open(filePath, "w")

	io.output(file)
	io.write(str)
	io.close()
end

function DebugModule.rebuildFromIndexmap(oriTable, indexMap)
	local flag = false
	local newTable = {}

	for index = 22600, 22899 do
		if oriTable[index] then
			newTable[index] = {}

			for key, value in pairs(indexMap) do
				newTable[index][key] = oriTable[index][key]
			end
		end
	end

	return newTable
end

function DebugModule.rebuildTalkFromIndexmap(oriTable, indexMap, actionIndexMap)
	local flag = false
	local newTable = {}

	for index, data in pairs(oriTable) do
		newTable[index] = {}

		for key, value in pairs(indexMap) do
			if key == "action" then
				if data[key] then
					newTable[index][key] = {}

					for _index, _data in pairs(data[key]) do
						newTable[index][key][_index] = {}

						for _key, _value in pairs(actionIndexMap) do
							newTable[index][key][_index][_key] = data[key][_index][_key]
						end
					end
				end
			else
				newTable[index][key] = data[key]
			end
		end
	end

	return newTable
end

function DebugModule.getAVGRichError(sender, menu, value)
	local AVGInfo = require("UI/AVG/AVGInfo")
	local editorData, excelData = AVGInfo:getRawAVGData("ResTalk")
	local ResTalkNpc = require("ClientData/ResTalkNpc")
	local valueList = utils.splitString(value, ",")

	if #valueList < 1 then
		return
	end

	local checkSectionList = {}

	for _, section in ipairs(valueList) do
		local sectionId = tonumber(section)

		table.insert(checkSectionList, sectionId)
	end

	local sectionContentList = {}

	for _, talkInfo in pairs(editorData) do
		if talkInfo.section and (talkInfo.talk or talkInfo.branch_info) then
			if not sectionContentList[talkInfo.section] then
				sectionContentList[talkInfo.section] = {}
			end

			table.insert(sectionContentList[talkInfo.section], talkInfo)
		end
	end

	for _, talkInfo in pairs(excelData) do
		if talkInfo.section and (talkInfo.talk or talkInfo.branch_info) then
			if not sectionContentList[talkInfo.section] then
				sectionContentList[talkInfo.section] = {}
			end

			table.insert(sectionContentList[talkInfo.section], talkInfo)
		end
	end

	local outPutList = {}

	for idx1, sectionId in ipairs(checkSectionList) do
		local contentList = sectionContentList[sectionId]

		if not contentList and ResVideoTalk[sectionId] and ResVideoTalk[sectionId].talk_id then
			contentList = sectionContentList[ResVideoTalk[sectionId].talk_id]
		end

		if contentList then
			for idx, talkInfo in ipairs(contentList) do
				if talkInfo.talk then
					local output = {}

					output.talkId = talkInfo.id

					local content = utils.replaceString(talkInfo.talk, ",", "，")

					content = utils.replaceString(content, "\n", "\\n")
					content = ClientUtils.checkMarkIllegal(content)

					if string.find(content, "<%w.->") or string.find(content, "</.->") then
						output.content = content
						output.section = talkInfo.section
						output.idx = idx1

						table.insert(outPutList, output)
					end
				elseif talkInfo.branch_info then
					for _, branchInfo in ipairs(talkInfo.branch_info) do
						if branchInfo.branch_content and branchInfo.branch_content ~= "" then
							local output = {}

							output.talkId = talkInfo.id

							local content = utils.replaceString(branchInfo.branch_content, ",", "，")

							content = utils.replaceString(content, "\n", "\\n")
							content = ClientUtils.checkMarkIllegal(content)

							if string.find(content, "<%w.->") or string.find(content, "</.->") then
								output.content = content
								output.section = talkInfo.section
								output.idx = idx1

								table.insert(outPutList, output)
							end
						end
					end
				end
			end
		end
	end

	if #outPutList <= 0 then
		return
	end

	local function _sortOutPut(outPutMsgA, outPutMsgB)
		if outPutMsgA.idx ~= outPutMsgB.idx then
			return outPutMsgA.idx < outPutMsgB.idx
		else
			return outPutMsgA.talkId < outPutMsgB.talkId
		end
	end

	table.sort(outPutList, _sortOutPut)

	local file = io.open("TalkAVGRichError" .. os.date("%m-%d-%H_%M_%S", ClientUtils.getServerTime()) .. ".csv", "w+")
	local output = "Section,Content\n"

	for i, v in ipairs(outPutList) do
		local lineStr = string.format("%s,%s\n", v.section, v.content)

		output = output .. lineStr
	end

	file:write(output)
	file:flush()
	file:close()
end

DebugModule.FUNC_MENU = {
	{
		name = "输入段落",
		typ = DebugConst.BTN_TYPE_INPUT,
		func = DebugModule.stepA
	},
	{
		name = "新手AVG段落",
		typ = DebugConst.BTN_TYPE_INPUT,
		func = DebugModule.newbieAVG
	},
	{
		name = "输入段落列表",
		typ = DebugConst.BTN_TYPE_INPUT,
		func = DebugModule.stepList
	},
	{
		name = "可重复观看AVG",
		typ = DebugConst.BTN_TYPE_BUTTON,
		func = DebugModule.setForcePlayAvg
	},
	{
		name = "检查重复ID",
		typ = DebugConst.BTN_TYPE_BUTTON,
		func = DebugModule.checkRepeatedAVG
	},
	{
		name = "检查不存在译文的AVG",
		typ = DebugConst.BTN_TYPE_INPUT,
		func = DebugModule.checkErrorTranslate
	},
	{
		name = "AVG检查文本是否超框",
		typ = DebugConst.BTN_TYPE_INPUT,
		func = DebugModule.checkOverflow
	},
	{
		name = "检查不存在译文的主线关卡",
		typ = DebugConst.BTN_TYPE_INPUT,
		func = DebugModule.checkErrorMainStage
	},
	{
		name = "检查AVG文本重复",
		typ = DebugConst.BTN_TYPE_BUTTON,
		func = DebugModule.checkDuplicateAvg
	},
	{
		name = "拉某NPC说的所有话",
		typ = DebugConst.BTN_TYPE_INPUT,
		func = DebugModule.getTalkContentByNpc
	},
	{
		name = "拉剧情回看表内容",
		typ = DebugConst.BTN_TYPE_BUTTON,
		func = DebugModule.getPlotRewindDetailContent
	},
	{
		name = "拉某段落AVG内容",
		typ = DebugConst.BTN_TYPE_INPUT,
		func = DebugModule.getAVGContent
	},
	{
		name = "从lua提取Json",
		typ = DebugConst.BTN_TYPE_INPUT,
		func = DebugModule.forBandiRebuild
	},
	{
		name = "检查AVG富文本错误",
		typ = DebugConst.BTN_TYPE_INPUT,
		func = DebugModule.getAVGRichError
	}
}

return DebugModule
