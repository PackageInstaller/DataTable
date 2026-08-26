-- chunkname: @modules/logic/seasonver/act166/view2_6/Season166_2_6InformationAnalyRewardView.lua

module("modules.logic.seasonver.act166.view2_6.Season166_2_6InformationAnalyRewardView", package.seeall)

local Season166_2_6InformationAnalyRewardView = class("Season166_2_6InformationAnalyRewardView", BaseView)

function Season166_2_6InformationAnalyRewardView:onInitView()
	self.rewardItems = {}
	self.goReward = gohelper.findChild(self.viewGO, "Bottom/SliderPoint/#go_rewards")

	gohelper.setActive(self.goReward, false)

	self.slider = gohelper.findChildSlider(self.viewGO, "Bottom/Slider")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Season166_2_6InformationAnalyRewardView:addEvents()
	self.addEventCb(self, Season166Controller.instance, Season166Event.OnAnalyInfoSuccess, self.onAnalyInfoSuccess, self)
	self.addEventCb(self, Season166Controller.instance, Season166Event.OnInformationUpdate, self.onInformationUpdate, self)
	self.addEventCb(self, Season166Controller.instance, Season166Event.OnGetInfoBonus, self.onGetInfoBonus, self)
	self.addEventCb(self, Season166Controller.instance, Season166Event.ChangeAnalyInfo, self.onChangeAnalyInfo, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseViewFinish, self.onCloseViewFinish, self)
end

function Season166_2_6InformationAnalyRewardView:removeEvents()
	return
end

function Season166_2_6InformationAnalyRewardView:_editableInitView()
	return
end

function Season166_2_6InformationAnalyRewardView:onUpdateParam()
	return
end

function Season166_2_6InformationAnalyRewardView:onAnalyInfoSuccess()
	self:refreshUI()
end

function Season166_2_6InformationAnalyRewardView:onChangeAnalyInfo(infoId)
	self.infoId = infoId

	for i, v in ipairs(self.rewardItems) do
		v.activieStatus = nil
		v.hasGet = nil
	end

	self:refreshUI()
end

function Season166_2_6InformationAnalyRewardView:onInformationUpdate()
	self:refreshUI()
end

function Season166_2_6InformationAnalyRewardView:onGetInfoBonus()
	return
end

function Season166_2_6InformationAnalyRewardView:onOpen()
	self.actId = self.viewParam.actId
	self.infoId = self.viewParam.infoId

	self:refreshUI()
end

function Season166_2_6InformationAnalyRewardView:refreshUI()
	if not self.actId then
		return
	end

	self:refreshReward()
end

function Season166_2_6InformationAnalyRewardView:refreshReward()
	if ViewMgr.instance:isOpen(ViewName.CommonPropView) then
		return
	end

	local actInfo = Season166Model.instance:getActInfo(self.actId)
	local infoMo = actInfo:getInformationMO(self.infoId)
	local list = Season166Config.instance:getSeasonInfoAnalys(self.actId, self.infoId) or {}

	for i = 1, math.max(#list, #self.rewardItems) do
		local item = self.rewardItems[i]

		item = item or self:createRewardItem(i)

		self:refreshRewardItem(item, list[i])
	end

	local count = #list

	if infoMo then
		if not infoMo.stage then
			local curCount = 0
			local value = Mathf.Clamp01((curCount - 1) / (count - 1))

			self.slider:SetValue(value)
		end
	end
end

function Season166_2_6InformationAnalyRewardView:onGetReward(item)
	if not item.config then
		return
	end

	local config = item.config
	local actInfo = Season166Model.instance:getActInfo(config.activityId)
	local infoMo = actInfo:getInformationMO(config.infoId)

	if not infoMo then
		return
	end

	local hasGet = infoMo.bonusStage >= config.stage

	if hasGet then
		self:showInfo(config)

		return
	end

	if infoMo.stage >= config.stage then
		Activity166Rpc.instance:sendAct166ReceiveInfoBonusRequest(self.actId, self.infoId)
	else
		self:showInfo(config)
	end
end

function Season166_2_6InformationAnalyRewardView:showInfo(config)
	local bounds = GameUtil.splitString2(config.bonus, true)
	local rewardCfg = bounds[1]

	MaterialTipController.instance:showMaterialInfo(rewardCfg[1], rewardCfg[2], nil, nil, true)
end

function Season166_2_6InformationAnalyRewardView:createRewardItem(index)
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

function Season166_2_6InformationAnalyRewardView:refreshRewardItem(item, config)
	item.config = config

	if not config then
		gohelper.setActive(item.go, false)

		return
	end

	local actInfo = Season166Model.instance:getActInfo(config.activityId)
	local infoMo = actInfo:getInformationMO(config.infoId)
	local hasGet = infoMo and infoMo.bonusStage >= config.stage or false
	local activieStatus = infoMo and infoMo.stage >= config.stage or false

	gohelper.setActive(item.go, true)
	gohelper.setActive(item.goHasGet, hasGet)
	gohelper.setActive(item.goStatus, activieStatus)
	gohelper.setActive(item.goCanget, not hasGet and activieStatus)

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
		item.animHasGet:Play("open")
	end

	if activieStatus and item.activieStatus == false then
		item.animStatus:Play("open")
	end

	item.activieStatus = activieStatus
	item.hasGet = hasGet
end

function Season166_2_6InformationAnalyRewardView:onCloseViewFinish(viewName)
	if viewName == ViewName.CommonPropView then
		self:refreshReward()
	end
end

function Season166_2_6InformationAnalyRewardView:onClose()
	return
end

function Season166_2_6InformationAnalyRewardView:onDestroyView()
	for i, v in ipairs(self.rewardItems) do
		v.btn:RemoveClickListener()
	end
end

return Season166_2_6InformationAnalyRewardView
