-- chunkname: @modules/logic/versionactivity2_8/act197/view/Activity197View.lua

module("modules.logic.versionactivity2_8.act197.view.Activity197View", package.seeall)

local Activity197View = class("Activity197View", BaseView)

function Activity197View:onInitView()
	self._simagefullbg = gohelper.findChildSingleImage(self.viewGO, "#simage_fullbg")
	self._simagepage = gohelper.findChildSingleImage(self.viewGO, "Left/#simage_page")
	self._goleft = gohelper.findChild(self.viewGO, "Left")
	self._gopointcontent = gohelper.findChild(self.viewGO, "Left/Point")
	self._gopointitem = gohelper.findChild(self.viewGO, "Left/Point/#go_pointitem")
	self._scrollreward = gohelper.findChildScrollRect(self.viewGO, "Left/#scroll_reward")
	self._gorewarditemcontent = gohelper.findChild(self.viewGO, "Left/#scroll_reward/Viewport/Content/")
	self._gorewarditem = gohelper.findChild(self.viewGO, "Left/#scroll_reward/Viewport/Content/#go_rewarditem")
	self._txtindex = gohelper.findChildText(self.viewGO, "Left/indexBG/#txt_index")
	self._btnKey = gohelper.findChildButtonWithAudio(self.viewGO, "Left/#btn_Summon")
	self._txtusekey = gohelper.findChildText(self.viewGO, "Left/#btn_Summon/#txt_usepower")
	self._btnswitchLeft = gohelper.findChildButtonWithAudio(self.viewGO, "Left/#btn_switchLeft")
	self._btnswitchRight = gohelper.findChildButtonWithAudio(self.viewGO, "Left/#btn_switchRight")
	self._simageTitle = gohelper.findChildSingleImage(self.viewGO, "Right/#simage_Title")
	self._txtLimitTime = gohelper.findChildText(self.viewGO, "Right/LimitTime/#txt_LimitTime")
	self._scrollDesc = gohelper.findChildScrollRect(self.viewGO, "Right/#scroll_Desc")
	self._txtDec = gohelper.findChildText(self.viewGO, "Right/#scroll_Desc/Viewport/#txt_Dec")
	self._imageboxprogress = gohelper.findChildImage(self.viewGO, "Right/Computer/go_Unknown_Progress/#image_progress")
	self._goprogressunknown = gohelper.findChild(self.viewGO, "Right/Computer/go_Unknown_Progress/image_dec2")
	self._imageprogress = gohelper.findChildImage(self.viewGO, "Right/Progress/#image_progress")
	self._btnSearch = gohelper.findChildButtonWithAudio(self.viewGO, "Right/Progress/#btn_Search")
	self._txtusebubble = gohelper.findChildText(self.viewGO, "Right/Progress/#btn_Search/#txt_usepower")
	self._goExtraTips = gohelper.findChild(self.viewGO, "#go_ExtraTips")
	self._txtTips = gohelper.findChildText(self.viewGO, "#go_ExtraTips/#txt_Tips")
	self._govxkey = gohelper.findChild(self.viewGO, "vx_glow")
	self._govxbubble = gohelper.findChild(self.viewGO, "vx_light")
	self._govxFresh = gohelper.findChild(self.viewGO, "Left/vx_fresh")
	self._leftAnimator = self._goleft:GetComponent(typeof(UnityEngine.Animator))
	self._goCanGet = gohelper.findChild(self.viewGO, "Right/Computer/go_Canget")
	self._btnCanGet = gohelper.findChildButtonWithAudio(self.viewGO, "Right/Computer/go_Canget/#btn_canget")
	self._goHasGet = gohelper.findChild(self.viewGO, "Right/Computer/go_Hasget")
	self._goUnknown = gohelper.findChild(self.viewGO, "Right/Computer/go_Unknown")
	self._goUnknownProgress = gohelper.findChild(self.viewGO, "Right/Computer/go_Unknown_Progress")
	self._btntoptips = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_tips")
	self._gotoptips = gohelper.findChild(self.viewGO, "#btn_tips/go_tips")
	self._btnclosetoptips = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_tips/go_tips/#btn_close")
	self._btnbottomtips = gohelper.findChildButtonWithAudio(self.viewGO, "Right/Progress/#btn_tips")
	self._gobottomtips = gohelper.findChild(self.viewGO, "Right/Progress/#btn_tips/go_tips")
	self._btnclosebottomtips = gohelper.findChildButtonWithAudio(self.viewGO, "Right/Progress/#btn_tips/go_tips/#btn_close")
	self._goreddotKey = gohelper.findChild(self.viewGO, "Left/#btn_Summon/#go_reddot")
	self._goreddotBubble = gohelper.findChild(self.viewGO, "Right/Progress/#btn_Search/#go_reddot")
	self._goreddotComputer = gohelper.findChild(self.viewGO, "Right/Computer/#go_reddot")
	self._switchTime = 0.3
	self._vxfreshTime = 0.6
	self._vxItemGlowTime = 0.8
	self._showTipsTime = 2
	self._showtoptips = false
	self._showbottomtips = false
	self._isPlayAnim = false
	self._sendMsgTime = 10

	gohelper.setActive(self._gotoptips, false)

	self._animComputer = gohelper.findChild(self.viewGO, "Right/Computer/go_Unknown_Progress"):GetComponent(typeof(UnityEngine.Animator))

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Activity197View:addEvents()
	self._btnKey:AddClickListener(self._btnKeyOnClick, self)
	self._btnswitchLeft:AddClickListener(self._btnswitchLeftOnClick, self)
	self._btnswitchRight:AddClickListener(self._btnswitchRightOnClick, self)
	self._btnCanGet:AddClickListener(self._btnCanGetOnClick, self)
	self._btnSearch:AddClickListener(self._btnSearchOnClick, self)
	self._btntoptips:AddClickListener(self._btntoptipsOnClick, self)
	self._btnclosetoptips:AddClickListener(self._btnclosetoptipsOnClick, self)
	self._btnbottomtips:AddClickListener(self._btnbottomtipsOnClick, self)
	self._btnclosebottomtips:AddClickListener(self._btnclosebottomtipsOnClick, self)
	self.addEventCb(self, Activity197Controller.instance, Activity197Event.UpdateSingleItem, self.updateSingleRewardItem, self)
	self.addEventCb(self, Activity197Controller.instance, Activity197Event.onReceiveAct197Explore, self._refreshBtn, self)
	self.addEventCb(self, CurrencyController.instance, CurrencyEvent.CurrencyChange, self._refreshBtn, self)
	self.addEventCb(self, ActivityController.instance, ActivityEvent.RefreshActivityState, self.onRefreshActivity, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseViewFinish, self._onRewardRefresh, self)
	self.addEventCb(self, TaskController.instance, TaskEvent.OnFinishTask, self._onFinishTask, self)

	self._redDotKey = RedDotController.instance:addNotEventRedDot(self._goreddotKey, self.checkKeyReddot, self)
	self._redDotBubble = RedDotController.instance:addNotEventRedDot(self._goreddotBubble, self.checkBubbleReddot, self)
	self._redDotComputer = RedDotController.instance:addRedDot(self._goreddotComputer, RedDotEnum.DotNode.ActiveActivityProgressReward)
