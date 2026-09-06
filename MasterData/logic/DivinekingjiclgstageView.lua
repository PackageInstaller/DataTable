-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinekingjiclg/view/DivinekingjiclgstageView.lua

module("logic.extensions.divinekingjiclg.view.DivinekingjiclgstageView", package.seeall)

local DivinekingjiclgstageView = class("DivinekingjiclgstageView", ViewComponent)

function DivinekingjiclgstageView:ctor()
	DivinekingjiclgstageView.super.ctor(self)
end

function DivinekingjiclgstageView:unbindEvents()
	DivinekingjiclgstageView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	self._btnClg:RemoveClickListener()
	self._btnBan:RemoveClickListener()
	self._btnReset:RemoveClickListener()
end

function DivinekingjiclgstageView:bindEvents()
	DivinekingjiclgstageView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTip, self)
	self._btnClg:AddClickListener(self._onClickbtnClg, self)
	self._btnBan:AddClickListener(self._onClickbtnBan, self)
	self._btnReset:AddClickListener(self._onClickbtnReset, self)
end

function DivinekingjiclgstageView:buildUI()
	DivinekingjiclgstageView.super.buildUI(self)

	self._btnClose = goutil.findChild(self.mainGO, "leftTop/btnClose")
	self._btnTip = goutil.findChild(self.mainGO, "leftTop/btnTip")
	self._txtOpenTime = goutil.findChildTextComponent(self.mainGO, "txtOpenTime/txt")
	self._btnClg = self:getBtn("right/btnClg")
	self._btnBan = self:getBtn("right/btnBan")
	self._btnReset = self:getBtn("btnReset")
	self._posconGo = self:getGo("poscon")
	self._poscellGo = self:getGo("poscell")
	self._recordPos = self._posconGo:GetComponent(typeof(TestRecordPos))

	goutil.setActive(self._poscellGo, false)
	self:_buildPosCells()

	self._rewardtableviewGo = self:getGo("right/rewardtableview")
	self._rewardcellGo = self:getGo("right/rewardcell")
	self._rewardscrollerList = ScrollerList.create(self._rewardtableviewGo, self._rewardcellGo, GameUtil.handler(self._updateRewardCell, self), GameUtil.handler(self._clearRewardCell, self))
	self._txtLockNum = self:getTxt("right/txtLockNum")
	self._bufftablecellGo = self:getGo("right/buff/tablecell")
	self._bufftableviewGo = self:getGo("right/buff/tableview")
	self._buffscrollerList = ScrollerList.create(self._bufftableviewGo, self._bufftablecellGo, GameUtil.handler(self._updateBuffCell, self), GameUtil.handler(self._clearBuffCell, self))
	self._txtLockNumMax = self:getTxt("right/txtLockNumMax")
	self._txtStage = self:getTxt("right/txtStage")
end

function DivinekingjiclgstageView:_buildPosCells()
	self._posCellGos = {}

	for i = 1, 9 do
		self._posCellGos[i] = goutil.cloneAndSetParent(self._poscellGo, self._posconGo.transform)
	end

	self._recordPos:LoadPlan(0)
end

function DivinekingjiclgstageView:onExit()
	DivinekingjiclgstageView.super.onExit(self)
	self._rewardscrollerList:dispose()
	self._buffscrollerList:dispose()
end

function DivinekingjiclgstageView:onEnter()
	DivinekingjiclgstageView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.DivineKingJiClgResetRes, self._updateUI, self)

	self._activityId = self:getFirstParam()

	self:_updateUI()
	DivinekingjiclgController.instance:tryShowChangeSetId()
end

function DivinekingjiclgstageView:_onClickBtnTip()
	local challengeCfg = DivinekingjiclgController.instance:getChallengeCfg()

	TipsFacade.instance:openRulesView(challengeCfg.ruleKey)
end

function DivinekingjiclgstageView:_onClickbtnClg()
	local nextClgStageId = self._curPassStageId + 1
	local stageCfgs = DivinekingjiclgConfig.instance:getStageCfgs(self._activityId)

	if nextClgStageId > #stageCfgs then
		FloatWordMgr.instance:show("已通关")

		return
	end

	local fmtMo = DivinekingjiclgModel.instance:getFmtMo()

	fmtMo:initParams(self._activityId, nextClgStageId)
	CustomFmtController.instance:showMissionView(fmtMo)
end

