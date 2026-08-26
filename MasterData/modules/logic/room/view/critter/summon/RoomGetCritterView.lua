-- chunkname: @modules/logic/room/view/critter/summon/RoomGetCritterView.lua

module("modules.logic.room.view.critter.summon.RoomGetCritterView", package.seeall)

local RoomGetCritterView = class("RoomGetCritterView", BaseView)

function RoomGetCritterView:onInitView()
	self._goegg = gohelper.findChild(self.viewGO, "#go_egg")
	self._btnegg = gohelper.findChildButtonWithAudio(self.viewGO, "#go_egg/#btn_egg")
	self._gocritter = gohelper.findChild(self.viewGO, "#go_critter")
	self._gotip = gohelper.findChild(self.viewGO, "#go_critter/txt_tips")
	self._simagefullbg1 = gohelper.findChildSingleImage(self.viewGO, "#go_critter/#simage_fullbg1")
	self._simagefullbg2 = gohelper.findChildSingleImage(self.viewGO, "#go_critter/#simage_fullbg2")
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "#go_critter/#btn_close")
	self._simagetitle = gohelper.findChildSingleImage(self.viewGO, "#go_critter/#simage_title")
	self._simagecard = gohelper.findChildSingleImage(self.viewGO, "#go_critter/#simage_card")
	self._simagecritter = gohelper.findChildSingleImage(self.viewGO, "#go_critter/#simage_critter")
	self._gospine = gohelper.findChild(self.viewGO, "#go_critter/#simage_critter/#go_spine")
	self._gostarList = gohelper.findChild(self.viewGO, "#go_critter/#go_starList")
	self._goagain = gohelper.findChild(self.viewGO, "#go_critter/#go_again")
	self._btnsummon = gohelper.findChildButtonWithAudio(self.viewGO, "#go_critter/#go_again/#btn_summon")
	self._simagecurrency = gohelper.findChildSingleImage(self.viewGO, "#go_critter/#go_again/currency/#simage_currency")
	self._txtcurrency = gohelper.findChildText(self.viewGO, "#go_critter/#go_again/currency/#txt_currency")
	self._btnskip = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_skip")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function RoomGetCritterView:addEvents()
	self._btnegg:AddClickListener(self._btnEggOnClick, self)
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
	self._btnsummon:AddClickListener(self._btnsummonOnClick, self)
	self._btnskip:AddClickListener(self._btnskipOnClick, self)
end

function RoomGetCritterView:removeEvents()
	self._btnegg:RemoveClickListener()
	self._btnclose:RemoveClickListener()
	self._btnsummon:RemoveClickListener()
	self._btnskip:RemoveClickListener()
end

function RoomGetCritterView:_addEvents()
	self.addEventCb(self, CritterSummonController.instance, CritterSummonEvent.onStartSummon, self._onStartSummon, self)
	self.addEventCb(self, CritterSummonController.instance, CritterSummonEvent.onSummonSkip, self._onSummonSkip, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnOpenView, self._onOpenView, self)
	self.addEventCb(self, CritterSummonController.instance, CritterSummonEvent.onCloseRoomCriiterDetailSimpleView, self._onCloseRoomCriiterDetailSimpleView, self)
end

function RoomGetCritterView:_removeEvents()
	self.removeEventCb(self, CritterSummonController.instance, CritterSummonEvent.onStartSummon, self._onStartSummon, self)
	self.removeEventCb(self, CritterSummonController.instance, CritterSummonEvent.onSummonSkip, self._onSummonSkip, self)
	self.removeEventCb(self, ViewMgr.instance, ViewEvent.OnOpenView, self._onOpenView, self)
	self.removeEventCb(self, CritterSummonController.instance, CritterSummonEvent.onCloseRoomCriiterDetailSimpleView, self._onCloseRoomCriiterDetailSimpleView, self)
	self._critterAnimEvent:RemoveEventListener("closeEgg")
end

function RoomGetCritterView:_btnEggOnClick()
	if self.isOpeningEgg then
		return
	end

	self.isOpeningEgg = true

	if self._egg then
		self._egg:playOpenAnim(self.playerEggAnimFinish, self)
		AudioMgr.instance:trigger(AudioEnum.Room.play_ui_home_niudan_open)
	end

	self:showCritter(true)
end

