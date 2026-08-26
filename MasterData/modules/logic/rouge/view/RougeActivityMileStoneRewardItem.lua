-- chunkname: @modules/logic/rouge/view/RougeActivityMileStoneRewardItem.lua

module("modules.logic.rouge.view.RougeActivityMileStoneRewardItem", package.seeall)

local RougeActivityMileStoneRewardItem = class("RougeActivityMileStoneRewardItem", LuaCompBase)

function RougeActivityMileStoneRewardItem:init(go)
	self.go = go
	self._goIcon = gohelper.findChild(go, "go_icon")
	self._goCanget = gohelper.findChild(go, "go_canget")
	self._goReceive = gohelper.findChild(go, "go_receive")
	self._goHasGet = gohelper.findChild(go, "go_receive/go_hasget")
	self._animatorPlayer = ZProj.ProjAnimatorPlayer.Get(self._goHasGet)
	self._comItem = IconMgr.instance:getCommonPropItemIcon(self._goIcon)
end

function RougeActivityMileStoneRewardItem:addEventListeners()
	return
end

function RougeActivityMileStoneRewardItem:removeEventListeners()
	return
end

function RougeActivityMileStoneRewardItem:onClickItemIcon()
	if not ActivityModel.instance:isActOnLine(self._actId) then
		GameFacade.showToast(ToastEnum.BattlePass)

		return
	end

	if self._status == Activity186Enum.RewardStatus.Canget then
		gohelper.setActive(self._goCanget, false)
		gohelper.setActive(self._goReceive, true)
		GameUtil.setActiveUIBlock("RougeActivityMileStoneRewardItem", true, false)
		self._animatorPlayer:Play("go_hasget_in", self._onPlayGetRewardAnimDone, self)

		return
	end

	MaterialTipController.instance:showMaterialInfo(self._itemCo[1], self._itemCo[2])
end

function RougeActivityMileStoneRewardItem:_onPlayGetRewardAnimDone()
	GameUtil.setActiveUIBlock("RougeActivityMileStoneRewardItem", false, true)
	Activity186Rpc.instance:sendGetAct186MilestoneRewardRequest(self._actId)
end

function RougeActivityMileStoneRewardItem:onUpdateMO(actId, status, itemCo)
	self._actId = actId
	self._status = status
	self._itemCo = itemCo

	self._comItem:setMOValue(self._itemCo[1], self._itemCo[2], self._itemCo[3])
	self._comItem:customOnClickCallback(self.onClickItemIcon, self)
	self._comItem:isShowQuality(true)
	self._comItem:setCountFontSize(53)
	gohelper.setActive(self._goCanget, status == Activity186Enum.RewardStatus.Canget)
	gohelper.setActive(self._goReceive, status == Activity186Enum.RewardStatus.Hasget)
end

function RougeActivityMileStoneRewardItem:onDestroy()
	self._comItem = nil

	GameUtil.setActiveUIBlock("RougeActivityMileStoneRewardItem", false, true)
end

return RougeActivityMileStoneRewardItem
