-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\SneakBattle\\SneakBattleLevelMainDlg.lua

local ResNewPveLevel = require("ClientData/ResNewPveLevel")
local ResNewPveShow = require("ClientData/ResNewPveShow")
local ResNewPveIndex = require("ClientData/ResNewPveIndex")
local SneakBattleLevelCell = Class("SneakBattleLevelCell", UIControls.ScrollViewLoopCell)

function SneakBattleLevelCell:ctor(...)
	self:initUI()
end

function SneakBattleLevelCell:initUI(...)
	self.btnLevel = UIControls.Button(self, "BtnLevel")

	self.btnLevel:addEventClick(self.onBtnLevelClick)

	self.bgNml = UIControls.Image(self, "BtnLevel/Content/BgNml")
	self.bgLocked = UIControls.Image(self, "BtnLevel/Content/BgLocked")
	self.imgEliteNml = UIControls.Image(self, "BtnLevel/Content/BgNml/ImgElite")
	self.imgEliteLocked = UIControls.Image(self, "BtnLevel/Content/BgLocked/ImgElite")
	self.txtNmlTitle = UIControls.Label(self, "BtnLevel/Content/BgNml/TextTitle")
	self.txtLockedTitle = UIControls.Label(self, "BtnLevel/Content/BgLocked/TextTitle")
	self.txtNmlChineseName = UIControls.Label(self, "BtnLevel/Content/BgNml/TextTitle/TextName")
	self.txtLockedChineseName = UIControls.Label(self, "BtnLevel/Content/BgLocked/TextTitle/TextName")
	self.imgFinish = UIControls.Image(self, "BtnLevel/Content/ImgFinish")
	self.imgPerfect = UIControls.Image(self, "BtnLevel/Content/ImgPerfect")
	self.panelSlc = UIControls.Panel(self, "BtnLevel/Content/SlcPanel")
	self.efxPanel = UIControls.LazyEffectPlayer(self, "BtnLevel/Content/SlcPanel/Efx")
end

function SneakBattleLevelCell:setData(data)
	self.data = data

	if data then
		if data.stage_name then
			self.txtNmlTitle:setText(data.stage_name)
			self.txtLockedTitle:setText(data.stage_name)
		end

		if data.chinese_name then
			self.txtNmlChineseName:setText(data.chinese_name)
			self.txtLockedChineseName:setText(data.chinese_name)
		end

		if data.strongPass then
			self.imgPerfect:setVisible(true)
			self.imgFinish:setVisible(false)
		elseif data.weakPass then
			self.imgPerfect:setVisible(false)
			self.imgFinish:setVisible(true)
		else
			self.imgPerfect:setVisible(false)
			self.imgFinish:setVisible(false)
		end

		if data.need_limit and data.need_limit == 1 then
			self.txtNmlTitle:setFontColor(ResColor.SNEAKBATTLE02)
			self.txtNmlChineseName:setFontColor(ResColor.SNEAKBATTLE02)
			self.bgNml:setImage("Atlas/SneakBattleAtlas/SneakBattleAtlas2", "BgLevelEliteSel")
			self.imgEliteNml:setVisible(true)
			self.imgEliteLocked:setVisible(true)
		else
			self.txtNmlTitle:setFontColor(ResColor.SNEAKBATTLE01)
			self.txtNmlChineseName:setFontColor(ResColor.SNEAKBATTLE01)
			self.bgNml:setImage("Atlas/SneakBattleAtlas/SneakBattleAtlas2", "BgLevelSel")
			self.imgEliteNml:setVisible(false)
			self.imgEliteLocked:setVisible(false)
		end

		if self.data.canEnter then
			self.bgNml:setVisible(true)
			self.bgLocked:setVisible(false)

			local go = self.bgNml:getGameObject()
			local ComponentOrderType = typeof(Framework.UI.UIComponentOrder)
			local uiOrder = go:GetComponent(ComponentOrderType)

			uiOrder = uiOrder or go:AddComponent(ComponentOrderType)
			uiOrder.Order = 22
		else
			self.bgNml:setVisible(false)
			self.bgLocked:setVisible(true)
		end

		self.panelSlc:setVisible(data.stage == self.mParent.nowIndex + 1)

		if self.panelSlc:getVisible() then
			if data.need_limit and data.need_limit == 1 then
				self.efxPanel:playEffectByPath("Effects/UI/efx_ui_SneakBattleLevelCell_02.prefab")
			else
				self.efxPanel:playEffectByPath("Effects/UI/efx_ui_SneakBattleLevelCell_01.prefab")
			end
		end
	end
end

function SneakBattleLevelCell:onBtnLevelClick()
	if self.mParent.actData then
		UIManager.getUI("sneakBattleStageInfoDlg", true):setData(self.mParent.actData, self.data.stage)
	end
end

local SneakBattleLevelMainDlg = Class("SneakBattleLevelMainDlg", UIControls.Window)

function SneakBattleLevelMainDlg:ctor(...)
	self:initUI()
end