end

function Activity197View:removeEvents()
	self._btnKey:RemoveClickListener()
	self._btnswitchLeft:RemoveClickListener()
	self._btnswitchRight:RemoveClickListener()
	self._btnSearch:RemoveClickListener()
	self._btnCanGet:RemoveClickListener()
	self._btntoptips:RemoveClickListener()
	self._btnclosetoptips:RemoveClickListener()
	self._btnbottomtips:RemoveClickListener()
	self._btnclosebottomtips:RemoveClickListener()
	self.removeEventCb(self, Activity197Controller.instance, Activity197Event.UpdateSingleItem, self.updateSingleRewardItem, self)
	self.removeEventCb(self, Activity197Controller.instance, Activity197Event.onReceiveAct197Explore, self._refreshBtn, self)
	self.removeEventCb(self, CurrencyController.instance, CurrencyEvent.CurrencyChange, self._refreshBtn, self)
end

function Activity197View:_btntoptipsOnClick()
	self._showtoptips = not self._showtoptips

	gohelper.setActive(self._gotoptips, self._showtoptips)
end

function Activity197View:_btnclosetoptipsOnClick()
	self._showtoptips = false

	gohelper.setActive(self._gotoptips, self._showtoptips)
end

function Activity197View:_btnbottomtipsOnClick()
	self._showbottomtips = not self._showbottomtips

	gohelper.setActive(self._gobottomtips, self._showbottomtips)
