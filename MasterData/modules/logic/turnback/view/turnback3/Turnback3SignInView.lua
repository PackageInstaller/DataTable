-- chunkname: @modules/logic/turnback/view/turnback3/Turnback3SignInView.lua

module("modules.logic.turnback.view.turnback3.Turnback3SignInView", package.seeall)

local Turnback3SignInView = class("Turnback3SignInView", BaseView)

function Turnback3SignInView:onInitView()
	self._simagefullbg = gohelper.findChildSingleImage(self.viewGO, "root/#simage_fullbg")
	self._txtinfotext = gohelper.findChildText(self.viewGO, "root/#txt_infotext")
	self._btnvideobtn = gohelper.findChildButtonWithAudio(self.viewGO, "root/btn_onceagain/#btn_videobtn")
	self._govideoendbtn = gohelper.findChild(self.viewGO, "root/btn_onceagain_end")
	self._btnvideoendbtn = gohelper.findChildButtonWithAudio(self.viewGO, "root/btn_onceagain_end/#btn_videobtn")
	self._gocontent = gohelper.findChild(self.viewGO, "root/content")
	self._gocontentitem = gohelper.findChild(self.viewGO, "root/content/#go_item")
	self._animator = self.viewGO:GetComponent(typeof(UnityEngine.Animator))

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Turnback3SignInView:addEvents()
	self._btnvideobtn:AddClickListener(self._btnvideobtnOnClick, self)
	self._btnvideoendbtn:AddClickListener(self._btnvideoendbtnOnClick, self)
	TurnbackController.instance:registerCallback(TurnbackEvent.RefreshView, self.refreshItem, self)
	TimeDispatcher.instance:registerCallback(TimeDispatcher.OnDailyRefresh, self.refreshItem, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseView, self._onCloseViewFinish, self)
end

function Turnback3SignInView:removeEvents()
	self._btnvideobtn:RemoveClickListener()
	self._btnvideoendbtn:RemoveClickListener()
	TurnbackController.instance:unregisterCallback(TurnbackEvent.RefreshView, self.refreshItem, self)
	TimeDispatcher.instance:unregisterCallback(TimeDispatcher.OnDailyRefresh, self.refreshItem, self)
	self.removeEventCb(self, ViewMgr.instance, ViewEvent.OnCloseView, self._onCloseViewFinish, self)
end

function Turnback3SignInView:_btnvideobtnOnClick()
	local TurnbackMo = TurnbackModel.instance:getCurTurnbackMo()

	if TurnbackMo then
		::label_4_0::

		local var_4_0 = TurnbackMo.config

		if TurnbackMo.config then
			local storyId = TurnbackMo.config.startStory

			if storyId then
				StoryController.instance:playStory(storyId)
			else
				logError(string.format("TurnbackRewardShowView startStoryId is nil", storyId))
			end
		end
	end
end

function Turnback3SignInView:_btnvideoendbtnOnClick()
	local TurnbackMo = TurnbackModel.instance:getCurTurnbackMo()

	if TurnbackMo then
		::label_5_0::

		local var_5_0 = TurnbackMo.config

		if TurnbackMo.config then
			local storyId = TurnbackMo.config.endStory

			if storyId then
				StoryController.instance:playStory(storyId)
			else
				logError(string.format("TurnbackRewardShowView startStoryId is nil", storyId))
			end
		end
	end
end

function Turnback3SignInView:_editableInitView()
	self._signItems = {}

	for day = 1, 7 do
		local item = self:getUserDataTb_()
		local parentGO = gohelper.findChild(self._gocontent, "pos" .. day)

		item.go = (day == 2 or day == 7) and gohelper.findChild(parentGO, "#go_item") or gohelper.clone(self._gocontentitem, parentGO, "day" .. day)
		item.cls = MonoHelper.addNoUpdateLuaComOnceToGo(item.go, Turnback3SignInItem)

		table.insert(self._signItems, item)
		item.cls:initItem(day)
	end
end

function Turnback3SignInView:_initItem()
	return
end

function Turnback3SignInView:onUpdateParam()
	return
end

function Turnback3SignInView:onOpen()
	self._turnbackId = TurnbackModel.instance:getCurTurnbackId()

	local parentGO = self.viewParam.parent

	gohelper.addChild(parentGO, self.viewGO)
	AudioMgr.instance:trigger(AudioEnum.NewTurnabck.play_ui_call_back_Interface_entry_04)
	self:_refreshUI()

	self._animator.speed = 0

	TaskDispatcher.runDelay(self._playAnim, self, 0.01)
end

function Turnback3SignInView:_playAnim()
	TaskDispatcher.cancelTask(self._playAnim, self)

	self._animator.speed = 1
end

function Turnback3SignInView:refreshItem()
	for day, item in ipairs(self._signItems) do
		item.cls:initItem(day)
	end
end

function Turnback3SignInView:_refreshUI()
	self:_checkShowSotry()
end

function Turnback3SignInView:_checkShowSotry()
	local isAllReceive = TurnbackSignInModel.instance:checkGetAllSignInReward()

	gohelper.setActive(self._govideoendbtn, isAllReceive)

	if isAllReceive then
		local config = TurnbackConfig.instance:getTurnbackCo(self._turnbackId)

		if config then
			::label_13_0::

			local canPlay = not StoryModel.instance:isStoryFinished(config.endStory)

			if canPlay then
				local storyId = config.endStory

				if storyId then
					StoryController.instance:playStory(storyId)
				else
					logError(string.format("TurnbackTaskView endStoryId is nil", storyId))
				end
			end
		end
	end
end

function Turnback3SignInView:_onCloseViewFinish(viewName)
	if viewName == ViewName.Turnback3SignInRoleTalkView then
		self:_checkShowSotry()
	end
end

function Turnback3SignInView:onClose()
	TaskDispatcher.cancelTask(self._playAnim, self)
end

function Turnback3SignInView:onDestroyView()
	TaskDispatcher.cancelTask(self._playAnim, self)
end

return Turnback3SignInView
