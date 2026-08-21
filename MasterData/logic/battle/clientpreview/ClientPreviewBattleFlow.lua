-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/clientpreview/ClientPreviewBattleFlow.lua

module("logic.battle.clientpreview.ClientPreviewBattleFlow", package.seeall)

local ClientPreviewBattleFlow = class("ClientPreviewBattleFlow", DefaultBattleFlow)

function ClientPreviewBattleFlow:_registerComponents()
	ClientPreviewBattleFlow.super._registerComponents(self)
	self:_addComponent("serverSimulation", ClientPreviewServerSimulation)

	self.netAgent = ClientPreviewBattleNetAgent.instance
end

return ClientPreviewBattleFlow