end

function Activity197View:_btnclosebottomtipsOnClick()
	self._showbottomtips = false

	gohelper.setActive(self._gobottomtips, self._showbottomtips)
end

function Activity197View:_btnswitchLeftOnClick()
	if self._isPlayAnim then
		return
	end

	local poolId = self._currentPoolId - 1

	if poolId < 1 then
		return
	end

	self._currentPoolId = poolId

	self._leftAnimator:Play("left", 0, 0)
	AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_Universal_Click)
	TaskDispatcher.runDelay(self._onSwitchAnimFinish, self, self._switchTime)
end

function Activity197View:_btnswitchRightOnClick()
	if self._isPlayAnim then
		return
	end

	local poolId = self._currentPoolId + 1

	if poolId > Activity197Config.instance:getPoolCount() then
		return
	end

	if Activity197Model.instance:checkPoolOpen(poolId) then
		self._currentPoolId = poolId

		self._leftAnimator:Play("right", 0, 0)
		AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_Universal_Click)
		TaskDispatcher.runDelay(self._onSwitchAnimFinish, self, self._switchTime)
	else
		GameFacade.showToast(ToastEnum.GetBigRewardUnlock)
	end
end

function Activity197View:_onSwitchAnimFinish()
	TaskDispatcher.cancelTask(self._onSwitchAnimFinish, self)
	self:_refreshUI()

	self._isPlayAnim = false
end

function Activity197View:_btnSearchOnClick()
	if self._isPlayAnim then
		return
	end

	if Activity197Model.instance:canExplore() then
		self:showGetKetProgress()
	else
		local name = CurrencyConfig.instance:getCurrencyCo(Activity197Enum.BulbCurrency).name

		GameFacade.showToast(ToastEnum.V1a6CachotToast13, name)
	end
end

function Activity197View:_btnKeyOnClick()
	if self._isPlayAnim then
		return
	end

	if Activity197Model.instance:checkPoolGetAllReward(self._currentPoolId) then
		GameFacade.showToast(ToastEnum.HasReceiveAllReward)
	elseif Activity197Model.instance:canRummage() then
		self:_getRewardAnim()
	else
		local name = CurrencyConfig.instance:getCurrencyCo(Activity197Enum.KeyCurrency).name

		GameFacade.showToast(ToastEnum.V1a6CachotToast13, name)
	end
end

function Activity197View:_btnClickTopNode(poolId)
	if self._isPlayAnim then
		return
	end

	if self._currentPoolId == poolId then
		return
	end

	local isopen = Activity197Model.instance:checkPoolOpen(poolId)

	if isopen then
		local isleft = poolId > self._currentPoolId

		Activity197Model.instance:setCurrentPoolId(poolId)

		self._currentPoolId = poolId

		if isleft then
			self._leftAnimator:Play("left", 0, 0)
			TaskDispatcher.runDelay(self._onSwitchAnimFinish, self, self._switchTime)
		else
			self._leftAnimator:Play("right", 0, 0)
			TaskDispatcher.runDelay(self._onSwitchAnimFinish, self, self._switchTime)
		end

		self._isPlayAnim = false
	else
		GameFacade.showToast(ToastEnum.GetBigRewardUnlock)
	end

	AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_Universal_Click)
end

function Activity197View:_btnCanGetOnClick()
	local co = Activity197Config.instance:getStageConfig(self._actId, 1)

	if co then
		if not co.globalTaskId then
			local globalTaskId = 0

			TaskRpc.instance:sendFinishTaskRequest(globalTaskId)
		end
	end
