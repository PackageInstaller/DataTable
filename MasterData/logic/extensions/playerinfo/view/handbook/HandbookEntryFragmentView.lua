-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/playerinfo/view/handbook/HandbookEntryFragmentView.lua

module("logic.extensions.playerinfo.view.handbook.HandbookEntryFragmentView", package.seeall)

local M = class("HandbookEntryFragmentView", DynamicFragmentView)
local kView = {
	[CommEnum.HandBookSubView.RelationShip] = {
		viewName = ViewName.HandbookRelationshipEntryView
	},
	[CommEnum.HandBookSubView.CG] = {
		viewName = ViewName.HandbookCGEntryView
	},
	[CommEnum.HandBookSubView.Plot] = {
		viewName = ViewName.HandbookPlotEntryView
	},
	[CommEnum.HandBookSubView.Record] = {
		viewName = ViewName.HandbookRecordEntryView
	},
	[CommEnum.HandBookSubView.Monster] = {
		viewName = ViewName.HandbookMonsterDataEntryView
	},
	[CommEnum.HandBookSubView.Alienation] = {
		viewName = ViewName.HandbookAlienationEntryView
	},
	[CommEnum.HandBookSubView.Music] = {
		viewName = ViewName.HandbookMusicEntryView
	}
}

function M:ctor()
	M.super.ctor(self)
end

function M:buildUI()
	local registry = self:getRegistry()

	self._pageCompGroup = {}
	self._pageCompGroup[CommEnum.HandBookSubView.RelationShip] = {
		btn = UIComponentType.ButtonAdapter(registry:findUIElement("handbook_entry_view_1731660213")),
		processImg = registry:findUIElement("handbook_entry_view_1343479119", UIComponentType.Image),
		processTxt = registry:findUIElement("handbook_entry_view_1670795632", UIComponentType.Text),
		goNewSign = registry:findUIElement("handbook_entry_view_159855486"),
		goNormal = registry:findUIElement("handbook_all_entry_view_916889085"),
		goLock = registry:findUIElement("handbook_all_entry_view_-325908572"),
		txtLock = registry:findUIElement("handbook_all_entry_view_-286358223", UIComponentType.Text)
	}
	self._pageCompGroup[CommEnum.HandBookSubView.CG] = {
		btn = UIComponentType.ButtonAdapter(registry:findUIElement("handbook_entry_view_204031034")),
		processImg = registry:findUIElement("handbook_entry_view_1166199164", UIComponentType.Image),
		processTxt = registry:findUIElement("handbook_entry_view_238327717", UIComponentType.Text),
		goNewSign = registry:findUIElement("handbook_entry_view_1350384784"),
		goNormal = registry:findUIElement("handbook_all_entry_view_-562570711"),
		goLock = registry:findUIElement("handbook_all_entry_view_562161170"),
		txtLock = registry:findUIElement("handbook_all_entry_view_157699846", UIComponentType.Text)
	}
	self._pageCompGroup[CommEnum.HandBookSubView.Plot] = {
		btn = UIComponentType.ButtonAdapter(registry:findUIElement("handbook_entry_view_177039627")),
		processImg = registry:findUIElement("handbook_entry_view_132654386", UIComponentType.Image),
		processTxt = registry:findUIElement("handbook_entry_view_721426055", UIComponentType.Text),
		goNewSign = registry:findUIElement("handbook_entry_view_758560336"),
		goNormal = registry:findUIElement("handbook_all_entry_view_-1169613807"),
		goLock = registry:findUIElement("handbook_all_entry_view_-911164158"),
		txtLock = registry:findUIElement("handbook_all_entry_view_-1614048572", UIComponentType.Text)
	}
	self._pageCompGroup[CommEnum.HandBookSubView.Record] = {
		btn = UIComponentType.ButtonAdapter(registry:findUIElement("handbook_entry_view_2106389976")),
		processImg = registry:findUIElement("handbook_entry_view_1018481073", UIComponentType.Image),
		processTxt = registry:findUIElement("handbook_entry_view_1475030251", UIComponentType.Text),
		goNewSign = registry:findUIElement("handbook_entry_view_76020755"),
		goNormal = registry:findUIElement("handbook_all_entry_view_-1507352602"),
		goLock = registry:findUIElement("handbook_all_entry_view_1294823136"),
		txtLock = registry:findUIElement("handbook_all_entry_view_906051180", UIComponentType.Text)
	}
	self._pageCompGroup[CommEnum.HandBookSubView.Monster] = {
		btn = UIComponentType.ButtonAdapter(registry:findUIElement("handbook_entry_view_1254139588")),
		processImg = registry:findUIElement("handbook_entry_view_2006182069", UIComponentType.Image),
		processTxt = registry:findUIElement("handbook_entry_view_1803488901", UIComponentType.Text),
		goNewSign = registry:findUIElement("handbook_entry_view_1077171009"),
		goNormal = registry:findUIElement("handbook_all_entry_view_1959267704"),
		goLock = registry:findUIElement("handbook_all_entry_view_1638865051"),
		txtLock = registry:findUIElement("handbook_all_entry_view_-1978339976", UIComponentType.Text)
	}
	self._pageCompGroup[CommEnum.HandBookSubView.Alienation] = {
		btn = UIComponentType.ButtonAdapter(registry:findUIElement("handbook_entry_view_1813035856")),
		processImg = registry:findUIElement("handbook_entry_view_857443149", UIComponentType.Image),
		processTxt = registry:findUIElement("handbook_entry_view_193815503", UIComponentType.Text),
		goNewSign = registry:findUIElement("handbook_entry_view_786728572"),
		goNormal = registry:findUIElement("handbook_all_entry_view_371576596"),
		goLock = registry:findUIElement("handbook_all_entry_view_-1942052691"),
		txtLock = registry:findUIElement("handbook_all_entry_view_-158612975", UIComponentType.Text)
	}
	self._pageCompGroup[CommEnum.HandBookSubView.Music] = {
		btn = UIComponentType.ButtonAdapter(registry:findUIElement("handbook_entry_view_1159414671")),
		processImg = registry:findUIElement("handbook_entry_view_488078885", UIComponentType.Image),
		processTxt = registry:findUIElement("handbook_entry_view_815540164", UIComponentType.Text),
		goNewSign = registry:findUIElement("handbook_entry_view_1936265933"),
		goNormal = registry:findUIElement("handbook_all_entry_view_937157710"),
		goLock = registry:findUIElement("handbook_all_entry_view_1912974374"),
		txtLock = registry:findUIElement("handbook_all_entry_view_377359856", UIComponentType.Text)
	}
