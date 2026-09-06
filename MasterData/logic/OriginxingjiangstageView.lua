-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/orixingjiang/view/OriginxingjiangstageView.lua

module("logic.extensions.orixingjiang.view.OriginxingjiangstageView", package.seeall)

local OriginxingjiangstageView = class("OriginxingjiangstageView", ViewComponent)

function OriginxingjiangstageView:ctor()
	OriginxingjiangstageView.super.ctor(self)

	self._scrollList = {}
end

function OriginxingjiangstageView:unbindEvents()
	OriginxingjiangstageView.super.unbindEvents(self)
	self._btnTip:RemoveClickListener()
	self._btnClose:RemoveClickListener()
	self._btnBuff:RemoveClickListener()
end

function OriginxingjiangstageView:bindEvents()
	OriginxingjiangstageView.super.bindEvents(self)
	self._btnTip:AddClickListener(self._onClickbtnTip, self)
	self._btnClose:AddClickListener(self._onClickbtnClose, self)
	self._btnBuff:AddClickListener(self._onClickbtnBuff, self)
end

function OriginxingjiangstageView:buildUI()
	OriginxingjiangstageView.super.buildUI(self)

	self._tableviewGo = self:getGo("tableview")
	self._tablecellGo = self:getGo("tablecell")
	self._btnTip = self:getBtn("leftTop/btnTip")
	self._btnClose = self:getBtn("leftTop/btnClose")
	self._scrollerList = ScrollerList.create(self._tableviewGo, self._tablecellGo, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))

	self._scrollerList:regReloadFinish(GameUtil.handler(self._onReloadFinish, self))
	self._scrollerList:setCenterMode(true)

	self._txtDesc = self:getTxt("rule/tableviewdesc/viewport/content")
	self._btnBuff = self:getBtn("rule/btnBuff")
	self._txtTarget = self:getTxt("rule/txtTarget")
	self._txtBuffDesc = self:getTxt("rule/tableviewbuffdesc/viewport/content")
	self._buffDescEmptyGo = self:getGo("rule/buffDescEmpty")
end

function OriginxingjiangstageView:onExit()
	OriginxingjiangstageView.super.onExit(self)
	self._scrollerList:dispose()
	MaterialMgr.resetAll(self._itemGo)
end

function OriginxingjiangstageView:onEnter()
	OriginxingjiangstageView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.OriginXingjiangResetRes, self._updateUI, self)

	self._activityId = self:getFirstParam()
	self._info = OriginWeiLeiTaModel.instance:getInfo(self._activityId)
	self._actCfg = OrixingjiangConfig.instance:getActCfg(self._activityId)
	self._stageCfgs = OrixingjiangConfig.instance:getStageCfgs(self._activityId)
	self._actCfg = OrixingjiangConfig.instance:getActCfg(self._activityId)
	self._isFirstEnter = true
	self._currClgStageId = OrixingjiangController.instance:getCurrClgStageId()

	self:_updateUI()
end

function OriginxingjiangstageView:_updateUI()
	self:_updateStageView()
	self:_updateTxts()
end

function OriginxingjiangstageView:_updateTxts()
	local stageCnt = #OrixingjiangConfig.instance:getStageCfgs(self._activityId)
	local stagePassNum = OrixingjiangModel.instance:getStagePassNum(self._activityId)
	local transmogCnt = OrixingjiangModel.instance:getTransmogCnt(self._activityId)
	local color1 = stageCnt <= stagePassNum and "green" or "red"
	local color2 = transmogCnt >= self._actCfg.passNeedAliveTransmog and "green" or "red"

	self._txtTarget.text = string.format("全部关卡通关（<color=%s>%s</color>/%s）\n累计幻化且存活精灵（<color=%s>%s</color>/%s）", color1, stagePassNum, stageCnt, color2, transmogCnt, self._actCfg.passNeedAliveTransmog)

	local num = OrixingjiangModel.instance:getAliveTransmogNum(self._activityId)
	local str, state = OrixingjiangConfig.instance:getBuffDescByAliveTransmogNum(self._activityId, num)

	self._txtBuffDesc.text = state == -1 and "" or str

	goutil.setActive(self._buffDescEmptyGo, state == -1)
end

function OriginxingjiangstageView:_updateStageView()
	self:_updateFormations()
	self:_updateRule()
end

function OriginxingjiangstageView:_updateFormations()
	self._scrollerList:reloadData(self._stageCfgs)
end

function OriginxingjiangstageView:_updateRule()
	local ruleCfg = RulesConfig.instance:getRuleCo("originxingjiangstage")

	if ruleCfg then
		self._txtDesc.text = ruleCfg.rules
	end
end

