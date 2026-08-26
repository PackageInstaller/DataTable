-- chunkname: @modules/logic/versionactivity1_2/yaxian/view/YaXianRewardItem.lua

module("modules.logic.versionactivity1_2.yaxian.view.YaXianRewardItem", package.seeall)

local YaXianRewardItem = class("YaXianRewardItem", UserDataDispose)

function YaXianRewardItem:ctor(go)
	self:__onInit()

	self.go = go
	self.transform = self.go.transform

	recthelper.setAnchorY(self.transform, 0)
end

function YaXianRewardItem:init()
	self.goRewardContent = gohelper.findChild(self.go, "#go_rewards")
	self.imageStatus = gohelper.findChildImage(self.go, "#go_rewards/#image_status")
	self.goRewardTemplate = gohelper.findChild(self.go, "#go_rewards/#go_reward_template")
	self.goImportant = gohelper.findChild(self.go, "#go_rewards/#go_important")
	self.simageImportantBg = gohelper.findChildSingleImage(self.go, "#go_rewards/#go_important/#simage_importbg")
	self.txtScore = gohelper.findChildText(self.go, "#go_rewards/#txt_score")

	self.simageImportantBg:LoadImage(ResUrl.getDungeonIcon("bg_tishidiban"))
	gohelper.setActive(self.goRewardTemplate, false)

	self.rewardItemList = {}

	self.addEventCb(self, YaXianController.instance, YaXianEvent.OnUpdateBonus, self.refreshRewardHasGet, self)
end

function YaXianRewardItem:updateData(index, config)
	self.index = index
	self.config = config
	self.isFinish = self.config.needScore <= YaXianModel.instance:getScore()
end

function YaXianRewardItem:update(index, config)
	self:show()
	self:updateData(index, config)

	self.txtScore.text = self.config.needScore

	self:refreshIsImport()
	self:refreshStatus()
	self:refreshRewards()
	self:refreshRewardHasGet(true)
	self:calculateAnchorPosX()
	self:setAnchorPos()
end

function YaXianRewardItem:updateByTarget(config)
	self:updateData(-1, config)

	self.txtScore.text = self.config.needScore

	recthelper.setAnchorX(self.transform, 0)
	self:refreshStatus()
	self:refreshRewards()
	self:refreshRewardHasGet(true)
end

function YaXianRewardItem:refreshIsImport()
	gohelper.setActive(self.goImportant, self.config.important ~= 0)
end

function YaXianRewardItem:refreshStatus()
	UISpriteSetMgr.instance:setYaXianSprite(self.imageStatus, self.isFinish and "icon_zhanluedian_get" or "icon_zhanluedian_lock")
end

function YaXianRewardItem:refreshRewards()
	local rewardList = GameUtil.splitString2(self.config.bonus, true)
	local rewardItem, type, id, quantity, itemConfig, iconPath

	for index, rewardArr in ipairs(rewardList) do
		itemConfig, iconPath = ItemModel.instance:getItemConfigAndIcon(rewardArr[1], rewardArr[2])
		rewardItem = self.rewardItemList[index]

		if not self.rewardItemList[index] then
			rewardItem = self:createRewardItem()

			table.insert(self.rewardItemList, rewardItem)
		end

		rewardItem.itemConfig = itemConfig
		rewardItem.type = rewardArr[1]
		rewardItem.id = rewardArr[2]

		gohelper.setActive(rewardItem.go, true)
		UISpriteSetMgr.instance:setUiFBSprite(rewardItem.imageBg, "bg_pinjidi_" .. itemConfig.rare)
		UISpriteSetMgr.instance:setUiFBSprite(rewardItem.imageCircle, "bg_pinjidi_lanse_" .. itemConfig.rare)
		rewardItem.simageReward:LoadImage(iconPath)

		rewardItem.txtRewardCount.text = string.format("<size=25>x</size>%s", rewardArr[3])

		gohelper.setActive(rewardItem.goHasGet, self.isFinish)
	end

	for i = #rewardList + 1, #self.rewardItemList do
		gohelper.setActive(self.rewardItemList[i].go, false)
	end
