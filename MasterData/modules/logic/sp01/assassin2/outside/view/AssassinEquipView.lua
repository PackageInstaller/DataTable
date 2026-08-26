-- chunkname: @modules/logic/sp01/assassin2/outside/view/AssassinEquipView.lua

module("modules.logic.sp01.assassin2.outside.view.AssassinEquipView", package.seeall)

local AssassinEquipView = class("AssassinEquipView", BaseView)

function AssassinEquipView:onInitView()
	self._golayout = gohelper.findChild(self.viewGO, "root/#go_layout")
	self._goitem = gohelper.findChild(self.viewGO, "root/#go_layout/#go_item")
	self._btnconfirm = gohelper.findChildClickWithAudio(self.viewGO, "root/#btn_confirm", AudioEnum2_9.StealthGame.play_ui_cikeshang_normalclick)

	if self._editableInitView then
		self:_editableInitView()
	end
end

function AssassinEquipView:addEvents()
	self._btnconfirm:AddClickListener(self._btnconfirmOnClick, self)
end

function AssassinEquipView:removeEvents()
	self._btnconfirm:RemoveClickListener()

	if self._careerEquipItemList then
		for _, equipItem in ipairs(self._careerEquipItemList) do
			equipItem.btnunlockClick:RemoveClickListener()
			equipItem.btnlockedClick:RemoveClickListener()
		end
	end
end

function AssassinEquipView:_btnconfirmOnClick()
	if not self._curSelectedIndex then
		return
	end

	local careerEquipItem = self._careerEquipItemList[self._curSelectedIndex]

	AssassinController.instance:changeCareerEquip(self.assassinHeroId, careerEquipItem and careerEquipItem.id)
	self:closeThis()
end

function AssassinEquipView:_btnItemOnClick(index)
	if self._curSelectedIndex == index then
		return
	end

	local careerEquipItem = self._careerEquipItemList[index]
	local isUnlock = AssassinHeroModel.instance:isUnlockCareer(careerEquipItem and careerEquipItem.id)

	if not isUnlock then
		return
	end

	self._curSelectedIndex = index

	self:refreshSelectedEquipItem()
end

function AssassinEquipView:_btnItemLockOnClick(index)
	return
end

function AssassinEquipView:_editableInitView()
	return
end

function AssassinEquipView:onUpdateParam()
	self.assassinHeroId = self.viewParam.assassinHeroId
end

function AssassinEquipView:onOpen()
	self:onUpdateParam()
	self:setEquipItemList()

	local assassinCareerId = AssassinHeroModel.instance:getAssassinCareerId(self.assassinHeroId)

	for i, careerEquipItem in ipairs(self._careerEquipItemList) do
		if careerEquipItem.id == assassinCareerId then
			self:_btnItemOnClick(i)

			return
		end
	end
end

function AssassinEquipView:setEquipItemList()
	self._careerEquipItemList = {}

	local careerList = AssassinConfig.instance:getAssassinHeroCareerList(self.assassinHeroId)

	gohelper.CreateObjList(self, self._onCreateEquipItem, careerList, self._golayout, self._goitem)
end

