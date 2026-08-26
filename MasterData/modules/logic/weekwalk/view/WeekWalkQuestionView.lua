-- chunkname: @modules/logic/weekwalk/view/WeekWalkQuestionView.lua

module("modules.logic.weekwalk.view.WeekWalkQuestionView", package.seeall)

local WeekWalkQuestionView = class("WeekWalkQuestionView", BaseView)

function WeekWalkQuestionView:onInitView()
	self._gofullscreen = gohelper.findChild(self.viewGO, "#go_fullscreen")
	self._txtquestion = gohelper.findChildText(self.viewGO, "anim/#txt_question")
	self._gooptions = gohelper.findChild(self.viewGO, "anim/#go_options")
	self._gooptionitem = gohelper.findChild(self.viewGO, "anim/#go_options/#go_optionitem")
	self._simagebg = gohelper.findChildSingleImage(self.viewGO, "#simage_bg")
	self._simageline = gohelper.findChildSingleImage(self.viewGO, "anim/#simage_line")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function WeekWalkQuestionView:addEvents()
	return
end

function WeekWalkQuestionView:removeEvents()
	return
end

function WeekWalkQuestionView:_editableInitView()
	self._optionBtnList = self:getUserDataTb_()

	self._simagebg:LoadImage(ResUrl.getWeekWalkBg("full/bg_huan.png"))
	self._simageline:LoadImage(ResUrl.getWeekWalkBg("bg_xian.png"))
	self:_checkShowQuestion()
end

function WeekWalkQuestionView:_checkShowQuestion()
	local show = self:_showNextQuestion()

	if not show then
		if self._answerAll then
			return
		end

		self._answerAll = true

		WeekWalkController.instance:openWeekWalkView()
	end
end

function WeekWalkQuestionView:_showNextQuestion()
	local info = WeekWalkModel.instance:getInfo()

	self.questionIds, self.selects = info:getQuestionInfo()

	for i, v in ipairs(self.questionIds) do
		if not self.selects[i] then
			self:_showQuestion(v)

			return true
		end
	end

	return false
end

function WeekWalkQuestionView:_showQuestion(id)
	local config = WeekWalkConfig.instance:getQuestionConfig(id)

	self._txtquestion.text = config.text

	self:_addAllOptions(config)
end

function WeekWalkQuestionView:_addAllOptions(questionConfig)
	for k, v in pairs(self._optionBtnList) do
		gohelper.setActive(v[1], false)
	end

	for i = 1, 3 do
		self:_addOption(i, questionConfig["select" .. i])
	end
end

function WeekWalkQuestionView:_addOption(index, text)
	if self._optionBtnList[index] then
		if not self._optionBtnList[index][1] then
			local item = gohelper.cloneInPlace(self._gooptionitem)

			gohelper.setActive(item, true)

			local txt = gohelper.findChildText(item, "txt_optionitem")

			txt.text = text

			local btn = gohelper.findChildButtonWithAudio(item, "btn_optionitem", AudioEnum.WeekWalk.play_artificial_ui_answerchoose)

			btn:AddClickListener(self._onOptionClick, self, {
				index,
				text
			})

			self._optionBtnList[index] = self._optionBtnList[index] or {
				item,
				btn
			}
		end
	end
end

function WeekWalkQuestionView:_onOptionClick(param)
	local index = param[1]

	WeekwalkRpc.instance:sendWeekwalkQuestionSelectRequest(index)
end

function WeekWalkQuestionView:onUpdateParam()
	return
end

function WeekWalkQuestionView:onOpen()
	self.addEventCb(self, WeekWalkController.instance, WeekWalkEvent.OnQuestionReply, self._OnQuestionReply, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnOpenViewFinish, self._onOpenViewFinish, self)
	self.addEventCb(self, WeekWalkController.instance, WeekWalkEvent.OnGetInfo, self._OnGetInfo, self)
end

function WeekWalkQuestionView:_OnGetInfo()
	self:_checkExpire()
end

function WeekWalkQuestionView:_checkExpire()
	if WeekWalkModel.instance:infoNeedUpdate() then
		UIBlockMgr.instance:startBlock("WeekWalkQuestionView _checkExpire")
		TaskDispatcher.runDelay(self._exitView, self, 0.5)
	end
end

function WeekWalkQuestionView:_exitView()
	UIBlockMgr.instance:endBlock("WeekWalkQuestionView _checkExpire")
	GameFacade.showMessageBox(MessageBoxIdDefine.WeekWalkExpire, MsgBoxEnum.BoxType.Yes, function()
		ViewMgr.instance:closeAllPopupViews({
			ViewName.DungeonView
		})
	end, nil, nil)
end

function WeekWalkQuestionView:_onOpenViewFinish(viewName)
	if viewName == ViewName.WeekWalkView then
		self:closeThis()
	end
end

function WeekWalkQuestionView:_OnQuestionReply()
	self:_checkShowQuestion()
end

function WeekWalkQuestionView:onClose()
	for k, v in pairs(self._optionBtnList) do
		v[2]:RemoveClickListener()
	end

	if self._bgmId then
		self._bgmId = nil
	end

	TaskDispatcher.cancelTask(self._exitView, self)
end

function WeekWalkQuestionView:onDestroyView()
	self._simagebg:UnLoadImage()
	self._simageline:UnLoadImage()
end

return WeekWalkQuestionView
