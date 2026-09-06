-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/emoji/controller/EmojiController.lua

module("logic.extensions.emoji.controller.EmojiController", package.seeall)

local EmojiController = class("EmojiController", BaseController)

function EmojiController:ctor()
	return
end

function EmojiController:OpenView()
	UIStateManager.instance:open(ViewName.Emoji)
end

function EmojiController:GetEmojis()
	return HyperlinkHandler.GetEmojis()
end

function EmojiController:GetEmojiSprites(name)
	local result = TableUtil.Where(HyperlinkHandler.GetEmojis(), function(v)
		return v.nickname == name
	end)

	return (#result > 0 or nil) and (result[1].sprites or "")
end

EmojiController.instance = EmojiController.New()

return EmojiController
