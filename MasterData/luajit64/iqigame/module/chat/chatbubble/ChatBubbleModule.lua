-- chunkname: @IQIGame\\Module\\Chat\\ChatBubble\\ChatBubbleModule.lua

local m = {
	_defaultBubble = 0
}
local ChatBubbleData = require("IQIGame.Module.Chat.ChatBubble.ChatBubbleData")

function m.Reload()
	m.AddListeners()
end

function m.AddListeners()
	return
end

function m.RemoveListeners()
	return
end

function m.GetCurrentUseChatBubble()
	if PlayerModule.PlayerInfo.baseInfo.chatBackground > 0 then
		return PlayerModule.PlayerInfo.baseInfo.chatBackground
	end

	return m.GetDefaultChatBubble()
end

function m.GetDefaultChatBubble()
	if m._defaultBubble == 0 then
		for i, v in pairsCfg(CfgChatBubbleTable) do
			if v.Default then
				m._defaultBubble = v.Id

				break
			end
		end
	end

	return m._defaultBubble
end

function m.GetChatBubbles()
	local tab = {}

	for i, v in pairsCfg(CfgChatBubbleTable) do
		if not v.IsHide then
			local unlock = not v.IsLock

			if not unlock and PlayerModule.PlayerInfo.unlockChatBackgrounds then
				unlock = table.indexOf(PlayerModule.PlayerInfo.unlockChatBackgrounds, v.Id) ~= -1
			end

			local data = ChatBubbleData.New(v.Id, unlock)

			table.insert(tab, data)
		end
	end

	table.sort(tab, function(a, b)
		local lockA = a.unlock and 1 or 0
		local lockB = b.unlock and 1 or 0

		if lockA == lockB then
			return a:GetConfigData().Sort < b:GetConfigData().Sort
		end

		return lockB < lockA
	end)

	return tab
end

function m.Shutdown()
	m.RemoveListeners()
end

ChatBubbleModule = m
