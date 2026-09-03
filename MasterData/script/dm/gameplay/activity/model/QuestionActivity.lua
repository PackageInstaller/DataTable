-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/activity/model/QuestionActivity.lua

QuestionActivity = class("QuestionActivity", BaseActivity, _M)

function QuestionActivity:initialize()
	super.initialize(self)

	self._canGetRewSta = false
	self._rewardStatus = false
end

function QuestionActivity:dispose()
	super.dispose(self)
end

function QuestionActivity:synchronize(data)
	if not data then
		return
	end

	super.synchronize(self, data)

	if data.rewardStatus ~= nil then
		self._rewardStatus = data.rewardStatus
	end
end

function QuestionActivity:setCanGetRewSta(sta)
	self._canGetRewSta = sta
end

function QuestionActivity:hasRedPoint()
	if self._rewardStatus == false then
		return self._canGetRewSta
	end

	return false
end
