-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/recommendfmt/view/PetSkillAdjustView.lua

module("logic.extensions.recommendfmt.view.PetSkillAdjustView", package.seeall)

local PetSkillAdjustView = class("PetSkillAdjustView", TableViewComponent)

function PetSkillAdjustView:ctor()
	PetSkillAdjustView.super.ctor(self)
end

function PetSkillAdjustView:unbindEvents()
	PetSkillAdjustView.super.unbindEvents(self)
end

function PetSkillAdjustView:bindEvents()
	PetSkillAdjustView.super.bindEvents(self)
end

function PetSkillAdjustView:buildUI()
	PetSkillAdjustView.super.buildUI(self)

	self._tableCell2 = self:getGo("new/skillCell")

	goutil.setActive(self._tableCell2, false)

	self._scrollrect = self:getGo("new/tableview"):GetComponent("ScrollRect")
end

function PetSkillAdjustView:_getPath()
	return {
		cellPath = "new/infoCell",
		viewPath = "new/tableview"
	}
end

function PetSkillAdjustView:onExit()
	PetSkillAdjustView.super.onExit(self)
end

function PetSkillAdjustView:onEnter()
	PetSkillAdjustView.super.onEnter(self)

	self._isOpen = false
	self._moveIndex = 1

	self:_initPetList()
	self:_updatePetList(1, true)
end

function PetSkillAdjustView:_initPetList()
	local dic = PetNoticeConfig.instance:getSkillCfgsOnPetId()

	self._saveList = {}

	for k, v in pairs(dic) do
		local element = {}

		element.skinId = k
		element.skillList = v

		table.insert(self._saveList, element)
	end
end

function PetSkillAdjustView:_updatePetList(petIndex, isOpen)
	local list = {}
	local count = 1
	local moveIndex = 1

	for i, v in ipairs(self._saveList) do
		local petElement = {}

		petElement.cellTypeId = 0
		petElement.skinId = v.skinId
		petElement.isOpen = i == petIndex and isOpen
		petElement.index = i

		table.insert(list, petElement)

		count = count + 1

		if petElement.isOpen then
			moveIndex = count

			local skillElement = {}

			skillElement.cellTypeId = 1
			skillElement.skillList = v.skillList

			table.insert(list, skillElement)

			count = count + 1
		end
	end

	self._isOpen = isOpen
	self._moveIndex = moveIndex

	self:updateListData(list)
end

function PetSkillAdjustView:_cellSize(view, idx)
	local data = self._curViewDatas[idx + 1]

	if data.cellTypeId == 0 then
		return 332, 562
	else
		return 618, 560
	end
end

function PetSkillAdjustView:_cellAtIndex(view, idx)
	local cell
	local data = self._curViewDatas[idx + 1]
	local cell = data.cellTypeId == 1 and (view:DequeueCellByTag(data.cellTypeId) or view:AddChild(self._tableCell2, data.cellTypeId)) or view:DequeueCellByTag(data.cellTypeId) or view:AddChild(self._tableCell, data.cellTypeId)

	self:initCell(cell)

	cell.data = idx + 1
	cell.index = idx

	self:_updateCell(view, cell, data)

	return cell
end

function PetSkillAdjustView:_updateCell(view, cell, data)
	if data.cellTypeId == 0 then
		self:_updatePetCell(view, cell, data)
	else
		self:_updateSkillCell(view, cell, data)
	end
end

function PetSkillAdjustView:_clearTableview(cell)
	if cell.tag == 0 then
		GameUtil.rmClickHandler(goutil.findChild(cell, "imgBook"))

		local btnArrow = Framework.ButtonAdapter.GetFrom(cell.gameObject, "btnArrow")

		btnArrow:RemoveClickListener()
	else
		local cls = GameUtil.GetLua(cell.gameObject, PetSkillAdjustCell)

		if cls then
			cls:reset()
		end
	end
end

function PetSkillAdjustView:_onReloadFinish()
	if self._isOpen and #self._saveList > 0 then
		self:moveCellToCenter(self._moveIndex, -100)
	end
end

function PetSkillAdjustView:_updatePetCell(view, cell, data)
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
		self:_updatePetList(data.index, not data.isOpen)
	end)

	if data.isOpen then
		Framework.TransformUtil.SetLocalRotation(btnArrowRect, 0, 0, 180)
	else
		Framework.TransformUtil.SetLocalRotation(btnArrowRect, 0, 0, 0)
	end
end

function PetSkillAdjustView:_updateSkillCell(view, cell, data)
	local tableview = goutil.findChild(cell, "tableview")
	local drag = Framework.UIDragTrigger.Get(tableview)

	drag:AddDragListener(self._onDrag, self)
	drag:AddBeginDragListener(self._onBeginDrag, self)
	drag:AddEndDragListener(self._onEndDrag, self)

	local cls = GameUtil.AddLuaOnce(cell.gameObject, PetSkillAdjustCell)

	cls:init(data.skillList)
end

function PetSkillAdjustView:_onDrag(eventData)
	if self._tableview then
		self._scrollrect:OnDrag(eventData)
	end
end

function PetSkillAdjustView:_onBeginDrag(eventData)
	if self._tableview then
		self._scrollrect:OnBeginDrag(eventData)
	end
end

function PetSkillAdjustView:_onEndDrag(eventData)
	if self._tableview then
		self._scrollrect:OnEndDrag(eventData)
	end
end

return PetSkillAdjustView
