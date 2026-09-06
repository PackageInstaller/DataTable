-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/petdisplay/controller/PetDisplayController.lua

module("logic.extensions.petdisplay.controller.PetDisplayController", package.seeall)

local PetDisplayController = class("PetDisplayController", BaseController)

function PetDisplayController:onInit()
	self._curPetId = nil
end

function PetDisplayController:_onNewPet(petId, isPlayNow)
	PetDisplayModel.instance:addNewPet(petId)

	if isPlayNow == true then
		self:checkAndOpenDisplay()
	end
end

function PetDisplayController:tryShowNext(force)
	if PetDisplayModel.instance:hasNewPet() then
		self:checkAndOpenDisplay(force)
	else
		GlobalDispatcher:dispatch(GlobalNotify.OnMaterialPopEnd, MatType.Pet)
		GlobalDispatcher:dispatch(GlobalNotify.OnPetPopEnd, 9)
		PetDisplayModel.instance:excuteCallback()
	end
end

function PetDisplayController:checkAndOpenDisplay(force)
	print("checkAndOpenDisplay " .. tostring(PetDisplayModel.instance:hasNewPet()))

	if ViewMgr.instance:isOpen(ViewName.PetDisplay) then
		return
	end

	if not PetDisplayModel.instance:hasNewPet() then
		if TaskController.instance:isPause() then
			TaskController.instance:resume()
		end

		return
	end

	if SceneMgr.instance.isGogingToEnterBattleScene then
		print("判断在战斗中 SceneMgr.instance.isGogingToEnterBattleScene=false  不弹【精灵】获得面板")

		return
	end

	if TaskFacade.instance:isTaskStepFinished(1, 2) then
		local branch = GuideModel.instance:getGuideBranch(GuideConst.BRANCH_Effect)

		if branch and not branch:isFinished() then
			print("判断在 新手引导 5神兽引导之前   不弹【精灵】获得面板")

			return
		end
	end

	local petMo = self:getNextPetMo()

	UIStateManager.instance:open(ViewName.PetDisplay, petMo)
end

function PetDisplayController:getNextPetMo()
	local petId = PetDisplayModel.instance:getNewPet()
	local petMo = BagModel.instance:getPet(petId)

	if petMo == nil then
		petMo = PetHireModel.instance:getPetMoById(petId)
	end

	return petMo
end

PetDisplayController.instance = PetDisplayController.New()

return PetDisplayController
