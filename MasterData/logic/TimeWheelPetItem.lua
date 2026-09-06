-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timewheel/view/TimeWheelPetItem.lua

module("logic.extensions.timewheel.view.TimeWheelPetItem", package.seeall)

local LuaComponentContainer = Framework.LuaComponentContainer
local TimeWheelPetItem = class("TimeWheelPetItem")

function TimeWheelPetItem.AddOnce(go)
	local component = LuaComponentContainer.Get(go, TimeWheelPetItem)

	component = component or LuaComponentContainer.Add(go, TimeWheelPetItem)

	return component
end

function TimeWheelPetItem:ctor(luaComponentContainer)
	local go = luaComponentContainer.gameObject

	self._mask = goutil.findChild(go, "mask")
	self._node = goutil.findChild(go, "node")
	self._btnClick = Framework.ButtonAdapter.GetFrom(go, "btnClick")
end

function TimeWheelPetItem:init(data)
	self._data = data
	self._curState = TimeWheelStateModel.instance:getCurState()

	self._btnClick:AddClickListener(self._onBtnClick, self)

	local petId = data:getPetId()
	local isSelect = TimeWheelStateModel.instance:isPetSelected(petId)

	self._mask:SetActive(isSelect)

	local proxy = MaterialMgr.setCellByGId(MatType.Pet, petId, self._node)

	proxy.binder:setLock()
end

function TimeWheelPetItem:reset()
	MaterialMgr.resetAll(self._node)
	self._btnClick:RemoveClickListener()

	self._data = nil
end

function TimeWheelPetItem:_onBtnClick()
	if self._data:isLocked() then
		TimeWheelController.instance:openUnlockPopupView(self._data)

		return
	end

	local selectedPets = TimeWheelStateModel.instance:getSelectedPets()
	local isSelected = false
	local curPetId = self._data:getPetId()

	for k, v in pairs(selectedPets) do
		if v == curPetId then
			isSelected = true

			break
		end
	end

	if isSelected then
		TimeWheelStateModel.instance:removePet(curPetId)
		self._mask:SetActive(false)
		GlobalDispatcher:dispatch(GlobalNotify.RefreshSelectedArea)

		return
	end

	local isTopLimit = TimeWheelStateModel.instance:isSelectTopLimit()

	if isTopLimit then
		local curState = TimeWheelStateModel.instance:getCurState()

		if curState == TimeWheelStateModel.EnumType.Decompose then
			local txt = TimeWheelStateModel.instance:getMaxTopTip()

			FloatWordMgr.instance:show(txt)

			return
		else
			local selectedPets = TimeWheelStateModel.instance:getSelectedPets()
			local petId = selectedPets[1]

			TimeWheelStateModel.instance:clearSelectedPet()
			GlobalDispatcher:dispatch(GlobalNotify.CancelPetSelected, petId)
		end
	end

	TimeWheelStateModel.instance:addPet(curPetId)
	self._mask:SetActive(true)
	GlobalDispatcher:dispatch(GlobalNotify.RefreshSelectedArea)
end

return TimeWheelPetItem
