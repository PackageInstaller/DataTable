-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/gm/controller/GMController.lua

module("logic.extensions.gm.controller.GMController", package.seeall)

local GMController = class("GMController", BaseController)

GMController.MsgUseType = {
	Respond = 2,
	Request = 1
}
GMController.StatusType = {
	Error = 1,
	Correct = 2
}
GMController.LocalSearchDataArraysKey = "LocalSearchDataArraysKey"

local json = require("cjson")

function GMController:ctor()
	self.isRecMsg = false
	self.msgList = {}

	self:_initMsgListInfo()

	self.filter_list = {
		"1_1",
		"4_10",
		"4_9"
	}
	self.fightId = 0
	self.fightMsgList = {}
end

function GMController:setOpenBattleGMView(value)
	Framework.LocalStorage.Instance:SetInt("Battle_Open_GM_View", value and 1 or 0)
	GlobalDispatcher:dispatch(GlobalNotify.ActiveBattleGM)
end

function GMController:isOpenBattleGMView()
	return Framework.LocalStorage.Instance:GetInt("Battle_Open_GM_View", 0) ~= 0
end

function GMController:showGM(show)
	if enableDebug == true then
		if show == false then
			ViewMgr.instance:close(ViewName.GMView)
		else
			ViewMgr.instance:setPermanent(ViewName.GMView, true)
			ViewMgr.instance:open(ViewName.GMView)
		end
	end
end

function GMController:getIsRecMsg()
	if enableDebug then
		local name = "rec_" .. LoginModel.instance.userId

		self.isRecMsg = UnityEngine.PlayerPrefs.GetInt(name) == 1
	else
		self.isRecMsg = false
	end
end

function GMController:setIsRecMsg(boo)
	if enableDebug then
		self.isRecMsg = boo

		local name = "rec_" .. LoginModel.instance.userId

		if boo then
			UnityEngine.PlayerPrefs.SetInt(name, 1)
		else
			UnityEngine.PlayerPrefs.SetInt(name, 0)
		end
	end
end

function GMController:splitByNewlines(input, maxNewlines)
	local result = {}
	local count = 0
	local currentSegment = {}

	for line in input:gmatch("[^\n]*") do
		if line ~= "" then
			table.insert(currentSegment, line)

			count = count + 1
		end

		if maxNewlines <= count then
			table.insert(result, table.concat(currentSegment, "\n"))

			currentSegment = {}
			count = 0
		end
	end

	if #currentSegment > 0 then
		table.insert(result, table.concat(currentSegment, "\n"))
	end

	return result
end

function GMController:sendMsg(extId, cmdId, name, msg)
	if self.isRecMsg then
		local cmd = extId .. "_" .. cmdId

		if table.indexof(self.filter_list, cmd) then
			-- block empty
		else
			local msgStr = NetConnMgr.instance:_dumpMsg(msg)

			msgStr = self:cutStr(msgStr)

			local str = string.format("上行:[<color=#ff00ff>%s</color>]扩展:%s\n<color=#cccccc>%s</color>\n------", cmd, name, msgStr)
			local msgUseType = GMController.MsgUseType.Request
			local obj = self:_makeMsgObj(msgUseType, msg, nil, cmd, str, 1)

			self:_addObjToMsgList(obj)
			self:notify(GMModel.Notify.GMCONTROLLER_DUMP_MSG)
		end
	end
end

function GMController:handleMsg(extId, cmdId, name, msg, status)
	if self.isRecMsg then
		local cmd = extId .. "_" .. cmdId

		if table.indexof(self.filter_list, cmd) then
			-- block empty
		else
			local msgStr = type(msg) == "string" and msg or NetConnMgr.instance:_dumpMsg(msg)

			msgStr = self:cutStr(msgStr)

			local str = string.format("下行:[<color=#00ff00>%s</color>]R:[<color=%s>%s</color>] 扩展:%s\n\t<color=#FFFF00FF>%s</color>\n------", cmd, (status ~= 0 or nil) and "#ff0000", status, name, msgStr)
			local msgUseType = GMController.MsgUseType.Respond
			local obj = self:_makeMsgObj(msgUseType, msg, status, cmd, str, 1)

			self:_addObjToMsgList(obj)

			if status == 0 then
				self:dealFight(cmd, msg, obj)
			end

			self:notify(GMModel.Notify.GMCONTROLLER_DUMP_MSG)
		end
	end
