-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/luyngarde/view/LuyngardeChapter4View.lua

module("logic.extensions.luyngarde.view.LuyngardeChapter4View", package.seeall)

local LuyngardeChapter4View = class("LuyngardeChapter4View", ViewComponent)

function LuyngardeChapter4View:ctor()
	LuyngardeChapter4View.super.ctor(self)
end

function LuyngardeChapter4View:unbindEvents()
	LuyngardeChapter4View.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnReset)
	GameUtil.rmClickHandler(self._btnFight)
	GameUtil.rmClickHandler(self._btnRank)
	GameUtil.rmClickHandler(self._btnTask)
	GameUtil.rmClickHandler(self._btnTip)
end

function LuyngardeChapter4View:bindEvents()
	LuyngardeChapter4View.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickbtnTip, self)
	GameUtil.addClickHandler(self._btnReset, self._onClickBtnReset, self)
	GameUtil.addClickHandler(self._btnFight, self._onClickBtnFight, self)
	GameUtil.addClickHandler(self._btnRank, self._onClickBtnRank, self)
	GameUtil.addClickHandler(self._btnTask, self._onClickBtnTask, self)
end

function LuyngardeChapter4View:buildUI()
	LuyngardeChapter4View.super.buildUI(self)

	self._btnTask = self:getGo("btnTask")
	self._redPoint = self:getGo("btnTask/redPoint")
	self._btnTip = self:getGo("leftTop/btnTip")
	self._btnReset = self:getGo("btnReset")
	self._btnFight = self:getGo("btnFight")
	self._btnRank = self:getGo("btnRank")
	self._btnClose = self:getGo("leftTop/btnClose")
	self._times = self:getGo("times")
	self._best = self:getGo("best")
	self._txtNumTimes = self:getTxt("times/txtNum")
	self._txtNumBest = self:getTxt("best/txtNum")
	self._txtFight = self:getTxt("btnFight/txt")
	self._sliderHp = self:getSlider("Hp/slider")
	self._txtHp = self:getTxt("Hp/txt")

	local descTabGo = self:getGo("desc/tableview")
	local descItemGo = self:getGo("desc/tablecell")

	self._roleCon = self:getGo("roleCon")
	self._tableviewDesc = ScrollerList.create(descTabGo, descItemGo, GameUtil.handler(self._updateDescCell, self), GameUtil.handler(self._clearDescCell, self))
end

function LuyngardeChapter4View:onExit()
	LuyngardeChapter4View.super.onExit(self)
	self._tableviewDesc:dispose()

	if self._role then
		self._role = RoleObjectPool.instance:removeRole(self._role)
		self._role = nil
	end

	RedPointController.instance:unregRedPoint(self._redPoint)
end

function LuyngardeChapter4View:onEnter()
	LuyngardeChapter4View.super.onEnter(self)

	self._activityId = checknumber(self:getFirstParam())

	self.addGEvent(self, GlobalNotify.LuyngardeGetChapter4Info, self._handleGetInfo, self)
	self.addGEvent(self, GlobalNotify.LuyngardeResetChapter4Info, self._handleReset, self)
	self:_updateUIByCfg()
	LuyngardeController.instance:getChapter4Info(self._activityId)
	RedPointController.instance:regRedPoint(self._redPoint, 476)
end

function LuyngardeChapter4View:_handleGetInfo()
	local info = LuyngardeModel.instance:getChapter4InfoByActId(self._activityId)

	self._minLeftHp = checknumber(info.minLeftHp)
	self._curRoundTimes = checknumber(info.curRoundTimes)
	self._curRoundLeftHp = checknumber(info.curRoundLeftHp)

	self:_updateUI()
end

function LuyngardeChapter4View:_handleReset()
	self._curRoundTimes = 0
	self._curRoundLeftHp = -1

	self:_updateUI()
end

