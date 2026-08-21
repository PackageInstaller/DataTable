-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/reddot/agent/RedDotAgent.lua

module("logic.extensions.reddot.agent.RedDotAgent", package.seeall)

local M = class("RedDotAgent", BaseAgent)
local defaultStr = "0"

function M:ctor()
	M.super.ctor(self)

	self._parseFun = {}
end

function M:sendLoadAllRedPointRequest()
	local msg = RedPointExtension_pb.LoadAllRedPointRequest()

	self:sendMsg(msg)
end

function M:handleLoadAllRedPointReply(status, msg)
	if status == 0 then
		RedDotModel.instance:clear()
		GlobalDispatcher:dispatchEvent(EventType.RED_DOT_RESET)
		RedDotModel.instance:updateRedDotInfo(msg.redPoints)

		for k, v in ipairs(msg.redPoints) do
			local type = v.type
			local detailStrs, num = self._parseFun[type] and self._parseFun[type](v.detail) or RedDotModel.instance:getRedDotDetailList(type)

			print("显示的红点类型", type, v.detail, #detailStrs)

			if #detailStrs > 0 then
				for k1, str in pairs(detailStrs) do
					if str ~= defaultStr then
						GlobalDispatcher:dispatchEvent(EventType.RED_DOT_UPDATE_EVENT, {
							isActive = true,
							key = type .. "_" .. str,
							parentKey = type
						})
					end
				end
			end

			if self:_isOnlyOneRedPoint(detailStrs) then
				GlobalDispatcher:dispatchEvent(EventType.RED_DOT_UPDATE_EVENT, {
					isActive = true,
					key = type,
					num = num
				})
			end
		end
	end

	GlobalDispatcher:dispatchEvent(EventType.ENTER_GAME_REQUEST_OVER_EVENT, true)
end

function M:createRedDotDetailByIdList(ids)
	if ids and #ids > 0 then
		local detail = "["

		for i = 1, #ids - 1 do
			detail = detail .. ids[i] .. ","
		end

		detail = detail .. ids[#ids] .. "]"

		return detail
	else
		return "[0]"
	end
end

function M:sendRemoveRedPointRequest(type, ids)
	local msg = RedPointExtension_pb.RemoveRedPointRequest()
	local no = msg.redPoint

	no.type = type
	no.detail = self:createRedDotDetailByIdList(ids)

	self:sendMsg(msg)
end

function M:handleRemoveRedPointReply(status, msg)
	if status == 0 then
		-- block empty
	end
end

function M:handleChangeRedPointPush(status, msg)
	if status == 0 then
		if msg.add then
			RedDotModel.instance:addRedDotDetails(msg.add.type, msg.add.detail)

			local detailStrs, num = self._parseFun[type] and self._parseFun[type](msg.add.detail) or RedDotModel.instance:splitDetailStr(msg.add.detail)

			if #detailStrs > 0 then
				for k1, str in pairs(detailStrs) do
					if str ~= defaultStr then
						GlobalDispatcher:dispatchEvent(EventType.RED_DOT_UPDATE_EVENT, {
							isActive = true,
							key = msg.add.type .. "_" .. str,
							parentKey = msg.add.type
						})
					end
				end
			end

			if self:_isOnlyOneRedPoint(detailStrs) then
				GlobalDispatcher:dispatchEvent(EventType.RED_DOT_UPDATE_EVENT, {
					isActive = true,
					key = msg.add.type,
					num = num
				})
			end
		end

		if msg.remove then
			RedDotModel.instance:removeRedDotDetail(msg.remove.type, msg.remove.detail)

			local detailStrs = RedDotModel.instance:splitDetailStr(msg.remove.detail)

			if #detailStrs > 0 then
				for k1, str in pairs(detailStrs) do
					if str ~= defaultStr then
						GlobalDispatcher:dispatchEvent(EventType.RED_DOT_UPDATE_EVENT, {
							isActive = false,
							key = msg.remove.type .. "_" .. str,
							parentKey = msg.remove.type
						})
					end
				end
			end

			if self:_isOnlyOneRedPoint(detailStrs) then
				GlobalDispatcher:dispatchEvent(EventType.RED_DOT_UPDATE_EVENT, {
					isActive = false,
					key = msg.remove.type
				})
			end
		end
	end
end

function M:_isOnlyOneRedPoint(detailStrs)
	if not detailStrs or #detailStrs < 1 then
		return true
	end

	if #detailStrs == 1 and (detailStrs[1] == defaultStr or detailStrs[1] == "") then
		return true
	end

	return false
end

M.instance = M.New()

return M
