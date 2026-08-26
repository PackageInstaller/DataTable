-- chunkname: @modules/logic/fight/view/FightDeviceCardItemBase.lua

module("modules.logic.fight.view.FightDeviceCardItemBase", package.seeall)

local FightDeviceCardItemBase = class("FightDeviceCardItemBase", UserDataDispose)

FightDeviceCardItemBase.LockTextPathList = {
	"seal/ani/txtLockName",
	"seal/notani/txtLockName",
	"sealing/ani/txtLockName",
	"sealing/notani/txtLockName",
	"unseal/ani/txtLockName"
}

function FightDeviceCardItemBase:init(goParent, cardItem)
	self:__onInit()

	self.goParent = goParent
	self.rectTrParent = goParent:GetComponent(gohelper.Type_RectTransform)
	self.cardItem = cardItem
	self.active = false
end

function FightDeviceCardItemBase:setActive(active)
	self.active = active
end

function FightDeviceCardItemBase:getUid()
	return self.cardItem and self.cardItem:getUid()
end

function FightDeviceCardItemBase:startLoad(loadDoneCallback, loadDoneCallbackObj)
	self.loadDoneCallback = loadDoneCallback
	self.loadDoneCallbackObj = loadDoneCallbackObj
	self.loader = MultiAbLoader.New()

	self.loader:addPath(self.prefabPath)
	self.loader:startLoad(self.onLoadedCallback, self)
end

function FightDeviceCardItemBase:onLoadedCallback()
	local assetItem = self.loader:getFirstAssetItem()

	self.go = gohelper.clone(assetItem:GetResource(), self.goParent)
	self.rectTr = self.go:GetComponent(gohelper.Type_RectTransform)

	self:initViews()

	if self.loadDoneCallback then
		self.loadDoneCallback(self.loadDoneCallbackObj)
	end

	self.loadDoneCallback = nil
	self.loadDoneCallbackObj = nil
end

function FightDeviceCardItemBase:initViews()
	return
end

function FightDeviceCardItemBase:enableLockComp()
	if self.lockComp then
		return
	end

	self.lockComp = FightDevicePlayCardLockItem.New()

	self.lockComp:init(self)
end

function FightDeviceCardItemBase:setGrayMaskActive(active)
	self.grayMaskActive = active

	if not self.loadedDone then
		return
	end

	gohelper.setActive(self.goGrayMask, active)
end

function FightDeviceCardItemBase:setLockActive(active)
	self.lockActive = active

	if not self.loadedDone then
		return
	end

	gohelper.setActive(self.goLock, active)
end

function FightDeviceCardItemBase:setLockText(text)
	if not self.loadedDone then
		return
	end

	for _, txt in ipairs(self.txtLockList) do
		txt.text = text
	end
end

function FightDeviceCardItemBase:playLockAnim(animName, animDoneCallback, animDoneCallbackObj)
	if not self.loadedDone then
		return
	end

	if not self.active then
		return
	end

	if not self.skillCo then
		return
	end

	self.animDoneCallback = animDoneCallback
	self.animDoneCallbackObj = animDoneCallbackObj

	self:setLockActive(true)

	if self.lockAnimPlayer then
		self.lockAnimPlayer:Play(animName, self.playLockAnimDone, self)
	end
end

function FightDeviceCardItemBase:playLockAnimDone()
	local animDoneCallback = self.animDoneCallback
	local animDoneCallbackObj = self.animDoneCallbackObj

	self.animDoneCallback = nil
	self.animDoneCallbackObj = nil

	if animDoneCallback then
		self.animDoneCallback(animDoneCallbackObj)
	end
end

function FightDeviceCardItemBase:hide()
	if self.loadedDone then
		gohelper.setActive(self.go, false)
	end
end

function FightDeviceCardItemBase:show()
	if self.loadedDone then
		gohelper.setActive(self.go, true)
	end
end

function FightDeviceCardItemBase:refreshUI(deviceSkillInfo)
	return
end

function FightDeviceCardItemBase:getDeviceSkillInfo()
	return self.deviceSkillInfo
end

function FightDeviceCardItemBase:getSkillCo()
	return self.skillCo
end

function FightDeviceCardItemBase:getSkillId()
	return self.deviceSkillInfo and self.deviceSkillInfo.skillId
end

function FightDeviceCardItemBase:setSelectFrameActive(active)
	self.selectFrameActive = active

	if not self.loadedDone then
		return
	end

	gohelper.setActive(self.goSelect, active)
end

function FightDeviceCardItemBase:getRectTr()
	return self.rectTr
end

function FightDeviceCardItemBase:refreshStopEffect()
	if not self.active then
		return
	end

	if not self.deviceSkillInfo then
		return
	end

	local animName = self.deviceSkillInfo.isStop and "delicate_open" or "idle"

	self:playAnim(animName)
end

function FightDeviceCardItemBase:playAnimToLastFrame(animName)
	if not self.active then
		return
	end

	if self.animator then
		self.animatorPlayer:Stop()
		self.animator:Play(animName, 0, 1)
	end
end

function FightDeviceCardItemBase:playAnim(animName, callback, callbackObj)
	if not self.active then
		return
	end

	if self.animatorPlayer then
		self.animatorPlayer:Play(animName, callback, callbackObj)
	end
end

function FightDeviceCardItemBase:dispose()
	self.animDoneCallback = nil
	self.animDoneCallbackObj = nil
	self.loadDoneCallback = nil
	self.loadDoneCallbackObj = nil

	if self.loader then
		self.loader:dispose()

		self.loader = nil
	end

	if self.lockComp then
		self.lockComp:dispose()

		self.lockComp = nil
	end

	self:__onDispose()
end

return FightDeviceCardItemBase
