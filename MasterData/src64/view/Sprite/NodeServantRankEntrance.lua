local NodeServantRankEntrance = class("NodeServantRankEntrance", function()
	return cc.Node:create()
end)
local var_0_1 = require("controller.servant_rank_manager").getInstance()
local Utility = require("common.Utility")
local var_0_3 = var_0_1.FIGHT_TYPE
local var_0_4 = var_0_1.RANK_TYPE
local var_0_6 = config._DEBUG and 0 or 1

function NodeServantRankEntrance:showInLayer(arg_2_1, arg_2_2)
	local var_2_0 = NodeServantRankEntrance:create(arg_2_1)

	self:addChild(var_2_0)
	var_2_0:setPosition(arg_2_2)

	return var_2_0
end

function NodeServantRankEntrance:create(...)
	local var_3_0 = NodeServantRankEntrance.new()

	var_3_0:init(...)

	return var_3_0
end

function NodeServantRankEntrance:init(...)
	self:initData(...)
	self:initUI()
end

function NodeServantRankEntrance:initData(arg_5_1)
	if arg_5_1 then
		self.rankType = arg_5_1.rankType or var_0_4.NORMAL
	end

	if arg_5_1 then
		self.fightType = arg_5_1.fightType or var_0_3.PVE
	end

	if arg_5_1 then
		self.mode = arg_5_1.mode or 0
	end

	if arg_5_1 then
		self.chapter = arg_5_1.chapter or 0
	end

	if arg_5_1 then
		self.clickCallBack = arg_5_1.clickCallBack or nil
	end
end

function NodeServantRankEntrance:initUI()
	local var_6_0 = ccui.Button:create("public/button/btn_rank_entrance.png", nil, "public/button/btn_rank_entrance.png", var_0_6)

	self:addChild(var_6_0)
	Utility:addClickEventListener(var_6_0, handler(self, self.onBtnEntrance))
end

function NodeServantRankEntrance:onBtnEntrance(arg_7_1)
	if self.clickCallBack then
		self.clickCallBack()
	end

	LayerManager:switchShowLayer("ServantRankLayer", {
		fightType = self.fightType,
		rankType = self.rankType,
		mode = self.mode,
		chapter = self.chapter
	})
end

function NodeServantRankEntrance:updateData(arg_8_1)
	if arg_8_1 then
		self.mode = arg_8_1.mode or self.mode
	end

	if arg_8_1 then
		self.chapter = arg_8_1.chapter or self.chapter
	end
end

return NodeServantRankEntrance
