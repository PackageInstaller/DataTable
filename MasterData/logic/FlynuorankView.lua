-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/flyingnuo/view/FlynuorankView.lua

module("logic.extensions.flyingnuo.view.FlynuorankView", package.seeall)

local FlynuorankView = class("FlynuorankView", RankView)

function FlynuorankView:onEnter()
	GlobalDispatcher:addListener(FlyingNuoAgent.GetRankInfoRes, self._updateRankList, self)
	self:_setTipTxt(GameEnum.RankType.FlyNuo, "提示：每十分钟更新1次，分数到达" .. FlyNuoConfig.instance:getMinRankScore() .. "后才会上榜")
	self:_initTxtTab()
	self:onEnterRefresh()
end

function FlynuorankView:onExit()
	FlynuorankView.super.onExit(self)
	GlobalDispatcher:removeListener(FlyingNuoAgent.GetRankInfoRes, self._updateRankList, self)
end

function FlynuorankView:onEnterRefresh()
	self._initRoot = GameEnum.RankType.FlyNuo
	self._initLeaf = 0

	FlynuorankView.super.onEnterRefresh(self)
end

function FlynuorankView:initTabData()
	self._tableViewDatas = {}

	table.insert(self._tableViewDatas, {
		num = 0,
		reportBehavior = 0,
		id = GameEnum.RankType.FlyNuo
	})
end

function FlynuorankView:getCellName(root, leaf)
	if root == GameEnum.RankType.FlyNuo then
		return "勇闯龙城"
	end

	return "未知"
end

function FlynuorankView:_updateRankList()
	FlynuorankView.super._updateRankList(self)

	self._txtAttribute.text = "历史最高"
	self._txtFamily.text = "家族"
	self._txtName.text = "奥奇名称"
end

function FlynuorankView:_updateRankCell(view, cell)
	local idx = cell.index
	local component = RankItem.AddOnce(cell.gameObject)

	component:onSetMo(self._rankViewDatas[idx + 1], nil, GameEnum.RankType.FlyNuo)

	return cell
end

return FlynuorankView
