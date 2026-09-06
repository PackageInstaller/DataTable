-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originweileita/view/OriginweileitaextstageView.lua

module("logic.extensions.originweileita.view.OriginweileitaextstageView", package.seeall)

local OriginweileitaextstageView = class("OriginweileitaextstageView", ViewComponent)

function OriginweileitaextstageView:ctor()
	OriginweileitaextstageView.super.ctor(self)

	self._scrollList = {}
end

function OriginweileitaextstageView:unbindEvents()
	OriginweileitaextstageView.super.unbindEvents(self)
	self._btnTip:RemoveClickListener()
	self._btnClose:RemoveClickListener()
end

function OriginweileitaextstageView:bindEvents()
	OriginweileitaextstageView.super.bindEvents(self)
	self._btnTip:AddClickListener(self._onClickbtnTip, self)
	self._btnClose:AddClickListener(self._onClickbtnClose, self)
end

function OriginweileitaextstageView:buildUI()
	OriginweileitaextstageView.super.buildUI(self)

	self._tableviewGo = self:getGo("tableview")
	self._tablecellGo = self:getGo("tablecell")
	self._btnTip = self:getBtn("leftTop/btnTip")
	self._btnClose = self:getBtn("leftTop/btnClose")
	self._scrollerList = ScrollerList.create(self._tableviewGo, self._tablecellGo, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))

	self._scrollerList:regReloadFinish(GameUtil.handler(self._onReloadFinish, self))
	self._scrollerList:setCenterMode(true)

	self._txtDesc = self:getTxt("rule/tableviewdesc/viewport/content")
	self._itemGo = self:getGo("rule/item/con")
	self._itemGainGo = self:getGo("rule/item/gain")
end

function OriginweileitaextstageView:onExit()
	OriginweileitaextstageView.super.onExit(self)
	self._scrollerList:dispose()
	MaterialMgr.resetAll(self._itemGo)
end

function OriginweileitaextstageView:onEnter()
	OriginweileitaextstageView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.OriginWeiLeiTaResetExtremeStageRes, self._updateUI, self)

	self._activityId = self:getFirstParam()
	self._info = OriginWeiLeiTaModel.instance:getInfo(self._activityId)
	self._actCfg = OriginWeiLeiTaConfig.instance:getActCfg(self._activityId)
	self._stageCfgs = OriginWeiLeiTaConfig.instance:getExtStageCfgs(self._activityId)

	self:_updateUI()
end

function OriginweileitaextstageView:_updateUI()
	self:_updateStageView()
end

function OriginweileitaextstageView:_updateStageView()
	self:_updateFormations()
	self:_updateRule()
	MaterialMgr.setCellByCfg(self._actCfg.extremePassPrize, self._itemGo)

	local info = OriginWeiLeiTaModel.instance:getInfo(self._activityId)

	goutil.setActive(self._itemGainGo, info.passExtreme)
end

function OriginweileitaextstageView:_updateFormations()
	self._scrollerList:reloadData(self._stageCfgs)
end

function OriginweileitaextstageView:_updateRule()
	local ruleCfg = RulesConfig.instance:getRuleCo("originweileitaextstage")

	if ruleCfg then
		self._txtDesc.text = ruleCfg.rules
	end
end

