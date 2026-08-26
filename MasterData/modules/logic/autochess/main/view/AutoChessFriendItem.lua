-- chunkname: @modules/logic/autochess/main/view/AutoChessFriendItem.lua

module("modules.logic.autochess.main.view.AutoChessFriendItem", package.seeall)

local AutoChessFriendItem = class("AutoChessFriendItem", ListScrollCellExtend)

function AutoChessFriendItem:onInitView()
	self._textPlayerName = gohelper.findChildText(self.viewGO, "#txt_Name")
	self._playerHeadicon = gohelper.findChildSingleImage(self.viewGO, "HeroHeadIcon/#simage_headicon")
	self._playerBadge = gohelper.findChildText(self.viewGO, "Badge/#txt_badge")
	self._btnSelectFriend = gohelper.findChildButtonWithAudio(self.viewGO, "#btnClick")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function AutoChessFriendItem:addEvents()
	self._btnSelectFriend:AddClickListener(self.onClickSelectFriend, self)
end

function AutoChessFriendItem:removeEvents()
	self._btnSelectFriend:RemoveClickListener()
end

function AutoChessFriendItem:_editableInitView()
	return
end

function AutoChessFriendItem:onClickSelectFriend()
	AutoChessController.instance:dispatchEvent(AutoChessEvent.SelectFriendSnapshot, self._userId)
end

function AutoChessFriendItem:onUpdateData(friendData)
	self._textPlayerName.text = friendData.name

	local playerIconId = friendData.portrait
	local playerRank = friendData.rank

	self._userId = friendData.userId
	self._playerLiveHeadIcon = self._playerLiveHeadIcon or IconMgr.instance:getCommonLiveHeadIcon(self._playerHeadicon)

	self._playerLiveHeadIcon:setLiveHead(playerIconId)

	local actId = Activity182Model.instance:getCurActId()

	self._playerRankCfg = lua_auto_chess_rank.configDict[actId][playerRank]

	if not self._playerRankCfg then
		self._playerBadge.text = luaLang("autochess_badgeitem_noget")
	end

	self._playerBadge.text = self._playerRankCfg.name
end

function AutoChessFriendItem:onDestroyView()
	return
end

return AutoChessFriendItem
