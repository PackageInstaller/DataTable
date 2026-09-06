-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinekingjiclg/view/DivinekingjiclgextView.lua

module("logic.extensions.divinekingjiclg.view.DivinekingjiclgextView", package.seeall)

local DivinekingjiclgextView = class("DivinekingjiclgextView", ViewComponent)

function DivinekingjiclgextView:buildUI()
	DivinekingjiclgextView.super.buildUI(self)

	self._txtDesc = self:getTxt("topDesc/txtDesc")
end

function DivinekingjiclgextView:onEnter()
	DivinekingjiclgextView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.DivineKingJiClgCalLockRaceNum, self._onCalNum, self)

	self._fmtMo = self:getFirstParam()

	self:_onCalNum()
end

function DivinekingjiclgextView:_onCalNum()
	local formation = self._fmtMo:getCurFormation()
	local positions = formation:GetPositions()
	local elemMap = formation:getCurElementRelationMap()
	local stageCfg = DivinekingjiclgConfig.instance:getStageCfg(self._fmtMo._activityId, self._fmtMo._stageId)
	local lockNum = stageCfg.baseLockCount
	local raceIdxMap = {}

	for i, petId in pairs(positions) do
		if petId > 0 then
			local raceIdx = elemMap[petId]

			if not raceIdx then
				local petMo = formation:_getPet(petId)

				if petMo then
					raceIdx = PetSkinConfig.instance:getFisrtEleAttrIdx(petMo.curFaceId)
				end
			end

			raceIdxMap[raceIdx] = raceIdxMap[raceIdx] or 0
			raceIdxMap[raceIdx] = raceIdxMap[raceIdx] + 1
		end
	end

	local addNum = 0

	for k, v in pairs(raceIdxMap) do
		addNum = addNum + (v - 1) * 2
	end

	local raceIdxTypeNum = table.nums(raceIdxMap)

	if raceIdxTypeNum > 0 then
		if not (raceIdxTypeNum - 1) then
			local reduceNum = 0

			lockNum = lockNum + addNum - reduceNum
			lockNum = Mathf.Clamp(lockNum, 0, stageCfg.maxLockCount)
			self._txtDesc.text = string.format("通关后将封印己方战力最高的<color=#96fa73>%s</color>只精灵（最多%s只）", lockNum, stageCfg.maxLockCount)
		end
	end
end

return DivinekingjiclgextView
