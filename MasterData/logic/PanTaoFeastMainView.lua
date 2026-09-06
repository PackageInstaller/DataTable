-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/pantaofeast/view/PanTaoFeastMainView.lua

module("logic.extensions.pantaofeast.view.PanTaoFeastMainView", package.seeall)

local PanTaoFeastMainView = class("PanTaoFeastMainView", ViewComponent)
local REPAIR_NODE_COUNT = 16

function PanTaoFeastMainView:ctor()
	PanTaoFeastMainView.super.ctor(self)
end

function PanTaoFeastMainView:unbindEvents()
	PanTaoFeastMainView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnJump1)
	GameUtil.rmClickHandler(self._btnJump2)
	GameUtil.rmClickHandler(self._btnJump3)
	GameUtil.rmClickHandler(self._btnRepair)
	GameUtil.rmClickHandler(self._btnShowAllShowPrize)
	GameUtil.rmClickHandler(self._btnEnter)

	for _, cell in ipairs(self._guestCellList) do
		GameUtil.rmClickHandler(cell.btnGain)
	end
end

function PanTaoFeastMainView:bindEvents()
	PanTaoFeastMainView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTip, self)
	GameUtil.addClickHandler(self._btnJump1, GameUtil.handler(self._onClickBtnJump, self, 1))
	GameUtil.addClickHandler(self._btnJump2, GameUtil.handler(self._onClickBtnJump, self, 2))
	GameUtil.addClickHandler(self._btnJump3, GameUtil.handler(self._onClickBtnJump, self, 3))
	GameUtil.addClickHandler(self._btnRepair, GameUtil.handler(self._onClickBtnRepair, self))
	GameUtil.addClickHandler(self._btnShowAllShowPrize, GameUtil.handler(self._onClickBtnShowAllShowPrize, self))
	GameUtil.addClickHandler(self._btnEnter, GameUtil.handler(self._onClickBtnEnter, self))

	for _, cell in ipairs(self._guestCellList) do
		GameUtil.addClickHandler(cell.btnGain, GameUtil.handler(self._onClickBtnGainDailyPrize, self, cell))
	end
end

function PanTaoFeastMainView:buildUI()
	PanTaoFeastMainView.super.buildUI(self)

	self._txtOpenTime = self:getTxt("txtOpenTime/txt")
	self._btnClose = self:getGo("leftTop/btnClose")
	self._btnTip = self:getGo("leftTop/btnTip")
	self._btnJump1 = self:getGo("jumpBtnCol/btnJump1")
	self._btnJump2 = self:getGo("jumpBtnCol/btnJump2")
	self._btnJump3 = self:getGo("jumpBtnCol/btnJump3")
	self._repairCoverNodeList = {}
	self._repairPosNodeList = {}

	for i = 1, REPAIR_NODE_COUNT do
		local coverNode = self:getGo("repaircover/part_" .. i)
		local posNode = self:getGo("repairpos/pos_" .. i)

		table.insert(self._repairCoverNodeList, coverNode)
		table.insert(self._repairPosNodeList, posNode)
	end

	self._txtBtnRepair = self:getTxt("repairpos/node/btnRepair/txt")
	self._nodeRepair = self:getGo("repairpos/node")
	self._btnRepair = self:getGo("repairpos/node/btnRepair")
	self._conPrizeShowPrize = self:getGo("showPrize/conPrize")
	self._txtProgressShowPrize = self:getTxt("showPrize/txtProgress")
	self._btnShowAllShowPrize = self:getGo("showPrize/btnShowAll")
	self._markAllShowPrize = self:getGo("showPrize/markAll")
	self._btnGainDailyPrize = self:getGo("btnGainDailyPrize")
	self._btnEnter = self:getGo("btnEnter")
	self._guest = self:getGo("guest")
	self._guestCellList = {}

	for i = 1, 3 do
		local cell = {}

		cell.go = self:getGo("conGuest/guest_" .. i)
		cell.conRole = goutil.findChild(cell.go, "conRole")
		cell.goRole = goutil.findChild(cell.go, "conRole/role")
		cell.bubble = goutil.findChild(cell.go, "bubble")
		cell.btnGain = goutil.findChild(cell.go, "bubble/btnGain")
		cell.iconGift = goutil.findChild(cell.go, "bubble/btnGain/iconGift")

		table.insert(self._guestCellList, cell)
	end

	self._rdBookPrize = self:getGo("jumpBtnCol/btnJump3/redPoint")