end

function GMController:dealFight(cmd, msg, obj)
	if cmd == "5_1" then
		self.isRecFightMsg = true
		self.fightId = self.fightId + 1
		obj.fightId = self.fightId

		self:_addFightMsg(obj.fightId, msg)
	elseif cmd == "5_2" then
		obj.fightId = self.fightId

		self:_addFightMsg(obj.fightId, msg)
	elseif cmd == "5_3" then
		obj.fightId = self.fightId

		self:_addFightMsg(obj.fightId, msg)

		self.isRecFightMsg = false
	end
end

function GMController:_addFightMsg(fightId, msg)
	if self.isRecFightMsg == true then
		local msgClone
		local str = msg:SerializeToString()

		if msg._cname == "PM_BtlStartRes" then
			msgClone = BattleExtension_pb.PM_BtlStartRes()
		elseif msg._cname == "PM_NewRoundsGenRes" then
			msgClone = BattleExtension_pb.PM_NewRoundsGenRes()
		elseif msg._cname == "PM_BtlEndRes" then
			msgClone = BattleExtension_pb.PM_BtlEndRes()
		end

		msgClone:ParseFromString(str)

		self.fightMsgList[fightId] = self.fightMsgList[fightId] or {}

		table.insert(self.fightMsgList[fightId], msgClone)
	end
end

function GMController:cutStr(str)
	local len = string.len(str)

	if len > 4000 then
		return string.sub(str, 1, 4000) .. "..."
	else
		return str
	end
end

function GMController:copyToClipBoard(msg)
	local jsobj = self:_dumpMsg(msg)
	local msgStr = GameUtil.jsonToString(jsobj)

	Game.TextUtil.CopyToClipBoard(msgStr)

	local obj = GameUtil.jsonToTable(msgStr)
end

function GMController:hasRep(data)
	if data.key == "5_1" or data.key == "5_2" or data.key == "5_3" then
		return true
	end

	return false
end

