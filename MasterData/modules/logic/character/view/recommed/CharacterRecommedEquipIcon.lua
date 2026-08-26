-- chunkname: @modules/logic/character/view/recommed/CharacterRecommedEquipIcon.lua

module("modules.logic.character.view.recommed.CharacterRecommedEquipIcon", package.seeall)

local CharacterRecommedEquipIcon = class("CharacterRecommedEquipIcon", ListScrollCell)

function CharacterRecommedEquipIcon:onInitView()
	self._imagerare2 = gohelper.findChildImage(self.viewGO, "#image_rare2")
	self._simageicon = gohelper.findChildSingleImage(self.viewGO, "#simage_icon")
	self._imagerare = gohelper.findChildImage(self.viewGO, "#image_rare")

	local clickarea = gohelper.findChild(self.viewGO, "clickarea")

	self._btnclick = SLFramework.UGUI.UIClickListener.Get(clickarea)

	if self._editableInitView then
		self:_editableInitView()
	end
end

function CharacterRecommedEquipIcon:addEventListeners()
	self._btnclick:AddClickListener(self._btnclickOnClick, self)
end

function CharacterRecommedEquipIcon:removeEventListeners()
	self._btnclick:RemoveClickListener()
end

function CharacterRecommedEquipIcon:_btnclickOnClick()
	if self._clickCB and self._clickCBobj then
		self._clickCB(self._clickCBobj)
	end
end

function CharacterRecommedEquipIcon:init(go)
	self.viewGO = go

	self:onInitView()
end

function CharacterRecommedEquipIcon:_editableInitView()
	return
end

function CharacterRecommedEquipIcon:onUpdateMO(mo)
	self._equipId = mo

	local co = EquipConfig.instance:getEquipCo(self._equipId)

	UISpriteSetMgr.instance:setCommonSprite(self._imagerare, "equipbar" .. EquipConfig.instance:getRareColor(co.rare))
	UISpriteSetMgr.instance:setCommonSprite(self._imagerare2, "bgequip" .. tostring(ItemEnum.Color[co.rare]))
	self._simageicon:LoadImage(ResUrl.getEquipIcon(co.icon))
	ZProj.UGUIHelper.SetGrayscale(self._simageicon.gameObject, not EquipModel.instance:haveEquip(self._equipId))
end

function CharacterRecommedEquipIcon:setClickCallback(cb, cbobj)
	self._clickCB = cb
	self._clickCBobj = cbobj
end

function CharacterRecommedEquipIcon:onSelect(isSelect)
	return
end

function CharacterRecommedEquipIcon:onDestroy()
	self._simageicon:UnLoadImage()
end

return CharacterRecommedEquipIcon
