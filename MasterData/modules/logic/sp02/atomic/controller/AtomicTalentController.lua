-- chunkname: @modules/logic/sp02/atomic/controller/AtomicTalentController.lua

module("modules.logic.sp02.atomic.controller.AtomicTalentController", package.seeall)

local AtomicTalentController = class("AtomicTalentController", BaseController)

function AtomicTalentController:onInit()
	return
end

function AtomicTalentController:onInitFinish()
	return
end

function AtomicTalentController:reInit()
	return
end

function AtomicTalentController:onOpenView(viewParam)
	self._isOpening = true

	AtomicTalentViewModel.instance:initDatas(viewParam)
end

function AtomicTalentController:onCloseView()
	self._isOpening = false

	AtomicTalentViewModel.instance:clear()
end

function AtomicTalentController:notifyUpdateView()
	AtomicTalentViewModel.instance:onModelUpdate()
	self:dispatchEvent(AtomicEvent.TalentUpdate)
end

function AtomicTalentController:trySelectBranch(branchId)
	if not AtomicTalentViewModel.instance:trySelectBranch(branchId) then
		return
	end

	self:dispatchEvent(AtomicEvent.TalentBranchChange)
	self:notifyUpdateView()
end

function AtomicTalentController:trySelectNodeId(nodeId)
	if not AtomicTalentViewModel.instance:trySelectNodeId(nodeId) then
		return
	end

	self:notifyUpdateView()
end

function AtomicTalentController:trySelectSlot(slot)
	if not AtomicTalentViewModel.instance:trySelectSlot(slot) then
		return
	end

	self:notifyUpdateView()
end

function AtomicTalentController:tryInstallTalent(nodeId, slot)
	if not slot then
		return
	end

	local canInstall = AtomicTalentViewModel.instance:isNodeCanTalent(nodeId)

	if not canInstall then
		return
	end

	local isUnlock = AtomicTalentViewModel.instance:isNodeUnlocked(nodeId)

	if not isUnlock then
		return
	end

	local isInstalled = AtomicTalentViewModel.instance:isNodeInstalled(nodeId)

	if isInstalled then
		return
	end

	local list = AtomicTalentViewModel.instance:equipTalent(nodeId, slot)

	AtomicDungeonStatHelper.instance:senTalentInfo({
		nodeId
	}, AtomicDungeonEnum.OptionType.Install, list)
	AtomicRpc.instance:sendAtomicTalentSkillChooseRequest(list)
end

function AtomicTalentController:tryRemoveTalent(nodeId)
	local isInstalled = AtomicTalentViewModel.instance:isNodeInstalled(nodeId)

	if not isInstalled then
		return
	end

	local list = AtomicTalentViewModel.instance:removeTalent(nodeId)

	AtomicDungeonStatHelper.instance:senTalentInfo({
		nodeId
	}, AtomicDungeonEnum.OptionType.UnInstall, list)
	AtomicRpc.instance:sendAtomicTalentSkillChooseRequest(list)
end

function AtomicTalentController:tryUnlockTalent(nodeId)
	local canUnlock = AtomicTalentViewModel.instance:isCanUnlockTalent(nodeId, true)

	if not canUnlock then
		return
	end

	local installIds = AtomicTalentViewModel.instance:getTalentEquipList()

	AtomicDungeonStatHelper.instance:senTalentInfo({
		nodeId
	}, AtomicDungeonEnum.OptionType.Unlock, installIds)
	AtomicRpc.instance:sendAtomicTalentNodeUnlockRequest(nodeId)
end

function AtomicTalentController:tryResetTalent(nodeId)
	local isUnlock = AtomicTalentViewModel.instance:isNodeUnlocked(nodeId)

	if not isUnlock then
		return
	end

	local isInstalled = AtomicTalentViewModel.instance:isNodeInstalled(nodeId)

	if isInstalled then
		return
	end

	local config = AtomicConfig.instance:getTalentConfig(nodeId)
	local branchId = config.branchId

	local function func()
		AtomicRpc.instance:sendAtomicTalentResetRequest(branchId, nodeId)
	end

	GameFacade.showMessageBox(MessageBoxIdDefine.AtomicTalentResetConfirm2, MsgBoxEnum.BoxType.Yes_No, func)
end

function AtomicTalentController:onResetTalent()
	AtomicTalentViewModel.instance:initDatas()
	self:notifyUpdateView()
end

function AtomicTalentController:onUnlockTalent()
	self:notifyUpdateView()
end

AtomicTalentController.instance = AtomicTalentController.New()

LuaEventSystem.addEventMechanism(AtomicTalentController.instance)

return AtomicTalentController
