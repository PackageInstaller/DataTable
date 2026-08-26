-- chunkname: @modules/logic/handbook/view/HandbookEquipViewContainer.lua

module("modules.logic.handbook.view.HandbookEquipViewContainer", package.seeall)

local HandbookEquipViewContainer = class("HandbookEquipViewContainer", BaseViewContainer)

function HandbookEquipViewContainer:buildViews()
	local views = {}

	table.insert(views, HandbookEquipView.New())
	table.insert(views, TabViewGroup.New(1, "#go_btns"))

	return views
end

function HandbookEquipViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self.navigateView = NavigateButtonsView.New({
			true,
			true,
			false
		})

		return {
			self.navigateView
		}
	end
end

function HandbookEquipViewContainer:onContainerInit()
	self:checkConfigValid()
end

function HandbookEquipViewContainer:onContainerOpenFinish()
	self.navigateView:resetCloseBtnAudioId(AudioEnum.UI.Play_UI_CloseHouse)
	self.navigateView:resetHomeBtnAudioId(AudioEnum.UI.UI_checkpoint_story_close)
end

function HandbookEquipViewContainer:checkConfigValid()
	if not SLFramework.FrameworkSettings.IsEditor then
		return
	end

	local handbookEquipIdDict = {}

	for _, handbookEquipCo in ipairs(lua_handbook_equip.configList) do
		handbookEquipIdDict[handbookEquipCo.equipId] = true
	end

	local equipDict = {}

	for _, equipCo in ipairs(lua_equip.configList) do
		equipDict[equipCo.id] = true
	end

	for equipId, _ in pairs(equipDict) do
		if not handbookEquipIdDict[equipId] then
			local equipCo = lua_equip.configDict[equipId]

			if string.nilorempty(equipCo.canShowHandbook) then
				logError("图鉴心相表未配置装备id : " .. equipId)
			end
		end
	end
end

return HandbookEquipViewContainer
