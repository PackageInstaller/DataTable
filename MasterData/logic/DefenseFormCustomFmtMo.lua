-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/traincampdefense/model/DefenseFormCustomFmtMo.lua

module("logic.extensions.traincampqiecuo.model.DefenseFormCustomFmtMo", package.seeall)

local DefenseFormCustomFmtMo = class("DefenseFormCustomFmtMo", ICustomFmtMo)

function DefenseFormCustomFmtMo:initSaveHandler()
	self.setSaveHandler(self, function(ref, fromBtnSave)
		if not fromBtnSave then
			TraincampdefenseModel.instance:resetFormDefenseForm()

			return
		end

		local num = self:getCurFormation():getCurExistPetNumber()

		if num < 5 then
			FloatWordMgr.instance:show("不含契约精灵，上阵数量小于5只，无法保存")

			return
		end

		TraincampdefenseController.instance:saveDefenseForm()
	end, self)
end

function DefenseFormCustomFmtMo:initParams()
	self.isShowTab = false
	self.isShowBtnSave = true
end

function DefenseFormCustomFmtMo:initPetList()
	local pets = BagPetsController.instance:getFightBagPet()

	for i, petMo in ipairs(pets) do
		self:addPetToList(petMo)
	end
end

function DefenseFormCustomFmtMo:refreshPetList(changePetMoMap)
	for petId, petMo in pairs(changePetMoMap) do
		self:updatePetMo(petMo)
	end
end

function DefenseFormCustomFmtMo:initFightHandler()
	return
end

return DefenseFormCustomFmtMo
