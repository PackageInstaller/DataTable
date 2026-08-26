-- chunkname: @modules/logic/teaching/view/TeachingEnterView.lua

module("modules.logic.teaching.view.TeachingEnterView", package.seeall)

local TeachingEnterView = class("TeachingEnterView", BaseView)

function TeachingEnterView:onInitView()
	self._gobtns = gohelper.findChild(self.viewGO, "#go_btns")
	self._btnBaseLearn = gohelper.findChildButtonWithAudio(self.viewGO, "#go_btns/#btn_BaseLearn")
	self._goreddotbase = gohelper.findChild(self.viewGO, "#go_btns/#btn_BaseLearn/#go_reddot_base")
	self._godonebase = gohelper.findChild(self.viewGO, "#go_btns/#btn_BaseLearn/#go_done_base")
	self._txtnumbase = gohelper.findChildText(self.viewGO, "#go_btns/#btn_BaseLearn/numbg/#txt_num_base")
	self._imagebaseicon = gohelper.findChildImage(self.viewGO, "#go_btns/#btn_BaseLearn/numbg/#txt_num_base/#image_base_icon")
	self._btnSystemLearn = gohelper.findChildButtonWithAudio(self.viewGO, "#go_btns/#btn_SystemLearn")
	self._goreddotsystem = gohelper.findChild(self.viewGO, "#go_btns/#btn_SystemLearn/#go_reddot_system")
	self._godonesystem = gohelper.findChild(self.viewGO, "#go_btns/#btn_SystemLearn/#go_done_system")
	self._txtnumsystem = gohelper.findChildText(self.viewGO, "#go_btns/#btn_SystemLearn/numbg/#txt_num_system")
	self._gotopLeft = gohelper.findChild(self.viewGO, "#go_topLeft")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function TeachingEnterView:addEvents()
	self._btnBaseLearn:AddClickListener(self._btnBaseLearnOnClick, self)
	self._btnSystemLearn:AddClickListener(self._btnSystemLearnOnClick, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseView, self.onCloseView, self)
end

function TeachingEnterView:removeEvents()
	self._btnBaseLearn:RemoveClickListener()
	self._btnSystemLearn:RemoveClickListener()
	self.removeEventCb(self, ViewMgr.instance, ViewEvent.OnCloseView, self.onCloseView, self)
end

function TeachingEnterView:_btnBaseLearnOnClick()
	TeachNoteController.instance:enterTeachNoteView(nil, false)
end

function TeachingEnterView:_btnSystemLearnOnClick()
	ViewMgr.instance:openView(ViewName.TeachingMainView)
end

function TeachingEnterView:_editableInitView()
	self.teachingBaseRedDot = RedDotController.instance:addRedDot(self._goreddotbase, RedDotEnum.DotNode.V3a7TeachingBase, nil, self._checkTeachingBaseRed, self)
	self.teachingSystemRedDot = RedDotController.instance:addRedDot(self._goreddotsystem, RedDotEnum.DotNode.V3a7TeachingSystem, nil, self._checkTeachingSystemRed, self)
	self._anim = self.viewGO:GetComponent(gohelper.Type_Animator)
end

function TeachingEnterView:_checkTeachingBaseRed(redDotIcon)
	redDotIcon:defaultRefreshDot()

	if not redDotIcon.show then
		redDotIcon.show = TeachNoteModel.instance:hasRewardCouldGet()

		redDotIcon:showRedDot(RedDotEnum.Style.Normal)
	end

	if not redDotIcon.show then
		redDotIcon.show = tabletool.len(TeachNoteModel.instance:getNewOpenTopics()) > 0

		redDotIcon:showRedDot(RedDotEnum.Style.NewTag)
	end
end

function TeachingEnterView:_checkTeachingSystemRed(redDotIcon)
	redDotIcon:defaultRefreshDot()

	if not redDotIcon.show then
		redDotIcon.show = TeachingModel.instance:haveCanReceiveRewardTeaching()

		redDotIcon:showRedDot(RedDotEnum.Style.Normal)
	end

	if not redDotIcon.show then
		redDotIcon.show = TeachingModel.instance:haveNewTeaching()

		redDotIcon:showRedDot(RedDotEnum.Style.Green)
	end
end

function TeachingEnterView:onUpdateParam()
	return
end

function TeachingEnterView:onOpen()
	self.addEventCb(self, TeachNoteController.instance, TeachNoteEvent.GetServerTopicInfo, self._refreshView, self)
	self.addEventCb(self, TeachingController.instance, TeachingEvent.OnTeachingBonusUpdate, self._refreshView, self)
	self.addEventCb(self, TeachingController.instance, TeachingEvent.OnSelectTeachingId, self._refreshView, self)
	self:_refreshView()
	UISpriteSetMgr.instance:setCurrencyItemSprite(self._imagebaseicon, "202_1")
	AudioMgr.instance:trigger(AudioEnum3_7.Teaching.play_ui_teaching_enter)
end

function TeachingEnterView:_refreshView()
	local getCount, totalCount = TeachingModel.instance:getAllTeachingRewardCount()
	local baseGetCount, baseTotalCount = TeachNoteModel.instance:getAllUnLockRewardCount()

	self._txtnumsystem.text = string.format("%s/%s", getCount, totalCount)
	self._txtnumbase.text = string.format("%s/%s", baseGetCount, baseTotalCount)

	gohelper.setActive(self._godonebase, baseGetCount == baseTotalCount)
	gohelper.setActive(self._godonesystem, getCount == totalCount)

	local baseNewOpenTopics = TeachNoteModel.instance:getNewOpenTopics()

	gohelper.setActive(self._gonewbase, tabletool.len(baseNewOpenTopics) > 0)
	gohelper.setActive(self._gonewsystem, false)

	if self.teachingBaseRedDot then
		self.teachingBaseRedDot:refreshDot()
	end

	if self.teachingSystemRedDot then
		self.teachingSystemRedDot:refreshDot()
	end
end

function TeachingEnterView:onCloseView(viewName)
	if (viewName == ViewName.TeachingMainView or viewName == ViewName.TeachNoteView) and self._anim then
		self._anim:Play("open", 0, 0)
	end
end

function TeachingEnterView:onClose()
	self.removeEventCb(self, TeachNoteController.instance, TeachNoteEvent.GetServerTopicInfo, self._refreshView, self)
	self.removeEventCb(self, TeachingController.instance, TeachingEvent.OnTeachingBonusUpdate, self._refreshView, self)
end

function TeachingEnterView:onDestroyView()
	return
end

return TeachingEnterView
