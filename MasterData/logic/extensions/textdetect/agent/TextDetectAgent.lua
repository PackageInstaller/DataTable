-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/textdetect/agent/TextDetectAgent.lua

module("logic.extensions.textdetect.agent.TextDetectAgent", package.seeall)

local M = class("TextDetectAgent", BaseAgent)

function M:ctor()
	M.super.ctor(self)
end

function M:sendDetectTextRequest(text, textType)
	local msg = TextDetectExtension_pb.DetectTextRequest()

	msg.text = text
	msg.textType = textType

	self:sendMsg(msg)
end

function M:handleDetectTextReply(status, msg)
	if status == 0 then
		local illegal = msg.result
		local filteredText = msg.filteredText
		local textType = msg.textType

		GlobalDispatcher:dispatchEvent(EventType.SENSITIVE_WORDS_SCREEN, illegal, filteredText, textType)
	end
end

function M:sendCheckDescriptionRequest(type, id, hash, desc)
	local req = TextDetectExtension_pb.CheckDescriptionRequest()
	local descriptionNO = TextDetectExtension_pb.DescriptionNO()

	descriptionNO.type = type
	descriptionNO.id = id

	if hash then
		descriptionNO.descriptionHash = hash
	end

	if desc then
		descriptionNO.description = desc
	end

	table.insert(req.description, descriptionNO)
	self:sendMsg(req)
end

function M:handleCheckDescriptionReply(status, msg)
	if status == 0 then
		local id = string.gmatch(tostring(msg), "type: (%d+)")()
		local text = string.gmatch(tostring(msg), "description: (.+)\n}")()

		GlobalDispatcher:dispatchEvent(EventType.GET_GUIDE_TEXT, text, tonumber(id))
	end
end

M.instance = M.New()

return M
