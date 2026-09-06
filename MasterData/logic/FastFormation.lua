-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/formation/model/FastFormation.lua

module("logic.extensions.formation.model.FastFormation", package.seeall)

local FastFormation = class("FastFormation", FastFormationBase)

function FastFormation:_getCurFormId()
	return FormationNewModel.instance:GetCurFormId()
end

function FastFormation:_getCurFormation()
	if self.myCurForFunc then
		return GameUtil.callBack(self.myCurForFunc)
	else
		return FormationNewModel.instance:GetCurTeam():GetCurFormation()
	end
end

function FastFormation:_changePosition(pos, value)
	self.position = self.position or {}
	self.position[pos] = value
end

function FastFormation:_setPositionFinish()
	self:_getCurFormation():setPositionForce(self.position)
	GlobalDispatcher:dispatch(GlobalNotify.FormationPet_POS_FINISH)
end

function FastFormation:_getPets()
	if self.myCurListFunc then
		return GameUtil.callBack(self.myCurListFunc)
	else
		return self:_getBagPets()
	end
end

function FastFormation:_getBagPets()
	return BagPetsController.instance:getFightBagPet() or {}
end

function FastFormation:setCurFormFunc(myCurForFunc)
	self.myCurForFunc = myCurForFunc
end

function FastFormation:setGetCurPetList(myCurListFunc)
	self.myCurListFunc = myCurListFunc
end

function FastFormation:setFormation(isForce, notFilterFunc, myFinalListFunc)
	self.position = nil
	self.myFinalListFunc = myFinalListFunc

	FastFormation.super.setFormation(self, isForce, notFilterFunc)
end

function FastFormation:clean(fixedPosDic)
	self.position = nil

	FastFormation.super.clean(self, fixedPosDic)
end

function FastFormation:getFinalePosList(posList, petPool)
	if self.myFinalListFunc ~= nil then
		posList, petPool = GameUtil.callBack(self.myFinalListFunc, posList, petPool)
	end

	return posList, petPool
end

function FastFormation:setPetAtFixedPos(posList, petList)
	posList, petList = self:getFinalePosList(posList, petList)

	for i, v in ipairs(posList) do
		local pet = petList[i]

		if pet then
			self:_changePosition(v, pet.petId)
		else
			self:_changePosition(v, 0)
		end
	end
end

FastFormation.instance = FastFormation.New()

return FastFormation
