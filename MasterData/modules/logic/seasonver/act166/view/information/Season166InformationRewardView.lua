-- chunkname: @modules/logic/seasonver/act166/view/information/Season166InformationRewardView.lua

module("modules.logic.seasonver.act166.view.information.Season166InformationRewardView", package.seeall)

local Season166InformationRewardView = class("Season166InformationRewardView", BaseView)

function Season166InformationRewardView:onInitView()
	self.txtTitle = gohelper.findChildTextMesh(self.viewGO, "Left/SmallTitle/txt_SmallTitle")
	self.rewardItems = {}
	self.goReward = gohelper.findChild(self.viewGO, "Bottom/SliderPoint/#go_rewards")

	gohelper.setActive(self.goReward, false)

	self.slider = gohelper.findChildSlider(self.viewGO, "Bottom/Slider")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Season166InformationRewardView:addEvents()
	self.addEventCb(self, Season166Controller.instance, Season166Event.OnInformationUpdate, self.onInformationUpdate, self)
	self.addEventCb(self, Season166Controller.instance, Season166Event.OnGetInformationBonus, self.onGetInformationBonus, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseViewFinish, self.onCloseViewFinish, self)
end

function Season166InformationRewardView:removeEvents()
	return
end

function Season166InformationRewardView:_editableInitView()
	return
end

function Season166InformationRewardView:onUpdateParam()
	return
end

function Season166InformationRewardView:onInformationUpdate()
	self:refreshUI()
end

function Season166InformationRewardView:onGetInformationBonus()
	return
end

function Season166InformationRewardView:onCloseViewFinish(viewName)
	if viewName == ViewName.CommonPropView or viewName == ViewName.CharacterSkinGainView then
		self:refreshReward()
	end
end

function Season166InformationRewardView:onOpen()
	self.actId = self.viewParam.actId

	self:refreshUI()
end

function Season166InformationRewardView:refreshUI()
	if not self.actId then
		return
	end

	local actInfo = Season166Model.instance:getActInfo(self.actId)
	local hasGetBonusCount, bonusCount = actInfo:getBonusNum()
	local tag = {
		hasGetBonusCount,
		bonusCount
	}

	self.txtTitle.text = GameUtil.getSubPlaceholderLuaLang(luaLang("season166_infoanalyze_rewardview_txt"), tag)
	self.infoAnalyCount = actInfo:getInfoAnalyCount()

	self:refreshReward()
end

function Season166InformationRewardView:refreshReward()
	if ViewMgr.instance:isOpen(ViewName.CommonPropView) or ViewMgr.instance:isOpen(ViewName.CharacterSkinGainView) then
		return
	end

	local list = Season166Config.instance:getSeasonInfoBonuss(self.actId) or {}

	for i = 1, math.max(#list, #self.rewardItems) do
		local item = self.rewardItems[i]

		item = item or self:createRewardItem(i)

		self:refreshRewardItem(item, list[i])
	end

	local count = #list
	local curCount = self.infoAnalyCount
	local value = Mathf.Clamp01((curCount - 1) / (count - 1))

	self.slider:SetValue(value)
end

function Season166InformationRewardView:onGetReward(item)
	if not item.config then
		return
	end

	local config = item.config
	local actInfo = Season166Model.instance:getActInfo(config.activityId)
	local hasGet = actInfo:isBonusGet(config.analyCount)

	if hasGet then
		self:showInfo(config)

		return
	end

	if self.infoAnalyCount >= config.analyCount then
		Activity166Rpc.instance:sendAct166ReceiveInformationBonusRequest(self.actId)
	else
		self:showInfo(config)
	end
end

function Season166InformationRewardView:showInfo(config)
	local bounds = GameUtil.splitString2(config.bonus, true)
	local rewardCfg = bounds[1]

	MaterialTipController.instance:showMaterialInfo(rewardCfg[1], rewardCfg[2], nil, nil, true)
end

function Season166InformationRewardView:createRewardItem(index)
	local item = self:getUserDataTb_()

	item.go = gohelper.cloneInPlace(self.goReward, string.format("reward%s", index))
	item.goStatus0 = gohelper.findChild(item.go, "image_status0")
	item.goStatus = gohelper.findChild(item.go, "#image_status")
	item.goReward = gohelper.findChild(item.go, "#go_reward_template")
	item.imgBg = gohelper.findChildImage(item.goReward, "image_bg")
	item.imgCircle = gohelper.findChildImage(item.goReward, "image_circle")
	item.goHasGet = gohelper.findChild(item.goReward, "go_hasget")
	item.goIcon = gohelper.findChild(item.goReward, "go_icon")
	item.txtCount = gohelper.findChildTextMesh(item.goReward, "txt_rewardcount")
	item.goCanget = gohelper.findChild(item.goReward, "go_canget")
	item.btn = gohelper.findButtonWithAudio(item.go)

	item.btn:AddClickListener(self.onGetReward, self, item)

	item.animStatus = item.goStatus:GetComponent(typeof(UnityEngine.Animator))
	item.animHasGet = item.goHasGet:GetComponent(typeof(UnityEngine.Animator))
	self.rewardItems[index] = item

	return item
end

function Season166InformationRewardView:refreshRewardItem(item, config)
	item.config = config

	if not config then
		gohelper.setActive(item.go, false)

		return
	end

	local actInfo = Season166Model.instance:getActInfo(config.activityId)
	local hasGet = actInfo:isBonusGet(config.analyCount)

	gohelper.setActive(item.go, true)
	gohelper.setActive(item.goHasGet, hasGet)
	gohelper.setActive(item.goStatus, self.infoAnalyCount >= config.analyCount)
	gohelper.setActive(item.goCanget, not hasGet and self.infoAnalyCount >= config.analyCount)

	local bounds = GameUtil.splitString2(config.bonus, true)
	local rewardCfg = bounds[1]
	local itemCfg = ItemModel.instance:getItemConfig(rewardCfg[1], rewardCfg[2])

	UISpriteSetMgr.instance:setUiFBSprite(item.imgBg, "bg_pinjidi_" .. itemCfg.rare)
	UISpriteSetMgr.instance:setUiFBSprite(item.imgCircle, "bg_pinjidi_lanse_" .. itemCfg.rare)

	item.txtCount.text = string.format("x%s", rewardCfg[3])

	if rewardCfg then
		item.itemIcon = item.itemIcon or IconMgr.instance:getCommonPropItemIcon(item.goIcon)

		item.itemIcon:setMOValue(rewardCfg[1], rewardCfg[2], rewardCfg[3], nil, true)
		item.itemIcon:isShowQuality(false)
		item.itemIcon:isShowCount(false)
	end

	if hasGet and item.hasGet == false then
		item.animStatus:Play("open")
	end

	item.hasGet = hasGet
end

function Season166InformationRewardView:onClose()
	return
end

function Season166InformationRewardView:onDestroyView()
	for i, v in ipairs(self.rewardItems) do
		v.btn:RemoveClickListener()
	end
end

return Season166InformationRewardView
