-- chunkname: @modules/logic/versionactivity4_0/concertlimit/view/actflip/ActFlipRewardItem.lua

module("modules.logic.versionactivity4_0.concertlimit.view.actflip.ActFlipRewardItem", package.seeall)

local ActFlipRewardItem = class("ActFlipRewardItem", LuaCompBase)

function ActFlipRewardItem:init(go)
	self.go = go
	self._goitem = gohelper.findChild(self.go, "go_item")
	self._goget = gohelper.findChild(self.go, "go_get")
	self._gobigreward = gohelper.findChild(self.go, "#go_bigreward")
end

function ActFlipRewardItem:refresh(rewardId)
	self._rewardId = rewardId

	gohelper.setActive(self.go, true)

	local isBig = ActFlipModel.instance:isBigReward(rewardId)

	gohelper.setActive(self._gobigreward, isBig)

	local rewardCo = ActFlipConfig.instance:getRewardCo(rewardId)

	gohelper.setActive(self._goitem, true)

	local itemCos = string.splitToNumber(rewardCo.reward, "#")

	self._item = self._item or IconMgr.instance:getCommonItemIcon(self._goitem)

	self._item:setMOValue(itemCos[1], itemCos[2], itemCos[3])
	self._item:isShowQuality(true)
end

function ActFlipRewardItem:showGet(show)
	gohelper.setActive(self._goget, show)
end

function ActFlipRewardItem:showItem(show)
	gohelper.setActive(self.go, show)
end

function ActFlipRewardItem:destroy()
	return
end

return ActFlipRewardItem
