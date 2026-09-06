-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/godstatueswar/view/GodStatuesWarTowerFmtAdjustDetailView.lua

module("logic.extensions.godstatueswar.view.GodStatuesWarTowerFmtAdjustDetailView", package.seeall)

local GodStatuesWarTowerFmtAdjustDetailView = class("GodStatuesWarTowerFmtAdjustDetailView", ViewComponent)

function GodStatuesWarTowerFmtAdjustDetailView:ctor()
	GodStatuesWarTowerFmtAdjustDetailView.super.ctor(self)
end

function GodStatuesWarTowerFmtAdjustDetailView:buildUI()
	GodStatuesWarTowerFmtAdjustDetailView.super.buildUI(self)

	self._btnClose = goutil.findChild(self.mainGO, "btnClose")
	self._btnReplace = goutil.findChild(self.mainGO, "btnReplace")

	local fmtScrView = goutil.findChild(self.mainGO, "fmtCol/fmtScrView")
	local fmtScrCell = goutil.findChild(self.mainGO, "fmtCol/fmtScrCell")

	self._fmtScrollList = ScrollerList.create(fmtScrView, fmtScrCell, GameUtil.handler(self._updateFmtCell, self), GameUtil.handler(self._clearFmtCell, self))
	self._fmtShowCol = goutil.findChild(self.mainGO, "fmtShowCol")
	self._fmtShowCol_fmtView = goutil.findChild(self.mainGO, "fmtShowCol/fmt/fmtView")
	self._fmtShowCol_txtPower = goutil.findChildTextComponent(self.mainGO, "fmtShowCol/info/txtPower")
	self._fmtShowCol_txtSpeed = goutil.findChildTextComponent(self.mainGO, "fmtShowCol/info/txtSpeed")
	self._fmtShowCol_tips = goutil.findChild(self.mainGO, "fmtShowCol/tips")
	self._fmtShowCol_tips_txt = goutil.findChildTextComponent(self.mainGO, "fmtShowCol/tips/txt")
	self._fmtShowCol_name_txt = goutil.findChildTextComponent(self.mainGO, "fmtShowCol/name/txt")
	self._fmtShowCol_systemTag = goutil.findChildTextComponent(self.mainGO, "fmtShowCol/systemTag")
	self._fmtShowCol_playerTag = goutil.findChildTextComponent(self.mainGO, "fmtShowCol/playerTag")
end

function GodStatuesWarTowerFmtAdjustDetailView:bindEvents()
	GodStatuesWarTowerFmtAdjustDetailView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnReplace, self._onClickBtnReplace, self)
end

function GodStatuesWarTowerFmtAdjustDetailView:unbindEvents()
	GodStatuesWarTowerFmtAdjustDetailView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnReplace)
end

function GodStatuesWarTowerFmtAdjustDetailView:onEnter()
	GodStatuesWarTowerFmtAdjustDetailView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._seasonId = checknumber(params[1])
	self._tierId = checknumber(params[2])
	self._seatIdx = checknumber(params[3])

	local isInTime = GodStatuesWarController.instance:isInSeasonTime(self._seasonId)

	if not isInTime then
		printError(string.format("不在开启期限内( seasonId = %d )", self._seasonId))
		self:close()

		return
	end

	self._onlyId = GodStatuesWarController.instance:getOnlyIdInTierOfSimple(self._seasonId, self._tierId, self._seatIdx)
	self._seasonData = GodStatuesWarConfig.instance:getNfbSeasonData(self._seasonId)
	self._stepMgr = GodStatuesWarController.instance:gswStepMgrOnEnter(self._seasonId)
	self._isFamilyChief = GodStatuesWarController.instance:isFamilyChief()
	self._curShowOnlyId = GodStatuesWarController.instance:getOnlyIdInTierOfSimple(self._seasonId, self._tierId, self._seatIdx)

	self.addGEvent(self, GlobalNotify.GodStatuesWarStepChange, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.handlePM_NewFamilyBattleGetDivinePillarMapRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.handlePM_NewFamilyBattleGetDivinePillarFormRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.handlePM_NewFamilyBattleAdjustRes, self._handleBattleAdjustRes, self)
	GodStatuesWarController.instance:sendPM_NewFamilyBattleGetDivinePillarFormReq(self._seasonId)
