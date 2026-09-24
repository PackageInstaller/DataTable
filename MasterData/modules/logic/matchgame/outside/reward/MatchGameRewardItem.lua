-- chunkname: @modules/logic/matchgame/outside/reward/MatchGameRewardItem.lua

module("modules.logic.matchgame.outside.reward.MatchGameRewardItem", package.seeall)

local MatchGameRewardItem = class("MatchGameRewardItem", ListScrollCellExtend)

function MatchGameRewardItem:onInitView()
	self._rectTransform = self.viewGO.transform
	self._gospecial = gohelper.findChild(self.viewGO, "#go_special")
	self._goLightScore = gohelper.findChild(self.viewGO, "#go_lightscore")
	self._txtScore1 = gohelper.findChildText(self.viewGO, "#go_lightscore/#txt_score1")
	self._txtIndex1 = gohelper.findChildText(self.viewGO, "#go_lightscore/#txt_index1")
	self._goDarkScore = gohelper.findChild(self.viewGO, "#go_darkscore")
	self._txtScore2 = gohelper.findChildText(self.viewGO, "#go_darkscore/#txt_score2")
	self._txtIndex2 = gohelper.findChildText(self.viewGO, "#go_darkscore/#txt_index2")
	self._goRewardParent = gohelper.findChild(self.viewGO, "#go_item")
	self._rectRewardParent = self._goRewardParent.transform
	self._goRewardTemplate = gohelper.findChild(self.viewGO, "#go_item/#go_rewarditem")

	gohelper.setActive(self._goRewardTemplate, false)

	if self._editableInitView then
		self:_editableInitView()
	end
end

function MatchGameRewardItem:addEvents()
	return
end

function MatchGameRewardItem:removeEvents()
	return
end

function MatchGameRewardItem:refresh(data)
	if data then
		self:onUpdateMO(data)
		gohelper.setActive(self.viewGO, true)
	else
		self.config = nil

		gohelper.setActive(self.viewGO, false)
	end
end

function MatchGameRewardItem:onUpdateMO(rewardCo)
	self.config = rewardCo
	self.score = self.config.score or self.config.star
	self.rewardType = MatchGameEnum.RewardType.Normal
	self.status = MatchGameModel.instance:getRewardStatus(self.rewardType, self.config)

	self:refreshReward()
	self:refreshChapter()
end

function MatchGameRewardItem:refreshReward()
	local config = self.config
	local rewardList = DungeonConfig.instance:getRewardItems(tonumber(config.rewardId))

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

function MatchGameRewardItem:createRewardItem(index)
	local item = self:getUserDataTb_()
	local itemGo = gohelper.clone(self._goRewardTemplate, self._goRewardParent, "reward_" .. tostring(index))

	item.go = itemGo
	item.imagebg = gohelper.findChildImage(itemGo, "bg")
	item.txtrewardcount = gohelper.findChildText(itemGo, "txt_rewardcount")
	item.goalreadygot = gohelper.findChild(itemGo, "go_hasget")
	item.gocanget = gohelper.findChild(itemGo, "go_canget")
	item.btn = gohelper.findChildButtonWithAudio(itemGo, "btn_click")

	item.btn:AddClickListener(self.onClickItem, self, item)

	item.rewardAnim = item.go:GetComponent(typeof(UnityEngine.Animator))
	item.goSp = gohelper.findChild(itemGo, "reward_sp")
	item.goNormal = gohelper.findChild(itemGo, "goreward")

	return item
end

local COLOR_REWARD_NORMAL = Color.New(1, 1, 1, 1)

function MatchGameRewardItem:refreshRewardItem(item, data)
	item.data = data

	if not data then
		gohelper.setActive(item.go, false)

		return
	end

	gohelper.setActive(item.go, true)

	local itemCfg, iconPath = ItemModel.instance:getItemConfigAndIcon(data[1], data[2])

	if itemCfg then
		UISpriteSetMgr.instance:setMatchGameSprite(item.imagebg, string.format("matchgame_rewarditem_%s", itemCfg.rare), true)
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

	item.txtrewardcount.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("multi_num"), GameUtil.numberDisplay(data[3]))

	gohelper.setActive(item.goalreadygot, self.status == MatchGameEnum.RewardItemStatus.Gained)

	local canGet = self.status == MatchGameEnum.RewardItemStatus.CanGet

	gohelper.setActive(item.gocanget, canGet)

	local isSp = data[2] == 672801

	gohelper.setActive(item.goSp, isSp)
	gohelper.setActive(item.goNormal, not isSp)

	if self.status == MatchGameEnum.RewardItemStatus.Gained then
		item.rewardAnim.enabled = true

		item.rewardAnim:Play("dungeoncumulativerewardsitem_receiveenter")
	elseif self.status == MatchGameEnum.RewardItemStatus.CanGet then
		item.rewardAnim.enabled = true

		item.rewardAnim:Play("dungeoncumulativerewardsitem_received")
	else
		item.rewardAnim.enabled = false
		item.imagebg.color = COLOR_REWARD_NORMAL
	end
end

function MatchGameRewardItem:onClickItem(item)
	if not self.config then
		return
	end

	if self.status == MatchGameEnum.RewardItemStatus.CanGet then
		MatchGameRpc.instance:sendAct244ReceiveStarBonusRequest(self.config.activityId)
	elseif item.data then
		MaterialTipController.instance:showMaterialInfo(item.data[1], item.data[2])
	end
end

function MatchGameRewardItem:refreshChapter()
	local isNotFinish = self.status == MatchGameEnum.RewardItemStatus.Normal
	local scoreStr = GameUtil.numberDisplay(self.score)

	self._txtScore1.text = scoreStr
	self._txtScore2.text = scoreStr

	local indexStr = string.format("%02d", self._index)

	self._txtIndex1.text = indexStr
	self._txtIndex2.text = indexStr

	gohelper.setActive(self._goLightScore, not isNotFinish)
	gohelper.setActive(self._goDarkScore, isNotFinish)
end

function MatchGameRewardItem:_editableInitView()
	return
end

function MatchGameRewardItem:onDestroyView()
	if self._rewardItems then
		for _, item in pairs(self._rewardItems) do
			item.btn:RemoveClickListener()
		end

		self._rewardItems = nil
	end
end

return MatchGameRewardItem
