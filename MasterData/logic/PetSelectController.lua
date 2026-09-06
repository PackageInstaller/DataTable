-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/petselect/controller/PetSelectController.lua

module("logic.extensions.petselect.controller.PetSelectController", package.seeall)

local PetSelectController = class("PetSelectController", BaseController)

PetSelectController.STATE_NORMAL = 1
PetSelectController.STATE_ONE_RACE = 2

function PetSelectController:ctor()
	return
end

function PetSelectController:onInit()
	self:onReset()
end

function PetSelectController:onReset()
	self._selectedPet = {}
	self._canNotSelectPet = {}
	self._targetObj = nil
	self._filterFunc = nil
	self._submitFunc = nil
	self._cancelFunc = nil
	self._petIsNoneFunc = nil
	self._canNotEmpty = nil
	self._numStrict = nil
	self._petList = nil
end

function PetSelectController:setStartSelect(arr)
	self._startSelectList = arr
end

function PetSelectController:setOneRaceState()
	self:setState(PetSelectController.STATE_ONE_RACE)
end

function PetSelectController:setNormalState()
	self:setState(PetSelectController.STATE_NORMAL)
end

function PetSelectController:setState(state)
	self.state = state
end

function PetSelectController:OpenView(onlyoneOrCount, title, filterFunc, submitFunc, cancelFunc, petIsNoneFunc, targetObj, petList, canNotEmpty, numStrict, txtEmpty, sortFunc, showbagpetRaceName, isTopFunc)
	self._selectedPet = self._startSelectList or {}
	self._startSelectList = nil
	self._canNotSelectPet = {}
	self.selectedLimit = 1

	if type(onlyoneOrCount) == "boolean" then
		self._onlyOne = onlyoneOrCount

		if onlyoneOrCount == false then
			self.selectedLimit = -1
		end
	elseif type(onlyoneOrCount) == "number" then
		onlyoneOrCount = math.max(1, onlyoneOrCount)
		self._onlyOne = onlyoneOrCount == 1
		self.selectedLimit = onlyoneOrCount
	end

	self._targetObj = targetObj
	self._filterFunc = filterFunc
	self._submitFunc = submitFunc
	self._cancelFunc = cancelFunc
	self._petIsNoneFunc = petIsNoneFunc
	self._canNotEmpty = canNotEmpty
	self._numStrict = numStrict
	self._sortFunc = sortFunc
	self._showbagpetRaceName = showbagpetRaceName
	self._isTopFunc = isTopFunc
	petList = petList or BagPetsController.instance:getBagPets() or {}
	self._petList = petList

	ViewMgr.instance:open(ViewName.PetSelect_New, title, petList, txtEmpty)
end

function PetSelectController:OpenViewWithOnce(title, filterFunc, submitFunc, cancelFunc, targetObj)
	self:OpenView(true, title, filterFunc, submitFunc, cancelFunc, nil, targetObj)
end

function PetSelectController:OpenViewWithMultiple(title, filterFunc, submitFunc, cancelFunc, targetObj)
	self:OpenView(false, title, filterFunc, submitFunc, cancelFunc, nil, targetObj)
end

function PetSelectController:OpenViewMaybePetIsNone(title, filterFunc, submitFunc, cancelFunc, petIsNoneFunc, targetObj)
	self:OpenView(true, title, filterFunc, submitFunc, cancelFunc, petIsNoneFunc, targetObj)
end

function PetSelectController:OpenViewWithParams(params)
	self:OpenView(params.onlyoneOrCount, params.title, params.filterFunc, params.submitFunc, params.cancelFunc, params.petIsNoneFunc, params.targetObj, petList, params.canNotEmpty, params.numStrict, params.txtEmpty, params.sortFunc, params.showbagpetRaceName, params.isTopFunc)
end

function PetSelectController:Filter(pet)
	if not self._filterFunc then
		return true
	end

	if self._targetObj then
		return self._filterFunc(self._targetObj, pet)
	else
		return self._filterFunc(pet)
	end
end

