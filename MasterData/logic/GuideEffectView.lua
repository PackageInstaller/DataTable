-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/guide/view/GuideEffectView.lua

module("logic.extensions.guide.view.GuideEffectView", package.seeall)

local GuideEffectView = class("GuideEffectView", ViewComponent)

function GuideEffectView:ctor()
	GuideEffectView.super.ctor(self)
end

function GuideEffectView:onEnter()
	local _camera = goutil.find("UICamera"):GetComponent("Camera")

	CameraRectSetter.CalcRect(_camera)

	_camera.enabled = false

	TaskController.instance:pause()
end

function GuideEffectView:onExit()
	local _camera = goutil.find("UICamera")

	_camera:GetComponent("Camera").enabled = true

	local _allPets = BagPetsController.instance:getBagPets()

	for i, v in pairs(_allPets) do
		if v.raceId == 10059 then
			FormationController.instance:ChangePosition(2, v.petId)
		elseif v.raceId == 10057 then
			FormationController.instance:ChangePosition(4, v.petId)
		elseif v.raceId == 10058 then
			FormationController.instance:ChangePosition(6, v.petId)
		elseif v.raceId == 10060 then
			FormationController.instance:ChangePosition(8, v.petId)
		elseif v.raceId == 10140 then
			FormationController.instance:ChangePosition(5, v.petId)
		end
	end

	FormationController.instance:SaveFormationEx()
	PetDisplayController.instance:tryShowNext(true)
end

return GuideEffectView
