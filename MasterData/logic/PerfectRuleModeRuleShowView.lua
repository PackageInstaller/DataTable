-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/view/perfectrulemode/PerfectRuleModeRuleShowView.lua

module("logic.extensions.timelimitedchallenge.view.perfectrulemode.PerfectRuleModeRuleShowView", package.seeall)

local PerfectRuleModeRuleShowView = class("PerfectRuleModeRuleShowView", ViewComponent)

function PerfectRuleModeRuleShowView:unbindEvents()
	PerfectRuleModeRuleShowView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()

	for i = 1, 5 do
		self._modes[i].btn:RemoveClickListener()
	end
end

function PerfectRuleModeRuleShowView:bindEvents()
	PerfectRuleModeRuleShowView.super.bindEvents(self)
	self._btnClose:AddClickListener(self.close, self)

	for i = 1, 5 do
		self._modes[i].btn:AddClickListener(function()
			self:_onClickModeBtn(i)
		end, self)
	end
end

function PerfectRuleModeRuleShowView:buildUI()
	PerfectRuleModeRuleShowView.super.buildUI(self)

	self._challengeId = 0
	self._modes = {}
	self._modeId = nil

	for i = 1, 5 do
		local mode = {}
		local str = "btn" .. i

		mode.btn = self:getBtn(str)
		mode.txt = self:getTxt(str .. "/Text")
		mode.uiChanges = self:getGo(str):GetComponent("UIChangeGroup")
		mode.cfg = nil
		mode.dataList = {}
		self._modes[i] = mode
	end

	self._btnClose = self:getBtn("btnClose")
	self._goCell = self:getGo("right/cell")
	self._goTable = self:getGo("right/tableview")
	self._tableView = ScrollerList.create(self._goTable, self._goCell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
end

function PerfectRuleModeRuleShowView:onEnter()
	PerfectRuleModeRuleShowView.super.onEnter(self)

	self._challengeId = checkint(self:getFirstParam())

	if self._challengeId > 0 then
		for i = 1, 5 do
			local mode = self._modes[i]

			mode.cfg = PerfectRuleModeConfig.instance:getModeCfgsByIndex(self._challengeId, i)

			if mode.cfg then
				mode.txt.text = langPara("%s难度", mode.cfg.desc)
				mode.dataList = {}

				local ruleCfgs = PerfectRuleModeConfig.instance:getRuleCfgByModeId(self._challengeId, mode.cfg.modeId)

				for _, v in pairs(ruleCfgs) do
					local data = {}

					data.sortId = #mode.dataList + 1
					data.cfg = v

					table.insert(mode.dataList, data)
				end
			end
		end

		self:_onClickModeBtn(1)
	end
end

function PerfectRuleModeRuleShowView:_onClickModeBtn(modeId)
	if self._modeId == modeId then
		return
	end

	local curModeCfg = PerfectRuleModeConfig.instance:getModeCfgsByIndex(self._challengeId, modeId)
	local isOpen, openTime = PerfectRuleModeModel.instance:getModeIsOpen(self._challengeId, curModeCfg.modeId)

	if isOpen then
		self._modeId = modeId

		self._tableView:reloadData(self._modes[self._modeId].dataList)
	else
		local str = self._modes[modeId].txt.text
		local tipStr = GameUtil.formatTimeStamp(lang("%m月%d日开启"), openTime)

		tipStr = str .. tipStr

		FloatWordMgr.instance:show(tipStr)

		return
	end

	for i = 1, 5 do
		if modeId == i then
			self._modes[i].uiChanges:SetState(1)
		else
			self._modes[i].uiChanges:SetState(0)
		end
	end
end

function PerfectRuleModeRuleShowView:_updateCell(view, cell, data)
	local uitext = goutil.findChild(cell, "imgNum"):GetComponent("UIImgNumeralText")

	uitext:SetText(data.sortId)

	local txtEffect = goutil.findChildTextComponent(cell, "txtEffect")

	txtEffect.text = data.cfg.buffDes

	local txtWinPrefect = goutil.findChildTextComponent(cell, "txtWinPrefect")
	local str = data.cfg.perfectDes

	str = GameUtil.isEmptyString(str) and lang("无") or langPara("完美：成功通关同时%s", str)
	txtWinPrefect.text = str
end

function PerfectRuleModeRuleShowView:_clearCell(cell)
	return
end

return PerfectRuleModeRuleShowView
