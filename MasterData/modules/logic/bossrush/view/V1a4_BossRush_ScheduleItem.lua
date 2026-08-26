-- chunkname: @modules/logic/bossrush/view/V1a4_BossRush_ScheduleItem.lua

module("modules.logic.bossrush.view.V1a4_BossRush_ScheduleItem", package.seeall)

local V1a4_BossRush_ScheduleItem = class("V1a4_BossRush_ScheduleItem", LuaCompBase)
local split = string.split
local splitToNumber = string.splitToNumber

function V1a4_BossRush_ScheduleItem:init(go)
	self._goBg = gohelper.findChildImage(go, "#go_Bg")
	self._imageStatus = gohelper.findChildImage(go, "verticalLayout/#image_Status")
	self._txtPointValue = gohelper.findChildText(go, "verticalLayout/#image_Status/#txt_PointValue")

	self:_initItems(go)

	self._txtPointValue.text = ""

	gohelper.setActive(self._goBg, false)
end

function V1a4_BossRush_ScheduleItem:_initItems(rootGo)
	self._itemList = {}

	local i = 1
	local go = gohelper.findChild(rootGo, "verticalLayout/item" .. i)
	local itemClass = V1a4_BossRush_ScheduleItemRewardItem

	while not gohelper.isNil(go) do
		self._itemList[i] = MonoHelper.addNoUpdateLuaComOnceToGo(go, itemClass)
		i = i + 1
		go = gohelper.findChild(rootGo, "verticalLayout/item" .. i)
	end
end

function V1a4_BossRush_ScheduleItem:setData(mo)
	self._mo = mo

	self:_refresh()
	self:_playOpen()
end

function V1a4_BossRush_ScheduleItem:onDestroyView()
	TaskDispatcher.cancelTask(self._playOpenInner, self)
	GameUtil.onDestroyViewMemberList(self, "_itemList")
end

function V1a4_BossRush_ScheduleItem:_refresh()
	local mo = self._mo
	local stageRewardCO = mo.stageRewardCO
	local isDisplay = stageRewardCO.display > 0
	local rewardStrList = split(stageRewardCO.reward, "|")

	for _, item in ipairs(self._itemList) do
		item:setActive(false)
	end

	for i, str in ipairs(rewardStrList) do
		local itemCO = splitToNumber(str, "#")
		local item = self._itemList[i]

		if item then
			item:setData(itemCO)
			item:setActive(true)
		end
	end

	UISpriteSetMgr.instance:setV1a4BossRushSprite(self._imageStatus, BossRushConfig.instance:getRewardStatusSpriteName(isDisplay, self:_isGot()))
	gohelper.setActive(self._goBg, isDisplay)

	self._txtPointValue.text = stageRewardCO.rewardPointNum

	SLFramework.UGUI.GuiHelper.SetColor(self._txtPointValue, (self:_isGot() or nil) and (BossRushEnum.Color.POINTVALUE_GOT or BossRushEnum.Color.POINTVALUE_NORMAL))
end

function V1a4_BossRush_ScheduleItem:refreshByDisplayTarget(mo)
	self._mo = mo
	self._index = mo._index

	self:_refresh()
	gohelper.setActive(self._goBg, false)
end

function V1a4_BossRush_ScheduleItem:_isNewGot()
	local index = self._index
	local staticData = V1a4_BossRush_ScheduleViewListModel.instance:getStaticData()
	local fromIndex = staticData.fromIndex
	local toIndex = staticData.toIndex

	return fromIndex <= index and index <= toIndex
end

function V1a4_BossRush_ScheduleItem:_isAlreadyGot()
	local mo = self._mo
	local isGot = mo.isGot
	local index = self._index
	local staticData = V1a4_BossRush_ScheduleViewListModel.instance:getStaticData()
	local fromIndex = staticData.fromIndex

	return isGot or index < fromIndex
end

function V1a4_BossRush_ScheduleItem:_isGot()
	return self:_isAlreadyGot() or self:_isNewGot()
end

function V1a4_BossRush_ScheduleItem:_playOpen()
	if self:_isGot() then
		local staticData = V1a4_BossRush_ScheduleViewListModel.instance:getStaticData()
		local fromIndex = staticData.fromIndex

		TaskDispatcher.runDelay(self._playOpenInner, self, 0.1 + (self._index - fromIndex) * 0.02)
	end
end

local EAnimScheduleItemRewardItem = BossRushEnum.AnimScheduleItemRewardItem
local EAnimScheduleItemRewardItem_HasGet = BossRushEnum.AnimScheduleItemRewardItem_HasGet

function V1a4_BossRush_ScheduleItem:_playOpenInner()
	for _, v in ipairs(self._itemList) do
		if self:_isNewGot() then
			v:playAnim(EAnimScheduleItemRewardItem.ReceiveEnter)
			v:playAnim_HasGet(EAnimScheduleItemRewardItem_HasGet.Got)
		else
			v:playAnim((self:_isGot() or nil) and (EAnimScheduleItemRewardItem.Got or EAnimScheduleItemRewardItem.Idle))
		end
	end
end

return V1a4_BossRush_ScheduleItem