end

local COLOR_REWARD_GOT = Color.New(0.6941177, 0.6941177, 0.6941177, 1)
local COLOR_REWARD_NORMAL = Color.New(1, 1, 1, 1)
local COLOR_BG_GOT_A = 0.5
local COLOR_BG_NORMAL_A = 1

function YaXianRewardItem:refreshRewardHasGet(isOpen)
	local hasGet = YaXianModel.instance:hasGetBonus(self.config.id)

	if hasGet then
		if not COLOR_REWARD_GOT then
			local rewardColor = COLOR_REWARD_NORMAL

			if hasGet then
				if not COLOR_BG_GOT_A then
					local bgColorA = COLOR_BG_NORMAL_A
					local dungeonSprite = UISpriteSetMgr.instance:getDungeonSprite()

					for _, rewardItem in ipairs(self.rewardItemList) do
						dungeonSprite:setImageAlpha(rewardItem.imageBg, bgColorA)

						rewardItem.imageReward.color = rewardColor

						gohelper.setActive(rewardItem.goHasGet, hasGet)

						if isOpen then
							rewardItem.hasGet = hasGet
						elseif hasGet and hasGet ~= rewardItem.hasGet then
							rewardItem.animator:Play("go_hasget_in")
						end
					end
				end
			end
		end
	end
end

function YaXianRewardItem:createRewardItem()
	local rewardItem = self:getUserDataTb_()

	rewardItem.go = gohelper.clone(self.goRewardTemplate, self.goRewardContent, "reward")
	rewardItem.imageBg = gohelper.findChildImage(rewardItem.go, "image_bg")
	rewardItem.imageCircle = gohelper.findChildImage(rewardItem.go, "image_circle")
	rewardItem.simageReward = gohelper.findChildSingleImage(rewardItem.go, "simage_reward")
	rewardItem.imageReward = gohelper.findChildImage(rewardItem.go, "simage_reward")
	rewardItem.txtRewardCount = gohelper.findChildText(rewardItem.go, "txt_rewardcount")
	rewardItem.goHasGet = gohelper.findChild(rewardItem.go, "go_hasget")
	rewardItem.animator = rewardItem.goHasGet:GetComponent(typeof(UnityEngine.Animator))
	rewardItem.click = gohelper.getClick(rewardItem.simageReward.gameObject)

	rewardItem.click:AddClickListener(self.onCLickRewardItem, self, rewardItem)

	return rewardItem
end

function YaXianRewardItem:onCLickRewardItem(rewardItem)
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Common_Click)
	MaterialTipController.instance:showMaterialInfo(rewardItem.type, rewardItem.id)
end

function YaXianRewardItem:calculateAnchorPosX()
	self.anchorPosX = (self.index - 1) * (YaXianEnum.RewardEnum.RewardItemWidth + YaXianEnum.RewardEnum.IntervalX) + YaXianEnum.RewardEnum.HalfRewardItemWidth
end

function YaXianRewardItem:setAnchorPos()
	recthelper.setAnchorX(self.transform, self.anchorPosX)
end

function YaXianRewardItem:getAnchorPosX()
	return self.anchorPosX
end

function YaXianRewardItem:isImportItem()
	return self.config.important ~= 0
end

function YaXianRewardItem:show()
	gohelper.setActive(self.go, true)
end

function YaXianRewardItem:hide()
	gohelper.setActive(self.go, false)
end

function YaXianRewardItem:onDestroy()
	self.simageImportantBg:UnLoadImage()

	for _, rewardItem in ipairs(self.rewardItemList) do
		rewardItem.click:RemoveClickListener()
		rewardItem.simageReward:UnLoadImage()
	end

	self.rewardItemList = nil

	self:__onDispose()
end

return YaXianRewardItem
