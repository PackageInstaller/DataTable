-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/survivalking/view/SurvivalKingDetailView.lua

module("logic.extensions.survivalking.view.SurvivalKingDetailView", package.seeall)

local SurvivalKingDetailView = class("SurvivalKingDetailView", ViewComponent)

function SurvivalKingDetailView:ctor()
	SurvivalKingDetailView.super.ctor(self)
end

function SurvivalKingDetailView:unbindEvents()
	SurvivalKingDetailView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function SurvivalKingDetailView:bindEvents()
	SurvivalKingDetailView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
end

function SurvivalKingDetailView:buildUI()
	SurvivalKingDetailView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._leftCells = {}
	self._rightCells = {}

	for i = 1, 9 do
		local cell = {}

		cell.go = self:getGo(string.format("Left/Item%d", i))
		cell.icon = goutil.findChild(cell.go, "Icon")
		cell.dead = goutil.findChild(cell.go, "Dead")
		cell.sldHp = Framework.SliderAdapter.GetFrom(cell.go, "sldHp")
		self._leftCells[i] = cell
	end

	for i = 1, 9 do
		local cell = {}

		cell.go = self:getGo(string.format("Right/Item%d", i))
		cell.icon = goutil.findChild(cell.go, "Icon")
		cell.dead = goutil.findChild(cell.go, "Dead")
		cell.sldHp = Framework.SliderAdapter.GetFrom(cell.go, "sldHp")
		self._rightCells[i] = cell
	end

	self._imgAlivePetsNum = self:getGo("imgAlivePetsNum"):GetComponent("UIImageSpriteChange")
	self._ResultText2 = self:getTxt("ResultText2")
end

function SurvivalKingDetailView:onExit()
	SurvivalKingDetailView.super.onExit(self)

	for i, cell in ipairs(self._leftCells) do
		MaterialMgr.resetAll(cell.icon)
	end

	for i, cell in ipairs(self._rightCells) do
		MaterialMgr.resetAll(cell.icon)
	end
end

function SurvivalKingDetailView:onEnter()
	SurvivalKingDetailView.super.onEnter(self)

	for i, cell in ipairs(self._leftCells) do
		MaterialMgr.resetAll(cell.icon)
		goutil.setActive(cell.dead, false)
		goutil.setActive(cell.icon, false)
		goutil.setActive(cell.sldHp.gameObject, false)
	end

	for i, cell in ipairs(self._rightCells) do
		MaterialMgr.resetAll(cell.icon)
		goutil.setActive(cell.dead, false)
		goutil.setActive(cell.icon, false)
		goutil.setActive(cell.sldHp.gameObject, false)
	end

	self._alivePetCount = 0
	self._isWin = false

	local msg = self:getFirstParam()
	local info = GameUtil.pbToTable(msg)

	if info then
		if not info.record.teamA then
			local teamA = {}

			if not info.record.teamB then
				local teamB = {}
				local userId = checknumber(RoleModel.instance:getUserId())
				local userIdA = checknumber(teamA.userId)
				local petLefts = {}
				local petRights = {}

				if userId == userIdA then
					petLefts = teamA.pets or {}
					petRights = teamB.pets or {}
					self._isWin = info.record.isTeamAWin
				else
					petLefts = teamB.pets or {}
					petRights = teamA.pets or {}
					self._isWin = not info.record.isTeamAWin
				end

				for _, petInfo in ipairs(petLefts) do
					if not petInfo.position then
						local posId = 0
						local cell = self._leftCells[posId]

						if cell then
							goutil.setActive(cell.icon, true)
							goutil.setActive(cell.sldHp.gameObject, true)
							goutil.setActive(cell.dead, petInfo.leftHp <= 0)
							MaterialMgr.setIcon(cell.icon, MatType.Pet, petInfo.raceId)

							if self._isWin then
								if petInfo.leftHp > 0 then
									self._alivePetCount = self._alivePetCount + 1
								end

								cell.sldHp:SetValue(petInfo.leftHp)
							else
								cell.sldHp:SetValue(0)
								goutil.setActive(cell.dead, true)
							end
						end
					end
				end

				for _, petInfo in ipairs(petRights) do
					if not petInfo.position then
						local posId = 0
						local cell = self._rightCells[posId]

						if cell then
							goutil.setActive(cell.icon, true)
							goutil.setActive(cell.sldHp.gameObject, true)
							goutil.setActive(cell.dead, petInfo.leftHp <= 0)
							MaterialMgr.setIcon(cell.icon, MatType.Pet, petInfo.raceId)

							if self._isWin then
								cell.sldHp:SetValue(0)
								goutil.setActive(cell.dead, true)
							else
								cell.sldHp:SetValue(petInfo.leftHp)
							end
						end
					end
				end
			end
		end
	end

	self._imgAlivePetsNum:SetState(self._alivePetCount)

	self._ResultText2.text = self._isWin and "成功" or "失败"
end

return SurvivalKingDetailView
