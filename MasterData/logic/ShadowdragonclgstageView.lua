-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/shadowdragonclg/view/ShadowdragonclgstageView.lua

module("logic.extensions.shadowdragonclg.view.ShadowdragonclgstageView", package.seeall)

local ShadowdragonclgstageView = class("ShadowdragonclgstageView", ViewComponent)

function ShadowdragonclgstageView:ctor()
	ShadowdragonclgstageView.super.ctor(self)
end

function ShadowdragonclgstageView:unbindEvents()
	ShadowdragonclgstageView.super.unbindEvents(self)
	self._btnTip:RemoveClickListener()
	self._btnClose:RemoveClickListener()
	self._btnSpace:RemoveClickListener()
	self._btnReset:RemoveClickListener()
end

function ShadowdragonclgstageView:bindEvents()
	ShadowdragonclgstageView.super.bindEvents(self)
	self._btnTip:AddClickListener(self._onClickbtnTip, self)
	self._btnClose:AddClickListener(self._onClickbtnClose, self)
	self._btnSpace:AddClickListener(self._onClickbtnSpace, self)
	self._btnReset:AddClickListener(self._onClickbtnReset, self)
end

function ShadowdragonclgstageView:buildUI()
	ShadowdragonclgstageView.super.buildUI(self)

	self._tableviewGo = self:getGo("tableview")
	self._tablecellGo = self:getGo("tablecell")
	self._tabtableviewGo = self:getGo("tabtableview")
	self._tabtablecellGo = self:getGo("tabtablecell")
	self._btnTip = self:getBtn("leftTop/btnTip")
	self._btnClose = self:getBtn("leftTop/btnClose")
	self._tabscrollerList = ScrollerList.create(self._tabtableviewGo, self._tabtablecellGo, GameUtil.handler(self._updateTabCell, self), GameUtil.handler(self._clearTabCell, self))
	self._scrollerList = ScrollerList.create(self._tableviewGo, self._tablecellGo, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))

	self._scrollerList:regReloadFinish(GameUtil.handler(self._onReloadFinish, self))

	self._txtDesc = self:getTxt("rule/txtDesc")
	self._txtOpenTime = goutil.findChildTextComponent(self.mainGO, "txtOpenTime/txt")
	self._btnSpace = self:getBtn("btnSpace")
	self._btnReset = self:getBtn("btnReset")
	self._cellScrollList = {}
	self._txtNum1 = self:getTxt("coin1/txtNum")
	self._txtNum2 = self:getTxt("coin2/txtNum")
end

function ShadowdragonclgstageView:onExit()
	ShadowdragonclgstageView.super.onExit(self)
	self._tabscrollerList:dispose()
	self._scrollerList:dispose()
end

function ShadowdragonclgstageView:onEnter()
	ShadowdragonclgstageView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.ShadowDragonClgGetInfoRes, self._updateUI, self)
	self.addGEvent(self, GlobalNotify.ShadowDragonClgResetAllStageRes, self._onResetAllStageRes, self)

	self._activityId = self:getFirstParam()

	self:_initFloorId()
	ShadowdragonclgController.instance:setCurrFloorType(self._currSelectFloorType)

	self._tabCfgs = ShadowdragonclgConfig.instance:getFloorCfgs(self._activityId)

	self:_updateTabs()
	self:_updateUI()
	self:_checkShowCI()
end

function ShadowdragonclgstageView:_initFloorId()
	local floorType = ShadowdragonclgController.instance:getCurrFloorType()

	self._currSelectFloorType = floorType

	if floorType == ShadowdragonclgController.FloorType.None then
		local info = ShadowdragonclgModel.instance:getInfo(self._activityId)
		local isNowFloorPass = ShadowdragonclgModel.instance:isFloorPass(self._activityId, ShadowdragonclgController.FloorType.Now)
		local stageList

		self._currSelectFloorType = isNowFloorPass and ShadowdragonclgController.FloorType.PassFuture or ShadowdragonclgController.FloorType.Now
	elseif floorType == ShadowdragonclgController.FloorType.Now then
		local isUse = GameUtil.getUserData(ShadowdragonclgController.Key_AutoSelectTab)
		local isNowFloorPass = ShadowdragonclgModel.instance:isFloorPass(self._activityId, ShadowdragonclgController.FloorType.Now)

		if not isUse and isNowFloorPass then
			self._currSelectFloorType = ShadowdragonclgController.FloorType.PassFuture

			GameUtil.saveUserData(ShadowdragonclgController.Key_AutoSelectTab, true)
		end
	end

	if not floorType then
		self._currSelectFloorType = ShadowdragonclgController.FloorType.Now
	end
