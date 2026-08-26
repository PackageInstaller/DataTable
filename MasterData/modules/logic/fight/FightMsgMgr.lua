-- chunkname: @modules/logic/fight/FightMsgMgr.lua

module("modules.logic.fight.FightMsgMgr", package.seeall)

local FightMsgMgr = class("FightMsgMgr")
local xpcall = xpcall
local __G__TRACKBACK__ = __G__TRACKBACK__
local FightMsgItem = FightMsgItem
local pairs = pairs
local msgItems = {}
local msgItemCount = {}
local needRemove = false
local replyIndex = {}
local replyDic = {}
local checkRemoveId = {}

function FightMsgMgr.registMsg(msgId, callback, handle)
	local list = msgItems[msgId]

	if not list then
		list = {}
		msgItems[msgId] = list
	end

	local msgItem = FightMsgItem.New(msgId, callback, handle)
	local count = (msgItemCount[msgId] or 0) + 1

	msgItemCount[msgId] = count
	list[count] = msgItem

	return msgItem
end

function FightMsgMgr.sendMsg(msgId, ...)
	local list = msgItems[msgId]

	if not list then
		return
	end

	if not replyIndex[msgId] then
		local curIndex = 0

		curIndex = curIndex + 1
		replyIndex[msgId] = curIndex

		local count = msgItemCount[msgId]

		for i = 1, count do
			local item = list[i]

			if not item.isDone then
				xpcall(item.callback, __G__TRACKBACK__, item.handle, ...)
			end
		end

		replyIndex[msgId] = curIndex - 1

		local replyData = replyDic[msgId]

		if replyData then
			local replyList = replyData.list[curIndex]

			if replyList then
				replyData.list[curIndex] = nil
				replyData.listCount[curIndex] = nil

				return replyList[1], replyList
			end
		end
	end
end

function FightMsgMgr.replyMsg(msgId, reply)
	if not replyIndex[msgId] then
		local curIndex = 0

		if curIndex == 0 then
			return
		end

		local replyData = replyDic[msgId]

		if not replyData then
			replyData = {
				list = {},
				listCount = {}
			}
			replyDic[msgId] = replyData
		end

		local replyList = replyData.list[curIndex]

		if not replyData.listCount[curIndex] then
			local count = 0

			if not replyList then
				replyList = {}
				replyData.list[curIndex] = replyList
			end

			count = replyData.listCount[curIndex] + 1
			replyData.listCount[curIndex] = replyData.listCount[curIndex]
			replyList[replyData.listCount[curIndex]] = reply
		end
	end
end

function FightMsgMgr.removeMsg(msgItem)
	if not msgItem then
		return
	end

	msgItem.isDone = true
	checkRemoveId[msgItem.msgId] = true
	needRemove = true
end

function FightMsgMgr.clearMsg()
	if not needRemove then
		return
	end

	for msgId, v in pairs(checkRemoveId) do
		local list = msgItems[msgId]

		if list then
			local listCount = msgItemCount[msgId]
			local j = 1

			for i = 1, listCount do
				local item = list[i]

				if not item.isDone then
					if i ~= j then
						list[j] = item
						list[i] = nil
					end

					j = j + 1
				else
					list[i] = nil
				end
			end

			listCount = j - 1
			msgItemCount[msgId] = j - 1

			if listCount == 0 then
				msgItems[msgId] = nil
				replyDic[msgId] = nil
			end
		end

		checkRemoveId[msgId] = nil
	end

	needRemove = false
end

FightTimer.registRepeatTimer(FightMsgMgr.clearMsg, FightMsgMgr, 10, -1)

return FightMsgMgr