end

function M:destroyUI()
	self._pageCompGroup = nil
end

function M:bindEvents()
	for pageTypCode, compGroup in pairs(self._pageCompGroup) do
		compGroup.btn:AddClickListener(function()
			self:_onClickSubPageEntry(pageTypCode)
		end, self)
	end
end

function M:unbindEvents()
	for pageTypCode, compGroup in pairs(self._pageCompGroup) do
		compGroup.btn:RemoveClickListener()
	end
end

function M:onEnter()
	self._isEnter = true

	HandbookController.instance:checkAutoUnlockPlotMemory()
	self:_refreshLockTips()
	self:_handleHandbookUnreadInfoChange()
	self:_setEvent(true)
	self:_handleHandbookUnreadInfoChange(nil)
end

function M:onExit()
	self:_setEvent(false)

	self._isEnter = false
end

function M:_setEvent(add)
	if add then
		GlobalDispatcher:addEventListener(EventType.HANDBOOK_UNREAD_INFO_CHANGE, self._handleHandbookUnreadInfoChange, self)
	else
		GlobalDispatcher:removeEventListener(EventType.HANDBOOK_UNREAD_INFO_CHANGE, self._handleHandbookUnreadInfoChange, self)
	end
end

function M:_onKeycodeChange(keycode, isOn)
	if keycode and isOn then
		printError(keycode, isOn)

		if not self._once then
			self._once = true

			local list = LoginPopUpsConfig.instance:getConfigList(ConfigName.LoginPopUps)

			if list then
				for _, v in ipairs(list) do
					local key = "loginPopUpsKey" .. v.code .. PlayerModel.instance:getId()

					Astral.LocalStorage.Instance:DeleteKey(key)
				end
			end

			GlobalDispatcher:dispatchEvent(EventType.FW_CLOCK_TICKDAILYREFRESH)
			GlobalDispatcher:dispatchEvent(EventType.FW_CLOCK_TICKDAY)
		end
	end
end

function M:getMainGo()
	return self.mainGO
