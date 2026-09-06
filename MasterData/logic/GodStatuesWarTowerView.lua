-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/godstatueswar/view/GodStatuesWarTowerView.lua

module("logic.extensions.godstatueswar.view.GodStatuesWarTowerView", package.seeall)

local GodStatuesWarTowerView = class("GodStatuesWarTowerView", ViewComponent)

function GodStatuesWarTowerView:ctor()
	GodStatuesWarTowerView.super.ctor(self)
end

function GodStatuesWarTowerView:buildUI()
	GodStatuesWarTowerView.super.buildUI(self)

	self._btnClose = goutil.findChild(self.mainGO, "leftTop/btnClose")
	self._btnTip = goutil.findChild(self.mainGO, "leftTop/btnTip")
	self._txtOpenTime = goutil.findChildTextComponent(self.mainGO, "txtOpenTime/txt")
	self._progressCol = goutil.findChild(self.mainGO, "progressCol")
	self._progressCol_imgPillar = goutil.findChild(self.mainGO, "progressCol/imgPillar")
	self._progressCol_txtMin = goutil.findChildTextComponent(self.mainGO, "progressCol/txtMin")
	self._progressCol_txtMax = goutil.findChildTextComponent(self.mainGO, "progressCol/txtMax")
	self._progressCol_sldTower = goutil.findChild(self.mainGO, "progressCol/sldTower")
	self._progressCol_headIcon = goutil.findChild(self.mainGO, "progressCol/sldTower/pointHead/headIcon")
	self._progressCol_txtLevel = goutil.findChildTextComponent(self.mainGO, "progressCol/sldTower/pointHead/txtLevel")

	local tierScrView = goutil.findChild(self.mainGO, "tierCol/tierScrView")
	local tierScrCell = goutil.findChild(self.mainGO, "tierCol/tierScrCell")

	self._tierScrollList = ScrollerList.create(tierScrView, tierScrCell, GameUtil.handler(self._updateTierCell, self), GameUtil.handler(self._clearTierCell, self))
	self._clgItemScrollListDic = {}
	self._passItemScrollListDic = {}
	self._seatRolePool = {}
	self._goldCol = goutil.findChild(self.mainGO, "goldCol")
	self._goldCol_leftTimes = goutil.findChild(self.mainGO, "goldCol/leftTimes")
	self._goldCol_leftTimes_txt = goutil.findChildTextComponent(self.mainGO, "goldCol/leftTimes/txt")
	self._goldCol_leftTier = goutil.findChild(self.mainGO, "goldCol/leftTier")
	self._goldCol_leftTier_txt = goutil.findChildTextComponent(self.mainGO, "goldCol/leftTier/txt")
	self._goldCol_energy = goutil.findChild(self.mainGO, "goldCol/energy")
	self._goldCol_energy_txt = goutil.findChildTextComponent(self.mainGO, "goldCol/energy/txt")
	self._btnClg = goutil.findChild(self.mainGO, "btnClg")
end

function GodStatuesWarTowerView:bindEvents()
	GodStatuesWarTowerView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTip, self)
	GameUtil.addClickHandler(self._btnClg, self._onClickBtnClg, self)
end

function GodStatuesWarTowerView:unbindEvents()
	GodStatuesWarTowerView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnClg)
end

function GodStatuesWarTowerView:onEnter()
	GodStatuesWarTowerView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._seasonId = checknumber(params[1])
	self._pillarId = checknumber(params[2])

	local isInTime = GodStatuesWarController.instance:isInSeasonTime(self._seasonId)

	if not isInTime then
		printError(string.format("不在开启期限内( seasonId = %d )", self._seasonId))
		self:close()

		return
	end

	if self._pillarId <= 0 then
		printError("缺失pillarId")
		self:close()

		return
	end

	self._seasonData = GodStatuesWarConfig.instance:getNfbSeasonData(self._seasonId)
	self._pillarData = GodStatuesWarConfig.instance:getNfbPillarInfoData(self._seasonId, self._pillarId)
	self._stepMgr = GodStatuesWarController.instance:gswStepMgrOnEnter(self._seasonId)
	self._isFamilyChief = GodStatuesWarController.instance:isFamilyChief()

	self.addGEvent(self, GlobalNotify.GodStatuesWarStepChange, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.handlePM_NewFamilyBattleGetDivinePillarMapRes, self._sendPillarInfoReq, self)
	self.addGEvent(self, GlobalNotify.handlePM_NewFamilyBattleGetDivinePillarInfoRes, self._onUpdate, self)
	self:_onSetUI()
	self:_sendPillarInfoReq()
