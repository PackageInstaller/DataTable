-- chunkname: @modules/logic/seasonver/act166/view/information/Season166InformationReportItem.lua

module("modules.logic.seasonver.act166.view.information.Season166InformationReportItem", package.seeall)

local Season166InformationReportItem = class("Season166InformationReportItem", LuaCompBase)

function Season166InformationReportItem:init(go)
	self:__onInit()

	self.go = go
	self.animItem = self.go:GetComponent(typeof(UnityEngine.Animator))

	local goLine = gohelper.findChild(self.go, "image_Line")

	self.lockedCtrl = goLine:GetComponent(typeof(ZProj.MaterialPropsCtrl))
	self.animPlayer = SLFramework.AnimatorPlayer.Get(goLine)
	self.simagePic = gohelper.findChildSingleImage(self.go, "image_Line/image_ReportPic")
	self.goLock = gohelper.findChild(self.go, "image_Line/#go_Locked")
	self.goLockTips = gohelper.findChild(self.goLock, "#go_LockTips")
	self.txtLockTips = gohelper.findChildTextMesh(self.goLock, "#go_LockTips/image_LockTips/#txt_LockTips")
	self.goLockIcon = gohelper.findChild(self.goLock, "image_LockedIcon")
	self.simagePicLocked = gohelper.findChildSingleImage(self.goLock, "image_ReportLockedPic")
	self.goSchdule = gohelper.findChild(self.go, "Schdule")
	self.animSchdule = self.goSchdule:GetComponent(typeof(UnityEngine.Animator))
	self.goSchduleItem = gohelper.findChild(self.goSchdule, "#go_Item")

	gohelper.setActive(self.goSchduleItem, false)

	self.schduleItems = {}
	self.btnClick = gohelper.findButtonWithAudio(self.go)
	self.goreddot = gohelper.findChild(self.go, "image_Line/#go_reddot")
	self.gonewReddot = gohelper.findChild(self.go, "image_Line/#go_infoNewReddot")
	self.canShowNew = false
end

function Season166InformationReportItem:addEventListeners()
	self.btnClick:AddClickListener(self.onClickItem, self)
	Season166Controller.instance:registerCallback(Season166Event.OnAnalyInfoSuccess, self.refreshReddot, self)
end

function Season166InformationReportItem:onClickItem()
	if not self.config then
		return
	end

	local actInfo = Season166Model.instance:getActInfo(self.activityId)
	local infoMo = actInfo and actInfo:getInformationMO(self.infoId)

	if not infoMo then
		GameFacade.showToast(ToastEnum.Season166ReportNotUnlock)

		return
	end

	local param = {}

	param.actId = self.activityId
	param.infoId = self.infoId
	param.unlockState = self.unlockState

	ViewMgr.instance:openView(ViewName.Season166InformationAnalyView, param)

	self.canShowNew = false

	Season166Controller.instance:dispatchEvent(Season166Event.ClickInfoReportItem, param)
	self:refreshUnlockState(Season166Enum.UnlockState)
end

function Season166InformationReportItem:refreshUI(config)
	self.config = config

	gohelper.setActive(self.go, config ~= nil)

	if not config then
		return
	end

	self.activityId = self.config.activityId
	self.infoId = self.config.infoId

	self.simagePic:LoadImage(string.format("singlebg/seasonver/season_infoanalyze_reportpic_%s_1.png", self.infoId))
	self.simagePicLocked:LoadImage(string.format("singlebg/seasonver/season_infoanalyze_reportpic_%s_0.png", self.infoId))

	local actInfo = Season166Model.instance:getActInfo(self.activityId)
	local infoMo = actInfo and actInfo:getInformationMO(self.infoId)

	if infoMo then
		self.unlockState = Season166Enum.UnlockState or Season166Enum.LockState
	end

	gohelper.setActive(self.goLockIcon, not infoMo)
	self:refreshSchdule(infoMo)
	gohelper.setActive(self.goLockTips, self.unlockState == Season166Enum.LockState)

	if self.unlockState == Season166Enum.LockState then
		self.txtLockTips.text = self.config.unlockDes
	end

	self:playOpenAnim()
end

function Season166InformationReportItem:playOpenAnim()
	if self.hasPlayOpen then
		return
	end

	self.hasPlayOpen = true

	self.animItem:SetBool("isUnlock", self.unlockState == Season166Enum.UnlockState)

	if self.unlockState == Season166Enum.UnlockState then
		self.animItem:Play("open")
	else
		self.animItem:Play("unlock")
	end
end

