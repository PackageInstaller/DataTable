-- chunkname: @modules/logic/herogrouppreset/view/HeroGroupPresetModifyNameView.lua

module("modules.logic.herogrouppreset.view.HeroGroupPresetModifyNameView", package.seeall)

local HeroGroupPresetModifyNameView = class("HeroGroupPresetModifyNameView", BaseView)

function HeroGroupPresetModifyNameView:onInitView()
	self._btnClose = gohelper.findChildButtonWithAudio(self.viewGO, "bottom/#btn_close")
	self._btnSure = gohelper.findChildButtonWithAudio(self.viewGO, "bottom/#btn_sure")
	self._input = gohelper.findChildTextMeshInputField(self.viewGO, "message/#input_signature")
	self._btncleanname = gohelper.findChildButtonWithAudio(self.viewGO, "message/#btn_cleanname")
	self._simagerightbg = gohelper.findChildSingleImage(self.viewGO, "window/#simage_rightbg")
	self._simageleftbg = gohelper.findChildSingleImage(self.viewGO, "window/#simage_leftbg")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function HeroGroupPresetModifyNameView:addEvents()
	self._btnClose:AddClickListener(self._onBtnClose, self)
	self._btnSure:AddClickListener(self._onBtnSure, self)
	self._btncleanname:AddClickListener(self._onBtnClean, self)
	self._input:AddOnValueChanged(self._onValueChanged, self)
end

function HeroGroupPresetModifyNameView:removeEvents()
	self._btnClose:RemoveClickListener()
	self._btnSure:RemoveClickListener()
	self._btncleanname:RemoveClickListener()
	self._input:RemoveOnValueChanged()
end

function HeroGroupPresetModifyNameView:_editableInitView()
	self._simageleftbg:LoadImage(ResUrl.getCommonIcon("bg_1"))
	self._simagerightbg:LoadImage(ResUrl.getCommonIcon("bg_2"))
end

function HeroGroupPresetModifyNameView:onRefreshViewParam()
	return
end

function HeroGroupPresetModifyNameView:_onBtnClose()
	self:closeThis()
end

function HeroGroupPresetModifyNameView:_onBtnClean()
	self._input:SetText("")
end

function HeroGroupPresetModifyNameView:_onBtnSure()
	local str = self._input:GetText()

	if string.nilorempty(str) then
		return
	end

	if GameUtil.utf8len(str) > 5 then
		GameFacade.showToast(ToastEnum.InformPlayerCharLen)

		return
	end

	local callback = self.viewParam.addCallback
	local callbackObj = self.viewParam.callbackObj

	if callback and callbackObj then
		HeroGroupRpc.instance:sendCheckHeroGroupNameRequest(str, function(cmd, resultCode, msg)
			if resultCode ~= 0 then
				return
			end

			callback(callbackObj, str)
		end)

		return
	end

	local id = self.viewParam.groupId
	local index = self.viewParam.subId

	HeroGroupRpc.instance:sendUpdateHeroGroupNameRequest(id, index, str, HeroGroupPresetModifyNameView.UpdateHeroGroupNameRequest)
end

function HeroGroupPresetModifyNameView.UpdateHeroGroupNameRequest(cmd, resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	HeroGroupPresetHeroGroupNameController.instance:setName(msg.currentSelect, msg.name, msg.id)
	HeroGroupPresetController.instance:dispatchEvent(HeroGroupPresetEvent.UpdateGroupName, msg.currentSelect)
	ViewMgr.instance:closeView(ViewName.HeroGroupPresetModifyNameView)
end

function HeroGroupPresetModifyNameView:_onValueChanged()
	local inputValue = self._input:GetText()

	gohelper.setActive(self._btncleanname, not string.nilorempty(inputValue))
end

function HeroGroupPresetModifyNameView:onOpen()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_petrus_exchange_element_get)

	local name = self.viewParam.name

	self._input:SetText(name)
	gohelper.setActive(self._btncleanname, not string.nilorempty(name))
end

function HeroGroupPresetModifyNameView:_onFrame(value)
	PostProcessingMgr.instance:setBlurWeight(value)
end

function HeroGroupPresetModifyNameView:_onFinish()
	PostProcessingMgr.instance:setBlurWeight(1)
end

function HeroGroupPresetModifyNameView:onClose()
	if self._blurTweenId then
		PostProcessingMgr.instance:setBlurWeight(1)
		ZProj.TweenHelper.KillById(self._blurTweenId)

		self._blurTweenId = nil
	end
end

function HeroGroupPresetModifyNameView:onDestroyView()
	self._simagerightbg:UnLoadImage()
	self._simageleftbg:UnLoadImage()
end

return HeroGroupPresetModifyNameView
