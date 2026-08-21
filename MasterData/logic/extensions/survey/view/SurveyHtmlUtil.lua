-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/survey/view/SurveyHtmlUtil.lua

module("logic.extensions.survey.view.SurveyHtmlUtil", package.seeall)

local surveyData
local paramWithSign = ""

function requestSurveyData()
	do return end

	local param = {}
	local configUrlType = CSGameUtils.GetGameConfigUrlType()
	local urls = GameRequestUrl.URL_USER_SURVEY[SDKManager.getSDKType()]

	if not urls then
		return
	end

	if configUrlType == 0 and urls then
		param.url = urls.INTERNAL
	else
		param.url = urls.EXTERNAL
	end

	param.dataWithSign = paramWithSign

	printWarn("=====sendHttpGetSurveyListRequest==url=getSurveyData==", param.url)
	LoginAgent.instance:sendHttpGetSurveyListRequest(param)
end

function setSurveyParamWithSign(param)
	paramWithSign = param
end

function setSurveyData(data)
	surveyData = data
end

function getSurveyData()
	return surveyData
end

function getSurveyDataOrigin()
	return surveyData
end

function sortFun(moA, moB)
	local stampA = TimeUtil.instance:dateStr2TimeStamp(moA.startTime)
	local stampB = TimeUtil.instance:dateStr2TimeStamp(moB.startTime)

	if moA.rank < moB.rank then
		return true
	elseif moA.rank == moB.rank then
		return stampA < stampB
	else
		return false
	end
end