function OriginweileitaextstageView:_updateCell(view, cell, stageCfg, tag)
	local passGo = goutil.findChild(cell.gameObject, "passGo")
	local txtName = goutil.findChildTextComponent(cell.gameObject, "name/txtName")
	local btnReset = Framework.ButtonAdapter.GetFrom(cell.gameObject, "btnReset")
	local goTablecell = goutil.findChild(cell.gameObject, "tablecell")
	local goTableview = goutil.findChild(cell.gameObject, "tableview")
	local goEmpty = goutil.findChild(cell.gameObject, "empty")
	local txtBtnReset = goutil.findChildTextComponent(cell.gameObject, "btnReset/txt")
	local uiChangeBtnReset = goutil.findChild(cell.gameObject, "btnReset"):GetComponent(ComponentType.UIChangeGroup)
	local creepsMasterId = stageCfg.creepsMasterId
	local stageInfo = OriginWeiLeiTaModel.instance:getExtStageInfo(self._activityId, stageCfg.stageId)

	if stageInfo then
		if not stageInfo.lockRaceIds then
			local lockRaceIds = {}
			local isPass = #lockRaceIds > 0
			local posList = {}

			for i = 1, 9 do
				local petPosCell = {}

				petPosCell.go = goutil.findChild(cell.gameObject, "formation/cell_" .. i)
				petPosCell.con = goutil.findChild(petPosCell.go, "con")
				posList[i] = petPosCell
			end

			self:_petPosReset(posList)

			local creepsCfgs = OriginWeiLeiTaConfig.instance:getCreepsCfgs(creepsMasterId) or {}

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

			local strList = {
				[1] = "破阵，激活标记即通关"
			}

			for signId, v in ipairs(stageCfg.winScoreRequirements) do
				local signCfg = OriginWeiLeiTaConfig.instance:getSignCfg(self._activityId, signId)

				table.insert(strList, string.format(signCfg.name .. signCfg.passDesc, v))
			end

			txtName.text = table.concat(strList, "\n")

			local scroll = self:_getScroll(goTableview, goTablecell)

			scroll:reloadData(lockRaceIds)
			btnReset:AddClickListener(function()
				if not isPass then
					local fmtMo = OriginWeiLeiTaModel.instance:getExtFmtMo()

					fmtMo:initParams(self._activityId, stageCfg.stageId, creepsMasterId)
					CustomFmtController.instance:showMissionView(fmtMo)
				else
					local text = "是否将本关重置为未挑战，解除精灵封印"

					TipsFacade.instance:openPopupWindow("提示", text, function()
						OriginWeiLeiTaAgent.instance:sendPM_OriginWeiLeiTaResetExtremeStageReq(self._activityId, stageCfg.stageId)
					end)
				end
			end)
			goutil.setActive(passGo, isPass)
			goutil.setActive(goEmpty, #lockRaceIds <= 0)

			txtBtnReset.text = isPass and "重置本关" or "进入挑战"

			uiChangeBtnReset:SetState(isPass and 0 or 1)
		end
	end
end

function OriginweileitaextstageView:_onClickPetCon(creepsCfg)
	local fPowerPet = FightingPowerPetMo.New()

	fPowerPet:fromChallengeCreepCo(creepsCfg)

	local petMo = fPowerPet:toBaseBagPetMo()

	CommonTipsMgr.instance:showPetTips(petMo)
end

function OriginweileitaextstageView:_getScroll(goView, goCell)
	local scroll = self._scrollList[goView]

	if not scroll then
		scroll = ScrollerList.create(goView, goCell, GameUtil.handler(self._updatePetCell, self), GameUtil.handler(self._clearPetCell, self))

		scroll:setCenterMode(true)

		self._scrollList[goView] = scroll
	end

	return scroll
end

function OriginweileitaextstageView:_petPosReset(posList)
	for i = 1, #posList do
		GameUtil.SetActive(posList[i].go, false)
		uGuiUtil.clearImage(posList[i].con)
	end
end

function OriginweileitaextstageView:_updatePetCell(view, cell, raceId, tag)
	MaterialMgr.setCell(MatType.Pet, raceId, cell.gameObject)
end

function OriginweileitaextstageView:_clearPetCell(cell)
	MaterialMgr.resetAll(cell.gameObject)
end

function OriginweileitaextstageView:_clearCell(cell)
	local goTablecell = goutil.findChild(cell.gameObject, "tablecell")
	local goTableview = goutil.findChild(cell.gameObject, "tableview")
	local scroll = self:_getScroll(goTableview, goTablecell)

	if scroll then
		scroll:dispose()
	end
end

function OriginweileitaextstageView:_onClickbtnTip()
	local challengeCfg = OriginWeiLeiTaController.instance:getChallengeCfg()

	TipsFacade.instance:openRulesView(challengeCfg.ruleKey)
end

function OriginweileitaextstageView:_onClickbtnClose()
	self:close()
end

function OriginweileitaextstageView:_onReloadFinish()
	return
end

return OriginweileitaextstageView
