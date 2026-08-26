-- chunkname: @modules/logic/character/view/CharacterView.lua

module("modules.logic.character.view.CharacterView", package.seeall)

local CharacterView = class("CharacterView", BaseView)
local ATTRIBUTE_NUM = 5

function CharacterView:onInitView()
	self._simagebg = gohelper.findChildSingleImage(self.viewGO, "anim/bgcanvas/bg/#simage_bg")
	self._simageplayerbg = gohelper.findChildSingleImage(self.viewGO, "anim/bgcanvas/bg/#simage_playerbg")
	self._gospine = gohelper.findChild(self.viewGO, "anim/#go_herocontainer/dynamiccontainer/#go_spine")
	self._simagestatic = gohelper.findChildSingleImage(self.viewGO, "anim/#go_herocontainer/staticcontainer/#simage_static")
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "anim/go_btns/#btn_close")
	self._btnhome = gohelper.findChildButtonWithAudio(self.viewGO, "anim/go_btns/#btn_home")
	self._btndata = gohelper.findChildButtonWithAudio(self.viewGO, "anim/go_btns/#btn_data")
	self._godatareddot = gohelper.findChild(self.viewGO, "anim/go_btns/#btn_data/#go_datareddot")
	self._btnskin = gohelper.findChildButtonWithAudio(self.viewGO, "anim/go_btns/#btn_skin")
	self._btnfavor = gohelper.findChildButtonWithAudio(self.viewGO, "anim/go_btns/#btn_favor")
	self._imagefavor = gohelper.findChildImage(self.viewGO, "anim/go_btns/#btn_favor")
	self._btnhelp = gohelper.findChildButtonWithAudio(self.viewGO, "anim/go_btns/#btn_help")
	self._btnrecommed = gohelper.findChildButtonWithAudio(self.viewGO, "anim/go_btns/#btn_recommed")
	self._gorare = gohelper.findChild(self.viewGO, "anim/info/#go_rare")
	self._imagecareericon = gohelper.findChildImage(self.viewGO, "anim/info/#image_careericon")
	self._imagedmgtype = gohelper.findChildImage(self.viewGO, "anim/info/#image_dmgtype")
	self._txtnamecn = gohelper.findChildText(self.viewGO, "anim/info/#txt_namecn")
	self._txtnameen = gohelper.findChildText(self.viewGO, "anim/info/#txt_namecn/#txt_nameen")
	self._txttrust = gohelper.findChildText(self.viewGO, "anim/info/trust/#txt_trust")
	self._slidertrust = gohelper.findChildSlider(self.viewGO, "anim/info/trust/#slider_trust")
	self._gocareer = gohelper.findChild(self.viewGO, "anim/#go_career")
	self._btnattribute = gohelper.findChildButtonWithAudio(self.viewGO, "anim/attribute/#btn_attribute")
	self._goattributenode = gohelper.findChild(self.viewGO, "anim/attribute")
	self._goattribute = gohelper.findChild(self.viewGO, "anim/attribute/#go_attribute")
	self._goattributetipsnode = gohelper.findChild(self.viewGO, "anim/#go_attributetips")
	self._animatorattributetipsnode = self._goattributetipsnode:GetComponent(typeof(UnityEngine.Animator))
	self._goattributetips = gohelper.findChild(self.viewGO, "anim/#go_attributetips/#go_attribute")
	self._txtlevel = gohelper.findChildText(self.viewGO, "anim/level/lvtxt/#txt_level")
	self._txtlevelmax = gohelper.findChildText(self.viewGO, "anim/level/lvtxt/#txt_level/#txt_levelmax")
	self._btnlevel = gohelper.findChildButtonWithAudio(self.viewGO, "anim/level/#btn_level")
	self._gorankeyes = gohelper.findChild(self.viewGO, "anim/rank/#go_rankeyes")
	self._goranklights = gohelper.findChild(self.viewGO, "anim/rank/#go_ranklights")
	self._btnrank = gohelper.findChildButtonWithAudio(self.viewGO, "anim/rank/#btn_rank")
	self._gorankreddot = gohelper.findChild(self.viewGO, "anim/rank/#go_rankreddot")
	self._goskill = gohelper.findChild(self.viewGO, "anim/layout/#go_skillLayout/#go_skill")
	self._btnpassiveskill = gohelper.findChildButtonWithAudio(self.viewGO, "anim/passiveskill/#btn_passiveskill")
	self._txtpassivename = gohelper.findChildText(self.viewGO, "anim/passiveskill/bg/passiveskillimage/#txt_passivename")
	self._gopassiveskills = gohelper.findChild(self.viewGO, "anim/passiveskill/#go_passiveskills")
	self._btnexskill = gohelper.findChildButtonWithAudio(self.viewGO, "anim/layout/rightbottom/exskill/#btn_exskill")
	self._goexskills = gohelper.findChild(self.viewGO, "anim/layout/rightbottom/exskill/#go_exskills")
	self._goexskillreddot = gohelper.findChild(self.viewGO, "anim/layout/rightbottom/exskill/#go_exskillreddot")
	self._gotalent = gohelper.findChild(self.viewGO, "anim/layout/rightbottom/#go_talent")
	self._txttalentcn = gohelper.findChildText(self.viewGO, "anim/layout/rightbottom/#go_talent/talentcn")
	self._txttalenten = gohelper.findChildText(self.viewGO, "anim/layout/rightbottom/#go_talent/talentcn/talenten")
	self._btntalent = gohelper.findChildButtonWithAudio(self.viewGO, "anim/layout/rightbottom/#go_talent/#btn_talent")
	self._gotalents = gohelper.findChild(self.viewGO, "anim/layout/rightbottom/#go_talent/#go_talents")
	self._gotalentstyle = gohelper.findChild(self.viewGO, "anim/layout/rightbottom/#go_talent/#go_talentstyle")
	self._imageicon = gohelper.findChildImage(self.viewGO, "anim/layout/rightbottom/#go_talent/#go_talentstyle/#image_icon")
	self._txttalentvalue = gohelper.findChildText(self.viewGO, "anim/layout/rightbottom/#go_talent/#txt_talentvalue")
	self._gotalentlock = gohelper.findChild(self.viewGO, "anim/layout/rightbottom/#go_talent/#go_talentlock")
	self._gotalentreddot = gohelper.findChild(self.viewGO, "anim/layout/rightbottom/#go_talent/#go_talentreddot")
	self._gocontentbg = gohelper.findChild(self.viewGO, "anim/bottom/#go_contentbg")
	self._txtanacn = gohelper.findChildText(self.viewGO, "anim/bottom/#txt_ana_cn")
	self._txtanaen = gohelper.findChildText(self.viewGO, "anim/bottom/#txt_ana_en")
	self._godynamiccontainer = gohelper.findChild(self.viewGO, "anim/#go_herocontainer/dynamiccontainer")
	self._gostaticcontainer = gohelper.findChild(self.viewGO, "anim/#go_herocontainer/staticcontainer")
	self._goherocontainer = gohelper.findChild(self.viewGO, "anim/#go_herocontainer")
	self._simagesignature = gohelper.findChildSingleImage(self.viewGO, "anim/bottom/#simage_signature")
	self._golevelimage = gohelper.findChild(self.viewGO, "anim/level/levelimage")
	self._golevelicon = gohelper.findChild(self.viewGO, "anim/level/addicon")
	self._golevelimagetrial = gohelper.findChild(self.viewGO, "anim/level/#go_levelimagetrial")
	self._gorankimage = gohelper.findChild(self.viewGO, "anim/rank/rankimage")
	self._gorankicon = gohelper.findChild(self.viewGO, "anim/rank/addicon")
	self._gorankimagetrial = gohelper.findChild(self.viewGO, "anim/rank/#go_rankimagetrial")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function CharacterView:addEvents()
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
	self._btnhome:AddClickListener(self._btnhomeOnClick, self)
	self._btndata:AddClickListener(self._btndataOnClick, self)
	self._btnskin:AddClickListener(self._btnskinOnClick, self)
	self._btnfavor:AddClickListener(self._btnfavorOnClick, self)
	self._btnhelp:AddClickListener(self._btnhelpOnClick, self)
	self._btnrecommed:AddClickListener(self._btnrecommedOnClick, self)
	self._btnattribute:AddClickListener(self._btnattributeOnClick, self)
	self._btnlevel:AddClickListener(self._btnlevelOnClick, self)
	self._btnrank:AddClickListener(self._btnrankOnClick, self)
	self._btnpassiveskill:AddClickListener(self._btnpassiveskillOnClick, self)
	self._btnexskill:AddClickListener(self._btnexskillOnClick, self)
	self._btntalent:AddClickListener(self._btntalentOnClick, self)
	GameStateMgr.instance:registerCallback(GameStateEvent.onApplicationPause, self._onApplicationPause, self)
	self.addEventCb(self, CharacterController.instance, CharacterEvent.levelUpChangePreviewLevel, self._refreshAttributeTips, self)
	self.addEventCb(self, CharacterController.instance, CharacterEvent.onTalentStyleRead, self._refreshTalentRed, self)
	self.addEventCb(self, CharacterController.instance, CharacterEvent.onUseTalentStyleReply, self._onRefreshStyleIcon, self)
	self.addEventCb(self, CharacterController.instance, CharacterEvent.UseTalentTemplateReply, self._onRefreshStyleIcon, self)
	self.addEventCb(self, HeroResonanceController.instance, HeroResonanceEvent.UseShareCode, self._onRefreshStyleIcon, self)
	self.addEventCb(self, CharacterDestinyController.instance, CharacterDestinyEvent.OnUseStoneReply, self._onRefreshDestiny, self)
	self.addEventCb(self, CharacterDestinyController.instance, CharacterDestinyEvent.OnRankUpReply, self._onRefreshDestiny, self)
	self.addEventCb(self, CharacterController.instance, CharacterEvent.onRefreshCharacterSkill, self._refreshSkill, self)
	self.addEventCb(self, CharacterRecommedController.instance, CharacterRecommedEvent.OnJumpView, self._onJumpView, self)
