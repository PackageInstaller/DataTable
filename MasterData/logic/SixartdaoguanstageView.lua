-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/sixartdaoguan/view/SixartdaoguanstageView.lua

module("logic.extensions.sixartdaoguan.view.SixartdaoguanstageView", package.seeall)

local SixartdaoguanstageView = class("SixartdaoguanstageView", ViewComponent)

function SixartdaoguanstageView:ctor()
	SixartdaoguanstageView.super.ctor(self)
end

function SixartdaoguanstageView:unbindEvents()
	SixartdaoguanstageView.super.unbindEvents(self)
	self._btnTip:RemoveClickListener()
	self._btnClose:RemoveClickListener()
	self._btnBuff:RemoveClickListener()
end

function SixartdaoguanstageView:bindEvents()
	SixartdaoguanstageView.super.bindEvents(self)
	self._btnTip:AddClickListener(self._onClickbtnTip, self)
	self._btnClose:AddClickListener(self._onClickbtnClose, self)
	self._btnBuff:AddClickListener(self._onClickbtnBuff, self)
end

function SixartdaoguanstageView:buildUI()
	SixartdaoguanstageView.super.buildUI(self)

	self._tableviewGo = self:getGo("tableview")
	self._tablecellGo = self:getGo("tablecell")
	self._scrollerList = ScrollerList.create(self._tableviewGo, self._tablecellGo, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))

	self._scrollerList:regReloadFinish(GameUtil.handler(self._onReloadFinish, self))

	self._headGo = self:getGo("player/head")
	self._playerGo = self:getGo("player")
	self._txtName = self:getTxt("player/txtName")
	self._btnTip = self:getBtn("leftTop/btnTip")
	self._btnClose = self:getBtn("leftTop/btnClose")
	self._btnBuff = self:getBtn("btnBuff")
	self._roleconGo = self:getGo("rolecon")
	self._txtbubble = self:getTxt("bubble/txtbubble")
end

function SixartdaoguanstageView:onExit()
	SixartdaoguanstageView.super.onExit(self)
	self._scrollerList:dispose()
	HeadItemController.instance:resetHeadCell(self._headGo)

	self._roleObj = RoleObjectPool.instance:removeRole(self._roleObj)
end

function SixartdaoguanstageView:onEnter()
	SixartdaoguanstageView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = params[1]
	self._challengeId = params[2]
	self._isFirstEnter = true
	self._isChallengeDefense = self._challengeId == SixartdaoguanController.ChallengeType.Defense

	goutil.setActive(self._btnBuff.gameObject, self._isChallengeDefense)
	self:_updateUI()
	self:_setRole()
	self:_checkExistDropBuff()
	self:_setBubble()
end

function SixartdaoguanstageView:_onClickbtnClose()
	self:close()
end

function SixartdaoguanstageView:_onClickbtnTip()
	TipsFacade.instance:openRulesView("sixartdaoguan")
end

function SixartdaoguanstageView:_onClickbtnBuff()
	UIStateManager.instance:push(ViewName.SixartdaoguanallbuffView, self._activityId)
end

