-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dress/view/DressShopData.lua

module("logic.extensions.dress.view.DressShopData", package.seeall)

local DressShopData = class("DressShopData")
local Payway = {
	"rmb_",
	"8:14:",
	"8:1:",
	"105:1:"
}

function DressShopData:ctor()
	self.goodsCfg = nil
	self.isSuit = false
	self.dressIds = {}
	self.trialUseCfg = nil
	self.costType = 0
	self.costNum = 0
	self._useTime = 0
	self._firstDressCfg = nil
	self.belongTags = nil
	self.tag = nil
end

function DressShopData:initDataByCfg(cfg)
	self.goodsCfg = cfg

	if not cfg then
		printError("服装商城配置为空")
	end

	self._view = view

	local costStr = cfg.originalGoodsId

	for k, str in pairs(Payway) do
		if string.find(costStr, str) then
			self.costType = k
			self.costNum = checkint(string.sub(costStr, GameUtil.getStrLen(str) + 1, -1))

			break
		end
	end

	if self.costType == 0 then
		printError("服装商城配置不支持货币类型:" .. cfg.originalGoodsId)

		self.costType = 1
	end

	self.isSuit = cfg.showType == 1

	local matStrs = MaterialMgr.changeItemStrArr(cfg.content)
	local matType, matId, num = MaterialMgr.getMatParams(matStrs[1])

	self.trialUseCfg = MaterialConfig.instance:getCfgByMatAndId(matType, matId)

	if self.trialUseCfg then
		matStrs = MaterialMgr.changeItemStrArr(self.trialUseCfg.content)
	end

	local firstDressStr = matStrs[1]

	if not GameUtil.isEmptyString(firstDressStr) then
		self._useTime = checkint(string.split(firstDressStr, ":")[3])
		self._firstDressCfg = MaterialMgr.getMatCfgByStr(firstDressStr)

		if not self._firstDressCfg then
			printError("服装配置错误：" .. firstDressStr)
		end
	end

	for k, matStr in ipairs(matStrs) do
		matType, matId, num = MaterialMgr.getMatParams(matStr)

		if matType == MatType.Cloth and checkint(matId) > 0 then
			table.insert(self.dressIds, checkint(matId))
		end
	end

	self.belongTags = {}

	if self.isSuit then
		table.insert(self.belongTags, 1)
	else
		table.insert(self.belongTags, 2)
		table.insert(self.belongTags, 2 + self._firstDressCfg.belogTab)
	end

	self.tag = nil

	local tags = string.split(cfg.tag, "#")

	for k, v in pairs(tags) do
		if not GameUtil.isEmptyString(v) then
			if table.keyof(DressConfig.ShopShowTags, v) then
				self.tag = v
			else
				table.insert(self.belongTags, v)
			end
		end
	end
end

function DressShopData:getIsOwn()
	if table.nums(self.dressIds) == 0 then
		return false
	end

	if self.trialUseCfg then
		return MaterialModel.instance:getMaterialsNumber(self.trialUseCfg.materialType, self.trialUseCfg.materialId) > 0
	else
		for k, v in pairs(self.dressIds) do
			if not DressModel.instance:getIsOwnDressById(v) then
				return false
			end
		end

		return true
	end
end

function DressShopData:getIsFoverOwn()
	if table.nums(self.dressIds) == 0 then
		return false
	end

	for k, v in pairs(self.dressIds) do
		if not DressModel.instance:getIsOwnDressById(v) then
			return false
		end
	end

	return true
end

function DressShopData:getIsAbleToBuy()
	if self:getIsFoverOwn() then
		return false
	else
		return PayShopModel.instance:getPayShopGoodsCanBuyById(self.goodsCfg.id)
	end
end

function DressShopData:getIsAbleToOneKeyBuy()
	if self:getIsAbleToBuy() then
		if self.costType == 1 then
			return false
		end

		if self:getIsSuit() then
			return false
		end

		return true
	end

	return false
end

function DressShopData:getIsTrialCard()
	return self.trialUseCfg
end

function DressShopData:getUseTime()
	return self._useTime
end

function DressShopData:getIsSuit()
	return self.isSuit
end

function DressShopData:getPayTypeAndCost()
	return self.costType, self.costNum
end

function DressShopData:getFirstDressCfg()
	if self.isSuit then
		printError("获取到套装类型")
	else
		return self._firstDressCfg
	end
end

function DressShopData:getDeduceCfg()
	if self.goodsCfg.deducePlanId > 0 then
		return PayShopConfig.instance:getDeduceCfg(self.goodsCfg.deducePlanId)
	end
end

return DressShopData