function AssassinEquipView:_onCreateEquipItem(obj, data, index)
	local careerEquipItem = self:getUserDataTb_()

	careerEquipItem.go = obj
	careerEquipItem.id = data

	local gounlock = gohelper.findChild(careerEquipItem.go, "#go_unlock")

	careerEquipItem.unlockCanvasGroup = gounlock:GetComponent(typeof(UnityEngine.CanvasGroup))
	careerEquipItem.goselected = gohelper.findChild(careerEquipItem.go, "#go_unlock/#go_selected")
	careerEquipItem.txtcareer = gohelper.findChildText(careerEquipItem.go, "#go_unlock/career/#txt_career")
	careerEquipItem.txtname = gohelper.findChildText(careerEquipItem.go, "#go_unlock/#txt_name")
	careerEquipItem.simageicon = gohelper.findChildSingleImage(careerEquipItem.go, "#go_unlock/#simage_icon")
	careerEquipItem.goitemLayout = gohelper.findChild(careerEquipItem.go, "#go_unlock/#go_itemLayout")
	careerEquipItem.goitemGrid = gohelper.findChild(careerEquipItem.go, "#go_unlock/#go_itemLayout/#go_itemGrid")
	careerEquipItem.goattrLayout = gohelper.findChild(careerEquipItem.go, "#go_unlock/#go_attrLayout")
	careerEquipItem.goattrItem = gohelper.findChild(careerEquipItem.go, "#go_unlock/#go_attrLayout/#go_attrItem")
	careerEquipItem.txtdesc = gohelper.findChildText(careerEquipItem.go, "#go_unlock/#go_assassinSkill/ScrollView/Viewport/#txt_desc")
	careerEquipItem.btnunlockClick = gohelper.findChildClickWithAudio(careerEquipItem.go, "#go_unlock/#go_assassinSkill/ScrollView/#btn_click", AudioEnum2_9.StealthGame.play_ui_cikeshang_skillchoose)

	careerEquipItem.btnunlockClick:AddClickListener(self._btnItemOnClick, self, index)

	careerEquipItem.golocked = gohelper.findChild(careerEquipItem.go, "#go_locked")
	careerEquipItem.btnlockedClick = gohelper.findChildClickWithAudio(careerEquipItem.go, "#go_locked/#btn_click", AudioEnum2_9.StealthGame.play_ui_cikeshang_skillchoose)

	careerEquipItem.btnlockedClick:AddClickListener(self._btnItemLockOnClick, self, index)

	careerEquipItem.txtcareer.text = AssassinConfig.instance:getAssassinCareerTitle(careerEquipItem.id)
	careerEquipItem.txtname.text = AssassinConfig.instance:getAssassinCareerEquipName(careerEquipItem.id)

	local pic = AssassinConfig.instance:getAssassinCareerEquipPic(careerEquipItem.id)
	local picPath = ResUrl.getSp01AssassinSingleBg("weapon/" .. pic)

	careerEquipItem.simageicon:LoadImage(picPath)

	local skillId = AssassinConfig.instance:getAssassinSkillIdByHeroCareer(self.assassinHeroId, careerEquipItem.id)

	careerEquipItem.txtdesc.text = AssassinConfig.instance:getAssassinCareerSkillDesc(skillId)

	local bagCapacity = AssassinConfig.instance:getAssassinCareerCapacity(careerEquipItem.id)

	gohelper.CreateNumObjList(careerEquipItem.goitemLayout, careerEquipItem.goitemGrid, bagCapacity)

	local equipAttrList = AssassinConfig.instance:getAssassinCareerAttrList(careerEquipItem.id)

	gohelper.CreateObjList(self, self._onCreateCareerEquipAttrItem, equipAttrList, careerEquipItem.goattrLayout, careerEquipItem.goattrItem)

	local isUnlock = AssassinHeroModel.instance:isUnlockCareer(careerEquipItem.id)

	careerEquipItem.unlockCanvasGroup.alpha = isUnlock and 1 or 0.25

	gohelper.setActive(careerEquipItem.golocked, not isUnlock)
	gohelper.setActive(careerEquipItem.goselected, false)

	self._careerEquipItemList[index] = careerEquipItem
end

function AssassinEquipView:_onCreateCareerEquipAttrItem(obj, data, index)
	local attrIcon = gohelper.findChildImage(obj, "icon")
	local attrName = gohelper.findChildText(obj, "#txt_attrName")
	local attrValue = gohelper.findChildText(obj, "#txt_attrValue")
	local attrId = data[1]
	local attrCO = HeroConfig.instance:getHeroAttributeCO(attrId)

	CharacterController.instance:SetAttriIcon(attrIcon, attrId, GameUtil.parseColor("#675C58"))

	attrName.text = attrCO.name
	attrValue.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("add_percent_value"), (data[2] or 0) / 10)
end

function AssassinEquipView:refreshSelectedEquipItem()
	if self._careerEquipItemList then
		for index, careerEquipItem in ipairs(self._careerEquipItemList) do
			gohelper.setActive(careerEquipItem.goselected, self._curSelectedIndex == index)
		end
	end
end

function AssassinEquipView:onClose()
	return
end

function AssassinEquipView:onDestroyView()
	if self._careerEquipItemList then
		for _, equipItem in ipairs(self._careerEquipItemList) do
			equipItem.simageicon:UnLoadImage()
		end
	end
end

return AssassinEquipView