end

function GodStatuesWarTowerView:onExit()
	GodStatuesWarTowerView.super.onExit(self)
	self:_onClear()

	if self._stepMgr then
		GodStatuesWarController.instance:gswStepMgrOnExit(self._seasonId)

		self._stepMgr = nil
	end
end

function GodStatuesWarTowerView:_sendPillarInfoReq()
	self._familyId = GodStatuesWarController.instance:getFamilyIdInGroup(self._seasonId, self._pillarId)

	if self._familyId > 0 then
		GodStatuesWarController.instance:sendPM_NewFamilyBattleGetDivinePillarInfoReq(self._seasonId, self._familyId)
	end
end

function GodStatuesWarTowerView:_onSetUI()
	return
end

function GodStatuesWarTowerView:_onUpdate()
	local stepInterval = self._stepMgr:getStepInterval(self._stepMgr:getNewestStep())

	if stepInterval ~= GswEnum.StepInterval_Bat then
		local text = "开战阶段已结束"

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

function GodStatuesWarTowerView:_onUpdateData()
	self._step = GodStatuesWarController.instance:getCurStepOfGsw(self._seasonId)
	self._stepData = GodStatuesWarConfig.instance:getNfbStepData(self._seasonId, self._step)
	self._curFightingTier = GodStatuesWarController.instance:getCurFightingTier(self._seasonId, self._pillarId)
end

function GodStatuesWarTowerView:_onUpdateUI()
	self:_onUpdatePlaneUI()
	self:_onUpdateTierColUI()
end

function GodStatuesWarTowerView:_onClear()
	self:_onClearTierCol()
	self:_unLoadBigBg(self._progressCol_imgPillar)
end

function GodStatuesWarTowerView:_onUpdatePlaneUI()
	if self._goldCol_leftTimes_txt then
		local left = GodStatuesWarController.instance:getLeftDivinePillarFightTime(self._seasonId, self._step)
		local max = GodStatuesWarController.instance:getMaxDivinePillarFightTime(self._seasonId, self._step)

		self._goldCol_leftTimes_txt.text = left > 0 and string.format("挑战神柱：<color=#20b376>%s</color>/%s", left, max) or string.format("挑战神柱：<color=#eb4624>%s</color>/%s", left, max)
	end

	if self._goldCol_leftTier_txt then
		local left = GodStatuesWarController.instance:getLeftTierCount(self._seasonId, self._pillarId)

		self._goldCol_leftTier_txt.text = left > 0 and string.format("神柱层数：剩%s层", left) or string.format("神柱层数：剩<color=#eb4624>%s</color>层", left)
	end

	if self._goldCol_energy_txt then
		local value = GodStatuesWarController.instance:getEnergyIncreaseInPillar(self._seasonId, self._pillarId)

		self._goldCol_energy_txt.text = string.format("总生存能量：%s/分钟", value)
	end

	local isMyPillar = GodStatuesWarController.instance:isMyPillar(self._seasonId, self._pillarId)
	local isHaveFamily = GodStatuesWarController.instance:isEmptyPillar(self._seasonId, self._pillarId)

	GameUtil.SetActive(self._btnClg, not isMyPillar and not isHaveFamily)

	local tierCount = GodStatuesWarController.instance:getTierCount(self._seasonId)
	local curTier = GodStatuesWarController.instance:getCurFightingTier(self._seasonId, self._pillarId)

	self._progressCol_txtMin.text = string.format("第%s层", Mathf.Min(1, tierCount))
	self._progressCol_txtMax.text = string.format("第%s层", tierCount)
	self._progressCol_txtLevel.text = string.format("当前：%s层", curTier)
	self._progressCol_sldTower:GetComponent(ComponentType.Slider).value = curTier / tierCount

	local path = "ui/bigbg/" .. self._pillarData.bigIcon

	self:_loadBigBg(self._progressCol_imgPillar, path, true)
end

