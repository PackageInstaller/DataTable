-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divineyuhui/view/DivineYuHuifmtView.lua

module("logic.extensions.divineyuhui.view.DivineYuHuifmtView", package.seeall)

local DivineYuHuifmtView = class("DivineYuHuifmtView", ViewComponent)

function DivineYuHuifmtView:ctor()
	DivineYuHuifmtView.super.ctor(self)
end

function DivineYuHuifmtView:unbindEvents()
	DivineYuHuifmtView.super.unbindEvents(self)
end

function DivineYuHuifmtView:bindEvents()
	DivineYuHuifmtView.super.bindEvents(self)
end

function DivineYuHuifmtView:buildUI()
	DivineYuHuifmtView.super.buildUI(self)

	self._imgList = {}

	for i = 1, 9 do
		local img = self:getGo("img" .. i)

		table.insert(self._imgList, img)
	end
end

function DivineYuHuifmtView:onExit()
	DivineYuHuifmtView.super.onExit(self)
	self:_clearAllStateUI()
end

function DivineYuHuifmtView:onEnter()
	DivineYuHuifmtView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.DivineYuHuiPetBagEndGrag, self.updateStateUI, self)

	self._fmtMo = self:getFirstParam()
	self._formationMo = self._fmtMo:getCurFormation()
	self._activityId = self._fmtMo:getActivityId()
	self._stageId = self._fmtMo:getStageId()
	self._info = DivineYuHuiModel.instance:getInfo(self._activityId)
	self._stageInfo = self._info.stages and self._info.stages[self._stageId]
	self._curStageCfg = DivineYuHuiConfig.instance:getStageCfgByStageId(self._activityId, self._stageId)

	self:updateStateUI()
end

function DivineYuHuifmtView:updateStateUI()
	self:_clearAllStateUI()
	settimer(1, self._changeState, self)
	self:_changeState()
end

function DivineYuHuifmtView:_clearAllStateUI()
	self._states = {}
	self._stateIdxDic = {
		0,
		0,
		0,
		0,
		0,
		0,
		0,
		0,
		0
	}

	removetimer(self._changeState, self)
end

function DivineYuHuifmtView:_changeState()
	local positions = self._formationMo:GetPositions()

	for i, img in ipairs(self._imgList) do
		local petId = positions[i]
		local imgState = goutil.findChild(img, "imgState")
		local imgComp = imgState:GetComponent(ComponentType.UIImageSpriteChange)

		GameUtil.SetActive(img, false)

		if petId > 0 then
			local petMo = BagPetsController.instance:getPet(petId)

			if petMo then
				local raceId = petMo.raceId

				if raceId > 0 then
					local stageIdList = DivineYuHuiModel.instance:getStageIdListByRaceId(self._activityId, raceId)

					if stageIdList and #stageIdList > 0 then
						local stageIdListLength = #stageIdList
						local index = self._stateIdxDic[i]
						local nextIndex = index % stageIdListLength + 1
						local nextState = stageIdList[nextIndex]

						self._states[i] = nextState
						self._stateIdxDic[i] = nextIndex

						imgComp:SetState(nextState - 1)
						GameUtil.SetActive(img, true)
					end
				end
			end
		end
	end
end

return DivineYuHuifmtView
