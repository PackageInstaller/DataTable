-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinefarnas/view/DivineFarnasExtView.lua

module("logic.extensions.divinefarnas.view.DivineFarnasExtView", package.seeall)

local DivineFarnasExtView = class("DivineFarnasExtView", ViewComponent)
local BtnChallengePosXList = {
	93.4,
	35
}
local BtnChallengePosY = -267.2

function DivineFarnasExtView:ctor()
	DivineFarnasExtView.super.ctor(self)
end

function DivineFarnasExtView:unbindEvents()
	DivineFarnasExtView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnChallenge)
	GameUtil.rmClickHandler(self._btnPet)
end

function DivineFarnasExtView:bindEvents()
	DivineFarnasExtView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTip, self)
	GameUtil.addClickHandler(self._btnChallenge, self._onClickBtnChallenge, self)
	GameUtil.addClickHandler(self._btnPet, self._onClickBtnPet, self)
end

function DivineFarnasExtView:buildUI()
	DivineFarnasExtView.super.buildUI(self)

	self._btnClose = self:getGo("leftTop/btnClose")
	self._btnTip = self:getGo("leftTop/btnTip")
	self._btnPet = self:getGo("rightCol/btnPet")
	self._btnChallenge = self:getGo("rightCol/btnChallenge")
	self._txtBtnChallenge = self:getTxt("rightCol/btnChallenge/txt")
	self._Content = self:getTxt("rightCol/rule/ScrollView/Viewport/Content")
	self._txtPower = self:getTxt("rightCol/txtPower")
	self._tableview = self:getGo("rightCol/tableview")
	self._stages = self:getGo("stages")
	self._cell = self:getGo("rightCol/cell")
	self._scrollList = ScrollerList.create(self._tableview, self._cell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
end

function DivineFarnasExtView:onExit()
	DivineFarnasExtView.super.onExit(self)
	self._scrollList:dispose()
	self:_clearStageUI()
end

function DivineFarnasExtView:onEnter()
	DivineFarnasExtView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.PM_DivineFarnasClgGetInfoRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.PM_DivineFarnasClgResetRes, self._onUpdate, self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])

	if self._activityId <= 0 then
		self._activityId = 522001
	end

	local key = string.format("DivineFarnasExtView_%d", self._activityId)
	local selectStageId = GameUtil.getUserData(key, self._curSelectStageId)

	self._curSelectStageId = checknumber(selectStageId) and selectStageId or 1
	self._actCfg = DivineFarnasConfig.instance:getActCfg(self._activityId)
	self._buffCfgs = DivineFarnasConfig.instance:getBuffCfgs(self._activityId)
	self._stageCfgs = DivineFarnasConfig.instance:getExtStageCfgs(self._activityId)
	self._buffCfgs = DivineFarnasConfig.instance:getBuffCfgs(self._activityId)

	self:_onSetUI()
	DivineFarnasController.instance:sendPM_DivineFarnasClgGetInfoReq(self._activityId)
end

function DivineFarnasExtView:_onSetUI()
	self._Content.text = self._actCfg.ruleDescExt
end

function DivineFarnasExtView:_onUpdate()
	self._info = DivineFarnasModel.instance:getInfo(self._activityId)
	self._stageInfos = self._info and self._info.extremeStages

	local curStageHasPass = DivineFarnasController.instance:stageIsPass(self._activityId, self._curSelectStageId)
	local raceNum = DivineFarnasModel.instance:getTotalRaceIdNum(self._activityId)
	local activeBuffLevel = DivineFarnasController.instance:getActiveBuffCfgLevel(self._activityId)

	self._txtBtnChallenge.text = curStageHasPass and "重置\n本关" or "进入\n挑战"
	self._txtPower.text = string.format("毁灭关卡存活精灵：%d", raceNum)

	self._scrollList:reloadData(self._buffCfgs)
	self._scrollList:MoveCellToCenter(activeBuffLevel - 1)

	local isHuiMieStage = self._curSelectStageId <= #self._stageCfgs / 2
	local curIdx = BtnChallengePosXList[isHuiMieStage and 1 or 2]

	GameUtil.SetActive(self._btnPet, isHuiMieStage)
	GameUtil.setAnchoredPos(self._btnChallenge, curIdx, BtnChallengePosY)
	self:_updateStageUI()
end

