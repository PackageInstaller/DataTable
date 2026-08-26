-- chunkname: @modules/logic/rouge/dlc/101/view/RougeLimiterView.lua

module("modules.logic.rouge.dlc.101.view.RougeLimiterView", package.seeall)

local RougeLimiterView = class("RougeLimiterView", BaseView)

RougeLimiterView.DefaultBackgroundImageName = "rouge_dlc1_fullbg1"

local LineStateName = {
	Locked2Unlocked = "light",
	Unlocked = "idle",
	Locked = "idlegray"
}
local BgAnimStateName = {
	"idle",
	"1to2",
	"2to3",
	"3to4",
	Default = "idle",
	[5] = "4to5"
}
local BgAnimSpeed = {
	Positive = 1,
	Reverse = -1
}
local BgAnimNormalizedTime = {
	[BgAnimSpeed.Positive] = 0,
	[BgAnimSpeed.Reverse] = 1
}
local BgSwitchAudio = {
	[BgAnimStateName[1]] = AudioEnum.UI.LimiterStageChanged_1,
	[BgAnimStateName[2]] = AudioEnum.UI.LimiterStageChanged_2,
	[BgAnimStateName[3]] = AudioEnum.UI.LimiterStageChanged_3,
	[BgAnimStateName[4]] = AudioEnum.UI.LimiterStageChanged_4,
	[BgAnimStateName[5]] = AudioEnum.UI.LimiterStageChanged_5
}

function RougeLimiterView:onInitView()
	self._gobuffdec = gohelper.findChild(self.viewGO, "#go_buffdec")
	self._gochoosebuff = gohelper.findChild(self.viewGO, "#go_choosebuff")
	self._gosmallbuffitem = gohelper.findChild(self.viewGO, "#go_choosebuff/SmallBuffView/Viewport/Content/#go_smallbuffitem")
	self._golimiteritem = gohelper.findChild(self.viewGO, "Right/#go_limiteritem")
	self._goRightTop = gohelper.findChild(self.viewGO, "#go_RightTop")
	self._txtpoint = gohelper.findChildText(self.viewGO, "#go_RightTop/point/#txt_point")
	self._btnclick = gohelper.findChildButtonWithAudio(self.viewGO, "#go_RightTop/point/#btn_click")
	self._goLeftTop = gohelper.findChild(self.viewGO, "#go_LeftTop")
	self._btnreset = gohelper.findChildButtonWithAudio(self.viewGO, "#go_RightTop/#btn_reset")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function RougeLimiterView:addEvents()
	self._btnreset:AddClickListener(self._btnresetOnClick, self)
end

function RougeLimiterView:removeEvents()
	self._btnreset:RemoveClickListener()
end

function RougeLimiterView:_btnresetOnClick()
	local limiterGroupIds = RougeDLCModel101.instance:getSelectLimiterGroupIds()

	if not limiterGroupIds or #limiterGroupIds <= 0 then
		return
	end

	RougeDLCModel101.instance:resetAllSelectLimitIds()
	RougeDLCController101.instance:openRougeLimiterView()
end

function RougeLimiterView:_editableInitView()
	gohelper.addUIClickAudio(self._btnreset.gameObject, AudioEnum.UI.ResetRougeLimiter)
	self.addEventCb(self, RougeDLCController101.instance, RougeDLCEvent101.UpdateLimitGroup, self._onUpdateLimiterGroup, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseView, self._onCloseViewCallBack, self)

	self._godifficultybg = gohelper.findChild(self.viewGO, "difficulty_bg")
	self._bgAnimator = gohelper.onceAddComponent(self._godifficultybg, gohelper.Type_Animator)
end

function RougeLimiterView:onOpen()
	self:onInit()
end

function RougeLimiterView:onUpdateParam()
	self:onInit()
end

function RougeLimiterView:onInit()
	self:initDebuffs()
	self:initBuffEntry()
	self:refreshBackGroundBg()
end

function RougeLimiterView:initDebuffs()
	local versions = RougeModel.instance:getVersion()
	local allLimitGroupCos = RougeDLCConfig101.instance:getAllVersionLimiterGroupCos(versions)

	if allLimitGroupCos then
		self:initBuffIcons(allLimitGroupCos)
		self:initLines(allLimitGroupCos)
	end

	RougeDLCModel101.instance:resetLimiterGroupNewUnlockInfo()
end

function RougeLimiterView:initBuffIcons(allLimitGroupCos)
	for index, limitGroupCo in ipairs(allLimitGroupCos) do
		local limiterGroupItem = self:_getOrCreatelimiterGroupItem(limitGroupCo.id)

		limiterGroupItem:onUpdateMO(limitGroupCo)
	end
end

function RougeLimiterView:refreshBackGroundBg()
	local totalRiskValue = RougeDLCModel101.instance:getTotalRiskValue()
	local nextRiskCo = RougeDLCConfig101.instance:getRougeRiskCoByRiskValue(totalRiskValue)

	if self._riskCo == nextRiskCo then
		return
	end

	local animName, animSpeed, animNormalizedTime = self:getTargetBgAnimStateInfo(self._riskCo, nextRiskCo)

	self._bgAnimator:SetFloat("speed", animSpeed)
	self._bgAnimator:Play(animName, 0, animNormalizedTime)

	local switchAuidoId = BgSwitchAudio[animName]

	if switchAuidoId then
		AudioMgr.instance:trigger(switchAuidoId)
	end

	self._riskCo = nextRiskCo
