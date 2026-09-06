-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originaresmom/view/OriginaresmomextstageView.lua

module("logic.extensions.originaresmom.view.OriginaresmomextstageView", package.seeall)

local OriginaresmomextstageView = class("OriginaresmomextstageView", ViewComponent)

function OriginaresmomextstageView:ctor()
	OriginaresmomextstageView.super.ctor(self)

	self._scrollList = {}
end

function OriginaresmomextstageView:unbindEvents()
	OriginaresmomextstageView.super.unbindEvents(self)
	self._btnTip:RemoveClickListener()
	self._btnClose:RemoveClickListener()
	self._btnBuff:RemoveClickListener()
end

function OriginaresmomextstageView:bindEvents()
	OriginaresmomextstageView.super.bindEvents(self)
	self._btnTip:AddClickListener(self._onClickbtnTip, self)
	self._btnClose:AddClickListener(self._onClickbtnClose, self)
	self._btnBuff:AddClickListener(self._onClickbtnBuff, self)
end

function OriginaresmomextstageView:buildUI()
	OriginaresmomextstageView.super.buildUI(self)

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
	self._txtBuffDesc = self:getTxt("rule/txtBuffDesc")
end

function OriginaresmomextstageView:onExit()
	OriginaresmomextstageView.super.onExit(self)
	self._scrollerList:dispose()
end

function OriginaresmomextstageView:onEnter()
	OriginaresmomextstageView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.OriginAresMomClgResetExtremeStageRes, self._updateUI, self)

	self._activityId = self:getFirstParam()
	self._info = OriginaresmomModel.instance:getInfo(self._activityId)
	self._isFirstEnter = true
	self._actCfg = OriginaresmomConfig.instance:getActCfg(self._activityId)
	self._stageCfgs = OriginaresmomConfig.instance:getExtStageCfgs(self._activityId)
	self._extremePassed = self._info.extremePassed

	self:_updateUI()
end

function OriginaresmomextstageView:_updateUI()
	self:_updateStageView()
	self:_updateScore()
end

function OriginaresmomextstageView:_updateScore()
	local actCfg = OriginaresmomConfig.instance:getActCfg(self._activityId)
	local score = OriginaresmomModel.instance:getExtStageTotalScore(self._activityId)
	local color = score >= actCfg.extremePassEnergy and "green" or "red"

	self._txtTarget.text = string.format("生命之树能量：<color=%s>%s</color>/%s", color, score, actCfg.extremePassEnergy)
	self._txtBuffDesc.text = OriginaresmomConfig.instance:getBuffDescByScore(self._activityId, score)
end

function OriginaresmomextstageView:_updateStageView()
	self:_updateFormations()
	self:_updateRule()
end

function OriginaresmomextstageView:_updateFormations()
	self._scrollerList:reloadData(self._stageCfgs)
end

function OriginaresmomextstageView:_updateRule()
	local ruleCfg = RulesConfig.instance:getRuleCo("originaresmomextstage")

	self._txtDesc.text = ruleCfg.rules
end

