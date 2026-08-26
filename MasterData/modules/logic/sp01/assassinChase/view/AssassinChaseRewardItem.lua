-- chunkname: @modules/logic/sp01/assassinChase/view/AssassinChaseRewardItem.lua

module("modules.logic.sp01.assassinChase.view.AssassinChaseRewardItem", package.seeall)

local AssassinChaseRewardItem = class("AssassinChaseRewardItem", LuaCompBase)

function AssassinChaseRewardItem:init(go)
	self.viewGO = go
	self._gorewardPos = gohelper.findChild(self.viewGO, "go_rewardPos")
	self._gorewardGet = gohelper.findChild(self.viewGO, "go_rewardGet")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function AssassinChaseRewardItem:_editableInitView()
	self._rewardItem = IconMgr.instance:getCommonItemIcon(self._gorewardPos)
end

function AssassinChaseRewardItem:setData(rewardParam)
	local itemData = string.splitToNumber(rewardParam, "#")
	local item = self._rewardItem

	item:setMOValue(itemData[1], itemData[2], itemData[3])
	item:isShowCount(true)
	item:setInPack(false)
end

function AssassinChaseRewardItem:setGetState(isGet)
	gohelper.setActive(self._gorewardGet, isGet)
end

function AssassinChaseRewardItem:setActive(active)
	gohelper.setActive(self.viewGO, active)
end

function AssassinChaseRewardItem:onDestroy()
	return
end

return AssassinChaseRewardItem
