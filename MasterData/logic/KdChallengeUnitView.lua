-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/kingdragonchallenge/view/KdChallengeUnitView.lua

module("logic.extensions.kingdragonchallenge.view.KdChallengeUnitView", package.seeall)

local KdChallengeUnitView = class("KdChallengeUnitView", ViewComponent)

function KdChallengeUnitView:buildUI()
	KdChallengeUnitView.super.buildUI(self)

	self._btnClose = goutil.findChild(self.mainGO, "leftTop/btnClose")
	self._btnTip = goutil.findChild(self.mainGO, "leftTop/btnTip")
	self._txtTitle = goutil.findChildTextComponent(self.mainGO, "leftTop/txtTitle")
	self._partCol = goutil.findChild(self.mainGO, "partCol")
	self._partView = goutil.findChild(self.mainGO, "partCol/partView")
	self._partCell = goutil.findChild(self.mainGO, "partCol/partCell")
	self._infoCol = goutil.findChild(self.mainGO, "infoCol")
	self._txtInfoTitle = goutil.findChildTextComponent(self.mainGO, "infoCol/txtTitle")
	self._txtBuffDesc = goutil.findChildTextComponent(self.mainGO, "infoCol/buffCol/descScrollerview/Viewport/txtBuffDesc")
	self._txtDeBuffDesc = goutil.findChildTextComponent(self.mainGO, "infoCol/debuffCol/txtDeBuffDesc")
	self._enemyScrollerview = goutil.findChild(self.mainGO, "infoCol/enemyCol/enemyScrollerview")
	self._enemyScrollercell = goutil.findChild(self.mainGO, "infoCol/enemyCol/enemyScrollercell")
	self._txtReward = goutil.findChildTextComponent(self.mainGO, "infoCol/rewardCol/txtReward")
	self._btnChallenge = goutil.findChild(self.mainGO, "infoCol/btnChallenge")
	self._pass = goutil.findChild(self.mainGO, "infoCol/pass")
	self._goldBarCon = goutil.findChild(self.mainGO, "goldBarCon")
	self._btnReset = goutil.findChild(self.mainGO, "btnReset")
	self._effRoot = goutil.findChild(self.mainGO, "effRoot")
	self._txtRemain = goutil.findChildTextComponent(self.mainGO, "remain/txt")

	GameUtil.SetActive(self._partCell, false)

	self._enemyScrollList = ScrollerList.create(self._enemyScrollerview, self._enemyScrollercell, GameUtil.handler(self._updateEnemyCell, self), GameUtil.handler(self._clearEnemyCell, self))
end

function KdChallengeUnitView:bindEvents()
	KdChallengeUnitView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTip, self)
	GameUtil.addClickHandler(self._btnChallenge, self._onClickBtnChallenge, self)
	GameUtil.addClickHandler(self._btnReset, self._onClickBtnReset, self)
end

function KdChallengeUnitView:unbindEvents()
	KdChallengeUnitView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnChallenge)
	GameUtil.rmClickHandler(self._btnReset)
end

function KdChallengeUnitView:onEnter()
	KdChallengeUnitView.super.onEnter(self)

	self._challengeId = KdChallengeConfig.instance:getKdCurChallengeId()

	self:_onSetUI()
	GlobalDispatcher:addListener(GlobalNotify.KDChallengeGetInfoRes, self._onUpdate, self)
	GlobalDispatcher:addListener(GlobalNotify.KDChallengeUnitUnitResetRes, self._onUpdate, self)
	GlobalDispatcher:addListener(GlobalNotify.KDChallengeResultConfirmRes, self._onUpdate, self)
	KdChallengeController.instance:sendPM_TQKingDragonGetInfoReq(self._challengeId)

	local redId = RedPointModel.ID_KINGDRAGON_LANDINGONCE_RED_UNIT

	KdChallengeController.instance:saveRedAsLandingOnce(redId, true)
end

function KdChallengeUnitView:onExit()
	KdChallengeUnitView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.KDChallengeGetInfoRes, self._onUpdate, self)
	GlobalDispatcher:removeListener(GlobalNotify.KDChallengeUnitUnitResetRes, self._onUpdate, self)
	GlobalDispatcher:removeListener(GlobalNotify.KDChallengeResultConfirmRes, self._onUpdate, self)

	if self._bgEff then
		UIEffectManager.instance:stopEffect(self._bgEff)

		self._bgEff = nil
	end
end

