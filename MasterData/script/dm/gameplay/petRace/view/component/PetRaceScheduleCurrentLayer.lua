-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/petRace/view/component/PetRaceScheduleCurrentLayer.lua

PetRaceScheduleCurrentLayer = class("PetRaceScheduleCurrentLayer", DmBaseUI)

PetRaceScheduleCurrentLayer:has("_petRaceSystem", {
	is = "r"
}):injectWith("PetRaceSystem")

local kBtnHandlers = {}

function PetRaceScheduleCurrentLayer:initialize(data)
	super.initialize(self)
	self:setView(data.view)
	self:intiView()
	self:mapButtonHandlersClick(kBtnHandlers)
end

function PetRaceScheduleCurrentLayer:intiView()
	self._node_normal = self:getView():getChildByName("Node_normal")
	self._node_eight = self:getView():getChildByName("Node_eight")
	self._node_notice_r = self:getView():getChildByName("Node_notice_r")
	self._node_notice_l = self:getView():getChildByName("Node_notice_l")

	self._node_normal:getChildByFullName("Node_info_l.Text_cost_des"):enableOutline(cc.c4b(0, 0, 0, 219.29999999999998), 1)
	self._node_normal:getChildByFullName("Node_info_l.Text_power_des"):enableOutline(cc.c4b(0, 0, 0, 219.29999999999998), 1)
	self._node_normal:getChildByFullName("Node_info_l.Text_first_des"):enableOutline(cc.c4b(0, 0, 0, 219.29999999999998), 1)
	self._node_normal:getChildByFullName("Node_info_r.Text_cost_des"):enableOutline(cc.c4b(0, 0, 0, 219.29999999999998), 1)
	self._node_normal:getChildByFullName("Node_info_r.Text_power_des"):enableOutline(cc.c4b(0, 0, 0, 219.29999999999998), 1)
	self._node_normal:getChildByFullName("Node_info_r.Text_first_des"):enableOutline(cc.c4b(0, 0, 0, 219.29999999999998), 1)
end

function PetRaceScheduleCurrentLayer:refreshView()
	local round = self._petRaceSystem:getRound()
	local scoreRound = self._petRaceSystem:getScoreMaxRound()
	local roundList = self._petRaceSystem:getRoundList()

	if round > #roundList then
		round = #roundList
	end

	self._node_normal:setVisible(false)
	self._node_eight:setVisible(false)

	if scoreRound < round then
		self:refreshEight()
	else
		self:refreshNormal()
	end

	self:updateTime()
end