function GodStatuesWarTowerView:_onUpdateTierColUI()
	local last = GodStatuesWarConfig.instance:getNfbParamsValue("DIVINE_PILLAR_LAST_TIER_NUM", true)
	local next = GodStatuesWarConfig.instance:getNfbParamsValue("DIVINE_PILLAR_NEXT_TIER_NUM", true)
	local tierCount = GodStatuesWarController.instance:getTierCount(self._seasonId)
	local curTier = GodStatuesWarController.instance:getCurFightingTier(self._seasonId, self._pillarId)
	local tierIdList = {}

	for i = 1, last do
		local tierId = curTier - i

		if tierId > 0 then
			table.insert(tierIdList, tierId)
		end
	end

	table.insert(tierIdList, curTier)

	for i = 1, next do
		local tierId = curTier + i

		if tierId <= tierCount then
			table.insert(tierIdList, tierId)
		end
	end

	local curIdx = 0

	for idx, tierId in ipairs(tierIdList) do
		if curTier == tierId then
			curIdx = idx

			break
		end
	end

	self._tierScrollList:reloadData(tierIdList)

	if #tierIdList > 0 then
		self._tierScrollList:MoveCellInView(curIdx - 1, true)
	end
end

function GodStatuesWarTowerView:_onClearTierCol()
	self._tierScrollList:dispose()
end

function GodStatuesWarTowerView:_updateTierCell(view, cell, tierId, tag)
	local divinePillarPlanId = self._stepData.divinePillarPlanId
	local tierData = GodStatuesWarConfig.instance:getNfbDivinePillarData(divinePillarPlanId, tierId)
	local seatCount = GodStatuesWarController.instance:getSeatCountInTier(self._seasonId, tierId)
	local isPass = GodStatuesWarController.instance:isPassTier(self._seasonId, self._pillarId, tierId)
	local mainGo = cell.gameObject
	local seatView = goutil.findChild(mainGo, "seatView")
	local seatCell = goutil.findChild(mainGo, "seatCell")
	local level = goutil.findChild(mainGo, "level")
	local level_txt = goutil.findChildTextComponent(mainGo, "level/txt")
	local imgPass = goutil.findChild(mainGo, "imgPass")
	local clgPrize_itemScrView = goutil.findChild(mainGo, "clgPrize/itemScrView")
	local clgPrize_itemScrCell = goutil.findChild(mainGo, "clgPrize/itemScrCell")
	local passPrize_itemScrView = goutil.findChild(mainGo, "passPrize/itemScrView")
	local passPrize_itemScrCell = goutil.findChild(mainGo, "passPrize/itemScrCell")

	if tierData.challengePrize then
		local prizeStrArr = string.split(tierData.challengePrize, "#")

		if not self._clgItemScrollListDic[mainGo] then
			local itemScrollList = ScrollerList.create(clgPrize_itemScrView, clgPrize_itemScrCell, GameUtil.handler(self._updateItemCell, self), GameUtil.handler(self._clearItemCell, self))

			self._clgItemScrollListDic[mainGo] = itemScrollList

			itemScrollList:reloadData(prizeStrArr)
			itemScrollList:dragNotifyParent()
		end
	elseif self._clgItemScrollListDic[mainGo] then
		self._clgItemScrollListDic[mainGo]:dispose()
	end

	if tierData.passPrize_client then
		local prizeStrArr = string.split(tierData.passPrize_client, "#")

		if not self._passItemScrollListDic[mainGo] then
			local itemScrollList = ScrollerList.create(passPrize_itemScrView, passPrize_itemScrCell, GameUtil.handler(self._updateItemCell, self), GameUtil.handler(self._clearItemCell, self))

			self._passItemScrollListDic[mainGo] = itemScrollList

			itemScrollList:reloadData(prizeStrArr)
			itemScrollList:dragNotifyParent()
		end
	elseif self._passItemScrollListDic[mainGo] then
		self._passItemScrollListDic[mainGo]:dispose()
	end

	level_txt.text = string.format("第%s层", tierId)

	GameUtil.SetActive(imgPass, isPass)

	local seatList = {}

	for seatIdx = 1, seatCount do
		table.insert(seatList, tierData)
	end

	GameUtil.updateCellsList(seatView, seatCell, seatList, self._updateSeatCell, self)
end

function GodStatuesWarTowerView:_clearTierCell(cell)
	local mainGo = cell.gameObject
	local seatView = goutil.findChild(mainGo, "seatView")

	if self._clgItemScrollListDic[mainGo] then
		self._clgItemScrollListDic[mainGo]:dispose()
	end

	if self._passItemScrollListDic[mainGo] then
		self._passItemScrollListDic[mainGo]:dispose()
	end

	GameUtil.clearCells(seatView, self._clearSeatCell, self)