end

function GodStatuesWarTowerFmtAdjustDetailView:onExit()
	GodStatuesWarTowerFmtAdjustDetailView.super.onExit(self)
	self:_onClear()

	if self._stepMgr then
		GodStatuesWarController.instance:gswStepMgrOnExit(self._seasonId)

		self._stepMgr = nil
	end
end

function GodStatuesWarTowerFmtAdjustDetailView:_handleBattleAdjustRes()
	FloatWordMgr.instance:show("调整成功")
	self:close()
end

function GodStatuesWarTowerFmtAdjustDetailView:_onUpdate()
	local stepInterval = self._stepMgr:getStepInterval(self._stepMgr:getNewestStep())

	if stepInterval ~= GswEnum.StepInterval_Adj then
		local text = "不在调整阶段内"

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

function GodStatuesWarTowerFmtAdjustDetailView:_onUpdateData()
	local onlyIdList = GodStatuesWarController.instance:getOnlyIdListOfSimple(self._seasonId)
	local list = {}

	for _, onlyId in ipairs(onlyIdList) do
		local info = {}

		info.onlyId = onlyId

		local fmtInfoMo = GodStatuesWarController.instance:getTierFmtInfoMoByOnlyIdOfSimple(self._seasonId, onlyId)

		info.zdl = fmtInfoMo and fmtInfoMo:getZdl() or 0

		table.insert(list, info)
	end

	table.sort(list, function(a, b)
		return a.zdl > b.zdl
	end)

	self._onlyIdList = {}

	for i, v in ipairs(list) do
		table.insert(self._onlyIdList, v.onlyId)
	end
end

function GodStatuesWarTowerFmtAdjustDetailView:_onUpdateUI()
	self:_onUpdateFmtColUI()
	self:_onUpdateFmtShowColUI()
end

function GodStatuesWarTowerFmtAdjustDetailView:_onClear()
	self:_onClearFmtColUI()
	self:_onClearFmtShowColUI()
end

function GodStatuesWarTowerFmtAdjustDetailView:_onUpdateFmtColUI()
	self._fmtScrollList:reloadData(self._onlyIdList)

	local idx = 0
	local isMotion = true

	if not string.nilorempty(self._curShowOnlyId) then
		for i, v in ipairs(self._onlyIdList) do
			if self._curShowOnlyId == v then
				idx = i

				break
			end
		end
	end

	self._fmtScrollList:MoveCellInView(idx, isMotion)
end

function GodStatuesWarTowerFmtAdjustDetailView:_onClearFmtColUI()
	self._fmtScrollList:dispose()
end

function GodStatuesWarTowerFmtAdjustDetailView:_updateFmtCell(view, cell, onlyId, tag)
	local tierId = GodStatuesWarController.instance:getTierIdOfSimple(self._seasonId, onlyId)
	local seatIdx = GodStatuesWarController.instance:getSeatIdxOfSimple(self._seasonId, onlyId)
	local fmtInfoMo = GodStatuesWarController.instance:getTierFmtInfoMoByOnlyIdOfSimple(self._seasonId, onlyId)
	local fmtType = fmtInfoMo:getFmtType()
	local mainGo = cell.gameObject
	local icon = goutil.findChild(mainGo, "pet/icon")
	local btnSelect = goutil.findChild(mainGo, "btnSelect")
	local imgUp = goutil.findChild(mainGo, "imgUp")
	local imgSelect = goutil.findChild(mainGo, "imgSelect")
	local txtPower = goutil.findChildTextComponent(mainGo, "txtPower")
	local firstSkinId = 0

	for posId = 1, 9 do
		local skinId = fmtInfoMo:getSkinId(posId) or 0

		if skinId > 0 then
			firstSkinId = skinId

			break
		end
	end

	if firstSkinId > 0 then
		MaterialMgr.setIcon(icon, MatType.Pet, firstSkinId, nil, nil)
	else
		MaterialMgr.clearIcon(icon)
	end

	txtPower.text = fmtInfoMo:getZdl()

	GameUtil.SetActive(imgUp, tierId > 0 and seatIdx > 0)
	GameUtil.SetActive(imgSelect, self._curShowOnlyId == onlyId)
	GameUtil.addClickHandler(btnSelect, GameUtil.handler(self._onClickFmtCellBtnSelect, self, onlyId))
