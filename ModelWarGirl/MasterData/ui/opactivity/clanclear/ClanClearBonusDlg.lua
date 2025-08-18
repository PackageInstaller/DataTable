-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\OpActivity\\ClanClear\\ClanClearBonusDlg.lua

local ActivityPanelMixin = require("UI/OpActivity/ActivityPanelMixin")
local CommonHeroListPanel = require("UI/Battle/CommonHeroListPanel")
local FilterSelectPanel = require("UI/MainState/FilterSelectPanel")
local GridHeroStarUp = require("UI/Hero/StarUp/GridHeroStarUp")
local ResOpActClanBossAddon = require("ClientData/ResOpActClanBossAddon")
local ResOpActClanBossLimit = require("ClientData/ResOpActClanBossLimit")
local ResOpActClanBossStage = require("ClientData/ResOpActClanBossStage")
local ResOpActivityClientTemplate = require("ClientData/ResOpActivityClientTemplate")
local ClanClearGetBonusCell = Class("ClanClearGetBonusCell", UIControls.ScrollViewLoopCell)

function ClanClearGetBonusCell:ctor(...)
	self:initUI()
end

function ClanClearGetBonusCell:initUI(...)
	self.btnSensor = UIControls.Button(self, "ContentPanel/BtnGet")

	self.btnSensor:addEventClick(self.onBtnSensorClick)

	self.imgBg = UIControls.Image(self, "ContentPanel/IconAward")
	self.textName = UIControls.Label(self, "ContentPanel/TextName")
	self.textProgress = UIControls.Label(self, "ContentPanel/TextProgress")
	self.grids = {}
	self.imgBgTitle = UIControls.Image(self, "ContentPanel/BgTitle")
	self.mPath = "Atlas/ActivityAtlas/"

	local templateData = ResOpActivityClientTemplate[self.mParent.actId] or {}

	self.replacePath = "ActivityMayDayCleanAtlas"

	if templateData.src_replace and templateData.src_replace[3] then
		self.replacePath = templateData.src_replace[3]
	end
end

function ClanClearGetBonusCell:setData(bonusInfo)
	self.inClicking = false
	self.layer = bonusInfo[1]
	self.index = bonusInfo[2]
	self.bonusData = bonusInfo[3]
	self.round = bonusInfo[4] or 0

	local layerData = self.mParent.clientData[self.layer]

	self.textName:setText(layerData.name or "")

	if self.index == #layerData.score_award then
		self.textProgress:setText(self.mParent.miscData.slider_finish_notice)
	else
		self.textProgress:setText(string.format(self.mParent.miscData.slider_progress_notice, self.bonusData.score))
	end

	local detail_id = self.mParent.actId
	local bossId = self.mParent.bossId
	local isBoss = ResOpActClanBossStage[detail_id][bossId][self.layer].is_boss

	if isBoss == 1 then
		if self.replacePath then
			self.imgBgTitle:setImage(self.mPath .. self.replacePath .. "/ActivityMayDayCleanAtlas03", "BgSpecial")
			self.imgBg:setImage(self.mPath .. self.replacePath .. "/ActivityMayDayCleanAtlas06", "320")
		end
	elseif self.replacePath then
		self.imgBgTitle:setImage(self.mPath .. self.replacePath .. "/ActivityMayDayCleanAtlas03", "BgOrdinary")
		self.imgBg:setImage(self.mPath .. self.replacePath .. "/ActivityMayDayCleanAtlas06", "319")
	end

	ClientUtils.CreateActivityBonusGrid(self, self.grids, "ContentPanel/AwardPanel", self.bonusData.award)
end

function ClanClearGetBonusCell:onBtnSensorClick()
	if self.inClicking then
		return
	end

	self.mParent:onBonusClick(self.layer, self.index, self.round)

	self.inClicking = true
end

local strClassName = "ClanClearBonusDlg"
local ClanClearBonusDlg = Class(strClassName, UIControls.Window)

function ClanClearBonusDlg:ctor()
	self:initUI()
end

function ClanClearBonusDlg:initUI()
	self.clanBonusCells = {}
	self.clanBonusView = UIControls.ScrollViewLoopV(self, "BgPanel/GetList", 0, self.onCellChanged)
	self.btnClose = UIControls.Button(self, "BtnClose")

	self.btnClose:addEventClick(self.onCloseClick)
end

function ClanClearBonusDlg:onCloseClick()
	self:setVisible(false)
end

function ClanClearBonusDlg:onShowBoss(bossId, actObj)
	self.actObj = actObj
	self.bossId = bossId
	self.actId = self.actObj.actId

	local actData = self.actObj.actData

	self.miscData = self.actObj.actData.miscData or {}
	self.clientData = actData.clientData[bossId]
	self.cellPath = "System/Activity/ActMayDayCleanAwardCell"

	if actObj.clientTemplateData and actObj.clientTemplateData.src_replace and actObj.clientTemplateData.src_replace[1] then
		self.cellPath = "System/Activity/" .. actObj.clientTemplateData.src_replace[1] .. "/ActMayDayCleanAwardCell"
	end

	self.allValidBonus = actData:getAllValidBonus(bossId) or {}

	self.clanBonusView:setTotalCount(#self.allValidBonus, 1)
end

function ClanClearBonusDlg:onBonusClick(layer, index, round)
	self.actObj.actData:rpcGetAward(self.bossId, layer, index, round)
end

function ClanClearBonusDlg:updateActivityData()
	self:onShowBoss(self.bossId, self.actObj)
end

function ClanClearBonusDlg:onCellChanged(sender, targetCell, newIdx)
	if targetCell == nil then
		targetCell = ClanClearGetBonusCell(sender, self.cellPath, newIdx)
	else
		self.clanBonusCells[targetCell.mIndex] = nil
		targetCell.mIndex = newIdx
	end

	self.clanBonusCells[newIdx] = targetCell

	targetCell:setData(self.allValidBonus[newIdx])
end

return ClanClearBonusDlg
