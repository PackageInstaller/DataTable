-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/petskin/view/PetSkinEnterEffectSetView.lua

module("logic.extensions.petskin.view.PetSkinEnterEffectSetView", package.seeall)

local PetSkinEnterEffectSetView = class("PetSkinEnterEffectSetView", ViewComponent)

function PetSkinEnterEffectSetView:ctor()
	PetSkinEnterEffectSetView.super.ctor(self)
end

function PetSkinEnterEffectSetView:unbindEvents()
	PetSkinEnterEffectSetView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function PetSkinEnterEffectSetView:bindEvents()
	PetSkinEnterEffectSetView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
end

function PetSkinEnterEffectSetView:buildUI()
	PetSkinEnterEffectSetView.super.buildUI(self)

	self._tableview = self:getGo("tableview")
	self._cell = self:getGo("cell")
	self._tableList = ScrollerList.create(self._tableview, self._cell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._btnClose = self:getGo("btnClose")
end

function PetSkinEnterEffectSetView:onExit()
	PetSkinEnterEffectSetView.super.onExit(self)
end

function PetSkinEnterEffectSetView:onEnter()
	PetSkinEnterEffectSetView.super.onEnter(self)

	self._showList = self:getFirstParam()

	self:_refreshView()
end

function PetSkinEnterEffectSetView:_refreshView()
	self._tableList:reloadData(self._showList)
end

function PetSkinEnterEffectSetView:_updateCell(view, cell, data, tag)
	local go = cell.gameObject
	local txtName = goutil.findChildTextComponent(go, "txtName")
	local petCon = goutil.findChild(go, "mask/con")
	local btnSelect = goutil.findChild(go, "contract/btnSet")
	local selectGo = goutil.findChild(btnSelect, "select")

	txtName.text = data.skinName

	local modelCo = CharacterConfig.instance:getModelCo(checknumber(data.skinId))

	uGuiUtil.setSpriteToImage(petCon, uGuiUtil.SpriteType.BigBg, GameUrl.getPetImgUrl(modelCo.cardName))
	GameUtil.SetActive(selectGo, not PetskinModel.instance:getUnEnableEnterEffect(data.skinId))
	GameUtil.rmClickHandler(btnSelect)
	GameUtil.addClickHandler(btnSelect, function()
		self:_onClickSet(data.skinId)
	end)
end

function PetSkinEnterEffectSetView:_clearCell(cell)
	local go = cell.gameObject
	local btnSelect = goutil.findChild(go, "contract/btnSet")
	local petCon = goutil.findChild(go, "mask/con")

	uGuiUtil.clearImage(petCon)
	GameUtil.rmClickHandler(btnSelect)
end

function PetSkinEnterEffectSetView:_onClickSet(skinId)
	local curStatus = PetskinModel.instance:getUnEnableEnterEffect(skinId)

	PetskinModel.instance:setUnEnableEnterEffect(skinId, not curStatus)
	self:_refreshView()
end

return PetSkinEnterEffectSetView
