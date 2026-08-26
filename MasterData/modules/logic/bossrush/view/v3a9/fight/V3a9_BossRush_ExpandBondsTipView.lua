-- chunkname: @modules/logic/bossrush/view/v3a9/fight/V3a9_BossRush_ExpandBondsTipView.lua

module("modules.logic.bossrush.view.v3a9.fight.V3a9_BossRush_ExpandBondsTipView", package.seeall)

local V3a9_BossRush_ExpandBondsTipView = class("V3a9_BossRush_ExpandBondsTipView", BaseView)

function V3a9_BossRush_ExpandBondsTipView:onInitView()
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_close")
	self._txtName = gohelper.findChildText(self.viewGO, "title/#txt_Name")
	self._txtLevel = gohelper.findChildText(self.viewGO, "title/#txt_Level")
	self._imageIcon = gohelper.findChildImage(self.viewGO, "title/#image_Icon")
	self._scrollDetails = gohelper.findChildScrollRect(self.viewGO, "#scroll_Details")
	self._txtDesc = gohelper.findChildText(self.viewGO, "#scroll_Details/Viewport/Content/#txt_Desc")
	self._imageindex = gohelper.findChildImage(self.viewGO, "#scroll_Details/Viewport/Content/#txt_Desc/#image_index")
	self._scrollHeros = gohelper.findChildScrollRect(self.viewGO, "#scroll_Heros")
	self._goHeroItem = gohelper.findChild(self.viewGO, "#scroll_Heros/Viewport/Content/#go_HeroItem")
	self._rootGrid = gohelper.findChild(self.viewGO, "grid")
	self._btnleft = gohelper.getClick(gohelper.findChild(self.viewGO, "#btn_left"))
	self._btnright = gohelper.getClick(gohelper.findChild(self.viewGO, "#btn_right"))

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V3a9_BossRush_ExpandBondsTipView:addEvents()
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
	self._btnleft:AddClickListener(self._btnleftOnClick, self)
	self._btnright:AddClickListener(self._btnrightOnClick, self)
	self.addEventCb(self, HeroGroupController.instance, HeroGroupEvent.OnHeroEditItemSelectChange, self._refreshHeroState, self)
end

function V3a9_BossRush_ExpandBondsTipView:removeEvents()
	self._btnclose:RemoveClickListener()
	self._btnleft:RemoveClickListener()
	self._btnright:RemoveClickListener()
	self.removeEventCb(self, HeroGroupController.instance, HeroGroupEvent.OnHeroEditItemSelectChange, self._refreshHeroState, self)
end

function V3a9_BossRush_ExpandBondsTipView:_btnleftOnClick()
	self:_refreshSwitch(self._switchGroupIndex - 1)
end

function V3a9_BossRush_ExpandBondsTipView:_btnrightOnClick()
	self:_refreshSwitch(self._switchGroupIndex + 1)
end

function V3a9_BossRush_ExpandBondsTipView:_btncloseOnClick()
	gohelper.addChildPosStay(self.viewGO, self._btnclose)
	self._animatorPlayer:Play("close", self.closeThis, self)
end

function V3a9_BossRush_ExpandBondsTipView:_editableInitView()
	self._levelDescItems = self:getUserDataTb_()
	self._heroItems = self:getUserDataTb_()

	gohelper.setActive(self._txtDesc.gameObject, false)
	gohelper.setActive(self._goHeroItem.gameObject, false)
	gohelper.setActive(self._btnleft.gameObject, false)
	gohelper.setActive(self._btnright.gameObject, false)

	self._animatorPlayer = SLFramework.AnimatorPlayer.Get(self.viewGO.gameObject)
end

function V3a9_BossRush_ExpandBondsTipView:onOpen()
	self._groupId = self.viewParam.groupId
	self._closeRoot = self.viewParam.closeRoot
	self._heroId = self.viewParam.heroId

	if self._closeRoot then
		gohelper.addChildPosStay(self._closeRoot, self._btnclose)
	end

	self:refresh()
end

function V3a9_BossRush_ExpandBondsTipView:refresh()
	self._groupMo = V3a9_BossRushExpandBondModel.instance:getExpandBondGroupMo(self._groupId)
	self._heroGroupMos = self._heroId and V3a9_BossRushExpandBondModel.instance:getHeroExpandBondGroupsList(self._heroId)

	local switchGroupIndex = 1

	if self._heroGroupMos then
		for i, mo in pairs(self._heroGroupMos) do
			if mo:getGroupId() == self._groupId then
				switchGroupIndex = i

				break
			end
		end
	end

	self:_refreshSwitch(switchGroupIndex)
	self:_refreshGroup()
end

