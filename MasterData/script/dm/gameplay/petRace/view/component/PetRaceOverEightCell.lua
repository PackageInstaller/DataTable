-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/petRace/view/component/PetRaceOverEightCell.lua

PetRaceOverEightCell = class("PetRaceOverEightCell", DmBaseUI)

PetRaceOverEightCell:has("_petRaceSystem", {
	is = "r"
}):injectWith("PetRaceSystem")

local kBtnHandlers = {
	Button_play = "onClickPlay",
	Button_share = "onClickshare",
	["Node_des.Image_box_silver"] = "OnClickGetReward",
	["Node_des.Image_box_gold"] = "OnClickGetReward"
}

function PetRaceOverEightCell:initialize(data)
	super.initialize(self)
	self:setView(data.view)
	self:intiView()
	self:mapButtonHandlersClick(kBtnHandlers)
end

function PetRaceOverEightCell:update(data, index)
	self._round = index
	self._data = data
	self._report = data.report

	local isWin = data.userId == data.winId

	self._button_play:setVisible(true)
	self._button_share:setVisible(false)
	self._image_win:setVisible(false)

	local nodeLeft = self:getView():getChildByFullName("Node_des.Node_left")
	local nodeRight = self:getView():getChildByFullName("Node_des.Node_right")

	if data.userId and data.userId == data.winId then
		self._image_win:setPosition(nodeLeft:getPosition())
		self._image_win:setVisible(true)
	elseif data.rivalId and data.rivalId == data.winId then
		self._image_win:setPosition(nodeRight:getPosition())
		self._image_win:setVisible(true)
	end

	local rivalName = self._data.rivalName

	if not rivalName or rivalName == "" then
		rivalName = Strings:get("Petrace_Text_94")
	end

	local rivalLevel = self._data.rivalLevel

	if not rivalLevel or rivalLevel == 0 then
		rivalLevel = Strings:get("Petrace_Text_94")
	end

	local desStr = self._petRaceSystem:getDesRound(self._round)

	self._title:setString(desStr)
	self._text_name_l:setString(data.userName)
	self._text_level_l:setString("Lv" .. data.userLevel)
	self._text_name_r:setString(rivalName)
	self._text_level_r:setString("Lv" .. rivalLevel)

	local rivalNone = true
	local text_nonePlayer_r = self:getView():getChildByFullName("Node_des.Text_nonePlayer_r")

	text_nonePlayer_r:setVisible(true)

	if self._data.rivalName and self._data.rivalName ~= "" then
		rivalNone = false

		text_nonePlayer_r:setVisible(false)
	end

	for i = 1, 3 do
		local nodeBase = self:getView():getChildByFullName("Node_" .. i)
		local role_l = nodeBase:getChildByFullName("Node_role_l")
		local role_r = nodeBase:getChildByFullName("Node_role_r")
		local text_noneEmbattle_l = nodeBase:getChildByFullName("Text_noneEmbattle_1")
		local text_noneEmbattle_r = nodeBase:getChildByFullName("Text_noneEmbattle_2")

		if not data.myEmbattle[i] then
			if not data.rivalEmbattle[i] then
				local rivalEmbattle = {}

				self._petRaceSystem:refreshIconEmbattle(data.myEmbattle[i].embattle or {}, role_l, true)
				self._petRaceSystem:refreshIconEmbattle(rivalEmbattle.embattle or {}, role_r)

				if data.myEmbattle[i].embattle and table.nums(data.myEmbattle[i].embattle) > 0 then
					text_noneEmbattle_l:setVisible(false)
				else
					text_noneEmbattle_l:setVisible(true)
				end

				if rivalNone then
					self._text_name_r:setVisible(false)
					self._text_level_r:setVisible(false)
					text_noneEmbattle_r:setVisible(false)
				elseif rivalEmbattle.embattle and table.nums(rivalEmbattle.embattle) > 0 then
					self._text_name_r:setVisible(true)
					self._text_level_r:setVisible(true)
					text_noneEmbattle_r:setVisible(false)
				else
					self._text_name_r:setVisible(true)
					self._text_level_r:setVisible(true)
					text_noneEmbattle_r:setVisible(true)
				end
			end
		end
	end

	self:refreshReward(isWin)
end

function PetRaceOverEightCell:intiView()
	self._title = self:getView():getChildByFullName("Node_des.Text_des")
	self._text_name_l = self:getView():getChildByFullName("Node_des.Text_name_l")
	self._text_name_r = self:getView():getChildByFullName("Node_des.Text_name_r")
	self._text_level_l = self:getView():getChildByFullName("Node_des.Text_level_l")
	self._text_level_r = self:getView():getChildByFullName("Node_des.Text_level_r")
	self._image_win = self:getView():getChildByFullName("Node_des.Node_win")
	self._image_box_silver = self:getView():getChildByFullName("Node_des.Image_box_silver")
	self._image_box_gold = self:getView():getChildByFullName("Node_des.Image_box_gold")
	self._image_vs = self:getView():getChildByFullName("Node_des.Image_vs")
	self._button_play = self:getView():getChildByFullName("Button_play")
	self._button_share = self:getView():getChildByFullName("Button_share")

	for i = 1, 3 do
		local nodeBase = self:getView():getChildByName("Node_" .. i)
		local text_num = nodeBase:getChildByName("Text_num")

		text_num:setString(i)
	end
end

function PetRaceOverEightCell:onClickPlay()
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

function PetRaceOverEightCell:onClickshare()
	return
end

function PetRaceOverEightCell:OnClickGetReward()
	local rewardId = self._data.rewardId

	if rewardId and #rewardId > 0 then
		self._petRaceSystem:requstGetReward({
			round = self._round
		}, true)
	end
end

function PetRaceOverEightCell:refreshReward(isWin)
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
