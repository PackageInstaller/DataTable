-- chunkname: @modules/logic/fight/view/FightBottomLeftView.lua

module("modules.logic.fight.view.FightBottomLeftView", package.seeall)

local FightBottomLeftView = class("FightBottomLeftView", FightBaseView)

function FightBottomLeftView:onInitView()
	self.goRoot = gohelper.findChild(self.viewGO, "root/heroSkill")
end

function FightBottomLeftView:addEvents()
	return
end

function FightBottomLeftView:removeEvents()
	return
end

function FightBottomLeftView:onOpen()
	self:showShouTaoPart()
end

function FightBottomLeftView:showShouTaoPart()
	local shouTaoData = FightDataHelper.fieldMgr.customData[FightCustomData.CustomDataType.ShowTaoFuBen]

	if shouTaoData then
		local url = "ui/viewres/fight/fight_gloves_skillview.prefab"

		self:com_openSubView(FightGlovesSkillViewMgr, url, self.goRoot)
	end
end

function FightBottomLeftView:onClose()
	return
end

function FightBottomLeftView:onDestroyView()
	return
end

return FightBottomLeftView
