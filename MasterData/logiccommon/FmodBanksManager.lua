-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logiccommon/common/audio/FmodBanksManager.lua

module(..., package.seeall)

local FmodBanksManager = class("FmodBanksManager")

function FmodBanksManager:ctor()
	self._laodedBanks = {}
	self._toLoadBanks = {}
end

function FmodBanksManager:loadBank(bankName)
	if not AudioPlayerEx.isInitialized then
		return
	end

	if self:isBankLoaded(bankName) then
		return
	end

	if not table.indexof(self._toLoadBanks, bankName) then
		table.insert(self._toLoadBanks, bankName)

		if not self._isLoadingBanks then
			self._isLoadingBanks = true

			settimer(0, self._doLoadBanks, self)
		end
	end
end

function FmodBanksManager:isBankLoaded(bankName)
	if not AudioPlayerEx.isInitialized then
		return false
	end

	return self._laodedBanks[bankName]
end

function FmodBanksManager:stopLoadBanks()
	if not AudioPlayerEx.isInitialized then
		return
	end

	removetimer(self._doLoadBanks, self)
	table.clear(self._toLoadBanks)

	self._isLoadingBanks = nil
end

function FmodBanksManager:unloadAllBanks()
	self:stopLoadBanks()
end

function FmodBanksManager:_doLoadBanks()
	if #self._toLoadBanks == 0 then
		removetimer(self._doLoadBanks, self)

		self._isLoadingBanks = nil

		return
	end

	local bankName = self._toLoadBanks[1]

	table.remove(self._toLoadBanks, 1)
	AudioPlayerEx.instance:CheckLoadBankAfterFrame(bankName)

	self._laodedBanks[bankName] = true
end

FmodBanksManager.instance = FmodBanksManager.New()

return FmodBanksManager
