-- chunkname: @modules/logic/seasonver/act123/view/Season123CelebrityCardTipView.lua

module("modules.logic.seasonver.act123.view.Season123CelebrityCardTipView", package.seeall)

local Season123CelebrityCardTipView = class("Season123CelebrityCardTipView", BaseView)

function Season123CelebrityCardTipView:onInitView()
	self._simageblur = gohelper.findChildSingleImage(self.viewGO, "#simage_blur")
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_close")

	local guideGMNode = GMController.instance:getGMNode("seasoncelebritycardtipview", self.viewGO)

	if guideGMNode then
		self._gogm = gohelper.findChild(guideGMNode, "#go_gm")
		self._txtmattip = gohelper.findChildText(guideGMNode, "#go_gm/bg/#txt_mattip")
		self._btnone = gohelper.findChildButtonWithAudio(guideGMNode, "#go_gm/#btn_one")
		self._btnten = gohelper.findChildButtonWithAudio(guideGMNode, "#go_gm/#btn_ten")
		self._btnhundred = gohelper.findChildButtonWithAudio(guideGMNode, "#go_gm/#btn_hundred")
		self._btnthousand = gohelper.findChildButtonWithAudio(guideGMNode, "#go_gm/#btn_thousand")
		self._btntenthousand = gohelper.findChildButtonWithAudio(guideGMNode, "#go_gm/#btn_tenthousand")
		self._btntenmillion = gohelper.findChildButtonWithAudio(guideGMNode, "#go_gm/#btn_tenmillion")
		self._btninput = gohelper.findChildButtonWithAudio(guideGMNode, "#go_gm/#btn_input")
	end

	self._simagebg1 = gohelper.findChildSingleImage(self.viewGO, "bg/#simage_bg1")
	self._simagebg2 = gohelper.findChildSingleImage(self.viewGO, "bg/#simage_bg2")
	self._txtpropname = gohelper.findChildText(self.viewGO, "#txt_propname")
	self._txtpropnameen = gohelper.findChildText(self.viewGO, "#txt_propname/#txt_propnameen")
	self._scrolldesc = gohelper.findChildScrollRect(self.viewGO, "#scroll_desc")
	self._goeffect = gohelper.findChild(self.viewGO, "#scroll_desc/viewport/content/#go_effect")
	self._goeffectitem = gohelper.findChild(self.viewGO, "#scroll_desc/viewport/content/#go_effect/#go_effectitem")
	self._goeffectdesc = gohelper.findChild(self.viewGO, "#scroll_desc/viewport/content/#go_effectdesc")
	self._goeffectdescitem = gohelper.findChild(self.viewGO, "#scroll_desc/viewport/content/#go_effectdesc/#go_effectdescitem")
	self._txthadnumber = gohelper.findChildText(self.viewGO, "#go_quantity/#txt_hadnumber")
	self._goquantity = gohelper.findChild(self.viewGO, "#go_quantity")
	self._gocard = gohelper.findChild(self.viewGO, "#go_card")
	self._gocarditem = gohelper.findChild(self.viewGO, "#go_ctrl/#go_targetcardpos/#go_carditem")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Season123CelebrityCardTipView:addEvents()
	self._btnclose:AddClickListener(self._btncloseOnClick, self)

	if self._gogm then
		self._btnone:AddClickListener(self.onClickGMAdd, self, 1)
		self._btnten:AddClickListener(self.onClickGMAdd, self, 10)
		self._btnhundred:AddClickListener(self.onClickGMAdd, self, 100)
		self._btnthousand:AddClickListener(self.onClickGMAdd, self, 1000)
		self._btntenthousand:AddClickListener(self.onClickGMAdd, self, 10000)
		self._btntenmillion:AddClickListener(self.onClickGMAdd, self, 10000000)
		self._btninput:AddClickListener(self._btninputOnClick, self)
	end
end

function Season123CelebrityCardTipView:removeEvents()
	self._btnclose:RemoveClickListener()

	if self._gogm then
		self._btnone:RemoveClickListener()
		self._btnten:RemoveClickListener()
		self._btnhundred:RemoveClickListener()
		self._btnthousand:RemoveClickListener()
		self._btntenthousand:RemoveClickListener()
		self._btntenmillion:RemoveClickListener()
		self._btninput:RemoveClickListener()
	end
end

function Season123CelebrityCardTipView:_btncloseOnClick()
	self:closeThis()
end

function Season123CelebrityCardTipView:onClickGMAdd(count)
	GameFacade.showToast(ToastEnum.GMTool5, self.viewParam.id)
	GMRpc.instance:sendGMRequest(string.format("add material %d#%d#%d", self.viewParam.type, self.viewParam.id, 10))
end

function Season123CelebrityCardTipView:_btninputOnClick()
	local inputMo = CommonInputMO.New()

	inputMo.title = "请输入增加道具数量！"
	inputMo.defaultInput = "Enter Item Num"

	function inputMo.sureCallback(inputStr)
		GameFacade.closeInputBox()

		local inputNum = tonumber(inputStr)

		if inputNum and inputNum > 0 then
			GameFacade.showToast(ToastEnum.GMTool5, self.viewParam.id)
			GMRpc.instance:sendGMRequest(string.format("add material %d#%d#%d", self.viewParam.type, self.viewParam.id, inputNum))
		end
	end

	GameFacade.openInputBox(inputMo)
end