function LuyngardeChapter4View:_updateUIByCfg()
	self._actCfg = LuyngardeConfig.instance:getActCfg(self._activityId)
	self._descCfgs = LuyngardeConfig.instance:getChapter4DescCfgs(self._activityId)

	local masterCfg = LuyngardeConfig.instance:getCreepCfgs(self._actCfg.c4CreepsMasterId)

	self._totalHpMax = 0

	for i, cfg in pairs(masterCfg) do
		if cfg.carriedMasterId == 0 and cfg.oracleMasterId == 0 then
			local fmo = FightingPowerPetMo.New()

			fmo:fromChallengeCreepCo(cfg)

			local petMo = fmo:toBaseBagPetMo()

			self._totalHpMax = self._totalHpMax + petMo._maxHp
		end
	end

	self._totalTimes = self._actCfg.c4TimesOneRound

	local c4ShowSkinId = checknumber(self._actCfg.c4ShowSkinId)

	self._role = RoleObjectPool.instance:addRoleToParent(self._role, c4ShowSkinId, self._roleCon, nil, nil, true, nil, nil)
end

function LuyngardeChapter4View:_updateUI()
	self._curStepId = 0

	if self._curRoundLeftHp <= 0 then
		self._sliderHp:SetValue(1)

		self._txtHp.text = string.format("<color=#a3fcff>剩余血量%s，</color>占比100.00%%", self._totalHpMax)
		self._txtFight.text = "挑战命渊"

		if self._minLeftHp <= 0 then
			goutil.setActive(self._times, true)
			goutil.setActive(self._best, false)

			self._txtNumTimes.text = string.format("剩余:%s次", self._totalTimes - self._curRoundTimes)
		else
			goutil.setActive(self._times, false)
			goutil.setActive(self._best, true)

			self._txtNumBest.text = self._minLeftHp
		end
	else
		local curProgress = checknumber(self._curRoundLeftHp / self._totalHpMax)

		self._sliderHp:SetValue(curProgress)

		self._txtHp.text = string.format("<color=#a3fcff>剩余血量%s，</color>占比%.2f%%", self._curRoundLeftHp, curProgress * 100)

		for i, cfg in ipairs(self._descCfgs) do
			if curProgress * 100 <= cfg.leftHp then
				self._curStepId = i
			else
				break
			end
		end

		self._txtFight.text = "再次挑战"

		goutil.setActive(self._times, true)
		goutil.setActive(self._best, false)

		self._txtNumTimes.text = string.format("剩余:%s次", self._totalTimes - self._curRoundTimes)
	end

	self._tableviewDesc:reloadData(self._descCfgs)
end

function LuyngardeChapter4View:_updateDescCell(view, cell, data)
	local txt = goutil.findChildTextComponent(cell.gameObject, "txt")
	local select = goutil.findChild(cell.gameObject, "select")

	goutil.setActive(select, data.id == self._curStepId)

	txt.text = data.desc
end

function LuyngardeChapter4View:_clearDescCell(cell)
	return
end

function LuyngardeChapter4View:_onClickBtnReset()
	TipsFacade.instance:openPopupWindow("提示", "重置后boss将变为满血，当前挑战进度将被清空，是否确认重置？", function()
		LuyngardeController.instance:resetChapter4Challenge(self._activityId)
	end)
end

function LuyngardeChapter4View:_onClickBtnFight()
	LuyngardeController.instance:openChapter4MissionView(self._activityId)
end

function LuyngardeChapter4View:_onClickBtnRank()
	UIStateManager.instance:push(ViewName.LuyngardeRankMainView, self._activityId, 3, 1)
end

function LuyngardeChapter4View:_onClickBtnTask()
	UIStateManager.instance:push(ViewName.WishTreeBottleTaskFrameView, self._activityId)
end

function LuyngardeChapter4View:_onClickbtnTip()
	local key = self._actCfg.ruleKey

	TipsFacade.instance:openRulesView(key)
end

return LuyngardeChapter4View
