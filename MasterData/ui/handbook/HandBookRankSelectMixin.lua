-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\HandBook\\HandBookRankSelectMixin.lua

local ResHeroCampCareerConfig = require("ClientData/ResHeroCampCareerConfig")
local ResGamePlayNotice = require("ClientData/ResGamePlayNotice")
local HandBookRankBtnPanel = require("UI/HandBook/HandBookRankBtnPanel")
local HandBookRankSelectMixin = {}
local BTN_PANEL_INFO = {
	{
		btnName = "BtnGroup1",
		monumentType = Const.MONUMENT_TYPE_GROUP1,
		title = string.format(Lang.get(30312), ResHeroCampCareerConfig[1][1].name),
		rankType = Const.RANK_TYPE_GROUP1
	},
	{
		btnName = "BtnGroup2",
		monumentType = Const.MONUMENT_TYPE_GROUP2,
		title = string.format(Lang.get(30312), ResHeroCampCareerConfig[1][2].name),
		rankType = Const.RANK_TYPE_GROUP2
	},
	{
		btnName = "BtnGroup3",
		monumentType = Const.MONUMENT_TYPE_GROUP3,
		title = string.format(Lang.get(30312), ResHeroCampCareerConfig[1][3].name),
		rankType = Const.RANK_TYPE_GROUP3
	},
	{
		btnName = "BtnMainBattle",
		monumentType = Const.MONUMENT_TYPE_STAGE,
		title = Lang.get(30313),
		rankType = Const.RANK_TYPE_MAINSTAGE
	},
	{
		btnName = "BtnOneTimeTower",
		monumentType = Const.MONUMENT_TYPE_ONCE_TOWER,
		title = Lang.get(30314),
		rankType = Const.RANK_TYPE_ONCETOWER
	}
}
local RANK_TYPE_LIST = {
	BTN_PANEL_INFO[1].rankType,
	BTN_PANEL_INFO[2].rankType,
	BTN_PANEL_INFO[3].rankType,
	BTN_PANEL_INFO[4].rankType,
	BTN_PANEL_INFO[5].rankType
}

function HandBookRankSelectMixin:initUI()
	self.btnPanelList = {}
	self.btnPanelInfo = BTN_PANEL_INFO

	for idx, panelInfo in ipairs(self.btnPanelInfo) do
		local btnPanel = HandBookRankBtnPanel(self, "MainInfoPanel/" .. panelInfo.btnName)

		btnPanel:setRankBtnPanelInfo(panelInfo, idx)
		btnPanel.btnSelf:setEnable(false)
		btnPanel.imgIconNew:setVisible(CurAvatar.handbookMonumentCanGet[panelInfo.monumentType] ~= nil)
		table.insert(self.btnPanelList, btnPanel)
	end

	RPC.rankTopGet(RANK_TYPE_LIST)
end

function HandBookRankSelectMixin:setPlayerInfo(rank)
	self.playersInfo = rank

	for idx, btnPanel in ipairs(self.btnPanelList) do
		btnPanel.contentPanel:setPlayerInfo(self.playersInfo[idx])
		btnPanel.btnSelf:setEnable(true)
	end
end

function HandBookRankSelectMixin:refreshOnePlayer(rank, rankType)
	for idx, _ in ipairs(self.playersInfo) do
		if BTN_PANEL_INFO[idx].rankType == rankType then
			self.playersInfo[idx] = rank

			self.btnPanelList[idx].contentPanel:setPlayerInfo(rank)
		end
	end
end

function HandBookRankSelectMixin:refreshForAward()
	for i, btnPanel in ipairs(self.btnPanelList) do
		btnPanel.imgIconNew:setVisible(CurAvatar.handbookMonumentCanGet[self.btnPanelInfo[i].monumentType] ~= nil)
	end
end

return HandBookRankSelectMixin
