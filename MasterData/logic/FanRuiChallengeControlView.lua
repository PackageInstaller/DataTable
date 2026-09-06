-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/fanruichallenge/view/FanRuiChallengeControlView.lua

module("logic.extensions.fanruichallenge.view.FanRuiChallengeControlView", package.seeall)

local FanRuiChallengeControlView = class("FanRuiChallengeControlView", ViewComponent)
local ChildStageMaxProgress = 3

function FanRuiChallengeControlView:buildUI()
	FanRuiChallengeControlView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._tabList = {}

	for i = 1, 3 do
		local cell = {}

		cell.pass = self:getGo(string.format("tab%d/pass", i))
		cell.spriteChange = self:getGo(string.format("tab%d", i)):GetComponent(ComponentType.UIImageSpriteChange)
		cell.colorChange = self:getGo(string.format("tab%d/txtName", i)):GetComponent(ComponentType.UITextColorChange)
		cell.levelColorChange = self:getGo(string.format("tab%d/txtLevel", i)):GetComponent(ComponentType.UITextColorChange)
		cell.txtName = self:getTxt(string.format("tab%d/txtName", i))

		table.insert(self._tabList, cell)
	end

	local fmtInfo = self:getGo("fmtInfo")
	local fmtCell = self:getGo("fmtInfo/fmt1")

	self._fmtList = {}

	local fmt = {}

	fmt.go = fmtCell
	self._fmtList[1] = fmt

	for i = 1, 3 do
		local cell

		if i == 1 then
			cell = self._fmtList[i]
		else
			cell = {}
			self._fmtList[i] = cell
			cell.go = goutil.cloneAndSetParent(fmtCell, fmtInfo.transform, "fmt" .. i)
		end

		cell.txtName = goutil.findChildTextComponent(cell.go, "txtName")
		cell.pass = goutil.findChild(cell.go, "pass")
		cell.btnBuff = Framework.ButtonAdapter.GetFrom(cell.go, "btnBuff")
		cell.btnEnter = Framework.ButtonAdapter.GetFrom(cell.go, "headFmt")

		local headFmtList = {}

		for i = 1, 9 do
			local item = {}

			item.go = goutil.findChild(cell.go, string.format("headFmt/cell_%d", i))
			item.con = goutil.findChild(cell.go, string.format("headFmt/cell_%d/con", i))

			table.insert(headFmtList, item)
		end

		cell.headFmtList = headFmtList
		cell.maskGo = goutil.findChild(cell.go, "headFmt/mask")
	end

	self._slider = self:getSlider("progress/slider")
	self._reward = self:getGo("progress/reward")
	self._btnReset = self:getBtn("btnReset")
	self._txtRule = self:getTxt("rule/txt")
end

function FanRuiChallengeControlView:bindEvents()
	FanRuiChallengeControlView.super.bindEvents(self)
	self._btnClose:AddClickListener(self.close, self)
	self._btnReset:AddClickListener(self._onClickReset, self)

	for i, v in ipairs(self._fmtList) do
		v.btnBuff:AddClickListener(function()
			self:_onClickBuff(i)
		end)
		v.btnEnter:AddClickListener(function()
			self:_onClickEnter(i)
		end)
	end
end

function FanRuiChallengeControlView:unbindEvents()
	FanRuiChallengeControlView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
	self._btnReset:RemoveClickListener()

	for i, v in ipairs(self._fmtList) do
		v.btnBuff:RemoveClickListener()
		v.btnEnter:RemoveClickListener()
	end
end

function FanRuiChallengeControlView:onEnter()
	FanRuiChallengeControlView.super.onEnter(self)
	GlobalDispatcher:addListener(GlobalNotify.FanRuiClgResetThemeControlStageRes, self._onResetRes, self)

	self._activityId = self:getFirstParam()

	local cfgs = FanRuiChallengeConfig.instance:getControlClgStageCfgList(self._activityId)
	local maxLevels = #cfgs

	for i, v in ipairs(self._tabList) do
		local cfg = cfgs[i]

		if cfg and not string.nilorempty(cfg.title) then
			v.txtName.text = cfg.title
		end
	end

	self._isPassAllStage = FanRuiChallengeModel.instance:isPassBigLevel(self._activityId, FanRuiChallengeModel.StageControl)
	self._curStageIndex = Mathf.Clamp(FanRuiChallengeModel.instance:getControlPassProgress(self._activityId) + 1, 1, maxLevels)
	self._cfgStage = FanRuiChallengeConfig.instance:getControlClgStageCfg(self._activityId, self._curStageIndex)

	self:_updateTabs()
	self:_updateFmtInfos()
	self:_updateProgressSlider()
	self:_initReward()
	self:_initRule()
