-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/parallelkingdragon/view/ParallelkingdragonextView.lua

module("logic.extensions.parallelkingdragon.view.ParallelkingdragonextView", package.seeall)

local ParallelkingdragonextView = class("ParallelkingdragonextView", ViewComponent)

function ParallelkingdragonextView:ctor()
	ParallelkingdragonextView.super.ctor(self)
end

function ParallelkingdragonextView:unbindEvents()
	ParallelkingdragonextView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnHide)
	GameUtil.rmClickHandler(self._btnShow)
end

function ParallelkingdragonextView:bindEvents()
	ParallelkingdragonextView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnHide, self._onClickHide, self)
	GameUtil.addClickHandler(self._btnShow, self._onClickShow, self)
end

function ParallelkingdragonextView:buildUI()
	ParallelkingdragonextView.super.buildUI(self)

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
end

function ParallelkingdragonextView:onExit()
	ParallelkingdragonextView.super.onExit(self)

	for i, v in ipairs(self._enemyList) do
		MaterialMgr.resetAll(v.itemGo)
		MaterialMgr.resetAll(v.con)
	end
end

function ParallelkingdragonextView:onEnter()
	ParallelkingdragonextView.super.onEnter(self)

	self._fmtMo = self:getFirstParam()
	self._activityId = self._fmtMo._activityId
	self._stageId = self._fmtMo._stageId

	local stageCfg = ParallelkingdragonConfig.instance:getStageCfg(self._activityId, self._fmtMo._stageId)

	self._masterList = ParallelkingdragonConfig.instance:getCreepsCfgs(stageCfg.creepsMasterId)
	self._selectList = {}
	self._selectCount = 0

	self:refreshView()
	self:_onClickShow()
end

function ParallelkingdragonextView:refreshView()
	local stageCfg = ParallelkingdragonConfig.instance:getStageCfg(self._activityId, self._stageId)
	local treasurePosition = stageCfg.treasurePosition

	for i = 1, 9 do
		MaterialMgr.resetAll(self._enemyList[i].con)
		GameUtil.SetActive(self._enemyList[i].go, false)
	end

	for i, v in ipairs(self._masterList) do
		if v.posId > 0 then
			GameUtil.setLocalScale(self._enemyList[v.posId].con, 0.8, 0.8, 0.8)

			local treasureId = treasurePosition[v.posId]
			local has = treasureId > 0

			goutil.setActive(self._enemyList[v.posId].itemGo, has)

			local fakeItemId = 0

			if has then
				local treasureCfg = ParallelkingdragonConfig.instance:getTreasureCfg(self._activityId, treasureId)
				local proxy = MaterialMgr.setCell(MatType.Item_Fake, treasureCfg.itemId, self._enemyList[v.posId].itemGo)

				proxy.binder:setBgActive(false)

				fakeItemId = treasureCfg.itemId
			end

			local proxy = MaterialMgr.setCell(MatType.Pet, v.raceId, self._enemyList[v.posId].con)

			proxy.binder:setAutoTips(false)

			if has and fakeItemId > 0 then
				proxy.binder:setCallBack(function()
					CommonTipsMgr.instance:openMaterialTips(nil, MatType.Item_Fake, fakeItemId)
				end)
			else
				proxy.binder:setCallBack(function()
					local petMo = FightingPowerFormula.instance:getRealMaxFightingPowerPetMo(v.raceId)

					CommonTipsMgr.instance:showPetTips(petMo, true)
				end)
			end

			GameUtil.SetActive(self._enemyList[v.posId].go, true)
		end
	end
end

function ParallelkingdragonextView:_onClickHide()
	GameUtil.SetActive(self._infoGo, false)
	GameUtil.SetActive(self._showGo, true)
end

function ParallelkingdragonextView:_onClickShow()
	GameUtil.SetActive(self._infoGo, true)
	GameUtil.SetActive(self._showGo, false)
end

return ParallelkingdragonextView
