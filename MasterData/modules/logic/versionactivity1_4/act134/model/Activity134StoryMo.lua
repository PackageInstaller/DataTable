-- chunkname: @modules/logic/versionactivity1_4/act134/model/Activity134StoryMo.lua

module("modules.logic.versionactivity1_4.act134.model.Activity134StoryMo", package.seeall)

local Activity134StoryMo = class("Activity134StoryMo")

function Activity134StoryMo:ctor()
	self.config = nil
	self.index = nil
	self.status = Activity134Enum.StroyStatus.Orgin
	self.title = nil
	self.desc = {}
	self.introduce = {}
	self.needTokensType = nil
	self.needTokensId = nil
	self.needTokensQuantity = nil
	self.icon = nil
end

function Activity134StoryMo:init(index, config)
	self.config = config
	self.index = index
	self.title = config.title
	self.storyType = config.storyType

	self:setDesc()

	local costs = string.splitToNumber(config.needTokens, "#")

	self.needTokensType = costs[1]
	self.needTokensId = costs[2]
	self.needTokensQuantity = costs[3]
end

function Activity134StoryMo:setDesc()
	if not self.config then
		return
	end

	local coDesc = self.config.desc
	local descSpilt = string.split(coDesc, "|")

	for _, id in ipairs(descSpilt) do
		local storyCo = Activity134Config.instance:getStoryConfig(tonumber(id))

		if not storyCo or storyCo.storyType ~= self.storyType then
			logError("[1.4运营活动下半场尘封记录数据错误] 故事配置错误:" .. id)

			return
		end

		table.insert(self.desc, storyCo)
	end
end

return Activity134StoryMo
