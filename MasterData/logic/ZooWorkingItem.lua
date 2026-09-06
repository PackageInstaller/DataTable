-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/zoo/view/ZooWorkingItem.lua

module("logic.extensions.zoo.view.ZooWorkingItem", package.seeall)

local ZooWorkingItem = class("ZooWorkingItem", ZooPlaceItem)

function ZooWorkingItem:buildUI()
	ZooWorkingItem.super.buildUI(self)

	self._cancelBtn = Framework.ButtonAdapter.GetFrom(self.mainGO, "activeCon/cancelBtn")
	self._lockDesc = goutil.findChildTextComponent(self.mainGO, "lockCon/lockDesc/txt")
end

function ZooWorkingItem:onEnter(index, animalModel, buildingMO)
	self._buildingMO = buildingMO

	ZooWorkingItem.super.onEnter(self, index, animalModel)
	GlobalDispatcher:addListener(GlobalNotify.OnPutAnimalToWork, self._onPutAnimalToWork, self)
	self._cancelBtn:AddClickListener(self._onClickCancel, self)
end

function ZooWorkingItem:onExit()
	self._replaceAnimalId = nil

	self._cancelBtn:RemoveClickListener()
	ZooWorkingItem.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.OnPutAnimalToWork, self._onPutAnimalToWork, self)
end

function ZooWorkingItem:setData(animalModel)
	self._animalModel = animalModel

	goutil.setActive(self._emptyCon, false)

	self._nameText.text = animalModel.name

	goutil.setActive(self._activeCon, true)

	if self._show == nil then
		self._show, self._avatar = animalModel:showAnimalAvatar(self._icon, 128, 128, 0.56, 0.45, AvatarUseType.Scene)
	else
		local avatarMo = self._avatar:getNewUseMo()

		avatarMo:setDataByAnimalMo(animalModel)
		self._avatar:updateByMo(avatarMo)
	end
end

function ZooWorkingItem:setLock(flag)
	ZooWorkingItem.super.setLock(self, flag)

	if flag then
		self._lockDesc = string.format(lang("petzoo_working_unlockpet_level"), self._buildingMO.buildingLevel + 1)
	end
end

function ZooWorkingItem:_onClickGo()
	self._replaceAnimalId = nil
	self._isDirty = false

	if self._lock then
		FloatWordMgr.instance:show(string.format(lang("petzoo_working_nummaxtips"), self._buildingMO:getBuildingName(), self._buildingMO.buildingLevel + 1))

		return
	end

	local function selectCallBack(selectIds)
		self._isDirty = true

		ZooController.instance:replaceAnimalWorking(self._buildingMO:getBuildingId(), self.index, selectIds[1], -1)
	end

	ZooController.instance:openSelectView(ZooController.ANIMALTYPE, selectCallBack, self._buildingMO.zooMo:getCanWorkingAnimalList(), nil, nil, lang("petzoo_building_deployment"))
end

function ZooWorkingItem:_onClickChange()
	self._isDirty = false
	self._replaceAnimalId = nil

	local function selectCallBack(selectIds)
		self._isDirty = true
		self._replaceAnimalId = selectIds[1]

		ZooController.instance:replaceAnimalWorking(self._buildingMO:getBuildingId(), self.index, self._replaceAnimalId, self:getAnimalId())
	end

	ZooController.instance:openSelectView(ZooController.ANIMALTYPE, selectCallBack, self._buildingMO.zooMo:getCanWorkingAnimalList(), nil, nil, lang("petzoo_building_deployment"))
end

function ZooWorkingItem:_onClickCancel()
	self._replaceAnimalId = nil
	self._isDirty = true

	ZooController.instance:replaceAnimalWorking(self._buildingMO:getBuildingId(), self.index, -1, self:getAnimalId())
end

function ZooWorkingItem:_onPutAnimalToWork(buildingId, slotId, animalId)
	if not self._isDirty then
		return
	end

	if animalId <= 0 then
		self:clearData(false)

		if not self._replaceAnimalId then
			self._isDirty = false
		end
	else
		self:setData(self._buildingMO.zooMo:getAnimalById(animalId))

		self._replaceAnimalId = nil
		self._isDirty = false
	end
end

return ZooWorkingItem