function PetRaceScheduleCurrentLayer:refreshNormal()
	self._node_normal:setVisible(true)

	local myCurrentEmbattleInfo = self._petRaceSystem:getMyCurrentEmbattleInfo()
	local maxCost = self._petRaceSystem:getMaxCost()
	local text_cost_l = self._node_normal:getChildByFullName("Node_info_l.Text_cost")

	text_cost_l:enableOutline(cc.c4b(0, 0, 0, 219.29999999999998), 1)

	local text_power_l = self._node_normal:getChildByFullName("Node_info_l.Text_power")

	text_power_l:enableOutline(cc.c4b(0, 0, 0, 219.29999999999998), 1)

	local text_first_l = self._node_normal:getChildByFullName("Node_info_l.Text_first")

	text_first_l:enableOutline(cc.c4b(0, 0, 0, 219.29999999999998), 1)

	local text_lv_l = self._node_normal:getChildByFullName("Text_lv_l")

	text_lv_l:enableOutline(cc.c4b(0, 0, 0, 219.29999999999998), 1)

	local text_name_l = self._node_normal:getChildByFullName("Text_name_l")

	text_name_l:enableOutline(cc.c4b(0, 0, 0, 219.29999999999998), 1)

	local node_role_l = self._node_normal:getChildByFullName("Node_role_l")
	local node_9frame_l = self._node_normal:getChildByFullName("Node_9frame_l")

	text_cost_l:setString(myCurrentEmbattleInfo.cost .. "/" .. maxCost)
	text_power_l:setString(myCurrentEmbattleInfo.combat)
	text_first_l:setString(myCurrentEmbattleInfo.speed)
	text_lv_l:setString("Lv." .. myCurrentEmbattleInfo.level)
	text_name_l:setString(myCurrentEmbattleInfo.name)
	self._petRaceSystem:refreshNineEmbattle(myCurrentEmbattleInfo.embattle, node_9frame_l)
	self._petRaceSystem:refreshIconEmbattle(myCurrentEmbattleInfo.embattle, node_role_l, true)

	local enemyCurrentEmbattleInfo = self._petRaceSystem:getEnemyCurrentEmbattleInfo()
	local text_cost_r = self._node_normal:getChildByFullName("Node_info_r.Text_cost")

	text_cost_r:enableOutline(cc.c4b(0, 0, 0, 219.29999999999998), 1)

	local text_power_r = self._node_normal:getChildByFullName("Node_info_r.Text_power")

	text_power_r:enableOutline(cc.c4b(0, 0, 0, 219.29999999999998), 1)

	local text_first_r = self._node_normal:getChildByFullName("Node_info_r.Text_first")

	text_first_r:enableOutline(cc.c4b(0, 0, 0, 219.29999999999998), 1)

	local text_lv_r = self._node_normal:getChildByFullName("Text_lv_r")

	text_lv_r:enableOutline(cc.c4b(0, 0, 0, 219.29999999999998), 1)

	local text_name_r = self._node_normal:getChildByFullName("Text_name_r")

	text_name_r:enableOutline(cc.c4b(0, 0, 0, 219.29999999999998), 1)

	local node_role_r = self._node_normal:getChildByFullName("Node_role_r")
	local node_9frame_r = self._node_normal:getChildByFullName("Node_9frame_r")
	local text_noneEmbattle_l = self._node_normal:getChildByFullName("Text_noneEmbattle_l")
	local text_noneEmbattle_r = self._node_normal:getChildByFullName("Text_noneEmbattle_r")
	local text_nonePlayer_r = self._node_normal:getChildByFullName("Text_nonePlayer_r")

	text_noneEmbattle_l:enableOutline(cc.c4b(0, 0, 0, 219.29999999999998), 1)
	text_noneEmbattle_r:enableOutline(cc.c4b(0, 0, 0, 219.29999999999998), 1)
	text_nonePlayer_r:enableOutline(cc.c4b(0, 0, 0, 219.29999999999998), 1)
	text_noneEmbattle_l:setVisible(false)
	text_noneEmbattle_r:setVisible(false)
	text_nonePlayer_r:setVisible(false)

	if enemyCurrentEmbattleInfo.cost ~= Strings:get("Petrace_Text_94") then
		text_cost_r:setString(enemyCurrentEmbattleInfo.cost .. "/" .. maxCost)
	else
		text_cost_r:setString(enemyCurrentEmbattleInfo.cost)
	end

	text_power_r:setString(enemyCurrentEmbattleInfo.combat)
	text_first_r:setString(enemyCurrentEmbattleInfo.speed)
	text_lv_r:setString("Lv." .. enemyCurrentEmbattleInfo.level)
	text_name_r:setString(enemyCurrentEmbattleInfo.name)
	self._petRaceSystem:refreshNineEmbattle(enemyCurrentEmbattleInfo.embattle, node_9frame_r)
	self._petRaceSystem:refreshIconEmbattle(enemyCurrentEmbattleInfo.embattle, node_role_r)

	local node_none = node_role_r:getChildByFullName("Node_none")

	node_none:setVisible(false)

	local round = self._petRaceSystem:getRound()

	if round == 0 then
		node_none:setVisible(true)
	else
		if myCurrentEmbattleInfo.embattle and table.nums(myCurrentEmbattleInfo.embattle) == 0 then
			text_noneEmbattle_l:setVisible(true)
		end

		if enemyCurrentEmbattleInfo.noneSta then
			text_lv_r:setVisible(false)
			text_name_r:setVisible(false)
			text_nonePlayer_r:setVisible(true)
		elseif enemyCurrentEmbattleInfo.embattle and table.nums(enemyCurrentEmbattleInfo.embattle) == 0 then
			text_lv_r:setVisible(true)
			text_name_r:setVisible(true)
			text_noneEmbattle_r:setVisible(true)
		else
			text_lv_r:setVisible(true)
			text_name_r:setVisible(true)
		end
	end
end

