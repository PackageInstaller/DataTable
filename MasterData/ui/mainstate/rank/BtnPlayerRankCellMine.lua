-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\MainState\\Rank\\BtnPlayerRankCellMine.lua

local ResNewMazeDisplay = require("ClientData/ResNewMazeDisplay")
local strClassName = "BtnPlayerRankCellMine"
local BtnPlayerRankCellMine = Class(strClassName, UIControls.BtnPlayerRankCellChild)

function BtnPlayerRankCellMine:ctor()
	self:_initUI()
end

function BtnPlayerRankCellMine:_initUI()
	self.txtLv = UIControls.Label(self, "BgPanel/TextLv")
	self.btnHelp = UIControls.Button(self, "BgPanel/BtnHelp")

	self.btnHelp:addEventClick(self.onBtnHelpClick)

	self.txtRule = UIControls.Label(self, "BgPanel/TextRule")
end

local RANK_TYPE_CAMP_DIC = {
	[Const.RANK_TYPE_GROUP1] = 1,
	[Const.RANK_TYPE_GROUP2] = 2,
	[Const.RANK_TYPE_GROUP3] = 3
}

function BtnPlayerRankCellMine:onBtnHelpClick()
	if self.data then
		local commonData = self.data.data
		local rankRuleDlg = UIManager.getUI("rankRuleDlg", true)
		local totalScore, starScore = CurAvatar:getHeroTotalCampScore(RANK_TYPE_CAMP_DIC[self.data.rankType])
		local starScoreInfo = {}

		starScoreInfo.totalScore = totalScore
		starScoreInfo.starScoreList = starScore

		rankRuleDlg:setPointData(commonData.score, starScoreInfo)
	end
end

function BtnPlayerRankCellMine:setAdditionalData()
	local commonData = self.data.data

	if self.data.rankType ~= Const.RANK_TYPE_CIRCLE_BATTLE_LAYER then
		self.txtLv:setVisible(true)
		self.txtLv:setText(string.format(Lang.get(30171), commonData.comm.level))
	else
		self.txtLv:setVisible(false)
	end

	self.btnHelp:setVisible(self.data.rankType == Const.RANK_TYPE_GROUP1 or self.data.rankType == Const.RANK_TYPE_GROUP2 or self.data.rankType == Const.RANK_TYPE_GROUP3)

	if self.data.rankType == Const.RANK_TYPE_WORLDBOSS then
		if CurAvatar.onShowWorldBossRankIndex and CurAvatar.onShowWorldBossRankIndex ~= 1 then
			self.txtRule:setVisible(false)
		else
			self.txtRule:setVisible(true)
			self.txtRule:setText(ClientUtils.getClientNotice(273))
		end
	elseif self.data.rankType == Const.RANK_TYPE_HOUSEFAVOR then
		self.txtRule:setVisible(true)
	elseif self.data.rankType == Const.RANK_TYPE_NEW_MAZE then
		self.txtRule:setVisible(true)
		self.txtRule:setText(ResNewMazeDisplay[13060018].desc)
	else
		self.txtRule:setVisible(false)
	end
end

return BtnPlayerRankCellMine
