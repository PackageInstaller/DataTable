-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dragonmanclg/view/DragonManClgStageView.lua

module("logic.extensions.dragonmanclg.view.DragonManClgStageView", package.seeall)

local DragonManClgStageView = class("DragonManClgStageView", ViewComponent)

function DragonManClgStageView:ctor()
	DragonManClgStageView.super.ctor(self)
end

function DragonManClgStageView:unbindEvents()
	DragonManClgStageView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnFight)
end

function DragonManClgStageView:bindEvents()
	DragonManClgStageView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnFight, self._onClickBtnFight, self)
end

function DragonManClgStageView:buildUI()
	DragonManClgStageView.super.buildUI(self)

	self._btnClose = self:getGo("leftTop/btnClose")
	self._btnFight = self:getGo("btnFight")
	self._powerPetMo = FightingPowerPetMo.New()
	self._txtTarget = self:getTxt("txtTarget")
	self._fmtCellList = {}
	self._fmtView = self:getGo("fmt/fmtView")

	for posId = 1, self._fmtView.transform.childCount do
		local cell = {}

		cell.go = self._fmtView.transform:GetChild(posId - 1).gameObject
		cell.icon = goutil.findChild(cell.go, "icon")
		cell.mark = goutil.findChild(cell.go, "mark")
		cell.bgChagne = goutil.findChildComponent(cell.mark, "bg", "UIImageSpriteChange")
		cell.txt = goutil.findChildTextComponent(cell.mark, "txt")

		table.insert(self._fmtCellList, cell)
	end

	self._txtRule = self:getTxt("rule/Viewport/txt")
	self._passFmt = self:getGo("fmt/pass")

	local goTablecell = self:getGo("stage/cell")
	local goTableview = self:getGo("stage/tableview")

	self._tableview = ScrollerList.create(goTableview, goTablecell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
end

function DragonManClgStageView:onExit()
	DragonManClgStageView.super.onExit(self)

	for i, v in pairs(self._fmtCellList) do
		MaterialMgr.resetAll(v.icon)
	end

	self._tableview:dispose()
end

function DragonManClgStageView:onEnter()
	DragonManClgStageView.super.onEnter(self)

	self._activityId = checknumber(self:getFirstParam())

	if self._activityId == 0 then
		self._activityId = 552001
	end

	self:_updateUIByCfg()
	self:_updateUIByInfo()
	DragonManClgController.instance:getInfo(self._activityId)
	self.addGEvent(self, GlobalNotify.PM_DragonManClgInfoRes, self._updateUIByInfo, self)
end

function DragonManClgStageView:_updateUIByCfg()
	self._stageCfgs = DragonManClgConfig.instance:getStageCfgs(self._activityId) or {}
end

function DragonManClgStageView:_updateUIByInfo()
	self._curStageId = 1
	self._curMaxPassStageId = 0

	local info = DragonManClgModel.instance:getInfoByActId(self._activityId)

	if info then
		self._curMaxPassStageId = info.maxPassedStageId
	end

	self._curStageId = self._curMaxPassStageId + 1

	if self._curStageId > #self._stageCfgs then
		self._curStageId = #self._stageCfgs

		self:close()
	end

	self:_switchCurStage()
end

function DragonManClgStageView:_onClickBtnFight()
	if self._curStageId <= self._curMaxPassStageId then
		FloatWordMgr.instance:show("该关卡已通关，请选择下一关卡挑战")

		return
	end

	DragonManClgController.instance:showMissionView(self._activityId, self._curStageId)
end

function DragonManClgStageView:_switchCurStage()
	local stageCfg = self._stageCfgs[self._curStageId]

	if not stageCfg then
		return
	end

	self._txtRule.text = stageCfg.ruleDesc or ""
	self._txtTarget.text = stageCfg.targetDesc or ""

	GameUtil.setAnchoredPos(self._txtRule.gameObject, 0, 0)

	local creepsMasterId = stageCfg.creepsMasterId
	local creepCfgs = DragonManClgConfig.instance:getCreepCfgs(creepsMasterId)

	for i, v in ipairs(self._fmtCellList) do
		MaterialMgr.resetAll(v.icon)
		goutil.setActive(v.mark, false)
	end

	for i, cfg in ipairs(creepCfgs) do
		local cell = self._fmtCellList[cfg.posId]

		if cell then
			self._powerPetMo:fromChallengeCreepCo(cfg)

			local bagPetMo = self._powerPetMo:toBaseBagPetMo()
			local proxy = MaterialMgr.setCellByMo(bagPetMo, cell.icon)

			if proxy then
				proxy.binder:setAutoTips(false)
				proxy:setCallBack(function()
					CommonTipsMgr.instance:showPetTips(bagPetMo)
				end)
			end

			if cfg.buffMark and cfg.buffMark > 0 then
				local markCfg = DragonManClgConfig.instance:getMarkCfgById(self._activityId, cfg.buffMark)

				if markCfg then
					goutil.setActive(cell.mark, true)

					cell.txt.text = markCfg.eMarkDesc or ""

					cell.bgChagne:ChangeSprite(markCfg.bgPicPath)
				end
			end
		end
	end

	goutil.setActive(self._passFmt, self._curMaxPassStageId >= self._curStageId)
	goutil.setActive(self._btnFight, self._curMaxPassStageId + 1 >= self._curStageId)
	self._tableview:reloadData(self._stageCfgs)
	self._tableview:MoveCellToBegin(self._curStageId - 1)
end

function DragonManClgStageView:_updateCell(view, cell, data)
	local go = cell.gameObject
	local com = goutil.findChild(go, "com")

	if not data.pos then
		GameUtil.setAnchoredPos(com, data.pos[1], data.pos[2])

		local txtStage = goutil.findChildTextComponent(go, "com/txtStage")

		txtStage.text = string.format("第%s关", GameUtil.getChineseNumber(data.stageId or 1))

		local select = goutil.findChild(go, "com/select")

		goutil.setActive(select, self._curStageId == data.stageId)

		local pass = goutil.findChild(go, "com/pass")

		goutil.setActive(pass, self._curMaxPassStageId >= data.stageId)

		local notOpen = goutil.findChild(go, "com/notOpen")

		goutil.setActive(notOpen, self._curMaxPassStageId + 1 < data.stageId)

		local lineLeft = goutil.findChild(go, "com/lineLeft")
		local lineRight = goutil.findChild(go, "com/lineRight")
		local lineLeftRectTrans = lineLeft:GetComponent("RectTransform")
		local lineRightRectTrans = lineRight:GetComponent("RectTransform")
		local isShow = data.stageId % 2 == 0

		goutil.setActive(lineLeft, isShow)
		goutil.setActive(lineRight, isShow)

		if isShow then
			go.transform:SetAsFirstSibling()

			if not data.lineLParams then
				do
					local lineLParams = {
						0,
						0
					}

					if not data.lineRParams then
						local lineRParams = {
							0,
							0
						}

						goutil.setHeight(lineLeftRectTrans, data.lineLParams[1])
						goutil.setHeight(lineRightRectTrans, lineRParams[1])
						GameUtil.setLocalRotation(lineLeft, 0, 0, data.lineLParams[2])
						GameUtil.setLocalRotation(lineRight, 0, 0, lineRParams[2])
					end
				end

				if data.stageId == #self._stageCfgs then
					goutil.setActive(lineRight, false)
				elseif data.stageId == 1 then
					goutil.setActive(lineLeft, false)
				end
			end
		end
	end
end

function DragonManClgStageView:_clearCell(cell)
	return
end

return DragonManClgStageView
