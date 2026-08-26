-- chunkname: @modules/logic/meilanni/view/MeilanniDialogBtnView.lua

module("modules.logic.meilanni.view.MeilanniDialogBtnView", package.seeall)

local MeilanniDialogBtnView = class("MeilanniDialogBtnView", BaseView)

function MeilanniDialogBtnView:onInitView()
	self._gooptions = gohelper.findChild(self.viewGO, "top_right/btncontain/#go_btntype1")
	self._gotalkitem = gohelper.findChild(self.viewGO, "top_right/btncontain/#go_btntype1/#btn_templateclick")
	self._gobtnpos1 = gohelper.findChild(self.viewGO, "top_right/btncontain/#go_btntype1/#go_btnpos1")
	self._gobtnpos2 = gohelper.findChild(self.viewGO, "top_right/btncontain/#go_btntype1/#go_btnpos2")
	self._gobtnpos3 = gohelper.findChild(self.viewGO, "top_right/btncontain/#go_btntype1/#go_btnpos3")
	self._btnend = gohelper.findChildButtonWithAudio(self.viewGO, "top_right/btncontain/#btn_end")
	self._txtendinfo = gohelper.findChildText(self.viewGO, "top_right/btncontain/#btn_end/layout/txt_info")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function MeilanniDialogBtnView:addEvents()
	self._btnend:AddClickListener(self._btnendOnClick, self)
end

function MeilanniDialogBtnView:removeEvents()
	self._btnend:RemoveClickListener()
end

function MeilanniDialogBtnView:_btnresetOnClick()
	return
end

function MeilanniDialogBtnView:_editableInitView()
	self._optionBtnList = self:getUserDataTb_()
	self._animatorPlayer = SLFramework.AnimatorPlayer.Get(self._gooptions)
	self._endPlayer = SLFramework.AnimatorPlayer.Get(self._btnend.gameObject)
end

function MeilanniDialogBtnView:onUpdateParam()
	return
end

function MeilanniDialogBtnView:onOpen()
	self.addEventCb(self, MeilanniController.instance, MeilanniEvent.startShowDialogOptionBtn, self._startShowDialogOptionBtn, self)
	self.addEventCb(self, MeilanniController.instance, MeilanniEvent.refreshDialogBtnState, self._refreshDialogBtnState, self)
	self.addEventCb(self, MeilanniController.instance, MeilanniEvent.showDialogOptionBtn, self._showDialogOptionBtn, self)
	self.addEventCb(self, MeilanniController.instance, MeilanniEvent.showDialogEndBtn, self._showDialogEndBtn, self)
	self.addEventCb(self, MeilanniController.instance, MeilanniEvent.dialogClose, self._dialogClose, self)
	self.addEventCb(self, MeilanniController.instance, MeilanniEvent.resetMap, self._resetMap, self)
end

function MeilanniDialogBtnView:_onAnimDone()
	gohelper.setActive(self._gooptions, self._showOption)
end

function MeilanniDialogBtnView:_refreshDialogBtnState(showOption)
	self._showOption = showOption

	if not showOption then
		if not self._gooptions.activeSelf then
			return
		end

		self._animatorPlayer:Play("close", self._onAnimDone, self)

		return
	end

	gohelper.setActive(self._gooptions, showOption)
	self._animatorPlayer:Play("open", self._onAnimDone, self)
end

function MeilanniDialogBtnView:_onEndAnimDone()
	gohelper.setActive(self._btnend, self._showEndBtn)
end

function MeilanniDialogBtnView:_refreshEndBtnState(showOption)
	self._showEndBtn = showOption

	if not showOption then
		if not self._btnend.gameObject.activeSelf then
			return
		end

		self._endPlayer:Play("close", self._onEndAnimDone, self)

		return
	end

	gohelper.setActive(self._btnend, showOption)
	self._endPlayer:Play("open", self._onEndAnimDone, self)
end

function MeilanniDialogBtnView:_startShowDialogOptionBtn()
	for k, v in pairs(self._optionBtnList) do
		gohelper.setActive(v[1], false)
	end
end

function MeilanniDialogBtnView:_showDialogOptionBtn(param)
	local optionParam = param[1]
	local sectionId = optionParam[1]
	local num = optionParam[5]
	local iconName = optionParam[6]
	local text = optionParam[2]
	local index = optionParam[3]

	self._optionCallbackTarget = param[2]
	self._optionCallback = param[3]

	if num < 3 then
		index = index + 1
	end

	if self._optionBtnList[index] then
		if not self._optionBtnList[index][1] then
			local item = gohelper.clone(self._gotalkitem, self["_gobtnpos" .. index])

			gohelper.setActive(item, true)

			local optionText = text
			local txt = gohelper.findChildText(item, "layout/txt_info")

			txt.text = ":" .. optionText

			local iconImg = gohelper.findChildImage(item, "layout/txt_info/image_icon")

			UISpriteSetMgr.instance:setMeilanniSprite(iconImg, iconName or "bg_xuanzhe_1")

			local bgImg = item:GetComponent(gohelper.Type_Image)

			UISpriteSetMgr.instance:setMeilanniSprite(bgImg, sectionId == -1 and "btn000" or "btn001")

			local btn = gohelper.findButtonWithAudio(item, AudioEnum.WeekWalk.play_artificial_ui_talkchoose)

			btn:AddClickListener(self._onOptionClick, self, optionParam)

			if not self._optionBtnList[index] then
				self._optionBtnList[index] = {
					item,
					btn
				}
				item.name = "talkitem_" .. tostring(index)
			end
		end
	end
end

function MeilanniDialogBtnView:_onOptionClick(param)
	self._optionCallback(self._optionCallbackTarget, param)
end

function MeilanniDialogBtnView:_showDialogEndBtn(param)
	self._txtendinfo.text = param[1]
	self._callbackTarget = param[2]
	self._callback = param[3]

	local delayTime = param[4]

	if not delayTime then
		self:_refreshEndBtnState(true)

		return
	end

	TaskDispatcher.cancelTask(self._delayShowEndBtn, self)
	TaskDispatcher.runDelay(self._delayShowEndBtn, self, delayTime)
end

function MeilanniDialogBtnView:_delayShowEndBtn()
	self:_refreshEndBtnState(true)
end

function MeilanniDialogBtnView:_btnendOnClick()
	self._callback(self._callbackTarget)
end

function MeilanniDialogBtnView:_dialogClose()
	TaskDispatcher.cancelTask(self._delayShowEndBtn, self)
	self:_refreshEndBtnState(false)
	self:_refreshDialogBtnState(false)
end

function MeilanniDialogBtnView:_resetMap()
	self:_dialogClose()
end

function MeilanniDialogBtnView:onClose()
	self:_dialogClose()

	for k, v in pairs(self._optionBtnList) do
		v[2]:RemoveClickListener()
	end
end

function MeilanniDialogBtnView:onDestroyView()
	return
end

return MeilanniDialogBtnView
