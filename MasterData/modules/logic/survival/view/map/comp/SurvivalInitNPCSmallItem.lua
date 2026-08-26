-- chunkname: @modules/logic/survival/view/map/comp/SurvivalInitNPCSmallItem.lua

module("modules.logic.survival.view.map.comp.SurvivalInitNPCSmallItem", package.seeall)

local SurvivalInitNPCSmallItem = class("SurvivalInitNPCSmallItem", LuaCompBase)

function SurvivalInitNPCSmallItem:init(go)
	self.go = go
	self._goHaveNpc = gohelper.findChild(go, "#go_HaveHero")
	self._goLock = gohelper.findChild(go, "#go_Locked")
	self._goEmpty = gohelper.findChild(go, "#go_Empty")
	self._goEmpty2 = gohelper.findChild(go, "#go_Empty2")
	self._goEmptyAdd = gohelper.findChild(go, "#go_Empty/image_Add")
	self._clickThis = gohelper.getClick(go)
	self._txtname = gohelper.findChildTextMesh(self._goHaveNpc, "#txt_PartnerName")
	self._imagechess = gohelper.findChildSingleImage(self._goHaveNpc, "#image_Chess")
end

function SurvivalInitNPCSmallItem:setIndex(index)
	self._index = index
end

function SurvivalInitNPCSmallItem:setParentView(view)
	self._teamView = view
end

function SurvivalInitNPCSmallItem:addEventListeners()
	self._clickThis:AddClickListener(self._onClickThis, self)
end

function SurvivalInitNPCSmallItem:removeEventListeners()
	self._clickThis:RemoveClickListener()
end

function SurvivalInitNPCSmallItem:getNpcMo()
	return self._npcMo
end

function SurvivalInitNPCSmallItem:setNoShowAdd()
	self._noShowAdd = true
end

function SurvivalInitNPCSmallItem:setIsLock(value)
	self._isLock = value

	if value then
		gohelper.setActive(self._goLock, true)
		gohelper.setActive(self._goHaveNpc, false)
		gohelper.setActive(self._goEmpty, false)
	end
end

function SurvivalInitNPCSmallItem:onUpdateMO(mo)
	gohelper.setActive(self.go, true)

	self._npcMo = mo

	local hasNpc = self._npcMo ~= nil

	gohelper.setActive(self._goEmpty, not hasNpc)
	gohelper.setActive(self._goEmptyAdd, not hasNpc and not self._noShowAdd)
	gohelper.setActive(self._goEmpty2, (false or nil) and true)
	gohelper.setActive(self._goHaveNpc, hasNpc)

	if hasNpc then
		local npcCo = mo.co

		if not npcCo then
			return
		end

		self._txtname.text = npcCo.name

		SurvivalUnitIconHelper.instance:setNpcIcon(self._imagechess, npcCo.headIcon)
	end
end

function SurvivalInitNPCSmallItem:showSelectEffect()
	return
end

function SurvivalInitNPCSmallItem:_onClickThis()
	if self._isLock then
		return
	end

	local weekInfo = SurvivalShelterModel.instance:getWeekInfo()

	if weekInfo.inSurvival then
		if self._npcMo then
			SurvivalController.instance:dispatchEvent(SurvivalEvent.OnClickTeamNpc, self._npcMo)
		end

		return
	end

	AudioMgr.instance:trigger(AudioEnum.HeroGroupUI.Play_UI_Team_Open)
	ViewMgr.instance:openView(ViewName.SurvivalNPCSelectView, self._npcMo)
end

function SurvivalInitNPCSmallItem:hide()
	gohelper.setActive(self.go, false)
end

function SurvivalInitNPCSmallItem:onDestroy()
	self._teamView = nil
end

return SurvivalInitNPCSmallItem