function PetRaceScheduleCurrentLayer:refreshEight()
	self._node_eight:setVisible(true)

	local myCurrentEmbattleInfo = self._petRaceSystem:getMyCurrentEmbattleInfo()
	local text_name_l = self._node_eight:getChildByFullName("Text_name_l")

	text_name_l:enableOutline(cc.c4b(0, 0, 0, 219.29999999999998), 1)

	local text_lv_l = self._node_eight:getChildByFullName("Text_lv_l")

	text_lv_l:enableOutline(cc.c4b(0, 0, 0, 219.29999999999998), 1)

	local node_team_l = self._node_eight:getChildByFullName("Node_team_l")

	text_name_l:setString(myCurrentEmbattleInfo.name)
	text_lv_l:setString("Lv." .. myCurrentEmbattleInfo.level)
	self:refreshFinalTeam(myCurrentEmbattleInfo.embattleAll, node_team_l, true)

	local enemyCurrentEmbattleInfo = self._petRaceSystem:getEnemyCurrentEmbattleInfo()
	local text_name_r = self._node_eight:getChildByFullName("Text_name_r")

	text_name_r:enableOutline(cc.c4b(0, 0, 0, 219.29999999999998), 1)

	local text_lv_r = self._node_eight:getChildByFullName("Text_lv_r")

	text_lv_r:enableOutline(cc.c4b(0, 0, 0, 219.29999999999998), 1)

	local node_team_r = self._node_eight:getChildByFullName("Node_team_r")

	text_name_r:setString(enemyCurrentEmbattleInfo.name)
	text_lv_r:setString("Lv." .. enemyCurrentEmbattleInfo.level)
	self:refreshFinalTeam(enemyCurrentEmbattleInfo.embattleAll or {}, node_team_r)

	local text_nonePlayer_r = self._node_eight:getChildByFullName("Text_nonePlayer_r")

	text_nonePlayer_r:enableOutline(cc.c4b(0, 0, 0, 219.29999999999998), 1)

	if enemyCurrentEmbattleInfo.noneSta then
		text_nonePlayer_r:setVisible(true)
		text_lv_r:setVisible(false)
		text_name_r:setVisible(false)
	else
		text_nonePlayer_r:setVisible(false)
		text_lv_r:setVisible(true)
		text_name_r:setVisible(true)
	end

	for index = 1, 3 do
		local clickIndex = index
		local teamNode_l = node_team_l:getChildByFullName("Node_team_" .. index)
		local imageBg_l = teamNode_l:getChildByFullName("Panel_base.Image_bg")

		imageBg_l:setTouchEnabled(true)

		local teamNode_r = node_team_r:getChildByFullName("Node_team_" .. index)
		local imageBg_r = teamNode_r:getChildByFullName("Panel_base.Image_bg")

		imageBg_r:setTouchEnabled(true)

		local text_noneEmbattle_l = node_team_l:getChildByFullName("Text_noneEmbattle_" .. index)
		local text_noneEmbattle_r = node_team_r:getChildByFullName("Text_noneEmbattle_" .. index)

		text_noneEmbattle_l:enableOutline(cc.c4b(0, 0, 0, 219.29999999999998), 1)
		text_noneEmbattle_r:enableOutline(cc.c4b(0, 0, 0, 219.29999999999998), 1)

		if myCurrentEmbattleInfo.embattleAll and myCurrentEmbattleInfo.embattleAll[index].embattle and table.nums(myCurrentEmbattleInfo.embattleAll[index].embattle) > 0 then
			text_noneEmbattle_l:setVisible(false)
		else
			text_noneEmbattle_l:setVisible(true)
		end

		if enemyCurrentEmbattleInfo.noneSta or enemyCurrentEmbattleInfo.embattleAll and enemyCurrentEmbattleInfo.embattleAll[index].embattle and table.nums(enemyCurrentEmbattleInfo.embattleAll[index].embattle) > 0 then
			text_noneEmbattle_r:setVisible(false)
		else
			text_noneEmbattle_r:setVisible(true)
		end

		local function clickCallfun()
			local data = {}

			data.clickIndex = clickIndex
			data.myEmbattleInfo = myCurrentEmbattleInfo.embattleAll
			data.enemyEmbattleInfo = enemyCurrentEmbattleInfo.embattleAll
			data.nameR = enemyCurrentEmbattleInfo.name
			data.levelR = enemyCurrentEmbattleInfo.level
			data.nameL = myCurrentEmbattleInfo.name
			data.laveL = myCurrentEmbattleInfo.level
			data.round = self._petRaceSystem:getRound()
			data.state = self._petRaceSystem:getState()
			data.endTime = self._petRaceSystem:getUpdateTime()

			local view = self:getInjector():getInstance("PetRaceFinalSquadView")
			local event = ViewEvent:new(EVT_SHOW_POPUP, view, {}, data)

			self:dispatch(event)
		end

		imageBg_l:addClickEventListener(clickCallfun)
		imageBg_r:addClickEventListener(clickCallfun)
	end
end

function PetRaceScheduleCurrentLayer:updateTime()
	local nodeTime = self._node_normal:isVisible() and self._node_normal:getChildByFullName("Node_time") or self._node_eight:getChildByFullName("Node_time")
	local knockoutSta = self._petRaceSystem:knockout()
	local state = self._petRaceSystem:getState()

	if state == PetRaceEnum.state.matchOver or knockoutSta then
		nodeTime:setVisible(false)
	else
		nodeTime:setVisible(true)
		self._petRaceSystem:updateTimeDes(nodeTime)
	end
end

function PetRaceScheduleCurrentLayer:showShout(content, isSelf)
	local node = self._node_notice_r

	if isSelf then
		node = self._node_notice_l
	end

	node:stopAllActions()

	local textWorld = node:getChildByName("Text_word")

	textWorld:setString(content)

	local text_bg = node:getChildByName("Image_bg")
	local sizeBg = text_bg:getContentSize()
	local textBgH = textWorld:getContentSize().height + 20

	if textBgH < 150 then
		textBgH = 150
	end

	text_bg:setContentSize(cc.size(sizeBg.width, textBgH))
	node:setVisible(true)
	performWithDelay(node, function()
		node:setVisible(false)
	end, 3)
end

function PetRaceScheduleCurrentLayer:refreshFinalTeam(data, node, isSelf)
	for i = 1, 3 do
		if not data[i] then
			local teamNode = node:getChildByName("Node_team_" .. i)

			teamNode:getChildByFullName("Panel_base.Text_num"):setString(i)

			local node_role = teamNode:getChildByFullName("Panel_base.Node_role")

			self._petRaceSystem:refreshIconEmbattle(data[i].embattle or {}, node_role, isSelf)
		end
	end
end
