-- chunkname: @modules/logic/character/view/CharacterVoiceItem.lua

module("modules.logic.character.view.CharacterVoiceItem", package.seeall)

local CharacterVoiceItem = class("CharacterVoiceItem", ListScrollCellExtend)
local itemShowAniName = "voiceview_item_in"

function CharacterVoiceItem:onInitView()
	self._itemclick = SLFramework.UGUI.UIClickListener.Get(self.viewGO)
	self._itemAnimator = self.viewGO:GetComponent(typeof(UnityEngine.Animator))
	self._goplayicon = gohelper.findChild(self.viewGO, "#go_playicon")
	self._gostopicon = gohelper.findChild(self.viewGO, "#go_stopicon")
	self._golockicon = gohelper.findChild(self.viewGO, "#go_lockicon")
	self._txtvoicename = gohelper.findChildText(self.viewGO, "voice/#txt_voicename")
	self._govoiceicon = gohelper.findChild(self.viewGO, "#go_voiceicon")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function CharacterVoiceItem:addEvents()
	self._itemclick:AddClickListener(self._itemOnClick, self)
	self.addEventCb(self, CharacterController.instance, CharacterEvent.ChangeVoiceLang, self._onChangeCharVoiceLang, self)
end

function CharacterVoiceItem:removeEvents()
	self._itemclick:RemoveClickListener()
end

function CharacterVoiceItem:_itemOnClick()
	if CharacterDataModel.instance:isCurHeroAudioLocked(self._audioId) then
		return
	end

	if CharacterDataModel.instance:isCurHeroAudioPlaying(self._audioId) then
		CharacterController.instance:dispatchEvent(CharacterEvent.StopVoice, self._audioId)
	else
		self:_setRandomVoiceId()
		CharacterDataModel.instance:setPlayingInfo(self._audioId, self._defaultAudioId)
		CharacterController.instance:dispatchEvent(CharacterEvent.PlayVoice, self._audioId)
	end
end

function CharacterVoiceItem:_setRandomVoiceId()
	if not self._multiVoiceList then
		local heroinfo = HeroModel.instance:getByHeroId(self._mo.heroId)
		local skinCo = SkinConfig.instance:getSkinCo(heroinfo.skin)
		local list = CharacterDataConfig.instance:getCharacterTypeVoicesCO(self._mo.heroId, CharacterEnum.VoiceType.MultiVoice, skinCo.id)

		self._multiVoiceList = {}

		for i, v in ipairs(list) do
			if tonumber(v.param) == self._defaultAudioId then
				table.insert(self._multiVoiceList, v)
			end
		end
	end

	local targetAudioId

	if #self._multiVoiceList > 0 and math.random() > 0.5 then
		local config = self._multiVoiceList[math.random(#self._multiVoiceList)]

		targetAudioId = config and config.audio
	end

	self._audioId = targetAudioId or self._defaultAudioId
end

function CharacterVoiceItem:_editableInitView()
	return
end

function CharacterVoiceItem:onUpdateMO(mo)
	self._mo = mo
	self._multiVoiceList = nil
	self._defaultAudioId = self._mo.id
	self._audioId = CharacterDataModel.instance:getPlayingAudioId(self._defaultAudioId) or self._defaultAudioId

	transformhelper.setLocalScale(self._gostopicon.transform, 1, 1, 1)
	self:_refreshItem()
end

function CharacterVoiceItem:_refreshItem()
	self._itemAnimator.enabled = CharacterVoiceModel.instance:isNeedItemAni()

	if CharacterDataModel.instance:isCurHeroAudioLocked(self._audioId) then
		gohelper.setActive(self._golockicon, true)
		gohelper.setActive(self._goplayicon, false)
		gohelper.setActive(self._gostopicon, false)
		gohelper.setActive(self._govoiceicon, false)
		SLFramework.UGUI.GuiHelper.SetColor(self._txtvoicename, "#9D9D9D")

		local heroInfo = HeroModel.instance:getByHeroId(self._mo.heroId)

		self._txtvoicename.text = CharacterDataConfig.instance:getConditionStringName(self._mo)
	else
		local isplaying = CharacterDataModel.instance:isCurHeroAudioPlaying(self._audioId)

		gohelper.setActive(self._golockicon, false)
		gohelper.setActive(self._goplayicon, not isplaying)
		gohelper.setActive(self._gostopicon, isplaying)
		gohelper.setActive(self._govoiceicon, isplaying)

		if isplaying then
			SLFramework.UGUI.GuiHelper.SetColor(self._txtvoicename, "#C66030")
		else
			SLFramework.UGUI.GuiHelper.SetColor(self._txtvoicename, "#E2E1DF")
		end

		self._txtvoicename.text = " " .. self._mo.name
	end
end

function CharacterVoiceItem:_onChangeCharVoiceLang()
	self._itemAnimator.enabled = CharacterVoiceModel.instance:isNeedItemAni()

	self._itemAnimator:Play(itemShowAniName, 0, 0)
end

function CharacterVoiceItem:onDestroyView()
	return
end

return CharacterVoiceItem
