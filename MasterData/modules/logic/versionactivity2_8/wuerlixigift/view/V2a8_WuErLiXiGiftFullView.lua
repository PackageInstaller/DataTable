-- chunkname: @modules/logic/versionactivity2_8/wuerlixigift/view/V2a8_WuErLiXiGiftFullView.lua

module("modules.logic.versionactivity2_8.wuerlixigift.view.V2a8_WuErLiXiGiftFullView", package.seeall)

local V2a8_WuErLiXiGiftFullView = class("V2a8_WuErLiXiGiftFullView", BaseView)

function V2a8_WuErLiXiGiftFullView:onInitView()
	self._txtremainTime = gohelper.findChildText(self.viewGO, "image_TimeBG/#txt_remainTime")
	self._btnClaim = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_Claim")
	self._goNormal = gohelper.findChild(self.viewGO, "#btn_Claim/#go_Normal")
	self._goReceived = gohelper.findChild(self.viewGO, "#btn_Claim/#go_Received")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V2a8_WuErLiXiGiftFullView:addEvents()
	self._btnClaim:AddClickListener(self._btnClaimOnClick, self)
end

function V2a8_WuErLiXiGiftFullView:removeEvents()
	self._btnClaim:RemoveClickListener()
end

function V2a8_WuErLiXiGiftFullView:_btnClaimOnClick()
	V2a8_WuErLiXiGiftController.instance:receiveV2a8_WuErLiXiGift(self.refreshCanGet, self)
end

function V2a8_WuErLiXiGiftFullView:_editableInitView()
	return
end

function V2a8_WuErLiXiGiftFullView:onUpdateParam()
	return
end

function V2a8_WuErLiXiGiftFullView:onOpen()
	local parentGO = self.viewParam.parent

	gohelper.addChild(parentGO, self.viewGO)
	self:refresh()
	AudioMgr.instance:trigger(AudioEnum.Va3Armpipe.play_ui_molu_button_display)
end

function V2a8_WuErLiXiGiftFullView:refresh()
	self:refreshCanGet()
	self:refreshRemainTime()
	TaskDispatcher.cancelTask(self.refreshRemainTime, self)
	TaskDispatcher.runRepeat(self.refreshRemainTime, self, TimeUtil.OneMinuteSecond)
end

function V2a8_WuErLiXiGiftFullView:refreshCanGet()
	local canReceive = V2a8_WuErLiXiGiftModel.instance:isShowRedDot()

	gohelper.setActive(self._goNormal, canReceive)
	gohelper.setActive(self._goReceived, not canReceive)
end

function V2a8_WuErLiXiGiftFullView:refreshRemainTime()
	local actId = V2a8_WuErLiXiGiftModel.instance:getV2a8_WuErLiXiGiftActId()
	local actInfoMo = ActivityModel.instance:getActMO(actId)
	local timeStr = actInfoMo:getRemainTimeStr3(false, true)

	self._txtremainTime.text = string.format(luaLang("remain"), timeStr)
end

function V2a8_WuErLiXiGiftFullView:onClose()
	return
end

function V2a8_WuErLiXiGiftFullView:onDestroyView()
	TaskDispatcher.cancelTask(self.refreshRemainTime, self)
end

return V2a8_WuErLiXiGiftFullView