function RoomGetCritterView:_btncloseOnClick()
	if self._critterMOList and #self._critterMOList > 0 then
		self._critterMo = self._critterMOList[1]

		table.remove(self._critterMOList, 1)
		self:_showGetCritter()

		return
	end

	if self._mode ~= RoomSummonEnum.SummonType.ItemGet and not ViewMgr.instance:isOpen(ViewName.RoomCritterSummonResultView) then
		CritterController.instance:dispatchEvent(CritterEvent.CritterBuildingViewRefreshCamera)
		CritterSummonController.instance:dispatchEvent(CritterSummonEvent.onCloseGetCritter)
	end

	self:closeThis()
end

function RoomGetCritterView:_btnsummonOnClick()
	local toast, name = CritterSummonModel.instance:notSummonToast(self._poolId)

	if string.nilorempty(toast) then
		CritterRpc.instance:sendSummonCritterRequest(self._poolId, self._summonCount)
	else
		GameFacade.showToast(toast, name)
	end
end

function RoomGetCritterView:_btncardOnClick()
	CritterController.instance:openCriiterDetailSimpleView(self._critterMo)
end

function RoomGetCritterView:_btnskipOnClick()
	self:closeThis()
end

function RoomGetCritterView:_editableInitView()
	self._txtname = gohelper.findChildText(self.viewGO, "#go_critter/txt_crittername")
	self._eggRareVX = {
		[3] = gohelper.findChild(self.viewGO, "#go_egg/bg/r"),
		[4] = gohelper.findChild(self.viewGO, "#go_egg/bg/sr"),
		[5] = gohelper.findChild(self.viewGO, "#go_egg/bg/ssr")
	}
	self._star = self:getUserDataTb_()

	for i = 1, self._gostarList.transform.childCount do
		local child = gohelper.findChild(self._gostarList, "star" .. i)

		table.insert(self._star, child)
	end

	self._critterAnim = SLFramework.AnimatorPlayer.Get(self._gocritter)
	self._critterAnimEvent = self._gocritter:GetComponent(gohelper.Type_AnimationEventWrap)

	self._critterAnimEvent:AddEventListener("closeEgg", self.closeEggCallback, self)
end

function RoomGetCritterView:closeEggCallback()
	gohelper.setActive(self._goegg.gameObject, false)
	AudioMgr.instance:trigger(AudioEnum.Room.play_ui_home_niudan_show)
end

function RoomGetCritterView:onUpdateParam()
	return
end

function RoomGetCritterView:onClickModalMask()
	self:_btncloseOnClick()
end

function RoomGetCritterView:_onSummonSkip()
	self:showCritter(true)
	self:playCritterSkipAnim()
end

