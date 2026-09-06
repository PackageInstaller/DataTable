-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/bag/view/PetBondDetailView.lua

module("logic.extensions.bag.view.PetBondDetailView", package.seeall)

local PetBondDetailView = class("PetBondDetailView", ViewComponent)

function PetBondDetailView:ctor()
	PetBondDetailView.super.ctor(self)
end

function PetBondDetailView:buildUI()
	PetBondDetailView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._bondCell = self:getGo("bondcell")
	self._goContent = self:getGo("bondInfo/Viewport/Content")
	self._bondsOnForm = self:getGo("bondInfo/Viewport/Content/bondsOnForm")
	self._bondsCollect = self:getGo("bondInfo/Viewport/Content/bondsCollect")

	GameUtil.SetActive(self._bondCell, false)
end

function PetBondDetailView:bindEvents()
	PetBondDetailView.super.bindEvents(self)
	self._btnClose:AddClickListener(self.close, self)
end

function PetBondDetailView:unbindEvents()
	PetBondDetailView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
end

function PetBondDetailView:destroyUI()
	PetBondDetailView.super.destroyUI(self)
end

function PetBondDetailView:onEnter()
	PetBondDetailView.super.onEnter(self)

	self._raceId = self._viewPresentor:getFirstParam()

	self:_refresh()
end

function PetBondDetailView:onEnterFinished()
	PetBondDetailView.super.onEnterFinished(self)
end

function PetBondDetailView:onExit()
	PetBondDetailView.super.onExit(self)
end

function PetBondDetailView:onExitFinished()
	PetBondDetailView.super.onExitFinished(self)
end

function PetBondDetailView:_refresh()
	goutil.setActive(self._bondsOnForm, false)

	self._bondOnFormCells = self._bondOnFormCells or {}

	local cfgs = CharacterConfig.instance:getBondCfgsOnForm(self._raceId)

	if cfgs and #cfgs > 0 then
		for i = 1, #cfgs - #self._bondOnFormCells do
			table.insert(self._bondOnFormCells, goutil.cloneAndSetParent(self._bondCell, self._bondsOnForm.transform))
		end

		for i = 1, #self._bondOnFormCells do
			if i <= #cfgs then
				self:_setCell(self._bondOnFormCells[i], cfgs[i], true)
			else
				self:_destroyCell(self._bondOnFormCells[i])
			end
		end

		goutil.setActive(self._bondsOnForm, true)
	else
		for _, v in ipairs(self._bondOnFormCells) do
			self:_destroyCell(v)
		end
	end

	goutil.setActive(self._bondsCollect, false)

	self._bondCollectCells = self._bondCollectCells or {}

	local cfgs = CharacterConfig.instance:getBondCfgsCollect(self._raceId)

	if cfgs and #cfgs > 0 then
		for i = 1, #cfgs - #self._bondCollectCells do
			table.insert(self._bondCollectCells, goutil.cloneAndSetParent(self._bondCell, self._bondsCollect.transform))
		end

		for i = 1, #self._bondCollectCells do
			if i <= #cfgs then
				self:_setCell(self._bondCollectCells[i], cfgs[i], false)
			else
				self:_destroyCell(self._bondCollectCells[i])
			end
		end

		goutil.setActive(self._bondsCollect, true)
	else
		for _, v in ipairs(self._bondCollectCells) do
			self:_destroyCell(v)
		end
	end

	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self._goContent.gameObject.transform)
end

