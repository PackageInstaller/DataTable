-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logiccommon/common/viewlib/pool/CharacterObjectMgr.lua

module("logiccommon.common.viewlib.pool.CharacterObjectMgr", package.seeall)

local CharacterObjectMgr = class("CharacterObjectMgr")

function CharacterObjectMgr:init()
	return
end

function CharacterObjectMgr:clear()
	return
end

function CharacterObjectMgr:_onFormationInited()
	local positions = FormationFacade.instance:getCurPositions()
	local _loader = {}
	local count = 0

	for i, petId in ipairs(positions) do
		if petId > 0 then
			count = count + 1

			local pet = BagPetsController.instance:getPet(petId)

			RoleObjectPool.instance:getRoleAsset(pet.curFaceId, function(go, loader)
				table.insert(_loader, {
					loader,
					go
				})

				if #_loader == count then
					for i, v in ipairs(_loader) do
						RoleObjectPool.instance:resetLoader(v[1], nil, v[2])
					end
				end
			end)
			print(pet.curFaceId .. "loaded!!!!!!!!!!")
		end
	end

	self:_checkLoadWushenshou()
end

function CharacterObjectMgr:_checkLoadWushenshou()
	return
end

CharacterObjectMgr.instance = CharacterObjectMgr.New()

return CharacterObjectMgr