end

function PanTaoFeastMainView:onExit()
	PanTaoFeastMainView.super.onExit(self)
	MaterialMgr.resetAll(self._conPrizeShowPrize)
	self:_removeAllGuestAnim()
	self:_stopAndRecycleAllSpine()

	for _, cell in ipairs(self._guestCellList) do
		uGuiUtil.clearImage(cell.iconGift)
	end
end

function PanTaoFeastMainView:onEnter()
	PanTaoFeastMainView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.PM_PanTaoFeastGetInfoRes, self._updateUIByInfo, self)
	self.addGEvent(self, GlobalNotify.PM_PanTaoFeastRepairBuildingRes, self._handleRepairSuccess, self)
	self.addGEvent(self, GlobalNotify.PM_PanTaoFeastNotifyChangeRes, self._updateRepairInfo, self)
	self.addGEvent(self, GlobalNotify.PM_PanTaoFeastGainDailyGiftRes, self._handleGainDailyGift, self)
	self.addGEvent(self, GlobalNotify.PM_PanTaoFeastNotifyChangeRes, self._updateBookInfo, self)
	self.addGEvent(self, GlobalNotify.PM_PanTaoFeastGainBookPrizeRes, self._updateBookInfo, self)

	self._activityId = checknumber(self:getFirstParam())

	if self._activityId == 0 then
		self._activityId = PanTaoFeastController.instance:getDefaultActivityId() or 0
	end

	if not ActivityDefineController.instance:checkIsInActivityTimeByActivityId(self._activityId) then
		local text = string.format("活动不在开启期限内( activityId = %d )", self._activityId)

		local function func()
			self:close()
		end

		TipsFacade.instance:openTipWindow("提示", text, func, "确定", UnityEngine.TextAnchor.MiddleCenter)

		return
	end

	self:_updateUIByCfg()

	if #self._allBuildCfgs > REPAIR_NODE_COUNT then
		printError("蟠桃盛宴活动配置的建筑数量超过了修复节点数量，请检查配置，activityId = " .. self._activityId)
		self:close()

		return
	end

	self:_updateUIByInfo()
	PanTaoFeastController.instance:getInfo(self._activityId)
	self:_startGuestLoopAnim()
end

function PanTaoFeastMainView:_updateUIByCfg()
	self._actCfg = PanTaoFeastConfig.instance:getActivityCfg(self._activityId) or {}
	self._gainGiftCountMax = self._actCfg.dailyGiftCount or 0
	self._storyId = self._actCfg.storyId or 0
	self._gotoStrs = self._actCfg.gotoStrs or {}
	self._txtOpenTime.text = TimeGateController.instance:getActTimeShow(self._activityId)
	self._allBuildCfgs = PanTaoFeastConfig.instance:getBuildingCfgs(self._activityId) or {}

	local key = string.format("%s_first_play_story_%s", self._viewPresentor.viewName, self._activityId)

	GameUtil.doCallbackWhenFirst(key, function()
		if self._storyId > 0 then
			GlobalDispatcher:dispatch(GlobalNotify.PushStory, self._storyId, StoryModel.StoryType.SCCopy)
		end
	end)

	if not self._actCfg.modelPlanId then
		local spineModelCfgs = PanTaoFeastConfig.instance:getAllSpineModelCfgsByPlanId(self._actCfg.modelPlanId) or {}

		self._spineModelCfgs = {}

		for _, cfg in ipairs(spineModelCfgs) do
			table.insert(self._spineModelCfgs, cfg)
		end

		GameUtil.permuteArray(self._spineModelCfgs)

		for i, cell in ipairs(self._guestCellList) do
			local cfg = self._spineModelCfgs[i]

			if cfg then
				if not cfg.sortLayer then
					self:_loadSpineModelByCfg(i, cfg)
				end
			end
		end
	end
