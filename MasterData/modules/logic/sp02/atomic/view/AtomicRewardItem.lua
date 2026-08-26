-- chunkname: @modules/logic/sp02/atomic/view/AtomicRewardItem.lua

module("modules.logic.sp02.atomic.view.AtomicRewardItem", package.seeall)

local AtomicRewardItem = class("AtomicRewardItem", ListScrollCellExtend)

function AtomicRewardItem:onInitView()
	self._rectTransform = self.viewGO.transform
	self._gospecial = gohelper.findChild(self.viewGO, "#go_special")
	self.txtScore = gohelper.findChildTextMesh(self.viewGO, "#txt_score")
	self.goScoreBg = gohelper.findChild(self.viewGO, "#go_special/scorebg")
	self.goScoreBgGrey = gohelper.findChild(self.viewGO, "#go_special/scorebg_grey")
	self._goPoint = gohelper.findChild(self.viewGO, "#image_point")
	self._goPointFinish = gohelper.findChild(self.viewGO, "#image_point_finish")
	self._goRewardParent = gohelper.findChild(self.viewGO, "#go_item")
	self._rectRewardParent = self._goRewardParent.transform
	self._goRewardTemplate = gohelper.findChild(self.viewGO, "#go_item/#go_rewarditem")
	self.imgStar = gohelper.findChildImage(self.viewGO, "#txt_score/staricon")

	gohelper.setActive(self._goRewardTemplate, false)

	if self._editableInitView then
		self:_editableInitView()
	end
end

function AtomicRewardItem:addEvents()
	return
end

function AtomicRewardItem:removeEvents()
	return
end

function AtomicRewardItem:refresh(data)
	if data then
		self:onUpdateMO(data)
		gohelper.setActive(self.viewGO, true)
	else
		self.data = nil

		gohelper.setActive(self.viewGO, false)
	end
end

function AtomicRewardItem:onUpdateMO(data)
	self.data = data
	self.config = data:getConfig()

	self:refreshReward()
	self:refreshChapter()
end

function AtomicRewardItem:refreshReward()
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
end

function AtomicRewardItem:createRewardItem(index)
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

function AtomicRewardItem:refreshRewardItem(item, data)
	item.data = data

	if not data then
		gohelper.setActive(item.go, false)

		return
	end

	gohelper.setActive(item.go, true)

	local config = self.config
	local state = MileStoneUtil.getBonusState(config.milestoneId, config.bonusId)
	local itemCfg, iconPath = ItemModel.instance:getItemConfigAndIcon(data[1], data[2])

	if itemCfg then
		UISpriteSetMgr.instance:setSurvivalSprite(item.imagebg, "survival_shelter_reward_quality_" .. itemCfg.rare)
	end

	item.itemIcon = item.itemIcon or IconMgr.instance:getCommonPropItemIcon(item.goNormal)

	item.itemIcon:setMOValue(data[1], data[2], data[3], nil, true)

	if data[1] == MaterialEnum.MaterialType.Equip then
		item.itemIcon._equipIcon._overrideLoadIconFunc(item.itemIcon._equipIcon, EquipHelper.getEquipDefaultIconLoadPath, item.itemIcon._equipIcon)
		item.itemIcon._equipIcon:_loadIconImage()
	end

	item.itemIcon:isShowQuality(false)
	item.itemIcon:isShowCount(false)
	item.itemIcon:hideEquipLvAndBreak(true)

	item.txtrewardcount.text = string.format("<size=25>x</size>%s", tostring(data[3]))

	local hasGet = state == MileStoneEnum.BonusState.HasGet
	local canGet = state == MileStoneEnum.BonusState.CanGet

	gohelper.setActive(item.goalreadygot, hasGet)
	gohelper.setActive(item.gocanget, canGet)

	local isSp = data[2] == 672801

	gohelper.setActive(item.goSp, isSp)
	gohelper.setActive(item.goNormal, not isSp)

	if canGet then
		item.rewardAnim.enabled = true

		item.rewardAnim:Play("dungeoncumulativerewardsitem_receiveenter")
	elseif hasGet then
		item.rewardAnim.enabled = true

		item.rewardAnim:Play("dungeoncumulativerewardsitem_received")
	else
		item.rewardAnim.enabled = false
		item.imagebg.color = COLOR_REWARD_NORMAL
	end
end

function AtomicRewardItem:onClickItem(item)
	if not self.config then
		return
	end

	local config = self.config

	if MileStoneUtil.isBonusCanGet(config.milestoneId, config.bonusId) then
		MileStoneRpc.instance:sendGetMilestoneBonusRequest(config.milestoneId)
	elseif item.data then
		MaterialTipController.instance:showMaterialInfo(item.data[1], item.data[2])
	end
end

local finishScroreTxtColor = "#FFFFFF"
local unfinishScoreTxtColor = "#979fa8"

function AtomicRewardItem:refreshChapter()
	local config = self.config
	local state = MileStoneUtil.getBonusState(config.milestoneId, config.bonusId)
	local isKeyReward = config.special
	local scoreTxtColor = unfinishScoreTxtColor
	local isNotFinish = state == MileStoneEnum.BonusState.CanNotGet

	if not isNotFinish then
		scoreTxtColor = finishScroreTxtColor
	end

	gohelper.setActive(self._goPoint, isNotFinish)
	gohelper.setActive(self._goPointFinish, not isNotFinish)

	self.txtScore.text = string.format("<color=%s>%s</color>", scoreTxtColor, config.needProgress)

	gohelper.setActive(self._gospecial, isKeyReward)

	if isKeyReward then
		gohelper.setActive(self.goScoreBg, not isNotFinish)
		gohelper.setActive(self.goScoreBgGrey, isNotFinish)
	end

	ZProj.UGUIHelper.SetColorAlpha(self.imgStar, isNotFinish and 0.5 or 1)
end

function AtomicRewardItem:_editableInitView()
	return
end

function AtomicRewardItem:onDestroyView()
	if self._rewardItems then
		for _, item in pairs(self._rewardItems) do
			item.btn:RemoveClickListener()
		end

		self._rewardItems = nil
	end
end

return AtomicRewardItem
