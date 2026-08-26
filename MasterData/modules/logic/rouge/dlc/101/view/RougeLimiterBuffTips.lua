-- chunkname: @modules/logic/rouge/dlc/101/view/RougeLimiterBuffTips.lua

module("modules.logic.rouge.dlc.101.view.RougeLimiterBuffTips", package.seeall)

local RougeLimiterBuffTips = class("RougeLimiterBuffTips", LuaCompBase)

function RougeLimiterBuffTips:init(go)
	self.viewGO = go
	self._txtbuffname = gohelper.findChildText(self.viewGO, "#txt_buffname")
	self._txtbuffdec = gohelper.findChildText(self.viewGO, "buffdecView/Viewport/#txt_buffdec")
	self._btnequip = gohelper.findChildButtonWithAudio(self.viewGO, "btnContain/#btn_equip")
	self._btnunequip = gohelper.findChildButtonWithAudio(self.viewGO, "btnContain/#btn_unequip")
	self._btncostunlock = gohelper.findChildButtonWithAudio(self.viewGO, "btnContain/#btn_costunlock")
	self._txtunlocknum = gohelper.findChildText(self.viewGO, "btnContain/#btn_costunlock/#txt_unlocknum")
	self._imageicon = gohelper.findChildImage(self.viewGO, "btnContain/#btn_costunlock/#txt_unlocknum/#image_icon")
	self._btnspeedup = gohelper.findChildButtonWithAudio(self.viewGO, "btnContain/#btn_speedup")
	self._txtspeedupnum = gohelper.findChildText(self.viewGO, "btnContain/#btn_speedup/#txt_speedupnum")
	self._btnclosebuffdec = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_closebuffdec")
end

function RougeLimiterBuffTips:addEventListeners()
	self.addEventCb(self, RougeDLCController101.instance, RougeDLCEvent101.UpdateBuffState, self._onUpdateBuffState, self)
	self._btnequip:AddClickListener(self._btnequipOnClick, self)
	self._btnunequip:AddClickListener(self._btnunequipOnClick, self)
	self._btncostunlock:AddClickListener(self._btncostunlockOnClick, self)
	self._btnspeedup:AddClickListener(self._btnspeedupOnClick, self)
	self._btnclosebuffdec:AddClickListener(self._btnclosebuffdecOnClick, self)
end

function RougeLimiterBuffTips:removeEventListeners()
	self._btnequip:RemoveClickListener()
	self._btnunequip:RemoveClickListener()
	self._btncostunlock:RemoveClickListener()
	self._btnspeedup:RemoveClickListener()
	self._btnclosebuffdec:RemoveClickListener()
end

function RougeLimiterBuffTips:_btnequipOnClick()
	RougeDLCModel101.instance:try2EquipBuff(self._buffId)

	if self._buffCo then
		local isBlank = self._buffCo.blank == 1

		if isBlank then
			AudioMgr.instance:trigger(AudioEnum.UI.EquipedBlankLimiterBuff)
		else
			AudioMgr.instance:trigger(AudioEnum.UI.EquipedNormalLimiterBuff)
		end
	end
end

function RougeLimiterBuffTips:_btnunequipOnClick()
	RougeDLCModel101.instance:try2UnEquipBuff(self._buffId)
end

function RougeLimiterBuffTips:_btncostunlockOnClick()
	RougeDLCController101.instance:unlockLimiterBuff(self._buffId)
end

function RougeLimiterBuffTips:_btnspeedupOnClick()
	RougeDLCController101.instance:speedupLimiterBuff(self._buffId)
end

function RougeLimiterBuffTips:_btnclosebuffdecOnClick()
	gohelper.setActive(self.viewGO, false)
	RougeDLCController101.instance:dispatchEvent(RougeDLCEvent101.CloseBuffDescTips)
end

function RougeLimiterBuffTips:onUpdateMO(buffId, isSelect)
	self._buffId = buffId
	self._buffCo = RougeDLCConfig101.instance:getLimiterBuffCo(self._buffId)

	gohelper.setActive(self.viewGO, self._buffCo and isSelect)

	if not self._buffCo or not isSelect then
		return
	end

	self:_refreshBuffInfo()
	self:_refreshBuffStateUI()
end

function RougeLimiterBuffTips:_refreshBuffInfo()
	self._txtbuffname.text = self._buffCo and self._buffCo.title
	self._txtbuffdec.text = self._buffCo and self._buffCo.desc
end

function RougeLimiterBuffTips:_refreshBuffStateUI()
	local buffState = RougeDLCModel101.instance:getLimiterBuffState(self._buffId)

	self:refreshButtons(buffState)
	self:executeBuffStateCallBack(buffState)
end

function RougeLimiterBuffTips:refreshButtons(buffState)
	local isLocked = buffState == RougeDLCEnum101.BuffState.Locked
	local isUnequiped = buffState == RougeDLCEnum101.BuffState.Unlocked
	local isEquiped = buffState == RougeDLCEnum101.BuffState.Equiped
	local isCD = buffState == RougeDLCEnum101.BuffState.CD

	gohelper.setActive(self._btncostunlock.gameObject, isLocked)
	gohelper.setActive(self._btnequip.gameObject, isUnequiped)
	gohelper.setActive(self._btnunequip.gameObject, isEquiped)
	gohelper.setActive(self._btnspeedup.gameObject, isCD)
end

function RougeLimiterBuffTips:executeBuffStateCallBack(buffState)
	local callback = self:getBuffStateCallBack(buffState)

	if not callback then
		return
	end

	callback(self)
end

function RougeLimiterBuffTips:getBuffStateCallBack(buffState)
	self._stateCallBackMap = self._stateCallBackMap or {
		[RougeDLCEnum101.BuffState.Locked] = self.onBuffLocked,
		[RougeDLCEnum101.BuffState.CD] = self.onBuffCD
	}

	if self._stateCallBackMap then
		return self._stateCallBackMap[buffState]
	end
end

local MatchCDEmblemColor = "#D6D2C9"
local LackCDEmblemColor = "#BF2E11"
local MatchUnlockEmblemColor = "#D6D2C9"
local LackUnlockEmblemColor = "#BF2E11"

function RougeLimiterBuffTips:onBuffLocked()
	if self._buffCo then
		local needEmblem = self._buffCo.needEmblem
		local totalEmblemCount = RougeDLCModel101.instance:getTotalEmblemCount()
		local isEmblemCountMatch = needEmblem <= totalEmblemCount

		if isEmblemCountMatch then
			if not MatchUnlockEmblemColor then
				local emblemCountColor = LackUnlockEmblemColor

				self._txtunlocknum.text = string.format("<%s>-%s</color>", emblemCountColor, needEmblem)
			end
		end
	end
end

function RougeLimiterBuffTips:onBuffCD()
	local remainCDRound = RougeDLCModel101.instance:getLimiterBuffCD(self._buffId)
	local speedupCost = RougeDLCHelper101.getLimiterBuffSpeedupCost(remainCDRound)
	local totalEmblemCount = RougeDLCModel101.instance:getTotalEmblemCount()
	local isEmblemCountMatch = speedupCost <= totalEmblemCount

	if isEmblemCountMatch then
		if not MatchCDEmblemColor then
			local emblemCountColor = LackCDEmblemColor

			self._txtspeedupnum.text = string.format("<%s>-%s</color>", emblemCountColor, speedupCost)
		end
	end
end

function RougeLimiterBuffTips:_onUpdateBuffState(buffId)
	if self._buffId == buffId then
		self:_refreshBuffStateUI()
	end
end

return RougeLimiterBuffTips
