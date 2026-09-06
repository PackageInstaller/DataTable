-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/recommendfmt/view/PetArtifactAwakenView.lua

module("logic.extensions.recommendfmt.view.PetArtifactAwakenView", package.seeall)

local PetArtifactAwakenView = class("PetArtifactAwakenView", TableViewComponent)

function PetArtifactAwakenView:ctor()
	PetArtifactAwakenView.super.ctor(self)
end

function PetArtifactAwakenView:buildUI()
	PetArtifactAwakenView.super.buildUI(self)

	self._tableCell2 = self:getGo("awakenCell")

	goutil.setActive(self._tableCell2, false)

	self._scrollrect = self:getGo("tableview"):GetComponent("ScrollRect")
end

function PetArtifactAwakenView:bindEvents()
	PetArtifactAwakenView.super.bindEvents(self)
end

function PetArtifactAwakenView:unbindEvents()
	PetArtifactAwakenView.super.unbindEvents(self)
end

function PetArtifactAwakenView:onEnter()
	PetArtifactAwakenView.super.onEnter(self)

	self._isOpen = false
	self._moveIndex = 1

	self:_initPetList()
	self:_updatePetList(1, true)
end

function PetArtifactAwakenView:onExit()
	PetArtifactAwakenView.super.onExit(self)
end

function PetArtifactAwakenView:_getPath()
	return {
		cellPath = "infoCell",
		viewPath = "tableview"
	}
end

function PetArtifactAwakenView:_initPetList()
	local cfgs = PetNoticeConfig.instance:getArtifactAwakenCfgs()

	self._saveList = {}

	for i, v in ipairs(cfgs) do
		local petElement = {}

		petElement.cellTypeId = 0
		petElement.skinId = v.skinId
		petElement.petIndex = i
		petElement.isOpen = false

		table.insert(self._saveList, petElement)

		local equipElement = {}

		equipElement.cellTypeId = 1

		local count = #v.equID
		local equipList = {}

		for i = 1, count do
			local item = {}

			item.oldEquipId = v.equID[i]
			item.newEquipId = v.newequID[i]

			table.insert(equipList, item)
		end

		equipElement.cfg = v
		equipElement.equipList = equipList
		equipElement.parentElement = petElement

		table.insert(self._saveList, equipElement)
	end
end

function PetArtifactAwakenView:_updatePetList(petIndex, isOpen)
	local list = {}
	local count = 1
	local moveIndex = 1

	for i, v in ipairs(self._saveList) do
		if v.cellTypeId == 0 then
			v.isOpen = v.petIndex == petIndex and isOpen

			table.insert(list, v)

			count = count + 1
		elseif v.parentElement.isOpen then
			moveIndex = count
			count = count + 1

			table.insert(list, v)
		end
	end

	self._isOpen = isOpen
	self._moveIndex = moveIndex

	self:updateListData(list)
end

function PetArtifactAwakenView:_cellSize(view, idx)
	local data = self._curViewDatas[idx + 1]

	if data.cellTypeId == 0 then
		return 332, 562
	else
		return 714, 560
	end
end

function PetArtifactAwakenView:_cellAtIndex(view, idx)
	local cell
	local data = self._curViewDatas[idx + 1]
	local cell = data.cellTypeId == 1 and (view:DequeueCellByTag(data.cellTypeId) or view:AddChild(self._tableCell2, data.cellTypeId)) or view:DequeueCellByTag(data.cellTypeId) or view:AddChild(self._tableCell, data.cellTypeId)

	self:initCell(cell)

	cell.data = idx + 1
	cell.index = idx

	self:_updateCell(view, cell, data)

	return cell
end

function PetArtifactAwakenView:_updateCell(view, cell, data)
	if data.cellTypeId == 0 then
		self:_updatePetCell(view, cell, data)
	else
		self:_updateSkillCell(view, cell, data)
	end
end

