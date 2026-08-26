-- chunkname: @modules/logic/rouge2/bossbattle/view/Rouge2_BossBattleRewardStageItem.lua

module("modules.logic.rouge2.bossbattle.view.Rouge2_BossBattleRewardStageItem", package.seeall)

local Rouge2_BossBattleRewardStageItem = class("Rouge2_BossBattleRewardStageItem", LuaCompBase)

function Rouge2_BossBattleRewardStageItem:init(go)
	self.go = go
	self._tran = self.go.transform
	self._goRewardList = gohelper.findChild(self.go, "go_RewardList")
	self._goRewardItem = gohelper.findChild(self.go, "go_RewardList/go_RewardItem")
	self._goCanGet = gohelper.findChild(self.go, "go_CanGet")
	self._goHasGet = gohelper.findChild(self.go, "go_HasGet")
	self._goLock = gohelper.findChild(self.go, "go_Lock")
	self._txtScore1 = gohelper.findChildText(self.go, "go_CanGet/txt_Score")
	self._txtScore2 = gohelper.findChildText(self.go, "go_HasGet/txt_Score")
	self._txtScore3 = gohelper.findChildText(self.go, "go_Lock/txt_Score")
	self._iconItemTab = self:getUserDataTb_()
end

function Rouge2_BossBattleRewardStageItem:addEventListeners()
	return
end

function Rouge2_BossBattleRewardStageItem:removeEventListeners()
	return
end

function Rouge2_BossBattleRewardStageItem:onUpdateMO(battleInfo, bossInfo, rewardCo, posX, index)
	self._battleInfo = battleInfo
	self._bossInfo = bossInfo
	self._rewardCo = rewardCo
	self._posX = posX
	self._index = index
	self._status = self._bossInfo and self._bossInfo:getRewardStatus(self._rewardCo.id) or Rouge2_OutsideEnum.BossRewardStatus.Lock

	self:refreshUI()
end

function Rouge2_BossBattleRewardStageItem:refreshUI()
	if self._rewardCo then
		if not self._rewardCo.score then
			local score = 0

			self._txtScore1.text = score
			self._txtScore2.text = score
			self._txtScore3.text = score

			gohelper.setActive(self._goLock, self._status == Rouge2_OutsideEnum.BossRewardStatus.Lock)
			gohelper.setActive(self._goCanGet, self._status == Rouge2_OutsideEnum.BossRewardStatus.CanGet)
			gohelper.setActive(self._goHasGet, self._status == Rouge2_OutsideEnum.BossRewardStatus.HasGet)
			self:refreshPosition()
			self:refreshRewardList()
		end
	end
end

function Rouge2_BossBattleRewardStageItem:refreshPosition()
	recthelper.setAnchorX(self._tran, self._posX)
end

function Rouge2_BossBattleRewardStageItem:refreshRewardList()
	local itemList = Rouge2_BossBattleConfig.instance:getItemListByRewardId(self._rewardCo.id) or {}

	gohelper.CreateObjList(self, self._refreshRewardItem, itemList, self._goRewardList, self._goRewardItem)
end

function Rouge2_BossBattleRewardStageItem:_refreshRewardItem(goItem, itemInfo, index)
	local iconItem = self._iconItemTab[index]

	if not iconItem then
		iconItem = self:getUserDataTb_()

		local goIcon = gohelper.findChild(goItem, "go_Icon")

		iconItem.icon = IconMgr.instance:getCommonPropItemIcon(goIcon)
		iconItem.goHasGet = gohelper.findChild(goItem, "go_HasGet")
		iconItem.goCanGet = gohelper.findChild(goItem, "go_CanGet")
		self._iconItemTab[index] = iconItem
	end

	local materialType = itemInfo[1]
	local itemId = itemInfo[2]
	local count = itemInfo[3]

	iconItem.icon:setMOValue(materialType, itemId, count)
	iconItem.icon:setCountFontSize(45)
	gohelper.setActive(iconItem.goCanGet, self._status == Rouge2_OutsideEnum.BossRewardStatus.CanGet)
	gohelper.setActive(iconItem.goHasGet, self._status == Rouge2_OutsideEnum.BossRewardStatus.HasGet)
end

function Rouge2_BossBattleRewardStageItem:onDestroy()
	return
end

return Rouge2_BossBattleRewardStageItem