function KdChallengeUnitView:_onSetUI()
	local itemsStr = KdChallengeConfig.instance:getKdShowResource()

	if not string.nilorempty(itemsStr) then
		local itemsStrArray = string.split(itemsStr, "#")
		local list = {}

		for _, itemStr in ipairs(itemsStrArray) do
			t = {
				showAdd = true,
				id = itemStr
			}

			table.insert(list, t)
		end

		MainUIController.instance:showGlodBar(self._goldBarCon, self._viewPresentor, list)
	end

	local effParent = self._effRoot
	local pathName = "20220902/wzsltiaozhan/fx_ui_wzsl_guang"

	UIEffectManager.instance:stopEffect(self._bgEff)

	if effParent and not string.nilorempty(pathName) then
		local path = pathName .. ".prefab"

		local function finishHandler(handlerTarget, eff)
			return
		end

		local function loadedHandler(handlerTarget, eff)
			eff:setParent(effParent.transform)
			eff:setLocalPos(0, 0, 0)
			eff:setScale(1, 1, 1)

			eff.hideEffWhileNotOnTop = true
		end

		local handlerTarget

		self._bgEff = UIEffectManager.instance:playEffect(self, path, effParent, 0, 0, true, false, finishHandler, loadedHandler, handlerTarget)
	end
end

function KdChallengeUnitView:_onUpdate()
	self:_onUpdateCurUnitId()
	self:_onUpdateData()
	self:_onUpdateUI()
end

function KdChallengeUnitView:_onUpdateData()
	self:_onUpdatePartColData()
	self:_onUpdateInfoColData()
end

function KdChallengeUnitView:_onUpdateUI()
	self:_onUpdatePlaneUI()
	self:_onUpdatePartColUI()
	self:_onUpdateInfoColUI()
end

function KdChallengeUnitView:_onUpdatePlaneUI()
	local isPassAll = KdChallengeController.instance:isPassAllUnitAsUnit()

	GameUtil.SetActive(self._btnReset, not isPassAll)
end

function KdChallengeUnitView:_onUpdateCurUnitId()
	self._curUnitId = checknumber(self._curUnitId)

	if self._curUnitId ~= 0 and not KdChallengeModel.instance:isPassUnitAsUnit(self._curUnitId) then
		return
	end

	local curUnitId = 0
	local unitCfg = KdChallengeConfig.instance:getKdUnitCfgByCId(self._challengeId)

	for _, data in ipairs(unitCfg) do
		if not KdChallengeModel.instance:isPassUnitAsUnit(data.unitId) then
			curUnitId = data.unitId

			break
		end
	end

	self._curUnitId = curUnitId
end

function KdChallengeUnitView:_onUpdatePartColData()
	local infoList = {}
	local unitCfg = KdChallengeConfig.instance:getKdUnitCfgByCId(self._challengeId)

	for _, data in ipairs(unitCfg) do
		infoList[data.unitId] = {
			data = data,
			unitRecord = KdChallengeModel.instance:getRecordAsUnit(data.unitId),
			congBuffId = KdChallengeController.instance:getCongBuffIdAsUnit(data.unitId),
			acqBuffIdList = KdChallengeController.instance:getAcqBuffIdListAsUnit(data.unitId)
		}
	end

	self._partInfoList = infoList
end

function KdChallengeUnitView:_getCurPartInfo()
	return self._partInfoList[self._curUnitId]
end

