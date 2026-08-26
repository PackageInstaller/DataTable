-- chunkname: @modules/logic/autochess/main/view/AutoChessRankUpView.lua

module("modules.logic.autochess.main.view.AutoChessRankUpView", package.seeall)

local AutoChessRankUpView = class("AutoChessRankUpView", BaseView)

function AutoChessRankUpView:onInitView()
	self._goBadgeRoot = gohelper.findChild(self.viewGO, "#go_BadgeRoot")
	self._goReward = gohelper.findChild(self.viewGO, "root/#go_Reward")
	self._goRewardItem = gohelper.findChild(self.viewGO, "root/#go_Reward/reward/#go_RewardItem")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function AutoChessRankUpView:onClickModalMask()
	self:closeThis()
end

function AutoChessRankUpView:onOpen()
	AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_Rewards)

	self.actMo = Activity182Model.instance:getActMo()

	local badgeGo = self:getResInst(AutoChessStrEnum.ResPath.BadgeItem, self._goBadgeRoot)
	local badgeItem = MonoHelper.addNoUpdateLuaComOnceToGo(badgeGo, AutoChessBadgeItem)

	badgeItem:setData(self.actMo.rank, self.actMo.score, AutoChessBadgeItem.ShowType.RankUpView)

	if self.actMo.newRankUp then
		local rankCo = lua_auto_chess_rank.configDict[self.actMo.activityId][self.actMo.rank]

		if rankCo then
			local list = DungeonConfig.instance:getRewardItems(rankCo.reward)

			for k, v in ipairs(list) do
				local go = gohelper.cloneInPlace(self._goRewardItem, k)
				local cell_component = IconMgr.instance:getCommonItemIcon(go)

				gohelper.setAsFirstSibling(cell_component.go)
				cell_component:setMOValue(v[1], v[2], v[3], nil, true)
				cell_component:setCountFontSize(32)
			end

			gohelper.setActive(self.goReward, #list ~= 0)
		end
	else
		gohelper.setActive(self.goReward, false)
	end

	gohelper.setActive(self._goRewardItem, false)
end

function AutoChessRankUpView:onClose()
	self.actMo:clearRankUpMark()
	AutoChessController.instance:popupRewardView()
end

function AutoChessRankUpView:onDestroyView()
	return
end

return AutoChessRankUpView
