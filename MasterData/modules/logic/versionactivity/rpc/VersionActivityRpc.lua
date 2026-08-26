-- chunkname: @modules/logic/versionactivity/rpc/VersionActivityRpc.lua

module("modules.logic.versionactivity.rpc.VersionActivityRpc", package.seeall)

local VersionActivityRpc = class("VersionActivityRpc", BaseRpc)

VersionActivityRpc.instance = VersionActivityRpc.New()

return VersionActivityRpc