end

function CharacterView:removeEvents()
	self._btnclose:RemoveClickListener()
	self._btnhome:RemoveClickListener()
	self._btndata:RemoveClickListener()
	self._btnskin:RemoveClickListener()
	self._btnfavor:RemoveClickListener()
	self._btnhelp:RemoveClickListener()
	self._btnrecommed:RemoveClickListener()
	self._btnattribute:RemoveClickListener()
	self._btnlevel:RemoveClickListener()
	self._btnrank:RemoveClickListener()
	self._btnpassiveskill:RemoveClickListener()
	self._btnexskill:RemoveClickListener()
	self._btntalent:RemoveClickListener()
	GameStateMgr.instance:unregisterCallback(GameStateEvent.onApplicationPause, self._onApplicationPause, self)
	self.removeEventCb(self, CharacterController.instance, CharacterEvent.levelUpChangePreviewLevel, self._refreshAttributeTips, self)
	self.removeEventCb(self, CharacterController.instance, CharacterEvent.onTalentStyleRead, self._refreshTalentRed, self)
	self.removeEventCb(self, CharacterController.instance, CharacterEvent.onUseTalentStyleReply, self._onRefreshStyleIcon, self)
	self.removeEventCb(self, CharacterController.instance, CharacterEvent.UseTalentTemplateReply, self._onRefreshStyleIcon, self)
	self.removeEventCb(self, CharacterController.instance, CharacterEvent.OnMarkFavorSuccess, self._markFavorSuccess, self)
	self.removeEventCb(self, HeroResonanceController.instance, HeroResonanceEvent.UseShareCode, self._onRefreshStyleIcon, self)
	self.removeEventCb(self, CharacterDestinyController.instance, CharacterDestinyEvent.OnUseStoneReply, self._onRefreshDestiny, self)
	self.removeEventCb(self, CharacterDestinyController.instance, CharacterDestinyEvent.OnRankUpReply, self._onRefreshDestiny, self)
	self.removeEventCb(self, CharacterController.instance, CharacterEvent.onRefreshCharacterSkill, self._refreshSkill, self)
	self.removeEventCb(self, CharacterRecommedController.instance, CharacterRecommedEvent.OnJumpView, self._onJumpView, self)
end

CharacterView.HpAttrId = 101
CharacterView.AttackAttrId = 102
CharacterView.DefenseAttrId = 103
CharacterView.MdefenseAttrId = 104
CharacterView.TechnicAttrId = 105
CharacterView.RankIconOffset = 51.38
CharacterView.AttrIconColor = GameUtil.parseColor("#9b795e")
CharacterView.AttrIdList = {
	CharacterEnum.AttrId.Hp,
	CharacterEnum.AttrId.Defense,
	CharacterEnum.AttrId.Technic,
	CharacterEnum.AttrId.Mdefense,
	CharacterEnum.AttrId.Attack
}

function CharacterView:_editableInitView()
	gohelper.addUIClickAudio(self._btnlevel.gameObject, AudioEnum.UI.Play_Ui_Level_Unfold)
	gohelper.addUIClickAudio(self._btndata.gameObject, AudioEnum.UI.UI_role_introduce_open)
	gohelper.addUIClickAudio(self._btnskin.gameObject, AudioEnum.UI.UI_role_skin_open)
	gohelper.addUIClickAudio(self._btnhelp.gameObject, AudioEnum.UI.UI_help_open)
	gohelper.addUIClickAudio(self._btnclose.gameObject, AudioEnum.UI.UI_Rolesclose)
	gohelper.addUIClickAudio(self._btnhome.gameObject, AudioEnum.UI.UI_Rolesclose)
	gohelper.addUIClickAudio(self._btnattribute.gameObject, AudioEnum.UI.Play_ui_role_description)
	gohelper.addUIClickAudio(self._btntalent.gameObject, AudioEnum.UI.play_ui_admission_open)
	gohelper.addUIClickAudio(self._btnrank.gameObject, AudioEnum.UI.play_ui_role_insight_open)
	gohelper.setActive(self._btnskin.gameObject, CharacterEnum.SkinOpen)

	local showHelp = HelpModel.instance:isShowedHelp(HelpEnum.HelpId.Character)

	gohelper.setActive(self._btnhelp.gameObject, showHelp)
	self._simagebg:LoadImage(ResUrl.getCommonViewBg("full/juese_bj"))
	self._simageplayerbg:LoadImage(ResUrl.getCharacterIcon("guangyun"))

	self._uiSpine = GuiModelAgent.Create(self._gospine, true)

	self._uiSpine:setShareRT(CharacterVoiceEnum.RTShareType.Normal, self.viewName)

	self._rareStars = self:getUserDataTb_()

	for i = 1, 6 do
		self._rareStars[i] = gohelper.findChild(self._gorare, "rare" .. i)
	end

	self._careerlabels = self:getUserDataTb_()
	self._careeritem = gohelper.findChild(self._gocareer, "careerlabel")
	self._attributevalues = {}
	self._levelUpAttributeValues = {}

	for i = 1, ATTRIBUTE_NUM do
		local o = self:getUserDataTb_()

		o.value = gohelper.findChildText(self._goattribute, "attribute" .. tostring(i) .. "/txt_attribute")
		o.name = gohelper.findChildText(self._goattribute, "attribute" .. tostring(i) .. "/name")
		o.icon = gohelper.findChildImage(self._goattribute, "attribute" .. tostring(i) .. "/icon")
		o.rate = gohelper.findChildImage(self._goattribute, "attribute" .. tostring(i) .. "/rate")

		gohelper.setActive(o.rate.gameObject, false)

		self._attributevalues[i] = o

		local attr = self:getUserDataTb_()
		local strAttribute = "attribute" .. tostring(i)

		attr.value = gohelper.findChildText(self._goattributetips, strAttribute .. "/txt_attribute")
		attr.newValue = gohelper.findChildText(self._goattributetips, strAttribute .. "/txt_attribute/txt_attribute2")
		attr.newValueArrow = gohelper.findChildImage(self._goattributetips, strAttribute .. "/txt_attribute/image_Arrow")
		attr.name = gohelper.findChildText(self._goattributetips, strAttribute .. "/name")
		attr.icon = gohelper.findChildImage(self._goattributetips, strAttribute .. "/icon")
		self._levelUpAttributeValues[i] = attr
	end

	self._ranklights = {}

	for i = 1, 3 do
		local o = self:getUserDataTb_()

		o.go = gohelper.findChild(self._goranklights, "light" .. i)
		o.lights = self:getUserDataTb_()

		for j = 1, i do
			table.insert(o.lights, gohelper.findChild(o.go, "star" .. j))
		end

		self._ranklights[i] = o
	end

	self._skillContainer = MonoHelper.addNoUpdateLuaComOnceToGo(self._goskill, CharacterSkillContainer)
	self._passiveskillitems = {}

	for i = 1, 3 do
		self._passiveskillitems[i] = self:_findPassiveskillitems(i)
	end

	self._passiveskillitems[0] = self:_findPassiveskillitems(4)
	self._exskills = self:getUserDataTb_()

	for i = 1, 5 do
		self._exskills[i] = gohelper.findChild(self._goexskills, "exskill" .. tostring(i))
	end

	self._drag = SLFramework.UGUI.UIDragListener.Get(self._goherocontainer)
	self._signatureDrag = SLFramework.UGUI.UIDragListener.Get(self._simagesignature.gameObject)
	self._trustclick = SLFramework.UGUI.UIClickListener.Get(self._txttrust.gameObject)
	self._careerclick = SLFramework.UGUI.UIClickListener.Get(self._imagecareericon.gameObject)
	self._signatureClick = SLFramework.UGUI.UIClickListener.Get(self._simagesignature.gameObject)
	self._enableSwitchDrawing = false
	self._gopifu = gohelper.findChild(self.viewGO, "anim/bottom/#pifu")

	gohelper.setActive(self._gopifu, self._enableSwitchDrawing)
	self:_addListener()

	self._originSpineRootPosX = recthelper.getAnchorX(self._goherocontainer.transform)
	self._animator = ZProj.ProjAnimatorPlayer.Get(self.viewGO)
	self._herocontainerCanvasGroup = self._goherocontainer:GetComponent(typeof(UnityEngine.CanvasGroup))
	self._hasMoveIcon = false

	gohelper.setActive(self._goattributenode, true)
	self._animatorattributetipsnode:Play("close", 0, 1)

	self._talentRedType1 = gohelper.findChild(self._gotalentreddot, "type1")
	self._talentRedNew = gohelper.findChild(self._gotalentreddot, "new")
