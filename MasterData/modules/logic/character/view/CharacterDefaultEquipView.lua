-- chunkname: @modules/logic/character/view/CharacterDefaultEquipView.lua

module("modules.logic.character.view.CharacterDefaultEquipView", package.seeall)

local CharacterDefaultEquipView = class("CharacterDefaultEquipView", BaseView)

function CharacterDefaultEquipView:onInitView()
	self.goequipcontainer = gohelper.findChild(self.viewGO, "anim/layout/auxiliary/#go_equipcontainer")
	self.goclickarea = gohelper.findChild(self.viewGO, "anim/layout/auxiliary/#go_equipcontainer/#go_clickarea")
	self.txtlv = gohelper.findChildText(self.viewGO, "anim/layout/auxiliary/#go_equipcontainer/#txt_lv")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function CharacterDefaultEquipView:addEvents()
	return
end

function CharacterDefaultEquipView:removeEvents()
	return
end

function CharacterDefaultEquipView:_editableInitView()
	self.goaddicon = gohelper.findChild(self.goequipcontainer, "#go_addIcon")
	self.simageequipicon = gohelper.findChildSingleImage(self.goequipcontainer, "#simage_equipicon")
	self.equipClick = gohelper.getClickWithAudio(self.goclickarea, AudioEnum.UI.play_ui_admission_open)

	self.equipClick:AddClickListener(self.onClickEquip, self)

	self.gos02twinssychube = gohelper.findChild(self.goequipcontainer, "#go_s02")
	self.gos02uneffect = gohelper.findChild(self.gos02twinssychube, "#go_uneffect")
	self.gos02effected = gohelper.findChild(self.gos02twinssychube, "#go_effected")
	self.simages02equipicon = gohelper.findChildSingleImage(self.gos02effected, "#simage_equipicon")
	self._btns02 = gohelper.findChildButtonWithAudio(self.gos02twinssychube, "#btn_click")

	self._btns02:AddClickListener(self.onClickS02, self)

	self._s02twinssychubeAnim = self.gos02twinssychube:GetComponent(typeof(UnityEngine.Animator))
end

function CharacterDefaultEquipView:onClickS02()
	ViewMgr.instance:openView(ViewName.TwinssychubeEquipInfoView, {
		heroMo = self.heroMo
	})
end

function CharacterDefaultEquipView:onClickEquip()
	local isOwnHero = self.heroMo:isOwnHero()

	if isOwnHero then
		EquipController.instance:openEquipInfoTeamView({
			heroMo = self.heroMo,
			fromView = EquipEnum.FromViewEnum.FromCharacterView
		})

		return
	end

	local isOtherPlayerHero = self.heroMo:isOtherPlayerHero()

	if self.heroMo then
		local trialEquipMo = self.heroMo:getTrialEquipMo()

		if isOtherPlayerHero or not self.heroMo then
			GameFacade.showToast(ToastEnum.TrialCantUseEquip)
		else
			EquipController.instance:openEquipInfoTeamView({
				heroMo = self.heroMo,
				equipMo = self.heroMo,
				fromView = EquipEnum.FromViewEnum.FromCharacterView
			})
		end
	end
end

function CharacterDefaultEquipView:playOpenAnim()
	local isOtherPlayerHero = self.heroMo:isOtherPlayerHero()

	if not self.isUnlockEquip or isOtherPlayerHero then
		return
	end

	self._equipAnimator.enabled = false
	self._equipAnimator.enabled = true

	self._equipAnimator:Play("open", 0, 0)
end

function CharacterDefaultEquipView:_showEquipPreferenceOpen()
	local isOtherPlayerHero = self.heroMo:isOtherPlayerHero()

	if not self.isUnlockEquip or isOtherPlayerHero then
		return
	end

	self._equipAnimator = gohelper.onceAddComponent(self.goequipcontainer, typeof(UnityEngine.Animator))

	local id = PlayerEnum.SimpleProperty.EquipPreferenceOpen
	local value = PlayerModel.instance:getSimpleProperty(id)
	local targetValue = "1"

	if value == targetValue then
		self._equipAnimator:Play("open", 0, 0)

		return
	end

	self._equipAnimator:Play("onece", 0, 0)

	local value = targetValue

	PlayerModel.instance:forceSetSimpleProperty(id, value)
	PlayerRpc.instance:sendSetSimplePropertyRequest(id, value)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_inking_preference_open)
end

