-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/zoo/view/ZooPlaceItem.lua

module("logic.extensions.zoo.view.ZooPlaceItem", package.seeall)

local ZooPlaceItem = class("ZooPlaceItem")

function ZooPlaceItem:ctor(go)
	self.mainGO = go.gameObject

	self:buildUI()
end

function ZooPlaceItem:buildUI()
	self._activeCon = goutil.findChild(self.mainGO, "activeCon")
	self._changeBtn = Framework.ButtonAdapter.GetFrom(self._activeCon, "changeBtn")
	self._emptyCon = goutil.findChild(self.mainGO, "emptyCon")
	self._lockCon = goutil.findChild(self.mainGO, "lockCon")
	self._icon = goutil.findChild(self._activeCon, "icon")
	self._nameText = goutil.findChildTextComponent(self._activeCon, "nameText")
	self._bgBtn = GameUtil.asBtn(goutil.findChild(self.mainGO, "emptyCon/btnAdd"))
	self._itemCon = goutil.findChild(self._activeCon, "ScrollView")
	self._itemCell = goutil.findChild(self._activeCon, "cell")
	self._scrollList = ScrollerList.create(self._itemCon, self._itemCell, GameUtil.handler(self._updateCell, self))
end

function ZooPlaceItem:onEnter(index, animalModel)
	self.index = index
	self._replaceAnimalId = nil
	self._isDirty = false

	self._changeBtn:AddClickListener(self._onClickChange, self)
	self._bgBtn:AddClickListener(self._onClickGo, self)

	if animalModel then
		self:setData(animalModel)
	else
		self:clearData()
	end

	GlobalDispatcher:addListener(GlobalNotify.OnZooSetAnimalInZoo, self._addPlaceAnimal, self)
	GlobalDispatcher:addListener(GlobalNotify.OnZooCancelAnimalInZoo, self._calcelPlaceAnimal, self)
end

function ZooPlaceItem:onExit()
	GlobalDispatcher:removeListener(GlobalNotify.OnZooSetAnimalInZoo, self._addPlaceAnimal, self)
	GlobalDispatcher:removeListener(GlobalNotify.OnZooCancelAnimalInZoo, self._calcelPlaceAnimal, self)
	self._changeBtn:RemoveClickListener()
	self._bgBtn:RemoveClickListener()
	self:clearData()
	self._scrollList:dispose()
end

function ZooPlaceItem:_addPlaceAnimal(id)
	if not self._isDirty then
		return
	end

	self._replaceAnimalId = nil
	self._isDirty = false

	local myZoo = ZooModel.instance:getMyZoo()

	self:setData(myZoo:getAnimalById(id))
end

function ZooPlaceItem:_calcelPlaceAnimal(id)
	if not self._isDirty then
		return
	end

	self:clearData(false)

	if not self._replaceAnimalId then
		self._isDirty = false
	end
end

function ZooPlaceItem:setData(animalModel)
	self._animalModel = animalModel

	goutil.setActive(self._emptyCon, false)

	self._nameText.text = animalModel.name

	goutil.setActive(self._activeCon, true)

	if self._show == nil then
		self._show, self._avatar = animalModel:showAnimalAvatar(self._icon, 256, 256, 0.64, 0.6, AvatarUseType.Scene)
	else
		local avatarMo = self._avatar:getNewUseMo()

		avatarMo:setDataByAnimalMo(animalModel)
		self._avatar:updateByMo(avatarMo)
	end
end

function ZooPlaceItem:clearData(clearStatus)
	if clearStatus == nil then
		clearStatus = true
	end

	self._animalModel = nil

	goutil.setActive(self._emptyCon, true)
	goutil.setActive(self._activeCon, false)

	if self._show then
		self._avatar:destroy()

		self._avatar = nil

		self._show:clear()

		self._show = nil
	end

	if clearStatus then
		self._replaceAnimalId = nil
		self._isDirty = false
	end
end

function ZooPlaceItem:getAnimalId()
	if self._animalModel then
		return self._animalModel.id
	end

	return 0
end

function ZooPlaceItem:_onClickGo()
	self._replaceAnimalId = nil
	self._isDirty = false

	local myZoo = ZooModel.instance:getMyZoo()

	if self._lock then
		local mainBuilding = myZoo:getMainBuilding()

		FloatWordMgr.instance:show(string.format(lang("petzoo_place_petsnum_max"), mainBuilding:getBuildingName()))

		return
	end

	local function selectCallBack(selectIds)
		self._isDirty = true

		ZooController.instance:setAnimalInZoo(selectIds[1], true)
	end

	ZooController.instance:openSelectView(ZooController.ANIMALTYPE, selectCallBack, myZoo:getCanPlaceAnimalList(), nil, nil, lang("petzoo_place_placed"))
end

function ZooPlaceItem:_onClickChange()
	self._isDirty = false
	self._replaceAnimalId = nil

	local function selectCallBack(selectIds)
		self._isDirty = true
		self._replaceAnimalId = selectIds[1]

		ZooController.instance:replaceAnimalInZoo(self._replaceAnimalId, self:getAnimalId())
	end

	local myZoo = ZooModel.instance:getMyZoo()

	ZooController.instance:openSelectView(ZooController.ANIMALTYPE, selectCallBack, myZoo:getCanPlaceAnimalList(), nil, nil, lang("petzoo_place_placed"))
end

function ZooPlaceItem:setLock(flag)
	self._lock = flag

	goutil.setActive(self._lockCon, flag)
end

function ZooPlaceItem:_updateCell(view, cell, data)
	local spriteChange = goutil.findChildComponent(cell.gameObject, "icon", ComponentType.UIImageSpriteChange)

	if data.part then
		spriteChange:SetState(data.part - 1)
	else
		spriteChange:SetState(8)
	end
end

return ZooPlaceItem
