-- chunkname: @modules/logic/turnback/model/TurnbackSignInModel.lua

module("modules.logic.turnback.model.TurnbackSignInModel", package.seeall)

local TurnbackSignInModel = class("TurnbackSignInModel", ListScrollModel)

function TurnbackSignInModel:OnInit()
	self:reInit()
end

function TurnbackSignInModel:reInit()
	self.signInInfoMoList = {}
end

function TurnbackSignInModel:setSignInInfoList(signInInfos)
	self.signInInfoMoList = {}

	local curTurnbackId = TurnbackModel.instance:getCurTurnbackId()

	for i = 1, #signInInfos do
		local signInInfoMo = TurnbackSignInInfoMo.New()

		signInInfoMo:init(signInInfos[i], curTurnbackId)
		table.insert(self.signInInfoMoList, signInInfoMo)
	end

	table.sort(self.signInInfoMoList, function(a, b)
		return a.id < b.id
	end)
	self:setSignInList()
end

function TurnbackSignInModel:getSignInInfoMoList()
	return self.signInInfoMoList
end

function TurnbackSignInModel:getSignInStateById(id)
	local mo = self.signInInfoMoList[id]

	if mo then
		return mo.state
	end
end

function TurnbackSignInModel:setSignInList()
	if GameUtil.getTabLen(self.signInInfoMoList) > 0 then
		self:setList(self.signInInfoMoList)
	end
end

function TurnbackSignInModel:updateSignInInfoState(id, state)
	for _, info in ipairs(self.signInInfoMoList) do
		if info.id == id then
			info:updateState(state)

			break
		end
	end

	self:setList(self.signInInfoMoList)
end

function TurnbackSignInModel:getTheFirstCanGetIndex()
	for index, info in ipairs(self.signInInfoMoList) do
		if info.state == TurnbackEnum.SignInState.CanGet then
			return index
		end
	end

	return 0
end

function TurnbackSignInModel:setOpenTimeStamp()
	self.startTimeStamp = UnityEngine.Time.realtimeSinceStartup
end

function TurnbackSignInModel:getOpenTimeStamp()
	return self.startTimeStamp
end

function TurnbackSignInModel:checkShowNextTag(curItemDay)
	local curSignInDay = TurnbackModel.instance:getCurSignInDay()

	if curSignInDay and curSignInDay < 7 and curItemDay == curSignInDay + 1 then
		return true
	end

	return false
end

function TurnbackSignInModel:checkGetAllSignInReward()
	for index, mo in ipairs(self.signInInfoMoList) do
		if mo.state ~= TurnbackEnum.SignInState.HasGet then
			return false
		end
	end

	return true
end

TurnbackSignInModel.instance = TurnbackSignInModel.New()

return TurnbackSignInModel