function KdChallengeUnitView:_onUpdatePartColUI()
	local parentTran = self._partView.transform
	local children = GameUtil.getChildren(parentTran)

	for index, info in ipairs(self._partInfoList) do
		if not children[index] then
			local mainGo = goutil.cloneAndSetParent(self._partCell, parentTran)

			self:_updatePartCell(children[index], info)
		end
	end

	for idx = 1, parentTran.childCount do
		local mainGo = parentTran:GetChild(idx - 1)

		GameUtil.SetActive(mainGo, idx <= #self._partInfoList)
	end
end

function KdChallengeUnitView:_onClearPartCol()
	local parentTran = self._partView.transform
	local children = GameUtil.getChildren(parentTran)

	for _, mainGo in pairs(children) do
		GameUtil.rmClickHandler(mainGo)
	end
end

function KdChallengeUnitView:_updatePartCell(mainGo, info)
	local data = info.data
	local unitRecord = info.unitRecord
	local acqBuffIdList = info.acqBuffIdList
	local pass = goutil.findChild(mainGo, "pass")
	local selectGo = goutil.findChild(mainGo, "selectGo")
	local txtPartName = goutil.findChildTextComponent(mainGo, "txtPartName")
	local tagGo = goutil.findChild(mainGo, "tag")
	local txtTag = goutil.findChildTextComponent(mainGo, "tag/txt")

	mainGo.name = "partCell_" .. data.unitId

	GameUtil.setLocalPos(mainGo, data.partPos[1] or 0, data.partPos[2] or 0, 0)

	txtPartName.text = data.partName

	GameUtil.SetActive(pass, unitRecord.pass == true)
	GameUtil.SetActive(selectGo, self._curUnitId == data.unitId)
	GameUtil.SetActive(tagGo, not unitRecord.pass and not (#acqBuffIdList <= 0))

	txtTag.text = KdChallengeController.instance:getbuffNumAsUnit(data.unitId)

	GameUtil.addClickHandler(mainGo, GameUtil.handler(self._onClickPartCell, self, info))
end

function KdChallengeUnitView:_onClickPartCell(info)
	self._curUnitId = self._curUnitId == info.data.unitId and 0 or info.data.unitId

	self:_onUpdateUI()
end

function KdChallengeUnitView:_onUpdateInfoColData()
	return
end

function KdChallengeUnitView:_onUpdateInfoColUI()
	local info = self:_getCurPartInfo()

	GameUtil.SetActive(self._infoCol, info ~= nil)

	if info == nil then
		return
	end

	local data = info.data
	local unitRecord = info.unitRecord
	local congBuffId = info.congBuffId
	local acqBuffIdList = info.acqBuffIdList

	self._txtInfoTitle.text = data.partName

	local buffIdList = {}

	table.insert(buffIdList, congBuffId)

	for _, buffId in ipairs(acqBuffIdList) do
		table.insert(buffIdList, buffId)
	end

	local buffStr = ""

	for index, buffId in ipairs(buffIdList) do
		local buffData = KdChallengeConfig.instance:getKdBuffData(buffId)

		buffStr = index == 1 and buffStr .. string.format("%d.%s\n", index, buffData.des) or buffStr .. string.format("<color=#8FF6CBFF>%d.%s</color>\n", index, buffData.des)
	end

	self._txtBuffDesc.text = buffStr

	local deBuffData = KdChallengeConfig.instance:getKdBuffData(data.deBuffId)

	self._txtDeBuffDesc.text = deBuffData.des

	local creepsCfg = KdChallengeConfig.instance:getKdChallengeCreepsCfg(data.creepsMasterId)

	self._enemyScrollList:reloadData(creepsCfg)
	self._enemyScrollList:MoveCellInView(0, true)

	local matType, matId, matNum = MaterialMgr.getMatParams(data.prize)
	local matName = MaterialMgr.getMaterialsName(matType, matId)

	self._txtReward.text = string.format("%sx%d", matName, matNum)

	GameUtil.SetActive(self._pass, unitRecord.pass == true)
	GameUtil.SetActive(self._btnChallenge, unitRecord.pass ~= true)
end

function KdChallengeUnitView:_updateEnemyCell(view, cell, data, tag)
	local mainGo = cell.gameObject
	local skinId = checknumber(data.faceId)

	if skinId == 0 then
		skinId = data.raceId
	end

	local proxy = MaterialMgr.setCell(MatType.Pet, skinId, mainGo)

	if proxy then
		proxy.binder:setClickCallBack(nil)
	end
end

function KdChallengeUnitView:_clearEnemyCell(cell, tag)
	local mainGo = cell.gameObject

	MaterialMgr.resetAll(mainGo)
end

function KdChallengeUnitView:_onClickBtnTip()
	TipsFacade.instance:openRulesView("KingofTheDragon_rule_3")
end

function KdChallengeUnitView:_onClickBtnChallenge()
	local info = self:_getCurPartInfo()

	if info.pass == true then
		FloatWordMgr.instance:show("已通关")

		return
	end

	KdChallengeModel.instance:clearViewInfos()

	local tlData = TimeLimitedConfig.instance:getCfgById(self._challengeId)

	KdChallengeModel.instance:addViewInfo(tlData.viewName)
	KdChallengeModel.instance:addViewInfo(self._viewPresentor.viewName)
	KdChallengeController.instance:enterBattleAsKd(GameEnum.KingDragonType.Unit, info.data.unitId)
end

function KdChallengeUnitView:_onClickBtnReset()
	local tipsContent = "重置关卡则将挑战进度、精灵状态一同重置，是否确认重置关卡？"

	local function okFunc()
		KdChallengeController.instance:sendPM_TQKingDragonUnitResetReq(self._challengeId)
	end

	local function cencelFunc()
		return
	end

	TipsFacade.instance:openPopupWindow("提示", tipsContent, okFunc, cencelFunc, "确定", "取消")
end

return KdChallengeUnitView