end

function CharacterView:_findPassiveskillitems(index)
	local o = self:getUserDataTb_()

	o.go = gohelper.findChild(self._gopassiveskills, "passiveskill" .. index)
	o.on = gohelper.findChild(o.go, "on")
	o.off = gohelper.findChild(o.go, "off")

	return o
end

function CharacterView:_refreshHelp()
	if self._heroMO then
		local isOwnHero = self:isOwnHero()
		local showHelp = HelpModel.instance:isShowedHelp(HelpEnum.HelpId.Character)

		gohelper.setActive(self._btnhelp.gameObject, showHelp and self._heroMO)
	end
end

function CharacterView:_takeoffAllTalentCube()
	HeroRpc.instance:TakeoffAllTalentCubeRequest(self._heroMO.heroId)
end

function CharacterView:_addDrag()
	if not self._drag then
		return
	end

	self._drag:AddDragBeginListener(self._onDragBegin, self)
	self._drag:AddDragListener(self._onDrag, self)
	self._drag:AddDragEndListener(self._onDragEnd, self)
	self._signatureDrag:AddDragBeginListener(self._onDragBegin, self)
	self._signatureDrag:AddDragListener(self._onDrag, self)
	self._signatureDrag:AddDragEndListener(self._onDragEnd, self)
end

function CharacterView:_addListener()
	self._trustclick:AddClickListener(self._onOpenTrustTip, self)
	self._careerclick:AddClickListener(self._onOpenCareerTip, self)
	self._signatureClick:AddClickListener(self._switchDrawingOnClick, self)
	self.addEventCb(self, CharacterController.instance, CharacterEvent.TakeoffAllTalentCube, self._takeoffAllTalentCube, self)
	self.addEventCb(self, CharacterController.instance, CharacterEvent.successHeroRankUp, self._refreshView, self)
	self.addEventCb(self, CharacterController.instance, CharacterEvent.successHeroLevelUp, self._refreshView, self)
	self.addEventCb(self, CharacterController.instance, CharacterEvent.successHeroTalentUp, self._refreshView, self)
	self.addEventCb(self, CharacterController.instance, CharacterEvent.successHeroExSkillUp, self._refreshView, self)
	self.addEventCb(self, CharacterController.instance, CharacterEvent.successDressUpSkin, self._successDressUpSkin, self)
	self.addEventCb(self, RedDotController.instance, RedDotEvent.RefreshClientCharacterDot, self._refreshRedDot, self)
	self.addEventCb(self, CharacterController.instance, CharacterEvent.levelUpAttribute, self._onAttributeChanged, self)
	self.addEventCb(self, CharacterController.instance, CharacterEvent.HeroUpdatePush, self._onAttributeChanged, self)
	self.addEventCb(self, CharacterController.instance, CharacterEvent.showCharacterRankUpView, self._showCharacterRankUpView, self)
	self.addEventCb(self, CharacterController.instance, CharacterEvent.OnMarkFavorSuccess, self._markFavorSuccess, self)
	self.addEventCb(self, HelpController.instance, HelpEvent.RefreshHelp, self._refreshHelp, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnOpenFullView, self._onOpenFullView, self, LuaEventSystem.Low)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnOpenFullViewFinish, self._onOpenFullViewFinish, self, LuaEventSystem.Low)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnOpenView, self._onOpenView, self, LuaEventSystem.Low)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnOpenViewFinish, self._onOpenViewFinish, self, LuaEventSystem.Low)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseViewFinish, self._onCloseViewFinish, self, LuaEventSystem.Low)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseFullView, self._onCloseFullView, self, LuaEventSystem.Low)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseView, self._onCloseView, self, LuaEventSystem.Low)
	self.addEventCb(self, EquipController.instance, EquipEvent.onUpdateEquip, self.onEquipChange, self)
	self.addEventCb(self, EquipController.instance, EquipEvent.onDeleteEquip, self.onEquipChange, self)
end

function CharacterView:_markFavorSuccess()
	self._heroMO = HeroModel.instance:getByHeroId(self._heroMO.heroId)

	self:_refreshBtn()
end

function CharacterView:_onApplicationPause(isFront)
	if isFront then
		self:_resetSpinePos(false)
	end
end

function CharacterView:_setModelVisible(value)
	TaskDispatcher.cancelTask(self._delaySetModelHide, self)

	if not self:isSpineInView() then
		return
	end

	if value then
		self._uiSpine:setLayer(UnityLayer.Unit)
		self._uiSpine:setModelVisible(value)
		self._uiSpine:showModelEffect()
	else
		self._uiSpine:setLayer(UnityLayer.Water)
		self._uiSpine:hideModelEffect()
		TaskDispatcher.runDelay(self._delaySetModelHide, self, 1)
	end
end

function CharacterView:_delaySetModelHide()
	if not self:isSpineInView() then
		return
	end

	if self._uiSpine then
		self._uiSpine:setModelVisible(false)
	end
end

function CharacterView:_showCharacterRankUpView(func)
	if not self._uiSpine then
		return
	end

	self:_setModelVisible(false)

	if func then
		self:playCloseViewAnim(func)
	end
end

function CharacterView:_onOpenView(viewName)
	return
end

function CharacterView:_onOpenViewFinish(viewName)
	if viewName == ViewName.CharacterRankUpResultView and self._uiSpine then
		self._uiSpine:hideModelEffect()
	end

	if viewName == ViewName.CharacterRecommedView then
		self:playAnim(UIAnimationName.Open)
	end

	if viewName ~= ViewName.CharacterGetView then
		return
	end

	if self._uiSpine then
		self:_setModelVisible(false)
	end
end

function CharacterView:_successDressUpSkin()
	self.needSwitchSkin = true
end

function CharacterView:_onCloseView(viewName)
	if ViewHelper.instance:checkViewOnTheTop(self.viewName) then
		self:setShaderKeyWord()

		if self.needSwitchSkin then
			self:_refreshSkin()

			self.needSwitchSkin = false
		end
	end

	if viewName == ViewName.CharacterLevelUpView then
		gohelper.setActive(self._goattributenode, true)
		self._animatorattributetipsnode:Play("close", 0, 0)
	end

	if viewName == ViewName.CharacterRecommedView then
		self:_refreshSkin()
	end
end

function CharacterView:_onCloseViewFinish(viewName)
	if ViewHelper.instance:checkViewOnTheTop(self.viewName) then
		self:setShaderKeyWord()
	end

	if viewName == ViewName.CharacterRankUpResultView and self._uiSpine then
		self._uiSpine:showModelEffect()
	end

	if viewName ~= ViewName.CharacterGetView then
		return
	end

	if not self._uiSpine then
		return
	end

	self:_setModelVisible(true)
end

function CharacterView:_onOpenFullView(viewName)
	if not self._uiSpine or viewName == ViewName.CharacterView or viewName == ViewName.CharacterRecommedView then
		return
	end

	self:_setModelVisible(false)
end

function CharacterView:_onOpenFullViewFinish(viewName)
	if ViewMgr.instance:isOpen(ViewName.CharacterGetView) then
		return
	end

	if not self._uiSpine or viewName == ViewName.CharacterView or viewName == ViewName.CharacterRecommedView then
		return
	end

	if viewName ~= ViewName.CharacterView then
		self._uiSpine:stopVoice()
	else
		return
	end

	self:_setModelVisible(self.viewContainer._isVisible)
end

function CharacterView:_onCloseFullView(viewName)
	if self._animator and self:isEnterCharacterView() then
		self:playAnim(UIAnimationName.Open)

		local equipView = self.viewContainer:getEquipView()

		equipView:playOpenAnim()

		local destinyView = self.viewContainer:getDestinyView()

		destinyView:playOpenAnim()
	end

	if ViewMgr.instance:isOpen(ViewName.CharacterGetView) then
		return
	end

	if not self._uiSpine then
		return
	end

	self:_setModelVisible(self.viewContainer._isVisible)

	if viewName == ViewName.CharacterRankUpResultView then
		self:_checkPlaySpecialBodyMotion()

		if self._skillContainer then
			self._skillContainer:checkShowReplaceBeforeSkillUI()
		end
	end

	self:_checkGuide()
end

function CharacterView:isSpineInView()
	return gohelper.findChild(self.viewGO, "anim/#go_herocontainer/dynamiccontainer")
end

function CharacterView:isEnterCharacterView()
	local viewlist = ViewMgr.instance:getOpenViewNameList()

	for i = #viewlist, 1, -1 do
		local setting = ViewMgr.instance:getSetting(viewlist[i])

		if setting.layer == ViewMgr.instance:getSetting(self.viewName).layer then
			return viewlist[i] == self.viewName
		end
	end

	return false
end

function CharacterView:onOpenFinish()
	self:_addDrag()

	self._isOpenFinish = true

	if self._spineLoadedFinish then
		self:_onSpineLoaded()
	end

	if not GuideModel.instance:isGuideRunning(GuideEnum.VerticalDrawingSwitchingGuide) or not self._showSwitchDrawingGuide then
		local helpShowView = self.viewContainer.helpShowView

		helpShowView:setHelpId(HelpEnum.HelpId.Character)
		helpShowView:setDelayTime(0.5)
		helpShowView:tryShowHelp()
	end
end

