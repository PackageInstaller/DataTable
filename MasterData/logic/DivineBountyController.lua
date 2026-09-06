-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinebounty/controller/DivineBountyController.lua

module("logic.extensions.divinebounty.controller.DivineBountyController", package.seeall)

local DivineBountyController = class("DivineBountyController", BaseController)

DivineBountyController.ShopViewClose = "DivineBountyBuyViewClose"

function DivineBountyController:ctor()
	return
end

function DivineBountyController:onInit()
	self:onReset()
end

function DivineBountyController:onReset()
	return
end

function DivineBountyController:quickSort(arr, key)
	if #arr <= 1 then
		return arr
	end

	local pivot = arr[math.ceil(#arr / 2)][key]
	local left = {}
	local right = {}
	local middle = {}

	for _, v in ipairs(arr) do
		if pivot > v[key] then
			table.insert(left, v)
		elseif v[key] == pivot then
			table.insert(middle, v)
		else
			table.insert(right, v)
		end
	end

	return self:quickSort(left, key) .. middle .. self:quickSort(right, key)
end

DivineBountyController.instance = DivineBountyController.New()

return DivineBountyController