end

function ShadowdragonclgstageView:_updateUI()
	self._info = ShadowdragonclgModel.instance:getInfo(self._activityId)
	self._txtOpenTime.text = TimeGateController.instance:getActTimeShow(self._activityId)
	self._txtNum1.text = self:_getCoinNum1()
	self._txtNum2.text = self:_getCoinNum2()

	self:_onClickTabBtn(self._currSelectFloorType)
end

function ShadowdragonclgstageView:_updateTabs()
	self._tabscrollerList:reloadData(self._tabCfgs)
end

function ShadowdragonclgstageView:_updateStageView()
	self:_updateFormations()
	self:_updateRule()
end

function ShadowdragonclgstageView:_updateFormations()
	self._stageCfgs = {}
	self._stageCfgs = self:_isFloorNow() and ShadowdragonclgConfig.instance:getNowStageCfgs(self._activityId) or ShadowdragonclgConfig.instance:getFuturePassStageCfgs(self._activityId)

	self._scrollerList:reloadData(self._stageCfgs)
end

function ShadowdragonclgstageView:_updateRule()
	local cfg = ShadowdragonclgConfig.instance:getFloorCfg(self._activityId, self._currSelectFloorType)

	self._txtDesc.text = cfg.ruleDesc
end

function ShadowdragonclgstageView:_updateTabCell(view, cell, cfg, tag)
	local btn = Framework.ButtonAdapter.Get(goutil.findChild(cell.gameObject, "btn"))
	local selectGo = goutil.findChild(cell.gameObject, "btn/select")
	local txtName = goutil.findChildTextComponent(cell.gameObject, "btn/txtName")
	local passGo = goutil.findChild(cell.gameObject, "btn/passGo")
	local lockGo = goutil.findChild(cell.gameObject, "btn/lock")
	local bgGo = goutil.findChild(cell.gameObject, "btn/bg")
	local bggrayGo = goutil.findChild(cell.gameObject, "btn/bggray")
	local isCurr = cfg.floorType == self._currSelectFloorType
	local isGray = cfg.floorType ~= ShadowdragonclgController.FloorType.Now and not ShadowdragonclgModel.instance:isFloorPass(self._activityId, ShadowdragonclgController.FloorType.Now)

	goutil.setActive(selectGo, isCurr)
	goutil.setActive(lockGo, isGray)
	goutil.setActive(bgGo, not isGray)
	goutil.setActive(bggrayGo, isGray)

	txtName.text = cfg.tabName

	btn:AddClickListener(function()
		self:_onClickTabBtn(cfg.floorType)
	end)
	goutil.setActive(passGo, false)
end

function ShadowdragonclgstageView:_onClickTabBtn(floorType)
	local info = ShadowdragonclgModel.instance:getInfo(self._activityId)

	if not info then
		return
	end

	local fT = ShadowdragonclgController.FloorType.Now

	if floorType ~= fT and not ShadowdragonclgModel.instance:isFloorPass(self._activityId, fT) then
		FloatWordMgr.instance:show("第一层未通关")

		return
	end

	self._currSelectFloorType = floorType

	ShadowdragonclgController.instance:setCurrFloorType(self._currSelectFloorType)
	self._tabscrollerList:refresh()
	self:_updateStageView()
end

function ShadowdragonclgstageView:_clearTabCell(cell)
	return
end

