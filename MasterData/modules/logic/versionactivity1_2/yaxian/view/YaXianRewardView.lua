-- chunkname: @modules/logic/versionactivity1_2/yaxian/view/YaXianRewardView.lua

module("modules.logic.versionactivity1_2.yaxian.view.YaXianRewardView", package.seeall)

local YaXianRewardView = class("YaXianRewardView", BaseView)

function YaXianRewardView:onInitView()
	self._simagebg = gohelper.findChildSingleImage(self.viewGO, "#simage_bg")
	self._btncloseview = gohelper.findChildButton(self.viewGO, "#btn_closeview")
	self._simageblackbg = gohelper.findChildSingleImage(self.viewGO, "#simage_blackbg")
	self._simageleftbg = gohelper.findChildSingleImage(self.viewGO, "#simage_leftbg")
	self._gotips = gohelper.findChild(self.viewGO, "#go_tips")
	self._txttipsinfo = gohelper.findChildText(self.viewGO, "#go_tips/#txt_tipsinfo")
	self._scrollreward = gohelper.findChildScrollRect(self.viewGO, "#scroll_reward")
	self._gocontent = gohelper.findChild(self.viewGO, "#scroll_reward/Viewport/#go_content")
	self._gobottom = gohelper.findChild(self.viewGO, "#scroll_reward/Viewport/#go_content/#go_bottom")
	self._gograyline = gohelper.findChild(self.viewGO, "#scroll_reward/Viewport/#go_content/#go_bottom/#go_grayline")
	self._gonormalline = gohelper.findChild(self.viewGO, "#scroll_reward/Viewport/#go_content/#go_bottom/#go_normalline")
	self._goarrow = gohelper.findChild(self.viewGO, "#scroll_reward/Viewport/#go_content/#go_bottom/#go_arrow")
	self._gotarget = gohelper.findChild(self.viewGO, "#go_target")
	self._txtprogress = gohelper.findChildText(self.viewGO, "progresstip/#txt_progress")
	self._btnclose = gohelper.findChildButton(self.viewGO, "#btn_close")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function YaXianRewardView:addEvents()
	self._btncloseview:AddClickListener(self._btncloseviewOnClick, self)
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
end

function YaXianRewardView:removeEvents()
	self._btncloseview:RemoveClickListener()
	self._btnclose:RemoveClickListener()
end

function YaXianRewardView:_btncloseviewOnClick()
	self:closeThis()
end

function YaXianRewardView:_btncloseOnClick()
	self:closeThis()
end

function YaXianRewardView:initTargetRewardItem()
	local go = self:getResInst(self.itemPath, self.goTargetRewardItemContainer, "item")

	self.targetRewardItem = YaXianRewardItem.New(go)

	self.targetRewardItem:init()
	self.targetRewardItem:show()
end

function YaXianRewardView:_editableInitView()
	self._simagebg:LoadImage(ResUrl.getYaXianImage("img_deco_zhizhuwang"))
	self._simageblackbg:LoadImage(ResUrl.getYaXianImage("img_tanchuang_bg"))

	self.progressIcon = gohelper.findChildImage(self.viewGO, "progresstip/icon")

	UISpriteSetMgr.instance:setYaXianSprite(self.progressIcon, "icon_zhanluedian_get")

	self.goTargetRewardItemContainer = gohelper.findChild(self.viewGO, "#go_target/#go_targetRewardItemContainer")
	self.contentTransform = self._gocontent.transform
	self.scrollWidth = recthelper.getWidth(self._scrollreward.transform)
	self.grayLineTransform = self._gograyline.transform
	self.normalLineTransform = self._gonormalline.transform
	self.arrowTransform = self._goarrow.transform
	self.itemPath = self.viewContainer:getSetting().otherRes[1]
	self.rewardItemList = {}
	self._drag = SLFramework.UGUI.UIDragListener.Get(self._scrollreward.gameObject)

	self._drag:AddDragBeginListener(self._onDragBeginHandler, self)
	self._drag:AddDragEndListener(self._onDragEndHandler, self)

	self._touch = SLFramework.UGUI.UIClickListener.Get(self._scrollreward.gameObject)

	self._touch:AddClickDownListener(self._onClickDownHandler, self)

	self._audioScroll = MonoHelper.addLuaComOnceToGo(self._scrollreward.gameObject, DungeonMapEpisodeAudio, self._scrollreward)

	self:initTargetRewardItem()
	self._scrollreward:AddOnValueChanged(self.onValueChanged, self)
end

function YaXianRewardView:_onDragBeginHandler()
	self._audioScroll:onDragBegin()
end

function YaXianRewardView:_onDragEndHandler()
	self._audioScroll:onDragEnd()