function CharacterView:_onOpenTrustTip()
	logNormal("打开信赖值tip, 达到下一百分比羁绊值需要 " .. self.nextFaith .. " 的羁绊值")
end

function CharacterView:_onOpenCareerTip()
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Mission_switch)
	ViewMgr.instance:openView(ViewName.HeroGroupCareerTipView)
end

function CharacterView:_closeLevelUpview()
	if ViewMgr.instance:isOpen(ViewName.CharacterLevelUpView) then
		ViewMgr.instance:closeView(ViewName.CharacterLevelUpView, nil, true)
	end
end

function CharacterView:_btncloseOnClick()
	self:_closeLevelUpview()
	self:closeThis()
end

function CharacterView:_btnhomeOnClick()
	self:_closeLevelUpview()
	NavigateButtonsView.homeClick()
end

function CharacterView:_btndataOnClick()
	self:_closeLevelUpview()

	local function func()
		CharacterController.instance:openCharacterDataView(self._heroMO.heroId)
	end

	self:playCloseViewAnim(func)
end

function CharacterView:_btnskinOnClick()
	self:_closeLevelUpview()

	if self._uiSpine then
		self:_setModelVisible(false)
	end

	local function func()
		CharacterController.instance:openCharacterSkinView(self._heroMO)
	end

	self:playCloseViewAnim(func)
end

function CharacterView:_btnfavorOnClick()
	local isFavor = not self._heroMO.isFavor

	if isFavor then
		local favorHeros = HeroModel.instance:getAllFavorHeros()

		if #favorHeros >= CommonConfig.instance:getConstNum(ConstEnum.MaxFavorHeroCount) then
			GameFacade.showToast(ToastEnum.OverFavorMaxCount)

			return
		end
	end

	local heroId = self._heroMO.heroId

	HeroRpc.instance:setMarkHeroFavorRequest(heroId, isFavor)
end

function CharacterView:_btnhelpOnClick()
	self:_closeLevelUpview()
	HelpController.instance:showHelp(HelpEnum.HelpId.Character)
end

function CharacterView:_btnrecommedOnClick()
	local function func()
		CharacterRecommedController.instance:openRecommedView(self._heroMO.heroId, self.viewName, self._uiSpine)
	end

	self:playCloseViewAnim(func)
end

function CharacterView:_btnattributeOnClick()
	local info = {}

	info.tag = "attribute"
	info.heroMo = self._heroMO
	info.heroid = self._heroMO.heroId

	local defaultEquipUid = self._heroMO.defaultEquipUid

	if not string.nilorempty(defaultEquipUid) then
		info.equips = {
			defaultEquipUid
		}
	end

	info.trialEquipMo = self._heroMO.trialEquipMo

	CharacterController.instance:openCharacterTipView(info)
end

function CharacterView:_btnlevelOnClick()
	CharacterController.instance:openCharacterLevelUpView(self._heroMO, ViewName.CharacterView)
	self._animatorattributetipsnode:Play("open", 0, 0)
	gohelper.setActive(self._goattributenode, false)
end

function CharacterView:_btnrankOnClick()
	if not self._uiSpine then
		return
	end

	self:_setModelVisible(false)

	local function func()
		CharacterController.instance:openCharacterRankUpView(self._heroMO)
	end

	self:playCloseViewAnim(func)
end

function CharacterView:_btnpassiveskillOnClick()
	local info = {}

	info.tag = "passiveskill"
	info.heroid = self._heroMO.heroId
	info.anchorParams = {
		Vector2.New(1, 0.5),
		Vector2.New(1, 0.5)
	}
	info.tipPos = Vector2.New(-292, -51.1)
	info.buffTipsX = -770
	info.heroMo = self._heroMO
	info.defaultVNP = 1

	CharacterController.instance:openCharacterTipView(info)
end

function CharacterView:_btnexskillOnClick()
	if self._heroMO and self._heroMO:isNoShowExSkill() then
		GameFacade.showToast(ToastEnum.TrialHeroClickExSkill)

		return
	end

	local function func()
		CharacterController.instance:openCharacterExSkillView({
			heroId = self._heroMO.heroId,
			heroMo = self._heroMO,
			fromHeroDetailView = self._fromHeroDetailView,
			hideTrialTip = self._hideTrialTip
		})
	end

	self:playCloseViewAnim(func)
end

function CharacterView:_btntalentOnClick()
	local isOtherPlayerHero = self._heroMO:isOtherPlayerHero()

	if isOtherPlayerHero then
		local isOpenTalent = self._heroMO:getOtherPlayerIsOpenTalent()

		if not isOpenTalent then
			GameFacade.showToast(ToastEnum.TalentNotUnlock)

			return
		end
	end

	local isTrial = self._heroMO:isTrial()

	if OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Talent) or isTrial or isOtherPlayerHero then
		if self._heroMO.rank < CharacterEnum.TalentRank then
			if self._heroMO.config.heroType == CharacterEnum.HumanHeroType then
				GameFacade.showToast(ToastEnum.CharacterType6, self._heroMO.config.name)
			else
				GameFacade.showToast(ToastEnum.Character, self._heroMO.config.name)
			end

			return
		end

		local isOwnHero = self:isOwnHero()

		if not isOwnHero then
			CharacterController.instance:openCharacterTalentTipView({
				open_type = 0,
				isTrial = true,
				hero_id = self._heroMO.heroId,
				hero_mo = self._heroMO,
				isOwnHero = isOwnHero
			})

			return
		end

		CharacterController.instance:setTalentHeroId(self._heroMO.heroId)

		local function func()
			CharacterController.instance:openCharacterTalentView({
				heroid = self._heroMO.heroId,
				heroMo = self._heroMO
			})
		end

		self:playCloseViewAnim(func)
	else
		GameFacade.showToast(OpenModel.instance:getFuncUnlockDesc(OpenEnum.UnlockFunc.Talent))
	end
end

function CharacterView:_switchDrawingOnClick()
	if not self._enableSwitchDrawing or self._isDragingSpine then
		return
	end

	AudioMgr.instance:trigger(AudioEnum.UI.UI_Common_Click)

	local config = SkinConfig.instance:getSkinCo(self._heroMO.skin)
	local state = CharacterDataConfig.instance:getCharacterDrawingState(config.characterId)

	state = state == CharacterEnum.DrawingState.Static and CharacterEnum.DrawingState.Dynamic or CharacterEnum.DrawingState.Static

	CharacterDataConfig.instance:setCharacterDrawingState(config.characterId, state)
	self:_refreshDrawingState()
end

function CharacterView:_initExternalParams()
	local externalParam = CharacterView._externalParam

	self._hideHomeBtn = externalParam and externalParam.hideHomeBtn
	self._isOwnHero = externalParam and externalParam.isOwnHero
	self._fromHeroDetailView = externalParam and externalParam.fromHeroDetailView
	self._hideTrialTip = externalParam and externalParam.hideTrialTip

	self.viewContainer:setIsOwnHero(externalParam)

	CharacterView._externalParam = nil
end

function CharacterView:onOpen()
	self:_initExternalParams()

	self._heroMO = self.viewParam
	self._playGreetingVoices = true
	self._spineNeedHide = true

	self:_refreshView()
	NavigateMgr.instance:addEscape(ViewName.CharacterView, self._btncloseOnClick, self)
	self:_checkGuide()
	self:_refreshCharacter()
end

function CharacterView:_refreshCharacter()
	if self._skillContainer then
		self._skillContainer:checkShowReplaceBeforeSkillUI()
	end

	self:_refreshRecommedBtn()

	local destinyView = self.viewContainer:getDestinyView()

	destinyView:refreshUI(self._heroMO)
end

function CharacterView:_refreshRecommedBtn()
	local isOpenSummonView = ViewMgr.instance:isOpen(ViewName.CharacterBackpackView)

	gohelper.setActive(self._btnrecommed.gameObject, (isOpenSummonView or nil) and CharacterRecommedModel.instance:isShowRecommedView(self._heroMO.heroId))
end

function CharacterView:_refreshRedDot()
	local isOwnHero = self:isOwnHero()

	if not isOwnHero then
		gohelper.setActive(self._goexskillreddot, false)
		gohelper.setActive(self._gorankreddot, false)
		gohelper.setActive(self._godatareddot, false)
		self:_showRedDot(false)

		return
	end

	local exskillshow = CharacterModel.instance:isHeroCouldExskillUp(self._heroMO.heroId)

	gohelper.setActive(self._goexskillreddot, exskillshow)

	local rankshow = CharacterModel.instance:isHeroCouldRankUp(self._heroMO.heroId)

	gohelper.setActive(self._gorankreddot, rankshow)

	local datashow = CharacterModel.instance:hasCultureRewardGet(self._heroMO.heroId) or CharacterModel.instance:hasItemRewardGet(self._heroMO.heroId)

	gohelper.setActive(self._godatareddot, datashow)
	self:_refreshTalentRed()
end

function CharacterView:_showRedDot(isShow, type)
	if isShow then
		gohelper.setActive(self._gotalentreddot, true)
		gohelper.setActive(self._talentRedType1, type == 1)
		gohelper.setActive(self._talentRedNew, type == 2)
	else
		gohelper.setActive(self._gotalentreddot, false)
	end
end

