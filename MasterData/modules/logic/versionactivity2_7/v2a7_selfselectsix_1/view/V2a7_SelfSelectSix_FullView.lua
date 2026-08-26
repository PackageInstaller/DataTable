-- chunkname: @modules/logic/versionactivity2_7/v2a7_selfselectsix_1/view/V2a7_SelfSelectSix_FullView.lua

module("modules.logic.versionactivity2_7.v2a7_selfselectsix_1.view.V2a7_SelfSelectSix_FullView", package.seeall)

local V2a7_SelfSelectSix_FullView = class("V2a7_SelfSelectSix_FullView", BaseView)

function V2a7_SelfSelectSix_FullView:onInitView()
	self._btncheck = gohelper.findChildButtonWithAudio(self.viewGO, "root/#btn_check")
	self._gocanget = gohelper.findChild(self.viewGO, "root/reward/#go_canget")
	self._btnClaim = gohelper.findChildButtonWithAudio(self.viewGO, "root/reward/#go_canget/#btn_Claim")
	self._gocanuse = gohelper.findChild(self.viewGO, "root/reward/#go_canuse")
	self._btnuse = gohelper.findChildButtonWithAudio(self.viewGO, "root/reward/#go_canuse/#btn_use")
	self._txtcanuse = gohelper.findChildText(self.viewGO, "root/reward/#go_canuse/tips/#txt_canuse")
	self._gouesd = gohelper.findChild(self.viewGO, "root/reward/#go_uesd")
	self._txtdesc = gohelper.findChildText(self.viewGO, "root/simage_fullbg/#txt_desc")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V2a7_SelfSelectSix_FullView:addEvents()
	self._btncheck:AddClickListener(self._btncheckOnClick, self)
	self._btnClaim:AddClickListener(self._btnClaimOnClick, self)
	self._btnuse:AddClickListener(self._btnuseOnClick, self)
	ActivityController.instance:registerCallback(ActivityEvent.RefreshNorSignActivity, self.refreshUI, self)
	ViewMgr.instance:registerCallback(ViewEvent.OnCloseView, self._onCloseView, self)
end

function V2a7_SelfSelectSix_FullView:removeEvents()
	self._btncheck:RemoveClickListener()
	self._btnClaim:RemoveClickListener()
	self._btnuse:RemoveClickListener()
	ActivityController.instance:unregisterCallback(ActivityEvent.RefreshNorSignActivity, self.refreshUI, self)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseView, self._onCloseView, self)
end

function V2a7_SelfSelectSix_FullView:_btncheckOnClick()
	local itemco = ItemConfig.instance:getItemCo(V2a7_SelfSelectSix_Enum.RewardId)

	if string.nilorempty(itemco.effect) then
		return
	end

	local effectArr = string.split(itemco.effect, "|")

	V2a7_SelfSelectSix_PickChoiceListModel.instance:initData(effectArr, 1)

	local viewParam = {
		isPreview = true
	}

	ViewMgr.instance:openView(ViewName.V2a7_SelfSelectSix_PickChoiceView, viewParam)
end

function V2a7_SelfSelectSix_FullView:_btnClaimOnClick()
	if not self:checkReceied() and self:checkCanGet() then
		Activity101Rpc.instance:sendGet101BonusRequest(self._actId, 1)
	end
end

function V2a7_SelfSelectSix_FullView:_btnuseOnClick()
	local itemcount = ItemModel.instance:getItemCount(V2a7_SelfSelectSix_Enum.RewardId)

	if itemcount > 0 then
		local itemco = ItemConfig.instance:getItemCo(V2a7_SelfSelectSix_Enum.RewardId)

		if string.nilorempty(itemco.effect) then
			return
		end

		local effectArr = string.split(itemco.effect, "|")
		local viewParam = {
			quantity = 1,
			id = itemco.id
		}

		V2a7_SelfSelectSix_PickChoiceController.instance:openCustomPickChoiceView(effectArr, MaterialTipController.onUseSelfSelectSixHeroGift, MaterialTipController, viewParam, nil, nil, 1)
	end
end

function V2a7_SelfSelectSix_FullView:_editableInitView()
	return
end

function V2a7_SelfSelectSix_FullView:onUpdateParam()
	return
end

function V2a7_SelfSelectSix_FullView:onOpen()
	AudioMgr.instance:trigger(AudioEnum.Meilanni.play_ui_mln_day_night)

	local parentGO = self.viewParam.parent

	self._actId = self.viewParam.actId

	gohelper.addChild(parentGO, self.viewGO)
	Activity101Rpc.instance:sendGet101InfosRequest(self._actId)

	self._actCo = ActivityConfig.instance:getActivityCo(self._actId)
	self._txtdesc.text = self._actCo.actDesc

	self:refreshUI()
end

function V2a7_SelfSelectSix_FullView:refreshUI()
	local received = self:checkReceied()
	local canUse = self:checkCanUse()

	gohelper.setActive(self._gocanget, not received)
	gohelper.setActive(self._gocanuse, received and canUse)
	gohelper.setActive(self._gouesd, received and not canUse)

	if canUse then
		self:_initListModel()

		local lastUnlockEpisodeId, allPass = V2a7_SelfSelectSix_PickChoiceListModel.instance:getLastUnlockEpisodeId()

		if allPass then
			self._txtcanuse.text = luaLang("v2a7_newbie_rewardclaim_texts")
		else
			local episodeName = DungeonHelper.getEpisodeName(lastUnlockEpisodeId)

			self._txtcanuse.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("v2a7_newbie_storyprocess_locate_eventiterface"), episodeName)
		end
	end
end

function V2a7_SelfSelectSix_FullView:_initListModel()
	local itemco = ItemConfig.instance:getItemCo(V2a7_SelfSelectSix_Enum.RewardId)

	if string.nilorempty(itemco.effect) then
		return
	end

	local effectArr = string.split(itemco.effect, "|")

	V2a7_SelfSelectSix_PickChoiceListModel.instance:initData(effectArr, 1)
end

function V2a7_SelfSelectSix_FullView:_onCloseView(viewName)
	if viewName == ViewName.CharacterGetView then
		self:refreshUI()
	end
end

function V2a7_SelfSelectSix_FullView:checkReceied()
	return (ActivityType101Model.instance:isType101RewardGet(self._actId, 1))
end

function V2a7_SelfSelectSix_FullView:checkCanGet()
	return (ActivityType101Model.instance:isType101RewardCouldGet(self._actId, 1))
end

function V2a7_SelfSelectSix_FullView:checkCanUse()
	local itemcount = ItemModel.instance:getItemCount(V2a7_SelfSelectSix_Enum.RewardId)

	return itemcount > 0
end

function V2a7_SelfSelectSix_FullView:onClose()
	return
end

function V2a7_SelfSelectSix_FullView:onDestroyView()
	return
end

return V2a7_SelfSelectSix_FullView
