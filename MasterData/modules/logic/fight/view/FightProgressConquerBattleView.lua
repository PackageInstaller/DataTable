-- chunkname: @modules/logic/fight/view/FightProgressConquerBattleView.lua

module("modules.logic.fight.view.FightProgressConquerBattleView", package.seeall)

local FightProgressConquerBattleView = class("FightProgressConquerBattleView", FightBaseView)

function FightProgressConquerBattleView:onInitView()
	self.player = gohelper.findChild(self.viewGO, "Root/playerHp")
	self.enemy = gohelper.findChild(self.viewGO, "Root/enemyHp")
end

function FightProgressConquerBattleView:addEvents()
	return
end

function FightProgressConquerBattleView:onOpen()
	self.progressDic = FightDataHelper.fieldMgr.progressDic

	for k, data in pairs(self.progressDic) do
		if data.showId == 5 then
			self:com_openSubView(FightNewProgressView5, self.player, nil, data)
		elseif data.showId == 6 then
			self:com_openSubView(FightNewProgressView6, self.enemy, nil, data)
		end
	end
end

return FightProgressConquerBattleView