function SixartdaoguanstageView:_updateUI()
	local challengeInfo = SixartdaoguanModel.instance:getChallengeInfo(self._activityId, self._challengeId)

	if challengeInfo then
		if not challengeInfo.stageIdPassed then
			local stageIdPassed = 0
			local stageCfgs
			local stageCnt = 0

			self._stageIndex = -1

			if self._isChallengeDefense then
				stageCfgs = SixartdaoguanConfig.instance:getStageCfgs(self._activityId, self._challengeId)

				local waveSatageCfgs = {}
				local list = {}
				local waveId = 1

				for i, v in ipairs(stageCfgs) do
					table.insert(list, v)

					if v.dropBuffPlanId > 0 then
						waveSatageCfgs[waveId] = list
						list = {}
						waveId = waveId + 1
					end
				end

				if #list > 0 then
					waveSatageCfgs[waveId] = list
				end

				stageCnt = #waveSatageCfgs

				for i, cfgs in ipairs(waveSatageCfgs) do
					if stageIdPassed + 1 >= cfgs[1].stageId and stageIdPassed + 1 < cfgs[#cfgs].stageId then
						self._stageIndex = i - 1

						break
					end
				end

				self._scrollerList:reloadData(waveSatageCfgs)
			else
				stageCfgs = SixartdaoguanConfig.instance:getStageCfgs(self._activityId, self._challengeId)
				stageCnt = #stageCfgs

				for i, v in ipairs(stageCfgs) do
					if v.stageId == stageIdPassed + 1 then
						self._stageIndex = i - 1

						break
					end
				end

				self._scrollerList:reloadData(stageCfgs)
			end

			if self._stageIndex == -1 then
				self._stageIndex = stageIdPassed >= stageCfgs[#stageCfgs].stageId and stageCnt - 1 or 0
			end

			local challengeInfo = SixartdaoguanModel.instance:getChallengeInfo(self._activityId, self._challengeId)

			if challengeInfo.first then
				local hasFirstPassPlayer = challengeInfo.first.userName

				goutil.setActive(self._playerGo, hasFirstPassPlayer)

				if hasFirstPassPlayer then
					HeadItemController.instance:resetHeadCell(self._headGo)
					HeadItemController.instance:setHeadCellByInfo(self._headGo, challengeInfo.first, true)

					self._txtName.text = string.format("%s\n%s", challengeInfo.first.userName, challengeInfo.first.areaName)
				end
			end
		end
	end
end

function SixartdaoguanstageView:_updateDefenseCell(view, cell, datas, tag)
	local btn = Framework.ButtonAdapter.GetFrom(cell.gameObject, "btn")
	local goPassGo = goutil.findChild(cell.gameObject, "passGo")
	local goLockGo = goutil.findChild(cell.gameObject, "lockGo")
	local goItem1 = goutil.findChild(cell.gameObject, "item1")
	local goItem2 = goutil.findChild(cell.gameObject, "item2")
	local txtName = goutil.findChildTextComponent(cell.gameObject, "txtName")
	local txtDesc = goutil.findChildTextComponent(cell.gameObject, "txtDesc")
	local txtLock = goutil.findChildTextComponent(cell.gameObject, "txtLock")
	local dataFirst = datas[1]
	local dataLast = datas[#datas]
	local challengeCfg = SixartdaoguanConfig.instance:getChallengeCfg(self._activityId, dataFirst.challengeId)
	local challengeInfo = SixartdaoguanModel.instance:getChallengeInfo(self._activityId, dataFirst.challengeId)
	local openTime = GameUtil.string2time(dataFirst.openDateTime)
	local isOpen = openTime <= ServerTime.now()

	if challengeInfo then
		if not challengeInfo.stageIdPassed then
			local stageIdPassed = 0
			local isPass = stageIdPassed >= dataLast.stageId

			goutil.setActive(goPassGo, isPass)

			txtName.text = string.format("%s-第%s关", challengeCfg.desc, cell.data)
			txtLock.text = ""
			txtDesc.text = ""

			local curStage = Mathf.Clamp(stageIdPassed - dataFirst.stageId + 1, 0, #datas)

			if not isOpen or stageIdPassed + 1 < dataFirst.stageId then
				if not isOpen then
					local date = GameUtil.string2date(dataFirst.openDateTime)

					txtLock.text = string.format("%s.%s %s:00后开启", date.month, date.day, date.hour)
				else
					txtLock.text = "通关上一关后解锁"
				end
			else
				txtDesc.text = string.format("当前记录：%s/%s", curStage, #datas)
			end

			MaterialMgr.resetAll(goItem1)
			MaterialMgr.resetAll(goItem2)

			local arr = string.split(dataLast.prize, "#")

			MaterialMgr.setCellByCfg(arr[1], goItem1)

			if arr[2] then
				MaterialMgr.setCellByCfg(arr[2], goItem2)
			end

			btn:AddClickListener(function()
				if not isOpen then
					FloatWordMgr.instance:show("未开启")

					return
				end

				if isPass then
					FloatWordMgr.instance:show("已通关")

					return
				end

				if stageIdPassed + 1 < dataFirst.stageId then
					FloatWordMgr.instance:show("请先通过前面关卡")

					return
				end

				local fmtMo = SixartdaoguanModel.instance:getFmtMo(dataFirst.challengeId)

				fmtMo:initParams(self._activityId, dataFirst.challengeId, stageIdPassed + 1)
				CustomFmtController.instance:showMissionView(fmtMo)
			end)
		end
	end
end

function SixartdaoguanstageView:_updateCell(view, cell, data, tag)
	if self._isChallengeDefense then
		self:_updateDefenseCell(view, cell, data, tag)

		return
	end

	local btn = Framework.ButtonAdapter.GetFrom(cell.gameObject, "btn")
	local goPassGo = goutil.findChild(cell.gameObject, "passGo")
	local goLockGo = goutil.findChild(cell.gameObject, "lockGo")
	local goItem1 = goutil.findChild(cell.gameObject, "item1")
	local goItem2 = goutil.findChild(cell.gameObject, "item2")
	local txtName = goutil.findChildTextComponent(cell.gameObject, "txtName")
	local txtDesc = goutil.findChildTextComponent(cell.gameObject, "txtDesc")
	local txtLock = goutil.findChildTextComponent(cell.gameObject, "txtLock")
	local challengeCfg = SixartdaoguanConfig.instance:getChallengeCfg(self._activityId, data.challengeId)
	local challengeInfo = SixartdaoguanModel.instance:getChallengeInfo(self._activityId, data.challengeId)

	if challengeInfo then
		if not challengeInfo.stageIdPassed then
			local stageIdPassed = 0
			local openTime = GameUtil.string2time(data.openDateTime)
			local isOpen = openTime <= ServerTime.now()
			local isPass = stageIdPassed >= data.stageId

			goutil.setActive(goPassGo, isPass)

			txtName.text = string.format("%s-第%s关", challengeCfg.desc, data.stageId)
			txtLock.text = ""
			txtDesc.text = ""

			if not isOpen or stageIdPassed + 1 < data.stageId then
				if not isOpen then
					local date = GameUtil.string2date(data.openDateTime)

					txtLock.text = string.format("%s.%s %s:00后开启", date.month, date.day, date.hour)
				else
					txtLock.text = "通关上一关后解锁"
				end
			end

			MaterialMgr.resetAll(goItem1)
			MaterialMgr.resetAll(goItem2)

			local arr = string.split(data.prize, "#")

			MaterialMgr.setCellByCfg(arr[1], goItem1)

			if arr[2] then
				MaterialMgr.setCellByCfg(arr[2], goItem2)
			end

			btn:AddClickListener(function()
				if not isOpen then
					FloatWordMgr.instance:show("未开启")

					return
				end

				if isPass then
					FloatWordMgr.instance:show("已通关")

					return
				end

				if stageIdPassed + 1 ~= data.stageId then
					FloatWordMgr.instance:show("请先通过前面关卡")

					return
				end

				local fmtMo = SixartdaoguanModel.instance:getFmtMo(data.challengeId)

				fmtMo:initParams(self._activityId, data.challengeId, data.stageId)
				CustomFmtController.instance:showMissionView(fmtMo)
			end)
		end
	end
end

function SixartdaoguanstageView:_clearCell(cell)
	local goItem1 = goutil.findChild(cell.gameObject, "item1")
	local goItem2 = goutil.findChild(cell.gameObject, "item2")

	MaterialMgr.resetAll(goItem1)
	MaterialMgr.resetAll(goItem2)
end

function SixartdaoguanstageView:_setRole()
	local challengeCfg = SixartdaoguanConfig.instance:getChallengeCfg(self._activityId, self._challengeId)
	local trans = challengeCfg.trans
	local x, y, scale = trans[1], trans[2], trans[3]
	local raceId = challengeCfg.raceId

	self._roleObj = RoleObjectPool.instance:addRoleToParent(self._roleObj, raceId, self._roleconGo, scale, nil, true, x, y)
end

function SixartdaoguanstageView:_checkExistDropBuff()
	if self._isChallengeDefense then
		local info = SixartdaoguanModel.instance:getInfo(self._activityId)

		if not info then
			return
		end

		for i, v in ipairs(info.challenges) do
			if v.challengeId == SixartdaoguanController.ChallengeType.Defense then
				if v.dropBuffInfo and v.dropBuffInfo.selectingDropBuff then
					UIStateManager.instance:push(ViewName.SixartbuffeventView, self._activityId, true)
				end

				break
			end
		end
	end
end

function SixartdaoguanstageView:_setBubble()
	local challengeCfg = SixartdaoguanConfig.instance:getChallengeCfg(self._activityId, self._challengeId)

	self._txtbubble.text = challengeCfg.bubble
end

function SixartdaoguanstageView:_onReloadFinish()
	if self._isFirstEnter then
		self._isFirstEnter = false

		self._scrollerList:MoveCellToBegin(self._stageIndex)
	end
end

return SixartdaoguanstageView
