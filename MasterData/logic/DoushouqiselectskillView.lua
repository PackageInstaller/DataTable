-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/doushouqi/view/DoushouqiselectskillView.lua

module("logic.extensions.doushouqi.view.DoushouqiselectskillView", package.seeall)

local DoushouqiselectskillView = class("DoushouqiselectskillView", ViewComponent)

function DoushouqiselectskillView:ctor()
	DoushouqiselectskillView.super.ctor(self)
end

function DoushouqiselectskillView:unbindEvents()
	DoushouqiselectskillView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
	self._btnSure:RemoveClickListener()
end

function DoushouqiselectskillView:bindEvents()
	DoushouqiselectskillView.super.bindEvents(self)
	self._btnClose:AddClickListener(self._onClickbtnClose, self)
	self._btnSure:AddClickListener(self._onClickbtnSure, self)
end

function DoushouqiselectskillView:buildUI()
	DoushouqiselectskillView.super.buildUI(self)

	self._tablecellGo = self:getGo("tablecell")
	self._tableviewGo = self:getGo("tableview")
	self._txtDesc = self:getTxt("txtDesc")
	self._btnClose = self:getBtn("btnClose")
	self._btnSure = self:getBtn("btnSure")
	self._scrollerList = ScrollerList.create(self._tableviewGo, self._tablecellGo, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._txtTitle = self:getTxt("txtTitle")
	self._txtLockTip = self:getTxt("txtLockTip")
end

function DoushouqiselectskillView:onExit()
	DoushouqiselectskillView.super.onExit(self)
	self._scrollerList:dispose()
end

function DoushouqiselectskillView:onEnter()
	DoushouqiselectskillView.super.onEnter(self)

	local openParam = self:getOpenParam()

	self._activityId = openParam[1]
	self._onlyPreviewSkill = openParam[2]
	self._selectSkillId = DoushouqiModel.instance:getMySkillId()

	local info = DoushouqiModel.instance:getTypeInfo(DoushouqiController.ChessType.Doushouqi)

	if info then
		self._fightTimes = info.fightTimes or 0
	end

	self:_updateUI()
end

function DoushouqiselectskillView:_updateUI()
	self._txtTitle.text = self._onlyPreviewSkill and "查看技能" or "选择技能"

	goutil.setActive(self._btnSure.gameObject, not self._onlyPreviewSkill)

	local cfgs = DoushouqiConfig.instance:getSkillCfgs(self._activityId)

	self._scrollerList:reloadData(cfgs)
	self:_onClickSkill(self._selectSkillId)
end

function DoushouqiselectskillView:_onClickbtnClose()
	self:close()
end

function DoushouqiselectskillView:_onClickbtnSure()
	local cfg = DoushouqiConfig.instance:getSkillCfg(self._activityId, self._selectSkillId)

	if self._fightTimes < cfg.unlock then
		local str = string.format("完成%s场斗兽棋后解锁该技能", cfg.unlock)

		FloatWordMgr.instance:show(str)

		return
	end

	BeastFightingChessAgent.instance:sendBeastFightingChessSelectSkillReq(self._activityId, self._selectSkillId)
	self:close()
end

function DoushouqiselectskillView:_updateCell(view, cell, cfg, tag)
	local btnIcon = Framework.ButtonAdapter.GetFrom(cell.gameObject, "icon")
	local goIcon = goutil.findChild(cell.gameObject, "icon")
	local goSelect = goutil.findChild(cell.gameObject, "select")
	local goLock = goutil.findChild(cell.gameObject, "lock")
	local skillCfg = DoushouqiConfig.instance:getSkillCfg(self._activityId, cfg.skillId)
	local cfg = DoushouqiConfig.instance:getSkillCfg(self._activityId, cfg.skillId)
	local isLock = not self._onlyPreviewSkill and self._fightTimes < cfg.unlock

	GameUtil.SetGray(goIcon, isLock)
	goutil.setActive(goLock, isLock)
	goutil.setActive(goSelect, self._selectSkillId == cfg.skillId)

	local spriteName = string.format("%s.png", skillCfg.iconPath)

	uGuiUtil.setSpriteToImage(goIcon, uGuiUtil.SpriteType.BigBg, spriteName)
	btnIcon:AddClickListener(function()
		self:_onClickSkill(cfg.skillId)
	end)
end

function DoushouqiselectskillView:_clearCell(cell)
	local goIcon = goutil.findChild(cell.gameObject, "icon")

	uGuiUtil.clearImage(goIcon)
end

function DoushouqiselectskillView:_onClickSkill(skillId)
	self._selectSkillId = skillId

	self._scrollerList:refresh()

	local cfg = DoushouqiConfig.instance:getSkillCfg(self._activityId, skillId)
	local isLock = self._fightTimes < cfg.unlock

	self._txtDesc.text = cfg.desc

	goutil.setActive(self._btnSure.gameObject, not isLock and not self._onlyPreviewSkill)

	self._txtLockTip.text = not isLock and "" or string.format("剩余%s局斗兽棋解锁技能", cfg.unlock - self._fightTimes)
end

return DoushouqiselectskillView