function PetSelectController:OnSubmit()
	local petIdList = {}

	for k, v in pairs(self._selectedPet) do
		if v == true then
			table.insert(petIdList, k)
		end
	end

	if #petIdList == 0 and self._canNotEmpty then
		FloatWordMgr.instance:show("请先选择精灵")

		return
	elseif self.selectedLimit ~= -1 then
		if #petIdList > self.selectedLimit then
			FloatWordMgr.instance:show(langPara("选择的精灵数量不能超过%s只", self.selectedLimit))

			return
		end

		if self._numStrict then
			local limitNum = math.min(#self._petList, self.selectedLimit)

			if limitNum > #petIdList then
				FloatWordMgr.instance:show(langPara("需要选择%s只精灵", limitNum))

				return
			end
		end
	end

	ViewMgr.instance:close(ViewName.PetSelect_New)

	if #petIdList > 0 then
		FloatWordMgr.instance:show(lang("选择精灵成功"))
	else
		FloatWordMgr.instance:show(lang("没有选中精灵"))
	end

	if not self._submitFunc then
		return
	end

	local res = self._onlyOne and petIdList[1] or petIdList

	if self._targetObj then
		self._submitFunc(self._targetObj, res, petIdList)
	else
		self._submitFunc(res, petIdList)
	end

	self._selectedPet = {}
end

function PetSelectController:OnCancel()
	ViewMgr.instance:close(ViewName.PetSelect_New)

	if not self._cancelFunc then
		return
	end

	if self._targetObj then
		self._cancelFunc(self._targetObj)
	else
		self._cancelFunc()
	end

	self._selectedPet = {}
end

function PetSelectController:OnPetSelectChanged(petId)
	if self._selectedPet[petId] == true then
		self._selectedPet[petId] = false

		if self.state == PetSelectController.STATE_ONE_RACE then
			self:clearCannotSelectPetsPetId(petId)
		end
	else
		if self._onlyOne then
			self._selectedPet = {}
			self._canNotSelectPet = {}
		elseif self.selectedLimit ~= -1 and self:getSelectCount() >= self.selectedLimit then
			FloatWordMgr.instance:show(langPara("选择的精灵数量不能超过%s只", self.selectedLimit))

			return
		end

		self._selectedPet[petId] = true

		if self.state == PetSelectController.STATE_ONE_RACE then
			self:setCannotSelectPets(petId)
		end
	end

	GlobalDispatcher:dispatch(GlobalNotify.PetSelectChanged)
end

function PetSelectController:setCannotSelectPets(petId)
	local mo = MaterialMgr.getModel(MatType.Pet, petId)

	if mo then
		local raceId = mo.raceId
		local pets = BagPetsController.instance:getBagPets() or {}

		for k, v in pairs(pets) do
			if v.petId ~= petId and v.raceId == raceId then
				self._canNotSelectPet[v.petId] = true
			end
		end
	end
end

function PetSelectController:clearCannotSelectPetsPetId(petId)
	local mo = MaterialMgr.getModel(MatType.Pet, petId)

	if mo then
		local raceId = mo.raceId

		for k, v in pairs(self._canNotSelectPet) do
			local tmp = MaterialMgr.getModel(MatType.Pet, k)

			if tmp.raceId == raceId then
				self._canNotSelectPet[k] = nil
			end
		end
	end
end

function PetSelectController:IsCannotSelect(petId)
	return self._canNotSelectPet[petId] == true
end

function PetSelectController:IsPetSelected(petId)
	return self._selectedPet[petId] == true
end

function PetSelectController:getSelectLimit()
	return self.selectedLimit
end

function PetSelectController:getSelectCount()
	local count = 0

	for k, v in pairs(self._selectedPet) do
		if v == true then
			count = count + 1
		end
	end

	return count
end

function PetSelectController:petIsNoneFunc()
	if not self._petIsNoneFunc then
		return
	end

	if self._targetObj then
		self._petIsNoneFunc(self._targetObj)
	else
		self._petIsNoneFunc()
	end
end

function PetSelectController:customSortFunc(pets, isFirstSort)
	if not self._sortFunc then
		return false
	end

	if self._targetObj then
		return self._sortFunc(self._targetObj, pets, isFirstSort)
	else
		return self._sortFunc(pets, isFirstSort)
	end
end

function PetSelectController:isShowbagpetRaceName()
	return self._showbagpetRaceName
end

function PetSelectController:isTop(raceId)
	if self._isTopFunc then
		if self._targetObj then
			return self._isTopFunc(self._targetObj, raceId)
		else
			return self._isTopFunc(raceId)
		end
	end

	return false
end

PetSelectController.instance = PetSelectController.New()

return PetSelectController
