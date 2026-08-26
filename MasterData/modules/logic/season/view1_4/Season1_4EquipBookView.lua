-- chunkname: @modules/logic/season/view1_4/Season1_4EquipBookView.lua

module("modules.logic.season.view1_4.Season1_4EquipBookView", package.seeall)

local Season1_4EquipBookView = class("Season1_4EquipBookView", BaseView)

function Season1_4EquipBookView:onInitView()
	self._gobtns = gohelper.findChild(self.viewGO, "#go_btns")
	self._simagebg1 = gohelper.findChildSingleImage(self.viewGO, "bg/#simage_bg1")
	self._gotarget = gohelper.findChild(self.viewGO, "left/#go_target")
	self._gotargetcardpos = gohelper.findChild(self.viewGO, "left/#go_target/#go_ctrl/#go_targetcardpos")
	self._gotouch = gohelper.findChild(self.viewGO, "left/#go_target/#go_touch")
	self._txtcardname = gohelper.findChildText(self.viewGO, "left/#go_target/#txt_cardname")
	self._txteffectdesc = gohelper.findChildText(self.viewGO, "left/#go_target/Scroll View/Viewport/Content/#txt_effectdesc")
	self._scrollcardlist = gohelper.findChildScrollRect(self.viewGO, "right/mask/#scroll_cardlist")
	self._btnexchange = gohelper.findChildButtonWithAudio(self.viewGO, "right/#btn_exchange")
	self._goattributeitem = gohelper.findChild(self.viewGO, "left/#go_target/Scroll View/Viewport/Content/attrlist/#go_attributeitem")
	self._goskilldescitem = gohelper.findChild(self.viewGO, "left/#go_target/Scroll View/Viewport/Content/skilldesc/#go_skilldescitem")
	self._gocarditem = gohelper.findChild(self.viewGO, "left/#go_target/#go_ctrl/#go_targetcardpos/#go_carditem")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Season1_4EquipBookView:addEvents()
	self._btnexchange:AddClickListener(self._btnexchangeOnClick, self)
end

function Season1_4EquipBookView:removeEvents()
	self._btnexchange:RemoveClickListener()
end

function Season1_4EquipBookView:_btnexchangeOnClick()
	local actId = Activity104Model.instance:getCurSeasonId()

	ViewMgr.instance:openView(ViewName.Season1_4EquipComposeView, {
		actId = actId
	})
end

function Season1_4EquipBookView:_editableInitView()
	self._simagebg1:LoadImage(ResUrl.getSeasonIcon("full/hechengye_bj.jpg"))

	self._goDesc = gohelper.findChild(self.viewGO, "left/#go_target/Scroll View")
	self._goAttrParent = gohelper.findChild(self.viewGO, "left/#go_target/Scroll View/Viewport/Content/attrlist")
	self._animatorCard = self._gotargetcardpos:GetComponent(typeof(UnityEngine.Animator))
	self._animCardEventWrap = self._animatorCard:GetComponent(typeof(ZProj.AnimationEventWrap))

	self._animCardEventWrap:AddEventListener("switch", self.onSwitchCardAnim, self)

	self._propItems = {}
	self._skillItems = {}
end

function Season1_4EquipBookView:onDestroyView()
	self._simagebg1:UnLoadImage()

	if self._animCardEventWrap then
		self._animCardEventWrap:RemoveAllEventListener()

		self._animCardEventWrap = nil
	end

	if self._icon ~= nil then
		self._icon:disposeUI()

		self._icon = nil
	end

	Activity104EquipBookController.instance:onCloseView()
end

function Season1_4EquipBookView:onOpen()
	local actId = Activity104Model.instance:getCurSeasonId()

	self.addEventCb(self, Activity104EquipBookController.instance, Activity104Event.OnBookUpdateNotify, self.refreshUI, self)
	self.addEventCb(self, Activity104EquipBookController.instance, Activity104Event.OnBookChangeSelectNotify, self.onChangeSelectCard, self)
	Activity104EquipBookController.instance:onOpenView(actId)
	self:refreshUI()
end