function PetBondDetailView:_setCell(cell, cfg, isOnForm)
	self:_clearCell(cell)

	if not cfg then
		return
	end

	local goTxt = goutil.findChild(cell, "txt")
	local txt = goTxt:GetComponent("Text")
	local txtDesc = goutil.findChildTextComponent(cell, "txtDesc")
	local txtDesGo = goutil.findChild(cell, "txtDesc")
	local txtName = goutil.findChildTextComponent(cell, "name/txt")
	local petCellList = {}
	local pet = {}

	pet.go = goutil.findChild(cell, "petListInBondExt/pet_" .. 1)
	pet.iconHead = goutil.findChild(pet.go, "iconHead/icon")
	pet.btn = goutil.findChild(pet.go, "bg")
	pet.bg = goutil.findChildComponent(pet.go, "bg", "UIImageSpriteChange")
	petCellList[1] = pet

	for i = 2, 4 do
		local pet = {}

		pet.go = goutil.findChild(cell, "petListInBondExt/other/pet_" .. i)
		pet.iconHead = goutil.findChild(pet.go, "iconHead/icon")
		pet.btn = goutil.findChild(pet.go, "bg")
		pet.bg = goutil.findChildComponent(pet.go, "bg", "UIImageSpriteChange")
		petCellList[i] = pet
	end

	local petlist = {}
	local petlistInCfg = cfg.relativeRaceIds

	table.insert(petlist, 1, self._raceId)

	for i = 1, #petlistInCfg do
		table.insert(petlist, petlistInCfg[i])
	end

	for i = 1, #petlist do
		local petCo = CharacterConfig.instance:getPetCo(petlist[i])
		local rare = CharacterConfig.instance:getRareByAwakenLv(petCo.initAwakenLv, petCo.raceId)
		local modelCo = CharacterConfig.instance:getModelCo(checknumber(petCo.faceIds))

		petCellList[i].bg:SetState(tonumber(rare + 1))
		uGuiUtil.setSpriteToImage(petCellList[i].iconHead, uGuiUtil.SpriteType.BigBg, GameUrl.getCharacterIconUrl(modelCo.headName))
		GameUtil.SetActive(petCellList[i].go, true)
		GameUtil.addClickHandler(petCellList[i].btn, GameUtil.handler(self._onClickPetCell, self, petlist[i]))
	end

	GameUtil.SetActive(cell, true)

	txtName.text = cfg.name

	local isActive = false

	if isOnForm then
		for i = 2, #petlist do
			if BagModel.instance:isExistRaceId(petlist[i]) then
				GameUtil.SetGray(petCellList[i].go, false)

				isActive = true
			else
				GameUtil.SetGray(petCellList[i].go, true)
			end
		end
	else
		for i = 2, #petlist do
			if HandbookModel.instance:isHasPet(petlist[i]) then
				GameUtil.SetGray(petCellList[i].go, false)

				isActive = true
			else
				GameUtil.SetGray(petCellList[i].go, true)
			end
		end
	end

	GameUtil.SetGray(txtDesGo, not isActive)

	txtDesc.text = cfg.desc

	if isOnForm then
		local awakenName = CharacterConfig.instance:getAwakenName(cfg.activeNeedAwakenLv)

		txt.text = langPara("handbookpetbasicview__tips", "<color=red>", awakenName, "</color>")

		GameUtil.SetActive(goTxt, true)
	end
end

function PetBondDetailView:_clearCell(cell)
	local petListInBond = goutil.findChild(cell, "petListInBondExt")
	local pet = goutil.findChild(petListInBond, "pet_" .. 1)

	uGuiUtil.clearImage(goutil.findChild(pet, "iconHead"))
	GameUtil.rmClickHandler(goutil.findChild(pet, "bg"))
	GameUtil.SetActive(pet, false)

	for i = 2, 4 do
		local pet = goutil.findChild(petListInBond, "other/pet_" .. i)

		uGuiUtil.clearImage(goutil.findChild(pet, "iconHead"))
		GameUtil.rmClickHandler(goutil.findChild(pet, "bg"))
		GameUtil.SetActive(pet, false)
	end

	local goTxt = goutil.findChild(cell, "txt")

	GameUtil.SetActive(goTxt, false)
end

function PetBondDetailView:_destroyCell(cell)
	self:_clearCell(cell)
	goutil.setActive(cell, false)
end

function PetBondDetailView:_onClickPetCell(raceId)
	self:close()
	PetbookController.instance:openPetinfoView(raceId)
end

return PetBondDetailView
