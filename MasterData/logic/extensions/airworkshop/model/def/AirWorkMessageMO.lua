-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/airworkshop/model/def/AirWorkMessageMO.lua

module("logic.extensions.airworkshop.model.def.AirWorkMessageMO", package.seeall)

local M = class("AirWorkMessageMO")

function M:ctor()
	self._messageTxtList = {}
	self._params = 0
end

function M:createByAgent(no)
	if not no.time or no.time <= 0 then
		return false
	end

	local mo = AirWorkMessageMO.New()

	mo:setTime(no.time)
	mo:setParams(no.params)

	local leaveMsgMO = LeaveMsgMO.New(no.msg)

	mo:setLeaveMsgMO(leaveMsgMO)

	return mo
end

function M:setTime(time)
	self._condition = time
end

function M:setParams(params)
	self._params = params or 0
end

function M:setLeaveMsgMO(mo)
	self._leaveMsgMO = mo
end

function M:getLeaveMsgMO()
	return self._leaveMsgMO
end

function M:getCondition()
	return self._condition
end

function M:getParams()
	return self._params
end

function M:getMsgTitle()
	if self._leaveMsgMO then
		local title, content = self._leaveMsgMO:getPreviewMsg(true)

		return title
	end
end

function M:getMsgContent()
	if self._leaveMsgMO then
		local title, content = self._leaveMsgMO:getPreviewMsg(true)

		return content
	end
end

function M:getMsgStr()
	if self._leaveMsgMO then
		return self._leaveMsgMO:getPreviewMsg()
	end
end

function M:hasVoice()
	if self._leaveMsgMO then
		return self._leaveMsgMO:hasVoice()
	end
end

function M:playVoice()
	if self._leaveMsgMO then
		return self._leaveMsgMO:playVoice()
	end
end

function M:getEmoji()
	if self._leaveMsgMO then
		return self._leaveMsgMO:getEmoji()
	end
end

function M:isSame(msgMO)
	if not msgMO then
		return
	end

	if self._condition ~= msgMO:getCondition() then
		return false
	end

	if self._params ~= msgMO:getParams() then
		return false
	end

	local leaveMsgMo = msgMO:getLeaveMsgMO()

	if self._leaveMsgMO and leaveMsgMo then
		if not self._leaveMsgMO:isSame(leaveMsgMo) then
			return false
		end
	elseif not self._leaveMsgMO and not leaveMsgMo then
		-- block empty
	else
		return false
	end

	return true
end

function M:trans2AgentForm(msg)
	msg.time = self._condition

	if self._params and self._params ~= 0 then
		msg.params = self._params
	end

	self._leaveMsgMO:trans2MessageCompositeNO(msg.msg)
end

return M