function SneakBattleLevelMainDlg:initUI()
	self.btnClose = UIControls.Button(self, "BtnClose")

	self.btnClose:addEventClick(self.onBtnCloseClick)

	self.btnLimits = UIControls.Button(self, "MainInfoPanel/FuncPanel/BtnLimits")

	self.btnLimits:addEventClick(self.onBtnLimitsClick)

	self.btnHero = UIControls.Button(self, "MainInfoPanel/FuncPanel/BtnHero")

	self.btnHero:addEventClick(self.onBtnHeroClick)

	self.btnTeamSet = UIControls.Button(self, "MainInfoPanel/FuncPanel/BtnTeamSet")

	self.btnTeamSet:addEventClick(self.onBtnTeamSetClick)

	self.iconNew = UIControls.RedDot(self, "MainInfoPanel/FuncPanel/BtnHero/IconNew")
	self.txtName = UIControls.Label(self, "MainInfoPanel/FuncPanel/InfoPanel/TextName")
	self.txtLevel = UIControls.Label(self, "MainInfoPanel/FuncPanel/InfoPanel/TextLevel")
	self.btnReset = UIControls.Button(self, "MainInfoPanel/FuncPanel/InfoPanel/BtnReset")

	self.btnReset:addEventClick(self.onBtnResetClick)

	self.levelList = UIControls.ScrollViewLoopH(self, "MainInfoPanel/LevelList", 0, self.onCellChanged)
	self.cells = {}
	self.btnTips = UIControls.Button(self, "BtnTips")

	self.btnTips:addEventClick(self.onBtnTipsClick)
end

function SneakBattleLevelMainDlg:setData(actData)
	self.actData = actData or self.actData

	if self.actData then
		self.btnLimits:setVisible(self.actData:checkHaveLimitStage())
		self.iconNew:addHint({
			UIConst.RD_HINT_SNEAK_BATTLE_HERO_RELIC
		})

		self.level = self.actData.nowSelectLevel or 1
		self.modeIndex = self.actData.modeIndex or 1
		self.type = self.actData.type or 1

		if self.actData.lockedStage and self.actData.lockedStage ~= 0 then
			self.nowIndex = self.actData.lockedStage - 1
		else
			self.nowIndex = self.actData.curPassStage or 1
		end

		if ResNewPveIndex[self.modeIndex] and ResNewPveIndex[self.modeIndex].name then
			self.txtName:setText(ResNewPveIndex[self.modeIndex].name)
		end

		if ResNewPveLevel and ResNewPveLevel[self.type] and ResNewPveLevel[self.type][self.level] then
			self.txtLevel:setText(ResNewPveLevel[self.type][self.level].level_name)
		end

		self.stageData = self.actData:getNowLevelStageData()

		if self.stageData then
			local index = self.nowIndex

			index = math.max(index, 1)

			local count = self.actData:getStageCount(self.level) or 6

			index = math.min(count - 5, index)

			if self.actData:checkshowNewStageAni() then
				self.levelList:setTotalCount(#self.stageData, index - 1)
				self.levelList:scrollToCell(index, 600)
			else
				self.levelList:setTotalCount(#self.stageData, index)
			end
		end

		if self.actData:checkFinishOneLevel() then
			UIManager.getUI("sneakBattleFinishiLevelDlg", true)

			return
		end

		if not self.actData:checkCanEnterStage() then
			local ui = UIManager.tryGetUI("sneakBattleLimitDlg")

			if ui then
				ui:setData(self.actData)
				ui:onBtnEditClick()
			else
				ui = UIManager.getUI("sneakBattleLimitDlg", true)

				ui:setData(self.actData)
				ui:onBtnEditClick()
			end
		end

		if self.level == 1 and self.actData:checkCanEnterStage() and not self.actData:checkHaveFormationData() then
			UIManager.getUI("sneakBattleTeamSetDlg", true):setData(self.actData)
		end

		if self.actData.needShowToLowerLevel then
			self.actData.needShowToLowerLevel = false
			self.actData.hadToLoverLevel = true

			local function yesfun()
				self:setVisible(false)
			end

			UIManager.showConfirmWithId(1117, Slot(yesfun, self))
		end
	end
end

function SneakBattleLevelMainDlg:onCellChanged(sender, targetCell, newIdx)
	if targetCell == nil then
		targetCell = SneakBattleLevelCell(sender, "System/SneakBattle/SneakBattleLevelCell", newIdx, 0, 0)
		targetCell.index = newIdx
	end

	self.cells[targetCell.index] = nil
	self.cells[newIdx] = targetCell

	if self.stageData and self.stageData[newIdx] then
		targetCell:setData(self.stageData[newIdx])
	end
end

function SneakBattleLevelMainDlg:onBtnResetClick()
	if self.actData:checkCanReset() then
		local function yesfun(...)
			if self.actData then
				local opId = self.actData.actObject.opId
				local level = self.actData.nowSelectLevel

				RPC.newPveReset(opId, level)
			end
		end

		UIManager.showConfirmWithId(1115, Slot(yesfun, self))
	elseif ResNewPveShow[13090011] then
		MsgManager.notice(ResNewPveShow[13090011].desc)
	end
end

function SneakBattleLevelMainDlg:onBtnCloseClick()
	self:setVisible(false)
end

function SneakBattleLevelMainDlg:onBtnLimitsClick()
	if self.actData:checkHaveLimitStage() then
		UIManager.getUI("sneakBattleLimitDlg", true):setData(self.actData)
	elseif ResNewPveShow[13090010] then
		MsgManager.notice(ResNewPveShow[13090010].desc)
	end
end

function SneakBattleLevelMainDlg:onBtnTipsClick()
	UIManager.getUI("infoNotice", true):showSystemInfo(473)
end

function SneakBattleLevelMainDlg:onBtnHeroClick()
	UIManager.getUI("sneakBattleHeroCheckDlg", true)
end

function SneakBattleLevelMainDlg:onBtnTeamSetClick()
	if self.actData then
		if not self.actData:checkCanEnterStage() then
			if ResNewPveShow[13090013] then
				MsgManager.notice(ResNewPveShow[13090013].desc)
			end
		else
			UIManager.getUI("sneakBattleTeamSetDlg", true):setData(self.actData)
		end
	end
end

return SneakBattleLevelMainDlg
