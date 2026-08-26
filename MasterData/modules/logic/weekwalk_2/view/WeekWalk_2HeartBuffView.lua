-- chunkname: @modules/logic/weekwalk_2/view/WeekWalk_2HeartBuffView.lua

module("modules.logic.weekwalk_2.view.WeekWalk_2HeartBuffView", package.seeall)

local WeekWalk_2HeartBuffView = class("WeekWalk_2HeartBuffView", BaseView)

function WeekWalk_2HeartBuffView:onInitView()
	self._btnMask = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_Mask")
	self._simageTipsBG = gohelper.findChildSingleImage(self.viewGO, "Root/#simage_TipsBG")
	self._txtBuffName = gohelper.findChildText(self.viewGO, "Root/Right/#txt_BuffName")
	self._imageBuffIcon = gohelper.findChildImage(self.viewGO, "Root/Right/#image_BuffIcon")
	self._txtEffectDesc = gohelper.findChildText(self.viewGO, "Root/Right/Scroll View/Viewport/#txt_EffectDesc")
	self._btnEquip = gohelper.findChildButtonWithAudio(self.viewGO, "Root/Right/#btn_Equip")
	self._btnUnLoad = gohelper.findChildButtonWithAudio(self.viewGO, "Root/Right/#btn_UnLoad")
	self._btnClose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_Close")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function WeekWalk_2HeartBuffView:addEvents()
	self._btnMask:AddClickListener(self._btnMaskOnClick, self)
	self._btnEquip:AddClickListener(self._btnEquipOnClick, self)
	self._btnUnLoad:AddClickListener(self._btnUnLoadOnClick, self)
	self._btnClose:AddClickListener(self._btnCloseOnClick, self)
end

function WeekWalk_2HeartBuffView:removeEvents()
	self._btnMask:RemoveClickListener()
	self._btnEquip:RemoveClickListener()
	self._btnUnLoad:RemoveClickListener()
	self._btnClose:RemoveClickListener()
end

function WeekWalk_2HeartBuffView:_btnUnLoadOnClick()
	self._selectedSkillId = nil

	self:_updateBuffStatus()
	WeekWalk_2Controller.instance:dispatchEvent(WeekWalk_2Event.OnBuffSetup)

	if HeroGroupModel.instance.curGroupSelectIndex then
		Weekwalk_2Rpc.instance:sendWeekwalkVer2ChooseSkillRequest(HeroGroupModel.instance.curGroupSelectIndex)
	end
end

function WeekWalk_2HeartBuffView:_btnMaskOnClick()
	self:closeThis()
end

function WeekWalk_2HeartBuffView:_btnEquipOnClick()
	if self._isPrevBattleSkill then
		GameFacade.showToast(ToastEnum.WeekWalk_2BuffCannotSetup)

		return
	end

	self._selectedSkillId = self._buffConfig.id

	WeekWalk_2Controller.instance:dispatchEvent(WeekWalk_2Event.OnBuffSetup, self._buffConfig)

	if HeroGroupModel.instance.curGroupSelectIndex then
		Weekwalk_2Rpc.instance:sendWeekwalkVer2ChooseSkillRequest(HeroGroupModel.instance.curGroupSelectIndex, {
			self._selectedSkillId
		}, self._onBuffSetupReply, self)
	end
end

function WeekWalk_2HeartBuffView:_btnCloseOnClick()
	self:closeThis()
end

function WeekWalk_2HeartBuffView:_editableInitView()
	self._txtBuffName.text = ""
	self._txtEffectDesc.text = ""

	gohelper.setActive(self._btnEquip, false)
	gohelper.setActive(self._btnUnLoad, false)
	gohelper.addUIClickAudio(self._btnEquip.gameObject, AudioEnum2_6.WeekWalk_2.play_ui_fight_artificial_equip)
	gohelper.addUIClickAudio(self._btnUnLoad.gameObject, AudioEnum2_6.WeekWalk_2.play_ui_fight_artificial_unequip)
end

function WeekWalk_2HeartBuffView:_onBuffSelectedChange(buffConfig)
	self._buffConfig = buffConfig

	self:_updateBuffStatus()
end

function WeekWalk_2HeartBuffView:_updateBuffStatus()
	self._txtBuffName.text = self._buffConfig.name
	self._txtEffectDesc.text = self._buffConfig.desc

	local prevBattleSkillId = WeekWalk_2BuffListModel.instance.prevBattleSkillId

	self._isPrevBattleSkill = prevBattleSkillId == self._buffConfig.id

	if self._isBattle then
		local showBtnEquip = self._selectedSkillId ~= self._buffConfig.id

		gohelper.setActive(self._btnEquip, showBtnEquip)
		gohelper.setActive(self._btnUnLoad, self._isBattle and self._selectedSkillId == self._buffConfig.id and not self._isPrevBattleSkill)

		if showBtnEquip then
			ZProj.UGUIHelper.SetGrayscale(self._btnEquip.gameObject, self._isPrevBattleSkill)
		end

		UISpriteSetMgr.instance:setWeekWalkSprite(self._imageBuffIcon, self._buffConfig.icon)
	end
end

function WeekWalk_2HeartBuffView:onUpdateParam()
	return
end

function WeekWalk_2HeartBuffView:onOpen()
	self._isBattle = self.viewParam and self.viewParam.isBattle

	if self._isBattle then
		local mapInfo = WeekWalk_2Model.instance:getCurMapInfo()

		self._battleId = HeroGroupModel.instance.battleId
		self._layerId = mapInfo.id
		self._selectedSkillId = WeekWalk_2BuffListModel.getCurHeroGroupSkillId()
	end

	self.addEventCb(self, WeekWalk_2Controller.instance, WeekWalk_2Event.OnBuffSelectedChange, self._onBuffSelectedChange, self)
end

function WeekWalk_2HeartBuffView:_onBuffSetupReply()
	self:closeThis()
	GameFacade.showToast(ToastEnum.WeekWalk_2BuffSetup)
end

function WeekWalk_2HeartBuffView:onClose()
	return
end

function WeekWalk_2HeartBuffView:onDestroyView()
	return
end

return WeekWalk_2HeartBuffView
