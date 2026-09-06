-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/versionforesight/view/VersionForesightView.lua

module("logic.extensions.versionforesight.view.VersionForesightView", package.seeall)

local VersionForesightView = class("VersionForesightView", ViewComponent)

function VersionForesightView:ctor()
	VersionForesightView.super.ctor(self)
end

function VersionForesightView:unbindEvents()
	VersionForesightView.super.unbindEvents(self)
	self._btnTip:RemoveClickListener()
	self._btnStart:RemoveClickListener()
	self._btnReward:RemoveClickListener()
	self._btnGetTimes:RemoveClickListener()

	for i, v in ipairs(self._cellList) do
		v.btn:RemoveClickListener()
	end
end

function VersionForesightView:bindEvents()
	VersionForesightView.super.bindEvents(self)
	self._btnTip:AddClickListener(self._tipOnClick, self)
	self._btnStart:AddClickListener(self._startOnClick, self)
	self._btnReward:AddClickListener(self._rewardOnClick, self)
	self._btnGetTimes:AddClickListener(self._gotoGetTimes, self)
end

function VersionForesightView:onExit()
	VersionForesightView.super.onExit(self)
	self._skinGroup.components:Clear()

	for i, v in ipairs(self._cellList) do
		MaterialMgr.resetAll(v.icon)
		uGuiUtil.clearImage(v.icon)

		v.isShow = false

		goutil.setActive(v.select, false)
		v.bg:SetState(0)
	end

	for i, v in ipairs(self._imgList or {}) do
		UnityEngine.GameObject.Destroy(v.go)
	end

	MaterialMgr.resetAll(self._cellShowIcon)
	uGuiUtil.clearImage(self._cellShowIcon)
	uGuiUtil.clearImage(self._petCon)
	removetimer(self._startRoll, self)
	removetimer(self._overRoll, self)
	removetimer(self._showPet, self)
	GlobalDispatcher:removeListener(GlobalNotify.VersionForesightGetInfo, self._refreshView, self)
	GlobalDispatcher:removeListener(GlobalNotify.VersionForesightShakeDice, self._startGame, self)
	GlobalDispatcher:removeListener(GlobalNotify.VersionForesightGainBoxPrize, self._refreshBox, self)
end

function VersionForesightView:buildUI()
	VersionForesightView.super.buildUI(self)

	self._btnTip = self:getBtn("btnTip")
	self._btnStart = self:getBtn("btnStart")
	self._btnReward = self:getBtn("reward")
	self._btnGetTimes = self:getBtn("btnGetTimes")
	self._txtTime = self:getTxt("time/txt")
	self._txtCellShow = self:getTxt("cells/cellShow/item/txt")
	self._txtTip = self:getTxt("txtTip")
	self._txtRemain = self:getTxt("txtRemain")
	self._txtUnlock = self:getTxt("txtUnlock")
	self._lock = self:getGo("lock")
	self._petCon = self:getGo("petCon")
	self._receive = self:getGo("reward/receive")
	self._imgRed = self:getGo("btnStart/imgRed")
	self._imgRewardRed = self:getGo("reward/imgRed")
	self._skinGroup = self:getGo("skinGroup"):GetComponent(typeof(UIChangeToggleGroup))
	self._point = self:getGo("point")
	self._cellShowIcon = self:getGo("cells/cellShow/item/icon")
	self._cellShowBg = self:getGo("cells/cellShow/bg"):GetComponent("UIImageSpriteChange")
	self._cells = self:getGo("cells")
	self._cellList = {}

	for i = 1, 10 do
		local list = {}
		local go = self:getGo("cells/cell_" .. i)

		list.go = go
		list.select = goutil.findChild(go, "select")
		list.icon = goutil.findChild(go, "icon")
		list.bg = goutil.findChild(go, "bg"):GetComponent("UIImageSpriteChange")
		list.btn = GameUtil.asBtn(go)
		list.isShow = false
		list.idx = i

		table.insert(self._cellList, list)
	end
end

