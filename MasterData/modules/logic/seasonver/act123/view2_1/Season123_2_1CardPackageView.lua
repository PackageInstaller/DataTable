-- chunkname: @modules/logic/seasonver/act123/view2_1/Season123_2_1CardPackageView.lua

module("modules.logic.seasonver.act123.view2_1.Season123_2_1CardPackageView", package.seeall)

local Season123_2_1CardPackageView = class("Season123_2_1CardPackageView", BaseView)

function Season123_2_1CardPackageView:onInitView()
	self._gocardpackage = gohelper.findChild(self.viewGO, "#go_cardpackage")
	self._gocardgetBtns = gohelper.findChild(self.viewGO, "#go_cardpackage/cardgetBtns")
	self._gopackageCount = gohelper.findChild(self.viewGO, "#go_cardpackage/cardpackage/package/#go_packageCount")
	self._txtpackageCount = gohelper.findChildText(self.viewGO, "#go_cardpackage/cardpackage/package/#go_packageCount/#txt_packageCount")
	self._btnopenPackage = gohelper.findChildButtonWithAudio(self.viewGO, "#go_cardpackage/cardgetBtns/#btn_openPackage")
	self._btnopenOnePackage = gohelper.findChildButtonWithAudio(self.viewGO, "#go_cardpackage/cardgetBtns/#btn_openOnePackage")
	self._btnopenAllPackage = gohelper.findChildButtonWithAudio(self.viewGO, "#go_cardpackage/cardgetBtns/#btn_openAllPackage")
	self._gowaitingOpen = gohelper.findChild(self.viewGO, "#go_cardpackage/#go_waitingOpen")
	self._gorealOpen = gohelper.findChild(self.viewGO, "#go_cardpackage/#go_waitingOpen/#drag_realOpen")
	self._gocardget = gohelper.findChild(self.viewGO, "#go_cardget")
	self._scrollcardget = gohelper.findChildScrollRect(self.viewGO, "#go_cardget/mask/#scroll_cardget")
	self._gocardContent = gohelper.findChild(self.viewGO, "#go_cardget/mask/#scroll_cardget/Viewport/#go_cardContent")
	self._gocarditem = gohelper.findChild(self.viewGO, "#go_cardget/mask/#scroll_cardget/Viewport/#go_cardContent/#go_carditem")
	self._btnquit = gohelper.findChildButtonWithAudio(self.viewGO, "#go_cardget/#btn_quit")
	self._btnopenNext = gohelper.findChildButtonWithAudio(self.viewGO, "#go_cardget/cardgetBtns/#btn_openNext")
	self._btnskip = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_skip")
	self._imageskip = gohelper.findChildImage(self.viewGO, "#btn_skip/#image_skip")
	self._gobtns = gohelper.findChild(self.viewGO, "#go_btns")
	self._goopenEffect = gohelper.findChild(self.viewGO, "#go_cardpackage/cardpackage/package/openup")
	self._goopenLineEffect = gohelper.findChild(self.viewGO, "#go_cardpackage/cardpackage/package/kabao/go_line")
	self._animator = ZProj.ProjAnimatorPlayer.Get(self.viewGO)
	self._dragrealOpen = SLFramework.UGUI.UIDragListener.Get(self._gorealOpen)

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Season123_2_1CardPackageView:addEvents()
	self._btnopenPackage:AddClickListener(self._btnopenPackageOnClick, self)
	self._btnopenOnePackage:AddClickListener(self._btnopenOnePackageOnClick, self)
	self._btnopenAllPackage:AddClickListener(self._btnopenAllPackageOnClick, self)
	self._dragrealOpen:AddDragBeginListener(self._onDragBegin, self)
	self._dragrealOpen:AddDragEndListener(self._onDragEnd, self)
	self._btnquit:AddClickListener(self._btnquitOnClick, self)
	self._btnopenNext:AddClickListener(self._btnopenNextOnClick, self)
	self._btnskip:AddClickListener(self._btnskipOnClick, self)
	self.addEventCb(self, Season123Controller.instance, Season123Event.OnCardPackageOpen, self.showWaitingOpenView, self)