function ShadowdragonclgstageView:_updateCell(view, cell, stageCfg, tag)
	local btn = Framework.ButtonAdapter.GetFrom(cell.gameObject, "btn")
	local passGo = goutil.findChild(cell.gameObject, "passGo")
	local descGo1 = goutil.findChild(cell.gameObject, "desc1")
	local descGo2 = goutil.findChild(cell.gameObject, "desc2")
	local selectGo = goutil.findChild(cell.gameObject, "select")
	local txtName = goutil.findChildTextComponent(cell.gameObject, "name/txtName")

	goutil.setActive(descGo1, self:_isFloorNow())
	goutil.setActive(descGo2, self._currSelectFloorType == ShadowdragonclgController.FloorType.PassFuture)
	self:_setFormationPets(cell, stageCfg.creepsMasterId)

	if self:_isFloorNow() then
		self:_updateNowBottomCell(descGo1, stageCfg)
	else
		self:_updatePassFutureBottomCell(descGo2, stageCfg)
	end

	local isPrePass = stageCfg.stageId <= 1 or ShadowdragonclgModel.instance:isStagePass(self._activityId, self._currSelectFloorType, stageCfg.stageId - 1)
	local isPass = ShadowdragonclgModel.instance:isStagePass(self._activityId, self._currSelectFloorType, stageCfg.stageId)
	local isSelect = isPrePass and not isPass
	local isCanChallenge = isSelect

	txtName.text = stageCfg.desc

	goutil.setActive(selectGo, isSelect)
	goutil.setActive(passGo, isPass)
	btn:AddClickListener(function()
		local isAllPass = ShadowdragonclgModel.instance:isAllFloorPass(self._activityId)

		if not isAllPass then
			if isPass then
				FloatWordMgr.instance:show("已通关")

				return
			end

			if not isCanChallenge then
				FloatWordMgr.instance:show("需要通过前置关卡")

				return
			end
		end

		local isNow = self:_isFloorNow()

		if isNow and stageCfg.stageId > 1 then
			if isAllPass then
				local fmtMo = ShadowdragonclgModel.instance:getFmtMo()

				fmtMo:initParams(self._activityId, self._currSelectFloorType, stageCfg.stageId)
				fmtMo:setDefultParam()
				CustomFmtController.instance:showMissionView(fmtMo)
			else
				UIStateManager.instance:push(ViewName.ShadowdragonclgbuffView, self._activityId, stageCfg.stageId)
			end
		else
			local fmtMo = ShadowdragonclgModel.instance:getFmtMo()

			fmtMo:initParams(self._activityId, self._currSelectFloorType, stageCfg.stageId)

			if isAllPass then
				fmtMo:setDefultParam()
			end

			CustomFmtController.instance:showMissionView(fmtMo)
		end
	end)
end

function ShadowdragonclgstageView:_setFormationPets(cell, creepsMasterId)
	local creepsCfgs = ShadowdragonclgConfig.instance:getCreepsCfgs(creepsMasterId)
	local posList = {}

	for i = 1, 9 do
		local petPosCell = {}

		petPosCell.go = goutil.findChild(cell.gameObject, "formation/cell_" .. i)
		petPosCell.con = goutil.findChild(petPosCell.go, "con")
		posList[i] = petPosCell
	end

	self:_petPosReset(posList)

	for i, v in ipairs(creepsCfgs) do
		local cellCfg = creepsCfgs[i]

		if cellCfg.posId > 0 then
			GameUtil.SetActive(posList[cellCfg.posId].go, true)

			local faceId = checknumber(cellCfg.faceId) > 0 and checknumber(cellCfg.faceId) or cellCfg.raceId
			local modelCo = CharacterConfig.instance:getModelCo(faceId)

			uGuiUtil.setSpriteToImage(posList[cellCfg.posId].con, uGuiUtil.BigBg, GameUrl.getCharacterIconUrl(modelCo.headName))
		end
	end
end