end

function YaXianRewardView:_onClickDownHandler()
	self._audioScroll:onClickDown()
end

function YaXianRewardView:onValueChanged()
	self:refreshTargetRewardItem()
end

function YaXianRewardView:onOpen()
	self._txtprogress.text = YaXianModel.instance:getScore()

	self:refreshItems()
	self:refreshContentWidth()
	self:refreshLineWidthAndArrowAnchor()
	self:refreshTargetRewardItem()
	TaskDispatcher.runDelay(self.senGetBonusRequest, self, 1)
end

function YaXianRewardView:refreshItems()
	local configList = lua_activity115_bonus.configList
	local rewardItem, go

	for index, config in ipairs(configList) do
		rewardItem = self.rewardItemList[index]

		if not self.rewardItemList[index] then
			rewardItem = YaXianRewardItem.New((self:getResInst(self.itemPath, self._gobottom, "item" .. config.id)))

			rewardItem:init()
			table.insert(self.rewardItemList, rewardItem)
		end

		rewardItem:update(index, config)
	end

	for i = #configList + 1, #self.rewardItemList do
		self.rewardItemList[i]:hide()
	end
end

function YaXianRewardView:refreshContentWidth()
	self.contentWidth = #lua_activity115_bonus.configList * (YaXianEnum.RewardEnum.RewardItemWidth + YaXianEnum.RewardEnum.IntervalX) + YaXianEnum.RewardEnum.RewardContentOffsetX

	recthelper.setWidth(self.contentTransform, self.contentWidth)
end

function YaXianRewardView:calculateNormalWidth()
	self.normalLineWidth = 0

	local score = YaXianModel.instance:getScore()
	local find = false
	local anchorIndex = 0

	for index, rewardItem in ipairs(self.rewardItemList) do
		if score < rewardItem.config.needScore then
			local preRewardItem = self.rewardItemList[index - 1]
			local preAnchorX = preRewardItem and preRewardItem:getAnchorPosX() or 0

			if preRewardItem then
				if not preRewardItem.config.needScore then
					local preNeedScore = 0
					local currentAnchorX = rewardItem:getAnchorPosX()

					self.normalLineWidth = preAnchorX + (score - preNeedScore) / (rewardItem.config.needScore - preNeedScore) * (currentAnchorX - preAnchorX)
					anchorIndex = index
					find = true

					break
				end
			end
		end
	end

	if not find then
		self.normalLineWidth = self.contentWidth
		anchorIndex = #self.rewardItemList
	end

	local len = #self.rewardItemList - 4

	self._scrollreward.horizontalNormalizedPosition = (anchorIndex - 4) / len
end

function YaXianRewardView:refreshLineWidthAndArrowAnchor()
	self:calculateNormalWidth()
	recthelper.setWidth(self.grayLineTransform, self.contentWidth)
	recthelper.setWidth(self.normalLineTransform, self.normalLineWidth)
	recthelper.setAnchorX(self.arrowTransform, self.normalLineWidth)
end

function YaXianRewardView:refreshTargetRewardItem()
	local config = self:getTargetRewardConfig()

	if self.targetRewardItem.config and self.targetRewardItem.config.id == config.id then
		return
	end

	self.targetRewardItem:updateByTarget(config)
end

function YaXianRewardView:getTargetRewardConfig()
	local maxAnchorX = recthelper.getAnchorX(self.contentTransform) - self.scrollWidth - YaXianEnum.RewardEnum.HalfRewardItemWidth

	maxAnchorX = -maxAnchorX

	for _, rewardItem in ipairs(self.rewardItemList) do
		if rewardItem:isImportItem() and maxAnchorX <= rewardItem:getAnchorPosX() then
			return rewardItem.config
		end
	end

	for i = #lua_activity115_bonus.configList, 1, -1 do
		local config = lua_activity115_bonus.configList[i]

		if config.important ~= 0 then
			return config
		end
	end
end

function YaXianRewardView:senGetBonusRequest()
	Activity115Rpc.instance:sendAct115BonusRequest()
end

function YaXianRewardView:onClose()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_insight_close)
end

function YaXianRewardView:onDestroyView()
	self._simagebg:UnLoadImage()
	self._simageblackbg:UnLoadImage()
	self._drag:RemoveDragBeginListener()
	self._drag:RemoveDragEndListener()

	self._drag = nil

	self._touch:RemoveClickDownListener()

	self._touch = nil

	for _, rewardItem in ipairs(self.rewardItemList) do
		rewardItem:onDestroy()
	end

	self.targetRewardItem:onDestroy()
	self._scrollreward:RemoveOnValueChanged()

	self.rewardItemList = nil
end

return YaXianRewardView
