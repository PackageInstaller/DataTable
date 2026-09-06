-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinewatertianyan/view/DivinewatertianyanstageView.lua

module("logic.extensions.divinewatertianyan.view.DivinewatertianyanstageView", package.seeall)

local DivinewatertianyanstageView = class("DivinewatertianyanstageView", ViewComponent)

function DivinewatertianyanstageView:ctor()
	DivinewatertianyanstageView.super.ctor(self)
end

function DivinewatertianyanstageView:unbindEvents()
	DivinewatertianyanstageView.super.unbindEvents(self)
	self._btnTip:RemoveClickListener()
	self._btnClose:RemoveClickListener()
	self._btnProtocal:RemoveClickListener()
end

function DivinewatertianyanstageView:bindEvents()
	DivinewatertianyanstageView.super.bindEvents(self)
	self._btnTip:AddClickListener(self._onClickbtnTip, self)
	self._btnClose:AddClickListener(self._onClickbtnClose, self)
	self._btnProtocal:AddClickListener(self._onClickbtnProtocal, self)
end

function DivinewatertianyanstageView:buildUI()
	DivinewatertianyanstageView.super.buildUI(self)

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
	self._btnProtocal = self:getBtn("btnProtocal")
end

function DivinewatertianyanstageView:onExit()
	DivinewatertianyanstageView.super.onExit(self)
	self._tabscrollerList:dispose()
	self._scrollerList:dispose()
end

function DivinewatertianyanstageView:onEnter()
	DivinewatertianyanstageView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.DivineWaterTianYanClgGetInfoRes, self._updateUI, self)

	self._activityId = self:getFirstParam()
	self._isFirstEnter = true

	local var_6_0 = self._stageType

	if not self._stageType then
		var_6_0 = DivinewatertianyanModel.instance:getCurrStageType()
		var_6_0 = var_6_0 or DivinewatertianyanController.StageType.Fire
	end

	self._stageType = var_6_0
	self._totalStageCfgs = DivinewatertianyanConfig.instance:getStageCfgs(self._activityId)
	self._tabCfgs = DivinewatertianyanConfig.instance:getTabCfgs(self._activityId)

	self:_updateUI()
	self:_updateTabs()
end

function DivinewatertianyanstageView:_updateUI()
	self._info = DivinewatertianyanModel.instance:getInfo(self._activityId)
	self._txtOpenTime.text = TimeGateController.instance:getActTimeShow(self._activityId)

	self:_onClickTabBtn(self._stageType)
end

function DivinewatertianyanstageView:_updateTabs()
	self._tabscrollerList:reloadData(self._tabCfgs)
end

function DivinewatertianyanstageView:_updateStageView()
	self:_updateFormations()
	self:_updateRule()
	goutil.setActive(self._btnProtocal.gameObject, self._stageType == DivinewatertianyanController.StageType.Water)
end

function DivinewatertianyanstageView:_updateFormations()
	self._stageCfgs = {}

	for i, v in ipairs(self._totalStageCfgs) do
		if v.stageType == self._stageType then
			table.insert(self._stageCfgs, v)
		end
	end

	self._stageTypePass = DivinewatertianyanModel.instance:isStageTypePass(self._activityId, self._stageType)

	self._scrollerList:reloadData(self._stageCfgs)
end

function DivinewatertianyanstageView:_updateRule()
	local cfg = DivinewatertianyanConfig.instance:getTabCfg(self._activityId, self._stageType)

	self._txtDesc.text = cfg.ruleDesc
end

function DivinewatertianyanstageView:_updateTabCell(view, cell, cfg, tag)
	local btn = Framework.ButtonAdapter.Get(goutil.findChild(cell.gameObject, "btn"))
	local selectChange = goutil.findChild(cell.gameObject, "btn/select"):GetComponent(ComponentType.UIImageSpriteChange)
	local txtName = goutil.findChildTextComponent(cell.gameObject, "btn/txtName")
	local passGo = goutil.findChild(cell.gameObject, "btn/passGo")
	local isCurr = cfg.stageType == self._stageType

	goutil.setActive(selectChange.gameObject, isCurr)

	txtName.text = cfg.tabName

	selectChange:SetState(cfg.stageType == DivinewatertianyanController.StageType.Water and 1 or 0)
	btn:AddClickListener(function()
		self:_onClickTabBtn(cfg.stageType)
	end)

	local floorIsPass = DivinewatertianyanModel.instance:isStageTypePass(self._activityId, cfg.stageType)

	goutil.setActive(passGo, floorIsPass)
end

function DivinewatertianyanstageView:_onClickTabBtn(stageType)
	DivinewatertianyanModel.instance:setCurrStageType(stageType)

	self._stageType = stageType

	self._tabscrollerList:refresh()
	self:_updateStageView()
end

function DivinewatertianyanstageView:_clearTabCell(cell)
	return
end

