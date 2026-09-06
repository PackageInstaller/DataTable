-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/bag/view/PetAwakeStrengthView.lua

module("logic.extensions.bag.view.PetAwakeStrengthView", package.seeall)

local PetAwakeStrengthView = class("PetAwakeStrengthView", ViewComponent)

function PetAwakeStrengthView:ctor()
	PetAwakeStrengthView.super.ctor(self)
end

function PetAwakeStrengthView:unbindEvents()
	PetAwakeStrengthView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
end

function PetAwakeStrengthView:bindEvents()
	PetAwakeStrengthView.super.bindEvents(self)
	self._btnClose:AddClickListener(function()
		self:close()
	end, self)
end

function PetAwakeStrengthView:buildUI()
	PetAwakeStrengthView.super.buildUI(self)

	self._petTab = self:getGo("petList/tableview")
	self._petCell = self:getGo("petList/cell")
	self._empty = self:getGo("petList/empty")
	self._btnClose = self:getBtn("btnClose")
	self._petUpList = ScrollerList.create(self._petTab, self._petCell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearItemCell, self))
end

function PetAwakeStrengthView:onEnter()
	PetAwakeStrengthView.super.onEnter(self)

	local list = self:getFirstParam()

	self._listTab = {}

	goutil.setActive(self._empty, #list <= 0)
	self._petUpList:reloadData(list)
end

function PetAwakeStrengthView:onExit()
	PetAwakeStrengthView.super.onExit(self)
	self._petUpList:dispose()
end

function PetAwakeStrengthView:_updateCell(view, cell, data)
	local petIcon = goutil.findChild(cell, "item")
	local list = goutil.findChild(cell, "list")
	local listCell = goutil.findChild(cell, "listCell")
	local txtName = goutil.findChildTextComponent(cell, "txtName")
	local txtAttr = goutil.findChildTextComponent(cell, "txtAttr")
	local txtWakeLv = goutil.findChildTextComponent(cell, "txtWakeLv")
	local petCo = CharacterConfig.instance:getPetCo(data.raceId)
	local attLevel = HandbookModel.instance:getAttributeLevel(data.raceId)
	local startLevel = checknumber(data.startLv)

	self._listTab[cell] = self._listTab[cell] or ScrollerList.create(list, listCell, GameUtil.handler(self._updatePetCell, self), GameUtil.handler(self._clearPetCell, self))

	local mo = BagModel.instance:getPet(data.petId)
	local strList = {}
	local tem = {}

	tem.name = "战斗力"
	tem.startProperty = data:getFightingPower()
	tem.property = "--"

	if mo then
		tem.property = mo:getFightingPower()
	end

	table.insert(strList, tem)

	local tem = {}

	tem.name = "觉醒等级"
	tem.startProperty = awakenLv == 0 and "未觉醒" or "觉醒" .. GameUtil.toRomanNumber(data.awakeLevel)
	tem.property = "--"

	if mo then
		tem.property = "觉醒" .. GameUtil.toRomanNumber(mo.awakeLevel)
	end

	table.insert(strList, tem)
	self._listTab[cell]:reloadData(strList)

	txtName.text = petCo.name

	MaterialMgr.resetAll(petIcon)

	local proxy = MaterialMgr.setCell(MatType.Pet, data.raceId, petIcon)

	proxy:setAutoTips(false)
end

function PetAwakeStrengthView:_clearItemCell(cell)
	local petIcon = goutil.findChild(cell, "item")

	MaterialMgr.resetAll(petIcon)

	if self._listTab[cell] then
		self._listTab[cell]:dispose()
	end
end

function PetAwakeStrengthView:_updatePetCell(view, cell, data)
	local bg = goutil.findChild(cell, "bg"):GetComponent(ComponentType.UIImageColorChange)
	local txtName = goutil.findChildTextComponent(cell, "txtName")
	local txtNow = goutil.findChildTextComponent(cell, "txtNow")
	local txtNext = goutil.findChildTextComponent(cell, "txtNext")

	txtName.text = data.name
	txtNow.text = data.startProperty
	txtNext.text = data.property

	bg:SetState(checknumber(cell.index) % 2)
end

function PetAwakeStrengthView:_clearPetCell(cell)
	return
end

return PetAwakeStrengthView
