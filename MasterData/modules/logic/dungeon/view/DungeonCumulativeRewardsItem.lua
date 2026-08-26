-- chunkname: @modules/logic/dungeon/view/DungeonCumulativeRewardsItem.lua

module("modules.logic.dungeon.view.DungeonCumulativeRewardsItem", package.seeall)

local DungeonCumulativeRewardsItem = class("DungeonCumulativeRewardsItem", ListScrollCellExtend)

function DungeonCumulativeRewardsItem:onInitView()
	self._gorewards = gohelper.findChild(self.viewGO, "#go_rewards")
	self._goimportant = gohelper.findChild(self.viewGO, "#go_rewards/#go_important")
	self._simageimportantbg = gohelper.findChildSingleImage(self.viewGO, "#go_rewards/#go_important/#simage_importantbg")
	self._txtpointname = gohelper.findChildText(self.viewGO, "#go_rewards/#go_important/#txt_pointname")
	self._gofinishline = gohelper.findChild(self.viewGO, "#go_rewards/#go_important/#txt_pointname/#go_finishline")
	self._gounfinishline = gohelper.findChild(self.viewGO, "#go_rewards/#go_important/#txt_pointname/#go_unfinishline")
	self._gorewardtemplate = gohelper.findChild(self.viewGO, "#go_rewards/#go_reward_template")
	self._imagestatus = gohelper.findChildImage(self.viewGO, "#go_rewards/#image_status")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function DungeonCumulativeRewardsItem:addEvents()
	return
end

function DungeonCumulativeRewardsItem:removeEvents()
	return
end

function DungeonCumulativeRewardsItem:ctor(param)
	self._chapterId = param[1]
	self._pointRewardCfg = param[2]
	self._isRightDisplay = param[3]
	self.rewardId = self._pointRewardCfg.id
	self.curPointValue = self._pointRewardCfg.rewardPointNum
	self.prevPosX = param[4]
	self.curPosX = param[5]
	self.prevPointValue = param[6]
end

function DungeonCumulativeRewardsItem:createRewardUIs()
	local pointRewardCfg = self._pointRewardCfg
	local rewardStrList = string.split(pointRewardCfg.reward, "|")

	self._rewarditems = {}

	for i = 1, #rewardStrList do
		local rewardInfo = string.splitToNumber(rewardStrList[i], "#")
		local item = self:getUserDataTb_()
		local itemGo = gohelper.clone(self._gorewardtemplate, self._gorewards, "reward_" .. tostring(i))

		item.imagebg = gohelper.findChildImage(itemGo, "image_bg")
		item.imagecircle = gohelper.findChildImage(itemGo, "image_circle")
		item.simagereward = gohelper.findChildSingleImage(itemGo, "simage_reward")
		item.txtrewardcount = gohelper.findChildText(itemGo, "txt_rewardcount")
		item.txtpointvalue = gohelper.findChildText(itemGo, "txt_pointvalue")
		item.imagereward = item.simagereward:GetComponent(gohelper.Type_Image)
		item.btn = gohelper.findChildClick(itemGo, "simage_reward")
		item.goalreadygot = gohelper.findChild(itemGo, "go_hasget")

		item.btn:AddClickListener(self.onClickItem, self, item)

		item.go = itemGo
		item.rewardCfg = rewardInfo
		item.itemCfg, item.iconPath = ItemModel.instance:getItemConfigAndIcon(rewardInfo[1], rewardInfo[2])

		gohelper.setActive(item.go, true)
		UISpriteSetMgr.instance:setUiFBSprite(item.imagebg, "bg_pinjidi_" .. item.itemCfg.rare)
		UISpriteSetMgr.instance:setUiFBSprite(item.imagecircle, "bg_pinjidi_lanse_" .. item.itemCfg.rare)
		table.insert(self._rewarditems, item)
	end
end

function DungeonCumulativeRewardsItem:refreshRewardItems(showGetAnim)
	self._pointRewardInfo = DungeonMapModel.instance:getRewardPointInfo(self._chapterId)

	for i, item in ipairs(self._rewarditems) do
		self:refreshRewardUIItem(item, self._pointRewardCfg, showGetAnim)
	end
