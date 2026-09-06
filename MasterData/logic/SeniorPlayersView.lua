-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/seniorarena/view/SeniorPlayersView.lua

module("logic.extensions.seniorarena.view.SeniorPlayersView", package.seeall)

local SeniorPlayersView = class("SeniorPlayersView", ViewComponent)

function SeniorPlayersView:buildUI()
	self._players = self:getGo("players")
end

function SeniorPlayersView:onExit()
	self._leftPlayerInfo = nil
	self._rightPlayerInfo = nil
	self._leftFormMos = nil
	self._rightFormMos = nil

	for _, v in ipairs(self._pointHeads) do
		MaterialMgr.resetAll(v)
	end

	for _, v in ipairs(self._pointPets) do
		MaterialMgr.resetAll(v)
	end

	self._pointHeads = nil
	self._pointPets = nil
end

function SeniorPlayersView:onEnter()
	local params = self:getOpenParam()

	self._leftPlayerInfo = params[1]
	self._rightPlayerInfo = params[2]
	self._leftFormMos = params[3]
	self._rightFormMos = params[4]
	self._pointHeads = {}
	self._pointPets = {}

	GameUtil.updateCellsWithLen(self._players, 2, self._updateOnePlayer, self)
end

function SeniorPlayersView:_updateOnePlayer(cell, idx)
	self._curIdx = idx

	local pointHead = goutil.findChild(cell, "pointHead")
	local txtTotalForce = goutil.findChildTextComponent(cell, "txtTotalForce")
	local txtUserName = goutil.findChildTextComponent(cell, "txtUserName")
	local forms = goutil.findChild(cell, "forms")

	if idx == 1 then
		if not self._leftPlayerInfo then
			local playerInfo = self._rightPlayerInfo

			if idx == 1 then
				if not self._leftFormMos then
					local formMos = self._rightFormMos

					if playerInfo.isMyInfo then
						HeadItemController.instance:setMyHeadCell(pointHead)

						txtUserName.text = playerInfo.userName
					else
						HeadItemController.instance:setHeadCellByInfo(pointHead, playerInfo.headInfo)

						txtUserName.text = playerInfo.headInfo.userName
					end

					local totalPower = 0

					for i = 1, 3 do
						if formMos[i] then
							totalPower = totalPower + formMos[i]:getTotalPower()
						end
					end

					txtTotalForce.text = totalPower

					GameUtil.updateCellsWithLen(forms, 3, function(cell, idx)
						self:_updateOneForm(cell, formMos[idx])
					end)
					table.insert(self._pointHeads, pointHead)
				end
			end
		end
	end
end

function SeniorPlayersView:_updateOneForm(cell, data)
	local txtTotalForce = goutil.findChildTextComponent(cell, "txtTotalForce")
	local txtTeam = goutil.findChildTextComponent(cell, "txtTeam")
	local pets = goutil.findChild(cell, "formations")

	txtTeam.text = "队伍" .. data:getFormId()
	txtTotalForce.text = data:getTotalPower()

	local petMos = data:getPetMoList()

	GameUtil.updateCells(pets, petMos, self._updateOnePet, self)
end

function SeniorPlayersView:_updateOnePet(cell, data)
	local txtForce = goutil.findChildTextComponent(cell, "force/txtForce")
	local pointPet = goutil.findChild(cell, "pointPet")

	MaterialMgr.resetAll(pointPet)

	txtForce.text = "0"

	if data then
		local proxy = MaterialMgr.setCellByData(MatType.Pet, data, pointPet)

		if proxy then
			proxy.binder:setIconDirection(self._curIdx == 1)
		end
	end

	table.insert(self._pointPets, pointPet)
end

return SeniorPlayersView
