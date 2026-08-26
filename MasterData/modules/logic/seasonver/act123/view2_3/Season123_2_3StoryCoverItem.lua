-- chunkname: @modules/logic/seasonver/act123/view2_3/Season123_2_3StoryCoverItem.lua

module("modules.logic.seasonver.act123.view2_3.Season123_2_3StoryCoverItem", package.seeall)

local Season123_2_3StoryCoverItem = class("Season123_2_3StoryCoverItem", LuaCompBase)

function Season123_2_3StoryCoverItem:ctor(param)
	self.param = param
end

function Season123_2_3StoryCoverItem:init(go)
	self:__onInit()

	self.go = go
	self.storyId = self.param.storyId
	self.config = self.param.storyConfig
	self.actId = self.param.actId
	self.canvasGroup = gohelper.findChild(self.go, "go_root"):GetComponent(typeof(UnityEngine.CanvasGroup))
	self.txtStageNum = gohelper.findChildText(self.go, "go_root/NumMask/txt_Num")
	self.txtTitle = gohelper.findChildText(self.go, "go_root/txt_Title")
	self.txtTitleEn = gohelper.findChildText(self.go, "go_root/txt_TitleEn")
	self.goArrow = gohelper.findChild(self.go, "go_root/go_arrow")
	self.goLocked = gohelper.findChild(self.go, "go_Locked")
	self.animLocked = ZProj.ProjAnimatorPlayer.Get(self.goLocked)
	self.btnClick = gohelper.findChildButtonWithAudio(self.go, "btn_click")
end

function Season123_2_3StoryCoverItem:addEventListeners()
	self.btnClick:AddClickListener(self.onClickCoverItem, self)
end

function Season123_2_3StoryCoverItem:removeEventListeners()
	self.btnClick:RemoveClickListener()
end

Season123_2_3StoryCoverItem.unlockDelayTime = 1.16

function Season123_2_3StoryCoverItem:refreshItem()
	local stageMO = Season123Model.instance:getActInfo(self.actId).stageMap[self.config.condition]

	self.isPass = stageMO and stageMO.isPass
	self.isUnlock = Season123ProgressUtils.isStageUnlock(self.actId, self.config.condition) and self.isPass == true
	self.canvasGroup.alpha = self.isUnlock and 1 or 0.5
	self.txtStageNum.text = self.config.storyId
	self.txtTitle.text = self.config.title
	self.txtTitleEn.text = self.config.titleEn
end

function Season123_2_3StoryCoverItem:onClickCoverItem()
	if self.isUnlock then
		Season123Controller.instance:dispatchEvent(Season123Event.OnCoverItemClick, {
			storyId = self.storyId
		})
	else
		GameFacade.showToast(ToastEnum.SeasonStageNotPass)
	end
end

function Season123_2_3StoryCoverItem:refreshUnlockState(unlockState)
	if self.isUnlock and self.isUnlock ~= unlockState then
		gohelper.setActive(self.goLocked, not unlockState)
		UIBlockMgr.instance:endBlock("playCoverItemUnlockAnim")
		UIBlockMgr.instance:startBlock("playCoverItemUnlockAnim")
		TaskDispatcher.runDelay(self.playUnlockAnim, self, Season123_2_3StoryCoverItem.unlockDelayTime)
		UIBlockMgrExtend.setNeedCircleMv(false)
	else
		gohelper.setActive(self.goLocked, not self.isUnlock)
	end
end

function Season123_2_3StoryCoverItem:playUnlockAnim()
	self.animLocked:Play(UIAnimationName.Unlock, self.onUnlockAnimDone, self)
	AudioMgr.instance:trigger(AudioEnum.Season123.play_ui_jinye_tale_unlock)
end

function Season123_2_3StoryCoverItem:onUnlockAnimDone()
	gohelper.setActive(self.goLocked, not self.isUnlock)
	UIBlockMgr.instance:endBlock("playCoverItemUnlockAnim")
end

function Season123_2_3StoryCoverItem:destroy()
	self:__onDispose()
	UIBlockMgr.instance:endBlock("playCoverItemUnlockAnim")
	TaskDispatcher.cancelTask(self.playUnlockAnim, self)
end

return Season123_2_3StoryCoverItem
