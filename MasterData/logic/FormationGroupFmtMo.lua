-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/formation/model/group/FormationGroupFmtMo.lua

module("logic.extensions.formation.model.group.FormationGroupFmtMo", package.seeall)

local FormationGroupFmtMo = class("FormationGroupFmtMo", BaseCustomFmtMo)

function FormationGroupFmtMo:onInit()
	FormationGroupFmtMo.super.onInit(self)

	self.isShowBtnFormationUse = false
	self.isShowBtnFormationEdit = true
	self.isShowTab = false
	self.nEnterShowRuleFlag = ICustomFmtMo.EEnterShowRuleFlag_None
	self.isPopRuleDesc = true
	self.showSetDefense = true
end

function FormationGroupFmtMo:initParams()
	self:_updateCurFmtMo()
end

function FormationGroupFmtMo:updateData()
	if not FormationGroupModel.instance:getIsInited() then
		GlobalDispatcher:addListener(GlobalNotify.FormationGroupInfoUpdate, self._onUpdateInfo, self)
		FormationGroupController.instance:sendGetInfo()
	end

	FormationGroupModel.instance:setIsChange()
end

function FormationGroupFmtMo:onExitView()
	GlobalDispatcher:removeListener(GlobalNotify.FormationGroupInfoUpdate, self._onUpdateInfo, self)
end

function FormationGroupFmtMo:_onUpdateInfo()
	self:_updateCurFmtMo()
	GlobalDispatcher:dispatch(GlobalNotify.ForceChangeCurFormTab)
end

function FormationGroupFmtMo:_updateCurFmtMo()
	local curTabId = FormationGroupModel.instance.curTabId
	local tabInfo = FormationGroupModel.instance:getTabInfo(curTabId)

	if tabInfo then
		local formationMo = self:getCurFormation()
		local simpleForm = tabInfo.simpleForm

		formationMo:SetData(simpleForm)
	end
end

function FormationGroupFmtMo:initSaveHandler()
	self.setSaveHandler(self, self._sendSaveAllFmt, self)
end

function FormationGroupFmtMo:_sendSaveAllFmt()
	self:onBeforeEditFmt()
end

function FormationGroupFmtMo:onBeforeEditFmt()
	self:_saveCurFmtMo()
end

function FormationGroupFmtMo:onBeforeSetDefenseFmt()
	self:_saveCurFmtMo()
end

function FormationGroupFmtMo:_saveCurFmtMo()
	local curTabId = FormationGroupModel.instance.curTabId
	local tabInfo = FormationGroupModel.instance:getTabInfo(curTabId)

	if tabInfo then
		local pb = self:getCurSimpleForm()
		local curFmtMo = self:getCurFormation()
		local summonMasterId = 0
		local summonedPetId = curFmtMo:GetSummonPetId()
		local mo = curFmtMo:_getPet(summonedPetId)

		if mo then
			summonMasterId = mo.summonMasterId
		else
			summonedPetId = 0
		end

		FormationGroupController.instance:sendSaveCurFmtMo(curTabId, tabInfo, pb, summonMasterId, summonedPetId)
	end
end

return FormationGroupFmtMo