function RoomGetCritterView:onOpen()
	self:_addEvents()

	self._summonCount = 1
	self._mode = self.viewParam.mode
	self._critterMOList = {}

	if self._mode == RoomSummonEnum.SummonType.Summon then
		self._poolId = self.viewParam.poolId
		self._critterMo = self.viewParam.critterMo

		if self.viewParam and self.viewParam.critterMOList then
			tabletool.addValues(self._critterMOList, self.viewParam.critterMOList)
			tabletool.removeValue(self._critterMOList, self._critterMo)
		end
	elseif self._mode == RoomSummonEnum.SummonType.ItemGet then
		self._critterMOList = self.viewParam.critterMOList
		self._critterMo = self._critterMOList[1]

		table.remove(self._critterMOList, 1)
	end

	self._critterMo = self.viewParam.critterMo

	do
		local critterMo = CritterIncubateController.instance:checkHasChildCritter()

		if critterMo then
			table.insert(self._critterMOList, critterMo)
		end
	end

	gohelper.setActive(self._btnskip, self._critterMOList and #self._critterMOList > 1)
	self:_showGetCritter()
end

function RoomGetCritterView:_showGetCritter()
	self.isOpeningEgg = false

	gohelper.setActive(self._simagecard.gameObject, true)

	local co = self._critterMo:getDefineCfg()

	self._rare = co.rare
	self._rareCo = CritterConfig.instance:getCritterRareCfg(self._rare)

	for rare, go in pairs(self._eggRareVX) do
		gohelper.setActive(go, rare == self._rare)
	end

	if self._critterMo then
		self:refreshCritter()
	end

	gohelper.setActive(self._btnclose.gameObject, false)
	gohelper.setActive(self._gotip.gameObject, false)
	self:_refreshSingleCost()

	local cardGo = gohelper.findChild(self.viewGO, "#go_critter/#simage_card")

	self._cardBtn = SLFramework.UGUI.UIClickListener.Get(cardGo)

	self._cardBtn:AddClickListener(self._btncardOnClick, self)
	self:_onRefreshBtn()
	self:critterSpine()

	local isSkip = self.viewParam.isSkip

	self:showCritter(isSkip)
	gohelper.setActive(self._goegg.gameObject, not isSkip)

	if isSkip then
		self:playCritterSkipAnim()
	else
		if not self._egg then
			local path = ResUrl.getRoomCritterEggPrefab(self._rareCo.eggRes)
			local parent = gohelper.findChild(self.viewGO, "#go_egg/egg")
			local childGO = self:getResInst(path, parent)

			self._egg = MonoHelper.addNoUpdateLuaComOnceToGo(childGO, RoomGetCritterEgg)
		end

		self:playerEggAnim()
		AudioMgr.instance:trigger(AudioEnum.Room.play_ui_home_niudan_obtain)
	end
end

function RoomGetCritterView:playCritterSkipAnim()
	self._critterAnim:Play("skip", self.showCloseBtn, self)
end

function RoomGetCritterView:playCritterOpenAnim()
	self._critterAnim:Play("open", self.showCloseBtn, self)
end

function RoomGetCritterView:showCloseBtn()
	gohelper.setActive(self._btnclose.gameObject, true)
	gohelper.setActive(self._gotip.gameObject, true)
end

function RoomGetCritterView:onClose()
	self:_removeEvents()

	self.isOpeningEgg = false
end

function RoomGetCritterView:_onRefreshBtn()
	if self._mode == RoomSummonEnum.SummonType.Summon then
		local toast = CritterSummonModel.instance:notSummonToast(self._poolId)
		local isCan = string.nilorempty(toast)

		ZProj.UGUIHelper.SetGrayscale(self._btnsummon.gameObject, not isCan)
	end

	gohelper.setActive(self._goagain.gameObject, self._mode == RoomSummonEnum.SummonType.Summon and self._poolId ~= nil)
end

function RoomGetCritterView:onDestroyView()
	self._simagecard:UnLoadImage()
	self._simagecurrency:UnLoadImage()
	self._cardBtn:RemoveClickListener()
end

function RoomGetCritterView:playerEggAnim()
	self._egg:playIdleAnim(self.playerEggIdleAnimFinish, self)
end

function RoomGetCritterView:playerEggIdleAnimFinish()
	return
end

function RoomGetCritterView:playerEggAnimFinish()
	self.isOpeningEgg = false

	CritterSummonController.instance:dispatchEvent(CritterSummonEvent.onOpenEgg)
end

function RoomGetCritterView:refreshIcon()
	return
end

function RoomGetCritterView:refreshCritter()
	local iconPath = ResUrl.getRoomCritterIcon(self._rareCo.cardRes)

	self._simagecard:LoadImage(iconPath)

	self._txtname.text = self._critterMo:getName()

	for i = 1, #self._star do
		gohelper.setActive(self._star[i].gameObject, i <= self._rare + 1)
	end

	self:refreshIcon()
end

function RoomGetCritterView:showCritter(isShow)
	gohelper.setActive(self._gocritter, isShow)

	if isShow then
		self:playCritterOpenAnim()
	end
end

function RoomGetCritterView:_refreshSingleCost()
	local cost_icon, str, _ = CritterSummonModel.instance:getPoolCurrency(self._poolId)

	if not string.nilorempty(cost_icon) then
		self._simagecurrency:LoadImage(cost_icon)

		self._txtcurrency.text = str
	end
end

function RoomGetCritterView:_onStartSummon(param)
	self:closeThis()
	CritterSummonController.instance:openSummonView(nil, param)
end

function RoomGetCritterView:_onOpenView(viewName)
	if viewName == ViewName.RoomCriiterDetailSimpleView then
		gohelper.setActive(self._simagecard.gameObject, false)
	end
end

function RoomGetCritterView:_onCloseRoomCriiterDetailSimpleView()
	gohelper.setActive(self._simagecard.gameObject, true)
end

function RoomGetCritterView:critterSpine()
	self.bigSpine = self.bigSpine or MonoHelper.addNoUpdateLuaComOnceToGo(self._gospine, RoomCritterUISpine)

	self.bigSpine:stopVoice()
	self.bigSpine:setResPath(self._critterMo)
end

return RoomGetCritterView
