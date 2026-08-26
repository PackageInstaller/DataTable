-- chunkname: @modules/logic/season/view1_6/Season1_6EquipSelfChoiceView.lua

module("modules.logic.season.view1_6.Season1_6EquipSelfChoiceView", package.seeall)

local Season1_6EquipSelfChoiceView = class("Season1_6EquipSelfChoiceView", BaseView)

function Season1_6EquipSelfChoiceView:onInitView()
	self._btnclose1 = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_close1")
	self._simagebg1 = gohelper.findChildSingleImage(self.viewGO, "root/bg/#simage_bg1")
	self._simagebg2 = gohelper.findChildSingleImage(self.viewGO, "root/bg/#simage_bg2")
	self._scrollitem = gohelper.findChildScrollRect(self.viewGO, "root/mask/#scroll_item")
	self._gocarditem = gohelper.findChild(self.viewGO, "root/mask/#scroll_item/viewport/itemcontent/#go_carditem")
	self._btnok = gohelper.findChildButtonWithAudio(self.viewGO, "root/#btn_ok")
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "root/#btn_close")
	self.goempty = gohelper.findChild(self.viewGO, "root/right/#go_empty")
	self.gocardinfo = gohelper.findChild(self.viewGO, "root/right/#go_cardinfo")
	self.txtcardname = gohelper.findChildTextMesh(self.viewGO, "root/right/#go_cardinfo/#txt_curcardname")
	self.godescitem = gohelper.findChild(self.viewGO, "root/right/#go_cardinfo/#scroll_info/Viewport/Content/#go_descitem")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Season1_6EquipSelfChoiceView:addEvents()
	self._btnclose1:AddClickListener(self._btnclose1OnClick, self)
	self._btnok:AddClickListener(self._btnokOnClick, self)
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
	self.addEventCb(self, Activity104Controller.instance, Activity104Event.SelectSelfChoiceCard, self.selectSelfChoiceCard, self)
end

function Season1_6EquipSelfChoiceView:removeEvents()
	self._btnclose1:RemoveClickListener()
	self._btnok:RemoveClickListener()
	self._btnclose:RemoveClickListener()
	self.removeEventCb(self, Activity104Controller.instance, Activity104Event.SelectSelfChoiceCard, self.selectSelfChoiceCard, self)
end

function Season1_6EquipSelfChoiceView:_btnclose1OnClick()
	return
end

function Season1_6EquipSelfChoiceView:_btnokOnClick()
	Activity104EquipSelfChoiceController.instance:sendSelectCard(self.handleSendChoice, self)
end

function Season1_6EquipSelfChoiceView:_btncloseOnClick()
	self:closeThis()
end

function Season1_6EquipSelfChoiceView:_editableInitView()
	self._simagebg1:LoadImage(ResUrl.getCommonIcon("bg_leftdown"))
	self._simagebg2:LoadImage(ResUrl.getCommonIcon("bg_rightup"))
end

function Season1_6EquipSelfChoiceView:onDestroyView()
	self._simagebg1:UnLoadImage()
	self._simagebg2:UnLoadImage()
	Activity104EquipSelfChoiceController.instance:onCloseView()
end

function Season1_6EquipSelfChoiceView:onOpen()
	local actId = self.viewParam.actId
	local costItemUid = self.viewParam.costItemUid

	if not Activity104EquipSelfChoiceController:checkOpenParam(actId, costItemUid) then
		self:delayClose()

		return
	end

	self:selectSelfChoiceCard()
	Activity104EquipSelfChoiceController.instance:onOpenView(actId, costItemUid)
end

function Season1_6EquipSelfChoiceView:selectSelfChoiceCard(itemId)
	local itemCo = SeasonConfig.instance:getSeasonEquipCo(itemId)

	if not itemCo then
		gohelper.setActive(self.goempty, true)
		gohelper.setActive(self.gocardinfo, false)

		return
	end

	gohelper.setActive(self.goempty, false)
	gohelper.setActive(self.gocardinfo, true)

	self.txtcardname.text = itemCo.name

	local skillList = SeasonEquipMetaUtils.getSkillEffectStrList(itemCo)
	local colorStr = SeasonEquipMetaUtils.getCareerColorBrightBg(itemId)

	self._skillItems = self._skillItems or {}

	for i = 1, math.max(#self._skillItems, #skillList) do
		local item = self:getOrCreateSkillText(i)

		if skillList[i] then
			gohelper.setActive(item.go, true)

			item.txtDesc.text = skillList[i]

			SLFramework.UGUI.GuiHelper.SetColor(item.txtDesc, colorStr)
			SLFramework.UGUI.GuiHelper.SetColor(item.imagePoint, colorStr)
		else
			gohelper.setActive(item.go, false)
		end
	end
end

function Season1_6EquipSelfChoiceView:getOrCreateSkillText(index)
	local item = self._skillItems[index]

	if not item then
		item = self:getUserDataTb_()
		item.go = gohelper.cloneInPlace(self.godescitem, "desc" .. tostring(index))
		item.txtDesc = gohelper.findChildText(item.go, "txt_desc")
		item.imagePoint = gohelper.findChildImage(item.go, "dot")
		self._skillItems[index] = item
	end

	return item
end

function Season1_6EquipSelfChoiceView:onClose()
	TaskDispatcher.cancelTask(self.closeThis, self)
end

function Season1_6EquipSelfChoiceView:delayClose()
	TaskDispatcher.runDelay(self.closeThis, self, 0.001)
end

function Season1_6EquipSelfChoiceView:handleSendChoice(cmd, resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	self:closeThis()

	if self.viewParam.successCall then
		self.viewParam.successCall(self.viewParam.successCallObj)
	end
end

return Season1_6EquipSelfChoiceView
