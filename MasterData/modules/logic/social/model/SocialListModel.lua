-- chunkname: @modules/logic/social/model/SocialListModel.lua

module("modules.logic.social.model.SocialListModel", package.seeall)

local SocialListModel = class("SocialListModel")

function SocialListModel:ctor()
	self._models = {}
end

function SocialListModel:reInit()
	for _, model in pairs(self._models) do
		model:clear()
	end
end

function SocialListModel:getModel(type)
	self._models[type] = self._models[type] or ListScrollModel.New()

	return self._models[type]
end

function SocialListModel:setModelList(type, dict)
	local model = self:getModel(type)
	local list = {}

	if dict then
		for _, v in pairs(dict) do
			table.insert(list, v)
		end
	end

	if type == SocialEnum.Type.Friend then
		table.sort(list, SocialListModel.sortFriend)
	else
		table.sort(list, SocialListModel.sort)
	end

	model:setList(list)
end

function SocialListModel:sortFriendList()
	local model = self:getModel(SocialEnum.Type.Friend)

	model:sort(SocialListModel.sortFriend)
end

function SocialListModel.sortFriend(a, b)
	local timeA = SocialMessageModel.instance:getUnReadLastMsgTime(a.userId)
	local timeB = SocialMessageModel.instance:getUnReadLastMsgTime(b.userId)

	if timeA ~= 0 and timeB ~= 0 then
		return timeB < timeA
	elseif timeA ~= 0 or timeB ~= 0 then
		return timeA ~= 0
	else
		return SocialListModel.sort(a, b)
	end
end

function SocialListModel.sort(x, y)
	local xTime = tonumber(x.time)
	local yTime = tonumber(y.time)

	if xTime == 0 and yTime ~= 0 then
		return true
	elseif yTime == 0 and xTime ~= 0 then
		return false
	end

	if yTime < xTime then
		return true
	elseif xTime < yTime then
		return false
	end

	if x.level > y.level then
		return true
	elseif x.level < y.level then
		return false
	end

	if tonumber(x.userId) < tonumber(y.userId) then
		return true
	elseif tonumber(x.userId) > tonumber(y.userId) then
		return false
	end

	return false
end

SocialListModel.instance = SocialListModel.New()

return SocialListModel