end

function Activity197View:_editableInitView()
	self._isShowTip = false

	gohelper.setActive(self._gopointitem, false)
	gohelper.setActive(self._gorewarditem, false)
	gohelper.setActive(self._goExtraTips, false)

	self._imageboxprogress.fillAmount = 0
	self._imageprogress.fillAmount = 0

	self:_initTopNode()
	self:_initRewardItems()
end

function Activity197View:_initTopNode()
	self._topnodeList = {}

	local poolList = Activity197Config.instance:getPoolList()

	for index, poolId in ipairs(poolList) do
		local item = self._topnodeList[index]

		if not item then
			item = self:getUserDataTb_()
			item.poolId = poolId
			item.go = gohelper.clone(self._gopointitem, self._gopointcontent, "pool" .. index)
			item.golocked = gohelper.findChild(item.go, "locked")
			item.gounlock = gohelper.findChild(item.go, "unlock")
			item.goselect = gohelper.findChild(item.go, "unlock/go_select")
			item.gogetall = gohelper.findChild(item.go, "unlock/go_allGet")
			item.btn = gohelper.findChildButton(item.go, "btn")

			item.btn:AddClickListener(self._btnClickTopNode, self, item.poolId)

			item.anim = item.go:GetComponent(typeof(UnityEngine.Animator))

			gohelper.setActive(item.go, true)
			table.insert(self._topnodeList, item)
		end
	end
end

function Activity197View:_initRewardItems()
	self._rewardItems = {}

	for index = 1, 12 do
		local item = self._rewardItems[index]

		if not item then
			item = self:getUserDataTb_()
			item.gainId = index
			item.go = gohelper.clone(self._gorewarditem, self._gorewarditemcontent, "reward" .. index)
			item.goreceive = gohelper.findChild(item.go, "go_receive")
			item.gohasget = gohelper.findChild(item.go, "go_receive/go_hasget")
			item.goitem = gohelper.findChild(item.go, "go_icon")
			item.gofirstPrice = gohelper.findChild(item.go, "go_firstPrice")
			item.goitemcomp = IconMgr.instance:getCommonPropItemIcon(item.goitem)
			item.vxglow = gohelper.findChild(item.go, "vx_glow")
			item.animHasGet = item.gohasget:GetComponent(typeof(UnityEngine.Animator))

			gohelper.setActive(item.gofirstPrice, index == 1)
			gohelper.setActive(item.go, true)
			table.insert(self._rewardItems, item)
		end
	end
end

function Activity197View:_onFinishTask()
	self:_refreshComputer()

	self._imageprogress.fillAmount = 1

	RedDotRpc.instance:sendGetRedDotInfosRequest({
		RedDotEnum.DotNode.ActiveActivityProgressReward,
		RedDotEnum.DotNode.ActiveActivity
	})
	self:_refreshRedDot()
end

function Activity197View:onOpen()
	self._actId = self.viewParam.actId
	self._lastOpenPoolId = 1
	self._currentPoolId = Activity197Model.instance:getLastOpenPoolId()

	TaskRpc.instance:sendGetTaskInfoRequest({
		TaskEnum.TaskType.Activity173
	}, self._onSendTaskBack, self)
	AudioMgr.instance:trigger(AudioEnum.ui_mail.play_ui_mail_open_1)
	self:_getLastPoolId()
	self:_refreshUI()
	self:_checkNeedShowBubbleVx()
end

function Activity197View:_getLastPoolId()
	for _, node in ipairs(self._topnodeList) do
		local isopen = Activity197Model.instance:checkPoolOpen(node.poolId)

		if isopen then
			self._lastOpenPoolId = node.poolId
		end
	end
end

