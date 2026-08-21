-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/friend/view/blacklist/BlacklistItemCell.lua

module("logic.extensions.friend.view.blacklist.BlacklistItemCell", package.seeall)

local M = class("BlacklistItemCell", FriendBaseItemCell)

function M:updateData(data)
	M.super.updateData(self, data)
end

function M:_buildUI()
	M.super._buildUI(self)
	self._btnRemove.gameObject:SetActive(true)
end

function M:_onClickBtnRemove()
	local function confirmCallback()
		FriendAgent.instance:sendUnBlockUserRequest(self._data:getUserId())
	end

	local name = self._data:getNickName()
	local content = string.format(lang("tip_remove_back_list"), name)
	local dialog = Dialog.showMessage(lang("tip_title"), content)

	dialog:setConfirmListener(confirmCallback, self)
end

return M
