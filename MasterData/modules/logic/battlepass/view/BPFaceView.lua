-- chunkname: @modules/logic/battlepass/view/BPFaceView.lua

module("modules.logic.battlepass.view.BPFaceView", package.seeall)

local BPFaceView = class("BPFaceView", BaseView)
local Statu = {
	Idle = 1,
	CardAnimIdle = 3,
	FinalIdle = 5,
	OpenCardAnim = 2,
	TweenAnim = 4
}

function BPFaceView:onInitView()
	self._anim = gohelper.findChildAnim(self.viewGO, "")
	self._btnClose = gohelper.findChildButtonWithAudio(self.viewGO, "main/#simage_fullbg/icon/#btn_close")
	self._btnCloseBg = gohelper.findChildButtonWithAudio(self.viewGO, "main/#btn_closeBg")
	self._btnStart = gohelper.findChildButtonWithAudio(self.viewGO, "main/#btn_start")
	self._simagesignature = gohelper.findChildSingleImage(self.viewGO, "main/desc/#simage_signature")
	self._txtskinname = gohelper.findChildTextMesh(self.viewGO, "main/desc/#txt_skinname")
	self._txtname = gohelper.findChildTextMesh(self.viewGO, "main/desc/#txt_skinname/#txt_name")
	self._txtnameEn = gohelper.findChildTextMesh(self.viewGO, "main/desc/#txt_skinname/#txt_name/#txt_enname")
	self._btnClickCard = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_fullclick")
end

function BPFaceView:addEvents()
	self._btnClose:AddClickListener(self.onBtnCloseClick, self, BpEnum.ButtonName.Close)
	self._btnCloseBg:AddClickListener(self.onBtnCloseClick, self, BpEnum.ButtonName.CloseBg)
	self._btnStart:AddClickListener(self._openBpView, self)
	self._btnClickCard:AddClickListener(self._onClickCard, self)
end

function BPFaceView:removeEvents()
	self._btnClose:RemoveClickListener()
	self._btnCloseBg:RemoveClickListener()
	self._btnStart:RemoveClickListener()
	self._btnClickCard:RemoveClickListener()
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseView, self._onViewClose, self)
end

function BPFaceView:_openBpView()
	if not self:canClickClose() then
		return
	end

	self:statData(BpEnum.ButtonName.Goto)
	ViewMgr.instance:registerCallback(ViewEvent.OnCloseView, self._onViewClose, self)
	BpController.instance:openBattlePassView(nil, nil, true)
end

function BPFaceView:onClickModalMask()
	if not self:canClickClose() then
		return
	end

	self:onBtnCloseClick(BpEnum.ButtonName.CloseBg)
end

function BPFaceView:_onClickCard()
	if self._statu == Statu.Idle then
		self._statu = Statu.OpenCardAnim

		TaskDispatcher.runDelay(self._delayPlayAudio, self, 1.5)
		self._anim:Play("tarot_click", 0, 0)
		AudioMgr.instance:trigger(AudioEnum2_6.BP.FaceView)
	elseif self._statu == Statu.CardAnimIdle then
		self._statu = Statu.TweenAnim

		self._anim:Play("tarot_click1", 0, 0)
		AudioMgr.instance:trigger(AudioEnum.Act187.play_ui_yuanxiao_switch)
		TaskDispatcher.runDelay(self._delayFinishAnim, self, 1)
	end
end

function BPFaceView:canClickClose()
	return self._statu == Statu.FinalIdle
end

function BPFaceView:_delayPlayAudio()
	self._statu = Statu.CardAnimIdle
end

function BPFaceView:_delayFinishAnim()
	self._statu = Statu.FinalIdle

	gohelper.setActive(self._btnClickCard, false)
end

function BPFaceView:onBtnCloseClick(statParam)
	if not self:canClickClose() then
		return
	end

	self:statData(statParam)
	self:closeThis()
end

function BPFaceView:_onViewClose(viewName)
	if viewName == ViewName.BpView then
		self:closeThis()
	end
end

function BPFaceView:onOpen()
	self._statu = Statu.Idle

	local co = BpConfig.instance:getBpCO(BpModel.instance.id)

	if co then
		self._txtskinname.text = co.bpSkinDesc
		self._txtname.text = co.bpSkinNametxt
		self._txtnameEn.text = co.bpSkinEnNametxt

		local skinId = BpConfig.instance:getCurSkinId(BpModel.instance.id)
		local heroId = lua_skin.configDict[skinId].characterId
		local heroCo = lua_character.configDict[heroId]

		self._simagesignature:LoadImage(ResUrl.getSignature(heroCo.signature))
	end

	local key = string.format("%s#%s#%s", PlayerPrefsKey.FirstShowPatFace, "BPFace", PlayerModel.instance:getPlayinfo().userId)

	PlayerPrefsHelper.setString(key, tostring(BpModel.instance.id))
end

function BPFaceView:statData(param)
	StatController.instance:track(StatEnum.EventName.BP_Click_Face_Slapping, {
		[StatEnum.EventProperties.BP_Button_Name] = param
	})
end

function BPFaceView:onClose()
	TaskDispatcher.cancelTask(self._delayFinishAnim, self)
	TaskDispatcher.cancelTask(self._delayPlayAudio, self)
end

return BPFaceView
