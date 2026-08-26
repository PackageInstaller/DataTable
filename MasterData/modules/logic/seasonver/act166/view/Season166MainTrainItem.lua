-- chunkname: @modules/logic/seasonver/act166/view/Season166MainTrainItem.lua

module("modules.logic.seasonver.act166.view.Season166MainTrainItem", package.seeall)

local Season166MainTrainItem = class("Season166MainTrainItem", LuaCompBase)

function Season166MainTrainItem:ctor(param)
	self.param = param
end

function Season166MainTrainItem:init(go)
	self:__onInit()

	self.go = go
	self.actId = self.param.actId
	self.trainId = self.param.trainId
	self.config = self.param.config
	self.anim = self.go:GetComponent(gohelper.Type_Animator)
	self.goFinish = gohelper.findChild(self.go, "go_finish")
	self.imageFinishBg = gohelper.findChildImage(self.go, "go_finish/image_finishbg")
	self.goFinishEffect = gohelper.findChild(self.go, "go_finish/fe_01")
	self.goSpFinishEffect = gohelper.findChild(self.go, "go_finish/fe_02")
	self.govxEffect1 = gohelper.findChild(self.go, "vx_ink_01")
	self.govxEffect2 = gohelper.findChild(self.go, "vx_ink_02")
	self.goNormal = gohelper.findChild(self.go, "go_normal")
	self.imageNormalBg = gohelper.findChildImage(self.go, "go_normal/image_normalbg")
	self.goLock = gohelper.findChild(self.go, "go_lock")
	self.golockbg = gohelper.findChild(self.go, "go_lock/bg")
	self.imageLockBg = gohelper.findChildImage(self.go, "go_lock/bg")
	self.goLockMask = gohelper.findChild(self.go, "go_lock/go_lockMask")
	self.gounlockTip = gohelper.findChild(self.go, "go_lock/unlockTip")
	self.txtStarNum = gohelper.findChildText(self.go, "go_lock/unlockTip/txt_starNum")
	self.btnClick = gohelper.findChildButtonWithAudio(self.go, "btn_click")

	self:initTitleInfo(self.goFinish)
	self:initTitleInfo(self.goNormal)
	self:initTitleInfo(self.goLock)
end

function Season166MainTrainItem:addEventListeners()
	self.btnClick:AddClickListener(self.onClickTrainItem, self)
end

function Season166MainTrainItem:onClickTrainItem()
	local param = {}

	param.actId = self.actId
	param.trainId = self.trainId
	param.config = self.config
	param.viewType = Season166Enum.WordTrainType

	if not self.canUnlock then
		if not self.isUnlockTime and self.config.type == Season166Enum.TrainSpType then
			GameFacade.showToast(ToastEnum.Season166TrainTimeLock)
		else
			GameFacade.showToast(ToastEnum.Season166TrainStarLock)
		end
	else
		Season166Controller.instance:openSeasonTrainView(param)
	end
end

function Season166MainTrainItem:refreshUI()
	self.isFinish = Season166TrainModel.instance:checkIsFinish(self.actId, self.trainId)

	local unlockTrainMap = Season166TrainModel.instance:getUnlockTrainInfoMap(self.actId)

	self.canUnlock = unlockTrainMap[self.trainId]

	if self.canUnlock then
		self.unlockState = Season166Enum.UnlockState or Season166Enum.LockState
	end

	self.isUnlockTime = Season166TrainModel.instance:isHardEpisodeUnlockTime(self.actId)
	self.txtStarNum.text = self.config.needStar

	local isSpEpisode = self.config.type == Season166Enum.TrainSpType
	local normalIconName = isSpEpisode and "season_main_stage_2_0" or "season_main_stage_1_0"
	local finishIconName = isSpEpisode and "season_main_stage_2_1" or "season_main_stage_1_2"

	UISpriteSetMgr.instance:setSeason166Sprite(self.imageFinishBg, finishIconName, true)
	UISpriteSetMgr.instance:setSeason166Sprite(self.imageNormalBg, normalIconName, true)
	UISpriteSetMgr.instance:setSeason166Sprite(self.imageLockBg, normalIconName, true)
	gohelper.setActive(self.goFinish, self.isFinish)

	if isSpEpisode then
		gohelper.setActive(self.gounlockTip, self.isUnlockTime)
	else
		gohelper.setActive(self.gounlockTip, not self.canUnlock)
	end

	gohelper.setActive(self.goLockMask, not self.isUnlockTime and isSpEpisode)
	gohelper.setActive(self.goLock, not self.canUnlock)
	gohelper.setActive(self.govxEffect1, self.canUnlock)
	gohelper.setActive(self.govxEffect2, self.canUnlock)
	ZProj.UGUIHelper.SetGrayscale(self.golockbg, not self.canUnlock)
	gohelper.setActive(self.goNormal, self.canUnlock and not self.isFinish)
	gohelper.setActive(self.goSpFinishEffect, self.isFinish and isSpEpisode)
	gohelper.setActive(self.goFinishEffect, self.isFinish and not isSpEpisode)
end

function Season166MainTrainItem:initTitleInfo(stateItem)
	local txtTitle = gohelper.findChildText(stateItem, "txt_title")
	local txtIndex = gohelper.findChildText(stateItem, "txt_index")

	txtTitle.text = self.config.name
	txtIndex.text = string.format("St.%d", self.trainId)
end

function Season166MainTrainItem:getUnlockState()
	return self.unlockState
end

function Season166MainTrainItem:refreshUnlockState(saveUnlockState)
	if self.canUnlock and self.unlockState ~= saveUnlockState then
		if self.isFinish then
			self.anim:Play(UIAnimationName.Finish, 0, 0)
			AudioMgr.instance:trigger(AudioEnum.VersionActivity2_2Season166.play_ui_resonate_fm)
		else
			self.anim:Play(UIAnimationName.Unlock, 0, 0)
			AudioMgr.instance:trigger(AudioEnum.VersionActivity2_2Season166.play_ui_wangshi_argus_level_open)
		end
	end
end

function Season166MainTrainItem:getFinishState()
	return self.isFinish
end

function Season166MainTrainItem:playFinishEffect()
	if self.isFinish then
		self.anim:Play(UIAnimationName.Finish, 0, 0)
		AudioMgr.instance:trigger(AudioEnum.VersionActivity2_2Season166.play_ui_resonate_fm)
	end
end

function Season166MainTrainItem:removeEventListeners()
	self.btnClick:RemoveClickListener()
end

function Season166MainTrainItem:destroy()
	self:__onDispose()
end

return Season166MainTrainItem
