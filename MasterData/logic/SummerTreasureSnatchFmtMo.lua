-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/summertreasuresnatch/model/SummerTreasureSnatchFmtMo.lua

module("logic.extensions.summertreasuresnatch.model.SummerTreasureSnatchFmtMo", package.seeall)

local SummerTreasureSnatchFmtMo = class("SummerTreasureSnatchFmtMo", BaseCustomFmtMo)

function SummerTreasureSnatchFmtMo:updateCfg(activityId)
	self._activityId = checknumber(activityId)
	self._preSetFormationMap = SummerTreasureSnatchModel.instance:getPresetFormationMap(activityId)
	self.isShowBtnSave = true
	self.isShowTab = true
	self._presetFormationNumStandard = SummerTreasureSnatchConfig.instance:getCommonNumber("PRESET_FORMATION_NUM")
	self._petExperienceMap = SummerTreasureSnatchModel.instance:getPetExperienceMap(self._activityId)

	self:_updateFormation()
	self:initPetList()
end

function SummerTreasureSnatchFmtMo:updatePresetFormationMap()
	self._preSetFormationMap = SummerTreasureSnatchModel.instance:getPresetFormationMap(self._activityId)
end

function SummerTreasureSnatchFmtMo:_updateFormation()
	for i = 1, 3 do
		local formPb = self._preSetFormationMap[i]

		if formPb then
			local infoForm = formPb.form

			if infoForm then
				if self.forMationMap[i] == nil then
					self.forMationMap[i] = FormationMO.New(GameUtil.handler(self.getPetMoById, self))
				end

				local formMo = self.forMationMap[i]

				formMo:SetData(infoForm)
			end
		else
			self.forMationMap[i] = FormationMO.New(GameUtil.handler(self.getPetMoById, self))
		end
	end
end

function SummerTreasureSnatchFmtMo:jumpToTabIndex(idx)
	self.curTabIndex = idx

	GlobalDispatcher:dispatch(GlobalNotify.ForceChangeCurFormTab)
end

function SummerTreasureSnatchFmtMo:checkPetIsForbit(petMo)
	return self:_isPetLock(petMo)
end

function SummerTreasureSnatchFmtMo:showForbitPetAlert(petMo)
	if self:_isPetLock(petMo) then
		FloatWordMgr.instance:show("精灵已锁定,无法上阵")
	end
end

function SummerTreasureSnatchFmtMo:_isPetLock(petMo)
	local raceId = petMo and petMo:getDefineId() or 0

	for idx, formation in pairs(self.forMationMap) do
		if idx ~= self.curTabIndex and formation:HasRace(raceId) then
			return true
		end
	end

	return false
end

function SummerTreasureSnatchFmtMo:_getCurFormList()
	local formList = {}

	for k, formation in pairs(self.forMationMap) do
		if not formation:isEmpty() then
			local formPb = CustomFmtController.instance:createFormPb(formation)

			table.insert(formList, formPb)
		end
	end

	return formList
end

function SummerTreasureSnatchFmtMo:_saveAndSendPresetReq()
	local formList = self:_getCurFormList()

	SummerTreasureSnatchController.instance:sendPM_SummerTreasureSnatchPresetFormationReq(self._activityId, formList)
end

function SummerTreasureSnatchFmtMo:onClickCloseBtn(handler)
	local hasEmptyForm = false
	local formNum = 0

	for k, formation in pairs(self.forMationMap) do
		if formation then
			if formation:isEmpty() then
				hasEmptyForm = true
			else
				formNum = formNum + 1
			end
		end
	end

	local realFormNum = 0

	for k, v in pairs(self._preSetFormationMap) do
		if v then
			realFormNum = realFormNum + 1
		end
	end

	local tipsContent = lang("少于三只队伍将影响作战结果是否确定退出")
	local satisfyRequest = formNum == self._presetFormationNumStandard and not hasEmptyForm or realFormNum == self._presetFormationNumStandard

	if realFormNum < formNum then
		tipsContent = lang("检测到目前队伍数量变化暂无保存，是否确定退出")
	end

	if satisfyRequest then
		GameUtil.callBack(handler)
	else
		local function okFunc()
			GameUtil.callBack(handler)
		end

		TipsFacade.instance:openPopupWindow(lang("提示"), tipsContent, okFunc, nil, "确定", "取消")
	end
end

function SummerTreasureSnatchFmtMo:initSaveHandler()
	local function handler()
		local formation = self.forMationMap[self.curTabIndex]

		if formation:isEmpty() then
			FloatWordMgr.instance:show(lang("布阵为空，请先布阵后再保存"))

			return
		end

		self:_saveAndSendPresetReq()
	end

	self:setSaveHandler(handler, nil)
end

function SummerTreasureSnatchFmtMo:sendSaveMsg(fromBtnSave)
	if not fromBtnSave then
		return
	end

	GameUtil.callBack(self._onSaveHandler, self._onSaveHandlerObject, fromBtnSave)
	self:onExitView()
end

return SummerTreasureSnatchFmtMo
