-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logiccommon/common/avatar/new/avatarmountlogic/AvatarMountLogicBalloon.lua

module("logiccommon.common.avatar.avatarmountlogic.AvatarMountLogicBalloon", package.seeall)

local AvatarMountLogicBalloon = class("AvatarMountLogicBalloon", AvatarMountLogicBase)

function AvatarMountLogicBalloon:ctor(avatarBase, logicParams, userId)
	AvatarMountLogicBalloon.super.ctor(self, avatarBase, logicParams)

	self._ownerUserId = userId
end

function AvatarMountLogicBalloon:start()
	self:_refreshBalloons()
end

function AvatarMountLogicBalloon:_refreshBalloons()
	if self._logicParams then
		if self._ownerUserId == RoleModel.instance:getUserId() then
			local go = self._avatar:getGameObject()

			for k, v in pairs(self._logicParams) do
				local node = goutil.findChild(go, v)

				if node then
					node:SetActive(BagModel.instance:getPetIdByRaceId(checknumber(k)) ~= nil)
				end
			end
		else
			local playerMo = CityModel.instance:getPlayerMo(self._ownerUserId)

			if playerMo then
				local raceIds = playerMo.userVar:getOriginVar(UserVarKey.MOUNT_DECORATORS) or {}
				local go = self._avatar:getGameObject()

				for k, v in pairs(self._logicParams) do
					local node = goutil.findChild(go, v)

					if node then
						node:SetActive(raceIds[checknumber(k)] or false)
					end
				end
			end
		end
	end
end

return AvatarMountLogicBalloon
