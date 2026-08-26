-- chunkname: @modules/logic/survival/view/shelter/SurvivalShelterRewardItem.lua

module("modules.logic.survival.view.shelter.SurvivalShelterRewardItem", package.seeall)

local SurvivalShelterRewardItem = class("SurvivalShelterRewardItem", ListScrollCellExtend)

function SurvivalShelterRewardItem:onInitView()
	self._rectTransform = self.viewGO.transform
	self._gospecial = gohelper.findChild(self.viewGO, "#go_special")
	self.txtScore = gohelper.findChildTextMesh(self.viewGO, "#txt_score")
	self.goScoreBg = gohelper.findChild(self.viewGO, "#go_special/scorebg")
	self.goScoreBgGrey = gohelper.findChild(self.viewGO, "#go_special/scorebg_grey")
	self.txtIndex = gohelper.findChildTextMesh(self.viewGO, "#txt_index")
	self._imagepoint = gohelper.findChildImage(self.viewGO, "#image_point")
	self._goRewardParent = gohelper.findChild(self.viewGO, "#go_item")
	self._rectRewardParent = self._goRewardParent.transform
	self._goRewardTemplate = gohelper.findChild(self.viewGO, "#go_item/#go_rewarditem")

	gohelper.setActive(self._goRewardTemplate, false)

	if self._editableInitView then
		self:_editableInitView()
	end
end

function SurvivalShelterRewardItem:addEvents()
	return
end

function SurvivalShelterRewardItem:removeEvents()
	return
end

function SurvivalShelterRewardItem:refresh(data)
	if data then
		self:onUpdateMO(data)
		gohelper.setActive(self.viewGO, true)
	else
		self.data = nil

		gohelper.setActive(self.viewGO, false)
	end
end

function SurvivalShelterRewardItem:onUpdateMO(data)
	self.data = data
	self.config = data

	self:refreshReward()
	self:refreshChapter()
end

function SurvivalShelterRewardItem:refreshReward()
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
end

function SurvivalShelterRewardItem:createRewardItem(index)
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

function SurvivalShelterRewardItem:refreshRewardItem(item, data)
	item.data = data

	if not data then
		gohelper.setActive(item.go, false)

		return
	end

	gohelper.setActive(item.go, true)

	local config = self.config
	local state = SurvivalModel.instance:getRewardState(config.id, config.score)
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

	gohelper.setActive(item.goalreadygot, state == 2)

	local canGet = state == 1

	gohelper.setActive(item.gocanget, canGet)

	local isSp = data[2] == 672801

	gohelper.setActive(item.goSp, isSp)
	gohelper.setActive(item.goNormal, not isSp)

	if state == 2 then
		item.rewardAnim.enabled = true

		item.rewardAnim:Play("dungeoncumulativerewardsitem_receiveenter")
	elseif state == 1 then
		item.rewardAnim.enabled = true

		item.rewardAnim:Play("dungeoncumulativerewardsitem_received")
	else
		item.rewardAnim.enabled = false
		item.imagebg.color = COLOR_REWARD_NORMAL
	end
end

function SurvivalShelterRewardItem:onClickItem(item)
	if not self.config then
		return
	end

	local config = self.config
	local state = SurvivalModel.instance:getRewardState(config.id, config.score)

	if state == 1 then
		SurvivalOutSideRpc.instance:sendSurvivalOutSideGainReward(0)
	elseif item.data then
		MaterialTipController.instance:showMaterialInfo(item.data[1], item.data[2])
	end
end

local finishIndexTxtColor = "#8C1603"
local unfinishIndexTxtColor = "#000000"
local finishScroreTxtColor = "#994C3D"
local unfinishScoreTxtColor = "#333333"

function SurvivalShelterRewardItem:refreshChapter()
	local config = self.config
	local state = SurvivalModel.instance:getRewardState(config.id, config.score)
	local isKeyReward = config.special == 1
	local pointIconName = "survival_shelter_reward_point2_0"
	local indexTxtColor = unfinishIndexTxtColor
	local scoreTxtColor = unfinishScoreTxtColor
	local isNotFinish = state == 0

	if isNotFinish then
		pointIconName = isKeyReward and "survival_shelter_reward_point1_0" or "survival_shelter_reward_point2_0"
	else
		pointIconName = isKeyReward and "survival_shelter_reward_point1_1" or "survival_shelter_reward_point2_1"
		indexTxtColor = finishIndexTxtColor
		scoreTxtColor = finishScroreTxtColor
	end

	UISpriteSetMgr.instance:setSurvivalSprite(self._imagepoint, pointIconName)

	self.txtScore.text = string.format("<color=%s>%s</color>", scoreTxtColor, config.score)
	self.txtIndex.text = string.format("<color=%s>%02d</color>", scoreTxtColor, self._index)

	gohelper.setActive(self._gospecial, isKeyReward)

	if isKeyReward then
		gohelper.setActive(self.goScoreBg, not isNotFinish)
		gohelper.setActive(self.goScoreBgGrey, isNotFinish)
	end
end

function SurvivalShelterRewardItem:_editableInitView()
	return
end

function SurvivalShelterRewardItem:onDestroyView()
	if self._rewardItems then
		for _, item in pairs(self._rewardItems) do
			item.btn:RemoveClickListener()
		end

		self._rewardItems = nil
	end
end

return SurvivalShelterRewardItem
