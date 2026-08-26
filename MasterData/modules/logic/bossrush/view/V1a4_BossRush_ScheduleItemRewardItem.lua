-- chunkname: @modules/logic/bossrush/view/V1a4_BossRush_ScheduleItemRewardItem.lua

module("modules.logic.bossrush.view.V1a4_BossRush_ScheduleItemRewardItem", package.seeall)

local V1a4_BossRush_ScheduleItemRewardItem = class("V1a4_BossRush_ScheduleItemRewardItem", LuaCompBase)

function V1a4_BossRush_ScheduleItemRewardItem:init(go)
	self._imageQualityBg = gohelper.findChildImage(go, "image_QualityBg")
	self._simageReward = gohelper.findChildSingleImage(go, "simage_Reward")
	self._imageQualityFrame = gohelper.findChildImage(go, "image_QualityFrame")
	self._goHasGet = gohelper.findChild(go, "go_HasGet")
	self._txtDesc = gohelper.findChildText(go, "txt_Desc")
	self._click = gohelper.getClick(go)
	self.go = go
	self._anim = go:GetComponent(gohelper.Type_Animator)
	self._goHasGetAnim = self._goHasGet:GetComponent(gohelper.Type_Animator)

	self._click:AddClickListener(self._onClick, self)

	self._isActive = false

	gohelper.setActive(go, false)
end

function V1a4_BossRush_ScheduleItemRewardItem:onDestroy()
	self._click:RemoveClickListener()

	if self._simageReward then
		self._simageReward:UnLoadImage()
	end

	self._simageReward = nil
end

function V1a4_BossRush_ScheduleItemRewardItem:onDestroyView()
	self:onDestroy()
end

function V1a4_BossRush_ScheduleItemRewardItem:setData(itemCO)
	self._itemCO = itemCO

	local itemType = itemCO[1]
	local itemId = itemCO[2]
	local quantity = itemCO[3]
	local itemConfig, iconPath = ItemModel.instance:getItemConfigAndIcon(itemType, itemId)
	local rare = itemConfig.rare

	UISpriteSetMgr.instance:setV1a4BossRushSprite(self._imageQualityBg, BossRushConfig.instance:getQualityBgSpriteName(rare))
	UISpriteSetMgr.instance:setV1a4BossRushSprite(self._imageQualityFrame, BossRushConfig.instance:getQualityFrameSpriteName(rare))
	self._simageReward:LoadImage(iconPath)

	self._txtDesc.text = luaLang("multiple") .. quantity
end

function V1a4_BossRush_ScheduleItemRewardItem:setActive(isActive)
	if self._isActive == isActive then
		return
	end

	self._isActive = isActive

	gohelper.setActive(self.go, isActive)
end

function V1a4_BossRush_ScheduleItemRewardItem:_onClick()
	local itemCO = self._itemCO

	if not itemCO then
		return
	end

	MaterialTipController.instance:showMaterialInfo(itemCO[1], itemCO[2])
end

function V1a4_BossRush_ScheduleItemRewardItem:playAnim_HasGet(eAnimScheduleItemRewardItem_HasGet, ...)
	self._goHasGetAnim:Play(eAnimScheduleItemRewardItem_HasGet, ...)
end

function V1a4_BossRush_ScheduleItemRewardItem:playAnim(eAnimScheduleItemRewardItem, ...)
	self._anim:Play(eAnimScheduleItemRewardItem, ...)
end

return V1a4_BossRush_ScheduleItemRewardItem
