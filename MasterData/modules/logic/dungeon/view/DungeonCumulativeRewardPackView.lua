-- chunkname: @modules/logic/dungeon/view/DungeonCumulativeRewardPackView.lua

module("modules.logic.dungeon.view.DungeonCumulativeRewardPackView", package.seeall)

local DungeonCumulativeRewardPackView = class("DungeonCumulativeRewardPackView", BaseView)

function DungeonCumulativeRewardPackView:onInitView()
	self._simagebg = gohelper.findChildSingleImage(self.viewGO, "#simage_bg")
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_close")
	self._txtprogress = gohelper.findChildText(self.viewGO, "#txt_progress")
	self._imagepoint = gohelper.findChildImage(self.viewGO, "go_progress/#image_point")
	self._imagenormalright = gohelper.findChildImage(self.viewGO, "go_progress/#image_normal_right")
	self._imagenormalleft = gohelper.findChildImage(self.viewGO, "go_progress/#image_normal_left")
	self._gorewards = gohelper.findChild(self.viewGO, "#go_rewards")
	self._gorewardtemplate = gohelper.findChild(self.viewGO, "#go_rewards/#go_reward_template")
	self._gotips = gohelper.findChild(self.viewGO, "#go_tips")
	self._txttipsinfo = gohelper.findChildText(self.viewGO, "#go_tips/#txt_tipsinfo")
	self._simageleftbg = gohelper.findChildSingleImage(self.viewGO, "#simage_leftbg")
	self._simagerightbg = gohelper.findChildSingleImage(self.viewGO, "#simage_rightbg")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function DungeonCumulativeRewardPackView:addEvents()
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
end

function DungeonCumulativeRewardPackView:removeEvents()
	self._btnclose:RemoveClickListener()
end

function DungeonCumulativeRewardPackView:_btncloseOnClick()
	self:closeThis()
end

function DungeonCumulativeRewardPackView:_editableInitView()
	self._simagebg:LoadImage(ResUrl.getDungeonIcon("full/guankajianlibiejing_038"))
	self._simageleftbg:LoadImage(ResUrl.getCommonIcon("bg_1"))
	self._simagerightbg:LoadImage(ResUrl.getCommonIcon("bg_2"))

	self._txttitlecn = gohelper.findChildText(self.viewGO, "titlecn")
	self._txttitleen = gohelper.findChildText(self.viewGO, "titlecn/titleen")
end

function DungeonCumulativeRewardPackView:onUpdateParam()
	return
end

function DungeonCumulativeRewardPackView:_getPointRewardRequest()
	if GuideModel.instance:isFlagEnable(GuideModel.GuideFlag.DelayGetPointReward) then
		return
	end

	local rewards = DungeonMapModel.instance:canGetRewards(self._chapterId)

	if rewards and #rewards > 0 then
		DungeonRpc.instance:sendGetPointRewardRequest(rewards)
	end
end

function DungeonCumulativeRewardPackView:onOpen()
	self._chapterId = self.viewParam.chapterId

	if not GuideModel.instance:isFlagEnable(GuideModel.GuideFlag.DelayGetPointReward) then
		TaskDispatcher.runDelay(self._getPointRewardRequest, self, 0.6)
	end

	NavigateMgr.instance:addEscape(self.viewName, self._btncloseOnClick, self)

	self._pointRewardCfg = DungeonConfig.instance:getChapterPointReward(self._chapterId)
	self._pointRewardInfo = DungeonMapModel.instance:getRewardPointInfo(self._chapterId)

	local len = #self._pointRewardCfg

	if len > 0 then
		self._lastPointRewardCfg = self._pointRewardCfg[len]
	end

	local chapterConfig = DungeonConfig.instance:getChapterCO(self._chapterId)

	self._txttitlecn.text = chapterConfig.name
	self._txttitleen.text = chapterConfig.name_En

	self:createRewardUIs()
	self:refreshRewardItems()
	self:refreshUnlockCondition()
	self:refreshProgress()
	self.addEventCb(self, DungeonController.instance, DungeonEvent.OnGetPointReward, self.refreshRewardItems, self)
	self.addEventCb(self, DungeonController.instance, DungeonEvent.GuideGetPointReward, self._getPointRewardRequest, self)
end

