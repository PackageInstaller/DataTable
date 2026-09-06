-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/herotrial/model/HeroTrialFastFormation.lua

module("logic.extensions.material.model.HeroTrialFastFormation", package.seeall)

local HeroTrialFastFormation = class("HeroTrialFastFormation", FastFormationBase)

function HeroTrialFastFormation:_getCurFormId()
	return HerotrialModel.instance:getCurFormationId()
end

function HeroTrialFastFormation:_getCurFormation()
	return HerotrialModel.instance:getFormation()
end

function HeroTrialFastFormation:setFormation(isForce, notFilterFunc)
	self.position = nil

	HeroTrialFastFormation.super.setFormation(self, isForce, notFilterFunc)
end

function HeroTrialFastFormation:_changePosition(pos, value)
	self.position = self.position or {}
	self.position[pos] = value
end

function HeroTrialFastFormation:_setPositionFinish()
	self:_getCurFormation():setPositionForce(self.position)
end

function HeroTrialFastFormation:_getPets()
	return HerotrialModel.instance:getAllPets()
end

function HeroTrialFastFormation:_getPet(id)
	return HerotrialModel.instance:getPet(id)
end

function HeroTrialFastFormation:clean(fixedPosDic)
	local formId = self:_getCurFormId()
	local formCo = BattleConfig.instance:getFormationCo(formId)

	for i = 1, 9 do
		if i ~= 2 then
			if fixedPosDic then
				if not fixedPosDic[i] then
					local isFixed = false

					if TableUtil.isHad(formCo.posList, i) and not isFixed then
						self:_changePosition(i, 0)
					end
				end
			end
		end
	end

	self:_setPositionFinish()
end

function HeroTrialFastFormation:getInitNeedPets()
	local tempId = HerotrialModel.instance:getCreepsId()
	local petMo = self:_getPet(tempId)
	local initPets = {}

	table.insert(initPets, petMo)

	return initPets
end

function HeroTrialFastFormation:setPetAtFixedPos(posList, finalList)
	local tempId = HerotrialModel.instance:getCreepsId()
	local tempMo = self:_getPet(tempId)
	local fixPosList = {
		2
	}
	local fixPetMoList = {
		tempMo
	}
	local needPets = self.needPets

	posList, finalList = CustomFmtController.instance:getFinalFmoListAsFixPos(self:_getCurFormation(), posList, finalList, needPets, fixPosList, fixPetMoList, 5)

	for i, v in ipairs(posList) do
		local pet = finalList[i]

		if pet then
			self:_changePosition(v, pet.petId)
		else
			self:_changePosition(v, 0)
		end
	end
end

HeroTrialFastFormation.instance = HeroTrialFastFormation.New()

return HeroTrialFastFormation
