-- chunkname: @modules/logic/sp02/paomian/guessme/view/Sp02_GuessMeRewardItem.lua

module("modules.logic.sp02.paomian.guessme.view.Sp02_GuessMeRewardItem", package.seeall)

local Sp02_GuessMeRewardItem = class("Sp02_GuessMeRewardItem", LuaCompBase)

function Sp02_GuessMeRewardItem:init(go)
	self.go = go
	self._goIcon = gohelper.findChild(self.go, "go_Icon")
	self._goCanGet = gohelper.findChild(self.go, "go_CanGet")
	self._goHasGet = gohelper.findChild(self.go, "go_HasGet")
	self._iconItem = IconMgr.instance:getCommonPropItemIcon(self._goIcon)
end

function Sp02_GuessMeRewardItem:addEventListeners()
	return
end

function Sp02_GuessMeRewardItem:removeEventListeners()
	return
end

function Sp02_GuessMeRewardItem:onUpdateMO(index, rewardCo, taskCo, signMo)
	self._index = index
	self._rewardCo = rewardCo
	self._taskCo = taskCo
	self._activityId = taskCo and taskCo.activityId
	self._id = taskCo and taskCo.id
	self._signMo = signMo
	self._status = self._signMo and self._signMo:getStatus() or Sp02_GuessMeEnum.TaskStatus.Lock

	self:refreshUI()
end

function Sp02_GuessMeRewardItem:refreshUI()
	self._iconItem:setMOValue(self._rewardCo[1], self._rewardCo[2], self._rewardCo[3], nil, true)
	self._iconItem:setCountFontSize(46)
	gohelper.setActive(self._goCanGet, self._status == Sp02_GuessMeEnum.TaskStatus.CanGet)
	gohelper.setActive(self._goHasGet, self._status == Sp02_GuessMeEnum.TaskStatus.Finish)
end

function Sp02_GuessMeRewardItem:onDestroy()
	self._iconItem = nil
end

return Sp02_GuessMeRewardItem
