-- chunkname: @modules/logic/versionactivity/view/VersionActivityExchangeView.lua

module("modules.logic.versionactivity.view.VersionActivityExchangeView", package.seeall)

local VersionActivityExchangeView = class("VersionActivityExchangeView", BaseView)

function VersionActivityExchangeView:onInitView()
	self._simagebg = gohelper.findChildSingleImage(self.viewGO, "#simage_bg")
	self._gobtns = gohelper.findChild(self.viewGO, "#go_btns")
	self._gochat = gohelper.findChild(self.viewGO, "taklkarea/#go_chat")
	self._txttalk1 = gohelper.findChildText(self.viewGO, "taklkarea/#go_chat/#txt_talk1")
	self._txttalk2 = gohelper.findChildText(self.viewGO, "taklkarea/#go_chat/#txt_talk2")
	self._gohero1 = gohelper.findChild(self.viewGO, "taklkarea/hero1/#go_hero1")
	self._gohero2 = gohelper.findChild(self.viewGO, "taklkarea/hero2/#go_hero2")
	self._goroleimage = gohelper.findChild(self.viewGO, "taklkarea/#go_role_image")
	self._txtdeadline = gohelper.findChildText(self.viewGO, "#txt_deadline")
	self._txthas = gohelper.findChildText(self.viewGO, "gohas/#txt_has")
	self._scrollreward = gohelper.findChildScrollRect(self.viewGO, "#scroll_reward")
	self._goContent = gohelper.findChild(self.viewGO, "#scroll_reward/Viewport/#go_Content")
	self._gorewardItem = gohelper.findChild(self.viewGO, "#scroll_reward/Viewport/#go_Content/#go_rewardItem")
	self._gorewardcontent = gohelper.findChild(self.viewGO, "#scroll_reward/Viewport/#go_Content/#go_rewardItem/#go_rewardcontent")
	self._btngetres = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_getres")
	self._btnrule = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_rule")
	self._gotopleft = gohelper.findChild(self.viewGO, "#go_topleft")
	self._slider = gohelper.findChildSlider(self.viewGO, "#scroll_reward/Viewport/#go_Content/#slider_progress")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function VersionActivityExchangeView:addEvents()
	self._btngetres:AddClickListener(self._btngetresOnClick, self)
	self._btnrule:AddClickListener(self.openTips, self)
end

function VersionActivityExchangeView:removeEvents()
	self._btngetres:RemoveClickListener()
	self._btnrule:RemoveClickListener()
end

function VersionActivityExchangeView:_btngetresOnClick()
	local endTime = ActivityModel.instance:getActEndTime(self.actId)

	endTime = endTime / 1000

	local offTime = endTime - ServerTime.now()

	if offTime < tonumber(self._actMO.config.param) * 3600 then
		ToastController.instance:showToast(185)
	else
		ViewMgr.instance:openView(ViewName.VersionActivityExchangeTaskView, {
			actId = self.actId
		})
	end
end

function VersionActivityExchangeView:openTips()
	ViewMgr.instance:openView(ViewName.VersionActivityTipsView)
end

function VersionActivityExchangeView:_editableInitView()
	gohelper.setActive(self._gorewardItem, false)

	self.rewardItemList = {}
	self.actId = 11114
	self._actMO = ActivityModel.instance:getActMO(self.actId)
	self._uiSpine1 = GuiModelAgentNew.Create(self._gohero1, true)
	self._uiSpine2 = GuiModelAgentNew.Create(self._gohero2, true)

	self._simagebg:LoadImage(ResUrl.getVersionActivityExchangeIcon("full/bg"))

	local _gotaklkarea = gohelper.findChild(self.viewGO, "taklkarea")

	self._animator = _gotaklkarea:GetComponent(typeof(UnityEngine.Animator))

	local root = ViewMgr.instance:getUIRoot().transform
	local rootH = recthelper.getHeight(root)
	local rootW = recthelper.getWidth(root)
	local img1 = gohelper.findChild(self._goroleimage, "maskhero1Shadow/img_hero1").transform
	local img2 = gohelper.findChild(self._goroleimage, "maskhero2Shadow/img_hero2").transform
	local img3 = gohelper.findChild(self._goroleimage, "maskhero1/img_hero1").transform
	local img4 = gohelper.findChild(self._goroleimage, "maskhero2/img_hero2").transform

	recthelper.setSize(img1, rootW, rootH)
	recthelper.setSize(img2, rootW, rootH)
	recthelper.setSize(img3, rootW, rootH)
	recthelper.setSize(img4, rootW, rootH)

	self.iconClick = gohelper.findChildClick(self.viewGO, "gohas/icon")

	self.iconClick:AddClickListener(self.onClickIcon, self)

	self._firstShow = true
	self._gotaskdot = gohelper.findChild(self.viewGO, "#btn_getres/dot")

	RedDotController.instance:addRedDot(self._gotaskdot, RedDotEnum.DotNode.VersionActivityExchangeTask)