function VersionForesightView:onEnter()
	VersionForesightView.super.onEnter(self)

	self._activityId = VersionForesightModel.instance:getActivityId()

	if self._activityId <= 0 then
		FloatWordMgr.instance:show("活动未开启")

		return
	end

	self._cfg = VersionForesightConfig.instance:getCfgById(self._activityId)
	self._showPetCfg = VersionForesightConfig.instance:getShowPetCfg(self._activityId)
	self._foresightGridCfg = VersionForesightConfig.instance:getForesightGridCfgById(self._activityId)
	self._isTime = VersionForesightModel.instance:getSplittingPoint()
	self._imgList = {}
	self._selectShowPetId = 0
	self._selectGrid = 1
	self._todayGameTimes = 0
	self._gainBoxPrize = false
	self._isStart = false

	self:_setGroup()
	self._cellShowBg:SetState(0)

	self._txtCellShow.text = "前方会有什么等\n着奥奇呢?"
	self._txtTime.text = GameUtil.getActTimeDesc(GameEnum.ActivityType.VersionForesight, self._activityId)

	local time = GameUtil.time2date(GameUtil.string2time(self._cfg.splittingPoint))
	local rewardName = MaterialMgr.getMaterialsNameByCfg(self._cfg.boxPrize)

	self._txtTip.text = string.format("解锁所有格子，%02d.%02d领取%s！", time.month, time.day, rewardName)

	goutil.setActive(self._txtCellShow.gameObject, true)
	self:_getInfoReq()
	GlobalDispatcher:addListener(GlobalNotify.VersionForesightGetInfo, self._refreshView, self)
	GlobalDispatcher:addListener(GlobalNotify.VersionForesightShakeDice, self._startGame, self)
	GlobalDispatcher:addListener(GlobalNotify.VersionForesightGainBoxPrize, self._refreshBox, self)
end

function VersionForesightView:_getInfoReq()
	VersionForesightAgent.instance:sendPM_VersionForesightGetInfoReq(self._activityId)
end

function VersionForesightView:_startOnClick()
	if not VersionForesightModel.instance:getSplittingPoint() then
		FloatWordMgr.instance:show("解锁时间已过~")

		return
	end

	if self._unlockIdsLen >= 10 then
		FloatWordMgr.instance:show("全部格子已解锁~")

		return
	end

	if self._isStart then
		FloatWordMgr.instance:show("揭晓中，请耐心等候~")

		return
	end

	if self._todayGameTimes < 1 then
		FloatWordMgr.instance:show("今日次数已用完")

		return
	end

	self._isStart = true

	VersionForesightAgent.instance:sendPM_VersionForesightShakeDiceReq(self._activityId)
end

function VersionForesightView:_tipOnClick()
	UIStateManager.instance:push(ViewName.RulesView, "versionforesightview_1")
end

function VersionForesightView:_rewardOnClick()
	if VersionForesightModel.instance:getSplittingPoint() then
		local timeStr = GameUtil.formatTimeString("%m月%d日 %H:%M", self._cfg.splittingPoint)

		FloatWordMgr.instance:show(string.format("完成所有格子后，%s后登录即可领取奖励", timeStr))

		return
	end

	if self._unlockIdsLen < self._cfg.unlockNum then
		FloatWordMgr.instance:show("首周未解锁全部格子，无法领取奖励噢~")

		return
	end

	if self._gainBoxPrize then
		FloatWordMgr.instance:show("已经领取过奖励啦")

		return
	end

	VersionForesightAgent.instance:sendPM_VersionForesightGainBoxPrizeReq(self._activityId)
end

function VersionForesightView:_gotoGetTimes()
	GotoMgr.gotoByString("func#56#1")
end

function VersionForesightView:_refreshView()
	self._todayGameTimes = VersionForesightModel.instance:getTodayGameTimes()
	self._unlockIdsLen = VersionForesightModel.instance:getUnlockIdsLen()
	self._gainBoxPrize = VersionForesightModel.instance:getGainBoxPrize()
	self._txtRemain.text = "今日剩余次数:" .. self._todayGameTimes
	self._txtUnlock.text = string.format("解锁格子:%s/10", self._unlockIdsLen)

	goutil.setActive(self._receive, self._gainBoxPrize)
	goutil.setActive(self._imgRed, self._todayGameTimes > 0)
	goutil.setActive(self._imgRewardRed, not self._isTime and not self._gainBoxPrize and self._unlockIdsLen >= self._cfg.unlockNum)
	goutil.setActive(self._txtRemain.gameObject, self._isTime)
	goutil.setActive(self._btnStart.gameObject, self._isTime)
	self:_setCells()
	self:_showPet()
	removetimer(self._showPet, self)
	settimer(3, self._showPet, self)
end

function VersionForesightView:_setGroup()
	self._skinGroup.components:Clear()

	for i, v in ipairs(self._showPetCfg) do
		local list = {}
		local go = UnityEngine.GameObject.Instantiate(self._point, self._skinGroup.gameObject.transform)

		list.go = go
		list.id = v.id
		list.num = v.num
		list.icon = v.icon
		list.img = go:GetComponent(typeof(UIImageSpriteChange))

		goutil.setActive(go, true)
		self._skinGroup.components:Add(list.img)
		table.insert(self._imgList, list)
	end
end

function VersionForesightView:_showPet()
	local curId = self._selectShowPetId

	self._selectShowPetId = self:_getNextShowPetId(curId)

	local cfg = self._showPetCfg[self._selectShowPetId]

	if self._unlockIdsLen < cfg.num and self._isTime then
		return
	end

	goutil.setActive(self._lock, false)
	self._skinGroup:SetState(self._selectShowPetId - 1)
	uGuiUtil.setSpriteToImage(self._petCon, uGuiUtil.SpriteType.BigBg, string.format("ui/bigbg/versionforesight/%s.png", cfg.icon))
