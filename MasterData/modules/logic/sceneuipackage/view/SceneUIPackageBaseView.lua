-- chunkname: @modules/logic/sceneuipackage/view/SceneUIPackageBaseView.lua

module("modules.logic.sceneuipackage.view.SceneUIPackageBaseView", package.seeall)

local SceneUIPackageBaseView = class("SceneUIPackageBaseView", BaseView)

function SceneUIPackageBaseView:onInitView()
	self._txttime = gohelper.findChildText(self.viewGO, "root/timebg/#txt_time")
	self._btncheck = gohelper.findChildButtonWithAudio(self.viewGO, "root/#btn_check")
end

function SceneUIPackageBaseView:addEvents()
	self._btncheck:AddClickListener(self._btncheckOnClick, self)
	self._btnframe:AddClickListener(self.btnframeOnClick, self)
	self._btnbackground:AddClickListener(self.btnbackgroundOnClick, self)
	self._btnreward:AddClickListener(self.btnrewardOnClick, self)
	self.addEventCb(self, ActivityController.instance, ActivityEvent.RefreshNorSignActivity, self.refreshView, self)
end

function SceneUIPackageBaseView:removeEvents()
	self._btncheck:RemoveClickListener()
	self._btnframe:RemoveClickListener()
	self._btnbackground:RemoveClickListener()
	self._btnreward:RemoveClickListener()
	self.removeEventCb(self, ActivityController.instance, ActivityEvent.RefreshNorSignActivity, self.refreshView, self)
end

function SceneUIPackageBaseView:btnrewardOnClick()
	local restItem = SceneUIPackageModel.instance:getRestItem(self._actId)

	if not restItem then
		return
	end

	MaterialTipController.instance:showMaterialInfo(restItem[1], restItem[2])
end

function SceneUIPackageBaseView:btnbackgroundOnClick()
	local sceneCo = SceneUIPackageModel.instance:getSceneCo(self._actId)

	if not sceneCo then
		return
	end

	local sceneSkinId = sceneCo.id

	ViewMgr.instance:openView(ViewName.MainSceneSwitchInfoView, {
		isPreview = true,
		noInfoEffect = true,
		sceneSkinId = sceneSkinId
	})
end

function SceneUIPackageBaseView:btnframeOnClick()
	local UICo = SceneUIPackageModel.instance:getUICo(self._actId)

	if not UICo then
		return
	end

	local uiSkinId = UICo.id

	MainUISwitchController.instance:openMainUISwitchInfoView(uiSkinId, true, false, false)
end

function SceneUIPackageBaseView:_btncheckOnClick()
	local sceneCo = SceneUIPackageModel.instance:getSceneCo(self._actId)

	if not sceneCo then
		return
	end

	local sceneSkinId = sceneCo.id
	local UICo = SceneUIPackageModel.instance:getUICo(self._actId)

	if not UICo then
		return
	end

	local uiSkinId = UICo.id

	MainUISwitchController.instance:openSceneUIPackageInfoView(uiSkinId, sceneSkinId, false)
end

function SceneUIPackageBaseView:_btnRewardOnClick(index)
	local couldGet = ActivityType101Model.instance:isType101RewardCouldGet(self._actId, index)

	if couldGet then
		Activity101Rpc.instance:sendGet101BonusRequest(self._actId, index)
	else
		local co = ActivityConfig.instance:getNorSignActivityCo(self._actId, index)
		local bonus = string.splitToNumber(co.bonus, "#")

		MaterialTipController.instance:showMaterialInfo(bonus[1], bonus[2])
	end
end

function SceneUIPackageBaseView:_editableInitView()
	self._rewardItem = self:getUserDataTb_()

	local count = 3

	for i = 1, count do
		local go = gohelper.findChild(self.viewGO, "root/reward" .. i)
		local item = self:getUserDataTb_()

		item.go = go
		item.icon = gohelper.findChildSingleImage(go, "#image_icon")
		item.txtnum = gohelper.findChildText(go, "mask/#txt_nums")
		item.gocanget = gohelper.findChild(go, "go_canget")
		item.goreceive = gohelper.findChild(go, "go_receive")
		item.gotomorrow = gohelper.findChild(go, "go_tomorrow")
		item.btnClick = gohelper.findChildButtonWithAudio(go, "#btn_click")

		item.btnClick:AddClickListener(self._btnRewardOnClick, self, i)

		self._rewardItem[i] = item
	end

	self._btnframe = gohelper.findChildButtonWithAudio(self.viewGO, "root/go_frame")
	self._btnbackground = gohelper.findChildButtonWithAudio(self.viewGO, "root/go_background")
	self._btnreward = gohelper.findChildButtonWithAudio(self.viewGO, "root/go_reward")
	self._goframereceive = gohelper.findChild(self.viewGO, "root/go_frame/go_receive")
	self._gobackgroundreceive = gohelper.findChild(self.viewGO, "root/go_background/go_receive")
	self._gorewardreceive = gohelper.findChild(self.viewGO, "root/go_reward/go_receive")
	self._simgreward = gohelper.findChildSingleImage(self.viewGO, "root/go_reward/icon")
	self._txtrewardnum = gohelper.findChildText(self.viewGO, "root/go_reward/#go_num/#txt_num")
	self._bgs = self:getUserDataTb_()
	self._bgCount = 2

	self:_initBgs()
