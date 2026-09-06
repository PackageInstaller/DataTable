-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/traincampdefense/controller/TraincampdefenseController.lua

module("logic.extensions.traincampdefense.controller.TraincampdefenseController", package.seeall)

local TraincampdefenseController = class("TraincampdefenseController", BaseController)

function TraincampdefenseController:ctor()
	return
end

function TraincampdefenseController:onInit()
	self:onReset()
end

function TraincampdefenseController:onReset()
	self._needSetDefOpenView = false
	self._needOpenListView = false
end

function TraincampdefenseController:onGetFormRes(defenseForm)
	TraincampdefenseModel.instance:setDefenseForm(defenseForm)

	if self._needSetDefOpenView then
		self._needSetDefOpenView = false

		self:openSetDefenseForm()
	end

	if self._needOpenListView then
		self._needOpenListView = false

		self:openListView()
	end

	self:checkFmtRed()
end

function TraincampdefenseController:openSetDefenseForm()
	if not TraincampdefenseModel.instance:isLoadData() then
		self._needSetDefOpenView = true

		TrainCampDefenseFormAgent.instance:sendPM_DF_GetMyFormReq()
	else
		local customFmtMo = TraincampdefenseModel.instance:getDefenseCustomFmtMo()

		customFmtMo:initParams()
		CustomFmtController:showMissionFormationView(customFmtMo)
	end
end

function TraincampdefenseController:saveDefenseForm()
	local customFmtMo = TraincampdefenseModel.instance:getDefenseCustomFmtMo()
	local form = customFmtMo:getCurFormation():createFormPb()

	TrainCampDefenseFormAgent.instance:sendPM_DF_SaveFormReq(form)
end

function TraincampdefenseController:saveFormRes()
	FloatWordMgr.instance:show("保存成功")
	TrainCampDefenseFormAgent.instance:sendPM_DF_GetMyFormReq()
end

function TraincampdefenseController:enterMission(headInfo, defenseFormZdl)
	self._missionObj = {
		headInfo = headInfo,
		defenseFormZdl = defenseFormZdl
	}

	TrainCampDefenseFormAgent.instance:sendPM_DF_GetOtherFormReq(headInfo.userId)
end

function TraincampdefenseController:onGetOtherFormRes(otherPlayerView)
	if not self._missionObj then
		return
	end

	local customFmtMo = TraincampdefenseModel.instance:getMissionCustomFmtMo()

	customFmtMo:setOtherPlayerView(otherPlayerView, self._missionObj.headInfo.userId, self._missionObj.defenseFormZdl, self._missionObj.headInfo.userName)
	customFmtMo:initParams()
	customFmtMo:getCurFormation():ResetPosition()
	CustomFmtController:showMissionView(customFmtMo)

	self._missionObj = nil
end

function TraincampdefenseController:setDefensePlayerlistList(playerList)
	if not self._notShowTip then
		local list = TraincampdefenseModel.instance:getDefensePlayerlistList()

		if list and #list > 0 then
			if #list ~= #playerList then
				FloatWordMgr.instance:show("列表刷新成功")
			else
				local old = {}

				for i, v in ipairs(list) do
					old[v.playerHeadInfo.userId] = true
				end

				local isChange = false

				for i, v in ipairs(playerList) do
					isChange = not old[v.playerHeadInfo.userId]
				end

				if not isChange then
					FloatWordMgr.instance:show("暂无可刷新的内容")
				else
					FloatWordMgr.instance:show("列表已刷新")
				end
			end
		end
	end

	self._notShowTip = false

	TraincampdefenseModel.instance:setDefensePlayerlistList(playerList)
end

function TraincampdefenseController:sendPM_DF_RefreshFormListReq(notShowTip)
	self._notShowTip = notShowTip

	TrainCampDefenseFormAgent.instance:sendPM_DF_RefreshFormListReq()
end

function TraincampdefenseController:openListView()
	if TraincampdefenseModel.instance:isLoadData() then
		local mo = TraincampdefenseModel.instance:getDefenseCustomFmtMo()

		if mo:getCurFormation():isEmpty() then
			TraincampdefenseController.instance:openSetDefenseForm()

			return
		end

		UIStateManager.instance:push(ViewName.TraincampdefenselistView)
	else
		self._needOpenListView = true

		TrainCampDefenseFormAgent.instance:sendPM_DF_GetMyFormReq()
	end
end

function TraincampdefenseController:getFormData()
	if not TraincampdefenseModel.instance:isLoadData() then
		TrainCampDefenseFormAgent.instance:sendPM_DF_GetMyFormReq()
	end
end

function TraincampdefenseController:checkFmtRed()
	local mo = TraincampdefenseModel.instance:getDefenseCustomFmtMo()
	local num = mo:getCurFormation():getCurExistPetNumber()

	RedPointController.instance:setRedPointInfo(RedPointModel.ID_PK_SETFMT_RED, (num < 5 or nil) and true)
end

TraincampdefenseController.instance = TraincampdefenseController.New()

return TraincampdefenseController
