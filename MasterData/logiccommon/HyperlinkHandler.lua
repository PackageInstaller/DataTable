-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logiccommon/common/util/HyperlinkHandler.lua

module("logiccommon.common.util.HyperlinkHandler", package.seeall)

local HyperlinkHandler = {}
local EmojiMap = {}
local regex = "%[(%a*):(%w*)]"
local ChatInputText = {
	[GameEnum.RichText.Emoji] = "[f:%s]"
}

function HyperlinkHandler.GetEmojis()
	return EmojiMap
end

function HyperlinkHandler.ChangeRichText(text)
	return (string.gsub(text, regex, function(type, id)
		if type == "f" then
			id = tonumber(id)

			if EmojiMap[id] then
				return string.format("<quad name=%s size=30 width=1 des=%s />", EmojiMap[id], id)
			end
		end

		return string.format("[%s:%s]", type, id or "")
	end))
end

function HyperlinkHandler.GetInputText(type)
	return ChatInputText[type]
end

function HyperlinkHandler.GetInputTextLen(text)
	local content = string.gsub(text, regex, function(type, id)
		if type == "f" then
			id = tonumber(id)

			if EmojiMap[id] then
				return "aaaaa"
			end
		end

		return string.format("[%s:%s]", type, id or "")
	end)

	return (StringUtil.GetUtf8Length(content))
end

function HyperlinkHandler:ReplaceEmojiText(text)
	return
end

function HyperlinkHandler.init()
	for i = 1, 17 do
		table.insert(EmojiMap, "image_emoticon" .. i)
	end
end

HyperlinkHandler.init()

return HyperlinkHandler
