-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roguelike/flow/component/interface/IRogueFlowComp.lua

module("logic.extensions.roguelike.flow.component.interface.IRogueFlowComp", package.seeall)

local M = class("IRogueFlowComp")

M.flow = false
M[BattleFunctionName.onInit] = false
M[BattleFunctionName.onStart] = false
M[BattleFunctionName.onResourceLoaded] = false
M[BattleFunctionName.onEnterDone] = false
M[BattleFunctionName.onClear] = false

return M
