-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/funarena/view/formation/FunArenaBuzhenLeftView.lua

module("logic.extensions.funarena.view.formation.FunArenaBuzhenLeftView", package.seeall)

local FunArenaBuzhenLeftView = class("FunArenaBuzhenLeftView", BuzhenLeftView)

function FunArenaBuzhenLeftView:buildUI()
	FunArenaBuzhenLeftView.super.buildUI(self)

	local _Nego_TeamInfo = goutil.findChild(self.mainGO, "Nego_Left/Nego_TeamInfo")

	GameUtil.SetActive(_Nego_TeamInfo, false)
end

function FunArenaBuzhenLeftView:onEnter()
	FunArenaBuzhenLeftView.super.onEnter(self)
	self:_setActiveBtnFormation(false)
	self:setBtnCutePetActive(false)
	self:_setActiveBtnFormationUse(false)
	GlobalDispatcher:addListener(GlobalNotify.FormationPet_POS_FINISH, self.onAllPetSetFinish, self)
	FastFormation.instance:setCurFormFunc(function()
		return self:_getCurFormation()
	end)
	FastFormation.instance:setGetCurPetList(function()
		return FunArenaModel.instance:getAllShowPetList()
	end)
end

function FunArenaBuzhenLeftView:onExit()
	FunArenaBuzhenLeftView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.FormationPet_POS_FINISH, self.onAllPetSetFinish, self)
	FastFormation.instance:setCurFormFunc(nil)
	FastFormation.instance:setGetCurPetList(nil)
end

function FunArenaBuzhenLeftView:_setBtnFormationActive()
	return false
end

function FunArenaBuzhenLeftView:_saveCurrFmt()
	return
end

function FunArenaBuzhenLeftView:GetFormStrengthIdAndLv()
	local fid = 0
	local flvl = 0
	local info = self:_getCurFormation():GetFormStrengthInfo()

	if info and info.formStrengthId and info.formStrengthId > 0 then
		fid = info.formStrengthId
		flvl = info.formStrengthLv
	end

	return fid, (fid > 0 or nil) and BattleConfig.instance:getFormStrengthMaxLv(fid)
end

function FunArenaBuzhenLeftView:_OnClickBtnBuffForm()
	local isOpen = FuncOpenModel.instance:getFuncIsOpen(96)

	if not isOpen then
		local cfgFuncOpen = FuncOpenConfig.instance:getFunctionOpenById(96)

		if cfgFuncOpen then
			FloatWordMgr.instance:show(cfgFuncOpen.description)
		end

		return
	end

	local curPetNumber = self:_getCurFormation():getCurExistPetNumber()

	UIStateManager.instance:push(ViewName.FormationactivetipView, self._CurFormId or 0, curPetNumber, false, true)
end

function FunArenaBuzhenLeftView:getCurAllFormStrengthInfo()
	local fsMap = {}

	for i = 1, 8 do
		local _maxlv = BattleConfig.instance:getFormStrengthMaxLv(i)

		fsMap[i] = {
			formStrengthId = i,
			formStrengthLv = _maxlv
		}
	end

	return fsMap
end

function FunArenaBuzhenLeftView:_onUpdateBuffFormById(info)
	goutil.setActive(self._MarkLock_BuffForm, false)

	local formId
	local formLv = 0

	if info then
		info.formStrengthLv = BattleConfig.instance:getFormStrengthMaxLv(info.formStrengthId)
	end

	self:SetFormStrengthInfo(info)

	if info then
		formId = info.formStrengthId
		formLv = info.formStrengthLv
	end

	self:_onSelectBuffForm(formId, formLv)

	formId = nil

	if self._CurFormId ~= nil then
		self._CurFormId = checknumber(formId)

		self:_SetPowerAndSpeed()

		if checknumber(formId) > 0 then
			self:_showFormationActive()
		end
	end
end

function FunArenaBuzhenLeftView:_getPet(petId)
	return FunArenaModel.instance:getPetMo(petId)
end

function FunArenaBuzhenLeftView:_getCurFormId()
	return 1
end

function FunArenaBuzhenLeftView:_getCurFormation()
	return FunArenaModel.instance:getCurFormMo()
end

function FunArenaBuzhenLeftView:getIsBoundUseBagPet()
	return false
end

function FunArenaBuzhenLeftView:_getItemSeatCls()
	return FunArenaItemSeat
end

return FunArenaBuzhenLeftView