end

function Season123_2_1CardPackageView:removeEvents()
	self._btnopenPackage:RemoveClickListener()
	self._btnopenOnePackage:RemoveClickListener()
	self._btnopenAllPackage:RemoveClickListener()
	self._dragrealOpen:RemoveDragBeginListener()
	self._dragrealOpen:RemoveDragEndListener()
	self._btnquit:RemoveClickListener()
	self._btnopenNext:RemoveClickListener()
	self._btnskip:RemoveClickListener()
	self.removeEventCb(self, Season123Controller.instance, Season123Event.OnCardPackageOpen, self.showWaitingOpenView, self)
end

Season123_2_1CardPackageView.hideCardPackageTime = 0.33

function Season123_2_1CardPackageView:_btnopenPackageOnClick()
	self:openCardPackage()
end

function Season123_2_1CardPackageView:_btnopenOnePackageOnClick()
	self:openCardPackage()
end

function Season123_2_1CardPackageView:_btnopenAllPackageOnClick()
	if self.hasClickOpen then
		return
	end

	Activity123Rpc.instance:sendAct123OpenCardBagRequest(self.actId, Activity123Enum.openAllCardPackage)
	Activity123Rpc.instance:sendGetUnlockAct123EquipIdsRequest(self.actId)
end

function Season123_2_1CardPackageView:_onDragBegin(param, pointerEventData)
	self._startPos = pointerEventData.position.x
end

function Season123_2_1CardPackageView:_onDragEnd(param, pointerEventData)
	local endPos = pointerEventData.position.x
	local distance = recthelper.getWidth(self._gorealOpen.transform) / 4

	if endPos > self._startPos and distance <= Mathf.Abs(endPos - self._startPos) then
		self:playOpenCardAnim()
		gohelper.setActive(self._gowaitingOpen, false)
	end
end

function Season123_2_1CardPackageView:_btnskipOnClick()
	if self.hasClickSkip then
		return
	end

	self._animator:Stop()
	self._animator:Play("kabao_skip", self.showCardGetView, self)

	local maxRare = Season123CardPackageModel.instance:getCardMaxRare()

	for i = 2, 5 do
		gohelper.setActive(self.rareEffectList[i], i == maxRare)
	end

	self.hasClickSkip = true
end

function Season123_2_1CardPackageView:_btnquitOnClick()
	self:closeThis()
end

function Season123_2_1CardPackageView:_btnopenNextOnClick()
	self:openCardPackage()
end

function Season123_2_1CardPackageView:_editableInitView()
	self.rareEffectList = self:getUserDataTb_()
	self.rareLineEffectList = self:getUserDataTb_()
	self.actId = Season123Model.instance:getCurSeasonId()
	self.contentGrid = self._gocardContent:GetComponent(typeof(UnityEngine.UI.GridLayoutGroup))

	for i = 2, 5 do
		local goRare = gohelper.findChild(self._goopenEffect, "go_rare" .. i)
		local goLineRare = gohelper.findChild(self._goopenLineEffect, "go_rare" .. i)

		self.rareEffectList[i] = goRare
		self.rareLineEffectList[i] = goLineRare

		gohelper.setActive(goRare, false)
		gohelper.setActive(goLineRare, false)
	end

	self.hasClickSkip = false
	self.hasClickOpen = false
end

function Season123_2_1CardPackageView:onOpen()
	self:refreshCardPackageUI()
	gohelper.setActive(self._gocardgetBtns, true)
	gohelper.setActive(self._btnskip.gameObject, false)
	gohelper.setActive(self._gowaitingOpen, false)
	gohelper.setActive(self._gobtns, true)
	AudioMgr.instance:trigger(AudioEnum.Season123.play_ui_jinye_cardpacks_unfold)
end

