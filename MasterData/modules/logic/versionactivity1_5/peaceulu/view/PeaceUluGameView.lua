-- chunkname: @modules/logic/versionactivity1_5/peaceulu/view/PeaceUluGameView.lua

module("modules.logic.versionactivity1_5.peaceulu.view.PeaceUluGameView", package.seeall)

local PeaceUluGameView = class("PeaceUluGameView", BaseView)

function PeaceUluGameView:onInitView()
	self._golive2d = gohelper.findChild(self.viewGO, "#go_live2d")
	self._gotalk = gohelper.findChild(self.viewGO, "#go_live2d/#go_talk")
	self._gotalkbg = gohelper.findChild(self.viewGO, "#go_live2d/#go_talkbg")
	self._txttalk = gohelper.findChildText(self.viewGO, "#go_live2d/#go_talk/bg/#txt_talk")
	self._goleftbg = gohelper.findChild(self.viewGO, "game/left/#go_bg")
	self._gostartmask = gohelper.findChild(self.viewGO, "game/#go_BlackMask1")
	self._goresultmask = gohelper.findChild(self.viewGO, "game/#go_BlackMask2")
	self._goleftselected = gohelper.findChild(self.viewGO, "game/left/#go_selected")
	self._imgleftselected = gohelper.findChildImage(self.viewGO, "game/left/#go_selected")
	self._txtleft = gohelper.findChildText(self.viewGO, "game/left/#go_selected/#txt_left")
	self._goxian = gohelper.findChild(self.viewGO, "game/#go_xian")
	self._gorightbg = gohelper.findChild(self.viewGO, "game/right/#go_bg")
	self._gobtns = gohelper.findChild(self.viewGO, "game/#go_btns")
	self._btnpaper = gohelper.findChildButtonWithAudio(self.viewGO, "game/#go_btns/#btn_paper")
	self._btnrock = gohelper.findChildButtonWithAudio(self.viewGO, "game/#go_btns/#btn_rock")
	self._btnscissors = gohelper.findChildButtonWithAudio(self.viewGO, "game/#go_btns/#btn_scissors")
	self._btnconfirm = gohelper.findChildButtonWithAudio(self.viewGO, "game/#go_btns/#btn_confirm")
	self._gotips = gohelper.findChild(self.viewGO, "game/#go_tips")
	self._txttips = gohelper.findChildText(self.viewGO, "game/right/#go_tips/bg/#txt_tips")
	self._gorightselected = gohelper.findChild(self.viewGO, "game/right/#go_selected")
	self._imgrightselected = gohelper.findChildImage(self.viewGO, "game/right/#go_selected")
	self._txtright = gohelper.findChildText(self.viewGO, "game/right/#go_selected/#txt_right")
	self._gostate = gohelper.findChild(self.viewGO, "game/#go_state")
	self._gostart = gohelper.findChild(self.viewGO, "game/#go_state/#go_start")
	self._btndraw = gohelper.findChildButton(self.viewGO, "game/#go_state/0/#btn_draw")
	self._gocontentbg = gohelper.findChild(self.viewGO, "bottom/#go_contentbg")
	self._txtanacn = gohelper.findChildText(self.viewGO, "bottom/#txt_ana_cn")
	self._txtanaen = gohelper.findChildText(self.viewGO, "bottom/#txt_ana_en")
	self._animator = self.viewGO:GetComponent(typeof(UnityEngine.Animator))
	self._stateList = {}
	self._btnItemList = {}
	self._isSelect = false
	self.tweenDuration = 0.5
	self._isTips = false

	if self._editableInitView then
		self:_editableInitView()
	end
end

function PeaceUluGameView:addEvents()
	self._btnconfirm:AddClickListener(self._btnconfirmOnClick, self)
	self._btndraw:AddClickListener(self._onClickDraw, self)
	self.addEventCb(self, PeaceUluController.instance, PeaceUluEvent.onGetGameResult, self._getResult, self)
end

function PeaceUluGameView:removeEvents()
	self._btnconfirm:RemoveClickListener()
	self._btndraw:RemoveClickListener()
	self.removeEventCb(self, PeaceUluController.instance, PeaceUluEvent.onGetGameResult, self._getResult, self)
end

function PeaceUluGameView:_editableInitView()
	for i = 0, 2 do
		local go = gohelper.findChild(self.viewGO, "game/#go_state/" .. i)

		table.insert(self._stateList, go)
	end

	for i = 1, 3 do
		local btnItem = self:getUserDataTb_()

		btnItem.trs = gohelper.findChild(self.viewGO, "game/#go_btns/" .. i).transform
		btnItem.go = gohelper.findChild(self.viewGO, "game/#go_btns/" .. i .. "/img")
		btnItem.btn = gohelper.findChildButtonWithAudio(self.viewGO, "game/#go_btns/" .. i)
		btnItem.id = i

		gohelper.setActive(btnItem.go, false)
		btnItem.btn:AddClickListener(self._onClickGameBtn, self, btnItem)
		table.insert(self._btnItemList, btnItem)
	end
end

function PeaceUluGameView:_onClickGameBtn(btnItem)
	self.selectId = btnItem.id

	for index, item in ipairs(self._btnItemList) do
		if item.id ~= self.selectId then
			gohelper.setActive(item.go, false)
		else
			gohelper.setActive(item.go, true)
		end
	end

	gohelper.setActive(self._btnconfirm.gameObject, true)
end

function PeaceUluGameView:_btnconfirmOnClick()
	PeaceUluRpc.instance:sendAct145GameRequest(VersionActivity1_5Enum.ActivityId.PeaceUlu, self.selectId)
	gohelper.setActive(self._btnconfirm.gameObject, false)
	TaskDispatcher.runDelay(self._onGameTipsFinish, self, 2)
