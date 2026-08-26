-- chunkname: @modules/logic/equip/controller/EquipEvent.lua

module("modules.logic.equip.controller.EquipEvent", package.seeall)

local EquipEvent = _M

EquipEvent.onChooseEquip = 1
EquipEvent.onDeleteEquip = 2
EquipEvent.onUpdateEquip = 3
EquipEvent.onChooseAttr = 4
EquipEvent.onStrengthenFast = 5
EquipEvent.onStrengthenUpgrade = 6
EquipEvent.onDecomposeSuccess = 7
EquipEvent.onChangeStrengthenScrollState = 9
EquipEvent.onHideChooseEquipList = 10
EquipEvent.onChooseChange = 11
EquipEvent.onBreakMaxLevel = 12
EquipEvent.onEquipStrengthenReply = 13
EquipEvent.onRefreshEquipResolveList = 14
EquipEvent.onSelectResolveScrollItem = 15
EquipEvent.onShowBreakCostListModelContainer = 16
EquipEvent.onShowStrengthenListModelContainer = 17
EquipEvent.onHideBreakAndStrengthenListModelContainer = 18
EquipEvent.onBreakSuccess = 19
EquipEvent.onSelectRefineScrollItem = 20
EquipEvent.onEquipRefineReply = 21
EquipEvent.onChangeRefineScrollState = 50
EquipEvent.onCloseEquipStrengthenView = 51
EquipEvent.onAddEquipToPlayEffect = 52
EquipEvent.onOpenEquipScroll = 53
EquipEvent.onOpenRefineEquipScroll = 54
EquipEvent.onCloseEquipRefineView = 55
EquipEvent.onEquipLockChange = 56
EquipEvent.onCloseEquipLevelUpView = 57
EquipEvent.onRefreshRefineEquipList = 58
EquipEvent.ChangeSelectedEquip = 59
EquipEvent.OnRefineSelectedEquipChange = 60
EquipEvent.OnEquipTypeHasChange = 61
EquipEvent.equipHasRefine = 100
EquipEvent.onGuideChooseEquip = 201
EquipEvent.OnEquipDecomposeSelectEquipChange = 301
EquipEvent.OnEquipDecomposeSortStatusChange = 302
EquipEvent.OnEquipBeforeDecompose = 303

return EquipEvent