function CharacterView:_refreshTalentRed()
	local isTalentUp = CharacterModel.instance:heroTalentRedPoint(self._heroMO.heroId)
	local isTalentStyleNew = self._heroMO.isShowTalentStyleRed
	local redType = isTalentStyleNew and 2 or isTalentUp and 1 or 0

	self:_showRedDot(true, redType)
end

function CharacterView:_refreshView()
	self:_unmarkNew()
	self:_refreshBtn()
	self:_refreshSkill()
	self:_refreshDrawingState()
	self:_refreshSpine()
	self:_refreshInfo()
	self:_refreshCareer()
	self:_refreshAttribute()
	self:_refreshLevel()
	self:_refreshRank()
	self:_refreshPassiveSkill()
	self:_refreshExSkill()
	self:_refreshTalent()
	self:_refreshSignature()
	self:_refreshRedDot()
	self:_refreshReshape()
end

function CharacterView:isOwnHero()
	if self._isOwnHero ~= nil then
		return self._isOwnHero
	end

	return self._heroMO and self._heroMO:isOwnHero()
end

function CharacterView:_refreshBtn()
	local isOwnHero = self:isOwnHero()
	local showHelp = HelpModel.instance:isShowedHelp(HelpEnum.HelpId.Character)

	gohelper.setActive(self._btnhome.gameObject, not self._hideHomeBtn)
	gohelper.setActive(self._btnhelp.gameObject, showHelp and isOwnHero)
	gohelper.setActive(self._btnskin.gameObject, CharacterEnum.SkinOpen and isOwnHero)
	gohelper.setActive(self._btnfavor.gameObject, isOwnHero)
	gohelper.setActive(self._btndata.gameObject, isOwnHero)
	gohelper.setActive(self._btnlevel.gameObject, isOwnHero)
	gohelper.setActive(self._btnrank.gameObject, isOwnHero)
	gohelper.setActive(self._golevelimage, isOwnHero)
	gohelper.setActive(self._golevelicon.gameObject, isOwnHero)
	gohelper.setActive(self._gorankicon, isOwnHero)
	gohelper.setActive(self._gorankimage, isOwnHero)
	gohelper.setActive(self._golevelimagetrial, not isOwnHero)
	gohelper.setActive(self._gorankimagetrial, not isOwnHero)

	if not isOwnHero and not self._hasMoveIcon then
		recthelper.setAnchorX(self._gorankeyes.transform, recthelper.getAnchorX(self._gorankeyes.transform) + CharacterView.RankIconOffset)
		recthelper.setAnchorX(self._goranklights.transform, recthelper.getAnchorX(self._goranklights.transform) + CharacterView.RankIconOffset)

		self._hasMoveIcon = true
	end

	UISpriteSetMgr.instance:setCommonSprite(self._imagefavor, self._heroMO.isFavor and "btn_favor_light" or "btn_favor_dark")
end

function CharacterView:_refreshSkin()
	self._spineNeedHide = true

	self:_refreshDrawingState()
	self:_refreshSpine()
end

function CharacterView:_unmarkNew()
	if self._heroMO and self._heroMO.isNew then
		HeroRpc.instance:sendUnMarkIsNewRequest(self._heroMO.heroId)
	end
end

function CharacterView:_onDragBegin(param, pointerEventData)
	self._startPos = pointerEventData.position.x

	self:playAnim(UIAnimationName.SwitchClose)

	self._isDragingSpine = true

	if self._uiSpine then
		self._uiSpine:showDragEffect(false)
	end
end

function CharacterView:_onDrag(param, pointerEventData)
	if not self._isDragingSpine then
		return
	end

	local curPos = pointerEventData.position.x
	local moveSmooth = 1
	local curSpineRootPosX = recthelper.getAnchorX(self._goherocontainer.transform)

	curSpineRootPosX = curSpineRootPosX + pointerEventData.delta.x * moveSmooth

	recthelper.setAnchorX(self._goherocontainer.transform, curSpineRootPosX)

	local alphaSmooth = 0.001

	self._herocontainerCanvasGroup.alpha = 1 - Mathf.Abs(self._startPos - curPos) * alphaSmooth
end

function CharacterView:_onDragEnd(param, pointerEventData)
	if not self._isDragingSpine then
		return
	end

	if self._uiSpine then
		self._uiSpine:showDragEffect(true)
	end

	local endPos = pointerEventData.position.x
	local isDrag2Left = false
	local isSwitchSpineSucc = false

	if endPos > self._startPos and endPos - self._startPos >= 300 then
		local nextmo = CharacterBackpackCardListModel.instance:getLastCharacterCard(self._heroMO.heroId)

		if nextmo then
			AudioMgr.instance:trigger(AudioEnum.UI.play_ui_character_view_switch)

			self._heroMO = nextmo
			self.viewContainer.viewParam = self._heroMO
			self._playGreetingVoices = true
			self._delayPlayVoiceTime = 0.3
			isSwitchSpineSucc = true
			self._spineNeedHide = true

			self:_refreshView()
			self:_refreshCharacter()
			CharacterController.instance:dispatchEvent(CharacterEvent.RefreshDefaultEquip, self._heroMO)
			CharacterController.instance:dispatchEvent(CharacterEvent.OnSwitchSpine, self._heroMO)
		end
	elseif endPos < self._startPos and self._startPos - endPos >= 300 then
		local lastmo = CharacterBackpackCardListModel.instance:getNextCharacterCard(self._heroMO.heroId)

		if lastmo then
			AudioMgr.instance:trigger(AudioEnum.UI.play_ui_character_view_switch)

			self._heroMO = lastmo
			self.viewContainer.viewParam = self._heroMO
			self._playGreetingVoices = true
			self._delayPlayVoiceTime = 0.3
			isSwitchSpineSucc = true
			self._spineNeedHide = true

			self:_refreshView()
			self:_refreshCharacter()
			CharacterController.instance:dispatchEvent(CharacterEvent.RefreshDefaultEquip, self._heroMO)
			CharacterController.instance:dispatchEvent(CharacterEvent.OnSwitchSpine, self._heroMO)

			isDrag2Left = true
		end
	end

	self:_resetSpinePos(isSwitchSpineSucc, isDrag2Left)

	self._isDragingSpine = false
end

function CharacterView:_cutCharacter(heroId)
	self._heroMO = HeroModel.instance:getByHeroId(heroId)
	self.viewContainer.viewParam = self._heroMO
	self._playGreetingVoices = true
	self._delayPlayVoiceTime = 0.3
	self._spineNeedHide = true

	self:_refreshView()
	self:_refreshCharacter()
	CharacterController.instance:dispatchEvent(CharacterEvent.RefreshDefaultEquip, self._heroMO)
	CharacterController.instance:dispatchEvent(CharacterEvent.OnSwitchSpine, self._heroMO)
end

function CharacterView:_resetSpinePos(isSwitchSpineSucc, isDrag2Left)
	local leftPrePos = -800
	local rightPrePos = 800
	local originTargetPos = recthelper.getAnchorX(self._goherocontainer.transform)

	if isSwitchSpineSucc then
		recthelper.setAnchorX(self._goherocontainer.transform, isDrag2Left and leftPrePos or rightPrePos)
	end

	ZProj.UGUIHelper.RebuildLayout(self._goherocontainer.transform)

	local switchFailMoveTime = 0.3
	local switchSuccMoveTime = 0.5
	local targetSwitchTime = isSwitchSpineSucc and switchSuccMoveTime or switchFailMoveTime

	if self._dragTweenId then
		ZProj.TweenHelper.KillById(self._dragTweenId)
	end

	self._dragTweenId = ZProj.TweenHelper.DOAnchorPosX(self._goherocontainer.transform, self._originSpineRootPosX, targetSwitchTime, nil, self, nil, EaseType.OutQuart)

	self:playAnim(UIAnimationName.SwitchOpen)

	local equipView = self.viewContainer:getEquipView()

	equipView:playOpenAnim()

	local destinyView = self.viewContainer:getDestinyView()

	destinyView:playOpenAnim()

	self._herocontainerCanvasGroup.alpha = 1
end

function CharacterView:_refreshSignature()
	local config = self._heroMO.config

	self._simagesignature:UnLoadImage()
	self._simagesignature:LoadImage(ResUrl.getSignature(config.signature))
end

function CharacterView:_refreshSpine()
	if not self:isSpineInView() then
		if self._uiSpine then
			TaskDispatcher.cancelTask(self._playSpineVoice, self)
			self._uiSpine:stopVoice()
		end

		return
	end

	if self._uiSpine then
		TaskDispatcher.cancelTask(self._playSpineVoice, self)
		self._uiSpine:onDestroy()
		self._uiSpine:stopVoice()

		self._uiSpine = nil
	end

	self._uiSpine = GuiModelAgent.Create(self._gospine, true)

	local skinCo = SkinConfig.instance:getSkinCo(self._heroMO.skin)

	self._uiSpine:setResPath(skinCo, self._onSpineLoaded, self)

	local offsets = SkinConfig.instance:getSkinOffset(skinCo.characterViewOffset)

	CharacterVoiceEnum.setSpineOffset(self._uiSpine, tonumber(offsets[1]), tonumber(offsets[2]))
	transformhelper.setLocalScale(self._gospine.transform, tonumber(offsets[3]), tonumber(offsets[3]), tonumber(offsets[3]))

	local haloOffset = SkinConfig.instance:getSkinOffset(skinCo.haloOffset)
	local haloX = tonumber(haloOffset[1])
	local haloY = tonumber(haloOffset[2])
	local haloScale = tonumber(haloOffset[3])

	recthelper.setAnchor(self._simageplayerbg.transform, haloX, haloY)
	transformhelper.setLocalScale(self._simageplayerbg.transform, haloScale, haloScale, haloScale)
