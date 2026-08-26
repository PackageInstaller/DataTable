-- chunkname: @modules/logic/survival/view/map/comp/SurvivalInitHeroSelectQuickEditItem.lua

module("modules.logic.survival.view.map.comp.SurvivalInitHeroSelectQuickEditItem", package.seeall)

local SurvivalInitHeroSelectQuickEditItem = class("SurvivalInitHeroSelectQuickEditItem", SurvivalInitHeroSelectEditItem)

function SurvivalInitHeroSelectQuickEditItem:init(go)
	SurvivalInitHeroSelectQuickEditItem.super.init(self, go)

	self._goframe = gohelper.findChild(go, "frame")
	self._txtorder = gohelper.findChildTextMesh(go, "go_order/txt_order")
	self._goorderbg = gohelper.findChild(go, "go_order")

	self:enableDeselect(false)
	self._heroItem:setNewShow(false)
	self._heroItem:_setTxtPos("_nameCnTxt", 0.55, 68.9)
	self._heroItem:_setTxtPos("_nameEnTxt", 0.55, 36.1)
	self._heroItem:_setTxtPos("_lvObj", 1.7, 96.8)
	self._heroItem:_setTxtPos("_rankObj", 1.7, -107.7)
	self._heroItem:_setTranScale("_nameCnTxt", 1.25, 1.25)
	self._heroItem:_setTranScale("_nameEnTxt", 1.25, 1.25)
	self._heroItem:_setTranScale("_lvObj", 1.25, 1.25)
	self._heroItem:_setTranScale("_rankObj", 0.22, 0.22)
	self._heroItem:setStyle_SurvivalHeroGroupEdit()
	gohelper.setActive(self._goorderbg, false)
end

function SurvivalInitHeroSelectQuickEditItem:onUpdateMO(mo)
	self._mo = mo

	self._heroItem:onUpdateMO(mo)
	self._heroItem:setNewShow(false)

	if not mo:isTrial() then
		local lv = SurvivalBalanceHelper.getHeroBalanceLv(mo.heroId)

		if lv > mo.level then
			self._heroItem:setBalanceLv(lv)
		end
	end

	self:updateLimitStatus()
	self:updateTrialTag()
	self:updateTrialRepeat()
	self._heroItem:setRepeatAnimFinish()

	local index = self:getGroupModel():getMoIndex(mo)

	self._team_pos_index = index

	gohelper.setActive(self._goorderbg, index > 0)
	gohelper.setActive(self._goframe, index > 0)

	if index > 0 then
		self._txtorder.text = index
	end

	self._open_ani_finish = true

	self._healthPart:setHeroId(mo.heroId)
end

function SurvivalInitHeroSelectQuickEditItem:updateTrialRepeat(mo)
	if mo and (mo.heroId ~= self._mo.heroId or mo == self._mo) then
		return
	end

	self._heroItem:setTrialRepeat(false)
end

function SurvivalInitHeroSelectQuickEditItem:_onItemClick()
	AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_Universal_Click)

	local weekInfo = SurvivalShelterModel.instance:getWeekInfo()

	if weekInfo:getHeroMo(self._mo.heroId).health == 0 then
		GameFacade.showToast(ToastEnum.SurvivalHeroDead)

		return
	end

	local index = self:getGroupModel():getMoIndex(self._mo)

	if index > 0 then
		self:getGroupModel().allSelectHeroMos[index] = nil

		gohelper.setActive(self._goorderbg, false)
		gohelper.setActive(self._goframe, false)
	else
		local addIndex = self:getGroupModel():tryAddHeroMo(self._mo)

		if addIndex then
			self._view:selectCell(self._index, true)
			gohelper.setActive(self._goorderbg, true)
			gohelper.setActive(self._goframe, true)

			self._txtorder.text = addIndex
		else
			GameFacade.showToast(ToastEnum.SurvivalInitHeroLimit)
		end
	end

	HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnHeroEditItemSelectChange, self._mo)
end

function SurvivalInitHeroSelectQuickEditItem:onSelect(select)
	self._isSelect = select

	if select then
		HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnClickHeroEditItem, self._mo)
	end
end

function SurvivalInitHeroSelectQuickEditItem:getGroupModel()
	return SurvivalMapModel.instance:getInitGroup()
end

return SurvivalInitHeroSelectQuickEditItem
