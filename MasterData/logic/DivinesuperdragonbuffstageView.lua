-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinesuperdragon/view/DivinesuperdragonbuffstageView.lua

module("logic.extensions.divinesuperdragon.view.DivinesuperdragonbuffstageView", package.seeall)

local DivinesuperdragonbuffstageView = class("DivinesuperdragonbuffstageView", ViewComponent)

function DivinesuperdragonbuffstageView:ctor()
	DivinesuperdragonbuffstageView.super.ctor(self)
end

function DivinesuperdragonbuffstageView:unbindEvents()
	DivinesuperdragonbuffstageView.super.unbindEvents(self)
	self._btnTip:RemoveClickListener()
	self._btnClose:RemoveClickListener()
end

function DivinesuperdragonbuffstageView:bindEvents()
	DivinesuperdragonbuffstageView.super.bindEvents(self)
	self._btnTip:AddClickListener(self._onClickbtnTip, self)
	self._btnClose:AddClickListener(self._onClickbtnClose, self)
end

function DivinesuperdragonbuffstageView:buildUI()
	DivinesuperdragonbuffstageView.super.buildUI(self)

	self._tableviewGo = self:getGo("tableview")
	self._tablecellGo = self:getGo("tablecell")
	self._scrollerList = ScrollerList.create(self._tableviewGo, self._tablecellGo, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._btnTip = self:getBtn("leftTop/btnTip")
	self._btnClose = self:getBtn("leftTop/btnClose")
	self._txtTip = self:getTxt("tipsCol/txt")
	self._txtTimeGo = self:getGo("txtTime")
	self._txtTime = goutil.findChildTextComponent(self.mainGO, "txtTime/txt")
end

function DivinesuperdragonbuffstageView:onExit()
	DivinesuperdragonbuffstageView.super.onExit(self)
	self._scrollerList:dispose()
end

function DivinesuperdragonbuffstageView:onEnter()
	DivinesuperdragonbuffstageView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])

	if self._activityId <= 0 then
		self._activityId = DivinesuperdragonController.instance:getActivityId()
	end

	self._actCfg = DivinesuperdragonConfig.instance:getActCfg(self._activityId)

	local cfgs = DivinesuperdragonConfig.instance:getBuffStageCfgs(self._activityId)

	self._stageId = DivinesuperdragonModel.instance:getPassMaxBuffStageId(self._activityId)
	self._isAoqiGodProcessType = ActivityDefineController.instance:isAoqiGodProcessType(self._activityId)

	self._scrollerList:reloadData(cfgs)
	self._scrollerList:MoveCellToBegin(self._stageId - 1)
	self:_initAoqiGodUI()
	self:_setRule()
	self:_setActTime()
end

function DivinesuperdragonbuffstageView:_initAoqiGodUI()
	GameUtil.SetActive(self._txtTimeGo, not self._isAoqiGodProcessType)
end

function DivinesuperdragonbuffstageView:_updateCell(view, cell, cfg, tag)
	local btn = Framework.ButtonAdapter.GetFrom(cell.gameObject, "btn")
	local goMask = goutil.findChild(cell.gameObject, "mask")
	local iconGo = goutil.findChild(cell.gameObject, "icon")
	local imgChangeAttr = goutil.findChild(cell.gameObject, "attr"):GetComponent(ComponentType.UIImageSpriteChange)
	local txtDesc = goutil.findChildTextComponent(cell.gameObject, "txtDesc")
	local txtLock = goutil.findChildTextComponent(cell.gameObject, "mask/txtLock")

	txtDesc.text = cfg.desc

	local isOpen = false

	if not cfg.openTime then
		isOpen = true
	else
		local time = GameUtil.string2time(cfg.openTime)

		isOpen = time <= ServerTime.now()
	end

	local raceId = cfg.raceId
	local modelCo = CharacterConfig.instance:getModelCo(raceId)

	if not modelCo then
		printError("t_model id not exist:" .. raceId)
	else
		uGuiUtil.setSpriteToImage(iconGo, uGuiUtil.SpriteType.BigBg, GameUrl.getPetImgUrl(modelCo.cardName))
	end

	local race = PetSkinConfig.instance:getFisrtEleAttrIdx(raceId)

	race = race % 10

	local targetValue = race - 1

	imgChangeAttr:SetState(targetValue)

	if not isOpen then
		local date = GameUtil.string2date(cfg.openTime)

		txtLock.text = string.format("%s年%s月%s日开启", date.year, date.month, date.day)
	end

	btn:AddClickListener(function()
		if not isOpen then
			FloatWordMgr.instance:show(txtLock.text)

			return
		end

		if self._isAoqiGodProcessType then
			local result = AoqiGodController.instance:getTryClgResultAndTipsByAct(true, GameEnum.ActivityType.DivineSuperDragon, self._activityId)

			if result ~= GameEnum.ResultCode.Success then
				return
			end
		end

		DivinesuperdragonController.instance:enterMission(self._activityId, GameEnum.DivinesuperdragonClgType.BuffStage, cfg.creepsMasterId)
	end)

	local isPass = DivinesuperdragonModel.instance:isBuffStagePass(self._activityId, cfg.stageId)

	goutil.setActive(goMask, not isOpen or isPass)

	if isPass then
		txtLock.text = "已通关"
	end
end

function DivinesuperdragonbuffstageView:_clearCell(cell)
	return
end

function DivinesuperdragonbuffstageView:_onClickbtnTip()
	local key = DivinesuperdragonConfig.instance:getRuleKey(self._activityId, "ruleKeyXingzhou")

	TipsFacade.instance:openRulesView(key)
end

function DivinesuperdragonbuffstageView:_onClickbtnClose()
	self:close()
end

function DivinesuperdragonbuffstageView:_setRule()
	self._txtTip.text = self._actCfg.xzRuleDesc
end

function DivinesuperdragonbuffstageView:_setActTime()
	self._txtTime.text = TimeGateController.instance:getActTimeShow(self._activityId)
end

return DivinesuperdragonbuffstageView
