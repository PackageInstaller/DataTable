-- chunkname: @modules/logic/versionactivity3_4/chg/flow/ChgNewRoundStartFlow.lua

local sf = string.format

module("modules.logic.versionactivity3_4.chg.flow.ChgNewRoundStartFlow", package.seeall)

local Base = ChgSimpleFlowSequence
local ChgNewRoundStartFlow = class("ChgNewRoundStartFlow", Base)

function ChgNewRoundStartFlow:ctor(...)
	Base.ctor(self, ...)
end

function ChgNewRoundStartFlow:onStart()
	self.viewObj:_clearCache()
	self.viewObj._lineSegmentList:clear()

	local now = self.viewContainer:roundNowAndMax()
	local title = luaLang(sf("v3a4_chg_gameview_round%s", now))

	self.viewContainer:showV3a4_Chg_GameStartView(title, self.viewContainer:gameStartDesc())
	self:_resetLayout()
	self.viewObj:_refreshMap()
	self.viewObj:_refreshItems()
	self.viewObj:setText_txtNum(sf(luaLang("V3a4_Chg_GameView_txtNum"), self.viewContainer:roundNowAndMax()))
	self:addWork(GaoSiNiaoWork_WaitCloseView.s_create(ViewName.V3a4_Chg_GameStartView))

	local startMapObj = self.viewContainer:startObj()

	if not startMapObj:hasInvokedEffect() then
		startMapObj:setHasInvokedEffect(true)

		local effects = startMapObj:effects()

		for _, effect in ipairs(effects) do
			if effect.type == ChgEnum.PuzzleMazeEffectType.Guide then
				local guideId = tonumber(effect.param)

				self:addWork(ChgGuideWork.s_create(guideId))
			end
		end
	end

	self:_addEnergyOnBegin()
end

function ChgNewRoundStartFlow:_resetLayout()
	local mapW, mapH = self.viewContainer:mapSize()
	local go = gohelper.findChild(self:Settings(), sf("%sx%s", mapW, mapH))

	if not go then
		return
	end

	local function _applyLineLayout(settingTrans, applyToTrans, applyToLayoutCmp)
		local x, y, z = transformhelper.getLocalPos(settingTrans)

		recthelper.setAnchor(applyToTrans, x, y)

		applyToLayoutCmp.spacing = z
	end

	local setting_Line_Horizontal = gohelper.findChild(go, "Line_Horizontal").transform
	local setting_Line_Vertical = gohelper.findChild(go, "Line_Vertical").transform

	_applyLineLayout(setting_Line_Horizontal, self:Line_HorizontalTrans(), self:Line_HorizontalLayoutCmp())
	_applyLineLayout(setting_Line_Vertical, self:Line_VerticalTrans(), self:Line_VerticalGoLayoutCmp())
end

function ChgNewRoundStartFlow:_addEnergyOnBegin()
	local fromEnergy = self.viewContainer:curEnergy()

	self:setText_txtCount(fromEnergy)

	local addEnergy = self.viewContainer:addEnergyBeginRound()

	self.viewContainer:setEnergy(fromEnergy + addEnergy)

	local toEnergy = self.viewContainer:curEnergy()

	self:addWork(ChgDragging_EditEnergyWork.s_create(fromEnergy, toEnergy))
end

return ChgNewRoundStartFlow
