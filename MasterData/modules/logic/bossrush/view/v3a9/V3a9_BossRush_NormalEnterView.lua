-- chunkname: @modules/logic/bossrush/view/v3a9/V3a9_BossRush_NormalEnterView.lua

module("modules.logic.bossrush.view.v3a9.V3a9_BossRush_NormalEnterView", package.seeall)

local V3a9_BossRush_NormalEnterView = class("V3a9_BossRush_NormalEnterView", LuaCompBase)

function V3a9_BossRush_NormalEnterView:init(go)
	self.viewGO = go
	self._simageFullBG = gohelper.findChildSingleImage(self.viewGO, "#simage_FullBG")
	self._simageBOSS1 = gohelper.findChildSingleImage(self.viewGO, "BOSS/#simage_BOSS1")
	self._simageBOSS2 = gohelper.findChildSingleImage(self.viewGO, "BOSS/#simage_BOSS2")
	self._simageBOSS3 = gohelper.findChildSingleImage(self.viewGO, "BOSS/#simage_BOSS3")
	self._simageTitle = gohelper.findChildSingleImage(self.viewGO, "Left/#simage_Title")
	self._txtLimitTime = gohelper.findChildText(self.viewGO, "Left/LimitTime/#txt_LimitTime")
	self._btnStore = gohelper.findChildButtonWithAudio(self.viewGO, "Right/Store/#btn_Store")
	self._simageProp = gohelper.findChildSingleImage(self.viewGO, "Right/Store/#btn_Store/#simage_Prop")
	self._txtNum = gohelper.findChildText(self.viewGO, "Right/Store/#btn_Store/#txt_Num")
	self._gorank = gohelper.findChild(self.viewGO, "Right/#go_rank")
	self._btnNormal = gohelper.findChildButtonWithAudio(self.viewGO, "Right/#btn_Normal/click")
	self._btnUnOpen = gohelper.findChildButtonWithAudio(self.viewGO, "Right/#btn_UnOpen/click")
	self._goreddot = gohelper.findChild(self.viewGO, "Right/#btn_Normal/#go_reddot")
	self._txtTips = gohelper.findChildText(self.viewGO, "Right/#btn_UnOpen/image_TIps/#txt_Tips")
	self._animator = self.viewGO:GetComponent(typeof(UnityEngine.Animator))
	self._anim = self.viewGO:GetComponent(typeof(UnityEngine.Animator))

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V3a9_BossRush_NormalEnterView:addEventListeners()
	self._btnStore:AddClickListener(self._btnStoreOnClick, self)
	self._btnNormal:AddClickListener(self._btnNormalOnClick, self)
	self._btnUnOpen:AddClickListener(self._btnUnOpenOnClick, self)
	self.addEventCb(self, ActivityController.instance, ActivityEvent.RefreshActivityState, self._refreshStoreTag, self)
	self.addEventCb(self, RedDotController.instance, RedDotEvent.UpdateActTag, self._refreshStoreTag, self)
	self.addEventCb(self, CurrencyController.instance, CurrencyEvent.CurrencyChange, self._refreshCurrency, self)
	self.addEventCb(self, BossRushController.instance, BossRushEvent.OnEnterStoreView, self._refreshStoreTag, self)
	self.addEventCb(self, BossRushController.instance, BossRushEvent.onReceiveAct128GetExpReply, self.playRankBtnAnim, self)
	self.addEventCb(self, BossRushController.instance, BossRushEvent.OnReceiveGet128InfosReply, self._onReceiveGet128InfosReply, self)
end

function V3a9_BossRush_NormalEnterView:removeEventListeners()
	self._btnStore:RemoveClickListener()
	self._btnNormal:RemoveClickListener()
	self._btnUnOpen:RemoveClickListener()
	self.removeEventCb(self, ActivityController.instance, ActivityEvent.RefreshActivityState, self._refreshStoreTag, self)
	self.removeEventCb(self, RedDotController.instance, RedDotEvent.UpdateActTag, self._refreshStoreTag, self)
	self.removeEventCb(self, CurrencyController.instance, CurrencyEvent.CurrencyChange, self._refreshCurrency, self)
	self.removeEventCb(self, BossRushController.instance, BossRushEvent.OnEnterStoreView, self._refreshStoreTag, self)
	self.removeEventCb(self, BossRushController.instance, BossRushEvent.onReceiveAct128GetExpReply, self.playRankBtnAnim, self)
	self.removeEventCb(self, BossRushController.instance, BossRushEvent.OnReceiveGet128InfosReply, self._onReceiveGet128InfosReply, self)
end

function V3a9_BossRush_NormalEnterView:_btnUnOpenOnClick()
	self:_enterActivity()
end

function V3a9_BossRush_NormalEnterView:_btnStoreOnClick()
	BossRushController.instance:openBossRushStoreView(self.actId)
end

function V3a9_BossRush_NormalEnterView:_btnNormalOnClick()
	self:_enterActivity()
end

function V3a9_BossRush_NormalEnterView:_enterActivity()
	if self._isInfo then
		V3a9_BossRushController.instance:openV3a9MainView()
	end
end

function V3a9_BossRush_NormalEnterView:onShow(isShow)
	gohelper.setActive(self.viewGO, isShow)

	if isShow then
		self._anim:Play("open", 0, 0)
	end
end

