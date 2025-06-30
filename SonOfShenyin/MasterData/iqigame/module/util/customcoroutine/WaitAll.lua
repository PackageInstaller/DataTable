-- chunkname: @IQIGame\\Module\\Util\\CustomCoroutine\\WaitAll.lua

WaitAll = class(nil, CustomWait)

function WaitAll:ctor(coroutines)
	if coroutines == nil then
		return
	end

	self.waitType = "WaitAll"
	self.subCoroutines = coroutines
end

function WaitAll:Update()
	if self.subCoroutines == nil then
		return
	end

	for i = 1, #self.subCoroutines do
		if not self.subCoroutines[i].isComplete then
			return
		end
	end

	self.isComplete = true
end
