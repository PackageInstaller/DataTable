-- chunkname: @modules/logic/seasonver/act123/view3_5/Season123_3_5EquipBookView.lua

module("modules.logic.seasonver.act123.view3_5.Season123_3_5EquipBookView", package.seeall)

local Season123_3_5EquipBookView = class("Season123_3_5EquipBookView", BaseView)

function Season123_3_5EquipBookView:onInitView()
	self._simagebg1 = gohelper.findChildSingleImage(self.viewGO, "bg/#simage_bg1")
	self._gotarget = gohelper.findChild(self.viewGO, "left/#go_target")
	self._goctrl = gohelper.findChild(self.viewGO, "left/#go_target/#go_ctrl")
	self._gotargetcardpos = gohelper.findChild(self.viewGO, "left/#go_target/#go_ctrl/#go_targetcardpos")
	self._gocarditem = gohelper.findChild(self.viewGO, "left/#go_target/#go_ctrl/#go_targetcardpos/#go_carditem")
	self._gotouch = gohelper.findChild(self.viewGO, "left/#go_target/#go_touch")
	self._txtcardname = gohelper.findChildText(self.viewGO, "left/#go_target/#txt_cardname")
	self._scrolldesc = gohelper.findChildScrollRect(self.viewGO, "left/#go_target/#scroll_desc")
	self._godescContent = gohelper.findChild(self.viewGO, "left/#go_target/#scroll_desc/Viewport/#go_descContent")
	self._godescitem = gohelper.findChild(self.viewGO, "left/#go_target/#scroll_desc/Viewport/#go_descContent/#go_descitem")
	self._scrollcardlist = gohelper.findChildScrollRect(self.viewGO, "right/mask/#scroll_cardlist")
	self._btnbatchDecompose = gohelper.findChildButtonWithAudio(self.viewGO, "right/#btn_batchDecompose")
	self._gobtns = gohelper.findChild(self.viewGO, "#go_btns")
	self._gotipPos = gohelper.findChild(self.viewGO, "#go_tippos")
	self.goTab = gohelper.findChild(self.viewGO, "right/#go_handbook/top/#go_tab")
	self.tabList = {}

	gohelper.setActive(self.goTab, false)

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Season123_3_5EquipBookView:addEvents()
	self.addEventCb(self, Season123EquipBookController.instance, Season123Event.OnEquipBookItemChangeSelect, self.onChangeSelectCard, self)
end

function Season123_3_5EquipBookView:removeEvents()
	self.removeEventCb(self, Season123EquipBookController.instance, Season123Event.OnEquipBookItemChangeSelect, self.onChangeSelectCard, self)
end

Season123_3_5EquipBookView.defaultDescColor = "#cac8c5"

function Season123_3_5EquipBookView:_editableInitView()
	self._animatorCard = self._gotargetcardpos:GetComponent(typeof(UnityEngine.Animator))
	self._animCardEventWrap = self._animatorCard:GetComponent(typeof(ZProj.AnimationEventWrap))

	self._animCardEventWrap:AddEventListener("switch", self.onSwitchCardAnim, self)

	self.colorStr = Season123_3_5EquipBookView.defaultDescColor
end

function Season123_3_5EquipBookView:onOpen()
	AudioMgr.instance:trigger(AudioEnum.Season123.play_ui_leimi_unlock)

	self.actId = Season123Model.instance:getCurSeasonId()

	self:refreshUI()
end

function Season123_3_5EquipBookView:onSwitchCardAnim()
	self:refreshUI()
end

function Season123_3_5EquipBookView:refreshEquipBook()
	self._scrollcardlist.verticalNormalizedPosition = 1

	self:refreshUI()
end

function Season123_3_5EquipBookView:refreshUI()
	self.itemId = Season123EquipBookModel.instance.curSelectItemId

	self:refreshCardDesc()
	self:refreshIcon()
	self:refreshTabList()
end

