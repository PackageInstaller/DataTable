-- chunkname: @modules/logic/rouge/view/RougeInitTeamHeroItem.lua

module("modules.logic.rouge.view.RougeInitTeamHeroItem", package.seeall)

local RougeInitTeamHeroItem = class("RougeInitTeamHeroItem", LuaCompBase)

function RougeInitTeamHeroItem:init(go)
	self.go = go
	self._clickGO = gohelper.findChild(go, "clickarea")
	self._emptyGO = gohelper.findChild(go, "empty")
	self._selectedEffect = gohelper.findChild(go, "selectedeffect")
	self._clickThis = gohelper.getClick(self._clickGO)
	self._heroGOParent = gohelper.findChild(go, "heroitem")
end

function RougeInitTeamHeroItem:setIndex(index)
	self._index = index
end

function RougeInitTeamHeroItem:setRougeInitTeamView(view)
	self._teamView = view
end

function RougeInitTeamHeroItem:setHeroItem(prefab)
	self._heroItemGo = gohelper.clone(prefab, self._heroGOParent)

	local heroGo = gohelper.findChild(self._heroItemGo, "hero")
	local hpGo = gohelper.findChild(self._heroItemGo, "#go_hp")

	gohelper.setActive(hpGo, false)

	self._heroItem = IconMgr.instance:getCommonHeroItem(heroGo)

	self._heroItem:setStyle_CharacterBackpack()
	self._heroItem:hideFavor(true)

	self._heroAnimator = self._heroItem.go:GetComponent(typeof(UnityEngine.Animator))

	self:_initCapacity()
end

function RougeInitTeamHeroItem:_initCapacity()
	local volumeGo = gohelper.findChild(self._heroItemGo, "volume")

	self._capacityComp = RougeCapacityComp.Add(volumeGo, nil, nil, true)

	self._capacityComp:setSpriteType(RougeCapacityComp.SpriteType3, RougeCapacityComp.SpriteType3)
end

function RougeInitTeamHeroItem:addEventListeners()
	self._clickThis:AddClickListener(self._onClickThis, self)
end

function RougeInitTeamHeroItem:removeEventListeners()
	self._clickThis:RemoveClickListener()
end

function RougeInitTeamHeroItem:getHeroMo()
	return self._heroMO
end

function RougeInitTeamHeroItem:onUpdateMO(mo)
	self.mo = mo
	self._heroMO = mo:getHeroMO()

	local hasHero = self._heroMO ~= nil

	gohelper.setActive(self._emptyGO, not hasHero)
	gohelper.setActive(self._heroGOParent, hasHero)

	self._capacity = 0

	if hasHero then
		self._heroItem:onUpdateMO(self._heroMO)
		self._heroItem:setNewShow(false)

		self._capacity = RougeController.instance:getRoleStyleCapacity(self._heroMO)

		self._capacityComp:updateMaxNum(self._capacity)

		local lv = RougeHeroGroupBalanceHelper.getHeroBalanceLv(self._heroMO.heroId)

		if lv > self._heroMO.level then
			self._heroItem:setBalanceLv(lv)
		end

		self:updateTrialTag()
	end
end

function RougeInitTeamHeroItem:setTrialValue(value)
	self._isTrial = value
end

function RougeInitTeamHeroItem:updateTrialTag()
	local txt

	self._heroItem:setTrialTxt((self._isTrial or nil) and luaLang("herogroup_trial_tag0"))
end

function RougeInitTeamHeroItem:showSelectEffect()
	self._heroAnimator:Play(UIAnimationName.Idle, 0, 0)
	gohelper.setActive(self._selectedEffect, false)
	gohelper.setActive(self._selectedEffect, true)
end

function RougeInitTeamHeroItem:getCapacity()
	return self._capacity
end

function RougeInitTeamHeroItem:_onClickThis()
	if self._isTrial then
		return
	end

	local curCapacity, totalCapacity = self._teamView:getCapacityProgress()

	if totalCapacity <= curCapacity and not self._heroMO then
		GameFacade.showToast(ToastEnum.RougeTeamSelectHeroCapacityFull)

		return
	end

	self:_openRougeHeroGroupEditView(self.mo.id)
end

function RougeInitTeamHeroItem:_openRougeHeroGroupEditView(id)
	local curCapacity, totalCapacity = self._teamView:getNoneAssistCapacityProgress()
	local param = {}

	param.singleGroupMOId = id
	param.originalHeroUid = RougeHeroSingleGroupModel.instance:getHeroUid(id)
	param.equips = {
		"0"
	}
	param.heroGroupEditType = RougeEnum.HeroGroupEditType.Init
	param.selectHeroCapacity = self._capacity
	param.curCapacity = curCapacity
	param.totalCapacity = totalCapacity
	param.assistCapacity = self._teamView:getAssistCapacity()
	param.assistPos = self._teamView:getAssistPos()
	param.assistHeroId = self._teamView:getAssistHeroId()

	ViewMgr.instance:openView(ViewName.RougeHeroGroupEditView, param)
end

function RougeInitTeamHeroItem:onDestroy()
	self._teamView = nil
end

return RougeInitTeamHeroItem
