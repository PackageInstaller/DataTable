-- chunkname: @modules/logic/autochess/main/model/rpcmo/AutoChessBaseInfoMo.lua

module("modules.logic.autochess.main.model.rpcmo.AutoChessBaseInfoMo", package.seeall)

local AutoChessBaseInfoMo = pureTable("AutoChessBaseInfoMo")

function AutoChessBaseInfoMo:init(data)
	self.sceneRound = data.sceneRound
	self.previewCoin = data.previewCoin
	self.preview = data.preview
	self.buyInfos = GameUtil.rpcInfosToList(data.buyInfos, AutoChessBuyInfoMo)
end

return AutoChessBaseInfoMo
