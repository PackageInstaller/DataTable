-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/kingarena/model/KingArenaFormationCustomFmtMo.lua

module("logic.extensions.kingarena.model.KingArenaFormationCustomFmtMo", package.seeall)

local KingArenaFormationCustomFmtMo = class("KingArenaFormationCustomFmtMo", BaseCustomFmtMo)

function KingArenaFormationCustomFmtMo:updateCfg(seasonId, periodId, simpleForm)
	self._seasonId = seasonId
	self._periodId = periodId
	self._simpleForm = simpleForm
	self.isShowBtnBuffForm = true
	self.isShowBtnFormationUse = true
	self.isShowBtnSave = true
	self.isShowBtnCutePet = true
end

function KingArenaFormationCustomFmtMo:updateData()
	self:initPetList()
	self:refreshMyFmts(self._simpleForm)
end

function KingArenaFormationCustomFmtMo:initPetList()
	self:clearAllPetList()

	local pets = BagPetsController.instance:getFightBagPet()

	for i, petMo in ipairs(pets) do
		self:addPetToList(self:_changePetMo(petMo))
	end
end

function KingArenaFormationCustomFmtMo:_changePetMo(petMo)
	local petMoForm = petMo:GetClone()

	petMoForm.attrMo:resetPublicAttr()
	petMoForm.attrMo:calcTotalAttrs()
	petMoForm:refreshAllAttr()

	return petMoForm
end

function KingArenaFormationCustomFmtMo:refreshMyFmts(data)
	if data then
		self:getCurFormation():SetData(data)
	else
		self:getCurFormation():ResetPosition()
	end
end

function KingArenaFormationCustomFmtMo:initSaveHandler()
	self.setSaveHandler(self, self.fmtVerifyReq, self)
end

function KingArenaFormationCustomFmtMo:fmtVerifyReq()
	if self:isEmptyFmt() then
		FloatWordMgr.instance:show("空阵不能保存作为守阵，请返回布阵")

		return
	end

	local simpleForm = self:getCurSimpleForm()

	GlobalDispatcher:addListener(GlobalNotify.HandlePM_KingArenaSetDefenseFormRes, self._handlePM_KingArenaSetDefenseFormRes, self)
	KingArenaController.instance:sendPM_KingArenaSetDefenseFormReq(simpleForm)
end

function KingArenaFormationCustomFmtMo:_handlePM_KingArenaSetDefenseFormRes(status)
	GlobalDispatcher:removeListener(GlobalNotify.HandlePM_KingArenaSetDefenseFormRes, self._handlePM_ShowDown_SetFormRes, self)

	if status ~= 0 then
		FloatWordMgr.instance:show("阵容保存失败")
	else
		FloatWordMgr.instance:show("阵容保存成功")
	end
end

function KingArenaFormationCustomFmtMo:sendSaveMsg(fromBtnSave)
	if not fromBtnSave then
		return
	end

	KingArenaFormationCustomFmtMo.super.sendSaveMsg(self, fromBtnSave)
end

function KingArenaFormationCustomFmtMo:isEmptyFmt()
	return self:getCurFormation():isEmpty()
end

return KingArenaFormationCustomFmtMo