end

function VersionActivityExchangeView:onClickIcon()
	MaterialTipController.instance:showMaterialInfo(1, 970002, false, nil, false)
end

function VersionActivityExchangeView:onUpdateParam()
	Activity112Rpc.instance:sendGet112InfosRequest(self.actId)
	self:refreshReward()
	self:updateItemNum()
	self:updateDeadline()
end

function VersionActivityExchangeView:onOpen()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_leimi_paraphrase_open)
	self.addEventCb(self, BackpackController.instance, BackpackEvent.UpdateItemList, self.updateItemNum, self)
	self.addEventCb(self, VersionActivityController.instance, VersionActivityEvent.VersionActivity112Update, self.refreshReward, self)
	Activity112Rpc.instance:sendGet112InfosRequest(self.actId)

	local list = VersionActivityConfig.instance:getAct112Config(self.actId)

	self._needList = {}

	for i, v in ipairs(list) do
		local needArr = string.splitToNumber(v.items, "#")

		self._needList[i] = needArr[3]
	end

	self:updateItemNum()
	self:updateDeadline()
	TaskDispatcher.runRepeat(self.updateDeadline, self, 60)
end

function VersionActivityExchangeView:onClose()
	self.removeEventCb(self, BackpackController.instance, BackpackEvent.UpdateItemList, self.updateItemNum, self)
	self.removeEventCb(self, VersionActivityController.instance, VersionActivityEvent.VersionActivity112Update, self.refreshReward, self)
	TaskDispatcher.cancelTask(self.updateDeadline, self)
end

function VersionActivityExchangeView:removeEventCb()
	return
end

function VersionActivityExchangeView:onDestroyView()
	for i, v in ipairs(self.rewardItemList) do
		v:onDestroyView()
	end

	self.iconClick:RemoveClickListener()

	self.rewardItemList = nil

	self._simagebg:UnLoadImage()
end

function VersionActivityExchangeView:refreshReward()
	local list = VersionActivityConfig.instance:getAct112Config(self.actId)
	local startTime = ActivityModel.instance:getActStartTime(self.actId)

	startTime = startTime / 1000

	local offTime = ServerTime.now() - startTime

	offTime = offTime / 86400

	local lastOpen
	local selId = PlayerPrefsHelper.getNumber(PlayerPrefsKey.VersionActivityExchangeViewSelKey, 0)

	if selId == 0 then
		selId = list[1].id

		PlayerPrefsHelper.setNumber(PlayerPrefsKey.VersionActivityExchangeViewSelKey, list[1].id)
	end

	local selConfig

	for i, v in ipairs(list) do
		local item = self.rewardItemList[i]

		if item == nil then
			local itemGo = gohelper.cloneInPlace(self._gorewardItem, "item" .. i)

			gohelper.setActive(itemGo, true)

			item = MonoHelper.addLuaComOnceToGo(itemGo, VersionActivityExchangeItem, self)
			self.rewardItemList[i] = item

			item:setSelectFunc(self.onSelectItem, self)
		end

		if selId == v.id then
			selConfig = v
		end

		item:updateItem(v, i, self._firstShow)
		item:updateSelect(selId)
	end

	self._firstShow = false

	if selConfig == nil then
		selConfig = list[1]
		selId = list[1].id

		self.rewardItemList[1]:updateSelect(list[1].id)
		PlayerPrefsHelper.setNumber(PlayerPrefsKey.VersionActivityExchangeViewSelKey, selId)
	end

	self.selectConfig = selConfig

	self:updateSelectInfo()
