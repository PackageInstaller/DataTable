-- chunkname: @modules/logic/herogroup/view/HeroGroupModifyNameView.lua

module("modules.logic.herogroup.view.HeroGroupModifyNameView", package.seeall)

local HeroGroupModifyNameView = class("HeroGroupModifyNameView", BaseView)

function HeroGroupModifyNameView:onInitView()
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

function HeroGroupModifyNameView:addEvents()
	self._btnClose:AddClickListener(self._onBtnClose, self)
	self._btnSure:AddClickListener(self._onBtnSure, self)
	self._btncleanname:AddClickListener(self._onBtnClean, self)
	self._input:AddOnValueChanged(self._onValueChanged, self)
end

function HeroGroupModifyNameView:removeEvents()
	self._btnClose:RemoveClickListener()
	self._btnSure:RemoveClickListener()
	self._btncleanname:RemoveClickListener()
	self._input:RemoveOnValueChanged()
end

function HeroGroupModifyNameView:_editableInitView()
	self._simageleftbg:LoadImage(ResUrl.getCommonIcon("bg_1"))
	self._simagerightbg:LoadImage(ResUrl.getCommonIcon("bg_2"))
end

function HeroGroupModifyNameView:onRefreshViewParam()
	return
end

function HeroGroupModifyNameView:_onBtnClose()
	self:closeThis()
end

function HeroGroupModifyNameView:_onBtnClean()
	self._input:SetText("")
end

function HeroGroupModifyNameView:_onBtnSure()
	local str = self._input:GetText()

	if string.nilorempty(str) then
		return
	end

	if GameUtil.utf8len(str) > 5 then
		GameFacade.showToast(ToastEnum.InformPlayerCharLen)

		return
	end

	local id = HeroGroupModel.instance:getHeroGroupSnapshotType()
	local index = HeroGroupModel.instance:getHeroGroupSelectIndex()

	HeroGroupRpc.instance:sendUpdateHeroGroupNameRequest(id, index, str, self.onReq, self)
end

function HeroGroupModifyNameView:onReq(cmd, resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	HeroGroupModel.instance:setCommonGroupName(msg.currentSelect, msg.name, msg.id)
	self:closeThis()
end

function HeroGroupModifyNameView:_onValueChanged()
	local inputValue = self._input:GetText()

	gohelper.setActive(self._btncleanname, not string.nilorempty(inputValue))
end

function HeroGroupModifyNameView:onOpen()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_petrus_exchange_element_get)

	local name = HeroGroupModel.instance:getCommonGroupName()

	self._input:SetText(name)

	self._blurTweenId = ZProj.TweenHelper.DOTweenFloat(0, 1, 0.35, self._onFrame, self._onFinish, self, nil, EaseType.Linear)

	gohelper.setActive(self._btncleanname, not string.nilorempty(name))
end

function HeroGroupModifyNameView:_onFrame(value)
	PostProcessingMgr.instance:setBlurWeight(value)
end

function HeroGroupModifyNameView:_onFinish()
	PostProcessingMgr.instance:setBlurWeight(1)
end

function HeroGroupModifyNameView:onClose()
	if self._blurTweenId then
		PostProcessingMgr.instance:setBlurWeight(1)
		ZProj.TweenHelper.KillById(self._blurTweenId)

		self._blurTweenId = nil
	end
end

function HeroGroupModifyNameView:onDestroyView()
	self._simagerightbg:UnLoadImage()
	self._simageleftbg:UnLoadImage()
end

return HeroGroupModifyNameView
