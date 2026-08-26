-- chunkname: @modules/logic/versionactivity2_1/aergusi/view/AergusiEnterView.lua

module("modules.logic.versionactivity2_1.aergusi.view.AergusiEnterView", package.seeall)

local AergusiEnterView = class("AergusiEnterView", VersionActivityEnterBaseSubView)

function AergusiEnterView:onInitView()
	self._simageFullBG = gohelper.findChildSingleImage(self.viewGO, "#simage_FullBG")
	self._simageTitle = gohelper.findChildSingleImage(self.viewGO, "Right/#simage_Title")
	self._txtLimitTime = gohelper.findChildText(self.viewGO, "Right/image_LimitTimeBG/#txt_LimitTime")
	self._txtDescr = gohelper.findChildText(self.viewGO, "Right/#txt_Descr")
	self._gorewards = gohelper.findChild(self.viewGO, "Right/scroll_Reward/Viewport/#go_rewards")
	self._btnEnter = gohelper.findChildButtonWithAudio(self.viewGO, "Right/#btn_Enter")
	self._goreddot = gohelper.findChild(self.viewGO, "Right/#btn_Enter/#go_reddot")
	self._btnLocked = gohelper.findChildButtonWithAudio(self.viewGO, "Right/#btn_Locked")
	self._txtUnLocked = gohelper.findChildText(self.viewGO, "Right/#btn_Locked/#txt_UnLocked")
	self._goTry = gohelper.findChild(self.viewGO, "Right/#go_Try")
	self._goTips = gohelper.findChild(self.viewGO, "Right/#go_Try/#go_Tips")
	self._simageReward = gohelper.findChildSingleImage(self.viewGO, "Right/#go_Try/#go_Tips/#simage_Reward")
	self._btnTrial = gohelper.findChildButtonWithAudio(self.viewGO, "Right/#go_Try/image_TryBtn")
	self._txtNum = gohelper.findChildTextMesh(self.viewGO, "Right/#go_Try/#go_Tips/#txt_Num")
	self._btnItem = gohelper.findChildButtonWithAudio(self.viewGO, "Right/#go_Try/#go_Tips/#btn_item")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function AergusiEnterView:addEvents()
	self._btnEnter:AddClickListener(self._btnEnterOnClick, self)
	self._btnLocked:AddClickListener(self._btnLockedOnClick, self)
	self._btnTrial:AddClickListener(self._btnTrailOnClick, self)
	self._btnItem:AddClickListener(self._btnItemOnClick, self)
end

function AergusiEnterView:removeEvents()
	self._btnEnter:RemoveClickListener()
	self._btnLocked:RemoveClickListener()
	self._btnTrial:RemoveClickListener()
	self._btnItem:RemoveClickListener()
end

function AergusiEnterView:_btnEnterOnClick()
	AergusiController.instance:openAergusiLevelView()
end

function AergusiEnterView:_btnLockedOnClick()
	local toastId, toastParamList = OpenHelper.getToastIdAndParam(self.actCo.openId)

	if toastId and toastId ~= 0 then
		GameFacade.showToastWithTableParam(toastId, toastParamList)
	end
end

function AergusiEnterView:_btnTrailOnClick()
	if ActivityHelper.getActivityStatus(VersionActivity2_1Enum.ActivityId.Aergusi) == ActivityEnum.ActivityStatus.Normal then
		local episodeId = self.actCo.tryoutEpisode

		if episodeId <= 0 then
			logError("没有配置对应的试用关卡")

			return
		end

		local config = DungeonConfig.instance:getEpisodeCO(episodeId)

		DungeonFightController.instance:enterFight(config.chapterId, episodeId)
	else
		self:_clickLock()
	end
end

function AergusiEnterView:_btnItemOnClick()
	MaterialTipController.instance:showMaterialInfo(MaterialEnum.MaterialType.Currency, CurrencyEnum.CurrencyType.FreeDiamondCoupon, false, nil, false)
end

function AergusiEnterView:_editableInitView()
	self.actCo = ActivityConfig.instance:getActivityCo(VersionActivity2_1Enum.ActivityId.Aergusi)
	self._txtDescr.text = self.actCo.actDesc

	local episodeId = self.actCo.tryoutEpisode
	local getNum = 0

	if episodeId > 0 then
		local bonus = DungeonModel.instance:getEpisodeFirstBonus(episodeId)

		getNum = bonus[1] and bonus[1][3] or 0
	end

	self._txtNum.text = getNum

	RedDotController.instance:addRedDot(self._goreddot, RedDotEnum.DotNode.V2a1AergusiTaskRed, VersionActivity2_1Enum.ActivityId.Aergusi)
end

function AergusiEnterView:onOpen()
	AergusiEnterView.super.onOpen(self)
	self:_refreshTime()
end

function AergusiEnterView:onClose()
	AergusiEnterView.super.onClose(self)
end

function AergusiEnterView:everySecondCall()
	self:_refreshTime()
end

function AergusiEnterView:_refreshTime()
	local actInfoMo = ActivityModel.instance:getActivityInfo()[VersionActivity2_1Enum.ActivityId.Aergusi]

	if actInfoMo then
		local offsetSecond = actInfoMo:getRealEndTimeStamp() - ServerTime.now()

		gohelper.setActive(self._txtLimitTime.gameObject, offsetSecond > 0)

		if offsetSecond > 0 then
			self._txtLimitTime.text = TimeUtil.SecondToActivityTimeFormat(offsetSecond)
		end

		local isLock = ActivityHelper.getActivityStatus(VersionActivity2_1Enum.ActivityId.Aergusi) ~= ActivityEnum.ActivityStatus.Normal

		gohelper.setActive(self._btnEnter, not isLock)
		gohelper.setActive(self._btnLocked, isLock)
	end
end

return AergusiEnterView
