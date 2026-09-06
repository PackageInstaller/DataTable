-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/godstatueswar/view/GodStatuesWarTowerFmtAdjustView.lua

module("logic.extensions.godstatueswar.view.GodStatuesWarTowerFmtAdjustView", package.seeall)

local GodStatuesWarTowerFmtAdjustView = class("GodStatuesWarTowerFmtAdjustView", ViewComponent)

function GodStatuesWarTowerFmtAdjustView:ctor()
	GodStatuesWarTowerFmtAdjustView.super.ctor(self)
end

function GodStatuesWarTowerFmtAdjustView:buildUI()
	GodStatuesWarTowerFmtAdjustView.super.buildUI(self)

	self._btnClose = goutil.findChild(self.mainGO, "leftTop/btnClose")
	self._btnTip = goutil.findChild(self.mainGO, "leftTop/btnTip")
	self._tabScrView = goutil.findChild(self.mainGO, "tabCol/tabScrView"):GetComponent("ScrollRectExt")
	self._tabScrView_content = goutil.findChild(self.mainGO, "tabCol/tabScrView/Viewport/Content")
	self._tabScrCell = goutil.findChild(self.mainGO, "tabCol/tabScrCell")

	GameUtil.SetActive(self._tabScrCell, false)

	local fmtScrView = goutil.findChild(self.mainGO, "fmtCol/fmtScrView")
	local fmtScrCell = goutil.findChild(self.mainGO, "fmtCol/fmtScrCell")

	self._fmtScrollList = ScrollerList.create(fmtScrView, fmtScrCell, GameUtil.handler(self._updateFmtCell, self), GameUtil.handler(self._clearFmtCell, self))
end

function GodStatuesWarTowerFmtAdjustView:bindEvents()
	GodStatuesWarTowerFmtAdjustView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTip, self)
	self._tabScrView:AddOnEndDrag(self._onEndDrag, self)
end

function GodStatuesWarTowerFmtAdjustView:unbindEvents()
	GodStatuesWarTowerFmtAdjustView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	self._tabScrView:RemoveOnEndDrag()
end

function GodStatuesWarTowerFmtAdjustView:onEnter()
	GodStatuesWarTowerFmtAdjustView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._seasonId = checknumber(params[1])

	local isInTime = GodStatuesWarController.instance:isInSeasonTime(self._seasonId)

	if not isInTime then
		printError(string.format("不在开启期限内( seasonId = %d )", self._seasonId))
		self:close()

		return
	end

	self._seasonData = GodStatuesWarConfig.instance:getNfbSeasonData(self._seasonId)
	self._stepMgr = GodStatuesWarController.instance:gswStepMgrOnEnter(self._seasonId)
	self._isFamilyChief = GodStatuesWarController.instance:isFamilyChief()

	self.addGEvent(self, GlobalNotify.GodStatuesWarStepChange, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.handlePM_NewFamilyBattleGetDivinePillarMapRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.handlePM_NewFamilyBattleGetDivinePillarFormRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.handlePM_NewFamilyBattleAdjustRes, self._onUpdate, self)
	GodStatuesWarController.instance:sendPM_NewFamilyBattleGetDivinePillarFormReq(self._seasonId)
end

function GodStatuesWarTowerFmtAdjustView:onExit()
	GodStatuesWarTowerFmtAdjustView.super.onExit(self)
	self:_onClear()

	if self._stepMgr then
		GodStatuesWarController.instance:gswStepMgrOnExit(self._seasonId)

		self._stepMgr = nil
	end
end

function GodStatuesWarTowerFmtAdjustView:_onUpdate()
	local stepInterval = self._stepMgr:getStepInterval(self._stepMgr:getNewestStep())

	if stepInterval ~= GswEnum.StepInterval_Adj then
		local text = "调整阶段已结束"

		local function func()
			return
		end

		TipsFacade.instance:openTipWindow("提示", text, func, "确定", UnityEngine.TextAnchor.MiddleCenter)
		self:close()

		return
	end

	self:_onUpdateData()
	self:_onUpdateUI()
end

function GodStatuesWarTowerFmtAdjustView:_onUpdateData()
	self:_onUpdateTabColData()
