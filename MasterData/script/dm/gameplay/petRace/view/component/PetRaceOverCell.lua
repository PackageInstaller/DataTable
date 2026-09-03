-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/petRace/view/component/PetRaceOverCell.lua

PetRaceOverCell = class("PetRaceOverCell", DmBaseUI)

PetRaceOverCell:has("_petRaceSystem", {
	is = "r"
}):injectWith("PetRaceSystem")

local kBtnHandlers = {
	Button_play = "onClickPlay",
	Button_share = "onClickshare",
	["Node_des.Image_box_silver"] = "OnClickGetReward",
	["Node_des.Image_box_gold"] = "OnClickGetReward"
}

function PetRaceOverCell:initialize(data)
	super.initialize(self)
	self:setView(data.view)
	self:intiView()
	self:mapButtonHandlersClick(kBtnHandlers)
end

function PetRaceOverCell:update(data, index)
	self._data = data
	self._round = index or self._round
	self._report = data.report

	local isWin = data.userId == data.winId

	self._button_play:setVisible(true)
	self._button_share:setVisible(false)
	self._node_win:setVisible(false)

	local nodeLeft = self:getView():getChildByFullName("Node_des.Node_left")
	local nodeRight = self:getView():getChildByFullName("Node_des.Node_right")

	if data.userId and data.userId == data.winId then
		self._node_win:setPosition(nodeLeft:getPosition())
		self._node_win:setVisible(true)
	elseif data.rivalId and data.rivalId == data.winId then
		self._node_win:setPosition(nodeRight:getPosition())
		self._node_win:setVisible(true)
	end

	self._title:setString(Strings:get("Petrace_Text_76"))
	self._text_round:setString(string.format(Strings:get("Petrace_Text_1"), self._round))

	local rivalName = self._data.rivalName

	if not rivalName or rivalName == "" then
		rivalName = Strings:get("Petrace_Text_94")
	end

	local rivalLevel = self._data.rivalLevel

	if not rivalLevel or rivalLevel == 0 then
		rivalLevel = Strings:get("Petrace_Text_94")
	end

	self._text_name_l:setString(self._data.userName)
	self._text_level_l:setString("Lv " .. self._data.userLevel)
	self._text_name_r:setString(rivalName)
	self._text_level_r:setString("Lv " .. rivalLevel)

	if not self._data.myEmbattle[1] then
		if not data.rivalEmbattle[1] then
			local rivalEmbattle = {}

			self._petRaceSystem:refreshIconEmbattle(self._data.myEmbattle[1].embattle or {}, self._node_role_l, true)
			self._petRaceSystem:refreshIconEmbattle(rivalEmbattle.embattle or {}, self._node_role_r)

			local text_noneEmbattle_l = self:getView():getChildByFullName("Node_des.Text_noneEmbattle_l")
			local text_noneEmbattle_r = self:getView():getChildByFullName("Node_des.Text_noneEmbattle_r")
			local text_nonePlayer_r = self:getView():getChildByFullName("Node_des.Text_nonePlayer_r")

			if self._data.myEmbattle[1].embattle and table.nums(self._data.myEmbattle[1].embattle) > 0 then
				text_noneEmbattle_l:setVisible(false)
			else
				text_noneEmbattle_l:setVisible(true)
			end

			if self._data.rivalName == nil or self._data.rivalName == "" then
				self._text_name_r:setVisible(false)
				self._text_level_r:setVisible(false)
				text_noneEmbattle_r:setVisible(false)
				text_nonePlayer_r:setVisible(true)
			elseif rivalEmbattle.embattle and table.nums(rivalEmbattle.embattle) > 0 then
				self._text_name_r:setVisible(true)
				self._text_level_r:setVisible(true)
				text_noneEmbattle_r:setVisible(false)
				text_nonePlayer_r:setVisible(false)
			else
				self._text_name_r:setVisible(true)
				self._text_level_r:setVisible(true)
				text_noneEmbattle_r:setVisible(true)
				text_nonePlayer_r:setVisible(false)
			end

			self:refreshReward(isWin)
		end
	end
end

function PetRaceOverCell:intiView()
	self._title = self:getView():getChildByFullName("Node_des.Text_des")
	self._text_round = self:getView():getChildByFullName("Node_des.Text_num")
	self._text_name_l = self:getView():getChildByFullName("Node_des.Text_name_l")
	self._text_name_r = self:getView():getChildByFullName("Node_des.Text_name_r")
	self._text_level_l = self:getView():getChildByFullName("Node_des.Text_level_l")
	self._text_level_r = self:getView():getChildByFullName("Node_des.Text_level_r")
	self._node_role_l = self:getView():getChildByFullName("Node_des.Node_role_l")
	self._node_role_r = self:getView():getChildByFullName("Node_des.Node_role_r")
	self._node_win = self:getView():getChildByFullName("Node_des.Node_win")
	self._image_box_silver = self:getView():getChildByFullName("Node_des.Image_box_silver")
	self._image_box_gold = self:getView():getChildByFullName("Node_des.Image_box_gold")
	self._image_vs = self:getView():getChildByFullName("Node_des.Image_vs")
	self._button_play = self:getView():getChildByFullName("Button_play")
	self._button_share = self:getView():getChildByFullName("Button_share")
end

function PetRaceOverCell:onClickPlay()
	local reportId = self._data.reportId

	if reportId and #reportId > 0 then
		self._petRaceSystem:requestReportDetail(self._round, reportId, true)
	else
		self:dispatch(ShowTipEvent({
			duration = 0.5,
			tip = Strings:get("Petrace_Text_50")
		}))
	end
end

function PetRaceOverCell:onClickshare()
	return
end

function PetRaceOverCell:OnClickGetReward()
	local rewardId = self._data.rewardId

	if rewardId and #rewardId > 0 then
		self._petRaceSystem:requstGetReward({
			round = self._round
		}, true)
	end
end

function PetRaceOverCell:refreshReward(isWin)
	local rewardId = self._data.rewardId

	self._image_vs:setVisible(false)

	local state = self._petRaceSystem:getState()

	if self._report == nil and rewardId and rewardId ~= "" and state ~= PetRaceEnum.state.matchOver then
		self._image_box_silver:setVisible(not isWin)
		self._image_box_gold:setVisible(isWin)
	else
		self._image_vs:setVisible(true)
		self._image_box_silver:setVisible(false)
		self._image_box_gold:setVisible(false)
	end
end
