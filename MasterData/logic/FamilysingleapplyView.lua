-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/family/view/FamilysingleapplyView.lua

module("logic.extensions.family.view.FamilysingleapplyView", package.seeall)

local FamilysingleapplyView = class("FamilysingleapplyView", ViewComponent)

function FamilysingleapplyView:ctor()
	FamilysingleapplyView.super.ctor(self)
end

function FamilysingleapplyView:unbindEvents()
	FamilysingleapplyView.super.unbindEvents(self)
	self._btnApply:RemoveClickListener()
	self._btnClose:RemoveClickListener()
end

function FamilysingleapplyView:bindEvents()
	FamilysingleapplyView.super.bindEvents(self)
	self._btnApply:AddClickListener(self._onClickbtnApply, self)
	self._btnClose:AddClickListener(self._onClickbtnClose, self)
end

function FamilysingleapplyView:buildUI()
	FamilysingleapplyView.super.buildUI(self)

	self._btnApply = self:getBtn("btnApply")
	self._btnClose = self:getBtn("btnClose")
	self._txtFamilyDesc = self:getTxt("root/txtFamilyDesc")
	self._txtFamilyNum = self:getTxt("root/txtFamilyNum")
	self._txtNumber = self:getTxt("root/txtNumber")
	self._txtChiefName = self:getTxt("root/txtChiefName")
	self._txtLimitDesc = self:getTxt("root/txtLimitDesc")
	self._txtFamilyName = self:getTxt("root/txtFamilyName")
	self._txtLv = self:getTxt("root/txtLv")
	self._txtPurpose = self:getTxt("root/txtPurpose")
	self._headIconIsc = self:getGo("root/icon"):GetComponent(ComponentType.UIImageSpriteChange)
	self._txtPurposeChange = self:getGo("root/txtPurpose"):GetComponent(ComponentType.UITextColorChange)
	self._imgColorChange = self:getGo("root/imgColorChange"):GetComponent(ComponentType.UIImageColorChange)
end

function FamilysingleapplyView:onExit()
	FamilysingleapplyView.super.onExit(self)
end

function FamilysingleapplyView:onEnter()
	FamilysingleapplyView.super.onEnter(self)
	self.addGEvent(self, FamilyAgent.ApplyJoinFamilyReq, self.close, self)

	self._searchResult = self:getFirstParam()

	if not self._searchResult then
		self:close()

		return
	end

	self:_initData()
	self:_updateUI()
end

function FamilysingleapplyView:_onClickbtnApply()
	local id = FamilyModel.instance:getFamilyId()

	if id == self._familyId then
		FloatWordMgr.instance:show("你已在此家族中")

		return
	elseif id > 0 then
		FloatWordMgr.instance:show("你已加入其他家族")

		return
	end

	FamilyController.instance:applyJoinFamilyReq(self._familyId)
end

function FamilysingleapplyView:_onClickbtnClose()
	self:close()
end

function FamilysingleapplyView:_initData()
	self._familyId = self._searchResult.familyId

	local lvCfg = FamilyConfig.instance:getLvCfgByLv(self._searchResult.level)

	self._maxAllMemberCount = lvCfg.maxAllMemberCount
end

function FamilysingleapplyView:_updateUI()
	self._txtLv.text = string.format("Lv.%s", self._searchResult.level)
	self._txtFamilyName.text = self._searchResult.familyName
	self._txtNumber.text = self._searchResult.familyId
	self._txtChiefName.text = self._searchResult.cheifName
	self._txtFamilyNum.text = string.format("%s/%s", self._searchResult.familyMemberCount, self._maxAllMemberCount)
	self._txtLimitDesc.text = FamilyFacade.instance:getFamilyTagText(self._searchResult, " ")
	self._txtFamilyDesc.text = self._searchResult.declaration
	self._txtPurpose.text = lang("tip_family_purpose_" .. self._searchResult.purpose + 1)

	self._headIconIsc:SetState(self._searchResult.iconId)
	self._txtPurposeChange:SetState(self._searchResult.purpose)
end

return FamilysingleapplyView
