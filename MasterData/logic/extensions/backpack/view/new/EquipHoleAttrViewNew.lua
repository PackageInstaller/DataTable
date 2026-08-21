-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/backpack/view/new/EquipHoleAttrViewNew.lua

module("logic.extensions.backpack.view.new.EquipHoleAttrViewNew", package.seeall)

local M = class("EquipHoleAttrViewNew")

function M:ctor(compContainer)
	self._compContainer = compContainer
	self._mainGo = self._compContainer.gameObject

	self:_buildUI()
end

function M:_buildUI()
	self._unalterableGo = goutil.findChild(self._mainGo, "unalterable")
	self._txtDescUnalterable = goutil.findChildComponent(self._unalterableGo, "txtDesc", UIComponentType.TextMeshProUGUI)
	self._unlockGo = goutil.findChild(self._mainGo, "unlock")
	self._txtDescUnlock = goutil.findChildComponent(self._unlockGo, "txtDesc", UIComponentType.TextMeshProUGUI)
	self._lockGo = goutil.findChild(self._mainGo, "lock")
	self._txtDescLock = goutil.findChildComponent(self._lockGo, "txtDesc", UIComponentType.TextMeshProUGUI)
	self._noCalibrationGo = goutil.findChild(self._mainGo, "noCalibration")
	self._txtDescNoCalibration = goutil.findChildComponent(self._noCalibrationGo, "txtDesc", UIComponentType.TextMeshProUGUI)
	self._sealGo = goutil.findChild(self._mainGo, "seal")
	self._selectImg = goutil.findChild(self._mainGo, "imgSelect")
	self._btnClick = UIComponentType.ButtonAdapter(self._mainGo)

	self:_bindEvents()
end

function M:setSelectGoVisible(select)
	self._selectImg:SetActive(select)
end

function M:_bindEvents()
	self._btnClick:AddClickListener(self._onClickBtnClick, self)
end

function M:_unbindEvents()
	self._btnClick:RemoveClickListener()
end

function M:onEnter()
	return
end

function M:onExit()
	return
end

function M:OnDestroy()
	self:_destroyUI()
end

function M:_destroyUI()
	self:_unbindEvents()

	self._callback = nil
end

function M:_onClickBtnClick()
	if self._callback then
		self._callback()
	end
end

function M:setClickCallback(callback)
	self._callback = callback
end

function M:setEquipHoleAttrMo(equipHoleAttrMo)
	self._unalterableGo:SetActive(false)
	self._unlockGo:SetActive(false)
	self._lockGo:SetActive(false)
	self._noCalibrationGo:SetActive(false)
	self._sealGo:SetActive(false)

	if equipHoleAttrMo.status == EquipEnum.HoleStatus.Unalterable then
		self._unalterableGo:SetActive(true)

		self._txtDescUnalterable.text = equipHoleAttrMo.desc
	elseif equipHoleAttrMo.status == EquipEnum.HoleStatus.Lock then
		self._lockGo:SetActive(true)

		self._txtDescLock.text = equipHoleAttrMo.desc
	elseif equipHoleAttrMo.status == EquipEnum.HoleStatus.NoCalibration then
		self._noCalibrationGo:SetActive(true)

		self._txtDescNoCalibration.text = equipHoleAttrMo.desc
	elseif equipHoleAttrMo.status == EquipEnum.HoleStatus.Unlock then
		self._unlockGo:SetActive(true)

		self._txtDescUnlock.text = equipHoleAttrMo.desc
	elseif equipHoleAttrMo.status == EquipEnum.HoleStatus.Seal then
		self._sealGo:SetActive(true)
	end
end

function M:showGuang(iShowGuang)
	return
end

function M:showTimingTisp(show)
	return
end

function M:setVisible(visible)
	self._mainGo:SetActive(visible)
end

function M:setPos(x, y)
	if not self._transform then
		self._transform = self._mainGo.transform
	end

	TransformUtils.SetLocalPosition(self._transform, x, y, 0)
end

return M