function DivineFarnasExtView:_updateCell(view, cell, data)
	local curActivate = goutil.findChild(cell, "curActivate")
	local bg = goutil.findChild(cell, "bg")
	local txtDesc = goutil.findChildTextComponent(cell, "txtDesc")
	local txtScore = goutil.findChildTextComponent(cell, "txtScore")
	local extRaceCount = DivineFarnasModel.instance:getTotalRaceIdNum(self._activityId)
	local preCount = 0

	if data.buffId ~= 1 then
		local preCfg = DivineFarnasConfig.instance:getBuffCfgByBuffId(self._activityId, data.buffId - 1)

		preCount = preCfg.raceCount + 1
	end

	local curBuffCfg = DivineFarnasConfig.instance:getBuffCfgByBuffId(self._activityId, data.buffId)
	local curCount = curBuffCfg.raceCount

	txtDesc.text = data.buffDesc

	local buffCanActive = preCount <= extRaceCount and extRaceCount <= curCount

	txtScore.text = string.format("%d-%d", preCount, curCount)

	if curCount == preCount then
		txtScore.text = preCount
	end

	GameUtil.SetActive(curActivate, buffCanActive)
	GameUtil.SetActive(bg, cell.index % 2 == 0)
end

function DivineFarnasExtView:_clearCell(cell)
	return
end

function DivineFarnasExtView:_updateStageUI()
	for i, cfg in ipairs(self._stageCfgs) do
		local cellGo = goutil.findChild(self._stages, "cell" .. i)
		local imgSelect = goutil.findChild(cellGo, "imgSelect")
		local pass = goutil.findChild(cellGo, "pass")
		local pet = goutil.findChild(cellGo, "pet")
		local txtNum = goutil.findChildTextComponent(cellGo, "num/txtNum")
		local isCurStage = cfg.stageId == self._curSelectStageId
		local stageIsPass = DivineFarnasController.instance:stageIsPass(self._activityId, cfg.stageId)

		if self._stageInfos then
			if not self._stageInfos.activeRaceIds then
				local activeRaceIds = {}

				if self._stageInfos then
					if not #activeRaceIds then
						local activeRaceIdNum = DivineFarnasModel.instance:getDiffPetNum(self._activityId, cfg.stageId)
						local dodgeTimes = cfg.buffNeedCount
						local skinId = DivineFarnasConfig.instance:getFirstPetSkinId(self._activityId, cfg.stageId)

						txtNum.text = cfg.type == DivineFarnasController.EXT_TYPE_HUIMIE and string.format("精灵数量: %d", activeRaceIdNum) or string.format("闪避目标: %d", dodgeTimes)

						MaterialMgr.setIcon(pet, MatType.Pet, skinId, nil, nil)
						GameUtil.SetActive(imgSelect, isCurStage)
						GameUtil.SetActive(pass, stageIsPass)
						GameUtil.addClickHandler(cellGo, function()
							self._curSelectStageId = cfg.stageId

							local key = string.format("DivineFarnasExtView_%d", self._activityId)
							local isHuiMieStage = self._curSelectStageId <= #self._stageCfgs / 2
							local curIdx = BtnChallengePosXList[isHuiMieStage and 1 or 2]

							GameUtil.SetActive(self._btnPet, isHuiMieStage)
							GameUtil.setAnchoredPos(self._btnChallenge, curIdx, BtnChallengePosY)
							GameUtil.saveUserData(key, self._curSelectStageId)
							self:_onUpdate()
						end, self)
					end
				end
			end
		end
	end
end

function DivineFarnasExtView:_clearStageUI()
	for i, cfg in ipairs(self._stageCfgs) do
		local cellGo = goutil.findChild(self._stages, "cell" .. i)
		local pet = goutil.findChild(cellGo, "pet")

		MaterialMgr.clearIcon(pet)
		GameUtil.rmClickHandler(cellGo)
	end
end

function DivineFarnasExtView:_onClickBtnChallenge()
	if self._curSelectStageId <= 0 then
		FloatWordMgr.instance:show("请先选择关卡")

		return
	end

	local curStageHasPass = DivineFarnasController.instance:stageIsPass(self._activityId, self._curSelectStageId)

	if curStageHasPass then
		local function okFunc()
			DivineFarnasController.instance:sendPM_DivineFarnasClgResetReq(self._activityId, self._curSelectStageId)
		end

		TipsFacade.instance:openPopupWindow("提示", "是否将本关重置为未挑战", okFunc, nil, "确定", "取消")
	else
		DivineFarnasController.instance:enterBattleClgExt(self._activityId, self._curSelectStageId)
	end
end

function DivineFarnasExtView:_onClickBtnTip()
	local key = self._actCfg.ruleKeyExt

	TipsFacade.instance:openRulesView(key)
end

function DivineFarnasExtView:_onClickBtnPet()
	local curStageHasPass = DivineFarnasController.instance:stageIsPass(self._activityId, self._curSelectStageId)
	local stageNum = #self._stageCfgs

	if self._curSelectStageId > stageNum / 2 then
		FloatWordMgr.instance:show("仅毁灭关卡可查看")

		return
	end

	if not curStageHasPass then
		FloatWordMgr.instance:show("通关本关后可查看")

		return
	end

	UIStateManager.instance:push(ViewName.DivineFarnasExtUsePetView, self._activityId, self._curSelectStageId)
end

return DivineFarnasExtView