function OriginxingjiangstageView:_updateCell(view, cell, stageCfg, tag)
	local passGo = goutil.findChild(cell.gameObject, "passGo")
	local txtName = goutil.findChildTextComponent(cell.gameObject, "name/txtName")
	local btnReset = Framework.ButtonAdapter.GetFrom(cell.gameObject, "btnReset")
	local goTablecell = goutil.findChild(cell.gameObject, "tablecell")
	local goTableview = goutil.findChild(cell.gameObject, "tableview")
	local goEmpty = goutil.findChild(cell.gameObject, "empty")
	local txtBtnReset = goutil.findChildTextComponent(cell.gameObject, "btnReset/txt")
	local uiChangeBtnReset = goutil.findChild(cell.gameObject, "btnReset"):GetComponent(ComponentType.UIChangeGroup)
	local creepsMasterId = stageCfg.creepsMasterId
	local stageInfo = OrixingjiangModel.instance:getStageInfo(self._activityId, stageCfg.stageId)

	if stageInfo then
		if not stageInfo.banRaceIds then
			local banRaceIds = {}
			local isPass = stageInfo
			local posList = {}

			for i = 1, 9 do
				local petPosCell = {}

				petPosCell.go = goutil.findChild(cell.gameObject, "formation/cell_" .. i)
				petPosCell.con = goutil.findChild(petPosCell.go, "con")
				posList[i] = petPosCell
			end

			self:_petPosReset(posList)

			local creepsCfgs = OrixingjiangConfig.instance:getCreepsCfgs(creepsMasterId) or {}

			for i, v in ipairs(creepsCfgs) do
				local cellCfg = creepsCfgs[i]

				if cellCfg.posId > 0 and posList[cellCfg.posId] then
					GameUtil.SetActive(posList[cellCfg.posId].go, true)

					local faceId = checknumber(cellCfg.faceId) > 0 and checknumber(cellCfg.faceId) or cellCfg.raceId
					local modelCo = CharacterConfig.instance:getModelCo(faceId)

					if modelCo then
						uGuiUtil.setSpriteToImage(posList[cellCfg.posId].con, uGuiUtil.BigBg, GameUrl.getCharacterIconUrl(modelCo.headName))
						GameUtil.addClickHandler(posList[cellCfg.posId].con, GameUtil.handler(self._onClickPetCon, self, v))
					end
				end
			end

			txtName.text = string.format("幻化且存活：%s", #banRaceIds)

			local scroll = self:_getScroll(goTableview, goTablecell)

			scroll:reloadData(banRaceIds)
			btnReset:AddClickListener(function()
				if not isPass then
					local fmtMo = OrixingjiangModel.instance:getFmtMo()

					fmtMo:initParams(self._activityId, stageCfg.stageId, creepsMasterId)
					CustomFmtController.instance:showMissionView(fmtMo)
				else
					local text = "是否将本关重置为未挑战，解除精灵封印"

					TipsFacade.instance:openPopupWindow("提示", text, function()
						OriginXingjiangAgent.instance:sendPM_OriginXingjiangResetReq(self._activityId, stageCfg.stageId)
					end)
				end
			end)
			goutil.setActive(passGo, isPass)
			goutil.setActive(goEmpty, #banRaceIds <= 0)

			txtBtnReset.text = isPass and "重置本关" or "进入挑战"

			uiChangeBtnReset:SetState(isPass and 0 or 1)
		end
	end
end

function OriginxingjiangstageView:_onClickPetCon(creepsCfg)
	local fPowerPet = FightingPowerPetMo.New()

	fPowerPet:fromChallengeCreepCo(creepsCfg)

	local petMo = fPowerPet:toBaseBagPetMo()

	CommonTipsMgr.instance:showPetTips(petMo)
end

function OriginxingjiangstageView:_getScroll(goView, goCell)
	local scroll = self._scrollList[goView]

	if not scroll then
		scroll = ScrollerList.create(goView, goCell, GameUtil.handler(self._updatePetCell, self), GameUtil.handler(self._clearPetCell, self))

		scroll:setCenterMode(true)

		self._scrollList[goView] = scroll
	end

	return scroll
end

function OriginxingjiangstageView:_petPosReset(posList)
	for i = 1, #posList do
		GameUtil.SetActive(posList[i].go, false)
		uGuiUtil.clearImage(posList[i].con)
	end
end

function OriginxingjiangstageView:_updatePetCell(view, cell, raceId, tag)
	MaterialMgr.setCell(MatType.Pet, raceId, cell.gameObject)
end

function OriginxingjiangstageView:_clearPetCell(cell)
	MaterialMgr.resetAll(cell.gameObject)
end

function OriginxingjiangstageView:_clearCell(cell)
	local goTablecell = goutil.findChild(cell.gameObject, "tablecell")
	local goTableview = goutil.findChild(cell.gameObject, "tableview")
	local scroll = self:_getScroll(goTableview, goTablecell)

	if scroll then
		scroll:dispose()
	end
end

function OriginxingjiangstageView:_onClickbtnTip()
	local challengeCfg = OrixingjiangController.instance:getChallengeCfg()

	TipsFacade.instance:openRulesView(challengeCfg.ruleKey)
end

function OriginxingjiangstageView:_onClickbtnClose()
	self:close()
end

function OriginxingjiangstageView:_onReloadFinish()
	if self._isFirstEnter then
		self._isFirstEnter = false

		if self._currClgStageId then
			for i, v in ipairs(self._stageCfgs) do
				if v.stageId == self._currClgStageId then
					self._scrollerList:MoveCellToBegin(i - 1)

					break
				end
			end
		end
	end
end

function OriginxingjiangstageView:_onClickbtnBuff()
	UIStateManager.instance:push(ViewName.OriginxingjiangbufftipView, self._activityId)
end

return OriginxingjiangstageView
