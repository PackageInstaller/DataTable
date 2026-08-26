-- chunkname: @modules/logic/sp02/paomian/marcus/view/Sp02_MarcusRewardItem.lua

module("modules.logic.sp02.paomian.marcus.view.Sp02_MarcusRewardItem", package.seeall)

local Sp02_MarcusRewardItem = class("Sp02_MarcusRewardItem", LuaCompBase)

function Sp02_MarcusRewardItem:init(go)
	self.go = go
	self._goIcon = gohelper.findChild(self.go, "go_Icon")
	self._goHasGet = gohelper.findChild(self.go, "go_HasGet")
	self._goCanGet = gohelper.findChild(self.go, "go_CanGet")
	self._iconItem = IconMgr.instance:getCommonPropItemIcon(self._goIcon)
end

function Sp02_MarcusRewardItem:addEventListeners()
	return
end

function Sp02_MarcusRewardItem:removeEventListeners()
	return
end

function Sp02_MarcusRewardItem:onUpdateMO(index, rewardCo, dayCo)
	self._index = index
	self._rewardCo = rewardCo
	self._dayCo = dayCo
	self._status = Sp02_MarcusModel.instance:getStatus(self._dayCo.activityId, self._dayCo.id)

	self:refreshUI()
end

function Sp02_MarcusRewardItem:refreshUI()
	self._iconItem:setMOValue(self._rewardCo[1], self._rewardCo[2], self._rewardCo[3], nil, true)
	self._iconItem:setCountFontSize(46)

	local isPlayed = Sp02_PaoMianController.instance:isPlayedMarcusDesc(self._dayCo.activityId, self._dayCo.id)
	local canGet = isPlayed and self._status == Sp02_MarcusEnum.BonusStatus.CanGet

	gohelper.setActive(self._goCanGet, canGet)
	gohelper.setActive(self._goHasGet, self._status == Sp02_MarcusEnum.BonusStatus.Finish)
end

function Sp02_MarcusRewardItem:onDestroy()
	self._iconItem = nil
end

return Sp02_MarcusRewardItem
