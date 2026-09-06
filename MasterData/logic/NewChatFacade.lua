-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/chat/facade/NewChatFacade.lua

module("logic.extensions.chat.facade.NewChatFacade", package.seeall)

local NewChatFacade = class("NewChatFacade")

function NewChatFacade:ctor()
	return
end

function NewChatFacade:LoadOfflineMsg()
	ChatAgent.instance:sendGetChatSettingsAndOfflineMsgsReq()
end

local colorfulColor = {
	"#ffa8b2",
	"#ffcf9a",
	"#fffcbe",
	"#c8ffde",
	"#bdeaff",
	"#dfc1ff"
}
local colorLen = #colorfulColor

function NewChatFacade.changeColorContent(content, startIdx)
	if not string.nilorempty(content) then
		if NewChatFacade.hasUnityColorTag(content) == true then
			return content
		end

		local colorfulText = ""
		local i = 1 + checknumber(startIdx)
		local index = 1
		local len = string.len(content)

		while index <= len do
			local char = string.byte(content, index)
			local size = StringUtil.utf8CharSize(char)

			if size > 0 then
				local value = string.sub(content, index, index + size - 1)

				index = index + size

				local idx = (i - 1) % colorLen + 1

				colorfulText = colorfulText .. string.format("<color=%s>%s</color>", colorfulColor[idx], value)
				i = i + 1
			else
				index = index + 1
			end
		end

		return colorfulText
	end

	return ""
end

function NewChatFacade.hasUnityColorTag(str)
	if type(str) ~= "string" then
		return false
	end

	local pattern = "/>"
	local patternClose = "</"

	return string.find(str, pattern) ~= nil or string.find(str, patternClose) ~= nil
end

local FitMode = UnityEngine.UI.ContentSizeFitter.FitMode

function NewChatFacade:setChatText(text, content, maxWidth, contentSizeFitter, rectTransForm, horizontalOffset)
	local textWidth = Game.TextUtil.CalcuTextWidth(text, content)

	if textWidth <= maxWidth then
		contentSizeFitter.horizontalFit = FitMode.PreferredSize
	else
		contentSizeFitter.horizontalFit = FitMode.Unconstrained
		rectTransForm.sizeDelta = Vector2.New(maxWidth + horizontalOffset, 0)
	end

	text.text = content
end

function NewChatFacade:getChatTextPreferedHeight(text, content, maxWidth, imgContainer)
	local contentSizeFitter = imgContainer:GetComponent(typeof(UnityEngine.UI.ContentSizeFitter))
	local rectTransForm = imgContainer:GetComponent(typeof(UnityEngine.RectTransform))
	local layoutGroup = imgContainer:GetComponent(typeof(UnityEngine.UI.LayoutGroup))
	local padding = layoutGroup.padding
	local contentSizeImmediate = imgContainer:GetComponent(typeof(Framework.ContentSizeImmediate))

	self:setChatText(text, content, maxWidth, contentSizeFitter, rectTransForm, padding.left + padding.right)

	if contentSizeImmediate then
		local size = contentSizeImmediate:GetPreferredSize()

		return size.y
	end

	return 0
end

NewChatFacade.instance = NewChatFacade.New()

return NewChatFacade
