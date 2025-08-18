-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\PVPMode\\ActivityPVP\\ActivityPvpRankChangeDlg.lua

local PVPCommon = require("Logic/PVP/PVPCommon")
local ResArenaDan = require("ClientData/ResArenaDan")
local ActivityPvpRankAwardGetCell = require("UI/PVPMode/ActivityPVP/ActivityPvpRankAwardGetCell")
local strClassName = "ActivityPvpRankChangeDlg"
local ActivityPvpRankChangeDlg = Class(strClassName, UIControls.Window)

function ActivityPvpRankChangeDlg:ctor(...)
	self:initUI()
end

function ActivityPvpRankChangeDlg:initUI(...)
	self.panelAward = UIControls.Panel(self, "AwardPanel")
	self.panelNone = UIControls.Panel(self, "AwardPanel/AwardNonePanel")
	self.panelAwardList = UIControls.Panel(self, "AwardPanel/AwardList")
	self.scrollView = UIControls.ScrollViewLoopV(self, "AwardPanel/AwardList", 0, self.onAwardCellChanged)
	self.btnConfirm = UIControls.Button(self, "BtnConfirm")

	self.btnConfirm:addEventClick(self.onBtnConfirmClick)

	self.imgRankIcon = UIControls.Image(self, "Bg/BgDec/IconRankLv")
	self.lazyAniUp = UIControls.LazyEffectPlayer(self, "BgPanel/EfxUp")
	self.lazyAniDown = UIControls.LazyEffectPlayer(self, "BgPanel/EfxDown")
	self.rankUIData = {}

	local uiNames = {
		"/IconRankLv",
		"/IconRankLv/BgRankLv",
		"/IconRankLv/BgRankLvS",
		"/IconRankLv/IconRankLvS"
	}
	local path = "BgPanel"

	for i, name in ipairs(uiNames) do
		self.rankUIData[i] = UIControls.Image(self, path .. name)
	end
end

function ActivityPvpRankChangeDlg:show()
	local arenaData = CurAvatar:getPVPArenaActivityData()

	if arenaData == nil then
		return
	end

	local actData = CurAvatar:getPVPArenaActData()
	local preDan = actData:getPreDan()
	local dan = arenaData.award_dan

	if preDan then
		dan = preDan
	end

	dan = math.max(1, math.min(#ResArenaDan, dan))

	local info = PVPCommon.getPartInfoByScore(arenaData.score)

	if dan > info.dan then
		self:playAni("ShowActivityPVPRankDown", nil, true)
		self.panelAward:setVisible(false)
	else
		self:playAni("ShowActivityPVPRankUp", nil, true)
		self.panelAward:setVisible(true)
	end

	PVPCommon.setRankIconBig(self.imgRankIcon, info)

	self.coFunc = coroutine.start(function(...)
		local preInfo = ResArenaDan[dan]

		self:checkEfx(preInfo, info)
		PVPCommon.setRankUI(self.rankUIData, preInfo)
		coroutine.wait(0.55)
		PVPCommon.setRankUI(self.rankUIData, info)
	end)
	self.data = {}

	if info.dan > arenaData.award_dan then
		self.panelNone:setVisible(false)
		self.panelAwardList:setVisible(true)

		for i = info.dan, arenaData.award_dan + 1, -1 do
			table.insert(self.data, ResArenaDan[i])
		end

		self.scrollView:setTotalCount(#self.data)
	else
		self.panelNone:setVisible(true)
		self.panelAwardList:setVisible(false)
	end

	if arenaData.award_dan < info.dan then
		local actId = CurAvatar:getPVPArenaActivityOpId()

		if actId then
			RPC.opactArenaRoleInfoRefresh(actId)
		end
	end

	actData:savePreDan(info.dan)
	RedDotManager.setKeyState(UIConst.RD_HINT_OPACTPVP_PART_CHANGE, false)
end

function ActivityPvpRankChangeDlg:checkEfx(preInfo, newInfo)
	if preInfo.dan > newInfo.dan then
		if preInfo.big_rank_idx == newInfo.big_rank_idx then
			self.lazyAniDown:playEffectByPath("Effects/UI/efx_ui_RankChange_Down2.prefab")
		else
			self.lazyAniDown:playEffectByPath("Effects/UI/efx_ui_RankChange_Down.prefab")
		end
	elseif preInfo.big_rank_idx == newInfo.big_rank_idx then
		self.lazyAniUp:playEffectByPath("Effects/UI/efx_ui_RankChange_Up2.prefab")
	else
		self.lazyAniUp:playEffectByPath("Effects/UI/efx_ui_RankChange_Up.prefab")
	end
end

function ActivityPvpRankChangeDlg:onAwardCellChanged(sender, targetCell, newIdx)
	if targetCell == nil then
		targetCell = ActivityPvpRankAwardGetCell(sender, "System/ActivityPVP/ActivityPVPRankAwardGetCell", newIdx, 0, 0)
	end

	targetCell.mIndex = newIdx

	targetCell:setData(self.data[newIdx])
end

function ActivityPvpRankChangeDlg:onBtnConfirmClick(...)
	self:setVisible(false)
end

function ActivityPvpRankChangeDlg:destroy(...)
	ActivityPvpRankChangeDlg.super.destroy(self)

	if self.coFunc then
		coroutine.stop(self.coFunc)
	end

	self.coFunc = nil
end

return ActivityPvpRankChangeDlg