end

function VersionActivityExchangeView:updateDeadline()
	local str = ActivityModel.instance:getActivityInfo()[self.actId]:getRemainTimeStr2ByEndTime()

	self._txtdeadline.text = string.format(luaLang("activity_remain_time"), str)
end

function VersionActivityExchangeView:updateItemNum()
	local hasQuantity = ItemModel.instance:getItemQuantity(1, 970002)

	self._txthas.text = hasQuantity

	local nowPre = 0
	local nowMark = 0
	local nextTar = 0
	local offPer = 0
	local tagPre = 0.2
	local sliderPre = 1 - tagPre
	local halfTagPre = 0.1

	for i, v in ipairs(self._needList) do
		if v <= hasQuantity then
			nowPre = i
			nowMark = v
			nextTar = v
		elseif nextTar <= nowMark then
			nextTar = v
		end
	end

	if nextTar ~= nowMark then
		offPer = (hasQuantity - nowMark) / (nextTar - nowMark)
	end

	if nowPre == 0 then
		self._slider:SetValue((halfTagPre + 0.3 * offPer) / (#self._needList - 0.5))
	else
		self._slider:SetValue((nowPre - 0.5 + halfTagPre + sliderPre * offPer) / (#self._needList - 0.5))
	end

	for i, v in ipairs(self.rewardItemList) do
		v:updateNeed()
	end
end

function VersionActivityExchangeView:onSelectItem(config)
	for i, v in ipairs(self.rewardItemList) do
		v:updateSelect(config.id)
	end

	PlayerPrefsHelper.setNumber(PlayerPrefsKey.VersionActivityExchangeViewSelKey, config.id)
	self._animator:Play(UIAnimationName.Click, 0, 0)

	self.selectConfig = config

	TaskDispatcher.cancelTask(self.updateSelectInfo, self)
	TaskDispatcher.runDelay(self.updateSelectInfo, self, 0.3)
end

function VersionActivityExchangeView:updateSelectInfo()
	local config = self.selectConfig

	self.state = VersionActivity112Model.instance:getRewardState(config.activityId, config.id)

	if self.state == 1 then
		self._txttalk1.text = config.themeDone
		self._txttalk2.text = config.themeDone2
	else
		self._txttalk1.text = config.theme
		self._txttalk2.text = config.theme2
	end

	gohelper.setActive(self._gochat, true)
	gohelper.setActive(self._goroleimage, false)
	transformhelper.setLocalScale(self._gohero1.transform, 1, 1, 1)
	transformhelper.setLocalScale(self._gohero2.transform, 1, 1, 1)
	self._uiSpine1:setResPath(config.skin, string.find(config.skin, "live2d"), self._onSpineLoaded1, self)
	self._uiSpine2:setResPath(config.skin2, string.find(config.skin2, "live2d"), self._onSpineLoaded2, self)
end

function VersionActivityExchangeView:_onSpineLoaded1()
	gohelper.setActive(self._goroleimage, true)

	local offsets = string.splitToNumber(self.selectConfig.skinOffSet, "#")

	recthelper.setAnchor(self._gohero1.transform, offsets[1], offsets[2])
	transformhelper.setLocalScale(self._gohero1.transform, offsets[3], offsets[3], offsets[3])
end

function VersionActivityExchangeView:_onSpineLoaded2()
	gohelper.setActive(self._goroleimage, true)

	local offsets = string.splitToNumber(self.selectConfig.skin2OffSet, "#")

	recthelper.setAnchor(self._gohero2.transform, offsets[1], offsets[2])
	transformhelper.setLocalScale(self._gohero2.transform, offsets[3], offsets[3], offsets[3])
end

return VersionActivityExchangeView
