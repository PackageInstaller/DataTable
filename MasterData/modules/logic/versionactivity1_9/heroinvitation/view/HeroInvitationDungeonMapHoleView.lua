-- chunkname: @modules/logic/versionactivity1_9/heroinvitation/view/HeroInvitationDungeonMapHoleView.lua

module("modules.logic.versionactivity1_9.heroinvitation.view.HeroInvitationDungeonMapHoleView", package.seeall)

local HeroInvitationDungeonMapHoleView = class("HeroInvitationDungeonMapHoleView", DungeonMapHoleView)

function HeroInvitationDungeonMapHoleView:refreshHoles()
	if not self.loadSceneDone or gohelper.isNil(self.mat) then
		return
	end

	local list = {}

	for _, co in pairs(self.holdCoList) do
		local id = co[4]
		local x = co[1] + self.sceneWorldPosX - self.defaultSceneWorldPosX
		local y = co[2] + self.sceneWorldPosY - self.defaultSceneWorldPosY
		local size = math.abs(co[3])
		local xDistance = math.sqrt((self.mainCameraPosX - x)^2)
		local yDistance = math.sqrt((self.mainCameraPosY - y)^2)

		if xDistance <= self._mapHalfWidth + size and yDistance <= self._mapHalfHeight + size then
			local data = {
				finish = 0,
				distance = -(xDistance * xDistance + yDistance * yDistance),
				pos = {
					x,
					y,
					co[3]
				},
				id = id or 0
			}

			if id and id > 0 then
				data.finish = DungeonMapModel.instance:elementIsFinished(id) and 0 or 1
			end

			table.insert(list, data)
		end
	end

	if #list > 1 then
		table.sort(list, SortUtil.tableKeyUpper({
			"finish",
			"distance",
			"id"
		}))
	end

	for i = 1, 5 do
		local data = list[i]

		if data then
			self.tempVector4:Set(data.pos[1], data.pos[2], data.pos[3])
			self.mat:SetVector(self.shaderParamList[i], self.tempVector4)
		else
			self.tempVector4:Set(0, 0, 0)
			self.mat:SetVector(self.shaderParamList[i], self.tempVector4)
		end
	end
end

return HeroInvitationDungeonMapHoleView
