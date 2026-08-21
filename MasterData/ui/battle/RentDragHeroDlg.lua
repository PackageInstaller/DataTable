-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Battle\\RentDragHeroDlg.lua

local DragPlane = require("UI/Control/Com/DragPlane")
local MultiDragHeroDlg = require("UI/Battle/MultiDragHeroDlg")
local PVPCommon = require("Logic/PVP/PVPCommon")
local strClassName = "RentDragHeroDlg"
local RentDragHeroDlg = Class(strClassName, MultiDragHeroDlg)

function RentDragHeroDlg:ctor()
	return
end

function RentDragHeroDlg:setMaxTeamNum(maxTeam)
	self.MAX_TEAM_NUM = maxTeam

	self:_specInitUI()
end

function RentDragHeroDlg:_initUI()
	return
end

function RentDragHeroDlg:_specInitUI()
	RentDragHeroDlg.super._initUI(self)
	self.btnSwitch:setVisible(false)
	self.btnClose:setText(Lang.get(330))

	if self.MAX_TEAM_NUM < 5 then
		for index = self.MAX_TEAM_NUM + 1, 5 do
			local newBtn = UIControls.Button(self, "TeamPanel/BtnTeam" .. index)

			newBtn:setVisible(false)
		end
	end
end

function RentDragHeroDlg:_initTeamFormation()
	self.teamFormations = {}
	self.teamPets = {}

	local ketStr

	for i = 1, self.MAX_TEAM_NUM do
		self.teamFormations[i] = utils.copyTable(CurAvatar:getNowFormation(Const.FORMATION_RENT_TEAMS[i]))
		self.teamPets[i] = utils.copyTable(CurAvatar:getFormationOtherInfo(Const.FORMATION_RENT_TEAMS[i]))
	end

	self:onTeamSelect(self.teamBtns[self.battlePreInfo.rentData.formationIndex or 1])
end

function RentDragHeroDlg:isSameFormation()
	for i = 1, self.MAX_TEAM_NUM do
		local formation = CurAvatar:getNowFormation(Const.FORMATION_RENT_TEAMS[i])
		local isSame = true
		local preCount = utils.getTableElemCount(formation)
		local nowCount = 0

		for gid, pos in pairs(self.teamFormations[i]) do
			if pos > 0 then
				nowCount = nowCount + 1

				if formation[gid] and formation[gid] == pos then
					-- block empty
				else
					isSame = false

					break
				end
			end
		end

		if isSame and nowCount == preCount then
			-- block empty
		else
			return false
		end
	end

	return true
end

function RentDragHeroDlg:_onConfirm(...)
	if self:saveFormationToServer() then
		MsgManager.notice(Lang.get(30152))
		self:exit()
	end
end

function RentDragHeroDlg:saveFormationToServer()
	self:saveNowFormation()

	local result = {}

	for index = 1, self.MAX_TEAM_NUM do
		local info = self.teamFormations[index] or {}
		local data = {
			hero = {}
		}

		for gid, pos in pairs(info) do
			table.insert(data.hero, {
				idx = pos,
				gid = gid
			})
		end

		if #data.hero == 0 then
			MsgManager.clientNotice(258)

			return
		end

		if self.teamPets[index] and self.teamPets[index].petId then
			data.pet = self.teamPets[index].petId
		end

		table.insert(result, data)
	end

	RPC.formationsUpdateByType(Const.FORMATION_TYPE_RENT_DEFEND, result)

	return true
end

return RentDragHeroDlg
