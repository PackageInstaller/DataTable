-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/petRace/view/component/PetRaceRewardCell.lua

PetRaceRewardCell = class("PetRaceRewardCell", DmBaseUI)

PetRaceRewardCell:has("_petRaceSystem", {
	is = "r"
}):injectWith("PetRaceSystem")

local kBtnHandlers = {
	Image_box_silver = "OnClickGetReward",
	Image_box_gold = "OnClickGetReward",
	Button_play = "onClickPlay",
	Button_share = "onClickshare"
}

function PetRaceRewardCell:initialize(data)
	super.initialize(self)
	self:setView(data.view)
	self:intiView()
	self:mapButtonHandlersClick(kBtnHandlers)
end

function PetRaceRewardCell:update(data, index)
	self._reportId = data.reportId
	self._userId = data.userId
	self._winId = data.winId
	self._round = index
	self._isWin = data.userId == data.winId
	self._rewardId = data.rewardId
	self._isFightOver = data.isFightOver

	if #data.winId > 0 and self._isFightOver then
		self._image_lost:setVisible(not self._isWin)
		self._image_win:setVisible(self._isWin)
		self:refreshRewardShow()
	else
		self._image_vs:setVisible(true)
		self._image_box_silver:setVisible(false)
		self._image_box_gold:setVisible(false)
		self._image_lost:setVisible(false)
		self._image_win:setVisible(false)
	end

	self._title:setString(data.des)
end

function PetRaceRewardCell:intiView()
	self._title = self:getView():getChildByName("Text_des")
	self._image_lost = self:getView():getChildByName("Image_lost")
	self._image_win = self:getView():getChildByName("Image_win")
	self._button_play = self:getView():getChildByName("Button_play")
	self._button_share = self:getView():getChildByName("Button_share")
	self._image_box_silver = self:getView():getChildByName("Image_box_silver")
	self._image_box_gold = self:getView():getChildByName("Image_box_gold")
	self._image_vs = self:getView():getChildByName("Image_vs")
end

function PetRaceRewardCell:onClickPlay()
	local state = self._petRaceSystem:getState()
	local round = self._petRaceSystem:getRound()

	if state == 2 and round == self._round then
		self:dispatch(ShowTipEvent({
			duration = 0.5,
			tip = Strings:get("Petrace_Text_49")
		}))

		return
	end

	if not self._isFightOver then
		self:dispatch(ShowTipEvent({
			duration = 0.5,
			tip = Strings:get("21015")
		}))

		return
	end

	if self._reportId and #self._reportId > 0 then
		self._petRaceSystem:requestReportDetail(self._reportId, true)
	else
		self:dispatch(ShowTipEvent({
			duration = 0.5,
			tip = Strings:get("Petrace_Text_50")
		}))
	end
end

function PetRaceRewardCell:onClickshare()
	return
end

function PetRaceRewardCell:refreshRewardShow()
	if self._rewardId and #self._rewardId > 0 then
		self._image_vs:setVisible(false)
		self._image_box_silver:setVisible(not self._isWin)
		self._image_box_gold:setVisible(self._isWin)
	else
		self._image_vs:setVisible(true)
		self._image_box_silver:setVisible(false)
		self._image_box_gold:setVisible(false)
	end
end

function PetRaceRewardCell:OnClickGetReward()
	if self._rewardId and #self._rewardId > 0 then
		self._petRaceSystem:getReward(nil, {
			round = self._round
		}, true)
	end
end
