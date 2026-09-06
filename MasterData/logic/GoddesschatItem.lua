-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/goddess/view/GoddesschatItem.lua

module("logic.extensions.goddess.view.GoddesschatItem", package.seeall)

local GoddesschatItem = class("GoddesschatItem", BaseLuaOnce)

function GoddesschatItem:buildUI()
	self._contentText = self:getText("ImgC_ContentBg/TxtC_Content")
	self._headIcon = self:getGo("Nego_Icon/ImgC_Icon")
end

function GoddesschatItem:OnDestroy()
	self:onExit()
end

function GoddesschatItem:onEnter(data)
	self._contentText.text = data.cfg.text

	if not string.nilorempty(data.headName) or data.isMe then
		if data.isMe then
			local headId = RoleModel.instance:getHeadIconId()
			local proxy = HeadItemController.instance:setHeadCell(self._headIcon, headId)

			if proxy then
				proxy.binder:setAutoTips(false)
			end
		else
			uGuiUtil.setSpriteToImage(self._headIcon, nil, GameUrl.getCharacterIconUrl(data.headName))
		end
	end
end

function GoddesschatItem:onExit()
	uGuiUtil.clearImage(self._headIcon)
	HeadItemController.instance:resetHeadCell(self._headIcon)
end

return GoddesschatItem
