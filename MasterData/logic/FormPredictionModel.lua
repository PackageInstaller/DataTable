-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/formprediction/model/FormPredictionModel.lua

module("logic.extensions.formprediction.model.FormPredictionModel", package.seeall)

local FormPredictionModel = class("FormPredictionModel", BaseModel)

function FormPredictionModel:onInit()
	self:onReset()
end

function FormPredictionModel:onReset()
	self._infoMsgMap = {}
	self._ratioMsgMap = {}
	self._rankMsgMap = {}
end

function FormPredictionModel:onGetInfo(msg)
	self._infoMsgMap[msg.activityId] = GameUtil.pbToTable(msg)
end

function FormPredictionModel:onGetPrize(msg)
	local info = self._infoMsgMap[msg.activityId]

	if info then
		local formId = msg.formId

		info.formList = info.formList or {}

		for i, v in ipairs(info.formList) do
			if v.formId == formId then
				v.gainPrize = true

				break
			end
		end
	end
end

function FormPredictionModel:onGetRatio(msg)
	local pb = GameUtil.pbToTable(msg)

	self._ratioMsgMap[msg.activityId] = self._ratioMsgMap[msg.activityId] or {}
	self._ratioMsgMap[msg.activityId][msg.formId] = pb.ratioList
end

function FormPredictionModel:onGetRank(msg)
	self._rankMsgMap[msg.activityId] = self._rankMsgMap[msg.activityId] or {}
	self._rankMsgMap[msg.activityId][msg.formId] = GameUtil.pbToTable(msg)
end

function FormPredictionModel:getRankInfo(activityId, formId)
	if self._rankMsgMap[activityId] then
		return self._rankMsgMap[activityId][formId]
	end
end

function FormPredictionModel:getRatioInfo(activityId, formId)
	if self._ratioMsgMap[activityId] then
		return self._ratioMsgMap[activityId][formId]
	end
end

function FormPredictionModel:onSetForm(msg)
	local info = self._infoMsgMap[msg.activityId]

	if info then
		local form = GameUtil.pbToTable(msg.form)

		info.formList = info.formList or {}

		local has = false

		for i, v in ipairs(info.formList) do
			if v.formId == form.formId then
				info.formList[i] = form
				has = true

				break
			end
		end

		if not has then
			table.insert(info.formList, form)
		end

		self._infoMsgMap[msg.activityId] = info
	end
end

function FormPredictionModel:getInfo(activityId)
	return self._infoMsgMap[activityId]
end

FormPredictionModel.instance = FormPredictionModel.New()

return FormPredictionModel
