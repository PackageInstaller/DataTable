-- chunkname: @modules/logic/survival/model/SurvivalModel.lua

module("modules.logic.survival.model.SurvivalModel", package.seeall)

local SurvivalModel = class("SurvivalModel", BaseModel)

function SurvivalModel:onInit()
	self._outsideInfo = SurvivalOutSideInfoMo.New()
	self._report = nil
	self._survivalSettleInfo = nil
	self._lastIndex = nil
	self._isUseSimpleDesc = PlayerPrefsHelper.getNumber(PlayerPrefsKey.SurvivalDescSimply, 1)
	self.summaryActPosOffset = 0

	self:clearDebugSettleStr()
end

function SurvivalModel:clearDebugSettleStr()
	self.debugSettleStr = ""
end

function SurvivalModel:addDebugSettleStr(str)
	self.debugSettleStr = string.format("%s\n%s", self.debugSettleStr, str)
end

function SurvivalModel:reInit()
	self:onInit()
	SurvivalMapHelper.instance:clear()
end

function SurvivalModel:getCurVersionActivityId()
	return VersionActivity3_5Enum.ActivityId.Survival
end

function SurvivalModel:onGetInfo(info)
	self._outsideInfo:init(info)
	SurvivalController.instance:dispatchEvent(SurvivalEvent.OnOutInfoChange)
end

function SurvivalModel:getOutSideInfo()
	return self._outsideInfo
end

function SurvivalModel:getRewardState(rewardId, rewardScore)
	return self._outsideInfo:getRewardState(rewardId, rewardScore)
end

function SurvivalModel:setDailyReport(report)
	self._report = report
end

function SurvivalModel:getDailyReport()
	return self._report
end

function SurvivalModel:setSurvivalSettleInfo(info)
	self._survivalSettleInfo = info
end

function SurvivalModel:getSurvivalSettleInfo()
	return self._survivalSettleInfo
end

function SurvivalModel:changeDescSimple()
	self._isUseSimpleDesc = 1 - self._isUseSimpleDesc

	PlayerPrefsHelper.setNumber(PlayerPrefsKey.SurvivalDescSimply, self._isUseSimpleDesc)
	SurvivalController.instance:dispatchEvent(SurvivalEvent.OnEquipDescSimpleChange)
end

function SurvivalModel:setBossFightLastIndex(index)
	self._lastIndex = index
end

function SurvivalModel:getBossFightLastIndex()
	self._lastIndex = nil

	return self._lastIndex
end

function SurvivalModel:getSummaryActMapId()
	return 3102
end

function SurvivalModel:getCollectionRoomMapId()
	return 10003
end

function SurvivalModel:getDefaultRoleId()
	return tonumber(lua_survival_hardness_mod.configDict[SurvivalEnum.SimpleHardnessId].initRole)
end

function SurvivalModel:cacheBossFightItem(msg)
	self.cacheBossItemTips = msg.itemTips
end

function SurvivalModel:checkBossFightItem()
	if self.cacheBossItemTips then
		local items = {}

		for _, v in ipairs(self.cacheBossItemTips) do
			local itemMo = SurvivalBagItemMo.New()

			itemMo:init({
				id = v.itemId,
				count = v.count
			})

			itemMo.source = SurvivalEnum.ItemSource.Drop

			table.insert(items, itemMo)
		end

		if #items > 0 then
			PopupController.instance:addPopupView(PopupEnum.PriorityType.CommonPropView, ViewName.SurvivalGetRewardView, {
				items = items
			})

			self.cacheBossItemTips = nil
		end
	end
end

SurvivalModel.instance = SurvivalModel.New()

return SurvivalModel
