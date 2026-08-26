-- chunkname: @modules/logic/tower/view/assistboss/TowerBossTalentModifyNameView.lua

module("modules.logic.tower.view.assistboss.TowerBossTalentModifyNameView", package.seeall)

local TowerBossTalentModifyNameView = class("TowerBossTalentModifyNameView", BaseView)

function TowerBossTalentModifyNameView:onInitView()
	self._btncloseView = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_closeView")
	self._simagerightbg = gohelper.findChildSingleImage(self.viewGO, "window/#simage_rightbg")
	self._simageleftbg = gohelper.findChildSingleImage(self.viewGO, "window/#simage_leftbg")
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "bottom/#btn_close")
	self._btnsure = gohelper.findChildButtonWithAudio(self.viewGO, "bottom/#btn_sure")
	self._input = gohelper.findChildTextMeshInputField(self.viewGO, "message/#input_signature")
	self._txttext = gohelper.findChildText(self.viewGO, "message/#input_signature/textarea/#txt_text")
	self._btncleanname = gohelper.findChildButtonWithAudio(self.viewGO, "message/#btn_cleanname")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function TowerBossTalentModifyNameView:addEvents()
	self._btncloseView:AddClickListener(self._btncloseOnClick, self)
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
	self._btnsure:AddClickListener(self._btnsureOnClick, self)
	self._btncleanname:AddClickListener(self._btncleannameOnClick, self)
	self._input:AddOnValueChanged(self._onInputValueChanged, self)
end

function TowerBossTalentModifyNameView:removeEvents()
	self._btncloseView:RemoveClickListener()
	self._btnclose:RemoveClickListener()
	self._btnsure:RemoveClickListener()
	self._btncleanname:RemoveClickListener()
	self._input:RemoveOnValueChanged()
end

function TowerBossTalentModifyNameView:_btncloseOnClick()
	self:closeThis()
end

function TowerBossTalentModifyNameView:_btnsureOnClick()
	local str = self._input:GetText()

	if string.nilorempty(str) then
		return
	end

	if GameUtil.utf8len(str) > 6 then
		GameFacade.showToast(ToastEnum.InformPlayerCharLen)

		return
	end

	str = GameUtil.trimInput(str)

	TowerRpc.instance:sendTowerRenameTalentPlanRequest(self.bossId, str, self._onRenameTalentReply, self)
end

function TowerBossTalentModifyNameView:_onRenameTalentReply()
	self:_btncloseOnClick()
	GameFacade.showToast(ToastEnum.PlayerModifyChangeName)
end

function TowerBossTalentModifyNameView:_btncleannameOnClick()
	self._input:SetText("")
end

function TowerBossTalentModifyNameView:_onInputValueChanged()
	local inputValue = self._input:GetText()

	gohelper.setActive(self._btncleanname, not string.nilorempty(inputValue))
end

function TowerBossTalentModifyNameView:_editableInitView()
	self._simageleftbg:LoadImage(ResUrl.getCommonIcon("bg_1"))
	self._simagerightbg:LoadImage(ResUrl.getCommonIcon("bg_2"))
end

function TowerBossTalentModifyNameView:onOpen()
	self.bossId = self.viewParam.bossId
end

function TowerBossTalentModifyNameView:onDestroyView()
	self._simagerightbg:UnLoadImage()
	self._simageleftbg:UnLoadImage()
end

return TowerBossTalentModifyNameView
