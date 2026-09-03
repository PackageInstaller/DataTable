-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/base/RuleFactory.lua

RuleFactory = RuleFactory or {}

function RuleFactory:showRules(outSelf, rule, introduceKey)
	if self:showPicGuide(outSelf, introduceKey) == false then
		self:showTextGuide(outSelf, rule)
	end

	self:saveCount(outSelf, introduceKey)
end

function RuleFactory:showPicGuide(outSelf, key)
	if key and key ~= "" then
		local count = ConfigReader:getDataByNameIdAndKey("PicGuide", key, "ChangeInfo")
		local curCount = self:getCount(outSelf, key)

		if count and curCount < count or count == 9999 then
			local view = outSelf:getInjector():getInstance("GameIntroduceView")

			outSelf:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
				transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
			}, {
				key = key
			}))

			return true
		end
	end

	return false
end

function RuleFactory:showTextGuide(outSelf, rule)
	if rule then
		local view = outSelf:getInjector():getInstance("ExplorePointRule")

		outSelf:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
			transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
		}, rule))

		return true
	end

	return false
end

function RuleFactory:getCount(outself, key)
	local cjson = require("cjson.safe")
	local customDataSystem = outself:getInjector():getInstance(CustomDataSystem)
	local data = cjson.decode(customDataSystem:getValue(PrefixType.kGlobal, "GameIntroduce", "{}"))

	if data[key] == nil then
		return 0
	end

	return data[key]
end

function RuleFactory:saveCount(outSelf, introduceKey)
	local cjson = require("cjson.safe")
	local customDataSystem = outSelf:getInjector():getInstance(CustomDataSystem)
	local data = cjson.decode(customDataSystem:getValue(PrefixType.kGlobal, "GameIntroduce", "{}"))

	if data[introduceKey] == nil then
		data[introduceKey] = 0
	end

	data[introduceKey] = data[introduceKey] + 1

	local dataStr = cjson.encode(data)

	customDataSystem:setValue(PrefixType.kGlobal, "GameIntroduce", dataStr)
end