end

function GodStatuesWarTowerFmtAdjustDetailView:_clearFmtCell(cell)
	local mainGo = cell.gameObject
	local icon = goutil.findChild(mainGo, "pet/icon")
	local btnSelect = goutil.findChild(mainGo, "btnSelect")

	MaterialMgr.clearIcon(icon)
	GameUtil.rmClickHandler(btnSelect)
end

function GodStatuesWarTowerFmtAdjustDetailView:_onClickFmtCellBtnSelect(onlyId)
	self._curShowOnlyId = onlyId

	self:_onUpdateUI()
end

function GodStatuesWarTowerFmtAdjustDetailView:_onUpdateFmtShowColUI()
	local showOnlyId = self._curShowOnlyId
	local fmtInfoMo = not string.nilorempty(showOnlyId) and GodStatuesWarController.instance:getTierFmtInfoMoByOnlyIdOfSimple(self._seasonId, showOnlyId) or GodStatuesWarController.instance:getTierFmtInfoMoOfSimple(self._seasonId, self._tierId, self._seatIdx)
	local fmtType = fmtInfoMo:getFmtType()
	local fmtView = self._fmtShowCol_fmtView

	for posId = 1, fmtView.transform.childCount do
		local go = fmtView.transform:GetChild(posId - 1)
		local icon = goutil.findChild(go, "icon")
		local petMo = fmtInfoMo:getPetMo(posId)

		if petMo then
			local skinId = petMo.curFaceId
			local proxy = MaterialMgr.setCell(MatType.Pet, skinId, icon)
			local isHideZdl = fmtType ~= GswEnum.FmtType_Player

			if proxy then
				proxy.binder:setClickCallBack(function()
					CommonTipsMgr.instance:showPetTips(petMo, isHideZdl)
				end)
			end
		else
			MaterialMgr.resetAll(icon)
		end
	end

	if fmtInfoMo then
		self._fmtShowCol_txtPower.text = fmtInfoMo:getZdl()
		self._fmtShowCol_txtSpeed.text = fmtInfoMo:getSpeed()
	else
		self._fmtShowCol_txtPower.text = 0
		self._fmtShowCol_txtSpeed.text = 0
	end

	if not string.nilorempty(showOnlyId) then
		local tierId = GodStatuesWarController.instance:getTierIdOfSimple(self._seasonId, showOnlyId)
		local seatIdx = GodStatuesWarController.instance:getSeatIdxOfSimple(self._seasonId, showOnlyId)

		self._fmtShowCol_tips_txt.text = (tierId == 0 or seatIdx == 0) and "暂未上阵" or string.format("已上阵：%s层 队伍%s", tierId, seatIdx)
	else
		self._fmtShowCol_tips_txt.text = string.format("已上阵：%s层 队伍%s", self._tierId, self._seatIdx)
	end

	if fmtInfoMo then
		local fmtType = fmtInfoMo:getFmtType()

		GameUtil.SetActive(self._fmtShowCol_systemTag, fmtType == GswEnum.FmtType_System)
		GameUtil.SetActive(self._fmtShowCol_playerTag, fmtType == GswEnum.FmtType_Player)
	else
		GameUtil.SetActive(self._fmtShowCol_systemTag, false)
		GameUtil.SetActive(self._fmtShowCol_playerTag, false)
	end

	self._fmtShowCol_name_txt.text = fmtInfoMo and fmtInfoMo:getFmtName() or ""

	GameUtil.SetActive(self._btnReplace, not string.nilorempty(self._curShowOnlyId))