function Season166InformationReportItem:refreshSchdule(info)
	if not info then
		gohelper.setActive(self.goSchdule, false)
		self:_setImgValue(0)

		return
	end

	gohelper.setActive(self.goSchdule, true)

	local analys = Season166Config.instance:getSeasonInfoAnalys(self.activityId, self.infoId) or {}

	for i = 1, math.max(#self.schduleItems, #analys) do
		local item = self.schduleItems[i]

		item = item or self:createSchduleItem(i)

		self:refreshSchduleItem(item, analys[i], info.stage)
	end

	local analyCount = #analys
	local value = info.stage / analyCount

	self:_setImgValue(value)
end

function Season166InformationReportItem:_setImgValue(value)
	self.lockedCtrl:GetIndexProp(2, 2)

	self.lockedCtrl.vector_03 = Vector4.New(value, 0.05, 0, 0)

	self.lockedCtrl:SetIndexProp(2, 2)
end

function Season166InformationReportItem:createSchduleItem(index)
	local item = self:getUserDataTb_()

	item.go = gohelper.cloneInPlace(self.goSchduleItem, string.format("schdule%s", index))
	item.goStatus0 = gohelper.findChild(item.go, "image_status0")
	item.goStatus = gohelper.findChild(item.go, "#image_status")
	self.schduleItems[index] = item

	return item
end

function Season166InformationReportItem:refreshSchduleItem(item, analyConfig, curStage)
	if not analyConfig then
		gohelper.setActive(item.go, false)

		return
	end

	gohelper.setActive(item.go, true)
	gohelper.setActive(item.goStatus, curStage >= analyConfig.stage)
end

function Season166InformationReportItem:refreshUnlockState(saveUnlockState)
	self.canShowNew = self.unlockState == Season166Enum.UnlockState and self.unlockState ~= saveUnlockState

	self:refreshReddot()
end

function Season166InformationReportItem:refreshUnlockAnimState(tab)
	if not tab[self.infoId] then
		if tab[self.infoId] == Season166Enum.LockState and self.unlockState == Season166Enum.UnlockState then
			local actInfo = Season166Model.instance:getActInfo(self.activityId)
			local infoMo = actInfo and actInfo:getInformationMO(self.infoId)

			if infoMo.stage == 0 then
				Season166Model.instance:setLocalPrefsTab(Season166Enum.ReportUnlockAnimLocalSaveKey, self.infoId, Season166Enum.UnlockState)
				gohelper.setActive(self.goLockIcon, true)
				gohelper.setActive(self.goSchdule, false)
				TaskDispatcher.runDelay(self._playUnlockAnim, self, 1.6)
			end
		end
	end
end

function Season166InformationReportItem:_playUnlockAnim()
	AudioMgr.instance:trigger(AudioEnum.Season166.play_ui_wangshi_argus_level_open)
	self.animPlayer:Play("unlock", self.onUnlockAnimPlayFinish, self)
	gohelper.setActive(self.goSchdule, true)
	self.animSchdule:Play("open")
end

function Season166InformationReportItem:onUnlockAnimPlayFinish()
	gohelper.setActive(self.goLockIcon, false)
end

function Season166InformationReportItem:refreshFinishAnimState(tab)
	if self.unlockState == Season166Enum.LockState then
		return
	end

	if not tab[self.infoId] then
		local state = Season166Enum.LockState
		local analys = Season166Config.instance:getSeasonInfoAnalys(self.activityId, self.infoId) or {}
		local actInfo = Season166Model.instance:getActInfo(self.activityId)
		local infoMo = actInfo and actInfo:getInformationMO(self.infoId)
		local isFinish = infoMo.stage >= #analys

		if state == Season166Enum.LockState and isFinish then
			Season166Model.instance:setLocalPrefsTab(Season166Enum.ReportFinishAnimLocalSaveKey, self.infoId, Season166Enum.UnlockState)
			gohelper.setActive(self.goLock, true)
			AudioMgr.instance:trigger(AudioEnum.Season166.play_ui_checkpoint_unlock)
			self.animPlayer:Play("finish", self.onFinishAnimPlayFinish, self)
		end
	end
end

function Season166InformationReportItem:onFinishAnimPlayFinish()
	return
end

function Season166InformationReportItem:refreshReddot()
	RedDotController.instance:addRedDot(self.goreddot, RedDotEnum.DotNode.Season166InfoSmallReward, self.infoId, self.checkReddotShow, self)
end

function Season166InformationReportItem:checkReddotShow(redDotIcon)
	redDotIcon:defaultRefreshDot()

	if self.canShowNew then
		gohelper.setActive(self.gonewReddot, true)
		gohelper.setActive(self.goreddot, false)
	else
		gohelper.setActive(self.goreddot, true)
		gohelper.setActive(self.gonewReddot, false)
		redDotIcon:showRedDot(RedDotEnum.Style.Normal)
	end
end

function Season166InformationReportItem:removeEventListeners()
	self.btnClick:RemoveClickListener()
	Season166Controller.instance:unregisterCallback(Season166Event.OnAnalyInfoSuccess, self.refreshReddot, self)
end

function Season166InformationReportItem:onDestroy()
	TaskDispatcher.cancelTask(self._playUnlockAnim, self)
	self.simagePic:UnLoadImage()
	self.simagePicLocked:UnLoadImage()
	self:__onDispose()
end

return Season166InformationReportItem
