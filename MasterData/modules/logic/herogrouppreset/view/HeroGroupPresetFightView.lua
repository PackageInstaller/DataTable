-- chunkname: @modules/logic/herogrouppreset/view/HeroGroupPresetFightView.lua

module("modules.logic.herogrouppreset.view.HeroGroupPresetFightView", package.seeall)

local HeroGroupPresetFightView = class("HeroGroupPresetFightView", BaseView)

function HeroGroupPresetFightView:onInitView()
	self._btnmodifyname = gohelper.findChildButtonWithAudio(self.viewGO, "#go_container/btnContain/horizontal/#drop_herogroup/#btn_changename")
	self._btnchangeteam = gohelper.findChildButtonWithAudio(self.viewGO, "#go_container/btnContain/horizontal/#drop_herogroup/#btn_changeteam")
	self._txtherogroupname = gohelper.findChildText(self.viewGO, "#go_container/btnContain/horizontal/#drop_herogroup/Label")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function HeroGroupPresetFightView:addEvents()
	if self._btnchangeteam then
		self._btnchangeteam:AddClickListener(self._changeTeam, self)
	end
end

function HeroGroupPresetFightView:removeEvents()
	if self._btnchangeteam then
		self._btnchangeteam:RemoveClickListener()
	end
end

function HeroGroupPresetFightView:_editableInitView()
	self._goherogroupcontain = gohelper.findChild(self.viewGO, "herogroupcontain")

	self.addEventCb(self, HeroGroupPresetController.instance, HeroGroupPresetEvent.UseHeroGroup, self._onUseHeroGroup, self)
	self.addEventCb(self, HeroGroupPresetController.instance, HeroGroupPresetEvent.UpdateGroupName, self._onUpdateGroupName, self)
	HeroGroupPresetController.instance:initCopyHeroGroupList()
end

function HeroGroupPresetFightView:_onUpdateGroupName()
	self:_updateHeroGroupName()
end

function HeroGroupPresetFightView:onClose()
	HeroGroupPresetController.instance:revertCurHeroGroup()
	HeroGroupPresetController.instance:clearCopyList()
end

function HeroGroupPresetFightView:onOpen()
	self:_initChangeTeam()
end

function HeroGroupPresetFightView:_onUseHeroGroup(param)
	local selectIndex = param.subId

	if HeroGroupModel.instance:setHeroGroupSelectIndex(selectIndex) then
		HeroGroupModel.instance:_setSingleGroup()

		local fightView = self.viewContainer:getHeroGroupFightView()

		fightView:_checkEquipClothSkill()
		GameFacade.showToast(fightView._changeToastId or ToastEnum.SeasonGroupChanged)
		HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnModifyHeroGroup)
		gohelper.setActive(self._goherogroupcontain, false)
		gohelper.setActive(self._goherogroupcontain, true)
		HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnModifyGroupSelectIndex)
	end

	self:_updateHeroGroupName()
end

function HeroGroupPresetFightView:_initChangeTeam()
	local heroGroupType = HeroGroupModel.instance:getPresetHeroGroupType()

	if not heroGroupType then
		return
	end

	local arrow = gohelper.findChild(self.viewGO, "#go_container/btnContain/horizontal/#drop_herogroup/arrow")

	gohelper.setActive(arrow, false)
	gohelper.setActive(self._btnmodifyname, false)
	gohelper.setActive(self._btnchangeteam, true)
	self:_updateHeroGroupName()
end

function HeroGroupPresetFightView:_updateHeroGroupName()
	local heroGroupType = HeroGroupModel.instance:getPresetHeroGroupType()

	if not heroGroupType then
		return
	end

	local index = self:_getGroupSubId()

	self._txtherogroupname.text = HeroGroupPresetHeroGroupNameController.instance:getName(heroGroupType, index)
end

function HeroGroupPresetFightView:_changeTeam()
	local heroGroupType = HeroGroupModel.instance:getPresetHeroGroupType()

	HeroGroupPresetController.instance:openHeroGroupPresetTeamView({
		subId = self:_getGroupSubId(),
		showType = HeroGroupPresetEnum.ShowType.Fight,
		heroGroupTypeList = {
			heroGroupType
		}
	})
end

function HeroGroupPresetFightView:_getGroupSubId()
	if HeroGroupModel.instance.heroGroupType == ModuleEnum.HeroGroupType.General then
		local snapshotId = HeroGroupSnapshotModel.instance:getCurSnapshotId()

		return HeroGroupSnapshotModel.instance:getCurGroupId(snapshotId)
	end

	return HeroGroupModel.instance.curGroupSelectIndex
end

return HeroGroupPresetFightView