end

function M:getRegistry()
	return self._registry
end

function M:_handleHandbookUnreadInfoChange(e)
	for keyStr, valTyp in pairs(CommEnum.HandBookSubView) do
		self:_checkSubPageNewTag(valTyp)
	end

	self:_refreshAllEntryData()
end

function M:_onClickSubPageEntry(pageTypCode)
	if self:_getSubPageTypLock(pageTypCode, true) then
		return
	end

	ViewMgr.instance:open(kView[pageTypCode].viewName)
end

function M:_refreshAllEntryData()
	for pageTypCode, _ in pairs(self._pageCompGroup or {}) do
		self:_refreshEntryData(pageTypCode)
	end
end

function M:_refreshLockTips()
	for pageTypCode, compG in pairs(self._pageCompGroup or {}) do
		local cfgCO = SystemOpenConfig.instance:getSystemOpenCOById(self:_getSubPageTypSystemOpenCode(pageTypCode))

		compG.txtLock.text = cfgCO and cfgCO:getUnlockText() or ""
	end
end

function M:_refreshEntryData(pageTypCode)
	local compGroup = self._pageCompGroup[pageTypCode]

	if compGroup then
		local lock = self:_getSubPageTypLock(pageTypCode)

		goutil.setActive(compGroup.goLock, lock)
		goutil.setActive(compGroup.goNormal, not lock)

		local process = self:_getSubPageTypProcess(pageTypCode)

		compGroup.processImg.fillAmount = lock and 0 or process
		compGroup.processTxt.text = string.format("%s", math.floor(process * 100))
	else
		printError("无法找到该类型页签组件", pageTypCode)
	end
end

function M:_getSubPageTypLock(pageTypCode, showLockTips)
	local systemOpenCode = self:_getSubPageTypSystemOpenCode(pageTypCode)
	local isOpen = SystemOpenFacade.instance:isOpen(systemOpenCode, showLockTips)

	return not isOpen
end

function M:_getSubPageTypSystemOpenCode(pageTypCode)
	return pageTypCode + 28000
end

function M:_getSubPageTypProcess(pageTypCode)
	local process = 0
	local SubViewType = CommEnum.HandBookSubView

	if pageTypCode == SubViewType.RelationShip then
		local max = HandbookConfig.instance:getMaxNum(GameEnum.UnlockTypeEnum.Hero)
		local now = GalleryModel.instance:getTypUnlockCount(GameEnum.UnlockTypeEnum.Hero)

		process = max == 0 and 0 or now / max
	elseif pageTypCode == SubViewType.CG then
		local max = HandbookConfig.instance:getMaxNum(GameEnum.UnlockTypeEnum.CG)
		local now = GalleryModel.instance:getTypUnlockCount(GameEnum.UnlockTypeEnum.CG)

		process = max == 0 and 0 or now / max
	elseif pageTypCode == SubViewType.Plot then
		local max = HandbookConfig.instance:getMaxNum(GameEnum.UnlockTypeEnum.PlotMemory)
		local now = GalleryModel.instance:getTypUnlockCount(GameEnum.UnlockTypeEnum.PlotMemory)

		process = max == 0 and 0 or now / max
	elseif pageTypCode == SubViewType.Record then
		local max = HandbookConfig.instance:getMaxNum(GameEnum.UnlockTypeEnum.Event)

		max = max + HandbookConfig.instance:getMaxNum(GameEnum.UnlockTypeEnum.Word)

		local now = GalleryModel.instance:getTypUnlockCount(GameEnum.UnlockTypeEnum.Event)

		now = now + GalleryModel.instance:getTypUnlockCount(GameEnum.UnlockTypeEnum.Word)
		process = max == 0 and 0 or now / max
	elseif pageTypCode == SubViewType.Monster then
		local max = HandbookConfig.instance:getMaxNum(GameEnum.UnlockTypeEnum.Monster)
		local now = GalleryModel.instance:getTypUnlockCount(GameEnum.UnlockTypeEnum.Monster)

		process = max == 0 and 0 or now / max
	elseif pageTypCode == SubViewType.Alienation then
		local max = HandbookConfig.instance:getMaxNum(GameEnum.UnlockTypeEnum.Protomer)

		max = max + HandbookConfig.instance:getMaxNum(GameEnum.UnlockTypeEnum.EchoItem)

		local now = GalleryModel.instance:getTypUnlockCount(GameEnum.UnlockTypeEnum.Protomer)

		now = now + GalleryModel.instance:getTypUnlockCount(GameEnum.UnlockTypeEnum.EchoItem)
		process = max == 0 and 0 or now / max
	elseif pageTypCode == SubViewType.Music then
		local max = HandbookConfig.instance:getMaxNum(GameEnum.UnlockTypeEnum.Music)
		local now = GalleryModel.instance:getTypUnlockCount(GameEnum.UnlockTypeEnum.Music)

		process = max == 0 and 0 or now / max
	end

	return process
