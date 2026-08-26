-- chunkname: @modules/logic/partygame/view/common/PlayerInfoComp.lua

module("modules.logic.partygame.view.common.PlayerInfoComp", package.seeall)

local PlayerInfoComp = class("PlayerInfoComp", ListScrollCellExtend)

function PlayerInfoComp:onInitView()
	self._goPlayers = gohelper.findChild(self.viewGO, "#go_Players")
	self._gorankitem = gohelper.findChild(self.viewGO, "#go_Players/#go_rankitem")
	self._gonormal = gohelper.findChild(self.viewGO, "#go_Players/#go_rankitem/#go_normal")
	self._txtnum = gohelper.findChildText(self.viewGO, "#go_Players/#go_rankitem/#go_normal/#lvbg/#txt_num")
	self._txtname = gohelper.findChildText(self.viewGO, "#go_Players/#go_rankitem/#go_normal/#txt_name")
	self._txtscore = gohelper.findChildText(self.viewGO, "#go_Players/#go_rankitem/#go_normal/#txt_score")
	self._goself = gohelper.findChild(self.viewGO, "#go_Players/#go_rankitem/#go_self")
	self._txtselfnum = gohelper.findChildText(self.viewGO, "#go_Players/#go_rankitem/#go_self/#lvbg/#txt_self_num")
	self._txtselfname = gohelper.findChildText(self.viewGO, "#go_Players/#go_rankitem/#go_self/#txt_self_name")
	self._txtselfscore = gohelper.findChildText(self.viewGO, "#go_Players/#go_rankitem/#go_self/#txt_self_score")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function PlayerInfoComp:addEvents()
	return
end

function PlayerInfoComp:removeEvents()
	return
end

function PlayerInfoComp:Init()
	self._allPlayerItem = self:getUserDataTb_()
	self._curPlayerList = PartyGameModel.instance:getCurGamePlayerList()

	gohelper.CreateObjList(self, self._onPlayerComp, self._curPlayerList, self._goPlayers, self._gorankitem, self:getItemCls())
end

function PlayerInfoComp:getItemCls()
	return PlayerInfoItem
end

function PlayerInfoComp:_onPlayerComp(obj, data, index)
	obj:Init(data)
	obj:ShowMainPlayer()
	table.insert(self._allPlayerItem, obj)
end

function PlayerInfoComp:viewDataUpdate()
	if self._allPlayerItem == nil then
		return
	end

	for _, v in ipairs(self._allPlayerItem) do
		v:onUpdateMO()
	end

	table.sort(self._allPlayerItem, PlayerInfoItem.sort)

	for k, v in ipairs(self._allPlayerItem) do
		v:updateIndex(k)
	end
end

function PlayerInfoComp:refreshData(data)
	return
end

function PlayerInfoComp:onDestroyView()
	self._curPlayerList = nil
end

function PlayerInfoComp:getPlayerItems()
	return self._allPlayerItem
end

return PlayerInfoComp