function Activity197View:_refreshUI()
	self._txtLimitTime.text = ActivityHelper.getActivityRemainTimeStr(self._actId)

	local index = string.format("%03d", self._currentPoolId)

	self._txtindex.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("anniversary_activity_name"), index)

	local isLast = self._currentPoolId == Activity197Config.instance:getPoolCount()
	local isFirst = self._currentPoolId == 1

	gohelper.setActive(self._btnswitchRight.gameObject, not isLast)
	gohelper.setActive(self._btnswitchLeft.gameObject, not isFirst)
	self:_refreshTopNodeList()
	self:_refreshRewardItems()
	self:_refreshProgress()
	self:_refreshBtn()
end

function Activity197View:_refreshRedDot()
	if self._redDotKey then
		self._redDotKey:refreshRedDot()
	end

	if self._redDotBubble then
		self._redDotBubble:refreshRedDot()
	end
end

function Activity197View:_refreshComputer()
	local canGet = Activity197Model.instance:checkBigRewardCanGet()
	local hasGet = Activity197Model.instance:checkBigRewardHasGet()

	gohelper.setActive(self._goCanGet, canGet)
	gohelper.setActive(self._goHasGet, hasGet)
	gohelper.setActive(self._goUnknown, not canGet and not hasGet)
	gohelper.setActive(self._goUnknownProgress, not canGet and not hasGet)
end

function Activity197View:_refreshTopNodeList()
	for _, node in ipairs(self._topnodeList) do
		local isopen = Activity197Model.instance:checkPoolOpen(node.poolId)

		if isopen and node.poolId > self._lastOpenPoolId then
			self._lastOpenPoolId = node.poolId

			node.anim:Play("unlock", 0, 0)

			self._txtTips.text = luaLang("anniversary_activity_tip2")
			self._currentPoolId = self._lastOpenPoolId

			self._leftAnimator:Play("right", 0, 0)
			TaskDispatcher.runDelay(self._onSwitchAnimFinish, self, self._switchTime)
			self:showGetKeyTip()
		end

		gohelper.setActive(node.gounlock, isopen)
		gohelper.setActive(node.golocked, not isopen)

		local isSelect = node.poolId == self._currentPoolId

		gohelper.setActive(node.goselect, isSelect)

		local allGet = Activity197Model.instance:checkPoolGetAllReward(node.poolId)

		if allGet and not node.allGet then
			node.allGet = true

			node.anim:Play("finish", 0, 0)

			self._currentPoolId = self._lastOpenPoolId

			self._leftAnimator:Play("right", 0, 0)
			TaskDispatcher.runDelay(self._onSwitchAnimFinish, self, self._switchTime)
		end

		gohelper.setActive(node.gogetall, allGet)
	end
end

function Activity197View:_refreshRewardItems()
	local configList = Activity197Config.instance:getPoolConfigById(self._currentPoolId)

	for index, rewardItem in ipairs(self._rewardItems) do
		local co = configList[index]

		if co and not string.nilorempty(co.bonus) then
			local bonus = string.splitToNumber(co.bonus, "#")

			rewardItem.goitemcomp:setMOValue(bonus[1], bonus[2], bonus[3], nil, true)
		end

		local state = Activity197Model.instance:checkRewardReceied(self._currentPoolId, index)

		gohelper.setActive(rewardItem.goreceive, state)
	end
end

function Activity197View:updateSingleRewardItem(param)
	local poolId = param.poolId
	local index = param.gainId

	if poolId ~= self._currentPoolId then
		return
	end

	local item = self._rewardItems[index]

	function self._onvxglowFinish()
		local state = Activity197Model.instance:checkRewardReceied(self._currentPoolId, index)

		gohelper.setActive(item.goreceive, state)
		item.animHasGet:Play("open", 0, 0)
		self:_refreshTopNodeList()
	end

	gohelper.setActive(item.vxglow, true)
	AudioMgr.instance:trigger(AudioEnum.Va3Aact120.play_ui_molu_jlbn_level_pass)

	function self._delayFunc()
		TaskDispatcher.cancelTask(self._delayFunc, self)
		gohelper.setActive(item.vxglow, false)
		Activity197Controller.instance:popupRewardView()

		self._isPlayAnim = false
	end

	self:_refreshRedDot()
	TaskDispatcher.runDelay(self._delayFunc, self, self._vxItemGlowTime)
