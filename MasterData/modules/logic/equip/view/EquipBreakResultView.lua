-- chunkname: @modules/logic/equip/view/EquipBreakResultView.lua

module("modules.logic.equip.view.EquipBreakResultView", package.seeall)

local EquipBreakResultView = class("EquipBreakResultView", BaseView)

function EquipBreakResultView:onInitView()
	self._simagebg = gohelper.findChildSingleImage(self.viewGO, "bg/#simage_bg")
	self._gobtns = gohelper.findChild(self.viewGO, "#go_btns")
	self._simageequip = gohelper.findChildSingleImage(self.viewGO, "center/#simage_equip")
	self._imagelock = gohelper.findChildImage(self.viewGO, "center/#image_lock")
	self._txtname = gohelper.findChildText(self.viewGO, "center/#txt_name")
	self._txtnum = gohelper.findChildText(self.viewGO, "center/#txt_num")
	self._gorighttop = gohelper.findChild(self.viewGO, "#go_righttop")
	self._image1 = gohelper.findChildImage(self.viewGO, "right/container/go_insigt/#image_1")
	self._image2 = gohelper.findChildImage(self.viewGO, "right/container/go_insigt/#image_2")
	self._image3 = gohelper.findChildImage(self.viewGO, "right/container/go_insigt/#image_3")
	self._image4 = gohelper.findChildImage(self.viewGO, "right/container/go_insigt/#image_4")
	self._image5 = gohelper.findChildImage(self.viewGO, "right/container/go_insigt/#image_5")
	self._gostrengthenattr = gohelper.findChild(self.viewGO, "right/container/#go_strengthenattr")
	self._gobreakattr = gohelper.findChild(self.viewGO, "right/container/#go_breakattr")
	self._txtmeshsuiteffect = gohelper.findChildTextMesh(self.viewGO, "right/suiteffect/#txtmesh_suiteffect")
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_close")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function EquipBreakResultView:addEvents()
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
end

function EquipBreakResultView:removeEvents()
	self._btnclose:RemoveClickListener()
end

function EquipBreakResultView:_btncloseOnClick()
	self:closeThis()
end

function EquipBreakResultView:_editableInitView()
	self._simagebg:LoadImage(ResUrl.getCommonViewBg("full/zhuangbei_006"))

	self._strengthenattrs = self:getUserDataTb_()
	self._attrIndex = 1
end

function EquipBreakResultView:onUpdateParam()
	return
end

function EquipBreakResultView:onOpen()
	self._equipMO = self.viewParam[1]
	self._prevLv = self.viewParam[2]
	self._prevBreakLv = self.viewParam[3]
	self._config = self._equipMO.config
	self._lock = self._equipMO.isLock

	local isExpEquip = self._config.isExpEquip == 1

	if isExpEquip then
		self._imagelock.gameObject:SetActive(false)
	else
		UISpriteSetMgr.instance:setEquipSprite(self._imagelock, self._lock and "bg_tips_suo" or "bg_tips_jiesuo", true)
	end

	for i = 1, 5 do
		UISpriteSetMgr.instance:setEquipSprite(self["_image" .. i], i <= self._equipMO.breakLv and "xx_11" or "xx_10")
	end

	self._simageequip:LoadImage(ResUrl.getEquipSuit(self._config.icon))

	self._txtname.text = self._config.name

	local hp1, atk1, def1, mdef1, upAttrs1 = EquipConfig.instance:getEquipStrengthenAttr(self._equipMO, nil, self._prevLv, self._prevBreakLv)
	local hp, atk, def, mdef, upAttrs = EquipConfig.instance:getEquipStrengthenAttr(self._equipMO, nil, self._equipMO.level, self._equipMO.breakLv)

	for id, config in pairs(lua_character_attribute.configDict) do
		if config.type == 2 or config.type == 3 then
			EquipController.instance.showAttr(self, id, config.showType, upAttrs[config.attrType], upAttrs1[config.attrType])
		end
	end

	self:showLevelInfo()
end

function EquipBreakResultView:showLevelInfo()
	gohelper.setActive(self._gobreakattr, true)

	local txtvalue = gohelper.findChildText(self._gobreakattr, "txt_value")
	local txtprevvalue = gohelper.findChildText(self._gobreakattr, "txt_prevvalue")

	txtvalue.text = EquipConfig.instance:getMaxLevel(self._equipMO.breakLv)
	txtprevvalue.text = EquipConfig.instance:getMaxLevel(self._prevBreakLv)
end

function EquipBreakResultView:onClose()
	return
end

function EquipBreakResultView:onDestroyView()
	self._simagebg:UnLoadImage()
	self._simageequip:UnLoadImage()
end

return EquipBreakResultView