function V3a9_BossRush_NormalEnterView:_editableInitView()
	self._goStoreTip = gohelper.findChild(self.viewGO, "Right/Store/image_Tips")
	self._txtStore = gohelper.findChildText(self.viewGO, "Right/Store/#btn_Store/txt_Store")
	self._txtActDesc = gohelper.findChildText(self.viewGO, "Left/txtDescr")

	local nameCn, nameEn = V1a6_BossRush_StoreModel.instance:getStoreGroupName(StoreEnum.BossRushStore.ManeTrust)

	self._txtStore.text = nameCn
	self._itemObjects = {}

	local actInfoMo = BossRushModel.instance:getActivityMo()

	if actInfoMo then
		self._txtActDesc.text = actInfoMo.config.actDesc

		local rewards = GameUtil.splitString2(actInfoMo.config.activityBonus, true)

		if rewards then
			for i, reward in ipairs(rewards) do
				local item = self._itemObjects[i]

				if not item then
					item = IconMgr.instance:getCommonPropItemIcon(self._gorewardcontent)

					table.insert(self._itemObjects, item)
				end

				item:setMOValue(reward[1], reward[2], 1)
				item:isShowCount(false)
			end
		end

		if actInfoMo.config.openId and actInfoMo.config.openId > 0 then
			self._txtTips.text = OpenHelper.getActivityUnlockTxt(actInfoMo.config.openId)
		end
	end

	local activityId = BossRushConfig.instance:getActivityId()

	if ActivityHelper.isOpen(activityId) then
		BossRushRpc.instance:sendGet128InfosRequest()
	end

	self:_initRank()
end

function V3a9_BossRush_NormalEnterView:_initRank()
	if self.loader then
		self.loader:dispose()

		self.loader = nil
	end

	self.loader = MultiAbLoader.New()

	self.loader:addPath(BossRushEnum.ResPath.v3a2_bossrush_rankbtn)
	self.loader:startLoad(self.loadResFinish, self)
end

function V3a9_BossRush_NormalEnterView:loadResFinish()
	local assetItem = self.loader:getAssetItem(BossRushEnum.ResPath.v3a2_bossrush_rankbtn)
	local res = assetItem:GetResource(BossRushEnum.ResPath.v3a2_bossrush_rankbtn)
	local go = gohelper.clone(res, self._gorank)

	self._rankBtn = MonoHelper.addNoUpdateLuaComOnceToGo(go, V3a2_BossRush_RankBtn)

	if self._isInfo then
		self._rankBtn:refreshUI()
	end
end

function V3a9_BossRush_NormalEnterView:onStart()
	self.actId = BossRushConfig.instance:getActivityId()

	local actInfoMo = ActivityModel.instance:getActivityInfo()[self.actId]
	local isOpen = actInfoMo and ActivityHelper.getActivityStatus(self.actId) == ActivityEnum.ActivityStatus.Normal
	local goGo = gohelper.findChild(self.viewGO, "Right/#btn_Normal")
	local goUnOpen = gohelper.findChild(self.viewGO, "Right/#btn_UnOpen")
	local goreddot = gohelper.findChild(self.viewGO, "Right/#btn_Normal/#go_reddot")

	gohelper.setActive(goGo, isOpen)
	gohelper.setActive(goUnOpen, not isOpen)

	local defineId = RedDotEnum.DotNode.BossRushEnter

	RedDotController.instance:addRedDot(goreddot, defineId)

	self._isInfo = false

	BossRushRpc.instance:sendGet128InfosRequest()

	if not actInfoMo then
		self._txtLimitTime.text = ""
	end

	self:_refreshCurrency()
	self:_refreshTime()
	V1a6_BossRush_StoreModel.instance:readAllStoreGroupNewData()
	V1a6_BossRush_StoreModel.instance:checkStoreNewGoods()
	self:_refreshStoreTag()
end

function V3a9_BossRush_NormalEnterView:onDestroy()
	if self.rewardItems then
		for k, v in pairs(self.rewardItems) do
			v:onDestroy()
		end

		self.rewardItems = nil
	end

	if self.loader then
		self.loader:dispose()

		self.loader = nil
	end
end

function V3a9_BossRush_NormalEnterView:_refreshStoreTag()
	local isNew = V1a6_BossRush_StoreModel.instance:isHasNewGoodsInStore()

	gohelper.setActive(self._goStoreTip, isNew)
end

function V3a9_BossRush_NormalEnterView:playRankBtnAnim()
	if self._rankBtn then
		self._rankBtn:playAnim()
	end
end

function V3a9_BossRush_NormalEnterView:_onReceiveGet128InfosReply()
	if self._rankBtn then
		self._rankBtn:refreshUI()
	end

	self._isInfo = true
end

function V3a9_BossRush_NormalEnterView:_refreshTime()
	local actId = V3a9_BossRushModel.instance:getActModeActId()
	local actInfoMo = ActivityModel.instance:getActMO(actId)

	if actInfoMo then
		local offsetSecond = actInfoMo:getRealStartTimeStamp() - ServerTime.now()

		gohelper.setActive(self._txtLimitTime.gameObject, offsetSecond > 0)

		if offsetSecond > 0 then
			local dateStr = TimeUtil.SecondToActivityTimeFormat(offsetSecond)

			self._txtLimitTime.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("p_v3a9_bossrush_actmode_startime_tip"), dateStr)
		end
	end
end

function V3a9_BossRush_NormalEnterView:_refreshCurrency()
	local count = V1a6_BossRush_StoreModel.instance:getCurrencyCount(self.actId)

	if count then
		self._txtNum.text = count
	end
end

function V3a9_BossRush_NormalEnterView:everySecondCall()
	self:_refreshTime()
end

return V3a9_BossRush_NormalEnterView