end

function SceneUIPackageBaseView:_initBgs()
	for i = 1, self._bgCount do
		self._bgs[i] = gohelper.findChild(self.viewGO, "root/simage_panelbg_" .. i)
	end
end

function SceneUIPackageBaseView:refreshReceive()
	local hasScene = SceneUIPackageModel.instance:hasScene(self._actId)
	local hasUI = SceneUIPackageModel.instance:hasUI(self._actId)
	local canBuy = SceneUIPackageModel.instance:canBuy(self._actId)

	gohelper.setActive(self._goframereceive, hasUI)
	gohelper.setActive(self._gobackgroundreceive, hasScene)
	gohelper.setActive(self._gorewardreceive, not canBuy)
end

function SceneUIPackageBaseView:onOpen()
	if self.viewParam then
		self._actId = self.viewParam.actId or SceneUIPackageModel.instance:getActId()
	end

	self._actCo = ActivityConfig.instance:getActivityCo(self._actId)
	self._txttime.text = ActivityHelper.getActivityRemainTimeStr(self._actId)

	Activity101Rpc.instance:sendGet101InfosRequest(self._actId)
	self:_initGoods()

	self._curBgIndex = 1

	self:_changeBgs()

	local packageCo = SceneUIPackageModel.instance:getPackageCo(self._actId)

	if packageCo then
		if not packageCo.millisecond then
			local time = 3000

			TaskDispatcher.runRepeat(self._changeBgs, self, time * 0.001)
			AudioMgr.instance:trigger(AudioEnum3_10.SceneUIPackage.play_ui_langchao_pailian)
		end
	end
end

function SceneUIPackageBaseView:_initGoods()
	self._items = {}
	self._goodsCo = SceneUIPackageModel.instance:getGoodsCo(self._actId)

	local restItem = SceneUIPackageModel.instance:getRestItem(self._actId)

	if restItem then
		local _, icon = ItemModel.instance:getItemConfigAndIcon(restItem[1], restItem[2])

		self._simgreward:LoadImage(icon)

		self._txtrewardnum.text = restItem[3]
	end
end

function SceneUIPackageBaseView:refreshView()
	self:refreshSignReward()
	self:refreshReceive()
end

function SceneUIPackageBaseView:refreshSignReward()
	for i, item in ipairs(self._rewardItem) do
		local rewardGet = ActivityType101Model.instance:isType101RewardGet(self._actId, i)
		local couldGet = ActivityType101Model.instance:isType101RewardCouldGet(self._actId, i)
		local totalday = ActivityType101Model.instance:getType101LoginCount(self._actId)

		gohelper.setActive(item.gocanget, couldGet)
		gohelper.setActive(item.goreceive, rewardGet)
		gohelper.setActive(item.gotomorrow, totalday + 1 == i)

		local co = ActivityConfig.instance:getNorSignActivityCo(self._actId, i)

		if co and not string.nilorempty(co.bonus) then
			local bonus = string.splitToNumber(co.bonus, "#")
			local _, icon = ItemModel.instance:getItemConfigAndIcon(bonus[1], bonus[2])

			item.icon:LoadImage(icon)

			item.txtnum.text = luaLang("multiple") .. bonus[3]
		end
	end
end

function SceneUIPackageBaseView:_changeBgs()
	for i, go in pairs(self._bgs) do
		gohelper.setActive(go, i == self._curBgIndex)
	end

	self._curBgIndex = self._curBgIndex == self._bgCount and 1 or self._curBgIndex + 1
end

function SceneUIPackageBaseView:onClose()
	return
end

function SceneUIPackageBaseView:onDestroyView()
	for i, item in ipairs(self._rewardItem) do
		item.btnClick:RemoveClickListener()
		item.icon:UnLoadImage()
	end

	self._simgreward:UnLoadImage()
	TaskDispatcher.cancelTask(self._changeBgs, self)
end

return SceneUIPackageBaseView
