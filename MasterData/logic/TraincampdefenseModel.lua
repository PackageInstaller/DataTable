-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/traincampdefense/model/TraincampdefenseModel.lua

module("logic.extensions.traincampdefense.model.TraincampdefenseModel", package.seeall)

local TraincampdefenseModel = class("TraincampdefenseModel", BaseModel)

function TraincampdefenseModel:ctor()
	return
end

function TraincampdefenseModel:onInit()
	self:onReset()
end

function TraincampdefenseModel:onReset()
	self._defenseForm = nil
	self._defenseFormCustomFmtMo = nil
	self._playerList = nil
	self._missionCustomFmtMo = nil
	self._lastPositions = {}
end

function TraincampdefenseModel:isLoadData()
	return self._defenseForm
end

function TraincampdefenseModel:setDefenseForm(defenseForm)
	self._defenseForm = defenseForm

	local mo = self:getDefenseCustomFmtMo()

	mo:getCurFormation():SetData(defenseForm)
end

function TraincampdefenseModel:resetFormDefenseForm()
	if self._defenseForm then
		local mo = self:getDefenseCustomFmtMo()

		mo:getCurFormation():SetData(self._defenseForm)
	end
end

function TraincampdefenseModel:getDefenseCustomFmtMo()
	self._defenseFormCustomFmtMo = self._defenseFormCustomFmtMo or DefenseFormCustomFmtMo.New()

	return self._defenseFormCustomFmtMo
end

function TraincampdefenseModel:getMissionCustomFmtMo()
	self._missionCustomFmtMo = self._missionCustomFmtMo or TraincampMissionCustomFmtMo.New()

	return self._missionCustomFmtMo
end

function TraincampdefenseModel:setDefensePlayerlistList(playerList)
	self._playerList = playerList
end

function TraincampdefenseModel:getDefensePlayerlistList()
	return self._playerList
end

TraincampdefenseModel.instance = TraincampdefenseModel.New()

return TraincampdefenseModel