function DungeonCumulativeRewardPackView:createRewardUIs()
	local lastCfg = self._lastPointRewardCfg

	if self._isInitItems or not lastCfg then
		return
	end

	local rewardStrList = string.split(lastCfg.reward, "|")

	self._isInitItems = true
	self._rewarditems = {}

	for i = 1, #rewardStrList do
		local rewardInfo = string.splitToNumber(rewardStrList[i], "#")
		local item = self:getUserDataTb_()
		local itemGo = gohelper.clone(self._gorewardtemplate, self._gorewards, "reward_" .. tostring(i))

		item.imagebg = gohelper.findChildImage(itemGo, "image_bg")
		item.simagereward = gohelper.findChildSingleImage(itemGo, "simage_reward")
		item.txtrewardcount = gohelper.findChildText(itemGo, "txt_rewardcount")
		item.imagereward = item.simagereward:GetComponent(gohelper.Type_Image)
		item.btn = gohelper.findChildClick(itemGo, "simage_reward")
		item.goalreadygot = gohelper.findChild(itemGo, "go_hasget")

		item.btn:AddClickListener(self.onClickItem, self, item)

		item.go = itemGo
		item.rewardCfg = rewardInfo
		item.itemCfg, item.iconPath = ItemModel.instance:getItemConfigAndIcon(rewardInfo[1], rewardInfo[2])

		gohelper.setActive(item.go, true)
		table.insert(self._rewarditems, item)
	end
end

function DungeonCumulativeRewardPackView:refreshRewardItems()
	local pointRewardInfo = self._pointRewardInfo
	local lastCfg = self._lastPointRewardCfg

	for i, item in ipairs(self._rewarditems) do
		self:refreshRewardUIItem(item, lastCfg, pointRewardInfo)
	end
end

local COLOR_REWARD_GOT = Color.New(0.6941177, 0.6941177, 0.6941177, 1)
local COLOR_REWARD_NORMAL = Color.New(1, 1, 1, 1)
local COLOR_BG_GOT = Color.New(1, 1, 1, 0.5)
local COLOR_BG_NORMAL = Color.New(1, 1, 1, 1)
local COLOR_COUNT_GOT = Color.New(0.227451, 0.227451, 0.227451, 1)
local COLOR_COUNT_NORMAL = Color.New(0.227451, 0.227451, 0.227451, 1)

function DungeonCumulativeRewardPackView:refreshRewardUIItem(itemObj, pointCfg, pointInfo)
	local alreadyGot = tabletool.indexOf(pointInfo.hasGetPointRewardIds, pointCfg.id)

	if alreadyGot then
		if not COLOR_REWARD_GOT then
			local rewardColor = COLOR_REWARD_NORMAL

			if alreadyGot then
				if not COLOR_BG_GOT then
					local bgColor = COLOR_BG_NORMAL

					if alreadyGot then
						if not COLOR_COUNT_GOT then
							itemObj.imagereward.color = rewardColor
							itemObj.imagebg.color = bgColor
							itemObj.txtrewardcount.color = COLOR_COUNT_NORMAL

							itemObj.simagereward:LoadImage(itemObj.iconPath)

							itemObj.txtrewardcount.text = tostring(itemObj.rewardCfg[3])

							gohelper.setActive(itemObj.goalreadygot, alreadyGot)
						end
					end
				end
			end
		end
	end
end

function DungeonCumulativeRewardPackView:onClickItem(itemObj)
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Common_Click)
	MaterialTipController.instance:showMaterialInfo(itemObj.rewardCfg[1], itemObj.rewardCfg[2])
end

function DungeonCumulativeRewardPackView:refreshUnlockCondition()
	local unlockChapterConfig = DungeonConfig.instance:getUnlockChapterConfig(self._chapterId)

	if not unlockChapterConfig then
		gohelper.setActive(self._gotips, false)

		return
	end

	gohelper.setActive(self._gotips, true)

	local cur, max = DungeonMapModel.instance:getTotalRewardPointProgress(self._chapterId)
	local tag = {
		tostring(max),
		unlockChapterConfig.name
	}

	self._txttipsinfo.text = GameUtil.getSubPlaceholderLuaLang(luaLang("dungeoncumulativerewardsview_tips"), tag)
end

function DungeonCumulativeRewardPackView:refreshProgress()
	local cur, max = DungeonMapModel.instance:getTotalRewardPointProgress(self._chapterId)

	self._txtprogress.text = string.format("%s/%s", cur, max)

	local maxNum = self._lastPointRewardCfg.rewardPointNum
	local progressValue = cur / max

	self._imagenormalleft.fillAmount = progressValue
	self._imagenormalright.fillAmount = progressValue

	local isFinish = maxNum <= self._pointRewardInfo.rewardPoint

	UISpriteSetMgr.instance:setUiFBSprite(self._imagepoint, isFinish and "xingjidian_dian2_005" or "xingjidian_dian1_004")
end

function DungeonCumulativeRewardPackView:onClose()
	if self._isInitItems then
		for _, item in pairs(self._rewarditems) do
			item.btn:RemoveClickListener()
			item.simagereward:UnLoadImage()
		end
	end

	TaskDispatcher.cancelTask(self._getPointRewardRequest, self)
end

function DungeonCumulativeRewardPackView:onDestroyView()
	self._simagebg:UnLoadImage()
	self._simageleftbg:UnLoadImage()
	self._simagerightbg:UnLoadImage()
end

return DungeonCumulativeRewardPackView
