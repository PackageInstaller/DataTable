-- chunkname: @modules/logic/versionactivity1_6/dungeon/view/boss/VersionActivity1_6_BossScheduleItem.lua

module("modules.logic.versionactivity1_6.dungeon.view.boss.VersionActivity1_6_BossScheduleItem", package.seeall)

local VersionActivity1_6_BossScheduleItem = class("VersionActivity1_6_BossScheduleItem", LuaCompBase)
local split = string.split
local splitToNumber = string.splitToNumber

function VersionActivity1_6_BossScheduleItem:init(go)
	self._goBg = gohelper.findChildImage(go, "#go_Bg")
	self._imageStatus = gohelper.findChildImage(go, "verticalLayout/#image_Status")
	self._txtPointValue = gohelper.findChildText(go, "verticalLayout/#image_Status/#txt_PointValue")

	self:_initItems(go)

	self._txtPointValue.text = ""

	gohelper.setActive(self._goBg, false)
end

function VersionActivity1_6_BossScheduleItem:_initItems(rootGo)
	self._itemList = {}

	local i = 1
	local go = gohelper.findChild(rootGo, "verticalLayout/item" .. i)
	local itemClass = VersionActivity1_6_BossScheduleRewardItem

	while not gohelper.isNil(go) do
		self._itemList[i] = MonoHelper.addNoUpdateLuaComOnceToGo(go, itemClass)
		i = i + 1
		go = gohelper.findChild(rootGo, "verticalLayout/item" .. i)
	end
end

function VersionActivity1_6_BossScheduleItem:setData(mo)
	self._mo = mo

	self:_refresh()
	self:_playOpen()
end

function VersionActivity1_6_BossScheduleItem:onDestroyView()
	TaskDispatcher.cancelTask(self._playOpenInner, self)
	GameUtil.onDestroyViewMemberList(self, "_itemList")
end

function VersionActivity1_6_BossScheduleItem:_refresh()
	local mo = self._mo
	local rewardCfg = mo.rewardCfg
	local rewardStrList = split(rewardCfg.reward, "|")

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

	self._txtPointValue.text = rewardCfg.rewardPointNum

	SLFramework.UGUI.GuiHelper.SetColor(self._txtPointValue, (self:_isGot() or nil) and (BossRushEnum.Color.POINTVALUE_GOT or BossRushEnum.Color.POINTVALUE_NORMAL))
end

function VersionActivity1_6_BossScheduleItem:refreshByDisplayTarget(mo)
	self._mo = mo
	self._index = mo._index

	self:_refresh()
	gohelper.setActive(self._goBg, false)
end

function VersionActivity1_6_BossScheduleItem:_isNewGot()
	local index = self._index
	local staticData = VersionActivity1_6ScheduleViewListModel.instance:getStaticData()
	local fromIndex = staticData.fromIndex
	local toIndex = staticData.toIndex

	return fromIndex <= index and index <= toIndex
end

function VersionActivity1_6_BossScheduleItem:_isAlreadyGot()
	local mo = self._mo
	local isGot = mo.isGot
	local index = self._index
	local staticData = VersionActivity1_6ScheduleViewListModel.instance:getStaticData()
	local fromIndex = staticData.fromIndex

	return isGot or index < fromIndex
end

function VersionActivity1_6_BossScheduleItem:_isGot()
	return self:_isAlreadyGot() or self:_isNewGot()
end

function VersionActivity1_6_BossScheduleItem:_playOpen()
	if self:_isGot() then
		local staticData = VersionActivity1_6ScheduleViewListModel.instance:getStaticData()
		local fromIndex = staticData.fromIndex

		TaskDispatcher.runDelay(self._playOpenInner, self, 0.1 + (self._index - fromIndex) * 0.02)
	end
end

local EAnimScheduleItemRewardItem = BossRushEnum.AnimScheduleItemRewardItem
local EAnimScheduleItemRewardItem_HasGet = BossRushEnum.AnimScheduleItemRewardItem_HasGet

function VersionActivity1_6_BossScheduleItem:_playOpenInner()
	for _, v in ipairs(self._itemList) do
		if self:_isNewGot() then
			v:playAnim(EAnimScheduleItemRewardItem.ReceiveEnter)
			v:playAnim_HasGet(EAnimScheduleItemRewardItem_HasGet.Got)
		else
			v:playAnim((self:_isGot() or nil) and (EAnimScheduleItemRewardItem.Got or EAnimScheduleItemRewardItem.Idle))
		end
	end
end

return VersionActivity1_6_BossScheduleItem