function PetArtifactAwakenView:_clearTableview(cell)
	printInfo("test _clearTableview", cell.tag)

	if cell.tag == 0 then
		GameUtil.rmClickHandler(goutil.findChild(cell, "imgBook"))
	else
		local cls = GameUtil.GetLua(cell.gameObject, PetArtifactAwakenCell)

		if cls then
			cls:reset()
		end
	end
end

function PetArtifactAwakenView:_onReloadFinish()
	if self._isOpen and self._moveIndex <= #self._curViewDatas then
		self:moveCellToCenter(self._moveIndex, -140)
	end
end

function PetArtifactAwakenView:_updatePetCell(view, cell, data)
	local infoPet = PetSkinConfig.instance:getPetSkinCfg(data.skinId)
	local race = PetSkinConfig.instance:getFisrtEleAttrIdx(data.skinId) % 10 - 1
	local rare = CharacterConfig.instance:getInitRare(infoPet.raceId)
	local rareSkin = PetSkinConfig.instance:getPetSkinCfg(data.skinId).quality
	local ModelCo = CharacterConfig.instance:getModelCo(checknumber(data.skinId))
	local imgPath = GameUrl.getPetImgUrl(ModelCo.cardName)
	local downTxt = PetStrategyConfig.instance:getStrategyById(infoPet.raceId).resume

	goutil.findChildTextComponent(cell, "namebg/txt").text = infoPet.skinName
	goutil.findChildTextComponent(cell, "imgDown/txt").text = downTxt

	local attrIcon = goutil.findChildComponent(cell, "layout/Nego_Attr/Img_attr", "UIImageSpriteChange")

	attrIcon:SetState(race)

	local imageObj = goutil.findChild(cell, "mask/con")

	uGuiUtil.setSpriteToImage(imageObj, uGuiUtil.SpriteType.BigBg, imgPath)

	local btnBook = goutil.findChild(cell, "imgBook")
	local attrObj = goutil.findChild(cell, "layout/Nego_Attr")
	local btnArrow = Framework.ButtonAdapter.GetFrom(cell.gameObject, "btnArrow")
	local btnArrowRect = btnArrow.gameObject:GetComponent(goutil.Type_RectTransform)

	GameUtil.getUIImageSpriteChange(goutil.findChild(cell, "bg")):SetState(rare)
	GameUtil.getUIImageSpriteChange(attrObj):SetState(rare)
	GameUtil.getUIImageSpriteChange(goutil.findChild(cell, "layout/Nego_Skin/skin")):SetState(rareSkin)
	GameUtil.asBtn(btnBook):AddClickListener(function()
		PetbookController.instance:openPetinfoView(infoPet.raceId)
	end, self)
	btnArrow:AddClickListener(function()
		self:_updatePetList(data.petIndex, not data.isOpen)
	end)

	if data.isOpen then
		Framework.TransformUtil.SetLocalRotation(btnArrowRect, 0, 0, 180)
	else
		Framework.TransformUtil.SetLocalRotation(btnArrowRect, 0, 0, 0)
	end
end

function PetArtifactAwakenView:_updateSkillCell(view, cell, data)
	local tableview = goutil.findChild(cell, "artifact/tableview")
	local drag = Framework.UIDragTrigger.Get(tableview)

	drag:AddDragListener(self._onDrag, self)
	drag:AddBeginDragListener(self._onBeginDrag, self)
	drag:AddEndDragListener(self._onEndDrag, self)

	local cls = GameUtil.AddLuaOnce(cell.gameObject, PetArtifactAwakenCell)

	cls:init(data)
end

function PetArtifactAwakenView:_onDrag(eventData)
	if self._tableview then
		self._scrollrect:OnDrag(eventData)
	end
end

function PetArtifactAwakenView:_onBeginDrag(eventData)
	if self._tableview then
		self._scrollrect:OnBeginDrag(eventData)
	end
end

function PetArtifactAwakenView:_onEndDrag(eventData)
	if self._tableview then
		self._scrollrect:OnEndDrag(eventData)
	end
end

return PetArtifactAwakenView