end

function CharacterView:_onSpineLoaded()
	if self._uiSpine then
		self._uiSpine:initSkinDragEffect(self._heroMO.skin)
	end

	self._spineLoadedFinish = true

	if not self._isOpenFinish then
		return
	end

	if not self._playGreetingVoices then
		return
	end

	if not self._uiSpine then
		return
	end

	if not self._gospine.activeInHierarchy then
		return
	end

	self._playGreetingVoices = nil

	local heroId = self._heroMO.heroId
	local state = CharacterDataConfig.instance:getCharacterDrawingState(heroId)

	if ViewMgr.instance:isOpen(ViewName.CharacterRankUpView) then
		return
	end

	if state == CharacterEnum.DrawingState.Dynamic then
		if self:isOwnHero() then
			self._greetingVoices = HeroModel.instance:getVoiceConfig(heroId, CharacterEnum.VoiceType.Greeting)
		else
			self._greetingVoices = {}

			local voices = CharacterDataConfig.instance:getCharacterVoicesCo(heroId)

			if voices then
				for _, voiceCfg in pairs(voices) do
					if voiceCfg.type == CharacterEnum.VoiceType.Greeting and CharacterDataConfig.instance:checkVoiceSkin(voiceCfg, self._heroMO.skin) then
						table.insert(self._greetingVoices, voiceCfg)
					end
				end
			end
		end

		if self._greetingVoices and #self._greetingVoices > 0 then
			self._delayTime = self._delayPlayVoiceTime or 0

			if self._uiSpine:isLive2D() then
				self._uiSpine:setLive2dCameraLoadFinishCallback(self.onLive2dCameraLoadedCallback, self)

				return
			end

			self:_startDelayPlayVoice(self._delayTime)

			self._delayPlayVoiceTime = 0
		end
	end
end

function CharacterView:onLive2dCameraLoadedCallback()
	self._uiSpine:setLive2dCameraLoadFinishCallback(nil, nil)
	self:_startDelayPlayVoice(self._delayTime)
end

function CharacterView:_startDelayPlayVoice(time)
	time = time or 0
	self._repeatNum = math.max(time * 30, CharacterVoiceEnum.DelayFrame + 1)
	self._repeatCount = 0

	TaskDispatcher.cancelTask(self._playSpineVoice, self)
	TaskDispatcher.runRepeat(self._playSpineVoice, self, 0, self._repeatNum)
end

function CharacterView:_playSpineVoice()
	if not self:isSpineInView() then
		return
	end

	self._repeatCount = self._repeatCount + 1

	if self._repeatCount < self._repeatNum then
		return
	end

	if not self._uiSpine then
		return
	end

	if self:_checkPlaySpecialBodyMotion() then
		return
	end

	self._uiSpine:playVoice(self._greetingVoices[1], nil, self._txtanacn, self._txtanaen, self._gocontentbg)
end

function CharacterView:_refreshDrawingState()
	if not self:isSpineInView() then
		return
	end

	local static = false
	local config = SkinConfig.instance:getSkinCo(self._heroMO.skin)

	if config.showDrawingSwitch == 1 then
		self._enableSwitchDrawing = true

		local state = CharacterDataConfig.instance:getCharacterDrawingState(config.characterId)

		if state == CharacterEnum.DrawingState.Static then
			static = true
		end
	else
		self._enableSwitchDrawing = false

		CharacterDataConfig.instance:setCharacterDrawingState(config.characterId, CharacterEnum.DrawingState.Dynamic)
	end

	if self._heroMO.isSettingSkinOffset then
		static = true
	end

	if self._spineNeedHide and static then
		gohelper.setActive(self._godynamiccontainer, false)
	else
		gohelper.setActive(self._godynamiccontainer, true)
	end

	self._spineNeedHide = false

	local scale = static and 0.01 or 1

	transformhelper.setLocalScale(self._godynamiccontainer.transform, scale, scale, scale)

	if not static then
		self._uiSpine:hideModelEffect()
		self._uiSpine:showModelEffect()
	end

	gohelper.setActive(self._gostaticcontainer, static)

	if static then
		self._playGreetingVoices = nil

		if self._uiSpine then
			self._uiSpine:stopVoice()
		end

		self._simagestatic:LoadImage(ResUrl.getHeadIconImg(config.drawing), self._loadedImage, self)
	else
		self._simagestatic:UnLoadImage()
		self:_setModelVisible(true)
	end

	gohelper.setActive(self._gopifu, self._enableSwitchDrawing)
end

function CharacterView:_checkGuide()
	self._showSwitchDrawingGuide = false

	if not self._enableSwitchDrawing then
		return
	end

	if not self.viewContainer._isVisible then
		return
	end

	local showGuide = false
	local heroList = HeroModel.instance:getList()

	for i, v in ipairs(heroList) do
		if v.rank > 1 and v.config.rare >= 3 then
			showGuide = true

			break
		end
	end

	if showGuide then
		CharacterController.instance:dispatchEvent(CharacterEvent.OnGuideSwitchDrawing)
	end

	self._showSwitchDrawingGuide = showGuide
end

function CharacterView:_loadedImage()
	if not self:isSpineInView() then
		return
	end

	local config = SkinConfig.instance:getSkinCo(self._heroMO.skin)

	gohelper.onceAddComponent(self._simagestatic.gameObject, gohelper.Type_Image):SetNativeSize()

	local offsetStr = config.characterViewImgOffset

	if not string.nilorempty(offsetStr) then
		local offsets = string.splitToNumber(offsetStr, "#")

		recthelper.setAnchor(self._simagestatic.transform, tonumber(offsets[1]), tonumber(offsets[2]))
		transformhelper.setLocalScale(self._simagestatic.transform, tonumber(offsets[3]), tonumber(offsets[3]), tonumber(offsets[3]))
	else
		recthelper.setAnchor(self._simagestatic.transform, 0, 0)
		transformhelper.setLocalScale(self._simagestatic.transform, 1, 1, 1)
	end
end

function CharacterView:_refreshInfo()
	for i = 1, 6 do
		gohelper.setActive(self._rareStars[i], i <= CharacterEnum.Star[self._heroMO.config.rare])
	end

	UISpriteSetMgr.instance:setCharactergetSprite(self._imagecareericon, "charactercareer" .. tostring(self._heroMO.config.career))
	UISpriteSetMgr.instance:setCommonSprite(self._imagedmgtype, "dmgtype" .. tostring(self._heroMO.config.dmgType))

	local percent = self:_getFaithPercent()

	self._txttrust.text = percent * 100 .. "%"

	self._slidertrust:SetValue(percent)

	self._txtnamecn.text = self._heroMO:getHeroName()
	self._txtnameen.text = self._heroMO.config.nameEng
	self._txttalentcn.text = luaLang("talent_character_talentcn" .. self._heroMO:getTalentTxtByHeroType())
	self._txttalenten.text = luaLang("talent_character_talenten" .. self._heroMO:getTalentTxtByHeroType())
end

function CharacterView:_getFaithPercent()
	local result = HeroConfig.instance:getFaithPercent(self._heroMO.faith)

	self.nextFaith = result[2]

	return result[1]
end

function CharacterView:_refreshReshape()
	local rot = 0

	if self._heroMO.destinyStoneMo then
		local co = self._heroMO.destinyStoneMo:isEquipReshape()

		if co ~= nil then
			rot = 180
		end
	end

	transformhelper.setLocalRotation(self._goexskills.transform, rot, 0, 0)
end