function V3a9_BossRush_ExpandBondsTipView:_refreshSwitch(index)
	if self._switchGroupIndex == index or not self._heroGroupMos then
		return
	end

	if index < 1 or index > #self._heroGroupMos then
		return
	end

	local groupMo = self._heroGroupMos[index]

	if not groupMo then
		return
	end

	self._groupId = groupMo:getGroupId()
	self._groupMo = V3a9_BossRushExpandBondModel.instance:getExpandBondGroupMo(self._groupId)
	self._switchGroupIndex = index

	self:_refreshGroup()
	gohelper.setActive(self._btnleft.gameObject, self._heroId ~= nil and index > 1)
	gohelper.setActive(self._btnright.gameObject, (self._heroId ~= nil or nil) and self._heroGroupMos and index < #self._heroGroupMos)
	V3a9_BossRushController.instance:dispatchEvent(V3a9_BossRushEvent.onSwitchHeroExpandBonds, self._groupId, self._heroId)
end

function V3a9_BossRush_ExpandBondsTipView:onUpdateParam()
	self._heroId = self.viewParam.heroId
	self._groupId = self.viewParam.groupId

	self:refresh()
end

function V3a9_BossRush_ExpandBondsTipView:_refreshGroup()
	if not self._groupMo then
		return
	end

	self._txtName.text = self._groupMo:getName()

	local icon = self._groupMo:getIcon()

	if not string.nilorempty(icon) then
		UISpriteSetMgr.instance:setV1a4BossRushSprite(self._imageIcon, icon)
	end

	self:_refreshLevelDesc()
	self:_refreshHeros()
end

function V3a9_BossRush_ExpandBondsTipView:_refreshLevelDesc()
	local mos = self._groupMo:getLevelMoList()
	local curActive = self._groupMo:getCurActiveMo()
	local activeNum = curActive and curActive:getActiveNum() or 0
	local numStr = ""
	local lang = luaLang("v3a9_bossrush_expandbonds_activenum")

	for i, mo in ipairs(mos) do
		local co = mo:getConfig()
		local num = mo:getActiveNum()

		if activeNum == num then
			num = string.format("<color=#FFA64D>%s</color>", num)
		end

		numStr = string.nilorempty(numStr) and num or GameUtil.getSubPlaceholderLuaLangTwoParam(lang, numStr, num)

		local descItem = self:_getLevelDesc(i)

		descItem.txtdesc.text = co.desc

		UISpriteSetMgr.instance:setV1a4BossRushSprite(descItem.imgindex, co.numberIcon, true)

		descItem.canvasgroup.alpha = activeNum >= mo:getActiveNum() and 1 or 0.65
	end

	self._txtLevel.text = numStr

	for i, item in ipairs(self._levelDescItems) do
		gohelper.setActive(item.go.gameObject, i <= #mos)
	end
end

function V3a9_BossRush_ExpandBondsTipView:_getLevelDesc(index)
	local item = self._levelDescItems[index]

	if not item then
		item = self:getUserDataTb_()
		item.go = gohelper.cloneInPlace(self._txtDesc.gameObject)
		item.txtdesc = gohelper.findChildText(item.go, "")
		item.imgindex = gohelper.findChildImage(item.go, "#image_index")
		item.canvasgroup = item.go:GetComponent(typeof(UnityEngine.CanvasGroup))
		self._levelDescItems[index] = item
	end

	return item
end

function V3a9_BossRush_ExpandBondsTipView:_btnClickHero(index)
	return
end

function V3a9_BossRush_ExpandBondsTipView:_refreshHeros()
	local heros = self._groupMo:getAllHero()

	for i, id in ipairs(heros) do
		local heroItem = self:_getHeroItem(i)

		heroItem.item:setParam(self._stage, self._groupMo)
		heroItem.item:onUpdateHeroId(i, id)
		heroItem.item:setClickCb(self._btnClickHero, self)
	end

	for i, item in ipairs(self._heroItems) do
		gohelper.setActive(item.go.gameObject, i <= #heros)
	end
end

function V3a9_BossRush_ExpandBondsTipView:_refreshHeroState()
	for i, item in ipairs(self._heroItems) do
		item.item:_refreshState()
	end
end

function V3a9_BossRush_ExpandBondsTipView:_getHeroItem(index)
	local item = self._heroItems[index]

	if not item then
		item = self:getUserDataTb_()

		local path = self.viewContainer:getSetting().otherRes[1]

		item.go = gohelper.cloneInPlace(self._goHeroItem)

		local goHero = self:getResInst(path, item.go)

		item.item = MonoHelper.addNoUpdateLuaComOnceToGo(goHero, V3a9_BossRush_ExpandBondsHeroItem)
		item.index = index
		self._heroItems[index] = item
	end

	return item
end

function V3a9_BossRush_ExpandBondsTipView:onClose()
	gohelper.addChildPosStay(self.viewGO, self._btnclose)
	V3a9_BossRushController.instance:dispatchEvent(V3a9_BossRushEvent.onSwitchHeroExpandBonds)
	V3a9_BossRushController.instance:dispatchEvent(V3a9_BossRushEvent.onClickExpandBonds)
end

function V3a9_BossRush_ExpandBondsTipView:onDestroyView()
	return
end

return V3a9_BossRush_ExpandBondsTipView
