-- chunkname: @modules/logic/versionactivity3_9/racingcar/view/reward/V3a9RacingRewardItem.lua

module("modules.logic.versionactivity3_9.racingcar.view.reward.V3a9RacingRewardItem", package.seeall)

local V3a9RacingRewardItem = class("V3a9RacingRewardItem", ListScrollCellExtend)

function V3a9RacingRewardItem:onInitView()
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

function V3a9RacingRewardItem:addEvents()
	return
end

function V3a9RacingRewardItem:removeEvents()
	return
end

function V3a9RacingRewardItem:refresh(data)
	if data then
		self:onUpdateMO(data)
		gohelper.setActive(self.viewGO, true)
	else
		self.data = nil

		gohelper.setActive(self.viewGO, false)
	end
end

function V3a9RacingRewardItem:onUpdateMO(data)
	self.data = data
	self.config = data:getConfig()

	self:refreshReward()
	self:refreshChapter()
end

function V3a9RacingRewardItem:refreshReward()
	local config = self.config
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

	gohelper.setActive(self._gospecial, config.special == 1)
end

function V3a9RacingRewardItem:createRewardItem(index)
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

function V3a9RacingRewardItem:refreshRewardItem(item, data)
	item.data = data

	if not data then
		gohelper.setActive(item.go, false)

		return
	end

	gohelper.setActive(item.go, true)

	local state = MileStoneUtil.getBonusState(self.config.milestoneId, self.config.bonusId)
	local itemCfg, iconPath = ItemModel.instance:getItemConfigAndIcon(data[1], data[2])

	if itemCfg then
		UISpriteSetMgr.instance:setUiFBSprite(item.imagebg, "bg_pinjidi_" .. itemCfg.rare)
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

	gohelper.setActive(item.goalreadygot, state == MileStoneEnum.BonusState.HasGet)

	local canGet = state == MileStoneEnum.BonusState.CanGet

	gohelper.setActive(item.gocanget, canGet)

	local isSp = data[2] == 672801

	gohelper.setActive(item.goSp, isSp)
	gohelper.setActive(item.goNormal, not isSp)

	if state == MileStoneEnum.BonusState.HasGet then
		item.rewardAnim.enabled = true

		item.rewardAnim:Play("dungeoncumulativerewardsitem_receiveenter")
	elseif state == MileStoneEnum.BonusState.CanGet then
		item.rewardAnim.enabled = true

		item.rewardAnim:Play("dungeoncumulativerewardsitem_received")
	else
		item.rewardAnim.enabled = false
		item.imagebg.color = COLOR_REWARD_NORMAL
	end
end

function V3a9RacingRewardItem:onClickItem(item)
	if not self.config then
		return
	end

	local state = MileStoneUtil.getBonusState(self.config.milestoneId, self.config.bonusId)

	if state == MileStoneEnum.BonusState.CanGet then
		MileStoneRpc.instance:sendGetMilestoneBonusRequest(self.config.milestoneId)
	elseif item.data then
		MaterialTipController.instance:showMaterialInfo(item.data[1], item.data[2])
	end
end

function V3a9RacingRewardItem:refreshChapter()
	local state = MileStoneUtil.getBonusState(self.config.milestoneId, self.config.bonusId)
	local isNotFinish = state == MileStoneEnum.BonusState.CanNotGet

	self.txtScore.text = GameUtil.numberDisplay(self.data:getProgress())

	if self._index > 9 then
		self.txtIndex.text = self._index or string.format("0%s", self._index)
	end

	gohelper.setActive(self.goScoreBg, not isNotFinish)
	gohelper.setActive(self.goScoreBgGrey, isNotFinish)
end

function V3a9RacingRewardItem:_editableInitView()
	return
end

function V3a9RacingRewardItem:onDestroyView()
	if self._rewardItems then
		for _, item in pairs(self._rewardItems) do
			item.btn:RemoveClickListener()
		end

		self._rewardItems = nil
	end
end

return V3a9RacingRewardItem