end

function VersionForesightView:_getNextShowPetId(curId)
	local len = #self._showPetCfg
	local id = len < curId + 1 and 1 or curId + 1

	if self._unlockIdsLen >= self._showPetCfg[id].num or not self._isTime then
		return id
	elseif id == 1 then
		return id
	else
		return self:_getNextShowPetId(id)
	end
end

function VersionForesightView:_setCells()
	if self._isTime then
		self._unlockIds = VersionForesightModel.instance:getUnlockIds() or VersionForesightConfig.instance:getForesightGridIds(self._activityId)
	end

	for i, v in ipairs(self._unlockIds) do
		local cfg = self._foresightGridCfg[v]
		local cell = self._cellList[v]

		MaterialMgr.clearIcon(cell.icon)
		uGuiUtil.clearImage(cell.icon)

		if string.nilorempty(cfg.content) and string.nilorempty(cfg.icon) then
			local params = string.split(cfg.prize, ":")

			MaterialMgr.setIcon(cell.icon, params[1], params[2])
		else
			uGuiUtil.setSpriteToImage(cell.icon, uGuiUtil.SpriteType.BigBg, string.format("ui/icon/%s.png", cfg.icon))
		end

		cell.bg:SetState(1)

		cell.isShow = true
	end

	for i, v in ipairs(self._cellList) do
		v.btn:RemoveClickListener()
		v.btn:AddClickListener(function()
			self:_showCenterText(v.idx)
		end, self)
	end
end

function VersionForesightView:_showCenterText(idx)
	if self._isStart then
		return
	end

	local cfg = self._foresightGridCfg[idx]
	local str = ""
	local isShow = table.indexof(self._unlockIds, idx) and string.nilorempty(cfg.content) and string.nilorempty(cfg.icon)

	MaterialMgr.resetAll(self._cellShowIcon)
	uGuiUtil.clearImage(self._cellShowIcon)
	self._cellShowBg:SetState(1)

	if isShow then
		local params = string.split(cfg.prize, ":")

		MaterialMgr.setCellByCfg(cfg.prize, self._cellShowIcon)
	else
		if table.indexof(self._unlockIds, idx) then
			uGuiUtil.setSpriteToImage(self._cellShowIcon, uGuiUtil.SpriteType.BigBg, string.format("ui/icon/%s.png", cfg.icon))

			str = cfg.content
		end

		local var_18_0

		do
			str = "暂未解锁"

			self._cellShowBg:SetState(0)

			var_18_0 = (isShow or table.indexof(self._unlockIds, idx)) and self._cfg.showCenterIcon
		end
	end

	GameUtil.SetActive(self._cellShowIcon, var_18_0)
	goutil.setActive(self._txtCellShow.gameObject, not isShow)

	self._txtCellShow.text = str

	self:_setCellState(idx)
end

function VersionForesightView:_startGame()
	local round = 2

	self._stepNum = round * self:_getSurplusCellLen()
	self._targetNum = VersionForesightModel.instance:getNewUnlockId()
	self._interval = 0.1

	settimer(self._interval, self._startRoll, self)
end

function VersionForesightView:_startRoll()
	if self._stepNum > 0 then
		self:_setCellState(self._selectGrid)
		self:_setNextGrid()
	else
		removetimer(self._startRoll, self)

		self._interval = 0.7

		settimer(self._interval, self._overRoll, self)
	end

	self._stepNum = self._stepNum - 1
end

function VersionForesightView:_overRoll()
	if self._targetNum ~= self._selectGrid then
		self:_setCellState(self._selectGrid)
		self:_setNextGrid()
	else
		removetimer(self._overRoll, self)

		local changeSetId = VersionForesightModel.instance:getChangeSetId()

		MaterialController.instance:showChangeSetInTemp(changeSetId)
		self:_getInfoReq()
		self:_setCellState(self._selectGrid)

		self._isStart = false

		self:_showCenterText(self._selectGrid)
	end
end

function VersionForesightView:_getSurplusCellLen()
	local num = 0

	for i, v in ipairs(self._cellList) do
		if not v.isShow then
			num = num + 1
		end
	end

	return num
end

function VersionForesightView:_setNextGrid()
	self._selectGrid = self._selectGrid + 1 > #self._cellList and 1 or self._selectGrid + 1

	if self._cellList[self._selectGrid].isShow then
		self:_setNextGrid()
	end
end

function VersionForesightView:_setCellState(idx)
	for i, v in ipairs(self._cellList) do
		goutil.setActive(v.select, idx == v.idx)
	end
end

function VersionForesightView:_refreshBox()
	self._gainBoxPrize = true

	goutil.setActive(self._receive, self._gainBoxPrize)
	goutil.setActive(self._imgRewardRed, false)
end

return VersionForesightView