end

function Activity197View:_onRewardRefresh()
	if self._onvxglowFinish then
		self:_onvxglowFinish()

		self._onvxglowFinish = nil
	end

	if self._needShowTip then
		self:showGetKeyTip()

		self._needShowTip = false
	end
end

function Activity197View:_refreshProgress()
	if not Activity197Model.instance:checkStageOpen(self._actId) then
		return
	end

	local co = Activity197Config.instance:getStageConfig(self._actId, 1)
	local lastStageEndTime = TimeUtil.stringToTimestamp(co.endTime)

	self.remainsearchtime = lastStageEndTime - ServerTime.now()

	self:_updateStageProgress()
	TaskDispatcher.cancelTask(self._sendTaskRpc, self)

	local cansend = not Activity197Model.instance:checkBigRewardHasGet() and not Activity197Model.instance:checkBigRewardCanGet()

	if self.remainsearchtime > 0 and cansend then
		TaskDispatcher.runRepeat(self._sendTaskRpc, self, self._sendMsgTime)
	end
end

function Activity197View:_sendTaskRpc()
	TaskRpc.instance:sendGetTaskInfoRequest({
		TaskEnum.TaskType.Activity173
	}, self._onSendTaskBack, self)
end

function Activity197View:_onSendTaskBack()
	self:_refreshProgress()
end

function Activity197View:_updateStageProgress()
	if Activity197Model.instance:checkBigRewardHasGet() then
		self:_refreshComputer()

		self._imageprogress.fillAmount = 1

		return
	end

	if Activity197Model.instance:checkBigRewardCanGet() then
		self:_refreshComputer()
		self:_refreshRedDot()

		self._imageprogress.fillAmount = 1

		TaskDispatcher.cancelTask(self._sendTaskRpc, self)
	else
		self._imageprogress.fillAmount = Activity197Model.instance:getStageProgress(self._actId)
	end
end

function Activity197View:_refreshBtn()
	local rummageConsume = Activity197Config.instance:getRummageConsume()

	self._txtusekey.text = "-" .. rummageConsume

	local currency2 = CurrencyModel.instance:getCurrency(CurrencyEnum.CurrencyType.BulbCurrency)

	if currency2 then
		if not currency2.quantity then
			local bulbCount = 0

			self._txtusebubble.text = "×" .. GameUtil.numberDisplay(bulbCount)

			local allGet = Activity197Model.instance:checkPoolGetAllReward(self._currentPoolId)

			gohelper.setActive(self._btnKey.gameObject, not allGet)
			self:_refreshRedDot()
		end
	end
end

function Activity197View:showGetKeyTip()
	self._isShowTip = true

	self:_refreshBtn()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_screenplay_open)
	gohelper.setActive(self._goExtraTips, self._isShowTip)
	TaskDispatcher.runDelay(self.closeGetKeyTip, self, self._showTipsTime)
end

function Activity197View:closeGetKeyTip()
	TaskDispatcher.cancelTask(self.showGetKeyTip, self)

	self._isShowTip = false

	gohelper.setActive(self._goExtraTips, self._isShowTip)
end

function Activity197View:showGetKetProgress()
	self._isPlayAnim = true

	gohelper.setActive(self._goUnknown, false)
	gohelper.setActive(self._goUnknownProgress, true)
	self._animComputer:Play("open", 0, 0)

	local canGet = Activity197Model.instance:checkBigRewardCanGet()
	local hasGet = Activity197Model.instance:checkBigRewardHasGet()

	gohelper.setActive(self._goprogressunknown, not canGet and not hasGet)
	AudioMgr.instance:trigger(AudioEnum.VersionActivity2_2TianShiNaNa.play_ui_youyu_death)

	self._txtTips.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("anniversary_activitytip_1"), Activity197Model.instance:getOnceExploreKeyCount())

	TaskDispatcher.runDelay(self.flyKeyAnim, self, self._showTipsTime)
end

