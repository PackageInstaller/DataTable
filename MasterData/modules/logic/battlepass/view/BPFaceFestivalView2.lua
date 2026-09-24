-- chunkname: @modules/logic/battlepass/view/BPFaceFestivalView2.lua

module("modules.logic.battlepass.view.BPFaceFestivalView2", package.seeall)

local BPFaceFestivalView2 = class("BPFaceFestivalView2", BaseView)
local Statu = {
	CloseAnim = 100,
	Idle = 1,
	CardAnimIdle = 3,
	FinalIdle = 5,
	OpenCardAnim = 2,
	TweenAnim = 4
}

BPFaceFestivalView2.OPEN_TYPE = {
	StoreSkin = 1
}

function BPFaceFestivalView2:onInitView()
	self._anim = gohelper.findChildAnim(self.viewGO, "")
	self._btnClose = gohelper.findChildButtonWithAudio(self.viewGO, "main/icon/#btn_close")
	self._btnCloseBg = gohelper.findChildButtonWithAudio(self.viewGO, "main/#btn_closeBg")
	self._btnStart = gohelper.findChildButtonWithAudio(self.viewGO, "main/#btn_start")
	self._btnClickCard = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_fullclick")

	local _namePaths = {
		"main/desc",
		"guochang/#go_step2/desc"
	}

	self._nameTbList = {}

	for _, childPath in ipairs(_namePaths) do
		local go = gohelper.findChild(self.viewGO, childPath)

		if not gohelper.isNil(go) then
			table.insert(self._nameTbList, self:_createNameItemTB(go))
		end
	end
end

function BPFaceFestivalView2:addEvents()
	self._btnClose:AddClickListener(self.onBtnCloseClick, self, BpEnum.ButtonName.Close)
	self._btnCloseBg:AddClickListener(self.onBtnCloseClick, self, BpEnum.ButtonName.CloseBg)
	self._btnStart:AddClickListener(self._openBpView, self)
	self._btnClickCard:AddClickListener(self._onClickCard, self)
end

function BPFaceFestivalView2:removeEvents()
	self._btnClose:RemoveClickListener()
	self._btnCloseBg:RemoveClickListener()
	self._btnStart:RemoveClickListener()
	self._btnClickCard:RemoveClickListener()
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseView, self._onViewClose, self)
end

function BPFaceFestivalView2:_openBpView()
	if not self:canClickClose() then
		return
	end

	self:statData(BpEnum.ButtonName.Goto)
	BpController.instance:openBattlePassView(nil, nil, true)
	ViewMgr.instance:registerCallback(ViewEvent.OnCloseView, self._onViewClose, self)
end

function BPFaceFestivalView2:onClickModalMask()
	if not self:canClickClose() then
		return
	end

	self:onBtnCloseClick(BpEnum.ButtonName.CloseBg)
end

function BPFaceFestivalView2:_onClickCard()
	if self._statu == Statu.Idle then
		self._statu = Statu.OpenCardAnim

		TaskDispatcher.runDelay(self._delayPlayAudio, self, 1.5)
		self._anim:Play("tarot_click", 0, 0)
		AudioMgr.instance:trigger(AudioEnum4_0.BP.play_ui_yingmen4_0_bp_show)
	elseif self._statu == Statu.CardAnimIdle then
		self._statu = Statu.TweenAnim

		self._anim:Play("tarot_click1", 0, 0)
		AudioMgr.instance:trigger(AudioEnum4_0.BP.play_ui_yingmen4_0_open)
		TaskDispatcher.runDelay(self._delayFinishAnim, self, 1)
	end
end

function BPFaceFestivalView2:canClickClose()
	return self._statu == Statu.FinalIdle
end

function BPFaceFestivalView2:_delayPlayAudio()
	self._statu = Statu.CardAnimIdle
end

function BPFaceFestivalView2:_delayFinishAnim()
	self._statu = Statu.FinalIdle

	gohelper.setActive(self._btnClickCard, false)
end

function BPFaceFestivalView2:onBtnCloseClick(statParam)
	if not self:canClickClose() then
		return
	end

	self:statData(statParam)
	self:closeThis()
end

function BPFaceFestivalView2:_onViewClose(viewName)
	if viewName == ViewName.BpView or viewName == ViewName.StoreView then
		self:closeThis()
	end
end

function BPFaceFestivalView2:onOpen()
	self._closeCallback = self.viewParam and self.viewParam.closeCallback
	self._cbObj = self.viewParam and self.viewParam.cbObj
	self._statu = Statu.Idle

	AudioMgr.instance:trigger(AudioEnum4_0.BP.play_ui_yingmen4_0_bp_open)

	local co = BpConfig.instance:getBpCO(BpModel.instance.id)

	for _, tb in ipairs(self._nameTbList) do
		tb._txtskinname.text = co.bpSkinDesc
		tb._txtname.text = co.bpSkinNametxt
		tb._txtnameEn.text = co.bpSkinEnNametxt

		local skinId = BpConfig.instance:getCurSkinId(BpModel.instance.id)
		local heroId = lua_skin.configDict[skinId].characterId
		local heroCo = lua_character.configDict[heroId]

		tb._simagesignature:LoadImage(ResUrl.getSignature(heroCo.signature))
	end

	local key = string.format("%s#%s#%s", PlayerPrefsKey.FirstShowPatFace, "BPFace", PlayerModel.instance:getPlayinfo().userId)

	PlayerPrefsHelper.setString(key, tostring(BpModel.instance.id))
end

function BPFaceFestivalView2:_createNameItemTB(go)
	local tb = self:getUserDataTb_()

	tb._txtskinname = gohelper.findChildTextMesh(go, "#txt_skinname")
	tb._txtname = gohelper.findChildTextMesh(go, "#txt_skinname/#txt_name")
	tb._txtnameEn = gohelper.findChildTextMesh(go, "#txt_skinname/#txt_name/#txt_enname")
	tb._simagesignature = gohelper.findChildSingleImage(go, "#simage_signature")

	return tb
end

function BPFaceFestivalView2:statData(param)
	StatController.instance:track(StatEnum.EventName.BP_Click_Face_Slapping, {
		[StatEnum.EventProperties.BP_Button_Name] = param
	})
end

function BPFaceFestivalView2:onClose()
	TaskDispatcher.cancelTask(self._delayFinishAnim, self)
	TaskDispatcher.cancelTask(self._delayPlayAudio, self)
	AudioMgr.instance:trigger(AudioEnum4_0.BP.stop_ui_yingmen4_0_bp_show)

	if self._nameTbList and #self._nameTbList > 0 then
		for _, tb in ipairs(self._nameTbList) do
			tb._simagesignature:UnLoadImage()
		end

		self._nameTbList = nil
	end

	if self._closeCallback then
		if self._cbObj then
			self._closeCallback(self._cbObj)
		else
			self._closeCallback()
		end
	end
end

return BPFaceFestivalView2
