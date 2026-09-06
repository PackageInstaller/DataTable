-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timewheel/view/TimeWheelOverflowItem.lua

module("logic.extensions.timewheel.view.TimeWheelOverflowItem", package.seeall)

local TimeWheelOverflowItem = class("TimeWheelOverflowItem")

function TimeWheelOverflowItem:ctor(luaComponentContainer)
	local go = luaComponentContainer.gameObject

	self._mask = goutil.findChild(go, "mask")
	self._node = goutil.findChild(go, "node")
	self._btnClick = Framework.ButtonAdapter.GetFrom(go, "btnClick")
end

function TimeWheelOverflowItem:init(data)
	self._data = data

	self._mask:SetActive(false)
	self._btnClick:AddClickListener(self._onBtnClick, self)

	local isSelect = TimeWheelStateModel.instance:isPetSelected(self._data)

	self._mask:SetActive(isSelect)

	if data.matType == TimeWheelStateModel.Pet then
		local proxy = MaterialMgr.setCellByGId(MatType.Pet, data.id, self._node)

		proxy.binder:setLock()

		local petMo = BagPetsController.instance:getPet(data.id)

		proxy.binder:showStarByCustom(petMo:getAwakenLv())
	elseif data.matType == TimeWheelStateModel.Item then
		local proxy = MaterialMgr.setCell(MatType.Item, data.id, self._node)
	end
end

function TimeWheelOverflowItem:reset()
	MaterialMgr.resetAll(self._node)
	self._btnClick:RemoveClickListener()

	self._data = nil
end

function TimeWheelOverflowItem:_onBtnClick()
	if self._data.matType == TimeWheelStateModel.Pet then
		local bagPetMo = BagModel.instance:getPet(self._data.id)

		if bagPetMo and bagPetMo:isLocked() then
			TimeWheelController.instance:openUnlockPopupView(bagPetMo)

			return
		end
	end

	local selectedPets = TimeWheelStateModel.instance:getSelectedPets()
	local isSelected = false

	for k, v in pairs(selectedPets) do
		if v == self._data then
			isSelected = true

			break
		end
	end

	if isSelected then
		TimeWheelStateModel.instance:removePet(self._data)
		self._mask:SetActive(false)
		printInfo("test 是否选中2", isSelected, self._data.matType, self._data.id)
		GlobalDispatcher:dispatch(GlobalNotify.RefreshSelectedArea)

		return
	end

	local isNotDestroy = false

	if self._data.matType == TimeWheelStateModel.Pet then
		local bagPetMo = BagModel.instance:getPet(self._data.id)

		if bagPetMo then
			isNotDestroy = bagPetMo:checkHasDestroyStarGodPlus()
		end
	end

	if isNotDestroy then
		FloatWordMgr.instance:show("该精灵佩戴专属星神不可进行此操作")

		return
	end

	local isTopLimit = TimeWheelStateModel.instance:isSelectTopLimit()

	if isTopLimit then
		FloatWordMgr.instance:show(TimeWheelStateModel.instance:getMaxTopTip())

		return
	end

	if self._data.matType == TimeWheelStateModel.Pet then
		local bagPetMo = BagModel.instance:getPet(self._data.id)
		local raceId = bagPetMo:getDefineId()
		local isEvolved = EvolveConfig.instance:getDivineEvolvePlusCfgByNewRaceId(raceId)

		if isEvolved then
			local text = DivineEvolvePlusController.instance:getEvolveTip()

			TipsFacade.instance:openPopupWindow(lang("tip"), text, function()
				self:_addPet()
			end)

			return
		end
	end

	self:_addPet()
end

function TimeWheelOverflowItem:_addPet()
	TimeWheelStateModel.instance:addPet(self._data)

	if not goutil.isNil(self._mask) then
		self._mask:SetActive(true)
	end

	GlobalDispatcher:dispatch(GlobalNotify.RefreshSelectedArea)
end

return TimeWheelOverflowItem