function Activity197View:flyKeyAnim()
	TaskDispatcher.cancelTask(self.flyKeyAnim, self)

	local canGet = Activity197Model.instance:checkBigRewardCanGet()
	local hasGet = Activity197Model.instance:checkBigRewardHasGet()

	if canGet or hasGet then
		gohelper.setActive(self._goCanGet, canGet)
		gohelper.setActive(self._goHasGet, hasGet)
		gohelper.setActive(self._goUnknown, not canGet and not hasGet)
		gohelper.setActive(self._goUnknownProgress, not canGet and not hasGet)
	else
		gohelper.setActive(self._goUnknown, true)
		gohelper.setActive(self._goUnknownProgress, false)
	end

	Activity197Rpc.instance:sendAct197ExploreReqvest(self._actId, Activity197Enum.FindType.All)
	gohelper.setActive(self._govxkey, true)
	TaskDispatcher.runDelay(self._vxkeyAnim, self, 0.5)
end

function Activity197View:_vxkeyAnim()
	TaskDispatcher.cancelTask(self._vxkeyAnim, self)
	gohelper.setActive(self._govxkey, false)

	self._needShowTip = true
	self._isPlayAnim = false
end

function Activity197View:_getRewardAnim()
	self._isPlayAnim = true

	gohelper.setActive(self._govxFresh, true)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_doom_disappear)
	TaskDispatcher.runDelay(self._vxFreshAnim, self, self._vxfreshTime)
end

function Activity197View:_vxFreshAnim()
	TaskDispatcher.cancelTask(self._vxFreshAnim, self)
	gohelper.setActive(self._govxFresh, false)
	Activity197Rpc.instance:sendAct197RummageRequest(self._actId, self._currentPoolId)
end

function Activity197View:_checkNeedShowBubbleVx()
	if Activity197Model.instance:getShowBubbleVx() then
		TaskDispatcher.runDelay(self._showBubbleVx, self, 0.5)
	end
end

function Activity197View:_showBubbleVx()
	TaskDispatcher.cancelTask(self._showBubbleVx, self)
	gohelper.setActive(self._govxbubble, true)
	TaskDispatcher.runDelay(self._vxBubbleAnim, self, 0.5)
end

function Activity197View:_vxBubbleAnim()
	TaskDispatcher.cancelTask(self._vxBubbleAnim, self)
	gohelper.setActive(self._govxbubble, false)
	Activity197Model.instance:resetShowBubbleVx()
end

function Activity197View:checkKeyReddot()
	if Activity197Model.instance:checkAllPoolRewardGet() then
		return false
	end

	return Activity197Model.instance:canRummage()
end

function Activity197View:checkBubbleReddot()
	if Activity197Model.instance:checkAllPoolRewardGet() then
		return false
	end

	return Activity197Model.instance:canExplore()
end

function Activity197View:onClose()
	TaskDispatcher.cancelTask(self._sendTaskRpc, self)
	TaskDispatcher.cancelTask(self._onSwitchAnimFinish, self)
	TaskDispatcher.cancelTask(self._vxkeyAnim, self)
	TaskDispatcher.cancelTask(self._vxFreshAnim, self)
	TaskDispatcher.cancelTask(self._delayFunc, self)
	TaskDispatcher.cancelTask(self._vxBubbleAnim, self)
	TaskDispatcher.cancelTask(self._showBubbleVx, self)

	if self._topnodeList and #self._topnodeList > 0 then
		for _, node in ipairs(self._topnodeList) do
			node.btn:RemoveClickListener()
		end
	end
end

function Activity197View:onDestroyView()
	TaskDispatcher.cancelTask(self._sendTaskRpc, self)
	TaskDispatcher.cancelTask(self.showGetKeyTip, self)
end

function Activity197View:onRefreshActivity()
	local status = ActivityHelper.getActivityStatus(self._actId)

	if status == ActivityEnum.ActivityStatus.NotOnLine or status == ActivityEnum.ActivityStatus.Expired then
		MessageBoxController.instance:showSystemMsgBox(MessageBoxIdDefine.EndActivity, MsgBoxEnum.BoxType.Yes, ActivityLiveMgr.yesCallback)

		return
	end
end

return Activity197View
