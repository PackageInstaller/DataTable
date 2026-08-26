-- chunkname: @modules/logic/herogroup/view/HeroGroupFightFiveHeroView.lua

module("modules.logic.herogroup.view.HeroGroupFightFiveHeroView", package.seeall)

local HeroGroupFightFiveHeroView = class("HeroGroupFightFiveHeroView", HeroGroupFightView)

function HeroGroupFightFiveHeroView:_editableInitView()
	self:checkHeroList()
	HeroGroupFightFiveHeroView.super._editableInitView(self)
end

function HeroGroupFightFiveHeroView:checkHeroList()
	local roleNum = ModuleEnum.FiveHeroEnum.MaxHeroNum
	local groupMO = HeroGroupModel.instance:getCurGroupMO()

	HeroSingleGroupModel.instance:setMaxHeroCount(roleNum)
	HeroSingleGroupModel.instance:setSingleGroup(groupMO)
end

function HeroGroupFightFiveHeroView._getKey()
	return (string.format("%s_%s", PlayerPrefsKey.FiveHeroGroupSelectIndex, PlayerModel.instance:getPlayinfo().userId))
end

function HeroGroupFightFiveHeroView:_initFightGroupDrop()
	self:_initFightGroupDropFiveHero()
	self:_checkEquipClothSkill()
end

function HeroGroupFightFiveHeroView:_initFightGroupDropFiveHero()
	if not self:_noAidHero() then
		return
	end

	local list = {}

	for i = 1, 4 do
		local info = HeroGroupSnapshotModel.instance:getHeroGroupInfo(ModuleEnum.HeroGroupSnapshotType.FiveHero, i)
		local name = info and info.name

		list[i] = not string.nilorempty(name) and name or formatLuaLang("herogroup_common_name", GameUtil.getNum2Chinese(i))
	end

	local selectIndex = PlayerPrefsHelper.getNumber(self:_getKey(), 0)

	self:_setHeroGroupSelectIndex((selectIndex == 0 or nil) and (ModuleEnum.FiveHeroEnum.FifthIndex or selectIndex))
	gohelper.setActive(self._btnmodifyname, selectIndex ~= 0)

	local name = HeroGroupModel.instance:getGroupTypeName()

	if name then
		table.insert(list, 1, name)
	else
		selectIndex = selectIndex - 1
	end

	self._dropherogroup:ClearOptions()
	self._dropherogroup:AddOptions(list)
	self._dropherogroup:SetValue(selectIndex)
	gohelper.setActive(self._dropherogroup, false)
end

function HeroGroupFightFiveHeroView:_groupDropValueChanged(value)
	PlayerPrefsHelper.setNumber(self:_getKey(), value)

	local selectIndex = value

	gohelper.setActive(self._btnmodifyname, selectIndex ~= 0)

	selectIndex = value == 0 and ModuleEnum.FiveHeroEnum.FifthIndex or value

	if self:_setHeroGroupSelectIndex(selectIndex) then
		self:_checkEquipClothSkill()
		HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnModifyHeroGroup)
		gohelper.setActive(self._goherogroupcontain, false)
		gohelper.setActive(self._goherogroupcontain, true)
		HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnModifyGroupSelectIndex)
	end
end

function HeroGroupFightFiveHeroView:_setHeroGroupSelectIndex(index)
	HeroGroupSnapshotModel.instance:setSelectIndex(ModuleEnum.HeroGroupSnapshotType.FiveHero, index)
	HeroGroupModel.instance:_setSingleGroup()

	return true
end

function HeroGroupFightFiveHeroView:onClose()
	HeroGroupFightFiveHeroView.super.onClose(self)
	HeroSingleGroupModel.instance:setMaxHeroCount()
end

function HeroGroupFightFiveHeroView:_refreshBtns(isCostPower)
	HeroGroupFightFiveHeroView.super._refreshBtns(self, isCostPower)
	gohelper.setActive(self._dropherogroup, false)
end

return HeroGroupFightFiveHeroView