function GMController:replayMsg(data)
	if SceneMgr.instance.isGogingToEnterBattleScene then
		return
	end

	if data.fightId then
		local arr = self.fightMsgList[data.fightId]

		if #arr >= 3 then
			BattleController.instance:onBattleStart(arr[1])

			for i = 2, #arr - 1 do
				local msg = arr[i]
				local battid = msg.battleId
				local newroundsresult = msg.newRoundsResult

				BattleModel.instance:pushOneRoundResult(battid, newroundsresult)
			end

			BattleModel.instance:onBattleResult(arr[#arr - 1])
		end
	end
end

function GMController:saveMsg(data)
	if data.fightId then
		local arr = self.fightMsgList[data.fightId]

		if #arr >= 3 then
			local originalStates = arr[1]:SerializeToString()
			local rounds = BattlePublicDef_pb.PM_OneFightResult()

			for i = 2, #arr - 1 do
				for j = 1, #arr[i].newRoundsResult do
					table.insert(rounds.roundList, arr[i].newRoundsResult[j])
				end
			end

			local roundsResult = rounds:SerializeToString()
			local resultResult = arr[#arr - 1]:SerializeToString()
			local saveStartPath = Framework.FileUtils.Instance:FullPathForFile(BattleModel.CgBattleStartPath)
			local saveRoundPath = Framework.FileUtils.Instance:FullPathForFile(BattleModel.CgBattleRoundPath)
			local saveResultPath = Framework.FileUtils.Instance:FullPathForFile(BattleModel.CgBattleResultPath)

			Framework.FileUtils.Instance:CheckDirExistsForFile(saveStartPath)
			Framework.FileUtils.Instance:CheckDirExistsForFile(saveRoundPath)
			Framework.FileUtils.Instance:CheckDirExistsForFile(saveResultPath)
			Framework.FileUtils.Instance:WriteFile(originalStates, saveStartPath)
			Framework.FileUtils.Instance:WriteFile(roundsResult, saveRoundPath)
			Framework.FileUtils.Instance:WriteFile(resultResult, saveResultPath)
		end
	end
end

function GMController:clearMsg()
	self.msgList = {}

	self:_initMsgListInfo()

	if self.isRecFightMsg == true then
		for k, v in pairs(self.fightMsgList) do
			if k ~= self.fightId then
				self.fightMsgList[k] = nil
			end
		end
	else
		self.fightMsgList = {}
	end

	self:notify(GMModel.Notify.GMCONTROLLER_DUMP_MSG)
end

function GMController:getAllMsg()
	return self.msgList
end

function GMController:getMsgObj(msgId)
	return self.msgList[msgId]
end

function GMController:_addObjToMsgList(obj)
	if obj then
		table.insert(self.msgList, obj)
		self:_setUseTypeNumOfMsg(obj.useType, self:getUseTypeNumOfMsg(obj.useType) + 1)
		self:_setStatusTypeNumOfMsg(obj.statusType, self:getStatusTypeNumOfMsg(obj.statusType) + 1)
	else
		printError("错误,尝试添加空的消息块")
	end
end

function GMController:_dumpMsg(pbMsg, tb)
	tb = tb or {}

	if pbMsg._fields ~= nil and _G.next(pbMsg._fields) ~= nil then
		for k, v in pairs(pbMsg._fields) do
			if v then
				tb[k.name] = type(v) ~= "table" and v or self:_dumpMsg(v)
			end
		end

		return tb
	else
		for k, v in ipairs(pbMsg) do
			if v then
				tb[k] = type(v) ~= "table" and v or self:_dumpMsg(v)
			end
		end

		return tb
	end

	return tb
end

function GMController:showCustomMsg(...)
	local str = "自定义消息："
	local list = {
		...
	}

	for i, v in ipairs(list) do
		str = str .. "  " .. tostring(v)
	end

	local cmd = "test"
	local msg
	local status = 0
	local msgUseType = GMController.MsgUseType.Respond
	local obj = self:_makeMsgObj(msgUseType, msg, status, cmd, str, 1)

	self:_addObjToMsgList(obj)
	self:dealFight(cmd, msg, obj)
	self:notify(GMModel.Notify.GMCONTROLLER_DUMP_MSG)
end

function GMController:_makeMsgObj(useType, msg, status, key, str, idx)
	local obj = {}

	if useType then
		obj.useType = useType
	else
		printError("useType is nil")
	end

	if key == "5_1" or key == "5_2" or key == "5_3" then
		msg = clone(msg)
	end

	obj.msg = msg
	obj.status = status or 0
	obj.key = key or "nil"
	obj.str = str or "nil"
	obj.idx = idx
	obj.statusType = GMController.StatusType.Correct

	if obj.status < 0 then
		obj.statusType = GMController.StatusType.Error
	end

	return obj
end

function GMController:getMsgNum()
	return #self.msgList
end

function GMController:_initMsgListInfo()
	self._msgListInfo = {}
	self._msgListInfo.useTypeNums = {}
	self._msgListInfo.statusTypeNums = {}
end

function GMController:getUseTypeNumOfMsg(useType)
	return self._msgListInfo.useTypeNums[useType] or 0
end

function GMController:_setUseTypeNumOfMsg(useType, num)
	self._msgListInfo.useTypeNums[useType] = num
end

function GMController:getStatusTypeNumOfMsg(statusType)
	return self._msgListInfo.statusTypeNums[statusType] or 0
end

function GMController:_setStatusTypeNumOfMsg(statusType, num)
	self._msgListInfo.statusTypeNums[statusType] = num
end

function GMController:getLocalSearchDataArrays()
	local lists
	local jsonStr = Framework.LocalStorage.Instance:GetString(GMController.LocalSearchDataArraysKey, "")

	if not string.nilorempty(jsonStr) then
		lists = GameUtil.jsonToTable(jsonStr)
	end

	local result = {}

	if lists then
		for key, list in pairs(lists) do
			local array = Array.New()

			for _, val in ipairs(list) do
				array:PushBack(val)
			end

			result[key] = array
		end
	end

	return result
end

function GMController:saveLocalSearchDataArrays(value)
	local lists = {}

	if value then
		for key, array in pairs(value) do
			lists[key] = {}

			for index = 0, array:GetSize() - 1 do
				table.insert(lists[key], array:Get(index))
			end
		end
	end

	Framework.LocalStorage.Instance:SetString(GMController.LocalSearchDataArraysKey, GameUtil.jsonToString(lists))
	Framework.LocalStorage.Instance:Save()
end

GMController.instance = GMController.New()

return GMController
