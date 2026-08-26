-- chunkname: @modules/logic/versionactivity3_4/goldenmilletpresent/view/V3a4_GoldenMilletPresentReceiveView.lua

module("modules.logic.versionactivity3_4.goldenmilletpresent.view.V3a4_GoldenMilletPresentReceiveView", package.seeall)

local V3a4_GoldenMilletPresentReceiveView = class("V3a4_GoldenMilletPresentReceiveView", BaseViewExtended)

function V3a4_GoldenMilletPresentReceiveView:onInitView()
	gohelper.setActive(self.viewGO, true)

	self._txtReceiveRemainTime = gohelper.findChildText(self.viewGO, "image_TimeBG/#txt_remainTime")
	self._btnClaim = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_Claim")
	self._goNormal = gohelper.findChild(self.viewGO, "#btn_Claim/#go_Normal")
	self._goHasReceived = gohelper.findChild(self.viewGO, "#btn_Claim/#go_Received")
	self._btnCloseReceive = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_Close")
	self._btnBgClose = gohelper.findChildButtonWithAudio(self.viewGO, "close")
	self._txtskin = gohelper.findChildText(self.viewGO, "role_name/txt_name")
	self._txtname = gohelper.findChildText(self.viewGO, "role_name/txt_name/txt")
	self._btnIcon = gohelper.findChildButtonWithAudio(self.viewGO, "role_name")
end

function V3a4_GoldenMilletPresentReceiveView:addEvents()
	self._btnClaim:AddClickListener(self._btnClaimOnClick, self)

	if self._btnCloseReceive then
		self._btnCloseReceive:AddClickListener(self._btnCloseReceiveOnClick, self)
	end

	if self._btnBgClose then
		self._btnBgClose:AddClickListener(self._btnCloseReceiveOnClick, self)
	end

	if self._btnIcon then
		self._btnIcon:AddClickListener(self._btnGotoOnClick, self)
	end

	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseViewFinish, self.afterReceive, self)
end

function V3a4_GoldenMilletPresentReceiveView:removeEvents()
	self._btnClaim:RemoveClickListener()

	if self._btnCloseReceive then
		self._btnCloseReceive:RemoveClickListener()
	end

	if self._btnBgClose then
		self._btnBgClose:RemoveClickListener()
	end

	if self._btnIcon then
		self._btnIcon:RemoveClickListener()
	end

	self.removeEventCb(self, ViewMgr.instance, ViewEvent.OnCloseViewFinish, self.afterReceive, self)
end

function V3a4_GoldenMilletPresentReceiveView:_btnClaimOnClick()
	GoldenMilletPresentController.instance:receiveGoldenMilletPresent(self.afterReceive, self)
	AudioMgr.instance:trigger(AudioEnum.GoldenMillet.stop_ui_tangren_songpifu_loop)
end

function V3a4_GoldenMilletPresentReceiveView:_btnCloseReceiveOnClick()
	TaskDispatcher.cancelTask(self.refreshRemainTime, self)
	AudioMgr.instance:trigger(AudioEnum.GoldenMillet.stop_ui_tangren_songpifu_loop)
	self:closeThis()
end

function V3a4_GoldenMilletPresentReceiveView:_btnGotoOnClick()
	local id = GoldenMilletEnum.Index2Skin[1]

	CharacterController.instance:openCharacterSkinTipView({
		isShowHomeBtn = false,
		skinId = id
	})
end

function V3a4_GoldenMilletPresentReceiveView:onOpen()
	self:refreshRemainTime()
	TaskDispatcher.cancelTask(self.refreshRemainTime, self)
	TaskDispatcher.runRepeat(self.refreshRemainTime, self, TimeUtil.OneMinuteSecond)
	self:refreshReceiveStatus()
	AudioMgr.instance:trigger(AudioEnum.UI.GoldenMilletReceiveViewOpen)
	AudioMgr.instance:trigger(AudioEnum.GoldenMillet.play_ui_tangren_songpifu_loop)

	local skinId = GoldenMilletEnum.FreeSkin
	local skinCo = SkinConfig.instance:getSkinCo(skinId)
	local heroConfig = HeroConfig.instance:getHeroCO(skinCo.characterId)

	self._txtskin.text = skinCo.characterSkin
	self._txtname.text = "— " .. heroConfig.name
end

function V3a4_GoldenMilletPresentReceiveView:refreshReceiveStatus()
	local haveReceived = GoldenMilletPresentModel.instance:haveReceivedSkin()

	gohelper.setActive(self._goNormal, not haveReceived)
	gohelper.setActive(self._goHasReceived, haveReceived)
end

function V3a4_GoldenMilletPresentReceiveView:afterReceive(viewName)
	if viewName == ViewName.CommonPropView then
		self.viewContainer:openGoldMilletPresentDisplayView()
	end
end

function V3a4_GoldenMilletPresentReceiveView:refreshRemainTime()
	local actId = GoldenMilletPresentModel.instance:getGoldenMilletPresentActId()
	local actInfoMo = ActivityModel.instance:getActMO(actId)
	local timeStr = actInfoMo:getRemainTimeStr3(false, true)

	self._txtReceiveRemainTime.text = string.format(luaLang("remain"), timeStr)
end

function V3a4_GoldenMilletPresentReceiveView:onClose()
	TaskDispatcher.cancelTask(self.refreshRemainTime, self)
	AudioMgr.instance:trigger(AudioEnum.GoldenMillet.stop_ui_tangren_songpifu_loop)
end

return V3a4_GoldenMilletPresentReceiveView
