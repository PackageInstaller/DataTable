-- chunkname: @modules/logic/versionactivity1_9/semmelweisgift/view/SemmelWeisGiftFullView.lua

module("modules.logic.versionactivity1_9.semmelweisgift.view.SemmelWeisGiftFullView", package.seeall)

local SemmelWeisGiftFullView = class("SemmelWeisGiftFullView", BaseView)

function SemmelWeisGiftFullView:onInitView()
	self._txtremainTime = gohelper.findChildText(self.viewGO, "Root/image_TimeBG/#txt_remainTime")
	self._btnClaim = gohelper.findChildButtonWithAudio(self.viewGO, "Root/#btn_Claim")
	self._goNormal = gohelper.findChild(self.viewGO, "Root/#btn_Claim/#go_Normal")
	self._goReceived = gohelper.findChild(self.viewGO, "Root/#btn_Claim/#go_Received")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function SemmelWeisGiftFullView:addEvents()
	self._btnClaim:AddClickListener(self._btnClaimOnClick, self)
end

function SemmelWeisGiftFullView:removeEvents()
	self._btnClaim:RemoveClickListener()
end

function SemmelWeisGiftFullView:_btnClaimOnClick()
	SemmelWeisGiftController.instance:receiveSemmelWeisGift(self.refreshCanGet, self)
end

function SemmelWeisGiftFullView:_editableInitView()
	return
end

function SemmelWeisGiftFullView:onUpdateParam()
	return
end

function SemmelWeisGiftFullView:onOpen()
	local parentGO = self.viewParam.parent

	gohelper.addChild(parentGO, self.viewGO)
	self:refresh()
end

function SemmelWeisGiftFullView:refresh()
	self:refreshCanGet()
	self:refreshRemainTime()
	TaskDispatcher.cancelTask(self.refreshRemainTime, self)
	TaskDispatcher.runRepeat(self.refreshRemainTime, self, TimeUtil.OneMinuteSecond)
end

function SemmelWeisGiftFullView:refreshCanGet()
	local canReceive = SemmelWeisGiftModel.instance:isShowRedDot()

	gohelper.setActive(self._goNormal, canReceive)
	gohelper.setActive(self._goReceived, not canReceive)
end

function SemmelWeisGiftFullView:refreshRemainTime()
	local actId = SemmelWeisGiftModel.instance:getSemmelWeisGiftActId()
	local actInfoMo = ActivityModel.instance:getActMO(actId)
	local timeStr = actInfoMo:getRemainTimeStr3(false, true)

	self._txtremainTime.text = string.format(luaLang("remain"), timeStr)
end

function SemmelWeisGiftFullView:onClose()
	return
end

function SemmelWeisGiftFullView:onDestroyView()
	TaskDispatcher.cancelTask(self.refreshRemainTime, self)
end

return SemmelWeisGiftFullView