function Season1_4EquipBookView:onClose()
	return
end

function Season1_4EquipBookView:refreshUI()
	self:refreshDesc()
	self:refreshIcon()
end

function Season1_4EquipBookView:refreshDesc()
	local itemId = Activity104EquipItemBookModel.instance.curSelectItemId

	if not itemId then
		self._txtcardname.text = ""

		gohelper.setActive(self._goDesc, false)
	else
		local itemCfg = SeasonConfig.instance:getSeasonEquipCo(itemId)

		if not itemCfg then
			self._txtcardname.text = ""

			gohelper.setActive(self._goDesc, false)
		else
			gohelper.setActive(self._goDesc, true)
		end

		self._txtcardname.text = string.format("[%s]", itemCfg.name)

		self:refreshProps(itemCfg)
		self:refreshSkills(itemCfg)
	end
end

function Season1_4EquipBookView:refreshIcon()
	self:checkCreateIcon()

	local itemId = Activity104EquipItemBookModel.instance.curSelectItemId

	if self._icon then
		self._icon:updateData(itemId)
	end
end

function Season1_4EquipBookView:refreshProps(itemCfg)
	local processedSet = {}
	local isDirty = false

	if itemCfg and itemCfg.attrId ~= 0 then
		local propsList = SeasonEquipMetaUtils.getEquipPropsStrList(itemCfg.attrId)
		local colorStr = SeasonEquipMetaUtils.getCareerColorDarkBg(itemCfg.equipId)

		for index, propStr in ipairs(propsList) do
			local item = self:getOrCreatePropText(index)

			gohelper.setActive(item.go, true)

			item.txtDesc.text = propStr

			SLFramework.UGUI.GuiHelper.SetColor(item.txtDesc, colorStr)

			processedSet[item] = true
			isDirty = true
		end
	end

	for _, item in pairs(self._propItems) do
		if not processedSet[item] then
			gohelper.setActive(item.go, false)
		end
	end

	gohelper.setActive(self._goAttrParent, isDirty)
end

function Season1_4EquipBookView:refreshSkills(itemCfg)
	local skillList = SeasonEquipMetaUtils.getSkillEffectStrList(itemCfg)
	local colorStr = SeasonEquipMetaUtils.getCareerColorDarkBg(itemCfg.equipId)
	local processedSet = {}

	for index, skillStr in ipairs(skillList) do
		local item = self:getOrCreateSkillText(index)

		gohelper.setActive(item.go, true)

		item.txtDesc.text = skillStr

		SLFramework.UGUI.GuiHelper.SetColor(item.txtDesc, colorStr)

		processedSet[item] = true
	end

	for _, item in pairs(self._skillItems) do
		if not processedSet[item] then
			gohelper.setActive(item.go, false)
		end
	end
end

function Season1_4EquipBookView:getOrCreatePropText(index)
	local item = self._propItems[index]

	if not item then
		item = self:getUserDataTb_()
		item.go = gohelper.cloneInPlace(self._goattributeitem, "propname_" .. tostring(index))
		item.txtDesc = gohelper.findChildText(item.go, "txt_attributedesc")
		self._propItems[index] = item
	end

	return item
end

function Season1_4EquipBookView:getOrCreateSkillText(index)
	local item = self._skillItems[index]

	if not item then
		item = self:getUserDataTb_()
		item.go = gohelper.cloneInPlace(self._goskilldescitem, "skill_" .. tostring(index))
		item.txtDesc = gohelper.findChildText(item.go, "txt_skilldesc")
		self._skillItems[index] = item
	end

	return item
end

function Season1_4EquipBookView:checkCreateIcon()
	if not self._icon then
		local go = self._gocarditem

		self._icon = MonoHelper.addNoUpdateLuaComOnceToGo(go, Season1_4CelebrityCardEquip)
	end
end

function Season1_4EquipBookView:onChangeSelectCard()
	self._animatorCard:Play("switch", 0, 0)
end

function Season1_4EquipBookView:onSwitchCardAnim()
	self:refreshUI()
end

return Season1_4EquipBookView
