-- chunkname: @modules/logic/college/model/CollegeClientDataMo.lua

module("modules.logic.college.model.CollegeClientDataMo", package.seeall)

local CollegeClientDataMo = class("CollegeClientDataMo")

CollegeClientDataMo.version = 1

function CollegeClientDataMo.Create(str)
	local mo = CollegeClientDataMo.New()

	if not string.nilorempty(str) then
		local ok, json = pcall(cjson.decode, str)

		if ok and json and json.version == CollegeClientDataMo.version then
			mo.data = json
		end
	end

	mo.data.version = CollegeClientDataMo.version

	return mo
end

function CollegeClientDataMo:ctor()
	self.data = {}
end

function CollegeClientDataMo:getNeedPlayCoinChange()
	if not self.data.lastCoin then
		local lastCoin = 0
		local nowCoin = CollegeModel.instance:getCoinCount()

		if nowCoin == lastCoin then
			return false
		end

		self:updateLastCoin()

		if lastCoin < nowCoin then
			CollegeController.instance:showToast(GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("college_toast_powerchange"), nowCoin - lastCoin))
		end

		return lastCoin < nowCoin, lastCoin, nowCoin
	end
end

function CollegeClientDataMo:updateLastCoin()
	local nowCoin = CollegeModel.instance:getCoinCount()

	if nowCoin ~= self.data.lastCoin then
		self.data.lastCoin = nowCoin

		self:save()
	end
end

function CollegeClientDataMo:updateNeedPlayFirstStory()
	if not self.data.lastActiveStoryCount then
		local lastActiveCount = 0
		local nowCount = CollegeModel.instance:getSceneMo().milestoneBox:getActiveCount()

		if nowCount ~= lastActiveCount then
			self.data.lastActiveStoryCount = nowCount

			self:save()

			return lastActiveCount < nowCount
		end

		return false
	end
end

function CollegeClientDataMo:updateAreaUnlock(id)
	local isPlay = self:isPlayedUnlock(id)

	if not isPlay then
		table.insert(self.data.area, id)
		self:save()
	end

	return not isPlay
end

function CollegeClientDataMo:isPlayedUnlock(id)
	self.data.area = self.data.area or {}

	local index = tabletool.indexOf(self.data.area, id)

	if index then
		return true
	end

	return false
end

function CollegeClientDataMo:isEntered()
	return self.data.entered == 1
end

function CollegeClientDataMo:save()
	if not self.data.entered then
		self.data.entered = 1

		CollegeController.instance:dispatchEvent(CollegeEvent.FirstSaveClientData)
	end

	if self.dirty then
		return
	end

	self.dirty = true

	TaskDispatcher.runDelay(self._delaySave, self, 0)
end

function CollegeClientDataMo:_delaySave()
	self.dirty = false

	CollegeRpc.instance:sendCollegeClientDataUpdate(cjson.encode(self.data))
end

return CollegeClientDataMo
