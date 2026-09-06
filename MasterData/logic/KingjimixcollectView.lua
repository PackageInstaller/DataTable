-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/kingjichallenge/view/KingjimixcollectView.lua

module("logic.extensions.kingjichallenge.view.KingjimixcollectView", package.seeall)

local KingjimixcollectView = class("KingjimixcollectView", ViewComponent)

function KingjimixcollectView:ctor()
	KingjimixcollectView.super.ctor(self)
end

function KingjimixcollectView:unbindEvents()
	KingjimixcollectView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
	self._btnCancel:RemoveClickListener()
	self._btnSure:RemoveClickListener()
end

function KingjimixcollectView:bindEvents()
	KingjimixcollectView.super.bindEvents(self)
	self._btnClose:AddClickListener(self._onClickbtnClose, self)
	self._btnCancel:AddClickListener(self._onClickbtnCancel, self)
	self._btnSure:AddClickListener(self._onClickbtnSure, self)
end

function KingjimixcollectView:buildUI()
	KingjimixcollectView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._txtCollect = self:getTxt("txtCollect")
	self._tablecellGo = self:getGo("tablecell")
	self._tableviewGo = self:getGo("tableview")
	self._scrollerList = ScrollerList.create(self._tableviewGo, self._tablecellGo, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._bgGo = self:getGo("bg")
	self._saveRootGo = self:getGo("saveRoot")
	self._btnCancel = self:getBtn("saveRoot/btnCancel")
	self._btnSure = self:getBtn("saveRoot/btnSure")
	self._txtPetEmpty = self:getTxt("txtPetEmpty")
end

function KingjimixcollectView:onExit()
	KingjimixcollectView.super.onExit(self)
	self._scrollerList:dispose()
end

function KingjimixcollectView:onEnter()
	KingjimixcollectView.super.onEnter(self)
	self.addGEvent(self, KingJiChallengeAgent.KingJiChallengeSaveResultRes, self._saveResultRes, self)

	local params = self:getOpenParam()

	self._activityId = KingjichallengeModel.instance:getActivityId()
	self._stageId = params[1]
	self._creepsMasterId = params[2]
	self._hasSaveOp = params[3]
	self._mixSaveMsg = nil

	if self._hasSaveOp then
		self._mixSaveMsg = KingjichallengeController.instance:getMixSaveMsg()
	end

	self._isAoqiGodProcessType = ActivityDefineController.instance:isAoqiGodProcessType(self._activityId)

	self:_updateUI()
end

function KingjimixcollectView:_onClickbtnClose()
	if self._hasSaveOp then
		self:_onClickbtnCancel()

		return
	end

	self:close()
end

function KingjimixcollectView:_onClickbtnCancel()
	KingJiChallengeAgent.instance:sendPM_KingJiChallengeSaveResultReq(self._activityId, self._stageId, self._creepsMasterId, false)
	self:close()
end

function KingjimixcollectView:_onClickbtnSure()
	KingJiChallengeAgent.instance:sendPM_KingJiChallengeSaveResultReq(self._activityId, self._stageId, self._creepsMasterId, true)

	if not self._isAoqiGodProcessType then
		self:close()
	end
end

function KingjimixcollectView:_updateUI()
	self:_adjust()
	self:_updateCollectDesc()
	self:_updateLockPet()
end

function KingjimixcollectView:_updateCollectDesc()
	if self._mixSaveMsg then
		self:_updateCollectDescPreview(self._mixSaveMsg)

		return
	end

	local info = KingjichallengeModel.instance:getInfo()

	if not info then
		return
	end

	local list = {}

	for i, v in ipairs(info.mixInfo.stageList) do
		if v.stageId == self._stageId then
			for _, o in ipairs(v.masterList) do
				if o.passCreepsMasterIds == self._creepsMasterId then
					for _, p in ipairs(o.itemList) do
						table.insert(list, string.format("%s*%s", p.attribute, p.collectCount))
					end

					break
				end
			end

			break
		end
	end

	self._txtCollect.text = #list <= 0 and "无" or table.concat(list, "、")
end

function KingjimixcollectView:_updateCollectDescPreview(mixSaveMsg)
	local list = {}
	local masterInfo = mixSaveMsg.masterInfo

	for _, p in ipairs(masterInfo.itemList) do
		table.insert(list, string.format("%s*%s", p.attribute, p.collectCount))
	end

	self._txtCollect.text = #list <= 0 and "无" or table.concat(list, "、")
end

function KingjimixcollectView:_updateLockPet()
	if self._mixSaveMsg then
		self:_updateLockPetPreview(self._mixSaveMsg)

		return
	end

	local raceIds = KingjichallengeModel.instance:getLockRaceIds(self._stageId, self._creepsMasterId)

	self:_updatePetReal(raceIds)
end

function KingjimixcollectView:_updatePetReal(raceIds)
	local list = table.values(raceIds)

	table.sort(list, function(a, b)
		return a < b
	end)
	self._scrollerList:reloadData(list)

	self._txtPetEmpty.text = #list <= 0 and "无" or ""
end

function KingjimixcollectView:_updateLockPetPreview(mixSaveMsg)
	local masterInfo = mixSaveMsg.masterInfo
	local raceIds = {}

	for i, v in ipairs(masterInfo.lockRaceIds) do
		raceIds[i] = v
	end

	self:_updatePetReal(raceIds)
end

function KingjimixcollectView:_updateCell(view, cell, raceId, tag)
	local cfgStr = string.format("%s:%s", MatType.Pet, raceId)

	MaterialMgr.resetAll(cell.gameObject)

	local proxy = MaterialMgr.setCellByCfg(cfgStr, cell.gameObject)
end

function KingjimixcollectView:_clearCell(cell)
	MaterialMgr.resetAll(cell.gameObject)
end

function KingjimixcollectView:_adjust()
	goutil.setActive(self._saveRootGo, self._hasSaveOp)

	self._bgGo.transform.sizeDelta = self._hasSaveOp and Vector2.New(760, 508) or Vector2.New(760, 418)
end

function KingjimixcollectView:_saveResultRes()
	local isAoqiGodProcessType = ActivityDefineController.instance:isAoqiGodProcessType(self._activityId)

	if isAoqiGodProcessType then
		local ronghePass = KingjichallengeController.instance:isChallengePass(GameEnum.KingjiChallengeType.Ronghe)

		if ronghePass then
			AoqiGodController.instance:doHandleChallengeFinishReady(GameEnum.ActivityType.KingJiChallenge, self._activityId)
			UIJumper.instance:resumeStack()
		end
	end

	self:close()
end

return KingjimixcollectView
