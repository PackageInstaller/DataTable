-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/legend/view/treasure/LegendPetItem.lua

module("logic.extensions.legend.view.treasure.LegendPetItem", package.seeall)

local LegendPetItem = class("LegendPetItem")

function LegendPetItem:ctor()
	return
end

function LegendPetItem:init(go, cfg)
	self._cfg = cfg

	self:_buildUI(go)
	self:_setHeadIcon(cfg.raceId)
	self:_setObjActive()
	self:_setText()
end

function LegendPetItem:_buildUI(go)
	self.mainGo = go
	self._headIcon = goutil.findChild(go, "icon")
	self._lock = goutil.findChild(go, "lock")
	self._sweep = goutil.findChild(go, "sweep")
	self._redPoint = goutil.findChild(go, "redPoint")
	self._txtCount = goutil.findChildTextComponent(go, "sweep/txtCount")
	self._btn = Framework.ButtonAdapter.Get(go)

	self._btn:AddClickListener(self._onClick, self)
end

function LegendPetItem:reset()
	goutil.setActive(self.mainGo, false)
	self._btn:RemoveClickListener()
	self:_removeHeadIcon()

	self._cfg = nil
end

function LegendPetItem:_setHeadIcon(raceId)
	MaterialMgr.setCell(MatType.Pet, raceId, self._headIcon)
end

function LegendPetItem:_removeHeadIcon()
	MaterialMgr.resetAll(self._headIcon)

	self._headIcon = nil
end

function LegendPetItem:_onClick()
	if self:_isFuncUnlock() then
		local dealType = LegendController.instance:getCurMapDealType()

		if dealType == LegendController.MapDealType.Original then
			UIStateManager.instance:open(ViewName.LegendPetTipView, self._cfg)
		else
			GotoMgr.gotoByString(self._cfg.jumpTo)
		end
	else
		FloatWordMgr.instance:show(self:_getLockDesc())
	end
end

function LegendPetItem:_isFuncUnlock()
	if self._cfg.unlockId > 0 then
		return FuncOpenModel.instance:getFuncIsOpen(self._cfg.unlockId)
	else
		return true
	end
end

function LegendPetItem:_setObjActive()
	local dealType = LegendController.instance:getCurMapDealType()

	if dealType == LegendController.MapDealType.Original then
		local isUnlock = self:_isFuncUnlock()
		local isPass = LegendModel.instance:isChallengePass(self._cfg.challengeId)
		local isShow = LegendController.instance:isShowRedByChallengeId(self._cfg)

		goutil.setActive(self._sweep, isUnlock and isPass)
		goutil.setActive(self._lock, not isUnlock)
		goutil.setActive(self._redPoint, isShow)
	else
		local isUnlock = self:_isFuncUnlock()

		goutil.setActive(self._sweep, false)
		goutil.setActive(self._lock, not isUnlock)
		goutil.setActive(self._redPoint, false)
	end
end

function LegendPetItem:_getLockDesc()
	local funcOpenCfg = FuncOpenConfig.instance:getFunctionOpenById(self._cfg.unlockId)

	return (funcOpenCfg or nil) and (funcOpenCfg.description or "")
end

function LegendPetItem:_setText()
	local dealType = LegendController.instance:getCurMapDealType()

	if dealType == LegendController.MapDealType.Original then
		self._txtCount.text = "扫荡：" .. self:_getSweepCountTxt()
	end
end

function LegendPetItem:_getSweepCountTxt()
	local curCount = LegendModel.instance:getLeftCountByChallengeId(self._cfg.challengeId)
	local maxCount = VipModel.instance:getFreeChallengeTimesOfPet()

	return string.format("%d/%d", checknumber(curCount), maxCount)
end

return LegendPetItem
