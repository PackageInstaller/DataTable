-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/petRace/view/component/PetRacePrelimLayer.lua

PetRacePrelimLayer = class("PetRacePrelimLayer", DmBaseUI)

PetRacePrelimLayer:has("_petRaceSystem", {
	is = "r"
}):injectWith("PetRaceSystem")

local kBtnHandlers = {}
local kCellWidth, kCellHeight, kCellGap = 568, 50, 5

function PetRacePrelimLayer:initialize(data)
	super.initialize(self)
	self:setView(data.view)
	self:initView()
	self:mapButtonHandlersClick(kBtnHandlers)
end

function PetRacePrelimLayer:initView()
	AdjustUtils.adjustLayoutUIByRootNode(self:getView())
end

function PetRacePrelimLayer:refreshView()
	self:updateEightRank()
	self:updateMyScoreNum()
	self:updateMyRankNum()
	self:updateMyWinkNum()
	self:updateTotalUser()
end

function PetRacePrelimLayer:updateEightRank()
	local rankList = self._petRaceSystem:getEightRankData()
	local node_rank = self:getView():getChildByFullName("Panel_base.Node_rank")

	for i = 1, 8 do
		local data_role = rankList[i]
		local node_cell = node_rank:getChildByName("Node_" .. i)
		local text_name = node_cell:getChildByName("Text_name")
		local text_score = node_cell:getChildByName("Text_score_num")
		local text_win = node_cell:getChildByName("Text_win_num")
		local nameStr = tostring(i) .. "."

		if data_role and data_role.nickname and data_role.nickname ~= "" then
			text_name:setString(nameStr .. data_role.nickname)
		else
			text_name:setString(nameStr .. Strings:get("Petrace_Text_82"))
		end

		if data_role and data_role.score then
			text_score:setString(data_role.score)
		else
			text_score:setString("0")
		end

		if data_role and data_role.winNum then
			text_win:setString(data_role.winNum)
		else
			text_win:setString("0")
		end
	end
end

function PetRacePrelimLayer:updateMyScoreNum()
	local num = self._petRaceSystem:getScore()
	local text_score = self:getView():getChildByFullName("Panel_base.Text_scoreNum")

	text_score:setString(num)
end

function PetRacePrelimLayer:updateMyRankNum()
	local num = self._petRaceSystem:getRank()
	local totalUser = self._petRaceSystem:getTotalUser()

	if num == -1 then
		num = totalUser
	end

	local text_rank = self:getView():getChildByFullName("Panel_base.Text_rankNum")

	text_rank:setString(num)
end

function PetRacePrelimLayer:updateMyWinkNum()
	local num = self._petRaceSystem:getWinNum()
	local text_winNum = self:getView():getChildByFullName("Panel_base.Text_winNum")

	text_winNum:setString(num)
end

function PetRacePrelimLayer:updateTotalUser()
	local num = self._petRaceSystem:getTotalUser()
	local text_remainNum = self:getView():getChildByFullName("Panel_base.Text_remainNum")

	text_remainNum:setString(num)
end

function PetRacePrelimLayer:updateTime()
	local node_time = self:getView():getChildByFullName("Panel_base.Node_time")

	self._petRaceSystem:updateTimeDes(node_time, nil, nil, nil, {
		0,
		0,
		0,
		255
	})
end