function OriginaresmomextstageView:_updateCell(view, cell, stageCfg, tag)
	local passGo = goutil.findChild(cell.gameObject, "passGo")
	local txtName = goutil.findChildTextComponent(cell.gameObject, "name/txtName")
	local btnReset = Framework.ButtonAdapter.GetFrom(cell.gameObject, "btnReset")
	local goTablecell = goutil.findChild(cell.gameObject, "tablecell")
	local goTableview = goutil.findChild(cell.gameObject, "tableview")
	local goEmpty = goutil.findChild(cell.gameObject, "empty")
	local txtBtnReset = goutil.findChildTextComponent(cell.gameObject, "btnReset/txt")
	local uiChangeBtnReset = goutil.findChild(cell.gameObject, "btnReset"):GetComponent(ComponentType.UIChangeGroup)
	local creepsMasterId = stageCfg.creepsMasterId
	local stageInfo = OriginaresmomModel.instance:getExtStageInfo(self._activityId, stageCfg.stageId)

	if stageInfo then
		if not stageInfo.lockRaceIds then
			local lockRaceIds = {}
			local isPass = #lockRaceIds > 0

			if stageInfo then
				if not (stageInfo.score * self._actCfg.buffEnergy) then
					local energy = 0
					local posList = {}

					for i = 1, 9 do
						local petPosCell = {}

						petPosCell.go = goutil.findChild(cell.gameObject, "formation/cell_" .. i)
						petPosCell.con = goutil.findChild(petPosCell.go, "con")
						posList[i] = petPosCell
					end

					self:_petPosReset(posList)

					local creepsCfgs = OriginaresmomConfig.instance:getCreepsCfgs(creepsMasterId)

					for i, v in ipairs(creepsCfgs) do
						local cellCfg = creepsCfgs[i]

						if cellCfg.posId > 0 then
							GameUtil.SetActive(posList[cellCfg.posId].go, true)

							local faceId = checknumber(cellCfg.faceId) > 0 and checknumber(cellCfg.faceId) or cellCfg.raceId
							local modelCo = CharacterConfig.instance:getModelCo(faceId)

							uGuiUtil.setSpriteToImage(posList[cellCfg.posId].con, uGuiUtil.BigBg, GameUrl.getCharacterIconUrl(modelCo.headName))
							GameUtil.addClickHandler(posList[cellCfg.posId].con, GameUtil.handler(self._onClickPetCon, self, v))
						end
					end

					txtName.text = string.format("生命之树能量：%s", energy)

					local scroll = self:_getScroll(goTableview, goTablecell)

					scroll:reloadData(lockRaceIds)
					btnReset:AddClickListener(function()
						if not isPass then
							local fmtMo = OriginaresmomModel.instance:getExtFmtMo()

							fmtMo:initParams(self._activityId, stageCfg.stageId, creepsMasterId)
							CustomFmtController.instance:showMissionView(fmtMo)
						else
							local text = "是否将本关重置为未挑战，清空能量，解除精灵封印"

							TipsFacade.instance:openPopupWindow("提示", text, function()
								OriginAresMomClgAgent.instance:sendPM_OriginAresMomClgResetExtremeStageReq(self._activityId, stageCfg.stageId)
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
	end
end

function OriginaresmomextstageView:_onClickPetCon(creepsCfg)
	local fPowerPet = FightingPowerPetMo.New()

	fPowerPet:fromChallengeCreepCo(creepsCfg)

	local petMo = fPowerPet:toBaseBagPetMo()

	CommonTipsMgr.instance:showPetTips(petMo)
end

function OriginaresmomextstageView:_getScroll(goView, goCell)
	local scroll = self._scrollList[goView]

	if not scroll then
		scroll = ScrollerList.create(goView, goCell, GameUtil.handler(self._updatePetCell, self), GameUtil.handler(self._clearPetCell, self))

		scroll:setCenterMode(true)

		self._scrollList[goView] = scroll
	end

	return scroll
end

function OriginaresmomextstageView:_petPosReset(posList)
	for i = 1, #posList do
		GameUtil.SetActive(posList[i].go, false)
		uGuiUtil.clearImage(posList[i].con)
	end
end

function OriginaresmomextstageView:_updatePetCell(view, cell, raceId, tag)
	MaterialMgr.setCell(MatType.Pet, raceId, cell.gameObject)
end

function OriginaresmomextstageView:_clearPetCell(cell)
	MaterialMgr.resetAll(cell.gameObject)
end

function OriginaresmomextstageView:_clearCell(cell)
	local goTablecell = goutil.findChild(cell.gameObject, "tablecell")
	local goTableview = goutil.findChild(cell.gameObject, "tableview")
	local scroll = self:_getScroll(goTableview, goTablecell)

	scroll:dispose()
end

function OriginaresmomextstageView:_onClickbtnTip()
	local challengeCfg = OriginaresmomController.instance:getChallengeCfg()

	TipsFacade.instance:openRulesView(challengeCfg.ruleKey)
end

function OriginaresmomextstageView:_onClickbtnClose()
	DivinewatertianyanModel.instance:setCurrStageType(nil)
	self:close()
end

function OriginaresmomextstageView:_onReloadFinish()
	return
end

function OriginaresmomextstageView:_onClickbtnBuff()
	UIStateManager.instance:push(ViewName.OriginaresmombufftipView, self._activityId)
end

return OriginaresmomextstageView
