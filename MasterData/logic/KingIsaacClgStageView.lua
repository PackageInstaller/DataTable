-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/kingisaacclg/view/KingIsaacClgStageView.lua

module("logic.extensions.kingisaacclg.view.KingIsaacClgStageView", package.seeall)

local KingIsaacClgStageView = class("KingIsaacClgStageView", ViewComponent)

function KingIsaacClgStageView:buildUI()
	KingIsaacClgStageView.super.buildUI(self)

	self._btnClose = goutil.findChild(self.mainGO, "leftTop/btnClose")
	self._btnTip = goutil.findChild(self.mainGO, "leftTop/btnTip")
	self._txtTitle = goutil.findChildTextComponent(self.mainGO, "leftTop/txtTitle")
	self._con = goutil.findChild(self.mainGO, "con")

	local tabScrollerview = goutil.findChild(self.mainGO, "tabCol/tabScrollerview")
	local tabScrollercell = goutil.findChild(self.mainGO, "tabCol/tabScrollercell")

	self._tabScrollList = ScrollerList.create(tabScrollerview, tabScrollercell, GameUtil.handler(self._updateTabCell, self), GameUtil.handler(self._clearTabCell, self))
	self._fmtCol = goutil.findChild(self.mainGO, "fmtCol")
	self._fmtView = goutil.findChild(self.mainGO, "fmtCol/fmtView")
	self._fmtCol_imgPass = goutil.findChild(self.mainGO, "fmtCol/imgPass")
	self._btnClg = goutil.findChild(self.mainGO, "ruleCol/btnClg")
	self._ruleCol_descScrollerview = goutil.findChild(self.mainGO, "ruleCol/descScrollerview/Viewport/Content")
	self._ruleCol_descCell = goutil.findChild(self.mainGO, "ruleCol/descCell")

	GameUtil.SetActive(self._ruleCol_descCell, false)
end

function KingIsaacClgStageView:bindEvents()
	KingIsaacClgStageView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTip, self)
	GameUtil.addClickHandler(self._btnClg, self._onClickBtnClg, self)
end

function KingIsaacClgStageView:unbindEvents()
	KingIsaacClgStageView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnClg)
end

function KingIsaacClgStageView:onEnter()
	KingIsaacClgStageView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])
	self._activityType = KingIsaacClgController.instance:getActivityType()

	local isInTime = KingIsaacClgController.instance:isInActivityTime(self._activityId)

	if not isInTime then
		local text = string.format("活动不在开启期限内( activityId = %d )", self._activityId)

		local function func()
			self:close()
		end

		TipsFacade.instance:openTipWindow("提示", text, func, "确定", UnityEngine.TextAnchor.MiddleCenter)

		return
	end

	self._actData = KingIsaacClgConfig.instance:getKicActData(self._activityId)

	self.addGEvent(self, GlobalNotify.handlePM_KingIsaacClgInfoRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.handlePM_NotifyKingIsaacClgChallengeEndRes, self._onUpdate, self)

	local skinId = KingIsaacClgController.instance:getSkinId(self._activityId)

	self._role = RoleObjectPool.instance:addRoleToParent(self._role, skinId, self._con, nil, nil, true, nil, nil)

	self:_onUpdate()
end

function KingIsaacClgStageView:onExit()
	KingIsaacClgStageView.super.onExit(self)

	if self._role then
		self._role = RoleObjectPool.instance:removeRole(self._role)
		self._role = nil
	end

	self:_onClear()
end

function KingIsaacClgStageView:_onUpdate()
	self:_onUpdateData()
	self:_onUpdateUI()
end

function KingIsaacClgStageView:_onClear()
	self:_onClearTabColUI()
	self:_onClearFmtShowColUI()
end