function Season123CelebrityCardTipView:_editableInitView()
	self._simagebg1:LoadImage(ResUrl.getCommonIcon("bg_1"))
	self._simagebg2:LoadImage(ResUrl.getCommonIcon("bg_2"))

	self._goSkillTitle = gohelper.findChild(self.viewGO, "#scroll_desc/viewport/content/#go_effectdesc/title")
	self._propItems = {}
	self._skillItems = {}

	if self._gogm then
		gohelper.setActive(self._gogm, GMController.instance:isOpenGM())
	end
end

function Season123CelebrityCardTipView:onDestroyView()
	self._simagebg1:UnLoadImage()
	self._simagebg2:UnLoadImage()

	if self._icon then
		self._icon:disposeUI()

		self._icon = nil
	end
end

function Season123CelebrityCardTipView:onOpen()
	self._itemId = self.viewParam.id
	self._itemCfg = ItemModel.instance:getItemConfigAndIcon(self.viewParam.type, self._itemId)
	self._activityId = self.viewParam.actId or Season123Model.instance:getCurSeasonId()

	if not self._itemCfg then
		logError("can't find card cfg : " .. tostring(self._itemId))

		return
	end

	self:refreshUI()
end

function Season123CelebrityCardTipView:onClose()
	return
end

function Season123CelebrityCardTipView:refreshUI()
	self._txtpropname.text = self._itemCfg.name

	if self._txtmattip then
		self._txtmattip.text = tostring(self.viewParam.type) .. "#" .. tostring(self.viewParam.id)
	end

	self:checkCreateIcon()
	self._icon:updateData(self._itemId)
	self:refreshQuantity()

	local isPropDirty = self:refreshProps()
	local isSkillDirty = self:refreshSkills()

	if not isPropDirty or not isSkillDirty then
		gohelper.setActive(self._goSkillTitle, false)
	end
end

function Season123CelebrityCardTipView:refreshQuantity()
	if self.viewParam.needQuantity then
		gohelper.setActive(self._goquantity, true)

		local numStr

		self._txthadnumber.text = formatLuaLang("materialtipview_itemquantity", self.viewParam.fakeQuantity and tostring(self.viewParam.fakeQuantity) or self._activityId and tostring(GameUtil.numberDisplay(Season123EquipMetaUtils.getEquipCount(self._activityId, self._itemId))) or tostring(Season123EquipMetaUtils.getCurSeasonEquipCount(self._itemId)))
	else
		gohelper.setActive(self._goquantity, false)
	end
end

function Season123CelebrityCardTipView:refreshProps()
	local isDirty = false
	local propsList = Season123EquipMetaUtils.getEquipPropsStrList(self._itemCfg.attrId, true)
	local colorStr = Season123EquipMetaUtils.getCareerColorBrightBg(self._itemId)
	local processedSet = {}

	for index, propStr in ipairs(propsList) do
		local item = self:getOrCreatePropText(index)

		gohelper.setActive(item.go, true)

		item.txtDesc.text = propStr

		SLFramework.UGUI.GuiHelper.SetColor(item.txtDesc, colorStr)
		SLFramework.UGUI.GuiHelper.SetColor(item.imagePoint, colorStr)

		processedSet[item] = true
		isDirty = true
	end

	for _, item in pairs(self._propItems) do
		if not processedSet[item] then
			gohelper.setActive(item.go, false)
		end
	end

	gohelper.setActive(self._goeffect, isDirty)

	return isDirty
end

function Season123CelebrityCardTipView:refreshSkills()
	local skillList = Season123EquipMetaUtils.getSkillEffectStrList(self._itemCfg)
	local colorStr = Season123EquipMetaUtils.getCareerColorBrightBg(self._itemId)
	local isDirty = false
	local processedSet = {}

	for index, skillStr in ipairs(skillList) do
		local item = self:getOrCreateSkillText(index)

		gohelper.setActive(item.go, true)

		item.txtDesc.text = skillStr

		SLFramework.UGUI.GuiHelper.SetColor(item.txtDesc, colorStr)
		SLFramework.UGUI.GuiHelper.SetColor(item.imagePoint, colorStr)

		processedSet[item] = true
		isDirty = true
	end

	for _, item in pairs(self._skillItems) do
		if not processedSet[item] then
			gohelper.setActive(item.go, false)
		end
	end

	return isDirty
end

function Season123CelebrityCardTipView:checkCreateIcon()
	if not self._icon then
		local path = self.viewContainer:getSetting().otherRes[1]
		local go = self:getResInst(path, self._gocard, "icon")

		self._icon = MonoHelper.addNoUpdateLuaComOnceToGo(go, Season123CelebrityCardEquip)
	end
end

function Season123CelebrityCardTipView:getOrCreatePropText(index)
	local item = self._propItems[index]

	if not item then
		item = self:getUserDataTb_()
		item.go = gohelper.cloneInPlace(self._goeffectitem, "propname_" .. tostring(index))
		item.txtDesc = gohelper.findChildText(item.go, "txt_desc")
		item.imagePoint = gohelper.findChildImage(item.go, "point")
		self._propItems[index] = item
	end

	return item
end

function Season123CelebrityCardTipView:getOrCreateSkillText(index)
	local item = self._skillItems[index]

	if not item then
		item = self:getUserDataTb_()
		item.go = gohelper.cloneInPlace(self._goeffectdescitem, "skill_" .. tostring(index))
		item.txtDesc = gohelper.findChildText(item.go, "txt_desc")
		item.imagePoint = gohelper.findChildImage(item.go, "point")
		self._skillItems[index] = item
	end

	return item
end

function Season123CelebrityCardTipView:onClickModalMask()
	self:closeThis()
end

return Season123CelebrityCardTipView
