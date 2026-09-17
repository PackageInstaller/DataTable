PopTalkLayer = class("PopTalkLayer", function()
	return cc.Layer:create()
end)

require("view.Sprite.TalkSprite")

local conversation_class_data = require("data.conversation_class_data")
local role_conversation_data = require("data.role_conversation_data")
local var_0_2
local var_0_3 = 1

function PopTalkLayer.create(arg_2_0, arg_2_1)
	local var_2_0 = PopTalkLayer.new()

	var_2_0:init(arg_2_1)

	return var_2_0
end

function PopTalkLayer.getInstance()
	return var_0_2
end

function PopTalkLayer:init(arg_4_1)
	var_0_2 = self

	if arg_4_1 == var_0_3 then
		if math.random(10) > 4 then
			return
		end

		self:popTalk()
	end

	self:registerScriptHandler(function(arg_5_0)
		if arg_5_0 == "exit" then
			getRoleLayerInstance = nil

			if self.callback then
				self.callback()
			end
		end
	end)
end

function PopTalkLayer.popTalk(arg_6_0)
	local var_6_0 = {}
	local var_6_1 = {}

	for iter_6_0, iter_6_1 in pairs(FightManager.players) do
		if iter_6_1._instance and iter_6_1:getStatus() ~= STATUS_DIED then
			table.insert(var_6_0, iter_6_1)
		end
	end

	local var_6_2 = var_6_0[#var_6_0 == 1 and 1 or math.random(#var_6_0)]

	::label_6_0::

	local var_6_4

	if conversation_class_data[var_6_2.model.soulid * 10000 + 301] then
		repeat
			table.insert(var_6_1, conversation_class_data[var_6_2.model.soulid * 10000 + 301].conversation1)

			goto label_6_0
		until true

		var_6_4 = role_conversation_data
	end

	var_6_2:addChild(TalkSprite:create(var_6_4[var_6_1[#var_6_1 == 1 and 1 or math.random(#var_6_1)]].dec))
end
