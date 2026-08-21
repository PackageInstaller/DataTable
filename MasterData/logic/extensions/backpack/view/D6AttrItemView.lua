-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/backpack/view/D6AttrItemView.lua

module("logic.extensions.backpack.view.D6AttrItemView", package.seeall)

local M = class("D6AttrItemView")

function M:ctor(compContainer)
	self._compContainer = compContainer
	self._mainGo = self._compContainer.gameObject

	self:_buildUI()

	self._data = nil
end

function M:_buildUI()
	self._txtD6AttributeUnlock = goutil.findChildComponent(self._mainGo, "unlock/txtD6Attribute", UIComponentType.TextMeshProUGUI)
	self._txtD6AttributeUnknow = goutil.findChildComponent(self._mainGo, "unknown/txtD6Attribute", UIComponentType.TextMeshProUGUI)
	self._txtD6AttributeUnknow.text = StringUtil.randomReplaceTMPToBlackBlock("?????")
	self._txtD6AttributeLock = goutil.findChildComponent(self._mainGo, "lock/txtLock", UIComponentType.TextMeshProUGUI)
	self._txtD6AttrOrigin = goutil.findChildComponent(self._mainGo, "unalterable/txtD6Attribute", UIComponentType.TextMeshProUGUI)
	self._statusGo = {
		goutil.findChild(self._mainGo, "unalterable"),
		goutil.findChild(self._mainGo, "lock"),
		goutil.findChild(self._mainGo, "noCalibration"),
		goutil.findChild(self._mainGo, "unlock"),
		goutil.findChild(self._mainGo, "seal"),
		goutil.findChild(self._mainGo, "unknown")
	}

	local equipHoleItemGo = goutil.findChild(self._mainGo, "equip_hole_item")

	self._equipHoleItemView = Astral.LuaComponentContainer.Add(equipHoleItemGo, EquipHoleItemView)

	self._equipHoleItemView:setNoCalibrationIcon(false)

	self._currentGo = goutil.findChild(self._mainGo, "unlock/current")
	self._RomeNum = {}

	for i = 1, 6 do
		local item = goutil.findChild(self._mainGo, "dice/" .. i)

		self._RomeNum[i] = item
	end

	self._currentGo:SetActive(false)

	self._enhanceAniGo = {
		goutil.findChild(self._mainGo, "equip_hole_item/vfx04_loop02"),
		goutil.findChild(self._mainGo, "equip_hole_item/vfx04_loop01")
	}

	for _, go in ipairs(self._enhanceAniGo) do
		goutil.setActive(go, false)
	end
end

function M:setTimingLockingShow(isShow)
	self._equipHoleItemView:setTimingLockingShow(isShow)
end

function M:closeEnhanceAni()
	goutil.setActive(self._enhanceAniGo[2], false)
	goutil.setActive(self._enhanceAniGo[1], false)
end

function M:playEnhanceAni(enhanceNum)
	if enhanceNum > 1 and enhanceNum < 4 then
		goutil.setActive(self._enhanceAniGo[2], true)
	elseif enhanceNum == 4 then
		goutil.setActive(self._enhanceAniGo[1], true)
	end
end

function M:expendAsBotton()
	self._btnClick = UIComponentType.ButtonAdapter(self._mainGo)

	self._btnClick:AddClickListener(self._onClickBtnClick, self)
end

function M:onEnter()
	return
end

function M:onExit()
	return
end

function M:setData(diceAttrMo)
	self._data = diceAttrMo
	self._txtD6AttributeUnlock.text = diceAttrMo:getDesc()
	self._txtD6AttributeLock.text = diceAttrMo:getDesc()

	self._equipHoleItemView:setData(diceAttrMo)
end

function M:getData()
	return self._data
end

function M:setRomeNum(index)
	for idx, item in ipairs(self._RomeNum) do
		goutil.setActive(item, idx == index)
	end
end

function M:setVisible(visible)
	self._mainGo:SetActive(visible)
end

function M:getButtonGo()
	if self._btnClick then
		return self._btnClick.gameObject
	end

	return false
end

function M:OnDestroy()
	self:_destroyUI()
end

function M:_destroyUI()
	self._equipHoleItemView = nil

	if self._btnClick then
		self._btnClick:RemoveClickListener()

		self._callback = nil
		self._btnClick = nil
	end
end

function M:cancleButton()
	if self._btnClick then
		self._btnClick:RemoveClickListener()

		self._callback = nil
		self._btnClick = nil
	end
end

function M:setCurrentGoVisible(visible)
	self._currentGo:SetActive(visible)
end

function M:setStatus(status)
	for i = 1, 6 do
		self._statusGo[i]:SetActive(false)
	end

	goutil.setActive(self._statusGo[status], true)
	self._equipHoleItemView:setStatus(status)
end

function M:_onClickBtnClick()
	if self._callback then
		self._callback()
	end
end

function M:setClickCallback(callback)
	self._callback = callback
end

return M
