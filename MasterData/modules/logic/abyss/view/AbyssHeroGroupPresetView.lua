-- chunkname: @modules/logic/abyss/view/AbyssHeroGroupPresetView.lua

module("modules.logic.abyss.view.AbyssHeroGroupPresetView", package.seeall)

local AbyssHeroGroupPresetView = class("AbyssHeroGroupPresetView", HeroGroupPresetFightView)

function AbyssHeroGroupPresetView:_editableInitView()
	AbyssHeroGroupPresetView.super._editableInitView(self)

	self._btnReadPreset = gohelper.findChildButton(self.viewGO, "#go_container/btnContain/horizontal/#btn_readpreset")

	self.addEventCb(self, AbyssController.instance, AbyssEvent.OnSelectStage, self._refreshReadPresetVisible, self)
	self.addEventCb(self, AbyssController.instance, AbyssEvent.OnUpdateStageInfo, self._refreshReadPresetVisible, self)
end

function AbyssHeroGroupPresetView:addEvents()
	AbyssHeroGroupPresetView.super.addEvents(self)

	if self._btnReadPreset then
		self._btnReadPreset:AddClickListener(self._btnReadPresetOnClick, self)
	end
end

function AbyssHeroGroupPresetView:removeEvents()
	AbyssHeroGroupPresetView.super.removeEvents(self)

	if self._btnReadPreset then
		self._btnReadPreset:RemoveClickListener()
	end
end

function AbyssHeroGroupPresetView:_btnReadPresetOnClick()
	local stageMo = AbyssModel.instance:getCurStageMo()

	if stageMo:isChallenged() then
		GameFacade.showToast(ToastEnum.AbyssHeroGroupCannotEdit)

		return
	end

	local heroGroupType = HeroGroupPresetEnum.HeroGroupType.AbyssPreset

	HeroGroupPresetController.instance:openHeroGroupPresetTeamView({
		showType = HeroGroupPresetEnum.ShowType.Copy,
		heroGroupTypeList = {
			heroGroupType
		}
	})
end

function AbyssHeroGroupPresetView:_refreshReadPresetVisible()
	if not self._btnReadPreset then
		return
	end

	local stageMo = AbyssModel.instance:getCurStageMo()
	local haveChallenge = stageMo and stageMo:isChallenged()

	gohelper.setActive(self._btnReadPreset, not haveChallenge)
end

function AbyssHeroGroupPresetView:onOpen()
	AbyssHeroGroupPresetView.super.onOpen(self)
	self:_refreshReadPresetVisible()
end

function AbyssHeroGroupPresetView:_onUseHeroGroup(param)
	if not param or not param.groupId or not param.subId then
		return
	end

	local stageMo = AbyssModel.instance:getCurStageMo()

	if stageMo:isChallenged() then
		return
	end

	if stageMo then
		if not stageMo.heroGroupSubId then
			local targetSubId = 1
			local targetMo = HeroGroupPresetController.instance:copyPresetToOther(param.groupId, param.subId, HeroGroupPresetEnum.HeroGroupType.Abyss, targetSubId, false)

			if targetMo == nil then
				return
			end

			AbyssController.instance:saveSnapShot(targetMo, targetSubId, self._onCopyPresetComplete, self)
		end
	end
end

function AbyssHeroGroupPresetView:_onCopyPresetComplete()
	local actInfo = AbyssModel.instance:getCurInfoMo()

	actInfo:updateHeroUseInfo()
	GameFacade.showToast(ToastEnum.ReadPresetSuccess)
	HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnReadPreset)
	HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnModifyHeroGroup)
	gohelper.setActive(self._goherogroupcontain, false)
	gohelper.setActive(self._goherogroupcontain, true)
	self:_updateHeroGroupName()
end

function AbyssHeroGroupPresetView:_updateHeroGroupName()
	return
end

return AbyssHeroGroupPresetView