function DivinewatertianyanstageView:_updateCell(view, cell, stageCfg, tag)
	local btn = Framework.ButtonAdapter.GetFrom(cell.gameObject, "btn")
	local passGo = goutil.findChild(cell.gameObject, "passGo")
	local txtName = goutil.findChildTextComponent(cell.gameObject, "name/txtName")
	local txtDesc = goutil.findChildTextComponent(cell.gameObject, "desc/txtDesc")
	local descGo = goutil.findChild(cell.gameObject, "desc")
	local imgGo = goutil.findChild(cell.gameObject, "desc/img")
	local selectChange = goutil.findChild(cell.gameObject, "select"):GetComponent(ComponentType.UIImageSpriteChange)
	local txtOpenTime = goutil.findChildTextComponent(cell.gameObject, "lock/txtOpenTime")
	local lockGo = goutil.findChild(cell.gameObject, "lock")
	local goItemcon = goutil.findChild(cell.gameObject, "itemcon")
	local layout = goItemcon:GetComponent(ComponentType.UILayoutSingleLine)
	local posList = {}

	for i = 1, 9 do
		local petPosCell = {}

		petPosCell.go = goutil.findChild(cell.gameObject, "formation/cell_" .. i)
		petPosCell.con = goutil.findChild(petPosCell.go, "con")
		posList[i] = petPosCell
	end

	local isPrePass = stageCfg.sortedStageId <= 1 or DivinewatertianyanModel.instance:isStagePass(self._activityId, stageCfg.stageId - 1)
	local isPass = DivinewatertianyanModel.instance:isStagePass(self._activityId, stageCfg.stageId)
	local isSelect = isPrePass and not isPass

	if stageCfg.stageType ~= DivinewatertianyanController.StageType.Fire or not isPass then
		::label_16_0::

		local var_16_0 = self._stageTypePass

		if not self._stageTypePass and isPrePass then
			::label_16_1::

			local isCanChallenge = not isPass
			local openTime = stageCfg.openTime
			local isLock = not string.nilorempty(openTime) and GameUtil.string2time(openTime) > ServerTime.now()

			if isLock then
				local date = GameUtil.string2date(openTime)

				txtOpenTime.text = string.format("开启时间：%s月%s日%s点", date.month, date.day, date.hour)
			end

			self:_petPosReset(posList)

			local creepsCfgs = DivinewatertianyanConfig.instance:getCreepsCfgs(stageCfg.creepsMasterId)

			for i, v in ipairs(creepsCfgs) do
				local cellCfg = creepsCfgs[i]

				if cellCfg.posId > 0 then
					GameUtil.SetActive(posList[cellCfg.posId].go, true)

					local faceId = checknumber(cellCfg.faceId) > 0 and checknumber(cellCfg.faceId) or cellCfg.raceId
					local modelCo = CharacterConfig.instance:getModelCo(faceId)

					uGuiUtil.setSpriteToImage(posList[cellCfg.posId].con, uGuiUtil.BigBg, GameUrl.getCharacterIconUrl(modelCo.headName))
				end
			end

			btn:AddClickListener(function()
				if isLock then
					FloatWordMgr.instance:show(txtOpenTime.text)

					return
				end

				if not isCanChallenge then
					if not isPrePass then
						FloatWordMgr.instance:show("需要通过前置关卡")

						return
					end

					FloatWordMgr.instance:show("已通关")

					return
				end

				local fmtMo = DivinewatertianyanModel.instance:getFmtMo()

				fmtMo:initParams(self._activityId, stageCfg.stageId, stageCfg.stageId)
				CustomFmtController.instance:showMissionView(fmtMo)
			end)

			local isShowDown = false

			if stageCfg.stageType == DivinewatertianyanController.StageType.Water then
				txtDesc.text = string.format("目标破盾次数：%s", stageCfg.passNeedValue)
				isShowDown = true
			else
				isShowDown = not isLock

				if DivinewatertianyanModel.instance:isStagePass(self._activityId, stageCfg.stageId) then
					local value = DivinewatertianyanModel.instance:getStageSaveValue(self._activityId, stageCfg.stageId)

					txtDesc.text = string.format("余焰数量：        x%s", value)
				else
					txtDesc.text = "余焰数量：        暂无"
				end
			end

			txtName.text = string.format("%s领域-%s", stageCfg.stageType == DivinewatertianyanController.StageType.Fire and "火" or "水", stageCfg.sortedStageId)

			goutil.setActive(lockGo, isLock)
			goutil.setActive(descGo, isShowDown)
			goutil.setActive(selectChange.gameObject, isSelect)
			goutil.setActive(imgGo, stageCfg.stageType == DivinewatertianyanController.StageType.Fire)
			goutil.setActive(passGo, isPass)
			selectChange:SetState(stageCfg.stageType == DivinewatertianyanController.StageType.Fire and 0 or 1)
			MaterialMgr.setCellListByCfg(stageCfg.prize, goItemcon, urlOrGo, luaCls, isOne)
			layout:Layout()
		end
	end
end

function DivinewatertianyanstageView:_petPosReset(posList)
	for i = 1, #posList do
		GameUtil.SetActive(posList[i].go, false)
		uGuiUtil.clearImage(posList[i].con)
	end
end

function DivinewatertianyanstageView:_clearCell(cell)
	return
end

function DivinewatertianyanstageView:_onClickbtnTip()
	local challengeCfg = DivinewatertianyanController.instance:getChallengeCfg()

	TipsFacade.instance:openRulesView(challengeCfg.ruleKey)
end

function DivinewatertianyanstageView:_onClickbtnClose()
	DivinewatertianyanModel.instance:setCurrStageType(nil)
	self:close()
end

function DivinewatertianyanstageView:_onReloadFinish()
	local stageList_kv = {}

	for i, v in ipairs(self._info.stageList) do
		stageList_kv[v.stageId] = v
	end

	for i, v in ipairs(self._stageCfgs) do
		if not stageList_kv[v.stageId] or not stageList_kv[v.stageId].isPass then
			self._scrollerList:MoveCellToBegin(i - 1)

			break
		end
	end
end

function DivinewatertianyanstageView:_onClickbtnProtocal()
	UIStateManager.instance:push(ViewName.DivinewatertianyanprotocolView, self._activityId)
end

return DivinewatertianyanstageView