end

function GodStatuesWarTowerFmtAdjustDetailView:_onClearFmtShowColUI()
	local fmtView = self._fmtShowCol_fmtView

	for posId = 1, fmtView.transform.childCount do
		local go = fmtView.transform:GetChild(posId - 1)
		local icon = goutil.findChild(go, "icon")

		MaterialMgr.resetAll(icon)
	end
end

function GodStatuesWarTowerFmtAdjustDetailView:_onClickBtnReplace()
	if string.nilorempty(self._curShowOnlyId) then
		return
	end

	if self._curShowOnlyId == self._onlyId then
		FloatWordMgr.instance:show("阵型相同，无需替换")

		return
	end

	local seasonId = self._seasonId
	local onlyIdA = self._onlyId
	local tierIdA = self._tierId
	local seatIdxA = self._seatIdx
	local onlyIdB = self._curShowOnlyId
	local tierIdB = GodStatuesWarController.instance:getTierIdOfSimple(seasonId, onlyIdB)
	local seatIdxB = GodStatuesWarController.instance:getSeatIdxOfSimple(seasonId, onlyIdB)
	local tipsContent = string.format("是否将<color=#cd7800>%s层 队伍%s</color>的守阵替换到<color=#cd7800>%s层 队伍%s</color>", tierIdB, seatIdxB, tierIdA, seatIdxA)

	local function okFunc()
		GodStatuesWarController.instance:getGswMo(seasonId):getSpInfoCtrl():setOnlyIdToTier(onlyIdA, tierIdB, seatIdxB)
		GodStatuesWarController.instance:getGswMo(seasonId):getSpInfoCtrl():setOnlyIdToTier(onlyIdB, tierIdA, seatIdxA)

		local req = NewFamilyBattleExtension_pb.PM_NewFamilyBattleAdjustReq()

		req.seasonId = seasonId

		local moA

		if not string.nilorempty(onlyIdA) then
			local fmtInfoMo = GodStatuesWarController.instance:getTierFmtInfoMoByOnlyIdOfSimple(seasonId, onlyIdA)

			if fmtInfoMo and fmtInfoMo:getFmtType() ~= GswEnum.FmtType_Empty then
				local mo = NewFamilyBattleExtension_pb.PM_NewFamilyBattleDivinePillarSimpleFormation()

				mo.playerId = fmtInfoMo:getPlayerId()
				mo.playerFormId = fmtInfoMo:getPlayerFormId()
				mo.tier = tierIdB
				mo.formId = seatIdxB
				moA = mo
			end
		end

		local moB

		if not string.nilorempty(onlyIdB) then
			local fmtInfoMo = GodStatuesWarController.instance:getTierFmtInfoMoByOnlyIdOfSimple(seasonId, onlyIdB)

			if fmtInfoMo and fmtInfoMo:getFmtType() ~= GswEnum.FmtType_Empty then
				local mo = NewFamilyBattleExtension_pb.PM_NewFamilyBattleDivinePillarSimpleFormation()

				mo.playerId = fmtInfoMo:getPlayerId()
				mo.playerFormId = fmtInfoMo:getPlayerFormId()
				mo.tier = tierIdA
				mo.formId = seatIdxA
				moB = mo
			end
		end

		if moA then
			req.formList:add():ParseFromString(moA:SerializeToString())
		end

		if moB then
			req.formList:add():ParseFromString(moB:SerializeToString())
		end

		GodStatuesWarController.instance:sendPM_NewFamilyBattleAdjustReq(seasonId, req)
	end

	local function cencelFunc()
		return
	end

	if tierIdB > 0 or seatIdxB > 0 then
		TipsFacade.instance:openPopupWindow("提示", tipsContent, okFunc, cencelFunc, "确定", "取消")
	else
		okFunc()
	end
end

return GodStatuesWarTowerFmtAdjustDetailView
