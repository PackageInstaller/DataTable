-- chunkname: @modules/logic/versionactivity2_8/activity2nd/view/Activity2ndShowSkinView.lua

module("modules.logic.versionactivity2_8.activity2nd.view.Activity2ndShowSkinView", package.seeall)

local Activity2ndShowSkinView = class("Activity2ndShowSkinView", BaseView)

function Activity2ndShowSkinView:onInitView()
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "root/#btn_close")
	self._gotime = gohelper.findChild(self.viewGO, "root/#go_time")
	self._txtLimitTime = gohelper.findChildText(self.viewGO, "root/#go_time/#txt_LimitTime")
	self._btndetail = gohelper.findChildButtonWithAudio(self.viewGO, "root/#btn_detail")
	self._btnclaim = gohelper.findChildButtonWithAudio(self.viewGO, "root/#btn_claim")
	self._gocanget = gohelper.findChild(self.viewGO, "root/#btn_claim/simage_canget")
	self._gohasget = gohelper.findChild(self.viewGO, "root/#btn_claim/simage_hasget")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Activity2ndShowSkinView:addEvents()
	for i, btnPresent in ipairs(self._btnPresentList) do
		btnPresent:AddClickListener(self._btnPresentOnClick, self, i)
	end

	self._btnclose:AddClickListener(self._btncloseOnClick, self)
	self._btndetail:AddClickListener(self._btndetailOnClick, self)
	self._btnclaim:AddClickListener(self._btnclaimOnClick, self)
	ActivityController.instance:registerCallback(ActivityEvent.RefreshNorSignActivity, self.refreshUI, self)
	self.addEventCb(self, ActivityController.instance, ActivityEvent.RefreshActivityState, self.onRefreshActivity, self)
end

function Activity2ndShowSkinView:removeEvents()
	self._btnclose:RemoveClickListener()
	self._btndetail:RemoveClickListener()
	self._btnclaim:RemoveClickListener()

	for _, btnPresent in ipairs(self._btnPresentList) do
		btnPresent:RemoveClickListener()
	end

	ActivityController.instance:unregisterCallback(ActivityEvent.RefreshNorSignActivity, self.refreshUI, self)
end

function Activity2ndShowSkinView:_btndetailOnClick()
	local var_4_0 = self._rewardconfig

	if self._rewardconfig then
		var_4_0 = self._rewardconfig.bonus

		if self._rewardconfig.bonus then
			local reward = string.split(self._rewardconfig.bonus, "#")

			MaterialTipController.instance:showMaterialInfo(reward[1], reward[2])
		end
	end
end

function Activity2ndShowSkinView:_btnclaimOnClick()
	if self:checkCanGet(self._actId) then
		Activity101Rpc.instance:sendGet101BonusRequest(self._actId, 1)
	end
end

function Activity2ndShowSkinView:_btncloseOnClick()
	self:closeThis()
end

function Activity2ndShowSkinView:_editableInitView()
	self._btnPresentList = self:getUserDataTb_()

	for i = 1, Activity2ndEnum.DISPLAY_SKIN_COUNT do
		local btnPresent = gohelper.findChildButtonWithAudio(self.viewGO, "root/simage_FullBG/role/simage_role" .. i)

		if btnPresent then
			self._btnPresentList[#self._btnPresentList + 1] = btnPresent
		end
	end
end

function Activity2ndShowSkinView:_btnPresentOnClick(index)
	local isOpen = ActivityHelper.isOpen(self._actId)

	if not isOpen then
		return
	end

	if index == 1 then
		local skinId = Activity2ndEnum.ShowSkin4

		if skinId then
			CharacterController.instance:openCharacterSkinTipView({
				isShowHomeBtn = false,
				skinId = skinId
			})

			local skinCo = SkinConfig.instance:getSkinCo(tonumber(skinId))

			if skinCo then
				StatController.instance:track(StatEnum.EventName.Activity2ndSkinCollectionClick, {
					[StatEnum.EventProperties.skinId] = tonumber(skinId),
					[StatEnum.EventProperties.HeroName] = skinCo.name
				})
			end
		end
	else
		local goodsId = Activity2ndEnum.Index2GoodsId[index]

		if goodsId then
			local goodMo = StoreModel.instance:getGoodsMO(tonumber(goodsId))

			if not goodMo then
				return
			end

			ViewMgr.instance:openView(ViewName.StoreSkinPreviewView, {
				goodsMO = StoreModel.instance:getGoodsMO(tonumber(goodsId))
			})

			local config = StoreConfig.instance:getGoodsConfig(goodsId)

			if config then
				::label_8_0::

				local var_8_0 = config.product

				if config.product then
					local tab = string.split(config.product, "#")
					local skinId = tab and tab[2]

					if skinId then
						local skinCo = SkinConfig.instance:getSkinCo(tonumber(skinId))

						if skinCo then
							StatController.instance:track(StatEnum.EventName.Activity2ndSkinCollectionClick, {
								[StatEnum.EventProperties.skinId] = tonumber(skinId),
								[StatEnum.EventProperties.HeroName] = skinCo.name
							})
						end
					end
				end
			end
		end
	end
end

function Activity2ndShowSkinView:checkReceied(actId)
	return (ActivityType101Model.instance:isType101RewardGet(actId, 1))
end

function Activity2ndShowSkinView:checkCanGet(actId)
	return (ActivityType101Model.instance:isType101RewardCouldGet(actId, 1))
end

function Activity2ndShowSkinView:onUpdateParam()
	return
end

function Activity2ndShowSkinView:onOpen()
	self._actId = self.viewParam and self.viewParam.actId
	self._rewardconfig = ActivityConfig.instance:getNorSignActivityCo(self._actId, 1)

	self:refreshUI()
	AudioMgr.instance:trigger(AudioEnum.Meilanni.play_ui_mln_day_night)
end

function Activity2ndShowSkinView:refreshUI()
	self._txtLimitTime.text = ActivityHelper.getActivityRemainTimeStr(self._actId)

	local canGet = self:checkCanGet(self._actId)
	local hasGet = self:checkReceied(self._actId)

	gohelper.setActive(self._gohasget, hasGet)
	gohelper.setActive(self._gocanget, canGet)
end

function Activity2ndShowSkinView:onRefreshActivity()
	local status = ActivityHelper.getActivityStatus(self._actId)

	if status == ActivityEnum.ActivityStatus.NotOnLine or status == ActivityEnum.ActivityStatus.Expired then
		MessageBoxController.instance:showSystemMsgBox(MessageBoxIdDefine.EndActivity, MsgBoxEnum.BoxType.Yes, ActivityLiveMgr.yesCallback)

		return
	end
end

function Activity2ndShowSkinView:onClose()
	return
end

function Activity2ndShowSkinView:onDestroyView()
	return
end

return Activity2ndShowSkinView
