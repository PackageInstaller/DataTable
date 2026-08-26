-- chunkname: @modules/logic/reddot/rpc/RedDotRpc.lua

module("modules.logic.reddot.rpc.RedDotRpc", package.seeall)

local RedDotRpc = class("RedDotRpc", BaseRpc)

function RedDotRpc:sendGetRedDotInfosRequest(ids, callback, callbackObj)
	local req = RedDotModule_pb.GetRedDotInfosRequest()

	if ids then
		for i, id in ipairs(ids) do
			table.insert(req.ids, id)
		end
	end

	return self:sendMsg(req, callback, callbackObj)
end

function RedDotRpc:onReceiveGetRedDotInfosReply(resultCode, msg)
	if resultCode == 0 then
		RedDotModel.instance:setRedDotInfo(msg.redDotInfos)

		local refreshlist = {}

		for _, v in ipairs(msg.redDotInfos) do
			local ids = RedDotModel.instance:_getAssociateRedDots(v.defineId)

			for _, id in pairs(ids) do
				refreshlist[id] = true
			end
		end

		RedDotController.instance:CheckExpireDot()
		RedDotController.instance:dispatchEvent(RedDotEvent.UpdateRelateDotInfo, refreshlist)
		RedDotController.instance:dispatchEvent(RedDotEvent.RefreshClientCharacterDot)
	end
end

function RedDotRpc:onReceiveUpdateRedDotPush(resultCode, msg)
	if resultCode == 0 then
		RedDotModel.instance:updateRedDotInfo(msg.redDotInfos)

		local refreshlist = {}

		for _, v in ipairs(msg.redDotInfos) do
			local ids = RedDotModel.instance:_getAssociateRedDots(v.defineId)

			for _, id in pairs(ids) do
				refreshlist[id] = true
			end
		end

		RedDotController.instance:CheckExpireDot()
		RedDotController.instance:dispatchEvent(RedDotEvent.UpdateRelateDotInfo, refreshlist)
		RedDotController.instance:dispatchEvent(RedDotEvent.RefreshClientCharacterDot)
	end
end

function RedDotRpc:sendShowRedDotRequest(defineId, isVisible)
	local req = RedDotModule_pb.ShowRedDotRequest()

	req.defineId = defineId
	req.isVisible = isVisible

	self:sendMsg(req)
end

function RedDotRpc:onReceiveShowRedDotReply(resultCode, msg)
	if resultCode == 0 then
		-- block empty
	end
end

function RedDotRpc:clientAddRedDotGroupList(list, replaceAll)
	local groups = {}

	for _, v in ipairs(list) do
		groups[v.id] = groups[v.id] or {}

		local info = self:clientMakeRedDotGroupItem(v.uid, v.value)

		table.insert(groups[v.id], info)
	end

	local msg = {
		redDotInfos = {},
		replaceAll = replaceAll or false
	}

	for id, infos in pairs(groups) do
		local redDotInfo = self:clientMakeRedDotGroup(id, infos, replaceAll)

		table.insert(msg.redDotInfos, redDotInfo)
	end

	self:onReceiveUpdateRedDotPush(0, msg)
end

function RedDotRpc:clientMakeRedDotGroupItem(uid, value, time, ext)
	return {
		id = uid or 0,
		value = value or 0,
		time = time or 0,
		ext = ext or ""
	}
end

function RedDotRpc:clientMakeRedDotGroup(id, infos, replaceAll)
	return {
		defineId = id,
		infos = infos,
		replaceAll = replaceAll or false
	}
end

RedDotRpc.instance = RedDotRpc.New()

return RedDotRpc
