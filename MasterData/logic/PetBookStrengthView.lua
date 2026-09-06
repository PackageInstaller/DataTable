-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/handbook/view/PetBookStrengthView.lua

module("logic.extensions.handbook.view.PetBookStrengthView", package.seeall)

local PetBookStrengthView = class("PetBookStrengthView", ViewComponent)

function PetBookStrengthView:ctor()
	PetBookStrengthView.super.ctor(self)
end

function PetBookStrengthView:unbindEvents()
	PetBookStrengthView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
end

function PetBookStrengthView:bindEvents()
	PetBookStrengthView.super.bindEvents(self)
	self._btnClose:AddClickListener(function()
		self:close()
	end, self)
end

function PetBookStrengthView:buildUI()
	PetBookStrengthView.super.buildUI(self)

	self._petTab = self:getGo("petList/tableview")
	self._petCell = self:getGo("petList/cell")
	self._empty = self:getGo("petList/empty")
	self._btnClose = self:getBtn("btnClose")
	self._petUpList = ScrollerList.create(self._petTab, self._petCell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearItemCell, self))
end

function PetBookStrengthView:onEnter()
	PetBookStrengthView.super.onEnter(self)

	local list = self:getFirstParam()

	self._listTab = {}

	goutil.setActive(self._empty, #list <= 0)
	self._petUpList:reloadData(list)
end

function PetBookStrengthView:onExit()
	PetBookStrengthView.super.onExit(self)
	self._petUpList:dispose()
end

function PetBookStrengthView:_updateCell(view, cell, data)
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

	local content = ""
	local startLvStr = ""

	startLvStr = startLevel >= 0 and (startLevel == 0 and "已激活" or CharacterConfig.instance:getAwakenRareCfg(startLevel).upDesc) or "未激活"
	content = checknumber(attLevel) == 0 and "已激活" or CharacterConfig.instance:getAwakenRareCfg(attLevel).upDesc

	local strList = HandbookController.instance:getcalculateSumAttrTextByRaceId(data.raceId, startLevel)
	local petList = {}

	petList.name = "当前图鉴强化"
	petList.startProperty = startLvStr
	petList.property = content

	table.insert(strList, petList)
	self._listTab[cell]:reloadData(strList)

	txtName.text = petCo.name

	MaterialMgr.resetAll(petIcon)

	local proxy = MaterialMgr.setCell(MatType.Pet, data.raceId, petIcon)

	proxy:setAutoTips(false)
end

function PetBookStrengthView:_clearItemCell(cell)
	local petIcon = goutil.findChild(cell, "item")

	MaterialMgr.resetAll(petIcon)
end

function PetBookStrengthView:_updatePetCell(view, cell, data)
	local bg = goutil.findChild(cell, "bg"):GetComponent(ComponentType.UIImageColorChange)
	local txtName = goutil.findChildTextComponent(cell, "txtName")
	local txtNow = goutil.findChildTextComponent(cell, "txtNow")
	local txtNext = goutil.findChildTextComponent(cell, "txtNext")

	txtName.text = data.name
	txtNow.text = data.startProperty
	txtNext.text = data.property

	bg:SetState(checknumber(cell.index) % 2)
end

function PetBookStrengthView:_clearPetCell(cell)
	return
end

return PetBookStrengthView
