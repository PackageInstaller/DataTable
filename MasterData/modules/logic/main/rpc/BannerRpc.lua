-- chunkname: @modules/logic/main/rpc/BannerRpc.lua

module("modules.logic.main.rpc.BannerRpc", package.seeall)

local BannerRpc = class("BannerRpc", BaseRpc)

BannerRpc.instance = BannerRpc.New()

return BannerRpc
