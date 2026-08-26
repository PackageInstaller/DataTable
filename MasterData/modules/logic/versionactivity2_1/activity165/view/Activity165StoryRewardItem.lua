-- chunkname: @modules/logic/versionactivity2_1/activity165/view/Activity165StoryRewardItem.lua

module("modules.logic.versionactivity2_1.activity165.view.Activity165StoryRewardItem", package.seeall)

local Activity165StoryRewardItem = class("Activity165StoryRewardItem", LuaCompBase)

function Activity165StoryRewardItem:onInitView()
	self._goreward = gohelper.findChild(self.viewGO, "#go_reward")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Activity165StoryRewardItem:addEvents()
	return
end

function Activity165StoryRewardItem:removeEvents()
	return
end

function Activity165StoryRewardItem:addEventListeners()
	self:addEvents()
end

function Activity165StoryRewardItem:removeEventListeners()
	self:removeEvents()
end

function Activity165StoryRewardItem:init(go)
	self.viewGO = go

	self:onInitView()
end

function Activity165StoryRewardItem:_editableInitView()
	self._rewarditems = {}
	self._rewardGoPrefabs = gohelper.findChild(self.viewGO, "layout/go_reward")
	self._godarkpoint = gohelper.findChild(self.viewGO, "darkpoint")
	self._golightpoint = gohelper.findChild(self.viewGO, "lightpoint")
	self._golayout = gohelper.findChild(self.viewGO, "layout")
end

function Activity165StoryRewardItem:onUpdateParam(index, co)
	local bonus = DungeonConfig.instance:getRewardItems(tonumber(co.bonus))

	self._storyId = co.storyId
	self._actId = Activity165Model.instance:getActivityId()
	self._storyMo = Activity165Model.instance:getStoryMo(self._actId, self._storyId)
	self._index = index

	local rewardCount = #bonus

	for i = 1, rewardCount do
		local rewardInfo = bonus[i]
		local item = self:getRewardItem(i)

		self:onRefreshItem(index, i)
		gohelper.setActive(item.go, true)

		item.rewardCfg = rewardInfo
		item.itemCfg, item.iconPath = ItemModel.instance:getItemConfigAndIcon(rewardInfo[1], rewardInfo[2])

		item.simagereward:LoadImage(item.iconPath)
		UISpriteSetMgr.instance:setUiFBSprite(item.imagebg, "bg_pinjidi_" .. item.itemCfg.rare)

		item.txtpointvalue.text = luaLang("multiple") .. rewardInfo[3]
	end

	gohelper.setActive(self.viewGO, true)
end

function Activity165StoryRewardItem:getRewardItem(index)
	local item = self._rewarditems[index]

	if not item then
		item = self:getUserDataTb_()

		local itemGo = gohelper.clone(self._rewardGoPrefabs, self._golayout, "reward_" .. tostring(index))

		item.imagebg = gohelper.findChildImage(itemGo, "item/image_rare")
		item.simagereward = gohelper.findChildSingleImage(itemGo, "item/simage_icon")
		item.txtpointvalue = gohelper.findChildText(itemGo, "item/txt_num")
		item.imagereward = item.simagereward:GetComponent(gohelper.Type_Image)
		item.btn = gohelper.findChildButtonWithAudio(itemGo, "item/btn_click")
		item.goalreadygot = gohelper.findChild(itemGo, "go_hasget")
		item.btncanget = gohelper.findChildButtonWithAudio(itemGo, "go_canget")

		item.btn:AddClickListener(self.onClickItem, self, item)

		item.go = itemGo
		self._rewarditems[index] = item
	end

	return item
end

function Activity165StoryRewardItem:onRefreshItem(line, index)
	if not self._storyMo then
		return
	end

	local item = self:getRewardItem(index)
	local unlockEndingCount = self._storyMo:getUnlockEndingCount() or 0
	local claimCount = self._storyMo:getclaimRewardCount() or 0

	item.hasGetBonus = line <= claimCount
	item.unlock = line <= unlockEndingCount
	item.canGetBonus = item.unlock and not item.hasGetBonus

	gohelper.setActive(item.goalreadygot, item.hasGetBonus)
	gohelper.setActive(item.btncanget.gameObject, item.canGetBonus)
	gohelper.setActive(self._godarkpoint, not item.unlock)
	gohelper.setActive(self._golightpoint.gameObject, item.unlock)
end

function Activity165StoryRewardItem:onClickItem(item)
	MaterialTipController.instance:showMaterialInfo(item.rewardCfg[1], item.rewardCfg[2])
end

function Activity165StoryRewardItem:checkBonus()
	if not self._storyMo then
		return
	end

	local unlockEndingCount = self._storyMo:getUnlockEndingCount()
	local claimCount = self._storyMo:getclaimRewardCount()
	local allRewardCo = self._storyMo:getAllEndingRewardCo()
	local isCanGetBonus = false

	for i = 1, #allRewardCo do
		local canGetBonus = i <= unlockEndingCount and i > claimCount

		if canGetBonus then
			isCanGetBonus = true

			break
		end
	end

	if isCanGetBonus then
		TaskDispatcher.runDelay(self.onGetBonusCallback, self, 0.5)
	end
end

function Activity165StoryRewardItem:onGetBonusCallback()
	Activity165Rpc.instance:sendAct165GainMilestoneRewardRequest(self._actId, self._storyId)
end

function Activity165StoryRewardItem:onStart()
	return
end

function Activity165StoryRewardItem:onDestroy()
	for _, item in pairs(self._rewarditems) do
		item.btn:RemoveClickListener()
		item.btncanget:RemoveClickListener()
		item.simagereward:UnLoadImage()
	end

	TaskDispatcher.cancelTask(self.onGetBonusCallback, self)
end

return Activity165StoryRewardItem
