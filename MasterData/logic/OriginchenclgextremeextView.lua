-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originchenclg/view/OriginchenclgextremeextView.lua

module("logic.extensions.originchenclg.view.OriginchenclgextremeextView", package.seeall)

local OriginchenclgextremeextView = class("OriginchenclgextremeextView", ViewComponent)

function OriginchenclgextremeextView:ctor()
	OriginchenclgextremeextView.super.ctor(self)
end

function OriginchenclgextremeextView:unbindEvents()
	OriginchenclgextremeextView.super.unbindEvents(self)
end

function OriginchenclgextremeextView:bindEvents()
	OriginchenclgextremeextView.super.bindEvents(self)
end

function OriginchenclgextremeextView:buildUI()
	OriginchenclgextremeextView.super.buildUI(self)

	self._txtDesc = self:getTxt("topDesc/txtDesc")
	self._topDesc = self:getGo("topDesc")
end

function OriginchenclgextremeextView:onExit()
	OriginchenclgextremeextView.super.onExit(self)
end

function OriginchenclgextremeextView:onEnter()
	OriginchenclgextremeextView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.FormationChangeFinish, self._onFormationChanged, self)

	self._fmtMo = self:getFirstParam()
	self._activityId = self._fmtMo._activityId
	self._stageId = self._fmtMo._stageId
	self._actCfg = OriginChenClgConfig.instance:getActivityCfg(self._activityId)
	self._suitPlanId = self._actCfg.suitPlanId
	self._stageCfg = OriginChenClgConfig.instance:getExtremeStageCfg(self._activityId, self._stageId)
	self._petValidator = self._stageCfg.petValidator
	self._suitPlanCfg = OriginChenClgConfig.instance:getSuitPlanCfg(self._suitPlanId)

	self:_onFormationChanged()
end

function OriginchenclgextremeextView:_onFormationChanged()
	local formation = self._fmtMo:getCurFormation()
	local positions = formation:GetPositions()
	local hasPet = false
	local count = 0

	for i = 1, 9 do
		local petId = positions[i]

		if petId > 0 then
			hasPet = true

			local petMo = formation:_getPet(petId)
			local petContext = PetExpressValidator.buildContextByPetMo(petMo)

			if PetExpressValidator.match(self._petValidator, petContext) then
				count = count + 1
			end
		end
	end

	GameUtil.SetActive(self._topDesc, hasPet)

	for i, v in ipairs(self._suitPlanCfg) do
		if count >= v.minN and count <= v.maxN then
			self._txtDesc.text = v.desc

			break
		end
	end
end

return OriginchenclgextremeextView