function Season123_2_1CardPackageView:refreshCardPackageUI()
	gohelper.setActive(self._gocardpackage, true)
	gohelper.setActive(self._gocardget, false)

	self.curPackageCount = Season123CardPackageModel.instance:initPackageCount()
	self._txtpackageCount.text = self.curPackageCount

	gohelper.setActive(self._btnopenPackage.gameObject, self.curPackageCount == 1)
	gohelper.setActive(self._btnopenOnePackage.gameObject, self.curPackageCount > 1)
	gohelper.setActive(self._btnopenAllPackage.gameObject, self.curPackageCount > 1)
end

function Season123_2_1CardPackageView:showWaitingOpenView()
	self._animator:Play("kabao_wait")
	self:refreshCardPackageUI()
	gohelper.setActive(self._gowaitingOpen, true)
	gohelper.setActive(self._gocardgetBtns, false)
	gohelper.setActive(self._gobtns, false)
end

function Season123_2_1CardPackageView:playOpenCardAnim()
	self:refreshCardPackageUI()
	gohelper.setActive(self._btnskip.gameObject, true)
	gohelper.setActive(self._gocardgetBtns, false)
	self._animator:Play("kabao_open", self.showCardGetView, self)

	self.openCardPackageAudioId = AudioMgr.instance:trigger(AudioEnum.Season123.play_ui_jinye_cardpacks_open)

	local maxRare = Season123CardPackageModel.instance:getCardMaxRare()

	for i = 2, 5 do
		gohelper.setActive(self.rareEffectList[i], i == maxRare)
		gohelper.setActive(self.rareLineEffectList[i], i == maxRare)
	end
end

function Season123_2_1CardPackageView:showCardGetView()
	self:refreshCardGetUI()
	TaskDispatcher.runDelay(self.hideCardPackageView, self, Season123_2_1CardPackageView.hideCardPackageTime)

	if self.hasClickSkip then
		self:stopOpenCardPackageAudio()
	end

	Season123Controller.instance:dispatchEvent(Season123Event.GotCardView)
end

function Season123_2_1CardPackageView:hideCardPackageView()
	gohelper.setActive(self._gocardpackage, false)

	self.hasClickSkip = false
end

function Season123_2_1CardPackageView:refreshCardGetUI()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_leimi_celebrity_get)
	gohelper.setActive(self._gocardget, true)
	gohelper.setActive(self._btnskip.gameObject, false)
	self:refreshScrollPos()
	gohelper.setActive(self._btnopenNext, self.curPackageCount > 0)
	gohelper.setActive(self._btnquit, true)
	gohelper.setActive(self._gobtns, false)

	self.hasClickOpen = false
end

function Season123_2_1CardPackageView:refreshScrollPos()
	local itemCount = Season123CardPackageModel.instance:getCount()

	if itemCount <= 6 then
		self.contentGrid.enabled = false
		self.contentGrid.enabled = true

		transformhelper.setLocalPosXY(self._scrollcardget.transform, 0, -680)
	else
		self.contentGrid.enabled = false

		transformhelper.setLocalPosXY(self._scrollcardget.transform, 0, -570)
	end
end

function Season123_2_1CardPackageView:openCardPackage()
	if self.hasClickOpen then
		return
	end

	self.hasClickOpen = true

	local packageItemMO = Season123CardPackageModel.instance:getOpenPackageMO()

	Activity123Rpc.instance:sendAct123OpenCardBagRequest(self.actId, packageItemMO.id)
	Activity123Rpc.instance:sendGetUnlockAct123EquipIdsRequest(self.actId)
	self:stopOpenCardPackageAudio()
end

function Season123_2_1CardPackageView:stopOpenCardPackageAudio()
	if self.openCardPackageAudioId then
		AudioMgr.instance:stopPlayingID(self.openCardPackageAudioId)

		self.openCardPackageAudioId = nil
	end
end

function Season123_2_1CardPackageView:onClose()
	TaskDispatcher.cancelTask(self.hideCardPackageView, self)
	self:stopOpenCardPackageAudio()
end

function Season123_2_1CardPackageView:onDestroyView()
	Season123CardPackageModel.instance:release()
end

return Season123_2_1CardPackageView