end

function PanTaoFeastMainView:_updateUIByInfo()
	self:_updateGiftInfo()
	self:_updateRepairInfo()
	self:_updateBookInfo()
end

function PanTaoFeastMainView:_updateRepairInfo()
	self._repairProgress = 0
	self._curScore = 0

	local info = PanTaoFeastModel.instance:getInfo(self._activityId)

	if info then
		self._repairProgress = info.repairedBuildingCount or 0
		self._curScore = info.score or 0
	end

	for i = 1, REPAIR_NODE_COUNT do
		local coverNode = self._repairCoverNodeList[i]

		goutil.setActive(coverNode, i > self._repairProgress)
	end

	local curBuildId = self._repairProgress + 1

	if self._repairProgress >= #self._allBuildCfgs then
		goutil.setActive(self._nodeRepair, false)
	else
		goutil.setActive(self._nodeRepair, true)

		local posNode = self._repairPosNodeList[curBuildId]
		local pos = GameUtil.getAnchoredPos(posNode) or Vector2.zero

		GameUtil.setAnchoredPos(self._nodeRepair, pos.x, pos.y)

		if not self._allBuildCfgs[curBuildId] then
			local buildCfg = {}

			if not buildCfg.costScore then
				local costScore = 0

				if costScore <= self._curScore then
					self._txtBtnRepair.text = "修复"

					GameUtil.setUIImageSpriteIdx(self._btnRepair, 1)
				else
					local percent = math.floor(self._curScore / costScore * 100)

					self._txtBtnRepair.text = langPara("%s%%", percent)

					GameUtil.setUIImageSpriteIdx(self._btnRepair, 0)
				end
			end
		end
	end

	if not self._allBuildCfgs[curBuildId] then
		local prizeCfg = {}

		MaterialMgr.resetAll(self._conPrizeShowPrize)
		goutil.setActive(self._markAllShowPrize, self._repairProgress >= #self._allBuildCfgs)

		if prizeCfg then
			if not prizeCfg.prize then
				local prizeStr = ""

				MaterialMgr.setCellListByCfg(prizeStr, self._conPrizeShowPrize)
			end
		end

		self._txtProgressShowPrize.text = langPara("当前修缮进度：<color=#329215>%s</color>/%s", self._repairProgress, #self._allBuildCfgs)
	end
end

function PanTaoFeastMainView:_handleRepairSuccess()
	TipsFacade.instance:openCommonTips(lang("修复成功，建筑已修缮"))
	self:_updateRepairInfo()

	if not self._allBuildCfgs[self._repairProgress] then
		if not self._allBuildCfgs[self._repairProgress].storyId then
			local storyId = 0

			if storyId > 0 then
				GlobalDispatcher:dispatch(GlobalNotify.PushStory, storyId, StoryModel.StoryType.SCCopy)
			end
		end
	end
end

function PanTaoFeastMainView:_handleGainDailyGift()
	PanTaoFeastGameController.instance:tryPopElementCI(self._showGiftElementId)
	TipsFacade.instance:openCommonTips(lang("礼包领取成功，已存入棋盘"))
	self:_updateGiftInfo()
end

function PanTaoFeastMainView:_updateGiftInfo()
	self._dailyGiftCount = 0
	self._dailyGiftNextId = 0
	self._showGiftElementId = 0

	local info = PanTaoFeastModel.instance:getInfo(self._activityId)

	if info then
		self._dailyGiftCount = info.dailyGiftGainCount or 0
		self._dailyGiftNextId = info.dailyGiftId or 0
	end

	for _, cell in ipairs(self._guestCellList) do
		goutil.setActive(cell.bubble, false)
	end

	if self._dailyGiftNextId > 0 then
		local giftCfg = PanTaoFeastConfig.instance:getDailyGiftCfg(self._activityId, self._dailyGiftNextId)

		if giftCfg then
			local showPosId = Mathf.Random(1, #self._guestCellList)

			for i, cell in ipairs(self._guestCellList) do
				goutil.setActive(cell.bubble, i == showPosId)

				if i == showPosId then
					if not giftCfg.gridElementId then
						local gridElementId = 0

						self._showGiftElementId = gridElementId

						uGuiUtil.clearImage(cell.iconGift)

						local iconPath = PanTaoFeastController.instance:getElementIconPathById(self._activityId, gridElementId)

						if not GameUtil.isEmptyString(iconPath) then
							local spriteName = GameUrl.getItemIconUrl(iconPath)

							uGuiUtil.setSpriteToImage(cell.iconGift, uGuiUtil.SpriteType.BigBg, spriteName)
						end
					end
				end
			end
		end
	end
end

function PanTaoFeastMainView:_updateBookInfo()
	local isShowRed = false
	local info = PanTaoFeastModel.instance:getInfo(self._activityId)

	if info then
		isShowRed = false

		if not info.unlockedBookIdMap then
			if not info.gainedBookPrizeIdMap then
				local gainedBookPrizeIdMap = {}

				for bookId, _ in pairs(info.unlockedBookIdMap) do
					if not gainedBookPrizeIdMap[bookId] then
						isShowRed = true

						break
					end
				end
			end
		end
	end

	goutil.setActive(self._rdBookPrize, isShowRed)
end

function PanTaoFeastMainView:_onClickBtnTip()
	if not self._actCfg.ruleKey then
		TipsFacade.instance:openRulesView(self._actCfg.ruleKey)
	end
end

function PanTaoFeastMainView:_onClickBtnJump(index)
	if not self._gotoStrs[index] then
		if not GameUtil.isEmptyString(self._gotoStrs[index]) then
			GotoMgr.gotoByString(self._gotoStrs[index])
		end
	end
end

function PanTaoFeastMainView:_onClickBtnRepair()
	local curBuildId = self._repairProgress + 1

	if not self._allBuildCfgs[curBuildId] then
		if not self._allBuildCfgs[curBuildId].costScore then
			local costScore = 0

			if costScore > self._curScore then
				TipsFacade.instance:openCommonTips(lang("积分不足，无法修复"))

				return
			end

			if self._repairProgress >= #self._allBuildCfgs then
				TipsFacade.instance:openCommonTips(lang("已修复完毕，无需再修复"))

				return
			end

			PanTaoFeastController.instance:repairBuilding(self._activityId, curBuildId)
		end
	end
end

function PanTaoFeastMainView:_onClickBtnShowAllShowPrize()
	UIStateManager.instance:push(ViewName.PanTaoFeastRewardShowView, self._activityId)
end

function PanTaoFeastMainView:_onClickBtnGainDailyPrize()
	if self._dailyGiftCount >= self._gainGiftCountMax then
		TipsFacade.instance:openCommonTips(lang("今日已无领取次数，明天再来吧"))

		return
	end

	if self._dailyGiftNextId <= 0 then
		TipsFacade.instance:openCommonTips(lang("没有可领取的礼物"))

		return
	end

	if not PanTaoFeastGameController.instance:hasEmptyGrid(self._activityId) then
		TipsFacade.instance:openCommonTips(lang("仓库已满，无法领取,请整理仓库后再领取"))

		return
	end

	PanTaoFeastController.instance:gainDailyGift(self._activityId)
end

function PanTaoFeastMainView:_onClickBtnEnter()
	UIStateManager.instance:push(ViewName.PanTaoFeastGameView, self._activityId)
end

function PanTaoFeastMainView:_startGuestLoopAnim()
	for i, cell in ipairs(self._guestCellList) do
		local isTurnRight = Mathf.Random(1, 2) % 2 == 1

		self:_playGuestAnim(cell, isTurnRight)
	end
end

function PanTaoFeastMainView:_playGuestAnim(guestCell, isTurnRight)
	local go = guestCell and guestCell.go

	if not go then
		return
	end

	local scaleX = isTurnRight and 1 or -1
	local xLimit = {
		left = -500,
		right = 500
	}
	local moveDistance = math.random(200, 450)
	local targetX = isTurnRight and moveDistance or -moveDistance
	local moveSpeed = 25

	self._tweenRightMap = self._tweenRightMap or {}
	self._tweenLeftMap = self._tweenLeftMap or {}

	if not isTurnRight then
		if not self._tweenRightMap then
			local removeTweenMap = self._tweenLeftMap

			if isTurnRight then
				if not self._tweenRightMap then
					local addTweenMap = self._tweenLeftMap

					if removeTweenMap[go] then
						removeTweenMap[go]:Kill(true)

						removeTweenMap[go] = nil
					end

					local localPos = GameUtil.getAnchoredPos(go) or Vector2.zero
					local x = Mathf.Clamp(localPos.x, xLimit.left, xLimit.right)

					if isTurnRight and targetX <= x then
						x = targetX
					elseif not isTurnRight and x <= targetX then
						x = targetX
					end

					GameUtil.setAnchoredPos(go, x, localPos.y)
					GameUtil.setLocalScale(guestCell.conRole, scaleX, 1, 1)

					local distance = math.abs(targetX - x)
					local duration = distance / moveSpeed

					addTweenMap[go] = go.transform:DOLocalMoveX(targetX, duration, false):SetEase(DG.Tweening.Ease.Linear):OnComplete(function()
						self:_playGuestAnim(guestCell, not isTurnRight)
					end)
				end
			end
		end
	end
end

function PanTaoFeastMainView:_removeAllGuestAnim()
	self._tweenRightMap = self._tweenRightMap or {}
	self._tweenLeftMap = self._tweenLeftMap or {}

	for go, tween in pairs(self._tweenRightMap) do
		if tween then
			tween:Kill(true)
		end
	end

	for go, tween in pairs(self._tweenLeftMap) do
		if tween then
			tween:Kill(true)
		end
	end

	self._tweenRightMap = {}
	self._tweenLeftMap = {}
end

function PanTaoFeastMainView:_loadSpineModelByCfg(posId, spineModelCfg)
	if not spineModelCfg then
		return
	end

	if not spineModelCfg.spinePath then
		local modelPath = ""
		local URL = GameUrl.getSpineUIUrl(modelPath)

		self._posIdByUrl = self._posIdByUrl or {}
		self._posIdByUrl[URL] = posId

		getres(URL, self._onSpineResloadFinish, self, ResType.AssetBundle, true)
	end
end

function PanTaoFeastMainView:_stopAndRecycleAllSpine()
	self._posIdByUrl = self._posIdByUrl or {}

	for URL, posId in pairs(self._posIdByUrl) do
		removeresl(URL, self._onSpineResloadFinish, self)
	end

	self._posIdByUrl = {}
	self._resMap = self._resMap or {}

	for posId, res in pairs(self._resMap) do
		if res then
			res:Release()
		end
	end

	self._resMap = {}
end

function PanTaoFeastMainView:_onSpineResloadFinish(res)
	local resPath = res.ResPath
	local posId = self._posIdByUrl[resPath]

	if not posId then
		return
	end

	self._resMap = self._resMap or {}

	if self._guestCellList[posId] then
		local roleParent = self._guestCellList[posId].goRole
		local spineModelCfg = self._spineModelCfgs[posId]

		if not spineModelCfg then
			return
		end

		if not spineModelCfg.aniName then
			local aniName = ""

			if not spineModelCfg.posOffset then
				local posOffset = {
					0,
					0
				}

				if not spineModelCfg.scale then
					local scale = {
						1,
						1,
						1
					}

					if not roleParent then
						return
					end

					if res and res.IsSuccess then
						self._resMap[posId] = res

						res:Retain()

						local prefab = res:GetMainAsset()

						if prefab then
							local go = goutil.clone(prefab)

							goutil.clearChildren(roleParent)
							goutil.addChildToParent(go, roleParent)
							GameUtil.setAnchoredPos(go, checknumber(posOffset[1]), checknumber(posOffset[2]))
							GameUtil.setLocalScale(go, checknumber(scale[1]), checknumber(scale[2]), checknumber(scale[3]))
							RoleObjectPool.instance:playAnimation(go, aniName, true)
						end
					end
				end
			end
		end
	end
end

return PanTaoFeastMainView
