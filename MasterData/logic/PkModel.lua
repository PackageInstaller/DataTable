-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/pk/model/PkModel.lua

module("logic.extensions.pk.model.PkModel", package.seeall)

local PkModel = class("PkModel", BaseModel)

PkModel.IniteNotify = "PkModel.IniteNotify"

function PkModel:ctor()
	return
end

function PkModel:onInit()
	return
end

function PkModel:onReset()
	self._pkSwitch = nil
	self._pkStranger = nil
	self._myForm = nil
	self._attackVideo = nil
end

function PkModel:setMyFormation(formMo)
	self._myForm = self._myForm or formMo
end

function PkModel:getMyFormation()
	return self._myForm
end

function PkModel:setDefenseForm(form, petSimple)
	if form then
		local list = {}
		local pool = {}

		for i, v in ipairs(petSimple) do
			local bagPet = BagPetMo.New()

			bagPet:initBaseView(v)
			table.insert(list, bagPet)

			pool[bagPet.petId] = bagPet
		end

		self._defenseFormPet = petSimple
		self._defenseForm = FormationMO.New(function(petId)
			return pool[petId]
		end)

		self._defenseForm:SetData(form)
	else
		self._defenseForm = nil
		self._defenseFormPet = nil
	end
end

function PkModel:getDefenseForm()
	return self._defenseForm
end

function PkModel:getDefensePetSimple()
	return self._defenseFormPet
end

function PkModel:setHeadInfo(myheadInfo, opHeadInfo)
	self._myHeadInfo = myheadInfo
	self._opHeadInfo = opHeadInfo
end

function PkModel:getMyUserHeadInfo()
	return self._myHeadInfo
end

function PkModel:getOpUserHeadInfo()
	return self._opHeadInfo
end

function PkModel:setPkResult(state, attackVideo, defenseVideo, myPetLeftCount, opPetLeftCount, myForm, opForm, recordId)
	print("setPkResult" .. debug.traceback())

	self._attackVideo = attackVideo
	self._pkResult = {
		state = state,
		attackVideo = attackVideo,
		defenseVideo = defenseVideo,
		myPetLeftCount = myPetLeftCount,
		opPetLeftCount = opPetLeftCount or 0,
		myForm = myForm,
		opForm = opForm,
		recordId = recordId
	}
end

function PkModel:getPkResult()
	return self._pkResult
end

function PkModel:getPkAttackVideo()
	if self._attackVideo then
		print("xxxxxxxxxxxxxxxxxx")

		local str = self._attackVideo:SerializeToString()
		local msgClone = BattleExtension_pb.PM_BattleResult()

		msgClone:ParseFromString(str)

		return msgClone
	end
end

function PkModel:setPkSwitch(switch, stranger)
	self._pkSwitch = switch
	self._pkStranger = stranger
end

function PkModel:getPkSwitch()
	return self._pkSwitch, self._pkStranger
end

PkModel.instance = PkModel.New()

return PkModel