function KingIsaacClgStageView:_onUpdateData()
	if not self._curTabIdx then
		local tabIdx = 1

		self._tabInfoList = {}

		local cfg = KingIsaacClgConfig.instance:getKicStageCfg(self._activityId)

		for idx, data in ipairs(cfg or {}) do
			local info = {}

			info.data = data
			info.stageId = data.stageId

			local result, _ = KingIsaacClgController.instance:getTryEnterKingIsaacClgStageResultAndTips(self._activityId, data.stageId)

			if result == GameEnum.ResultCode.Success or result == GameEnum.ResultCode.IsPass or result == GameEnum.ResultCode.NotInTime then
				tabIdx = idx
			end

			table.insert(self._tabInfoList, info)
		end

		self._curTabIdx = Mathf.Clamp(self._curTabIdx, 0, #self._tabInfoList)
	end
end

function KingIsaacClgStageView:_onUpdateUI()
	self:_onUpdateTabColUI()
	self:_onUpdateFmtShowColUI()
end

function KingIsaacClgStageView:_getCurStageId()
	local info = self:_getCurTabInfo()

	return (info or nil) and (info.stageId or 0)
end

function KingIsaacClgStageView:_getCurData()
	local info = self:_getCurTabInfo()

	return info and info.data
end

function KingIsaacClgStageView:_getCurTabInfo()
	return self._tabInfoList[self._curTabIdx]
end

function KingIsaacClgStageView:_onUpdateTabColUI()
	self._tabScrollList:reloadData(self._tabInfoList)

	if #self._tabInfoList > 0 then
		local index = self._curTabIdx - 1

		self._tabScrollList:MoveCellInView(index, true)
	end
end

function KingIsaacClgStageView:_onClearTabColUI()
	self._tabScrollList:dispose()
end

function KingIsaacClgStageView:_updateTabCell(view, cell, info, tag)
	local tabIdx = cell.index + 1
	local data = info.data
	local stageId = info.stageId
	local isSelected = self._curTabIdx == tabIdx
	local result, _ = KingIsaacClgController.instance:getTryEnterKingIsaacClgStageResultAndTips(self._activityId, stageId)
	local mainGo = cell.gameObject
	local txtName = goutil.findChildTextComponent(mainGo, "txtName")
	local imgSelected = goutil.findChild(mainGo, "imgSelected")
	local redPoint = goutil.findChild(mainGo, "redPoint")
	local imgPass = goutil.findChild(mainGo, "imgPass")
	local lock = goutil.findChild(mainGo, "lock")
	local lock_txtTime = goutil.findChildTextComponent(mainGo, "lock/txtTime")
	local lock_txtPass = goutil.findChildTextComponent(mainGo, "lock/txtPass")

	GameUtil.SetActive(imgPass, false)
	GameUtil.SetActive(imgSelected, false)
	GameUtil.SetActive(imgSelected, isSelected)

	txtName.text = string.format("%s", tabIdx)

	GameUtil.SetActive(imgPass, result == GameEnum.ResultCode.IsPass)
	GameUtil.SetActive(lock, false)
	GameUtil.SetActive(lock_txtTime.gameObject, false)
	GameUtil.SetActive(lock_txtPass.gameObject, false)

	if result == GameEnum.ResultCode.NotUnlockCond then
		local formatTime = GameUtil.getFormatTimeByStamp(GameUtil.string2time(data.startTime), nil)

		lock_txtTime.text = string.format("%s后开启", formatTime)

		GameUtil.SetActive(lock, true)
		GameUtil.SetActive(lock_txtTime.gameObject, true)
	elseif result == GameEnum.ResultCode.NotPassLast then
		GameUtil.SetActive(lock, true)
		GameUtil.SetActive(lock_txtPass.gameObject, true)
	end

	GameUtil.addClickHandler(mainGo, GameUtil.handler(self._clickTabCell, self, tabIdx))
end

function KingIsaacClgStageView:_clearTabCell(cell)
	local mainGo = cell.gameObject

	GameUtil.rmClickHandler(mainGo)
end

function KingIsaacClgStageView:_clickTabCell(tabIdx)
	local info = self._tabInfoList[tabIdx]
	local stageId = info.stageId
	local result, tips = KingIsaacClgController.instance:getTryEnterKingIsaacClgStageResultAndTips(self._activityId, stageId)

	if result == GameEnum.ResultCode.Success or result == GameEnum.ResultCode.IsPass or result == GameEnum.ResultCode.NotInTime then
		self._curTabIdx = tabIdx

		self:_onUpdateUI()
	else
		FloatWordMgr.instance:show(tips)
	end
end

function KingIsaacClgStageView:_onUpdateFmtShowColUI()
	local stageId = self:_getCurStageId()
	local stageData = KingIsaacClgConfig.instance:getKicStageData(self._activityId, stageId)

	if stageData then
		if not stageData.creepsMasterId then
			local creepsMasterId = 0
			local creepsCfg = KingIsaacClgConfig.instance:getKicCreepsCfg(creepsMasterId)
			local isPass = KingIsaacClgController.instance:isHasPassStage(self._activityId, stageId)
			local templatePosList = {}

			if stageData then
				if not stageData.templateId then
					local templateId = 0
					local templateCfg = KingIsaacClgConfig.instance:getKicMirrorTemplateCfg(templateId)

					if templateCfg then
						for i, data in pairs(templateCfg) do
							table.insert(templatePosList, data.posId)
						end
					end

					local fmtView = self._fmtView

					for posId = 1, fmtView.transform.childCount do
						local go = fmtView.transform:GetChild(posId - 1)
						local con = goutil.findChild(go, "con")
						local master = goutil.findChild(go, "master")
						local creepsData

						if creepsCfg then
							for _, cData in ipairs(creepsCfg) do
								if cData.posId == posId then
									creepsData = cData

									break
								end
							end
						end

						if creepsData then
							local skinId = checknumber(creepsData.faceId)

							if skinId == 0 then
								skinId = creepsData.raceId
							end

							local proxy = MaterialMgr.setCell(MatType.Pet, skinId, con)

							if proxy then
								proxy.binder:setClickCallBack(nil)
							end
						else
							MaterialMgr.resetAll(con)
						end

						local isClone = table.indexof(templatePosList, posId) ~= false

						GameUtil.SetActive(master, isClone)
					end

					GameUtil.SetActive(self._fmtCol_imgPass, isPass)
					GameUtil.SetGray(self._btnClg, isPass)

					local parentTran = self._ruleCol_descScrollerview.transform
					local childGo = self._ruleCol_descCell
					local children = GameUtil.getChildren(parentTran)

					if stageData then
						if not stageData.ruleDescs then
							local ruleDescArray = {}
							local length = #ruleDescArray

							for idx, ruleDesc in ipairs(ruleDescArray) do
								local mainGo = children[idx]

								if mainGo == nil then
									mainGo = goutil.cloneAndSetParent(childGo, parentTran, string.format("%s_%s", childGo.name, idx))
								end

								local txtDesc = goutil.findChildTextComponent(mainGo, "txtDesc")

								txtDesc.text = ruleDesc
							end

							for idx = 1, parentTran.childCount do
								local mainGo = parentTran:GetChild(idx - 1)

								GameUtil.SetActive(mainGo, idx <= length)

								if idx <= length then
									UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(mainGo:GetComponent(goutil.Type_RectTransform))
								end
							end

							UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(parentTran:GetComponent(goutil.Type_RectTransform))
						end
					end
				end
			end
		end
	end
end

function KingIsaacClgStageView:_onClearFmtShowColUI()
	local fmtView = self._fmtView

	for posId = 1, fmtView.transform.childCount do
		local go = fmtView.transform:GetChild(posId - 1)
		local con = goutil.findChild(go, "con")

		MaterialMgr.resetAll(con)
	end
end

function KingIsaacClgStageView:_onClickBtnClg()
	local info = self:_getCurTabInfo()

	if info == nil then
		return
	end

	local stageId = info.stageId
	local result, tips = KingIsaacClgController.instance:getTryEnterKingIsaacClgStageResultAndTips(self._activityId, stageId)

	FloatWordMgr.instance:show(tips)

	if result ~= GameEnum.ResultCode.Success then
		return
	end

	KingIsaacClgController.instance:enterBattle(self._activityId, stageId)
end

function KingIsaacClgStageView:_onClickBtnTip()
	local key = KingIsaacClgConfig.instance:getKicCommonValue(self._activityId, "ruleKeyMain")

	TipsFacade.instance:openRulesView(key)
end

return KingIsaacClgStageView
