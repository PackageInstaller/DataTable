-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/friend/view/search/SearchItemCell.lua

module("logic.extensions.friend.view.search.SearchItemCell", package.seeall)

local M = class("SearchItemCell", FriendBaseItemCell)
local RelationTypeEnum = GameEnum.RelationTypeEnum

function M:ctor(...)
	M.super.ctor(self, ...)

	self._tipsPosGo = nil
end

function M:updateData(data)
	M.super.updateData(self, data)

	local relationType = self._data:getRelationShip()

	self._btnAgree.gameObject:SetActive(relationType == RelationTypeEnum.BeApply)
	self._btnRefuse.gameObject:SetActive(relationType == RelationTypeEnum.BeApply)

	local isFriend = FriendModel.instance:isInRelationType(RelationTypeEnum.Friend, data:getUserId())

	self._addedSignGo:SetActive(isFriend or relationType == RelationTypeEnum.Apply)
	self._btnAddFriends.gameObject:SetActive(not isFriend and relationType == 0)
	self._btnChat.gameObject:SetActive(false)
end

function M:_buildUI()
	M.super._buildUI(self)
	self._requestGo:SetActive(true)
end

function M:setTipsPosGo(go)
	self._tipsPosGo = go
end

function M:_onClickBtnClick()
	local info = ToolTipsUtil.createFriendTipsData({
		friendMo = self._data
	}, self._imgHeadIcon, true)

	ToolTipsMgr.showTips(ViewName.FriendTips, info)
end

function M:_onClickBtnAgree()
	local cur = FriendModel.instance:getUserCountByType(RelationTypeEnum.Friend)
	local max = ConstConfig.instance:getNumValueByKey("MaxFriendNum")

	if max <= cur then
		FloatWordMgr.instance:show("您的好友已满，无法添加")

		return
	end

	local userIdList = {
		self._data:getUserId()
	}

	FriendAgent.instance:sendAgreeApplyRequest(userIdList)
end

function M:_onClickBtnRefuse()
	local userIdList = {
		self._data:getUserId()
	}

	FriendAgent.instance:sendRefuseApplyRequest(userIdList)
end

function M:_onClickBtnAddFriends()
	local cur = FriendModel.instance:getUserCountByType(RelationTypeEnum.Friend)
	local max = ConstConfig.instance:getNumValueByKey("MaxFriendNum")

	if max <= cur then
		FloatWordMgr.instance:show("您的好友已满，无法添加")

		return
	end

	local userId = self._data:getUserId()

	FriendAgent.instance:sendApplyFriendRequest(userId)
end

return M
