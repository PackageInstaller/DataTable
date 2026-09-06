-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/shadowdragonclg/view/ShadowdragonclgextView.lua

module("logic.extensions.shadowdragonclg.view.ShadowdragonclgextView", package.seeall)

local ShadowdragonclgextView = class("ShadowdragonclgextView", ViewComponent)

function ShadowdragonclgextView:ctor()
	ShadowdragonclgextView.super.ctor(self)
end

function ShadowdragonclgextView:unbindEvents()
	ShadowdragonclgextView.super.unbindEvents(self)
	self._btnBuff:RemoveClickListener()
	GameUtil.rmClickHandler(self._btnHide)
	GameUtil.rmClickHandler(self._btnShow)
end

function ShadowdragonclgextView:bindEvents()
	ShadowdragonclgextView.super.bindEvents(self)
	self._btnBuff:AddClickListener(self._onClickbtnBuff, self)
	GameUtil.addClickHandler(self._btnHide, self._onClickHide, self)
	GameUtil.addClickHandler(self._btnShow, self._onClickShow, self)
end

function ShadowdragonclgextView:buildUI()
	ShadowdragonclgextView.super.buildUI(self)

	self._btnBuff = self:getBtn("btnBuff")

	local go = self:getGo("info/emenyFmt")

	self._enemyList = {}

	for i = 1, 9 do
		self._enemyList[i] = {
			go = goutil.findChild(go, "teamEnemy/cell_" .. i),
			con = goutil.findChild(go, "teamEnemy/cell_" .. i .. "/icon"),
			itemGo = goutil.findChild(go, "teamEnemy/cell_" .. i .. "/item")
		}
	end

	self._btnHide = self:getGo("info/btnHide")
	self._showGo = self:getGo("showGo")
	self._btnShow = self:getGo("showGo/btnShow")
	self._txtRule = self:getTxt("info/txtRule")
	self._infoGo = self:getGo("info")
	self._goTopDesc = self:getGo("topDesc")
	self._txtTopDesc = self:getTxt("topDesc/txtDesc")
end

function ShadowdragonclgextView:onExit()
	ShadowdragonclgextView.super.onExit(self)

	for i, v in ipairs(self._enemyList) do
		MaterialMgr.resetAll(v.itemGo)
		MaterialMgr.resetAll(v.con)
	end
end

function ShadowdragonclgextView:onEnter()
	ShadowdragonclgextView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.ShadowDragonClgSelectBuffRes, self._onShadowDragonClgSelectBuffRes, self)
	self.addGEvent(self, GlobalNotify.FormationChangeFinish, self._onFormationChangeFinish, self)

	self._fmtMo = self:getFirstParam()
	self._isNow = self._fmtMo._isNow
	self._stageId = self._fmtMo._stageId
	self._activityId = self._fmtMo._activityId
	self._stageCfg = self._fmtMo._stageCfg
	self._isPassStage = self._stageCfg.type and self._stageCfg.type == ShadowdragonclgController.PassFutureStageType.Pass
	self._formation = self._fmtMo:getCurFormation()

	self:_updateUI()

	if not self._isNow and not self._isPassStage then
		self:_refreshView()
		self:_onClickShow()
	end
end

function ShadowdragonclgextView:_onClickbtnBuff()
	if self._isNow then
		UIStateManager.instance:push(ViewName.ShadowdragonclgbuffView, self._fmtMo._activityId, self._fmtMo._stageId, function(buffId)
			local selectBuffId = ShadowdragonclgModel.instance:getNowStageSelectBuffId(self._fmtMo._activityId, self._fmtMo._stageId)

			if selectBuffId ~= buffId then
				ShadowDragonClgAgent.instance:sendPM_ShadowDragonClgSelectBuffReq(self._activityId, self._stageId, buffId)
			end
		end)
	elseif self._isPassStage then
		local buffIdNow = self._fmtMo:getPassStageBuffId()

		UIStateManager.instance:push(ViewName.ShadowdragonclgpassbuffView, self._activityId, self._stageId, buffIdNow, function(buffId)
			self._fmtMo:setPassStageBuffId(buffId)
		end)
	end
end

function ShadowdragonclgextView:_updateUI()
	local showPassStage = not self._isNow and not self._isPassStage
	local showBuffBtn = false

	if self._isNow then
		showBuffBtn = self._stageId > 1
	elseif self._isPassStage then
		showBuffBtn = ShadowdragonclgConfig.instance:getFuturePassBuffCfgs(self._activityId, self._stageId)
	end

	local showTopDesc = not self._isNow and not string.nilorempty(self._stageCfg.topDesc)

	goutil.setActive(self._btnBuff.gameObject, showBuffBtn)
	goutil.setActive(self._showGo.gameObject, showPassStage)
	goutil.setActive(self._infoGo.gameObject, showPassStage)
	goutil.setActive(self._goTopDesc, showTopDesc)

	if showTopDesc then
		self._txtTopDesc.text = self._stageCfg.topDesc
	end
end

function ShadowdragonclgextView:_onShadowDragonClgSelectBuffRes()
	return
end

function ShadowdragonclgextView:_onFormationChangeFinish()
	if not self._isNow and not self._isPassStage then
		self:_refreshView()
	end
end

function ShadowdragonclgextView:_onClickHide()
	GameUtil.SetActive(self._infoGo, false)
	GameUtil.SetActive(self._showGo, true)
end

function ShadowdragonclgextView:_onClickShow()
	GameUtil.SetActive(self._infoGo, true)
	GameUtil.SetActive(self._showGo, false)
end

function ShadowdragonclgextView:_refreshView()
	local selectRaceId = self._fmtMo:getFutureStageRaceId()

	for i = 1, 9 do
		MaterialMgr.resetAll(self._enemyList[i].con)
		GameUtil.SetActive(self._enemyList[i].go, false)
	end

	local positions = self._formation:GetPositions()

	for posId, petId in ipairs(positions) do
		if petId > 0 then
			local petMo = self._fmtMo:getCurFormation():_getPet(petId)

			GameUtil.setLocalScale(self._enemyList[posId].con, 0.8, 0.8, 0.8)

			local proxy = MaterialMgr.setCellByMo(petMo, self._enemyList[posId].con)

			proxy.binder:setAutoTips(false)
			proxy.binder:setCallBack(function()
				if not self:_checkEnough() then
					FloatWordMgr.instance:show("消耗材料不足，无法选择")

					return
				end

				self._fmtMo:setFutureStageRaceId(petMo.raceId)
				self:_refreshView()
			end)
			GameUtil.SetActive(self._enemyList[posId].go, true)
			GameUtil.SetGray(self._enemyList[posId].go, selectRaceId ~= petMo.raceId)
		end
	end
end

function ShadowdragonclgextView:_checkEnough()
	local info = ShadowdragonclgModel.instance:getInfo(self._activityId)
	local count = 0
	local useCount = 0

	for i, v in ipairs(info.nowStageList) do
		if v.selectBuffId == ShadowdragonclgController.PassFutureStageType.Future then
			count = count + 1
		end
	end

	for i, v in ipairs(info.futurePassStageList) do
		if v.param > 0 then
			local stageCfg = ShadowdragonclgConfig.instance:getFuturePassStageCfg(self._activityId, v.stageId)

			if stageCfg.type == ShadowdragonclgController.PassFutureStageType.Future then
				useCount = useCount + 1
			end
		end
	end

	return useCount < count
end

return ShadowdragonclgextView