end

function FanRuiChallengeControlView:onExit()
	FanRuiChallengeControlView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.FanRuiClgResetThemeControlStageRes, self._onResetRes, self)
	self:_clearReward()
	self:_clearFmts()
end

function FanRuiChallengeControlView:_onClickReset()
	if self._isPassAllStage then
		FloatWordMgr.instance:show("已通关")
	elseif not FanRuiChallengeModel.instance:isCurControlPassAnyOne() then
		FloatWordMgr.instance:show("所有阵型均未通过，无需重置")
	else
		local text = "是否将所有关卡重置为未挑战状态，解锁被锁定的精灵？"

		local function okFunc()
			FanRuiChallengeAgent.instance:sendPM_FanRuiClgResetThemeControlStageReq(self._activityId)
		end

		TipsFacade.instance:openPopupWindow(lang("tip"), text, okFunc)
	end
end

function FanRuiChallengeControlView:_onClickBuff(index)
	local creepsMasterId = checknumber(self._cfgStage.creepsMasterIds[index])

	if creepsMasterId > 0 then
		UIStateManager.instance:push(ViewName.FanRuiChallengeForecastView, creepsMasterId)
	end
end

function FanRuiChallengeControlView:_onClickEnter(index)
	if FanRuiChallengeModel.instance:isControlChildStagePass(self._activityId, index) then
		FloatWordMgr.instance:show("已通过")
	else
		FanRuiChallengeController.instance:openControlMissionView(self._activityId, self._curStageIndex, index, self._viewPresentor.viewName, ViewName.FanRuiChallengePosView)
	end
end

function FanRuiChallengeControlView:_onResetRes()
	self:_updateFmtInfos()
	self:_updateProgressSlider()
end

function FanRuiChallengeControlView:_updateTabs()
	for i, v in ipairs(self._tabList) do
		local isPass = FanRuiChallengeModel.instance:isControlPassProgress(self._activityId, i)

		goutil.setActive(v.pass, isPass)

		local isSelect = i == self._curStageIndex

		v.spriteChange:SetState(isSelect and 1 or 0)
		v.colorChange:SetState(isSelect and 1 or 0)
		v.levelColorChange:SetState(isSelect and 1 or 0)
	end
end

function FanRuiChallengeControlView:_updateProgressSlider()
	if self._isPassAllStage then
		self._slider:SetValue(1)

		return
	end

	local curProgress = FanRuiChallengeModel.instance:getControlChildProgress(self._activityId)
	local percent = curProgress / ChildStageMaxProgress

	self._slider:SetValue(percent)
end

function FanRuiChallengeControlView:_initReward()
	if self._cfgStage then
		MaterialMgr.setCellByCfg(self._cfgStage.passStagePrize, self._reward)
	end
end

function FanRuiChallengeControlView:_clearReward()
	MaterialMgr.resetAll(self._reward)
end

function FanRuiChallengeControlView:_updateFmtInfos()
	for i, v in ipairs(self._fmtList) do
		local isPass = FanRuiChallengeModel.instance:isControlChildStagePass(self._activityId, i)

		v.txtName.text = string.format("敌阵%s", GameUtil.getChineseNumber(i))

		goutil.setActive(v.pass, isPass)
		goutil.setActive(v.maskGo, isPass)

		local creepsMasterId = checknumber(self._cfgStage.creepsMasterIds[i])
		local cfgCreeps = FanRuiChallengeConfig.instance:getCreepsCfgs(creepsMasterId)

		for j, cfgEnemy in ipairs(cfgCreeps) do
			local item = v.headFmtList[cfgEnemy.posId]

			if item and item.go then
				goutil.setActive(item.go, true)
				GameUtil.setLocalScale(item.con, 0.8, 0.8, 0.8)
				MaterialMgr.setCell(MatType.Pet, cfgEnemy.raceId, item.con)
			end
		end
	end
end

function FanRuiChallengeControlView:_clearFmts()
	for i, v in ipairs(self._fmtList) do
		for j, item in ipairs(v.headFmtList) do
			MaterialMgr.resetAll(item.con)
			goutil.setActive(item.go, false)
		end
	end
end

function FanRuiChallengeControlView:_initRule()
	self._txtRule.text = FanRuiChallengeConfig.instance:getCommonValue("FANRUI_DESC5")
end

return FanRuiChallengeControlView
