-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/rank/view/collection_rank/CollectionRankCell.lua

module("logic.extensions.rank.view.collection_rank.CollectionRankCell", package.seeall)

local M = class("CollectionRankCell", ListBinderCell)

function M:Awake()
	self._text_percent = goutil.findChildTextComponent(self._go, "stateSJL/txtCollect")
	self._go_user = goutil.findChild(self._go, "player_ranking_common_item")
	self._rankUserCell = Astral.LuaComponentContainer.Add(self._go_user, RankUserCell)
end

function M:updateData(data)
	if not data then
		return
	end

	self._rankUserCell:updateData(data)

	self._text_percent.text = string.format("%s%%", data:getRatio())
end

return M