function CharacterDefaultEquipView:onOpen()
	self.heroMo = self.viewParam

	local isTrial = self.viewParam:isTrial()
	local isOtherPlayerHero = self.viewParam:isOtherPlayerHero()

	self.isUnlockEquip = isTrial and true or OpenModel.instance:isFuncBtnShow(OpenEnum.UnlockFunc.Equip)

	gohelper.setActive(self.goequipcontainer, self.isUnlockEquip and not isOtherPlayerHero)

	if not self.isUnlockEquip then
		return
	end

	self:_showEquipPreferenceOpen()

	self.equipMo = nil

	if not isOtherPlayerHero and self.heroMo:hasDefaultEquip() then
		if self.heroMo then
			local equipMo = self.heroMo:getTrialEquipMo()

			equipMo = self.heroMo or EquipModel.instance:getEquip(self.heroMo.defaultEquipUid)
			self.equipMo = self.heroMo
		end
	end

	self:refreshUI()
	self.addEventCb(self, CharacterController.instance, CharacterEvent.HeroUpdatePush, self.onHeroUpdatePush, self)
	self.addEventCb(self, CharacterController.instance, CharacterEvent.RefreshDefaultEquip, self._onRefreshDefaultEquip, self)
	self.addEventCb(self, EquipController.instance, EquipEvent.onUpdateEquip, self.refreshUI, self)
	ViewMgr.instance:registerCallback(ViewEvent.OnCloseViewFinish, self._onCloseViewFinish, self)
end

function CharacterDefaultEquipView:_onCloseViewFinish(viewName)
	if viewName == ViewName.TwinssychubeEquipInfoView then
		self:_checkActivatetTwinssychubeEquip()
	end
end

function CharacterDefaultEquipView:refreshUI()
	gohelper.setActive(self.simageequipicon.gameObject, self.equipMo ~= nil)
	gohelper.setActive(self.txtlv.gameObject, self.equipMo ~= nil)
	gohelper.setActive(self.goaddicon, self.equipMo == nil)

	if self.equipMo then
		self.simageequipicon:LoadImage(ResUrl.getHeroDefaultEquipIcon(self.equipMo.config.icon))

		self.txtlv.text = self.equipMo.level
	end

	self:_refreshTwinssychube()
end

function CharacterDefaultEquipView:_refreshTwinssychube()
	if self.heroMo then
		local isTwinssychube = self.heroMo.heroId == CharacterEnum.TwinssychubeHeroId

		gohelper.setActive(self.gos02twinssychube.gameObject, isTwinssychube)

		local isActivateTwinssychubeEquip = EquipModel.instance:isActivateTwinssychubeEquip(self.heroMo)

		gohelper.setActive(self.gos02uneffect.gameObject, not isActivateTwinssychubeEquip)
		gohelper.setActive(self.gos02effected.gameObject, isActivateTwinssychubeEquip)

		if self.equipMo then
			local otherEquipId = EquipModel.instance:getOtherTwinssychubeEquipId(self.equipMo.equipId)

			if otherEquipId then
				local config = EquipConfig.instance:getEquipCo(otherEquipId)

				if config then
					self.simages02equipicon:LoadImage(ResUrl.getHeroDefaultEquipIcon(config.icon))
				end
			end

			self:_checkActivatetTwinssychubeEquip()
		end
	end
end

function CharacterDefaultEquipView:_checkActivatetTwinssychubeEquip()
	if EquipModel.instance:isPlayDoubleUnlockAnim() and not ViewMgr.instance:isOpen(ViewName.TwinssychubeEquipInfoView) then
		self._s02twinssychubeAnim:Play("unlock", 0, 0)
		EquipModel.instance:setPlayDoubleUnlockAnim(false)
		AudioMgr.instance:trigger(AudioEnum3_10.Twinssychube.play_ui_langchao_link_special_refresh)
	end
end

function CharacterDefaultEquipView:onUpdateParam()
	self:onOpen()
end

function CharacterDefaultEquipView:onHeroUpdatePush()
	local isOtherPlayerHero = self.heroMo:isOtherPlayerHero()

	self.equipMo = not isOtherPlayerHero and self.heroMo:hasDefaultEquip() and EquipModel.instance:getEquip(self.heroMo.defaultEquipUid) or nil

	self:refreshUI()
end

function CharacterDefaultEquipView:onClose()
	self.equipClick:RemoveClickListener()
	self._btns02:RemoveClickListener()

	if self.isUnlockEquip then
		self.simageequipicon:UnLoadImage()
		self.simages02equipicon:UnLoadImage()
		self.removeEventCb(self, CharacterController.instance, CharacterEvent.HeroUpdatePush, self.onHeroUpdatePush, self)
		self.removeEventCb(self, CharacterController.instance, CharacterEvent.RefreshDefaultEquip, self._onRefreshDefaultEquip, self)
		self.removeEventCb(self, EquipController.instance, EquipEvent.onUpdateEquip, self.refreshUI, self)
		ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseViewFinish, self._onCloseViewFinish, self)
	end
end

function CharacterDefaultEquipView:_onRefreshDefaultEquip(viewParam)
	self.viewParam = viewParam

	self:onOpen()
end

function CharacterDefaultEquipView:onDestroyView()
	return
end

return CharacterDefaultEquipView
