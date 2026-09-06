-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/traincampqiecuo/view/TrainFmtItemSeat.lua

module("logic.extensions.traincampqiecuo.view.TrainFmtItemSeat", package.seeall)

local LuaComponentContainer = Framework.LuaComponentContainer
local TrainFmtItemSeat = class("TrainFmtItemSeat", ItemSeat)

function TrainFmtItemSeat.AddOnce(go)
	local component = ItemSeat.Get(go)

	component = component or LuaComponentContainer.Add(go, TrainFmtItemSeat)

	return component
end

function TrainFmtItemSeat.Get(go)
	return (LuaComponentContainer.Get(go, TrainFmtItemSeat))
end

function TrainFmtItemSeat.Remove(go)
	local LuaComponentContainer = Framework.LuaComponentContainer

	LuaComponentContainer.Remove(go, TrainFmtItemSeat)
end

function TrainFmtItemSeat:_loadRole(petId, isAuto, curFaceId)
	local modelCfg = CharactorFacade.instance:getFormationModelUIPosAndScale(curFaceId)

	if not modelCfg[1] then
		if not modelCfg[2] then
			if not (modelCfg[3] * 0.35) then
				local scale = 0.35

				scale = scale * self:getPerspectiveFactor(self._posId)

				self:resetCharactorColor()

				self._loader, self._lastCallBack, self._character = RoleObjectPool.instance:resetLoader(self._loader, self._lastCallBack, self._character)
				self._loader, self._lastCallBack = RoleObjectPool.instance:getRoleAsset(curFaceId, function(go)
					go:SetActive(true)
					goutil.addChildToParent(go, self._Nego_Character)
					Framework.TransformUtil.SetLocalPos(go.transform, 0, 0, 0)
					Framework.TransformUtil.SetLocalScale(go.transform, -scale, scale, scale)

					self._character = go

					if not self:_isSelfPetId(petId) then
						self:setCharactorColor()
					end
				end, isAuto)
			end
		end
	end
end

return TrainFmtItemSeat