end

local COLOR_REWARD_GOT = Color.New(0.5, 0.5, 0.5, 1)
local COLOR_REWARD_NORMAL = Color.New(1, 1, 1, 1)
local COLOR_BG_GOT = Color.New(0.5, 0.5, 0.5, 1)
local COLOR_BG_NORMAL = Color.New(1, 1, 1, 1)
local COLOR_POINTVALUE_NORMAL = Color.New(0.4, 0.3882353, 0.3843137, 1)
local COLOR_POINTVALUE_GOT = Color.New(0.6745098, 0.3254902, 0.1254902, 1)

function DungeonCumulativeRewardsItem:refreshRewardUIItem(itemObj, pointCfg, showGetAnim)
	local alreadyGot = tabletool.indexOf(self._pointRewardInfo.hasGetPointRewardIds, pointCfg.id)

	itemObj.simagereward:LoadImage(itemObj.iconPath)

	itemObj.txtrewardcount.text = string.format("%s%s", luaLang("multiple"), tostring(itemObj.rewardCfg[3]))
	itemObj.txtpointvalue.text = pointCfg.rewardPointNum

	if alreadyGot then
		itemObj.txtpointvalue.color = COLOR_POINTVALUE_GOT or COLOR_POINTVALUE_NORMAL
	end

	gohelper.setActive(itemObj.goalreadygot, alreadyGot)

	if showGetAnim then
		local animator = itemObj.goalreadygot:GetComponent(typeof(UnityEngine.Animator))

		animator:Play("go_hasget_in")
	end

	local rewardAnim = itemObj.go:GetComponent(typeof(UnityEngine.Animator))

	if alreadyGot then
		if not showGetAnim then
			rewardAnim:Play("dungeoncumulativerewardsitem_receiveenter")
		else
			rewardAnim:Play("dungeoncumulativerewardsitem_received")
		end
	end
end

function DungeonCumulativeRewardsItem:onClickItem(itemObj)
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Common_Click)
	MaterialTipController.instance:showMaterialInfo(itemObj.rewardCfg[1], itemObj.rewardCfg[2])
end

function DungeonCumulativeRewardsItem:_editableInitView()
	self:createRewardUIs()
	self:refreshRewardItems()
	self:_refreshStatus()
	self._simageimportantbg:LoadImage(ResUrl.getDungeonIcon("bg_tishidiban"))
end

function DungeonCumulativeRewardsItem:_refreshStatus()
	local isFinish = self._pointRewardInfo.rewardPoint >= self.curPointValue

	if self._pointRewardCfg.display > 0 then
		UISpriteSetMgr.instance:setUiFBSprite(self._imagestatus, "bg_xingjidian_1" .. (isFinish and "" or "_dis"), true)
	else
		UISpriteSetMgr.instance:setUiFBSprite(self._imagestatus, "bg_xingjidian" .. (isFinish and "" or "_dis"), true)
	end

	gohelper.setActive(self._goimportant, self._pointRewardCfg.display > 0)

	local showUnlock = self._pointRewardCfg.unlockChapter > 0

	if showUnlock then
		local chapterConfig = lua_chapter.configDict[self._pointRewardCfg.unlockChapter]

		self._txtpointname.text = string.format(luaLang("dungeonmapview_unlocktitle"), chapterConfig.name)

		gohelper.setActive(self._gofinishline, isFinish)
		gohelper.setActive(self._gounfinishline, not isFinish)
	else
		gohelper.setActive(self._txtpointname.gameObject, false)
	end

	gohelper.setActive(self._simageimportantbg.gameObject, not self._isRightDisplay)
end

function DungeonCumulativeRewardsItem:_editableAddEvents()
	return
end

function DungeonCumulativeRewardsItem:_editableRemoveEvents()
	return
end

function DungeonCumulativeRewardsItem:onDestroyView()
	for _, item in pairs(self._rewarditems) do
		item.btn:RemoveClickListener()
		item.simagereward:UnLoadImage()
	end

	self._simageimportantbg:UnLoadImage()
end

return DungeonCumulativeRewardsItem
