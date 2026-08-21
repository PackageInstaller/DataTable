-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/charactersystem/view/equip/new/EquipIntensifyMainViewNewPresentor.lua

module("logic.extensions.charactersystem.view.equip.new.EquipIntensifyMainViewNewPresentor", package.seeall)

local IntensiTyTitle = class("IntensiTyTitleView", TitleView)

function IntensiTyTitle:back()
	self._viewPresentor:tryBack()
end

function IntensiTyTitle:_onClickHint()
	local status = self._viewPresentor:getUIStatus()

	if status == EquipEnum.MainUIStatus.LvUp then
		ViewMgr.instance:open(ViewName.ImageGuide, {
			CommEnum.GuideID.EquipLvUp
		})
	elseif status == EquipEnum.MainUIStatus.Timing then
		ViewMgr.instance:open(ViewName.ImageGuide, {
			CommEnum.GuideID.EquipTiming
		})
	elseif status == EquipEnum.MainUIStatus.Retiming then
		ViewMgr.instance:open(ViewName.ImageGuide, {
			CommEnum.GuideID.EquipRetiming
		})
	end
end

local M = class("EquipIntensifyMainViewNewPresentor", ViewPresentor)

function M:ctor()
	M.super.ctor(self)

	self._statusView = false
end

function M:dependWhatResources()
	return {
		ResName.Equipsystem_new_equip_function_view_copy,
		CommonResPath.Url_Currency_Item,
		IconLoader.getSpriteAtlasUrl(IconType.DynSpriteAtlas_Backpack)
	}
end

function M:buildViews()
	local views = {}
	local lvView = EquipIntensifyMainViewNew.New()
	local timingView = EquipTimingViewNew.New()
	local retmingView = EquipTimingResetViewNew.New()
	local statusComp = EquipViewStatusComponent.New()

	statusComp:setStatusView(lvView, timingView, retmingView)
	table.insert(views, lvView)
	table.insert(views, timingView)
	table.insert(views, retmingView)
	table.insert(views, statusComp)
	table.insert(views, IntensiTyTitle.New())
	table.insert(views, EquipIntencifyMoneyView.New())

	self._statusView = statusComp

	return views
end

function M:tryBack()
	self._statusView:tryBack()
end

function M:getUIStatus()
	return self._statusView:getUIStatus()
end

function M:inUIStatus(status)
	local curStatus = self._statusView:getUIStatus()

	return curStatus and curStatus == status
end

return M
