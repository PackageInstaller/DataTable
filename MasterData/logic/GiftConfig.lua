-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/config/GiftConfig.lua

module("logic.extensions.config.GiftConfig", package.seeall)

local GiftConfig = class("GiftConfig", BaseConfig)

function GiftConfig:onInit()
	GiftConfig.super.onInit(self)

	self._giftCfg = {}
	self._giftCfg2 = {}
end

function GiftConfig:getNames()
	return {
		"pack"
	}
end

function GiftConfig:handleConfig(name, content)
	if name == "pack" then
		for i, v in ipairs(content.dataList) do
			local gift = {}
			local itemStrs = string.split(v.content, "#")

			for _, itemStr in ipairs(itemStrs) do
				local values = string.split(itemStr, ":")
				local type, id, num = unpack(values)
				local var_3_0 = {}

				var_3_0.type = tonumber(type) or 0
				var_3_0.id = tonumber(id) or 0
				var_3_0.num = tonumber(num) or 0

				local item = var_3_0

				table.insert(gift, item)
			end

			table.insert(self._giftCfg, i, gift)
		end

		self._giftCfg2 = content
	end
end

function GiftConfig:GetGift(id)
	return self._giftCfg[id]
end

function GiftConfig:GetGift2(id)
	return self._giftCfg2[id]
end

GiftConfig.instance = GiftConfig.New()

return GiftConfig
