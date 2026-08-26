-- chunkname: @modules/logic/turnback/invitation/view/TurnBackInvitationFriendItem.lua

module("modules.logic.turnback.invitation.view.TurnBackInvitationFriendItem", package.seeall)

local TurnBackInvitationFriendItem = class("TurnBackInvitationFriendItem", LuaCompBase)

function TurnBackInvitationFriendItem:init(go)
	self:__onInit()

	self.go = go
	self._txtName = gohelper.findChildTextMesh(go, "invited/namebg/#txt_name")
	self._goInvited = gohelper.findChild(go, "invited")
	self._goUnInvite = gohelper.findChild(go, "uninvite")
	self._simgHeadIcon = gohelper.findChildSingleImage(go, "invited/#go_playerheadicon")
	self._goframenode = gohelper.findChild(go, "invited/#go_playerheadicon/#go_framenode")
	self._loader = MultiAbLoader.New()
end

function TurnBackInvitationFriendItem:setData(info)
	self._roleInfo = info

	self:_refreshItem()
end

function TurnBackInvitationFriendItem:setEmpty()
	self:setInfoState(false)
end

function TurnBackInvitationFriendItem:setInfoState(invited)
	gohelper.setActive(self._goInvited, invited)
	gohelper.setActive(self._goUnInvite, not invited)
end

function TurnBackInvitationFriendItem:_refreshItem()
	local roleInfo = self._roleInfo

	if roleInfo == nil then
		logError("Player Info is nil")
		self:setEmpty()

		return
	end

	self:setInfoState(true)

	self._txtName.text = roleInfo.name

	local config = lua_item.configDict[roleInfo.portrait]

	self._liveHeadIcon = self._liveHeadIcon or IconMgr.instance:getCommonLiveHeadIcon(self._simgHeadIcon)

	self._liveHeadIcon:setLiveHead(config.id)

	local effectArr = string.split(config.effect, "#")

	if #effectArr > 1 then
		if config.id == tonumber(effectArr[#effectArr]) then
			gohelper.setActive(self._goframenode, true)

			if not self.frame then
				local framePath = "ui/viewres/common/effect/frame.prefab"

				self._loader:addPath(framePath)
				self._loader:startLoad(self._onLoadCallback, self)
			end
		end
	else
		gohelper.setActive(self._goframenode, false)
	end
end

function TurnBackInvitationFriendItem:_onLoadCallback()
	local framePrefab = self._loader:getFirstAssetItem():GetResource()

	gohelper.clone(framePrefab, self._goframenode, "frame")

	self.frame = gohelper.findChild(self._goframenode, "frame")

	local img = self.frame:GetComponent(gohelper.Type_Image)

	img.enabled = false

	local iconwidth = recthelper.getWidth(self._simgHeadIcon.transform)
	local framenodewidth = recthelper.getWidth(self.frame.transform)
	local scale = 1.41 * (iconwidth / framenodewidth)

	transformhelper.setLocalScale(self.frame.transform, scale, scale, 1)
end

function TurnBackInvitationFriendItem:addEventListeners()
	return
end

function TurnBackInvitationFriendItem:removeEventListeners()
	return
end

function TurnBackInvitationFriendItem:destroy()
	self:__onDispose()
	self._simgHeadIcon:UnLoadImage()

	self._roleInfo = nil
end

return TurnBackInvitationFriendItem
