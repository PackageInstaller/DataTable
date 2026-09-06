-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/catchprops/model/CatchPropsFragmentMO.lua

module("logic.extensions.catchprops.model.CatchPropsFragmentMO", package.seeall)

local CatchPropsFragmentMO = class("CatchPropsFragmentMO")

function CatchPropsFragmentMO:ctor()
	self.id = 0
	self.isUnlock = false
	self.unlockProps = nil
	self.isNewUnLock = false
end

return CatchPropsFragmentMO