end

function PeaceUluGameView:_getResult()
	local otherChoice = PeaceUluModel.instance:getOtherChoice()

	gohelper.setActive(self._gobtns, false)
	gohelper.setActive(self._gotips, false)
	gohelper.setActive(self._goresultmask, true)
	gohelper.setActive(self._goxian, true)
	gohelper.setActive(self._goleftselected, true)
	gohelper.setActive(self._gorightselected, true)
	UISpriteSetMgr.instance:setPeaceUluSprite(self._imgleftselected, otherChoice)
	UISpriteSetMgr.instance:setPeaceUluSprite(self._imgrightselected, self.selectId)
	self._animator:Play("play", 0, 0)
	self._animator:Update(0)

	local navigatetionview = self.viewContainer:getNavigateButtonView()

	navigatetionview:setParam({
		false,
		false,
		false
	})
	AudioMgr.instance:trigger(AudioEnum.ui_activity_1_5_wulu.play_ui_wulu_caiquan_decide)
	TaskDispatcher.runDelay(self._showResult, self, 1.6)
end

function PeaceUluGameView:_showResult()
	TaskDispatcher.cancelTask(self._showResult, self)

	local result = PeaceUluModel.instance:getGameRes()

	if result == PeaceUluEnum.GameResult.Win then
		self._animator:Play("success", 0, 0)
		self._animator:Update(0)
		AudioMgr.instance:trigger(AudioEnum.ui_activity.play_ui_pkls_endpoint_arrival)
		TaskDispatcher.runDelay(self._showResultFinish, self, 2.2)
	elseif result == PeaceUluEnum.GameResult.Fail then
		self._animator:Play("fail", 0, 0)
		self._animator:Update(0)
		AudioMgr.instance:trigger(AudioEnum.ui_activity.play_ui_pkls_challenge_fail)
		TaskDispatcher.runDelay(self._showResultFinish, self, 2.2)
	else
		self._animator:Play("draw", 0, 0)
		self._animator:Update(0)
		AudioMgr.instance:trigger(AudioEnum.ui_activity.play_ui_pkls_endpoint_arrival)
	end

	gohelper.setActive(self._stateList[result + 1], true)
end

function PeaceUluGameView:_onClickDraw()
	self._animator:Play("drawend", 0, 0)
	self._animator:Update(0)
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Common_Click)
	TaskDispatcher.runDelay(self._showResultFinish, self, 0.5)
end

function PeaceUluGameView:_showResultFinish()
	TaskDispatcher.cancelTask(self._showResultFinish, self)

	for index, go in ipairs(self._stateList) do
		gohelper.setActive(go, false)
	end

	local result = PeaceUluModel.instance:getGameRes()

	if result == PeaceUluEnum.GameResult.Draw then
		gohelper.setActive(self._gostate, false)
		self:_onGameStart()
	else
		PeaceUluController.instance:dispatchEvent(PeaceUluEvent.reInitResultView)
		self.viewContainer:dispatchEvent(ViewEvent.ToSwitchTab, 2, PeaceUluEnum.TabIndex.Result)
		gohelper.setActive(self._goresultmask, false)
	end
end

function PeaceUluGameView:_reInitUI()
	for index, item in ipairs(self._btnItemList) do
		gohelper.setActive(item.go, false)
	end

	gohelper.setActive(self._btnconfirm.gameObject, false)
end

function PeaceUluGameView:_onGameStart()
	self._animator:Play("start", 0, 0)
	self._animator:Update(0)
	gohelper.setActive(self._gobtns, true)
	gohelper.setActive(self._gostate, true)
	gohelper.setActive(self._gostart, true)
	gohelper.setActive(self._goresultmask, true)
	gohelper.setActive(self._goxian, false)
	gohelper.setActive(self._gotips, false)
	gohelper.setActive(self._goleftbg, false)
	gohelper.setActive(self._goleftselected, false)
	gohelper.setActive(self._gorightselected, false)
	gohelper.setActive(self._gorightbg, false)
	self:_reInitUI()
	TaskDispatcher.runDelay(self._onGameStartFinish, self, 2)
end

function PeaceUluGameView:_onGameStartFinish()
	TaskDispatcher.cancelTask(self._onGameStartFinish, self)
	gohelper.setActive(self._goresultmask, false)
	gohelper.setActive(self._gostartmask, true)
	gohelper.setActive(self._gostart, false)
	gohelper.setActive(self._gotips, true)
end

function PeaceUluGameView:_onGameTipsFinish()
	TaskDispatcher.cancelTask(self._onGameTipsFinish, self)
	gohelper.setActive(self._gotips, false)
	gohelper.setActive(self._gostartmask, false)
end

function PeaceUluGameView:onUpdateParam()
	self:_refreshUI()
end

function PeaceUluGameView:onOpen()
	self._animator:Play("start", 0, 0)
	self._animator:Update(0)
	self:_onGameStart()
	AudioMgr.instance:trigger(AudioEnum.ui_activity_1_5_wulu.play_ui_wulu_caiquan_open)
end

function PeaceUluGameView:_refreshUI()
	return
end

function PeaceUluGameView:onClose()
	TaskDispatcher.cancelTask(self._showResult, self)
	TaskDispatcher.cancelTask(self._onGameStartFinish, self)
	TaskDispatcher.cancelTask(self._onGameTipsFinish, self)
	TaskDispatcher.cancelTask(self._showResultFinish, self)
end

function PeaceUluGameView:onDestroyView()
	for index, item in ipairs(self._btnItemList) do
		item.btn:RemoveClickListener()
	end
end

return PeaceUluGameView
