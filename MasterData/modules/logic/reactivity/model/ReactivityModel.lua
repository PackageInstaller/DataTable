-- chunkname: @modules/logic/reactivity/model/ReactivityModel.lua

module("modules.logic.reactivity.model.ReactivityModel", package.seeall)

local ReactivityModel = class("ReactivityModel", BaseModel)

function ReactivityModel:onInit()
	return
end

function ReactivityModel:reInit()
	return
end

function ReactivityModel:isReactivity(actId)
	if not actId or actId <= 0 then
		return false
	end

	local actCo = ActivityConfig.instance:getActivityCo(actId)

	if not actCo then
		return false
	end

	return actCo.isRetroAcitivity == 1
end

function ReactivityModel:getActivityCurrencyId(actId)
	local define = ReactivityEnum.ActivityDefine[actId]

	if define then
		return define.storeCurrency
	end

	for k, v in pairs(ReactivityEnum.ActivityDefine) do
		if v.storeActId == actId then
			return v.storeCurrency
		end
	end
end

ReactivityModel.instance = ReactivityModel.New()

return ReactivityModel