function Season123_3_5EquipBookView:refreshTabList()
	local stageList = Season123Config.instance:getStageCos(self.actId)

	for i = 1, math.max(#self.tabList, #stageList) do
		local item = self.tabList[i]

		if not item then
			item = self:getUserDataTb_()
			item.go = gohelper.cloneInPlace(self.goTab, tostring(i))
			item.goUnlock = gohelper.findChild(item.go, "unlock")
			item.goUnChoose = gohelper.findChild(item.go, "unlock/go_unchoose")
			item.txtUnChoose = gohelper.findChildTextMesh(item.go, "unlock/go_unchoose/txt")
			item.goChoose = gohelper.findChild(item.go, "unlock/go_choose")
			item.txtChoose = gohelper.findChildTextMesh(item.go, "unlock/go_choose/txt")
			item.goLock = gohelper.findChild(item.go, "lock")
			item.btnClick = gohelper.findChildButtonWithAudio(item.go, "#btn_click")

			item.btnClick:AddClickListener(self.onClickTab, self, item)

			self.tabList[i] = item
		end

		local stageConfig = stageList[i]

		item.stageConfig = stageConfig

		if stageConfig then
			gohelper.setActive(item.go, true)

			local rs = Season123ProgressUtils.isStageUnlock(stageConfig.activityId, stageConfig.stage)

			if rs then
				gohelper.setActive(item.goLock, false)
				gohelper.setActive(item.goUnlock, true)

				item.txtUnChoose.text = stageConfig.name
				item.txtChoose.text = stageConfig.name

				local isSelect = stageConfig.stage == Season123EquipBookModel.instance:getSelectStage()

				gohelper.setActive(item.goChoose, isSelect)
				gohelper.setActive(item.goUnChoose, not isSelect)
			else
				gohelper.setActive(item.goLock, true)
				gohelper.setActive(item.goUnlock, false)
			end
		else
			gohelper.setActive(item.go, false)
		end
	end
end

function Season123_3_5EquipBookView:onClickTab(item)
	local stageConfig = item.stageConfig

	if not stageConfig then
		return
	end

	Season123EquipBookModel.instance:setSelectStage(stageConfig.stage)
	self:refreshTabList()
end

function Season123_3_5EquipBookView:refreshCardDesc()
	if not self.itemId then
		self._txtcardname.text = ""

		gohelper.setActive(self._scrolldesc.gameObject, false)
	else
		local itemConfig = Season123Config.instance:getSeasonEquipCo(self.itemId)

		self._txtcardname.text = itemConfig ~= nil and string.format("[%s]", itemConfig.name) or ""

		gohelper.setActive(self._scrolldesc.gameObject, itemConfig ~= nil)
		self:refreshCardItem(itemConfig)
	end
end

function Season123_3_5EquipBookView:refreshCardItem(itemConfig)
	self._cardDescInfos = self:getUserDataTb_()

	if itemConfig then
		local skillList = Season123EquipMetaUtils.getSkillEffectStrList(itemConfig)

		self.colorStr = Season123EquipMetaUtils.getCareerColorDarkBg(itemConfig.equipId)

		if itemConfig.attrId ~= 0 then
			local propsList = Season123EquipMetaUtils.getEquipPropsStrList(itemConfig.attrId)

			if GameUtil.getTabLen(propsList) > 0 then
				tabletool.addValues(self._cardDescInfos, propsList)
			end
		end

		tabletool.addValues(self._cardDescInfos, skillList)
		gohelper.CreateObjList(self, self.cardDescItemShow, self._cardDescInfos, self._godescContent, self._godescitem)
	end
end

function Season123_3_5EquipBookView:cardDescItemShow(obj, data, index)
	obj.name = "desc" .. index

	local txtDesc = gohelper.findChildText(obj, "txt_desc")
	local fixTmpBreakLine = MonoHelper.addNoUpdateLuaComOnceToGo(txtDesc.gameObject, FixTmpBreakLine)

	data = SkillHelper.addLink(data)
	data = HeroSkillModel.instance:skillDesToSpot(data)
	txtDesc.text = data

	fixTmpBreakLine:refreshTmpContent(txtDesc)
	SLFramework.UGUI.GuiHelper.SetColor(txtDesc, self.colorStr)
	SkillHelper.addHyperLinkClick(txtDesc, self.setSkillClickCallBack, self)
end

function Season123_3_5EquipBookView:setSkillClickCallBack(effId, clickPosition)
	local tipPosX, tipPosY = recthelper.getAnchor(self._gotipPos.transform)
	local tipPos = Vector2.New(tipPosX, tipPosY)

	CommonBuffTipController:openCommonTipViewWithCustomPos(effId, tipPos, CommonBuffTipEnum.Pivot.Left)
end

function Season123_3_5EquipBookView:refreshIcon()
	if not self._icon then
		local go = self._gocarditem

		self._icon = MonoHelper.addNoUpdateLuaComOnceToGo(go, Season123_3_5CelebrityCardEquip)
	end

	if self.itemId and self.itemId > 0 then
		gohelper.setActive(self._gocarditem, true)
		self._icon:updateData(self.itemId)
		self._icon:setIndexLimitShowState(true)
	else
		gohelper.setActive(self._gocarditem, false)
	end
end

function Season123_3_5EquipBookView:onChangeSelectCard()
	self._animatorCard:Play("switch", 0, 0)
end

function Season123_3_5EquipBookView:onClose()
	Season123EquipBookModel.instance._itemStartAnimTime = nil
end

function Season123_3_5EquipBookView:onDestroyView()
	if self._animCardEventWrap then
		self._animCardEventWrap:RemoveAllEventListener()

		self._animCardEventWrap = nil
	end

	if self._icon ~= nil then
		self._icon:disposeUI()

		self._icon = nil
	end

	for _, item in pairs(self.tabList) do
		item.btnClick:RemoveClickListener()
	end

	Season123EquipBookController.instance:onCloseView()
end

return Season123_3_5EquipBookView
