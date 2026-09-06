-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/goodfeel/view/GoodFeelChatItem.lua

module("logic.extensions.goodfeel.view.GoodFeelChatItem", package.seeall)

local GoodFeelChatItem = class("GoodFeelChatItem", BaseLuaOnce)

function GoodFeelChatItem:buildUI()
	self._contentText = self:getText("ImgC_ContentBg/TxtC_Content")
	self._headIcon = self:getGo("Nego_Icon/ImgC_Icon")
end

function GoodFeelChatItem:OnDestroy()
	self:onExit()
end

function GoodFeelChatItem:onEnter(data)
	self._contentText.text = data.chatTxt

	if not string.nilorempty(data.iconResName) or data.isMe then
		if data.isMe then
			local headId = RoleModel.instance:getHeadIconId()
			local proxy = HeadItemController.instance:setHeadCell(self._headIcon, headId)

			if proxy then
				proxy.binder:setAutoTips(false)
			end
		else
			uGuiUtil.setSpriteToImage(self._headIcon, nil, GameUrl.getCharacterIconUrl(data.iconResName))
		end
	end
end

function GoodFeelChatItem:onExit()
	uGuiUtil.clearImage(self._headIcon)
	HeadItemController.instance:resetHeadCell(self._headIcon)
end

return GoodFeelChatItem
