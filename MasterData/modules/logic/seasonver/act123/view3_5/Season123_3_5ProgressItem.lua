-- chunkname: @modules/logic/seasonver/act123/view3_5/Season123_3_5ProgressItem.lua

module("modules.logic.seasonver.act123.view3_5.Season123_3_5ProgressItem", package.seeall)

local Season123_3_5ProgressItem = class("Season123_3_5ProgressItem", ListScrollCellExtend)

function Season123_3_5ProgressItem:onInitView()
	self._rectTransform = self.viewGO.transform
	self._goRewardParent = gohelper.findChild(self.viewGO, "#go_item")
	self._rectRewardParent = self._goRewardParent.transform
	self._goRewardTemplate = gohelper.findChild(self.viewGO, "#go_item/#go_rewarditem")

	gohelper.setActive(self._goRewardTemplate, false)

	self.goHasget = gohelper.findChild(self.viewGO, "score/hasget")
	self.goUnget = gohelper.findChild(self.viewGO, "score/unget")
	self.txtHasgetScore = gohelper.findChildTextMesh(self.viewGO, "score/hasget/#txt_score")
	self.txtUngetScore = gohelper.findChildTextMesh(self.viewGO, "score/unget/#txt_score")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Season123_3_5ProgressItem:addEvents()
	return
end

function Season123_3_5ProgressItem:removeEvents()
	return
end

function Season123_3_5ProgressItem:refresh(data)
	if data then
		self:onUpdateMO(data)
		gohelper.setActive(self.viewGO, true)
	else
		self.data = nil

		gohelper.setActive(self.viewGO, false)
	end
end

function Season123_3_5ProgressItem:onUpdateMO(data)
	self.data = data

	self:refreshReward(data)
	self:refreshChapter(data)
end

function Season123_3_5ProgressItem:refreshReward(data)
	local config = data.config
	local rewardList = GameUtil.splitString2(config.bonus, true) or {}

	self._rewardItems = self._rewardItems or {}

	for i = 1, math.max(#self._rewardItems, #rewardList) do
		local reward = rewardList[i]
		local item = self._rewardItems[i]

		if not item then
			item = self:createRewardItem(i)
			self._rewardItems[i] = item
		end

		self:refreshRewardItem(item, reward)
	end
end

function Season123_3_5ProgressItem:createRewardItem(index)
	local item = self:getUserDataTb_()
	local itemGo = gohelper.clone(self._goRewardTemplate, self._goRewardParent, "reward_" .. tostring(index))

	item.go = itemGo
	item.imagebg = gohelper.findChildImage(itemGo, "rare")
	item.simagereward = gohelper.findChildSingleImage(itemGo, "simage_reward")
	item.imagereward = gohelper.findChildImage(itemGo, "simage_reward")
	item.txtrewardcount = gohelper.findChildText(itemGo, "txt_rewardcount")
	item.goalreadygot = gohelper.findChild(itemGo, "go_hasget")
	item.gocanget = gohelper.findChild(itemGo, "go_canget")
	item.btn = gohelper.findChildButtonWithAudio(itemGo, "btn_click")

	item.btn:AddClickListener(self.onClickItem, self, item)

	item.rewardAnim = item.go:GetComponent(typeof(UnityEngine.Animator))

	function item.onLoadImageCallback(itemObj)
		itemObj.imagereward:SetNativeSize()
	end

	return item
end

local COLOR_REWARD_NORMAL = Color.New(1, 1, 1, 1)

function Season123_3_5ProgressItem:refreshRewardItem(item, data)
	item.data = data

	if not data then
		gohelper.setActive(item.go, false)

		return
	end

	gohelper.setActive(item.go, true)

	local itemCfg, iconPath = ItemModel.instance:getItemConfigAndIcon(data[1], data[2])

	if itemCfg then
		UISpriteSetMgr.instance:setUiFBSprite(item.imagebg, "bg_pinjidi_" .. itemCfg.rare)
	end

	if data[1] == MaterialEnum.MaterialType.Equip then
		iconPath = ResUrl.getHeroDefaultEquipIcon(itemCfg.icon)
	end

	if iconPath then
		item.simagereward:LoadImage(iconPath, item.onLoadImageCallback, item)
	end

	item.txtrewardcount.text = string.format("<size=25>x</size>%s", tostring(data[3]))

	local state = self.data.state

	gohelper.setActive(item.goalreadygot, state == 2)
	gohelper.setActive(item.gocanget, state == 1)

	if state == 2 then
		item.rewardAnim.enabled = true

		item.rewardAnim:Play("dungeoncumulativerewardsitem_receiveenter")
	elseif state == 1 then
		item.rewardAnim.enabled = true

		item.rewardAnim:Play("dungeoncumulativerewardsitem_received")
	else
		item.rewardAnim.enabled = false
		item.imagereward.color = COLOR_REWARD_NORMAL
		item.imagebg.color = COLOR_REWARD_NORMAL
	end
end

function Season123_3_5ProgressItem:onClickItem(item)
	if not self.data then
		return
	end

	local config = self.data.config
	local state = self.data.state

	if state == 1 then
		AudioMgr.instance:trigger(AudioEnum.Season123.play_fight_ui_uttu_award)
		Activity123Rpc.instance:sendAct123ReceiveStageBonusRequest(config.activityId, config.stageId)
	elseif item.data then
		MaterialTipController.instance:showMaterialInfo(item.data[1], item.data[2])
	end
end

function Season123_3_5ProgressItem:refreshChapter(data)
	local config = self.data.config
	local state = self.data.state

	gohelper.setActive(self.goHasget, state == 2)
	gohelper.setActive(self.goUnget, state ~= 2)

	self.txtHasgetScore.text = tostring(config.star)
	self.txtUngetScore.text = tostring(config.star)
end

function Season123_3_5ProgressItem:_editableInitView()
	return
end

function Season123_3_5ProgressItem:onDestroyView()
	if self._rewardItems then
		for _, item in pairs(self._rewardItems) do
			item.btn:RemoveClickListener()
			item.simagereward:UnLoadImage()
		end

		self._rewardItems = nil
	end
end

return Season123_3_5ProgressItem
