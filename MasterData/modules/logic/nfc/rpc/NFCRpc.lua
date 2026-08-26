-- chunkname: @modules/logic/nfc/rpc/NFCRpc.lua

module("modules.logic.nfc.rpc.NFCRpc", package.seeall)

local NFCRpc = class("NFCRpc", BaseRpc)

NFCRpc.instance = NFCRpc.New()

return NFCRpc
