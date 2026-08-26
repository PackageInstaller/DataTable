-- chunkname: @modules/logic/versionactivity3_3/arcade/view/reward/ArcadeRewardItem.lua

module("modules.logic.versionactivity3_3.arcade.view.reward.ArcadeRewardItem", package.seeall)

local ArcadeRewardItem = class("ArcadeRewardItem", ListScrollCellExtend)

function ArcadeRewardItem:onInitView()
	self._rectTransform = self.viewGO.transform
	self._gospecial = gohelper.findChild(self.viewGO, "#go_special")
	self.txtScore = gohelper.findChildTextMesh(self.viewGO, "#txt_score")
	self.goScoreBg = gohelper.findChild(self.viewGO, "indexBg/light")
	self.goScoreBgGrey = gohelper.findChild(self.viewGO, "indexBg/dark")
	self.txtIndex = gohelper.findChildTextMesh(self.viewGO, "#txt_index")
	self._goRewardParent = gohelper.findChild(self.viewGO, "#go_item")
	self._rectRewardParent = self._goRewardParent.transform
	self._goRewardTemplate = gohelper.findChild(self.viewGO, "#go_item/#go_rewarditem")

	gohelper.setActive(self._goRewardTemplate, false)

	if self._editableInitView then
		self:_editableInitView()
	end
end

function ArcadeRewardItem:addEvents()
	return
end

function ArcadeRewardItem:removeEvents()
	return
end

function ArcadeRewardItem:refresh(data)
	if data then
		self:onUpdateMO(data)
		gohelper.setActive(self.viewGO, true)
	else
		self.data = nil

		gohelper.setActive(self.viewGO, false)
	end
end

function ArcadeRewardItem:onUpdateMO(data)
	self.data = data
	self.config = data.co

	self:refreshReward()
	self:refreshChapter()
end

function ArcadeRewardItem:refreshReward()
	local config = self.config
	local rewardList = DungeonConfig.instance:getRewardItems(tonumber(config.reward))

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

	gohelper.setActive(self._gospecial, config.special == 1)
end

function ArcadeRewardItem:createRewardItem(index)
	local item = self:getUserDataTb_()
	local itemGo = gohelper.clone(self._goRewardTemplate, self._goRewardParent, "reward_" .. tostring(index))

	item.go = itemGo
	item.imagebg = gohelper.findChildImage(itemGo, "bg")
	item.txtrewardcount = gohelper.findChildText(itemGo, "txt_rewardcount")
	item.goalreadygot = gohelper.findChild(itemGo, "go_hasget")
	item.gocanget = gohelper.findChild(itemGo, "go_canget")
	item.btn = gohelper.findChildButtonWithAudio(itemGo, "btn_click", AudioEnum3_3.Arcade.play_ui_yuanzheng_click)

	item.btn:AddClickListener(self.onClickItem, self, item)

	item.rewardAnim = item.go:GetComponent(typeof(UnityEngine.Animator))
	item.goSp = gohelper.findChild(itemGo, "reward_sp")
	item.goNormal = gohelper.findChild(itemGo, "goreward")

	return item
end

local COLOR_REWARD_NORMAL = Color.New(1, 1, 1, 1)

function ArcadeRewardItem:refreshRewardItem(item, data)
	item.data = data

	if not data then
		gohelper.setActive(item.go, false)

		return
	end

	gohelper.setActive(item.go, true)

	local state = self.data:getRewardState()
	local itemCfg, iconPath = ItemModel.instance:getItemConfigAndIcon(data[1], data[2])

	if itemCfg then
		UISpriteSetMgr.instance:setV3a3EliminateSprite(item.imagebg, "v3a3_eliminate_reward_quality_" .. itemCfg.rare)
	end

	item.itemIcon = item.itemIcon or IconMgr.instance:getCommonPropItemIcon(item.goNormal)

	item.itemIcon:setMOValue(data[1], data[2], data[3], nil, true)

	if data[1] == MaterialEnum.MaterialType.Equip then
		item.itemIcon._equipIcon._overrideLoadIconFunc(item.itemIcon._equipIcon, EquipHelper.getEquipDefaultIconLoadPath, item.itemIcon._equipIcon)
		item.itemIcon._equipIcon:_loadIconImage()
		gohelper.setActive(item.itemIcon._equipIcon._gonum, false)
	end

	item.itemIcon:isShowQuality(false)
	item.itemIcon:isShowCount(false)
	item.itemIcon:hideEquipLvAndBreak(true)

	item.txtrewardcount.text = string.format("<size=25>x</size>%s", tostring(data[3]))

	gohelper.setActive(item.goalreadygot, state == ArcadeEnum.RewardItemStatus.Gained)

	local canGet = state == ArcadeEnum.RewardItemStatus.CanGet

	gohelper.setActive(item.gocanget, canGet)

	local isSp = data[2] == 672801

	gohelper.setActive(item.goSp, isSp)
	gohelper.setActive(item.goNormal, not isSp)

	if state == ArcadeEnum.RewardItemStatus.Gained then
		item.rewardAnim.enabled = true

		item.rewardAnim:Play("dungeoncumulativerewardsitem_receiveenter")
	elseif state == ArcadeEnum.RewardItemStatus.CanGet then
		item.rewardAnim.enabled = true

		item.rewardAnim:Play("dungeoncumulativerewardsitem_received")
	else
		item.rewardAnim.enabled = false
		item.imagebg.color = COLOR_REWARD_NORMAL
	end
end

function ArcadeRewardItem:onClickItem(item)
	if not self.config then
		return
	end

	local state = self.data:getRewardState()

	if state == ArcadeEnum.RewardItemStatus.CanGet then
		ArcadeOutSideRpc.instance:sendArcadeGainRewardRequest(0)
	elseif item.data then
		MaterialTipController.instance:showMaterialInfo(item.data[1], item.data[2])
	end
end

function ArcadeRewardItem:refreshChapter()
	local state = self.data:getRewardState()
	local isNotFinish = state == ArcadeEnum.RewardItemStatus.Normal

	self.txtScore.text = GameUtil.numberDisplay(self.data:getScore())

	if self._index > 9 then
		self.txtIndex.text = self._index or string.format("0%s", self._index)
	end

	gohelper.setActive(self.goScoreBg, not isNotFinish)
	gohelper.setActive(self.goScoreBgGrey, isNotFinish)
end

function ArcadeRewardItem:_editableInitView()
	return
end

function ArcadeRewardItem:onDestroyView()
	if self._rewardItems then
		for _, item in pairs(self._rewardItems) do
			item.btn:RemoveClickListener()
		end

		self._rewardItems = nil
	end
end

return ArcadeRewardItem
