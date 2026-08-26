-- chunkname: @modules/logic/tower/view/TowerHeroTrialView.lua

module("modules.logic.tower.view.TowerHeroTrialView", package.seeall)

local TowerHeroTrialView = class("TowerHeroTrialView", BaseView)

function TowerHeroTrialView:onInitView()
	self._btncloseFullView = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_closeFullView")
	self._scrollhero = gohelper.findChildScrollRect(self.viewGO, "#scroll_hero")
	self._goheroContent = gohelper.findChild(self.viewGO, "#scroll_hero/Viewport/#go_heroContent")
	self._goheroItem = gohelper.findChild(self.viewGO, "#scroll_hero/Viewport/#go_heroContent/#go_heroItem")
	self._scrolldesc = gohelper.findChildScrollRect(self.viewGO, "#scroll_desc")
	self._godescContent = gohelper.findChild(self.viewGO, "#scroll_desc/Viewport/#go_descContent")
	self._godescItem = gohelper.findChild(self.viewGO, "#scroll_desc/Viewport/#go_descContent/#go_descItem")
	self._btnrule = gohelper.findChildButtonWithAudio(self.viewGO, "title/txt/#btn_rule")
	self._goruleTip = gohelper.findChild(self.viewGO, "#go_ruleTip")
	self._btncloseRuleTip = gohelper.findChildButtonWithAudio(self.viewGO, "#go_ruleTip/#btn_closeRuleTip")
	self._txtrule = gohelper.findChildText(self.viewGO, "#go_ruleTip/#txt_rule")
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_close")
	self._imagefacetsIcon = gohelper.findChildImage(self.viewGO, "#scroll_desc/Viewport/#go_descContent/#go_descItem/facets/image_facetsIcon")
	self._txtfacets = gohelper.findChildText(self.viewGO, "#scroll_desc/Viewport/#go_descContent/#go_descItem/facets/txt_facets")
	self._gofacetsDesc = gohelper.findChild(self.viewGO, "#scroll_desc/Viewport/#go_descContent/#go_descItem/go_facetsDesc")
	self._gofacetsDescItem = gohelper.findChild(self.viewGO, "#scroll_desc/Viewport/#go_descContent/#go_descItem/go_facetsDesc/txt_facetsDesc")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function TowerHeroTrialView:addEvents()
	self._btncloseFullView:AddClickListener(self._btncloseFullViewOnClick, self)
	self._btnrule:AddClickListener(self._btnruleOnClick, self)
	self._btncloseRuleTip:AddClickListener(self._btncloseRuleTipOnClick, self)
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
	self.addEventCb(self, TowerController.instance, TowerEvent.OnSelectHeroTrialItem, self.createOrRefreshDesc, self)
end

function TowerHeroTrialView:removeEvents()
	self._btncloseFullView:RemoveClickListener()
	self._btnrule:RemoveClickListener()
	self._btncloseRuleTip:RemoveClickListener()
	self._btnclose:RemoveClickListener()
	self.removeEventCb(self, TowerController.instance, TowerEvent.OnSelectHeroTrialItem, self.createOrRefreshDesc, self)
end

function TowerHeroTrialView:_btncloseFullViewOnClick()
	self:_btncloseOnClick()
end

function TowerHeroTrialView:_btnruleOnClick()
	gohelper.setActive(self._goruleTip, true)
end

function TowerHeroTrialView:_btncloseRuleTipOnClick()
	gohelper.setActive(self._goruleTip, false)
end

function TowerHeroTrialView:_btncloseOnClick()
	self:closeThis()
end

function TowerHeroTrialView:_editableInitView()
	self.descItemList = self:getUserDataTb_()
end

function TowerHeroTrialView:onOpen()
	AudioMgr.instance:trigger(AudioEnum.Tower.play_ui_fight_bubbles)
	gohelper.setActive(self._goruleTip, false)
	gohelper.setActive(self._goheroItem, false)
	self:refreshUI()
end

function TowerHeroTrialView:refreshUI()
	self._txtrule.text = TowerConfig.instance:getTowerConstLangConfig(TowerEnum.ConstId.HeroTrialRule)

	self:createOrRefreshDesc()
end

function TowerHeroTrialView:createOrRefreshDesc()
	local curSelectHeroId = TowerHeroTrialListModel.instance:getCurSelectHeroId()

	self.trialConfig = lua_hero_trial.configDict[curSelectHeroId][0]

	local facetsId = self.trialConfig.facetsId
	local facetslevel = self.trialConfig.facetslevel
	local destinyCo = CharacterDestinyConfig.instance:getDestinyFacetConsumeCo(facetsId)

	if not destinyCo then
		logError(self.trialConfig.id .. "角色命石消耗表中狂想配置不存在，请检查： " .. facetsId)

		return
	end

	local tenp = CharacterDestinyEnum.SlotTend[destinyCo.tend]
	local tendIcon = tenp.TitleIconName

	UISpriteSetMgr.instance:setUiCharacterSprite(self._imagefacetsIcon, tendIcon)

	self._txtfacets.color = GameUtil.parseColor(tenp.TitleColor)
	self._txtfacets.text = destinyCo.name

	local facetsDataList = {}

	for level = 1, facetslevel do
		local facetsCo = CharacterDestinyConfig.instance:getDestinyFacets(facetsId, level)

		table.insert(facetsDataList, facetsCo)
	end

	gohelper.CreateObjList(self, self.showFacetsDescItem, facetsDataList, self._gofacetsDesc, self._gofacetsDescItem)
end

function TowerHeroTrialView:showFacetsDescItem(obj, data, index)
	local txtItem = self:getUserDataTb_()

	txtItem.txtdesc = obj:GetComponent(gohelper.Type_TextMesh)
	txtItem.txtdesc.text = data.desc
	txtItem.skillDesc = MonoHelper.addNoUpdateLuaComOnceToGo(obj, SkillDescComp)

	txtItem.skillDesc:updateInfo(txtItem.txtdesc, data.desc, self.trialConfig.heroId)
	txtItem.skillDesc:setTipParam(0, Vector2(-200, 100))
end

function TowerHeroTrialView:onClose()
	TowerHeroTrialListModel.instance:setCurSelectHeroId(0)
end

function TowerHeroTrialView:onDestroyView()
	return
end

return TowerHeroTrialView