function DivinekingjiclgstageView:_onClickbtnBan()
	UIStateManager.instance:push(ViewName.DivinekingjiclgbanView, self._activityId)
end

function DivinekingjiclgstageView:_onClickbtnReset()
	local info = DivinekingjiclgModel.instance:getInfo(self._activityId)

	if info.curPassStageId <= 0 then
		FloatWordMgr.instance:show("无需重置")

		return
	end

	local text = "是否重置全部关卡，且解锁全部精灵封印"

	TipsFacade.instance:openPopupWindow("提示", text, function()
		DivineKingJiClgAgent.instance:sendPM_DivineKingJiClgResetReq(self._activityId)
	end)
end

function DivinekingjiclgstageView:_updateUI()
	local info = DivinekingjiclgModel.instance:getInfo(self._activityId)

	self._curPassStageId = info.curPassStageId

	for i, v in ipairs(self._posCellGos) do
		self:_updateCell(v, i)
	end

	local stageCfg = DivinekingjiclgConfig.instance:getStageCfg(self._activityId, self._curPassStageId + 1)

	self:_updatePrize(stageCfg)
	self:_updateBuffDesc(stageCfg)

	self._txtLockNum.text = stageCfg.baseLockCount
	self._txtLockNumMax.text = stageCfg.maxLockCount
	self._txtStage.text = string.format("第%s关", stageCfg.stageId)
end

function DivinekingjiclgstageView:_updatePrize(stageCfg)
	self._rewardscrollerList:reloadData((stageCfg or nil) and string.split(stageCfg.prize, "#"))
end

function DivinekingjiclgstageView:_updateBuffDesc(stageCfg)
	local tempBuffCfgs = DivinekingjiclgConfig.instance:getBuffPlanCfgs(stageCfg.buffPlanId)
	local buffCfgs = table.values(tempBuffCfgs)

	table.sort(buffCfgs, function(a, b)
		return a.startNum < b.startNum
	end)

	local list = {}

	for i = 1, #buffCfgs - 1 do
		table.insert(list, {
			startNum = buffCfgs[i].startNum,
			endNum = buffCfgs[i + 1].startNum - 1,
			buffCfg = buffCfgs[i]
		})
	end

	local buffEndNum = #buffCfgs

	table.insert(list, {
		startNum = buffCfgs[buffEndNum].startNum,
		endNum = buffCfgs[buffEndNum].startNum,
		buffCfg = buffCfgs[buffEndNum]
	})
	self._buffscrollerList:reloadData(list)
end

function DivinekingjiclgstageView:_updateCell(go, stageId)
	local goCurrGo = goutil.findChild(go, "currGo")
	local goPassGo = goutil.findChild(go, "passGo")
	local imgChangeBg = goutil.findChild(go, "bg"):GetComponent(ComponentType.UIImageSpriteChange)
	local txtDesc = goutil.findChildTextComponent(go, "bg/txtDesc")
	local nextClgStageId = self._curPassStageId + 1
	local isGray = nextClgStageId < stageId

	GameUtil.SetGray(imgChangeBg.gameObject, isGray)
	goutil.setActive(goCurrGo, nextClgStageId == stageId)
	goutil.setActive(goPassGo, stageId < nextClgStageId)
	imgChangeBg:SetState(nextClgStageId == stageId and 0 or 1)

	txtDesc.text = stageId
end

function DivinekingjiclgstageView:_updateRewardCell(view, cell, data, tag)
	MaterialMgr.setCellByCfg(data, cell.gameObject)
end

function DivinekingjiclgstageView:_clearRewardCell(cell)
	MaterialMgr.resetAll(cell.gameObject)
end

function DivinekingjiclgstageView:_updateBuffCell(view, cell, data, tag)
	local goBg = goutil.findChild(cell.gameObject, "bg")
	local txtDesc = goutil.findChildTextComponent(cell.gameObject, "txtDesc")
	local txtTitle = goutil.findChildTextComponent(cell.gameObject, "txtTitle")
	local titleStr

	txtTitle.text = data.startNum >= data.endNum and data.startNum or string.format("%s~%s", data.startNum, data.endNum)
	txtDesc.text = data.buffCfg.buffDesc

	goutil.setActive(goBg, cell.index % 2 == 1)
end

function DivinekingjiclgstageView:_clearBuffCell(cell)
	return
end

return DivinekingjiclgstageView