end

function GodStatuesWarTowerFmtAdjustView:_onUpdateUI()
	self:_onUpdateTabColUI()
	self:_onUpdateFmtColUI()
end

function GodStatuesWarTowerFmtAdjustView:_onClear()
	self:_onClearTabCol()
	self:_onClearFmtColUI()
end

function GodStatuesWarTowerFmtAdjustView:_onUpdateTabColData()
	self._tierIdList = {}

	local tierCount = GodStatuesWarController.instance:getTierCount(self._seasonId)

	for tierId = 1, tierCount do
		table.insert(self._tierIdList, tierId)
	end

	self._tabIdx = self._tabIdx or 1
	self._tabIdx = Mathf.Clamp(self._tabIdx, 0, #self._tierIdList)
end

function GodStatuesWarTowerFmtAdjustView:_getTierId(tabIdx)
	return self._tierIdList[tabIdx]
end

function GodStatuesWarTowerFmtAdjustView:_onUpdateTabColUI()
	self:_updateAllTabCellUI()
	self._tabScrView:initChildList(self._tabIdx - 1)
end

function GodStatuesWarTowerFmtAdjustView:_updateAllTabCellUI()
	local tierCount = GodStatuesWarController.instance:getTierCount(self._seasonId)
	local tierIdList = {}

	for tierId = 1, tierCount do
		table.insert(tierIdList, tierId)
	end

	GameUtil.updateCellsList(self._tabScrView_content, self._tabScrCell, tierIdList, self._updateTabCell, self)
end

function GodStatuesWarTowerFmtAdjustView:_onClearTabCol()
	GameUtil.clearCells(self._tabScrView_content, self._clearTabCell, self)
end

function GodStatuesWarTowerFmtAdjustView:_updateTabCell(mainGo, tierId, tabIdx)
	local isSelected = tabIdx == self._tabIdx
	local root = goutil.findChild(mainGo, "root")
	local unSelect = goutil.findChild(mainGo, "root/unSelect")
	local select = goutil.findChild(mainGo, "root/select")

	GameUtil.SetActive(unSelect, not isSelected)
	GameUtil.SetActive(select, isSelected)

	if not isSelected then
		self:_updateTabCellUnSelect(unSelect, tierId, tabIdx)
	else
		self:_updateTabCellSelect(select, tierId, tabIdx)
	end

	GameUtil.addClickHandler(root, GameUtil.handler(self._onClickTabCell, self, tabIdx, tierId))
end

function GodStatuesWarTowerFmtAdjustView:_updateTabCellUnSelect(mainGo, tierId, tabIdx)
	local txtName = goutil.findChildTextComponent(mainGo, "txtName")

	txtName.text = tierId > 9 and tierId or string.format("0%d", tierId)
end

function GodStatuesWarTowerFmtAdjustView:_updateTabCellSelect(mainGo, tierId, tabIdx)
	local txtName = goutil.findChildTextComponent(mainGo, "txtName")

	txtName.text = tierId > 9 and tierId or string.format("0%d", tierId)
end

function GodStatuesWarTowerFmtAdjustView:_clearTabCell(cell)
	local mainGo = cell.gameObject

	GameUtil.rmClickHandler(mainGo)
end

function GodStatuesWarTowerFmtAdjustView:_onClickTabCell(tabIdx, tierId)
	self._tabIdx = tabIdx

	self:_onUpdateUI()
end

function GodStatuesWarTowerFmtAdjustView:_onEndDrag(curSelectIndex)
	self._tabIdx = curSelectIndex + 1

	self:_updateAllTabCellUI()
	self:_onUpdateFmtColUI()
end

function GodStatuesWarTowerFmtAdjustView:_onUpdateFmtColUI()
	local tierId = self:_getTierId(self._tabIdx)
	local seatCount = GodStatuesWarController.instance:getSeatCountInTier(self._seasonId, tierId)
	local seatIdxList = {}

	for seatIdx = 1, seatCount do
		table.insert(seatIdxList, seatIdx)
	end

	self._fmtScrollList:reloadData(seatIdxList)
end

function GodStatuesWarTowerFmtAdjustView:_onClearFmtColUI()
	self._fmtScrollList:dispose()
end

function GodStatuesWarTowerFmtAdjustView:_updateFmtCell(view, cell, seatIdx, tag)
	local tierId = self:_getTierId(self._tabIdx)
	local fmtInfoMo = GodStatuesWarController.instance:getTierFmtInfoMoOfSimple(self._seasonId, tierId, seatIdx)
	local playerId = fmtInfoMo:getPlayerId() or ""
	local zdlValue = fmtInfoMo:getZdl() or 0
	local speedValue = fmtInfoMo:getSpeed() or 0
	local fmtType = fmtInfoMo:getFmtType()
	local fmtName = fmtInfoMo:getFmtName()
	local mainGo = cell.gameObject
	local systemTag = goutil.findChild(mainGo, "systemTag")
	local playerTag = goutil.findChild(mainGo, "playerTag")
	local btnReplace = goutil.findChild(mainGo, "btnReplace")
	local name_txt = goutil.findChildTextComponent(mainGo, "name/txt")
	local txtPower = goutil.findChildTextComponent(mainGo, "info/txtPower")
	local txtSpeed = goutil.findChildTextComponent(mainGo, "info/txtSpeed")
	local txtPlayer = goutil.findChildTextComponent(mainGo, "txtPlayer")
	local fmt = goutil.findChild(mainGo, "fmt")
	local fmtView = goutil.findChild(mainGo, "fmt/fmtView")

	for posId = 1, fmtView.transform.childCount do
		local go = fmtView.transform:GetChild(posId - 1)
		local icon = goutil.findChild(go, "icon")
		local petMo = fmtInfoMo:getPetMo(posId)

		if petMo then
			local skinId = petMo.curFaceId
			local proxy = MaterialMgr.setCell(MatType.Pet, skinId, icon)

			if proxy then
				proxy.binder:setClickCallBack(function()
					CommonTipsMgr.instance:showPetTips(petMo)
				end)
			end
		else
			MaterialMgr.resetAll(icon)
		end
	end

	name_txt.text = string.format("队伍%s", seatIdx)
	txtPower.text = zdlValue
	txtSpeed.text = speedValue
	txtPlayer.text = fmtName

	GameUtil.SetActive(systemTag, fmtType == GswEnum.FmtType_System)
	GameUtil.SetActive(playerTag, fmtType == GswEnum.FmtType_Player)
	GameUtil.addClickHandler(btnReplace, GameUtil.handler(self._onClickFmtCellBtnReplace, self, tierId, seatIdx))
end

function GodStatuesWarTowerFmtAdjustView:_clearFmtCell(mainGo)
	local fmtView = goutil.findChild(mainGo, "fmt/fmtView")
	local btnEnter = goutil.findChild(mainGo, "btnEnter")

	for posId = 1, fmtView.transform.childCount do
		local go = fmtView.transform:GetChild(posId - 1)
		local icon = goutil.findChild(go, "icon")

		MaterialMgr.resetAll(icon)
	end

	GameUtil.rmClickHandler(btnEnter)
end

function GodStatuesWarTowerFmtAdjustView:_onClickFmtCellBtnReplace(tierId, seatIdx)
	UIStateManager.instance:push(ViewName.GodStatuesWarTowerFmtAdjustDetailView, self._seasonId, tierId, seatIdx)
end

function GodStatuesWarTowerFmtAdjustView:_onClickBtnClg()
	local result, tips = GodStatuesWarController.instance:getTryOpenRankViewInGswResultAndTips(self._seasonId)

	FloatWordMgr.instance:show(tips)

	if result ~= GameEnum.ResultCode.Success then
		return
	end

	UIStateManager.instance:push(ViewName.GodStatuesWarTabFrameRankView)
end

function GodStatuesWarTowerFmtAdjustView:_onClickBtnTip()
	local key = GodStatuesWarConfig.instance:getNfbClientCommonValue(self._seasonId, "adjustTipsKey")

	TipsFacade.instance:openRulesView(key)
end

return GodStatuesWarTowerFmtAdjustView
