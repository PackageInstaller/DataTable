-- chunkname: @modules/logic/rouge2/bossbattle/controller/Rouge2_FightRecordController.lua

module("modules.logic.rouge2.bossbattle.controller.Rouge2_FightRecordController", package.seeall)

local Rouge2_FightRecordController = class("Rouge2_FightRecordController", BaseController)

function Rouge2_FightRecordController:replaceRecord(index)
	if not self:checkIndexValid(index) then
		return
	end

	Rouge2OutsideRpc.instance:sendRouge2SaveContextRequest(index)
end

function Rouge2_FightRecordController:getSaveInfoList()
	local bossBattleInfo = Rouge2_OutsideModel.instance:getBossBattleInfo()

	return bossBattleInfo and bossBattleInfo:getSaveInfoList()
end

function Rouge2_FightRecordController:getSaveInfo(index)
	local bossBattleInfo = Rouge2_OutsideModel.instance:getBossBattleInfo()

	return bossBattleInfo and bossBattleInfo:getSaveInfoByIndex(index)
end

function Rouge2_FightRecordController:getMaxRecordNum()
	return tonumber(lua_rouge2_const.configDict[Rouge2_MapEnum.ConstKey.MaxFightRecordNum].value)
end

function Rouge2_FightRecordController:getMinRecordDifficulty()
	return tonumber(lua_rouge2_const.configDict[Rouge2_MapEnum.ConstKey.MinFightRecordDiff].value)
end

function Rouge2_FightRecordController:getMainRecordDifficultyName()
	local minDiffId = self:getMinRecordDifficulty()
	local minDiffCo = Rouge2_Config.instance:getDifficultyCoById(minDiffId)

	if minDiffCo then
		if not minDiffCo.title then
			local minDiffName = ""

			if minDiffCo then
				if not minDiffCo.difficulty then
					local difficulty = 0

					return minDiffName, difficulty
				end
			end
		end
	end
end

function Rouge2_FightRecordController:checkIndexValid(index)
	return index and index > 0 and index <= self:getMaxRecordNum()
end

function Rouge2_FightRecordController:tryShowRecordMsgBox(resultInfo, notValidCallback, yesCallback, noCallback, callbackObj)
	local isValid = self:checkCanSave(resultInfo)

	if not isValid then
		if notValidCallback then
			notValidCallback(callbackObj)
		end

		return
	end

	MessageBoxController.instance:showMsgBoxAndSetBtn(MessageBoxIdDefine.Rouge2RecordResult, MsgBoxEnum.BoxType.Yes_No, luaLang("rouge2_fightrecord_confirm"), "CONFIRM", luaLang("rouge2_fightrecord_abort"), "QUIT", yesCallback, noCallback, nil, callbackObj, callbackObj)

	return true
end

function Rouge2_FightRecordController:checkCanSave(resultInfo)
	if not resultInfo then
		return
	end

	local isSucc = resultInfo:isSucceed()
	local difficulty = resultInfo:getDifficulty()
	local minRecordDiff = self:getMinRecordDifficulty()

	return isSucc and minRecordDiff <= difficulty
end

function Rouge2_FightRecordController:startSaveRecord()
	local param = {
		viewType = Rouge2_OutsideEnum.SaveInfoViewType.Edit
	}

	Rouge2_ViewHelper.openSaveInfoView(param)
end

function Rouge2_FightRecordController:cancelSaveRecord()
	Rouge2OutsideRpc.instance:sendRouge2SaveContextRequest(Rouge2_OutsideEnum.RemvoeSaveInfoIndex)
end

function Rouge2_FightRecordController:setUseRecordIndex(index)
	if not self:checkIndexValid(index) then
		return
	end

	local saveInfo = self:getSaveInfo(index)

	if not saveInfo then
		return
	end

	Rouge2OutsideRpc.instance:sendRouge2ChoiceSaveRequest(index)
end

function Rouge2_FightRecordController:hasUseSaveIndex()
	local battleInfo = Rouge2_OutsideModel.instance:getBossBattleInfo()

	return battleInfo and battleInfo:hasUseSaveIndex()
end

function Rouge2_FightRecordController:getUseSaveIndex()
	local battleInfo = Rouge2_OutsideModel.instance:getBossBattleInfo()

	return battleInfo and battleInfo:getUseSaveIndex()
end

function Rouge2_FightRecordController:getUseSaveInfo()
	if not self:hasUseSaveIndex() then
		return
	end

	local useSaveIndex = self:getUseSaveIndex()

	return self:getSaveInfo(useSaveIndex)
end

Rouge2_FightRecordController.instance = Rouge2_FightRecordController.New()

return Rouge2_FightRecordController
