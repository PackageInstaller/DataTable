-- chunkname: @modules/logic/sodache/model/SodacheCardMo.lua

module("modules.logic.sodache.model.SodacheCardMo", package.seeall)

local SodacheCardMo = pureTable("SodacheCardMo")

function SodacheCardMo.Create(configId, count)
	local itemMo = SodacheItemMo.New()

	itemMo:init({
		configId = configId,
		count = count or 1
	})

	return itemMo:toCardMo(SodacheEnum.CardSource.ClientShow)
end

function SodacheCardMo:init(serverMo, source)
	self.serverMo = serverMo
	self.source = source or SodacheEnum.CardSource.Normal
end

return SodacheCardMo