end

function GodStatuesWarTowerView:_updateSeatCell(mainGo, tierData, seatIdx)
	local tierId = tierData.divinePillarTier
	local fmtInfoMo = GodStatuesWarController.instance:getTierFmtInfoMo(self._seasonId, self._pillarId, tierId, seatIdx)
	local posList = fmtInfoMo and fmtInfoMo:getPosList() or {}
	local curHp = fmtInfoMo and fmtInfoMo:getCurHp() or 0
	local maxHp = fmtInfoMo and fmtInfoMo:getMaxHp() or 0
	local isPass = curHp <= 0
	local spineRoot = goutil.findChild(mainGo, "spineRoot")
	local imgLock = goutil.findChild(mainGo, "imgLock")
	local imgPass = goutil.findChild(mainGo, "imgPass")
	local info = goutil.findChild(mainGo, "info")
	local info_txtName = goutil.findChildTextComponent(mainGo, "info/txtName")
	local info_bloodSld = goutil.findChild(mainGo, "info/bloodSld")
	local info_txtBlood = goutil.findChildTextComponent(mainGo, "info/txtBlood")
	local firstPetMo

	for posId, petId in ipairs(posList) do
		local petMo = fmtInfoMo:getPetMo(petId)

		if petMo then
			firstPetMo = petMo

			break
		end
	end

	if firstPetMo then
		if not firstPetMo.curFaceId then
			local skinId = 0
			local loader = self._seatRolePool[mainGo]

			loader = skinId > 0 and RoleObjectPool.instance:addRoleToParent(loader, skinId, spineRoot, nil, nil, false) or RoleObjectPool.instance:removeRole(loader)
			self._seatRolePool[mainGo] = loader

			GameUtil.SetActive(imgPass, isPass)

			info_txtName.text = string.format("神柱守卫%s", seatIdx)

			local rate = 0

			if maxHp > 0 then
				rate = curHp / maxHp
			end

			info_bloodSld:GetComponent(ComponentType.Slider).value = rate
			info_txtBlood.text = string.format("%d%%", rate * 100)
		end
	end
end

function GodStatuesWarTowerView:_clearSeatCell(mainGo, seatIdx)
	local loader = self._seatRolePool[mainGo]

	loader = RoleObjectPool.instance:removeRole(loader)
end

function GodStatuesWarTowerView:_updateItemCell(view, cell, prizeStr, tag)
	local mainGo = cell.gameObject

	MaterialMgr.setCellByCfg(prizeStr, mainGo)
end

function GodStatuesWarTowerView:_clearItemCell(cell)
	local mainGo = cell.gameObject

	MaterialMgr.resetAll(mainGo)
end

function GodStatuesWarTowerView:_loadBigBg(bgGo, path, isSetNativeSize)
	if not string.nilorempty(path) and bgGo then
		local spriteType = uGuiUtil.SpriteType.BigBg
		local spriteName = string.format("%s.png", path)

		local function func()
			if isSetNativeSize then
				bgGo:GetComponent(goutil.Type_UIImage):SetNativeSize()
			end
		end

		uGuiUtil.setSpriteToImage(bgGo, spriteType, spriteName, func)
	else
		self:_unLoadBigBg(bgGo)
	end
end

function GodStatuesWarTowerView:_unLoadBigBg(bgGo)
	uGuiUtil.clearImage(bgGo)
end

function GodStatuesWarTowerView:_onClickBtnClg()
	local result, tips = GodStatuesWarController.instance:getTryEnterFightPillarInGswResultAndTips(self._seasonId, self._pillarId, self._curFightingTier)

	FloatWordMgr.instance:show(tips)

	if result ~= GameEnum.ResultCode.Success then
		return
	end

	GodStatuesWarController.instance:enterGodStatuesWarFightPillarFmt(self._seasonId, self._pillarId, self._familyId, self._curFightingTier, self._step)
end

function GodStatuesWarTowerView:_onClickBtnTip()
	local key = GodStatuesWarConfig.instance:getNfbClientCommonValue(self._seasonId, "towerTipsKey")

	TipsFacade.instance:openRulesView(key)
end

return GodStatuesWarTowerView
