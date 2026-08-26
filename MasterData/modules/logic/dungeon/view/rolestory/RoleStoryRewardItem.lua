-- chunkname: @modules/logic/dungeon/view/rolestory/RoleStoryRewardItem.lua

module("modules.logic.dungeon.view.rolestory.RoleStoryRewardItem", package.seeall)

local RoleStoryRewardItem = class("RoleStoryRewardItem", ListScrollCellExtend)

function RoleStoryRewardItem:onInitView()
	self._rectTransform = self.viewGO.transform
	self._gospecial = gohelper.findChild(self.viewGO, "#go_special")
	self.txtScore = gohelper.findChildTextMesh(self.viewGO, "scorebg/#txt_score")
	self.normalbg = gohelper.findChild(self.viewGO, "scorebg/normalbg")
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

function RoleStoryRewardItem:addEvents()
	return
end

function RoleStoryRewardItem:removeEvents()
	return
end

function RoleStoryRewardItem:refresh(data)
	if data then
		self:onUpdateMO(data)
		gohelper.setActive(self.viewGO, true)
	else
		self.data = nil

		gohelper.setActive(self.viewGO, false)
	end
end

function RoleStoryRewardItem:onUpdateMO(data)
	self.data = data

	self:refreshReward(data)
	self:refreshChapter(data)
end

function RoleStoryRewardItem:refreshReward(data)
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

function RoleStoryRewardItem:createRewardItem(index)
	local item = self:getUserDataTb_()
	local itemGo = gohelper.clone(self._goRewardTemplate, self._goRewardParent, "reward_" .. tostring(index))

	item.go = itemGo
	item.imagebg = gohelper.findChildImage(itemGo, "bg")
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

function RoleStoryRewardItem:refreshRewardItem(item, data)
	item.data = data

	if not data then
		gohelper.setActive(item.go, false)

		return
	end

	gohelper.setActive(item.go, true)

	local config = self.data.config
	local state = RoleStoryModel.instance:getRewardState(config.storyId, config.id, config.score)
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

function RoleStoryRewardItem:onClickItem(item)
	if not self.data then
		return
	end

	local config = self.data.config
	local state = RoleStoryModel.instance:getRewardState(config.storyId, config.id, config.score)

	if state == 1 then
		local list = {}
		local rewardList = RoleStoryConfig.instance:getRewardList(config.storyId)

		if rewardList then
			for i, v in ipairs(rewardList) do
				if RoleStoryModel.instance:getRewardState(v.storyId, v.id, v.score) == 1 then
					table.insert(list, v.id)
				end
			end
		end

		if #list > 0 then
			HeroStoryRpc.instance:sendGetScoreBonusRequest(list)
		end
	elseif item.data then
		MaterialTipController.instance:showMaterialInfo(item.data[1], item.data[2])
	end
end

local finishIndexTxtColor = "#DB7D29"
local unfinishIndexTxtColor = "#FFFFFF"
local unfinishIndexTxtColorAlpha = 0.86
local finishIndexTxtColorAlpha = 0.86
local finishScroreTxtColor = "#DB7D29"
local unfinishScoreTxtColor = "#8E8E8E"

function RoleStoryRewardItem:refreshChapter(data)
	local config = self.data.config
	local state = RoleStoryModel.instance:getRewardState(config.storyId, config.id, config.score)
	local isKeyReward = config.keyReward == 1
	local pointIconName = "v1a6_cachot_icon_pointdark"
	local indexTxtColor = unfinishIndexTxtColor
	local indexTxtAlpha = unfinishIndexTxtColorAlpha
	local scoreTxtColor = unfinishScoreTxtColor

	if state == 0 then
		pointIconName = isKeyReward and "v1a6_cachot_icon_pointdark2" or "v1a6_cachot_icon_pointdark"
	else
		pointIconName = isKeyReward and "v1a6_cachot_icon_pointlight2" or "v1a6_cachot_icon_pointlight"
		indexTxtColor = finishIndexTxtColor
		indexTxtAlpha = finishIndexTxtColorAlpha
		scoreTxtColor = finishScroreTxtColor
	end

	UISpriteSetMgr.instance:setV1a6CachotSprite(self._imagepoint, pointIconName)

	self.txtScore.text = string.format("<color=%s>%s</color>", scoreTxtColor, config.score)
	self.txtIndex.text = string.format("<color=%s>%02d</color>", scoreTxtColor, self.data.index)

	ZProj.UGUIHelper.SetColorAlpha(self.txtIndex, indexTxtAlpha)
	gohelper.setActive(self._gospecial, isKeyReward and not self.data.isTarget)
	gohelper.setActive(self.normalbg, isKeyReward and self.data.isTarget)
end

function RoleStoryRewardItem:_editableInitView()
	return
end

function RoleStoryRewardItem:onDestroyView()
	if self._rewardItems then
		for _, item in pairs(self._rewardItems) do
			item.btn:RemoveClickListener()
			item.simagereward:UnLoadImage()
		end

		self._rewardItems = nil
	end
end

return RoleStoryRewardItem