function ShadowdragonclgstageView:_updateNowBottomCell(descGo, stageCfg)
	local goTablecell = goutil.findChild(descGo.gameObject, "tablecell")
	local goTableviewfeature = goutil.findChild(descGo.gameObject, "tableviewfeature")
	local goTableviewpass = goutil.findChild(descGo.gameObject, "tableviewpass")
	local emptyPass = goutil.findChild(descGo.gameObject, "emptyPass")
	local emptyFuture = goutil.findChild(descGo.gameObject, "emptyFuture")
	local info = ShadowdragonclgModel.instance:getInfo(self._activityId)
	local scrollPass = self._cellScrollList[goTableviewpass]

	if not scrollPass then
		scrollPass = ScrollerList.create(goTableviewpass, goTablecell, GameUtil.handler(self._updateBottomPetCell, self), GameUtil.handler(self._clearBottomPetCell, self))
		self._cellScrollList[goTableviewpass] = scrollPass
	end

	local scrollFeature = self._cellScrollList[goTableviewfeature]

	if not scrollFeature then
		scrollFeature = ScrollerList.create(goTableviewfeature, goTablecell, GameUtil.handler(self._updateBottomPetCell, self), GameUtil.handler(self._clearBottomPetCell, self))
		self._cellScrollList[goTableviewfeature] = scrollFeature
	end

	for i, v in ipairs(info.nowStageList) do
		if v.stageId == stageCfg.stageId then
			goutil.setActive(emptyPass, not v.dieRacePosList or #v.dieRacePosList <= 0)
			goutil.setActive(emptyFuture, not v.activeRacePosList or #v.activeRacePosList <= 0)
			scrollPass:reloadData(v.dieRacePosList)
			scrollFeature:reloadData(v.activeRacePosList)

			break
		end
	end
end

function ShadowdragonclgstageView:_updateBottomPetCell(view, cell, data, tag)
	local raceId = data.left
	local petId = BagModel.instance:getMaxZdlPetIdByRaceId(raceId)
	local petMo = BagModel.instance:getPet(petId)

	if petMo then
		local proxy = MaterialMgr.setCellByMo(petMo, cell.gameObject)

		proxy.binder:setClickCallBack(function()
			CommonTipsMgr.instance:showPetTips(petMo)
		end)
	else
		printError("找不到精灵数据 raceId:", raceId)
		MaterialMgr.setCell(MatType.Pet, data.left, cell.gameObject)
	end
end

function ShadowdragonclgstageView:_clearBottomPetCell(cell)
	MaterialMgr.resetAll(cell.gameObject)
end

function ShadowdragonclgstageView:_updatePassFutureBottomCell(descGo, stageCfg)
	local info = ShadowdragonclgModel.instance:getInfo(self._activityId)

	for i, v in ipairs(info.futurePassStageList) do
		if v.stageId == stageCfg.stageId and checknumber(v.param) <= 0 then
			goutil.setActive(descGo, false)

			return
		end
	end

	local goIcon2 = goutil.findChild(descGo.gameObject, "icon1")
	local goIcon1 = goutil.findChild(descGo.gameObject, "icon2")

	goutil.setActive(goIcon1, stageCfg.type == ShadowdragonclgController.PassFutureStageType.Pass)
	goutil.setActive(goIcon2, stageCfg.type == ShadowdragonclgController.PassFutureStageType.Future)

	local txtNum = goutil.findChildTextComponent(descGo.gameObject, "txtNum")
	local preStr = stageCfg.type == ShadowdragonclgController.PassFutureStageType.Pass and "缩影" or "回响"

	txtNum.text = string.format("%sx%s", preStr, 1)
end

function ShadowdragonclgstageView:_petPosReset(posList)
	for i = 1, #posList do
		GameUtil.SetActive(posList[i].go, false)
		uGuiUtil.clearImage(posList[i].con)
	end
end

function ShadowdragonclgstageView:_clearCell(cell)
	local descGo1 = goutil.findChild(cell.gameObject, "desc1")
	local goTableviewfeature = goutil.findChild(descGo1.gameObject, "tableviewfeature")
	local goTableviewpass = goutil.findChild(descGo1.gameObject, "tableviewpass")

	if self._cellScrollList[goTableviewpass] then
		self._cellScrollList[goTableviewpass]:dispose()
	end

	if self._cellScrollList[goTableviewfeature] then
		self._cellScrollList[goTableviewfeature]:dispose()
	end
end

function ShadowdragonclgstageView:_onClickbtnTip()
	local challengeCfg = ShadowdragonclgController.instance:getChallengeCfg()

	TipsFacade.instance:openRulesView(challengeCfg.ruleKey)
end

function ShadowdragonclgstageView:_onClickbtnClose()
	self:close()
end

function ShadowdragonclgstageView:_onReloadFinish()
	if not self._info then
		return
	end

	if self:_isFloorNow() then
		if not self._info.nowStageList then
			local stageList = self._info.futurePassStageList
			local stageList_kv = {}

			for i, v in ipairs(stageList) do
				stageList_kv[v.stageId] = v
			end

			for i, v in ipairs(stageList) do
				if not stageList_kv[v.stageId] or not stageList_kv[v.stageId].pass then
					self._scrollerList:MoveCellToBegin(i - 1)

					break
				end
			end
		end
	end
end

function ShadowdragonclgstageView:_onClickbtnSpace()
	UIStateManager.instance:push(ViewName.ShadowdragonclgspaceView, self._activityId)
end

function ShadowdragonclgstageView:_onClickbtnReset()
	local content = "确定重置？"

	TipsFacade.instance:openPopupWindow("提示", content, function()
		ShadowDragonClgAgent.instance:sendPM_ShadowDragonClgResetAllStageReq(self._activityId)
	end)
end

function ShadowdragonclgstageView:_isFloorNow()
	return self._currSelectFloorType == ShadowdragonclgController.FloorType.Now
end

function ShadowdragonclgstageView:_onResetAllStageRes()
	self._currSelectFloorType = ShadowdragonclgController.FloorType.Now

	ShadowdragonclgController.instance:setCurrFloorType(self._currSelectFloorType)
	self:_updateUI()
	self._tabscrollerList:refresh()
	self._scrollerList:refresh()
	self._scrollerList:MoveCellToBegin(0)
end

function ShadowdragonclgstageView:_getCoinNum1()
	local info = ShadowdragonclgModel.instance:getInfo(self._activityId)
	local count = 0
	local useCount = 0

	for i, v in ipairs(info.nowStageList) do
		if v.selectBuffId == ShadowdragonclgController.PassFutureStageType.Pass and v.pass then
			count = count + 1
		end
	end

	for i, v in ipairs(info.futurePassStageList) do
		local buffId = checknumber(v.param)

		if buffId > 0 then
			local stageCfg = ShadowdragonclgConfig.instance:getFuturePassStageCfg(self._activityId, v.stageId)

			if stageCfg.type == ShadowdragonclgController.PassFutureStageType.Pass then
				useCount = useCount + 1
			end
		end
	end

	local leftTime = count - useCount

	return math.max(leftTime, 0)
end

function ShadowdragonclgstageView:_getCoinNum2()
	local info = ShadowdragonclgModel.instance:getInfo(self._activityId)
	local count = 0
	local useCount = 0

	for i, v in ipairs(info.nowStageList) do
		if v.selectBuffId == ShadowdragonclgController.PassFutureStageType.Future and v.pass then
			count = count + 1
		end
	end

	for i, v in ipairs(info.futurePassStageList) do
		local buffId = checknumber(v.param)

		if buffId > 0 then
			local stageCfg = ShadowdragonclgConfig.instance:getFuturePassStageCfg(self._activityId, v.stageId)

			if stageCfg.type == ShadowdragonclgController.PassFutureStageType.Future then
				useCount = useCount + 1
			end
		end
	end

	local leftTime = count - useCount

	return math.max(leftTime, 0)
end

function ShadowdragonclgstageView:_checkShowCI()
	local ci = ShadowdragonclgController.instance:getSaveChangeSetId()

	ShadowdragonclgController.instance:saveChangeSetToTemp(0)

	if ci and ci > 0 then
		MaterialController.instance:showChangeSetInTemp(ci)
	end
end

return ShadowdragonclgstageView