end

function RougeLimiterView:getTargetBgAnimStateInfo(preRiskCo, nextRiskCo)
	local isRisker = RougeDLCHelper101.isLimiterRisker(preRiskCo, nextRiskCo)
	local isNear = RougeDLCHelper101.isNearLimiter(preRiskCo, nextRiskCo)
	local stateName = ""
	local animSpeed

	if isRisker or not isNear then
		if nextRiskCo then
			if not nextRiskCo.id then
				local stateNameId = 0

				stateName = BgAnimStateName[stateNameId] or BgAnimStateName.Default
				animSpeed = BgAnimSpeed.Positive
			end
		end
	end

	if preRiskCo then
		if not preRiskCo.id then
			do
				local stateNameId = 0

				stateName = BgAnimStateName[stateNameId] or BgAnimStateName.Default
				animSpeed = BgAnimSpeed.Reverse
			end

			local animNormalizedTime = BgAnimNormalizedTime[animSpeed]

			return stateName, animSpeed, animNormalizedTime
		end
	end
end

function RougeLimiterView:_getOrCreatelimiterGroupItem(index)
	self._limiterGroupItemTab = self._limiterGroupItemTab or self:getUserDataTb_()

	local limiterGroupItem = self._limiterGroupItemTab[index]

	if not limiterGroupItem then
		local goRootPath = "Left/BuffView/Viewport/Content/" .. index
		local goRoot = gohelper.findChild(self.viewGO, goRootPath)

		if gohelper.isNil(goRoot) then
			local goParent = gohelper.findChild(self.viewGO, "Left/BuffView/Viewport/Content")

			goRoot = gohelper.create2d(goParent, index)

			logError("无法找到指定的限制器组挂点,已创建临时节点代替。挂点路径:" .. goRootPath)
		end

		local resUrl = self.viewContainer:getSetting().otherRes.LimiterGroupItem
		local goDebuff = self:getResInst(resUrl, goRoot, "debuffitem_" .. index)

		limiterGroupItem = MonoHelper.addNoUpdateLuaComOnceToGo(goDebuff, RougeLimiterGroupItem)
		self._limiterGroupItemTab[index] = limiterGroupItem
	end

	return limiterGroupItem
end

function RougeLimiterView:initLines(allLimitGroupCos)
	if not allLimitGroupCos then
		return
	end

	self:initUnlockMap(allLimitGroupCos)

	for preGroupId, nextGroupIds in pairs(self._unlockMap) do
		for nextGroupId, _ in pairs(nextGroupIds) do
			local nextGroupState = RougeDLCModel101.instance:getCurLimiterGroupState(nextGroupId)
			local isNextUnlocked = nextGroupState == RougeDLCEnum101.LimitState.Unlocked
			local goTran = gohelper.findChild(self.viewGO, string.format("Left/BuffView/Viewport/Content/%s_%s", preGroupId, nextGroupId))

			if not gohelper.isNil(goTran) then
				gohelper.setActive(goTran, true)

				local animStateName = LineStateName.Locked

				if isNextUnlocked then
					local isNewUnlocked = RougeDLCModel101.instance:isLimiterGroupNewUnlocked(nextGroupId)

					animStateName = isNewUnlocked and LineStateName.Locked2Unlocked or LineStateName.Unlocked
				end

				local lineAnimator = gohelper.onceAddComponent(goTran, gohelper.Type_Animator)

				lineAnimator:Play(animStateName, 0, 0)
			else
				logError(string.format("缺少限制器连接线:%s ---> %s", preGroupId, nextGroupId))
			end
		end
	end
end

function RougeLimiterView:initUnlockMap(limiterGroupCos)
	self._unlockMap = {}

	for _, limiterGroupCo in ipairs(limiterGroupCos) do
		local unlockCondition = limiterGroupCo.unlockCondition
		local _, limiterGroupIds = string.match(unlockCondition, "^(.*):(.+)$")

		limiterGroupIds = string.splitToNumber(limiterGroupIds, "#")

		if limiterGroupIds then
			for _, limiterGroupId in ipairs(limiterGroupIds) do
				self._unlockMap[limiterGroupId] = self._unlockMap[limiterGroupId] or {}
				self._unlockMap[limiterGroupId][limiterGroupCo.id] = true
			end
		end
	end
end

function RougeLimiterView:initBuffEntry()
	if not self._buffEntry then
		local resUrl = self.viewContainer:getSetting().otherRes.LimiterItem

		self._gobufficon = self:getResInst(resUrl, self._golimiteritem, "#go_bufficon")
		self._buffEntry = MonoHelper.addNoUpdateLuaComOnceToGo(self._gobufficon, RougeLimiterBuffEntry)
	end

	self._buffEntry:refreshUI(true)
end

function RougeLimiterView:_onUpdateLimiterGroup()
	self:refreshBackGroundBg()
end

function RougeLimiterView:_onCloseViewCallBack(viewName)
	if self._buffEntry then
		self._buffEntry:selectBuffEntry()
	end
end

function RougeLimiterView:onClose()
	RougeDLCController101.instance:try2SaveLimiterSetting()
end

function RougeLimiterView:onDestroyView()
	return
end

return RougeLimiterView
