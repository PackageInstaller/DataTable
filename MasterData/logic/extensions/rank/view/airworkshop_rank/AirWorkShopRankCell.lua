-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/rank/view/airworkshop_rank/AirWorkShopRankCell.lua

module("logic.extensions.rank.view.airworkshop_rank.AirWorkShopRankCell", package.seeall)

local M = class("AirWorkShopRankCell", ListBinderCell)

function M:Awake()
	self._img_level = goutil.findChildImageComponent(self._go, "stateKQGF/imgLevel")
	self._img_quality = goutil.findChildImageComponent(self._go, "stateKQGF/imgLevel/imgQuality")
	self._img_level2 = goutil.findChildImageComponent(self._go, "stateKQGF/imgLevel/imgLevel2")
	self._text_score = goutil.findChildTextComponent(self._go, "stateKQGF/txtNum")
	self._go_user = goutil.findChild(self._go, "player_ranking_common_item")
	self._rankUserCell = Astral.LuaComponentContainer.Add(self._go_user, RankUserCell)
end

function M:updateData(data)
	if not data then
		return
	end

	self._rankUserCell:updateData(data)
	AirWorkShopUtil.rodeoLvImgChange(data:getDan(), self._img_level, self._img_level2, nil, self._img_quality)

	self._text_score.text = data:getScore()
end

return M
