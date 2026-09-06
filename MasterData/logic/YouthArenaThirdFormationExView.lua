-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/youtharenathird/view/YouthArenaThirdFormationExView.lua

module("logic.extensions.youtharenathird.view.YouthArenaThirdFormationExView", package.seeall)

local YouthArenaThirdFormationExView = class("YouthArenaThirdFormationExView", ViewComponent)

function YouthArenaThirdFormationExView:ctor()
	YouthArenaThirdFormationExView.super.ctor(self)
end

function YouthArenaThirdFormationExView:buildUI()
	YouthArenaThirdFormationExView.super.buildUI(self)

	self._tabScrView = self:getGo("tabScrView")
	self._tabScrCell = self:getGo("tabScrCell")
	self._btnBuff = self:getGo("btnBuff")
	self._btnPetBuff = self:getGo("btnPetBuff")
	self._buffIcon = self:getGo("btnBuff/icon")
	self._buffIconImage = self._buffIcon:GetComponent(typeof(UnityEngine.UI.Image))
	self._defaultBuffIconSprite = self._buffIconImage.sprite
	self._tabScrollList = ScrollerList.create(self._tabScrView, self._tabScrCell, GameUtil.handler(self._updateTabCell, self), GameUtil.handler(self._clearTabCell, self))
end

function YouthArenaThirdFormationExView:onEnter()
	YouthArenaThirdFormationExView.super.onEnter(self)

	self._fmtMo = self:getFirstParam()
	self._tabDataList = {
		{
			tabName = "1v1",
			mode = YouthArenaThirdEnum.BattleMode.One
		},
		{
			tabName = "3v3",
			mode = YouthArenaThirdEnum.BattleMode.Three
		}
	}

	GameUtil.addClickHandler(self._btnBuff, self._onClickBuff, self)
	GameUtil.addClickHandler(self._btnPetBuff, self._onClickPetBuff, self)
	self:_refreshView()
	self.addGEvent(self, GlobalNotify.ForceChangeCurFormTab, self._refreshView, self)
end

function YouthArenaThirdFormationExView:onExit()
	YouthArenaThirdFormationExView.super.onExit(self)
	GameUtil.rmClickHandler(self._btnBuff)
	GameUtil.rmClickHandler(self._btnPetBuff)
	self:_restoreDefaultBuffIcon()

	self._petBuffPlanId = nil
	self._fmtMo = nil

	self._tabScrollList:dispose()
end

function YouthArenaThirdFormationExView:_refreshView()
	self._tabScrollList:reloadData(self._tabDataList)
	self:_refreshBuff()
	self:_refreshPetBuff()
end

function YouthArenaThirdFormationExView:_refreshPetBuff()
	self._petBuffPlanId = self:_getPetBuffPlanId()

	GameUtil.SetActive(self._btnPetBuff, self._petBuffPlanId > 0)
end

function YouthArenaThirdFormationExView:_getPetBuffPlanId()
	if self._fmtMo == nil then
		return 0
	end

	local matchStepId = 0

	if self._fmtMo:getIsFun() then
		matchStepId = YouthArenaThirdEnum.MatchStepId.Fun
	elseif self._fmtMo:getStepId() == YouthArenaThirdEnum.TimeStepId.QualifierStart then
		matchStepId = YouthArenaThirdEnum.MatchStepId.Qualifier
	elseif self._fmtMo:getStepId() == YouthArenaThirdEnum.TimeStepId.ScoreMatchStart then
		matchStepId = YouthArenaThirdEnum.MatchStepId.ScoreMatch
	end

	if matchStepId <= 0 then
		return 0
	end

	local matchCfg = YouthArenaThirdConfig.instance:getMatchData(self._fmtMo:getActivityId(), matchStepId)

	return checknumber(matchCfg and matchCfg.buffPlanId)
end

function YouthArenaThirdFormationExView:_refreshBuff()
	local buffPlanId = self._fmtMo and self._fmtMo:getBuffPlanId() or 0

	GameUtil.SetActive(self._btnBuff, buffPlanId > 0)

	if buffPlanId <= 0 then
		self:_restoreDefaultBuffIcon()

		return
	end

	local buffId = self._fmtMo:getCurBuffId()
	local cfg = YouthArenaThirdConfig.instance:getKnockoutBuffPlanData(buffPlanId, buffId)

	if cfg == nil or string.nilorempty(cfg.icon) then
		self:_restoreDefaultBuffIcon()
		GameUtil.SetActive(self._buffIcon, false)

		return
	end

	uGuiUtil.clearImage(self._buffIcon)
	uGuiUtil.setSpriteToImage(self._buffIcon, uGuiUtil.SpriteType.BigBg, string.format("ui/%s.png", cfg.icon))
	GameUtil.SetActive(self._buffIcon, true)
end

function YouthArenaThirdFormationExView:_restoreDefaultBuffIcon()
	if self._buffIcon == nil or self._buffIconImage == nil then
		return
	end

	uGuiUtil.clearImage(self._buffIcon)

	self._buffIconImage.sprite = self._defaultBuffIconSprite
end

function YouthArenaThirdFormationExView:_updateTabCell(view, cell, data, tag)
	local index = cell.data
	local mainGo = cell.gameObject

	if self._fmtMo then
		local isSelect = self._fmtMo:getMode() == data.mode
		local tagSelect = goutil.findChild(mainGo, "tagSelect")
		local txtName = goutil.findChildTextComponent(mainGo, "txtName")

		txtName.text = data.tabName

		GameUtil.setUIGroupIdx(cell, index - 1)
		GameUtil.SetActive(tagSelect, isSelect)
		GameUtil.addClickHandler(mainGo, GameUtil.handler(self._onClickTab, self, data))
	end
end

function YouthArenaThirdFormationExView:_clearTabCell(cell)
	GameUtil.rmClickHandler(cell.gameObject)
end

function YouthArenaThirdFormationExView:_onClickTab(data)
	YouthArenaThirdController.instance:trySwitchDefenseFormationMode(self._fmtMo, data.mode)
end

function YouthArenaThirdFormationExView:_onClickBuff()
	if self._fmtMo == nil then
		return
	end

	local buffPlanId = self._fmtMo:getBuffPlanId()

	if buffPlanId <= 0 then
		return
	end

	UIStateManager.instance:push(ViewName.YouthArenaThirdZdlBuffSelectView, self._fmtMo, self._fmtMo:getMode(), self._fmtMo:getCurFormTab(), buffPlanId)
end

function YouthArenaThirdFormationExView:_onClickPetBuff()
	if checknumber(self._petBuffPlanId) <= 0 then
		return
	end

	UIStateManager.instance:push(ViewName.YouthArenaThirdBuffView, self._petBuffPlanId)
end

return YouthArenaThirdFormationExView