end

function M:_checkSubPageNewTag(pageTypCode)
	local count = 0
	local goNewTag = self._pageCompGroup[pageTypCode].goNewSign
	local SubViewType = CommEnum.HandBookSubView

	if pageTypCode == SubViewType.RelationShip then
		count = GalleryModel.instance:getTypUnReadCount(GameEnum.UnlockTypeEnum.Hero)
		count = count + GalleryModel.instance:getTypUnReadCount(GameEnum.UnlockTypeEnum.HeroRelation)
	elseif pageTypCode == SubViewType.CG then
		count = GalleryModel.instance:getTypUnReadCount(GameEnum.UnlockTypeEnum.CG)
	elseif pageTypCode == SubViewType.Plot then
		count = GalleryModel.instance:getTypUnReadCount(GameEnum.UnlockTypeEnum.PlotMemory)
	elseif pageTypCode == SubViewType.Record then
		count = GalleryModel.instance:getTypUnReadCount(GameEnum.UnlockTypeEnum.Event)
		count = count + GalleryModel.instance:getTypUnReadCount(GameEnum.UnlockTypeEnum.Word)
	elseif pageTypCode == SubViewType.Monster then
		count = GalleryModel.instance:getTypUnReadCount(GameEnum.UnlockTypeEnum.Monster)
	elseif pageTypCode == SubViewType.Alienation then
		count = GalleryModel.instance:getTypUnReadCount(GameEnum.UnlockTypeEnum.Protomer)
		count = count + GalleryModel.instance:getTypUnReadCount(GameEnum.UnlockTypeEnum.EchoItem)
	elseif pageTypCode == SubViewType.Music then
		count = GalleryModel.instance:getTypUnReadCount(GameEnum.UnlockTypeEnum.Music)
	end

	local lock = self:_getSubPageTypLock(pageTypCode)

	if lock then
		count = 0
	end

	goutil.setActive(goNewTag, count > 0)
end

function M:_clearSubPageNewTag(pageTypCode)
	local goNewTag = self._pageCompGroup[pageTypCode].goNewSign

	goutil.setActive(goNewTag, false)

	local SubViewType = CommEnum.HandBookSubView

	if pageTypCode == SubViewType.RelationShip then
		HandbookController.instance:setHandbookTypAllRead(GameEnum.UnlockTypeEnum.Hero)
		HandbookController.instance:setHandbookTypAllRead(GameEnum.UnlockTypeEnum.HeroRelation)
	elseif pageTypCode == SubViewType.CG then
		HandbookController.instance:setHandbookTypAllRead(GameEnum.UnlockTypeEnum.CG)
	elseif pageTypCode == SubViewType.Plot then
		HandbookController.instance:setHandbookTypAllRead(GameEnum.UnlockTypeEnum.PlotMemory)
	elseif pageTypCode == SubViewType.Record then
		HandbookController.instance:setHandbookTypAllRead(GameEnum.UnlockTypeEnum.Event)
		HandbookController.instance:setHandbookTypAllRead(GameEnum.UnlockTypeEnum.Word)
	elseif pageTypCode == SubViewType.Monster then
		HandbookController.instance:setHandbookTypAllRead(GameEnum.UnlockTypeEnum.Monster)
	elseif pageTypCode == SubViewType.Alienation then
		HandbookController.instance:setHandbookTypAllRead(GameEnum.UnlockTypeEnum.Protomer)
		HandbookController.instance:setHandbookTypAllRead(GameEnum.UnlockTypeEnum.EchoItem)
	elseif pageTypCode == SubViewType.Music then
		HandbookController.instance:setHandbookTypAllRead(GameEnum.UnlockTypeEnum.Music)
	end
end

return M
