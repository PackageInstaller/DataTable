-- chunkname: @modules/logic/season/view3_0/Season3_0StoryCoverItem.lua

module("modules.logic.season.view3_0.Season3_0StoryCoverItem", package.seeall)

local Season3_0StoryCoverItem = class("Season3_0StoryCoverItem", LuaCompBase)

function Season3_0StoryCoverItem:ctor(param)
	self.param = param
end

function Season3_0StoryCoverItem:init(go)
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

function Season3_0StoryCoverItem:addEventListeners()
	self.btnClick:AddClickListener(self.onClickCoverItem, self)
end

function Season3_0StoryCoverItem:removeEventListeners()
	self.btnClick:RemoveClickListener()
end

Season3_0StoryCoverItem.unlockDelayTime = 1.16

function Season3_0StoryCoverItem:refreshItem()
	self.isUnlock = Activity104Model.instance:isStagePassed(self.config.condition)
	self.canvasGroup.alpha = self.isUnlock and 1 or 0.5
	self.txtStageNum.text = self.config.storyId
	self.txtTitle.text = self.config.title
	self.txtTitleEn.text = self.config.titleEn
end

function Season3_0StoryCoverItem:onClickCoverItem()
	if self.isUnlock then
		Activity104Controller.instance:dispatchEvent(Activity104Event.OnCoverItemClick, {
			storyId = self.storyId
		})
	else
		GameFacade.showToast(ToastEnum.SeasonStoryNotOpen)
	end
end

function Season3_0StoryCoverItem:refreshUnlockState(unlockState)
	if self.isUnlock and self.isUnlock ~= unlockState then
		gohelper.setActive(self.goLocked, not unlockState)
		UIBlockMgr.instance:endBlock("playCoverItemUnlockAnim")
		UIBlockMgr.instance:startBlock("playCoverItemUnlockAnim")
		TaskDispatcher.runDelay(self.playUnlockAnim, self, Season3_0StoryCoverItem.unlockDelayTime)
		UIBlockMgrExtend.setNeedCircleMv(false)
	else
		gohelper.setActive(self.goLocked, not self.isUnlock)
	end
end

function Season3_0StoryCoverItem:playUnlockAnim()
	self.animLocked:Play(UIAnimationName.Unlock, self.onUnlockAnimDone, self)
	AudioMgr.instance:trigger(AudioEnum.Season123.play_ui_jinye_tale_unlock)
end

function Season3_0StoryCoverItem:onUnlockAnimDone()
	gohelper.setActive(self.goLocked, not self.isUnlock)
	UIBlockMgr.instance:endBlock("playCoverItemUnlockAnim")
end

function Season3_0StoryCoverItem:destroy()
	self:__onDispose()
	UIBlockMgr.instance:endBlock("playCoverItemUnlockAnim")
	TaskDispatcher.cancelTask(self.playUnlockAnim, self)
end

return Season3_0StoryCoverItem
