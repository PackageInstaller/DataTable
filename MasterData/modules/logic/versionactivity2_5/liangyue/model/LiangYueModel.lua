-- chunkname: @modules/logic/versionactivity2_5/liangyue/model/LiangYueModel.lua

module("modules.logic.versionactivity2_5.liangyue.model.LiangYueModel", package.seeall)

local LiangYueModel = class("LiangYueModel", BaseModel)

function LiangYueModel:onInit()
	self._actInfoDic = {}
	self._afterGameEpisodeDic = {}
end

function LiangYueModel:reInit()
	self._actInfoDic = {}
end

function LiangYueModel:onGetActInfo(msg)
	local actId = msg.activityId
	local episodeDic

	if not self._actInfoDic[actId] then
		episodeDic = {}
		self._actInfoDic[actId] = episodeDic
	else
		episodeDic = self._actInfoDic[actId]

		tabletool.clear(self._actInfoDic[actId])
	end

	local infos = msg.episodes

	if not infos or #infos <= 0 then
		return
	end

	for _, info in ipairs(infos) do
		local mo

		if LiangYueConfig.instance:getEpisodeConfigByActAndId(actId, info.episodeId) == nil then
			logError("episodeConfig not exist id: " .. info.episodeId)
		elseif episodeDic[info.episodeId] then
			logError("episodeId has exist id: " .. info.episodeId)
		else
			mo = LiangYueInfoMo.New()

			mo:init(actId, info.episodeId, info.isFinished, info.puzzle)

			episodeDic[info.episodeId] = mo
		end
	end
end

function LiangYueModel:onActInfoPush(msg)
	local actId = msg.activityId
	local episodeDic

	if not self._actInfoDic[actId] then
		episodeDic = {}
		self._actInfoDic[actId] = episodeDic
	else
		episodeDic = self._actInfoDic[actId]
	end

	local infos = msg.episodes

	if not infos or #infos <= 0 then
		return
	end

	for _, info in ipairs(infos) do
		local mo

		if episodeDic[info.episodeId] then
			mo = episodeDic[info.episodeId]

			episodeDic[info.episodeId]:updateMO(info.isFinished, info.puzzle)
		else
			mo = LiangYueInfoMo.New()

			mo:init(actId, info.episodeId, info.isFinished, info.puzzle)

			episodeDic[info.episodeId] = mo
		end
	end
end

function LiangYueModel:getEpisodeInfoMo(actId, episodeId)
	if not self._actInfoDic[actId] then
		return nil
	end

	return self._actInfoDic[actId][episodeId]
end

function LiangYueModel:getActInfoDic(actId)
	return self._actInfoDic[actId]
end

function LiangYueModel:setEpisodeInfo(msg)
	local actInfoDic = self:getActInfoDic(msg.activityId)

	if actInfoDic == nil then
		return
	end

	local mo = actInfoDic[msg.episodeId]

	if not mo then
		mo = LiangYueInfoMo.New()

		mo:init(msg.activityId, msg.episodeId, true, msg.puzzle)

		return
	end

	mo:updateMO(true, msg.puzzle)
end

function LiangYueModel:isEpisodeFinish(actId, episodeId)
	local episodeMo = self:getEpisodeInfoMo(actId, episodeId)

	if not episodeMo then
		return false
	end

	return episodeMo.isFinish
end

function LiangYueModel:setCurEpisodeId(id)
	self._curEpisodeId = id
end

function LiangYueModel:getCurEpisodeId()
	return self._curEpisodeId
end

function LiangYueModel:setCurActId(id)
	self._curActId = id
end

function LiangYueModel:getCurActId()
	return self._curActId
end

LiangYueModel.instance = LiangYueModel.New()

return LiangYueModel
