-- chunkname: @modules/logic/versionactivity1_4/act129/view/Activity129RewardItem.lua

module("modules.logic.versionactivity1_4.act129.view.Activity129RewardItem", package.seeall)

local Activity129RewardItem = class("Activity129RewardItem", LuaCompBase)

function Activity129RewardItem:init(go)
	self.go = go
	self.goItem = gohelper.findChild(go, "#go_Item")
	self.txtNum = gohelper.findChildTextMesh(go, "Num/#txt_ItemNum")
	self.goGet = gohelper.findChild(go, "#go_Get")
	self.goLimit = gohelper.findChild(go, "#go_limit")
end

function Activity129RewardItem:setData(data, actId, poolId, rare)
	self.hideMark = false

	gohelper.setActive(self.go, true)
	gohelper.setAsLastSibling(self.go)

	self.itemIcon = self.itemIcon or IconMgr.instance:getCommonPropItemIcon(self.goItem)

	self.itemIcon:setMOValue(data[1], data[2], data[3], nil, true)
	self.itemIcon:isShowEffect(true)
	self.itemIcon:setCountTxtSize(34)

	local config = ItemModel.instance:getItemConfig(data[1], data[2])
	local tags = string.splitToNumber(config.tag or "")

	gohelper.setActive(self.goLimit, tabletool.indexOf(tags, 1) ~= nil)

	if not data[4] then
		local maxTimes = 0

		if maxTimes > 0 then
			local actMo = Activity129Model.instance:getActivityMo(actId)
			local poolMo = actMo:getPoolMo(poolId)
			local getTimes = poolMo and poolMo:getGoodsGetNum(rare, data[1], data[2]) or 0
			local remainTimes = maxTimes - getTimes

			self.txtNum.text = string.format("%s/%s", remainTimes, maxTimes)

			gohelper.setActive(self.goGet, remainTimes <= 0)
		else
			self.txtNum.text = "<size=40>∞</size>"

			gohelper.setActive(self.goGet, false)
		end
	end
end

function Activity129RewardItem:setHideMark()
	self.hideMark = true
end

function Activity129RewardItem:checkHide()
	if self.hideMark then
		gohelper.setActive(self.go, false)
	end
end

function Activity129RewardItem:onDestroy()
	return
end

return Activity129RewardItem
