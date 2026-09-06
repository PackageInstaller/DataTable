-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/catchprops/model/CatchPropsImageMO.lua

module("logic.extensions.catchprops.model.CatchPropsImageMO", package.seeall)

local CatchPropsImageMO = class("CatchPropsImageMO")

function CatchPropsImageMO:ctor(planId)
	self._planId = planId
	self._unlockFragments = nil

	self:_buildFragments()
end

function CatchPropsImageMO:getFragment(id)
	return self._unlockFragments[id]
end

function CatchPropsImageMO:getAllFragments()
	return self._unlockFragments
end

function CatchPropsImageMO:resetUnlockStatus()
	for k, v in pairs(self._unlockFragments) do
		v.isUnlock = false
		v.isNewUnLock = false
	end
end

function CatchPropsImageMO:setFragmentUnLock(id, unlocked)
	if self._unlockFragments[id] then
		self._unlockFragments[id].isUnlock = unlocked
	end
end

function CatchPropsImageMO:setFragmentNewUnLock(id, newUnlocked)
	if self._unlockFragments[id] then
		self._unlockFragments[id].isNewUnLock = newUnlocked
	end
end

function CatchPropsImageMO:_buildFragments()
	self._unlockFragments = {}

	local fragmentsCo = CatchPropsConfig.instance:getUnlockFamgmentsCo(self._planId)

	for k, v in pairs(fragmentsCo) do
		local fragmentMo = CatchPropsFragmentMO.New()

		fragmentMo.id = v.id
		fragmentMo.unlockProps = v.unlockProps
		fragmentMo.prize = v.prize
		self._unlockFragments[fragmentMo.id] = fragmentMo
	end
end

return CatchPropsImageMO