function CharacterView:_refreshCareer()
	local battleTag = self._heroMO:getHeroBattleTag()
	local tags = {}

	if not string.nilorempty(battleTag) then
		tags = string.split(battleTag, "#")
	end

	for i, tag in ipairs(tags) do
		local item = self:_getCareerItem(i)

		item.txt.text = HeroConfig.instance:getBattleTagConfigCO(tag).tagName
	end

	for i = 1, #self._careerlabels do
		gohelper.setActive(self._careerlabels[i].go, i <= #tags)
	end
end

function CharacterView:_getCareerItem(index)
	local item = self._careerlabels[index]

	if not item then
		item = self:getUserDataTb_()
		item.go = gohelper.cloneInPlace(self._careeritem, "career_" .. index)
		item.txt = item.go:GetComponent(gohelper.Type_TextMesh)
		self._careerlabels[index] = item
	end

	return item
end

function CharacterView:_onAttributeChanged(level, heroId)
	if not heroId or heroId == self._heroMO.heroId then
		self:_refreshAttribute(level)
	end
end

function CharacterView:onEquipChange()
	if not self.viewParam:hasDefaultEquip() then
		return
	end

	self:_refreshAttribute()
end

function CharacterView:_getOtherEquipAddValues(equipMo)
	local _equipHp, _equipAtk, _equipDef, _equipMdef, _equipBreakAddPercentValuesDict, otherEquipMo

	if self._heroMO.heroId == CharacterEnum.TwinssychubeHeroId then
		local trialEquipMo = self._heroMO.trialEquipMo

		if trialEquipMo then
			local otherEquipId = EquipModel.instance:getOtherTwinssychubeEquipId(trialEquipMo.equipId)

			if otherEquipId then
				otherEquipMo = EquipMO.New()

				local co = {
					equipId = otherEquipId,
					equipLv = trialEquipMo.level,
					equipRefine = trialEquipMo.refineLv
				}

				otherEquipMo:initByTrialCO(co)
			end
		elseif equipMo then
			::label_82_0::

			local otherEquipId = EquipModel.instance:getOtherTwinssychubeEquipId(equipMo.equipId)

			otherEquipMo = EquipModel.instance:getTwinssychubeEquipMo(otherEquipId)
		end
	end

	if otherEquipMo then
		_equipHp, _equipAtk, _equipDef, _equipMdef = EquipConfig.instance:getEquipAddBaseAttr(otherEquipMo)
		_equipBreakAddPercentValuesDict = EquipConfig.instance:getEquipBreakAddAttrValueDict(otherEquipMo.config, otherEquipMo.breakLv)
	end

	return _equipHp, _equipAtk, _equipDef, _equipMdef, _equipBreakAddPercentValuesDict
end

function CharacterView:_refreshAttribute(level)
	local heroMo = self._heroMO
	local heroAttrDict = heroMo:getHeroBaseAttrDict(level)
	local talentAttrDict = HeroConfig.instance:talentGainTab2IDTab(heroMo:getTalentGain(level))
	local destinyStoneMo = heroMo.destinyStoneMo
	local destinyStoneValues = destinyStoneMo:getAddAttrValues()
	local equipAttrDict = {}

	for _, attrId in ipairs(CharacterView.AttrIdList) do
		equipAttrDict[attrId] = 0
	end

	local isOtherPlayerHero = self._heroMO:isOtherPlayerHero()
	local hasDefaultEquip = self._heroMO:hasDefaultEquip()

	if not isOtherPlayerHero and hasDefaultEquip then
		if self._heroMO then
			local equipMo = self._heroMO:getTrialEquipMo()

			equipMo = equipMo or EquipModel.instance:getEquip(self._heroMO.defaultEquipUid)

			local _equipHp, _equipAtk, _equipDef, _equipMdef, _equipBreakAddPercentValuesDict = self:_getOtherEquipAddValues(equipMo)
			local equipHp, equipAtk, equipDef, equipMdef = EquipConfig.instance:getEquipAddBaseAttr(equipMo)

			equipAttrDict[CharacterEnum.AttrId.Attack] = equipAtk + (_equipAtk or 0)
			equipAttrDict[CharacterEnum.AttrId.Hp] = equipHp + (_equipHp or 0)
			equipAttrDict[CharacterEnum.AttrId.Defense] = equipDef + (_equipDef or 0)
			equipAttrDict[CharacterEnum.AttrId.Mdefense] = equipMdef + (_equipMdef or 0)

			local equipBreakAddPercentValuesDict = EquipConfig.instance:getEquipBreakAddAttrValueDict(equipMo.config, equipMo.breakLv)

			for _, attrId in ipairs(CharacterView.AttrIdList) do
				if _equipBreakAddPercentValuesDict then
					if not _equipBreakAddPercentValuesDict[attrId] then
						local _addPercent = 0
						local addPercent = equipBreakAddPercentValuesDict[attrId] + _addPercent

						if addPercent ~= 0 then
							equipAttrDict[attrId] = equipAttrDict[attrId] + math.floor(addPercent / 100 * heroAttrDict[attrId])
						end
					end
				end
			end
		end
	end

	for i, attrId in ipairs(CharacterView.AttrIdList) do
		local talentValue = talentAttrDict[attrId] and talentAttrDict[attrId].value and math.floor(talentAttrDict[attrId].value) or 0
		local destinyStoneAddValue = destinyStoneMo and destinyStoneMo:getAddValueByAttrId(destinyStoneValues, attrId, heroMo) or 0
		local totalValue = heroAttrDict[attrId] + equipAttrDict[attrId] + talentValue + destinyStoneAddValue

		self._attributevalues[i].value.text = totalValue

		local co = HeroConfig.instance:getHeroAttributeCO(attrId)

		self._attributevalues[i].name.text = co.name

		CharacterController.instance:SetAttriIcon(self._attributevalues[i].icon, attrId, CharacterView.AttrIconColor)

		local levelUpAttribute = self._levelUpAttributeValues[i]

		levelUpAttribute.value.text = totalValue
		levelUpAttribute.name.text = co.name

		CharacterController.instance:SetAttriIcon(levelUpAttribute.icon, attrId, CharacterView.AttrIconColor)
	end
end

function CharacterView:_refreshAttributeTips(level)
	local heroMo = self._heroMO
	local curLevel = heroMo.level

	if not level or level < curLevel then
		for _, levelUpAttribute in ipairs(self._levelUpAttributeValues) do
			levelUpAttribute.newValue.text = 0
		end

		return
	end

	local isCurLevel = level == curLevel
	local heroAttrDict = heroMo:getHeroBaseAttrDict(level)
	local talentAttrDict = HeroConfig.instance:talentGainTab2IDTab(heroMo:getTalentGain(level))
	local destinyStoneMo = heroMo.destinyStoneMo
	local destinyStoneValues = destinyStoneMo:getAddAttrValues()
	local equipAttrDict = {}

	for _, attrId in ipairs(CharacterView.AttrIdList) do
		equipAttrDict[attrId] = 0
	end

	local hasDefaultEquip = heroMo:hasDefaultEquip()

	if hasDefaultEquip then
		local equipMo = EquipModel.instance:getEquip(heroMo.defaultEquipUid)
		local _equipHp, _equipAtk, _equipDef, _equipMdef, _equipBreakAddPercentValuesDict = self:_getOtherEquipAddValues(equipMo)
		local equipHp, equipAtk, equipDef, equipMdef = EquipConfig.instance:getEquipAddBaseAttr(equipMo)

		equipAttrDict[CharacterEnum.AttrId.Attack] = equipAtk + (_equipAtk or 0)
		equipAttrDict[CharacterEnum.AttrId.Hp] = equipHp + (_equipHp or 0)
		equipAttrDict[CharacterEnum.AttrId.Defense] = equipDef + (_equipDef or 0)
		equipAttrDict[CharacterEnum.AttrId.Mdefense] = equipMdef + (_equipMdef or 0)

		local equipBreakAddPercentValuesDict = EquipConfig.instance:getEquipBreakAddAttrValueDict(equipMo.config, equipMo.breakLv)

		for _, attrId in ipairs(CharacterView.AttrIdList) do
			if _equipBreakAddPercentValuesDict then
				if not _equipBreakAddPercentValuesDict[attrId] then
					local _addPercent = 0
					local addPercent = equipBreakAddPercentValuesDict[attrId] + _addPercent

					if addPercent ~= 0 then
						equipAttrDict[attrId] = equipAttrDict[attrId] + math.floor(addPercent / 100 * heroAttrDict[attrId])
					end
				end
			end
		end
	end

	for i, attrId in ipairs(CharacterView.AttrIdList) do
		local talentValue = talentAttrDict[attrId] and talentAttrDict[attrId].value and math.floor(talentAttrDict[attrId].value) or 0
		local destinyStoneAddValue = destinyStoneMo and destinyStoneMo:getAddValueByAttrId(destinyStoneValues, attrId, heroMo) or 0
		local levelUpAttribute = self._levelUpAttributeValues[i]
		local txtNewValue = levelUpAttribute.newValue

		txtNewValue.text = heroAttrDict[attrId] + equipAttrDict[attrId] + talentValue + destinyStoneAddValue

		local strColor = isCurLevel and "#C7C3C0" or "#65B96F"

		txtNewValue.color = GameUtil.parseColor(strColor)
		levelUpAttribute.newValueArrow.color = GameUtil.parseColor(strColor)
	end
end

function CharacterView:_refreshLevel()
	local showLevel = HeroConfig.instance:getShowLevel(self._heroMO.level)
	local showMaxLevel = HeroConfig.instance:getShowLevel(CharacterModel.instance:getrankEffects(self._heroMO.heroId, self._heroMO.rank)[1])
	local isBalance = self._heroMO:getIsBalance()

	if isBalance then
		self._txtlevel.text = string.format("<color=#81abe5>%s</color>/", showLevel)
	end

	self._txtlevelmax.text = showMaxLevel
end

function CharacterView:_refreshRank()
	local rare = self._heroMO.config.rare
	local rank = self._heroMO.rank
	local target = HeroConfig.instance:getMaxRank(rare)

	for i = 1, 3 do
		gohelper.setActive(self._ranklights[i].go, target == i)

		for j = 1, i do
			if j <= rank - 1 then
				SLFramework.UGUI.GuiHelper.SetColor(self._ranklights[i].lights[j]:GetComponent("Image"), "#feb73b")
			else
				SLFramework.UGUI.GuiHelper.SetColor(self._ranklights[i].lights[j]:GetComponent("Image"), "#737373")
			end
		end
	end
end

function CharacterView:_refreshSkill()
	self._skillContainer:onUpdateMO(self._heroMO.heroId, nil, self._heroMO, nil, CharacterEnum.DeviceViewType.CharacterView)
end

function CharacterView:_onRefreshDestiny(heroId, stoneId)
	self:_refreshSkill()
	self:_refreshCareer()
	self:_refreshReshape()
end

function CharacterView:_onJumpView(type)
	if type == CharacterRecommedEnum.JumpView.Level then
		local tradeMo = CharacterRecommedModel.instance:getTracedHeroDevelopGoalsMO()

		self:_cutCharacter(tradeMo._heroId)

		if self._animator then
			self:playAnim(UIAnimationName.Open)
			self._animatorattributetipsnode:Play("open", 0, 0)
		end
	end
end

function CharacterView:_refreshPassiveSkill()
	local pskills = self._heroMO:getpassiveskillsCO()
	local firstSkill = pskills[1]
	local skillId = firstSkill.skillPassive
	local skillConfig = lua_skill.configDict[skillId]

	if not skillConfig then
		logError("找不到被动技能, skillId: " .. tostring(skillId))

		return
	end

	self._txtpassivename.text = skillConfig.name

	for i = 1, #pskills do
		local unlock = CharacterModel.instance:isPassiveUnlockByHeroMo(self._heroMO, i)

		gohelper.setActive(self._passiveskillitems[i].on, unlock)
		gohelper.setActive(self._passiveskillitems[i].off, not unlock)
		gohelper.setActive(self._passiveskillitems[i].go, true)
	end

	for i = #pskills + 1, #self._passiveskillitems do
		gohelper.setActive(self._passiveskillitems[i].go, false)
	end

	if pskills[0] then
		gohelper.setActive(self._passiveskillitems[0].on, true)
		gohelper.setActive(self._passiveskillitems[0].off, false)
		gohelper.setActive(self._passiveskillitems[0].go, true)
	else
		gohelper.setActive(self._passiveskillitems[0].go, false)
	end
end

function CharacterView:_refreshExSkill()
	for i = 1, 5 do
		if i <= self._heroMO.exSkillLevel then
			SLFramework.UGUI.GuiHelper.SetColor(self._exskills[i]:GetComponent("Image"), "#feb73b")
		else
			SLFramework.UGUI.GuiHelper.SetColor(self._exskills[i]:GetComponent("Image"), "#737373")
		end
	end
end

function CharacterView:_refreshTalent()
	local isOwnHero = self._heroMO:isOwnHero()
	local isShowTalent = OpenModel.instance:isFuncBtnShow(OpenEnum.UnlockFunc.Talent) or not isOwnHero
	local isUnLockTalent = false
	local isOtherPlayerHero = self._heroMO:isOtherPlayerHero()
	local styleId

	isUnLockTalent = isOtherPlayerHero and self._heroMO:getOtherPlayerIsOpenTalent() or OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Talent) or self._heroMO:isTrial()

	gohelper.setActive(self._gotalent, isShowTalent)
	gohelper.setActive(self._gotalentlock, not isUnLockTalent)
	ZProj.UGUIHelper.SetGrayscale(self._gotalents, not isUnLockTalent)
	self:_showTalentStyleBtn()

	if HeroResonanceConfig.instance:getTalentConfig(self._heroMO.heroId, self._heroMO.talent + 1) then
		self._txttalentvalue.text = self._heroMO.talent or "max"
	end
