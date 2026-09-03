-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/activity/model/AIShopActivity.lua

AIShopPackage = class("AIShopPackage", objectlua.Object, _M)

AIShopPackage:has("_times", {
	is = "r"
})
AIShopPackage:has("_rewards", {
	is = "r"
})
AIShopPackage:has("_productId", {
	is = "r"
})
AIShopPackage:has("_rebateType", {
	is = "r"
})
AIShopPackage:has("_productType", {
	is = "r"
})

function AIShopPackage:initialize()
	super.initialize(self)

	self._times = 1
	self._rewards = {}
	self._productId = ""
	self._rebateType = ""
	self._productType = ""
end

function AIShopPackage:dispose()
	super.dispose(self)
end

function AIShopPackage:synchronize(data)
	if not data then
		return
	end

	if data.times then
		self._times = data.times
	end

	if data.productId then
		self._productId = data.productId
	end

	if data.rewards then
		self._rewards = data.rewards
	end

	if data.rebate_type then
		self._rebateType = data.rebate_type
	end

	if data.productType then
		self._productType = data.productType
	end
end

AIShopActivity = class("AIShopActivity", BaseActivity, _M)

AIShopActivity:has("_packageList", {
	is = "r"
})
AIShopActivity:has("_page", {
	is = "r"
})

function AIShopActivity:initialize()
	super.initialize(self)

	self._page = 1
	self._packageList = {}
	self._baseBgList = {}
	self._specialBgList = {}
end

function AIShopActivity:dispose()
	super.dispose(self)
end

function AIShopActivity:synchronize(data, isReset)
	if not data then
		return
	end

	super.synchronize(self, data)

	if not next(self._baseBgList) then
		self:initGiftPic()
	end

	if isReset then
		self._packageList = {}

		self:resetRandomData()
	end

	if data.packageInfos then
		for k, v in pairs(data.packageInfos) do
			local package = self._packageList[k]

			if not package then
				package = AIShopPackage:new()
				self._packageList[k] = package
			end

			package:synchronize(v)
		end
	end

	if data.page then
		self._page = data.page
	end
end

function AIShopActivity:doReset()
	self._packageList = {}

	self:resetRandomData()
end

function AIShopActivity:getProbability()
	return self:getActivityConfig().Probability
end

function AIShopActivity:initGiftPic()
	local config = self:getActivityConfig()

	for i = 1, 3 do
		local specialList = {}

		for _, v in pairs(config["GiftPic" .. i]) do
			if v.type == "Base" then
				self._baseBgList[#self._baseBgList + 1] = v
			else
				specialList[#specialList + 1] = v
			end
		end

		self._specialBgList[#self._specialBgList + 1] = specialList
	end
end

function AIShopActivity:getSpecialBgListByIndex(index)
	return self._specialBgList[index]
end

function AIShopActivity:getBaseBgByIndex(index)
	return self._baseBgList[index]
end

function AIShopActivity:getStatisticPackageList()
	local list = {}
	local index = 1 + (self._page - 1) * 3

	for i = index, index + 2 do
		local package = self._packageList[tostring(i - 1)]

		list[#list + 1] = {
			rebate_type = package:getRebateType(),
			productId = package:getProductId(),
			productType = package:getProductType(),
			times = package:getTimes(),
			rewards = package:getRewards()
		}
	end

	return list
end

function AIShopActivity:resetRandomData()
	local cjson = require("cjson.safe")
	local data = {}

	data.isRandom = false
	data.randomIndex = 0
	data.bgIndex = 0

	local customDataSystem = DmGame:getInstance()._injector:getInstance(CustomDataSystem)

	customDataSystem:setValue(PrefixType.kGlobal, self._id, cjson.encode(data), nil, nil, true)
end
