-- chunkname: @modules/logic/sp02/dungeon/view/VersionActivity3_10DungeonMapView.lua

module("modules.logic.sp02.dungeon.view.VersionActivity3_10DungeonMapView", package.seeall)

local VersionActivity3_10DungeonMapView = class("VersionActivity3_10DungeonMapView", VersionActivityFixedDungeonMapView)

function VersionActivity3_10DungeonMapView:_editableInitView()
	VersionActivity3_10DungeonMapView.super._editableInitView(self)

	self._topRightAnimator = gohelper.onceAddComponent(self._gotopright, gohelper.Type_Animator)
	self.btnGame = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_game")
	self._gostealthreddot = gohelper.findChild(self.viewGO, "#btn_game/#go_stealthreddot")

	RedDotController.instance:addRedDot(self._gostealthreddot, RedDotEnum.DotNode.SP02AtomicDungeonEnter)
end

function VersionActivity3_10DungeonMapView:addEvents()
	VersionActivity3_10DungeonMapView.super.addEvents(self)
	self.addEventCb(self, DungeonController.instance, DungeonEvent.OnUpdateDungeonInfo, self._onUpdateDungeonInfo, self)
	self.addClickCb(self, self.btnGame, self.openDungeonView, self)
end

function VersionActivity3_10DungeonMapView:showBtnUI()
	if self.isShowUI == true then
		return
	end

	self.isShowUI = true

	VersionActivity3_10DungeonMapView.super.showBtnUI(self)
	self._topRightAnimator:Play("open")
end

function VersionActivity3_10DungeonMapView:hideBtnUI()
	if self.isShowUI == false then
		return
	end

	self.isShowUI = false

	VersionActivity3_10DungeonMapView.super.hideBtnUI(self)
	self._topRightAnimator:Play("close")
end

function VersionActivity3_10DungeonMapView:refreshMask()
	local isHardMode = self.activityDungeonMo:isHardMode()

	gohelper.setActive(self._simagenormalmask.gameObject, false)
	gohelper.setActive(self._simagehardmask.gameObject, isHardMode)
	self:refreshGameBtn()
end

function VersionActivity3_10DungeonMapView:setMask2DVisible(visible)
	return
end

function VersionActivity3_10DungeonMapView:_onUpdateDungeonInfo()
	self:refreshGameBtn()
end

function VersionActivity3_10DungeonMapView:refreshGameBtn()
	local isOpen = AtomicDungeonController.instance:isUnlockDungeon()

	gohelper.setActive(self.btnGame, isOpen)
end

function VersionActivity3_10DungeonMapView:openDungeonView()
	AudioMgr.instance:trigger(AudioEnum3_10.Dungeon.play_ui_action_return)
	self.animator:Play("togame", 0, 0)
	TaskDispatcher.cancelTask(self._realOpenDungeonView, self)
	TaskDispatcher.runDelay(self._realOpenDungeonView, self, 0.33)
end

function VersionActivity3_10DungeonMapView:_realOpenDungeonView()
	AtomicDungeonController.instance:openDungeonView()
end

function VersionActivity3_10DungeonMapView:onVisibleChange(isVisible)
	if isVisible then
		self.animator:Play("open", 0, 0)
	end
end

function VersionActivity3_10DungeonMapView:onOpen()
	VersionActivity3_10DungeonMapView.super.onOpen(self)
	AudioMgr.instance:trigger(AudioEnum3_10.Dungeon.play_ui_langchao_open_2)
end

function VersionActivity3_10DungeonMapView:onDestroyView()
	VersionActivity3_10DungeonMapView.super.onDestroyView(self)
	TaskDispatcher.cancelTask(self._realOpenDungeonView, self)
end

return VersionActivity3_10DungeonMapView