end

function CharacterView:_showTalentStyleBtn()
	local isOwnHero = self._heroMO:isOwnHero()
	local isUnlockTalentStyle = TalentStyleModel.instance:isUnlockStyleSystem(self._heroMO.talent)

	if not isOwnHero and not isUnlockTalentStyle and not isUnlockTalentStyle then
		self:_showTalentBtn()

		return
	end

	local styleId = self._heroMO:getHeroUseCubeStyleId()
	local mainCubeMo = self._heroMO.talentCubeInfos:getMainCubeMo()

	if styleId == 0 or not mainCubeMo then
		self:_showTalentBtn()

		return
	end

	local mainCubeId = mainCubeMo.id
	local styleList = HeroResonanceConfig.instance:getTalentStyle(mainCubeId)
	local styleCubeMo = styleList and styleList[styleId]

	if styleCubeMo then
		local growTagIcon, nomalTagIcon = styleCubeMo:getStyleTagIcon()
		local color = styleCubeMo._styleCo.color

		self._imageicon.color = GameUtil.parseColor(color)

		UISpriteSetMgr.instance:setCharacterTalentSprite(self._imageicon, nomalTagIcon)
		gohelper.setActive(self._gotalentstyle, true)
		gohelper.setActive(self._gotalents, false)
	else
		self:_showTalentBtn()
	end
end

function CharacterView:_showTalentBtn()
	gohelper.setActive(self._gotalentstyle, false)
	gohelper.setActive(self._gotalents, true)
end

function CharacterView:_onRefreshStyleIcon()
	self:_showTalentStyleBtn()
end

function CharacterView:onClose()
	if self._drag then
		self._drag:RemoveDragBeginListener()
		self._drag:RemoveDragEndListener()
		self._drag:RemoveDragListener()
	end

	if self._signatureDrag then
		self._signatureDrag:RemoveDragBeginListener()
		self._signatureDrag:RemoveDragEndListener()
		self._signatureDrag:RemoveDragListener()
	end

	self._trustclick:RemoveClickListener()
	self._careerclick:RemoveClickListener()
	self._signatureClick:RemoveClickListener()

	if self._uiSpine then
		self._uiSpine:stopVoice()
	end

	if self._dragTweenId then
		ZProj.TweenHelper.KillById(self._dragTweenId)

		self._dragTweenId = nil
	end

	TaskDispatcher.cancelTask(self._playSpineVoice, self)
	TaskDispatcher.cancelTask(self._delaySetModelHide, self)
	self.removeEventCb(self, ViewMgr.instance, ViewEvent.OnCloseViewFinish, self._onCloseViewFinish, self)
	self.removeEventCb(self, ViewMgr.instance, ViewEvent.OnCloseFullView, self._onCloseFullView, self)
	self.removeEventCb(self, ViewMgr.instance, ViewEvent.OnCloseView, self._onCloseView, self)

	if self._skillContainer then
		self._skillContainer:onFinishreplaceSkillAnim()
		self._skillContainer:clearDelay()
		self._skillContainer:onClose()
	end
end

function CharacterView:onUpdateParam()
	self._playGreetingVoices = true
	self._heroMO = self.viewParam

	self:clear()
	self:_refreshView()
end

function CharacterView:clear()
	self._simagestatic:UnLoadImage()
	self._simagesignature:UnLoadImage()
end

function CharacterView:playCloseViewAnim(func)
	if self._tempFunc then
		TaskDispatcher.cancelTask(self._tempFunc, self)
	end

	self:playAnim(UIAnimationName.Close)

	self._tempFunc = func

	UIBlockMgr.instance:startBlock(self.viewName .. "ViewCloseAnim")
	TaskDispatcher.runDelay(self._closeAnimFinish, self, 0.18)
end

function CharacterView:_closeAnimFinish()
	UIBlockMgr.instance:endBlock(self.viewName .. "ViewCloseAnim")
	self:_tempFunc()
end

function CharacterView:playAnim(animName)
	self._isAnim = true

	self:setShaderKeyWord()
	self._animator:Play(animName, self.onAnimDone, self)
end

function CharacterView:onAnimDone()
	self._isAnim = false

	self:setShaderKeyWord()
	self.viewContainer:_cancelBlock()
end

function CharacterView:setShaderKeyWord()
	if not self._isDragingSpine then
		if self._isDragingSpine then
			UnityEngine.Shader.EnableKeyword("_CLIPALPHA_ON")
		else
			UnityEngine.Shader.DisableKeyword("_CLIPALPHA_ON")
		end
	end
end

function CharacterView:onDestroyView()
	if self._uiSpine then
		self._uiSpine:onDestroy()

		self._uiSpine = nil
	end

	self._simageplayerbg:UnLoadImage()
	self._simagebg:UnLoadImage()
	self:clear()
	TaskDispatcher.cancelTask(self._closeAnimFinish, self)
	TaskDispatcher.cancelTask(self._delaySetModelHide, self)
	TaskDispatcher.cancelTask(self._playSpineVoice, self)
	UnityEngine.Shader.DisableKeyword("_CLIPALPHA_ON")
end

function CharacterView:_checkPlaySpecialBodyMotion()
	if not self._heroMO:isOwnHero() then
		return
	end

	local isCanPlayAnim, _, co = CharacterModel.instance:isCanPlayReplaceSkillAnim(self._heroMO)

	if isCanPlayAnim and co and not string.nilorempty(co.specialLive2d) then
		local specialLive2d = string.split(co.specialLive2d, "#")

		if not string.nilorempty(specialLive2d[3]) then
			local motion = "b_" .. specialLive2d[3]
			local mixTime = specialLive2d[4] and tonumber(specialLive2d[4]) or 0

			local function callback()
				if self._uiSpine then
					self._uiSpine:setActionEventCb(nil, self)

					if self._greetingVoices and #self._greetingVoices > 0 then
						self._uiSpine:playVoice(self._greetingVoices[1], nil, self._txtanacn, self._txtanaen, self._gocontentbg)
					end
				end
			end

			self._uiSpine:playSpecialMotion(motion, false, mixTime)
			self._uiSpine:setActionEventCb(callback, self)

			return true
		end
	end
end

return CharacterView
