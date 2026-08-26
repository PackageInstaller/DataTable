-- chunkname: @modules/logic/autochess/main/view/game/AutoChessPveFirstSettleView.lua

module("modules.logic.autochess.main.view.game.AutoChessPveFirstSettleView", package.seeall)

local AutoChessPveFirstSettleView = class("AutoChessPveFirstSettleView", BaseView)

function AutoChessPveFirstSettleView:onInitView()
	self._goSpecialTarget = gohelper.findChild(self.viewGO, "root/#go_SpecialTarget")
	self._txtSpecialTarget = gohelper.findChildText(self.viewGO, "root/#go_SpecialTarget/#txt_SpecialTarget")
	self._goReward = gohelper.findChild(self.viewGO, "root/#go_Reward")
	self._goRewardItem = gohelper.findChild(self.viewGO, "root/#go_Reward/reward/#go_RewardItem")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function AutoChessPveFirstSettleView:addEvents()
	return
end

function AutoChessPveFirstSettleView:removeEvents()
	return
end

function AutoChessPveFirstSettleView:onClickModalMask()
	self:closeThis()
end

function AutoChessPveFirstSettleView:_editableInitView()
	return
end

function AutoChessPveFirstSettleView:onUpdateParam()
	return
end

function AutoChessPveFirstSettleView:onOpen()
	AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_Rewards)

	local curEpisodeId = AutoChessModel.instance.episodeId

	self.config = AutoChessConfig.instance:getEpisodeCO(curEpisodeId)

	local firstBouns = GameUtil.splitString2(self.config.firstBounds, true)

	if firstBouns then
		for _, boun in ipairs(firstBouns) do
			local go = gohelper.cloneInPlace(self._goRewardItem)
			local item = IconMgr.instance:getCommonItemIcon(go)

			gohelper.setAsFirstSibling(item.go)
			item:setMOValue(boun[1], boun[2], boun[3])

			local goBg = item:getCountBg()

			transformhelper.setLocalScale(goBg.transform, 1, 1.7, 1)
			item:setCountFontSize(45)
		end
	else
		gohelper.setActive(self._goReward, false)
	end

	gohelper.setActive(self._goRewardItem, false)
	self:refreshSpecialUnlockTips()
end

function AutoChessPveFirstSettleView:onClose()
	AutoChessController.instance:onSettleViewClose()
	AutoChessController.instance:popupRewardView()
end

function AutoChessPveFirstSettleView:onDestroyView()
	return
end

function AutoChessPveFirstSettleView:refreshSpecialUnlockTips()
	local actId = Activity182Model.instance:getCurActId()
	local pvpEpisodeCo = AutoChessConfig.instance:getPvpEpisodeCo(actId)
	local unlockRefresh = tonumber(lua_auto_chess_const.configDict[AutoChessEnum.ConstKey.UnlockLeaderRefresh].value)
	local unlockSlot = tonumber(lua_auto_chess_const.configDict[AutoChessEnum.ConstKey.UnlockLeaderSlot].value)
	local unlockPVP = pvpEpisodeCo.preEpisode

	if self.config.id == unlockRefresh then
		self._txtSpecialTarget.text = luaLang("autochess_pvesettleview_tips3")
	elseif self.config.id == unlockSlot then
		self._txtSpecialTarget.text = luaLang("autochess_pvesettleview_tips2")
	elseif self.config.id == unlockPVP then
		self._txtSpecialTarget.text = luaLang("autochess_pvesettleview_tips1")
	else
		gohelper.setActive(self._goSpecialTarget, false)
	end
end

return AutoChessPveFirstSettleView
