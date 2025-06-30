-- chunkname: @IQIGame\\UI\\Common\\ImageNumber.lua

local UIObjectPool = require("IQIGame.UI.Common.UIObjectPool")
local m = {
	__NumGos = {}
}

function m.New(view, probableMaxDigitalNumber, apiPathFunc, customCreatePoolFunc)
	local obj = Clone(m)

	obj:Init(view, probableMaxDigitalNumber, apiPathFunc, customCreatePoolFunc)

	return obj
end

function m:Init(view, probableMaxDigitalNumber, getPathFunc, customCreatePoolFunc)
	self.View = view
	self.__GetPathFunc = getPathFunc
	self.__CanvasTrans = view:GetComponentInParent(typeof(UIController)).transform

	while self.View.transform.childCount > 0 do
		local child = self.View.transform:GetChild(0)

		child.transform:SetParent(nil)
		UnityEngine.Object.Destroy(child.gameObject)
	end

	if customCreatePoolFunc ~= nil then
		self.__NumberPool = customCreatePoolFunc()
	else
		if probableMaxDigitalNumber == nil or probableMaxDigitalNumber == 0 then
			logError("参数maxDigitalNumber必须为大于0的数字")

			probableMaxDigitalNumber = 1
		end

		self.__NumberPool = self:CreatePool(probableMaxDigitalNumber)
	end
end

function m:CreatePool(size)
	return UIObjectPool.New(size, function()
		local go = UnityEngine.GameObject("Num")

		go:AddComponent(typeof(UnityEngine.RectTransform))
		go:AddComponent(typeof(UnityEngine.UI.Image))

		return go
	end, function(go)
		UnityEngine.Object.Destroy(go)
	end)
end

function m:SetNum(value, minDigitalNumber)
	minDigitalNumber = minDigitalNumber or 1

	self:ClearNumGos(false)

	local numList = {}

	while value ~= 0 do
		table.insert(numList, 1, value % 10)

		value = math.floor(value / 10)
	end

	local diffFromMin = minDigitalNumber - #numList

	if diffFromMin > 0 then
		for i = 1, diffFromMin do
			table.insert(numList, 1, 0)
		end
	end

	for i = 1, #numList do
		local numGo = self.__NumberPool:Obtain()

		numGo:SetActive(true)
		numGo.transform:SetParent(self.View.transform, false)
		AssetUtil.LoadImage(self, self.__GetPathFunc(numList[i]), numGo:GetComponent("Image"))
		table.insert(self.__NumGos, numGo)
	end
end

function m:ClearNumGos(isDestroy)
	for i = 1, #self.__NumGos do
		local go = self.__NumGos[i]

		go:SetActive(false)

		if not isDestroy then
			go.transform:SetParent(self.__CanvasTrans, false)
		end

		self.__NumberPool:Release(go)
	end

	self.__NumGos = {}
end

function m:Dispose()
	AssetUtil.UnloadAsset(self)
	self:ClearNumGos(true)
	self.__NumberPool:Dispose()

	self.View = nil
end

return m
